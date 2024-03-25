Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE49CD11BF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol74-0007RG-Jd; Mon, 25 Mar 2024 10:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rol62-0005zJ-FH
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rol5x-00063P-R6
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711376076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebzzU7+FgjLZ8foVmeJq7+HKdxOVxgOyjXN239nNlw8=;
 b=SgGAEzDryyGd2NJrMsegdpEoiQ5T8hGlPv6wWHAFFtehR3zKgZvrTSvYhZNUepnuu53J9l
 yOzc90vcicxiX8FajC0rBwzZsk8dDhIBwuxF2oZMYf1rvxttn+oWiuyp7TbCZildIJhs0J
 aqGebIrp5WeE+pOEKuHVERte/MjV8po=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-NRHeQGRjNqiqlOovZOLWRA-1; Mon, 25 Mar 2024 10:14:35 -0400
X-MC-Unique: NRHeQGRjNqiqlOovZOLWRA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a473ac9d263so222253266b.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711376072; x=1711980872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebzzU7+FgjLZ8foVmeJq7+HKdxOVxgOyjXN239nNlw8=;
 b=I8OKfHewi8SLOT7rIx/Ah4axmXMVtpiUuedP+95xSm9CQ3IbcfVmNAQiT2OXc7idIg
 7qneRiBBnGHsBT80oGJb0LPkSwJJBggC3Dtpc67tsO+JcDBMBPMumfNkzPwunr1bQut9
 YPj0ikZrugNyPJywI+xI0gi9VvXMia+9r5zgXZ8ZZK4Bapl2VN0nrZKaQk3vtwUBGWwA
 Y8xSNjhLStc6MHnZO9T/qL+Mv0UVw1u8AGZthZ1s7v01qY0UNHvDR8CvEfVXqVHYYzYS
 kIX5yGsJlriOUUzxPwyKr3EW1clN8b8lePS/lyYMAl3lH62UljbIc2WjRWh0jEpcF0Ru
 ZlXA==
X-Gm-Message-State: AOJu0YyWcEQhsKvY2BrVw9JkkBzwo/HMZeXglbYlRx4xMSwCA6Q+QgV7
 C/teW/QXIdrJiT+d37F/QpaRfm3HK6hvwSIVD/qO6Tuura4irkAKMX5P780JRxdr5coC+fwogGy
 HebkH/rrfr/jZJAE4z0gRdwTkjdVNpAwiDNgf3e6uUsL3pzsoO3TF4cUGWG8eCpDFFYypvXZpQ/
 VoOMqJARkqka1mu+UXYEaj7fWuaAWpSx/tNMTI
X-Received: by 2002:a17:906:7d51:b0:a45:f352:73b0 with SMTP id
 l17-20020a1709067d5100b00a45f35273b0mr5240569ejp.65.1711376072328; 
 Mon, 25 Mar 2024 07:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3UFOtJKt83FgFLS3Tys3E7nFkpGNeVHrBg8PhI2qOF+H6pvDdGUn5mi/CqA4p1eEYnsAtmQ==
X-Received: by 2002:a17:906:7d51:b0:a45:f352:73b0 with SMTP id
 l17-20020a1709067d5100b00a45f35273b0mr5240550ejp.65.1711376071947; 
 Mon, 25 Mar 2024 07:14:31 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 dk5-20020a170907940500b00a4750b2e0f0sm1919391ejc.164.2024.03.25.07.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 07:14:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH for-9.1 v5 3/3] kvm: add support for guest physical bits
Date: Mon, 25 Mar 2024 15:14:22 +0100
Message-ID: <20240325141422.1380087-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325141422.1380087-1-pbonzini@redhat.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Query kvm for supported guest physical address bits, in cpuid
function 80000008, eax[23:16].  Usually this is identical to host
physical address bits.  With NPT or EPT being used this might be
restricted to 48 (max 4-level paging address space size) even if
the host cpu supports more physical address bits.

When set pass this to the guest, using cpuid too.  Guest firmware
can use this to figure how big the usable guest physical address
space is, so PCI bar mapping are actually reachable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240318155336.156197-2-kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v4->v5:
- only call new function if cpu->guest_phys_bits == -1
- guard more precisely the upper bound of cpu->guest_phys_bits

 target/i386/kvm/kvm-cpu.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c791b7b052..e6b7a46743b 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -18,10 +18,32 @@
 #include "kvm_i386.h"
 #include "hw/core/accel-cpu.h"
 
+static void kvm_set_guest_phys_bits(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    uint32_t eax, guest_phys_bits;
+
+    eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x80000008, 0, R_EAX);
+    guest_phys_bits = (eax >> 16) & 0xff;
+    if (!guest_phys_bits) {
+        return;
+    }
+    cpu->guest_phys_bits = guest_phys_bits;
+    if (cpu->guest_phys_bits > cpu->phys_bits) {
+        cpu->guest_phys_bits = cpu->phys_bits;
+    }
+
+    if (cpu->host_phys_bits && cpu->host_phys_bits_limit &&
+        cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
+        cpu->guest_phys_bits = cpu->host_phys_bits_limit;
+    }
+}
+
 static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    bool ret;
 
     /*
      * The realize order is important, since x86_cpu_realize() checks if
@@ -50,7 +72,17 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
                                                    MSR_IA32_UCODE_REV);
         }
     }
-    return host_cpu_realizefn(cs, errp);
+    ret = host_cpu_realizefn(cs, errp);
+    if (!ret) {
+        return ret;
+    }
+
+    if ((env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) &&
+        cpu->guest_phys_bits == -1) {
+        kvm_set_guest_phys_bits(cs);
+    }
+
+    return true;
 }
 
 static bool lmce_supported(void)
-- 
2.44.0


