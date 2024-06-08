Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F91FC27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYE-0002yd-Vy; Sat, 08 Jun 2024 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYC-0002wO-Tz
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYB-0000Hd-55
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lU92WHU8/0hwuwFkPavK7qpX2CZtM/+YFrjH0hKOPvU=;
 b=XGpgi+37kI1zIfBog/XXcDYv+BVRiLtl4J6xiZ4ScFIMmw3KmeZVpRYV1mzfp0LLFN2WB/
 doTKDPMiSK+88rukVbNhM+FBYS1MLnFvm7RUiTuW0j+AMM2sDIxhYShIw86XkYn22hFgIb
 rpuFau75uGfuOop/GxLJwUzHWf3Clw8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-VVAAyuwSOLSds2Pd3PfVdw-1; Sat, 08 Jun 2024 04:35:44 -0400
X-MC-Unique: VVAAyuwSOLSds2Pd3PfVdw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6912c4ddb1so160009166b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835742; x=1718440542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lU92WHU8/0hwuwFkPavK7qpX2CZtM/+YFrjH0hKOPvU=;
 b=TJrA3y24hZfVMUiZsz6YgyfrgKYUzO8//FV0oE872kcfXo1BaHbRqPHFyJ0sxJaDG+
 uLD0+JtiFecU5z8Zl9hJd3+y54XPutIW4hvBcnCwM2McYElPLCilr/7XAUqEzYFw1kOV
 6L/xZD41/fbtXdq4f6yB9Bny1UF2oRzpIPGJFnf/tnhRr2TP/m2XDTm30rcoZbnpnjKp
 ozZhDhPQcMHEvDOpHkXNRgjNV+973HplAmhdBqbsO1sF0FS9vVVeWwLxGKP0vRri5mKH
 9czpwQOOHAfdKJk8A5Ad6zMnoW6ggVxB73I5PrbAlJ+m4ZitxJriVputlhZJwS0BXX/2
 taHw==
X-Gm-Message-State: AOJu0YyuIuWQxb+MCmkFigW5eWIZZsO2abYxGslc/5c4eHNqASnK2r+m
 YLQo6S0+EJF3qD/VBvD5WPDcfcWJ3z9MA5Lwe2rLsTsJE6d72wvadkPym/NJKuuh4VR59a6J8qn
 BG0fafFoHuWraXbnJo6Lc/WVGav3K+Uu+57/n9u8yBGurdejy8RwHMb1O5Z5qtcg5Znx0FjHDrm
 nC33oZyLjdjMRcvozqOwXBOVqShzY1/5rgAmNK
X-Received: by 2002:a17:906:7f8b:b0:a6c:7221:60e6 with SMTP id
 a640c23a62f3a-a6cdb201bbamr307893066b.57.1717835742615; 
 Sat, 08 Jun 2024 01:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhl+R63wbPSRWQQwJjtYGobuW7rmYL3PYpEGXJZMU0E5lY29FZQvuRHXA5kJbP3/nIqWdUCw==
X-Received: by 2002:a17:906:7f8b:b0:a6c:7221:60e6 with SMTP id
 a640c23a62f3a-a6cdb201bbamr307892066b.57.1717835742156; 
 Sat, 08 Jun 2024 01:35:42 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f01a060dcsm48869266b.182.2024.06.08.01.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xin Li <xin3.li@intel.com>, Shan Kang <shan.kang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 33/42] target/i386: mark CR4.FRED not reserved
Date: Sat,  8 Jun 2024 10:34:06 +0200
Message-ID: <20240608083415.2769160-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Xin Li <xin3.li@intel.com>

The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when FRED
is exposed to guests, otherwise it is still a reserved bit.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20231109072012.8078-3-xin3.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ad3577056da..9a582218f43 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -261,6 +261,18 @@ typedef enum X86Seg {
 #define CR4_PKS_MASK   (1U << 24)
 #define CR4_LAM_SUP_MASK (1U << 28)
 
+#ifdef TARGET_X86_64
+#define CR4_FRED_MASK   (1ULL << 32)
+#else
+#define CR4_FRED_MASK   0
+#endif
+
+#ifdef TARGET_X86_64
+#define CR4_FRED_MASK   (1ULL << 32)
+#else
+#define CR4_FRED_MASK   0
+#endif
+
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
                 | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \
@@ -269,7 +281,7 @@ typedef enum X86Seg {
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
                 | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
-                | CR4_LAM_SUP_MASK))
+                | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -2613,6 +2625,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
         reserved_bits |= CR4_LAM_SUP_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
+        reserved_bits |= CR4_FRED_MASK;
+    }
     return reserved_bits;
 }
 
-- 
2.45.1


