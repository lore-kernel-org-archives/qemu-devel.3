Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA4C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKty2-0004ZP-E5; Fri, 30 May 2025 03:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx8-00033L-2H
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx6-00070d-Aq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmrfjHuadJffKlB3WUc28akcDQBFWMBFqmg2KxsvDI8=;
 b=D3anL0PA7UtQwObpvLG0CS6cybpIEVbeE3Eppz+8qUJNKzkd3uj10kAzJx+PBf2EFOg2HQ
 1q0jSO33AtQt89D1/HDQF+As2XPZ/c+nFCJSjj28X5H76aRVI/Y9GqgKcNjYjGAdFv3Xyh
 mxfpFffuigiS0PymWW6Poisn42t3Luk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-HHuqoBL6Mt2Fp7z2qqpjJA-1; Fri, 30 May 2025 03:14:49 -0400
X-MC-Unique: HHuqoBL6Mt2Fp7z2qqpjJA-1
X-Mimecast-MFC-AGG-ID: HHuqoBL6Mt2Fp7z2qqpjJA_1748589288
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad89c32a8a6so161715166b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589287; x=1749194087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmrfjHuadJffKlB3WUc28akcDQBFWMBFqmg2KxsvDI8=;
 b=qwxG6zMdz1aycSMJRdnxF8MR3Hq2Idv5C/nhAQ32I/QXq+Y+Xiiny11SGMOiWTvqzt
 a0l6E5vW6aOAMRRjPplM4DxJJJtitt70Uw1krVjj+7usAy6SAmyhvO8NcYpX3Llb29Mz
 +Xw9Lr9b+h+Sq86Uy0jIOKMuI2Brlz7AsKsaeGPXSYfdcnN5nYcEbFkAuCb9Pq6NMXRp
 +O//iqLQvIQvADDOkGhpItzw1W8lkvYGZ0+cvHc84Nk/hVgJCFAZjOJy56gHRQ7czhpD
 cZ3gSSsmbzwzWpEp0Zu1PGWqnWL0PRQGTvOJvwMpaZ3rGd11oRncTZn09X6b0xIqqbfR
 ISXg==
X-Gm-Message-State: AOJu0Yy7+Jg4d+yW3XVWPfiPSp6X/1zJA30GSEiDjnRY0Cf0cbNYkBaI
 4UppvjWZgo6/BKEiB5CZDlywugtenhquqkH3jvZPJpssVFN0QmCRC1MqnrxswJaYfatZHrcFKsc
 GJkuG4Op1z71J3cvxfHy5I5FOhPPQJUN9KRu2tOXs5Iq9kzwz41QDkCOLJuHu+5bEL5ITsuk8j5
 zpfwpZ0GTMFCz45lkzXtf0DyHo2oso0oRvZqPczmw9
X-Gm-Gg: ASbGnctC2I/V/xBXArGZ49z+kLAc8D/p5iVRTruaDTxJIRbVyUdTqbFk6g7PfOyfDKV
 mhZr53J0quop9465CnqkCnHQeDZ4TYpaamxkDirw289I3vg+lJeH9Iu1jHgqh9VNvRik/NHvdZI
 fz0IrnOwHqQJBbT4ry8FEgGQoEabjwkaIounJViJnRDII/gO9c2X27T6baOYxPr3rg8I3ITfB2V
 PaSBmPrq0Vh+pU7Pa3XTG5ILK84hqflrf1lhZ3bVbwqRgiIFyLjBBawXFEecVHG5eiok7QFNIpT
 zyEhqsO2u7AR1A==
X-Received: by 2002:a17:907:7ea4:b0:ad8:9909:20a3 with SMTP id
 a640c23a62f3a-adb3242f4f0mr201360966b.43.1748589287471; 
 Fri, 30 May 2025 00:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq+Bn/AxoOTQylFdy5QiEyhYOeSYXC+FgyROa8mwLp7RFDG/d1kLHxEp2gytfxVxmJacp6xQ==
X-Received: by 2002:a17:907:7ea4:b0:ad8:9909:20a3 with SMTP id
 a640c23a62f3a-adb3242f4f0mr201359066b.43.1748589287018; 
 Fri, 30 May 2025 00:14:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e2bf045sm277803266b.108.2025.05.30.00.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 46/77] i386/tdx: Force exposing CPUID 0x1f
Date: Fri, 30 May 2025 09:12:16 +0200
Message-ID: <20250530071250.2050910-47-pbonzini@redhat.com>
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

TDX uses CPUID 0x1f to configure TD guest's CPU topology. So set
enable_cpuid_0x1f for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-35-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7c5e59c5591..accaefb4011 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -400,7 +400,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
 
 static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
 {
+    X86CPU *x86cpu = X86_CPU(cpu);
+
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
+
+    x86cpu->enable_cpuid_0x1f = true;
 }
 
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
-- 
2.49.0


