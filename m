Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE5606A6C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=urihIXSF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUsv-0001xG-0C; Fri, 20 Nov 2026 15:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrL-00018O-Cj
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-0001sC-5K
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso638345f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205117; x=1795809917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nS/2ShJ+JR4p10Rlc+DozHGxl8+1BTCVWEZnAVnh64g=;
 b=urihIXSFclHqsZ8zMkfIxyhDtvIDNHAvJYuoUNEcGZ63RbQZEuTDeOQP0RFI2RI8J/
 rXMRg0ZTu9p0xsn/l36G7q2E6e26RHhEZoHOzkeCiRVwcyPZqJCsDl/HQfjSjftHdFQh
 IZg1JBuessu576qvDtFWKLj7EtuZMLE1tNLGLGaLOKWAX/c0i/S1xbg0oScxCpPnTNFV
 Og9Ze5nafF19ouHsS/GE/ztpXMHkeqRkJjRlIvUv/GP8MX543cRt4yk69hASbXKtkNaa
 9pv9kSbMZjEP9lhs7LsWxwA9ZUzChjNjqlr+Ri3UGLGgVNq81rUuCDyLoWgfIDs+hMIG
 IEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205117; x=1795809917;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nS/2ShJ+JR4p10Rlc+DozHGxl8+1BTCVWEZnAVnh64g=;
 b=qKXqfRCf+wySwLOWsMzgxAutZmzKKzJDruF2Eel05BWhoKKjfLx6ckkvS5NstAzPOl
 bkm8HB/bg95KUGuHu2Yiapqcw3m/r8GZLPH8ePXHPiFZKQZfz20GGj0SvYYoZZguQfYZ
 9GGTbkOqqkQPL+rhAoNHjtD6LZxRHNPYV5O4nBarkEXCfVFHjIsQOYJrY8vsLui92jnQ
 CSuLIujycEZmNucQ/GrAwwu2v5rt/EEKKQMhANC59Th7YTlcrWICSB4WN5WPOD5EW5nQ
 6NrRX6Yd8y0dOm9xoeFuORtSFHaVDzk9NL1Yz0yCftIMbrxRNlFZh+ztt2MJCnLt+RMa
 HO2A==
X-Gm-Message-State: APuU4Z8YhP7/thF+J5ydmyF/reAWDpIG6JL94/exinmnT2pB5dh0o9UR
 BWLkErAaXUDMCPlm14iegH3avzTr9ssdNvdUfP/nK3V6Av8FutceCDnJDoVwpSEZIT0=
X-Gm-Gg: AZFdTZdFPBBWKSsHytS+6TMITDFLwK7dcZAKMz95gRdPfVIJ7/UsPofFO6k9/RiRR8D
 q5z5fE5ZPA503JKrcvG6H+lw88/Rm5UxG5foVj0CSEUlsQ0gXhBlknL0iFfYK1G6DfTvzYwjbTh
 sHr/abX2S20raQ0sXqNPY/xYflNwWkdu6nckH7VShdw3I+lz1aVdVr2GHGGsX+AdIukIqDaxDIF
 ijWaMerbsALe+bWDgnJc/QcM5T2mEc4ghBrqt/lvwq2IXgzhhV6nkWVGeuV7lGbnJLYEE4HLXFN
 aKQR9+3oGrQdbOzjdgAvnkX760UXWQteJ0SEMN3U8V7YFutLFSeypr342DRzS/FCkM3ItPtNNZv
 SF4eYLwpb74Kbb45OQMnAngRZsJrFgMNEJCVTRCr4YJndGtsU9Ln6bWYiWYEfaWERKFv0rgsxJ/
 2WLQ+C295W7JrXltmRmWEg2fUYa8f6//BQnU/MTAL0jSaCJb1qbpBzv2/GJG5sK0LqkE3cohkbo
 OjEFW2f399CBSNxnVa/SHCaXlY7YGBGlb10E27BzN1bZ5Qir4v8fESCuk0mX//C0wwVX/UI2Oi2
 KhlAYLcKoM1uXds1YyVcQcy+nq0l
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id
 ffacd0b85a97d-4ac7595721cmr6160419f8f.40.1795205116700; 
 Fri, 20 Nov 2026 12:05:16 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm7842066f8f.53.2026.11.20.12.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C7225FA4E;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 08/22] scripts/get_maintainer.py: add
 --list-[maintained|reviewed]-by
Date: Fri, 20 Nov 2026 20:04:56 +0000
Message-ID: <20261120200511.822573-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

This is a simple quality of life feature to list the sections
maintained by a particular person or group. For example:

  ./scripts/get_maintainer.py --list-maintained-by "Alex Bennée"

to list all the sections of MAINTAINERS where I have a M: line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index ae97c755de2..aff2ea8282f 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -425,6 +425,12 @@ def parse_args():
                         default=None,
                         help="Just validate MAINTAINERS file")
 
+    # List sections matching regex
+    parser.add_argument('--list-maintained-by', metavar='REGEX',
+                        help='List sections where maintainer matches REGEX')
+    parser.add_argument('--list-reviewed-by', metavar='REGEX',
+                        help='List sections where reviewer matches REGEX')
+
     # We need to know or be told where the root of the source tree is
     src = find_src_root()
 
@@ -470,6 +476,21 @@ def main():
         print(f"loaded {len(maint_sections)} from MAINTAINERS")
         sys.exit(0)
 
+    # Build array of Path objects representing the files
+    if args.list_maintained_by or args.list_reviewed_by:
+        if args.list_maintained_by:
+            pattern = re_compile(args.list_maintained_by, IGNORECASE)
+            for m in maint_sections:
+                if any(pattern.search(str(p)) for p in m.maintainers):
+                    print(m.section)
+        if args.list_reviewed_by:
+            pattern = re_compile(args.list_reviewed_by, IGNORECASE)
+            for m in maint_sections:
+                if any(pattern.search(str(p)) for p in m.reviewers):
+                    print(m.section)
+        sys.exit(0)
+
+    # Build array of Path objects representing the files
     files = []
 
     if args.file:
-- 
2.47.3


