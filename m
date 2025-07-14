Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7883C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHTK-0004HA-Tb; Mon, 14 Jul 2025 07:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0m-0001cZ-UU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0k-00025h-Os
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWXeFYYxE013tWhjiyA4F7SmPG5yy1BXn+V7I3G9oQY=;
 b=F963hiBZEEqijdkz0RINxHsEy3+VX14fR4LbTsRJE9saplQvRI4+FDZY+lJ+96drX3S0N6
 74McoR5idZ/jUk4el/7hnhlRJrIC8LEtMYMu8aieepUkYilj3wdZ0z0F3U2pBkRMI45VGt
 +cHqK3Vf6DfycBFKgLvcwkkLvKyzeyc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-iceFfvbDMsGiHGiNxJ8g-w-1; Mon, 14 Jul 2025 07:06:16 -0400
X-MC-Unique: iceFfvbDMsGiHGiNxJ8g-w-1
X-Mimecast-MFC-AGG-ID: iceFfvbDMsGiHGiNxJ8g-w_1752491176
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so11253785e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491174; x=1753095974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWXeFYYxE013tWhjiyA4F7SmPG5yy1BXn+V7I3G9oQY=;
 b=OJC2s3SkpbOaZXl696uVK1Afva/SaPQ7P4qFAp8YvR9cTyQJjUdAsCqCb8bs68+RS+
 DNTHxqdKBwDE+jTppXR4goPSBPUTpm11NpooYafk+dhDtHbunycdT4KYuLNe15+XyqEL
 VmWxX2ikK+rgrBukjYWMw1l4zq2wxFZ4g3+WyuN1ZkS5D8zEDhB5cPp27MsvdkM/fDV3
 84oSmEsqE+DZQYHbw/H4N8a+k9vO6Zsq7pvUtaGZWWmqpByIzoI62Jxr4WI8rY0699Uz
 mZc1MefPF3ddEDF5kFZM/pX9eE1xc0Q1a7gxkRQZ044paHsCgU1+y2ff3MbrdnTk5VPC
 /3Zg==
X-Gm-Message-State: AOJu0Yy29mJtwzFZj9ethnD1r9dZiE7hawDlMNHA612DxxzjExCOQmUx
 9WDFS0cbQFmAPqYVZrSGCPG1MHWQaSk8DuS7Eyac4MLkExEyFu2wCdY+Z2VgOiT3qFsjg5Bvroc
 QV2XuqmGkbAk13lfjrnsBNqoMrOB+IESNkYV4Iy/EWm28kvD5h4z7XKGGdkxgVG6cEjlnX+Dgb3
 YMvDJ0xPAHKO5R8Lseui8sZXplBp+FBJW/wEGTopoG
X-Gm-Gg: ASbGncsZfxddxIAxiPpmTU/IKbua5FiZ4cB10CI8pBufyIBgc0oPVeTDVPWxAj2MU1o
 MN78uqQxpiK/Lu2GCgEM6sH9/kwTDLJmTcyutUwjRrZ8nDQy5ZyiWp/mQzXp4NjXL/5c1ayJZCT
 7PG5r90xPyMR6vwTTpw/8PDwwGT6q5LK/lEcFSVX0PrLug9LrEazYq4RdxoPnNS61wMuUj8f8Yd
 5+TMjQLYDtqjnWqItB2TNFG3IIcfou1Jn4UtR+6dOUe+JRRbcPbp/+OBZOfCK0XtSIp1mMvHDyT
 nVpIqxINuyJdo1HING5AzTYy7vrML2oIVnf7OsF7kKs=
X-Received: by 2002:a05:600c:3481:b0:456:1442:86e with SMTP id
 5b1f17b1804b1-45614420b46mr36818705e9.21.1752491174441; 
 Mon, 14 Jul 2025 04:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHruzOdOb2oWIjoxWZlHmbzlpnwdHPoN2U6OGf2d8NF/5PHD++Fv5vqWVc2xHpWoyY0JRWaLw==
X-Received: by 2002:a05:600c:3481:b0:456:1442:86e with SMTP id
 5b1f17b1804b1-45614420b46mr36818345e9.21.1752491173829; 
 Mon, 14 Jul 2025 04:06:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm46989245e9.1.2025.07.14.04.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 48/77] i386/cpu: Rename AMD_ENC_ASSOC to X86_ENC_ASSOC
Date: Mon, 14 Jul 2025 13:03:37 +0200
Message-ID: <20250714110406.117772-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Rename AMD_ENC_ASSOC to X86_ENC_ASSOC since Intel also uses the same
rules.

While there are some slight differences between the rules in AMD APM
v4.07 no.40332 and Intel. But considerring the needs of current QEMU,
generally they are consistent and current AMD_ENC_ASSOC can be applied
for Intel CPUs..

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2abcb5acffc..8a97272b4a4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -507,8 +507,8 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 
 #define ASSOC_FULL 0xFF
 
-/* AMD associativity encoding used on CPUID Leaf 0x80000006: */
-#define AMD_ENC_ASSOC(a) (a <=   1 ? a   : \
+/* x86 associativity encoding used on CPUID Leaf 0x80000006: */
+#define X86_ENC_ASSOC(a) (a <=   1 ? a   : \
                           a ==   2 ? 0x2 : \
                           a ==   4 ? 0x4 : \
                           a ==   8 ? 0x6 : \
@@ -534,7 +534,7 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     assert(l2->lines_per_tag > 0);
     assert(l2->line_size > 0);
     *ecx = ((l2->size / 1024) << 16) |
-           (AMD_ENC_ASSOC(l2->associativity) << 12) |
+           (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
     if (l3) {
@@ -543,7 +543,7 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
         assert(l3->lines_per_tag > 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
-               (AMD_ENC_ASSOC(l3->associativity) << 12) |
+               (X86_ENC_ASSOC(l3->associativity) << 12) |
                (l3->lines_per_tag << 8) | (l3->line_size);
     } else {
         *edx = 0;
@@ -7905,13 +7905,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+        *eax = (X86_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
-        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+        *ebx = (X86_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
                (L2_DTLB_4K_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
-- 
2.50.0


