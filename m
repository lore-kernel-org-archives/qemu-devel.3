Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEAACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IiR-00066q-SS; Mon, 29 Sep 2025 14:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igy-0005D7-FG
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igr-0003GJ-Mv
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4c9083a0so17423805e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170815; x=1759775615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRsfrHQBMjnrXhlxfeiXrXfyISPq/9LUWh417J9QSAY=;
 b=kmIAQhDWjKosDxqYa7virz7w09BbGRVCBz3mVYgg18RPGdYd/1zPJ+lNUpJAvL40Ll
 S2nh9e0XdI+TXpdngzH/S0oCFiKcXHKCiQyJ5gg/2Egd3VKgb3TiSik07X5M1GNZEq03
 wT2aNcIO2fFSJNfGDSqMdYm9H7A7hCrzayPiwntBw35diK6VyFJpb1VuqdmJdU4O/dgw
 kZikKyOcys+yW8RWIKb+cHF3DQBly3+1e48/WQo2gGnkLkG7QEYqWqNxPHfFL7VGS1LV
 Lus6uukeWTgVfW7jVs28pYt1Rlf99jAdWGKqlTk71vcpCHVqdbRoFXpVR5U090nfycHl
 Oa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170815; x=1759775615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRsfrHQBMjnrXhlxfeiXrXfyISPq/9LUWh417J9QSAY=;
 b=JS8197GYlAFk5BTFrXVYjKSZQUYjQhYNiAt1AkC9jEhHvmFZ0iLFNAEbw2rEqEWRMw
 bwOE6Gfg+FBqgkErouRdmdTaBP1TqkWbUrZ2bNOb66XTtoBU3T/+GGdWBUN32iavUtas
 SEZqPdp1okTbwzgPQaDXZWXTINXMgCnDSKSwWpiaohyIpcbWMQBU6YMvgqYjzDX+K2T/
 m9kN/d0v0Awy1dHI6Ryu3f7vUDoGAPhy3AWjazDaNOF5uvL43s7uRiv0FmbZ447Zvy/J
 Dm+ckAq49ettcASloc01lSZ7rcPo0QDhTl0uIfnO739vuEYUGbLvgYs+55ZGrsPSAYBS
 NFvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGLchU4u1WD44+SJGG+16xUlzg8geNbgtywPVv769rMUXghEmRWRra59tgFh54gGYTOKXh9Roq8P4x@nongnu.org
X-Gm-Message-State: AOJu0YwIAmiOca2sKJcm0hl8oXpAER0TBlNlOUKUkVHW8LrZfGbephTb
 zoI7jnM3ozluQu94tG7sFbrmrG3LLQKBUguC3hRhB5oClM79gKkXRCoAmdwMRuysZ8w=
X-Gm-Gg: ASbGncuiBW2qwfpQTuY7DtELtQ8nNi1c5AalCp8Sg4QHOMjIVME7Ml6w6HNPjYmbOPQ
 FaB+jXgdaRAinmz0FrYrDuWgBVDFB7Gu5TPzdWvX5++/1JfHqI+BvogyAVi9dSPd6RWdfWWVlnP
 kCcojzGfOilJxbzqMci13+6CGZgxhCPXc7cgM2GGQZakoDRT9tokhmT9nwPaTO2nem3+hRaErN+
 G93H9DkF3lqPI5+mrX7dJOxB4+BRB3n4zodw25exTH+Ibu14dRh21/2Lz2+ObMatfAUfD5Nast2
 HZfekJcfJscJ3XqW6mpG8s1ZQRuwVQ6KYdlErSah5UxBOqixY2BquCOt4OYKpMdfnYlz3IhpDJO
 1nqH0ojgoj5bgzcq18cqLx1TipQ/2UU1PYm6U2TYui7+pw/ucoX4n4kdpiqWyA2ge2WaB6qpYro
 PoFfnZVkY=
X-Google-Smtp-Source: AGHT+IHnK2dcf5REXjP75RtjLmG0FRF3SPCN5/ScyVADUNX4W97Ctb9XEl/zwwWPFNLidNab3G3GOQ==
X-Received: by 2002:a05:600c:8285:b0:46d:c045:d2bd with SMTP id
 5b1f17b1804b1-46e58ac80f9mr17543845e9.8.1759170815433; 
 Mon, 29 Sep 2025 11:33:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a996c03sm236802335e9.3.2025.09.29.11.33.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 07/15] target/s390x/mmu: Replace [cpu_physical_memory ->
 address_space]_rw()
Date: Mon, 29 Sep 2025 20:32:46 +0200
Message-ID: <20250929183254.85478-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(),
cpu_get_address_space(CPU(cpu), 0) returns &address_space_memory.

We can then replace cpu_physical_memory_rw() by the semantically
equivalent address_space_rw() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 00946e9c0fe..4e2f31dc763 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "kvm/kvm_s390x.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
+#include "system/memory.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
@@ -522,6 +523,7 @@ int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
 int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
                          int len, bool is_write)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     int currlen, nr_pages, i;
     target_ulong *pages;
     uint64_t tec;
@@ -545,8 +547,8 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            cpu_physical_memory_rw(pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                                   hostbuf, currlen, is_write);
+            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen, is_write);
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.51.0


