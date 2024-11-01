Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A07E674BB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 08:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6n8k-00071b-LB; Fri, 01 Nov 2024 04:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1t6n8i-000719-Kv
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 04:36:16 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1t6n8f-0003lX-PC
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 04:36:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so1373608a91.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730450172; x=1731054972; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=przCaPYxJ9fQC4VZIfRe5OYFhMQ8p8d0s9yPNLObsDs=;
 b=FFWaIdTUIFkzy3QMKQsgog0ljQq5CWf52a/150IV2TZez8j/inR0XZCK6ngFUmmi73
 iz/KYtz2ng1Nt2xcflG9IXYwBZ97R7wYTw+YuokPbsxSwSwgCkIol0I0ZZBMrKR4QdHr
 vguZhOyjuWjdtY8YVB4bIvrAvqT/PJC93ELEQe59XP95xi2kJzNMod5Mt4YxUPkjF5/C
 kRVOpT6HKvoAPP6iJQaNPFQ5TeMF+8jcKgOpe8JIE0FWV2pXhIeQD0UTnAKFEaJE/1Ta
 zQ9A1jLFvyucjifiD4OXEtf8yrrvPeYw8TS5Q75bnp/XTOTsVh7UUi1FbKINaBCgffoF
 vPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730450172; x=1731054972;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=przCaPYxJ9fQC4VZIfRe5OYFhMQ8p8d0s9yPNLObsDs=;
 b=eR49KzhWP+Ib9l2ddRKcprcmP4onmuS1F6MTKpTosZ1k7KyUqQyKE7CFeg8XO4oJMt
 Dado9d4KMlzOS60V1WIsa3WQHfdncUixOsoOXBLtQ6b7M3odNRjxYr3S92N9ooSSckAF
 OL2VGtaAkLq5mhdrlEwYJVCnYdpJQhrSLj/TUJdW0P978xCzBLUQ/qg+tLlhycoNTyfu
 x8xbX/xiV6wpjHZi11XOyOdZ+QajOa2MiQ/Je44NIsCrJlh2R4rvv3ninNnS8d45tObG
 L01ay5l6ClSJENwRC3MJ29BP99u88rMN73c7grfovKh0fTJj9SfZlttxiggzhvf33NgU
 f08w==
X-Gm-Message-State: AOJu0YyVwFeUwwfM0b4UG9XSuzmUTItEph/PyivsRDCcZvCHhzJxJO75
 DyQacv7USLqo6G2vXM0o86SDBeVSt6HWPvooFouV1+6940hBwlNhZu54ZtQlBR0o6ftOTWrXecG
 Jwj93zpJNwVW2URD9iVwaZvug4si/d9GoacsVKb9fGnz8uEjPf17tlMKkHmN6jgeT1c6SnBkryo
 uv0FukNih2qM+yaOOMWGGdwpWpCBoRk0UYYu5lec8WT1lR
X-Google-Smtp-Source: AGHT+IGen5LEFIdk1+nLYaucNa/tBFck8QOee6s8JLjVWjEI9Lw4v07eb0qZrDlws3zYr1HTbI+4XQ==
X-Received: by 2002:a17:90b:20b:b0:2e2:b46f:d92c with SMTP id
 98e67ed59e1d1-2e8f105e9a3mr22750368a91.14.1730450171908; 
 Fri, 01 Nov 2024 01:36:11 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fbfb04asm4558451a91.50.2024.11.01.01.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 01:36:11 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host doesn't
 support it
Date: Fri,  1 Nov 2024 16:36:05 +0800
Message-Id: <20241101083606.5122-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pj1-x1030.google.com
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

Currently QEMU will continue to emulate the AIA MSI devices and enable the
AIA extension for guest OS when the host kernel doesn't support the
in-kernel AIA irqchip. This will cause an illegal instruction exception
when the guest OS uses the IMSIC devices. Add additional checks to ensure
the guest OS only uses the AIA MSI device when the host kernel supports
the in-kernel AIA chip.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/riscv/virt.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 45a8c4f8190d..0d8e047844a6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
-        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
-                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
-                             memmap[VIRT_APLIC_S].base,
-                             memmap[VIRT_IMSIC_S].base,
-                             s->aia_guests);
+    if (kvm_enabled() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
+        if (virt_use_kvm_aia(s)) {
+            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
+                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 VIRT_IRQCHIP_NUM_MSIS,
+                                 memmap[VIRT_APLIC_S].base,
+                                 memmap[VIRT_IMSIC_S].base,
+                                 s->aia_guests);
+        } else {
+            error_report("Host machine doesn't support in-kernel APLIC MSI, "
+                         "please use aia=none or aia=aplic");
+            exit(1);
+        }
     }
 
     if (riscv_is_32bit(&s->soc[0])) {
-- 
2.17.1


