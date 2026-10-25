Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC9606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JDF4h4pS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL7we-0000El-Do; Sun, 25 Oct 2026 19:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Uo-0006iw-QB
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Un-00029q-6P
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1368041f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 16:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792970359; x=1793575159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E4EBPkvJT4HHZM+hkOnpPZ8ektePktmQrTRgK4EQrB8=;
 b=JDF4h4pSfK+yJDDPGugwDXpdJp1Ah6gecnwezzjRmDQwa901Pmmpleg2F31gdu3eeN
 ltQDpLYB5Y1DvptQS+UnH3N0CUnrAVXi4Psto7VqjdDMaKzysZCKPNgjF0sQatLnfirP
 6hDYuCRaY5I0IWE2l2zTrrPySVYRfk9bIIFNUwRxu6DBaKDmoR4t1bqXEi9m+A0J5m4T
 7OTps06E48m2Os1j9SofIWylqjmMbYRu40Ct+jtqnf7YfePxGPfdHkXu6VULiVAkZSWM
 Iw9/uwdzrKZHG56TunBXvFl4g4gUFlnQpdndXPcVDot/jw4bf35PkdaOhbmywLX31Pox
 sDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792970359; x=1793575159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E4EBPkvJT4HHZM+hkOnpPZ8ektePktmQrTRgK4EQrB8=;
 b=FULlHOJYdnCmWEWaN0Pvcp+aLuTwfmHyCFFDAMUmsSaJ8xcjGofFUjuQiKfPZbNysF
 cVAM+r2XXXbdKUmP2OcAH9hhrOAwohCFIV7FfkEJ/ReegHS06JAE0CUAjiLm6sDrTIFQ
 vuXZq5vKDJglFh0E6ApnA0ENPVJWBO5mpHJSp88BIBFu3ZUu4WqDrkmwe4oXLiaEfJuj
 PhXtcLRnJBEGN+dsg5Lwz87wuTSvetIb5lqt6lhUIA8k72eho28X39hyvKyNQNaF7XEI
 ZKFwtY+cc2tKNKWbJYQwLsPlHhZ5VY2EAGysDehwoe9a417PX4xKzn0KpwJK7p1FwXZr
 mLZQ==
X-Gm-Message-State: AFq9FYI8y4MFOte1TGmmjN/R9flylBNVRAgxY73iR39Y2QqOcbvkS+PO
 ClQI+iGAnsJTwPrQ9MdBxxw9p5/kgP8u3mbTsc/5a4GyiASfxd3csmnfakKrFnB2
X-Gm-Gg: AYBFou1rtLt/fHiXSCMRfzcwWWDvrODh/ECfpby56uKKpyzEcilVRp/Bk4/3uIuDzaq
 962s0G71E9znWci9EV2af2xmzxXLONfBNRVQfa3kF/6MU/HXi6RYS4FoFJeYP7KKr6PqLxkmrnw
 1SFwDBvLPn5Hp/jKAo23Ebshn9lqHYVtRfEkSDslJiTvbQjXkShrlte7iHcXXPqUWecJ0cqdEM4
 c9v8y9w6WaRbT8QDIYwr9fBCarLtiQtvhA5IEyLN1Qe0h7mctxU1FKLf7BKqVgCrZes1hFi52+f
 vWCL2U1UXuYwTwACTDLzS4XVkPFpFx3HjDDAthVH20UHgBvowpx2RPzbgLUrVShjHVGvXzw7Im2
 E6wlrwupx7s1RUhUVqXLDhBLl98LJyd/Q4NkuBMI3eV/BRlVupsxlGB6hClAWJrQt/IVw/9TO9S
 rDYvIAqzrF2N8a8JXUtAH6MGYg1gbFDS/0Rn88NLUQJDkPv3JAxrleJEKRI8fTl9XuFRSjXWPdp
 eZhtYSaGW5JegCjzfOgCjShmbyt8qdiALR8B3/7pP63OLxOMhB9jOidNcZqscgpcJoVc12AFEHJ
 YK6DNvh+8OKXxHN2Ede+K//9YiVLt2w=
X-Received: by 2002:a05:6000:2c0b:b0:48d:c15c:94a5 with SMTP id
 ffacd0b85a97d-48e3eb8671dmr8377707f8f.14.1792970359501; 
 Sun, 25 Oct 2026 16:19:19 -0700 (PDT)
Received: from DESKTOP-ECOGLG7 (ppp079166142084.access.hol.gr. [79.166.142.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm12767886f8f.54.2026.10.25.16.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 16:19:19 -0700 (PDT)
From: NickSampanis <nicksampanis@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 NickSampanis <nicksampanis@gmail.com>
Subject: [PATCH v1 1/3] target/i386/tcg: Fix 64-bit RSP truncation on retf in
 64-bit mode
Date: Mon, 26 Oct 2026 01:18:01 +0200
Message-ID: <20261025231803.870-2-nicksampanis@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20261025231803.870-1-nicksampanis@gmail.com>
References: <20261025231803.870-1-nicksampanis@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=nicksampanis@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 19:48:05 -0400
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

When executing retf in 64-bit mode with a 16- or 32-bit operand size,
`helper_ret_protected()` is invoked with a shift of 0 or 1. While in
long mode the stack uses the full RSP and the SS attributes are ignored.
This caused the code to fall back to `get_sp_mask(SS.flags)`. With `SS.B`
clear, this applied a 16-bit mask (`0xffff`); with `SS.B` set, it
applied a 32-bit mask (`0xffffffff`).

As a result, a 64-bit RSP pointing above 4 GiB was truncated. As observed
in testing, the truncated stack pop read the wrong address, loading
corrupted values for the new CS and RIP which resulted in a `#GP` fault
and then a triple fault.

Fix this by ensuring that `helper_ret_protected()` uses the full 64-bit
stack pointer with no mask applied whenever the active code segment (CS)
is running in 64-bit mode.

Signed-off-by: NickSampanis <nicksampanis@gmail.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 45bffcd738..af18aec694 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2056,7 +2056,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     sa.mmu_index = x86_mmu_index_pl(env, cpl);
 
 #ifdef TARGET_X86_64
-    if (shift == 2) {
+    if (shift == 2 || (env->hflags & HF_CS64_MASK)) {
         sa.sp_mask = -1;
     } else
 #endif
-- 
2.51.0.windows.2


