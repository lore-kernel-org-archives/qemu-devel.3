Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB65C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Lf-0005KJ-7A; Wed, 31 Jul 2024 07:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Ld-0005Dv-FF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lb-0006mG-SJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVLZx9cxauGLNxxqCHWm1ysmO8J+eGcn2LcW4LTM8N0=;
 b=gGrEDrZZIkaqpH9/4Uz1Md1Kgo2bMOEKJutUU+0l7Jtw5rW0OPAJe3WLbDzcvN7AEb9oSR
 ms3xDc3TyHYbw+m6JH9mfUk4lZ1D16UmJm9sfgcqqU911BspupMLXzqpjRajiXQpyzCaLv
 B4kOU0K2g5TeUn1cLeOqX02R3n+zdjs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-JmyQJ760P1OasYS_1BeFMw-1; Wed, 31 Jul 2024 07:18:22 -0400
X-MC-Unique: JmyQJ760P1OasYS_1BeFMw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-530ad977bccso1388905e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424700; x=1723029500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVLZx9cxauGLNxxqCHWm1ysmO8J+eGcn2LcW4LTM8N0=;
 b=Nc13yNIDUfnjoUSbrSCHHnDAWI++Y1xWoNe21mBGjE49qlP9+lpcQM/jQl5KF0wxKy
 /a/j24X/koOgBriIqSk9LvQMsZ6x/jxIa6gV83rLPNpwNbFqXIm3KrITFpGx5yO5ES8e
 vdpY51ZCKggWgDSG1SlDSW4SzOxN0hMH6btL7s8tQEj6fqzNg7NvYFvRmjkhRbfKOaNP
 d7xOMpucpbNjHaDKWLQ0FGPrzUd8YQZI+TMfAgocHNIN7CFLRZxpLp6dzE1nNYflsVeK
 SHHj/E6b+UaxVNDAIdaZp+M9nW/l7VK8NI2R4D5yvs6+o6hkU82BQN2VIPmKAelwxaUu
 XJGQ==
X-Gm-Message-State: AOJu0YwSyGWBX5CzICHfnlMRM7pNHPcnCz5Ssw2CV9C6IilJXW4yoIua
 cqmHA5MqttpUgR8HOj9KH8H9sA3m8KY/PCEC0btt3rKLwlAB3ndPjdTa2Nr1Q1pAdQe4Qj0gqrk
 +Hy4OvmKeuVwIi9rY+Ejvez1Ri5Yzjl8zeGcW4lfJglYVRMfMK8kRRJY6j9emkG7M5G6snePK8R
 Zw/r0AxlL6TPspEoAO5KrJMIO5DM8Uiav5fZpb
X-Received: by 2002:ac2:4d19:0:b0:52c:dbc6:8eb0 with SMTP id
 2adb3069b0e04-5309b27227dmr7613412e87.21.1722424700072; 
 Wed, 31 Jul 2024 04:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGV33v66AXlYzL0Rxv2r3llQ3tFveEhGcUPGUm69usdUj9r72dpteDIYmB5t0Pb09dk4FIg==
X-Received: by 2002:ac2:4d19:0:b0:52c:dbc6:8eb0 with SMTP id
 2adb3069b0e04-5309b27227dmr7613394e87.21.1722424699512; 
 Wed, 31 Jul 2024 04:18:19 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7d8288832fsm217166966b.6.2024.07.31.04.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/10] target/i386/cpu: Explicitly express SGX_LC and SGX
 feature words dependency
Date: Wed, 31 Jul 2024 13:18:00 +0200
Message-ID: <20240731111806.167225-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

From: Zhao Liu <zhao1.liu@intel.com>

At present, cpu_x86_cpuid() silently masks off SGX_LC if SGX is absent.

This is not proper because the user is not told about the dependency
between the two.

So explicitly define the dependency between SGX_LC and SGX feature
words, so that user could get a warning when SGX_LC is enabled but
SGX is absent.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20240730045544.2516284-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a9535284aa9..e864f55d4fc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1730,6 +1730,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
         .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
     },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -6545,11 +6549,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 *ecx |= CPUID_7_0_ECX_OSPKE;
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
-
-            if ((*ecx & CPUID_7_0_ECX_SGX_LC)
-                    && (!(*ebx & CPUID_7_0_EBX_SGX))) {
-                *ecx &= ~CPUID_7_0_ECX_SGX_LC;
-            }
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
             *edx = env->features[FEAT_7_1_EDX];
-- 
2.45.2


