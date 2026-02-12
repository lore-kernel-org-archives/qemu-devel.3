Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BDCEDF026
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTa-0007id-Mh; Wed, 11 Feb 2026 22:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTY-0007hU-A1
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:44 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTW-0008HA-SY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:44 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d18cf89e72so2017169a34.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867281; x=1771472081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VY+khrWva4TQzXBdBU/u3tJFGnrI2ZRRl79vbOIZYRo=;
 b=jmEZZxNwqp9/VCYl9LQwbo8rcvkddOg2d49GI50VcHkQb3Gj30dMckuIT/CrjcLIUH
 /H3p39t04ftc0yKROTKIqNTcKElE3QScb1siMNkK2bAYM5A6nZiu2smvTaDAjmdJExtQ
 +VBxJ5XgbIR89jLg4aH/flYTCz2OwymAFANf0dZQErJ0PMcM0B8xlWc8tQ0LUa/GHIxB
 Pti6z9dt1FsMbjxS+kyq9uDOyV2J0zo/3qUY72VTHKFNmtMll1AUcQrI4dcZWLSGKk9C
 iBZw0GTDbldpfUFdLJ9m6vD/oqZeVSFwxEHExF59slioIxyDyMI0OnsAUHe9YSeqb0hM
 hs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867281; x=1771472081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VY+khrWva4TQzXBdBU/u3tJFGnrI2ZRRl79vbOIZYRo=;
 b=pBnckva68Phqo1NExxrGypGPog82QaQCVibFEhvo/EC7+G7SLzrhjbTYLPP8X18C+w
 XtXy94lVs/b1YVtTzrMoOfcf2Wp3LJKH3m2NwoJm2I4oZr6trEpjs2pl1YkJ19cStr4r
 UV+7mOQDgfnY3EBNGueB5f8M8FhbemnUx7by4J1yvX3Dvbqy1vpyJ4eWmvTuLloVQRrk
 wZI9pmqIA4j0Ig/WC++jCGNvWUDxieWfxXUpHpfT9kMXUlthuTDd8IC82AHgMiNtYxfc
 MteCZ95FADy0+2GUNLwFOpmKAUOjNZzt4io2ENrrw5Vv3UNi9PNbdd1VPNCzoXtlK0IA
 Y0Bg==
X-Gm-Message-State: AOJu0YybaFenqEtOT5o7B9Vepq7kny7DB9IE0swSOGfu+NDlNVNyPgpI
 Y11QTbaqZnwWNzNIiBhP8sZrI7GziqMR/k4xc4UrRofFgzHj3WUeAU3YU3BdsA==
X-Gm-Gg: AZuq6aJ+ss3njJvT23r+AIwXewiF6RyI4L43kDmX8fQpdST2kYtwM/8KKnWtIadSbMD
 1IMYTGYHZtdBkZarH5Us7Msa6iDjys9GjV1O+VvzlXe/MT9f5ABBRRIal+OUTQLZnSL+W1ug5M6
 pPOrfndwh+cT8K0Fmaglxv/DJVIBRdmLaM4Te6+4ZMS4BOpvk5eZMuv1/MwX56cnPkwOG5+/vD/
 RXZLUwx/0K2dHClFmQuLj+qih82cG+VoCiz2e5ZqlN0bEozKhlkq9bXRxqrtd7O7Q5CQmvOy75t
 RNqKViDzB6Bx0Q3YuE1Mklh3WJ9M0SFSbSZYCYS8zA7k40W3zGDrObmPKUheg9PM5nY5y9p4Vy4
 WKjqGCj/MZSYUy+FGiqqEGTV6pkXgWkJPTWSB0Xl4qS2ot2i0/4ZisZLDGF2rYuqO2Vj06/q29p
 iRL6TQy9VNQJH/QeHtdPG6SxUw8A0Eo40hUU1qxgl5t822udhZlMXGCWbTCvEVo84ybsayvFrPF
 khIwVJUM+LoQpIG
X-Received: by 2002:a05:6830:490c:b0:7cf:e32f:de72 with SMTP id
 46e09a7af769-7d4b3ff6d3amr633310a34.6.1770867281482; 
 Wed, 11 Feb 2026 19:34:41 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:41 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 2/8] Hexagon (linux-user/hexagon) Identify Hexagon version in
 ELF file
Date: Wed, 11 Feb 2026 20:34:29 -0700
Message-ID: <20260212033435.3598-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x334.google.com
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


