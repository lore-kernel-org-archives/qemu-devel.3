Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91592C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwziM-00074p-Fx; Thu, 20 Aug 2026 06:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhq-0006sF-Dh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhn-0008Mo-OK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1312693f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220542; x=1787825342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fbFPcumdwqQtTm/8eCl+Gz40GixriWu5Kdq29TJDuH0=;
 b=hIoHHd8UWxWZuuZYpz2DiW3XEXXPIF6SW45m2LZwic6mUFj/5+VZeiBoxscBXUCmuw
 zZZyglNom57iKieQfxbbgykfXtY1S1jtRp5WWCK0cpPqHEDAe39hoXn7GKKI/fweS84M
 v+YB8U/fTH+lJxZQA5MaxK5NFyV6GjjTzxMdXbv+a5kUM/3Im0tGqsiP04zuc02RQalN
 DViOosDwQWwIhYCDAeFbpEMA/8+VFTdtCdzCyEENDy2sR4hE4u8PI/bM5faxbrAkEezi
 FIiYbYv9D6FhjXSEGJmw8xI9hEX0RegcjpIZ9IpxOqQXLYMIZRt7BnMgMFIzQm4Araa9
 39+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220542; x=1787825342;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbFPcumdwqQtTm/8eCl+Gz40GixriWu5Kdq29TJDuH0=;
 b=GuVmNyCrlPcLONwN7XF8NQvEIvBhshI5QsdHieA/I12QE3ByqbjwAxZgwIPmO88GH5
 V61VPcrz0QHoQSdOuuRBjUHIQAfZ8gGKms59e+fNBtwRsxHvY7zG8ejfMsMIlE6sia5i
 4gHCAjgdfWIMeSJSpd70qx0Bo1bwWs1m8S4LsBqKSPKJGFiJgYF95FuSOtLMAH0GAMMG
 hzpPaREZgAjkWYa4KLiHDU8zLk0UyBViyVSqgNwNFFwunniLv0WXeFI2OYpx++ttPipC
 bklbYwdCrNAxmDjr9iLMZOEBLCWAlakwC4Wc1NKLY0UDWqQVZkU8t1rbjEI/498Qqiy9
 tZZQ==
X-Gm-Message-State: AFuF++nG6BqtfvU3FTlJDfUARXgwJXbLDhnv7UR+2gCHmF5Q+Dn8fN0e
 OOkM+cU3nnWeHIUGQyScyWpQNTYWAs6oTPIpy3teyOdXGiseSR5XJwccVS3HkyPM3Q+Aq5gCIgi
 DYqmj
X-Gm-Gg: AR+sD13sog88fN2EOh6Vcj1daevpq+fGGZyo9QtaSiWjGwTzl0X7BaMU8aWQk6Pyh9z
 cAYjm/HLr54kNzSsOIRsGldc/A9yZSywUAP6cuqQmAmeE3qReUjWiU5Utbo3fGvPPhYnsqV60tu
 gFOXt7J1Wb2Lph11JgYQ6PTIb47FvvWpFDDaW9h7gZrqfydfzh5mKhaJszs+9DkM3eeSEU+PanP
 FGqARpqMlSEqvw8uS5lETMd6qu0SQ2OwSuitCHkwydMCklcRl+IsE8KhsFb4Lu7ijkse7N1RjI2
 E0g/aev2J55eGegGRgc/T0AtQoyIsxRQlQGp8lsVr4MKs3MxczXrLrGx6FeA2se4fiAzuBlfU5G
 +WSvMvmgiq0XjrapbHM+x5WsxfG5lmKFFegycCdSnw1mMvLLCWEYT5RtkLM/gfbVE6WQ9rfRjSp
 0sKqPxbpuZAVNuwzUv91P4GeEQKZ17knq4BGHkw/MNyhfnhBGxLT0MyhdR8A==
X-Received: by 2002:a05:6000:613:b0:47f:f31d:27a4 with SMTP id
 ffacd0b85a97d-482b1fd9bf6mr18659863f8f.13.1787220542266; 
 Thu, 20 Aug 2026 03:09:02 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 08/17] hw/ide: keep the IDENTIFY DEVICE current geometry in
 sync
Date: Thu, 20 Aug 2026 12:08:35 +0200
Message-ID: <20260820100844.411717-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

From: Denis V. Lunev <den@openvz.org>

Bit 0 of IDENTIFY DEVICE word 53 says that words 54 to 58 describe the CHS
translation in effect, and ATA-5 8.16.8 has INITIALIZE DEVICE PARAMETERS
set words 55 and 56 to the heads and sectors per track it was given. The
data is built once and then cached, so those words kept describing
whatever was in effect when a guest first asked for IDENTIFY DEVICE: the
device reported one geometry while addressing the medium with another, and
nothing reported an error. The revert SET FEATURES 0xCC asks for on the
next reset left the same disagreement.

Do not drop the cached data on a change, as parts of it are guest state
rather than a description of the drive: SET FEATURES records the write
cache setting in word 85, which ide_drive_post_load() reads back after
migration. Refresh the affected words in place instead, the way
ide_identify_size() does for the capacity words.

An ATAPI device has no translation but does take SET FEATURES 0xCC, so
leave its IDENTIFY PACKET DEVICE data alone, where those words differ.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index e5fd570575..048655b2d0 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1360,6 +1360,10 @@ static void ide_reset(IDEState *s)
         s->reset_reverts = false;
         s->heads         = s->drive_heads;
         s->sectors       = s->drive_sectors;
+        /* An ATAPI device takes SET FEATURES 0xCC but has no translation */
+        if (s->identify_set && s->drive_kind != IDE_CD) {
+            ide_identify_chs(s);
+        }
     }
     if (s->drive_kind == IDE_CFATA)
         s->mult_sectors = 0;
@@ -1668,6 +1672,9 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
 
     s->heads = (s->select & (ATA_DEV_HS)) + 1;
     s->sectors = s->nsector;
+    if (s->identify_set) {
+        ide_identify_chs(s);
+    }
     ide_bus_set_irq(s->bus);
 
     return true;
-- 
2.53.0


