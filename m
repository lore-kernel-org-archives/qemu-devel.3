Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3834DC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKty6-0004cs-Pl; Fri, 30 May 2025 03:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx2-0002sN-3x
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx0-00070B-Ib
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtjtyiGUQyegn1vBqOHyPoYR0tR2vu4Qq0YAIOE+sa8=;
 b=Kor52M3zw/Og8i8A7JnCyLGfEtZePxkyOoG72uAHVohNaxEKw75vI3Gfqv3njrVXxhWEol
 BgMOmAaoEK0zBOXzFNCuklk/v9SM0/RYhmm2DrZRa1RrqEa6uNazUZIZkf0aYSW4ZOthz5
 XEO6jxr4DNqoU6N4m+z4v+6lGtkZ95U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-s0yAQ31FPF-Av8K7Hus_Fw-1; Fri, 30 May 2025 03:14:44 -0400
X-MC-Unique: s0yAQ31FPF-Av8K7Hus_Fw-1
X-Mimecast-MFC-AGG-ID: s0yAQ31FPF-Av8K7Hus_Fw_1748589283
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so177934966b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589282; x=1749194082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtjtyiGUQyegn1vBqOHyPoYR0tR2vu4Qq0YAIOE+sa8=;
 b=Pq6qnNHkARTW/YlYtoo1gOHbo2dOCUQOCcji5xpe9IsBRttRJSLU2qcwnR5nnNF81z
 vPjNBwJvTA4B7y7I0B9ojGh4IFgG/LJSGHn2nEcLfxHAoK89YoBoVaN1Qk1k1UvQoXfo
 a1Dlu7dXlunhfq8wc8mXKHcJb9lqWVKooHsk6EBc6siBPsoHaRhXHDyAIFF2393ilYJ1
 i74Rna/byq/iYPqxPD3gxfEFhQr73O7OQHQyztvHGRB/76lbgr3/hrCf4eI2GA5Uacwq
 6aB7TztRNCiwy6ojyV8JzUXXItN1MvASr4rZnzzoDXSWlmhXWAAR8k+7NQqkGvZt1aee
 1fvQ==
X-Gm-Message-State: AOJu0Yw9lGyn2PAhKGYMuInbNhElP3X2PJioV1cr4KCZ3YTeF6gpZK9J
 rbKCDgOLaORg/+DCyI/Maz/vG6Efmlco5FdJpPMvCXQXVJM5830iplqzCqkBYZoBOvcS/eWawcV
 pnhSyPYTfYLhUYbTegQjaZLQXnYagUMUKB/EhP5EtaELwj8n62K6oZ9TRbCPzJ7MWEpYeacc1IG
 Y1+Ka8H2rhf2TaXdvFwrEVXCgl2J7vmQ/xvlhjGKTy
X-Gm-Gg: ASbGncuAZe8Thc0UyU1pOE8BMhE3nDr5Js93fnVqGsI0rkGMvDQJ8SVGIFQ5XAq5f3H
 JoN8wfats5RaXIdzEz81fJ5vYulSO24MvfegN4SVmQ+VVasCF5wKn6pW+rsfpnLyo3R1c9mnk+I
 m9B6Xq4+MZQZnsDzD3P7ZrTUyBUe5q0Md77eN2JqYvvaXZYEOVYTuhRhtewBFfhUZ61fYR3sVg0
 Insuro12cwL04gT52rfWXmWAXtpZt60I8KL7JGmizJuMRMvX+w0BOoWGm/OLlHFvycB1qVg8Yd9
 fVyTkNniR5nc0A==
X-Received: by 2002:a17:907:9691:b0:ad9:db54:ba40 with SMTP id
 a640c23a62f3a-adb322a3634mr219350566b.32.1748589282412; 
 Fri, 30 May 2025 00:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEgwxKO/uDBT2hnXDqfMTETHdI+73aw/G9FVM6AWn4tkqKmKrza71M8YRF9nI/lcFhSiVSDA==
X-Received: by 2002:a17:907:9691:b0:ad9:db54:ba40 with SMTP id
 a640c23a62f3a-adb322a3634mr219347666b.32.1748589281961; 
 Fri, 30 May 2025 00:14:41 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84f9e0sm275402966b.85.2025.05.30.00.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 44/77] i386/tdx: implement tdx_cpu_instance_init()
Date: Fri, 30 May 2025 09:12:14 +0200
Message-ID: <20250530071250.2050910-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Currently, pmu is not supported for TDX by KVM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-33-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index ae3740a2305..7c5e59c5591 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -398,6 +398,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
+static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
+{
+    object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -791,4 +796,5 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
+    x86_klass->cpu_instance_init = tdx_cpu_instance_init;
 }
-- 
2.49.0


