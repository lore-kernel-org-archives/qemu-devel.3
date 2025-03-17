Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97782C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJQ-0004yO-VH; Mon, 17 Mar 2025 14:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIl-0004US-R6
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIO-0006B6-Lj
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:34:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225b5448519so88590945ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236474; x=1742841274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=lJ3Jk9jgB2vzvglhUh5wIQVJsbOiyjAei3e4E50N9JZJI28cwku5hpR3qtYtpBqJGE
 MH3Tl7qgjJ0ZvtxAP2dnMmNCgFgi/yGaAV2/QkFELTcIrk92Ezlu2VOHA2XwOodUkOQL
 pzTsvFLxo1t7CNfvzrVB2u00NdB/Ivc6PVB4K5YJFn9JWUX85QSAqiIADODX12CrkwGx
 vpYgf6A/pyxgQSDnWi6ZEK0XLAfWE/yIZP2V3nqq8RozXIqSeOkrhhvcJsScIjOo2kON
 6PRlPaFxBqcc29/EABtQUCPZ7wnsXKiEzZupbNPnn4BvMabPxVGUK5Z6E9joHx63sqqK
 3uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236474; x=1742841274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=H7RnuR4Dr0x06AXna17DAYsMLefxK0qy5I4AYPfDf7rX7V2pRwT8DdB9Mf64UaQYSz
 z12qL07Q7FaGAsKY8V/6ZCpXonbfkfcKWO1cghFiexL4mu+dgrGbDRh+he9eiVK/wnlF
 ezE9Ya73RUUp+Fsboghm1kAlFSH4PH7zE092cOtuHdSSD7ynKRNHzh+K3haHpbgkNAvw
 qTrKtVpIxkFCAUF6CBd5AS8JRB5f6qahBa5XGh61hHW/45j0viuYjdG2UI8V1dI1JG/b
 fiSLf01CJbpeyNDsKMA6hNCiKjv2atJFvKa5gH2Ex3AJVqG8v9UViNWENAZwhlTRybAw
 n6tQ==
X-Gm-Message-State: AOJu0Yz3u9A9QlNrcyNcP5I7hnKdZSxgWh5hFkQZrq4/34K1wrg1t3ev
 stxfJloUZPy6+GV7eIVpOWEOc8Uc8mUrSy90zWRih2L5VAa3rhFaLYRZL6ucHZjeUyK1EhF9iDG
 m
X-Gm-Gg: ASbGncv/EqQhh+R8SEa2Y0P1zG/7thMQQ1TcVkH5d0vEDEBmez3dHJ5r5y0AdzlbsEB
 KPcEEA9cTUcOyydvQtlZb1fhhGF0hq1D8jdVa5LOLcrweZuH1I3OvIe8ByMM6b9DSl9ckHa9Wb+
 +xHXmkFar5f98jgOTzZbe2nwyboHUH1Ijp0J7UMjV1V//XpIvALH+CMdlcstgsjS6MkSb5+Jnra
 JoZ1iHtOvaVSSQlwMg8YOrQuxvFnJKGHNxA2q+Zqx7NK5vlPPCcqDY31OIN1LY3SkpA3+QjUlQw
 m8Br0j9XKI1NkTB6yYa0SDTPgmZZupZAtaBK5/Ub+nrZ
X-Google-Smtp-Source: AGHT+IHGRjUHfsZhtfemIo+dlcyT/9a20csro4vrsnSjWHRpRL87+9vnxPcq6naL2TxBdu+3gDVtPg==
X-Received: by 2002:a05:6a00:9a7:b0:736:6ac4:d204 with SMTP id
 d2e1a72fcca58-73722375218mr14371340b3a.11.1742236473962; 
 Mon, 17 Mar 2025 11:34:33 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 08/18] exec/memory-internal: remove dependency on cpu.h
Date: Mon, 17 Mar 2025 11:34:07 -0700
Message-Id: <20250317183417.285700-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac2..b729f3b25ad 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,8 +20,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
-
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
-- 
2.39.5


