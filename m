Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3B0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKr6-00055Q-HH; Wed, 27 Aug 2025 14:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqp-0004w1-O4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqi-0005qd-6L
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1MQvD0EMJParIA4Upbk/AkJVJttVwCK2SW6874n6L8=;
 b=LPKfr4VOfJGeyzZ8orZAXu8eYCkWhPYeo/F+kfVwP6MQsau+bvExtixDwdyUQ4S1dBSPHq
 /2BUmO06DbPjJzUi14THn5d/q9t8mKb2xRLgJyVbMc7xZYsCT231RMX0xHh+0lVl5+7q4Q
 R+ibHADZBBfymbVTJmM3ANqbBW5Ys30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-31wfgQI9NiGeBYKMV8xE3Q-1; Wed, 27 Aug 2025 14:26:15 -0400
X-MC-Unique: 31wfgQI9NiGeBYKMV8xE3Q-1
X-Mimecast-MFC-AGG-ID: 31wfgQI9NiGeBYKMV8xE3Q_1756319174
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b7265febdso4127685e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319173; x=1756923973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1MQvD0EMJParIA4Upbk/AkJVJttVwCK2SW6874n6L8=;
 b=ib9Qu6dW0HC4asH9O4lm6rMiGplBSuvzYPf3ZywyFPBcKR0C9eAqaKz/MFZfVpOEJY
 NPG0olda7Vt1iRRxtZGjeqzJihbTqq4BzlIWdOLkA3m+0ycRHReUzsksE2b3PDlXRbXP
 T9g7uKFjuGPyoAh9tTHTzw2QIP/u8Mtg6zu3sTBzvSVGCykmjxkDShTbU5XK+JG8V8Ra
 xgeqvxxPSqV+8+DbEg38DRwXGNzX0LPnd9pXfUaiwh6Fr5e0Zjyrrfz+4eGqGyyIFjal
 FTtMRIkYEt3mob7W75ciO4Wwa7EtFIL+j4PoDXFjXIECLsc/r7oPY+zRb2/+v9/mUMlq
 4doA==
X-Gm-Message-State: AOJu0Yy0Wgp2tjTVjbluOyQvw5ZnMViO3zd4ckW8Pb1FoMNIx3BTCIqn
 oZUxqLg9y7YesKpzYDFnUwZ7v3iVJKN6G8Tv0t7IXZm6WXaqnmRJEkVCQZ/PdQklnCvyJ5I3vZv
 1rmzsEy9mCtb1edPyB9eUOs0luIczliENpCkFqobl2N0JybcoBIaQK3PX4V3rYvi8UzVC/14bro
 exz55uXegSPIB1xZfFzJ+hx23J6VUKj+Xj5EVJtWO8
X-Gm-Gg: ASbGncvRm4ahUUea7uFme5O/bGBNAT90h2mempaULrw+7tWHejWVOXZekSoTCK1h7sh
 pmnPQhWSoOW6d6kSTGxC9Xo9zPp04rbe1t7jhvHl29vIVdDinctnmMTWnoJpsBrZMoYnuY5beLH
 JSr9jOM71A1iCclUTGUCly+phL7EzGBNpQaADZIxCQoKopRF0PQ/uAcXFRx21Pqdfii4eq2q9Ng
 m00bo/dT3BnNDAQwrbiMdmNXFkVBI8Fp7eKiVBin0ZXNObEAvifshZws/YWBwY4Hx8CFYKIxabM
 uSvUh8aA9FLf3kV+xYvhvKV/eQ6arrznpXAwuxp4tjnOc/yMyH542wxwQ7MliqFrDuzHzXVwUqV
 Hw4WUG6WPatw82aqEZ1LzIEGwIGDsJ6t8IPZcbljQnGg=
X-Received: by 2002:a05:6000:1aca:b0:3b7:8646:eeb3 with SMTP id
 ffacd0b85a97d-3cbb15c9d68mr5274488f8f.15.1756319173117; 
 Wed, 27 Aug 2025 11:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyhgFc2vWuCX9UlNOPLRt5cY7PnhIk7I0tnQ1ajpkU6SNhqQoB1eoogJdQX+iRRlzy2ne60w==
X-Received: by 2002:a05:6000:1aca:b0:3b7:8646:eeb3 with SMTP id
 ffacd0b85a97d-3cbb15c9d68mr5274464f8f.15.1756319172575; 
 Wed, 27 Aug 2025 11:26:12 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70ef55aabsm20993958f8f.23.2025.08.27.11.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/14] kvm/kvm-all: make kvm_park/unpark_vcpu local to kvm-all.c
Date: Wed, 27 Aug 2025 20:25:26 +0200
Message-ID: <20250827182533.854476-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Declare it
static, remove it from common header file and make it local to kvm-all.c

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250815065445.8978-1-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h | 17 -----------------
 accel/kvm/kvm-all.c  |  4 ++--
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 3c7d3147366..4fc09e38910 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -317,23 +317,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
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
-/**
- * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
- * @s: KVM State
- * @vcpu_id: Architecture vCPU ID of the parked vCPU
- *
- * @returns: KVM fd
- */
-int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
-
 /**
  * kvm_create_and_park_vcpu - Create and park a KVM vCPU
  * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f86..f36dfe33492 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -414,7 +414,7 @@ err:
     return ret;
 }
 
-void kvm_park_vcpu(CPUState *cpu)
+static void kvm_park_vcpu(CPUState *cpu)
 {
     struct KVMParkedVcpu *vcpu;
 
@@ -426,7 +426,7 @@ void kvm_park_vcpu(CPUState *cpu)
     QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
 }
 
-int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
+static int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
 {
     struct KVMParkedVcpu *cpu;
     int kvm_fd = -ENOENT;
-- 
2.51.0


