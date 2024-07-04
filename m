Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1626FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEu-0007Cm-Md; Thu, 04 Jul 2024 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEr-000784-EF
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEp-00089a-Tp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YNBGwi/blnINBXAKV0uUkbw1rjgQvKXb4SGyR3x4F4=;
 b=iHDadlmrjbUdMSnltO9MtNhtpFdZKNFdZn8m6knaaKkjB+AlXM1kg60vr0mbqfBamovniY
 C8Bu3iNNkg3taMxMhwafXM9Wyn/3Pvl7brsbe6Iiaoco6w0fuUxgtG7TdHBlXPdsS1qO3c
 AtMYcY7xdAohbG/3P0WWyRPW9XfUqRc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-VhyKXNYVOwuQhCBSBTcTPw-1; Thu, 04 Jul 2024 05:58:46 -0400
X-MC-Unique: VhyKXNYVOwuQhCBSBTcTPw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ee45dea727so5316061fa.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087124; x=1720691924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YNBGwi/blnINBXAKV0uUkbw1rjgQvKXb4SGyR3x4F4=;
 b=ajdvJQ6J+zdTdhg23pVWIPSelOoKKlUg29YqO57wIm0mQzXHBx7WyZKzhiBTIb3t2n
 v8s6TXU4pzxorbgU3+eOJitYyjPnIFjzQ2Jih8I/sru2Xz061xQ/T7F6Gijcm6/Aavy2
 zNk/bLjZpSTxCBReZPyuitfPQuOJtw2saFAY+X9TLb8YhQItOJZj5RrKLepY32TNU2k4
 25SqMA+Iuj8pcuZ3zt6tFoDiA1Ph+OvYUJTXO9mLPzhlgxzV+Ck4KjdocZY5OtvfWOAA
 w64oL1LGncJL0b/XLyEba8eyxppYU+zBATqXm71EYwsQ3jAhdbhcGaQDquMa4d7d0hoD
 ecHA==
X-Gm-Message-State: AOJu0YxQeKc5aryteQa0ljDc77XIU98C92rr/9xabOfVRHPd9nc1mZPE
 p83buCEQX/CN8shzPnmYhMVKEEVtgiISjYBMkerl6zXpAqYQcWi0RNFGL2SCqNQ0ljuW7JHnpdl
 0sPFh/ZypQDE5n/6Q60LD7OJrzlnz5UeHgZCkAPHNj83lLbWP7bhcKF0GV9wG3VElC0FU8uIP9i
 ag/kS6nZkPyhfSlVwXkUXrkeXNP9+NMa88kTbn
X-Received: by 2002:a2e:a312:0:b0:2ec:54ec:173d with SMTP id
 38308e7fff4ca-2ee8eda7119mr8166341fa.27.1720087124426; 
 Thu, 04 Jul 2024 02:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDiga0/GUfD4Rgrx8+CnT1PyHAG6o5mf302odZeu+v/p+zB4VAkIC6VzT4yxXetWBxXcrRSQ==
X-Received: by 2002:a2e:a312:0:b0:2ec:54ec:173d with SMTP id
 38308e7fff4ca-2ee8eda7119mr8165661fa.27.1720087121932; 
 Thu, 04 Jul 2024 02:58:41 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm17347975e9.32.2024.07.04.02.58.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] target/i386: add support for masking CPUID features in
 confidential guests
Date: Thu,  4 Jul 2024 11:58:05 +0200
Message-ID: <20240704095806.1780273-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
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
 target/i386/kvm/kvm.c            |  5 +++++
 2 files changed, 29 insertions(+)

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


