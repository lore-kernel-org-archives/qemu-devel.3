Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD06ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeX-00017p-NM; Tue, 30 Sep 2025 04:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VeP-0000rD-Mw
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdw-0001KS-9M
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so9309405e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220587; x=1759825387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+R20KfaeepivX48ztS5Qk+Utu4Wf2nP4nwxC8R0e4a4=;
 b=IcOF1Rksu59wCMGsQtXrXlv4DfZ3ADC3f5+lfaal01RYwA+drmix7wot0u8aknJIW+
 3Z9tujov//vnQge+q1DlNv4ICQX5ByBIUAHRTPx+lE0F2quoWR30Im42HvF5haCoc2Jh
 c39bGf3PQFsrAMxj0uRQbi5edRHXFZrFaBN4Xn68HKUKnCJFTj539xdGE33AycZsL+gZ
 FR5qnsFOKomjRk341o3M9rPe0vzlINs5JITOFrNfBvSpGfHeDbvXS37yqlo45pYib5OX
 1WH+DU0FoMy7fWbpCid9+eFRdGZxJ/9H6zcuBBb9vvH7WzCvuAzkWJpAikIi5zi5+HHw
 8MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220587; x=1759825387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+R20KfaeepivX48ztS5Qk+Utu4Wf2nP4nwxC8R0e4a4=;
 b=pVdRDKv5hI7Zvs7uMcMnOfEGucDg6mhcFCZqRGcycE0CPMHRvvhrE4f6L+Glcd259+
 QmKnxc7ertS+VWy6s8W6quhgCwTnEMjXcGD5sMm9BdgXBwr9eunNcIepPmD69wavvgu9
 pljkhcbYntEvKBlESnWu5GO/1q0r8qPkPra1zP7V5CiiwD3HcRs8RPlb8d5/3KKbRT7X
 4pmrg0mnrP436+KjbgoJ+RAfXo1fAf00OfZJemgFPTX9txFzkuLqs4GusHldLrMaDyUM
 4M72X+HegpRBEi5oekPpkx5sGi0smHUXDcP0dm9ywu0uYTJnj5qEUD4XdNPDt6BTBkkz
 wZ/A==
X-Gm-Message-State: AOJu0YwmtdhyfwH4YTQY4BKbGIRiofd/PPg2rdHSTHC0VE9TlWRQ26WZ
 GiKGg8GjNemca6MtCWhjnkb7uVMAR/hYUYYWPbiA92lszFL0Ci61iS8N29mI9sEk6Zj4AGf7cwI
 /r3uKevSx8A==
X-Gm-Gg: ASbGnctcFZZBEnGeIgmL5s9m9c7jLJgk2Rjbl3zmVUGkjcPFRWd/ZOenHaSvAzTE+U5
 kUe5Fn6VJCozcFAjnxakoUUEyo7I0wnB4khoXN947wD26boQEkrMSG3NbWjOR5asn6YHD4kcYqt
 1IF3TDgLpxHA7ZCeuW8i6oO9+K6tmu0CtjRlzVa3QKIC9JRCpKaVcToWERY/mNeAq0IEhFd8DX9
 6Jsp6gsHgIoVzSlo7kUJfBqPx71Byw6aEVhRjS0KkdJa78dE58z3rtCZgrgpxgY5/FAeq64zibb
 aKeVJiuruLw5wu/7MSXCkicIYE0HNaSZLNU81roOJP0UZcDJSDWrX8zBNtqWMHjewSXsEkQ8Jy+
 qyk/qseWtinxwhuyglTrwsdvi8j0ctY4QeIghiP002t2dmqpBjEcKer7wtgfuo6BFLbH6de/w2x
 ll7f8BI2ka8AS414hO9mTkwNj/jVH5UNY=
X-Google-Smtp-Source: AGHT+IGvdNJkPsXhO7mhTBAmSS24HJr1NcQFoKlHMGEeSQcfQp9VTD/G8Mg1Kg5Mqclxy+K9+gFIZw==
X-Received: by 2002:a05:600c:4e8c:b0:46e:477a:16cc with SMTP id
 5b1f17b1804b1-46e477a1b4emr94534015e9.24.1759220587242; 
 Tue, 30 Sep 2025 01:23:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2965sm21484653f8f.55.2025.09.30.01.23.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:23:06 -0700 (PDT)
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
Subject: [PATCH v3 18/18] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
Date: Tue, 30 Sep 2025 10:21:25 +0200
Message-ID: <20250930082126.28618-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
in order to replace the legacy cpu_physical_memory_unmap()
call by address_space_unmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e0..1ed3aa6abab 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -1622,7 +1623,8 @@ out:
  * virtqueue_unmap_sg() can't be used).  Assumes buffers weren't written to
  * yet.
  */
-static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
+static void virtqueue_undo_map_desc(AddressSpace *as,
+                                    unsigned int out_num, unsigned int in_num,
                                     struct iovec *iov)
 {
     unsigned int i;
@@ -1630,7 +1632,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
     for (i = 0; i < out_num + in_num; i++) {
         int is_write = i >= out_num;
 
-        cpu_physical_memory_unmap(iov->iov_base, iov->iov_len, is_write, 0);
+        address_space_unmap(as, iov->iov_base, iov->iov_len, is_write, 0);
         iov++;
     }
 }
@@ -1832,7 +1834,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
@@ -1982,7 +1984,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
-- 
2.51.0


