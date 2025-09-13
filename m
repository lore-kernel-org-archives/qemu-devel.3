Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45476CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNg-0003um-Pi; Sat, 13 Sep 2025 04:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN4-0001yB-3v
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMy-0005J8-6M
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LZ6zHpRmVQRwMqU8bnKSsPnDvukuMDh//P9NpXMQ+o=;
 b=dHDDPXhPSUp3tw3jf+ZmYQHBxm3Pj84LRLpntfUEtFW71NNShXMN6Y5ypugw+SEwW/lk/a
 mzXzHEYKloHXjqiTy+sr9F1ax/zADa4iHaVLk3gd8CYgnhi8cibl/h3pbwLi2/19AEt1Y1
 9yeWvLfEzkWV+Dusexbd6zFkD77+7QY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-vLI3xGd3MVmBfPdpqBVu0Q-1; Sat, 13 Sep 2025 04:12:24 -0400
X-MC-Unique: vLI3xGd3MVmBfPdpqBVu0Q-1
X-Mimecast-MFC-AGG-ID: vLI3xGd3MVmBfPdpqBVu0Q_1757751143
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45cb5dbda9cso16055085e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751142; x=1758355942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LZ6zHpRmVQRwMqU8bnKSsPnDvukuMDh//P9NpXMQ+o=;
 b=qZ2CTMwN9bnUad7K3NjHu74U13JYrRQS8m5wv/cr1QyvLDPH57R33TgYv+jb7LKggq
 KV/p+FWMkE7gl+0GdAZFIccNZQv81YrLyndv2CaXkRpbkFk2e8XlgccN5v1T8tnNAuqq
 gTPzs6oMKNwZfr6co/kA7ZzMKjobjR40EsVcnrerlBbAj6mf/0hxI6NlHfTdHXgKUVmx
 NIePrQDlSqFh6K2bsZ2dg3lfX1BY5LjZRrFuoYolFjsOjj5bo1g/Luh0YPid7uPiJNJf
 6Etgbp6qbb7MdUFHhngvIdueZUyuzJQ/58kzelio6uivUT0WYro+buCRQnxXhtZ1jodq
 /V0A==
X-Gm-Message-State: AOJu0YyxSSmP4YJERK3HdNkQOK3/EQy23vPBY2fZ5PzmSreMLxbjjMCo
 7+jY4CC3q6NRTSqi9Q64kbC8Zuwz2aedpy1yAtjPVC5Y6K6H2A1nxRwg8GVXO3A4uERAQo7gVik
 dQvQdgPeSrUe63fP5xhouBULaG2Fx5nX9dq3l8GP87d2I1j94/abRhaOJbvR1thF0dTfNiqe92f
 M0uSYiLT53aAK7IrRh3EUTKYFK0YQpXO57pRvuIr7h
X-Gm-Gg: ASbGncu4fY9OELgJFwpyXaA0TvpFzLN3gKGSxQze90A98Ob/+6UOtqEEX9+xdZP0EoD
 LvLeEf6wFkQ+xSR2NabP4Qf+j9PFqXgDRuWixmWe6vBBx1XTiscgaDGoHV4arsLkJ5MXVdYNMGB
 tVsXgHo0ToMu4TvnmCkXFYp16W+FzTU5RnmqPxY2d+1l8Z4OR2CSZN6s6FhzR8UTqg1R5zqYYWS
 VUPgzO6YqfzWPAP49Em2AMamJzhI1Brx4C6LYVEO25hveD4afqz4aUTxm8aqjwc0find2gkHzcR
 7zWC1RoYQsSUKyYoypbX0uc84IupuELf0M0OoKU3pe4HX+J/2f5/wimLatbSHEEabJoQubs3KfC
 yJORkX2dcBjjUF1tY0QFI+JzQ5PgkLDhPmPPQTAfpqkE=
X-Received: by 2002:a05:6000:25c2:b0:3e6:116a:8fed with SMTP id
 ffacd0b85a97d-3e7659f94f1mr5299497f8f.45.1757751142251; 
 Sat, 13 Sep 2025 01:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyUylgol7ZRPG1tKwDA+agkpoUyPyvPg/2ZUJLu1yTTiFuhauyvHHjSy9Vn99UMinJIY2VEw==
X-Received: by 2002:a05:6000:25c2:b0:3e6:116a:8fed with SMTP id
 ffacd0b85a97d-3e7659f94f1mr5299455f8f.45.1757751141493; 
 Sat, 13 Sep 2025 01:12:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f27f44624sm14581035e9.3.2025.09.13.01.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 57/61] i386/kvm: Get X86MachineState in kvm_arch_init() without
 the cast check
Date: Sat, 13 Sep 2025 10:09:38 +0200
Message-ID: <20250913080943.11710-58-pbonzini@redhat.com>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Commit 8f54bbd0b4d9 ("x86: Check for machine state object class before
typecasting it") added back the object_dynamic_cast() check before
casting MachineState to X86MachineState. And commit 035d1ef26565 ("i386:
Add ratelimit for bus locks acquired in guest") followed it.

The reason to check object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)
before commit 8f54bbd0b4d9 was that smm was not supported for microvm
machine at that time. But after commit 8f54bbd0b4d9, smm is supported
for all x86 machines (both pc and microvm). And since it's the
target-specifc implementation of kvm_arch_init() in target/i386/kvm/kvm.c,
I don't see how it would be called for other machines than x86machine,
and why the check of object_dynamic_cast() is needed.

Drop the object_dynamic_cast() check and simplify the code.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250729062014.1669578-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 28012d2b578..728ad401157 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3235,6 +3235,7 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    X86MachineState *x86ms = X86_MACHINE(ms);
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
@@ -3316,8 +3317,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        x86_machine_is_smm_enabled(x86ms)) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
@@ -3331,18 +3331,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
-        X86MachineState *x86ms = X86_MACHINE(ms);
-
-        if (x86ms->bus_lock_ratelimit > 0) {
-            ret = kvm_vm_enable_bus_lock_exit(s);
-            if (ret < 0) {
-                return ret;
-            }
-            ratelimit_init(&bus_lock_ratelimit_ctrl);
-            ratelimit_set_speed(&bus_lock_ratelimit_ctrl,
-                                x86ms->bus_lock_ratelimit, BUS_LOCK_SLICE_TIME);
+    if (x86ms->bus_lock_ratelimit > 0) {
+        ret = kvm_vm_enable_bus_lock_exit(s);
+        if (ret < 0) {
+            return ret;
         }
+        ratelimit_init(&bus_lock_ratelimit_ctrl);
+        ratelimit_set_speed(&bus_lock_ratelimit_ctrl,
+                            x86ms->bus_lock_ratelimit, BUS_LOCK_SLICE_TIME);
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
-- 
2.51.0


