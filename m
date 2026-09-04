Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5F7C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMt-0000ju-Mh; Fri, 04 Sep 2026 01:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMr-0000Vh-Um
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:37 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMq-0001T5-54
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:37 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so457939a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499295; x=1789104095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ug8aNtK1D6jZZA/LVlTnVqm+nGgyVqbb7HrSMyteamw=;
 b=bjWiNp6MuigJQ3oLaXBg9FWGUHb5h6JQdIJm6gAQ9Ad8LiXzzIHkZBG7KqQICTfYBO
 RzWxd2rY/g3i9fVeY/0/uzKSezr92FPpBNqfTLr059xCxKBpC2UOxiTnqX0TrA89jfzN
 oqBHHE2qSmMXD0Xwrf+PNvN62QLjY4qTKUa7GUzmyguemBf3chWkTGq72hEfe+JML2Oz
 UX4F55G3hnwVjBfyjAIHGnVQvEl+u7jgLonTNZOlnFqUTysQTy8B8OsezRFfvASYtPvK
 I/dTZKI0Yn6NH1CqgRX4/OoUGzAQuS7p9kNnSGy1RfzVLovAHzYpns41CnCqTPupXdcp
 kIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499295; x=1789104095;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ug8aNtK1D6jZZA/LVlTnVqm+nGgyVqbb7HrSMyteamw=;
 b=gCA5veehTKNrE1dSbSd11mhW50mLFRuJUUhXcXG3BLcaqM+QaBH+Bl01RexkgMj5sb
 0huZUrL7tWVBy1MEbCZRIswXZuHcYN8wSM2pgfG0f+LbKVFPVeXvqfpMEQYEaOqCq+3P
 IldwQcNcQHZvZGNymXzaoVxWOFO0DGgTGuIBOI8qCgjGhuLAcNMzipAAoshqQFfjgiM0
 qklOOk27wGVA23xoSh5f4NfDcS8bygnbPtIWplG4ZFtg7HUGtG8Z8j8CNWEJxAttlSdG
 BlP/jb5ufrrM0zJC0NCJSux+tojEC8iXs7+zfuMPenUlmZTn/+6FqIK3XX9zUFzBS4Zz
 M0+g==
X-Gm-Message-State: AFuF++mlZFn2J1OEjYt+W+HYt1Vs3nFNtzdFpgCRNmTHI4QY7ai7mboJ
 Z7zGjsozuTqFAnABJmoPSMVPXKko0DjI25Amu8lhiNtSrAaYqgpH6ndysH2lPg==
X-Gm-Gg: AYBFou2a6k6ItAXmbCwaWFrLwmfV7eeCsnfgvuC2Xm7BNKbp3X5jvQ74iSf9iLDRc/p
 LZ+0ezBRf4QLrbGpMLbA/6cdykViexwEXByDJdtpXtkcYtJ9IEm2PYOQRmmC1MQ8L8Mgd/Kmv8O
 8F3VJ9YdVDteYRXyErFUq+OSM2l33rP30XpsVsafcmqr830qcqbV1JLy4M6fF5/XYomeRuatsOv
 sScv8X9MvFv2l/IAKrAVDwMrfOUryBWqoAK+R40qDJ4SNHmJ34kA0pcCW9HJWEFhnv8xECC71JQ
 mQjsZ5pCGew6v4EM1rHtkJTTSjYowX76hDvQc0gh6s+oFKIIqR7xxyEuxp1AbMunxrBNUFCXz6r
 XMcMOCHxbOIGEkIJT+xVBFh91wCWHxLkAI0YwcWD/YmORfHAOFlYB8RESPmXGk3dH5Yg2PzLrXn
 L9IAYD18OaXb9T+K/6proyIQEZ1gnTn+q/v5ki3lNaRS6KuzzODODQciylhjoXKB3u64Gedm9Q8
 ddf3EtLkggfqCRyaMY=
X-Received: by 2002:a05:6a21:710c:b0:3cc:b26a:7686 with SMTP id
 adf61e73a8af0-3da39b5c435mr5805145637.6.1788499294624; 
 Thu, 03 Sep 2026 22:21:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 32/47] hw/riscv/aia: Take a MemoryRegion for the created devices
Date: Fri,  4 Sep 2026 15:19:28 +1000
Message-ID: <20260904051943.799041-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Joel Stanley <joel@jms.id.au>

Add a MemoryRegion parameter to riscv_create_aia(), to be passed on to
the IMSIC and APLIC helpers so a SoC can have the controllers mapped
into its own memory container. Both callers pass system_memory, so there
is no change in behaviour.

As the controllers don't yet take a MemoryRegion the parameter is not
yet passed on. Changing riscv_create_aia first avoids churn in the
intermediate commits.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260903055131.257903-2-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h         | 3 ++-
 hw/riscv/aia.c         | 3 ++-
 hw/riscv/tt_atlantis.c | 3 ++-
 hw/riscv/virt.c        | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 3b6d7f9625..5df3292610 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -13,7 +13,8 @@
 
 uint32_t imsic_num_bits(uint32_t count);
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *container,
+                             bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c1a5982856..e11382e512 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -24,7 +24,8 @@ uint32_t imsic_num_bits(uint32_t count)
     return ret;
 }
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *container,
+                             bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index db8a1805d7..e40aacbb6c 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -497,7 +497,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
+    s->irqchip = riscv_create_aia(system_memory,
+                                  true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
                                   TT_IRQCHIP_NUM_SOURCES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a72f1a6e4c..def46c1ec6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -808,8 +808,9 @@ static void virt_machine_init(MachineState *machine)
             s->irqchip[i] = virt_create_plic(s->memmap, i,
                                              base_hartid, hart_count);
         } else {
+            bool msimode = s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
             int imsic_bits = imsic_num_bits(s->aia_guests + 1);
-            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
+            s->irqchip[i] = riscv_create_aia(system_memory, msimode,
                                              s->aia_guests,
                                              IMSIC_HART_SIZE(0),
                                              IMSIC_HART_SIZE(imsic_bits),
-- 
2.55.0


