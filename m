Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F613CCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQi-0008JB-P9; Thu, 09 Oct 2025 03:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQh-0008I6-HF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQc-0004Pw-Hq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b35OUmPIlkjRw+EK5NvtUyTuytJCRQht6eOVyHoxw6k=;
 b=bO4U6/Z1E0TBjKKQfMW9LE1k1zPjeo0Iu+xXc6rujXAL5uptG0885Xm0CKKYPyJGAuQme0
 cSAs7JSwBCYqZfBJJdpO16JrHeYUCO/jDU9gKbo3yRPvWLBwqphMm9vYAVcM/nj9jvyw8a
 8V1TinsUd76FMFVK4q8XViwAkebgt2Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--WtnrEZrOOeAWN1SdpzbTg-1; Thu, 09 Oct 2025 03:51:07 -0400
X-MC-Unique: -WtnrEZrOOeAWN1SdpzbTg-1
X-Mimecast-MFC-AGG-ID: -WtnrEZrOOeAWN1SdpzbTg_1759996266
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so6611835e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996265; x=1760601065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b35OUmPIlkjRw+EK5NvtUyTuytJCRQht6eOVyHoxw6k=;
 b=XJEH1iZjy+pAq1db30rQDFoRwuqKHa5sVAbytezK9wAeh8H1tQAdUusX0NKw+OY1+U
 ZazUFTIDfvpAmczi/Bl5czD6M6yO5B9FS+UlijdCKuYHh+BDRCfL5W4hksAsqrDT4+6p
 tXCJvdTeYJ4QQDUXFkXMY2DOtkP12RHCn5M2c9gvqM9d6TrUgHX2Pqus4co30gkYKvgz
 5ELgH/TKMLb6zGCIlR/mcXdw3G9+Q7Oy8b7hthRlUp2A6VPw701MvjVSGW0XBfurxPnW
 9wZJYzU6yFhacn3gNVizluk1locF5FGtZ+xsAi1Wq1pJVAXRIMsUAa+mkMtE9Sfb0gkZ
 8Nsw==
X-Gm-Message-State: AOJu0YwGrv6h86Zbg1WQDXR5D1lnIhul+IuuWCLwvTF97n2qd6+88j2n
 btDJHh7SjzvvQfPV2sA6SAwfr+2D27OhZWzc7AhmuhcZ+jaF1DB4gBjFpIZi1euWjp6NQxYB+U9
 o+Ygr8eUJ8mSj6rnH8ASY+9tPF8sms70Iy1wTdvO/U9EDxJI0YriWWw+aqvg/Y6wTeWQB/umhMp
 q53uq43fPS1pafJ3B5kVom+RAZqILts7i2wAMkLSfexrA=
X-Gm-Gg: ASbGncv2Fayvqedj/0HM/E4cuBAhi8p+CsvHsRoQurnx5Qp/4clFwKjipFIjrFsgBvd
 6AO2ivxRfAWM6U/yOira4tYUnwTvBSZazZws9SUCPuOhs1H+Bbe6IbeyWQNVH9CeBcop7h28aKb
 3fbTzJVdXYNWa6BL1cbhAe6SunLqyaQqIHrfryOWSBj+/A2zMbtWYsUCRJGld/leed+fbV5JoK4
 wkMispMGZCuqUB2fDILTDq254v9atttHWDEfdkhurCEop/JiCfluJ/OggEGaDEJSbPFWeV2NYjR
 nIxMgxGvOZWSHB4ITGdC6IhzcSJiBMVDCSk/uvB1pg42BJvDSVEOlLYrnQnkmMxa8X41AUQ46dd
 CJTPA466r/c1B+9X5uYiUYWodXjd0VhfusDqSYT8acIDqG/Ew
X-Received: by 2002:a05:600c:5492:b0:46e:477a:16cc with SMTP id
 5b1f17b1804b1-46fa9af84ecmr50381985e9.24.1759996264644; 
 Thu, 09 Oct 2025 00:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAvcuJXjN4OaFnvU0BDpMBtHHOzemqxtXXbrzSy/pAfs0RHqZFHrlS13MzzsnxgNxVybLHlA==
X-Received: by 2002:a05:600c:5492:b0:46e:477a:16cc with SMTP id
 5b1f17b1804b1-46fa9af84ecmr50381745e9.24.1759996264196; 
 Thu, 09 Oct 2025 00:51:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm33790239f8f.39.2025.10.09.00.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 17/35] accel/mshv: Add vCPU signal handling
Date: Thu,  9 Oct 2025 09:50:07 +0200
Message-ID: <20251009075026.505715-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


