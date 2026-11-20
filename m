Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CF60A2637
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZXs3iKUT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUu6-0004D0-1F; Fri, 20 Nov 2026 15:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrR-0001AE-Fp
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrP-0001uc-Br
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso9904235e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205126; x=1795809926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3R91EV5Vo0R+ysQFpX1NS64YKXxk7YrfzSxtifqKgZU=;
 b=ZXs3iKUToRdBsl8D/dfwJli3ACc97iGG7NsKHFCgrgEe5QPZiPpL+Z1jgYpF+WDZx3
 3BlBPBxK47Vlkz9DEBGeqwLt31vQknh8+Hx01Edz24Ua3QvjuNRbKulDpJdS2wQMrCK2
 11LXGsly229mGdqS2Pt1kI2ryql9X58aOlGFGid2RcKdi8pSzYWdAMt20/KGP7QVQst0
 hWXIlStd8idH+FGyvYrsYLDxrF0WIipxsJrht8nHCkYNGTfDzTEEa8NhGS1sM0DytIKm
 ee/vG4xnOTxGe5j+z5PdP5LDI8VthjzQh7GqocWu5Yoz7kTL2hjYtd8v/xI/JoXjOwiO
 1I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205126; x=1795809926;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3R91EV5Vo0R+ysQFpX1NS64YKXxk7YrfzSxtifqKgZU=;
 b=B0PfMJhvXnLISkxS1AOgxlpQmqf2fqA7XCmKnQfwa1QWNZRgwr6/zwufaSFGMbyxVH
 WiUbU2LyYWRXRS8UWdb3V4mRWPNMhM8fA9Qk+1HhMta8eAMVeqhIiMcHeCRXwYPopEOS
 UoZ0uPtzizwr/+IJ/VAGecMitiL4l0n7jzoadrGCzaLgKcCzP2qi7zBWaW3GQ/jARDeG
 VRVC5y2gFlJTn8DgF6e9Oy5AR5BszDKYJw0yytAQkUdkxsMlC6Pc3Yod5RvkGJ5v6qU2
 ZbcI0xFVq0EibiMJrcgNXFBB3oNaAUgC/Dz7KBfyOj1HLRrUYUDF/aSgoIWkBGeEKyFU
 M+5g==
X-Gm-Message-State: APuU4Z9w5airUr9gChJUMBl54qBEDSK1vi66QoqAY4ove76KNIFySPVv
 wM6KEaTI4XwrmaV6POepGGs43vZ+Edf1KT6NqV/PXW97lQ54Rp7kq1TNGvlQkgdcRJE=
X-Gm-Gg: AYBFou3+brvlVIzdF/iIL5F5Rj78/nH/QQW5WhjK2MWPevdrx3vEehAarsLyxMll94N
 mbrmd797fgCwHH+NszS9yu7sAYMjpRfYRcu/7LpIq5CQuL8oVAAVYuVJF9g2ELOJELCCkqWJutf
 +Jj2kWJ1EknQ3IpJNGqL7KhrKUQNFM7g+9YZAPsfYLtlxt0Z/UketIcPnYEv8j2nuW6ZKcBj7R3
 19HnXf0CL+uFnTMygC1FrP+1sFs6JP8I8OfF8u+6Qcu/tLmS3br7EimPYIT4+EG9tO44ZBqBMS0
 6qHCfqOkNu2HlbEUzIwZyR0RIsKZbhXsl3GL9AKUOntrxvbnUSiGCuVxsut/A2vjgz2sxtUOnvG
 7PlR4Eru3Wt2B9Onp8vG+Pm6/VW+/WsMJlI/ZNelyu2SbXc/2IZwJ2WXn/nz+NhEWRoIViqMcx2
 ln8QCtjdQbp+D9Ima5HW6HOPDHFW+Z6Gbqna948srSoaen4vhBWwXw1NDN4HqyqlLcGKcB6AhXR
 YxdMYr6Tae0GHN4sfb+BFanU+DNY7NuO1reVjIDL4xh3KdYkU2iqWtdK+ol4OQzA2RRVbDna8RJ
 9JJYry9GyTn53C8dPE3WDNm2uoU=
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4bb88820687mr109809445e9.29.1795205125072; 
 Fri, 20 Nov 2026 12:05:25 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906817ccsm8461435e9.5.2026.11.20.12.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02A955FBBD;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 16/22] scripts/maintainer: add plot-maintainer-experience.py
