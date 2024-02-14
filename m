Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476A4C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDl-0000uH-IC; Wed, 14 Feb 2024 06:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDj-0000rg-TX
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDd-0006qo-QN
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxMN2l27ZlNrqzqAChublXV5BVT305BpADMb7E/hjJc=;
 b=NUWSpy9RD7b6OBKnHhstY0JFklUIAn8MsU9SF9jnmlUXnwcOaUaHPijne9FoD6Zh9sB7by
 xSqUa8QbxeU/X4wL9grP/DQ7CNrfVX0D03wmLvZFCu7vDWT2pHQwKvKs2PamZPiQXsEyoo
 kfqmok2vNwL8Px0lj2AvGCjjUnRxhaE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-WmrEfYtgPvKMVSbVe93-Bg-1; Wed, 14 Feb 2024 06:14:23 -0500
X-MC-Unique: WmrEfYtgPvKMVSbVe93-Bg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so4618068a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909262; x=1708514062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxMN2l27ZlNrqzqAChublXV5BVT305BpADMb7E/hjJc=;
 b=VGY9hOnPttvGtIzg/qo0Iwfn5H7AS+qYDUSDOCkUsWMnqDsFCLMmMmAmhhuPL6A1gO
 Z2vSk0Gt+pHbWQ/Ikt10dKMuNbW39r/6yRRjlUTOIHuyMwrn6VVWPzNbzh/l8/lsjXz/
 CLOsHW+UIh+7Y54S+Rsfqh8wLjC7ltwireuK9yW2tf7KhwjUJyNS8U44ZFW9yfubCyyi
 ih3mCEfpJu6VRUpNaouLf1lKw+rngrtlrLxu+HUCCwaITFeiY8JipD9OPJbOd1B0iN1i
 fUSv+uGWPJR2jqqODJO6HmpespzG5HgryHYLhFWkRFRbFzdjvBhg0aWo26xJFLLGibvv
 hlLg==
X-Gm-Message-State: AOJu0YylbaSwpiAQGaYO9LT/SAR60/0GPYSM8ChkPAGZTuLXMDT8pdGy
 wmmkU7k1p/2wVOk6qgFNffzyjp/t68FGPDg+P4GeGxttQ5CU1EU4rRxOQp1PmkcjP6YZuy8Z7dS
 p0itDjoZ68+siIFXTUUr5z4A1rLH9aAN6JKWFl0fzOQU+14GydcB73WLQP4pc3bE44C0ShkMpBx
 FxGkgxC1APeQS2J8/us1iZVccQ3DUG3w==
X-Received: by 2002:aa7:da0e:0:b0:560:d9d5:7af7 with SMTP id
 r14-20020aa7da0e000000b00560d9d57af7mr1647753eds.10.1707909261942; 
 Wed, 14 Feb 2024 03:14:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvy8bydbyLBiI7ND00c508SS6NxGZxgMTCL8GQaPbuYIBeKvXYhznHlA/3HnX0rB7B+ZDY/w==
X-Received: by 2002:aa7:da0e:0:b0:560:d9d5:7af7 with SMTP id
 r14-20020aa7da0e000000b00560d9d57af7mr1647729eds.10.1707909261625; 
 Wed, 14 Feb 2024 03:14:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVb6JaBbLgJiw0H6Eh7E7ZQxXPj2vRtYO+DIIJMDAi643t1PQLlK8T/Eykkk3LI2qBFHkWMJ3OmaTlJQXh2+8lqC8sj8RFe5XQSo29+9wNBW6PvDekDblkXiXzcW7ewgyNFIZC/YP30j2lAjlRK06cKexbVJAqgYKn5auZkfwLTBLPj9bXQ+2J5FinQawsVZFaFsJhTpaOTEeTXFwYHXAO8XxgQ8UM=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 i23-20020a50d757000000b005621e66c8ddsm708911edj.17.2024.02.14.03.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:20 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 20/60] hw/i386/x86: Fix PIC interrupt handling if APIC is
 globally disabled
Message-ID: <c2e6d7d8e7fc270a90c61944ef36574b1549ddcf.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

QEMU populates the apic_state attribute of x86 CPUs if supported by real
hardware or if SMP is active. When handling interrupts, it just checks whether
apic_state is populated to route the interrupt to the PIC or to the APIC.
However, chapter 10.4.3 of [1] requires that:

  When IA32_APIC_BASE[11] is 0, the processor is functionally equivalent to an
  IA-32 processor without an on-chip APIC.

This means that when apic_state is populated, QEMU needs to check for the
MSR_IA32_APICBASE_ENABLE flag in addition. Implement this which fixes some
real-world BIOSes.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual, Vol. 3A:
    System Programming Guide, Part 1

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240106132546.21248-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/apic.h |  1 +
 hw/i386/x86.c          |  4 ++--
 hw/intc/apic_common.c  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index f6e7489f2d..eb606d6076 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -10,6 +10,7 @@ void apic_deliver_nmi(DeviceState *d);
 int apic_get_interrupt(DeviceState *s);
 int cpu_set_apic_base(DeviceState *s, uint64_t val);
 uint64_t cpu_get_apic_base(DeviceState *s);
+bool cpu_is_apic_enabled(DeviceState *s);
 void cpu_set_apic_tpr(DeviceState *s, uint8_t val);
 uint8_t cpu_get_apic_tpr(DeviceState *s);
 void apic_init_reset(DeviceState *s);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 505f64f89c..684dce90e9 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -520,7 +520,7 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     CPU_FOREACH(cs) {
         X86CPU *cpu = X86_CPU(cs);
 
-        if (cpu->apic_state) {
+        if (cpu_is_apic_enabled(cpu->apic_state)) {
             apic_deliver_nmi(cpu->apic_state);
         } else {
             cpu_interrupt(cs, CPU_INTERRUPT_NMI);
@@ -555,7 +555,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
     X86CPU *cpu = X86_CPU(cs);
 
     trace_x86_pic_interrupt(irq, level);
-    if (cpu->apic_state && !kvm_irqchip_in_kernel() &&
+    if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
         !whpx_apic_in_platform()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 16ab40a35f..d8fc1e2815 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -62,6 +62,19 @@ uint64_t cpu_get_apic_base(DeviceState *dev)
     }
 }
 
+bool cpu_is_apic_enabled(DeviceState *dev)
+{
+    APICCommonState *s;
+
+    if (!dev) {
+        return false;
+    }
+
+    s = APIC_COMMON(dev);
+
+    return s->apicbase & MSR_IA32_APICBASE_ENABLE;
+}
+
 void cpu_set_apic_tpr(DeviceState *dev, uint8_t val)
 {
     APICCommonState *s;
-- 
MST


