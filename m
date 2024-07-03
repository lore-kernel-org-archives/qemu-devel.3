Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAD1C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxkG-0000wO-MN; Wed, 03 Jul 2024 07:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxkE-0000rv-NF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxkB-0003iQ-IF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720004504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpIysTSdh8B/Y+y+Q2OwUtr8eWU5XNjPnxSxI1PSbhc=;
 b=V/E1zH5HqYfq23pOCxq678s4Mb/cwBm3SOKZ5j3IdoO5p6Y42EjTTC8tZ9ish4vZ991Fhn
 NofGXTQ39ugEfhaOyLw/HeAHFRLsl+Gd+GsiYpW56fiOEnqxviUUT0WRtZZExSqHdATu3V
 X084lP4pXxz9vwbB8vEJJcHCRJUxbVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-qAUCz_88PruHRZ_q3Ynmsg-1; Wed, 03 Jul 2024 07:01:42 -0400
X-MC-Unique: qAUCz_88PruHRZ_q3Ynmsg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso23720345e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 04:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720004500; x=1720609300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpIysTSdh8B/Y+y+Q2OwUtr8eWU5XNjPnxSxI1PSbhc=;
 b=uZBhuWKCfg4eNzdwXkWQ5AuYWcY1RrMN20hSr0GyUeSY4zHbd7eFg5q//r81W+xsdb
 MzVH8arS7EU0qttImvX342VzxcuDorujbB6JPk8oDzdRgR4ESMmiZSMkzrvdn6qs86ef
 4m4uDEFpJdryN4UJnPYipnj0LTLmsIMujl83V1azBWiaCagzyLrcWlI0hHxwATqPOq2F
 A468T9PNroyhz/yz2SOvhoLTOUcDh1RZ7PDcIGU9iKpV9OTIZO8sHuBgH2vLi0nJ4ZY7
 rEIFkfPMvJ/nVSFGEREOaoIa1FQTDyxAuZDwUHUCMp4ZcmPvBX756Wqvk2Da3TgwAbHT
 SHLA==
X-Gm-Message-State: AOJu0YxDLZ3OmNflYpV852ipoPXKFRPgL6zTGSx1eMMXByli+c70qLPB
 BLMYH8uoxz6FttdU1ygXEh6BUQPQ8ggGzVottgUforh75PzBiUHK5aLGsxN/Yq6BE5gK+6FrdkR
 TdEJ7zInmtCyBwzEjd4zi9es8hqE6EqMMO4XHmdQIYbWyHbKAFwpA9cTxjR7CErwbXXsqFwBKF1
 QHRBIwcpuoWVkkNVdw6rBPPwte1XmwFI9Opx72
X-Received: by 2002:a05:600c:4fc5:b0:425:73a8:2fa3 with SMTP id
 5b1f17b1804b1-4257a04fe4emr68536235e9.30.1720004500044; 
 Wed, 03 Jul 2024 04:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8M6Ll8xZf5b1S/x9uPIecJp/J5MAA53yE1gyb1rsoqKUEba/weg/V4byMbHtYu5pq6ER07Q==
X-Received: by 2002:a05:600c:4fc5:b0:425:73a8:2fa3 with SMTP id
 5b1f17b1804b1-4257a04fe4emr68535995e9.30.1720004499604; 
 Wed, 03 Jul 2024 04:01:39 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c2afsm237886785e9.2.2024.07.03.04.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 04:01:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	zixchen@redhat.com
Subject: [RFC PATCH 1/2] target/i386: add support for masking CPUID features
 in confidential guests
Date: Wed,  3 Jul 2024 13:01:33 +0200
Message-ID: <20240703110134.1645979-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703110134.1645979-1-pbonzini@redhat.com>
References: <20240703110134.1645979-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Some CPUID features may be provided by KVM for some guests, independent of
processor support, for example TSC deadline or TSC adjust.  If these are
not supported by the confidential computing firmware, however, the guest
will fail to start.  Add support for removing unsupported features from
"-cpu host".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 24 ++++++++++++++++++++++++
 target/i386/cpu.c                |  9 +++++++++
 target/i386/kvm/kvm.c            |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 532e172a60b..7342d2843aa 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -39,6 +39,8 @@ struct X86ConfidentialGuestClass {
 
     /* <public> */
     int (*kvm_type)(X86ConfidentialGuest *cg);
+    uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
+                                    int reg, uint32_t value);
 };
 
 /**
@@ -56,4 +58,26 @@ static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
         return 0;
     }
 }
+
+/**
+ * x86_confidential_guest_mask_cpuid_features:
+ *
+ * Removes unsupported features from a confidential guest's CPUID values, returns
+ * the value with the bits removed.  The bits removed should be those that KVM
+ * provides independent of host-supported CPUID features, but are not supported by
+ * the confidential computing firmware.
+ */
+static inline int x86_confidential_guest_mask_cpuid_features(X86ConfidentialGuest *cg,
+                                                             uint32_t feature, uint32_t index,
+                                                             int reg, uint32_t value)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->mask_cpuid_features) {
+        return klass->mask_cpuid_features(cg, feature, index, reg, value);
+    } else {
+        return value;
+    }
+}
+
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index dd8b0f33136..056d117cd11 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -548,6 +548,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         ret |= 1U << KVM_HINTS_REALTIME;
     }
 
+    if (current_machine->cgs) {
+        ret = x86_confidential_guest_mask_cpuid_features(
+            X86_CONFIDENTIAL_GUEST(current_machine->cgs),
+            function, index, reg, ret);
+    }
     return ret;
 }
 
-- 
2.45.2


