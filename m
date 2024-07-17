Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D8CC3DA62
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 19:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9zQ-0004u0-1d; Wed, 17 Jul 2024 15:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sU9zN-0004mV-EG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 15:06:58 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sU9zJ-0000jM-EB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 15:06:55 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so1007671fa.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721243211; x=1721848011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmTyUPUh2TdjaS2kakIUu+zSdq0kzqZ8AQ2di4fhUkI=;
 b=oJ1oTNL0og8MQv8uYwZhYQBn+WlCKkvCmldwgKnVELDgM3u0l6pXo1AtTjqYoDao74
 ZkWY5Off2xQeuOok9xlBmDUqfrSGJL+q9qgQltqFLaz4XtP6G8j9/P9BSBQ89SrG5drF
 YqCfOozK0t/MS1QCfinn9XqU5JahBnLL2UTqvnR94l5Y5Bu5yPBm14dIBNTQtxuFBgda
 RfRsT3zeJ/eD1dXGRDMd4aAX9B8HWKh/y5IGC5t4XsMxaUtimAAYUmmFvW0rGYWIjMAX
 gepKtgD6w+olYVzcX2iGZCMtJx3A/VUkkAM0GWusoiYrxpTnfBgaOOr0TG6qxx4yptmG
 Q65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721243211; x=1721848011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmTyUPUh2TdjaS2kakIUu+zSdq0kzqZ8AQ2di4fhUkI=;
 b=azxV9gi4SxxtJjWwKaf3B1cOYHEgWsOSlKo9weFrSFQEHYBhSE0jhbxLDzhud16GhU
 mGsNYeJ6xBu2Y2mVXYXitLkz9bgOpAl9pamSPyLnW1gg3aWk4raIAt/OkF6MV36/Qll1
 BUsqhLHsMQ3rrkMztJlJPazVkPlVlXcIBN+2VuDwL79NhYLsHruoZUn/wSol9TZbnWcW
 0xMyclF9NGv68q5zd8TK6ziFGx7LFt3aqUTmQIzGJzCTnSi9u7vYkujakfop2a+VP7c5
 4C5yOC8JJ4/EEWgDZOIfJ1vfBmCE8pldP+OasYC9DLM8Da98ZBVDWQG6AiOnCL7CHKnF
 lyTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA2PVQoYktgHZSVP6JpMN8Xmdxajl3a83GLO3z6gkTyfHkfS88V25zAt71I5W96TrCH0NDnvwuZV43sTggkN7rfEItffg=
X-Gm-Message-State: AOJu0YwBN7vJwn/5rS36fLV2tZ6CBk/19u+7b4mR4fkMyXCZRahxQrB5
 yK6rRAxXHqBQrRurmcPNPb3BVyKv0MMGmuvnH6TIEvsormsN3ZUpmi3uhSe0h4YTnQGqISHJKcL
 qpQq4AUYxeU/Vw/b1bJws4gBK24gLNxoMUVXbYg==
X-Google-Smtp-Source: AGHT+IGXxq60Nbxt/VLpXBWKiQuKAR94McjSn38xqdH99XBIjQBmd2SBUsMaV2HlB23vdXxYiDos22kvDEsmQCNytgw=
X-Received: by 2002:a2e:9e02:0:b0:2ee:6b86:b0aa with SMTP id
 38308e7fff4ca-2ef05c7143emr2087811fa.17.1721243211042; Wed, 17 Jul 2024
 12:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240717150931.GA3988597@myrica>
 <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
In-Reply-To: <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jul 2024 20:06:39 +0100
Message-ID: <CAFEAcA9e+NCFZ+Zhs0C-XxD++=33FV7Tnt8GzZmvUnpzMw2Yxg@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
To: eric.auger@redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Wed, 17 Jul 2024 at 18:44, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Peter, Richard,
>
> On 7/17/24 17:09, Jean-Philippe Brucker wrote:
> > On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
> >> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> >> but not nested instances.
> >> This patch series adds support for nested translation in SMMUv3,
> >> this is controlled by property =E2=80=9Carm-smmuv3.stage=3Dnested=E2=
=80=9D, and
> >> advertised to guests as (IDR0.S1P =3D=3D 1 && IDR0.S2P =3D=3D 2)
> > For the whole series (3-9, 11, 12, 15, 16, 18):
> >
> > Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >
> > (and I think patch 16 is missing Eric's R-b)
>
> Jean-Philippe and I have followed up the progress of this series,
> Mostafa took into account all our comments and all the patches were
> reviewed. It seems to be in a pretty decent state so if you don't have
> any objection, please consider pulling it for 9.1.

Yep, I've had this series on my radar since you said in a
comment on the previous revision that it was close to
being ready. Thanks to both you and Jean-Philippe for doing
the heavy lifting on the code review here.

Applied to target-arm.next for 9.1, thanks.

-- PMM

