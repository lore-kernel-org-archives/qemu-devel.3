Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E272606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Nov 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fq3RUXsN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xXFi6-00043e-DL; Sat, 28 Nov 2026 05:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drifabdelmalekmohamedsaid@gmail.com>)
 id 1xXFi1-00043J-52
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 05:31:09 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <drifabdelmalekmohamedsaid@gmail.com>)
 id 1xXFhz-0004Jq-Dv
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 05:31:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso108844745e9.1
 for <qemu-devel@nongnu.org>; Sat, 28 Nov 2026 02:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795861865; x=1796466665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ytyWyrIlAoeO7V9N/lfLSv8jibtFa9CQeG8gEGhcIPI=;
 b=fq3RUXsNsTLuLCoTN0MO0RvhViv9e0Fasf1NLu0am8BlS2/VRwEJpUm2wHczAnUEd9
 mA9jf2Xh4vw3zkEvDySG6EgNs3qZcigwBPbnvWNjSFTbg9buPlQuoYCha1SQn3QlRZ+S
 q4ESZm1V03hWUYqbnrIbPBUZVEKKod2BzHHpAZmVQP+grysNNi01reNUdgYxINO21x3S
 lCzWwySBnQmWhsDlV2Bx54YKzKsliXR7GflDK3fFxwaoAO6GJuIJ2PG+I3CMrTgrS7JD
 Z1ww12kctCYSZGmJBXhs0/duzUioHXekox2BKskLdeCsYY6COqKayyBhGL9fOquXHw6Z
 qcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795861865; x=1796466665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytyWyrIlAoeO7V9N/lfLSv8jibtFa9CQeG8gEGhcIPI=;
 b=rB23JbGdZk0xqedPyO8U/dC5d0a9C6DHu70oK4fqnMtSs+euTN9QeideGECOsJ6JTC
 Bkzn2PPN4dK83RQ7GDguRRk0PFkS2lCYTO0MIZ0+OszOUkUsIZMlsZCSNJmR7PxzYOty
 +/g2tiZ///5xMcCt7CRzwIyp1AOML/bXPPIiGAf4aFBB7DfqMZ9lpPbhWS2ryL5enVEs
 R6A3CF4watnVTkrRGty1sm1FKIx1k1aNUCIM1qevEuCfdSzHpp4I1BP3rJvIABS3yE53
 Hj+vNiEDGMt82rkBVwnhue+gyML7/8cAiBIN9rErCnkdVeHsj6W41w2daPp8bHofmC4y
 0HYQ==
X-Gm-Message-State: APuU4Z8UOKkradS7ifG1x765GLT8XTIz4XN/zq/unFgFfDrd45hp+70L
 gdjlu5ViHx3Gjf4MjDyyPwtzVE0ZGwaD6ddq5bL2TWVG2jPa1qQVqpxmGRwfYw==
X-Gm-Gg: AZFdTZffRKyH1sjj78O58YfwRt70QHF8giBQ49KkDiObQ5eVN1f/vv27cb/fWBM+fGm
 czheoTOfuMiPDZCu04vWBcMjQVu2k3mKLZTxv6FJwk7p2eUe/6nF4radeK5cQp+v2+aST1M5lZR
 vvTUmXNVGmNICorZTKtoczouo8CsfMKwkMVHNdUOUR85PLr9kjW1bJmRWnQomkgINlDkA6zAPne
 yVCMH5SzCGFscMgMDWuTSBBdt3ejG+q7GHxD3o+OeAPLTVCHKt8s8yZGM8N6PP2bKuhLJFxNtFo
 9XMytErcRNBQNs/8DkLrLr3K+YvEVI+T04vQabtRwyj400lZ/uhHf1W1n1hOSsC8+fHpyAbNGTh
 XzIR/LBDkRXavlkjd85InQ0BXzAHfgow+FgAW+kKgIaPgtpDZudRG1yo+Bvs+HJ/8qM6LXiWrY/
 A6ZB8yEgsgbBa1BlJ6pnLtNHiQ8PE4F8BrjIlr9WcT07lyulxnbSafAd2RWM+dANel0vUVhQryU
 oN72HeMrKtSnl9p/45lz4WxfxQ0stwARnTqA2IB0aU6/M3fbcmjbrzuG1679T7sQs2B435xTDY5
 TQbQ+CobEWYEYtsltn9hjTOnkkXZcT28djvJIVsVCF3L4aopFn9yK5EnXpOYHf0/IfDlJiD6332
 hlh4nV7cDJg9LcZJogzxB0VfyGI1C8Ud+
X-Received: by 2002:a05:600c:a087:b0:4bb:5c92:ce22 with SMTP id
 5b1f17b1804b1-4bb887fe887mr550914855e9.8.1795861865171; 
 Sat, 28 Nov 2026 02:31:05 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([105.235.131.156])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f1489sm508903745e9.0.2026.11.28.02.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 02:31:04 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH RESEND] hw/i386/kvm/xen_evtchn: use lock guards
Date: Sat, 28 Nov 2026 11:31:00 +0100
Message-ID: <20261128103100.357-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=drifabdelmalekmohamedsaid@gmail.com;
 helo=mail-wm1-x334.google.com
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


