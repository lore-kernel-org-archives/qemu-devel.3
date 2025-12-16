Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36181D5E374
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 21:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVcA6-0001RV-L6; Tue, 16 Dec 2025 16:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyril.leclerc@subnoto.com>)
 id 1vVb3Y-0004Kr-Va
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 14:50:02 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cyril.leclerc@subnoto.com>)
 id 1vVb3W-0007MV-29
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 14:50:00 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b79e7112398so992452166b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=subnoto-com.20230601.gappssmtp.com; s=20230601; t=1765914594; x=1766519394;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YtFSQzS8+7Iy+4YrT1DbnI6bk/rrIAZ1H9KtkCUzPUM=;
 b=WJZoQvN3DEADdnygLnjtOqLctfdVSjdTcgjT+l8mNtXYpi6ZdfWDC+btIxsuwhb2yg
 GBppja8fTHhuM01fCy53ux49rwcnMje0V5V/ea/TEC6cAxDdKLyzBnxk0zvs7QttbeEq
 Q1BS7egkjwFDxqulkeqYUVfD7t+kGNk61xzMk1peiofmep/EZLb/DFW5BiBQmmHRxdP7
 eGWh85wHsHA3UpNd2CjlMWYyoBlT2eIm5YbCE0MGlWrcEng9XrWDTfNISch/1wjj8bQf
 XPAOgCB7ZL55nqKcMVKv/w12mliQt0Or22oQBKihNtReJCo01A6ERPbsWRUsCOpxwOka
 2cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765914594; x=1766519394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtFSQzS8+7Iy+4YrT1DbnI6bk/rrIAZ1H9KtkCUzPUM=;
 b=I36AJxHkHnN2xQ2Dx0i4FRvOjO7VsMJjauOHKO1GAJL2Wamt5fOX7+wX3iepZe7T+N
 0mIqYizd62gMWig87VN+ZgIsR9fxppM0jaUrYbgOyVDl38+MpcvG5k64tKxu4iEInpvV
 myVZ9VugJhAMzROewzY5Sw5QW9Jb8hmCSv9WwBSYmFvilDzpuWP66/GhBpEn0rPjZZ3a
 w09kDzE7AmNjFMDwBEpmYT8m1vMJGftKuZqSNhEfDwaSm3q/AQ3j99qBZ3xojYs7grQN
 RcKm1vK4wx6qCzEX3ci9Sb4bvmHbMknk345vHp3RNRs8iyWQD7bFBV7vmrrRJWMJuYI6
 Ff6w==
X-Gm-Message-State: AOJu0YyRaK2J9H8dMvcYO/G7uVKveiTnkkVCKqyr2EuBIM/f0faTvSx4
 IgEboPKT0rVUtOh6CEKsMTJPR0hT0LiL8OFbKGs10W0eOu59YuklMcT9ZHpzna12drsJQnieNfH
 RMEMf
X-Gm-Gg: AY/fxX5nUbNWwf2CL51gzUROlXoQP9NZWys4tMyFY4cihm/ElACHItz7j+afm37RHms
 M8ouJ/cOUB2vCgZ99Ab6jqwQed2Zm2jSSQ/MKFtrE6khRv1vS3bTN04M7RRFV+xuceNstAi13N4
 E5qYqFsjlSCP+PgDkgi+VjWolhNopwM6sjtk4cvr1vtGsgPFeK0hSr/iROQAddj4niIFYc1dSa7
 EZlpTl6lfw+U+2PRRrVy9UcxBuQUpOO3KpqF37SWAtWn10Fzcxofj6YKJ8T7Qx0Anp3weMcPYBo
 NWosX1+1CgsS7ZvtN0OqEmp1gkSzHpelRzShNgLZ888vgKktSm6M8dnr4rjdgeaqbriTZDllBIR
 xGadSXSWLOH6tnQZrRJrKSUg9OegcPvunil1OBiSXJNbg5WP/E0MofeHqVNUIagcdXwJK3ub8c7
 0zkH3lYTqoZxqehDVC4DnPGDwHrJ4whGl8TXmmj/X5EbU1urtCyIfQvUvvKbN4SqzIGbka0/dYE
 1e7IipY+XHibnMgumS88GUf4QVz+UF3NONEeTJLF27zq46NUdC5g32aiXC+RjFzmyOHALiunmBC
 ugeLQw==
X-Google-Smtp-Source: AGHT+IE6as294FLHdBuDb+RV+hYfSc+6vjSeLol4cTEkAMmtVNwCKfyKdZqUDVZ3mdaenuKTiVDUBw==
X-Received: by 2002:a17:907:969e:b0:b71:cec2:d54 with SMTP id
 a640c23a62f3a-b7d23a80cdcmr1448843866b.57.1765914594250; 
 Tue, 16 Dec 2025 11:49:54 -0800 (PST)
Received: from
 coder-e3a4a9b1-8b67-433d-8bfa-83dcda1c6c7d-85f799c49c-trc2n.coder.svc.cluster.local
 (195-154-137-126.rev.poneytelecom.eu. [195.154.137.126])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7cfa5d1e89sm1748574266b.69.2025.12.16.11.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 11:49:54 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cyril Leclerc <cyril.leclerc@subnoto.com>
Subject: [PATCH] hw/i386/microvm: account for SEV c-bit in 64 bit PCI MMIO hole
Date: Tue, 16 Dec 2025 19:49:53 +0000
Message-ID: <20251216194953.1183260-1-cyril.leclerc@subnoto.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=cyril.leclerc@subnoto.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Dec 2025 16:00:37 -0500
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
Reply-to:  Cyril Leclerc <cyril.leclerc@subnoto.com>
From:  Cyril Leclerc via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

microvm places the 64-bit PCI MMIO hole at the top of the physical
address space. With SEV, the c-bit reduces the usable address space,
so the MMIO hole ends up at addresses the guest cannot reach (the
guest always strips the c-bit on MMIO accesses).

Fix by placing the MMIO hole within the sev guest addressable range.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3245

Tested-by: Cyril Leclerc <cyril.leclerc@subnoto.com>
Signed-off-by: Cyril Leclerc <cyril.leclerc@subnoto.com>
---
 hw/i386/microvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 94d22a232a..cb43a399ff 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -36,6 +36,7 @@
 #include "hw/i386/microvm.h"
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
+#include "target/i386/sev.h"
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
@@ -230,7 +231,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie == ON_OFF_AUTO_ON) {
         /* use topmost 25% of the address space available */
-        hwaddr phys_size = (hwaddr)1 << X86_CPU(first_cpu)->phys_bits;
+        int phys_bits = X86_CPU(first_cpu)->phys_bits;
+        if (sev_enabled()) {
+            phys_bits -= sev_get_reduced_phys_bits();
+        }
+        hwaddr phys_size = (hwaddr)1 << phys_bits;
         if (phys_size > 0x1000000ll) {
             mms->gpex.mmio64.size = phys_size / 4;
             mms->gpex.mmio64.base = phys_size - mms->gpex.mmio64.size;
-- 
2.47.3


