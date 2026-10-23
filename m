Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40897606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mKxjby68
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3U-0003YI-T8; Fri, 23 Oct 2026 10:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3N-0003Qc-UV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3L-0006lG-Cn
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso602664f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764926; x=1793369726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/BnxDMpaTMP47DZOcmz0ZMasV+qTth8F67tBt4f393Q=;
 b=mKxjby68i+fRHibfKsp0QVXzi6xDnP6rAVbonzxXMpciUMip+7b+1hLvPSXVUFi8UY
 Bz9Ky7PikKIJIjpBvLxVS7GKmxg0GClLIDOvB5W5RogmqDQkgNKaSAvpmnZTbENQt5wH
 JW4GyykQqdqD0jTWCq/if1w1fNQXgRAdB5o39BrgnJzea1mhonxqNPDVPk6kVrXFOT5X
 ufGFC+6HQzfYNqLx2knaqeW3SH+Ocvh4OQzeCIQL8Bp1Fgdb1JpArrbLFF1VuslILzKc
 9b22/Q0jqNGjYIvITl/2IBp6/df9JFqoe2tLv6RDKoJwJtHyYcraEcX6k8iVqx2wWv4o
 iskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764926; x=1793369726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/BnxDMpaTMP47DZOcmz0ZMasV+qTth8F67tBt4f393Q=;
 b=el4IQSr/SuBu7wwQooq8/qwcZorwk+OZ4weLsduvKseLk03d8og2hyH2dNLZF4Hwi8
 pBBUmInzUht1j8ChfGGag025ReriAwNNVYsCDjtG2IWVZXDReM1A5PvNirVQl7c5XlAI
 aIWQoww+JixkQtEsqq1QBm0IYs7bSyu7bF7qFm7zFkaCsL6bmpsZkffu0JnyNE/S0hDL
 1Ld99Sy1b5xxgsQNtL/+WOXbyYH5mVQ271kp0KGr8CDxV2HQnlnkxg+RmuGna8Rn+ERU
 pY3egmKGpPZqi/gzlFzGs8DKtxmr3whVVDC0UOeTCn5/yw3UC4yxYWqVs8H2wyuUefRb
 1W3A==
X-Gm-Message-State: AFq9FYI4DcCHIGTCiOfM0kPw+5DdM77HNCwsvPCERqB9zGJQdt/qIaac
 x1f/QRuUar33AqsBJ7ZfFvXtUG6vWmQj/N1I4gAardMe6Lj9YP0nHsM79JkYZwPKS3qAfiFRj5r
 Dvm42vmw=
X-Gm-Gg: AYBFou1NqwKINhTkcbDXJxXSiaDssQPszEQn3O0+j+LzhJ1ORp3B1qHNK/F2X8HE+ii
 jvVUwFm4KaG5vDikGv+LYooru6AclsMjBA+Md0ZiWqNuInmnmz53Q5DPkDh/1BaNCbiRbYCNjzc
 +kq+XaNypHy12USTYTnx6whJJflBbt8MqLQO020n1qqKXrxbDT8KltvMfDBura9IRV1FdMoknh8
 u3d8sxQyl06FIEJZdR0fDgHaz2x/sqlvQYA/8JGJbLhefS8g3f5ajdAUHAaJO5Sb1Z7dVTlvPI8
 su9fMqCfkYfYPPJtNhA2BgVlAyydU/yh+DkyzriZn97sKLaPtjOIb+DwfxC6zxQB6nsbGGNZFbg
 9PxxvdbgNBRvLuwGlHXZiV7ra3/H2j6/nXFa2YbXnGC5JMUeFSX3A+fEHsZ4rW2IZ+wXNqE+5sf
 OUVVWi62VITGS32J/jNxkjfHZQMSsdQdFYBKJtiDgK6H303NooHz+HzLj+Ho2jXMYBFevMZQjhR
 0q64geeVQppmc899HiqtsxQN/jHdOAONZDZRc/4iV34EuF2ZbRC/YA6n0oh3cIkY4HC+RuIVysZ
 tSCJP1K6BDoLnyXjzAUJv6u1HtwClXjjABFE785csbNWGjjXmgOa0WdYZtGI
X-Received: by 2002:a05:600c:3151:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-4a211ef853emr38554315e9.15.1792764925261; 
 Fri, 23 Oct 2026 07:15:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] hw/intc/exynos4210_combiner: Fix group register range
 check
Date: Fri, 23 Oct 2026 15:14:59 +0100
Message-ID: <20261023141503.1397009-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The exynos4210 combiner has registers arranged in sets of 4:
 offset 0x0: IIESR0 (handles interrupt groups 0..3)
 offset 0x4: IIECR0
 offset 0x8: IISTR0
 offset 0xc: IIMSR0
 offset 0x10: IIESR1 (handles interrupt groups 4..7)
 offset 0x14: IIECR1

and so on for a total of 16 sets of registers, which puts the final
IIMSR15 at offset 0xfc.  After that come two registers which aren't
grouped, ICIPSR0 at 0x100 and ICIPSR1 at 0x104.  The entire register
memory region is thus 0x108 bytes.

The logic which separates out the "offset is in one of the sets of
registers" from "offset is one of the ICIPSRn registers" is
incorrect, and so a write to offset 0x10448100 (which should be
ICIPSR0) falls through into the code for handling accesses to a set
of registers, and indexes off the end of the s->group[] array.

For an input offset of, say, 0x3C, req_quad_base_n is 0x3, because
this is in the 3rd set of registers.  grp_quad_base_n is then 0xC,
because this set of registers handles interrupt groups 12..15, and we
will index s->group[] with grp_quad_base_n through to grp_quad_base_n
+ 3.  IIC_NGRP is the size of the group[] array, and so we need to
check grp_quad_base_n against it, not req_quad_base_n.

Fix the bounds check, and add an assertion that the code path
where we are beyond the register-set range isn't going to
overrun its array, which we know to be true because of the
size used for the MemoryRegion.

Cc: qemu-stable@nongnu.org
Fixes: 8e03cf1eeb1f9e0 ("ARM: exynos4210: IRQ subsystem support.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4709
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261019162217.3272337-2-peter.maydell@linaro.org
---
 hw/intc/exynos4210_combiner.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index dbbdee4d316..4f079fedaff 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -91,8 +91,9 @@ exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
     grp_quad_base_n = req_quad_base_n << 2;
     reg_n = (offset - (req_quad_base_n << 4)) >> 2;
 
-    if (req_quad_base_n >= IIC_NGRP) {
-        /* Read of ICIPSR register */
+    if (grp_quad_base_n >= IIC_NGRP) {
+        /* Read of ICIPSR register. MR size ensures this must be in bounds */
+        assert(reg_n < ARRAY_SIZE(s->icipsr));
         return s->icipsr[reg_n];
     }
 
@@ -184,7 +185,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
     grp_quad_base_n = req_quad_base_n << 2;
     reg_n = (offset - (req_quad_base_n << 4)) >> 2;
 
-    if (req_quad_base_n >= IIC_NGRP) {
+    if (grp_quad_base_n >= IIC_NGRP) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "exynos4210.combiner: unallowed write access at offset 0x"
                       HWADDR_FMT_plx "\n", offset);
-- 
2.43.0


