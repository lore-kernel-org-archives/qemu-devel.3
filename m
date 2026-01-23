Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C112D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInp-0007SX-34; Fri, 23 Jan 2026 10:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInJ-00072s-5L
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInH-00033k-I4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so2072697f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180990; x=1769785790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OscJg3dXrkhUjYsDycoGawVwLO3SVAen9cLVTEr2T6g=;
 b=LXnr5B2xApc6xxEpaNGSQp9DR5K5juGp/6SceYOU9A3jOWVNB750TuqN18Ic0yvUtG
 H/0ZCYRLVn7YwlDaEbdo/DfmQDfE0hLdN/o3SPK8SHW2xGUaPLYn/imTlYb0FGhZcDFg
 goHyvn/wpmxbnwyRgk+36XPLLBWS97pmXxV07VCoiC0LEEVXkTKjzKDIoiPR08+iyBvN
 Vt4TnGFVHOxp5VUdSOiX06E2KTgypNtSxsFN3PrLZ8/JtFmjWqHtaM2I5RnY4ccnWUuk
 NIFt32bb3f9vJemYdbfLFrD5FDtLa7QBvh0PiB8TNGZf2hbfeuj0xwmvG3tGihuWye/d
 rsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180990; x=1769785790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OscJg3dXrkhUjYsDycoGawVwLO3SVAen9cLVTEr2T6g=;
 b=fahMBPURP3zSUGla02qZnvqRXa2q4btTycBOYXalHpiu9r8HPnrm6xl2kqYSTjQXFY
 f8hroBPr5W/5fDX3wPhLWmrcglyNsYDSCNM59UQqSKUsIFzOEKnnmvIKh6BMea+6ar33
 pHDf9IPegdjuYftA9F6IOmnz5MGCqcFpA6QkLdxcQ+EblRpClMQ0JmgaTEdH+QhjFlgv
 GD8yAu/mcITeZDVsI7sJvjOO/aACbIxu8DZUYs8M0r22nvjfY5C+94eejG9FpIGLvSCh
 +gu96lXjv10ARepEgvpOuco1lhpHROEmiDJkqP8eETVn8l2ecyqcL6oWNzGcD9yyBzX3
 Jb1Q==
X-Gm-Message-State: AOJu0YzT6KXdkS6rJuAtsqVFZubdt6h4VOA5AJaofSudXOUNIpJbjDAq
 QxqbrXXXxW0a0ID2lC1gi0S7tlal/K8kS9tvRp8DWKx8AiKCqbKfNHCBLB2VfviEVVK5IpidE+W
 BkBp/3qs=
X-Gm-Gg: AZuq6aJb0iauwV4iKpsVGqQsn2f2m14reXXzucII/VZOStcq4qNh2PokJ4oinZwqOEe
 emelnIOltgbw+5xjEvHZV0TY/VEFseT7KxVyMxhEmcOSKk2b++C5FHzhSz0iluT82Ck9Oml7wwi
 1KAResaXW9y5OJ6U+JdvnCH8Yyh37B19qeWX6ERd2Ds1cu6erodvZh9tlx2+a6FSviGRDt3mVj0
 2moM2bIaUvrrJ9Fk/6z3OyIPdLC3w6cp+rcT0cwQAkR4/kOA0SsN7ceUNBnocS2A4De8Ul8AqLo
 gSxjHDKHV68IfjqMr3JZPO6WW5A+N2mQxKZNCvTPpNqqKVvlyaslz4XQ5L3/+4Q/DraTMbsQpp0
 NBGCOWXHVhuGBO43LEUuPxpYsqyaY9HEfMvI1UYBKaomjp0MjnVAwB9iPorrfSWRNe35eFN5fCp
 m2qy+WJQ7HVxTIqv1cjDbF+LosGf8D1J5qbsjf+518MHb1/ua1Wxxf
X-Received: by 2002:a5d:5f54:0:b0:430:fcda:452d with SMTP id
 ffacd0b85a97d-435b15946cfmr5374042f8f.22.1769180989844; 
 Fri, 23 Jan 2026 07:09:49 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/22] scripts/clean-includes: Do all our exclusions with
 REGEXFILE
Date: Fri, 23 Jan 2026 15:09:26 +0000
Message-ID: <20260123150941.1877768-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We currently have two mechanisms for excluding files:
 * the REGEXFILE which excludes by regex
 * special cases in the "loop over each file" which make
   us skip the file

Roll all the "skip this" cases into REGEXFILE, so we use
a single mechanism for identifying which files to exclude.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260116124005.925382-5-peter.maydell@linaro.org
---
 scripts/clean-includes | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 5ab3b07196..a45421d2ff 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -104,6 +104,15 @@ grep -v '^#' >"$REGEXFILE" <<EOT
 ^ebpf/rss.bpf.skeleton.h
 # These files just include some other .c file and have no content themselves
 ^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+# These are autogenerated headers
+^include/standard-headers/
+# osdep.h itself and its friends are expected to include system headers
+^include/qemu/osdep.h
+^include/qemu/compiler.h
+^include/glib-compat.h
+^include/system/os-(posix|win32).h
+# This is for use by plugins, which are standalone binaries
+^include/qemu/qemu-plugin.h
 EOT
 
 # We assume there are no files in the tree with spaces in their name
@@ -137,21 +146,6 @@ for f in "$@"; do
     *.c)
       MODE=c
       ;;
-    *include/qemu/osdep.h | \
-    *include/qemu/compiler.h | \
-    *include/qemu/qemu-plugin.h | \
-    *include/glib-compat.h | \
-    *include/system/os-posix.h | \
-    *include/system/os-win32.h | \
-    *include/standard-headers/ )
-      # Removing include lines from osdep.h itself would be counterproductive.
-      echo "SKIPPING $f (special case header)"
-      continue
-      ;;
-    *include/standard-headers/*)
-      echo "SKIPPING $f (autogenerated header)"
-      continue
-      ;;
     *.h)
       MODE=h
       ;;
-- 
2.47.3


