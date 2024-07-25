Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E74BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jj-0003Z4-HL; Thu, 25 Jul 2024 19:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jf-0002zS-W9; Thu, 25 Jul 2024 19:56:12 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Je-00013W-5V; Thu, 25 Jul 2024 19:56:11 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cf213128a1so263751a91.2; 
 Thu, 25 Jul 2024 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951768; x=1722556568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cKnQiTUyY7bbeUwr0G4Nd18/JU5PiZeN3Im5S/Z8L0=;
 b=U92KktcCLLwFXyvYSO+s4JHBfSE+IlSwXkmFS5V28pOKwWSTPnPymAhOzdDHa0RuLE
 1zxfNme8YyY1AavSUhfIfuv1pXbo0ADJzjB7X920XT/og4yUg3OAe6o3JYUOY1BUJV2g
 YkqECWQPbLp91NbAGxQbYdPbMbEeCXm+kPhxSelRjrLsHdXndRHULncnGJ43hW+LzcC3
 kdcP3EpSAY/CfdqNeLZHmbNjil/gN3llOe2phP9HBnc5jWIT/7yBLfR+5zMBWS3w3uCu
 vl5O8/vv0rs6s6ZtMaiTSk3dV9X+Cv6B1vtKsnZDhxAH0b+amBUnmzz8WRkDXkST8Emr
 JDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951768; x=1722556568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cKnQiTUyY7bbeUwr0G4Nd18/JU5PiZeN3Im5S/Z8L0=;
 b=LoRrrQRuQCEWvF6bd2Sc2Kot9uDOlFoKiHqyEw6irtyi0DwR8T32L/finoRJjcOcef
 M9/4Cl9n8Ik6BABGzVnrOgMwMEyOEnBnLp63D1A8uVihz+Z0Jv2xFSyXyyPLpmF9qLrc
 7kGxxv4L78RcGOHxdsAkRngFIoXTKqclx/jnCRcHTKgh3fHAlaRx+8USeotgLSvEAqgR
 5PTY1/ifkrPr7hsCYk7N6jianmfpj0GLhyXUh9ukCmrhezIgGzCJdf5eNQJV2+Yj6Uxk
 VNyqUuDBJXxNtwnsa/oBiVY6OOB27YQ/hF5Oobngzwb+EooM33JG89gV434iOgRSH//D
 YKSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmy8euxa7LWSWe+zQnCCC7ferOE88NsgW7saR0knPvFB9ZIh2OvKueUqm8I9aHlMvSulRqE39pTpJ3+AdIY3NOudGD
X-Gm-Message-State: AOJu0YzxmfkZU52h9Bgalt1CO5de2r6pC6KU/vvobJYfqewBpi4mi4Vg
 VtGbV56yqSovl5aayf4uIMRCA5chITS/mJxqLJkIJkY0aBgbFsCHY4fyQA==
X-Google-Smtp-Source: AGHT+IF+FKUhmCTwfx2bNGWoy846mbUqvCED+6GL2A67V3GKJhU8E1dAklbXqHfGbC2oXUHHV2L4+A==
X-Received: by 2002:a17:90a:64f:b0:2cd:2f63:a429 with SMTP id
 98e67ed59e1d1-2cf2eb9d1edmr4042653a91.35.1721951768128; 
 Thu, 25 Jul 2024 16:56:08 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/96] ppc/pnv: Implement big-core PVR for Power9/10
Date: Fri, 26 Jul 2024 09:53:02 +1000
Message-ID: <20240725235410.451624-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Power9/10 CPUs have PVR[51] set in small-core mode and clear in big-core
mode. This is used by skiboot firmware.

PVR is not hypervisor-privileged but it is not so important that spapr
to implement this because it's generally masked out of PVR matching code
in kernels, and only used by firmware.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 6dc05534d7..43cfeaa2d4 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -58,6 +58,10 @@ static void pnv_core_cpu_reset(PnvCore *pc, PowerPCCPU *cpu)
     env->nip = 0x10;
     env->msr |= MSR_HVB; /* Hypervisor mode */
     env->spr[SPR_HRMOR] = pc->hrmor;
+    if (pc->big_core) {
+        /* Clear "small core" bit on Power9/10 (this is set in default PVR) */
+        env->spr[SPR_PVR] &= ~PPC_BIT(51);
+    }
     hreg_compute_hflags(env);
     ppc_maybe_interrupt(env);
 
-- 
2.45.2


