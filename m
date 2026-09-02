Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEFFC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jhm-0002V6-UL; Wed, 02 Sep 2026 08:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1jhg-0002UV-FF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:04:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1jhf-0007hR-0C
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:04:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so8298215e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788350669; x=1788955469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4A2M/98xuuK7dzXHs7G0KQ/0Yn0HODH/YqQwMvlBc+U=;
 b=HSI5cnguB49m1YWgA00kc/Xe2GaJwukqJ94mSgw20myIz7W99PT8ua71LHcKNV4/Xa
 G9lc9Ie38wpnhAxvf8sbjFCF0OB5gRBV3cy5vsqZGyxJKEmGxFLDtrnLaWbrxYoVLaru
 ptYZOfgOPxa9V0ZcpPElE2/g6dIsQwDPbHEJ6dA5kbEwZVAKoxR1YFNvFLA7eeMgxHrQ
 3jyB7SKvNCPOqG1sXMR4JHlQ8dZdqMXB9WryaVvxtCg7YExDtPQCISQay0afIkzmMkAe
 McGmAu+7mYGBvN5XhUGN30Sp0mDMB3f9LlukuLZX/IlFqg6/k4QMEsKO3BRA/OxOAYZM
 QwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350669; x=1788955469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4A2M/98xuuK7dzXHs7G0KQ/0Yn0HODH/YqQwMvlBc+U=;
 b=DVHhA+yGG3s7bFhUKoQo41nfYdfGQfRCvjPNwsmfMLwOxi5k9ZZSiK0T1CN0oxF6tN
 WfI5pASvgAetsi7q0fdCLRBPoQsCQXtmJt1gUUR88Xk2oHiSCDATr+f869W71Qoyq9qQ
 FMT/32DoeUZ71/PSrB/rH/RsiauNAnipXmVtMMPR1vDCfVbCwjd9tiS/uaghgXwaSu2Z
 u6x/l04nbuCPSk21p17aWpskTYtfALornvWariFaB0WmmFOWCfI2oWpPujsf7USf+C7V
 wTEWfRi0jNhVtCnUk2LXmGBQVZr+VjAoTUIiaRaoYPuc1bJqsyy+Yi/Hj8Q0VQD9jXQW
 JLzg==
X-Gm-Message-State: AFuF++ka70DXBdh/us6wgy1BzeqM34ZHvsL9+Om7RSKW4KT7uVGR+iXD
 YW091YnuQHcnZRy7TUxmQn4KlrWQOWaXdF9RD1S2T1hjWia5hqNLY5yyQSVEZ69v6CE=
X-Gm-Gg: AR+sD10WSu03tNf2/n2EvHftsBKs2bjEd6F4XmoQycll0B7OaPJpZXoMQYFbtOIb7e2
 ufhxFcD1OTFpKM7eAYZbLi/zXRW/fGMJJFDE9wwzXLhWQ72KGgLF387wEkCGRhVZFbb41HAA4ww
 fX7KNYcvG3m8bVMToLYDf96vZMxx2nUYEb7w0n13IO2HV61Opl9EkbjH6Oqc1LlQA18SuAFPrXl
 RQi5RRnF7KoXxFgnTBbsF2dTl1nw0UYY5k05yJpo1mwjiH1nB4AMBvtNJL4q6gAzseInUuZhpnV
 eB5LOCpXMZrQ/8yJbnFYkwWfZXW1Y4QdkSl7kVJqqtESDapjEnStyVQl4PWbtkfLpXWqoIC2wPa
 YxF0p/J9EZhwxcBRfvMiFnWQFV3Z92x3AQe3GVRsI7w5wi3n5Chxj5ggbDvpcwP/h7jZdOhKq2o
 UDVAzu7zCXOAEwAur458WfpVX+mQyBvmgSGYsKulZMZGQ5EtxgpQQsO0iv31+lOEPTeEM90N6t4
 /qU6XSidGWYlbIG7XVPJKWarJH9S/fFoj3P083osKonvmG/H1aeyOFAd2ZtkpSfvpheUjnpSx9+
 BLv8Z8/5PboPv9Km8iF4OyfkBHVCdL0=
X-Received: by 2002:a05:600c:310e:b0:49c:e3ad:41d3 with SMTP id
 5b1f17b1804b1-49ce55906cfmr58088705e9.0.1788350669094; 
 Wed, 02 Sep 2026 05:04:29 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdc37sm6504420f8f.34.2026.09.02.05.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:04:28 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH 2/2] target/i386: Update FPU tag word for FXCH
Date: Wed,  2 Sep 2026 14:04:19 +0200
Message-ID: <20260902120419.212855-3-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902120419.212855-1-scherer.simon89@gmail.com>
References: <20260902120419.212855-1-scherer.simon89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

FXCH ST(i) exchanges the contents of ST(0) and ST(i). Both registers
receive a new value, so both should end up marked valid in the FPU tag
word, regardless of what they were tagged before the swap.

helper_fxchg_ST0_STN() swaps the two values but never touches either
register's tag. So if either register happened to be tagged empty
beforehand, it is still wrongly tagged empty afterwards.

Mark both ST0 and ST(st_index) valid after the swap.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 6ccc3c3b4e..9df9f2f375 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -520,6 +520,8 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
     tmp = ST(st_index);
     ST(st_index) = ST0;
     ST0 = tmp;
+    env->fptags[env->fpstt] = 0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
 }
 
 /* FPU operations */
-- 
2.53.0


