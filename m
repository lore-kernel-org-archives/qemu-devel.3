Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C238EC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4il-0003qA-2I; Wed, 31 Jul 2024 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ4ii-0003gx-MP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:30:04 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ4if-000105-Fb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:30:04 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so8272876a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722414600; x=1723019400; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0YOTAMMf4iPZMx01Vfm9GIEOnEcMxS+mWoBS6sntgd0=;
 b=VAo305HqSonS2cY/sgCWvkVMTbpkZeh5iPHDq8SdjiL2BXJ+T2swRpLAQrrY8Nevh1
 k+hQWaFgRQkXSnycnbT7XUwGR9noXWNBZ6AhX8coIi+S3lvnSByCv1HR8Ro2uKFp8Hip
 zHvqvZ7haIcuHXem7wRlQ8RRkqOs6ljl1ozM9JFzTddi0EKq1/MCy+r8glC6+zLhUDAz
 s6cfaFHwL8cVi6ECTrJZm1Q12AEqDjMxZpvlBu+In8/yIC8Gry1gmxstW5Qr4AB3ecsH
 D4B/F9k7+PQBMcKrDgVoEkX26zn2FgjSfv1LeJzLyWlMGzivK1FRsyKJm9YoGLqiUflk
 q7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722414600; x=1723019400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YOTAMMf4iPZMx01Vfm9GIEOnEcMxS+mWoBS6sntgd0=;
 b=mBz1bbDdXFkCFaQg4kng3KhDYd4lYjAo9cR4n1lYZhh/6fHDniOHmiDdjlup1GhnRC
 R+gEzzYEsHaegzBs9F/sq1axVw3h6yJXor/d3pPE+yPbTkwMoWwAqNyjI5KtpfC8AQsh
 SRWqXp4FHp+UjAyr5R+Tvq2RdlHc8zEpG4hdRiTrSYWjsFVDLGcO1hfxhPjwglD3JPNw
 7fxE5mJxDJjh7WqD9dRom+7peobweuojD6hzurvemsWo8Q0PzCH2POth4edI12VLI6MW
 JnFmtKvOhs/LpxW/6GHj36erFee4vO2+TPrdsyJ0zjZxM1brpK0MHDBV4qjyz4Y8rO1Z
 tIlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyo5A53dkgrX95IDyY5mmnyF6pUFsXO4d/cmYsCCf1PonJH9ZJV9TAnFOEbcl47Z/PL2c+cemXW5mU9Fk3bTd6i+g212w=
X-Gm-Message-State: AOJu0YxZ6IUjWavT2eUw77dYEahZiDrqj4edJubmgM1qTApAHEI6ER5h
 fOj7r8wAdPuCqTGnOyXPyjHISs1AIkIACSYXhWQUivjmRcLE+yAfsBkeyDIzhRADm8sRrc0e/3u
 neLDaIhuqklSPtbUWXCK18MNiM9b62nvagRaOuA==
X-Google-Smtp-Source: AGHT+IE/JbTN7mef1C8ukMIfVrKp04lDJI3RqkUimLPjbr1sZ16BQS6P1SCwpLFBI3jtHpIHmtzzHqOMN4Q7ByuTBJY=
X-Received: by 2002:a50:d55c:0:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-5b020ba8220mr8340344a12.19.1722414599667; Wed, 31 Jul 2024
 01:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240730155819.2958924-1-peter.maydell@linaro.org>
 <7c9662a0-240b-4bf5-9676-5eff403f86ef@linaro.org>
In-Reply-To: <7c9662a0-240b-4bf5-9676-5eff403f86ef@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 09:29:48 +0100
Message-ID: <CAFEAcA_97tRc-=XuqUgVa=CF7y=PmV7pPjRVbRx7C4qVGHaC4A@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Handle denormals correctly for FMOPA
 (widening)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 30 Jul 2024 at 23:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/31/24 01:58, Peter Maydell wrote:
> > -void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
> > -                         void *vpm, void *vst, uint32_t desc)
> > +void HELPER(sme_fmopa_h)(CPUARMState *env,
> > +                         void *vza, void *vzn, void *vzm, void *vpn,
> > +                         void *vpm, uint32_t desc)
>
> I think the env pointer should replace vst in the argument ordering.
> That keeps with the standard gvec signature.

Here I was going with our standard signature for everything
that isn't gvec and putting the env pointer first. I'd have
done that for the gvec helpers in the FEAT_EBF16 series too,
except the gvec machinery doesn't allow it AFAICT (and also
doesn't let you pass it as 'env' and insists on 'ptr' I think).

But I don't feel strongly, so I'll change this.

thanks
-- PMM

