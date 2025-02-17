Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A5C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwMH-0007Ae-Md; Mon, 17 Feb 2025 03:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwM9-0006Wt-Pw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:57 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwM7-00018k-Qx
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:57 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220c2a87378so56150345ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780394; x=1740385194; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rsbbdzwUTIdz+SJN+vwMzPlK/Tfp1AKNRLi4ZEU2WTU=;
 b=j4FqqKEe45Rq9c1avZWNz8VTPfwrI59qri3EtrpNniklYcqsV/POPZR/r4Zg72GRvK
 LYFDxyj+3xFlpJjTis5+B8JDKp4agdVev11KH8gV5jjwp3erUR8eoLAE1UFZXTL9TWIM
 6q1zc62WSfdQkpVXcHTkdH4Ewz9NnXFo6hLnnVjyDvynWCFjqmXlbkgk3dscPEAComBG
 Ba00FP8PgKV97SBvhuN2wIPC3Q5h5OYRDcVo9CGCz7aw6jlSxnSyuGGXDhI6kQSidvCS
 wGUHgDM6RyiKTuTG92XsUPCjAagwF9cYkNMGQ3xfu9+fZia333fdzhmFsrs5CArnE5qg
 ywfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780394; x=1740385194;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsbbdzwUTIdz+SJN+vwMzPlK/Tfp1AKNRLi4ZEU2WTU=;
 b=eh4LVCP10aigqtLG2mJrF3YyR4jEw/6Os9Xo6tebxHG4labtFalHH4rrkaUvLsj3uV
 CaDmyp+/cCodfMf7ohKmyuIk9YCdKf/8gHODukOJoJCJRXja4Z9gz3EEz54F3ky/CmdE
 BSAx/1L1G/1KMhKqqbnK7K4gJIcfdKZH901XuH5FGM8WDH3Eja50/3RrJ4kMsD+D50k6
 /0RkeHL/A2DUFe/ZAeVhaGdwtKGUgIf17Nx6v8Eaequx4Y3YuO/cN0SY4ZLDlqPgTu7w
 qW+u51KJ9KT8YYK8yVA1qHcsl4kHwkUH7nM2YH3lb3cY3JDFOM6F1d0N5h695E4dsvNq
 47VA==
X-Gm-Message-State: AOJu0YwNnm1YLoUi9n+DK72AO+ip9XFjgEzAyW/usejXs5XDOuyDufH2
 ZwKSNnJQOh6EHYo3s1XCva4AV0zYhz5EUoRpL2Y6cknHT/i6OANaoVyGdWDBLHTfpObXD4C6Rrp
 bX0a5VsErHdmO8faG9GLSK2Xpw/yGmKMU34eBWPNINbd00984St2+ikAOdbuWC05bkvDyJddjsM
 pt6LbXQ6zjpRx3YLPfb67kbJHqxPzifFJn9lHUm6ji7w==
X-Gm-Gg: ASbGncv7T4GL9HakOeEDDwmWkRhkKpGnvP56Qd57RMjGQ/g0CaRoMBxEysJLscw5F2p
 x3ZKIGf5QcdmvuGzqjN7aDFVxV2SEcAYTIKcDgSwfspQI7QdKnfyi7T+mj9x3eGzz4sNIF6gTAI
 LTUNE0EGifQ/q1QP7JHa0icIXKeTvgO5lfzZ1fZNxOY2j8vQcHTI//6/STdDV4dhUMp6iksFXEJ
 lpKdCbk0tClU+zBUbthn9slDOCvvfGmW0GKdmVhNOGVJQM44fhkT1KO9o63k6VtR8nDD5hCC1Hf
 KfDkusUDdkFtNAFa9yI8HF5m7gA4/K4J/FbNyXg/KuFYNw==
X-Google-Smtp-Source: AGHT+IErxbEeh1400cHRCZvfrsixcv8DALoxrTLqvpdfmv/G8dI4FA/lBB6GEBH9+uV7LqaK/VkNiA==
X-Received: by 2002:a17:902:f612:b0:21f:9c7:2d2e with SMTP id
 d9443c01a7336-221040bdb68mr154732425ad.40.1739780393650; 
 Mon, 17 Feb 2025 00:19:53 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d5e6sm66023445ad.173.2025.02.17.00.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:19:53 -0800 (PST)
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
Subject: [PATCH 4/4] hw/intc/aplic: refine kvm_msicfgaddr
Date: Mon, 17 Feb 2025 16:19:26 +0800
Message-Id: <20250217081927.10613-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081927.10613-1-yongxuan.wang@sifive.com>
References: <20250217081927.10613-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x632.google.com
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


