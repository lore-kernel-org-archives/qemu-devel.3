Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD302606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ig050lYi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq8B-0007an-8m; Mon, 19 Oct 2026 12:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq8A-0007aP-3k
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq88-00010O-8s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so28956315e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426951; x=1793031751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Iick0y2AGxfKXDLVnntT9WyV/jbAX0Ak+ln5YPzpJ0o=;
 b=Ig050lYiL8CXEIKyvLff7r6qP0COYDt3FqLjsucto+fnvzXBwR7Lex/szBlH7a1ruD
 cxEfL2af5FsRWMr0sLVFDUVkGNztqHkOkdK3Vq3uqfosRe1P3OvBYBO8aJc+kMTWXzkS
 O9OeVKarQkggGL7vNRzM83tF6wxqvB6WL6xaoFos7LjLgJgQARx/TS8diAIT6Vzm91Fd
 lDmfeeCJTXZSf0M5EN3aBG80wih9QRyyjo80AFEffIG8yxHDRLXFtWPAS9zHCVXNV88r
 MvzVMz1lXyjGZgJ32buvHddqPdhr3co8iguoG6kYePWzaU306bdfbPA8lwbj9TRIA+oS
 qcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426951; x=1793031751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Iick0y2AGxfKXDLVnntT9WyV/jbAX0Ak+ln5YPzpJ0o=;
 b=qHsYlItdankRkhGcB27l+WAl6btT8grqU77bDTT569XTz+ZY5lA4tzkk5HWTMQ9Nvj
 jdKa+KgGFugRQCOAWS78tBQlELM/aauZXov6dEkEAllR+JifhGRey3kYNG2TtdkOZUwb
 l3UAmQgVDoN2XPO2HJ1t/lLHJS1Rg4Rzz15fwdqmst06sDvJWsp6SPKUlgmm/86HMz34
 CsB+emYX9OC5JdH1/Q9HJrbHwl/VQQ3LGxZuoZ0XnkgPR/lhP0yF+BQh+bwtXhTtmDRn
 G77cWIV89yw3XGv24Xu+J38keYi84b2v4uZIOir9+JOLDGRg4sY54AWNjxtnl1TT5Jxm
 8z5g==
X-Forwarded-Encrypted: i=1;
 AKwUvByEzdg6wk87VmDJ5T7HOgmX80UVGTX7xi7ztzI1psWKHiiwD4VPtdbyy4i4bTLLOZNkvuBJbFC2Zd/M@nongnu.org
X-Gm-Message-State: AFq9FYKJtB+QloxgIOnYApUEVSp6sOYSFjwvcapBV+KPZ3KOf4uEga24
 zhC6mK3o3dhaMGVUXqL1sp3HXxx2EZRtBid/8SyOwmIghjUjhT6ynpXD+2EVP+1IOg0=
X-Gm-Gg: AYBFou1tm/P9xa822lqbAAbuVOa4HjuA+dSGM7Wl7jtFou0LGxP5VKeW52n2VbKtSmD
 K3rkt30Ka5FG3hlWhPcKYi1opJ8DmO+vM/iKA19zgJ5snrSDRIsUl7fMGKtzBjsTZdqwHGO7CqG
 6kzdRO2oOCIdfrRqMFsxP/uqlQZt54YmcJ4tN43VJAhXHifMPtW9sOyCjMnEh/I5CWrPKsVqkoR
 D69ofglJNumfbS6FDKLR6g38lW5neOzVbYQZtrAL1CdlKZ1lqUuv6I0frP2JWPkNKY/9O3CBpPd
 2/ci9BkUlGPk64D9OlzWpEObh7npvo0xQOLMRJDDGjeZnmWT6Z7i2Dv4XXv2MnKvMHOrNik+TJe
 SLoV3LDU+heivUF1ykVL3OV62GBd+KsLq9hheS0AiOhKHuhf2SlGH2Q5TgyJSaklTl+DIoId3oc
 2tmKlj6Dr0gyGoGLMIQMNmHMPw3yccds0qKqpqyA+WE5wxQmeMbmMvH1HK9YL2PCTHRB5VoVBq1
 I8ccsxC1D7qZ7ee58JoMp1byVqRQQ5bhb4m3y4kU63ROLFojjSnBc2ivAgjR6qoqu/IEXxXmZmD
 YRefeDigQ5jJeA==
X-Received: by 2002:a05:600c:3547:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4a1d7608dcemr170293325e9.16.1792426950700; 
 Mon, 19 Oct 2026 09:22:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm3100095e9.13.2026.10.19.09.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:22:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/intc/exynos4210_combiner: Fix group register range
 check
Date: Mon, 19 Oct 2026 17:22:14 +0100
Message-ID: <20261019162217.3272337-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019162217.3272337-1-peter.maydell@linaro.org>
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
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
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
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


