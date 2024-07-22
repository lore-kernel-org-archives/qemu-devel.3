Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954E4C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmO-0007bM-Sw; Sun, 21 Jul 2024 20:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgl7-0001RD-QJ
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgl5-0005uT-R9
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DSrvGWDM8WQlkDQ1QptgcjyZ8pct3cQ7nSxPz3zLafI=;
 b=Lnx97+XjxefFQ0CYeeleujw+I9Vcyam9zmf4IQCGeC2a7SHH8ZwRFmHE6cZJE/LWP1OnDJ
 8s3DGb6T2CuL0os0XsPuW3ZCzU3s5hNlE5RuW5H7BcZzW9M32w5QGHnhRb9dVkJh4ELSWF
 zrocGQ1c32+37+gwIQz3Ym/Apngc3h4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-RioShQkKOOeOhjGgtZiTBQ-1; Sun, 21 Jul 2024 20:18:26 -0400
X-MC-Unique: RioShQkKOOeOhjGgtZiTBQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso27672475e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607504; x=1722212304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSrvGWDM8WQlkDQ1QptgcjyZ8pct3cQ7nSxPz3zLafI=;
 b=Nb0d82m3nUqjWGeXwVW044af1v/MXUbl6arC/J9jbzbyFM15FXBFi1v9SO9rp8n5mG
 Ws0np+Wyu8V+Gw+iqcFHETLFFPfpulqOHm8ZlzwAWyiZ6q15xYxIbr5VoAli2ioo7tDL
 DeRaDjHR4g3H74WUKEQfYoASG1pSge9y1fVb1Ram8NzypTFCgxmn1FoIon7DL7STXRR3
 oZ4U2KPf2hWPsMS/dBs9BlS/JYSwsUEZqzYN/O+41OHMNW02ihj2mpRJIRhnL5O/09D6
 z77TrZBortXof8CDW0JAs9UOiBjhSvWYNCqQLfsA7fWHK8rLTTPd27AWE8DvXFlW9uNl
 ghLQ==
X-Gm-Message-State: AOJu0Yx3+rA1JGfpdEpy3Zm/b0T0twFeo+55QRJdwHleyFH/FdoyLxp9
 lYaSvZ8VzC3yxPNKd+PSDFUtm9xRV7x+Sw1utGHwlNjYNNGW4MaNe2MUq72uZmbpZEac/L85hYV
 USTchQtnYYvH9Sq8ajaJ4F3lJbORHRP3dH5/D4HmcQGfwVG4YlF1cx0kMJUcBTR0nGzaBBuX/t2
 IISame7y18JiaZQb0ElGp5ZW59lDtR+Q==
X-Received: by 2002:a05:600c:1f10:b0:426:5e8e:aa47 with SMTP id
 5b1f17b1804b1-427dcf69b05mr32388475e9.4.1721607504319; 
 Sun, 21 Jul 2024 17:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVAs5BgjvLYEh0pd5ccwHoeJwA+QVq/mi0TrjT3zQzDHFtsVJSvrjJQivRAc7qy/gvL18oVw==
X-Received: by 2002:a05:600c:1f10:b0:426:5e8e:aa47 with SMTP id
 5b1f17b1804b1-427dcf69b05mr32388205e9.4.1721607503800; 
 Sun, 21 Jul 2024 17:18:23 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa9b1sm107760615e9.8.2024.07.21.17.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:23 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Xianglai Li <lixianglai@loongson.cn>,
 Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 43/63] physmem: Add helper function to destroy CPU AddressSpace
Message-ID: <3ef94482c9e3e996eb5ed1ab3ec829885dc50d7f.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
involves destruction of the CPU AddressSpace. Add common function to help
destroy the CPU AddressSpace.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-7-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/cpu-common.h |  8 ++++++++
 include/hw/core/cpu.h     |  1 +
 system/physmem.c          | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 815342d043..240ee04369 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -129,6 +129,14 @@ size_t qemu_ram_pagesize_largest(void);
  */
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr);
+/**
+ * cpu_address_space_destroy:
+ * @cpu: CPU for which address space needs to be destroyed
+ * @asidx: integer index of this address space
+ *
+ * Note that with KVM only one address space is supported.
+ */
+void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d946161717..1c9c775df6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -496,6 +496,7 @@ struct CPUState {
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     struct CPUAddressSpace *cpu_ases;
+    int cpu_ases_count;
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
diff --git a/system/physmem.c b/system/physmem.c
index 9a3b3a7636..0e19186e1b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -763,6 +763,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+        cpu->cpu_ases_count = cpu->num_ases;
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -776,6 +777,34 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 }
 
+void cpu_address_space_destroy(CPUState *cpu, int asidx)
+{
+    CPUAddressSpace *cpuas;
+
+    assert(cpu->cpu_ases);
+    assert(asidx >= 0 && asidx < cpu->num_ases);
+    /* KVM cannot currently support multiple address spaces. */
+    assert(asidx == 0 || !kvm_enabled());
+
+    cpuas = &cpu->cpu_ases[asidx];
+    if (tcg_enabled()) {
+        memory_listener_unregister(&cpuas->tcg_as_listener);
+    }
+
+    address_space_destroy(cpuas->as);
+    g_free_rcu(cpuas->as, rcu);
+
+    if (asidx == 0) {
+        /* reset the convenience alias for address space 0 */
+        cpu->as = NULL;
+    }
+
+    if (--cpu->cpu_ases_count == 0) {
+        g_free(cpu->cpu_ases);
+        cpu->cpu_ases = NULL;
+    }
+}
+
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
 {
     /* Return the AddressSpace corresponding to the specified index */
-- 
MST


