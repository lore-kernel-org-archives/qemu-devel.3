Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58116C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWr-0006VR-5u; Tue, 04 Mar 2025 20:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVi-0004bw-8y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVg-0007Yh-KD
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so66721705e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137919; x=1741742719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JT3mCpufvIuWr8BVM5sYDayVdvf5uoSCrbbGB14l/A8=;
 b=pZaCGHpCED2gvXOOGqzKab5OS8z+/vtjFTiEY/QBWcAn+zECcXovbLu1V7ANK9Y1+A
 ZZQ3sNqU4/aQrqzZm5r3fQS794yo/Wa+v66vbfGN1U1BQo9fmIwf68A9aiHzCJSUXWgf
 Sj3Tj0jsuBepcuMK808aismpA8FNwl3xt58YLh67qW98BjgZlk3+Qabw+Q2Zmw+SnyS/
 1RYCNJdLY1rrUs/gVnA5yvFmaArCy6Lempr8xtBLHLVVVxAv7zO9k8NeV9rstWL5ous2
 axCYKnp0/lh1EXL1RZogQ1/RZEZFkNsE7GtlHA6uFsoot0FcKmwGXlHAWQ3Llt2rjRQH
 8kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137919; x=1741742719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JT3mCpufvIuWr8BVM5sYDayVdvf5uoSCrbbGB14l/A8=;
 b=hnqhiM9U1YnZIjkoKf/D+NRdGEklnzjQPZG2UY+E/vvTpf+Txnzbq9AYoKNr1tyER9
 LzdDzO+iKl1QkHHbWzhFtY6b6eOyjdtfR9bO164ZrQ2ACP7FMzHvd1jx7o+Vbx1lUqXH
 4BWHwXZk1bQbAVJXwu6RQ0Qk0uwvecLftlLtTD+fEwTnpFQibg7JP4o0NCxSaEa3/x6P
 BmHBKcIqV48e58G8D5MG0zMtFRybIgCks2t8day4MMF6lYT3cK8JXs6KZKycYiCzv/MC
 YcA8paRFpPaEOtfSv0ZcqNS576kk1JAjk5mm6n080IcbXWeVCD49epMOhM3Ufl2Lc3m8
 f4RA==
X-Gm-Message-State: AOJu0Yyz7PXESq0gmZ4yLkswQJuMTvaKzpEIQTVLoaOcVEygF4N91U0i
 ZIT4/dN5lcbTDp70PMEfCLxSHGFIGsOXJCpX+CmC/jE3zNhu901F2Ud3xSDdqPquWkr23pW5Jn9
 zP+8=
X-Gm-Gg: ASbGncswmWwK5KsNSQKFh5VC2c23ogAa6cO+dV5TCVSMlHksFtDGsFgV7iXhN1qZRgs
 GSy7dC+7NFhu4IlkVC4jGr/CCqFMR3OLJm4r8pn2q2QC++/ShFCT8sBJH6m9RlcX3pbTsNSuQNx
 B1hz/ivq4YJTxTTG5e1Xc2s2+36wv8jhuRyBmkkMnA7piF7fuhc9CMRA95uo3RbJ9eOKbaF+9rn
 lHCyAZ49XwZc03KHYCntx7ksr/ebc4DiXpl3wdg80aiL34oQkCa11BjfDGhOzKz9Gx7t9ARW35Q
 TWd6CKVQiuzWnAe9Vk/SV5fkyCZmwawnEywsjKemawSsB/SkCd5en7P42mwswMsmASShWeAS/5Q
 I9UTuN2o6a1LxweJqiac=
X-Google-Smtp-Source: AGHT+IEbSpdl7IDdjNfclOU3aa8iGxhBPbwTaibTF4bgxSFgtVp3aMl5+aMrUYQhClS+Y4Mg+tLHUA==
X-Received: by 2002:a05:600c:35ca:b0:43b:ce86:b31a with SMTP id
 5b1f17b1804b1-43bd29bd205mr5545765e9.22.1741137918695; 
 Tue, 04 Mar 2025 17:25:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd429375fsm2018015e9.10.2025.03.04.17.25.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:25:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/41] hw/nvram/eeprom_at24c: Reorganise init to avoid
 overwriting values
Date: Wed,  5 Mar 2025 02:21:56 +0100
Message-ID: <20250305012157.96463-42-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The init_rom[] can write values to the beginning of the memory but
these are overwritten by values from a backing file that covers the
whole memory.

init_rom[] is used only if there's no backing file (provides default
content) but should not overwrite backing file content (especially
leaving the file unchanged and only change it in memory).
Do the init_rom[] handling only if it would not be overwritten.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/eeprom_at24c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 78c81bea77f..ff7a21eee7f 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -191,10 +191,6 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
 
     ee->mem = g_malloc0(ee->rsize);
 
-    if (ee->init_rom) {
-        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
-    }
-
     if (ee->blk) {
         int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
 
@@ -204,6 +200,8 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
             return;
         }
         DPRINTK("Reset read backing file\n");
+    } else if (ee->init_rom) {
+        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
     }
 
     /*
-- 
2.47.1


