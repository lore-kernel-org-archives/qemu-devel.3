Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4958EC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRudj-00037o-16; Thu, 11 Jul 2024 10:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudh-00030W-8J; Thu, 11 Jul 2024 10:19:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudf-0005Rz-Pu; Thu, 11 Jul 2024 10:19:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70af3d9169bso860182b3a.1; 
 Thu, 11 Jul 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707553; x=1721312353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/0JQNiQg7zbx/VBkr1CcWf+JFBJuc5tZvRHhkhIoiY=;
 b=FM8c7SRBfQVrREweoXnTMOLORhgolGp/Qi1BpomHqmnCN0JDp6GnZ+5bHqlz6jyre8
 eeFDtBHl111MT4ivwQBB4C4c8VjsP/g94BgRlDno8Ux4ysdG+lZd2KknWmh33Eibt/IP
 6qF5Jbv8Y6x5OTfTeUOpQt+HlMYVu7zO/R+0EETpBK+Qa5Bq6yDC41SFP6tNhki+VOwF
 KibDQx3h5Sw4pGxq+v2FjRcwaml674kNYg3IqZxzW706TY04qMM/ord+kfiO24oJfWBE
 pgEzNZOqVUq57AHB0uBnVsBUlpg5kBJktwCLqwTiFxVnyxPFEDxp5MRCvJAXdeeSn6aP
 5gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707553; x=1721312353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/0JQNiQg7zbx/VBkr1CcWf+JFBJuc5tZvRHhkhIoiY=;
 b=Mb5gHIgSlsP7RYbygeaz9TSsq04lKe9/+jdC5tg1wJfm+d68oCpbCc27KE2g+iPYFC
 +fqzpxyU6L6HdC3jCDlPSWP+L1XUahj53Cv39uAK/+GP2dytiXtizXGD0NQ1ZxC4CgjI
 f4L+quxxGYzYhAQ0j4gxYE+2NCXCW2YOJCiMNQje6OrZX/n+JP0FeBAY6+zSz1bXygT6
 I9LPJ63uFriqm1WMxZ6usobX8GALNjkMlBv+wntd2eYB8X67aOf2n5vVj4kTqqYsfOeC
 11f/6N4IHDg5i6U6xdCwtkjMzF9JU48a8jdUl7kMp5ZbLtXY7GfFK0jsLhS/+ovP9k2m
 ebIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUfoiB0ubF48/RUV8DP27veDdpRWWjpMmG2dv4HCw45+z8Xrpn754LE78ARz1j9dj19jlTxITHJXdWTGcAempNC27je9U=
X-Gm-Message-State: AOJu0Yz5mgVCk4zvU79PE3dxHpJu3EQLwDLdYt7Lobcsh7bK/jnajPXP
 eLrch+DOQF0SA+i16jbaFzLwoDDITG4mnrCQWWv34K0fPhNTFNQSqZnoCfRj
X-Google-Smtp-Source: AGHT+IEHK9hFKCMVXA2i3/XqteYTJn1Byq7QkglNbkLE0opkdHddDU6L82lJ+qFWl4tigtF5IZkzlQ==
X-Received: by 2002:a05:6a00:a27:b0:704:2bdd:82fe with SMTP id
 d2e1a72fcca58-70b4356c534mr9166117b3a.15.1720707553286; 
 Thu, 11 Jul 2024 07:19:13 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 03/18] ppc/pnv: Add a pointer from PnvChip to PnvMachineState
Date: Fri, 12 Jul 2024 00:18:35 +1000
Message-ID: <20240711141851.406677-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

This helps avoid qdev_get_machine() calls.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chip.h | 2 ++
 hw/ppc/pnv.c              | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 4eaa7d3999..decfbc0ff7 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -23,6 +23,8 @@ struct PnvChip {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    PnvMachineState *pnv_machine;
+
     uint32_t     chip_id;
     uint64_t     ram_start;
     uint64_t     ram_size;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7878fed43c..3bcf11984c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2202,6 +2202,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
         return;
     }
 
+    chip->pnv_machine = pnv;
     chip->cores = g_new0(PnvCore *, chip->nr_cores);
 
     for (i = 0, core_hwid = 0; (core_hwid < sizeof(chip->cores_mask) * 8)
@@ -2614,7 +2615,7 @@ static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    PnvMachineState *pnv = PNV_MACHINE(n);
     int i;
 
     for (i = 0; i < pnv->num_chips; i++) {
-- 
2.45.1


