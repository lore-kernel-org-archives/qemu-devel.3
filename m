Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0436C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHCk-0005bj-9N; Mon, 14 Jul 2025 07:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1g-00025I-TK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1b-0002ER-Oe
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4vIGW+jVgxph6j7hy7m8DEr7QyusibOiGAbD/TBzyM=;
 b=cMHFlFwpCs3h6mmeV5Lgc1sewy6ihZG7GvL5OVn3aDFKuUKnHMoKmOR/AyqXbz8o8cfBAr
 KjrMClAQxRY81cNHyb8SGi/3OqxpKQefo0Cc21TbEUwRVshQV+mqyf6MlUVnhtGrTWBwiQ
 In1VV+4JFJoJWyRAMH0In6zSU1mmKBQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Gr4DJyvUN8iUPdqDr2s_FQ-1; Mon, 14 Jul 2025 07:07:09 -0400
X-MC-Unique: Gr4DJyvUN8iUPdqDr2s_FQ-1
X-Mimecast-MFC-AGG-ID: Gr4DJyvUN8iUPdqDr2s_FQ_1752491228
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so19545975e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491227; x=1753096027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4vIGW+jVgxph6j7hy7m8DEr7QyusibOiGAbD/TBzyM=;
 b=CL1LJ9ZnRQw9hgYrDKF5T2kd6z1PgK82bi2cUQ9Gd0s0uV/fmmJ6vCSruq2Xu7oiEg
 cc0wDeM53/WVpOfJ4s0H7h2b0PI1Sb1xnPI/SKX6oKZaaSzM7yCRrjNWNcwYZ+LlhdDJ
 Kq8uMMvYQSam4rE9DyREBwKGJmFyFvpzXrlYVcDNc2eLHsUvaAlxo/5BgVc7rlItGNDt
 VF/ncq4tEHuylbPkSoOWbwED3U8TED+XQEBoMJ2qYlQd+82zdF4MoXjDojXbYTVf72EP
 ojNgM4VaCOZ16uQwUacb3GhTPvG3DDY9CpJ/yBUFdGij/DrWr7dWqiwl0/miyVXXFTdt
 SWwQ==
X-Gm-Message-State: AOJu0Ywu6UH2lcoGSR2lRzzU0PxeFx1LBNooXLq78f5l6RdfQXVVPY/s
 +0flqsgWYgv7uLyCNcvYr3WDsdouHk8xAdY6stFY2iInCcI7YSvhbvBxXAEhma/Q65qhHSWB5lF
 Zk6f8alVfjWKCKdPYxBPm+UmtjwR63JnXINGxvsL85i+e0xWwOHm3yctY2f1RKBqtwLe6G8G7+Z
 E2txvdsT5pQ6sMyrVWYMn++NxB4dPfJlLYT48PLs7M
X-Gm-Gg: ASbGncusdbtFFep3KEt2q610NVlMGon001t3gK4sSGAAYYb4a49Fl6myqGbAd6FNswr
 s7eupJUlIP1OGiDkMm0mUmlsf8197VvpXZfBCIOWW6m7AhQf+U65w5MjyTTReZi7uA4zrLViG6G
 CqF16QSqmW/zW/4yvtEQ8Fh3VaswnqnCUexU0EBpAZ6wBlnMuChSYa/QO/ilCdeUpxGVKyvvfWr
 VIuyORGEjgzrEIEWuCtstjYeZacoSagko19bl3CYAem3r0QBi09In9XanISmG/k9oXlFqshi9gV
 LHygaVzORlN7OPyekJIhMX+6s0FO4TTRr00ZMxceZ94=
X-Received: by 2002:a05:600c:3481:b0:456:1442:854 with SMTP id
 5b1f17b1804b1-45614420b17mr46988295e9.24.1752491227184; 
 Mon, 14 Jul 2025 04:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE22Ji03Q7JG/6cd2n1WL9crEzQBnaoCanKn4DZ2t4b+u4X0RJjQ1zQsbt6auTjB2n39uRTxw==
X-Received: by 2002:a05:600c:3481:b0:456:1442:854 with SMTP id
 5b1f17b1804b1-45614420b17mr46987945e9.24.1752491226714; 
 Mon, 14 Jul 2025 04:07:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1833sm11796439f8f.8.2025.07.14.04.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 69/77] i386/cpu: Mark CPUID 0x80000007[EBX] as reserved for
 Intel
Date: Mon, 14 Jul 2025 13:03:58 +0200
Message-ID: <20250714110406.117772-70-pbonzini@redhat.com>
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

Per SDM,

80000007H EAX Reserved = 0.
          EBX Reserved = 0.
          ECX Reserved = 0.
          EDX Bits 07-00: Reserved = 0.
              Bit 08: Invariant TSC available if 1.
              Bits 31-09: Reserved = 0.

EAX/EBX/ECX in CPUID 0x80000007 leaf are reserved for Intel.

At present, EAX is reserved for AMD, too. And AMD hasn't used ECX in
QEMU. So these 2 registers are both left as 0.

Therefore, only fix the EBX and excode it as 0 for Intel.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20250627035129.2755537-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ae508fa962d..533c9d9abc7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8376,7 +8376,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
     case 0x80000007:
         *eax = 0;
-        *ebx = env->features[FEAT_8000_0007_EBX];
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *ebx = 0;
+        } else {
+            *ebx = env->features[FEAT_8000_0007_EBX];
+        }
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
-- 
2.50.0


