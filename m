Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F171C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ8H-0006BI-QA; Fri, 12 Jul 2024 12:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ88-0005t3-Iz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:28:21 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ87-00022O-1R
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:28:20 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52e9f788e7bso2616100e87.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801695; x=1721406495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD8b7Rs4S7P6621jHOvHnCt1DVRmUFEAq/B8zAgtE4Y=;
 b=iuCmszTnUWX9ZPAK7OWbGuoY4+BdR7t9ZTHlQI4K4KTli0ge7Rp/RexXypKa3AFDMB
 68H8z0cfgX5afZa4BwVJGACxzxtVE1Ynco0eyIXGlQhM/z9ToXw2jUjZR3rgVG4ncCZN
 +ITlftvi/wTXF4IPW6WhJN4FWnF0lWbA60ns8VJlfXph+bFvAPJ8L2SjKNfyd4UaMyIG
 Eaj8tWJ/pvDbuAE6nFTkLiPVkhMjdZiE1yfnvDmvVM41e9sY2z1CMXdKDL+VgT2rGvX3
 uSDV+ybGzMrczrp0rEFMjVZ9JPsjej4/gEvjrG9EsK2KinfI5mp5kT9JvI17wSmaG1dY
 ed8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801695; x=1721406495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD8b7Rs4S7P6621jHOvHnCt1DVRmUFEAq/B8zAgtE4Y=;
 b=M3tMXyy2uG6Kt5GcSi7oyK+7pTjcRQUvvzl98lq2mhszbdani+HjmfPYIBG4xsVk8M
 S7ntZ6/BEjWBASGdwA3v08z84/aihsphohlBokev5uj3GchQn+cVHhXytRP9YxUNZZ85
 k+1XD1FD8WHYn4RyJR4lGuU5JkCljopjh9C9B6RAlH7Y8bzOsCsEPuddwJdAY+gDqO5W
 SEJSa8BtcUHaeBgX1qsOXYOZOpXCC3CP0Q1sQGF4K0enWSdTKUy0aTX3ovVw1jq32LMt
 vWgZbCuVN+mi/i/73JUM/voEw5fRC7QLnbDKj5sr5XtaA5YPObQl9/PxK4hdWQTruOKB
 4LyA==
X-Gm-Message-State: AOJu0YzACWRzwBiRNuMwXcEXQM6Od7zfAjvVeWhbksQZPXyusuwBjZZV
 0CbiwaY6q3iUO58HHDLum9ostWAbYIChnkzO0uydGMAaXRumKcOCR42jiqQiHWxEfCYIZ3rv19M
 c
X-Google-Smtp-Source: AGHT+IGiHP80GQMf8rVhyThEQumGn78Xj/psTv/5C9d5BlQ50hLCsv8NeVlvWmP27xjk5PGuSfhayg==
X-Received: by 2002:a05:6512:3e09:b0:52e:9a4f:204c with SMTP id
 2adb3069b0e04-52eb998e696mr9477913e87.10.1720801695086; 
 Fri, 12 Jul 2024 09:28:15 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f09d1d8sm27750285e9.0.2024.07.12.09.28.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:28:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v49 09/11] hw/sd/sdcard: Add eMMC 'boot-partition-size'
 property
Date: Fri, 12 Jul 2024 18:27:17 +0200
Message-ID: <20240712162719.88165-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Avoid hardcoding 1MiB boot size in EXT_CSD_BOOT_MULT,
expose it as 'boot-partition-size' QOM property.

By default, do not use any size. The board is responsible
to set the boot partition size property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2246213b31..d49b144214 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -135,6 +135,7 @@ struct SDState {
     /* Static properties */
 
     uint8_t spec_version;
+    uint64_t boot_part_size;
     BlockBackend *blk;
 
     const SDProto *proto;
@@ -492,7 +493,8 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t size)
     /* Properties segment (RO) */
     sd->ext_csd[EXT_CSD_S_CMD_SET] = 0b1; /* supported command sets */
     sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x0; /* Boot information */
-    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+                                     /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = sd->boot_part_size / (128 * KiB);
     sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x1; /* Access size */
     sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x01; /* HC Erase unit size */
     sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
@@ -2704,6 +2706,7 @@ static Property sd_properties[] = {
 };
 
 static Property emmc_properties[] = {
+    DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0


