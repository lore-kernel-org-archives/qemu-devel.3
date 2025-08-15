Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B32CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 05:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umn1U-0003SR-Nj; Fri, 15 Aug 2025 01:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1umn1T-0003SJ-1L
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 01:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1umn1Q-0001yC-Ql
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 01:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755235834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OHlSvAm9bdBUOrpb3X4JFBC1CXKIgTtZFn6Afgo8h8s=;
 b=JtxSAaIC8bFqBZUIY8LQ3dcB55shMxz0TEYsFSX5IZc5MmuE0z49JrqU4QqLwEZdTCldNM
 rBYMjszIh4tF2B2RCZGFwBTSxT8kvGQMflIn1V21aV/5aTHKQNHrFLEs0KtI6yPjXrZ7Kd
 cEn1YfiYgwuiDBPQ/YAFlf3JahIfGEs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-EceUTl7AMN2Yh0xOo4zD7w-1; Fri, 15 Aug 2025 01:30:31 -0400
X-MC-Unique: EceUTl7AMN2Yh0xOo4zD7w-1
X-Mimecast-MFC-AGG-ID: EceUTl7AMN2Yh0xOo4zD7w_1755235831
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-323266c83f6so1845280a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 22:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755235830; x=1755840630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHlSvAm9bdBUOrpb3X4JFBC1CXKIgTtZFn6Afgo8h8s=;
 b=oeM5aNDipTip8tf4UTgG3Jdmr7Zy/BgVz8aD8WmIQJvW9R9k3l3FiwnUqLAJAhXc/h
 FuhqvC7VkNmCi4/aaPsAhyaMKKryr5o/JP+Ibgv5i8vi//T//VYiJQaVNOunWN1DcvBO
 JCsm1ri1vVWzTTV9H6eDSRkgs1o2LLK0+mt+X/LirCPk8X1TMxClVF4nj6YngMYz6vOK
 7kjVg2XSeYp8rx5E0MuYoHSWdBhTdvSkhp0j5xTZxaj0bmbzByu+2GXZhUWGt89Wo6DH
 ShWcqW2uqktV5YZgpjz34IOQvy+Yg/WNi3KKgodZxvuaAKT9+ieXGSOQssvdP6QuGulb
 jLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSXSzrUuCIMhgQdQSFuXsxBzqvqgMqU2g+QoS6KonMD2l0FcOb3Aq4+O9ymP0SaCZjOEHzJ/ztBoRJ@nongnu.org
X-Gm-Message-State: AOJu0Yw7IhFqpGWZUj7WgOudj+0+O6w1bKhW7VM8pYAVwz1Ady1yD6W1
 fx26mrUy4qFkt78+nhezm8A2rWcJ7R4NuZxdHIvocp6N3qJjCJSrrFRg0w+excvvkyMSbeHqL8C
 tLnPQZslw7QZv9mjTQ6WbOYBVk8qFLUDCvQMtcKI9+cfdCd6Jm97m8en8
X-Gm-Gg: ASbGncuV9zfiTKRxt+tW+BH0GedaUksh/qfk5uik5h3So8QLyZvXhkSs/F7sTJ77mqw
 nYt7/Rp4pjtFKr6hsGTySsXFKQ3NUaNJhFUmlgyD6yYhrMvvOLj/B6+t+kispue6ESBML+tUszM
 KwFw2nWCzuo3iJ8TTBXCsLwWILNvS1txkEGAxq2zlg2vQunZomr1WS2zu0legY96BW8Lx/8XBsw
 1LXktkrtcirlhnqxq/diJMeKMniLW9sJofaQfVXdb20cQ3wQhynStctBDeG2n6qZ/pZnCK66ngG
 HnbVWlOyoOlh4tbyAFfqYfWfM1lHqVNLhFUiUXeUAzi87U6plSI9mX1h
X-Received: by 2002:a17:90b:5305:b0:31e:7417:9e86 with SMTP id
 98e67ed59e1d1-3232978cc8fmr6161743a91.9.1755235830507; 
 Thu, 14 Aug 2025 22:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX5oOIfhi3M+WDXrtKmAnTTBuseeBLXuOMo1RXjIkKt9Eao/SYE5dL0A70pIxVQMzxuFHsow==
X-Received: by 2002:a17:90b:5305:b0:31e:7417:9e86 with SMTP id
 98e67ed59e1d1-3232978cc8fmr6161707a91.9.1755235829987; 
 Thu, 14 Aug 2025 22:30:29 -0700 (PDT)
Received: from ani-lenovo.domain.name
 ([2401:4900:1c84:e19a:d863:5334:4ba4:f128])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-76e452b40d3sm340665b3a.51.2025.08.14.22.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 22:30:29 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] kvm/kvm-all: declare kvm_park_vcpu static and make it local
 to kvm-all.c
Date: Fri, 15 Aug 2025 11:00:21 +0530
Message-ID: <20250815053021.31427-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

kvm_park_vcpu() is only used in kvm-all.c. Declare it static, remove it from
common header file and make it local to kvm-all.c

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c  | 3 ++-
 include/system/kvm.h | 8 --------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f8..41cf606ca8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -141,6 +141,7 @@ static QemuMutex kml_slots_lock;
 #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
 
 static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
+static void kvm_park_vcpu(CPUState *cpu);
 
 static inline void kvm_resample_fd_remove(int gsi)
 {
@@ -414,7 +415,7 @@ err:
     return ret;
 }
 
-void kvm_park_vcpu(CPUState *cpu)
+static void kvm_park_vcpu(CPUState *cpu)
 {
     struct KVMParkedVcpu *vcpu;
 
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 3c7d314736..c7fd7533bb 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -317,14 +317,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
-/**
- * kvm_park_vcpu - Park QEMU KVM vCPU context
- * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
- *
- * @returns: none
- */
-void kvm_park_vcpu(CPUState *cpu);
-
 /**
  * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
  * @s: KVM State
-- 
2.50.1


