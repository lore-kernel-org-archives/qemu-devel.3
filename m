Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869C9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAia-0001b6-M0; Fri, 10 Jul 2026 08:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wiAiB-0001aO-Oa
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:52:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wiAi9-0004e7-KS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:52:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1166980f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783687926; x=1784292726; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7T185QuUf9dnbSb7cqeb9k97Cfq4BHic/plE9ShSkeE=;
 b=nEPVZdhwYc+j3I4zSeI25jDcwIMp2IKIrOLfkLJw49611rk3oiPhOjpQ9mWp8fwKoE
 Ca+3lIMDhkJlY1MF3GoU3gf5KqZtTsElE2lHwOFWI9t0FNNBWBkWBKejx1Mtwc/zrbIw
 zVzcTLMOUkyfAYCBYhuT5viO5nOHH1tKumgFtrFzMlPbjI1qai/fWYmHpfTeJWdSmw1a
 HXkp+dPMajJxyLwgKSFRNNVC1grbx7DbLdbCI5bDFidW7XUI7VTSrCsENQLqiDcYwa/z
 6p09QF23GjzN4Vf1RTDhkkOa3knu+djcPBtALZqKOpiQv4F60MPVEZdQhgkw2dawnDO7
 l8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783687926; x=1784292726;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7T185QuUf9dnbSb7cqeb9k97Cfq4BHic/plE9ShSkeE=;
 b=HZA0RG2LS4Iy8/qLoyc0lhRfYY/2gVDWEiUPqevmGRP7Lf9AeInLpFf/6N9OdyCA7F
 i7MulBJ9pgpXFDyn2y0r5w+FQC7PrrvVXPaoexGoQihDvvKSyxuuZTQJfIc4BOsen+G6
 hcaU9iUltY4eYvQhSKbi/3rzobMNIDtAs9EImRB1GMOHF2gvzRrmXJ98UghVjTAcYvAi
 x8a6sWNNt9UEWLR+4+OIjYgeiCHQG0RnI5MyqFioP1NR+1ZjUmNSTSeobgCxI01PhEIS
 gc+ti0iyjJCa5kB4Jvd9kXY3kowPrERy8QKoq0a5KzCdWikX0NO/EiRvT81Yw0mCSTND
 USqA==
X-Gm-Message-State: AOJu0Ywzbp3SmCUtj3kw/Y0tKZsKRSdBOkLLCV5cdYBI3epVxNSzi+U0
 CpuILpjGBgoMchb1qofVI6vHhnXdzvgPK75njdIAWdxoQN2hQbqan7hbqMJhK+Q3736AB1ZuGaH
 7GCGUfkM=
X-Gm-Gg: AfdE7cnuYBicAuvklHf9KnIkQ/veL91lv1ExZOenhnLYCaar5kcoLCZkqxMRbQ05+Xs
 RZa/lAEqXj1lm5ylFIQZy15AFmXqnx6sLcB1vK18H2GQUcyfTM3JlgK/C/Ob570MqKMJucZkoZu
 pyjx0/vmoJ3L0Cp7LiA2d1oTeBwafJTP5ESqRC6lmQCxIKmrrpikxL1oHBO2htVPdV/3NFNACUW
 tQ+j0+LOFq455zTYTqw82vPmmzxwiPoEElPQmhcoKu09uTYk/BWHe1KhflUMX8vCFSMQ3YTo1KN
 ncAMrhEXf7mFkrPmoDF1CsVH1GVv9xACC7eS7W+Gs8bpfHQJHY0pJ+1yBkJgYS3Piqnv5e95bdm
 hGA2iXntgwLJhbHNc/iNh4Y/4cX47AwHxCn96+Q/isvkCR++vGkcoBWtAwnOzNkIgR0+ZfzfbLf
 QkMsu5C3+CgbWkGogjeGPSo4SLb3rZoWyfITjVSpr3vD2iOjfHtQ==
X-Received: by 2002:a5d:5f45:0:b0:475:f100:35f7 with SMTP id
 ffacd0b85a97d-47df0772506mr13520086f8f.52.1783687925704; 
 Fri, 10 Jul 2026 05:52:05 -0700 (PDT)
Received: from linaro.org (82-132-237-191.dab.02.net. [82.132.237.191])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm62425706f8f.21.2026.07.10.05.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:52:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:52:02 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 4/6] target/arm/cpu-features.h: x-rme now means GPC3
Message-ID: <alDq8uq0QsaH2LLN@linaro.org>
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
 <20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org>
 <CAFEAcA_M0Z770FApDyhNcYaP89JP3Q8MDj5bMjYKSpmONYrr7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_M0Z770FApDyhNcYaP89JP3Q8MDj5bMjYKSpmONYrr7A@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42f.google.com
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

On Mon, Jun 29, 2026 at 01:00:05PM +0100, Peter Maydell wrote:
> On Thu, 18 Jun 2026 at 17:33, Jim MacArthur <jim.macarthur@linaro.org> wrote:
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > ---
> >  target/arm/tcg/cpu64.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > index f7a920a202..75c2027900 100644
> > --- a/target/arm/tcg/cpu64.c
> > +++ b/target/arm/tcg/cpu64.c
> > @@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
> >  {
> >      ARMCPU *cpu = ARM_CPU(obj);
> >
> > -    /* Enable FEAT_RME_GPC2 */
> > -    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
> > +    /* Enable FEAT_RME_GPC3 */
> > +    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
> >  }
> 
> Just noticed this, but does this mean we should now list
> FEAT_RME_GPC3 in docs/system/arm/emulation.rst ?
> (If so, we can fix that as a followup patch.)
> 

Looking at this again, we don't currently implement the APAS instruction which is a necessary part of FEAT_RME_GPC3, so probably shouldn't advertise that in the documentation yet.
I'm unsure how to handle this instruction at the moment; it might be that we can simply decode it and ignore it, in which case I can easily make up another patch to complete FEAT_RME_GPC3, but if not I'll need to seek further advice.

Jim


