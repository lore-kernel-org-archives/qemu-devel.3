Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B325606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gUVMYdM6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEF-0005S9-2N; Mon, 02 Nov 2026 08:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD9-0003Kp-29
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD7-0002Jg-Aq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so28711025e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626588; x=1794231388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GZlkqybvypaIgOcRXKoK4DimKrXJcXhrmWLRK+1cknI=;
 b=gUVMYdM6H4FCjOjYw7MmciK/PXPcS1bznGxN+1T/0PGHvCScAx2m3FZZFn2FYv2OKB
 6Vm/4MHPglseNBBWDwGc2TD2ubTXAFwJRZN9ecFHj/mcm1jHrHjkL2r2ABsYFRkMR/tw
 ymVxfkc3on4vy///luZyc3ASeo6VrhDDZ+BaBj+DFLYFLPzPtv/Byn7bcHvG7th19MUi
 +k6KeMzMb95sl84ZX9U8+jZnLETdveF9F1ad1/6WGwpfQDswNBsHO5xR0WQItrD9Ap4X
 6zvVA1t90ca0aGVxHdDaxQ348coRcERa2qCF/qIxbCm1MK6sS74gnjmVy4KCMWQ1sIKf
 cSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626588; x=1794231388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GZlkqybvypaIgOcRXKoK4DimKrXJcXhrmWLRK+1cknI=;
 b=l9jTUZifBM3JvOf8C1MWXMQW3jVxQ3yike3oqaHZDAqSK5x1gf9ZRS8vfQoQgyYa8i
 tWzb51gooWEuJPfEsTz0hErKnTNbrA4qafqs+oiotKZvLBKs9gyWJJd+cPIHC/oKfSyc
 vs5pwZMr/nWz1dRZ0MV+EAQuwmUou1/c7PSLTUCt6qBtPP/fz1HsQQPlcOLDyDHyzDvN
 b95eWkdXgfXQF4ns3z92fegxYq9wEVu/0WcIPTq4odP5lLQMnmnyg4TQZo9A2HccY/24
 vi73jhWptuvKG05MVs3OwZC0dKTytipqBdaCw/6NIOYGXXTVBa/eb9RlKW33equbyfYP
 U6/A==
X-Gm-Message-State: AFq9FYI3hfPOdooruY/eXSFQxirtzn7vVfrC1Wu9QTaCd4Hv5quJ1OYB
 WadTQ3JngALBcTHwbTm6satA1yjs9sRA6Bcq6WqtetCOYX+qtUqyW5SZP8xZWPqsAgfTrvxqVv7
 Ej3TltCo=
X-Gm-Gg: AYBFou1IxNZC86h03quy8liGEoJWjhYJ93Vv2fZKSvbC61AxKYGKA8JeqR4W+jmczhc
 p8sXT1v/IUCzrfM6dG7ZGlDNAzArHm07TgmevZ07ak2i2Clfs4ntXF+L2l5LfRFdOqoVdCebAuG
 fB3rRD3cF+p6VUo0ilEmBh+NF1XGjKlC42uHW5NjYiSKeJeinXXPl/nLh2qkwfOOqj4oLzr8bgZ
 gUM8P3CZifg7uRi3T3LBycfAJ9nDROxhYxfxscIf9v/dSXL8/DJu0jKGTrmYju0f1ODhXtPn/Bi
 1b2Jnsvbn9TjtUP4nPlR/o/qGP7zLdEUhEBgRx1b5U3DJqAvn+9CMuiGyNA59nlZ2Yfx4km+oe2
 9+uEpYCqUYiPUclkSHfzH6czE9FjQE5UvkX8/7ovVFFFQzSYPUkGOWT4fQ4nyy0cjWiC2m2EyJq
 ebm/jTuc9jYZ5idlOZzzrvFrBy+qQftfk5k6oKrqr2TlyJaK6AZqnUcNblHF14cbGl5Hn2GmXMW
 QVq9DVSzKaPkeHYeh9SpSXBphS5HFqWNi1bETDCEQee2IBFVBbij1HpS6AogG70GEPPxjw5spxa
 bXRojJ/I7wVhqKXJyYmPVw/XZnHdOlhmGan9P/5by7utJwuGNqHdYfbL/37DRAUJJZRaEa7nDP/
 BIhR2VBRVv8pqR9Z8qDOJ/9U9HkzO9+080w==
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4ac19705d57mr222956685e9.31.1793626587858; 
 Mon, 02 Nov 2026 05:36:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/47] target/arm: Directly store cpu probe failure error