Date: Fri, 20 Nov 2026 20:05:04 +0000
Message-ID: <20261120200511.822573-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a script to plot the experience of maintainers and when they
started contributing to the project (either with review or commits).
We also handle the case when they become maintainers with the code the
submit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../maintainers/plot-maintainer-experience.py | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100755 scripts/maintainers/plot-maintainer-experience.py

diff --git a/scripts/maintainers/plot-maintainer-experience.py b/scripts/maintainers/plot-maintainer-experience.py
new file mode 100755
index 00000000000..1db2863a667
--- /dev/null
+++ b/scripts/maintainers/plot-maintainer-experience.py
@@ -0,0 +1,163 @@
+#!/usr/bin/env python3
+#
+# plot-maintainer-experience.py: plot the experience of the current
+# maintainer pool
+#
+# Copyright (C) 2026 Linaro, Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""
+Plot the distribution of experience across the current maintainers,
+using the CSV from get_maintainer.py --list-maintainers:
+
+    years as a maintainer       now - Maintainer Since
+    experience when appointed   Maintainer Since - Contributor Since
+
+"Contributor Since" is the first commit authored or committed, or the
+first Signed-off-by, Co-developed-by, Reviewed-by, Tested-by or Acked-by
+trailer.  Maintainers added within ARRIVED_DAYS of that usually came with
+their own code (a new board, device or port) and are shaded apart.
+Individuals are not labelled; those left out are listed on stdout.
+"""
+
+import argparse
+import os
+import sys
+
+import matplotlib
+if not (os.environ.get("DISPLAY") or os.environ.get("WAYLAND_DISPLAY")):
+    matplotlib.use("Agg")
+import matplotlib.pyplot as plt
+import numpy as np
+import pandas as pd
+
+REQUIRED_COLUMNS = {"Maintainer Name", "Contributor Since",
+                    "Maintainer Since"}
+# added to MAINTAINERS this soon after first involvement: arrived with
+# their code rather than being appointed after contributing
+ARRIVED_DAYS = 30
+COLOR = "#2a78d6"
+ARRIVED_COLOR = "#a9c9f0"
+
+
+def years_between(start, end):
+    return ((end - start).dt.days / 365.25).dropna()
+
+
+def plot_panel(ax, years, title, xlabel, bins, color, arrived=None):
+    if arrived is None:
+        ax.hist(years, bins=bins, color=color, edgecolor="white",
+                linewidth=1.5)
+    else:
+        # all the arrivals fall in the first bin, stacked under the rest
+        ax.hist([years[arrived], years[~arrived]], bins=bins, stacked=True,
+                color=[ARRIVED_COLOR, color], edgecolor="white",
+                linewidth=1.5,
+                label=[f"Arrived with their code "
+                       f"(within {ARRIVED_DAYS} days): {arrived.sum()}",
+                       "Appointed after contributing"])
+        ax.legend(frameon=False, fontsize=9, loc="upper right")
+
+    median = years.median()
+    ax.axvline(median, color="0.2", linewidth=1)
+    ax.annotate(f"median {median:.1f}", (median, 1), xycoords=("data",
+                "axes fraction"), xytext=(4, -4), textcoords="offset points",
+                ha="left", va="top", fontsize=9, color="0.2")
+
+    title = (f"{title}  (n={len(years)}, mean {years.mean():.1f}, "
+             f"skew {years.skew():+.2f})")
+    ax.set_title(title, fontsize=11, loc="left")
+    ax.set_xlabel(xlabel, fontsize=10)
+    ax.set_ylabel("Maintainers", fontsize=10)
+    ax.grid(axis="y", linestyle="--", alpha=0.5)
+    ax.set_axisbelow(True)
+    for side in ("top", "right"):
+        ax.spines[side].set_visible(False)
+
+
+def plot_experience(df, now, title):
+    contributor = pd.to_datetime(df["Contributor Since"])
+    maintainer = pd.to_datetime(df["Maintainer Since"])
+
+    tenure = years_between(maintainer, pd.Series(now, index=df.index))
+    before = years_between(contributor, maintainer)
+    # no involvement at all, or a maintainer entry before it: someone
+    # else's patch added them, or MAINTAINERS doesn't match git
+    left_out = df.loc[~df.index.isin(before[before >= 0].index)]
+    if not left_out.empty:
+        print(f"Left out of the experience panel ({len(left_out)}): "
+              "no matching involvement, or in MAINTAINERS before it")
+        for _, row in left_out.iterrows():
+            first = row["Contributor Since"]
+            print(f"  {row['Maintainer Name']}: maintainer "
+                  f"{row['Maintainer Since']}, first involvement "
+                  f"{first if pd.notna(first) else 'none'}")
+    before = before[before >= 0]
+    arrived = (maintainer - contributor).dt.days[before.index] <= ARRIVED_DAYS
+
+    top = int(np.ceil(max(tenure.max(), before.max())))
+    bins = np.arange(0, top + 1)
+
+    fig, (upper, lower) = plt.subplots(2, 1, figsize=(10, 7.5), sharex=True)
+    plot_panel(upper, tenure, "Years as a maintainer",
+               f"Years before {now:%Y-%m-%d}", bins, "#eb6834")
+    plot_panel(lower, before, "Experience when becoming a maintainer",
+               "Years from first involvement (commit or trailer) to "
+               "entering MAINTAINERS", bins, COLOR, arrived)
+    # sharex hides the upper tick labels, but its xlabel still applies
+    upper.tick_params(labelbottom=True)
+    lower.set_xlim(0, top)
+    lower.set_xticks(bins[::2])
+
+    fig.suptitle(title or "Experience of the Current QEMU Maintainers",
+                 fontsize=14, fontweight="bold")
+    fig.tight_layout()
+    return fig
+
+
+def build_parser():
+    parser = argparse.ArgumentParser(
+        description="Plot the experience distribution of current maintainers.",
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        epilog="""\
+examples:
+  scripts/get_maintainer.py --list-maintainers > maintainers.csv
+  %(prog)s -i maintainers.csv -o maintainer-experience.png
+""",
+    )
+    parser.add_argument("-i", "--input", required=True,
+                        help="CSV from get_maintainer.py --list-maintainers")
+    parser.add_argument("-o", "--output", default=None,
+                        help="Output image file. If not specified, "
+                             "displays interactively.")
+    parser.add_argument("--title", default=None, help="Plot title")
+    return parser
+
+
+def main():
+    args = build_parser().parse_args()
+
+    try:
+        df = pd.read_csv(args.input)
+    except (OSError, pd.errors.ParserError) as e:
+        print(f"Error reading '{args.input}': {e}", file=sys.stderr)
+        sys.exit(1)
+
+    missing = REQUIRED_COLUMNS - set(df.columns)
+    if missing:
+        print(f"Error: '{args.input}' lacks columns: {', '.join(missing)}",
+              file=sys.stderr)
+        sys.exit(1)
+
+    now = pd.Timestamp.now().normalize()
+    fig = plot_experience(df, now, args.title)
+    if args.output:
+        fig.savefig(args.output, dpi=300)
+        print(f"Plot saved to {args.output}")
+    else:
+        plt.show()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


