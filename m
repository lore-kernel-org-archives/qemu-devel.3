Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B910F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVy-0005dT-QN; Wed, 08 Apr 2026 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY5v-0006wg-P4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoX-0000pg-F5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b2ae8a0103so8863435ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600548; x=1776205348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=SWV3KPkzqq2XpdNe/o5lBvFQj8VSdNy8TD2lXoTNWcR74w4WoRG0Ts4r4qYcg+XW/w
 hHd6gA1BFe9ak7Kga73sXjBr7Bx3TeOTcOk+JimV3VcXsKoLyP2VNiMQmgwZry6sH9ic
 KgPKOpsTnMeNdwoneoKzGdQwdmQIxgAPXeOOhCdFO4+UdkVucK/3x9T+qiCL7jSqZMwk
 BkmYZ7/5UJtOZBVJQTGdr2oS092j/8aMjEqp0s1FyD6yKMBUUM0S1UI+B/mOFAgtLSRm
 7sc0Xs+w3rZf28hpqP4nCVZhR6nByULkjWOLkQ69Sq+nOI+B8AgPBD7cD2KCNT+gxnK/
 daYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600548; x=1776205348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=rDPUz3CQmvwV5eTP/RK7JXS5Ik7YVDpR9e3ZaOR11dOHAbPmgF9LNd+fsYCxwpYniD
 p/BcbEE/Pn6u9ElVQ7ged8V7EN7j59I9D8NRx4cbmFVzEujSDqVPf/6kpcV6PDM2Fk5J
 biImYZ8H4AK1PWzQwrw6wDnQ6N2U6VdAoGME0Uqv5iJq57cF/vSstQ3kpCtuGaLIi8yj
 mofwW4z7h9O0woyeivcx4iYTz2/lguHii9Simj5LZoomwTVRrnL85UWw6jnCiuIKGkFS
 kzSWJTj6LgzK4oIWHSlkni3Kb4E99KWnssMdm/PeGHuPLbz+lqFssKD3jpDAvlIQd9lu
 RUbg==
X-Gm-Message-State: AOJu0YwjfFtkboNu+svrzopCHMu6QcrwiSArMVmimQRH1E78sQTWPZUk
 aINPi7gVm+y7SECM3vSx74VKS+Tyrj0SkOLE9IA/HBJyHJGzoDGZ22jF1ksySoVf07BQ4LTWUem
 wFqdDQBk=
X-Gm-Gg: AeBDieubhF8nuk5q0sNax3oJ/xEiB5iNM8FRhpRGd5ahWsV8TqF6gpYOoMk8uJPK2zp
 PlETaNRvIFZblyeojxXFH3o2RPxOq60AKrZnhaykJ7p7o24Ezo9wsM7wfpauNpzunhtCNiSprtZ
 8CTrSuQ6c4hsPWkITa9vVDHbrQ7Bw3GIvvFGzNvp0mcDtZBKMP9Qs6DvQZGWewz+Rpgx/bN9TOX
 99jUhLEbmySa/xfMex937h3vQNHsRMOm2IpOPZjzUvWViLeNcQ9Yr72CSE3Bj1I8kOARqvOShQ1
 ehb7NkCgyMq94Sva7ozrTjwaB+EzgfT12SeS8852DY1/QvDI9+ZtBIFdXYXvRXvan0Zeqlrggwq
 ypBpqu6Hzf5jUH5uaZL/h/0XfrNbIRYhaA3Ohfd+8I0Co6JT1NqoOmW0LnECuttaM8YL1aEC/0s
 mPyyaXA//3ctJYpweXII/E9YmLNxv+/a45VTiibqSgv8UxEEvjuw599N1OpzeTuYy2RH1l0eaG6
 TBD
X-Received: by 2002:a17:903:b8c:b0:2b0:6885:f1d4 with SMTP id
 d9443c01a7336-2b2817b5e43mr196684775ad.39.1775600547848; 
 Tue, 07 Apr 2026 15:22:27 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 12/21] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Tue,  7 Apr 2026 15:21:59 -0700
Message-ID: <20260407222208.271838-13-pierrick.bouvier@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


