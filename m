Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4A2C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwS-0001lX-Bs; Fri, 30 May 2025 03:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwH-0001QE-64
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwF-0006vS-EK
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9xJhpuzXINKl3LZpWge4QLi33eUyTvHiKnQt0qRGfg=;
 b=F9WBJig1yOWveqv0QFPEsnD85hRwN7Uaz39SBp3xfHbQ9Gc/L/npqfqLIWDqHMJQSBXEF0
 tcsqvZSLAEJlII78nyMQpWzwT92WFm05LRDerX1Vo8+aAjhn4ppGrBBaURxy9Oo59uhvQy
 1DO/5I7zEKR3j4vfpAuY2Bwie1vpRgU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-2WXk8fS0PoaNExRkv6Yigg-1; Fri, 30 May 2025 03:13:57 -0400
X-MC-Unique: 2WXk8fS0PoaNExRkv6Yigg-1
X-Mimecast-MFC-AGG-ID: 2WXk8fS0PoaNExRkv6Yigg_1748589236
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so176600466b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589236; x=1749194036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9xJhpuzXINKl3LZpWge4QLi33eUyTvHiKnQt0qRGfg=;
 b=iSg874SVUakl3HLI1O0CHryink99O/0+fhqPHEWqV5GP4xKCI0CKB+9ZFpHOht+Bvj
 ww8hqV3fVU/ELNwJ7kDSyoXvFXbYtbFolAeS4l9xuQIo4MCWMuHJPRQ+qqgCb5sld/GA
 5819U0fe+FBpyMJsf0b3oJdJ1GV6i6GH0mXGsz4xdhRf92HgWNEEpOMy3r6tgHt1c2l7
 IoAGbvcqH34OUdG23QysJnVd1jvyoyaWuiRKnrJ2xjtvNH1cXXZs2xGygspJX/oCpzxO
 WzZZ/C08nh2oMQWgRxnvqHSb7T//N9dgx613QoNfuV4GgpBXBnijzpMCELhjmAvRe/a1
 euxQ==
X-Gm-Message-State: AOJu0YwUtS8qJWUkgeYNQPD5vAIyG7TZ4ZbjaW6zFPPaFLaH4h89WJk9
 gipfxx8bfKpPTdww3r1wBB/jEIIIbUCmRKAz4kMWzj8B29fEhX+oSI4/K7HF0hcd8cJ4lbEG6jK
 Wwfhl10ySAXyLH2oPrKJPSlMfutgcza0UU6t1NDi9YFZ4IA2AiwtiVrc2INaa0IETkvg0mx+GmT
 F5326NgN0LBu3VgoodKXBZTj000hq2IZEIsI+qp5rf
X-Gm-Gg: ASbGncvUuCZzTAtO0Zw41UE6H/qF1tmc3qVdzJjMqt4CE8W6pd5aZu61mLee8dPB6Nw
 O/vmdFMAoBKq2IQ1EdMmJvnJHzmeNoe4wdrVB+DDeBaIXmrJAOxGG6botXyRcJv6qgBoK9HI4fA
 9NThv129d1fnQyopGggkTjQv3CWHYIHiKc3ffoUjkMKqOvTNK4zVZNEdkWwGjI5OPsvGNmQbHDI
 8uJJQKSGq3AQ9wuMuY3BcSSCgyFs5UuGyWu4v1j5J6nIvx3XP9kJHDCUXYnmtBkC6H9x/ih+mDD
 NOIyUWVLtvkWRw==
X-Received: by 2002:a17:906:c143:b0:ad8:9428:6a3b with SMTP id
 a640c23a62f3a-adb36b05316mr105412466b.5.1748589235735; 
 Fri, 30 May 2025 00:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDU/OvWQ+LeP/oaX6fosAlEG6akHJT5Aiv9+wMCyGhbG7aJsJA9LXFjewVZkjQYwcMu/xRGA==
X-Received: by 2002:a17:906:c143:b0:ad8:9428:6a3b with SMTP id
 a640c23a62f3a-adb36b05316mr105409966b.5.1748589235358; 
 Fri, 30 May 2025 00:13:55 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb318db274sm119163566b.162.2025.05.30.00.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 26/77] i386/tdx: Set APIC bus rate to match with what TDX
 module enforces
Date: Fri, 30 May 2025 09:11:56 +0200
Message-ID: <20250530071250.2050910-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

TDX advertises core crystal clock with cpuid[0x15] as 25MHz for TD
guests and it's unchangeable from VMM. As a result, TDX guest reads
the APIC timer at the same frequency, 25MHz.

While KVM's default emulated frequency for APIC bus is 1GHz, set the
APIC bus rate to match with TDX explicitly to ensure KVM provide correct
emulated APIC timer for TD guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-15-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h |  3 +++
 target/i386/kvm/tdx.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index e472b11fb0d..d39e733d9fc 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -16,6 +16,9 @@ typedef struct TdxGuestClass {
     X86ConfidentialGuestClass parent_class;
 } TdxGuestClass;
 
+/* TDX requires bus frequency 25MHz */
+#define TDX_APIC_BUS_CYCLES_NS 40
+
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 671f23d910a..58983edd80a 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -254,6 +254,19 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+    if (!kvm_check_extension(kvm_state, KVM_CAP_X86_APIC_BUS_CYCLES_NS)) {
+        error_setg(errp, "KVM doesn't support KVM_CAP_X86_APIC_BUS_CYCLES_NS");
+        return -EOPNOTSUPP;
+    }
+
+    r = kvm_vm_enable_cap(kvm_state, KVM_CAP_X86_APIC_BUS_CYCLES_NS,
+                          0, TDX_APIC_BUS_CYCLES_NS);
+    if (r < 0) {
+        error_setg_errno(errp, -r,
+                         "Unable to set core crystal clock frequency to 25MHz");
+        return r;
+    }
+
     if (tdx_guest->mrconfigid) {
         g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
                               strlen(tdx_guest->mrconfigid), &data_len, errp);
-- 
2.49.0


