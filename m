Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82842CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vd8-0008Ut-9D; Tue, 30 Sep 2025 04:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vd5-0008UC-D7
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VcM-0000lq-Gw
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so38468455e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220505; x=1759825305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVuWODNllLBcWHkHdEzk+20qcWtQ6YA1oYWBzMhXpCQ=;
 b=sM2tGGP1QyugA35G78V2y63KC/k54ySQVX6FbBa/OmCTnGWDdvdlfgBA2g9tCZ9li/
 b2BxXTM56CoSCgyFFKiFBJOOBDZMdoUoH9j0aFNM8AZYcvIhWR6AAYuKSwzUL2StLRg7
 NomlkNmMOsLt7YKWivdo5vnzElDpbUIlXpRgqniTU9RBXwKPbcX8S394T4BikMl3Xvwv
 Yi6RexdOvihu8V02ujGg196/0ITWr6AYqHZtFzgghVj9MUGdb2nx3RUR5sYNjjfK1EDB
 DMO8EmZMh8UGzVn0d0Yd984bNjwJq9FO8MUxgdddAal10kv+47stVa0pGAaB3+znGtUJ
 bepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220505; x=1759825305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVuWODNllLBcWHkHdEzk+20qcWtQ6YA1oYWBzMhXpCQ=;
 b=pNFk4BcHiapgT6mdpLXcQ7jxhmnntJQmd7mXZeDxVzn9/1sgtUGCt75IC2A2DehVg6
 r0fJDIFcgnQeOxHF7/pQJ/WVn6LQfypd2cE/068ard3iOR5VRKnXlsnZnTIcBzoh/uN3
 M9Xwi/kkHkJp9qngi4fBT78akaiGEGKi4R8tOswSY15yL3gHqLEGkRx+dlRkS0QiN5dy
 IEr4NN7jqVXFWvhO9kA1LTgMPegKWUI/W5hVU456g8HwxV7CBsLbHb0lZQBqE1vSlJtT
 +lcw0sb8WA5iTT12JJvLeU9Fo7GJlk6fdDQcS3IwSPi6uUnXW79dJvbJbIgAwjzWlCvP
 W4iA==
X-Gm-Message-State: AOJu0YyIc/Uy7aYlM0qiB1Ii+UDDVqhHoFrMBqouCzxeM4TTgcHU1lhq
 CDf+BQwu1gkkYdcUyoCMWVfHC3s/mWGe4WvXAU37JD+cCHd4y/Gj6uX2QsRm7QT5HVEEE7OhsQc
 a/c8SC8CI3Q==
X-Gm-Gg: ASbGncsF+uUcQ6PzKuvexAyLSQ4+3yLjbt5FKpo+Rd3sgXlVPfgfApF/RrHdMJz1L4L
 pS0oQKAPxPVcYHxespBTdpsvjnOzHgx8vHXe77yEEpKPj2QG48dHX97/7CVaY1iZTYgWHExbGvY
 Wp21nC2wW7H0OlC/HXhg3VlZqfu5lz+DSM1V/P+il+HL56iCQXlTpbm9pkubrjfm1KzfuNSx3yX
 NiI0NwcQyQZPtLzkzEXaAc5MLESL5arHVqYpiSWzmT1nRzf9TBohOng0/uffodC77Z56LewrhwR
 XugKiJU4WoQlqtEY/nF9KHo/ejGONNMmoXd8kF0gwTGtF0hHeA0x3nQR9WBBogUYjE+5JMsXCXc
 Gw0v9klsKFPDgV354EJd9w4hz7KWcMdcdwEMZYNYG4x3lxGe0KB/wUA6UjliIjeti0GOeqIB5ca
 ylcJvwqpAdieKaALPLrcUwqstvcy2Z7NE=
X-Google-Smtp-Source: AGHT+IEnN1+Dj0G5eE22oo/LVcWK6MF1t2TvnNSxkl29p00iMJks8dqgYIqx9W0IIiNQ+maQ1TKmXg==
X-Received: by 2002:a05:600c:1e85:b0:45d:d5df:ab2d with SMTP id
 5b1f17b1804b1-46e32a03456mr188255845e9.26.1759220505370; 
 Tue, 30 Sep 2025 01:21:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c3cad50sm8272675e9.3.2025.09.30.01.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:21:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 03/18] system/memory: Factor address_space_is_io() out
Date: Tue, 30 Sep 2025 10:21:10 +0200
Message-ID: <20250930082126.28618-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Factor address_space_is_io() out of cpu_physical_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/system/memory.h |  9 +++++++++
 system/physmem.c        | 21 ++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3e5bf3ef05e..546c643961d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3030,6 +3030,15 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
 bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
+/**
+ * address_space_is_io: check whether an guest physical addresses
+ *                      whithin an address space is I/O memory.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ */
+bool address_space_is_io(AddressSpace *as, hwaddr addr);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 86422f294e2..84d7754ccab 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3359,6 +3359,17 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
     return flatview_access_valid(fv, addr, len, is_write, attrs);
 }
 
+bool address_space_is_io(AddressSpace *as, hwaddr addr)
+{
+    MemoryRegion *mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, NULL, false,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
@@ -3755,15 +3766,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 
 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
-    MemoryRegion*mr;
-    hwaddr l = 1;
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(&address_space_memory,
-                                 phys_addr, &phys_addr, &l, false,
-                                 MEMTXATTRS_UNSPECIFIED);
-
-    return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
+    return address_space_is_io(&address_space_memory, phys_addr);
 }
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
-- 
2.51.0


