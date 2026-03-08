Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86974EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMjT-0003NA-4d; Sun, 08 Mar 2026 18:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjQ-0003JU-OP
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjN-0003NN-Uh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so8465658f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009372; x=1773614172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C6RmIeQiTwJ3+6txXA5Lk1LKbCm90eL+X6+snaXIrnY=;
 b=ZFfA+NszByFwGB+llkB1KKpFqW8ZjzqnXh5hd8BqddI3iZIxD4pCYgz4PS6Nwmj+Ze
 R/dTp2cn8D93M6WXcyxv45rr13XcbJiSx6k6epNkFo5wWVbaDjHfN0hD4sZceVznO6KP
 wAEwr7zqEhSyWSiDKeyDo6RswdCK6omyBTtoeXLeEnrTwnNOsRLGjrvpu+e9LiJitUUd
 ut8xR+gwgUI9bYqdT7p3IeVhmvpdvcpHilulnJXpBTGY0R/2TjQ4xwxM3XYGla8h+Fm2
 8RaKlZYzT7pRAXF7dhmKG1TyU9CotE9bneeJwAdufabMwBFQUuj1hgpgiw+lGq4mNqGy
 la1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009372; x=1773614172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C6RmIeQiTwJ3+6txXA5Lk1LKbCm90eL+X6+snaXIrnY=;
 b=Al0v/V7ZThWDU4H4IoNhtx7wu9b4wD9YNbhQ7mgJ3pmNMujU3e66Nq8yybqVSImdmh
 U2SkGuunodFseT/DmxqOq70eotbdEyEJHfL0gfi20le0unGuWRJsFaws64S/qOhUNwFh
 clcnnU5zWjB+GLjNyBHC0T7ri32oPQ+SYKpiaxwQxyyajn2m84m/MG3ApfwPHLJikVqc
 aGHU1mGH3gbTvdVs4sHImcokIvjeLw5GxjF6DuSAjbPxPomQ77UXlrmlVH7PuS4fs5WQ
 1UF+pmeiewEDW/0Gk+2oGiL3G9dZ31JBvYQjghFZqLWx+VODQVLBYU+urJj3fBxaMdLK
 LmEQ==
X-Gm-Message-State: AOJu0Yy+LvKPD3EIARfFqHOYX40DteY1bianh5XHtNWJdaTfs7F57T3S
 F7Ec/+PdAwg8AgJ6OrVezIiEPib+pSf397iWyorjgpDTc7y0tt40v27Ad67LG7rGJZde7cfO77r
 syvMfTdU=
X-Gm-Gg: ATEYQzzxvxTh2MgPbRTwvi+9ylw0sb7Azk2a92qMe7k5AoE3H7+1V41BQU56woU4g8A
 cmOzGz8fPiONpi/LcpR6I69LhjPp+U1ryI88FWhrEzHfpP3I9//fwnMoQjddsjlZb7OkLzcmfwe
 6CUqb4IY+l0VSiOVh31/2fmfzENXeZ5lKu6g7Cq21SyPhx23mCB0FYG1et8IBpoifIC1TjyKUVL
 szbObh/x2hFTeGOxYqzIad1yhyaWa45w5CbX8CwZQv13i6ZWIYT1yTb1VYrAIlHBT9/fMhhJlgV
 YH4PJInf0TJBciWMCPU7Fef1JZNPiRxWIrBTAkDE8yaTT2z5nvUDBBPq1UDVg/BEYep/QW1lxin
 SBu3yFP2Onbw3q8hPIGj6mJvhnG7J3fQTnrghUJFNm/bK/jm+RnJLd4H5SR7IlQngkRHBz4A5fZ
 widMhTHjEy3pjmm8wajr40wdSKWbsHaJUe7K0/E5cmSHRClYNFTEI1QNeSS3Vz62yL2+EL7AHLc
 Ml4FwSPw1kbYgih
X-Received: by 2002:a05:6000:1865:b0:437:8fd6:d849 with SMTP id
 ffacd0b85a97d-439da8a2ef3mr15386656f8f.54.1773009371974; 
 Sun, 08 Mar 2026 15:36:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm23222664f8f.32.2026.03.08.15.36.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/49] hw/s390x/s390-pci-vfio: Avoid including CONFIG_DEVICES
 in hw/ header
Date: Sun,  8 Mar 2026 23:33:58 +0100
Message-ID: <20260308223433.25503-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

By turning the inline functions into stubs we can avoid the
use of target-specific CONFIG_DEVICES include in a hw/ header,
allowing to build the source files including it as common objects.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Message-Id: <20260225031658.32095-4-philmd@linaro.org>
---
 include/hw/s390x/s390-pci-vfio.h | 20 --------------------
 hw/s390x/s390-pci-vfio-stubs.c   | 32 ++++++++++++++++++++++++++++++++
 hw/s390x/meson.build             |  1 +
 3 files changed, 33 insertions(+), 20 deletions(-)
 create mode 100644 hw/s390x/s390-pci-vfio-stubs.c

diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index ae1b126ff70..f7d6149daf6 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -13,32 +13,12 @@
 #define HW_S390_PCI_VFIO_H
 
 #include "hw/s390x/s390-pci-bus.h"
-#include CONFIG_DEVICES
 
-#ifdef CONFIG_VFIO
 bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
-#else
-static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
-{
-    return false;
-}
-static inline S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
-                                                        S390PCIBusDevice *pbdev)
-{
-    return NULL;
-}
-static inline void s390_pci_end_dma_count(S390pciState *s,
-                                          S390PCIDMACount *cnt) { }
-static inline bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
-{
-    return false;
-}
-static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
-#endif
 
 #endif
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
new file mode 100644
index 00000000000..d9882b7aad0
--- /dev/null
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -0,0 +1,32 @@
+/*
+ * s390 vfio-pci stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/s390-pci-vfio.h"
+
+bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
+{
+    return false;
+}
+
+S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
+                                          S390PCIBusDevice *pbdev)
+{
+    return NULL;
+}
+
+void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
+{
+}
+
+bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
+{
+    return false;
+}
+
+void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
+{
+}
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 1bc85837996..57cc2a6be3d 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -34,6 +34,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
 ))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
 s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
+stub_ss.add(files('s390-pci-vfio-stubs.c'))
 s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
 
 virtio_ss = ss.source_set()
-- 
2.53.0


