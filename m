Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E41CA100C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmS-0000Gj-Co; Tue, 02 Sep 2025 09:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmQ-0000Fd-6n
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmL-0004Mu-1g
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b8b7ac427so13552685e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818623; x=1757423423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcjLwpsqf87AISo9maOgTW1/b11sEJi/zY3MvqFe2Zo=;
 b=YYdeJH4+y/K0pLg5rYFaGFyZsG0tzlS3VwTWF5+kHaRlcWho+bRvpsYv4Kdr2zRCYU
 sVESnquPkVEaCA+C4oI3Rq+KHkNuboRWGNPr9IzWlBlFdOrhCXY90lTyMwoqFznjE+nf
 OOy6koca7QwuvG3K6r5PPxr+cGM25WFuLaCXvsH8SZnBvV7+Xkb/r3RgG7eaXJPfAZDz
 o0okj2WtZLqRTALLBjZUfg+8/D9uevV77pFGxc6HmDwwGGSx6Kh3KJ3/PRBnaaPpgY4t
 9iwd57t71ya6pXaptSf3Bq/8ke/nyRWOTs7Bdi1+L/wpSeqRtvtd5PqDkpxhtGLwgC4n
 b7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818623; x=1757423423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcjLwpsqf87AISo9maOgTW1/b11sEJi/zY3MvqFe2Zo=;
 b=WVsIHCmc87eBALLFsck/xO0D+d9fawLiu+uL+WjMLNw9l8EBnRfE1fGSBBpRDJSd/2
 OikD7FRbgblCxi5Oj5PY6yoVDUw+kewidwAM/FI2vYZ/XHZ6CAO4WVMupW9y+unbxKuI
 hnq5SsW5+uSr5HM4qFE6sbmRJbW/0BlathrDFKGpGjIxwZWCLUmxw2QtjLJntUdPp7J5
 Z9WGV4lmVcDDjHUeekKH3LfUIrEvmV1U2RnEH9Qa4L5NY/xNAfq2tUBGaPfqmFYDtnKi
 jqSWpGbfJH1pK2UIanA+bKGWJTRFXc1B1MTlUh6u2hJc56itgSQWY0WiQrSBZqUA5TG+
 jpXA==
X-Gm-Message-State: AOJu0YzqnNZhSSd+1siI3W9ObMipgM+NrnRiSKKxVVu+071/Zsc6sL05
 tzqdYMU3Es+9cC/CoVM3ii7KNPZz1/h7g238cWkYmqioFDj4KknAkubqqkk8gdqIYeQQwYuARsN
 /VxSI
X-Gm-Gg: ASbGncsrzgws5YDahM+xff2+IYUQ18eodBVIb/OWaseou5gkSwoU0NMo4OQFmOCarNm
 /PRYicPypR+6yo4ioX9utn+XTS287VQiH7WIDkGPw3ac9QOgYPC+oxMZtq11QP7iELpsBNoSUXR
 w2qhx+vCmZIwsKwBpMILq4dnYx8dRjooDFnImEowgv81ZxPdjpVYlK9TaK3kaZMOZWm3hsTX+XY
 iZVuMSYAMeT/VzRXP0utRqOcAwo1G0GZ2Cw7E1BgfHBv9wAx2GuI/RUsk7byC00z0PsNm//IHuU
 f/rjfFZmYk3teF07lFmLstJ05sEfzn86iHLi2ihjvGoK5YrTWr+4N1Wp1YTmZfy+8zS2UyQUg/v
 qZ3eIk8uxAC4Sej1Ox9viPndwMkFbT5FrNY9IRiUIbTq3X2XmWZ1KPz1VQg0K6158Lu/dhI+G
X-Google-Smtp-Source: AGHT+IEuFY57piJM7GsBhC1Hi9XbBEowvG/cvPF9V4SYNzDdEAJad/ZB2PRFaoVe9nlOp6oLqyhY6g==
X-Received: by 2002:a05:600c:1387:b0:45b:615c:cd2 with SMTP id
 5b1f17b1804b1-45b85525da3mr105213185e9.8.1756818622777; 
 Tue, 02 Sep 2025 06:10:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d85f80d8casm6336051f8f.54.2025.09.02.06.10.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/39] hw/sd/sdcard: Remove support for spec v1.10
Date: Tue,  2 Sep 2025 15:09:38 +0200
Message-ID: <20250902131016.84968-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Support for spec v1.10 was deprecated in QEMU v9.1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240627071040.36190-4-philmd@linaro.org>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  5 +++++
 include/hw/sd/sd.h              |  1 -
 hw/sd/sd.c                      | 12 ++----------
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5d1579dcf82..6ae69206817 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -434,12 +434,6 @@ recommending to switch to their stable counterparts:
 - "Zve64f" should be replaced with "zve64f"
 - "Zve64d" should be replaced with "zve64d"
 
-``-device sd-card,spec_version=1`` (since 9.1)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-SD physical layer specification v2.00 supersedes the v1.10 one.
-v2.00 is the default since QEMU 3.0.0.
-
 Block device options
 ''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 25a904032c5..332d07e2b18 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1186,6 +1186,11 @@ by using ``-machine graphics=off``.
 
 The 'pvrdma' device and the whole RDMA subsystem have been removed.
 
+``-device sd-card,spec_version=1`` (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+SD physical layer specification v2.00 supersedes the v1.10 one.
+
 Related binaries
 ----------------
 
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 55d363f58fb..91b5c40a5f8 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -56,7 +56,6 @@
 #define AKE_SEQ_ERROR           (1 << 3)
 
 enum SDPhySpecificationVersion {
-    SD_PHY_SPECv1_10_VERS     = 1,
     SD_PHY_SPECv2_00_VERS     = 2,
     SD_PHY_SPECv3_01_VERS     = 3,
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8c290595f01..8b142e4796f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -195,7 +195,6 @@ static bool sd_is_emmc(SDState *sd)
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
-        [SD_PHY_SPECv1_10_VERS]     = "v1.10",
         [SD_PHY_SPECv2_00_VERS]     = "v2.00",
         [SD_PHY_SPECv3_01_VERS]     = "v3.01",
     };
@@ -407,11 +406,7 @@ static void sd_set_ocr(SDState *sd)
 static void sd_set_scr(SDState *sd)
 {
     sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
-    if (sd->spec_version == SD_PHY_SPECv1_10_VERS) {
-        sd->scr[0] |= 1;        /* Spec Version 1.10 */
-    } else {
-        sd->scr[0] |= 2;        /* Spec Version 2.00 or Version 3.0X */
-    }
+    sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
@@ -1555,9 +1550,6 @@ static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
 /* CMD8 */
 static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
 {
-    if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
-        return sd_cmd_illegal(sd, req);
-    }
     if (sd->state != sd_idle_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
@@ -2773,7 +2765,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
     int ret;
 
     switch (sd->spec_version) {
-    case SD_PHY_SPECv1_10_VERS
+    case SD_PHY_SPECv2_00_VERS
      ... SD_PHY_SPECv3_01_VERS:
         break;
     default:
-- 
2.51.0


