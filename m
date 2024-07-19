Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40605C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVQ-00048s-HI; Fri, 19 Jul 2024 13:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gpSaZggKClEF0x6wA13z77z4x.v759x5D-wxEx4676z6D.7Az@flex--whendrik.bounces.google.com>)
 id 1sUqUf-0003ap-0U
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:05 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gpSaZggKClEF0x6wA13z77z4x.v759x5D-wxEx4676z6D.7Az@flex--whendrik.bounces.google.com>)
 id 1sUqUa-0004bA-Sy
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:04 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-3684ea1537fso718509f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406594; x=1722011394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=3IYirU62feuJ1ii3Lh9tqpIeml1xUoS8NGP+XxL/lvo=;
 b=ZplJx0VVxk7ZQiSUz/Z5pFOjPS0fgMiRq4gAFuotP0g0KwktMUIEmzQtnkypN2uOKQ
 Kz+lj1vJuk1qUKmkypMx6ldwJXZi/ThF8RRl3M2wehT7jGs7IeESFN64hn6BrQCQzUpE
 +7EYf/+OHbvXbaNzZdsrE3Yd4eOrEHVh94CF/BgHH1zcqUFtBMa7ovtDAw2VrbkYp8JB
 +O8nauRoehkLbXhAAqTmMBvfHW2D0zYzpYzxbOUI3mJVL64c6oNW7PMN0u7BqrTgWVAq
 LgJ9m2ZXSAHM8oRKy7M+p+tCe1W4QPBSnrOBZMBqj5CXIxlYYRpOJJsxZWF/uALJq85D
 +3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406594; x=1722011394;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3IYirU62feuJ1ii3Lh9tqpIeml1xUoS8NGP+XxL/lvo=;
 b=TlTcweyMxYvz7MCdJEF9qLCQWbTXVXDr397ktoaXrxMa4+9GxXgVAVaWYW4oLQHyEH
 9WFHs1YmW7IfDzrV4cFEme3ASSfRHOlR/m08RM1H4h+9jK4MGkesV1ZB+pG1Y2jmIuun
 PY3k6D/v9lYS5F1qR3Od0zT8zadyjGR0RMJdIUT8MJArG783z1avdAj7LjPX2ZMiIsxd
 J5RzvBP5WkWrsuN8ZVp8CCMfq1C4ThG8mnGEKW1BkbZx+kTNuTVV1WsddfRdoC+cOjqR
 4eZ5LqRkLqS2W5tvFlo9arUKy/JITrGfJeWzACS7bpe7dr8HNIIRsTWeqGB7JS9UMfYF
 0DRA==
X-Gm-Message-State: AOJu0YxfIX1n8fKH4+tzMWK8EhfxVq3cOJ4XSz9+L/Mf2Urp2bIO7zBk
 B+UF0QouldEwqIPYbpaoIp/9WDCMGp4RvA50sqtZ/5H2E3t5AFmHcI036J/amnqfj3eSYYqIkF3
 3SCt0hdeDF8QNOdMms8cCGOxxPxGuWMZKKNyno60hdbzOaXXdZ+dfSU/1SQ4zw+j7YvWkKagCHB
 23hMCnesHf6zuv/o/q97+YEJNnrVztgGDKv3JyB051sw==
X-Google-Smtp-Source: AGHT+IH3FRwhAEpx8HFgxj/VDYPFO7B2fvunfDp1Bsu2LtKemUUmq+tyzuMdrrsOmjvi84Bvmas+tj6G4wL8jw==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:6000:107:b0:368:15ab:20ea with SMTP id
 ffacd0b85a97d-369b6797e8dmr97f8f.9.1721406594224; 
 Fri, 19 Jul 2024 09:29:54 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:29 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-10-whendrik@google.com>
Subject: [PATCH v1 9/9] Adjust level for RDT on full_cpuid_auto_level
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3gpSaZggKClEF0x6wA13z77z4x.v759x5D-wxEx4676z6D.7Az@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:50 -0400
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Make sure that RDT monitoring and allocation features are included in
in full_cpuid_auto_level.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 482f980a1f..6f5594d3e2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -875,6 +875,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
 #else
 #define TCG_7_0_ECX_RDPID 0
 #endif
+
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
@@ -7548,6 +7549,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **err=
p)
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_15_0_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_10_0_EBX);
=20
         /* Intel Processor Trace requires CPUID[0x14] */
         if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
--=20
2.45.2.1089.g2a221341d9-goog


