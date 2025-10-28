Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64445CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeh7-0007Qe-Tk; Tue, 28 Oct 2025 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeh5-0007NM-Co
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:04:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDegw-0000tc-U5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:04:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso27969655e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638668; x=1762243468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khQ4f+JLpb7fh8Bk0A11QSSL3qpoF8Qk2ODQYUaP4ck=;
 b=zkuuk7rZoAjECDh55GKh+1gdt5keehE1DPz4jNyoDUSwW3Bc/k6gkvz26qonP5J53c
 Fhpkv6BdO+nPao7rRphEtnpHXf8gxxkLCq5vXkzp2kZyq7M7s3DCaW0/QA4aqEZ2yYqi
 ksIecl4wwqymzOd+kRpeLpMFYb3fkTCUHQHHzmVkHYYr2J1e7Q72dr0jEDJOaL9+TQZw
 NHRW2CC+yPGrxhpfT9L/ENB6iMVGn2a34AMnHC4bg246zTptAlTEWgkyLkjm8N4b8g3J
 7yPxA/O5U3Qq/lF6QN0W8wslrAXfRvugNbb688AfG+ps8FNA6OWhA9MhG5bps7xPIuyk
 Gi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638668; x=1762243468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khQ4f+JLpb7fh8Bk0A11QSSL3qpoF8Qk2ODQYUaP4ck=;
 b=gxUJTBwNx2ZN4cUydHNxDutNMqoxKNj72qKaxPHuaYru06AMhtjHbktbdC0wIV/C8M
 oVvMBtnZvynUrDSr38iML8jurFX0RyTkRYIA4n7HQbuUAXDOnqsnkU1JJkO1u/PvWUG4
 VxlF3FHB4h8oYpOwSI96aFv6gXAMPtpjP/Adt3b6hM/8FJZJvDNN4NdxHOeKpXv5Tbjy
 PK44KEjHYHbg4ro7RVZehjb+0hbRZ2kG4pP04H3m9dTtRUQUG8/QI957ctVD78k9qQyL
 lb6VVTHMKP31Y0S35lLDfkhV1XaoWCrNF+5UvAKaDRE3j6cjbUmuIzOIzelYm6Euzu50
 BXVg==
X-Gm-Message-State: AOJu0YwzzqwkrTXXylbqtw2uo1N8NQi7uh0ETb2LrL6V2T4mpluBGm+L
 os34NNWH1xq7wQ/IAXugK/VKt91U8fpqUWc/nmCKL6cC+kP6ZLhbIS7WLpeL9CZ700pjxrnhP2C
 X9BVwbhc=
X-Gm-Gg: ASbGncv+F2pt/sstKdr55H75wuncJpu767kr3UfD+WbFUeg5hlmvMzZ5nPmCg1cbwt/
 vEU1IyfOAmpUJGY97SGIgZyIg2zWr2Bt/1nM0NwmjTFmADcY9dCAljrZx4v2td1Dgs/xJgnGcYF
 5Uve7wmfkcoY4VibPcidCgLYSy+prWojmndiIT08+NoCM/9Oh/R7/+LJNopLO5oZsPRShgbrkUk
 6ztkCRQMao0B1z61Heqc70aCOQtzlbEK4wQDTETtNf05gWbdtHGDAiJhVXcZ6LzJrpX2vw7gdrj
 fBiRuHL+KgyC/c5tWjfL2e9Hxhzbamr4iZEqVoWcHiiKCF1XvpqeaknjjvWERVghPNgdm0fk0nT
 NJ6FLRk97FBz70Pj+OZ828fEf3JAskS28aX8JBAFc8DTA571+x06ZM7B0Uiq88cTluLe1+rz1Kd
 DfsxvYqXk8GYOyXEo+4Bn61TuQ7Sce1rAaNZ6IoP6puFUoLQQNgsuZOQ8=
X-Google-Smtp-Source: AGHT+IH1wWc1POY3IlDrRidKTdwgtpTWr8O8xuTBDKg1cdXSQD1kcxB/k214JvO/0FfhxYoR6eTTJQ==
X-Received: by 2002:a05:600c:6303:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-47717e40960mr25113255e9.34.1761638667885; 
 Tue, 28 Oct 2025 01:04:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc596sm184858365e9.15.2025.10.28.01.04.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:04:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/7] hw/timer/hpet: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 09:02:54 +0100
Message-ID: <20251028080258.23309-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
References: <20251028080258.23309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SysBusDevice::mmio[] is kind of internal. Use the proper
sysbus_mmio_get_region() accessor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/hpet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1acba4fa9db..4ed79d72620 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -655,6 +655,7 @@ static void hpet_reset(DeviceState *d)
 {
     HPETState *s = HPET(d);
     SysBusDevice *sbd = SYS_BUS_DEVICE(d);
+    MemoryRegion *mr = sysbus_mmio_get_region(sbd, 0);
     int i;
 
     for (i = 0; i < s->num_timers; i++) {
@@ -677,7 +678,7 @@ static void hpet_reset(DeviceState *d)
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
     hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hpet_fw_cfg.hpet[s->hpet_id].address = mr->addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
-- 
2.51.0


