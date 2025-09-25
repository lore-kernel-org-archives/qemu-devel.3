Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1133DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1lyn-0008QA-C8; Thu, 25 Sep 2025 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CBrVaAgKCt0YGTXHEDHFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--zhuyifei.bounces.google.com>)
 id 1v1jGJ-0006pZ-Sc
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:44 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CBrVaAgKCt0YGTXHEDHFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--zhuyifei.bounces.google.com>)
 id 1v1jGH-0003Ps-Dh
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:43 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-33428befc3aso960063a91.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758796296; x=1759401096; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SENrR9IBQB26yG3dhbEdUf0q9fDrxQ/WMEddajrDBPc=;
 b=hkj+D74fR4WpDB4Hl8zDj8IELqbbowi5oJ1dqOYsWM6CJfXZE+pJxh24BAEaR73lwk
 nyX82Acr9FAbG+2a4ueLnKKG5lgS6OGshGxeBhvt8nFCBcP+jKvTMQpiAesMZjC+V5VI
 pjoQLj+rZk9TOYwp7wjWevFyeonS7ZcnpUgBp04Eb2ITAGbUY4sp4gncEwXnuKeLzobY
 SxmVrkjPHmgykXAG1jQlAD5ClJz02iT1QCWQFE200hg8Yx1UscDudZ2MldwvFiY4yOSV
 ndUme3YMnF390NV8hffGM8bOtyeNsFdnZz6BFlOfpWGODIh3zS+0B8XSNeOgv1dZ4l5C
 23Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796296; x=1759401096;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SENrR9IBQB26yG3dhbEdUf0q9fDrxQ/WMEddajrDBPc=;
 b=nakVtPMkah85Ors46V77lDaEl1nIwIiL47pKUAXzi4puaM3LZ5S/UIKlIYKp96oghs
 g/c9MG3uMa7bu4I/H7++Fwu1Ux6A8Xcq1vmfp6k5YRs+K16kX+fo2wVRfh4CD9olwrwp
 Oja/PbUS5j74z1sfwJopFFjb6AcBYqg3vQIUHuEZoc9BXIruxfQZ5vpzBLasBxQOXQ0Y
 Ai/336eTFLjfSa8r1h3GOZNlANwPHq/zB4z2pdSThq4/OpdMMKiYn4w/w2fbUgXEy2GH
 CiHX9nTKrOq1up8my01mRMCI36HvPvP8GIetCCes29cCRgH5rg1+Cgm8ZxTdD6CsZfjj
 jN0Q==
X-Gm-Message-State: AOJu0YxzN0+DwqHKlPBQOnmAVptegjaZApOn6S7GQPvMu9IvT98HAuGs
 j8+/joue7T+X4DJ7ByB5hqxP4cdH3tBytGcJy4m0apfDInmOyqgfihSeMcGirxw8UmWxTj17OA3
 OkRaUjS+tc1prvmyoIflBofjZ4jbQo+ZshNtojolJO3QDbXZau3QStq+zWQBDEv0q9+0Up1vAP7
 jk4pQR30g0f83GYYOR1lX6bw4unPtV0TawCb7UKuSawtbb9g==
X-Google-Smtp-Source: AGHT+IEGBXFWs4pspBuYxCzTpiDHTqgxyiebOGh2LayUlgpPrKui8nkWTztN7hJC+3fB69+qfE3fq9pFfNCoJQ==
X-Received: from pjoo14.prod.google.com ([2002:a17:90b:582e:b0:32b:ae4c:196c])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b4b:b0:329:e4d1:c20f with SMTP id
 98e67ed59e1d1-3342a2595a2mr3277634a91.9.1758796296242; 
 Thu, 25 Sep 2025 03:31:36 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:30:56 +0000
In-Reply-To: <cover.1758794468.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1758794468.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <ca9b26db036fe39ffcb2ebbf7b8629b08632b8c2.1758794468.git.zhuyifei@google.com>
Subject: [PATCH 1/2] i386/cpu: Prevent delivering SIPI during SMM in TCG mode
From: YiFei Zhu <zhuyifei@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-stable@nongnu.org, unvariant.winter@gmail.com, 
 YiFei Zhu <zhuyifei1999@gmail.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3CBrVaAgKCt0YGTXHEDHFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--zhuyifei.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Sep 2025 09:25:43 -0400
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

A malicious kernel may control the instruction pointer in SMM in a
multi-processor VM by sending a sequence of IPIs via APIC:

CPU0			CPU1
IPI(CPU1, MODE_INIT)
			x86_cpu_exec_reset()
			apic_init_reset()
			s->wait_for_sipi = true
IPI(CPU1, MODE_SMI)
			do_smm_enter()
			env->hflags |= HF_SMM_MASK;
IPI(CPU1, MODE_STARTUP, vector)
			do_cpu_sipi()
			apic_sipi()
			/* s->wait_for_sipi check passes */
			cpu_x86_load_seg_cache_sipi(vector)

A different sequence, SMI INIT SIPI, is also buggy in TCG because
INIT is not blocked or latched during SMM. However, it is not
vulnerable to an instruction pointer control in the same way because
x86_cpu_exec_reset clears env->hflags, exiting SMM.

Fixes: a9bad65d2c1f ("target-i386: wake up processors that receive an SMI")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d85149e6e..697cc4e63b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9762,7 +9762,8 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         return CPU_INTERRUPT_POLL;
     }
-    if (interrupt_request & CPU_INTERRUPT_SIPI) {
+    if ((interrupt_request & CPU_INTERRUPT_SIPI) &&
+        !(env->hflags & HF_SMM_MASK)) {
         return CPU_INTERRUPT_SIPI;
     }
 
-- 
2.51.0.536.g15c5d4f767-goog


