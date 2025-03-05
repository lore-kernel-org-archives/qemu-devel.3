Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99055C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUC-0001ib-Ew; Tue, 04 Mar 2025 20:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTV-00006O-6U
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:09 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTR-000712-24
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso66891085e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137779; x=1741742579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXmZv1/YGvLlH9tVUnIp5UMqICtZ1kO2g7onsOxZU/A=;
 b=vh7GAW80Tn56xake/45rgWZhDzVR59nUuc8WDY4LwEG5iWOELXMMrbLOxAaQVhZ5g8
 Nm4qoNQ154W8x66KYMVF0aiCBm8B1Tp6yN4Mm9/nPRnNZP3VKV3PB/CZWOnT0bBn7+9F
 QPGQj2ORnuO2L6EBzzkW7Nb8OuT3dS976Cg4hi+zRjPxLlrc7eTJXbJz6L8n5DQ0APap
 MRVrnktOkriQvEhl/c9Qmgx3LdniDTZRDd3ukApOAISCcPm3RL2FyNst+zf2Z6HO+Cb5
 Y3X/OT3GtHzqifyaE77ikK7euL7dNAGx3TUaCvwIgti5dlZvcdoNpAzUS0zcqPoI6rzi
 bFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137779; x=1741742579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXmZv1/YGvLlH9tVUnIp5UMqICtZ1kO2g7onsOxZU/A=;
 b=ajxOdj6sl9qfj/E2gMfSDavoCpadMrg/NyhFUgaxcdcu7qpdiUb+x+OFBL337eLpXp
 hzy/bVjY7+tMkm+xI1sktvEXVCZBVMBF0+l96vEH4yUkNFGSWfCOrWZeavGBQrHu4MMF
 LIt3ae8jGRpbQxGdMt8WkU+jrSJpxCIAsYdPpGRC7nlCvO4aPYPh1kzmLhN51gtA8JEf
 pr9IzRfuD3oymfQe85SbMv4U+DqMRwUQhlCza2aDHnjl8iEMoZQC8D5MDhGwpAkpqdMp
 2DGMDWo5wEKfZsQYvBs4eIjf8ZHhqM57a5ty1bUpdVx17p6SCEvoau0NCHErlzgWeQME
 DOPQ==
X-Gm-Message-State: AOJu0YxPjZWyFA0yH+FJ04Acp9NrNhj/X53jIlkFOsh9ch2dN67VzDDg
 u9s33KOCuRs04YEs1dFyZW2fBCOT8dqCg4oK8xERh4q4s9JNVnMVswMhKX6oheZu/tS7hcqOm5u
 D33I=
X-Gm-Gg: ASbGncszd3vXA+r4tFf+BcZBGL/zoIkQw4dBnK+B0xuTDOu596BilEF2yh2bhCnCLLP
 kT2DwGeRkdXCOrpQBE+YM3x+VIegvBv0aZHzzLHcMPMlvQrrbICIyDyEoC9kXhCUEVK2xjskLDZ
 uCfBTl2s0+oSzRWrkpNv3ApQIYD8IQ/FMnUte6dvKfRWY08nOuvmjVDn9JOhnRFP01hZOUUkUNV
 i79JYqU0mz43p53MKN9LJTGyoHySQ4Nqf+StJl2rx49q+uoIOsZogFdkyMkQWhewgfP2S4z72JK
 UMCxcWORZVf0Cc/9ffwp1xhjgGwjGEE0vy76wHML2JfAT5I454+mYIxHZucNHnZaRVpKyhUJZPM
 ZAV7R6k25W7WkV4V9cHo=
X-Google-Smtp-Source: AGHT+IFmTxVZuW5/nhwBo24C2YB0j3OTrWD+E440mDnEVYHbD3o+A7RJc8vWcP3+D/FPQt0uEhocIw==
X-Received: by 2002:a05:600c:4750:b0:439:9f97:7d5b with SMTP id
 5b1f17b1804b1-43bd29bd98amr6362685e9.23.1741137778967; 
 Tue, 04 Mar 2025 17:22:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47960b6sm19705434f8f.17.2025.03.04.17.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 12/41] hw/arm: Do not expose the virt machine on Xen-only binary
Date: Wed,  5 Mar 2025 02:21:27 +0100
Message-ID: <20250305012157.96463-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
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

Since the Virt machine is useless under Xen, do not even
try to build it there.
A Xen-only binary now only offers the XenPVH machine:

  $ qemu-system-aarch64 -M help
  Supported machines are:
  none                 empty machine
  xenpvh               Xen PVH ARM machine

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20250218162618.46167-3-philmd@linaro.org>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index faa00d1db3b..15200a2d7e7 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -2,6 +2,7 @@ config ARM_VIRT
     bool
     default y
     depends on ARM
+    depends on TCG || KVM || HVF
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_AMD_XGBE
-- 
2.47.1


