Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A6606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O2UXxwYZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL7we-0000Em-ER; Sun, 25 Oct 2026 19:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Uq-0006jC-9L
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Uo-00029w-PI
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so16478865e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792970361; x=1793575161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kEYJvAqBfYlkI4cuWFKUiPqYc0nd1Y+i/MMABj65Dsg=;
 b=O2UXxwYZWFWbS0eWD6N5GoT0s02rXIIWBymQfl1g1cP3sO+DIPIKlrO4kyMmwOHDwv
 oECoggGqG5pTZZ5MPGf9iZ1D/va1KXNy2XHaAgy68PrrXA8kke7HzZojt2xO/DISvGRE
 RGpH5obqLv7AFlBnhwGSKiYX5BXQUHn454rmKJKTkO6Sk5qxpF17n7uL9qbYd0yMPmoB
 G+3/Ny4ryrbLiXlPD/LRiAfVFEYKf8tYygxl5zjFzpZmA40hbDFPd9GlS15wAVUdufCv
 GIyn/F1NUYK822u5gCN0P3nvTDgbXCucqFH9y1eH7nB6mAup5Nxve/jcvcL77lXwClvi
 xnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792970361; x=1793575161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kEYJvAqBfYlkI4cuWFKUiPqYc0nd1Y+i/MMABj65Dsg=;
 b=MZHpyMi9HyvwKRMOjDQfIqpJMakTMHjsZoMeF7xjE1kHfIvNr+TATWJZPVzsfFFHdG
 KLceIKsOjb7bOhHnmFul7dum/88aPQ+e3RZLPE98RPGy5+VTQcWtWFkwB+Yuw25GSnml
 Fb6ZN0UT/6iiY6HTg5mOnzakiPJIn6P//rqcb0SEoAPkeXCh6EPsZlgNpIOP0K5YL7ze
 dif4QA02nFNcKiypZ9yw4fWPN0VYi6SSQ9qiY3fWNFIZR/Mn+8T0fMAPBc8b9OfGnaYj
 XvOMPBQj8PN+e/A5mvdU+93a00GU4heKgt8qvAA11+HjbJyFFod8RFAmy7xnMbW0f9Te
 +ooA==
X-Gm-Message-State: AFq9FYJIXc4ap+qZytsFo17ohhb00FEjosBsrHZLw+x+se7XrAj4JZxu
 WTy0poxbcezZrCrQ5e0Q5ATJDg6BRhAm5aPpntvFvdkl1y44EnCz4zNSTzax1jkr
X-Gm-Gg: AYBFou3d4CwysgpsVPTeuSWZ78FYslpWnPJ4BZvsk52tlh4QwfjwB/rp0beC72KbvRP
 au6DnpL4vi3qlajj89QEZm94b5VUNO+9zaBHlygCLHLDLZXrIA9mz5rGt7GaCKHLK4aP6gcJ2Id
 NbOY6/jQs0hxHfjIVptMkMN4bWrfVvEqgYy68K7Gr1C1f50IGAyGCuRsAWpOVWafc9AQgmsnM6H
 r9C7vMO8N9nAhntKqgplHLDjjFCuTiA+7bGzeqDqHZGLKWkjDNdPZ5scND0TEaaO9xwDAHUWvkw
 /s5UyGkvUtkcrnf8b6zm/e2YUTBd8HSTw/rPJdjP9xgZO4L1dckkMYJdsFrb+M3LDs0jkHHnqn5
 K6kDman/w2OfvOgoB/Qz6Hosa8sydtodZl/mDnhg4ljlryJIZeeZTiibiJT0W26Fc13Ac0WXsPy
 KLu8I9AUK8lBrksKVdCyi0a8EOTJNHxPOOXC2o1jOBnSPtPVMI2jfVwB+SJKBsltuI85m+ELAaa
 f5WxbRJuUyBJha9WOxMWzMOvjxEwuw9YEfThLNUe8JTIN/5R8XjabfouVaUGqmV/Ykiv3QGWnAh
 iVR8xd227ieHJGALvUreuqfPxzXmoxc=
X-Received: by 2002:a05:600c:3e10:b0:4a1:80d8:aed5 with SMTP id
 5b1f17b1804b1-4a35ac8bc6amr86102295e9.6.1792970361160; 
 Sun, 25 Oct 2026 16:19:21 -0700 (PDT)
Received: from DESKTOP-ECOGLG7 (ppp079166142084.access.hol.gr. [79.166.142.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm12767886f8f.54.2026.10.25.16.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 16:19:20 -0700 (PDT)
From: NickSampanis <nicksampanis@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 NickSampanis <nicksampanis@gmail.com>
Subject: [PATCH v1 2/3] target/i386/tcg: Fix 64-bit RSP truncation on far call
 in 64-bit mode
Date: Mon, 26 Oct 2026 01:18:02 +0200
Message-ID: <20261025231803.870-3-nicksampanis@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20261025231803.870-1-nicksampanis@gmail.com>
References: <20261025231803.870-1-nicksampanis@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=nicksampanis@gmail.com; helo=mail-wm1-x32c.google.com
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

When executing a direct far call to a code segment (no call gate
involved) in 64-bit mode with a 16- or 32-bit operand size,
`lcall_protected` falls back to `get_sp_mask(SS.flags)`. This gives a
16- or 32-bit mask, but in 64-bit mode the stack always uses the full
RSP. As a result, the pushes of the return address and the stack
pointer update (`SET_ESP`) truncate RSP. This is the same bug fixed
for retf in the previous patch.

Use the full stack pointer, with no mask, for a direct far call when
CS is 64-bit.

Signed-off-by: NickSampanis <nicksampanis@gmail.com>
---
 target/i386/tcg/seg_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index af18aec694..87492a2f64 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1731,7 +1731,11 @@ void HELPER(lcall_protected)(CPUX86State *env, int new_cs, target_ulong new_eip,
 #endif
         {
             sa.sp = env->regs[R_ESP];
-            sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+            if (env->hflags & HF_CS64_MASK) {
+                sa.sp_mask = -1;
+            } else {
+                sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+            }
             sa.ss_base = env->segs[R_SS].base;
             if (shift) {
                 pushl(&sa, env->segs[R_CS].selector);
-- 
2.51.0.windows.2


