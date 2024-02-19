Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1CCC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5Q-0007PA-Ew; Mon, 19 Feb 2024 03:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz51-0006Fg-O6; Mon, 19 Feb 2024 03:32:52 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz50-0002gt-1B; Mon, 19 Feb 2024 03:32:51 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dba177c596so20075525ad.0; 
 Mon, 19 Feb 2024 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331567; x=1708936367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MgGrqvKSu+YKIpZl9V799cCN3k/dXGAwCukmkEClIQ=;
 b=JhCqnDhyqk5fcnmdp03tyMdLXxJXwW2DBETjnjXUWfAAzs1iiL4lgoSR/EWCyCVnM7
 RbHs//2p0jxc2WjmGInPtAS2CNrOtvCkuNihEU84vrTmCM2qLNoPFNcPSnTHRWj0B7Zs
 T8BRnMdH8H9ZUY696qVPxkLZukPqRt7+OvbXb0Cjtp7JZSUq/96WOx6LQ1JtNDNsJ/w3
 myayGxqnVOXpnInNhqEg9TrB2I509su7+H0gwloFjbTITQVuVQ8Bgnm0FV1x9zNQAjX3
 ONbDxUv7dj22PPalk4kBQPSofwBEeTEs3lpUewedfWw2xx5+mLupW2oK2VPE3Vh4YsZH
 Cyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331567; x=1708936367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MgGrqvKSu+YKIpZl9V799cCN3k/dXGAwCukmkEClIQ=;
 b=n02h+2JbMyajTvteLquRZFGuPG1XtxRNxKNBg/NMb96gg/Oyi4CswAwpmmeVo47E4S
 TCdX9nyfKxpGnQjVU1mV34Lyop3mYwwXzIcWg989ZJJeTmUeF63sS9rRDvm/HKRQ/dJ1
 G4oijtgUwRdeuTn+NspGlQF+/SU/VZHVKZJdd0ZZLS6qA6sjs5d4zFuMSWpNE/zuBYT1
 yuG1GTLN1VUPsQ6uJFNqHr+S2bp1r0t11qjDrqftO5wRBLFy8Z1ZR2q9xx1qdzYGVxjy
 5SPnu9jIIJYCsMrKEWTTP1QuH+AebesbcScDZhNLj/LLy44pMf+Jzu3aecQe7ZXtNQDp
 gKUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpoNU0qt3NVclJuXv1XUb60dD1uHKOZee1Bpbysz1dSlsWs/MLdPg8zp6X0b5G2SC12UL/sLnOKCpU0jVM+8e1l0bJ
X-Gm-Message-State: AOJu0YyRBr5SU+kOKmoPTT8iQxmnqPYASyTF8JjeNN6WRYsJrggK5etT
 HpxF9UUbaWfHbVTw+/r625KB0EKUNqNlg6U6bFVGvY2Dmzqb59k+6/ySEeZJ
X-Google-Smtp-Source: AGHT+IG0GPyHonK1l3RmBtTOSq/1wCdRgl+gj6VnjO/bJxiHHB129OUHteVvKB/I27qHECQclUYxaw==
X-Received: by 2002:a17:902:ea0e:b0:1db:f15c:85c0 with SMTP id
 s14-20020a170902ea0e00b001dbf15c85c0mr2912178plg.33.1708331567056; 
 Mon, 19 Feb 2024 00:32:47 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 38/49] target/ppc: Fix move-to timebase SPR access permissions
Date: Mon, 19 Feb 2024 18:29:27 +1000
Message-ID: <20240219082938.238302-39-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The move-to timebase registers TBU and TBL can not be read, and they
can not be written in supervisor mode on hypervisor-capable CPUs.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 94c9a5a5c1..410b39c231 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -468,18 +468,33 @@ void register_generic_sprs(PowerPCCPU *cpu)
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_WR_TBL, "TBL",
-                 &spr_read_tbl, SPR_NOACCESS,
-                 &spr_read_tbl, &spr_write_tbl,
-                 0x00000000);
     spr_register(env, SPR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_WR_TBU, "TBU",
-                 &spr_read_tbu, SPR_NOACCESS,
-                 &spr_read_tbu, &spr_write_tbu,
-                 0x00000000);
+#ifndef CONFIG_USER_ONLY
+    if (env->has_hv_mode) {
+        spr_register_hv(env, SPR_WR_TBL, "TBL",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, &spr_write_tbl,
+                        0x00000000);
+        spr_register_hv(env, SPR_WR_TBU, "TBU",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, &spr_write_tbu,
+                        0x00000000);
+    } else {
+        spr_register(env, SPR_WR_TBL, "TBL",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     SPR_NOACCESS, &spr_write_tbl,
+                     0x00000000);
+        spr_register(env, SPR_WR_TBU, "TBU",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     SPR_NOACCESS, &spr_write_tbu,
+                     0x00000000);
+    }
+#endif
 }
 
 void register_non_embedded_sprs(CPUPPCState *env)
-- 
2.42.0


