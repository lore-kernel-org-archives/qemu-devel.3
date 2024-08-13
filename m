Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22991C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduyP-0005rp-7u; Tue, 13 Aug 2024 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyM-0005jJ-WD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyL-00037q-Ai
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3AoGWxUBf1bbBzxz0nTsWOl3v83/0it+wu2Qc+Vsvg=;
 b=UkNkCRRbUF+xS5cUTKYDzwyiHTvV2vu7rfQS/KrdPZ8Qh75a8cDaDEODoZ2papDnoSYVBv
 WfCbAkvC9yZQn+T4UeY1bm9U39bTj9ytWBrfXBg+SbFbfUSEemsXEpvJXcE4GVUtrNEHdI
 /TbxLrl2Rxp5cc/6llgxWPT9DF7KlxA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-UdQqbakUO0SHUM2SD4mJsQ-1; Tue, 13 Aug 2024 13:06:11 -0400
X-MC-Unique: UdQqbakUO0SHUM2SD4mJsQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ef3157ae4cso63359621fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568769; x=1724173569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3AoGWxUBf1bbBzxz0nTsWOl3v83/0it+wu2Qc+Vsvg=;
 b=uAVnKcZdibFKlXZWTyuD848p3s0TV0AnShALHmB6XE0npdj293bhoxkoW4NKkD4FLf
 2fwfGC5xSIVTRbPm4s7jHtnu6Xn/IWuRJgPji1gUgXt+lGRl+z2aIY82YrB5el4TnK1B
 XMTxA9iM6gX1KkjO52rrt2AsBTN0CkUwPnuPHDDksLn2V5J7mgYFe4UHiBIZL3xCGvkh
 jnYK+nkznGpgurnjH/W57J5bIvcR7Plge7E0DpL3cXTcNIcyZwD8ashMRDyfrf5xz5Ry
 kexwOsUDbQg4nEhBhgfR2M8xO75B1fKyUG8+MU8KuqKl8U2ZtWALXmYUz6zyjeFodVa4
 VrKg==
X-Gm-Message-State: AOJu0YwpBuolLkiBU73vNoumssZBXCirA2mb0T34YRB78ALdEyDpW9MI
 rA0UuwCs+gVdHKg94/AWDsk4qg2vcz58jXN255RXWztOGfVLJN/SgAjekhE15kBUP1yURSwA/t/
 SCI7dyD3uOiQz9yw3sr5dRGDHzCVd29pTfhYzEXRmlMKyF0BSZ5Eea1NaAE5Anwx+wexYevyZ05
 Scm5aINcwg2ksI/J4JAG8JWimn982JYlJEL9gC
X-Received: by 2002:a2e:9bc5:0:b0:2f1:67de:b536 with SMTP id
 38308e7fff4ca-2f3aa1f0788mr272781fa.24.1723568769424; 
 Tue, 13 Aug 2024 10:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAoqzXz2rHYrg6dCsSt2rB7weXlmJF3lJ8VjM9C3avp14WxvKPU4E4ZWwzdtpME24ZTuY6KA==
X-Received: by 2002:a2e:9bc5:0:b0:2f1:67de:b536 with SMTP id
 38308e7fff4ca-2f3aa1f0788mr272501fa.24.1723568768858; 
 Tue, 13 Aug 2024 10:06:08 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f475ccsm85779966b.14.2024.08.13.10.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:06:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/6] target/i386: Use unit not type in decode_modrm
Date: Tue, 13 Aug 2024 19:05:52 +0200
Message-ID: <20240813170556.104193-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
References: <20240813170556.104193-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Rather that enumerating the types that can produce
MMX operands, examine the unit.  No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240812025844.58956-3-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 03138b3876d..30be9237c31 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1799,13 +1799,13 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 }
 
 
-static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
-                        X86DecodedOp *op, X86OpType type)
+static int decode_modrm(DisasContext *s, CPUX86State *env,
+                        X86DecodedInsn *decode, X86DecodedOp *op)
 {
     int modrm = get_modrm(s, env);
     if ((modrm >> 6) == 3) {
         op->n = (modrm & 7);
-        if (type != X86_TYPE_Q && type != X86_TYPE_N) {
+        if (op->unit != X86_OP_MMX) {
             op->n |= REX_B(s);
         }
     } else {
@@ -2040,7 +2040,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         /* fall through */
     case X86_TYPE_nop:  /* modrm operand decoded but not fetched */
     get_modrm:
-        decode_modrm(s, env, decode, op, type);
+        decode_modrm(s, env, decode, op);
         break;
 
     case X86_TYPE_O:  /* Absolute address encoded in the instruction */
-- 
2.46.0


