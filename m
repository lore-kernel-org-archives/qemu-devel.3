Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF5FC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmL3-0006VA-Pv; Tue, 30 Jan 2024 06:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmKu-0006Kz-CB
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:31:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmKk-0005Pb-H4
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:31:26 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fafc8bd6dso1075245e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614275; x=1707219075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KrXeN10E4XsxZLxA1TMdRw66dElQqMYKHUX/+flIDU=;
 b=SyIzsRTo27b2e6YMBOKQvA18NXcVg31QgoamvJ6NpLVkxYtUkEpMi1lk13IEQNX61e
 7hykys5Eg2b93i2L1+eQ5jjry/Ttb56LBJ7MEvhk2PUZrZcTSVR0S7Y74CFcTkoQTRLl
 fkZUKoqrAYJ3e/OwCW+Q/oANwnRde+jZkfljS6XwlbxnLPWZUcg0VnuPdF7Z/LTsyQK4
 GD6Md1t0reWORWUhvam4oqvGEBO2vcRpIgqPYt8UyH9V95llGvx4nKn72CPVGKMDcesp
 L1BI+oc5ZNUQvFQPiid8y5CsZnIc5OxSZTB+4YV0pxN8S5O0zJQaNOeKRfEf1sL37DUY
 XP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614275; x=1707219075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KrXeN10E4XsxZLxA1TMdRw66dElQqMYKHUX/+flIDU=;
 b=PRlyZpa0DfZWdp9NlUqE8j/+cyG8lp0UoyZ4KBvsu5LUkvAjSDrX9wlLzvBxikt4eQ
 0RhkjYRWz3540MwCq+KglGPsHxuE6lvzIbCCcy/NnMYC6TufiA0dXxhxG6ZB0BiAyYt5
 nQ1fZCxH2w4f9PLMLq3S0OAu6UUdSXLHUoyl36QK/eJVM1o7SNfDlfZ0/l+/xQXp2w0v
 hLDuAdkGzsYeu57khIdXg3YugGNRVJeUi34s+jF+Nw25YGydJ1w/yEHan7E20gzlOVXF
 P/O2Y8qnVh32sws2FGoA7z0msGGDMg3QQNmqbijdQbOucBDOFcT1guucrVLD0bB1KfnA
 n1oA==
X-Gm-Message-State: AOJu0YykE+J93zwA7WNc6ok7msJJ29xrvCzY9Aqytx2sKPZrUFQRzdqY
 XI+rbB2j4CQ4nbtuxEZizYyRtiIUnN+jyGmMQUxDnLXSEzF51agpKfW7I7UqZvvJElBbXSNYwv7
 m
X-Google-Smtp-Source: AGHT+IGSsWciT1l+AcxCNFwMBzQpacXgSAsSVOpBba2f9elq9ajyDYnf4VVk9FS3LM093C6LwKh1DA==
X-Received: by 2002:a05:600c:1c81:b0:40e:622e:7449 with SMTP id
 k1-20020a05600c1c8100b0040e622e7449mr6317366wms.22.1706614275486; 
 Tue, 30 Jan 2024 03:31:15 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c35d200b0040f44b5c847sm1148598wmq.45.2024.01.30.03.31.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 03:31:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/sparc/leon3: Remove duplicated code
Date: Tue, 30 Jan 2024 12:31:02 +0100
Message-ID: <20240130113102.6732-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240130113102.6732-1-philmd@linaro.org>
References: <20240130113102.6732-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since commit b04d989054 ("SPARC: Emulation of Leon3") the
main_cpu_reset() handler sets both pc/npc when the CPU is
reset, after the machine is realized. It is pointless to
set it in leon3_generic_hw_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..1ae9a37583 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -343,8 +343,6 @@ static void leon3_generic_hw_init(MachineState *machine)
 
             bootloader_entry = memory_region_get_ram_ptr(prom);
             write_bootloader(env, bootloader_entry, entry);
-            env->pc = LEON3_PROM_OFFSET;
-            env->npc = LEON3_PROM_OFFSET + 4;
             reset_info->entry = LEON3_PROM_OFFSET;
         }
     }
-- 
2.41.0


