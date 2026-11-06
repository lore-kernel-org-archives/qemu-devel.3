Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C3606D802
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nK5JYvw1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPH2e-0004xx-Uf; Fri, 06 Nov 2026 05:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPH2c-0004xZ-Gg
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 05:19:26 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPH2X-0002bL-CW
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 05:19:26 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b315dd057bso2360577b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 02:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793960359; cv=none;
 d=google.com; s=arc-20260327;
 b=AzgwHi7k2zGrid/lNsfJOOuZGnNanG+cQ/dh6m8WmJGBn+SNfJBFMkMgCLzedJVt0X
 ButS8rkZ6pgzrLqzsq1w8Lgdk9Mlk1pWUs6+MekEEzvnS4Pbo/9idTJVS0PqR9EDZpDn
 zo/kqOuhImIuM43Usre+ha5rxZ1igZPWYTyeFTsupzY8ge6dVmzCTt0X97DmIxUCrHty
 3Ic7iFnw1SOqFwuKa7CUTquc80uLqvtgVJeMacHNt4aTRtViN5asfUo23OL+KEEgVm6E
 RZHIMCxQqhmxHTAhhWR4X35qrrr/bV4yIvnzXm1IsXl5wzmxGUb53Bypip7o9wnsxxsZ
 ngdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nlu2dWdwzrxdba2QJHZKr8Paeql3bqrS8ARrcb0p8vA=;
 fh=VRcZPmT6Amq8CJg6YQ9jtV39fafV0LyayVlqP5p8az0=;
 b=BmRDGkSQn8nggg38alaNbKIUVPZo0PtHx/fiPZKn7mJ4GoKmNQCW79sUnYWaPh8AJu
 vQlAOG/clpR54iwJacG1He2h/AUkyRmR+guYBrI4+9OB3/QI0fYnVnPXOqNm12gzygTH
 m7NcysipZhjdZ9I9oPvADYE3tADhOlifujpHmEN/+d7SweD6ape1ZkGOMw/Ng1CCXyEb
 /6lnhAc3K4EupOwDiEXp8VOe/WVVnKPhpFoI57Tnk2OKAYKKo2DifZrRmyPMCR3gnX+9
 84goOG15JAoY7ez5NCqoY0uzRSvBMf49ozzmXex3EpsEf0PWBQhpngQIm2BWWaqbVkoI
 dyWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793960359; x=1794565159; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nlu2dWdwzrxdba2QJHZKr8Paeql3bqrS8ARrcb0p8vA=;
 b=nK5JYvw1FMlfPydWKiNiod3Fp+pHa9EU/Z7DV2WOIMl+3KroUOfrp4nZ19f+OTIDZe
 iweIX41Ej+GvbftQNrcxoiyecBW0GMTysVx2Nu/qPJhb4EOYo4nhBD81PYiWGDhR67cy
 i3ZONdpPVvP9nj7Jg1WA59GamKp94SAD9gg7UpYfuyXFP197a5nMeRUTWEup3pAzupY3
 Z8LVexPoE//87SLCLaB/wbUakkQtjroQLA8d2Wyr5Wp1TfpWFNTQ9K8fbVw7IrwvL0LR
 J+Pzi3hsZj9BqjyZaUZKyjVOqqlEbRAZTNtz4vyzlGnfPCWRVTL3TZ/iTjJ2Z/9bnTfq
 C6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793960359; x=1794565159;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nlu2dWdwzrxdba2QJHZKr8Paeql3bqrS8ARrcb0p8vA=;
 b=YiI0FsPfrS0Fpwi2VSgTP2M4e5/6pVmzJ01dI+VVKTNf3MXGnaIQssVkRqyJ6c1Q7p
 jHIbT/YSVamebUMCXVqspPWEow0GcllsEDLNo+Jke0a6JKUmkUU4gpRdqjFv2una75oa
 cTSSuAIIFx4T2YnbO1zWrS765LcgvNY2jREkNLypF8h2LeUZk8V9ykGz/GAqE63Vzm6j
 NgXWDuGJmGCdwkG0BvjvS7zLbenT4B4ZFsc4nbFMuu1+uAz3S+EVvF3tCbV0MNtKsYDm
 rgzIxQXaXtM/QPGW7p1I+lsi6fu0/yktbu0MO56L+CmPwbZMtZZ8VRIvTZu/1AnpLKF9
 IfAA==
X-Gm-Message-State: APuU4Z+Jq2EYa8nQCR3GrmgMctCTNKhJtzA+OD8BNsBJgELJucDqz4+k
 eV7y0B0KR1ufHV9t36jninHf+mucObAZWxgDvmYOEHMk26PzUtRTFbuGwpLl8Kc+sl3VujC+llA
 mOGtQoPWtxIgyVG0nN8K6kv+aAZwmZ3eaiDtK6TKTRA==
