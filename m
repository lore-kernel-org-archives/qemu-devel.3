Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D113606A328
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aVv6hNdl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIHJ-00008t-1g; Tue, 03 Nov 2026 12:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIHA-000075-Dq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:26:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIH8-0006Q9-HO
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:26:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so9719115e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793726781; x=1794331581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FJKfVYm6VIqMavFwLhCg7yl/Tg1YqwuMPiBUuINmP8s=;
 b=aVv6hNdl/k6UMSq2E8XU1wIe3GvAjdC8Vwfyc94ff9J8CbCiql6Pv6lcAMuAIUjye0
 ctC67Jgf/bYp6Wi6oYbwFk8JxwzWuVpaeOsrkhMS2QQrPbNAU5VAeduzZn8E+01x77fn
 n+oEncnXkBXd9/VYyf7+lCiXUyAb9db1aMENFoRHxzeshzVjbh3CQJj2z6Htuuoc2dZ1
 tcQ6W/H30VUAEUeTGEtBZriLznVRPnTYj5SU4y4Mfh7mdc0f6G/Nd+X9N0j2VqcFYZeC
 juRcPa0B5SKM7T83L5Tp2dZIw/DweiFQ+9NQTX0IAGPdBduo5pvl2YmprIjcCqQBaBOE
 fQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726781; x=1794331581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FJKfVYm6VIqMavFwLhCg7yl/Tg1YqwuMPiBUuINmP8s=;
 b=Rgd/j2YZ06AKGuaIpRj5II8zp0bPTQIS18GzmUPbi7TBXfuXpvx/XQQYzJPAUh/JGk
 hr36ms+2LFhrxZTzrmDNUEL/pbix7u1/2IbOkSiR6h9j88+rdC0VDSh5TUh4DAmWV+Q0
 Mz21jU6Rj3CIBq+vQ+fdtIN5c8c2vJylP6ltG8Hc7qGLfLPT9SAFFbwrVzu9d2L56fFs
 pFmFc0KOfODuxuyXkcN2aO8Zc5mJ4v+mQfy4DU2KtKlrWQvHAF+1VgJnrQjopFe/oGuX
 sIlkxKJaMd/b9W8F9G+6aVtq/fDikOfkceYVm3Ta4nm1P15/F8aes42uz39v9GNc9sQE
 UOIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR1orld2KxF8aN0TN7PoJ7jarKpFZc3kCS5FJlAa4JaznSlvN1kRkplaDhdaRryMslm21i86RICMe4@nongnu.org
X-Gm-Message-State: APuU4Z+sZa7sjrbZp7NjHRgrIL5XjhUbPEOG9S5D/ZFq8U48Qh9gHM+r
 0UzyL4BvDlswljuhM56ieF+Lau60BDZn7uHfveLL64ZoYt+elnejH74CWXBjTaOo8FM=
X-Gm-Gg: AYBFou1R+LFWLfVk95CmHUiHJtcN/tVvjq6I5GqkcDshqeJTTzgpe3TjIKi/qAgumH/
 ks5SN++SD84W6MWDoxr3oOrEoZfK8IA5mxsSsLUkUMZSehM9Jjek2Mo59raOamdCP3iPSUHDplK
 BWjUs1ECrn6Vmi1Ny7mtHXz5iFW0MM19F2I1vkJT5PbbsTXw+Q5oCzN7vZnuaEyn6T112oR8t6Y
 /yawAsVOBVdgwm35hIdNZJUT3BDi6wK7/OQpYJz454Z676sOKq4C9mzRXRyeQ3m+T+Q2RycONcT
 3eK6zsixe+9nEFkaPcrxXAZKoEFr1cD2B4C5MAl0vJp+d+AC30hkNrfcqE++ixQomXYmQsA7Evf
 01KotUNDqYktYPq7Pi+kVKnAbuzj0BVNfcOFgwnwza1GnaO4eWSHy7tbnF1QzQLxqi8d8ZP23sR
 ca2366AleBk9Q20Li+EHAHkpb19r3jegnLSxZE6cepVud+z9HDiIM7oWBpCeqMeqFsDD7sFX/T+
 qqao6V5cEIaVRGZheRg/CC1KM6h928xcIHThkbnCwu0FURdxaQsIxz2LeVx4W+k/IIgagsoI8/g
 cVbXCYe3Cp5M0UicFHTynRbDecNQqLrlR6W1CjO4VLQvNzTE/Yk+U+CH/aMeXgsIaAdJlZcQEv1
 E8rYAjb/zgcRF8xAxvai4u7SIDNlz1in+Lw==
X-Received: by 2002:a05:600c:64c9:b0:4a2:180a:3417 with SMTP id
 5b1f17b1804b1-4ac14dd1debmr327086745e9.1.1793726781071; 
 Tue, 03 Nov 2026 09:26:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0950d533sm211082605e9.3.2026.11.03.09.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:26:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.2 2/4] hw/intc/arm_gicv5: Free memory in finalize
Date: Tue,  3 Nov 2026 17:26:14 +0000
Message-ID: <20261103172616.2400758-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103172616.2400758-1-peter.maydell@linaro.org>
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GICv5 allocates memory and creates hashtables during realize and
as part of its operation.  Free those resources in finalize.

Since the GICv5 is created at QEMU startup and remains in existence
for the lifetime of the process, this isn't an in-practice leak,
only a theoretical one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c        | 11 +++++++++++
 hw/intc/arm_gicv5_common.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d0a8574916b..fd6456cd8aa 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1970,6 +1970,17 @@ static void gicv5_init(Object *obj)
 
 static void gicv5_finalize(Object *obj)
 {
+    GICv5 *s = ARM_GICV5(obj);
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        GHashTable *ht = s->phys_lpi_config[i].lpi_cache;
+
+        if (ht) {
+            g_hash_table_destroy(ht);
+        }
+
+        g_free(s->hppi[i]);
+    }
 }
 
 static void gicv5_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 2920b11cc39..cfadfee4f05 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -112,6 +112,9 @@ static void gicv5_common_init(Object *obj)
 
 static void gicv5_common_finalize(Object *obj)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(obj);
+
+    g_free(cs->spi);
 }
 
 static void gicv5_common_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


