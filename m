Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A48C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpR-0000HI-CT; Wed, 17 Jul 2024 01:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpO-00007w-RD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpM-0001xK-Lu
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DP8/Gbiiia96Dtq1DrYBPLXdImupj3svM1Xar5lzxE=;
 b=SCCX3BpYfSVeHriXteyEiYT5ZPX8TCFGVun4GmJHLdQnmYnQ5lA34efmEvVa4k+1Je0oCi
 a9vBv83hC53PfnXD1xt3IZzYHVwuIx9Yl7/kU5CoX4ML6pC+zq48n/LeW8u3bSDFSDqA3D
 bSQ0HFkKgILBYZeUTIqy8s77Zr/pdzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-gi9Z7OvqP0GSD3Fr7gqB-Q-1; Wed, 17 Jul 2024 01:03:42 -0400
X-MC-Unique: gi9Z7OvqP0GSD3Fr7gqB-Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42725ec6e0aso47708995e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192620; x=1721797420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DP8/Gbiiia96Dtq1DrYBPLXdImupj3svM1Xar5lzxE=;
 b=oNiozwut12p6qGQnDJkmuowfehc9jh/ZeGbXFqfJ6dE8XL1D2KfHBz5/JdCCx4Mo1+
 CmuWqQ0+b4GZ347lgVYEUwQEll4iMOLLk5TEGU52zYvJppqj10ylMbOgG3UlZde4rXfQ
 s+0sqAHxo2pyRRcdkrRWhNHqIPeja4Lk26vNQACHjSqcwvt1TzHaNwPOHGNhAJjfxC9e
 Gf09VsmUNt6gTaxPyZ5E8dGko0yTNfvYiYlwTwZH6zr6kmie5PoeJ7Ac7MrmyvIXJX5Z
 wiDTynJL1pwR4Wzkkg3RYQ4V7epn2uJbnCJ7SvkF0/x23mDVmzXJlPCdTP9wC4ltPkBt
 1fxg==
X-Gm-Message-State: AOJu0Ywt8UZsEG2qjcjMDf6ll8sSsJhYbEoF303OyA3usF36QlmdYpSt
 VwnWrbkDoK8fmBbB3xl0yh82V+19aLU3g4uXQYzWe9G15bjET9wvKpLp2qnMp2Tt3lMaQWP8cc+
 uspR4Xpimnz0+JKy+wTpdI8DCUOhJW3TPGja/YhOROpB+mgF2cDmvDnGFLDRqJU4EYKixfQe6Qk
 vGq20+lr+Xo0SloeYO2HXPys7SwJTDBHy8Gr4n
X-Received: by 2002:a05:600c:1987:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-427c2cfc334mr3323235e9.28.1721192620525; 
 Tue, 16 Jul 2024 22:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF/oCM6jxb6rD3crbjRpBOTyWrpR70yo1vgX4+r3JV8L3Z/ZOLhd3dKmUMKZmxq4oiMEGoeA==
X-Received: by 2002:a05:600c:1987:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-427c2cfc334mr3323075e9.28.1721192620130; 
 Tue, 16 Jul 2024 22:03:40 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb525sm153459715e9.34.2024.07.16.22.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 03/20] cpu: Free queued CPU work
Date: Wed, 17 Jul 2024 07:03:13 +0200
Message-ID: <20240717050331.295371-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Running qemu-system-aarch64 -M virt -nographic and terminating it will
result in a LeakSanitizer error due to remaining queued CPU work so
free it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20240714-cpu-v1-1-19c2f8de2055@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h |  6 ++++++
 cpu-common.c          | 11 +++++++++++
 hw/core/cpu-common.c  |  1 +
 3 files changed, 18 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943f..8e6466c1dda 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1000,6 +1000,12 @@ void cpu_resume(CPUState *cpu);
  */
 void cpu_remove_sync(CPUState *cpu);
 
+/**
+ * free_queued_cpu_work() - free all items on CPU work queue
+ * @cpu: The CPU which work queue to free.
+ */
+void free_queued_cpu_work(CPUState *cpu);
+
 /**
  * process_queued_cpu_work() - process all items on CPU work queue
  * @cpu: The CPU which work queue to process.
diff --git a/cpu-common.c b/cpu-common.c
index ce78273af59..7ae136f98ca 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -331,6 +331,17 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
+void free_queued_cpu_work(CPUState *cpu)
+{
+    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
+        struct qemu_work_item *wi = QSIMPLEQ_FIRST(&cpu->work_list);
+        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
+        if (wi->free) {
+            g_free(wi);
+        }
+    }
+}
+
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index b19e1fdacf2..d2e3e4570ab 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -281,6 +281,7 @@ static void cpu_common_finalize(Object *obj)
         g_free(cpu->plugin_state);
     }
 #endif
+    free_queued_cpu_work(cpu);
     g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
-- 
2.45.2


