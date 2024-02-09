Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB46C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOgO-0002kJ-9N; Fri, 09 Feb 2024 06:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcw-0006aq-IH
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:05 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOct-0000pj-1n
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:01 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e071953676so532922b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476455; x=1708081255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVMEKw/MMi+uCAfBLiZxsoc3y2OkOUnHp6oV3e7W5eU=;
 b=ag2dy/VimWkRMfONJRw2zUX14pM1z/6JyZJZSfErBQaVJlJEmoWlkR1ZIJdj+2+Jsi
 oZ7c8g5gVjKjygh0VY5BCapxj9KDZNFXzWFIXXw4ALSNMcC3EiSBguv7J/0Avjyrdnhj
 ve/F11BIGaem9qOA+j0arf02Y/o4bGrauc9CGb6PmObLKgEP59HN9+s22JCgyLbV5s47
 m2ct9XLDRIlxu/JOFh08yKxdvyJXWL0SRQOOJ+hVUdq0W4wb3elw9pwcF3inbLaBq0XA
 ODfjSI6nSBV87aKS/wq9oG2o2QAjilOMPfGX0L5H8VubCEhGtYtcJD8OoNEga8S9BPw4
 UAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476455; x=1708081255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVMEKw/MMi+uCAfBLiZxsoc3y2OkOUnHp6oV3e7W5eU=;
 b=jq0d37LPQsw4HCZ4w9SUhoKhvTVfIxeXPtznf5gwl6YkdZ0wmtIVLd4v2YnEtQE3h9
 eHXQiGPNlIRXbWDCt3a3UwhF6GYG0bn04B9A8eNZbt5+IACWMAEeSEP/zva0aVRQfoE7
 7niJpme6WiIkQ/BMpcvRTpoUvxoVc/Elk33ngA8hApmLCyidVhzMO1fwOdpkeK37EJdW
 fvno1LSMrxeflPKRIcOKtYqc/b0WKuRS39Dk1NVcR8dSbsun83rtTHZNRGjFvGdGeyUD
 4+O6tDS2WZlVftaCyDefO7hxrCRXlBEgQSIbSJ0VlqBqNVBjBEs2E0EMO5E3p3FMCTx2
 FCGg==
X-Gm-Message-State: AOJu0YzqPBeEpwMNnf+b7YnijsOcgPBPMmMwufqzOFM/7PEd6NHf2xGR
 VN3SteYPUu4gpeYowRALjXl9xFNLMn5K/6GjuAmH8N6FoxSRW4krvIUFrLkGCkUN2g==
X-Google-Smtp-Source: AGHT+IGHiQ/VqAE/cUts/hLTUdmN5vw1zizhVvIe2SvaU/k00e/lkRK1E2VwFL2P1C4WW2CqvnDsJQ==
X-Received: by 2002:a05:6a00:704:b0:6e0:6dbb:38f6 with SMTP id
 4-20020a056a00070400b006e06dbb38f6mr1179184pfl.13.1707476455391; 
 Fri, 09 Feb 2024 03:00:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX0QyyCWu17Thps81JSYYJu00ySp7pNSOmOeU2NAAxvWslG3J3R9oIuEYBbuG1fN43IXvv8IsDdIZMiWgbHFogDS8iw80H0JXwK1Xhk1clmd1EqFrsMZB3ObQ5JVfNa3zBSROI=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/61] hw/riscv/virt.c: use g_autofree in create_fdt_sockets()
Date: Fri,  9 Feb 2024 20:57:58 +1000
Message-ID: <20240209105813.3590056-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Move 'clust_name' inside the loop, and g_autofree, to avoid having to
g_free() manually in each loop iteration.

'intc_phandles' is also g_autofreed to avoid another manual g_free().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122221529.86562-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 373b1dd96b..d0f402e0d5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -721,11 +721,11 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                uint32_t *irq_virtio_phandle,
                                uint32_t *msi_pcie_phandle)
 {
-    char *clust_name;
     int socket, phandle_pos;
     MachineState *ms = MACHINE(s);
     uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
-    uint32_t *intc_phandles, xplic_phandles[MAX_NODES];
+    uint32_t xplic_phandles[MAX_NODES];
+    g_autofree uint32_t *intc_phandles = NULL;
     int socket_count = riscv_socket_count(ms);
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
@@ -739,6 +739,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
     phandle_pos = ms->smp.cpus;
     for (socket = (socket_count - 1); socket >= 0; socket--) {
+        g_autofree char *clust_name = NULL;
         phandle_pos -= s->soc[socket].num_harts;
 
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
@@ -749,8 +750,6 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
         create_fdt_socket_memory(s, memmap, socket);
 
-        g_free(clust_name);
-
         if (tcg_enabled()) {
             if (s->have_aclint) {
                 create_fdt_socket_aclint(s, memmap, socket,
@@ -793,8 +792,6 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         }
     }
 
-    g_free(intc_phandles);
-
     if (kvm_enabled() && virt_use_kvm_aia(s)) {
         *irq_mmio_phandle = xplic_phandles[0];
         *irq_virtio_phandle = xplic_phandles[0];
-- 
2.43.0


