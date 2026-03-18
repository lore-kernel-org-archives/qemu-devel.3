Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FA4FEDA17
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2frV-0000nS-Tg; Tue, 17 Mar 2026 21:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w2frU-0000mn-VI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:38:16 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w2frT-0001sg-HA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:38:16 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35a1f3f07ebso2666139a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 18:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773797894; x=1774402694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65n1YjdwrmfnAbTxt9/zviUKHs6YsAptXaobJf5YYGI=;
 b=FF8zCqloyivtwm+/QNV+/IzGAeub11MFcMnSsX4dNc/p/KkjVyKB61AiXndTwdQGO9
 +tuFKpisesBZQT3LDG2gf/DW2CDvGPlTG7MFzkwkYbwpAngHIhirX6PLAkYsK5v6ny+D
 IP6R1HJx4dN0GrHlULRAIQkyaR3KKkfKJez0bc033GEORwiUks7aDwXeKjbfIu3sY/SO
 FOf4/rlL6SHH9z7GD/e6SSGZhWVDggCKiSYXH0LxLN9hJcn+6ABnpIKsyt5Xl3EeeQk+
 i/EAg9oTVIRDI5bp8VZqRFsTwepeswWsqa+JtD8Mrma+7mPQYq0AL7hdj3Az+vTH08nr
 ZbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773797894; x=1774402694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=65n1YjdwrmfnAbTxt9/zviUKHs6YsAptXaobJf5YYGI=;
 b=becq9nq6URZXEe3KztPCz4OcrFyyG8FaTLE4H57/asTGGOeLVjKGxlgyJWmEr7KTF2
 suvhvIgjpiLiQ4jSTJMae4WUkKFInmfbW7/pRNFB+/ZInRczgIir6kyZbp3KR3msLdOr
 QaFiVJNLwbOIVDYNFACgo16hUXhxkfS+EhYaJMjJPmfZEpGLDeVMbpQmNlaPEmB2MW42
 7dpmtNebqF71s1aBJdDDwi3JQK+vDFFTZI3frUjLRnuR2kXDhMJECqnKVV1AVH0fl65R
 7IX7icdzTRxd0iYNU24alu+uDiySex8JprZSvIbqbmH8nXslKUb6FDLkTQXAMhVfMBzU
 Wqgw==
X-Gm-Message-State: AOJu0YzHlnK45/l2Gfy9duaeYo2DPbHW0lR+2vzlQoRRXTfIHlNjiLfG
 YDaOcT3svFEfzttEk7T0FJ7RJ+LSr5JgZEophbDumAq7XuNVLKM1zOYhBd4ApZltux10Zm91OoR
 oqPNQY1uBcS/mL8PzE0z6NxULv7mtlAyOvdAHzg4Yh3Gh49pD2R2yUwCJkFFtEXfmPqq09IXGxn
 UkfUjg+WbU2/3WPBAo57u2dvn+1ZVCB6N58z5RW4Pb/A==
X-Gm-Gg: ATEYQzyrbWV0d++GjoPetOhb1mvZoFkRsavZJ18Xqops7B9IjjNyqDnw6xnC3vFsAD7
 DPhCQWkcRdsWV3Qexsa7ER5bynqWRghP+PhQmSuocMvEbgfeXWLxwPC+a9qlxz0dcP8lbOGzH5T
 /bTV66PK3+LhLOIYXgdTbrHWb5KJn1CSy8xvaeBgRBZuqXMqz2yM0xnBlei7ryTOGXDyKDqVIMd
 fmWzF25UCDSk47pW/A6lgaMM5OI6zJX3uVZK1z60zeaTztR12l9AHoyhcwq8rtxWPJTT1ZYB5FG
 k3yzwBgsxB1adxA55WzoZYra2aYtCHTRY/gobZumP3CdaGaJBt5XHnFlKOcQVx7W6lm2UaFGnTY
 3w6pledek9shZ2BvlDnSgPH/R9iqpoiMoVooZ8rI6mqIk6WfEydZKt6GUzfWfyoCUX8M8tgzOeE
 cl0pytIIY/5ysA4phPJGm+r0+jr17RU04tMHjGqBmbMml+y00rZL6tiFE8sF522JSt8c8Wv1Ote
 rjTLN+aBDk6IYzr55IDfieDmuA=
X-Received: by 2002:a17:90b:4fc5:b0:341:88d5:a74e with SMTP id
 98e67ed59e1d1-35bb9f2a19amr1460133a91.29.1773797893828; 
 Tue, 17 Mar 2026 18:38:13 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba4f2321sm788462a91.2.2026.03.17.18.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:38:13 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/2] target/riscv: rvv: Fix missing flags merge in probe_pages
 for cross-page accesses
Date: Wed, 18 Mar 2026 09:38:04 +0800
Message-ID: <20260318013805.1920377-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318013805.1920377-1-max.chou@sifive.com>
References: <20260318013805.1920377-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When probe_pages probes a memory region that spans two pages, it calls
probe_access_flags twice - once for each page. However, the flags from
the second page probe were overwriting the flags from the first page
instead of being merged together.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3334662dcd..a74ce70943 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -265,9 +265,9 @@ static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
         addr += curlen;
         curlen = len - curlen;
         if (flags != NULL) {
-            *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
-                                        access_type, mmu_index, nonfault,
-                                        host, ra);
+            *flags |= probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                         access_type, mmu_index, nonfault,
+                                         host, ra);
         } else {
             probe_access(env, adjust_addr(env, addr), curlen, access_type,
                          mmu_index, ra);
@@ -275,7 +275,6 @@ static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
     }
 }
 
-
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
-- 
2.43.7


