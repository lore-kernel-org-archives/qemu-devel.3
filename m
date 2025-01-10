Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C602E7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4s-0006P6-Pp; Fri, 10 Jan 2025 13:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK34-0001g0-4A
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK32-0001FH-CK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tXrkESM7KbpebY71/8nCs2zuzSL+b7tMHIIwxW8rds=;
 b=NDfc6co9OMvGr/I0VScBvJTkYIjDjCnfzRmopXQfP0wVJTJReYRNhnbtN7528yJqxaUB9E
 Rihfihwrd1Vyp07SUiGirfAqdy5ZNZ0hRpqkeTcxr3NTDLC9my6lhdEXJb39zRzVZP7v7Z
 sRTQWuiyIctFZNT8icdSwfmMJkzR8ik=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-EF-P-xqUMgq4k-9zWcRgSw-1; Fri, 10 Jan 2025 13:47:53 -0500
X-MC-Unique: EF-P-xqUMgq4k-9zWcRgSw-1
X-Mimecast-MFC-AGG-ID: EF-P-xqUMgq4k-9zWcRgSw
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3d6d924c1so2460716a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534872; x=1737139672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tXrkESM7KbpebY71/8nCs2zuzSL+b7tMHIIwxW8rds=;
 b=Qsok9LA113mpRrA1dy4B5pLp7Yk9mm10vftxqeC5O/M0xhnRnm3QmAl7SI5V1CMB5t
 plw0IcVGxbGB/UUZphXr+QJFtuXl9Gg4v/PrF0qkSR4TPTMQURAIdg6iLwFpCPcjBC/U
 fesO+gAPIyLSshRHzDOitpgYqDV14t37RsjMpkZZKYQbGpI6SRKBqpIXjsXj+RL+5OGP
 p1YfR36z41A1/OO0wWc05ZVFNC7iLK8Kk/s49B4EQ9KgrKqYfx63j5OIUYOaDRgEtYod
 9Ucj50QOoKY6hK+QJw3Skadox/oCvz9T8RFf8P7hGAqLbPsNZKEFMVRF9CdGO12is6y7
 O6Sw==
X-Gm-Message-State: AOJu0YwpMS92YozGXOspCOQuVByZ2V90gnWHvVl1iz2T6QaG+xHyrYnm
 B67RUoMdo28KVmitX5p7j1Gy7cDlbck7FCdq3PBHd1fJtZaZoy0btW9n3dlDCwnQp0tDVbj2P7a
 Ag0b4xMF80c8dd/4Z3Xof3kv+DSOkjrU4F7YduhhGVNkXDSEP/svr5OaC3+qAYVpfH65er6kFEM
 SnczYKMpq+1DI+zVxPtjERss1hyq2GLQ5Srwxkynk=
X-Gm-Gg: ASbGnctJr4zhRJWl8DGmLEvxqNJ2fzciq6zJZlVL/stqQ4sUD201RJ/GZD/vhtgb95W
 +jm3UQsnI9vLIoPaIy7yZtiRDssee+Sk0BeCPWkyvGC6hSyln9wlCgPIrMasT3qfiQL9VT1T8+V
 vZK+ESXeX/ne20vlzgqkPa2QrQUA7FN1/mXdUVrFZMe3hkVloAm5fupnok26/4lfrOiQnXDmR0A
 Hu7LvewLR836M+/IqfZ7bpaV/6po4Fi9E1REvfrRawR2lzZ5oK4Y9l1vdY=
X-Received: by 2002:a17:907:6ea5:b0:aa6:558b:fcc3 with SMTP id
 a640c23a62f3a-ab2ab6a850fmr1086958166b.4.1736534871690; 
 Fri, 10 Jan 2025 10:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfLkeoFbiBY7tuKOJngWRrGK7B0DWI4K7EXVQq4naPpWzKQk04SautNQ6OAhwAnsigRQ8+HQ==
X-Received: by 2002:a17:907:6ea5:b0:aa6:558b:fcc3 with SMTP id
 a640c23a62f3a-ab2ab6a850fmr1086955666b.4.1736534871287; 
 Fri, 10 Jan 2025 10:47:51 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c8ccc1b5sm192880466b.0.2025.01.10.10.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 37/38] i386/cpu: Set up CPUID_HT in x86_cpu_expand_features()
 instead of cpu_x86_cpuid()
Date: Fri, 10 Jan 2025 19:46:18 +0100
Message-ID: <20250110184620.408302-38-pbonzini@redhat.com>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Currently CPUID_HT is evaluated in cpu_x86_cpuid() each time. It's not a
correct usage of how feature bit is maintained and evaluated. The
expected practice is that features are tracked in env->features[] and
cpu_x86_cpuid() should be the consumer of env->features[].

Track CPUID_HT in env->features[FEAT_1_EDX] instead and evaluate it in
cpu's realizefn().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-10-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3f9475b4856..3f0821c15f2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6538,7 +6538,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
-            *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
@@ -7529,6 +7528,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    if (x86_threads_per_pkg(&env->topo_info) > 1) {
+        env->features[FEAT_1_EDX] |= CPUID_HT;
+    }
+
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.47.1


