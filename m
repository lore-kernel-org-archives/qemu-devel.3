Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA60BF9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUYk-0007MT-Ko; Wed, 22 Apr 2026 06:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXv-0006wQ-2W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXs-0000pH-OP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso56389515e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852659; x=1777457459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
 b=da3PKY+B1lHfDFNrpkxoY16rFBIc9UZ8yqwXhVye6y7JlisZiDMp6Fpfw0SzKJ9BBy
 MXKIyv0rUZr+M40vvzmKXm6Pyr5CB7uJPSOrq/muzbmEevUG+xv0Gl4YZXx0iIa5KyLk
 QBfb8AIO1QtO1iLSK5kcJc6mXDr7bzJ66NDqjI36DQ69d+XvzDABfhpMnoGRsJ08X8LF
 BNTJyhOsxsQFbh3c03PDekDTngoRZt/MdzAPKTHupOhJHkPm0gtK1IzFiXoTUMA0qwP7
 VnDoYG1w+/YwDTwEBADm/cB1q+0vOEKQ766StqfbFtcvcOepuQpKneh/x9z35HGUy69L
 hoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852659; x=1777457459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
 b=k49TXd8kcXFoj+ibWcCiGg+E20HpAOSxVWRefFcITNHNjcCwRzNhL+5V0gqlBM2kn7
 VggryMiznb8B5xnC+Q4u9M81PoAR3r2GBuVRywm9QrFkYWQmEbYg2jLBzdE67ulnru2g
 /6gBA64TY3KOLV3Ur28syjIjuMa3w35V52WIiuHzefre9nadTInXUSXc2GL5Y9XTiGMa
 DNmbjqx60UzEpXW4l+QDSFu3A57RzTvPf892RGTr9BCfBrBp+zAwcfg0Rj/QxOr73V6Q
 KL5PGrSeLDYGx8a9BW2XG430OtTFhdWF7rIY8b0ux9VFR3qgAKh76umgOREs0Aw/Bx+8
 dTEA==
X-Gm-Message-State: AOJu0YxBsrZRYFCE9aTccC5RWyWWnqCgqd2zeQu/TT+w9jiveb+a1Kl2
 irXibHL4cVlVGrYO1nyAO2YTYw7+zMVP7TbGPvhrqpgwyL0pZ4aF1vN63DBv9WlPyi4=
X-Gm-Gg: AeBDieuhdvFJTCDbNazYh6sG8KqxrhSozHXW1u+dJVC6GFsIlOrOrm1LqVuLpZOnZCM
 rQ4cgpsfGdcAmSGHTY5bBWCMiLPevVuObMzkXoHQJy0MSTwgQMBOMp+A53JoCttif7dBWQBim88
 tmT4b3oRTFpHjBf20GAcKuLIFEf5Yf7/E6qljlfOfcQl+zHZnKt41RjS+bMdzrfAefhMHBkMzui
 Gt87syfUx6D51YS+qHcIheJCeGrH6pu9bWnPhqoXCE3TP0ep/dYOmYAHZcCY0Xbmdz7hgwl4w1k
 gVZRUxM2Rz4TSnT6Kwdd6fEDRPgDv9Xu1MYhMQ5lYsUDqpFg3QYGcdZ+FWXbvmx6a1uJj7qTKGR
 beDwceXZT2FaEem+qvnmyd1mXWJyYOtgwLksec/p9TQdP57QpNfDPE0DqBDtKb4Rc0H2QructH2
 POgUqbp1hEnUUmONYtV2m7Xm952tEdDvsl3g==
X-Received: by 2002:a05:600c:1444:b0:489:1c0d:c9cb with SMTP id
 5b1f17b1804b1-4891c0dcaa5mr145715445e9.5.1776852658688; 
 Wed, 22 Apr 2026 03:10:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4633bsm44099622f8f.26.2026.04.22.03.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B610614A1;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 21/31] target/arm: use syndrome helpers to query VNCR bit
Date: Wed, 22 Apr 2026 11:10:32 +0100
Message-ID: <20260422101043.1234229-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

These are only valid for data abort syndromes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index c74d8e785a6..bbe1e70bc43 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -48,7 +48,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
      * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
      * faults and regardless of the target EL.
      */
-    if (template_syn & ARM_EL_VNCR) {
+    if (FIELD_EX32(template_syn, DABORT_ISS, VNCR)) {
         /*
          * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
          * they are always reported as "same EL", even though we are going
@@ -190,7 +190,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * because we masked that out in disas_set_insn_syndrome())
      */
     bool is_vncr = (access_type != MMU_INST_FETCH) &&
-        (env->exception.syndrome & ARM_EL_VNCR);
+        FIELD_EX32(env->exception.syndrome, DABORT_ISS, VNCR);
 
     if (is_vncr) {
         /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
-- 
2.47.3


