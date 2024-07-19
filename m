Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344ADC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpzD-0006pD-As; Fri, 19 Jul 2024 11:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUpzC-0006ll-7D
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:57:34 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUpz9-0003CS-Q3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:57:33 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a10835480bso1162546a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721404650; x=1722009450; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHKYSk2rntYjXFgiuT67fk3WNMoT57UruY+ot61GLIE=;
 b=n1V9/a+YR+FdhpvdOfGllY9JChwkmvQDwcw+dxA3Q0B9RhczUiSHYvadnx7kJcJPOK
 Hp7mIlhU3AzIXnArmP3ii8T98hyTOjAnyp0vN36zYUoxdGirh23TUo8yzSMloXqgqwvC
 1Rqz2f8C2/6IYqwDCtM7VIm87DGS1rfpndUnyN69f+uhnk3nTQFbjw9VxzNKkkDL2Hlc
 1gvA3aN4J59Zyf91mrWJq/cVWCdfg8TnfSm7I/thqm6PoR7vCMGKgANYtvFDelkbhQlM
 s7XDWzHQKTrWOSTc9UYFIHWshwIsZQA/zof8MOlaRR3XYB/bDTeuyhq2j2j6nP59VeYY
 yWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721404650; x=1722009450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHKYSk2rntYjXFgiuT67fk3WNMoT57UruY+ot61GLIE=;
 b=QQMrCQgCBRJ3SYXDt6oddNcRV2UoO7nOp+K4YJb1YLCd5lfa1Zi0TMnAiH28Y7O8EU
 p21LNrxJ8yMDggdkHkw+r5oZEyYu3GvqaztknHHg+f0ND7VFx8rJjhgMpaPZnz1pr+Ty
 Jl4Q71IFwxoZO98pplWzerzWiLZ9arBshXtD/qGchqu3FYcpH6wTJMcztzsw06HgfwpW
 uAnQ63ZuN1rB51lH2CDU5cDcK+SEWolC9Cis1GEn0+gFjhhakOxazsrx2unOA6OjJNRy
 MmmzR2f8/fxGeLieeuT5tzPne6+m0X+fZVEUobrnTMuZrVt5Rn+XIHzBL4l4P0OgG6eh
 5lAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8S+TppcF0jOADyGEFLajOKvF/V4dAKImnMK7a+I1CQcx/XF5oDYke0Jh6YUhs793ftKa/vaA5r9FvI9OJBuGX7l3aEes=
X-Gm-Message-State: AOJu0YyIGEwvty1px5e7jczJnz32rwSX8gmJ7YsbXthbl7dNlvXn0Urv
 MoUe6S5x7jDPE+RvKt7YjpdiOtfu/sae5s7A3cYgi7tu4ULXvlDEzRw4linFEdU/z2tZdmvrUBp
 Doz5ZiIkJUnR9qWk5WtXWZiLC753aTJJDQcevUw==
X-Google-Smtp-Source: AGHT+IGteFRfnddU5H8E9FQixzUwemfNrueJflRVOGZ4o2OtmI+AUY0qpTKBPEwBryjfnAnCiiqtQbgnUL6w3tLcd3E=
X-Received: by 2002:a05:6402:524b:b0:5a2:838a:15fa with SMTP id
 4fb4d7f45d1cf-5a2838a16d6mr2596281a12.15.1721404649620; Fri, 19 Jul 2024
 08:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240717150931.GA3988597@myrica>
 <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
 <5684927d-d890-42be-841c-ece681502503@xen.org>
 <a0ee8ba3-174f-4d00-807f-31584cba42d4@xen.org>
In-Reply-To: <a0ee8ba3-174f-4d00-807f-31584cba42d4@xen.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2024 16:57:18 +0100
Message-ID: <CAFEAcA8T3Yrj_R-B2oUW_Uu3u5HZs4RY1P+A7zF+8xWJnmtpQA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
To: Julien Grall <julien@xen.org>
Cc: eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, 
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 19 Jul 2024 at 16:36, Julien Grall <julien@xen.org> wrote:
>
> Hi,
>
> On 18/07/2024 10:43, Julien Grall wrote:
> > Hi Eric,
> >
> > On 17/07/2024 18:43, Eric Auger wrote:
> >> Hi Peter, Richard,
> >>
> >> On 7/17/24 17:09, Jean-Philippe Brucker wrote:
> >>> On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
> >>>> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> >>>> but not nested instances.
> >>>> This patch series adds support for nested translation in SMMUv3,
> >>>> this is controlled by property =E2=80=9Carm-smmuv3.stage=3Dnested=E2=
=80=9D, and
> >>>> advertised to guests as (IDR0.S1P =3D=3D 1 && IDR0.S2P =3D=3D 2)
> >>> For the whole series (3-9, 11, 12, 15, 16, 18):
> >>>
> >>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>
> >>> (and I think patch 16 is missing Eric's R-b)
> >>
> >> Jean-Philippe and I have followed up the progress of this series,
> >> Mostafa took into account all our comments and all the patches were
> >> reviewed. It seems to be in a pretty decent state so if you don't have
> >> any objection, please consider pulling it for 9.1.
> >>
> >> On my end I did some testing in non nesting mode with virtio-net/vhost
> >> and I have not noticed any regression.
> >> Would be nice if someone could send his T-b for the nested part though
> >> (Julien?).
> >
> > I haven't yet tried the latest version. I will do that in the next
> > couple of days.
> I see this is already merged. If this still matters:
>
> Tested-by: Julien Grall <jgrall@amazon.com>

We can't retrospectively add the tag, but the testing itself
is still important -- thanks for doing it.

Q: is there any reason not to:
 (a) change the default to "nested" rather than "1"
 (b) make the virt board (for new virt machine versions) use
     "nested"?

AIUI "nested" should be a superset of "stage-1 only", the guest
can just ignore stage-2 if it doesn't care about it. Or is
there a performance hit from having stage-2 around even if the
guest doesn't enable it?

thanks
-- PMM

