import { ArrowIcon, ViewsIcon } from "components/icons";

interface LinkProps {
  text: string,
  link: string,
}

export function LinkButton({ text, link }: LinkProps) {
  return (
    <div className="flex flex-col gap-2 md:flex-row md:gap-2 mb-4">
      <a
        rel="noopener noreferrer"
        target="_blank"
        href={link}
        className="flex w-full border border-neutral-200 dark:border-neutral-800 rounded-lg p-4 no-underline items-center text-neutral-800 dark:text-neutral-200 hover:dark:bg-neutral-900 hover:bg-neutral-100 transition-all justify-between"
      >
        <div className="flex items-center">
          <ViewsIcon />
          <div className="ml-3">{text}</div>
        </div>
        <ArrowIcon />
      </a>
    </div>
  );
}
