Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A1C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 10:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDibv-0006Fu-Jn; Sun, 02 Jun 2024 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sDibt-0006FL-P2; Sun, 02 Jun 2024 06:38:45 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sDibs-0007CO-5w; Sun, 02 Jun 2024 06:38:45 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ba33b08550so238507eaf.2; 
 Sun, 02 Jun 2024 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717324721; x=1717929521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/qTmOIQ5IR5TBp5xj+xfZSzNlH4qqX+SuA9WjRG9iTU=;
 b=WObwj31AO96863YzgEy00mPcgKVUjquQI5PRrKHZwZ57+fsgsCu8d1cclDtAm2sLpn
 IG/LkFOfKkH3I6I9vBuwojKR0maD7knsyW+5tiJYEl1+HOSsunrdvpIIMf/DpMs1UjYT
 TxSrbWaMpiIyvZ8qDQRpPIMquhngHnMXzBLCr1lfdI6TgGvqf2/G7BIh/kLyjp1gzuNj
 CdKVVmUdXVZHQ8DGBbr/sI82d2IX878564qSkj6vOSDdcynrMXLfGcpUVMRskq3JIUse
 3+01dKtt5DZg0nvIDvh4mhTfE8035itBHg4bzuAgciU7tuPQ0imMlr/YRc6HoGFplA85
 pJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717324721; x=1717929521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qTmOIQ5IR5TBp5xj+xfZSzNlH4qqX+SuA9WjRG9iTU=;
 b=k8yxWllX5xVAPkGDRgqQ2GM3B4RLgcD5FGSyQ7L4/qjlM317seOXNpnuzB/8/qXOdl
 5uUKEJq8Tfk4jA9KZgUqcYbThbw2RoaQx0y+eUnnfSD6B32UjYG/9UFTiMd3x2TloRfz
 QxfElFc5jXS9p10GeBaqbWjx8eOGEwjrUjVdvPfgnvP0RLL/cJS/aLZI7UvBvydp3I2D
 fzPQkxERDf/fYr948hytecP3sEL9HbKCc/vqZ38jIJjt7+NIMbZBFruhFnQ6slxHhORf
 7FwGl341HQ3vQdC11XRNGMpDNp8pbSTImmK6JXRqqIYyx14+KuN0aHRI8fUiXpvy7cos
 t5lw==
X-Gm-Message-State: AOJu0Yzp1nqFL43NZvRblo3Qz5zobHMK0Sa0V6rlHQIqMeoKT+QYSTPi
 JcuF+oZtY/GZrdhAkWbZ5hslDkJx1JVJynul7Amj2lnvrsPWJp3bJUrBDRG4
X-Google-Smtp-Source: AGHT+IEbiqQdI8bakaAcEHuL8vhD8kcBW48rft7J7MDpQkBzQyBwdSqwmdVnqqWRk0kb+qhNr8V7aw==
X-Received: by 2002:a05:6358:9814:b0:199:3305:133b with SMTP id
 e5c5f4694b2df-19b490d65d4mr856515655d.31.1717324720908; 
 Sun, 02 Jun 2024 03:38:40 -0700 (PDT)
Received: from wijungle.bbrouter ([183.83.54.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35629c3a1sm3821940a12.56.2024.06.02.03.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 03:38:40 -0700 (PDT)
From: Will Gyda <vilhelmgyda@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 manos.pitsidianakis@linaro.org, Will Gyda <vilhelmgyda@gmail.com>
Subject: [PATCH] i386: removes microvm from default build since microvm
 doesn't support Xen accel.
Date: Sun,  2 Jun 2024 16:08:10 +0530
Message-Id: <20240602103810.21356-1-vilhelmgyda@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

i386: removes microvm from default build since microvm doesn't support Xen accel.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2294

Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>

---
 configs/devices/i386-softmmu/default.mak | 1 -
 hw/i386/Kconfig                          | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 598c6646df..6f4f5ab9eb 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -29,4 +29,3 @@
 CONFIG_ISAPC=y
 CONFIG_I440FX=y
 CONFIG_Q35=y
-CONFIG_MICROVM=y
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6ee052f9a..95bcd922a5 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -108,6 +108,8 @@ config Q35
 
 config MICROVM
     bool
+    default y
+    depends on KVM || WHPX || NVMM || HVF || TCG
     select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
     select APIC
-- 
2.25.1


