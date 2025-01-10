Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DD3E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK3F-0002BZ-Jn; Fri, 10 Jan 2025 13:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2Q-0000IQ-8H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2M-0001AG-KJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nAGqhO6HWRVdOGt5ty+L8yX0pw1om5Lb+vMQSsKXoE=;
 b=KcdVEV5aZXwfOp84gJHqz9JM7EJ02EU573ZYgkWXRDSGEJXKVdgx62qNhsbMzdtVYcSYxz
 Sh68VUrSoIchPTLvCdzqo7UlBEcfFaRK7J4umHoe7fJWnehQ4ejNbqwnBJPkvdgO4L064B
 hEvf346IxFfz8fFCosGABlSpw+LEitE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-GZ2VwdCXMn6-3KNFs-H2Gg-1; Fri, 10 Jan 2025 13:47:12 -0500
X-MC-Unique: GZ2VwdCXMn6-3KNFs-H2Gg-1
X-Mimecast-MFC-AGG-ID: GZ2VwdCXMn6-3KNFs-H2Gg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aaf9d0f4e0eso210605666b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534831; x=1737139631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nAGqhO6HWRVdOGt5ty+L8yX0pw1om5Lb+vMQSsKXoE=;
 b=XiYSoWKnznrZH5vPB8UHD2DP4II9FPLWIam506qZWX5GUlZM/bpAm+7KaFnQ7O0QRF
 Fq4Pp6eevrj+SEbJ4x6vhEahN8NBDtPtgEcGiD7xxVTqGNKc4SunwojwC1PBrdwttna1
 XPN5CmDcJnpvljskp8g6AEbMaMWnxXsz33K1KThkQhzPeFSLzkNvkqHsb86XeQmjHE5N
 RiRlHLzAAxzA4/H6zp1r/GTpwZ+JpQv3Jqxe4L8mSexKeRM2hptfiTk+rtvZjov8FlJJ
 X2dEtJ9Q8FENpqO/yahgdQC+ouqYwvXjpcEm2KHynbhbIAkY22TJmGGq6/N1b8ZcZu7j
 XC/w==
X-Gm-Message-State: AOJu0YwVAKQA2fh3x/PZvBDsWsIMzJsYlneIlWsWklPtMgSV6mzQLSZZ
 MA+Uen1zl6Z2jg4m6c1W3OUeAVRbbiXYQ1LjFitX2k5oxpWVBQcUywI5xu8iFJiVnqfwQsYYtA6
 ZDYyHoYRUYSfwSqamTlAdxV5OFIABuQJsFDnZA48HQ5vhYXEaxc9yuP8Na1UUSWXyVWrU5Lgva5
 bhaz9zMuh+S40iAa3hpkarPDwwFMoLgJhPgoyi17c=
X-Gm-Gg: ASbGncu5Rh7HuC0cv8cHG6XHfCzXOjai9lBEGSdMmIGI36CE4aFtqyV24MOcOQhj5TH
 KI5YIx5wiUh+dYmw37a9by6AAzKhzgvmOh5YS3skzR0Wbgv0FnFhzKBezxBWSM4AOFz45OqLC/0
 gIVyOtGtfNo5W0J+vI2/pDels2lwc6Zdl+a0erigaZ8zCUu2Wk6aX53plvEzoA3EXWX6IMl/glv
 hYcAfj00dEtzNx7Bka0ylHqEUW9O14jkOPBsy+pqfas5+Ii702a+5vWwm4=
X-Received: by 2002:a17:907:1c22:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-ab2abcb0a84mr1205409866b.49.1736534830990; 
 Fri, 10 Jan 2025 10:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHADCMOYKrxysLC1uNIuRomKcWOxr9/vYoKlTm9B1LZIXqHJ0mQw9Q60mIh1cBtA2d3q91x7Q==
X-Received: by 2002:a17:907:1c22:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-ab2abcb0a84mr1205407366b.49.1736534830511; 
 Fri, 10 Jan 2025 10:47:10 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c394sm1932855a12.7.2025.01.10.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zide Chen <zide.chen@intel.com>
Subject: [PULL 21/38] target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
 MSR_KVM_SYSTEM_TIME definitions
Date: Fri, 10 Jan 2025 19:46:02 +0100
Message-ID: <20250110184620.408302-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

These 2 MSRs have been already defined in kvm_para.h (standard-headers/
asm-x86/kvm_para.h).

Remove QEMU local definitions to avoid duplication.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d6fb3bee86d..7870820a2b6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -95,9 +95,6 @@
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
 
-#define MSR_KVM_WALL_CLOCK  0x11
-#define MSR_KVM_SYSTEM_TIME 0x12
-
 /* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
-- 
2.47.1


