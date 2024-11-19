Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9584D6C28D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTj2-0002i0-79; Tue, 19 Nov 2024 14:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTj0-0002h6-JF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:22 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTiy-0007bp-2s
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:21 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so2885807a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043837; x=1732648637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBuLzPP/B8/86QP5/ZU+SYT0fd/LUTlpVZf64COogLU=;
 b=BMivpZjUgHOBgfepECeN1+cDkjDgFFbso8SJPsrPrUPN7m/F+bWEj1j6aNqx7l/T0w
 FBpyLkdiF/xM7Lp1exwz3mhgCXsf/TRXyUJdCZNCahXKAg36zD9u9IRSAfqo5/obsuy9
 xQqkdsfgsvPfeRGcJiDpFDOV1ASMHDpkO/rnK5hc/Nr0ALLHli/Q13v3Ml6YajFDQpQ+
 hjFo8ClBckdcCSSCV+/WHAtQGQXid9kSOVRJMBNTt+IF7gRfu2SQRd4x/VN9AJrDHdD8
 EM6LMHQFOcnYDh8mcbhl7mLR0eanWSQyqQWH6alJVil1NmjCjX3voCXHilZ4Yz6auzQo
 Zyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043837; x=1732648637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBuLzPP/B8/86QP5/ZU+SYT0fd/LUTlpVZf64COogLU=;
 b=YwXxxNCFn6GWapjK8YNs9j8gZwdV29j2V5RGO33sb5n6W1W5hx5R/VyIv8aQCd/9K9
 h/gUQ9eyF0TinGJClmUaMTX8P79CwL5kyiIWlb8waSi/SKWf78Df9OKBezVXEUBb7Rkr
 3BDiiHGXdDaf/2602OIMANds/AwynfAYsDnKWuaDjUBt2yJKhpkIPUbxOWT1zy0AAbK/
 ev9fx0lfDvnt4SWVMivpAZ87QfQc9vICWYvNelph8z21ofRrxr9XNQ/wI6WmpVdkRkQk
 lgSyLIIAzzAdTtLA/KhahSaGNh1+cTJ96MHOwvHdwM0VaF2S1byzJqMz0h9NF+FkIyQ5
 Of2A==
X-Gm-Message-State: AOJu0YwNFhGEecl/cY5ZbdqXETPLk8BnrfMrgPqeOxWyxVjEYxKDoRMC
 TKrfCgWRM/Ivt5k67iWlD8bNBV6QB8qJclm127PPt/hLaRcY2M/80Dqh7pvZbjmOtwu5InmlYXZ
 0
X-Google-Smtp-Source: AGHT+IFcTmWIvLRb22P+yc9zcL2nj2CrEfBQa5Uze2xQ2dTUGxsQYyYFNxDX8nZjD2DS353Un2M6YQ==
X-Received: by 2002:a05:6a20:918f:b0:1d9:11d0:1215 with SMTP id
 adf61e73a8af0-1ddaedcd994mr325067637.13.1732043837441; 
 Tue, 19 Nov 2024 11:17:17 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 2/8] hw/riscv/virt.c: reduce virt_use_kvm_aia()
 usage
Date: Tue, 19 Nov 2024 16:17:00 -0300
Message-ID: <20241119191706.718860-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x530.google.com
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

In create_fdt_sockets() we have the following pattern:

    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do stuff ...)
    } else {
        (... do other stuff ...)
    }
    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do more stuff ...)
    } else {
        (... do more other stuff)
    }

Do everything in a single if/else clause to reduce the usage of
virt_use_kvm_aia() helper and to make the code a bit less repetitive.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 45a8c4f819..e200fc561a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -781,6 +781,10 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
                                 ms->smp.cpus);
+
+        *irq_mmio_phandle = xplic_phandles[0];
+        *irq_virtio_phandle = xplic_phandles[0];
+        *irq_pcie_phandle = xplic_phandles[0];
     } else {
         phandle_pos = ms->smp.cpus;
         for (socket = (socket_count - 1); socket >= 0; socket--) {
@@ -798,13 +802,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                         s->soc[socket].num_harts);
             }
         }
-    }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
-        *irq_mmio_phandle = xplic_phandles[0];
-        *irq_virtio_phandle = xplic_phandles[0];
-        *irq_pcie_phandle = xplic_phandles[0];
-    } else {
         for (socket = 0; socket < socket_count; socket++) {
             if (socket == 0) {
                 *irq_mmio_phandle = xplic_phandles[socket];
-- 
2.47.0


