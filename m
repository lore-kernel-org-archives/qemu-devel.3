Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330F4E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGx-0004jb-SJ; Thu, 19 Dec 2024 11:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiW-000395-3s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiU-0002MA-Ia
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QndkQAdv+aZOEQr2b2o41BTTLOjnawhbhJJcyyz1yzo=;
 b=fboTz2aKOBPFD893G/856eT/1ehnF9yoXSpVF6Vzslw0WY/pzm1nxRNUitTbr0qAG3qNRI
 vtmilJ6tSr/waVA7L7Z7TqcVnjKPV6+viQxWlixurICeBu/Pye+jsM4kDkIc1Ii4EyKe7Y
 cemAfJDL3YhEIpVRVv+euieLggqpJNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Q3qhqaLkP5-8ywzxRwBnwg-1; Thu, 19 Dec 2024 09:41:23 -0500
X-MC-Unique: Q3qhqaLkP5-8ywzxRwBnwg-1
X-Mimecast-MFC-AGG-ID: Q3qhqaLkP5-8ywzxRwBnwg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so5411305e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619282; x=1735224082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QndkQAdv+aZOEQr2b2o41BTTLOjnawhbhJJcyyz1yzo=;
 b=CuG7UfZHmA/LdYlQOAStksFpmCSdCZYY7HM1w/N6gNYf+Aa6puJfj6KLIXxvCZjElG
 AwvPusoJo6QoIGqLbaUlUvKX0nyasI2aU8fFEwtMeTplKwXSxIq6TozoYjHGQ9TU6IVJ
 rcroDvh9I10p+uyv8X6iTa9qA0+eGVUxnMJE+D2CWa/gE+n9B9nBOIPVRWIIgVrxqYIO
 wwKYzOYUskZshpUegPOelvsA6R5Ny2c/lTuDJB4ikFNU4BPq58gi2yqvRngmCU38z7gq
 JflTlhfEg1stCTAr5UTfU4aZT2AVTbNZo0VHKn5IE9ppC+92qKq3Gcx8EqsusEf5Gga3
 AhyA==
X-Gm-Message-State: AOJu0YyqOCz0cA2ZE+GruLLJQ9hw0fMxMMPzokig0zWDEFMoY7S1TCGC
 e/xn1erD6xQVcmyyHzcLuIKfp866LjPS9/hEg58+utx3THpKdHthpuvmeU8IPnHbTDWVbQ2r3cp
 0dej5gNBXiGSQ9O3Quh/F9iM4lTZ3RCSEqlQ9+c5jJBP429/x9o4GWyS0cOTKQz+Fj/+a47pHjA
 /afixStJL//+mKI9WDNh2TCSnhy0813KARf+Q=
X-Gm-Gg: ASbGnctlpgxoAcFvyBvdCCZBWaThr0dvZhwVJGtxJsu6G1GMagBr6JMSys5iMOg+o1L
 SXBk9OZLkXFKJmAgiQEZPtkzLQiZ3afIpBT6R2sRYygTk7PQtIwkvbbG8Su6LbIqszzxaMQltYV
 u7Emxd6Qu+Wbt32/id8g1YSvx7BNB+g1RKOAuFS0xjCNLbgqhdjhqUmwG+Ikkb1+RnFYCB0sfls
 3xlTiLy3hlAxMFfrDEoMci+ENgnh6W4RNny1aQjoiHDt8e/PNbaN8K9ojdorTo4W2RCMsTYgCx3
 DtXHvkdI+3n41QwFRRQaMvyyhBenPbpT2vcLNoRz
X-Received: by 2002:a05:6000:154c:b0:385:decf:52bc with SMTP id
 ffacd0b85a97d-38a19b1680cmr3294883f8f.32.1734619281825; 
 Thu, 19 Dec 2024 06:41:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6aZO+nDAEA5YjakspU6Sj9NKtxSKEoLpfxqN6jXjYOygAUX94hJOesqUsED3r3p+eGw93Og==
X-Received: by 2002:a05:6000:154c:b0:385:decf:52bc with SMTP id
 ffacd0b85a97d-38a19b1680cmr3294845f8f.32.1734619281426; 
 Thu, 19 Dec 2024 06:41:21 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b11aecsm53403925e9.23.2024.12.19.06.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:20 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/14] s390x/s390-virtio-ccw: don't crash on weird RAM sizes
Date: Thu, 19 Dec 2024 15:41:02 +0100
Message-ID: <20241219144115.2820241-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

KVM is not happy when starting a VM with weird RAM sizes:

  # qemu-system-s390x --enable-kvm --nographic -m 1234K
  qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION
    failed, slot=0, start=0x0, size=0x244000: Invalid argument
  kvm_set_phys_mem: error registering slot: Invalid argument
  Aborted (core dumped)

Let's handle that in a better way by rejecting such weird RAM sizes
right from the start:

  # qemu-system-s390x --enable-kvm --nographic -m 1234K
  qemu-system-s390x: ram size must be multiples of 1 MiB

Message-ID: <20241008105455.2302628-2-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 67ae34aead..f2a17ecace 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -180,6 +180,17 @@ static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem = get_system_memory();
 
+    if (!QEMU_IS_ALIGNED(memory_region_size(ram), 1 * MiB)) {
+        /*
+         * SCLP cannot possibly expose smaller granularity right now and KVM
+         * cannot handle smaller granularity. As we don't support NUMA, the
+         * region size directly corresponds to machine->ram_size, and the region
+         * is a single RAM memory region.
+         */
+        error_report("ram size must be multiples of 1 MiB");
+        exit(EXIT_FAILURE);
+    }
+
     /* allocate RAM for core */
     memory_region_add_subregion(sysmem, 0, ram);
 
-- 
2.47.1


