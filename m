Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CB606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ly8iidoX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLMYc-00016w-3b; Mon, 26 Oct 2026 11:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLMYZ-00016W-KV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:24:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLMYW-0002u8-H7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:24:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso28430725e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793028251; x=1793633051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iHLjy8pJ8iyfK3sYq9Xi7wXXIOu6Z3yiwwBHVaC73dA=;
 b=ly8iidoXA6GgO2sXQLJMVkzsqhv2ExjLUwChcPCVP7R172gT6lcjnNL4Z4jCLTHC+E
 DdPKt9JF4XbcuSnBVh1ep6vMOwF93eTU6Tail3M/kfl+LogJrIF8A+FKO6whj6fYtGXu
 oxSbqVMSwWc/A6WkfIIxo7PFty1ReqwE8gHUJ18aIBlDUejW3vQgQi060fMV1D8xhMKg
 HDqp+Q++KxsM5cTTtd2FV5qkJqKrEn0xYgh/zsdq8Q0w3Ej4iPEVxEHUJGjoBzzPwvm3
 5uHrsGr9+XSFkHnkE+rxyOYIeNd05BEA/ClgItF4PETB5gMFMN4u11rK19GlD/7IuqZx
 THEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028251; x=1793633051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iHLjy8pJ8iyfK3sYq9Xi7wXXIOu6Z3yiwwBHVaC73dA=;
 b=yRpUoZAyXmJB/YOyQP+qBlYqszR+EqPqg7I2XveAJ8zAat9E5ye5IVOAlIXR8O4LnQ
 n6bFvLdgm+qDqAZGdDTpgjkW1/uiWSPQoSbPrfjrXhoazKTZjlYsA06O+JuoypJHjUhe
 v0DZKR3hOsyIhhnRW7wXRBISZGeLBN/HOf1a3+6nAmXx7PrmZtu0kdD3pb+zNGeOKzox
 FC7jnWTEIbTCTGZ3hWtBxQ54J2tvX/IPQgCqIxOBfQcD09GbqZ3Cg/oaIigcK0dftzbQ
 JCfoDfudFIeBA9zuUEEa8X/JLGHpGyIvZqCJm9QyU6jOzpssGhY7qdAw/oBZF5+QjePt
 N5Rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL8akzFf3DkyfqzZaw0WsO1CzVD0uMZupZvMfZhK8GkcSzjsV5bO+UPin5qDrfH4TX6+KH2oJe3Qht@nongnu.org
X-Gm-Message-State: AFq9FYKbgNSChHmd/X7cEOdGDCE1tmBATKtOxbhB3DrDfe6mwBxn+Hxs
 z7CP/f1hxsw5bGtWWpovdU6rx0vJkO99jf+mEsf15zt53AywzHd0iSgnPXU0fRC4vpU=
X-Gm-Gg: AYBFou2p+RNbyxdlLlgD2T3SLSlj+3JXxINlz0fgUIwLhryf0Jy3FA79Zd8f37WF0jy
 IKDX/MsVr7BlMZAM8xVfhtz9JE0gQ8oBfe4Wn/Tb1zsLC5PIv5bFwPINf6Xu4le2BzyaQiqNszI
 X0bdemKk74yy5Scvbu3zinrPCfbvehCydr7nEoDtwOl5fygerDK5xWBTiCYIFQhiqspFS6XdnMG
 LfWrzwc9Hc+29Bn+T14I1lnMdmaBXwgiB2lYAxoGHiquAhDApGJVHsLcD6FyUEilarcmfclF1hq
 WIh/Qcr8TnaUY2arZe5zmP28XGNY56xbgiN+x+1e7a1GbJH2aQlWx+qb9lpObqA9NfMv2WAiAv+
 uwKlTA/5/k0/HtleviAEG1Q7kBPl0VM6LYMh+ZcyyABPBHrZGEN8DSkn5xJz+5//8C9+BUQZPuk
 f9gvB74g6zayqUEsRarEKImDOQAAka7P8HyDnbcx9zF+Wk6LfRiZRYnBZpgLbxnBjgfJ4nFJfIM
 EjGsqdGoKQHpWSwOpnMuZ80G5mIfR5lUzhnwpWwlABSzF9FfCTpwnLI44zen3wHz+9vQVobl2PW
 eDNaSImE8bphn5tukythzbi0i7jISTWstQaA5TTtLID7ts13Uzo9uCZgYBCH
X-Received: by 2002:a05:600c:4e8b:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a35ac3cb16mr131069025e9.2.1793028250760; 
 Mon, 26 Oct 2026 08:24:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm352717525e9.0.2026.10.26.08.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:24:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH] hw/display/xlnx_dp: Make assertions clearer
Date: Mon, 26 Oct 2026 15:24:09 +0000
Message-ID: <20261026152409.2869104-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The xlnx_dp code has some assertions in its read and write functions
guarding the fallback "read from core_registers[]" codepath.  The
array can't be overrun because of the defined size of the memory
region, but the read assert is confusingly written and the write
assert seems to be completely garbled.

Replace both with a simple check against the size the array, which
makes it clear that we're asserting that we won't overflow it.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4586
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/xlnx_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 06594980292..ad6c4952065 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -812,10 +812,10 @@ static uint64_t xlnx_dp_read(void *opaque, hwaddr offset, unsigned size)
         ret = 0;
         break;
     default:
-        assert(offset <= (0x3AC >> 2));
         if (offset == (0x3A8 >> 2) || offset == (0x3AC >> 2)) {
             ret = s->core_registers[DP_INT_MASK];
         } else {
+            assert(offset < ARRAY_SIZE(s->core_registers));
             ret = s->core_registers[offset];
         }
         break;
@@ -986,7 +986,7 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
         xlnx_dp_update_irq(s);
         break;
     default:
-        assert(offset <= (0x504C >> 2));
+        assert(offset < ARRAY_SIZE(s->core_registers));
         s->core_registers[offset] = value;
         break;
     }
-- 
2.43.0


