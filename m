Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C22D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZO0-00069N-3h; Thu, 31 Oct 2024 13:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZN4-0003Bk-3Q
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZN2-0007Un-Lf
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psVFGgFhVUbUQBk/PeikeiUyvdkwchfRV6l+warlRyo=;
 b=eEptYj4UatyAGBZWALoWn13Ztlj6zJBys5EGwsZ5DnVHReuf/FBQ8xY467F1J5gM24tMmE
 x1mtUOGY7d2fSBHw0QphDZUVlSRX9MxQI8DNeNAkqx8cfcNrf8i8xl9d9vYt6RVwiLyUHa
 byF/IYVKSE1nujDzGbjr6g5N/k/m15c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-x0RtH86MMHyWh3VpeWzpwg-1; Thu, 31 Oct 2024 13:54:07 -0400
X-MC-Unique: x0RtH86MMHyWh3VpeWzpwg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso8565325e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397245; x=1731002045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psVFGgFhVUbUQBk/PeikeiUyvdkwchfRV6l+warlRyo=;
 b=EHLxc7opt1A+SE4Rmtp5d+zvdjGpwsilqV7FSGqW8l/mgvkujVSjsMtZbZW3O/JGQj
 QdHUK8UxFeUO2HMEjvNH4BBXGpSZ0e4MxuxhNomoZA6K0s7kDgfHcwYlXQ5tDWwlGNc9
 mhr9m9cOWSP9pNfJR8SjQQz5/9da/prbr2hd//ost/daqZ/weOkpBEgg6Cm1GMINN0rp
 dBKxVHPfA2VMNASi8xtkdRJgUYYPJBJZ6rnhRTT49iuXwQ7Zt0AzIWTVDiZVyMMp2CPM
 e7hz1KVXILZ/jv9FpgXTJ3Uc7PIlb9tdiB7TB85Y80Qn4bXT4GkLX8DYSZeLmr7x0yEC
 Rtfw==
X-Gm-Message-State: AOJu0Ywpar8hCIeY8sX0uvuCt29+STUv5MRZTBSjaXalVnFw+LNFyRGx
 asFFgJGf390onFxkGOHi+t3ZeHIuz5Tc0/4ak0aSbA6uFO3sICVHe49cjYKfA36VuwQ3SOVYDQV
 sht9mf2iayz720VQDd55qXMy/LXS6REIdELD4RqMCHNP6uAZfSnTvF5Gokv4NrBvmBoMCU70WUi
 E7xhzo7rCNqjCMwZ0haG20zFB1650w/jvsnSLDurU=
X-Received: by 2002:a05:600c:1c04:b0:431:5bf2:2d4 with SMTP id
 5b1f17b1804b1-4327b8000efmr40936855e9.29.1730397245047; 
 Thu, 31 Oct 2024 10:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcxMLpMdKP6qtulA2lscBoYWViQjYyiT/pIjgB/nzl3wnqTEUAz36pxezAntnuf0C1oH0Yyg==
X-Received: by 2002:a05:600c:1c04:b0:431:5bf2:2d4 with SMTP id
 5b1f17b1804b1-4327b8000efmr40936685e9.29.1730397244541; 
 Thu, 31 Oct 2024 10:54:04 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7a9esm2809521f8f.21.2024.10.31.10.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:54:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, Xuelian Guo <xuelian.guo@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 49/49] target/i386: Introduce GraniteRapids-v2 model
Date: Thu, 31 Oct 2024 18:52:13 +0100
Message-ID: <20241031175214.214455-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

Update GraniteRapids CPU model to add AVX10 and the missing features(ss,
tsc-adjust, cldemote, movdiri, movdir64b).

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-7-tao1.su@linux.intel.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241031085233.425388-9-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7666a50bf06..3baa95481fb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4403,6 +4403,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (GraniteRapids)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { "avx10", "on" },
+                    { "avx10-128", "on" },
+                    { "avx10-256", "on" },
+                    { "avx10-512", "on" },
+                    { "avx10-version", "1" },
+                    { "stepping", "1" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.47.0


