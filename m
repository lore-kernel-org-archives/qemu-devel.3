Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87439E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSX2-0002aE-7f; Tue, 17 Feb 2026 16:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWz-0002PP-TV
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:53 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWx-0002H6-Vd
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:53 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-463a0e14abfso2454257b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363371; x=1771968171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VY+khrWva4TQzXBdBU/u3tJFGnrI2ZRRl79vbOIZYRo=;
 b=klQCoCKVRf0l4Iz1lfbVbsvMDK4ZuZgXaLAY/mxzUQBpuzx3PeiSb9ymOTYW3JC3+g
 9w6FoLbp7a6qWtOTlaVF2I2SuXWuPfN1YpgP8JXq9fnFB9TDMDonNF4cESCiWPO3JFHx
 o/8dMqVLzQvwVd6vrwr4lJbxiciJ8P32tltuUz+iiZ3zqmk8m5H96o6l8RjIxb5c5Z7f
 hhn5Sn2j2gw19KTCs1Jdp8/Zq4Pvg3+Ey+A+6hJRq3MhT3JVCFoFeGBsutpxlCdTKBCG
 FcjCGOAj0V+z8lQXzxyk++WjYEx2cN4YSkjEKWYlvzLxyaot0DM/DQts5Q9lFyyu6YE7
 vJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363371; x=1771968171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VY+khrWva4TQzXBdBU/u3tJFGnrI2ZRRl79vbOIZYRo=;
 b=uaIrEVJRWXmXPSvxdicpexjSZ3KcGCZ+4T5KIr9/vtygPKM4Ps9dh7XF1XF3ENHGFL
 kLovyRTNzBQI8TNKUGdgubeHdWlkkpd2xCgdGaLmTK4v3i/sgHDnNp3uqHKAqxdI3Z30
 pXvgouqjuWktRWni3sMbqPaXnGtLrYjeBZL4g3Lp/xuHrekiK4MwkH1O6rtfIExXUD85
 HcwUgaydf8GEKP588SE46xQxFp4lhzCUj3LiZWP8S1DpEIWTmGT/hgQEiKfDq/caBKvY
 rghACp3gLgSnVmneIf1hnjtJQ0ccxbNXReVM6KwG67v0di6QEO5u7XgTc1ixZzRHVvVF
 RJyw==
X-Gm-Message-State: AOJu0YzBfcOd4HUgxyOizzG4utQWR+qF8CN2bWcxXmypLGikkHMQvs94
 D52qqi9YfTWUTI91RI2p+aN+tHKHEaTPOXSAWGa1ijXqSCUdXo3nONnVqlwCWw==
X-Gm-Gg: AZuq6aJ/RXGZh6oHgfCPUd/2bKp7/alz5Fe66G3trJ+87O65wqIlGo3KYa6xhWCuPxh
 sOadxxuhIAGUiIYeqFioB7DvrMtca0HvMG3fLGbbKxJY5Myv2WbRDDIM7cyPkSfMwwz8dM7LYu3
 ed83yLdF8/iqNJXfQR1M2W7+Fio/eIjZtCke/rJhGDlfBjNGI0SAllCYTiokpzczBNXKwp7wmcF
 v9ax2cHolUvm8MG1QYvcIrjnzqnU5VBLIDmhIBestzatUgVuUJiZJYLBBCEAl8zEZPtCvgnxhoD
 gU6NyEenaHaGvZE0lCNvtcNxWnNz0uMg274VHSwi8HnaXlGABWWSjap0RBz8t9cZiHMsFxRhITo
 frFBZi5IfqJL70jl3GMcA/ia/THBNbXWcVcBy66/JvM7AkbLVtzcjS7aRv2zfjaTH/MiLb2i0ig
 wxslDhMndUR1e8acaL+PgE2DLaIhx4orn1nXwuE06sVbZBfzjOdqIPhPfkxVFMZy9q76p+xsTWn
 oyBTYWQP/p8C9Ah
X-Received: by 2002:a05:6808:1302:b0:450:6eb0:3481 with SMTP id
 5614622812f47-4639adb5e20mr7367711b6e.43.1771363370675; 
 Tue, 17 Feb 2026 13:22:50 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:50 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 2/8] Hexagon (linux-user/hexagon) Identify Hexagon version
 in ELF file
Date: Tue, 17 Feb 2026 14:22:39 -0700
Message-ID: <20260217212245.95321-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Return proper Hexagon CPU version from get_elf_cpu_model

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 linux-user/hexagon/elfload.c | 43 ++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
index d8b545032a..39b0201814 100644
--- a/linux-user/hexagon/elfload.c
+++ b/linux-user/hexagon/elfload.c
@@ -10,23 +10,32 @@ const char *get_elf_cpu_model(uint32_t eflags)
     static char buf[32];
     int err;
 
-    /* For now, treat anything newer than v5 as a v73 */
-    /* FIXME - Disable instructions that are newer than the specified arch */
-    if (eflags == 0x04 ||    /* v5  */
-        eflags == 0x05 ||    /* v55 */
-        eflags == 0x60 ||    /* v60 */
-        eflags == 0x61 ||    /* v61 */
-        eflags == 0x62 ||    /* v62 */
-        eflags == 0x65 ||    /* v65 */
-        eflags == 0x66 ||    /* v66 */
-        eflags == 0x67 ||    /* v67 */
-        eflags == 0x8067 ||  /* v67t */
-        eflags == 0x68 ||    /* v68 */
-        eflags == 0x69 ||    /* v69 */
-        eflags == 0x71 ||    /* v71 */
-        eflags == 0x8071 ||  /* v71t */
-        eflags == 0x73       /* v73 */
-       ) {
+    switch (eflags) {
+    case 0x04:
+        return "v5";
+    case 0x05:
+        return "v55";
+    case 0x60:
+        return "v60";
+    case 0x61:
+        return "v61";
+    case 0x62:
+        return "v62";
+    case 0x65:
+        return "v65";
+    case 0x66:
+        return "v66";
+    case 0x67:
+    case 0x8067:        /* v67t */
+        return "v67";
+    case 0x68:
+        return "v68";
+    case 0x69:
+        return "v69";
+    case 0x71:
+    case 0x8071:        /* v71t */
+        return "v71";
+    case 0x73:
         return "v73";
     }
 
-- 
2.43.0


