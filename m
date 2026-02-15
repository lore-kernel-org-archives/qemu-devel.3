Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299BAE63F19
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEL-0005Xe-Ii; Sun, 15 Feb 2026 17:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEG-0005Vx-AP
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:37 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkED-00051i-Kz
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:36 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40427db1300so1821143fac.0
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193067; x=1771797867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VY+khrWva4TQzXBdBU/u3tJFGnrI2ZRRl79vbOIZYRo=;
 b=aRVli4jJmx2FkvZDZCpi/wD1zhFy1QwLv5RmWKWZkB150QTuW2bwcnMUcztzOEV3WK
 JSrrAX8aniXqLOs1Jg5M1vbLzCEON01CQ3yD5COv1LPkN0x0ebsrFcGc9sIxnvcPG1SE
 YIk4TsLQvae8I85VpWCJg+5NmZenzv7ciar0dlRg7T28agPP+Eu3+VofTXn1v4ZI50ur
 DGcAr5Heq3rircvGkKwRU/u3oZ1GMMPu3my2tU9+S3mMOty4JI98S3U/lMDep7Vlr5B0
 3dA+DFddOx6MypEGXVISOi0ShfWNxo6c1MGd2s0oe/oyFiRUQAMigJCygJ1sCaTcevYa
 nHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193067; x=1771797867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VY+khrWva4TQzXBdBU/u3tJFGnrI2ZRRl79vbOIZYRo=;
 b=XZZcMt27aRkKjXnrS3cu49G5dcepLj/mswdgJ04d1+9H0stIGQB713EiEA9v+K1t1V
 Ye4+waNyjp5yUpXuL+JskZ19dk84FHLFmNjVD0FpZrKhDng3hOOSY8NbwK/5xVmYRf7Q
 ZWEDamfke23fgwh4cNMnFlCrrmUDXFjZqYDxNloO02IuNhF+A59wUcnCjlzWo1FG84eG
 //NTfXiW83fGHPX0DjvMMDZSED9aiS5kakNG1Q+hbMEjCbMGtSdnjsv0HdpqnXxAlrH/
 Zbw+eIBBxQb8U1jPfZOgqG59tij3D2FmuYShl07IASUiZ4OksovJlpUXEnW+/gf8B8nC
 of4w==
X-Gm-Message-State: AOJu0YzMnFv/zvgueEG6icvcn6OYaXdZe1fJOvpKxWd6PFvGHUfZIgBh
 t1XcCx3bhqMtlgGDCWijKRIi+zpI5bS5ahbB4EvuhU9lPzVD9gpmv3ugfrtIAg==
X-Gm-Gg: AZuq6aI9LB61dZYurYO99hUiKYPclfVMRt9Wf5iaFowPHI0CzJCKFW3XoG7U95EHa7W
 EqDzgLc4i9+ZTJo6kz7Fpewr2vyGKOO3n/fQaqokaK6gc7rTuF3c2tS2z50v6xdbx4D3F1qBuIs
 /98fKCrexGmBd9S75uzV4uAR3WrmHJnl2xd6ZcUSSoqThTfZDpyp61WGwPS01SDg4YJNHKJ7C1Q
 ydWwFC2535F3Cht73ZasZztGFoSLGCXOSUD+eNf4bCO0FMkpVJw+DUDJ4hazOdaak1/HEOdg5go
 sH4rBJag1cpYPenCOcJkHOr59EkFdYxgtxtzcwn3lROwcOriOkTcKgkWczvTcFMhJ2cSI3MpcF9
 LwNL+2IQZyO2EQmbzMHZK7PTjIkJAG7L8xoK1GvqGNtYajtrRNRF5bkjeVJTySr+4gEj+D10RDd
 15oVb1a4WK794mwjI9OO8Pr/Pz5taNipN1xTgffCzkf0gzHxhQ2SlYYpPaVK0lZt3VS80OQtesa
 4XBrsVudRFj9l1y
X-Received: by 2002:a05:6871:890e:b0:40e:e931:e7e3 with SMTP id
 586e51a60fabf-40eeecf46aamr5645467fac.43.1771193067552; 
 Sun, 15 Feb 2026 14:04:27 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:26 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 2/8] Hexagon (linux-user/hexagon) Identify Hexagon version
 in ELF file
Date: Sun, 15 Feb 2026 15:04:16 -0700
Message-ID: <20260215220422.212249-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x33.google.com
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


