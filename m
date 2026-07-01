Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D40AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1e-0000HX-Sw; Wed, 01 Jul 2026 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1d-0000Fn-1T
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:37 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1b-0004Wr-5y
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:36 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-13b2b08a553so392932c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901114; x=1783505914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyEhFhQ2JjFty1k3RamKBZON4GAUV76VNepVYjWE+oo=;
 b=VzOgq2eFjsUBJfHgbnOPaRvUn7G3u4fZL3GdhjQqm7W3CHUcbrsrO8xRFJ+wno8oEw
 f6lv2PsjloAhtAXV9G4pxmcUOCqDhJtc6FIe1yLEWmlq3WkyaVkkHc0XqPAiCcEXVZ87
 QD0nqtx15HM7ArRz/FGgS8jcQpaDm5smlUv9lG4f7sNZxkuigfYPFZ5+NfMxBydfJ46k
 oCZraGPzUzhQia37WKT2F7k7dJI8+pBL5tgDUmYEGomwtzd0W0sQY19ciQwds4fVe+Qp
 uQHPFlcgFWD/C3PYY/DLJWt74iE+i0VCbopbMUo/slCLwj1ScKoTjIAxErSaSCeoOOI5
 8+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901114; x=1783505914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EyEhFhQ2JjFty1k3RamKBZON4GAUV76VNepVYjWE+oo=;
 b=Q5vWDDxQsPrpRCiet/nbkyS/yuazKadmul61UC+3gazCDa7NrA+Fp3vRDNEyWpVayz
 ThmAhCtEgS4Y/XdEZIBluYgKHzhZZhWkMx3nj8NKBfq7wtd/Bm94mI++rHO4vCgFQbJd
 x+/GuN91ByGMntHOv0mROZtsOSPoQiDc8mLg8eiamZ4nxiIgj/FJRUbvcreixzgWo4rn
 ZIS8xRsPP0iGaJNxnhlpzUx4WD5xXYn8xoc0jxUJky+wKN3PUciJYo922oa4Zv038shg
 1CCQ7E8SKHG4Q17EjHk9fnPhqXduTZfSgVE7UmluMpI8I5eZoj3QsVkvR+9x5qXOqofb
 Eceg==
X-Gm-Message-State: AOJu0YzNjGf7RN7I2Rrk3+s6V3gI6n3b8HsibO17gHd6uRGgV11d+4nc
 9YhSk9YGJ+Pf+IJGjv6vv8hMklpAlqxmTYULlCk+NYj6ryz3zsyQ1J/8ieifBw==
X-Gm-Gg: AfdE7cnuJkgrVatJZ5+nzi+3L4+oSidDKuSbhEQV/pOysQfpubfwaHfMz9KlNsqn2Wt
 lREGg5H2M0GCAINfuAg9AlTITt7OacMiwlyR7f9Xrz2Q/x8taBX+tIY8lrn2vaR+plthMzMGF1t
 n4pdoJ+CqNDN+8STmeccJB+Dz8wo8tEcw89W51aGL7P66P6vCYL36kRgBwFm+PFSQmn5K7teqR2
 fAMJ3im7dW5bSC+AX+DiGvmWKmAUoukJs9UhASoYsuPXHCdT1hoeADtZhHduKdm5grE5dLgBkcY
 IPCpBobnsW/Z737f70WbFUn+CiFVp8Qtdww4eDDSAXfg2C9VLgUCXeZ2tcWx4cUlUYcW2TqY4Fa
 EWuM0TnC4UFca5tdPyip2m9FSkMXD77/3aciBk6Jl5yfCJzAzq7/xTaR0kmQkftIvuGcbkboSvI
 dSz/BCp6VjAuetdOtgSocEK9STBqm0V7U=
X-Received: by 2002:a05:7022:6988:b0:139:c7fb:ab66 with SMTP id
 a92af1059eb24-13b36d6112amr1021495c88.10.1782901113737; 
 Wed, 01 Jul 2026 03:18:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Qingwei Hu <qingwei.hu@bytedance.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Sunil V L <sunilvl@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/39] hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for
 KVM
Date: Wed,  1 Jul 2026 20:17:21 +1000
Message-ID: <20260701101752.2522962-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1232.google.com
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

From: Qingwei Hu <qingwei.hu@bytedance.com>

Each RISC-V MADT RINTC entry contains an External Interrupt Controller
ID field. On the virt machine without AIA, this field identifies the
S-mode PLIC context associated with the hart.

TCG virt has both M-mode and S-mode PLIC contexts, so the S-mode context
ID is odd and 2 * local_cpu_id + 1 is correct. KVM virt exposes only
S-mode PLIC contexts, and those contexts are numbered contiguously from
0. Reporting the TCG context ID for KVM makes the guest enable a
different PLIC context from the one used by QEMU.

With ACPI enabled, this can leave PCI INTx interrupts pending in QEMU
while the guest-programmed PLIC context remains disabled. A virtio-blk
root disk can then stall during boot because its first interrupt is never
delivered.

Use local_cpu_id for KVM and keep the existing odd S-mode context ID for
TCG.

Fixes: d641da6ed43 ("hw/riscv/virt-acpi-build.c: Add PLIC in MADT")
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Message-ID: <20260604120017.398890-1-qingwei.hu@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 413d47d70e..6b06d9aa87 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -100,6 +100,8 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
         build_append_int_noprefix(entry,
                                   ACPI_BUILD_INTC_ID(
                                       arch_ids->cpus[uid].props.node_id,
+                                      kvm_enabled() ?
+                                      local_cpu_id :
                                       2 * local_cpu_id + 1),
                                   4);
     } else {
-- 
2.54.0


