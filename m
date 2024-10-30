Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4778BD7495F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 04:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t60Rd-0003x1-HY; Wed, 30 Oct 2024 00:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t60Rc-0003wk-BZ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 00:36:32 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t60Ra-0001JL-NY
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 00:36:32 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e290222fdd0so5559711276.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 21:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1730262989; x=1730867789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H85AbNTysqI7cuJO3FcIVkkH22m9A/gdkrfO0/GMUOw=;
 b=Z0KtnYLqWfQl/3kdYzT8lDibNWqWjrWU+ZYZlxOurfKtVluwWypFcU5KMfvVQhIrU4
 wNXb/WZK0sTwosDCRih2fWCLsLZKkEzXnKRS4eClehy1tzKPnOpD/MjOYYW7Tk1fW30f
 SgWKJ9Rg9cvg+5g6uAk63G9POZsOBYhFjAbBspScAMfnPZRkAMzUT/TPL1N+5zfQ9GXm
 vmJDosZTtyippKh1QENH8Ri322STVqJpK5tSgwCd9sTu8NBYDrsOqmE+kXbTW4Mf02Fi
 RRDqJ+gDFxEMR5bScDwzpdHm3AYk31Pzma5eLtzVCd1vkCCT5yb/kAJZpud7XJdax862
 y2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730262989; x=1730867789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H85AbNTysqI7cuJO3FcIVkkH22m9A/gdkrfO0/GMUOw=;
 b=BbLlm0YrTsxDuOV8SpzkvtR2zBjNcC/EZUucgj1xwT9OZzYWKYIWNHwi4i/5SZ+sn/
 yO6b8I7R7BofTYZBLtBER6MKtOcpQ/BOgbes5+k6x14RSu4wWmb75IYAY3h5pGuCu+hq
 vIdtX4RqUKrEt8LHKkJVy9TNc4JANBx7Kws/b2T+hELYcS/AiRg48Uuz+XWBIqolF5Gy
 xos54g1GikN0SywCrjHQIAQ3qPKKSbaOh4g/g2KMGkeamc55RlCCBqU58TFU0ilQrrhP
 pF4DhcrdXJouo6q7Qnrk7bacaX3BA3Jcu0xpnIWFg/oQPVJEyLhzVafcGV3lmfC08LYy
 qISA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX14H280Hk4VH2Bu3mvDbWKNTFD2T1tJFeMLyKbFuLstqgpnoN44Ewn2G92+Ktd40BQSR7IwFCub3x8@nongnu.org
X-Gm-Message-State: AOJu0YyuIL4gi+WISVyceqRye720PpwTcsasv3w/KxInzlnC+K3nr8Ot
 h6SQNQleCb7V5oWjQTG9czvzyXa8zHabSrpYXezQf3ibJL4+jkxS5rSx9t6j6+UUr+4BpQwHaVc
 ZANg=
X-Google-Smtp-Source: AGHT+IEWU64858/fh+MqXBbPbZH/T7ePu8ZYyzchbNkowm8JNBn6bPtmGl5Kx8jEsCnutD1QWU1+NA==
X-Received: by 2002:a05:6902:1021:b0:e2b:a8b3:d650 with SMTP id
 3f1490d57ef6-e3087a6b53cmr11823420276.24.1730262988862; 
 Tue, 29 Oct 2024 21:36:28 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e308fbc3e26sm1633860276.27.2024.10.29.21.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 21:36:28 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv: Fix vcompress with rvv_ta_all_1s
Date: Wed, 30 Oct 2024 15:35:38 +1100
Message-Id: <20241030043538.939712-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=antonb@tenstorrent.com; helo=mail-yb1-xb2e.google.com
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

vcompress packs vl or less fields into vd, so the tail starts after the
last packed field. This could be more clearly expressed in the ISA,
but for now this thread helps to explain it:

https://github.com/riscv/riscv-v-spec/issues/796

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 072bd444b1..ccb32e6122 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5132,7 +5132,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);             \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
-- 
2.34.1


