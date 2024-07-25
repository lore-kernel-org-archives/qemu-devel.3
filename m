Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D01AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8K6-0006Kx-02; Thu, 25 Jul 2024 19:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ju-0005ND-50; Thu, 25 Jul 2024 19:56:27 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Js-00017d-8R; Thu, 25 Jul 2024 19:56:25 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so301734a91.0; 
 Thu, 25 Jul 2024 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951781; x=1722556581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4BAed4GN5W2drBonSaP7QJJo+JlLxRQzh1kXuhUdfc=;
 b=l6Pjq+juooI1st01P2dLBOzJ/jaGV+vU3w+kNDV+KLuyOnv0RpZBaoaxmiSfCyirIo
 Mcs4Nvxstbce4u9XApfurhiOKqrWku1oZwFmXAGCy4/Esi+KLwPEt5lWrtyposwpd1F1
 ij46Zj0UUTl5zJv8B6jCP25KaPhMPbiYGe23cWUKKSsMmw1xYxdM56PHobhVJvbIamQ6
 86iEAWPv482K+Nrq372wuCqTZsJRlEWzIw3QHLqN8girW88kWiZLFWFqviNh8jWNDGHh
 Jpir8X50DYaaJ6/3qO2lpBD5lC/ovGNKJ09L1VhBbhLw2HCORK6cjwpFXHC5fJ8be2HU
 AJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951781; x=1722556581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4BAed4GN5W2drBonSaP7QJJo+JlLxRQzh1kXuhUdfc=;
 b=xByQWxogi5wyGiVBp0gUfD/Va9Cu0btYmTEmHCkrAxgh1FQYd444AWWZNW0/nkDUfC
 UmMV6w2v6/Mu6lIunpioPn5NxzWiUEzf0nvgJPisZtyUC/xmCY6ss/CgSeztq6Z+D6vz
 E42OHUNfXQD9fO/ahr+VDsE2+CgFl/Cg9EX8sDBuzMQn3qtc+SU4Hu8cjBLrERIWMirI
 yOWZTGLaw5WJezQhtlmGnl7bg7akjBo8yo5lxl7U6m+1v3oJmWtqwf/Zv3GVYcT6j9S1
 3HF6J/OfGm0aNn6OeediP4Q7w8LavhGG7CAuJIAVvUzadqSMfW9UL+00oMTgoo2Ml/sN
 tsow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXScmBFzDqWwacCfY6rb0Ig3yWDxy7gDzfCnB9PIdkOgloRVWa8U4fupgZglBOU8rKFoPolj6PEfMpLBPnLr15ATWtD
X-Gm-Message-State: AOJu0YwwChNbApyujKrlrhViFnsktX9SqRnuFIaiDR2FOneHRC4mE7Up
 3BLudHakebgXBqQCATU5zP8DZbB3MtXd+Phguw82Pj/+jeyffyToJHtgHw==
X-Google-Smtp-Source: AGHT+IFVJIOyNLFrnwcJmSrHfCaR49CBJFHsfbf4OEzXabsiCXJPNR5z+q8HqsMeWay/tGdu3mgClw==
X-Received: by 2002:a17:90a:b393:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2cf2eb04476mr3637152a91.33.1721951781237; 
 Thu, 25 Jul 2024 16:56:21 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/96] ppc/pnv: Add a CPU nmi and resume function
Date: Fri, 26 Jul 2024 09:53:06 +1000
Message-ID: <20240725235410.451624-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

Power CPUs have an execution control facility that can pause, resume,
and cause NMIs, among other things. Add a function that will nmi a CPU
and resume it if it was paused, in preparation for implementing the
control facility.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c         | 14 +++++++++++++-
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d19516c2d7..084cfb9984 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2751,11 +2751,23 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
          */
         env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
     }
+    if (arg.host_int == 1) {
+        cpu_resume(cs);
+    }
+}
+
+/*
+ * Send a SRESET (NMI) interrupt to the CPU, and resume execution if it was
+ * paused.
+ */
+void pnv_cpu_do_nmi_resume(CPUState *cs)
+{
+    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(1));
 }
 
 static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
 {
-    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c56d152889..b7858d310d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb);
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
 
+void pnv_cpu_do_nmi_resume(CPUState *cs);
+
 /*
  * BMC helpers
  */
-- 
2.45.2


