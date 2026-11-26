Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AC606A338
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3OjWx/B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaXb-0003a0-Hi; Thu, 26 Nov 2026 09:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xWaXQ-0003Dh-K3
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:33:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xWaXI-0001Ak-QZ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:33:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so55127155e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795703586; x=1796308386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cd5vkrrSWcpZ7F3e4D1cM7AMS3lJGeo3zC6MUWO6l04=;
 b=h3OjWx/BD4YGu9+xuQ3YUTvAiWwEsPtnmxu9482gFYkBfAMVNZYFV2SZ+zfgvxIMjw
 fzM3CXLbmpUGB6WQ3nbw8QIZbU5jywx/kkA1u2clkVrRGM+xvNLoNmYRBLumBEMbue7y
 cQtmjc+bx0zNF6Dw825OWgs3CWHZpw6OBW0SRA9zH65l7p7ld2E/FU3UoLaUXMXWTdZo
 Ui5BDWuo9YibII99o5/lmcx90EEI637CUNY4APm1key/EYCC3avFgGyvySyJDNHAhFX+
 JxbTF/SID7UABUbw37ZYfmcLZHUFpg2smjvS0d9+88gNbPTpLd5F+IZSryC0U6O903Ca
 EXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703586; x=1796308386;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cd5vkrrSWcpZ7F3e4D1cM7AMS3lJGeo3zC6MUWO6l04=;
 b=Df1ieVDNT9LFDycHb6fh3UTh8Cbt0HHSeqbJQlqLH9JV+vnbImIqJA0qp5HBtlEL7p
 4H+s7bMF2UYCqMlreUvqcqYE3bWqXKLjXln3EGrExfCRHdaWip2IXhJs59HqO6uKSJJL
 qjJVmN0nRs8u5vqT0/bkp0vx5o0zICxKWJxwYmOz9KjwD4y5Sn/Z6w6ajsRqYqyrkxjW
 yioXMRQeZ/dAT+SjTLw51wgps9Cvhgo1lyQYcAGqCuXWLENrakDzY07Yq0K0BWksD46W
 lcCr5ZhfFQvUXmQ2KXwe+Og3DmX1LoAhnGEHbYAiE6hfonTEXvfapkN+voZ+my7vtTrG
 uDvg==
X-Gm-Message-State: APuU4Z8hrBwCi/e2NZtZ0TTmy4smGZs2amS58wNldNX7FHBpzM0N8BL0
 XZVF/Py1WF8UUsLsfnoJR2d3C9AMG7Gux+MYLaFqhFsrzQWK7YhxMWGYZr/jKzs/
X-Gm-Gg: AZFdTZdueIQ8ajqXEZD+56W4yLrkKNQBsQ0EbWlOl3Rl5ooTrEBEkCCke7J1SQ4NZAV
 BZtuV9Ib6Oj+iX927HzXLLNRT9ubXtQGci8WjKsHG0JXeV6vaHsFSNRKs59mVvVKLA2hARv1v//
 eSQ9ICn5KHFKm6+3nb2CxEP4LA1vX+PZZmBILb9wCzIe2Ror2Sc8SLz8gWHuNKBy/3cA9gGxXRw
 lHpNfTonpKlE9ikLk1TBJQ4ybBPHB+1/5JQZZcNX7R7r6FLkTbEyhiuyhM5Nv2MqP/adi6BVJfp
 vnKBpvqCpivi2p/6ODTlC7OS+OZgAvjvmsGwhwmNGbqveCmFlL581WFDtvjS5Py3bKlIG3iUxFA
 IpLTYXNxTTront1i8JGBHHKvUWjkQKXR5qsOu9+V7LfY5PeTnBwB3bItIPXiXABEgA/ingptnug
 2pJGS5vzuagl3Snb4oWwtSA4ZZ/5R05yL8mg/vjqoQNAHUqSBEWnT3bjioFRT9Llc8b7WX+5m7c
 J2Kn2slhBPPIzSPUGj91/9iVbNDoaGQbruESXiDxHGgQLtVrO80u1up4A8F2pr5oykUlzSKSQVH
 4UHIEe6tHMrWzA2GovN4RLf6YyGfawmVIiroTx+b01MGIAsBQksJ1g6Rh94gQwLdRqEbytKwgTk
 9KMjBjAPros+xHmWrHA2VesgoksTOwUbDHc8xYXRG
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4bb8880ef6amr458687955e9.14.1795703585903; 
 Thu, 26 Nov 2026 06:33:05 -0800 (PST)
Received: from noys4.dd1.int.kernkonzept.com
 (ip-178-026-066-148.vkd85.pools.vodafone-ip.de. [178.26.66.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm849925415e9.13.2026.11.26.06.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:33:04 -0800 (PST)
From: Frank Mehnert <frank.mehnert@gmail.com>
X-Google-Original-From: Frank Mehnert <frank.mehnert@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 Frank Mehnert <frank.mehnert@kernkonzept.com>
Subject: [PATCH for-11.2 v2 1/2] target/arm: set the event register on a
 failed store-exclusive
Date: Thu, 26 Nov 2026 15:32:57 +0100
Message-ID: <20261126143258.1056688-2-frank.mehnert@kernkonzept.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126143258.1056688-1-frank.mehnert@kernkonzept.com>
References: <20261126143258.1056688-1-frank.mehnert@kernkonzept.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=frank.mehnert@gmail.com; helo=mail-wm1-x32a.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since WFE may sleep on A-profile, a WFE executed outside an exclusive
region halts the vCPU until an event arrives. Lock code commonly
branches back to WFE after a failed store-exclusive, for example:

  1: wfe
     ldaxr  w1, [x0]
     cbnz   w1, 1b
     stxr   w2, w3, [x0]
     cbnz   w2, 1b

The store-exclusive clears exclusive_addr, so the following WFE sleeps.
On hardware, the store by another PE that made the store-exclusive fail
cleared the global monitor of this PE, and clearing the global monitor
sets the Event Register (Arm ARM D1.6.1, R_XRZRK). The WFE then
completes immediately. QEMU does not model this, so with interrupts
masked and no event stream the vCPU sleeps until another PE executes
SEV, which such lock code never does.

Set the Event Register when a store-exclusive fails, in both the
AArch64 and the AArch32 translator. A failure for another reason causes
a spurious wakeup, which the architecture permits.

Fixes: 01b223f895a7 ("target/arm: enable WFE sleeping for A-profile")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4938
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Frank Mehnert <frank.mehnert@kernkonzept.com>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 target/arm/tcg/translate.c     | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49472f7d97..45f3b3df03 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3531,10 +3531,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
     }
     tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
-    tcg_gen_br(done_label);
+    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, done_label);
 
     gen_set_label(fail_label);
     tcg_gen_movi_i64(cpu_reg(s, rd), 1);
+    /*
+     * A failing store-exclusive means the global monitor was cleared, which
+     * generates a WFE wakeup event.
+     */
+    gen_event_reg();
     gen_set_label(done_label);
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 442c34ce84..2eef2ceef2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2137,10 +2137,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t2);
     }
     tcg_gen_mov_i32(cpu_R[rd], t0);
-    tcg_gen_br(done_label);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0, done_label);
 
     gen_set_label(fail_label);
     tcg_gen_movi_i32(cpu_R[rd], 1);
+    /*
+     * A failing store-exclusive means the global monitor was cleared, which
+     * generates a WFE wakeup event.
+     */
+    gen_event_reg();
     gen_set_label(done_label);
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
 }
-- 
2.55.0


