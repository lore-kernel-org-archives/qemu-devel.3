Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHXd-0007Ac-R9; Thu, 23 May 2024 19:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXc-00079l-Dy; Thu, 23 May 2024 19:08:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXa-0005dB-B7; Thu, 23 May 2024 19:08:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so313015b3a.0; 
 Thu, 23 May 2024 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505684; x=1717110484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Iiv0WKgx04uztzz7B3EzvVCbuWZVO8Ce/oy/GyixCc=;
 b=RXC3v0+qMygikzZJChYr9e1oqP2ewwmIud1FVGUVJbTKp/Fv2jiFMaaQgSgu/w3Iam
 ilf4zDOizd7pQW8tJiKrUz+9JPDHdJuBleuJh1wv3GZCDtvURnbTtAXu8+JCu6J9RFwJ
 QU5ooHnsLjI5tYA0n9rCnqgzqc5QWGJqcqM84fNWZgR1RZTrgXXXxlyOGqv1m/32ALcD
 fFS9ViqiZorligcjcI0MzKKCvMHxOqwMEP6GEpPYG/QF2eNq6U2avSlG3/PJSDK/lcdw
 0gzeQf+HKxF0RcSd1cicXgy/VAZ9IIuaTjDGuaTayG7dCbz2mgxHGbJKAbGNRSctisKt
 zMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505684; x=1717110484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Iiv0WKgx04uztzz7B3EzvVCbuWZVO8Ce/oy/GyixCc=;
 b=dTQLj14/y4ZlOhFcQEXpSGELUUEIMqKz1o0aTqBhurrC7nMDVWbhQhZ7i9oD6EMMKz
 iHtV3uLeZ9pnFD4uMxRtgtMRqN4xbM4Of9frPffH3Zd9bheCkp5WYVj8DrZma7GMjcyv
 TnnlXb40AMBlnV7xbghF5fDTAh/nViusa8eTO9g5ONQA4hgJYFzaJvc7MBzAY3pbRu1S
 e1BVg5et2xxIv8dI/9WM/TSfjWYaTwQZIuHvnDEWrEDWF0W4q5p6CMDHUHRPgVp71euo
 2sdLA+8aWvSTp0Bny7VrkmSNdsfy1dZBdIT2iq8usrKVhSPvh81aJtBlhtZaRaIXLYaf
 GmwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUN0Hpe5HJIVkfrzjVaWPl4m1oT3f6Revzm/CLWkik6rlAS96sELI0PMuQ5iqeyrNrsCxbNBl0fkKATm0FK9Wr8Cwb
X-Gm-Message-State: AOJu0YyWzBZCHGkelZdkoPwXrOd45Vp5M0f+IXCvS74qcmaV6k6VvIlk
 Co6+K/Jgqtiq5TMVu+hHdNmOIV/2TcinYgxwoY8Y4l77IFNobzVWHw8i8g==
X-Google-Smtp-Source: AGHT+IEaGvlmM/9MQb+fWAYgV4W+mnEP7lbN6+/1haO2rm7QbEla5s5hqORRiraK434H/e7e4YcTCw==
X-Received: by 2002:a05:6a21:4887:b0:1af:f89d:8320 with SMTP id
 adf61e73a8af0-1b212d4bde4mr1308587637.37.1716505683934; 
 Thu, 23 May 2024 16:08:03 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 02/72] ppc/spapr: Add ibm,pi-features
Date: Fri, 24 May 2024 09:06:35 +1000
Message-ID: <20240523230747.45703-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d2d1e310a3..4345764bce 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -353,6 +353,32 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
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
+    _FDT((fdt_setprop(fdt, offset, "ibm,pi-features", pi_features,
+                      sizeof(pi_features))));
+}
+
 static hwaddr spapr_node0_size(MachineState *machine)
 {
     if (machine->numa_state->num_nodes) {
@@ -815,6 +841,8 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
 
     spapr_dt_pa_features(spapr, cpu, fdt, offset);
 
+    spapr_dt_pi_features(spapr, cpu, fdt, offset);
+
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
 
-- 
2.43.0


