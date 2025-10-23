Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD105CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjr-0000u9-D4; Thu, 23 Oct 2025 00:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjp-0000pk-Ex
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjn-0007Mv-PN
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7a2754a7f6aso434303b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192941; x=1761797741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zk8Kix8Kg+2CjYkxMY72LuG/VHJwD8T3oyL5Prb33rA=;
 b=H+m5dJhODNTYn5sX7SPcSC2TNqYQCuP+52Y80+IcRm/caQ8YOrw01AA4TRmisniTS0
 JG9Td1Q4SWlAKe5I8PR6Ckh9GxAYNDstGOFiM1k0dXI1Mo4tYciTnwvyGA/Ii3YBNvBo
 IuypahtFN6c5p+x4KPtAYEMCY4iEt5xyfUtTbWv+tH/7XbMmLhbeqT7Rxpxv0C6evA5l
 VDcrp2iQ+Yk1RSZ5kzFj01Q56lY5cNSYkVfqm15bJS4fD7Awmm/GDYOC6M+eaDl3+STq
 foWpvqcbJRVX1+McI5d3wmYKtEArG1blHAjM6M6cF3/pXXYQsPfbmd37s/5NX1Pk1IBQ
 aVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192941; x=1761797741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zk8Kix8Kg+2CjYkxMY72LuG/VHJwD8T3oyL5Prb33rA=;
 b=Ap3u1p/QCQQh+hBB8vP7TvS4CpqV6MBz5FjdnSDjXitCmIK450W8mVCR2ASHhxnBXh
 sVRPde+UV0sP7Psrahmvqla9T5HYmGuPOg9J88EaEH1h3x3+gcwFuq0I+hyHHMt9szO3
 7b1a+Oz1JOAEJUcCAfi+kWsx0Vj6yHmxzfyfFxYeQYYMtAMxzQWyufQo89nbrDDMnCoM
 bAZ/K8BFvfIGeqZD6WhHXyQRPc91UyVOtzc/c2xqjTmARPzrgGpPouGNdUXinaSlRwIn
 rejD4t4TZ8+mDRVEkTv7ZD7C475HRVd888jpFT1GXU3I6qwHl5QGy5Ak9uLP4tW4JuZZ
 QXYA==
X-Gm-Message-State: AOJu0Yz3rDzWS/bpITBOoN/vJ3tmjjeFIOGTwm78Jb1sv02JA7SEOuQ+
 yzsbp0asHvGJErG+5zeU/7pV7FihbZUA1QapV5yoN9jiP19YQN3LIrcfaaTwzg==
X-Gm-Gg: ASbGncvykcwLuhZxmMn6fDCutPvK5io2tDQPVZVo1CTKpi5m5DlbUHCuToxOrSu99i+
 5uctC7zRGNEgkzGc/V8GfPZXLAf2PqjcK+ovCNVpDp9wn4A64bj+QySWv1+/BB2nSUE2qnkrtCU
 L+YtKuvGEreXcjg5Bj8eySpGK+HHtNZG8bmHBv52RKuT6nyeGpXsTB68bEPGuknpZGsrFJlhJzf
 RCn6bDe6ySoclXoAW4wqXpYF3ryPKT1l81993+Q775Be8xosGLj5lTahiy0s8T1cw766//06WbD
 ljZbG6IDODEyGoo94m0Dnd/633pj0t/0kvMbdDT7nFRm1bgvNREoVVo/a5GbIR71ozcnr4s6ULR
 pdiaCP9s9O7rchWOWtVGZ5E42ZmvscY11qhPQ5QChV8t1tsJyjO46gUcrLWSONBvIhYXW2OAzSL
 YWQlk8gDuOwR2i3ULG8oXtXjR8lv+fWqHuuxtcHHtnxCrjcoLo05NyU/VlLnnYJV7y1f8wCLz1s
 0Vm1kF/WlWX8mKwKaVY
X-Google-Smtp-Source: AGHT+IHnHX2rxYQa45csMgbb5w7SXXTQQkIGjXVcQUyctFpZF4ZVN8yRnxhNm4BwI/6MtlQ89OKLIw==
X-Received: by 2002:a05:6a20:5493:b0:334:84f7:5646 with SMTP id
 adf61e73a8af0-334a8650262mr33732964637.58.1761192940905; 
 Wed, 22 Oct 2025 21:15:40 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/37] hw/net/cadence_gem: Add pcs-enabled property
Date: Thu, 23 Oct 2025 14:14:14 +1000
Message-ID: <20251023041435.1775208-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

The Linux kernel checks the PCS disabled bit in the R_DESCONF register
to determine if SGMII is supported. If the bit is set, SGMII support is
disabled. Since the Microchip Icicle devicetree file configures SGMII
interface mode, enabling the Ethernet interfaces fails when booting
the Linux kernel.

Add pcs-enabled property to to let the driver know if PCS should be
enabled. Set the flag to false by default (indicating that PCS is disabled)
to match the exiting code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251004200049.871646-4-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/net/cadence_gem.h | 1 +
 hw/net/cadence_gem.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 21e7319f53..e63941f18f 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -62,6 +62,7 @@ struct CadenceGEMState {
     uint8_t num_type2_screeners;
     uint32_t revision;
     uint16_t jumbo_max_len;
+    bool pcs_enabled;
 
     /* GEM registers backing store */
     uint32_t regs[CADENCE_GEM_MAXREG];
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 520324adfd..44896f1801 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1477,7 +1477,10 @@ static void gem_reset(DeviceState *d)
     s->regs[R_TXPARTIALSF] = 0x000003ff;
     s->regs[R_RXPARTIALSF] = 0x000003ff;
     s->regs[R_MODID] = s->revision;
-    s->regs[R_DESCONF] = 0x02D00111;
+    s->regs[R_DESCONF] = 0x02D00110;
+    if (!s->pcs_enabled) {
+        s->regs[R_DESCONF] |= 0x00000001;
+    }
     s->regs[R_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[R_DESCONF5] = 0x002f2045;
     s->regs[R_DESCONF6] = R_DESCONF6_DMA_ADDR_64B_MASK;
@@ -1821,6 +1824,8 @@ static const Property gem_properties[] = {
                       num_type2_screeners, 4),
     DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
                        jumbo_max_len, 10240),
+    DEFINE_PROP_BOOL("pcs-enabled", CadenceGEMState,
+                       pcs_enabled, false),
     DEFINE_PROP_BOOL("phy-connected", CadenceGEMState, phy_connected, true),
     DEFINE_PROP_LINK("phy-consumer", CadenceGEMState, phy_consumer,
                      TYPE_CADENCE_GEM, CadenceGEMState *),
-- 
2.51.0


