Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lH-0002UW-4v; Fri, 28 Jun 2024 03:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lF-0002Rk-D7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lD-0004s5-LZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso3145635e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558666; x=1720163466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rhSRW4lnt4/3qEqJkcY7/by3NHero7LaTXmV3ByZHOM=;
 b=ERj0+eIaKqiVzbHELASp0pWif0JkmmljjxNJxVxoGLNMIRQhcKN2VVWyz/XO0Gp6o5
 hkaVo24tWV/Bnb2b0R6ltRNYYAwO+gV7QtkgjuSKOM3kdQXEEdJFvVbxnJONxFXXFFBh
 tLAqLHYHmjt7F1uZYduaNeGOyuAuM7+7f2EdJlOcdBW8YywHxctUKXVPUKV3lRvTC7/R
 Mm/UcHLTfm1fhX236Jfwyhx4u7gcI7B8ACrKJvaS/G/MUdBX3KNHVEGXR8z5xaU+VsjI
 FgTiyrmVlTgpyNQUzEUok6DK8kRJYPfx2QhyyWNb4DJ8rnLNgXcwQGR3obV6Z/R2111P
 hiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558666; x=1720163466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhSRW4lnt4/3qEqJkcY7/by3NHero7LaTXmV3ByZHOM=;
 b=oDjeX6IBZtZnMtS/5UkJP6skgXTQHCNxbgKgcRBmQLHAQVVDQkvASLYesy81OE/VQ3
 kgyWNKq4qHn8qVV9oQ+cVBnQYiENVjEWHBZ/lHs7MmJYSYTn3MBHc9OB3z9V4pq65WWC
 TU1MS07FSFdX85VfzQ0TrLoGwLeS/mNHvA7rtqxpCx3fObRJXOGP95JWzkM9EMmiaYTH
 I+8LluYRTpkCeduCE/QuhxHw6CwLgu5vSGER6XuhSfNH1yu3dYxiYkvrL/3Wf7aBHFAP
 /2l06lat28cskzC+q4L5bSIMz/1hpau0B44bh3rljLbdN2Bpn2312cwaXnMsYGVKB17z
 /ejg==
X-Gm-Message-State: AOJu0YwGyda1rZpbScziKjhckXLPEb35BHeH4Sd+TYI1hAdeC5+BiJso
 jJr7R2UnjvG+7UQpeLjfC8fXj3gupszzcSMJIkdyUbsgis27/32LIN3p9FWStY+V1gLeIZpe/lD
 Odus=
X-Google-Smtp-Source: AGHT+IGgysns2MB8ujJqMe1+IFDFJdfLb/r8ZMihilRH/dfuHmFDoBKGr8z61MzFlAVOFt2oIe/yVw==
X-Received: by 2002:a05:600c:68cc:b0:425:5eec:bb84 with SMTP id
 5b1f17b1804b1-4255eecc517mr65763395e9.36.1719558665800; 
 Fri, 28 Jun 2024 00:11:05 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm22071075e9.11.2024.06.28.00.11.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 91/98] hw/sd/sdcard: Adapt sd_cmd_ALL_SEND_CID handler
 for eMMC (CMD2)
Date: Fri, 28 Jun 2024 09:02:07 +0200
Message-ID: <20240628070216.92609-92-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
[PMD: Use aspeed_emmc_kludge]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index dc692fe1fa..f875fcd741 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1218,7 +1218,13 @@ static sd_rsp_type_t emmc_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
     switch (sd->state) {
+    case sd_idle_state:
+        if (!sd->aspeed_emmc_kludge) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+        /* fall-through */
     case sd_ready_state:
+        /* Bus always won */
         sd->state = sd_identification_state;
         return sd_r2_i;
     default:
-- 
2.41.0


