Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WWb7G9Ma
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaK-0005Bj-88; Tue, 24 Nov 2026 08:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaD-00057h-Kt
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:18 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaB-0007OW-EA
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:17 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so615510966b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526954; x=1796131754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J8wsbkDP/3WIoccwI/mam++6k53VGq0BvLwtvcHKec4=;
 b=WWb7G9MankpzSxx8yeFM14JxOovOi68gRwBNDudGuhCRCqJAdMpk4c0oqs3fPjK7yg
 pj/8f0EdBNITrbbmOWUiERIfATIJsu/d492ciXnbC3aI1o1i8Nz/wuglIg+RZedjjeDW
 HaCpS2TwNaPSIzVLucLTr+iLaZQyh1lFm6IoTn6eMSTnQO5V0Jt6rHja8/+bXXErSZ7z
 VrnpiQVfSKDq3CcQAFkAkwiiq1xgXTt+UURv6wfLj0QepWznTvErMcv1V5iGZvMD9UMc
 bDPybQiMr+XH8vGe3mebRyqXCKIPZcXDLRLy+pUOZ42WAsh7nk9Cm3bq/CIBYTY8sXhD
 CZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526954; x=1796131754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J8wsbkDP/3WIoccwI/mam++6k53VGq0BvLwtvcHKec4=;
 b=sFELgyoojklJblBGIKuqd09rcNiXJTuaoXgmKOlB53xxMW5U+CrkQx9gn02vFH1VEf
 sU25dasDJ3Pauaoq8LKKnN8yDvkOAOI15ApuF8BjHT0kf7Bqe/uh+VmReyE/ZKSo9+hi
 hOlbgiMlvnZODMVLutXuecj2ndBlBl07D1/SxuPOoE3cBtvXdNdrkYM6JRfDJ1+QwXfL
 d3cfQFMqq7v9YHA5HN1NAzV84wbKnvtSeI7ADvB7Pr/1wj0vxzkr6SsxjA1gtPbKONXl
 60vPC6ZjGzufnHZRgfcFb/nBTz85HTq2flnLOVWYqQ9nP1mtLh1LHzzjroXYi4a078BL
 OJgQ==
X-Gm-Message-State: APuU4Z94ChNESP27URtZpXGspZl1p0b6DgkaitGp8/K6bWyKeQJO7j3J
 MlLYYvpchTeb3E+BOp2wHSl3tT8V3mtJ/5tp9WVGV1O+XOs5OvMa3oNI8kU3/LHFuuIbasQ688g
 NyJcd
X-Gm-Gg: AZFdTZewaEkyA7J9W5fktByjRkhfczvaMcMRgr9yJlDU6MxpqU+dMHJClplLYrTgr3a
 gLiTj2ucGh2KE7j8NPdiyoluJ30LMG97/VgFlcmg7XWPQd/ASCBxMB1uNawdCuiP8vhXQbTxRjp
 t7c3GIykprx3zNj1QZSrZVhnAK2asHCPm7PQHHHYvmyU5Qxf7DBqBMY6ccte5SP1Hy0NWqpTucT
 GhAK+ZkAE/85zRVqapmRQ1uV4lTXlUtYOZA9yQx6jknt0YHRjm/9aT6Ov7bd03gjqgIo6tkWZPB
 AnrKGhncFJ592hKt0g8oPIaG9RWPoINYO5G1sJCxXmk6Mv5eNwUSjs6Yr2btDv2c8R+3Sveqj/E
 CPLWyOjAQ9YJTFh10xcnAKMB1uzBZzPVPfefkR5Bjz0+DmB7mzQH2vETUflStCCElLmA+2dpXLJ
 ZcsjqCGzeroW+47l4lHjgPs/J8pJRYiS4NlywZVyawJsmw/w/JrbFJUgXVdujp3Lzdv5BwowW/7
 RlIAiIHDAdM9tdY8YqLtv2YIBg3pzKfbX4gHhBM7PV+MQYgBh3LbqqjauMB6N+EXa6f5zDOMR69
 nPy+DAjb4NovbJLiXUgBzMSGmAuD8KqjdyqXWrNFBMnrNqUuAmfPU0EhovjSKJHC0aQG1GcqPz1
 4Ah5yq7SIAp/dVjDYiyj+hyJsAmWuyoo/z6E=
X-Received: by 2002:a17:907:d40a:b0:c40:f89f:d91d with SMTP id
 a640c23a62f3a-c513ab2082fmr1197418666b.28.1795526953771; 
 Tue, 24 Nov 2026 05:29:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] target/arm: Handle "PMU disabled" in migration validate
 functions
Date: Tue, 24 Nov 2026 13:29:02 +0000
Message-ID: <20261124132904.138731-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4905
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20261119165546.3050013-1-peter.maydell@linaro.org
---
 target/arm/machine.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index c3aef3f3301..02a2b78506a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -593,7 +593,12 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion;
+    /*
+     * Check MPU_RNR in-bounds. If no MPU, we still migrate this field
+     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
+     */
+    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
+        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
 }
 
 static const VMStateDescription vmstate_pmsav7 = {
@@ -693,14 +698,25 @@ static bool s_rnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
+    /*
+     * Check MPU_RNR in-bounds. If no MPU, we still migrate this field
+     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
+     */
+    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
+        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_S] == 0);
 }
 
 static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.sau.rnr < cpu->sau_sregion;
+    /*
+     * Check SAU_RNR in-bounds. If no SAU regions are implemented,
+     * we still migrate this field, but number of regions == 0 and
+     * SAU_RNR is RAZ/WI so also 0
+     */
+    return cpu->env.sau.rnr < cpu->sau_sregion ||
+        (cpu->sau_sregion == 0 && cpu->env.sau.rnr == 0);
 }
 
 static bool m_security_needed(void *opaque)
-- 
2.43.0


