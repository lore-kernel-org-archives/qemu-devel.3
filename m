Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9B606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxZWIjwU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNXTc-00050p-En; Sun, 01 Nov 2026 10:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drifabdelmalekmohamedsaid@gmail.com>)
 id 1xNXB1-0002Yw-AK
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 10:08:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <drifabdelmalekmohamedsaid@gmail.com>)
 id 1xNXAz-0002yd-L2
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 10:08:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so24982025e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 07:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793545730; x=1794150530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ytyWyrIlAoeO7V9N/lfLSv8jibtFa9CQeG8gEGhcIPI=;
 b=PxZWIjwUVMTez3Glo+y2vlUDXgpoDoJT5eRTH+8o/arcTPA/9EyWUXAjTulBSEsf+M
 X2N3VBd+uUlXrqCfOf8BL6j5PfvaDjBIzoPrzmOfr+hNqYAtHJD0r8EsMaoCLedcYrgc
 0iKtYbhor4swXloGA3oL64jOV4UyAGkdkQxSOz3aOBfrD2xYcPPyLjYcJ9oes2m4ibyA
 lP+19ChU8wPwmwO9DV5IiQuzNrw7hs5Qm+ZlxhU+MSIlf6VxFhwX6UctiIVy06zAboh7
 9NIvOpRrKNqvRhzB07M5yTKT4Guy83/L6I9f4QN8h7VD4jFgsme5PHI6kV0EPYhrLTqJ
 WueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793545730; x=1794150530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytyWyrIlAoeO7V9N/lfLSv8jibtFa9CQeG8gEGhcIPI=;
 b=KI1Mwa7EfwTO5zj0Pqac/aZbiszLKgjHpUM/Q4Qz5TiKd6mkbwLinZE+MtnOIGC4Xz
 HXB5XpZHrsSPEJLWfy2HP7uj1IfYEMMV5NAL9fyQpsR168LhrAbIXkdsTfMeR5MMN1vr
 TYGZhKqhGOjZ6pmKaFTkmKV66PiqD2DKG6v0cRBekdLL93kcyKcZJ4U+y5Acsdt1gozG
 hZi341OqIVktBU9gBSs9xCnQs9TjKTQJVd0q3GPdjwoMMN6qpzh0dz9vvnpp17Pm5nmh
 10wORGtuQwC5fM0+qXoybeAbskMl1vIDaLw8YGfIERStGQoYkaRrfUOPx2DF9tXv0NRb
 UXLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7gf2TbeNRmd7a6uGxlpbjxWWWb1b1f7QPoj6KaNYaunNBuX34HKmg/cMBqVFA50w90naDBk4G7eyV@nongnu.org
X-Gm-Message-State: AFq9FYLBC+bcR77ypgmNP7uxkbsSwM+XWXqFpz6MMpH7NHLzok0GVh+A
 UQ37EaZna2CTBydMJqP3V/rIIFJ/o8Xp5ZhjZYdpVZi401cDgZ+yhjqJ
X-Gm-Gg: AYBFou0kWioI7Vco1dB36JSny/w850y5xA5hOnyPAqlz5i45i8BdvXQguzocCh9qSKo
 OsGYoThDhHOlOzQo6vWInjORJ9WExsdkvHpqwrTbfeOyu5gqhaGKYTDJWNcarSoPTIwKcG2jGrV
 fMgNLyWuJl/lah2VB9tjtffiepd7JtkgGM4sW/JqGMMz5ChDutBN7atuFLNJDSBGYqoNXt8VZc7
 kno4zk8XgRea/YmAYKnvgD6qftZ92akYR8KDVBkj7ZexZBdw8E+QxQJauNKdFSbyVl+TOnlFH+5
 CoEQvJZC/VYR8nVS4YVbYxFYuyzwKihAqRkEL1eZAzVFHG2YcNqb5I9XWnfkXZi/scvq80rLLXo
 P+yEwFKvsz11urqbNJuS1kqowjZpedSAFUazVEUCskiIdLoaltUbHEIg3XRSs41AEp+Dm+fEq2H
 G+g1A75QFHlfxbfWY4mcYK9rDdgl/HqQUyGbBF42yyQ5FMyquom5gd4cw//8a4ZBApXSzcjvapI
 icR8LBjdLwb+9vBjQMj968IZGKbFvW9oOeeLV4P31e5IpQo0Nghek1DcMFaMfnjbwlBzUGfY75i
 MStRIi9Oe/diD9D+a2GaYpKleIM9cgY/YVeITjO4DUIn7nPmco/NKWJ5EE8Pq5LBNhxX
X-Received: by 2002:a05:600c:4e8c:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4ac1793ff26mr176095525e9.15.1793545729783; 
 Sun, 01 Nov 2026 07:08:49 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([154.243.136.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896fesm312295815e9.10.2026.11.01.07.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 07:08:49 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] hw/i386/kvm/xen_evtchn: use lock guards
Date: Sun,  1 Nov 2026 16:08:47 +0100
Message-ID: <20261101150847.29157-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=drifabdelmalekmohamedsaid@gmail.com;
 helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Nov 2026 10:28:03 -0500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace qemu_mutex_lock()/qemu_mutex_unlock() pairs with
QEMU_LOCK_GUARD()/WITH_QEMU_LOCK_GUARD() in functions with error paths
and early returns: xen_evtchn_bind_pirq_op(), xen_physdev_unmap_pirq(),
xen_be_evtchn_bind_interdomain() and xen_be_evtchn_unbind().

No functional change intended.

Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 hw/i386/kvm/xen_evtchn.c | 82 +++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 9379383e53..c0250cb357 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1293,20 +1293,17 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pirq *pirq)
         return -EBUSY;
     }
 
