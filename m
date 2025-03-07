Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B547C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3i-00046f-G0; Fri, 07 Mar 2025 13:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3g-00044U-Q0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3e-0002EX-71
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bc31227ecso12605835e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370664; x=1741975464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zein7nNBqGkN3Vk6l0GAK1eJKKbYG2EwAlAfLaPQUy0=;
 b=LS922t0gmmWjeFetMZ/iHRNHCQhkAsBj3pHY0BSTtFhXbpQH4LsMEljxskNVtCiYmx
 NZANlVemkIIA/kUoqjwHl8jF+/jHQSDdFo7QTlTh1Pi73BH2WRgSCqy04yz9S51w0VPN
 AuSn7Eb+oMues7cqMl+VuyqXUN5rqjBZ4LlrU0kYjJP2PAkXBA4j8OHiyL/Vm2I6BzOe
 3aWWvbUctrWUM6a6zjNZSsCyp4rF+ya/WE2McL+wKDkt3fwkhkZaSsrTwA3MM7dm+5ZE
 A6Ju+pnQkUzcDybALlenSAxf0FbGESIzTCbnudNNzVnZa5OTHo3eIz7egONcyFh9h//A
 mJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370664; x=1741975464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zein7nNBqGkN3Vk6l0GAK1eJKKbYG2EwAlAfLaPQUy0=;
 b=VEasGRbWCpI8ocllOiNOs17pGIaRkAhObY0qp1XQA8uD+xQ/JrwdBcMYgMb6f8XTwM
 rEdKO5dsvn838dNXB/idfcgdmrzX141K8aaq0vCVVBxJHG1kgz8dU8Jz3ph9Yqa1mMR5
 PnjFbcdRCBZWioy/phrhKwINsL5rfCjSIyZijjNd+f9cuEu/67LINgRPxGNJIxcmM/sb
 iH4rOcf/f0RurSpJRj9iO9IWRYDzmvohp8muK8jxvYPPjDUvwEASoobOriHFKWeLYmJB
 NmrDWjdAExD7WIrCiwElNX8d/4b+UHeYGDKAUHI0ly2zIfZ435nDDbRGV0blTQafAU4u
 VCcg==
X-Gm-Message-State: AOJu0YxvuqW1IFaAnIBWxaviF8O/qas/KIYRxUAkk2YMP3MTOry8luQa
 hMQXjnCO+ClkU4SU2Dn1eqydNKlbAUsqezLHBWRBtBOVXI/kciKzaQ6DEnkva+ELlVq1DCz23it
 CnxU=
X-Gm-Gg: ASbGnctdZK9E+YmKnQ4rGOfZ5w1zuAFQgxnv7SmvKu8kqCzXi+T7HhoOtYqnRYVyRgl
 7eohGp+SzURLfqZu6NRnCzAALKeOESHF36m3IxSyJP2IPORV0LNW09VhShyNbxUHDlxAr9qD7WJ
 juadj1rAy3cusPpB7PX862gnGByIy2Vwr2LqSMF8m8W5yRWsnyYTgDua75Hee/kyKbSt9g4vWBk
 /sYv7PT4K7sth7sT2y5lhx4FXbUrsXTiwJoGkiKfWjmNu4gneY6eUyJmoIJemuqbraNDSekZMDC
 TuzipLNnj4uoTAI5wu0qz2BGN+2YvAY3uMaW5QguVwvmUCrsATbfr4MTRgCKkahOkJU/dY+iLr2
 LTvTTMRak4d1jPUJCNBo=
X-Google-Smtp-Source: AGHT+IFDgIDG9piVmZplAJ+ruu2TBupqlEASPykHccRCOMyucVuMcasUmrzNVAlMlKSwIHkSMaQ5UA==
X-Received: by 2002:a05:600c:6d8e:b0:43b:cc3c:60ca with SMTP id
 5b1f17b1804b1-43c5a631736mr27612245e9.21.1741370663562; 
 Fri, 07 Mar 2025 10:04:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da097sm60151705e9.17.2025.03.07.10.04.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 08/14] system/kvm: Expose kvm_irqchip_[add,
 remove]_change_notifier()
Date: Fri,  7 Mar 2025 19:03:31 +0100
Message-ID: <20250307180337.14811-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently kvm_irqchip_add_irqfd_notifier() and
kvm_irqchip_remove_irqfd_notifier() are only declared on
target specific code. There is not particular reason to,
as their prototypes don't use anything target related.

Move their declaration with common prototypes, and
implement their stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h   |  8 ++++----
 accel/stubs/kvm-stub.c | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a551..75673fb794e 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -412,10 +412,6 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg);
 
 void kvm_irqchip_add_irq_route(KVMState *s, int gsi, int irqchip, int pin);
 
-void kvm_irqchip_add_change_notifier(Notifier *n);
-void kvm_irqchip_remove_change_notifier(Notifier *n);
-void kvm_irqchip_change_notify(void);
-
 struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
@@ -517,6 +513,10 @@ void kvm_irqchip_release_virq(KVMState *s, int virq);
 void kvm_add_routing_entry(KVMState *s,
                            struct kvm_irq_routing_entry *entry);
 
+void kvm_irqchip_add_change_notifier(Notifier *n);
+void kvm_irqchip_remove_change_notifier(Notifier *n);
+void kvm_irqchip_change_notify(void);
+
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq);
 int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ecfd7636f5f..a305b33d84d 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -83,6 +83,18 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
+int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
+                                   EventNotifier *rn, qemu_irq irq)
+{
+    return -ENOSYS;
+}
+
+int kvm_irqchip_remove_irqfd_notifier(KVMState *s, EventNotifier *n,
+                                      qemu_irq irq)
+{
+    return -ENOSYS;
+}
+
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-- 
2.47.1


