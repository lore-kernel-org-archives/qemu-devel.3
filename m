Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23419C3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLX-0007ct-2U; Sun, 04 May 2025 17:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLU-0007Xo-NB
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLT-0005D9-7U
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so35080705ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395877; x=1747000677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T30H+Xqi+D11ghfM6nKfQX3kyu+3U71s0mbiqhW/0/s=;
 b=Pdql+r8rx25wcbdLqYhCuGSz5nCZ5G8dLSku0WrvlGhXkJ/BttljvjXgoxNtRYqQUK
 4C8aVqjomPJoDcA6MOAx4DQLIT2o+AxAu6NH98neUaiOaeRZv2ugd3/L7vrioKeSrKI/
 RPL66q+R/xaM5NPcwNHLcmpap5+TGCHr1xcBCsKtlJxR2UETAk0sWTkiUnSeJrLwI4a0
 6vMDsRllX3R8AXkENmqXG3WpnT2DkW05nS7tVrpRHKExODQcGn2eRErtO/+w+sUBvEes
 nY0zqHqA9r+zExtp18gbcShs7uAhIzxQzQ++NGo7eIgU6ItnpAn+pccU4K7L8xXt3eHU
 z2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395877; x=1747000677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T30H+Xqi+D11ghfM6nKfQX3kyu+3U71s0mbiqhW/0/s=;
 b=RqX5jka92Rl/jQrE3Gkfc4P07GvydSbYI8jHNUjIuoI10QaCRTdFj2FTzHMNcXS8Le
 OPNBrVBLZTHH6mX48+qb2nqaRBz7T5U5xPncg00abU8BzYxtGnKtF+1hzkQIDMZsf/4z
 hGVuPpEjUUH052muAYbqQ3nha65tG/+cz/ET2aDIH1ko2xrn4wM6XKp5ljyWl+k16CcL
 4mIFRF1IatFLIUNJuBQbHpzx/d19+Lf6ieEaMrU5GJHG6DRFWBRHF9xVjbZGS5jxzjHd
 BsFcd1UDxl2g/PLVYgd0yV5KzS7HWD4jWQKdJavCcXlvgPnOwttn2a9vlVNAx1o+Zshe
 LxAw==
X-Gm-Message-State: AOJu0YygmJxw1ocTig8zAgv9nnQoLQOkvvXU+6J9kXrEtacaOBLovkPG
 BMdo1Q39Gx0263ev+xT+nmV16JlTp+PH8nJC+sXBs62X+CDxYOmqwPgoDxU7/pfc3A3lmYam1We
 +08s=
X-Gm-Gg: ASbGncskR0wu6O3/f1YimiURPdnNdsbH/a/XX4WFUnmGfibkM6nxxhMCv2eTDbqdnaQ
 6OTkSbpdh6E5xzdQ+9CUxuiXFJFZAwIAvJSymKhUMet5Y3NpMR4V/aKWxPvp4npp5L3Xjca+2v6
 LtoxVh3AbckP6KTnffn47TCInRV4huSSIf9YqNQzftYF0rBfEx3GgbYBe40T4iPpaawvSv1/6ge
 2nnF+cJtZVaIgwMcd9/CiDUMOxxOfOoAkC3p43q1hn++XV46LxFbrGb0myH186IY03VzCvneOxK
 I9j7X0KlYKIbUY7UXHxiogKYphVGuZgb0uPREXUndES0DVod
X-Google-Smtp-Source: AGHT+IFLOYo2VF9CCIcRfjuhSTmt7XVXCxZ/TEOLp6sfRYPRnAGNb5E/aa3DrqbfoYXE3MAPRWeKPA==
X-Received: by 2002:a17:902:f686:b0:223:635d:3e2a with SMTP id
 d9443c01a7336-22e1e909934mr73071745ad.23.1746395877119; 
 Sun, 04 May 2025 14:57:57 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:56 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/i386/acpi-build: Fix typo in function name
Date: Sun,  4 May 2025 21:56:36 +0000
Message-Id: <20250504215639.54860-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix missing "i" in the name of the function responsible for adding the call to
the PCI notification method (PCNT) in the ACPI table.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/i386/acpi-build.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b5836417a0..f40ad062f9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -589,8 +589,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
     }
 }
 
-static bool build_append_notfication_callback(Aml *parent_scope,
-                                              const PCIBus *bus)
+static bool build_append_notification_callback(Aml *parent_scope,
+                                               const PCIBus *bus)
 {
     Aml *method;
     PCIBus *sec;
@@ -604,7 +604,7 @@ static bool build_append_notfication_callback(Aml *parent_scope,
             continue;
         }
         nr_notifiers = nr_notifiers +
-                       build_append_notfication_callback(br_scope, sec);
+                       build_append_notification_callback(br_scope, sec);
         /*
          * add new child scope to parent
          * and keep track of bus that have PCNT,
@@ -1773,7 +1773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
 
         scope = aml_scope("\\_SB.PCI0");
-        has_pcnt = build_append_notfication_callback(scope, b);
+        has_pcnt = build_append_notification_callback(scope, b);
         if (has_pcnt) {
             aml_append(dsdt, scope);
         }
-- 
2.34.1


