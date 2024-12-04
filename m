Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA4E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl4A-0000HL-Na; Wed, 04 Dec 2024 03:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eRdQZwgKCiocNKTJXOQMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--whendrik.bounces.google.com>)
 id 1tIl48-0000GO-VF
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:49:00 -0500
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eRdQZwgKCiocNKTJXOQMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--whendrik.bounces.google.com>)
 id 1tIl47-00012G-EE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:49:00 -0500
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-385dcadffebso2475724f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302137; x=1733906937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=sAy6WBlDUJU2NNDa5pmhSI6Kdop6GN6BvVyL+oarK/U=;
 b=oaLTPF1xiC8bS+WUy8UH1tZgE0o5SA+xvdewouQEZYZ5YdBkmuVS16bmoSOZcHvB2X
 8rf5xEUvqxVHvHCA32CYHvhCcOMp4zkpW/bFln63bZoPSNWRwmXdDvxnnYlEii7TS7Ap
 LypOqm0IETNhVUu49c6wbfWeIbGY/gNCQi93U0vA774HOwV03OMQjWsbV7AMLD4/kudJ
 5Dm1Wy3RW86ANAd4taVF52IEoUm/+Z0ieoFv961vyjiCcTvo0wOsofhKzKnOVgFNWhqN
 OHgO9ui3MLdEcre0jU0g0Ec86x67fQ1PhbLu6i7N1uqriD2Q2P+2U5ct16Z4tEbZZIxx
 9CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302137; x=1733906937;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sAy6WBlDUJU2NNDa5pmhSI6Kdop6GN6BvVyL+oarK/U=;
 b=KjlIV1H+Exzx3g0xReLVLj9fVB4EBwGsASvpNQxVSNSuqT8YKSyLvnBr8/CVfcyK9h
 ApwPuMYAxMK1kjhx65Dum+beynV1zgxSPDRG9gDWpC/Gi73hhAfjpWX+CcDTtPYJR4QP
 x76Qn1diZHBbtMPH5h7YvD+G+uUy8dQaSd4OEbn88wv9jmsrVjA+gaG53EvCB3RETtK+
 RP2GkxHODhtcxwebjM2JeCB1hWJ9WUujnnNsUMZ4jXEk24EK7Jsw/qTLFgbWkwph4SS0
 38dgqwZsTNWuVhgPoUxIDGK15fLlTo3x6uQ8+568+ZCAa5QGm7IbaqWuT+mVS84PgI1m
 dlCg==
X-Gm-Message-State: AOJu0YxRUQFMxONM1cQxnS3hfpB56R+l2NDJvPhcFSt0QSuYXxU+y7Dp
 Zf2b+G5BduGhE2ShgbVnFZXqFYt09KlYspBF2tlPzTa1BabxV5ajus7qagrn+B30FnjUNWyB1zq
 ZE73JCgifpmEFB2qcENYvcGM2eyHJOD7NpC2qZCG/dceGthSBJvcp05orc5pxbLt8iZSH6IOrdJ
 3jYRwuZjwgk9K04CmTU197fkAU0Jbtsirl/VCll+5ywg==
X-Google-Smtp-Source: AGHT+IHeOcCTN8SgfHSKABPFP8lqTxjMXzScT7YaQJKMdLftVPC0GriXpqh96Js7Hm4qS63zJYiL1UjAvBf0Pw==
X-Received: from wmfu12.prod.google.com ([2002:a05:600c:138c:b0:434:a7cd:517a])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:648f:0:b0:385:e36a:e19f with SMTP id
 ffacd0b85a97d-385fd419194mr4068540f8f.41.1733302137330; 
 Wed, 04 Dec 2024 00:48:57 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:36 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-8-whendrik@google.com>
Subject: [PATCH v3 7/8] i386/cpu: Adjust CPUID level for RDT features
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3eRdQZwgKCiocNKTJXOQMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Adjust minimum CPUID level if RDT monitoring or allocation features are
enabled to ensure that CPUID will return them.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index af1da35985..a400839216 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7568,6 +7568,16 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **er=
rp)
         if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
         }
+
+        /* RDT monitoring requires CPUID[0xF] */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0xF);
+        }
+
+        /* RDT allocation requires CPUID[0x10] */
+        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQE) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x10);
+        }
     }
=20
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set =
*/
--=20
2.47.0.338.g60cca15819-goog


