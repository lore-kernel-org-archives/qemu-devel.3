Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF23C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHDd-0006Bx-UU; Mon, 14 Jul 2025 07:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0i-0001bL-Mv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0f-000253-Iz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjgJDMASZjcGOJV/vJO6lV99FBfJmaAIl4fEb4Kczgs=;
 b=IydOuFEQ2a0EriszpFzOE6lMKCK/6RkyNhcSn4aHqoRBeoUx3CiyDHqdi9o+/dlD80CZ5k
 KI/aCIRTNlQII2IaVw+XBtjnM2bxNvLGIDzVU2QjWwRz9D93RxUCELlEvydoKtE4KZf2Kq
 VzgwqVPZEgeYj0YFqqEkjezeLCA9LWE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-IVI1lenZMVi3dLRHIu8TdQ-1; Mon, 14 Jul 2025 07:06:11 -0400
X-MC-Unique: IVI1lenZMVi3dLRHIu8TdQ-1
X-Mimecast-MFC-AGG-ID: IVI1lenZMVi3dLRHIu8TdQ_1752491170
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so1838672f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491170; x=1753095970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjgJDMASZjcGOJV/vJO6lV99FBfJmaAIl4fEb4Kczgs=;
 b=ucGkBbU+b9yTW9p8+ydWWrWWfG3IlNw9ZmWiGplmdGCEc8Zn6eZUI6YRJ52lw8D6W8
 FYSV9cRAZwiD4u9r8C+68GJ9izMivxc7a9XWksfs/VVO1IhojsMc3veOekdcIttwVxlm
 3B1BgSFunWM+Wtg7vSH8H/L5QfAx0IlnThhQgubHuFiLB2TTC4T7TIdZN8q3mCKULwLs
 iot/yk1v8sw/n5baB6kWB0pQ6g6ZakvwiYXzvUtQVs8WrGTMPl2u/+rbeqJBqmZdF/HS
 d5y9nd16RHepdqu0bhd6IPrRwEzNtXGfPphked/ZF4teOcYshE9zy2y6kELpNpYdXw4a
 /pGA==
X-Gm-Message-State: AOJu0YycxFqBroBHL7NeBXzjLkJhdhMl3M7d8kSaxt+Q3TycUgra0QYM
 QkVRt+LwF89vAvncwXVI2HjnB9NtRgibGwF58tI2jFGtSDd5OMKHfWZWqDuQxArUH4TU3gzQAe6
 y3o1l58IyzWBZACydttkfxTsSXg1bO8YzlAdC1FKQC9Qt90u3ebc87iZHh5EXZR+wk5ewTlNwtc
 vI7kYp70LnA6bvyGptQQGQ7FSOkx1qlVqa4WoPGPx8
X-Gm-Gg: ASbGncu+thPv870XslM9nBza0H0DPyk479py2Q6g76n37zo2eoJqtpdpYfjXcAcpWuL
 Gv3Mf8QC9PxkC+Yxbc8/xhMg+QOVcDOGXoKJioi6Gzx30Mc7Q7f0QquBLEnUOlpNQAVBAfKdjMZ
 0IXB0Pq57g/lXnohHzQhBLEyKW8f9wqjnG1Gov6CgYhdBftk3KVhvTETjvSeb1AwQmDaUf4uSCf
 xL2FPxhg8v1IxM+H97E6mv1mTflse9KYg+7EjaJ12h2S1KeiIFFwZ+5bV3f1Qcp/0OGDuTfq8We
 JFfUxmrv0EngCHif/0BrRB9eBzdD7zhQ4t9x+OvY4Jg=
X-Received: by 2002:a05:6000:2004:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3b5f18b3ecbmr11074738f8f.34.1752491169560; 
 Mon, 14 Jul 2025 04:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3avFznPtpSpEwF0WHFReGm7r1UBfMpshWt9tcKw+6HMy39a/n0KxsP61s9DC6iNSWxv4Tg==
X-Received: by 2002:a05:6000:2004:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3b5f18b3ecbmr11074705f8f.34.1752491168878; 
 Mon, 14 Jul 2025 04:06:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0dc3esm11976967f8f.47.2025.07.14.04.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 46/77] i386/cpu: Add x-vendor-cpuid-only-v2 option for
 compatibility
Date: Mon, 14 Jul 2025 13:03:35 +0200
Message-ID: <20250714110406.117772-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Add a compat property "x-vendor-cpuid-only-v2" (for PC machine v10.0
and older) to keep the original behavior. This property will be used
to adjust vendor specific CPUID fields.

Make x-vendor-cpuid-only-v2 depend on x-vendor-cpuid-only. Although
x-vendor-cpuid-only and v2 should be initernal only, QEMU doesn't
support "internal" property. To avoid any other unexpected issues, check
the dependency.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 11 ++++++++++-
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d3f7c53e301..d88481ba8ec 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2282,9 +2282,18 @@ struct ArchCPU {
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
-    /* Only advertise CPUID leaves defined by the vendor */
+    /*
+     * Compatibility bits for old machine types (PC machine v6.0 and older).
+     * Only advertise CPUID leaves defined by the vendor.
+     */
     bool vendor_cpuid_only;
 
+    /*
+     * Compatibility bits for old machine types (PC machine v10.0 and older).
+     * Only advertise CPUID leaves defined by the vendor.
+     */
+    bool vendor_cpuid_only_v2;
+
     /* Only advertise TOPOEXT features that AMD defines */
     bool amd_topoext_features_only;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a6fa7923688..7cfa61c9ee6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@
 
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
+    { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ac22548f47d..630a40d72be 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8749,6 +8749,16 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 #endif
 
+    /*
+     * x-vendor-cpuid-only and v2 should be initernal only. But
+     * QEMU doesn't support "internal" property.
+     */
+    if (!cpu->vendor_cpuid_only && cpu->vendor_cpuid_only_v2) {
+        error_setg(errp, "x-vendor-cpuid-only-v2 property "
+                   "depends on x-vendor-cpuid-only");
+        return;
+    }
+
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         error_setg(errp, "apic-id property was not initialized properly");
         return;
-- 
2.50.0


