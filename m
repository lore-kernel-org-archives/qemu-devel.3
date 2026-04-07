Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F6E10F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYbr-0003eO-7Z; Wed, 08 Apr 2026 15:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY9F-0000QI-6V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoh-0000tf-Fl
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so49792865ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600557; x=1776205357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCYVORL8twjNtHEKHl2JRzrVw/Xl9zax7Xk6iBP1jLc=;
 b=nTymbnewuclRkPmLNxJfszFSW4B8YKdTNrCqxzcWPIu6MAFDivf+W44sucilleZ59s
 xBiUQTvgem5yWYOlJuhtNtlBo81P/ZobBNQ234RYxDmtuhGjoirx2jF7rPtk5RzDeLxh
 vDugk2MnbBygPpC+d8KeXjjeQifSkexZYVKGfgRi6a455b16vdyd1/uiEFxCbJES34ow
 dRdVx4C0EelRGHHesS1/QoYR558DSm0dGdWYHRBtu+6ro8EDtS0P91UI7iOdvuc9c6nR
 I/KGO4hG6PUB6Q+SLX7wBvX01/Uazw9jL6cdSy+2DwaiPDq1Htk2H9O+77eXEz8/nIUn
 nWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600557; x=1776205357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HCYVORL8twjNtHEKHl2JRzrVw/Xl9zax7Xk6iBP1jLc=;
 b=iqyg33nJozhZU0MimcbyxXQQe1DabUUmtgq+NtDTpB92b5Ba13tVCN6G8n+iLrkEy3
 O2lY2h+EdbDI79yEN8xwOGy03Q1ALtI4MmLw2V2NkJGFPXhxaM9gRwseUbhvqQNeXNC8
 dca4RU8AQLA67d4OMuZ0AqyhT+THypdvczqhJiqfRPP8iV+G45lUooUYxKAOjynuo/5E
 EYS5HYdu9k47s49xqgj2yF9gVeAK3shEx/JEwN1TqgtnB653LjeXr0KmSZ0+pOpCU6m/
 sK694hX63OGnm75TLZBuazUYjMF9ptMb0LIsTL9N9mQhSEX5v4NLtqNfRB62YmxB0NMZ
 h7JA==
X-Gm-Message-State: AOJu0YyEwYkfccyijPmmFNqid2fYNtMB7HtauCOR+FuzzWVFlsVuR5ty
 B6c6OorOswys7EiQkW+otMUkS/IB2oluINLRHtvI+Hx9Qipu5gMJRzBHQzrwyej34bjeAEeLm5W
 HdiSMj2A=
X-Gm-Gg: AeBDietOr3F5XI2MjR052dQcEDaf+MnZW1lW8P7dB2id1qBGukr4YoBrnylpVmGZjnd
 e3iZkOOsm5PL5i2HOQ9sIBozcykk83/aTwTy7u7iLsSBpi83bnczvZ3cmXfrdGEDRpXcQbbH1Kh
 4n2CvBcdR3xJAKZQyS/VOiOwvxprYYfXjVmhCzg7iir8C5M6f5TvdUyCCCkD+tSbZyrxhEK9hgp
 ALDFHmmsmhPnOcjA2IsY59NPLzjEH0OEZweOod+omKUI0kXIqMDRedKo+YsUdmZ6Nf5C8+Ldoda
 4EhGD3S6c9hgATA3iLvTgvyR6L/swIKqyI3PqNqj2A9/6nAqQ4l9jJXqi8vmDQGb0t/amBu2rKh
 PERlyOTRmO3i2EzWZwCZt87s1BPWYU6QlM7Z6MbTXjnCUdcSBMWhZiOjeg3ihNCgb5gRvfLnri7
 CRZrtkhix6FmaR5VNbJ3U8jEUB2CO2wZcLuoZU5eONSjtbI1x/E/Ax7mVGvl3j43odJ0CAzc93z
 VPk
X-Received: by 2002:a17:903:906:b0:2b2:4c92:c389 with SMTP id
 d9443c01a7336-2b2817cd623mr221327575ad.34.1775600557518; 
 Tue, 07 Apr 2026 15:22:37 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 20/21] target/arm/tcg/translate.c: remove target_ulong
Date: Tue,  7 Apr 2026 15:22:07 -0700
Message-ID: <20260407222208.271838-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We can replace it with uint32_t, because we know it's limited to 32-bit
target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c432de2a268..ce427c5a3ca 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6282,7 +6282,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
 /* Ditto, for a halfword (Thumb) instruction */
 static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                              target_ulong addr, bool sctlr_b)
+                              uint32_t addr, bool sctlr_b)
 {
     MemOp end = MO_LE;
     if (sctlr_b) {
@@ -6529,7 +6529,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 
 /* Load an instruction and return it in the standard little-endian order */
 static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                             target_ulong addr, bool sctlr_b)
+                             uint32_t addr, bool sctlr_b)
 {
     return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
 }
-- 
2.47.3


