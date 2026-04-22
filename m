Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06268FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjb-0005c6-MO; Wed, 22 Apr 2026 15:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjB-0005Kr-5o
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdj9-0000bI-87
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:16 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so2973657f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887953; x=1777492753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g4D8o7zdlm9JQU0fFzodGu9CF1Y0aNr6rJlMGYxDFYs=;
 b=YnHgRFD1GGKU8pKE4TZUDCwJkfGwwUk1aoYPinZ1CpM4VhOCkwirB1mkTltIxOE6Nr
 2bQlYLXLC6Ruo4ELJIpBnh5ocjLMM0y30SwqQseZFZ29JHnVvNaQg6FbaUVoc+qEHpMa
 aeKi81PU6fIP3/TlBheJ1vLTyJ40UEtJU6x0IzuWYi5OSw5Wm0MIDRi81SNrVz5hK7P1
 Sic8PymoDKE0ik1hKJ0hVx5ZNbpsW+MWVQ2hPfHzOzDjwmEIhQ2ukoOVI/KbDHlEiBX2
 U/mxF4N8sOKrJWQvnaRThQc9PQH3qiiq9xvCVyPKoITGmzJYdVB+Az1ltAAul6wM/dpi
 8uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887953; x=1777492753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g4D8o7zdlm9JQU0fFzodGu9CF1Y0aNr6rJlMGYxDFYs=;
 b=jrpZ7gyJCrTpJKVYerzetLZyKC477uIKTHCR3RRMg+nHNEFPqsT3myEgG1psAuFyAY
 5v+ZVbn8PqirO17rN9P2T+Qv7ZCgtjjhwQpUw27fWyNCfRI0l61Y76SHAGrdIV7k9I5P
 cqoVgV1M4Wl0RgrutAjpjiKmHvrje+/mc48/Mo3TtrmHQZu7P7qXZcn9xajE4wajqEvV
 kFwvN+F64MZkA8werXbaX64XJuf6tUEc6Dq3KOCLWJWJQ4GCtG1H6m1Jz7SGbMYPHU2k
 xntDoynx6TCEns6gS2bkzym0tjOa59Mt4HM/Y0p6n8Qhb6DMeEzhsYyS/nnJ0T78oYFE
 VhTA==
X-Gm-Message-State: AOJu0Ywk+uMvBemiZJa6Bk4aBm1izgGmRd55axWwU2jzZidKmrp/Su+v
 644kzDjGbojkvXBRN2gsTDrn7+HjPzNcblszp+VUY6FVpx3ryQ9nezZNFeKKfYXZGZmZzgZu60w
 p+61QvQA=
X-Gm-Gg: AeBDieul+kZdjaZjre3A4PsjIRlvwM7o5XD7Cxfd4235Ttyj5PE8crskRh9pbDLG2V7
 x19B2VgpyihbgwUmjRMqTBCJKPUSs5V/y6K30B/U8gf3OxzoiBQpILzHGZR95RptiOqwQZjKcEe
 XQJNsS1zKYlyUaKDuW9aO1Ly/TRAT5vCHOi2v2zcQubsuZT8J2B5mKa4D35P6op1uX29kBvqRyN
 f+ejUKWV6RIfAhTARFPsnmR0YU4S/AFjbk0O74ieF+foWDHXEQpKQo+GWcYbnitVnyCdwMJ6UxT
 5YdnrLjqj3E6oFyUv1axCnD7nkoXmafLRSdnqj2nc+ussywFtwKGsrQs9wPklJkoPZ6vs5atoJV
 kBTgp3MoVLPN+ZgbgagfrliAz4n4WrG6yp0H+kiS37v2LD5g21e4CK1MZce036i7nSUs2rjMVIS
 ve5+vB09QRa6BdcGsQH1sJutw51WVv2WHOhiMGKJcKkeTblr6kazbel81i/C3Mt1GqYchosYAkR
 8sx0t5B5x4=
X-Received: by 2002:a5d:46ce:0:b0:43f:dd40:bbc8 with SMTP id
 ffacd0b85a97d-43fe3dfbd25mr26173719f8f.24.1776887952736; 
 Wed, 22 Apr 2026 12:59:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm43249051f8f.32.2026.04.22.12.59.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/48] hw/ppc: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:10 +0200
Message-ID: <20260422195746.88865-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-30-philmd@linaro.org>
---
 include/hw/ppc/pnv.h          | 2 +-
 include/hw/ppc/spapr_fadump.h | 2 +-
 hw/ppc/mpc8544_guts.c         | 2 +-
 hw/ppc/mpc8544ds.c            | 2 +-
 hw/ppc/ppc440_uc.c            | 2 +-
 hw/ppc/ppc4xx_devs.c          | 2 +-
 hw/ppc/ppc_booke.c            | 2 +-
 hw/ppc/prep_systemio.c        | 2 +-
 hw/ppc/spapr_vhyp_mmu.c       | 2 +-
 hw/ppc/virtex_ml507.c         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 90028f974da..ce3ce73b530 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_H
 #define PPC_PNV_H
 
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/core/sysbus.h"
 #include "hw/ipmi/ipmi.h"
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index 82681fb9a6a..778981bc95e 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -6,7 +6,7 @@
 #ifndef PPC_SPAPR_FADUMP_H
 #define PPC_SPAPR_FADUMP_H
 
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 
 /* Fadump commands */
 #define FADUMP_CMD_REGISTER            1
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index 88ae573d1e8..3f2bbc0a511 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "system/runstate.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 582698559d2..6a5d3edc490 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -15,7 +15,7 @@
 #include "hw/ppc/openpic.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 
 static void mpc8544ds_fixup_devtree(void *fdt)
 {
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 0f28a7937fb..634046506e8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -19,7 +19,7 @@
 #include "hw/pci/pci.h"
 #include "exec/cpu-common.h"
 #include "system/reset.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "ppc440.h"
 
 /*****************************************************************************/
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 1e6b6fec5da..ae1ac4f4672 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 7c6e5df9fde..052c8c931ae 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index bc8b0964e75..5cd18a9e123 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h" /* for error_report() */
 #include "qemu/module.h"
 #include "system/runstate.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "trace.h"
 
 #define TYPE_PREP_SYSTEMIO "prep-systemio"
diff --git a/hw/ppc/spapr_vhyp_mmu.c b/hw/ppc/spapr_vhyp_mmu.c
index 2d41d7f77b7..9cc3aeb2a29 100644
--- a/hw/ppc/spapr_vhyp_mmu.c
+++ b/hw/ppc/spapr_vhyp_mmu.c
@@ -11,7 +11,7 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qemu/error-report.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 51b3d7d7121..d10d9135890 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -26,7 +26,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "exec/page-protection.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/block/flash.h"
-- 
2.53.0


