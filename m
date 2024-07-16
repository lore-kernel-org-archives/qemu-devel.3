Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D96C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2M-00021D-6B; Tue, 16 Jul 2024 12:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1J-0006VV-K0; Tue, 16 Jul 2024 12:27:19 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1F-0006bt-RL; Tue, 16 Jul 2024 12:27:16 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25e134abf00so2810986fac.1; 
 Tue, 16 Jul 2024 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147230; x=1721752030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNZWaeAaQd+FgPrD7L1WMdXukzJbPCdt43L1w3ipbZg=;
 b=mE71lWa1v1qDE/6ErfLgBoIRWJs9b8rb2OMtKuUiO0Xx3TegYRuy6zUPDSoL+zVgL3
 tkL4ROMzKlGPN9Ga+NfLbnP2AyTHAxtkQ+egjBuF7AIFqsZSdwUgISihnpA0sR9JvRbI
 1yn6MAPG1ichwo0WK1P6/qg0GuVY2MZfI5xwETqycvC65gBSJNHdpZvvJcuE6464g/hE
 +hnJlv0QY6tGDt7C1PxuG6aAkD8Y0ARa/gPC9KJt/sD8nsy95G4uTocp0lKgZoFERLoQ
 Nylv430tdWhJP5b18FpxYvcbmhAWiJuEe+Y6AfUKdBYLTQ/qonMc7ysPU0qEU2k3FIbj
 znAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147230; x=1721752030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNZWaeAaQd+FgPrD7L1WMdXukzJbPCdt43L1w3ipbZg=;
 b=wXM0yXuD3V/VJtzZmXEy8qq4F/p0rf76oazzPsBpCzZnw9iQwm5K9/XZTDrHioTDeq
 /pAoxaKlt2o2rp4EDzuj6tfN5orp+ccw7OuuQiQPVVZNRYOJn77v/u8m8gXF7CoM9TIA
 ukv02RheXyM3GSQgbUpVJNjM2awo9Kc0KJolzWAgLbE6B36OzaLAe2pt4CYqIcKPJp4V
 388sS5L+nMIU4OYb+2H9YXRkhRXKmC2P4JDb91bCf2Dcbdp5nbAnIEHjLTAC0OsryMGz
 lOVZjE8XdEt92Ar09/idDbNnK7UWwe4nKhs9ico0TLUYMUHbHh/DRaKROznda5ISQL+M
 1EHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVBCzZ2zSFjmN9piSosrsSZGwj7DOVt2ZcjRDcMP3z9uJTls1ikW0FImLUht7KbXqu9jkbqhvQlsSr3vEuJUnps06P35E=
X-Gm-Message-State: AOJu0Yzu1ef3tH3+iCtVW9atZYMcnYFiuf5smVCvxT+M91clWmR8FolA
 mGboFvNj3CgNAXgf5L0kAH16J0OSIRV8bP4jWa7b39VGjvIdJD7j6KBOZA==
X-Google-Smtp-Source: AGHT+IEyiUUhnKUIXWWM3ddqsHvRndyuL9HtRyw0F+VlNDRYkFMvZgafga3Tg50dngvSzIuvG/1Pwg==
X-Received: by 2002:a05:6870:6489:b0:23d:a1d0:7334 with SMTP id
 586e51a60fabf-260bd5bdb07mr2051825fac.17.1721147230428; 
 Tue, 16 Jul 2024 09:27:10 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 12/19] ppc/pnv: Implement big-core PVR for Power9/10
Date: Wed, 17 Jul 2024 02:26:08 +1000
Message-ID: <20240716162617.32161-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x32.google.com
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
2.45.1


