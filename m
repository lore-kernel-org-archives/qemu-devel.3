Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DBAC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoO-0006jZ-1t; Fri, 20 Jun 2025 12:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoL-0006eI-RG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoK-0000KY-9W
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AC4zT8sWe4ssqB8c1y68D3S1OxvabGsR5nhiZP73ISE=;
 b=iSxheyQEXQxQm1pv42wtMHdtFtKMfyh3e+9+VFg5wRqSUQchcy7Rq8Dgr8qr4XIEDyH2Xv
 lmkr4C4uhTlPj5QZyPuBnf4henaBmrmaLwnJSrgtFW7Z+iCNEdFhbUUeWOQTQAb1EObM63
 /LJyIz2q1dxDLJs4XCjrQwWOBaHOGSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-D2R1i0VeO_K8s1D7e4btcA-1; Fri, 20 Jun 2025 12:41:49 -0400
X-MC-Unique: D2R1i0VeO_K8s1D7e4btcA-1
X-Mimecast-MFC-AGG-ID: D2R1i0VeO_K8s1D7e4btcA_1750437708
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad89a3bcc62so152242566b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437708; x=1751042508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AC4zT8sWe4ssqB8c1y68D3S1OxvabGsR5nhiZP73ISE=;
 b=NXJFP2irmq3KOHpcSgZypseH55UCVol8rvTLDKAoi4DF8/FBvC7LSV24iWT3//LCUo
 6VKscOLpQbheDk8oHUfl3Vn3qXKTSieegOEaMochCZCHDZ8TCG5JpLdlQONvtWPV/yol
 h0Geh3L7Aw8Khi0A8d5YOVoEfElmXSCt4Yb+ematEQjSWgc2/8wDFUILyze3UAxfzrR7
 JNSPFipCfyQbX6rLH5ZLVSC8HxdJCpKCRYelIgPSxLwA1+nJ5Yrlsi4g9hgo8/aM4RoZ
 osBEBWuchg2WhcbRvONhD3bu+TMcgztOphlqzX6cGY7WFDEFRNpfY5tPuzkCHUP51RdE
 qhng==
X-Gm-Message-State: AOJu0Yy/YV0KcIVgIqGtEIcN3G3SheZwnOeTxVkl45ZcKa1AR/eD0rhb
 4Ok6F7N8jFRa4E8WaIBhHmjK41Ouzu9O4bIl9SUGNXXsQ94oMlw7dq5+o6/ha0Vc55vpRtGoyCm
 P1YO8BpF0Pd0xQ85n7rkHiIDQVjDfS02waPPZPH7iCQP4Ft3v1RD9mYfir93uAIE0xjEd6ThqFr
 qkQPaAGnjmZUAT3kjRB8W4y3uR6suLb8Bfzm4Q2C5g
X-Gm-Gg: ASbGncskzjUJpxsN0PpDMxB5fvoCm5MLzys6CbB+U249WTywJOYa2ix6CL3Hcz/R7H0
 HFVvIxMLooRp6Co0MvW6oSmvLySU8LqkN0pY507iUxDtIZtiXiKjXmXb8tTssBVYoT1tlsxBF2P
 RlMeFTHOqvqFVlbeoF3bsd99OjQ/yqxiTY6B+NQOEXTdCcSEl4KN0XWVDUcBS0CxkA2ARKfvkl5
 dcxfPKG1A9QfZ6b3aDWWIRennx50xDT39GeRQDYJtK+NgBk3tOFDnYtTyaQnKCsUTeo6zhiCBN7
 9vcqFLbJhS+fTZwZTtqAiHWF9g==
X-Received: by 2002:a17:907:3c8b:b0:ae0:180b:bb54 with SMTP id
 a640c23a62f3a-ae057a32920mr341122266b.26.1750437707809; 
 Fri, 20 Jun 2025 09:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwHct18rcZGnXx72ZNqidNLlwvFJJpJCCiioBIMlRmeFQjhnl2fUOW7GxEvUH3THIj+/w51w==
X-Received: by 2002:a17:907:3c8b:b0:ae0:180b:bb54 with SMTP id
 a640c23a62f3a-ae057a32920mr341120066b.26.1750437707278; 
 Fri, 20 Jun 2025 09:41:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0543421e9sm185450166b.185.2025.06.20.09.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 19/24] i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
Date: Fri, 20 Jun 2025 18:40:47 +0200
Message-ID: <20250620164053.579416-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The name of "enable_cpuid_0x1f" isn't right to its behavior because the
leaf 0x1f can be enabled even when "enable_cpuid_0x1f" is false.

Rename it to "force_cpuid_0x1f" to better reflect its behavior.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20250603050305.1704586-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 4 ++--
 target/i386/kvm/tdx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5910dcf74d4..51e10139dfd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2269,7 +2269,7 @@ struct ArchCPU {
     bool enable_cpuid_0xb;
 
     /* Force to enable cpuid 0x1f */
-    bool enable_cpuid_0x1f;
+    bool force_cpuid_0x1f;
 
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
@@ -2539,7 +2539,7 @@ void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
-    return cpu->enable_cpuid_0x1f ||
+    return cpu->force_cpuid_0x1f ||
            x86_has_extended_topo(cpu->env.avail_cpu_topo);
 }
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 2b52de9d71b..acbe7497543 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -752,7 +752,7 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
     /* invtsc is fixed1 for TD guest */
     object_property_set_bool(OBJECT(cpu), "invtsc", true, &error_abort);
 
-    x86cpu->enable_cpuid_0x1f = true;
+    x86cpu->force_cpuid_0x1f = true;
 }
 
 static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
-- 
2.49.0


