Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57574106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vto-0000oH-Rc; Fri, 13 Mar 2026 02:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vth-0000hm-AK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtf-0006tM-U9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b611274bso1144438f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382878; x=1773987678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIOm7tmuk8Unr+dWjypmj0K3jr2IzeJYxwNcrzDjXPA=;
 b=DMMW+CgiEmUd04TSVlVPes67pCjVVt17oMmK+MvngToitCp+dTlXlTJNVn6c6aTd9D
 C8zF7wkz7XK0TiphicPnRK+C09QkWfH9RDPQi2MWOK+1YcrtWVGZVrYPESbgHwrPu0Nw
 MInSh24iSNdlqHMRuF6Kd+5Jl/e9CmXxbrBKtVc1FcrrdhvD7AFjAx4cSdY2ujFYSZE4
 Wm6piGo8kgVHpGGpRH+hMoBjoZyV8AAuJoljSd2xsI5RMHWi2dvy1QAh5+TEV7J063M/
 nTT3d3QBosB6983B7mYriretEGNvtak1C979Nk/TYcaYWd7OtOqAQJlD0MxU4IpxFGV5
 66kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382878; x=1773987678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fIOm7tmuk8Unr+dWjypmj0K3jr2IzeJYxwNcrzDjXPA=;
 b=E3r7XtYmV0qK59c17/CFNHnSg5AH+KIPUThEHe4ck8+hpkKzCMQOH01MXGPBfKECW6
 AxeDiH3ZFmtMGghrKgyWMY+TwlGwOAMxQlZZsSnJP6tRDWLUa1+B37oioWG53fG0HgDh
 r5w2CyqY4RBSMbwyCGfqdVpGGBH2Prq+jjARPLfh0GWBa8yvNeZruUTqehwWVAdV0PF4
 grUwT929eqQfehqDQ14qzjX569ivbHo9jR1Hr1zFh9r8tcCMKJlb5mRLYyumPqgrtIM7
 jZX2q3WQ+sRXrsPGnVGqsOcP0cHpP50zltDBTdlDr2LjZVmq2dqVNN7esNATTEJrSFxT
 1Wrw==
X-Gm-Message-State: AOJu0Ywd0dW0hDE99IOuq74j6RemQ7sEoqAWlrALKevuTMeaW8W7EB3d
 cE3P9+bLmpLU6pxyh+2A5Fm0UUZ+UvSJ+/0qALIEr02fonn0M1Ifszq3LTCyzwTjVR2tRx767fT
 s6bPw03E=
X-Gm-Gg: ATEYQzywJlbUaayX56DJ9hFC04IQ6Sa2UNcyOsMxXakprLkM+dRNQ67gG3HTsUuOHwt
 FtYfydLm2DsfRZiDIQiO+0MbxTxQWMnKoMtUq8qwt2e+E0l4u1OiPNIOowx+Z1sTeCloUOtPsWx
 c+wuNCLb4ZQAyrwQozrVT6A08fG01tjJB1Po7JdysRlD25dWXYNw+30CkUs1nvHjpl/0KfVUs6h
 DDDlXoRIQllAE4GaEQ5nPrwDGRn/OueIlQMQi070abDz4rcMqfA+jXlGDHk81vUNqgp/IbC2hTA
 nRro6B4tdQ+1YnnL76fujpmzlONjjWKnY96ACxLb3qwtwr2QylJ2AmD51DkO1rTeern+NOIAEKF
 svpSh0fDIJou6a3MXNp1FDJmh2vT28T2hpTdhJgdt6yaLrTMJlGFlnDGuLU9urXZOiHbNT03hVh
 Bkm0z6XIALrkz2jJu2llL+16RJ6QvqzgG1mgd0WdGTiWdqiBRRxa8qXpPYNLsiESqKxwfK7zI6m
 EXd6X8CTux7nRKt
X-Received: by 2002:a05:6000:230c:b0:439:bf2f:123e with SMTP id
 ffacd0b85a97d-43a04d868d9mr3769280f8f.11.1773382877999; 
 Thu, 12 Mar 2026 23:21:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19acc6sm14756756f8f.8.2026.03.12.23.21.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 03/38] hw/s390x/vfio: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
Date: Fri, 13 Mar 2026 07:20:19 +0100
Message-ID: <20260313062055.2188-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Get the target page bits at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-pci-vfio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 8ce44dbecce..7c754b656da 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -22,6 +22,7 @@
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-helpers.h"
+#include "exec/target_page.h"
 
 /*
  * Get the current DMA available count from vfio.  Returns true if vfio is
@@ -150,7 +151,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
      * to request that the guest free DMA mappings as necessary.
      */
     if (!pbdev->rtr_avail) {
-        vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
+        vfio_size = pbdev->iommu->max_dma_limit << qemu_target_page_bits();
         if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
             pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
         }
-- 
2.53.0


