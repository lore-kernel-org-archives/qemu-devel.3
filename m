Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F755606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tmL6/ZkI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5RF-0001bB-KR; Thu, 19 Nov 2026 11:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5QP-0001WG-9y
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:55:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5QM-0002jA-RV
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:55:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so23670205e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795107348; x=1795712148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xHpJkOyP9xOQShQJ1+9T14i7Dxot0L5OZKDQXM6lmDA=;
 b=tmL6/ZkIM9nz6p5aiLm9exOdGlmVm+8MPI4Y8nr6Cp6aax9A6l9SlQmM1iVcYrvt/c
 4/l7xlTZ9ipzKIUgnak2rYzc+IW+0G2L/hZKeuCybbElbWa+Ba9zotiRRLsEeDX3VeOW
 T2v+KeIEZHAieXKuCk7hG4F3m/F9GePrvnraMgYK8/De5J37lr0DKVPOvsReTqXokyBB
 HJVgppikOZZqvjPbtRgc+Q/cBRxfAv+t+d53x+W4ofvPfQe6EF4XXhZsD0JBAnO/pdzI
 XrJcBbFOkv/W3+A/PkFSlC2J5hJVJQgeJF0cc0GLcu2r1LGnvoV2vm07nWeTDqYfmFFe
 3c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107348; x=1795712148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xHpJkOyP9xOQShQJ1+9T14i7Dxot0L5OZKDQXM6lmDA=;
 b=24RQmHV7JelbqY/pQwHgkL2mOLlBE2Exq5ViQ6nf+uJNEVQU5lLRXmGQaQ5qqRa9+7
 nC/PwWooUfZi74BCmOM9yLE+ueOGnRWwvdDQkv3jeR6aBTdlNcyzr9CQuvtcVR8OSSBC
 bAJ4FYu912UC6Mz+e053A0ApGeQxJu0iNgOsyX+56RCHQynQdzL7GsNJJJg/VMyNY4Rd
 /QOxz77orK+KHpt3CuGIw33KaqRcQIzoAvN6ewfS4FICJQdVOB+en+3jD8vJwfcNK+sW
 GzWCMjwQOdVEyc0kn6e+h9nOSzKdnXEMWVu8is1RJkh3nxX50JxW8+/cZKFtAQxqpOTc
 +0/g==
X-Forwarded-Encrypted: i=1;
 AL+hErF+cVUOQ+kf7EydxBMmC/H8qbnJdelXg/lPcBsl5vk9WNzAIcNihmKjtpAj7CS1nY089wjHWLRn1I55@nongnu.org
X-Gm-Message-State: APuU4Z/eNvy3J8HRUhsiYTPOmfUwRUVOcfnZ17wEm1tG63jJquGDvZlc
 +wFqLpGH01EGrfJYsUVXT0OT4MRLzLXrOE97v2Pwu0htGfP0p3vFrhG97s6XScrGlAA=
X-Gm-Gg: AYBFou3O9U30kofFGclnW2cye6DPSLh7DZcT9fEgvf5OopCGsxBga0BTIGr/fxOI4Sc
 CNJG7ZiBmUsbnGdGtv6SdDSSsWnZ1QhsBLcJpoz4qGOl1+LJtMpoYNF3/GMWaJCqJv8pHRo1FcN
 HsLUN1R7eb7GSAufFBOs/ZUReotqPmstxOZBUuK1RZS0q81IPtO7IUo/5+qgejU82udFr0QKB9C
 rDbN8W5wJPMwfupaIjWYkasmw62yriPmUQOrtZVKDcAZg8KFqPr+BEE3hABGf7J3izPDEk4UjJz
 zdWRRWBnFzgoYGXw023vWf5MqmGUmhMQq10BYbhRfkNbP+ceWV6CaoIYpKj8r02/WYd0n0AcwC2
 ThZ0n2zWA2/T1rPxJA3r/XTJO45eKVz0kwKEsJ60SJqcf+YI8ldjTQnt+wrb0/5AQtZybbuzDqx
 O4f9GsVz1anKr6h0qOaHEF7MtCanVct+Y8ssvzVGNREOg3OVg2J368L0mxHUEQjjNwYJ7PajNge
 UbC85x8kyxZ642NjERU0TKSRZf7pmCdXVMdWz1hOkw3aFMQh+vkC6kAy4bhrNBcinJdsJkoYdAi
 mOAGkEfMUETpaeF/cDDQl3He3KQOQhxbe7zLpKHa3QMqm4Fss/AczHmGHKrE9GD0iQAORr3hMVY
 9J6MC5doU/bXcwZBawuL56jwtAT9SsHN+MQ==
X-Received: by 2002:a05:600c:1c11:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4bb8881c357mr1864925e9.26.1795107348172; 
 Thu, 19 Nov 2026 08:55:48 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm9522665e9.8.2026.11.19.08.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:55:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH for-11.2] target/arm: Handle "PMU disabled" in migration
 validate functions
Date: Thu, 19 Nov 2026 16:55:46 +0000
Message-ID: <20261119165546.3050013-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In various test functions for VMSTATE_VALIDATE() fields, we check
whether the migrated region number register is within bounds (i.e.
less than the total number of configured regions).  These tests fail
spuriously if there are zero configured regions, because then "x <
cpu->pmsav7_dregion" is always false.

When we allowed v6M CPUs to have PMSAv7 in commit 157f6c69edd06, this
exposed a bug, because we now have a CPU which has PMSAv7 according
to the pmsav7_needed() function but which is configured with 0 PMSA
regions: the Cortex-M0.

We could fix this by having pmsav7_needed() return false if there
are 0 regions; however, the cpu/m-security vmstate struct does
migration of the secure equivalents of these fields, and we also do
a VMSTATE_VALIDATE that checks against the number of MPU regions
there. Making those fields be migrated only if there is more than
one region would be awkward (we'd need to pull them out into their
own vmstate struct), and it's unnecessary -- migrating something
that's all zeroes and not used isn't a problem.

So instead we relax the checks to handle the "no configured regions"
case, insisting then that the rnr field in the CPU state (which
should never be used) is zero.

Similarly, we adjust the check in sau_rnr_vmstate_validate against
sau_sregion; this one is currently theoretical as all our CPUs which
implement the Security Extension have at least one SAU region, but
architecturally it is permitted to implemnt no SAU regions.

Fixes: 157f6c69edd06 ("target/arm: extend PMSAv7 support to v6-M CPUs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index c3aef3f3301..d624425c0dd 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -593,7 +593,8 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion;
+    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
+        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
 }
 
 static const VMStateDescription vmstate_pmsav7 = {
@@ -693,14 +694,16 @@ static bool s_rnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
+    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
+        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
 }
 
 static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.sau.rnr < cpu->sau_sregion;
+    return cpu->env.sau.rnr < cpu->sau_sregion ||
+        (cpu->sau_sregion == 0 && cpu->env.sau.rnr == 0);
 }
 
 static bool m_security_needed(void *opaque)
-- 
2.43.0


