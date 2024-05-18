Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93168C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GoA-0005je-TL; Sat, 18 May 2024 05:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8Go9-0005jC-JO; Sat, 18 May 2024 05:56:53 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8Go7-0001fw-T4; Sat, 18 May 2024 05:56:53 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5b277e17e15so1500750eaf.2; 
 Sat, 18 May 2024 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716026209; x=1716631009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w3G0YjEj/ZtZfTFpVX30ielTug1SDL+ATHyj7RHn8kI=;
 b=KcnURe0Cy5xubhZbCWucdUPiIqjaEuZ1y/0XO9gWZQxQHug3vraxXtPb9XXMQxsE4q
 dVWILX67Oou4Sz+QpklXk5uS5eyRMhv02WecglH28NqEDl7myiAiYpzHDXWysAt4m+e8
 2ttJMrHfvIoi6PL8GspvXcLew99xFDZ3k9vOTGSPopQe2ri/PSlGAzbW5x8u4hcQeyyZ
 arZGE1k0/J/Idber7Ck+P+SvMMLhoai9RHyY8fRtzUJwgpwjNk8K/0LzVDEaDIInWgGN
 /fBG4fMrjVbYqUHVyOrASYfMHoBTg/ktp3leuatijQOXnqxm60kg9d0Xoxe/V/XoSrU4
 DI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716026209; x=1716631009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w3G0YjEj/ZtZfTFpVX30ielTug1SDL+ATHyj7RHn8kI=;
 b=d1O8wYT2ujAqvO7CcPNad+7uSlW4FDK0URElOwojHlmTnRbPgGrsdBT/iy9iI029bt
 tzW8gciOEkXUc4rUEroaf702bbLteWhXBwXf621fe1fxg74dhfqzgpsrEF7YIfy4GJ8b
 ANm0rvid10aCOYyegin8FxcbbiMkXySfetnjOwZKJGViGRgFx7Dg85ZiHyQ6CjSSlFdg
 dS/ugRbdSL/yD7i2DZzMDLuHvw+c0oONjWWbXIRKzTWLmNfgJ4gxxAlsKR697Hv1fVSO
 WcaB+9NRe+ssQu243+NGfzV+4wUyE2lCuPezErp9F0iC3gB+nSEeTYdSD3ToPaVOU5WR
 hfFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkri+NujSri89K4OAybu0qUOM/lH7T4lztEDSg+PpixER2qrORKoVVcBvl2ZoAHGCeQrptbC0WqEzGTPWwHWRhaVd7zN8=
X-Gm-Message-State: AOJu0Yz/ksAFUDFZYgvOKFTIEXmSxGhGWFa7aSbv6wPjP5+5/zQLFvCn
 dMThSX+ixQbUkFTOR+kElfYdGaaPGkU9g/84KEp9TCj7hLnVj9iqJVW/og==
X-Google-Smtp-Source: AGHT+IGP7E9nkE5ttVABD9khmJCw0dQXV+lFeMYcn69duuSssZeelHJP/WAH6HabOjxMy2Cs0no+zQ==
X-Received: by 2002:a05:6870:d0c6:b0:21e:7751:312c with SMTP id
 586e51a60fabf-24172baaa00mr27375525fac.30.1716026208949; 
 Sat, 18 May 2024 02:56:48 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af57c3sm16540901b3a.178.2024.05.18.02.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:56:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH] ppc/spapr: Add ibm,pi-features
Date: Sat, 18 May 2024 19:56:41 +1000
Message-ID: <20240518095641.408598-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc32.google.com
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

The ibm,pi-features property has a bit to say whether or not
msgsndp should be used. Linux checks if it is being run under
KVM and avoids msgsndp anyway, but it would be preferable to
rely on this bit.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 611a9e5184..6891d91e6e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -353,6 +353,31 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
 }
 
+static void spapr_dt_pi_features(SpaprMachineState *spapr,
+                                 PowerPCCPU *cpu,
+                                 void *fdt, int offset)
+{
+    uint8_t pi_features[] = { 1, 0,
+        0x00 };
+
+    if (kvm_enabled() && ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
+                                          0, cpu->compat_pvr)) {
+        /*
+         * POWER9 and later CPUs with KVM run in LPAR-per-thread mode where
+         * all threads are essentially independent CPUs, and msgsndp does not
+         * work (because it is physically-addressed) and therefore is
+         * emulated by KVM, so disable it here to ensure XIVE will be used.
+         * This is both KVM and CPU implementation-specific behaviour so a KVM
+         * cap would be cleanest, but for now this works. If KVM ever permits
+         * native msgsndp execution by guests, a cap could be added at that
+         * time.
+         */
+        pi_features[2] |= 0x08; /* 4: No msgsndp */
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pi-features", pi_features, sizeof(pi_features))));
+}
+
 static hwaddr spapr_node0_size(MachineState *machine)
 {
     if (machine->numa_state->num_nodes) {
@@ -815,6 +840,8 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
 
     spapr_dt_pa_features(spapr, cpu, fdt, offset);
 
+    spapr_dt_pi_features(spapr, cpu, fdt, offset);
+
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
 
-- 
2.43.0