Date: Mon,  2 Nov 2026 13:35:34 +0000
Message-ID: <20261102133547.1375701-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

In case *_arm_host_cpu_features() fails, we currently
record that state in cpu->host_cpu_probe_failed to later
report the error on realize().

Replace the boolean by an error handle to allow
more relevant error reports.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261030131406.461599-10-eric.auger@redhat.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  5 +++--
 target/arm/cpu.c           | 10 ++++++++--
 target/arm/hvf/hvf.c       |  3 ++-
 target/arm/kvm.c           |  3 ++-
 target/arm/whpx/whpx-all.c |  3 ++-
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5c5f551dacb..dae79539b54 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1075,10 +1075,11 @@ struct ArchCPU {
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
-    /* True if we tried kvm_arm_host_cpu_features() during CPU instance_init
+    /*
+     * Set if we tried *_set_cpu_features_from_host() during CPU instance_init
      * and the probe failed (so we need to report the error in realize)
      */
-    bool host_cpu_probe_failed;
+    Error *host_cpu_probe_err;
 
     /* QOM property to indicate we should use the back-compat CNTFRQ default */
     bool backcompat_cntfrq;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b9e4734de8d..c484c40a7e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1740,6 +1740,10 @@ static void arm_cpu_finalizefn(Object *obj)
 
     g_hash_table_destroy(cpu->cp_regs);
 
+    if (cpu->host_cpu_probe_err) {
+        error_free(cpu->host_cpu_probe_err);
+    }
+
     QLIST_FOREACH_SAFE(hook, &cpu->pre_el_change_hooks, node, next) {
         QLIST_REMOVE(hook, node);
         g_free(hook);
@@ -1842,12 +1846,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * then it's possible that might have failed in the initfn, but
      * this is the first point where we can report it.
      */
-    if (cpu->host_cpu_probe_failed) {
+    if (cpu->host_cpu_probe_err) {
         if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
             error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
+            error_free(cpu->host_cpu_probe_err);
         } else {
-            error_setg(errp, "Failed to retrieve host CPU features");
+            error_propagate(errp, cpu->host_cpu_probe_err);
         }
+        cpu->host_cpu_probe_err = NULL;
         return;
     }
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 40b7febceb9..1c63553957d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1313,7 +1313,8 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
              * We can't report this error yet, so flag that we need to
              * in arm_cpu_realizefn().
              */
-            cpu->host_cpu_probe_failed = true;
+            error_setg(&cpu->host_cpu_probe_err,
+                       "failed to retrieve host CPU features");
             return;
         }
     }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4b20c5dc27..f9c75774605 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -538,7 +538,8 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
          * We can't report this error yet, so flag that we need to
          * in arm_cpu_realizefn().
          */
-        cpu->host_cpu_probe_failed = true;
+        error_setg(&cpu->host_cpu_probe_err,
+                   "failed to retrieve host CPU features");
         return;
     }
 
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 024d18df046..ded42c980ba 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -767,7 +767,8 @@ void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu)
              * We can't report this error yet, so flag that we need to
              * in arm_cpu_realizefn().
              */
-            cpu->host_cpu_probe_failed = true;
+            error_setg(&cpu->host_cpu_probe_err,
+                      "failed to retrieve host CPU features");
             return;
         }
     }
-- 
2.43.0


