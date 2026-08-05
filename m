Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD61BC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfTQ-0000gJ-C0; Wed, 05 Aug 2026 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wrfCw-0003yz-8x
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wrfCu-0006Cd-Al
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ccdce28edeso1958745ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950106; x=1786554906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oILwzWuvctpkqfsV14fEATGnSgvAGf1HgOWFjcVoTqg=;
 b=ZVgkwA/vHIZSP6YeeINfb6puXhwolIBS5WPcE18e/LFtfbLLvJ49l+gkkMXEjAxMZG
 qlwIknXLhZs6DDb5D6ZZjn1JlYPeui0DyVKaTTx5b8HVzWfdefYtTb2/uMvb7/atpg+T
 Aw5MlBR5pTYieSbgbbij1ojzMOcGVpWZUzjEG0bU1z/XAGloyP++fY9CAc3RJgISjw2t
 iknooYicwhc3HFgb+lppKhRAicxNijSm2sDcqjitA4D4zJY8mCyEE46prNur1vYCEhZB
 DvJ/wRlsSJgNfVYUzGGoyVdGDFWrlWKaj7MPhi6kLqtOAYDqqC/3zJb5GyBAZhdWrqf8
 biTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950106; x=1786554906;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oILwzWuvctpkqfsV14fEATGnSgvAGf1HgOWFjcVoTqg=;
 b=NDMxcPe12IUjujdKfUtFs6rgcbXqdHInaDRsvVpKdXP0ruEtW3OE6LkOLykI2qHwd0
 5JYQC9FO7xII1PxDbDyApJdjMplkCcGmgdckEw0VS8U0Dgtk9jUYP6OpL6zVOUXLuw1I
 HhwyZ5PJWI6HnMZV8Ge/xUAUGicK371BKYnjBsTc0wJiJGJ+0at+pOeRwqX94Mj7UVuy
 qyCqmZIqZN60q4MH/47yQBdpGfUA23E9S/3MAo4sTR3Vi1sGpv89t7LXUH0G30IMwGg2
 4F4VXIkBBMP15RqK8QZFCcubymrIgNN3l0jIOV3ft7/fohGqlDU1e/YvxwHD/SwjiZlv
 oYxg==
X-Gm-Message-State: AOJu0Yyg2OVaOnt01S/XRvbazFr0UiAFbVpJmBy1c2thKTvfJuRk2vZl
 wOZro55tIYq7as/fBrYc/maaT8Bfw2Cb1SCZ92AWqMv3i3wyNNYV3n9dNjebuBEI
X-Gm-Gg: AR+sD13mC8vSWsBd4tSucS+TDAJca3GqNeRRQ9PSCjNx+nS7/JMf27KZUb8QuRrNBh3
 wRC4LBiMsK/c6rH/ZkOX9oNgbyK7D1IrbdUdp2xWkKfmrS1chin4Kd0qw4LAqxLmuhsfia4sz3k
 IKruzJExFsFFMuALF9a5U2KnJMppdtnTMGhKwXlumVuaH8C0HuWBX0m+7vRQ7mMuboafI9jyDCq
 YchQ0KSi4MxBeXdKClMKTJGeILU7i2kNglwvJjHAXVNqc0rayxaDl8Bj3MNTqobHlkXsQ3yj5bI
 /dBmtq0OhNPDBKFmZn8vkRrcqRyHbnO3ooRIlTdIx7wkDAKTPaItgxhqCrM/3kBPIjpTqAmGmVD
 Og/hcOeF+s76K1BFRQgS4MBGk7fUeU3jwFIde+M/wSIBGDWux49ua7I+YX0e98UEBWDC7Xug9tL
 mT9Ne0fUsE3Eos6/lW0D0V6ZF0Y/9fWTem6tO6l/GrCljaF34wCdkmYhPZugPoIiFWIBTt270+7
 tcoWZGCi9gJykc=
