Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C22606A6C8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i9qJY+Jg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtH-0002Ju-5h; Fri, 20 Nov 2026 15:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrO-00018w-HO
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrM-0001tX-6x
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso7762865e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205122; x=1795809922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RDvtmdMQ194NiQ4xl5A88giR2nE2EpeWjbNgzjwo8rc=;
 b=i9qJY+JgpAUWJbQfmjE/ZhKPHMNI255h2vIGPj3esM/bsT8G5AO1FLQ/vrLk0RO7fU
 SGoYWe/POUaVsFzCJsq5FhhqqH1l+343EHhWwRiYkSWF/81UC9qLiNB9vClrMf2evlZ0
 BgjLTLRCowy+4XlMrfHZqGYgl+r4mtC1o+DUI4JK//KSg3p/6JuP9gzvyipq/PabkPiy
 6o7JbkqZAWn4OYcIumTfn+wMNca1trtrhSz6lqi5dvtVIT/FVnoaaNrUTRRN5yQ+OaFc
 S92JfzStVy8S3dLc9orjFTU54BaOTJbeZQSYw97h5xB8iLHU9eM0bC1v8kd0NuSbayYS
 QvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205122; x=1795809922;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RDvtmdMQ194NiQ4xl5A88giR2nE2EpeWjbNgzjwo8rc=;
 b=qzUEOozfIUzPLPGg418y8WyO/8kWdioNdpoKhAWcvGCzJBNzYKQD9kMYUuBkn6nLfE
 A75Tg77Nh51aI/KgTzgH8kB3oX/a8n5k+hmDe6nbeU7yX1G2jKSNKlr8641pCOYV5DHw
 u3eQlDf5nHqsr+Hpkn8Ob264lenDSwW4DIqcfs57RJRXakS5PeargzxAiB3zv4WP3a+9
 YlZuqlSnMnSfGDYfwdtP5usTu3L9qYjTeDvs+GbnTNzb3JYPKY7ShkZR4jkBAgBXj+nt
 mQy8IeYSKmZtB6do/OwgscsFDnE4M2cN3GUPl44wQwdQMUe9q7zzxxzJoD2HKPjVeJPM
 oj8A==
X-Gm-Message-State: APuU4Z8Uejo9xEDrCmTmmmbaRoOY0kJ/spV7kuVi5R4YhVL9S7G/ISdw
 dmQ+WlIHJDXpTbO2x/v5g5M3dacAEYCZS444OaCcBVidnJM4EKYrCzMDf5B94mKTTKY=
X-Gm-Gg: AYBFou1Dr04DhPWctEoNPF20ObTc/TqA/xeyr9WHHefiXS9gnKHigN6R4HtunubOVR7
 pNWf6b6tUPXWlhIO+ib/5XZJ5Bewba1Q+nEeCdb+JNBMIk+v6+cxIXv+YUNBbiBKO1NXQUHlRQ8
 PLEeFx9GQyY0he/XRhWPNl45bmW6kqJWz9hogvAnLt0ndRROcTHIfrKu0GCVv1VZfhpAecUVbRo
 7YvIKIUPiTK2PQYouqBcTwcY8wieBTWnaxwFq9Dya4DfrT8SPD8SNWFsi25Sn57CSVdgvygKX5B
 0NZWE2R8nm/n5nrPeMD0N99cR1SA9PQOCwN2Zm6QHoLUd7aEAD9DOXtLx1+G6Cc9kIOVCy7LWUM
 9PI+I24UKWJ5oFaG3QQwJH1RhYHklgdT5+v4WoM1kt9n8c6G7WBiUIMic5SutyIbAbulRrHIATn
 uWd6ToL9asYPLTh1uk+Ar+Xd30wRLDoV29QHdWSChoh/hUjtuIsgbESlMmMIEFDg/tnA2XDCeCs
 DAKdDCIB3+NwYsB6F7TtoYOfxf2FzwXqDiNhBG/V5q/Osi9CozM3xILoOxedws9ATA724aCsyaX
 cV3/HgZ912E5J4nI85yF+bS3qwpv
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb88813024mr102122435e9.25.1795205122431; 
 Fri, 20 Nov 2026 12:05:22 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm61062795e9.4.2026.11.20.12.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 544E35FB01;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 09/22] scripts/get_maintainer.py: add --file-summary option
Date: Fri, 20 Nov 2026 20:04:57 +0000
Message-ID: <20261120200511.822573-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

This allows us to process a list of file names and dump the support
details for each file.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index aff2ea8282f..fc155028cf4 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -11,7 +11,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import sys
-from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
+from argparse import Action, ArgumentParser, ArgumentTypeError, BooleanOptionalAction
 from dataclasses import dataclass
 from os import path
 from pathlib import Path
@@ -22,6 +22,7 @@
 from regex import compile as prec_compile
 from git import Repo
 from collections import Counter
+from csv import writer as csv_writer
 
 #
 # Subsystem MAINTAINER entries
@@ -458,6 +459,17 @@ def parse_args():
     parser.add_argument('--git-min-percent', default=5,
                         help='minimum percentage of commits to tagged as a maintainer (default: 5)')
 
+    # Output options
+    class SetFileSummary(Action):
+        def __call__(self, parser, namespace, values, option_string=None):
+            setattr(namespace, self.dest, True)
+            # don't fallback to git
+            setattr(namespace, "git_fallback", False)
+
+    parser.add_argument('--file-summary', action=SetFileSummary, nargs=0,
+                        default=False,
+                        help="Summarise file maintenance status")
+
     return parser.parse_args()
 
 
@@ -507,14 +519,34 @@ def main():
             for m in kmaint:
                 maintained.add(m)
 
+    writer = csv_writer(sys.stdout)
+    if args.file_summary and files:
+        writer.writerow(["File", "Subsystem", "Status",
+                         "Num Maintainers", "Num Reviewers", "Num Lists"])
+
     for f in files:
         rf = f.relative_to(args.src)
         fmaint = [ms for ms in maint_sections if ms.is_file_covered(rf)]
         for m in fmaint:
             maintained.add(m)
 
-    for rm in maintained:
-       print(f"{rm}")
+        if args.file_summary:
+            valid_ms = [ms for ms in fmaint if ms.status != Status.UNKNOWN]
+            if valid_ms:
+                for ms in valid_ms:
+                    writer.writerow([rf, ms.section, str(ms.status),
+                                    len(ms.maintainers),
+                                    len(ms.reviewers),len(ms.lists)])
+            else:
+                writer.writerow([rf, "unmaintained", Status.UNKNOWN,
+                                 0, 0, 0])
+        else:
+            for m in fmaint:
+                maintained.add(m)
+
+    if not args.file_summary:
+        for rm in maintained:
+            print(f"{rm}")
 
     # Git fallback
     if args.git or (args.git_fallback and len(maintained) == 0):
-- 
2.47.3


