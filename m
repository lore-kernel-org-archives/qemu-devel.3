Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2D606A6AF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oWv97j/5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXSM-0000Yk-TS; Fri, 20 Nov 2026 17:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSL-0000XK-3U
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSJ-00052A-6H
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2f02b9c1f6fso9833455ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795215102; x=1795819902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LbxqGceFDK5knpFeN6JIgeF2191eJBtpeY5riuZC9TU=;
 b=oWv97j/5Fv67hQHrX0iUO/8lO2jQXJXPNLDUjyviQV6MAiXeOTqHU55mdWw0v9lq70
 FD/78AW+0R8eon/E9ZIJNHALnPb3MJfOSnr3cdIWJPAAiE7BhT5wn4FSWLd4GoVlLivO
 n2ZxPSMdBkP3u4KIIzm62XAZn9Urcp+SkWA8IuvZR9eiHzRpHoCnCGDImBVw5jeP93Ip
 kX37vJYJqYQ+ROWhte/eULekTu+nOOcZINgvF6IN+yIlCkShAXR9WgnQVe+CmQCn50c7
 tOpkNJYvqzA3wTRivJlqLGLi3aKaU1yzrFWnwjcv6Ba0pBVg4+Hf2RE4x4Qt8+UHZxdm
 Dy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795215102; x=1795819902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LbxqGceFDK5knpFeN6JIgeF2191eJBtpeY5riuZC9TU=;
 b=bCAEbDzNngCyVS+6uLWOh2OpQk1xHZTUXM/pawoFVrYpwLxukzJJe6UybtY/Nn976K
 msjOb+ziemG82Q4VKVEl1Jlo1WaXMLgXIQZ9E2t4ZGmpkUwmOWD131VZKrTup/D5vdMv
 J/q4X98xihfjq/cwTILyUKH8VXg5Tcv0+Zs8rS1/tUVvpYBGAo7Nxs92MRG8FW5SfX20
 TJq2vgizslyjVf61N1IyBFhjYeOMUwCGW1JDMsMd52atOlp9SKLsjB43qgEUC+9sgqzK
 qGVam0fyLGpEq26x/lmWSmVLLi/G2No/43qpb+wNses1Whkqlfo1Blq5ST7R4Gi46mkR
 b7EA==
X-Gm-Message-State: APuU4Z+5NRts1QUTqDxBouuy4sTM8L8paplRI5uJhoqFpB9M2U7KgWI+
 dpM67uU+Gcovg+UhHc/OFPKEaMybT1lO29nRZXT18dUb7sbwqzdQ3rUA+Da6EKHmenM9LuB5L4U
 ZYWKZ
X-Gm-Gg: AZFdTZd+YWv3vSZGcqzywQL7wXvnoHQxumuAKyxad6/S7fJabC3nc7xuUJQv+itq6ba
 bbUwGdItL9bHQyv4JpdNkaNpeu5nCHVDT9NrI5SE3azPHrfabZ5DAmOwcjIPcFWE3rEjzb2W8zy
 KtovxtZtxfbTLRhrJMU1DIN/mAenmh7FP7kk4Iqcn76Pu8jDiWtC4WoeQLLwgACQZDJlv490YMb
 CgC6kSNRr0w4NLpSXlb69Y1chkdwH/awEl5g5HyPg0FWarT1algcADL8nMJEsVVty9j4U3J2wvD
 fzHOPEiPH5mKtsKdMBbi33S44DU11wVbMNybDLB8io9Zw1JmyXydUAwC35OgE2Uc++eJDXQ4aJ7
 oQyTRxoL5zRoJ7zVG44QtvIYTIi1ibYHfZ0RyZ1enI4UhQwhfqBjCxHMiVL+hQNnpAwiWgmEW/5
 qg77gIv8H+Q9qi1Vdh+aCx+E9bM1lTsqRhiPNyDIjEfjUERVtvyHrhDuxj09BGB5WnjalI20oBD
 yv+gZZ9LYRrtk0Fcpfsc9ZeGXeD+AF+Yf1SYBM+x5UwSKHbEzZ1PW6Yytj1+pzyrKKUXvYWxbNf
 FxpBCMeGJFO/Y+CTesSuVxbNanMWTS3NFa81oI5MRwS6rSaHMk1JTLwqtOyq
X-Received: by 2002:a17:902:ce04:b0:2e9:64b9:a338 with SMTP id
 d9443c01a7336-2f03f18f272mr36348655ad.7.1795215101655; 
 Fri, 20 Nov 2026 14:51:41 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0433a3a43sm15669055ad.62.2026.11.20.14.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:51:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: WANG Xuerui <git@xen0n.name>,
	qemu-stable@nongnu.org
Subject: [PULL 4/5] host/include/loongarch64: Fix build with 128-bit LL/SC
 enabled
Date: Fri, 20 Nov 2026 14:51:37 -0800
Message-ID: <20261120225138.7198-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120225138.7198-1-richard.henderson@linaro.org>
References: <20261120225138.7198-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: WANG Xuerui <git@xen0n.name>

LoongArch64 v1.1 has native 128-bit LL/SC capability through the
`sc.q` instruction, and [GCC uses it since 16.1.0][1]. So for
`-march=la64v1.1` (and equivalents such as `-march=la664` or just
`-mscq`) configurations the following happens:

- `CONFIG_ATOMIC128` is set,
- in `host/include/generic/host/atomic128-cas.h.inc`, `HAVE_CMPXCHG128`
  is set to `1`,
- in `accel/tcg/ldst_atomicity.c.inc`, code paths invoking
  `store_atom_insert_al16` are enabled,
- this errors out because of the explicit
  `host/include/loongarch64/host/store-insert-al16.h.inc` override.

This doesn't affect `-march=la64v1.0` builds because the `atomic128`
probe, when code-generated without `sc.q` support, correctly fails to
link without libatomic.

Simply removing the override is enough to make QEMU build and run
correctly on `sc.q`-enabled hosts. The override was introduced in 2023,
in commit adc8467e697d ("host/include/loongarch64: Add atomic16 load
and store"), when it was true that no existing LoongArch implementation
could perform 128-bit LL/SC nor CAS at that time. It is no longer the
case since LA664 with LoongArch64 v1.1.

[1]: https://github.com/gcc-mirror/gcc/blob/releases/gcc-16.1.0/gcc/config/loongarch/sync.md#L784

Cc: qemu-stable@nongnu.org
Fixes: adc8467e697d ("host/include/loongarch64: Add atomic16 load and store")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4767
Signed-off-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261105102924.1309687-1-i.qemu@xen0n.name>
---
 .../include/loongarch64/host/store-insert-al16.h.inc | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 host/include/loongarch64/host/store-insert-al16.h.inc

diff --git a/host/include/loongarch64/host/store-insert-al16.h.inc b/host/include/loongarch64/host/store-insert-al16.h.inc
deleted file mode 100644
index 919fd8d744..0000000000
--- a/host/include/loongarch64/host/store-insert-al16.h.inc
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- * Atomic store insert into 128-bit, LoongArch version.
- */
-
-#ifndef LOONGARCH_STORE_INSERT_AL16_H
-#define LOONGARCH_STORE_INSERT_AL16_H
-
-void store_atom_insert_al16(Int128 *ps, Int128 val, Int128 msk)
-    QEMU_ERROR("unsupported atomic");
-
-#endif /* LOONGARCH_STORE_INSERT_AL16_H */
-- 
2.53.0


