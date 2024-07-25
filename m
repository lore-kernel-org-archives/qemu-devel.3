Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6E2C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8IQ-0003Ts-9m; Thu, 25 Jul 2024 19:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IO-0003NM-NF; Thu, 25 Jul 2024 19:54:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IN-0000Zm-72; Thu, 25 Jul 2024 19:54:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2cb55418470so291169a91.1; 
 Thu, 25 Jul 2024 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951689; x=1722556489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBLIzWvTbRTwfpGwDWzy1QCThM0tBGQJnZxTgRxhnC0=;
 b=V7AvkhGp9i2zyVNNowoZPvweGjchpK3SzPL4g+hAZrcpokmHFMfKtYGEtXXQI7WqLm
 Mwx5AJEW6kqB8E1ZWhIzczc9r7H8UPMteNWikFwWXOCRu253qGR1RlvQsBIeR4Zbuc+u
 6p5QzrH+wOQVsrzdin/NvqDaWVUnPN8CVxzUhl92YQGC2SC6iCHhiOlJt6iz8uvsjDcQ
 HWB5LSvQ7ACViO0eWPMFL34INPO6MuKNg/+0znfqHkfznMe76q9pqe+EuoFvIYuK9Zze
 rbdgAy9DD31R/cPeizrxQhmEaymlOFRPm0cY9gTqOcmaHaKcCzMSxqY0Y8fhWZQoTns9
 3PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951689; x=1722556489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBLIzWvTbRTwfpGwDWzy1QCThM0tBGQJnZxTgRxhnC0=;
 b=QkUyvT3LJW0ZF8abtUdN9sEyfNvB23Qapfxx1QT8/LEjaf/OLz4H967xJYs8FfLRDK
 bs+68qQomsYZ/3Ro+YkNeu/IHSUmUsQ2ZnCKiTaSlXNR0DVHp54d+w6j4e+TjYu49zga
 PoBlYojJeUDKFzteIkTcZwBDvN9L+wAMQQcCNwWiiXhux8STOHucRRA06OYhJpvPA2Cx
 ujEyjociyJqi4gFB61Ua8HSjvhV7t87OTGh3oJdtay/DwEqCP4FkmMBRXwPJwizQHj46
 PZyU8KlYqsrS/+pvVq7oR1MJSfqsSohyHNbRbaQc03P3duOorAUIWUUQWULpSQXb/lT4
 LZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu745Hj2zSAeL3WmyjEpPRoF8eJ6LEqA6wzGar39HnUOLc92s/F6UEaYYFG7Thb6zQQ/PTJA0/BVNB3f5mUaNiAgsD
X-Gm-Message-State: AOJu0YzH5WnLL4dhYjbMgA4R+HVO+lg62qnTwBbQTJg6YftT4SSUGJzH
 J/OH6wJg1E+GJP2gL0w3LK71Jkr7xj3RnIGZx7e/ND75Y8ESZsBodCxocw==
X-Google-Smtp-Source: AGHT+IHq9RXMFsaB47Qxzw6oBE2794eqWN8EkxAKKjsoWXxaIQsdi0Q6x3d9xhrXvhAOzdz9UH5mBQ==
X-Received: by 2002:a17:90a:db16:b0:2c9:74cf:7dd6 with SMTP id
 98e67ed59e1d1-2cf2eb878f6mr3977548a91.35.1721951689231; 
 Thu, 25 Jul 2024 16:54:49 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 05/96] accel/kvm: Introduce kvm_create_and_park_vcpu() helper
Date: Fri, 26 Jul 2024 09:52:38 +1000
Message-ID: <20240725235410.451624-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

There are distinct helpers for creating and parking a KVM vCPU.
However, there can be cases where a platform needs to create and
immediately park the vCPU during early stages of vcpu init which
can later be reused when vcpu thread gets initialized. This would
help detect failures with kvm_create_vcpu at an early stage.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 accel/kvm/kvm-all.c  | 12 ++++++++++++
 include/sysemu/kvm.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 67b773692f..e1d1386306 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -398,6 +398,18 @@ int kvm_create_vcpu(CPUState *cpu)
     return 0;
 }
 
+int kvm_create_and_park_vcpu(CPUState *cpu)
+{
+    int ret = 0;
+
+    ret = kvm_create_vcpu(cpu);
+    if (!ret) {
+        kvm_park_vcpu(cpu);
+    }
+
+    return ret;
+}
+
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c4a914b3d8..9cf14ca3d5 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -338,6 +338,14 @@ void kvm_park_vcpu(CPUState *cpu);
  */
 int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
 
+/**
+ * kvm_create_and_park_vcpu - Create and park a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+int kvm_create_and_park_vcpu(CPUState *cpu);
+
 /* Arch specific hooks */
 
 extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
-- 
2.45.2


