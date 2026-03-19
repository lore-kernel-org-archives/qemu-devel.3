Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08086108E1FD
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CFo-0000I5-Ta; Thu, 19 Mar 2026 08:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w3CFm-0000Hh-GF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:13:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1w3CFj-000653-7i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:13:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso3043865e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773922402; x=1774527202; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4lIRVs2anaFfNV5x5FomJeDL/767SmLRDSOPyojh0+E=;
 b=pSHMh/n+IrVoNyyGPss/9xowRyr1Cc0SaFj6i2eD1gj1ZjQGh8+fC78GAB1TPgevkF
 AtWvDQBFBChHmUgNZt6V3eaDK8IIXd2xxvyNYdmDXJSftoOEucZEKS0LeSe47EPXr+UP
 9QZWBdTdr7yBN6HE63AV/i1nNI/iBFPMXilZ6pZ1dHuzkkayLMwbCZTAzRYHda/0qhfO
 J+K7yS1xQxj6RbmwR/qAG9B/axBAOgabqq8ZqNoFckgJEL8Hm8aKibSSgjxObkuqtMg7
 bZ8+RMSwwEJwsEpVZ5cRlhG64FjZ+lpweI4Da40fad0jOxkfN6thqM00X0Snavh4Ywnh
 h2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922402; x=1774527202;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lIRVs2anaFfNV5x5FomJeDL/767SmLRDSOPyojh0+E=;
 b=fyOOk5t7dl0Y/Sh5YXr0JdnuEh0z3TrF7jk6uU2sUXkHjbolwpm6aozzwjx50EF3eP
 8qfeaOeY9zgMAKIJt0gAzNIJTqXNmuPtIxGZKpWLe5+reJCUrxhgCvA1MuaX2gL59BKi
 LQuoIEM+xW/7svP5ymcQJGwhcCTCkgLStrKiz7GpBM9dcMScOpJLG9zQUgTY0jdF3FMu
 WyNZN7yLAZlOYY4Y3TDG3tAM8xiTomWiRJzdr+NcI8Y4n2/QD3wGWpUZAJhXG3PznJ9+
 +A98v0yDO8zJY2HvQCg3vSy2v5dW6rOBmHCojuH4g0LyR7zhqCyNjQuK++Kb47d290Kw
 5BzA==
X-Gm-Message-State: AOJu0Yyx12XGXfrVaoPEHfKox8mHpc3QYTceAQuFCALR8c3nN7O2OEqk
 TpFLYJT3rL6V1RjIZKUNIOS/SOnpiDfG4bsQSp6YkyARnt1gtxAEqJNTaaDpyVGpJ1g=
X-Gm-Gg: ATEYQzzYYZbZ5FvVzakQFjCEsk6I6Le0Z3rDq5y4lQP9sjEa1r4ZQzr6vmxslTh+EPP
 RUGgtVs5IY0Xthd/GXrZWfVNmk3CSpg9ZQuMoVti1JRZiqsXzh36bUKqjh1o5IPkGCAlslsGHc7
 6gvDXCMGkgIpHzZTI+97rxVEih6DLimHhFjHQtSFY8+krAaoFtpLfiaSEqvwEtVc3URMT40yX2v
 QRNN6n3/my6M3eRNNBENSxk7nqwrogwNb+giDpNbQym+WFbOeFzJKxlC+xNcH2cWLXsZxJTIKIP
 L6sAgJK+JoHk2rNmqIQEemtT2WFOHn4LJG3AICutBhrKlbuimXQ+1qazM61Os8S/LeSZwqtVTwy
 GLmYfCpHxsJERf7GLb5M+2NgyOGJjIRkfARKl5BE5WbJC0GoDosQG2xyWqWeSkYyUyCKTZbXoHK
 Dhf8kEtHsctovhb6YzFtTardhhh8U=
X-Received: by 2002:a05:600c:3b14:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-486f445e260mr111034075e9.24.1773922402129; 
 Thu, 19 Mar 2026 05:13:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5dd6:71c1:29c2:4a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fd9575ffsm2456215e9.7.2026.03.19.05.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:13:21 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH RFC 0/2] Replace aarch64 TCG instruction formats with more
 meaningful names
Date: Thu, 19 Mar 2026 12:12:40 +0000
Message-Id: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjou2kC/x2NMQ6DMAwAv4I8YwloQkVXJB7QFXVwgwEPBOQEh
 IT4e6OON9zdBYFVOMAru0D5kCCrT1DmGbiZ/MQoQ2KoiqouHmWDROrm2mB0E4oPUXcXk4Pjqgt
 FVPa0MDZknmZga77WQmptyqOc/08P766Fz33/AAqWYMF8AAAA
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

tcg/aarch64/tcg-target.c.inc contains a lot of numbered instruction formats
called "I3XXX" in the enum AArch64Insn, named for the original section in the
Arm documentation which described those formats.

This patch aims to give them more meaningful names, for example, I3314 becomes
Ildstpair. Where possible, these names match those used in
target/arm/tcg/a64.decode.

For convenience, here is a list of the replacements.

* Automatic changes, made by passing the values in the enum to a modified
  version of the code produced by scripts/decodetree.py:
3206 => branch
3305 => ldlit
3306 => stxp
3312 => ldst_imm
3314 => ldstpair
3401 => addsub_imm
3402 => bitfield_32
3404 => logic_imm_32
3405 => movw_32
3406 => pcrel
3501 => addsub_ext
3502 => addsub_shift
3503 => rrr_sf
3507 => rr_sf
3508 => rrr
3509 => rrrr
3510 => logic_shift
3611 => rrr_e

* Manual changes, still matching names given in a64.decode but found in that
  file manually:
3201 => cbz
3205 => tbz
3207 => bcond_reg
3303 => simd_load_replicate
3403 => extract
3616 => qrrr_e
3617 => qrr_e

* Names invented by me, where a64.decode does not have a meaningful name:
3202 => bcond_imm
3506 => csel
3605 => simd_copy
3606 => simd_imm
3609 => q_shift
3612 => simd_rr
3614 => simd_shift_imm
3502S => addsub_realshift

This is marked RFC partly because there is also a possibility to extract names
from the machine-readable instruction descriptions given by Arm. These would
likely give different names to the ones in a64.decode, which means there is a
good argument for changing the names in a64.decode as well. This requires more
investigation. If we do decide to use Arm's provided instruction format names,
it would likely only change the names used and not the structure of this
change.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Jim MacArthur (2):
      tcg/aarch64/tcg-target.c.inc: Replacement of I3XXX names
      tcg/aarch64/tcg-target.c.inc: Manual replace of I3310, I3313

 tcg/aarch64/tcg-target.c.inc | 994 ++++++++++++++++++++++---------------------
 1 file changed, 510 insertions(+), 484 deletions(-)
---
base-commit: 5a68a3add61208aad34d47134fdcfd3f407d2ce4
change-id: 20260319-aarch64-tcg-instruction-format-rename-9a474de54b55

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


