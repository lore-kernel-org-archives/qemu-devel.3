Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RlI-0001yp-Ra; Tue, 30 Sep 2025 00:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlG-0001y5-O3
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rl9-00011h-T6
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso4373514f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205676; x=1759810476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onCfEhinWarPReSMP2g+nvBYz1NYywUR3fuXcFIYVYM=;
 b=e9ObO9+i5mCbpoDDuedu/yNO+zKxoX10Iy8Wt4QnDiuReW4dzoEu3Meu32BXjNfoSo
 /uitIfrLHWKhYsYb2U9SgBWtRSSiKkeSkj32ZhwH4keEe4h0GITlmOkTD2ZG6HjKdaAg
 O5V9c5pxE8cUOiqjhMhYGVQ82TkkTmkLT6EFvu+/fBPds5Tm2NmIB1VOr3/dQuBMIAdH
 AR7Xg4wv9JVSqLY4B57tmU7mfp6vfTmVYurBzyCjIleT1HNWah3BXlVALk9m06LeFBA+
 tntYrNxw30BGaNJMcW4cOVAIxHs+10EyGgq43VnHlX1k+SI2rLZXBFMniaz0y4ASjBl4
 QR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205676; x=1759810476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onCfEhinWarPReSMP2g+nvBYz1NYywUR3fuXcFIYVYM=;
 b=uoq+LLy4N5IdD/jMd2r6N4eFRRBPe8KlC+7X0j5z5EundKOvYV3WuaIEg64qdrADcB
 GsuNc6Es74daODu7P4IxbH3/F1lVCe3Y0wV9FikZkgvh3hsgNLd+glYT6qLI9RZV7FeM
 Nux73Me6N+JRU6zU8da2N/Sa2rgNFhiHDxi0ylZ8T7qRDtDi7A+LURQVYdZxaQd0b/Ic
 kVWo4LoJP7TaPpWXMiKx4Gm7FnRw38W3m8ZSRs7sAXuk2JzqzkORB7NZYhHDCiYsJ1qm
 fb8e0RBRkBoM+yNs2N3+lIdnjXNL/oLKNAQh927LJv4xK1qpkqT5RbI/jLOJGJt2eS2w
 tBKg==
X-Gm-Message-State: AOJu0YwlNXKhP+3lU4Zp5HqqM3r7DgYjmuPQbANKAUMXjhsZcPpWWuos
 MCBjAvVk8H16xcG1tlOoU/Pb4/Sn4TfNpSQxn3KQ9aof9H/bE0y4k7n1iLnyT3P1YlBhiIO8xDG
 /jtsqCofssg==
X-Gm-Gg: ASbGncuvrWN+ft7fGgBC+VKMQ8flUArd1dWutfp7mwIbF2GlL+IlbFT3ClcWprX0tXW
 +OAEYn/unEsAkoys0y8R3JOjMBah0+qJ6s2ih6coW5dsBHc8xClM2JojAfcp8y/L4UzFvm1f5Jn
 ATTv6xvlF8PwBjZ2qJwIpSKr100bz1TwSLUIQt6F6pqHMFMck77IVg4/kq6t3+hqco0fWzcDJc8
 fYDy4ctZrVs9roWYIu/c4ikKGKJB47ebIHHkwJ5flZ+XGfUZzX/879VlWyk0LdnD4FlhDVpBJlK
 TLBB3UfeOTef5fsWrTgu2AocYxQBrl5wsSpmLqLopvFqDVB/UGfswhisInRqigVZQmaubtw0Rw2
 7ZG+hjhyi/Btg/UrGnRbIPupUTARBn85NkYtr0c9Wgu/w5brjl4d8uHHx6jPmozU5wE8dsoz209
 vob5cYGIcCdiajHOw4kH+z0ybJa+JbW/MET8AMWlewHA==
X-Google-Smtp-Source: AGHT+IHXSt4CkpBPH+1BT7FZNZBNpbDyORtYFCRXPSlc1PSaGA5no80rsQKq3Agt1aNkmXQ30vgX3Q==
X-Received: by 2002:a05:6000:2689:b0:424:2158:c1a7 with SMTP id
 ffacd0b85a97d-4242158c3cbmr1203705f8f.34.1759205675919; 
 Mon, 29 Sep 2025 21:14:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm21288982f8f.49.2025.09.29.21.14.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 11/17] target/i386/kvm: Replace legacy
 cpu_physical_memory_rw() call
Date: Tue, 30 Sep 2025 06:13:19 +0200
Message-ID: <20250930041326.6448-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/xen-emu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 284c5ef6f68..52de0198343 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -21,6 +21,7 @@
 #include "system/address-spaces.h"
 #include "xen-emu.h"
 #include "trace.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 
 #include "hw/pci/msi.h"
@@ -75,6 +76,7 @@ static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
 static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
                       bool is_write)
 {
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
     uint8_t *buf = (uint8_t *)_buf;
     uint64_t gpa;
     size_t len;
@@ -87,7 +89,7 @@ static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
             len = sz;
         }
 
-        cpu_physical_memory_rw(gpa, buf, len, is_write);
+        address_space_rw(as, gpa, MEMTXATTRS_UNSPECIFIED, buf, len, is_write);
 
         buf += len;
         sz -= len;
-- 
2.51.0


