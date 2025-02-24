Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CE7C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOfN-0000v3-78; Sun, 23 Feb 2025 21:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOfI-0000qA-4M
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOfG-0001Ag-G3
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:51 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220c2a87378so64625755ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740365868; x=1740970668; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rsbbdzwUTIdz+SJN+vwMzPlK/Tfp1AKNRLi4ZEU2WTU=;
 b=k7AZMdk7dlI9RI3g+M7s5WTDd1s7KxU6wYN/ofZC/PWptYKyfBnRq/uKvX5qCHeZRF
 cO5L4gb9Zl/ARuIGjZYjji5Qc3+/5TQOsrRU2oRreR1x2pJstNuMwncZ4llkhxT+C2fk
 mBvc/KMinWFccgi8nlixRZH5Tz2ogDa+ZzRDpr5A1CpIPXduFKNdZ7YEdTAmkKKuEpfv
 Vy3GyJhu2HFc1g8tc8f5Fl/jEMKHklq40ZaQZ5B85QMYp352md14/6w5Vs5bkhWDTIib
 514JemNmrckAFicxoZRLZctNRTIljIVS91qmm0uc/BCR+V7lO3Bd+0rekGIiAoEuVKRx
 a49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740365868; x=1740970668;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsbbdzwUTIdz+SJN+vwMzPlK/Tfp1AKNRLi4ZEU2WTU=;
 b=j/9M0BrJ8160QmDIRupqOOlRK/pHN6NuA6PCvjIRWOtP4KNVma0ASGZlj+PqWa6Aqj
 31DxonvxyQvG/Gxth7s2nXtfvuPWGvhsPpI+6Cwj8IzYMG78DQF5+KyyrLjlnjaiftt0
 a0HX7+1gJLVTJwYMBH37dkmxNO4wxidAl9MkXuWgYfLajwOhMflgLMvRco1zBRMdYQH9
 dXbOdhI0M7hqp7yGpSGWI94pyrkWaLz6CBzARu9BspvQpHXqzrRcP90cIAlLKNTLET34
 CZ0uMuEJideJ6stUYS6afl1aTLVVydgfiOeuRfZS0ze4OPfBU6IlpSr7AxSHkouaGYX7
 y0dQ==
X-Gm-Message-State: AOJu0YywV0ctLr+3YIvuxY4vfryQDAEEm21cRlXI6qNRLTK5krv1dO73
 XKsy9MqXbhiLkaq89Xvtv4GrnNqc46uabNGOr5BnQDDZxdYwm8EW5Ay4lydjkOypr0A3SddkZ/w
 Szi4S5rwcZdLVWweUusB70GIAmZaSNMkryM78JFSVibLNRsuJMpbRIujzgyEITRzjBRrb+ShLtN
 IfyoNyI61EedHruML5y8bw1j6RTEPJengSPCFmWJpwzA==
X-Gm-Gg: ASbGncssYLY3ZqGcoOp4t+Rro9k6nIT7tsMz1bmZW2SOMj1pQnktLWKj5PXB59uL8OE
 zb62e1WIBzVK9ax1SgPuqjFJWBEvNjfuJFzCk8fBBmRn+zj0I55Qpf7swcCcM9pbnzAuoAVu4mE
 jqmdBawNr5NKpQZDZqB/VsaQPNAuWIy63WMWYtvn3m+pwpdjrCXprzQS7T3GHfpn0dPFsYTqccS
 2qoWtkCTTjnD3vlF/fc3lyXDSyKlproKfY+ceFpkjNI3HZy8R+m4XrnVG/XeSOMFablx1CHP90P
 0HqiVm/EBDOhb90cq62BIUUWef5MA6JfaE0at6kXvSEQw5CtmpiewyJr
X-Google-Smtp-Source: AGHT+IEJCX5vZgveq7Has+i5og/h67WkggkqDWIC04MnputBAxFU0ihYbpFtgL0l3UTVbqnik8wgaw==
X-Received: by 2002:a17:902:ccc2:b0:220:c113:714e with SMTP id
 d9443c01a7336-221a10ea4fbmr167667815ad.21.1740365868437; 
 Sun, 23 Feb 2025 18:57:48 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490c2sm171660665ad.47.2025.02.23.18.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 18:57:48 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 3/3] hw/intc/aplic: refine kvm_msicfgaddr
Date: Mon, 24 Feb 2025 10:57:20 +0800
Message-Id: <20250224025722.3999-4-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224025722.3999-1-yongxuan.wang@sifive.com>
References: <20250224025722.3999-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x633.google.com
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

Let kvm_msicfgaddr use the same format with mmsicfgaddr and smsicfgaddr.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/intc/riscv_aplic.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index e5714267c096..5964cde7e09e 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -181,8 +181,10 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 {
 #ifdef CONFIG_KVM
     if (riscv_use_emulated_aplic(aplic->msimode)) {
+        addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
-        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32);
+        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
+                                 APLIC_xMSICFGADDRH_VALID_MASK;
     }
 #endif
 }
@@ -403,12 +405,17 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
         }
     }
 
-    if (aplic->mmode) {
-        msicfgaddr = aplic_m->mmsicfgaddr;
-        msicfgaddrH = aplic_m->mmsicfgaddrH;
+    if (aplic->kvm_splitmode) {
+        msicfgaddr = aplic->kvm_msicfgaddr;
+        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     } else {
-        msicfgaddr = aplic_m->smsicfgaddr;
-        msicfgaddrH = aplic_m->smsicfgaddrH;
+        if (aplic->mmode) {
+            msicfgaddr = aplic_m->mmsicfgaddr;
+            msicfgaddrH = aplic_m->mmsicfgaddrH;
+        } else {
+            msicfgaddr = aplic_m->smsicfgaddr;
+            msicfgaddrH = aplic_m->smsicfgaddrH;
+        }
     }
 
     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
@@ -431,11 +438,6 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
     addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
 
-    if (aplic->kvm_splitmode) {
-        addr |= aplic->kvm_msicfgaddr;
-        addr |= ((uint64_t)aplic->kvm_msicfgaddrH << 32);
-    }
-
     address_space_stl_le(&address_space_memory, addr,
                          eiid, MEMTXATTRS_UNSPECIFIED, &result);
     if (result != MEMTX_OK) {
-- 
2.17.1


