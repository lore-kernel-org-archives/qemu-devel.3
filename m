Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39552C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Iy-0004hX-Ig; Sat, 08 Mar 2025 18:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Iv-0004eV-Hv
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Is-0001BC-Qx
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bdc607c3fso17911565e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475397; x=1742080197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNAZPNsyTlqo2tLPWvhBvh59TFVcvzQjUjnLojvYJaQ=;
 b=mqKI2Knpe9laQpZ9s7MYWyc8Q/lXhcgswgJ1O7fCC9GhbLVGX4dvV2q0Pvwol9gO6s
 oHirfdpAIb6hVbHhIxoT3pDyLddV3P0PpRF5ejSofKs0WRThP9tENywhIbI2nlJB9B4Y
 tjghfHK5BfVyhHfKCzgyWirNXeFraKvKVDGFs3o/m7hIvMHInZOV2RIpc3R3I74r3eQO
 kxr4Tf9SYq0ZVIgvieMJ2tX1Okn1FhYSsachTCjPi5OZ6paua2CYHvmoP2qiu6s4KC5J
 g3LBRQgPAutATRMO2Jov6RfNiGFJmZvO5ZFrCZ5SpF7079W+dKZ875CQEI87g1eu0u9c
 y3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475397; x=1742080197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNAZPNsyTlqo2tLPWvhBvh59TFVcvzQjUjnLojvYJaQ=;
 b=EsBMblC/Kw0XgvT1pq9yownGe1WksYcjajcZ+v+2AOkH6SOZh3xVxfAUqHj87gH2Bu
 VcsE3nUXyTuDsQ34bCC9iXUY0KL4gAn4rRH0hK63UPQpt8n/t88DAaLNLL0YPLUqIWEm
 XUX5lyUFLs1ITS6YzMe6c+d6+rdsrBlfjexVBQZFZy/fycKXGFTKA98FNwS52JuclXyR
 X098tZgmgiGQN1fcqAfxMW60hnVSpd+J8D/trUC5Ad/c3eB/qSZ4+z0S7OKCX7s97had
 701zowFBik/ZdYAu60+SVQmqHhsvR78qv5QHJWZUsHtD1Y5KcfTUxGl4llDW4z105C/7
 ultw==
X-Gm-Message-State: AOJu0YxyEdxJKqURI1aucEl7ZMelmyMBNYF06VJJgVgw4Bwwuo/LsJZO
 3lND5zHg3cvkVIKtauq075TJ9tEu48HWGsGscDe1SJ7QOopkl4rTMCXYAlwoyxEBBLj1ROIJNRG
 qtTg=
X-Gm-Gg: ASbGncv1SeMcz2cQAeY4d1blRdeN9xLBDxfy3Eq/eMHijVa6T79Ri2Lu6wdGO+Pg5tf
 i039DKQIxjDBQkM5tbhAcCfrJSYEmtYeibE44Y21Udnr+aqCgwbD9zd8+cClsJ+rHGLIdHy5+U3
 cYcQ3DEApRSP4fnea1Sz90IId/WJf+PCla82GQLpjlGmF5GBkn2ZzUXfAww2Xw+GauMxpGM4Amn
 k+fHZdzukCjVfbTh0bqARvK9Q3py7W+SOwhIfh7kejBGHgM8RbiQsU2mJ2psovaErPp/QvraFy6
 nAXH76UyA84/4cyvhl7yUxhNw+L+GgI9PyMIP3X6ZHAPN3m1PcdjF8I82WJCZGS8Nj3Gc7t3HUF
 85WXkr9oo6EddtnQvynU=
X-Google-Smtp-Source: AGHT+IG8MQrKfOJU0WoQHCAOd6Oq6wQcj1JZv9hwm7SxDKuTpUWDCbRgEKRZFOWkkDK4Q+3TnMf+nw==
X-Received: by 2002:adf:a1c7:0:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-39140954a39mr1073805f8f.25.1741475396652; 
 Sat, 08 Mar 2025 15:09:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c33asm132242055e9.3.2025.03.08.15.09.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/21] system: Declare qemu_[min/max]rampagesize() in
 'system/hostmem.h'
Date: Sun,  9 Mar 2025 00:09:02 +0100
Message-ID: <20250308230917.18907-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Both qemu_minrampagesize() and qemu_maxrampagesize() are
related to host memory backends, having the following call
stack:

  qemu_minrampagesize()
     -> find_min_backend_pagesize()
         -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)

  qemu_maxrampagesize()
     -> find_max_backend_pagesize()
        -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)

Having TYPE_MEMORY_BACKEND defined in "system/hostmem.h":

  include/system/hostmem.h:23:#define TYPE_MEMORY_BACKEND "memory-backend"

Move their prototype declaration to "system/hostmem.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h    | 3 ---
 include/system/hostmem.h   | 3 +++
 hw/ppc/spapr_caps.c        | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/vfio/spapr.c            | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 94bb3ccbe42..ccc8df561af 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -101,9 +101,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
 bool ramblock_is_pmem(RAMBlock *rb);
 
-long qemu_minrampagesize(void);
-long qemu_maxrampagesize(void);
-
 /**
  * qemu_ram_alloc_from_file,
  * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 5c21ca55c01..62642e602ca 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -93,4 +93,7 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
 char *host_memory_backend_get_name(HostMemoryBackend *backend);
 
+long qemu_minrampagesize(void);
+long qemu_maxrampagesize(void);
+
 #endif
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 904bff87ce1..9e53d0c1fd1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -34,6 +34,7 @@
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
+#include "system/hostmem.h"
 
 #include "hw/ppc/spapr.h"
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 51ae0c133d8..1261d93b7ce 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/s390x/tod.h"
 #include "system/system.h"
 #include "system/cpus.h"
+#include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 9b5ad05bb1c..1a5d1611f2c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -12,6 +12,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "system/kvm.h"
+#include "system/hostmem.h"
 #include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
-- 
2.47.1


