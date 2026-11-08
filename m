Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D9606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJiSWY0g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ0d7-00054f-Vc; Sun, 08 Nov 2026 06:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xQ0d4-0004yO-Ko
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:00:08 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xQ0d2-0003c7-7d
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:00:06 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3acd239776cso320861fa.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 03:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794135602; x=1794740402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rx/W8UYkJadlt3gkusVssWn0V16V7eFo42YPrHgzUk4=;
 b=pJiSWY0gnPzKuOs/Urjxb53/LYLHhyt6czP1eB9ibCgDunvvH0o5AUt0MSyah1sWkw
 BkUB4Oq8EjWPMhFy/oaPHJ80RJhbz4Wu8IprwQqtMv9K48hI04eA+tikOvsy8P16u0Vr
 Ey5VTci29LqwBzy2e+SzSnNKLIyv1+YBO7bVa2SjREuxnl4T1VcDFnFeF8ovB1JqTyyH
 vfHf0fRntMglmfMQbtU/3WYJNcL0dOwGzxnrb2wXjL8RzCI+/3kV+02zxIU24POulyvO
 oQ6938LBf2rHAUUWAfWjWuWU6GPKdsjrQGwyNnqVKiPiM6EiqoE0UySJo55a1dd9Sutf
 YBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794135602; x=1794740402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rx/W8UYkJadlt3gkusVssWn0V16V7eFo42YPrHgzUk4=;
 b=m+chRu9rM3amPHbesc4Js/IlMmJakxM+Zadyvx71xJxu4W/5NaST1kjMil6I6EV+F6
 5xvwzQB4MSmNX4k1ml94iNU2pmFwoEDNPJy+L8GAxwDxWFPm6/KiSPZbC7b6ItXfO7oA
 qyi1vwqI71kwqSXrjx6qqQvzzl/Z05zbCA3EBDz/pOxP47SHyBfCYMIgrug8Mj94Tzg0
 ZwcuhxO6mppXTSjwtPT47RfMJ5rsnGGB9w6D/fGiKd2giSK0CjM42rsKU/yErxeWd2QS
 BeeAuQD6XyKsYKNxZxt5mqmB4l+dStn7PPfoLfKsTMYNn1VhFDUPmbpJfbMzERJhCo2l
 mO5A==
X-Gm-Message-State: APuU4Z8Bbhh6L7zJTkJNwxj3PcGZMuU3GuDlsGXe2LQih9jhbnv9sApV
 7hLNwSa+4XhEluQUjK19J0mgBAKUEdphj60BXRoh7kuW2GGtlNIPs+Fs4BLR/THnG1o=
X-Gm-Gg: AYBFou0WRea5+N4qjc3aMtKocdAWVBdgoF6ny4AYfAuvwt2ogYe03IXPPXcRWPPjvqB
 traMx+Y/7XPK4K3Y9Cyj28W3rjApQVXIB68ia3Ie/lP4HQ4XJCXYEWiJU7axA7bkY4GRhEV2KaO
 HkEZVnPBmd9bu0cVXwMmZZ31i1DAfsCha2joMfk+ho1rVFqQN0hVSGXM1fOcuoyrDybXgIZ937O
 VaUET/QlYfYwYqAhyWL+Y2NRXwgjfdyqfPu/Kd9lc0RaP6ccElXoTnD9J7PMdWiPgvaA1NJPZi/
 i6jJbwcDOo53D4iBGA27cH4F7iMVlgs4qFTbiLPHf3f2QQLW+5NgVKVvS1qPQv+U5P0tkSMwBNL
 IkqSXOuPvQU1OTCqNoU+WRrxfrxc/gRMJbw49GcfvcC/mDZW2VkyFqvq9sUoUNsvs6vP2bZGLLl
 T3OI2Yc2Lx3qg11eo7ZRpiVd6b0N8Hu/kx+3d2OtFYhyFr/aQsYNEqfpWQZqjgatweOjd0Ss9hx
 ZxeXrpno2daUeJg+ZMSNlc70M7R5ZU2AhvFdmnDe7KyCKS5gyBjI3OXxvSEMZUyJvLQ2/xKwFHy
 XNr8Kj7HmRNgdcrrU7/tmAnAz2yPCfN8e7dY8BVdatyKucUX9fsbjhZJippQu+YfptIYmc1f/10
 7
X-Received: by 2002:a05:651c:1441:b0:3a6:6f81:1027 with SMTP id
 38308e7fff4ca-3adfa4c0c62mr2517241fa.24.1794135601616; 
 Sun, 08 Nov 2026 03:00:01 -0800 (PST)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3adf9df71fesm3007521fa.8.2026.11.08.02.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 03:00:01 -0800 (PST)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: Allow execution of INVD and WBINVD only when
 CPL==0
Date: Sun,  8 Nov 2026 20:59:57 +1000
Message-ID: <20261108105957.62338-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to both Volumes 2A and 2D of Intel 64 and IA-32 Architectures
Software Developer's Manual and Volume 3 of AMD64 Architecture Programmer's
Manual, INVD and WBINVD are privileged instructions, and therefore an attempt
to execute them at CPL!=0 should result in a #GP(0) exception being raised.

Currently, QEMU does not perform a CPL check when decoding these instructions,
which allows the userspace to freely execute them without a #GP(0).
This behavior does not match that of the real Intel and AMD hardware.

This commit fixes this bug by adding the missing CPL check to the decoder
table entries for these instructions.

Cc: QEMU Stable <qemu-stable@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: ae541c0eb47f ("target/i386: convert non-grouped, helper-based 2-byte opcodes")
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index aa22014786..956ac8b18b 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1423,8 +1423,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xf6] = X86_OP_ENTRY3(PSADBW,   V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
     [0xf7] = X86_OP_ENTRY3(MASKMOV,  None,None, V,dq, U,dq, vex4_unal avx2_256 mmx p_00_66),
 
-    [0x08] = X86_OP_ENTRY0(NOP,           svm(INVD)),
-    [0x09] = X86_OP_ENTRY0(NOP,           svm(WBINVD)),
+    [0x08] = X86_OP_ENTRY0(NOP,           chk(cpl0) svm(INVD)),
+    [0x09] = X86_OP_ENTRY0(NOP,           chk(cpl0) svm(WBINVD)),
     [0x0b] = X86_OP_ENTRY0(UD),           /* UD2 */
     [0x0d] = X86_OP_ENTRY1(NOP,  M,v),    /* 3DNow! prefetch */
     [0x0e] = X86_OP_ENTRY0(EMMS,                              cpuid(3DNOW)), /* femms */
-- 
2.53.0


