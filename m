Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B17D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFD-00055x-4h; Mon, 25 Nov 2024 14:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFA-000530-1T
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:36 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF4-0004m3-2H
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:35 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382411ea5eeso2754575f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564768; x=1733169568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6ECEauevFEDuaDl5024iGUaHxmj6lx8VtL68hjVAuI=;
 b=iuLxBJMGVBoxPF1UJDbA2Vv1OBWYbTtYScfkXCV61/kiTyEQAXG+SZfOPyBxJ0dHhP
 SPG5Mft6seqGOH4r3oPqIM00JwRAvMI29cbNnu1YpXzeMfssxWxo3wl5N8npQEMJtE9N
 Lm7KoK8eJn9xjEZ1krDjp89YU4EzGE9Zax4jSXZrNH6IBWgVgrN/OLfops3AxTLXqWmP
 PThUevk7U+onNLC0GKMePt92PK+BNNr4yuiwDyUPT951UHuAPfPP08wLBOzIUHRmjtcn
 xnTqeI+W6Ovn5ZgpDryC9n2BsR/rsbdNpnh86NPTuv6ZrO6i91xEEpBTT7MU2QyoyBBQ
 Jg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564768; x=1733169568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6ECEauevFEDuaDl5024iGUaHxmj6lx8VtL68hjVAuI=;
 b=B2n/b3yVWaHhR/PWi2JEM/vKxSLuo6qnbg09zAo5GeeiGboKG4PY0Xrt07yQGPX8QE
 CP63gKl267E7659ovEa3HBdMNB2Ql2r+VfvJpRZbUQw5un6ELBQ4KFDUuUqs/6McaJzX
 7sWJgDkElDfdwlUQ851lGXjRtSm/0dGzCT1Cqk8O0NMyZP+EjktoPa+s+2sjPhRtOs7f
 gL+GeqwWOSFswrq+k0ajcOAtWhmgu/Eoyo0ZaW3OcxrGayENv36KmNF8Hsua01m4k4NY
 PAUOvNQxOZ1I4wMagre6Heu3cV1CWrZHsebXbMMSr+ZOwNcXpppHXecAebUE+1yP1cfW
 HSwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrt/2VTRYLDn1Hv0BEWv118BH9QrbYV+ErTitKWxh9pS0/F4K/s+pLmElz1xz0HO5WGgB5YLbIo1Ih@nongnu.org
X-Gm-Message-State: AOJu0YwjY1+1Cc4owolfyTJy5CINn5oJowimNEha5j1bUT0q36M/Nbq+
 x4FmvYEdyHBR0jxuA/G8sg23E5JKtJ5vSe3eUn5hCLcsMp4vri61SKsWPFJ7nkE=
X-Gm-Gg: ASbGnctV3tjwo2G5gD1WKMs4OWVEKEHfSHWNbN12/8/78ha9qwxuKYvEk9Lpg/Olauk
 ox+ZthZrDYlJEr63vKuTpNwlfTrOrCqlbU0/o0Q5ex0GLyzO45XqF/LuzDGsP32S4fj0p2IrvHg
 ag9WC7B19R3xTO5OAywbP5WRQFOK9grsnRadobgyEDaIV6doBi1T5C/mwwqUvniYyi9AHpGZCXi
 /h9oD268lhOsPyJ0S1HYzIOEcF2Q/lL60GeA8thiTlJvvlBB07HWONJt5mhZO9ugPbE
X-Google-Smtp-Source: AGHT+IGbZl3AY2mB9oOWxAvM4IlArET44A1YQ5dGHlD5vZZFWUk/pyqrC23UoIgvZPpYjMWvWh/3Pg==
X-Received: by 2002:a5d:6d84:0:b0:37d:3780:31d2 with SMTP id
 ffacd0b85a97d-385bfaf0c1bmr602579f8f.15.1732564768631; 
 Mon, 25 Nov 2024 11:59:28 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:28 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 07/26] target/arm/kvm: Create scratch VM as Realm if
 necessary
Date: Mon, 25 Nov 2024 19:56:06 +0000
Message-ID: <20241125195626.856992-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Some ID registers have a different value for a Realm VM, for example
ID_AA64DFR0_EL1 contains the number of breakpoints/watchpoints
implemented by RMM instead of the hardware.

Even though RMM is in charge of setting up most Realm registers, KVM
still provides GET_ONE_REG interface on a Realm VM to probe the VM's
capabilities.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a0de2efc41..870f51bf02 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -106,6 +106,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -115,8 +116,9 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+    vm_type = kvm_arm_rme_vm_type(MACHINE(qdev_get_machine()));
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.47.0


