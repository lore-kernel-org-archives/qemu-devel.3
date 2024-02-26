Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215B2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reZDm-0000Iq-K3; Mon, 26 Feb 2024 06:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reZDl-0000IM-7D
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:32:33 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reZDj-0003nw-OI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:32:32 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso3868095a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708947149; x=1709551949; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0nMnDapFvvatrHhVmCWyHBrI/DiblXmep0imBoSKP0=;
 b=FGvAC2XwnRO/nPcxPv8XyWqPTJvkTBdrCIKFPmhPL0Bk1qHekd1L8KPZaDcSaINyu9
 OOFGKZc4x+sE2112MMqkKiruYwscF4N3bEAOV1dJfbJoILolgOELLuesDtRCVvNrqC/b
 fumkhDTqT1sgWnJTrs1WcxHo2NJ3SOZmTJH9XZ/cY9njpNLu5/GZkqLPfhbdDoxQqNZX
 wKc2x6dW0bOXnKRiBU2aVXiCoBvDW6k3oT2TnP1Sq8DwSUvPjqGwrhQ1ScmwQRzFzaQy
 usJ0HlVmTpATAUVEi5MRwAB1aOodTmTDrK9KMmU8tOoqVAoQpVWi3CMrdLvWcL5yvMvI
 Wv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708947149; x=1709551949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0nMnDapFvvatrHhVmCWyHBrI/DiblXmep0imBoSKP0=;
 b=Qykh5yHonGScDkTdbtYWujHyJiyQsdmg9xtPkYYH1Pj4gFoWG++yAPiSJ+/UBB96ws
 SjrZas5KuJVO0Oc4mdR4icOOvxA4JyuRhzmDhzbe1eLiGVNFJG6r03DXUS0ZDyvewnHJ
 V6cDnhOk8XIx9FYZ8OUEgIOOc7E6zlN+epezckEyNtkWJbx/67qeZKa7WlupScfo9TcJ
 a1RGHSTV1zjnNbvFWOKtkkc7OmcQVx/2JnsKliCQxCF/CXb5OJA02LcPK6Ir1cu/0FUH
 9pKI+0GjkXxFZ06IdTyquJnotM+DAdMaku+2DjNH3FnVr3kR3bdFqS1IS3wqCQe3ELLA
 BFTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHoSnL1q3pJyKcaGg4tLZngPsSapmr8G5xB5k3YoyLg84YiwvxO9g+2g7hE24/f0IXKCg7XsG1e6uh4gMH9TckJDUHrUs=
X-Gm-Message-State: AOJu0YzBzKfKE53GCtBa73tbAkB/2saBFDFYTe+l6t47xlu4cUU7O5WJ
 +jE2E4UIWdiP8l7A41BymJWXmq/cwvsb00UPQTxaVtkQdyq2p+Fm37XzlQakSDDC1cxyQ+GY1p7
 djICvaNRszH3Fj0LFkbKW6y9koYQ041vj/S6NIw==
X-Google-Smtp-Source: AGHT+IGkLN6tkrnXQn6rx+kTALydVQ6UCBkniksr0sVPTfAuoHzlxtFIaiG3Jzrzf6dWyajnYsbV7DJMaL8sjHeILqY=
X-Received: by 2002:aa7:d958:0:b0:564:f6d5:f291 with SMTP id
 l24-20020aa7d958000000b00564f6d5f291mr4745407eds.34.1708947148878; Mon, 26
 Feb 2024 03:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-18-ruanjinjie@huawei.com>
 <81167528-32e3-4741-84e4-3c70b788fc2c@linaro.org>
In-Reply-To: <81167528-32e3-4741-84e4-3c70b788fc2c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 11:32:17 +0000
Message-ID: <CAFEAcA9vxm0V3XNo_VVw3bVH1ucW1gWZY=rpvaOk3iv0fqOuVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 17/21] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 23 Feb 2024 at 20:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/23/24 00:32, Jinjie Ruan via wrote:
> > Add the NMIAR CPU interface registers which deal with acknowledging NMI.
> >
> > When introduce NMI interrupt, there are some updates to the semantics for the
> > register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
> > should return 1022 if the intid has super priority. And for ICC_NMIAR1_EL1
> > register, it should return 1023 if the intid do not have super priority.
> > Howerever, these are not necessary for ICC_HPPIR1_EL1 register.
> >
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

> > +static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    GICv3CPUState *cs = icc_cs_from_env(env);
> > +    uint64_t intid;
> > +
> > +    if (icv_access(env, HCR_IMO)) {
> > +        return icv_iar_read(env, ri);
> > +    }
> > +
> > +    if (!icc_hppi_can_preempt(cs)) {
> > +        intid = INTID_SPURIOUS;
> > +    } else {
> > +        intid = icc_hppir1_value(cs, env, true, false);
>
> Here... believe that the result *should* only consider superpriority.  I guess SPURIOUS is
> the correct result when there is no pending interrupt with superpriority?  It's really
> unclear to me from the register description.

Should be 1023: the ICC_NMIAR1_EL1[] pseudocode in the GIC
architecture spec (13.1.8) does this:

    if !IsNMI(intID) then
        return ZeroExtend(INTID_SPURIOUS);

(Note that the logic is "find the highest priority
pending interrupt, and then see if it is an NMI or not",
not "find the highest priority pending NMI".)

-- PMM

