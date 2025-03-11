Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE00C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvR3-0005y1-8I; Tue, 11 Mar 2025 04:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvR0-0005wT-2B
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:57:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvQv-0001GZ-Od
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:57:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso979353f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683472; x=1742288272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJAFD94zi/oNPjCaDJ/18IN628XDVYDLV93YoL8+1yI=;
 b=rweaF6Mw/qYS5RJTjfy2/IOnw7t76o1hveBhXliGgeEbEuB0yyvXCTPLYwNe7fXMK3
 jATpDvZzNnfeiWGJ3G02RC2j0e3YwKKXCpgO0BjdpZJLtp/BErpyfIhl+iVg1sMPDT6/
 W9Bf0s3XE3b0GJT+TfPOhwx+Lj5mylYo4h4hZT8c2zTAEa5YaaBclGHp6Kg2blTId0yA
 pg53QlyO2EBVkZ2hLvIdLyi1c9R5Rpd29W4UW9kmHuNsLbtOuNH+1bfFk1FybvGuAQBp
 Ay3CW50snyUHsv+hb2nAjNWRsbLsR6DqFxWflKmbjBpB3VC6TLc7yGYka2BIP0fvZbYG
 kkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683472; x=1742288272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJAFD94zi/oNPjCaDJ/18IN628XDVYDLV93YoL8+1yI=;
 b=ehiO7M7ovyHcLoHtAZ7rfbQmsIaztzDNzKHA1YcGTtIzRcxyJNLK1kycxE7FfjqExE
 2QV4WUmgSy4zPXCKhP6JgherD91xdsTx/rsI+75HZ0YVVDaJ6hd/rXx1vldqpssae0Sm
 iBIAzu//v1lDki5HBYbWVZnqaVyAPpj86W0ZjlCBFSP+zogxASRj/T57hTCOAfOY84bo
 Lb1JJtHDDAg9CBgAr2DEA7Tc0rJlwCQ+JNl9Cf0tmdALc03XhwwyG1otE3g8+rU0HS+o
 l+NWvNre13frY2XX3jQX3hu+galQtoHthblEIGG8xR//Iizv+ezSK3K2JR8zUIBc+e/i
 /ogA==
X-Gm-Message-State: AOJu0Yyg9P3xxqDTtCS5UMQUcA3sTKr5fKrSNaV5EvjLEDhYM98Y7WG/
 GGPAkzfVV46eb+FRNCXLFXH9H67rrH7YbwB5l4YE0w+AQRQ3Nv6ny3kh4qiOyorQ+LC72aInefR
 3mAc=
X-Gm-Gg: ASbGncv67sUhgUBiHgzoojJ2B49+kGPudQCIE9O8I60TRPigjSN9ermdSn2bfNBsv6Z
 0xox3DNGr5VcnXW/sjGDZ7QQY8GrZbFy4bxVj09x5FTsNRBwqMJobQN/R/g+Veech8dELwlqJUQ
 HdAW3+WJq0I/A3lYOUgxQwg4Gq0BhDNhToTEqLp6AIQlnwuG0oWNH4TFl4uHZi1k8HP8CO78rB6
 uZbyYqJma0rhV0Uxr9rz24WrvW2LRQnQqMjT4YC8LxWqVFCrrBFESt5BNTnbb2E/hB+CfTIlo9l
 8mT3g/zsoLlketi9a4Umx2JzmV+JEaBnJst7uUZPFC4pujmsa/PJDT3saA58O33rBcimhMzl2xj
 0D1DjbBL8NtPxozuUnTM=
X-Google-Smtp-Source: AGHT+IENGtdXpnHVaHE/pFqc7DQh359bAprD58qLtJIQITmL+4MLh1DrTmbMekHs2AKPpnClyzhKUQ==
X-Received: by 2002:a05:6000:1fa1:b0:390:d6b0:b89 with SMTP id
 ffacd0b85a97d-39132da91b9mr12448260f8f.50.1741683471678; 
 Tue, 11 Mar 2025 01:57:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf3ca4f5asm75774715e9.12.2025.03.11.01.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:57:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 1/8] system: Declare qemu_[min/max]rampagesize()
 in 'system/hostmem.h'
Date: Tue, 11 Mar 2025 09:57:36 +0100
Message-ID: <20250311085743.21724-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-7-philmd@linaro.org>
---
 include/exec/ram_addr.h    | 3 ---
 include/system/hostmem.h   | 3 +++
 hw/ppc/spapr_caps.c        | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/vfio/spapr.c            | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3d8df4edf15..e4c28fbec9b 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -102,9 +102,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
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
index a9b3db19f63..75b32182eb0 100644
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
index ad4c499eafe..237f96dd3fa 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,6 +15,7 @@
 #include <linux/kvm.h>
 #endif
 #include "system/kvm.h"
+#include "system/hostmem.h"
 #include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
-- 
2.47.1


