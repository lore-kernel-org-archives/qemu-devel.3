Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CACC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoI-0006dZ-1R; Fri, 20 Jun 2025 12:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoE-0006ch-GZ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoC-0000J4-93
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJbNjmMjp67OqR9BVIK8ZHYJ0eu+dJxsQY3QIusygAE=;
 b=h1WhJ+QYVI2jQpPC4DIOy1kNefAxLV1OTFJAWEmeiTFHdT/34FUb3DuLQTZxQ/4pIVZ8/Q
 fwIQImVuiZhI/Q/xa8ZtQPREstKBtQrH58Y/SiEZt11vKolEetTES9p3BjaupIU1d2Mxtq
 h+UN+iV/OAQSAQRkKAt4uaJLqDvDAwU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-cUn8Fq-NMs-O552K4jJ_QA-1; Fri, 20 Jun 2025 12:41:41 -0400
X-MC-Unique: cUn8Fq-NMs-O552K4jJ_QA-1
X-Mimecast-MFC-AGG-ID: cUn8Fq-NMs-O552K4jJ_QA_1750437700
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad8a2dc92ddso133642966b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437699; x=1751042499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJbNjmMjp67OqR9BVIK8ZHYJ0eu+dJxsQY3QIusygAE=;
 b=oShaDagaFzJs6qVrtg5fAQxfK1ycDbOHAcZG3NlcqIHbphTa9+rMnEnC4hSpx2osDP
 NksOwH7vqs3hc4AykeXb6OqeZxM+rNVIVhj/nNgOpoT4tVRFG3mJuD9VKc+v0INQ7Zdg
 Ck3GN2M6AswXlV790R3I5XukwaztFa+y1I4povdTEDPHOqClfrqaR6gZ/ceVXkwpwVkS
 inGpoOHUfU2ImRxxwctU9cka8j6b/tVDzO2nETtHgDrz0uGvKy5S68EI0UmSMblO6zIM
 DI8dgBPCzapmXqD7Ejrp2xMBQyAE7N1G7wJQ9pZnvhdhIxLotaPVOSce9Btpl0F4zx1j
 8pLA==
X-Gm-Message-State: AOJu0Yy6ij8WH8lEVpYVN+3zzF73uDCl25xZXNGHu3Vy7PMBaJJAL5Ej
 0KYK8TA2PAgE0FZeFHj4MoAtw4b34D4c/JKjnON9PRKDloQ5wvWvTeJy2ERFKGG6ytfuVDDaJPp
 yvjjHlQ8W4USU7xcpEJ1qK3L7ORaIb8W/wYCal7dXEp2sraqGBNynlBbb566qxqcl+UesgILvvh
 yBDIIxTZwv/E2oXqAGlHoiXVSZmjODM6C4XT/cGD0A
X-Gm-Gg: ASbGncvGzhPDGqJ8QdE7+hGEJcUSd5DI4Ggc3Nuz7cP8w4NsMI3mildQlfpNKj7HBys
 EF0xOb9bQZbPznfcj0zv20bArpn4l8/jJSlA/GQulGk8zLJNe79N3MG6YpmimdQ7gH7uqv9dzkJ
 8YRAP8gzgGERAWbHsVhUg0vVA5CnK1kjT9tj7lAmBShRLHwwInC6UQ2bNyIFyijMyh/YjioOmtK
 N7NaVSPzuYDixNgSzbUc3TsLdDgifLnL9ZMaRwIAhV/07d2qFzBDaVFrWA27kSZU6VJ2f9Gk+pU
 aFC+1fMIdeGoQPVuTT71M7lyDg==
X-Received: by 2002:a17:907:868d:b0:ad8:9d9b:40f9 with SMTP id
 a640c23a62f3a-ae057f20a41mr348902266b.43.1750437699315; 
 Fri, 20 Jun 2025 09:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaAWa45w8ofbc5wM39cegXCSvwa0EpUzq7BQe5qB3kwBQARZzEaKzOfUrgpX3L13wKMOrb0A==
X-Received: by 2002:a17:907:868d:b0:ad8:9d9b:40f9 with SMTP id
 a640c23a62f3a-ae057f20a41mr348899766b.43.1750437698889; 
 Fri, 20 Jun 2025 09:41:38 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e8218bsm186423966b.4.2025.06.20.09.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/24] i386/cpu: Move adjustment of CPUID_EXT_PDCM before
 feature_dependencies[] check
Date: Fri, 20 Jun 2025 18:40:44 +0200
Message-ID: <20250620164053.579416-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

There is one entry relates to CPUID_EXT_PDCM in feature_dependencies[].
So it needs to get correct value of CPUID_EXT_PDCM before using
feature_dependencies[] to apply dependencies.

Besides, it also ensures CPUID_EXT_PDCM value is tracked in
env->features[FEAT_1_ECX].

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250304052450.465445-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 40aefb38f6d..29bce67c3a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7349,9 +7349,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
         }
-        if (!cpu->enable_pmu) {
-            *ecx &= ~CPUID_EXT_PDCM;
-        }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
@@ -8341,6 +8338,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    if (!cpu->enable_pmu) {
+        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+    }
+
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.49.0


