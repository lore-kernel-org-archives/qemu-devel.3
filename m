Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32DBE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrho-0000lc-Si; Wed, 18 Dec 2024 05:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhn-0000lG-SK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhm-0006qX-42
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/QBJrTf6g4Vqln67IUOCc7Xr8xeF+lIWKbSulfpvbBM=;
 b=Ln8v3H+TYV+P/KE3vaVBRM7KDnHEdra7WhHr9ODiKn8Ag1hdea4qwxS9OH2Pspod6XlfAU
 QIIU35Lxr3htDshqCU8A96rO49Ywb1e0naByEL6t69Pb+alFxEUK7U+ouMxKAMVPBnf9ix
 G5KR1O+SE1AIJDQbzCkYOyAhPDNT5Ic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-eerHLl4cO7ijPjarwApByA-1; Wed, 18 Dec 2024 05:53:38 -0500
X-MC-Unique: eerHLl4cO7ijPjarwApByA-1
X-Mimecast-MFC-AGG-ID: eerHLl4cO7ijPjarwApByA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436289a570eso50744405e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519217; x=1735124017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QBJrTf6g4Vqln67IUOCc7Xr8xeF+lIWKbSulfpvbBM=;
 b=R7J/QK+0u6yx9fHcBFo8JzTP8Sr5AdCCBay///f7/oqcECjvBSqiOpT9ivyjnTyhXo
 oozYXwV2jyhSK4rHK7yN+FeUugapuqOP69daR1gPO8HsN2OQQfSabAIqO7zM7wP+up0d
 dJwh7l2qHjL3ALsIZolu0HB91YWrNkPYinb5W7ttsXA/e9RSv07wxqvIZ3OtKDrF28uQ
 2wnnYT5dETEBQuNK1vhqtZAVfgMRI4FW5cUOyIgkhZnN++MUwY2He0zFaBPdXXLbzJyh
 1d4KzVaxF7ECL5yCOkMmGUJFqG9h2pLikTujL8hmKzIgMDyHMagS1WGzoupQirfWOSMq
 bpgQ==
X-Gm-Message-State: AOJu0YyCKRTRRSPWWYQtVcrDSqTgjHQEaoxODNDcAnK1XDZKBpN+gqNy
 gQ2r+CjKUsB3PT+kS+qwAWiAJtGj07RWFUyHxTzaX1U4b59lS5FF1mumKqThZxkxq/2PduFSf1R
 0MUOipUFCkFgKbAioCsXROiSooXC+ot6CcPQrwSS1dsh3bnXJ5wjPCmAQpcZ6PLdBiJWO2P4tjK
 pzabwyHG3t3hHMK/ezYLOPzM5v28arc9qIMaQ=
X-Gm-Gg: ASbGncsEUBBZlo7oygdmWqEmYC79MtOd+rTPji5NM2R26XTe7cUWNwmudBbfd5Tsy6H
 /wrbqzaeAdP/99Le54ossZhuDpDGuyMhm79klUnOC3zLCE40MsXSDfQFVmenOFOkyLp61+4z39C
 xmViUsfnqRkbaVOTdS9e9jTT4onCnl9aMHpKLv9hXJI1ArnoWZzXXQdb4AlffBfadR972vZZ/4D
 +TY5EJtKfV2L87pWx2CEub7OzUyQJvNOEbGLhs1T93JCvwbsdg8h459MaXy67cgxXOSOGgqUt9e
 W5sFDIuDM9r21HEHpJ2qORuVn1NvLWDH44qmSeefEQ==
X-Received: by 2002:a05:6000:18a5:b0:386:3a8e:64bd with SMTP id
 ffacd0b85a97d-388e4d8b7c1mr1886343f8f.22.1734519217512; 
 Wed, 18 Dec 2024 02:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGxtoL89ebJ7m7B7KkyshTksdkcAMmk1gEf7e125/rlETHyOKlqVT/HvkA0HnoJZacLw7wpg==
X-Received: by 2002:a05:6000:18a5:b0:386:3a8e:64bd with SMTP id
 ffacd0b85a97d-388e4d8b7c1mr1886308f8f.22.1734519217017; 
 Wed, 18 Dec 2024 02:53:37 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-388c804a297sm13607480f8f.67.2024.12.18.02.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:36 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 13/15] s390x: remember the maximum page size
Date: Wed, 18 Dec 2024 11:53:01 +0100
Message-ID: <20241218105303.1966303-14-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Let's remember the value (successfully) set via s390_set_max_pagesize().
This will be helpful to reject hotplugged memory devices that would exceed
this initially set page size.

Handle it just like how we handle s390_get_memory_limit(), storing it in
the machine, and moving the handling to machine code.

Message-ID: <20241008105455.2302628-13-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 12 +++++++++++-
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 target/s390x/cpu-sysemu.c          |  7 -------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index aa06d07835..ef1bf32770 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -150,6 +150,16 @@ uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
     return s390ms->memory_limit;
 }
 
+static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
+                                  uint64_t pagesize)
+{
+    assert(!s390ms->max_pagesize && pagesize);
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, &error_fatal);
+    }
+    s390ms->max_pagesize = pagesize;
+}
+
 static void s390_memory_init(MachineState *machine)
 {
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
@@ -198,7 +208,7 @@ static void s390_memory_init(MachineState *machine)
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
+    s390_set_max_pagesize(s390ms, qemu_maxrampagesize());
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index eb04542979..5a730f5d07 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -30,6 +30,7 @@ struct S390CcwMachineState {
     bool pv;
     uint8_t loadparm[8];
     uint64_t memory_limit;
+    uint64_t max_pagesize;
 
     SCLPDevice *sclp;
 };
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 3118a25fee..706a5c53e2 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,13 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
-{
-    if (kvm_enabled()) {
-        kvm_s390_set_max_pagesize(pagesize, errp);
-    }
-}
-
 void s390_cmma_reset(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4506539f0..5b7992deda 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 /* cpu.c */
 void s390_crypto_reset(void);
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
-- 
2.47.1


