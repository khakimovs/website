import type { Metadata } from "next";
import { GitHubIcon, ArrowIcon } from "components/icons";

export const metadata: Metadata = {
  title: "About",
  description: "VP of Developer Experience at Vercel.",
};

export default function AboutPage() {
  return (
    <section>
      <h1 className="font-bold text-3xl font-serif">About Us</h1>
      <div className="prose prose-neutral dark:prose-invert text-neutral-800 dark:text-neutral-200">
        <p>
          We are the Khakimov family, a lineage renowned for producing
          individuals of influence and distinction. Our family, spanning
          generations, comprises professionals from a diverse array of fields,
          creating a mosaic of expertise and perspectives.
        </p>
        <hr />
        <p>
          We are not merely a family bound by blood, but also by our shared
          commitment to fostering innovation and advancing knowledge. Our
          endeavors have consistently extended into wide-ranging fields of
          study, with a unifying emphasis on contributing original research and
          creating novel, impactful solutions.
        </p>
        <p>
          Our members distinguish themselves through their unique abilities to
          challenge conventional wisdom and deliver transformative insights in
          their respective disciplines. As such, the Khakimov family has not
          only contributed to the intellectual and cultural wealth of our
          society but has also significantly shaped various academic and
          professional landscapes.
        </p>
        <p className="mb-8">
          Our mission, as a family, is to continue this legacy of innovation and
          influence. We strive to contribute to society through our research, to
          pioneer change, and to inspire others through our accomplishments.
        </p>
        <div className="flex flex-col gap-2 md:flex-row md:gap-2">
          <a
            rel="noopener noreferrer"
            target="_blank"
            href="https://github.com/khakimovs"
            className="flex w-full border border-neutral-200 dark:border-neutral-800 rounded-lg p-4 no-underline items-center text-neutral-800 dark:text-neutral-200 hover:dark:bg-neutral-900 hover:bg-neutral-100 transition-all justify-between"
          >
            <div className="flex items-center">
              <GitHubIcon />
              <div className="ml-3">GitHub</div>
            </div>
            <ArrowIcon />
          </a>
        </div>
      </div>
    </section>
  );
}
