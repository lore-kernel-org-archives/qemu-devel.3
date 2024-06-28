Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A456C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5g3-0006j9-Sg; Fri, 28 Jun 2024 03:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5g0-0006Ni-0C
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fy-0002m4-65
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so2791445e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558340; x=1720163140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R6Piulxoj8zPwW1Yv8YFFcFYZqBjXPSZ0pu/dRDGp6Y=;
 b=hCzbBxeDhfd8dlPIEWryRCNgCFyUGhCskfLFY4Kdv1PkZNEZ/OQTcDFaIpbJHWTjam
 Zrwh8Mr4bOIaX5GyezYq5un9fodN7LGxaykUauD0/ggxqHRTCwyoeJoLI48Fh3lbz/Gu
 SJr8uYkEd01XSn15oswptcXYqDRUa3drXcQ8MZdNPNl1sMrZvlBE7Toi1PxioYCvAFiT
 QVGmAuFMCE3Gby82oe4KHB+/vdnePHXhEQSco+9I6Uhmfj2+5ASJ/U79FN1WzlM+XiqR
 wlkqzocUflHYQMDxr9i/j0U2Vfvu1Th7sfrw9F37M3ffXvxrZQ3iGlbu1j3xc3iakCJq
 OJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558340; x=1720163140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6Piulxoj8zPwW1Yv8YFFcFYZqBjXPSZ0pu/dRDGp6Y=;
 b=fqQgp4MR59DYrvsu20inJie4f4woQ4lYkzVxlpwiwWAAVcKxCbNErI3J0OyltUJ6eD
 dXzRr+E008vHXKgHX0iA7PQNfasaDH+k7js+OeJjZbBv2h+vwGv0BdZoAeYZlXpp1ngF
 rcbENtSNMhUfXK0NU4mPVfBA0HzRd6WfCp3d8yj30mMxX3bejIg6VqJPK9tvjZik/Yie
 p80OML+9p4JKLAna01mZHfiI7t+p1dB7siRWpXcBLMvb1uOMWh2pmqKM5InDPZByss62
 ebZSCZ8xHWWUTkKbIbgP5gtGwnUrhSBpUGNr01oMf2gxKuB6Axc93DdigT0ZeNBCkEqw
 C4hg==
X-Gm-Message-State: AOJu0YxqW4KWM2meIMfVK+WcmNRYCdnLEkW6a/aATsUhjqCXDKtWlefr
 LylHVEqKuyp1AZ4nsmeY3YepOMTUCoZnx73OmSFCnEPuh6pgBeJd6tmDRaodST6GqI+64WmMz4A
 t7yo=
X-Google-Smtp-Source: AGHT+IGD1t5gUNGE/J41hpGIkOWkD2+PHLTY74ZshV4yB4RwknINsgwSdOOCMdcA8vLJjmI+bzHCow==
X-Received: by 2002:adf:9799:0:b0:367:40cc:ac2 with SMTP id
 ffacd0b85a97d-36740cc0c8fmr2527052f8f.48.1719558340498; 
 Fri, 28 Jun 2024 00:05:40 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd72asm1334859f8f.10.2024.06.28.00.05.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 33/98] hw/sd/sdcard: Convert PROGRAM_CSD to
 generic_write_byte (CMD27)
Date: Fri, 28 Jun 2024 09:01:09 +0200
Message-ID: <20240628070216.92609-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b9c72a0128..bdd5f3486a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1518,17 +1518,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
 
     /* Write protection (Class 6) */
     case 28:  /* CMD28:  SET_WRITE_PROT */
@@ -2096,8 +2086,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->csd)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
-- 
2.41.0


