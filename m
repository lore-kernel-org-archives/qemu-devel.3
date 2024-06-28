Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08408C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5l4-00027F-Rr; Fri, 28 Jun 2024 03:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5l0-00023K-QR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ky-0004rC-Qg
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so2222885e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558651; x=1720163451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CppPyHBGnGyh+KeMhLUUfKK62hbBIjgp+PC1jB0KmHY=;
 b=PVZQAHVsrg0+QA2EhMrTnLRi30TJfH1Ej8R3KDr2PF6LPgChUk8UpLARO21EOPHe4v
 ehAgji34leJqfUg8HW0btwRwOsoIMPQZaKOesjHRA1mUBrIbe9ruwiU6kJe9xOrPosrK
 hbV4d4+nkuk8BxXMA9TdVLO6JrhASsMJV6z2t4vMxe0auNWUOh6/gr2BV8Rtq9eFP10j
 13dOkkoWiEt/L07cqUD+kuNjttaj5YGVoq89+uMeDyhmjB0wavj1f0MO4MJ+K9TbAxte
 +00IOw3taO1kQ+47fPdwGXhqRf/GVEmYVA+5VriW9yiiDoO4rjtXOOsZWCaujaG/hhV5
 +ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558651; x=1720163451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CppPyHBGnGyh+KeMhLUUfKK62hbBIjgp+PC1jB0KmHY=;
 b=wkZ1jh8FX3J72seVjgbjAhVLn7IPKYhM3NeMm0PZsRKOL6RPXfQ9Z8pwkHyGJ6vXRy
 dZyEJw8iBo9rWxPqAjwsj1B6YA1MPOks36Qbiocky/njCDdgk8FiyIAeJPtAwB3BVmey
 Tv1Pg8dF526nHh9bVTd7DfOpoxmfc8vRNr+aSXjXgz+AXme8jUhKXmu/Dmbl+vxQkOda
 f0/v+Lj7j23HrBiW+F21+9lShgMtmNovoV7U99+a6DjuJml8chAsRRgMT0pNBJFWJFCI
 /+SPZfVK3QWyN27QuzvB7SPb382ybKXcenVXkbuXkyNlrCUpsdCTO2VOf03yZNfg9OwD
 1VgQ==
X-Gm-Message-State: AOJu0YwRLmDZTgib0TYGPd2Pn4qKB5SCqrWlX4gqatNippUL4vxXPMD3
 hUwg3526NQDhATxXCuYNs25bFyq87K1YsM6C9hXDlBieIXQdIKXir+ROKia7p2cw9VY1J18FByQ
 0LWE=
X-Google-Smtp-Source: AGHT+IH+gv4K6fguDUiGJumLj11p2MVomqcoWZYedxjYoiSeLMD323j48cjX6FTNDSRLhk99GvPIxA==
X-Received: by 2002:a05:600c:3216:b0:424:9f28:22fc with SMTP id
 5b1f17b1804b1-4249f2823a4mr69757575e9.2.1719558650733; 
 Fri, 28 Jun 2024 00:10:50 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c17e6sm21500175e9.42.2024.06.28.00.10.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 88/98] hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler
 (CMD26)
Date: Fri, 28 Jun 2024 09:02:04 +0200
Message-ID: <20240628070216.92609-89-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7c6f5ccc72..0f9bab105e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1520,6 +1520,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD26 */
+static sd_rsp_type_t mmc_cmd_PROGRAM_CID(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
+}
+
 /* CMD27 */
 static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
 {
@@ -1868,9 +1874,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 26:  /* CMD26:  PROGRAM_CID */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2429,6 +2432,7 @@ static const SDProto sd_proto_emmc = {
         [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [26] = {4,  sd_adtc, "PROGRAM_CID", mmc_cmd_PROGRAM_CID},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
-- 
2.41.0


