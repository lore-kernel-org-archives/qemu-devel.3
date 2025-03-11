Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14A7C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqxK-0004uv-3X; Tue, 11 Mar 2025 00:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvY-0003NV-R5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvU-0006T2-95
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:12 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so9690439a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666146; x=1742270946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S847jAMJoPTCQP5Yv6FtgKXIrkXeVt152gZ92AA3GhI=;
 b=En091zUcUq2wFkM4FtPgi25dOV608NcfWBcALngG7UztzSXGwc90rAL5IG7yJh8dwS
 oGrU71fhSwASTbIrC01s/gj41rJHHZ7C/0EQE8KzMcntFbHSzDmMRJHyx2asNla3OAtl
 dYy5uBR/EyFNuPq5abm522cH1VqhW4x2lH0zVL/kF7kZjGl8uYuOKFO86XLLVA5Hqx8d
 mkIGvQFTsOfGv93oU2Ox7VSJ8TvbDJpB1RqEH/9aWio+ytsua/MCFOBNl9m7acS6GCRe
 FVdztQaGU3fX50/Jc7bxCZFBNAA28NBMA76Cv/m58/aTDjIepbOb/myXurxPYzq8sfjf
 xJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666146; x=1742270946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S847jAMJoPTCQP5Yv6FtgKXIrkXeVt152gZ92AA3GhI=;
 b=kqutFED8Pnmgueg9ohriQ/FIc00EI1dFRhK7y3hHAcrAT/xanY/oU3fgLE0XOEZ07A
 j5aop8eeZwktHFF8QOxvfEPKfudFXpGmcrz9o514o5REsw0Z9+S4rY31MnMazI9kRXN6
 H7PPW0MWXop3yQW2mDjHO+hiDS6mHOjx3re5YaExPm0F8HSEQ/2x/EB9m5TP4GE4hOrJ
 SzZYU3MOvM5i63n/sYWAh7HIXp2vhreEJStttOgARw2L7SAHjs8mvB/erWbvNPlx+MlU
 sHOartUpOEGeXtXpn8QAxH/3sHJ+Qhvnf18n6fhETyMuUOERsllTwpACvYL4VOzZBCPE
 EXXA==
X-Gm-Message-State: AOJu0YyC5Y02JmVu5uigWA4seUSSyAhd2dVpuc7Fdc/zYa5/GK0DRoor
 6aXvl0IEUr3kxNA8H6UkD1oApg9rGL8u0/i0rqtqUlHLmGpCsqWM9/CF9F2dw1hOzqCkje6mVnE
 xuF4=
X-Gm-Gg: ASbGncvhJiDsbH7ZcinnGQ/1DM0fqhN+pXx8Tq4hSvaqx9XmRJXFBz/OZm5ZoCze4Ia
 HsOCMp3BLV3JGEK5xVA+ws2EE99dYdwuUXp2+iiPtmr0WHhwm0b9IXJTXsyAw27ZL6Q07yI5n/R
 Ew3bLt/EouzqdBuzBV60mIUr3tBshk5f6BKY8pBCMoHeGU3mhg4ORzzMiMhAmItShmin+fBZbHm
 b7tKuzgPiw5TMVHZtaY7/fFnCn4lHTWBtr43+XbpqMKv1qUOkZ6+eDWmBCquTljnUdX+jiV4RyC
 JrAL01kpGzaP1eO43Ov37ErhQ+hNdyCVjCEGZFPxHDTg
X-Google-Smtp-Source: AGHT+IE3Vl9B86Ve/DQiaAua/ITAo7nczT+bEsdawDqXZ5VAclVm0x5zL+4TIfw0f3xRMRf28fdfZw==
X-Received: by 2002:a05:6a21:516:b0:1f5:709d:e0c6 with SMTP id
 adf61e73a8af0-1f5709de3e1mr11267027637.42.1741666146178; 
 Mon, 10 Mar 2025 21:09:06 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/16] exec/memory-internal: remove dependency on cpu.h
Date: Mon, 10 Mar 2025 21:08:30 -0700
Message-Id: <20250311040838.3937136-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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