-    qemu_mutex_lock(&s->port_lock);
+    WITH_QEMU_LOCK_GUARD(&s->port_lock) {
+        ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
+                            &pirq->port);
+        if (ret) {
+            return ret;
+        }
 
-    ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
-                        &pirq->port);
-    if (ret) {
-        qemu_mutex_unlock(&s->port_lock);
-        return ret;
+        s->pirq[pirq->pirq].port = pirq->port;
+        trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
     }
 
-    s->pirq[pirq->pirq].port = pirq->port;
-    trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
-
-    qemu_mutex_unlock(&s->port_lock);
-
     /*
      * Need to do the unmask outside port_lock because it may call
      * back into the MSI translate function.
@@ -1919,27 +1916,24 @@ int xen_physdev_unmap_pirq(struct physdev_unmap_pirq *unmap)
     }
 
     BQL_LOCK_GUARD();
-    qemu_mutex_lock(&s->port_lock);
-
-    if (!pirq_inuse(s, pirq)) {
-        qemu_mutex_unlock(&s->port_lock);
-        return -ENOENT;
-    }
+    WITH_QEMU_LOCK_GUARD(&s->port_lock) {
+        if (!pirq_inuse(s, pirq)) {
+            return -ENOENT;
+        }
 
-    gsi = s->pirq[pirq].gsi;
+        gsi = s->pirq[pirq].gsi;
 
-    /* We can only unmap GSI PIRQs */
-    if (gsi < 0) {
-        qemu_mutex_unlock(&s->port_lock);
-        return -EINVAL;
-    }
+        /* We can only unmap GSI PIRQs */
+        if (gsi < 0) {
+            return -EINVAL;
+        }
 
-    s->gsi_pirq[gsi] = 0;
-    s->pirq[pirq].gsi = IRQ_UNBOUND; /* Doesn't actually matter because: */
-    pirq_inuse_word(s, pirq) &= ~pirq_inuse_bit(pirq);
+        s->gsi_pirq[gsi] = 0;
+        s->pirq[pirq].gsi = IRQ_UNBOUND; /* Doesn't actually matter because: */
+        pirq_inuse_word(s, pirq) &= ~pirq_inuse_bit(pirq);
 
-    trace_kvm_xen_unmap_pirq(pirq, gsi);
-    qemu_mutex_unlock(&s->port_lock);
+        trace_kvm_xen_unmap_pirq(pirq, gsi);
+    }
 
     if (gsi == IRQ_MSI_EMU) {
         kvm_update_msi_routes_all(NULL, true, 0, 0);
@@ -2078,7 +2072,7 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn_handle *xc, uint32_t domid,
         return -EINVAL;
     }
 
-    qemu_mutex_lock(&s->port_lock);
+    QEMU_LOCK_GUARD(&s->port_lock);
 
     /* The guest has to have an unbound port waiting for us to bind */
     gp = &s->port_table[guest_port];
@@ -2095,15 +2089,14 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn_handle *xc, uint32_t domid,
             if (kvm_xen_has_cap(EVTCHN_SEND)) {
                 assign_kernel_eventfd(gp->type, guest_port, xc->fd);
             }
-            break;
+            return ret;
         }
         /* fall through */
 
     case EVTCHNSTAT_unbound:
         be_port = find_be_port(s, xc);
         if (!be_port) {
-            ret = -ENOSPC;
-            goto out;
+            return -ENOSPC;
         }
 
         gp->type = EVTCHNSTAT_interdomain;
@@ -2113,24 +2106,16 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn_handle *xc, uint32_t domid,
         if (kvm_xen_has_cap(EVTCHN_SEND)) {
             assign_kernel_eventfd(gp->type, guest_port, xc->fd);
         }
-        ret = be_port;
-        break;
+        return be_port;
 
     default:
-        ret = -EINVAL;
-        break;
+        return -EINVAL;
     }
-
- out:
-    qemu_mutex_unlock(&s->port_lock);
-
-    return ret;
 }
 
 int xen_be_evtchn_unbind(struct xenevtchn_handle *xc, evtchn_port_t port)
 {
     XenEvtchnState *s = xen_evtchn_singleton;
-    int ret;
 
     if (!s) {
         return -ENOTSUP;
@@ -2140,12 +2125,10 @@ int xen_be_evtchn_unbind(struct xenevtchn_handle *xc, evtchn_port_t port)
         return -EFAULT;
     }
 
-    qemu_mutex_lock(&s->port_lock);
+    QEMU_LOCK_GUARD(&s->port_lock);
 
-    if (port && port != xc->be_port) {
-        ret = -EINVAL;
-        goto out;
-    }
+    if (port && port != xc->be_port)
+        return -EINVAL;
 
     if (xc->guest_port) {
         XenEvtchnPort *gp = &s->port_table[xc->guest_port];
@@ -2164,10 +2147,7 @@ int xen_be_evtchn_unbind(struct xenevtchn_handle *xc, evtchn_port_t port)
 
     s->be_handles[xc->be_port] = NULL;
     xc->be_port = 0;
-    ret = 0;
- out:
-    qemu_mutex_unlock(&s->port_lock);
-    return ret;
+    return 0;
 }
 
 int xen_be_evtchn_close(struct xenevtchn_handle *xc)
-- 
2.47.3


