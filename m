Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFEFCAC594
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLL3-0005pC-Lt; Sat, 13 Sep 2025 04:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLL2-0005oz-AM
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLL0-0004uc-Mf
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7joNFhlKCq/65i2RHs9pqNw9LGInItxc9SYTL3XBLRM=;
 b=SxBdAWOECa6DZyWY8tDS5aUUqjvics/qg2XT8BM6uv1N9UPKISIAkprr6YOJgAHPfW08d6
 bIfMG3QpO24twI7Psne7pvBKxy7aEmB+uFSmp3TOXTRe8oZdIh6GkADSPiEID8BlueSD+g
 d0dvaSQSqWL0zWNLVaQg4DXkvG80YP4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DHkW0MsMO4yIi5viwmdLrw-1; Sat, 13 Sep 2025 04:10:23 -0400
X-MC-Unique: DHkW0MsMO4yIi5viwmdLrw-1
X-Mimecast-MFC-AGG-ID: DHkW0MsMO4yIi5viwmdLrw_1757751022
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e760a261caso1453091f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751021; x=1758355821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7joNFhlKCq/65i2RHs9pqNw9LGInItxc9SYTL3XBLRM=;
 b=ccShqL7oB4aimFV+RsZp5VwHSR3ImllLvf5nwSFwS/pEcfL2T04FRBHk106HdQk2MH
 udgYIotxQunsB29U8BuvLVPZJmh08lujB8rW+0L+QCJamtHEXYEsF8DWQtlXpFu16kqZ
 55QrfzwfiklS2at73WcrxxFvlwS/264doy9cJAdtZYMZdkfVz36VkA6FuHKjhqJ36/2U
 nQsar5WDO11NMxsG7bnM4pkwy+dek6ztH/D4UIUFjUngtmMIsIaERfXkj9D/Gdq7Jz2V
 fpQojweBN1lyLJXUMLQGyTf3Y2U7bUmdqsiIZ5ByYHRIL2K2/YZxfsXVH2flln6hIlVk
 cQdA==
X-Gm-Message-State: AOJu0Ywo09LzdgJm+5ZYmGjgY4JFRXOqtuv+mXotKHHJRJ7kx1rw4KYT
 uw6fU9I7yoZX2ZDk++/qwvPicyG8pGMXhnU+7dpqxU3+V43Jld6nu4JtpzSfZXgVcNdobpSmUDY
 OH/cs1FBuHrYMcxkr6vxvp2wPsKerdLi7C67SKRMrH8gEp/eRofHZHwIrJ9ddp9ONsXyNyNdllO
 U8qsmy/+DDCGsHH1NOKO1SqeId7fw2mmmz5+ShyCgM
X-Gm-Gg: ASbGncsWV/0xFxJbLwkYHJRM9yWUGmI7rb9HViTIF3NUTbFALg4xVu532bWzm4bDI/z
 pYoYd9d5xvZttIanQmWE4jCh3x4LVNvCYliM9k6tHnzko1RmQZk/HZuUCI5WyY//vLMcNTjJYBM
 7jy6HsfB59VtRJ0u1ntW5auXU3j3PthfUnnuUZ12NaVlwagnQAB9AV85IIFCiymTWYW12MuqNMA
 LdLjtUwJb0P5jQpOnoIkiVET7FNFKtNTCpvTHwjMhh+UCvmJa5h2S8NWnfMGpTeNtIwRF7XoPJw
 MkyZ4KMBmgRIFgLZcNfPX79YNvL+LdcmKq4CCcDLgUMAjZyQmQoUclGr0ERZal4PxLGSY/BBxBL
 hnIGnehFq54uhq/bdC0o0t23dNK/zd7SX0IPo6dRHeqE=
X-Received: by 2002:a05:6000:24c4:b0:3e4:9dab:3f4d with SMTP id
 ffacd0b85a97d-3e7659f40a9mr5539840f8f.48.1757751021154; 
 Sat, 13 Sep 2025 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxhXPaaEG3aKQzOcQWS2zznurj+bzb5hO0eV1VnvEblalzXw+efeRVx3NTNuv8aNoJK31K9g==
X-Received: by 2002:a05:6000:24c4:b0:3e4:9dab:3f4d with SMTP id
 ffacd0b85a97d-3e7659f40a9mr5539806f8f.48.1757751020690; 
 Sat, 13 Sep 2025 01:10:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017b4222sm93412245e9.20.2025.09.13.01.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 13/61] cpus: remove TCG-ism from cpu_exit()
Date: Sat, 13 Sep 2025 10:08:54 +0200
Message-ID: <20250913080943.11710-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that TCG has its own kick function, make cpu_exit() do the right kick
for all accelerators.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/cpu-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 42463e6258d..41a339903ca 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -76,9 +76,7 @@ void cpu_exit(CPUState *cpu)
 {
     /* Ensure cpu_exec will see the reason why the exit request was set.  */
     qatomic_store_release(&cpu->exit_request, true);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    qemu_cpu_kick(cpu);
 }
 
 static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
-- 
2.51.0


