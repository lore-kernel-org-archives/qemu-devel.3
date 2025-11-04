Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F50CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbV-0006fX-6R; Tue, 04 Nov 2025 11:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbS-0006fA-8F
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbQ-0007JM-Jm
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47754e9cc7fso7107885e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272587; x=1762877387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MHZb1LdZqvo7UEAQF8ntiHG2BeGF10fj7LRcfuFkiE=;
 b=WRJPt8sxwzF8c04JeAyDZhXbYx1YCDpbVBdUd90a9UnS3XLvHvADRi2LSqxZNUmtyn
 mXp4Vt74wsvt0PfBqAwHeD1eEMfw0iquB7wncP0vrusX717WMc0P1Ihk7RATeZf+FBV+
 G4X1phxmC74A6bEd+zAV/Lz/WRvzdh+upy5hfKNGElt+vUvfOkJWzHaTQQDOkY9vtUqk
 YEomCPGtTrIL9WmovFuBXscyKDTpfuBOqJ+oK/amuJZOnq1lp0C/9JiKjLxzeHSvxURr
 qb09j57lOKbcgYgkYD3VqTRLPdXTrlf7Lpjf6/5YfczI0xKba7mTPqk52QHahN0X/YmV
 Pybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272587; x=1762877387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MHZb1LdZqvo7UEAQF8ntiHG2BeGF10fj7LRcfuFkiE=;
 b=FgO+RvmKinKWXHkucR4dhGLazIVWSu92i/kYh7jVF+6FU/MZcBt8DCBpH3hbEn2dGm
 cEieuikcjmLWobg6aAxmYTfTI1/lcPbziRkqngviohHnzj2JZKNBt7sBwGZX0cCGru9N
 NhP9yhm7dyKWBilqg41bo5SCiTjicCJLhJdPdgUZc+tp4IR4x2+o4NQ7J+KA5h0+2enu
 gx3tNEfpTiYn/EJeiCdbmCXCr5/27QJAqSdTAQBlfLUQgJoLkzN/lJyZX+J0bwpkne88
 AIczC6njGFPwrwd8gOmHwgf/wm7jQV6qd8xo255/kGDwNvBcYNuIsA86rh5Q/e4n+6Op
 tcwA==
X-Gm-Message-State: AOJu0YxKtVgZEHW/h4Auta5GoKIObeXlypRqNeboNwIcBe5idQf0ZY7F
 Fk4ZuJ6xpJ2CfWxhFTzjeWj9igDLtaPbQ4KWMj+spD9aJXvExja93AOciFeA2EhzxoM4VPE9y5O
 DKe8Z
X-Gm-Gg: ASbGnctYa4wgBswane5jjokeTQ6N1wx62Xl4lMik6DNiWiSIu02fdbsh2nQd3UQ/Lpx
 2PLNQZYE6lUOF0Y6TVexRZ/XTWR6L6VHuHp9MDw63hpCEfWZOu52EhOkcWIKIIDmxMf9dp+hGLI
 Ro9hB+3BsiCurLAZv2gkuM0P7PhydOWK7DC0DrravUXZ0f6ENOzgadJ0k2trO6URvnt9r/eSdkZ
 VyFxNSQr0kVwuBi1cN+jAgQ8lrOIOb4PqWFxBkVFUk86FE8AKvFscHSXM4eQ++yF0VF3cqsn4EO
 +ptAZzkOxLqc6ciX7/IJ5L+vXAGI17ZuqMKQEzwDiUoFtDpRfWsHeHs9dqccXFBBKjNRHhnyw/h
 QPc5XI7EpiE5DGKVeJr5OIa1Dfq07M7uikLOMl97ZhM7+8SNsLA9c4/BSGZ/U+kzGwXnSJeSTpx
 Y2rLLnMQ==
X-Google-Smtp-Source: AGHT+IGGhjEvjTjcjLT+0HdVLqmAaAOOQfrnumH0jIu+eMHcue+mWjYhsX9tBEBw9E+tQw0iJMxzZQ==
X-Received: by 2002:a05:600d:831c:b0:477:54cd:2029 with SMTP id
 5b1f17b1804b1-47754cd2172mr22065555e9.4.1762272587031; 
 Tue, 04 Nov 2025 08:09:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 1/9] scripts/clean-includes: Allow directories on command line
Date: Tue,  4 Nov 2025 16:09:35 +0000
Message-ID: <20251104160943.751997-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently clean-includes supports two ways of specifying files to check:
 * --all to run on everything
 * specific files
There's no way to say "check everything in target/arm".

Add support for handling directory names, by always running
the arguments through git ls-files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 25dbf16c021..07c0fd44e46 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -14,7 +14,7 @@
 # the top-level directory.
 
 # Usage:
-#   clean-includes [--git subjectprefix] [--check-dup-head] file ...
+#   clean-includes [--git subjectprefix] [--check-dup-head] file-or-dir ...
 # or
 #   clean-includes [--git subjectprefix] [--check-dup-head] --all
 #
@@ -28,7 +28,8 @@
 #
 # Using --all will cause clean-includes to run on the whole source
 # tree (excluding certain directories which are known not to need
-# handling).
+# handling). This is equivalent to passing '.' as the directory to
+# scan.
 
 # This script requires Coccinelle to be installed.
 
@@ -86,11 +87,14 @@ if [ $# -eq 0 ]; then
     exit 1
 fi
 
+# --all means "scan everything starting from the current directory"
 if [ "$1" = "--all" ]; then
-    # We assume there are no files in the tree with spaces in their name
-    set -- $(git ls-files '*.[ch]' | grep -E -v "$XDIRREGEX")
+    set -- '.'
 fi
 
+# We assume there are no files in the tree with spaces in their name
+set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v "$XDIRREGEX")
+
 # Annoyingly coccinelle won't read a scriptfile unless its
 # name ends '.cocci', so write it out to a tempfile with the
 # right kind of name.
-- 
2.43.0


