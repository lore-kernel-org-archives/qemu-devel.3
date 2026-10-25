Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F14606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWUycLvd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL7wc-0000ED-Pm; Sun, 25 Oct 2026 19:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Ur-0006jW-Tb
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Uq-0002AM-Aq
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so17885495e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792970363; x=1793575163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sj5derNeFHp8EGmJKxNHuj+datGr10zGAX5suWbv+GY=;
 b=UWUycLvdWD1SXjeIQKD1cKb8ZDH6gsop4Gm8Kjklw81mY1cXrey+KRBi943CdiV/JG
 io3rpxd7TKPU4PqQDo+nOLaFFEMQrrcfZgCYYA1o0A+iIotQmQpzyVKixeyVQa5rXYxj
 qfMQ3yWCH7hJNdZ7FyIV2jD+LZVzyzJwNpoEP9whlxI0Wu748wdt3sReXwAXYVZWsrPi
 flBVLA2/zv50ZLSt/xfNrPcVpLehK/oXx9iBHSyEUQD/dj4yuXY1RGz8lXQx80h/xyFz
 /iDj1NFgPKn1rvYobIC/PiLqOP0RQKcyp6DkYWI5qUsYobDCLfnmAmgiEuODrS/pilMr
 /C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792970363; x=1793575163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sj5derNeFHp8EGmJKxNHuj+datGr10zGAX5suWbv+GY=;
 b=Cl5+Ift07NZjAnu9K6RqYCg9renPobP1uZplyJbWJvBUZtp2EAC2l+ZJHGn+VgySO+
 xSlsDpk91yxT4TiR61/3uGnfuRvUTUyZoCz56LJjCmQRYV9AxXfkAvg39U8dQ+hY76MM
 EsPbVpKsVb7IlKrVHW9neXlsSqnkPT9XzdxMZkd63KI36aUuU4H06EaW8eEFFmFDXW8r
 2BKGBdTeMSVQLWII2q+N6qfJAdYKWtC0kIStkC5x4UorovLu/qOXHTxJiRg4hzQQnguC
 +7EhQFtUTpDV7CL6/5nWRg9dEDFk1MVn0IYRtNvBu9cnLc5GNz4XFr2tglcA10EXAWLf
 fqrg==
X-Gm-Message-State: AFq9FYINQYSoJxqv0AxhjdOpl9M2oVPnoHx0gxzC6mIYDIYCoysD4+1n
 Rsvw+iTcCU2zYJ+VS99sk5MxkpKXdfySV/LLBgMosWeFp79r2T+eW8wdi09ofwP6
X-Gm-Gg: AYBFou0itmytQUJHU7UWbtSnEaRmzQ7SEPF1/OZP7OIK86RjykbKtJwcQs2/oawsdey
 YgWFu96awayMIjRuHnRXjRmF05Kead+GV7BV36koSzYYViIK7Mk05bVhA+i9ijlR1udWRdIsE4x
 EEteWekSIkQizu/PiU+21yp+fxHVz00AYOVIfdKl1DC2BdeM1OFJbR0ZGaYSxADGyhmTCfJwPF9
 RaMfGQk4iYCXz+bjN8PV3IvW4jbm6S9Y/JmZrpNedg59CoxgfZ7HQNCk6lLiZJWy6kXxiwTV9kg
 be2eqCQHtndh1lScRKGnqanKnFxO172Rm0zyrz+d5ve5M/0k0UsVqCZbUYo960C/ikhxFoPfrf5
 h6+AdPpmfZm/7dlX6lT6/5+YnIgT3aR5r/HmwRpPgP4/SPgSnf5dbEl5srrQSijirnf0RLBCmHr
 lgTD2qsZIYxh4/QsFBMiusKIvkiKNN2Wk5EfneWEGBSjRkL6V3yG1GWE4zjvpi7crV4KkHCmowD
 ZrNx5C+GeSUSVbYH59x9BllwjLXC3ck2V05ADep2CfIIH7ouEDeG2p1UCcjBFqhv3U34vsDhn0v
 UxzA3G0fNQpmC3a2gUajTfPU0ZlFNhU=
X-Received: by 2002:a05:600c:6217:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a35aae5c3amr84642615e9.0.1792970362872; 
 Sun, 25 Oct 2026 16:19:22 -0700 (PDT)
Received: from DESKTOP-ECOGLG7 (ppp079166142084.access.hol.gr. [79.166.142.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm12767886f8f.54.2026.10.25.16.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 16:19:22 -0700 (PDT)
From: NickSampanis <nicksampanis@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 NickSampanis <nicksampanis@gmail.com>
Subject: [PATCH v1 3/3] target/i386/tcg: Fix 64-bit RSP truncation on far call
 through a call gate
Date: Mon, 26 Oct 2026 01:18:03 +0200
Message-ID: <20261025231803.870-4-nicksampanis@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20261025231803.870-1-nicksampanis@gmail.com>
References: <20261025231803.870-1-nicksampanis@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=nicksampanis@gmail.com; helo=mail-wm1-x32f.google.com
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

In long mode, a call gate is 16 bytes and always has a 64-bit target.
For a same-privilege call through a call gate, which can also be reached
by a compatibility-mode caller, lcall_protected uses
get_sp_mask(SS.flags) even though the pushes are 8 bytes.
Consequently, the pushes and the stack pointer update (SET_ESP)
truncate RSP. This is the same bug as in the previous two patches.

Use the full stack pointer when shift == 2, the same as the
inner-privilege branch. This condition tests the gate's own size
rather than the caller's mode, which is why it checks shift == 2
instead of HF_CS64_MASK.

Signed-off-by: NickSampanis <nicksampanis@gmail.com>
---
 target/i386/tcg/seg_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 87492a2f64..f11b55d136 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1925,7 +1925,12 @@ void HELPER(lcall_protected)(CPUX86State *env, int new_cs, target_ulong new_eip,
             /* to same privilege */
             sa.mmu_index = x86_mmu_index_pl(env, cpl);
             sa.sp = env->regs[R_ESP];
-            sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+#ifdef TARGET_X86_64
+            if (shift == 2) {
+                sa.sp_mask = -1;
+            } else
+#endif
+                sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
             sa.ss_base = env->segs[R_SS].base;
             /* push_size = (4 << shift); */
             new_stack = 0;
-- 
2.51.0.windows.2


