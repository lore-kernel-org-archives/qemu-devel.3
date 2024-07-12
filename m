Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A01C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0k-0000r1-VD; Fri, 12 Jul 2024 08:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0h-0000Vi-U1; Fri, 12 Jul 2024 08:04:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0g-0005o2-0y; Fri, 12 Jul 2024 08:04:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70af4868d3dso1691254b3a.3; 
 Fri, 12 Jul 2024 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785858; x=1721390658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCH6qpWycZzToOnNXgL5CZvi+FOCKYD18A0yufhOzBQ=;
 b=Ygy1EyCRF4ugpM4/CF/t8sYNpe4ZgmazYs8qs/7raqwMkXL5nh24R6QNjQudmNHMlv
 lsni9cHf4g1KahN+JwZNMfOki+9PUATIFZF2RGioFBfC8V9j0831I9JgVNNYfbXsPXnJ
 XdnNv3xvxJnlvRIsDjEgCGDuUyr0+c4p/+OKCwhldq4CoZSQhv7iBEHfrslgMG926xoJ
 kTcqNnWJJFPpVVKmp6OPWIsxbc1HtUV3RubpGgDexjESftmfO1uy3pGMiMLwSwiIWIOD
 5KiRrS0JiRehqsqlm6UXROUdLD3z6hDri3XZvT+hxUVFUENqMsZoGk0fA+asS+vyUbLy
 JhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785858; x=1721390658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCH6qpWycZzToOnNXgL5CZvi+FOCKYD18A0yufhOzBQ=;
 b=d69HsS1Z6sEv6YU4p9NyOd5eHUWT6Y/T+/IG0RI9wBEp58/pkIhyxBBz4f1JBNi3it
 PD59WdUYvCMw/xGuSp/bR0EM75P7PJZkau5atPHRB4wMbu2tslq2xjAZPqIOJSVgG2K6
 ucOkt1xn4WzBRwUlUsApsOQqzVNdSI8VjFvdDATfT125KdFCoyZMdxskkzZ+eqRK2DT7
 4HGUYT2ALWMFPWX02s0YvcKYGfgLLo2xwlhPsmrhz0EK6RNlYQPSiRF/5vbfXbPZYIHj
 H1DVJ5xWvWvHMa9/MdHLYJxdQcblk8O98IwWHuS60PJb4tBaJSLzL6/BW6XIvZrwo1dU
 HvFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUovjKxmYDuPMbgLqn4Lf6ksUl+5cpYzh4WgarcEv5B6p9czQ50WFbubAgmRHZ9c0gp7dopBArQBVXCkxSDmr9FNpyIgB0=
X-Gm-Message-State: AOJu0YyiuyW7HsM5qg0hktq03hleZtSYWzBqT2TNpV3qqLK4wSlvanfF
 /T1GvNd0ZN2mdSQ9VNW/fQpR07ofdnqv4Kxy/iBvxCOuPVYxw9v9pqklZg==
X-Google-Smtp-Source: AGHT+IFfPvJ8NKj+eaOTKUPH8DlkRFNBl5VDdxjMFX6R9xkWAc8UfDTlsTmkTACIEVUWv7AKaBMJJQ==
X-Received: by 2002:a05:6a20:43a9:b0:1c0:f07d:159e with SMTP id
 adf61e73a8af0-1c29822dd8dmr11848557637.26.1720785853117; 
 Fri, 12 Jul 2024 05:04:13 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 12/19] ppc/pnv: Implement big-core PVR for Power9/10
Date: Fri, 12 Jul 2024 22:02:39 +1000
Message-ID: <20240712120247.477133-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 16d40392db..a96ec4e2b9 100644
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
2.45.1


