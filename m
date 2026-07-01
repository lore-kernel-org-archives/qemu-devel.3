Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32F5C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2o-0004Ka-PE; Wed, 01 Jul 2026 06:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2m-0004GB-Ro
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:48 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2l-0004xz-8g
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:48 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-13b2bedcf00so344038c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901186; x=1783505986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OPLTIcUU9H43ibBkQDwiKroha8FlAu3j5bL9zbIaTc=;
 b=Zax8HDLNxFdxGi/HvqMQ4i9Wa0AAzz/sB+FKNimEw3lQYV1C9DeoTqxxktoY51rDnD
 PTY7OpNcVjj2UHAuWO289YZ7nC9ZMRVqJ4tMxr5Wjg6CIaN6eFoIidL6Bs2ui/Jvx88l
 vj64AER6I6zCI2Ia6dA6oEHi466MIWyMd5N2U27H5UmHfD2XIMmbcSgPsV6gahp7baph
 aQIUAERZmc6GbSjy95gTIiskHcaO3IbUehsp9l6Z77ai6x62dPDuE9jfpmLE6GjUgsTF
 mD+E1hSJ1WnnRQRvvabAh/JRYZaXzDp7y+JAAKsVR3P8+5ev6r9lNpTCWWwvrOaBOFRR
 R6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901186; x=1783505986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OPLTIcUU9H43ibBkQDwiKroha8FlAu3j5bL9zbIaTc=;
 b=C93mVwDB2zARB7QTV8VdvxqNZhHlstno07W+F5PIniURKs5e+iuqOnpyvBtTd6WXiz
 dF7t8aMP8D+AYgKAY6KaVSzTskgg9p5Em5WXrPPs1zexPYxNKJw+gFvMzZooehWsTXij
 PneEDcf+I3Ypaob0Ui/1c8CQqTwKBIx5kNx0nmDJlvUzp98dT8DVc42jlVkQU8GPb1Hs
 vUvjpstIPLNX6+Vs5ioL3F9VaKC0ZkKAoFr+KZ/WTn24m8idGaO3kp1ipZEintGQ48da
 /RQU05XcNTYZZpkbQCa8+O9DDIcimrU0d9NSH64ZwrbDrx2zfthrl7HqomVwHir++JWm
 LW9A==
X-Gm-Message-State: AOJu0Yw4Xv5hG3XFMk7ufA/zWNXK32OxR1zfeIYHIuESUx2t1oLA2T5k
 cwKM1SyF+/nzDtTuvwIqB0gHxG/x2bPAq8CGeRBDq7ERxXqvtnw+QT4GZGR/1g==
X-Gm-Gg: AfdE7ck/pwEAdi0tYN3j4GGsmgP7S4kvzCvCQ/suGLDLf+t2y0JqpkoMhDcdxZsSGsg
 BI38neTM1nstla/cwtehJp/qgfmmigKoI+KJZ5OvNrWIK/n2jdmRcWd6RIjl3YH7zsaCxK/JpsX
 IhuiY2KkfmHr5ygjLbMjH9htZmraP+KN1DrLTtbKvC4NL1d53E4no3N+PqaTfCm9md0P6eZ/GFY
 9hAbpGCDip1Sca15oCKd2WVhcvdKF1qccGcdy8SaRu6UTy4ZmqUEARDyUldRhNt+czGpsn3GfcH
 lTMLwt5/kT17iw79aSoXGf67xJ9CUIh8bx+uwhm7kTPg5u+wRDLPjslshtpddRj74j8SvgawVRq
 rtJp1803/4JlEHFWZmJjZRuEJpsn+k2KjPbSfawqfzQLqckPjCETlVAqxck8dU9XjbhQba4eipb
 BcYjBwJV66KzWxQRQwSPE5ZXGl3s5rC+0=
X-Received: by 2002:a05:7022:6883:b0:138:4952:5f8e with SMTP id
 a92af1059eb24-13b36d73253mr1123074c88.3.1782901185764; 
 Wed, 01 Jul 2026 03:19:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/39] hw/riscv/aia: Configure stride for the M-mode IMSIC
Date: Wed,  1 Jul 2026 20:17:44 +1000
Message-ID: <20260701101752.2522962-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1236.google.com
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

riscv_create_aia() currently hard-codes the M-IMSIC at one 4 KiB page
per hart and gives callers no way to widen it.

Add an m_imsic_stride parameter that supplies the per hart byte
stride directly. The virt machine passes IMSIC_HART_SIZE(0)
(= 4 KiB), preserving its existing compact layout.

The parameter only changes how the slots are spaced, with the rest of
each slot reserved. This allows future platforms that have different
layouts to control the stride.

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-6-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h  | 1 +
 hw/riscv/aia.c  | 3 ++-
 hw/riscv/virt.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 5ad0a902be..565f91accc 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -14,6 +14,7 @@
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 82ea9d48ea..ed89160029 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
@@ -47,7 +48,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
+                riscv_imsic_create(addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8f80c0607b..b68067cfdd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1401,6 +1401,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             IMSIC_HART_SIZE(0),
                                              s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
-- 
2.54.0


