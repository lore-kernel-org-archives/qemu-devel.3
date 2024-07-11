Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCFAC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueL-00063h-MR; Thu, 11 Jul 2024 10:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueJ-0005q6-1m; Thu, 11 Jul 2024 10:19:55 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueH-0005XJ-Dx; Thu, 11 Jul 2024 10:19:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70b0e9ee7bcso763892b3a.1; 
 Thu, 11 Jul 2024 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707591; x=1721312391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCH6qpWycZzToOnNXgL5CZvi+FOCKYD18A0yufhOzBQ=;
 b=H5ga13oiWb7etQmAi1sWxD31LI9FRLCCQBk5C7gdQnqVLjQXQ/L4+asy0ebTlI/MY6
 UvcIWFKkoyq6kgEEZEES0X5Kpq+e3MyWmMYfADgoolkix5yv/UjUnTFYrc4BT0A2Zid3
 0ILU2cL8R3BIHSeYAV9F2kW2kNBoIcs4JgQsKY7318vIsgkFuW7AwtqKa396iMvaOTlE
 wPWVkc5kipDRv6XZxwufdQm10Cim8g1mrCS2rPfXXGHIuWBiX4I0Ysuod6mgsThRdVw4
 aTFYEDQfeOAXXRVn61HlpFtPEzgJk2OOSUjqNcDSjNNZGerOX/kJe8lCDyIhjicllHc+
 A+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707591; x=1721312391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCH6qpWycZzToOnNXgL5CZvi+FOCKYD18A0yufhOzBQ=;
 b=mVSJp3nuu6/Au4BtrFPQKNElzgBSLP1BZzeFqH3GlX7dVPLyc7ZQS5dtG8ffeb5mBd
 56DbKWtrOtjJZQBcc/azF6gtZmBOJdRIlbskq/xzG2SDvxLoKMnZxUVh+pQj0uPkdcGA
 xDbqXCvXKVyW+rEtAc7OIyJHMmhTSDakJ8yplCClKOBskTPbknvWB9+cR0L++RIqQOK1
 V5AJDOIYBRSDGnPMzFZjesGJmcuG5kMCTcYIRpgy3YRPIX77aUk66tpKgXfpyq8BTtUj
 T8uHlOZVyl13WqzXsA2HTny6L1CvKx3Js+owi7dqB4gIGkoCtLskV8TRSFB954XYco8E
 syHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6DOF3/I8kQjiDptMDaxEUlV+4l01L1AvD3iHKEup18l8eYAMm0hN3S79JNdUA26XFidlW+b/6hw/KNSgvCMLYychVLpE=
X-Gm-Message-State: AOJu0YxElxEncDpkxwqwJiaF/IQl41rqYQZUwRv/+K/5178gmOsC4Mq6
 HG+apgj+0WXOlfF3Q8WkNUYoJU8HC0GEhZfkkmyLLr1/EfogTnrHJ1Se4Pbk
X-Google-Smtp-Source: AGHT+IFcZDiKX7ZkEQm0n56h3PAVTORrpPKRnD6I/PBtT7rrLUfJyGtnDGnZkCUjqldQ7TSgvEa2Jg==
X-Received: by 2002:a05:6a20:4c82:b0:1be:c414:7ae4 with SMTP id
 adf61e73a8af0-1c2984d7a62mr7401014637.60.1720707590816; 
 Thu, 11 Jul 2024 07:19:50 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 13/18] ppc/pnv: Implement big-core PVR for Power9/10
Date: Fri, 12 Jul 2024 00:18:45 +1000
Message-ID: <20240711141851.406677-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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


