Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761A7D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3Nj-0006Wg-79; Fri, 29 Nov 2024 10:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3Nh-0006WF-Gc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:58:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3Nf-0006MT-SU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:58:09 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cfd2978f95so3397848a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732895886; x=1733500686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OGL4vfV/tJS7xDopWomqNJ0/AN5OESAhWRytdgc3oY8=;
 b=tdAfgfzlD1W+nZfBvxF5GB5IkLboYuNoPdV/NaujAZwWE7gZkwycMtzoGCRmAv3UzB
 itQD3xmnwILtyvQ0pJi8BwKU65aq31MWacKyXNNvIXLLjXYyVzcxjQNbSps6gTPCyvbB
 6Lh4IcE08LgTg33koN95nzddYcq8S/fdQ3Y3pq1k+Nr3wa0VBpBCw/Kn7KAmxQ2dWGuC
 DVo8bfuQjdhUh81tuv3Ep7PbOwKW2szG0MOVzk9MNJn7DitX2aW0DwjKJCnYwaDA2nZv
 2SJ3gQgkyIE80/0YzmNerA9i+aIdbrofol+H5n7zPQa39E2HJnU5LFRaVew8tjuxTIat
 epuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732895886; x=1733500686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGL4vfV/tJS7xDopWomqNJ0/AN5OESAhWRytdgc3oY8=;
 b=JjGG7+o3WBZX1x2UBxdVs1YF4LPaV/7WaVoLMaswUI6RSUM/Gq4hf5l6QzweJVvrkz
 eRhyMCiHmdyhmHTuO0QnWWqSh4wjSQUYWE1ND174GCpBy+qO5QIv1c8hOSYHzKqMXjME
 pIA5tun/uyXsdwkyTYZSVMuHnxLs3RNUkXYtrGDBpPa7fYciqNxNvrNddBfdVxqrgYlc
 5x5K4wPmyDaR8KeYuJuoMMPbJUY3qgErp3SJAl6fiol60fnQtcwNb0624gQG3fnV/pN5
 MQHCeKMiFm14iQZLGJskkAnWQABfwiVG8/LRLmshWaZemxkP9WRGGn1T5UNE8xqugMTI
 3ViQ==
X-Gm-Message-State: AOJu0YxX/y8vuU7AKjxLjtukoMgoxzN/bW/1XLSz0HHuR8MEEfM9OpTR
 85Q6yagTIFgKFsfZL+OBaPG5vJ6mmDKIG01wbMJDhnBLRo5a7efo4WQP5gMvWNfW1b4RPieFAIs
 a
X-Gm-Gg: ASbGncsHB0ArGNCu+Q6f6KS7GnOl1TRAqHDMjdjM1AOnsGWbHGgYrSYVe/t8xcp/+H0
 TLVhMrsJGsRs3nS364PM/Bu9Zx72JDlwM5YLSO+GSn4nqFXtf8l5i+5g7ZkFRVCcSAIwhP6Vhtn
 FT9qfVADMt/TSkRnQeFdf98poLRhTl9jOvStci8qWkIOIyB5Qbkg987wxC0ck3ajqI2+TV8fN82
 SeOpfzAOCz4c3IZmo9mGXT/Kh4q/barfTy3K1LrR7ZkIOf9ZUhAer7QktKK
X-Google-Smtp-Source: AGHT+IFn2OHSB6CTkKDSfzmt2cXfP5ospDT9IfA+JQvn8/QzG4q2AExmb18W5Ni6fPbhFiaPoZJ9BQ==
X-Received: by 2002:a17:906:18a1:b0:a9a:6b4c:9d2c with SMTP id
 a640c23a62f3a-aa58107884fmr1065535366b.59.1732895885773; 
 Fri, 29 Nov 2024 07:58:05 -0800 (PST)
Received: from m1x-phil.lan ([176.176.147.124])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59990a79bsm186683166b.151.2024.11.29.07.58.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 07:58:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Vasant.Hegde@amd.com,
 Santosh Shukla <santosh.shukla@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Daniel Hoffman <dhoff749@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2] hw/i386/amd_iommu: Simplify non-KVM checks on
 XTSup feature
Date: Fri, 29 Nov 2024 16:58:02 +0100
Message-ID: <20241129155802.35534-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Generic code wanting to access KVM specific methods should
do so being protected by the 'kvm_enabled()' helper.

Doing so avoid link failures when optimization is disabled
(using --enable-debug), see for example commits c04cfb4596a
("hw/i386: fix short-circuit logic with non-optimizing builds")
and 0266aef8cd6 ("amd_iommu: Fix kvm_enable_x2apic link error
with clang in non-KVM builds").

XTSup feature depends on KVM, so protect the whole block
checking the XTSup feature with a check on whether KVM is
enabled.

Since x86_cpus_init() already checks APIC ID > 255 imply
kernel support for irqchip and X2APIC, remove the confuse
and unlikely reachable "AMD IOMMU xtsup=on requires support
on the KVM side" message.

Fix a type in "configuration" in error message.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2:
Rebased on merged 0266aef8cd6 ("amd_iommu: Fix kvm_enable_x2apic
link error with clang in non-KVM builds").
Supersedes: <20241129114113.33215-1-philmd@linaro.org>
---
 hw/i386/amd_iommu.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index af0f4da1f69..39b6d6ef295 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1652,17 +1652,10 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
-    /* AMD IOMMU with x2APIC mode requires xtsup=on */
-    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
-        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
         exit(EXIT_FAILURE);
     }
-    if (s->xtsup) {
-        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-            error_report("AMD IOMMU xtsup=on requires support on the KVM side");
-            exit(EXIT_FAILURE);
-        }
-    }
 
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
-- 
2.45.2