X-Gm-Gg: AYBFou1wFsb8G+UZqfV7cOyPi+6alPbCJlid2jNRDZ5BxNrOXB7wCnB5upnS2pC7EpW
 7PfZgx9xx63SIVDbF2IoAu9SSKbTJt5DPZUzck5WdDko+Kf/5jHl0AqmEATWT/R/Wxa7lqmgR9t
 zJFD0M0sJ2rKFJPfIQN1db9aqzbeuh8kBbgPXbP1LLtdfDpnwXf6jRoe8YG7VXKLl7p31qvkmny
 rcoukAMV8ahC2hwPcPYZFMQr5JuBKox9yFEQnl8D7aTcoYWCofqQjLAGg+ZQmlIt6CBbGAyxib3
 RUwImvMj5/5HByR84qpuHh/VmXTClRj2O2qTS/QvzZGODzDPavMi9iUpYLZBTbDvTvDQMoP0Lnf
 rTZZgyv5lTciTMvAQm/x7rdRdM9wrChZtEgrlXyW35hSt2QN+8Ul9zQAWHX5bXK4CwhgbGfg3dw
 YEH3M9jRT+pP4SC+ouOuyn
X-Received: by 2002:a05:690c:f90:b0:8b3:25ea:62b9 with SMTP id
 00721157ae682-8b341b38e4amr13104007b3.61.1793960359238; Fri, 06 Nov 2026
 02:19:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-armv6-xn-check-v1-1-fbeff926e692@linaro.org>
 <CAFEAcA_qmyR0E3+n8GByA6=kDwDQomCpk399DEc8pOPr=sqEaQ@mail.gmail.com>
 <to2jr0.1wqw0hsi7q7wn@linaro.org>
In-Reply-To: <to2jr0.1wqw0hsi7q7wn@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 10:19:07 +0000
X-Gm-Features: AclHuK__yclTGdRd-7fCZS5tj0iTK2TB7fmT1yydcFu4KaSm7q2djVA5cFLHdFc
Message-ID: <CAFEAcA93X=dQJx786hfENjXcwXVieRxEsv+eMA5_P1N62rQ78g@mail.gmail.com>
Subject: Re: [PATCH] target/arm/ptw: check XN for ARMv6 in get_S1prot()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 07:06, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, 05 Nov 2026 20:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> >On Thu, 5 Nov 2026 at 09:44, Manos Pitsidianakis
> ><manos.pitsidianakis@linaro.org> wrote:
> >>
> >> For the ARM_FEATURE_V6 case, it seems like we retrieve AP and XN bits in
> >> get_phys_addr_v6() but we don't check the XN bit in get_S1prot().
> >>
> >> Change the `if (arm_feature(env, ARM_FEATURE_V7))` check in get_S1prot()
> >> to `if (arm_feature(env, ARM_FEATURE_V6))` since v7 implies v6.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
> >> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> >I think this is worth backporting, so:
> >
> >Cc: qemu-stable@nongnu.org
> >Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")
> >
> >> ---
> >>  target/arm/ptw.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> >> index 2e67d02493bd463cfd2d31ecf1316272ac3f1d99..b8b22b014e0574340a85abe73f3d9611d2360219 100644
> >> --- a/target/arm/ptw.c
> >> +++ b/target/arm/ptw.c
> >> @@ -1595,7 +1595,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
> >>          if (regime_has_2_ranges(mmu_idx) && !is_user) {
> >>              xn = pxn || (user_rw & PAGE_WRITE);
> >>          }
> >> -    } else if (arm_feature(env, ARM_FEATURE_V7)) {
> >> +    } else if (arm_feature(env, ARM_FEATURE_V6)) {
> >>          switch (regime_el(mmu_idx)) {
> >>          case 1:
> >>          case 3:
> >
> >Digging into the various versions of the Arm ARM and looking
> >at QEMU's code, I think that "allow this for v6" is correct,
> >but  I think that ARM_FEATURE_V6 will always be true here
> >so we don't need to explicitly check it. The two callers of
> >get_S1prot() are get_phys_addr_v6() and get_phys_addr_lpae().
> >If the CPU isn't v6 then it doesn't get those page table formats.
> >(get_phys_addr_v5() is simpler and just figures out its prot
> >bits directly rather than calling this.)
> >
> >So I think we can make this a plain "else", and delete the
> >existing "else" clause that sets xn and wxn to 0.
> >
> >(Strictly speaking it is possible to get here without V6, because
> >we don't enforce that a guest on a v5 CPU can't write to the
> >SCTLR.XP bit which should be RAZ there, and we don't ignore it in
> >get_phys_addr_nogpc(). But if the guest does do that then they're
> >in UNPREDICTABLE territory and whether we give them v6 VMSA with
> >XP or v6 VMSA without XP doesn't matter.)
>
> It sounds like this is equivalent to this patch. Do you want me to send
> a v2?

Yes, please, have v2 use a simple "else {...}".

-- PMM

