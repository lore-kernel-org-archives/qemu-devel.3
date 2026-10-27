Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXXpMRld
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaSx-0006k5-7c; Tue, 27 Oct 2026 02:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSu-0006j9-P2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:20 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSt-0007IO-AS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:20 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36a17a332ecso143383eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793081718; x=1793686518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ujyr7Jx7RdrtwSaEiPldTVT9GggNzUt/ZtswxjPgnhE=;
 b=FXXpMRldW/5bIcyczREBhUoRYnNsMSN6Mn3D2oJDfRxhUeIPkmbpHDRCoO4OpT/QLi
 fnjcWS1+MuS6SwgHnZAyUDuhDNUHsaXsxSjuT93Ksk9vAHhiXU9KSeR9QUSs4zOuU0LB
 yn5mucWJM1S3v7+Tzj9PEY9HFwUzaJU4c5DfEnh6WKMkEQn0EAguHg8o2KF2o6WH9+UX
 qtAle9srZyDRcBl0WqtFG+aJ+3OIbvsF7SU1jnNa3YrVeyZPB4zQ3b1qj9FKMAuwR2Xq
 OTVvWIVKxLZce6JfhkAomU3OkVgZ0v8EnWuXCFVpuPPtvewAscaizxgQgbPUJtcaBcx0
 VCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793081718; x=1793686518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ujyr7Jx7RdrtwSaEiPldTVT9GggNzUt/ZtswxjPgnhE=;
 b=yyPfhNgjklmoCzhGgPx1lm6r+jabTMM48z3d/MRElX3Q0l5iCwGhRNT5QkmU1pvQPJ
 NZ0eOyojdX3Ipho5peH4Tj2x0fvkZs5f7TTleL//AKeiILM2GKdYKwQJ3BeHlIqvKe6g
 ZGUBKlGZyQE1RnsLG+MKGppOlBQoqzPF7Dx6n7Y0DQ+/qmJC+H+8DIHp64e3z13W3MZU
 Sl+KNyY71UXrgXcHE09vFapgN4sFMj8lCR3xVzENuy7PiIiX5qk7HsmT9W7NURuTgO1w
 RMFQypwiRk7jcDT4+0jE6T3f/tkufnTGesetsxVVOD7qzitREPmuoOycMZO2sIdlVs6l
 FgVQ==
X-Gm-Message-State: AFq9FYKjnC4u6ujy93nQJ1L76mjYwB67sTPw3aIQrCtC9lWS5OuExAHI
 LGKcNw/gX4LgQOiWtjp52o1fDOZC86TXCdePC9Nk9/kU4debsThgjL9mKJYGUVv3
X-Gm-Gg: AYBFou3HF0BS95DWgCFBXEfQYwQ9zCefZ5o/0kZQ7FJfzpolhn0uf3/NaktnFcnYkyl
 OFhZeK0F00imAlKfTxdkfFvQH1qH9CmYSNqvqnRIvfgthKB2cpQiYJeDScdm3ZgdsHvHtjghmB8
 BvsNDWzoubh6BIse3aY2LTYX2flVIYEWmzxyiBtGQKFqXs2a2KHPvbjWr+Zwm7YJ2EsNBkosEqV
 8ZehTA+OvQtQI7L5nZ2F92VEr8hKuweCXf+G20KW+R7XxtxGpk15ikONR8b3pA/2qroFAoo17vT
 m/5tacjQGbgHygBF3XushYoQg+2KX7p0wKmVLInPorkFe6VA0SGNWTfQI5cnJ88sf+rLGavVEjg
 QqQ+sqTXE8FkuCQgblo9XBynn4TNBQKkTfbi9rRMpCmUdOP1c6ASMemAtgec5vTBGzc1nuKvLOR
 Ur5BqkPqmjJYpZ7XWsoK5mLlXrjiMzRjh9zoCzlgTClIrqomjYXCwP2ApmjF2EQKKTHwZsDcuJJ
 3erlTyFqVN8pihZAf40oReseNdKaZYKwDy9ALu9W9ikak8QKO+br4llDvFCbIaBmEmtq+yJCpU=
X-Received: by 2002:a05:7300:ec8b:b0:36a:180f:3154 with SMTP id
 5a478bee46e88-36a180f58d0mr459552eec.18.1793081717796; 
 Mon, 26 Oct 2026 23:15:17 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec864fsm37346980eec.24.2026.10.26.23.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:15:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] qemu: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
Date: Tue, 27 Oct 2026 14:15:02 +0800
Message-ID: <20261027061504.2213-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261027061504.2213-1-luoyonggang@gmail.com>
References: <20261027061504.2213-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is more precise, so we can iterate all target_arch with QEMU_ARCH_ALL

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/base-arch-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index 806ad8094a4..a6478c2d3ff 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -41,7 +41,7 @@ enum {
     QEMU_ARCH_AVR =         QEMU_ARCH_BIT(SYS_EMU_TARGET_AVR),
     QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON),
     QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(SYS_EMU_TARGET_LOONGARCH64),
-    QEMU_ARCH_ALL =         UINT32_MAX,
+    QEMU_ARCH_ALL =         QEMU_ARCH_BIT(SYS_EMU_TARGET__MAX) - 1,
 };
 
 QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
-- 
2.55.0.windows.3