X-Received: by 2002:a17:902:dac3:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2d0ca158b88mr64499605ad.0.1785950105505; 
 Wed, 05 Aug 2026 10:15:05 -0700 (PDT)
Received: from fedora ([2402:e280:2177:35:a77f:15f7:4845:1af9])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d0d118a2dfsm6202185ad.28.2026.08.05.10.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:15:04 -0700 (PDT)
From: Yogesh Vyas <yvyas1991@gmail.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org,
 pbonzini@redhat.com
Cc: rathc@linux.ibm.com, anushree.mathur@linux.ibm.com, npiggin@gmail.com,
 harshpb@linux.ibm.com
Subject: [PATCH 1/1] tcg: defer tb_flush when initial region alloc fails
Date: Wed,  5 Aug 2026 22:44:53 +0530
Message-ID: <20260805171453.25940-1-yvyas1991@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yvyas1991@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Aug 2026 13:32:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Under MTTCG, busy vCPUs can temporarily exhaust the fixed code-gen
region pool by holding multiple regions. A newly registered vCPU
thread that then fails tcg_region_initial_alloc() currently hits
g_assert and aborts QEMU — seen during vCPU hotplug on ppc64 TCG
(virt-type=qemu) with a large maxcpus.
Instead of asserting, mark the context with tb_flush_pending. The
first tcg_tb_alloc() returns NULL so the existing tb_gen_code path
queues a tb_flush; tcg_region_reset_all() then repacks the pool and
the new thread obtains a region on retry.
This mirrors the graceful exhaustion handling already used by the
runtime tcg_region_alloc() path.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/2984
Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
---
 include/tcg/tcg.h |  9 +++++++++
 tcg/region.c      | 15 ++++++++++++++-
 tcg/tcg.c         | 12 ++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7669dc1c2d..8a05e3af7b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -381,6 +381,15 @@ struct TCGContext {
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
 
+    /*
+     * Set when this context (a newly registered vCPU thread) could not be
+     * given an initial code-gen region because the region pool was
+     * momentarily exhausted by other busy vCPUs. Rather than aborting, the
+     * thread defers a tb_flush: the next tcg_tb_alloc() forces a flush +
+     * retry, which resets the region pool and reclaims slack for this thread.
+     */
+    bool tb_flush_pending;
+
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
 
diff --git a/tcg/region.c b/tcg/region.c
index 5d4be1453b..1200947385 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -393,7 +393,20 @@ bool tcg_region_alloc(TCGContext *s)
 static void tcg_region_initial_alloc__locked(TCGContext *s)
 {
     bool err = tcg_region_alloc__locked(s);
-    g_assert(!err);
+
+    /*
+     * The region pool can be momentarily exhausted when many busy vCPUs have
+     * each grabbed several regions during translation. A newly started vCPU
+     * thread that cannot get its initial region must not abort QEMU: instead
+     * flag a deferred tb_flush. The thread's first tcg_tb_alloc() will force a
+     * flush + retry (tcg_region_reset_all() resets region.current and
+     * re-packs the live contexts), which reclaims that slack and assigns this
+     * context a region. This mirrors the graceful runtime path in
+     * tcg_tb_alloc()/tcg_region_alloc().
+     */
+    if (err) {
+        s->tb_flush_pending = true;
+    }
 }
 
 void tcg_region_initial_alloc(TCGContext *s)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1e77f2365a..ea66fb6f84 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1830,6 +1830,18 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     TranslationBlock *tb;
     void *next;
 
+    /*
+     * A newly started vCPU thread that could not obtain its initial region
+     * (region pool momentarily exhausted) deferred a flush. Trigger it now:
+     * returning NULL makes the caller queue a tb_flush and retry, which
+     * resets the region pool and gives this context a valid region. Do this
+     * before touching code_gen_ptr, which is not yet valid for this context.
+     */
+    if (unlikely(s->tb_flush_pending)) {
+        s->tb_flush_pending = false;
+        return NULL;
+    }
+
  retry:
     tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
-- 
2.54.0


