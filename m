Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77144CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvq-0001Eo-5w; Thu, 02 Oct 2025 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mv8-0000uc-FZ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mug-0005lb-Pz
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b35OUmPIlkjRw+EK5NvtUyTuytJCRQht6eOVyHoxw6k=;
 b=Hocll+THmvt1Y/SFAewSapbbX3Bqf2OBeGfVw22TKeoVYSrmVSr/tQZm/4QEdCtNEnTdn0
 gy8inUMyueSR7HI3RYZwsWowE4h7BBwe8fUSOg6PQtl9oB6iDWbyiF4qShDYN3NXkLrTB3
 NGHiANIDgmqR/BCQO+1OjqrPDD9sIQs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-TLNfMA8-OxehyNnYxeeBFw-1; Thu, 02 Oct 2025 13:16:11 -0400
X-MC-Unique: TLNfMA8-OxehyNnYxeeBFw-1
X-Mimecast-MFC-AGG-ID: TLNfMA8-OxehyNnYxeeBFw_1759425370
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3bc13c24d6so143061066b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425369; x=1760030169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b35OUmPIlkjRw+EK5NvtUyTuytJCRQht6eOVyHoxw6k=;
 b=bjMv7QcUq99yhvtiqHNrnUWuZkPZFJpgS3gTJX7i6H8KIxMoT1DeiiXoRrpJSCuU3X
 gATzFalNxEMzAyBKDz1wLvnPI1ZSEx+VtyZjThb1ayrCwQABJZHd52sZj/FCi+lfsoJY
 YiVjpE9b795vf/qcWGeseoYnG+VddXjy9iy9bN8pb9aHknNv2Xhh+Py1YZjbErwAQAaa
 3dbX725R6IQ/vEx4oEDfQ1vC6FyWPrdKwv+vtoyK35dgg0X5xu+nEEMeuR5wdbS9fnGr
 AQLEiwLcolk8adNJnHq6ZSaAzhr3wJ43hcHBUtK2z0vjk6/Rzbo8A/Z6POVWql17/Nmd
 uxmQ==
X-Gm-Message-State: AOJu0Yzh8a9F5hxIU3S08EP3PaV0F129qEVJ05+eITRW946BKsdJoX5c
 FCGN8ULzmiYS/kt5kS84PatLHTRHtBknZo8bdY8dWmDMc4e/Lna/U5DWJfDkiqBncio347QNiH5
 yqVl6I7Yr1cBUqe/+CV4ndXmHl7RYlaRYUpXANrf9nnO705uR5Fdo5GJ8ejsP0/oZyecJTO/9fc
 9gCum70CCcRhCdVE36SRQmiWV1F81mv9sRiej0NlgW
X-Gm-Gg: ASbGncss9AvEhVzrQWa2dZlc8Kp82kBj193fZRDUgumJkOUCkl/+3kw9GmfHypzte9l
 NkL8l0R698BsfxA/vj0f3I6k6cqM9sSckJvD2pxdMPnja2Fh7TaSUtTxYYfW2f8unla/eaN/G+5
 vxVZ8SBRTv+KfMvsg31/uweWFjr1x3NxW69/C3HvRVmqq88acyXEqQvnB0xrfH0pcouQyUv5cyx
 W7O/Udd0007i/eH0Z3fiLEBTPGMQnPQAUzwXZzS7RpzP9ycwl+HM1PvcwjLk6s+VNiWQtVVyBzR
 TVphevnRSHWzpVO7/89SnsYjeHCesUNoomHbbM4SJCfBErGc5W6cZuhzOHo9Ts9jWjYXM4sKpKI
 N5Roo6S4UClkBYnGkC3cCadwvzjlA9ny61I6uKYVYRcrFs8kl
X-Received: by 2002:a17:907:c805:b0:b3e:c99b:c77f with SMTP id
 a640c23a62f3a-b485b8b56c2mr467536366b.24.1759425369406; 
 Thu, 02 Oct 2025 10:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5SWw1AV3xwncGoCjP+Us6+nm/xgid3ywfxz+trR39Bj35b0k4EqlCSmoLdzEe54ETvXpuog==
X-Received: by 2002:a17:907:c805:b0:b3e:c99b:c77f with SMTP id
 a640c23a62f3a-b485b8b56c2mr467530166b.24.1759425368869; 
 Thu, 02 Oct 2025 10:16:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970a684sm240395466b.52.2025.10.02.10.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 11/27] accel/mshv: Add vCPU signal handling
Date: Thu,  2 Oct 2025 19:15:20 +0200
Message-ID: <20251002171536.1460049-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Implement signal handling for MSHV vCPUs to support asynchronous
interrupts from the main thread.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-12-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index e02421d79d4..fa1f8f35bdb 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -524,6 +524,35 @@ static int mshv_cpu_exec(CPUState *cpu)
     return ret;
 }
 
+/*
+ * The signal handler is triggered when QEMU's main thread receives a SIG_IPI
+ * (SIGUSR1). This signal causes the current CPU thread to be kicked, forcing a
+ * VM exit on the CPU. The VM exit generates an exit reason that breaks the loop
+ * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the system
+ * will shut down. For other cases, the system will continue running.
+ */
+static void sa_ipi_handler(int sig)
+{
+    /* TODO: call IOCTL to set_immediate_exit, once implemented. */
+
+    qemu_cpu_kick_self();
+}
+
+static void init_signal(CPUState *cpu)
+{
+    /* init cpu signals */
+    struct sigaction sigact;
+    sigset_t set;
+
+    memset(&sigact, 0, sizeof(sigact));
+    sigact.sa_handler = sa_ipi_handler;
+    sigaction(SIG_IPI, &sigact, NULL);
+
+    pthread_sigmask(SIG_BLOCK, NULL, &set);
+    sigdelset(&set, SIG_IPI);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
+}
+
 static void *mshv_vcpu_thread(void *arg)
 {
     CPUState *cpu = arg;
@@ -540,6 +569,7 @@ static void *mshv_vcpu_thread(void *arg)
         error_report("Failed to init vcpu %d", cpu->cpu_index);
         goto cleanup;
     }
+    init_signal(cpu);
 
     /* signal CPU creation */
     cpu_thread_signal_created(cpu);
-- 
2.51.0


