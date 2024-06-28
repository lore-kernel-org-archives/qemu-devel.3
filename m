Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97511C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5g8-0007Kl-8Z; Fri, 28 Jun 2024 03:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5g5-00070C-BB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5g3-00037p-BW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so2619765e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558345; x=1720163145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a+swjnqxsHD9ZmAL3ZynjQXwZx/kNtJr6qmfanG6zVA=;
 b=c9PARPRod/MFBb6AB0FGgcCvKZ/yfygLfp+YjMl7hVzm2INYYV2OzdJFjyRmsZXIi+
 VQFhEl9mICd7gd+VfywFAmnEr5fTsusWyFIR4u+YDz8XU3ZCFq4OUUMQcTdhrOpCoqgR
 xq+m7FOeLgc0puVghMqzF9zu2fDfjFcEfVZjjiPremLoEsaNQpV5u0BY+4Z7CYMG0DEs
 yCVNt9XJIJKhnDVy3/FNpMweqbE9BOMevbxgOdWkhVX7MgmUi4M8YRt+lvpRnDFBtl1z
 x9qwkeCHekJ2HhsQtDNgV/fPYk4y9BV0ordfgLgbsITbXNxDEXKzXyQVRvBr19tWWyCb
 ru2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558345; x=1720163145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+swjnqxsHD9ZmAL3ZynjQXwZx/kNtJr6qmfanG6zVA=;
 b=wG1MOlQ03y4wChfE8Z7SIpCXq0d+4iyNl8QIVPNt3tb0REVhNhbsdkev5AKLmKWLz7
 YD91+SEST0VhdVVd8TsASEB7LibdruQ3x51r20RlRTT3dHbOQ3nprn1ad+B9J8s4MumH
 V3rt8LpuYyB4BH0ffVu8Crz3ex5tTx0p75DecpLNYT41hZR0A/HKvukVWPDjwNYsMzcQ
 YTfd5ornIKQCtwJ3GptV2+tWmCb7f2Qxw8IKTUAHNrqnNS8qUys93ckNv3k/v0ZMwrDV
 F1du5X5JiZoEjC9cnosLOTDsaxR05tgHfdeo39GEipU3QtkrUYWkYG2z4QE9iGGt3noO
 FQFw==
X-Gm-Message-State: AOJu0YxjzYMo6srMaGHphddI7Cgdk/Iz6dGahsprjoIvqNmdQkWwbeDD
 vYqunWvdLrOP21Rd/jyTKziHFT0m9qB9NO6iYU2QsnevtvuIBiZ8I603kJQH+4DvZraIpLQYzTO
 FOwc=
X-Google-Smtp-Source: AGHT+IEEZ/wL6n/wMLMt+8tuHvxvnIX6twS0oabDEid6bOlHjFmZR4/5nZinengNCJCmW+zuMWXAWQ==
X-Received: by 2002:a05:600c:2192:b0:424:bb45:cdea with SMTP id
 5b1f17b1804b1-424bb45cedbmr51828945e9.22.1719558345582; 
 Fri, 28 Jun 2024 00:05:45 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c16bfsm21109305e9.39.2024.06.28.00.05.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 34/98] hw/sd/sdcard: Convert LOCK_UNLOCK to
 generic_write_byte (CMD42)
Date: Fri, 28 Jun 2024 09:01:10 +0200
Message-ID: <20240628070216.92609-35-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
index bdd5f3486a..0cb528b0b2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1628,17 +1628,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:  /* CMD42:  LOCK_UNLOCK */
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
+        return sd_cmd_to_receivingdata(sd, req, 0, 0);
 
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
@@ -2109,8 +2099,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
-- 
2.41.0


