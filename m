Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02242C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 09:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tofNF-0001FK-2V; Sun, 02 Mar 2025 04:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tofN9-0001D5-I5
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 04:12:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tofN8-0003K0-28
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 04:12:31 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22349bb8605so67782305ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740906747; x=1741511547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tjc4iz+I/x7TI5oB+jbfsG6hWaQKtW3nc06vJhmSDRc=;
 b=cgKXtxLAGPtWZykUgQigYVA+fbI1iskvdstBp5q3MRz6uuMw3L3Tg1OsFcScUpvfRP
 b/hEXQJfxQ8EH1dIwPjQNUHDhyFjrXa5Ye54SKoEwINqb2Qf3wHTRw8h/RkL7kg/PHFr
 EfimJOdC3uTzAApsmNrPHHarNkBAyIrjhxRD2OwGMbFrtZ/I8l4FECQ0JnbX6u7kkrD1
 mLHG3DdA8VfOfaNZMBBXcUvFPY84y1oHK8FFq4/DhUlOr1baXq2n2dUg4+eBq60jacN3
 bOJoViMkFW6agGC7EoD9/cXfuvIqTbfIOa+qBI0vtQPtd9yPIAchfagoDnroswlFpbvC
 SLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740906747; x=1741511547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjc4iz+I/x7TI5oB+jbfsG6hWaQKtW3nc06vJhmSDRc=;
 b=q4Ye5iKVlxaPlvQlDWNMklHun5CtjOeWxkwdmFmnNbmGWgOtHUi8Y5MY4RmFJR6Tko
 QqVjZX8Gfc3WgUijmNaAk86lp56KpIN9U/6GQmuxNOkK5ezyv/ugNEgiW83vQooPAxCr
 /75km9+zbGa29lkJoQiz8D4yVoypbWptvyYMOfHPEzaiaJiS5KKygJxrG8flyVEJsgI5
 lMWiHrSsoVQ65p02jZnqJ0iJa5TlP9PKKdekbget4JBtI4zt2HL+FLj24vb8mm3AkNB2
 rTDtqwrrXE3c7OMKVT4NrH/UagzrqmJCZrTxlp9fajnSwtkVKbyomg6gYQl/UP/cBaj8
 18/A==
X-Gm-Message-State: AOJu0YyZZvgok3RLJ/h3Ep6NzdUqKREpGuiNPG15uNK1uEDx0Iis6P0T
 6vQtiLWRzBpqcuX3UtvxW+uWUR10cW7ckbNiPMh0/PTULvL4P86PPvgqgRS/wSdN5MPn9Jhdjj1
 pxTeYa68zNro61d20tT6PTyW9iiUy4fX3azPlr457FpJ09MVKlmcE8J50EJ+4M5orPl4QyfCi/m
 RgzRIaw+5XzFzmdzMPKDxpAyJZ1LJv1o1QaPAFMd4=
X-Gm-Gg: ASbGnctO6ZlR+Wxyy6JSj+hIARdoJRILmY5ydeSmfPlhpcG2GVYile4gw079BwiIye9
 TBuLgngI2h0f2eX9adhFO0y7K468FM3kghayvwE4rAatDIeQZ4pQDiL3f6jVPa8Kujo4YuMlNZp
 ntmfYdpED3qqH9Gb8ryGVVpQBwedpDlXDD+B06VhvBbdQ7UYlMgm7NddYQdZLjWLclBx0tRdM2t
 aJCViS7ZfuHMRpxuNd8XKmA4xWBIGmoKY8SsBXanroyrYIwNkPakEvT5Uy96zTxnAePVPMECGef
 A4cVP76UnKNuDbPBgphySPK55f4yKLVcmf/MiBdV35iUCbW0oT6nXakmFvZ+OB3en36Y4jx9
X-Google-Smtp-Source: AGHT+IEgEAPhg+7yznp98FSyzHyqEh+Zc7k3dE/DfQs8W+cbNG7D5sHOEZnJv59fcGFH7dmD3MCxzA==
X-Received: by 2002:a05:6300:8095:b0:1f3:1eb8:7597 with SMTP id
 adf61e73a8af0-1f31eb88d4amr1172840637.35.1740906747350; 
 Sun, 02 Mar 2025 01:12:27 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736310abc8csm2952616b3a.77.2025.03.02.01.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 01:12:26 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 3/3] hw/riscv/riscv_iommu: Remove the "bus" property
Date: Sun,  2 Mar 2025 17:12:09 +0800
Message-ID: <20250302091209.20063-4-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250302091209.20063-1-jason.chien@sifive.com>
References: <20250302091209.20063-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62b.google.com
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

This property was originally intended to set the bus number for non-root
endpoints. However, since the PCIe bus number is assigned and modified
at runtime, setting this property before software execution is incorrect.
Additionally, the property incorrectly assumes that all endpoints share
the same bus, whereas no such restriction exists.

With the IOMMU now retrieving the latest device IDs from memory attributes,
there is no longer a need to set or update device IDs.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/riscv/riscv-iommu.c | 7 -------
 hw/riscv/riscv-iommu.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b72ce8e6d0..1ca85b95ac 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1197,9 +1197,6 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
 {
     RISCVIOMMUSpace *as;
 
-    /* FIXME: PCIe bus remapping for attached endpoints. */
-    devid |= s->bus << 8;
-
     QLIST_FOREACH(as, &s->spaces, list) {
         if (as->devid == devid) {
             break;
@@ -2261,9 +2258,6 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
         return MEMTX_ACCESS_ERROR;
     }
 
-    /* FIXME: PCIe bus remapping for attached endpoints. */
-    devid |= s->bus << 8;
-
     ctx = riscv_iommu_ctx(s, devid, 0, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
@@ -2498,7 +2492,6 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
 static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
-    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
     DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index a31aa62144..655c0e71a8 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -34,7 +34,6 @@ struct RISCVIOMMUState {
     /*< public >*/
     uint32_t version;     /* Reported interface version number */
     uint32_t pid_bits;    /* process identifier width */
-    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
 
     uint64_t cap;         /* IOMMU supported capabilities */
     uint64_t fctl;        /* IOMMU enabled features */
-- 
2.43.2


