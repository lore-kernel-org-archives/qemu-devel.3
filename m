Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD95C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRK7-0003W1-Ma; Thu, 04 Jul 2024 14:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRK6-0003VT-0p
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:36:50 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRK4-0005mq-FY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:36:49 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ee920b0781so4296201fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720118206; x=1720723006; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cQJ05o1jVN71hTnXWfiLF2GTxY/ASb+HHdgiIzEl/2g=;
 b=nef7jeS7PmrqSLoTn6QHgfw7z2YbPnB9RMhFYCAmObcUudm4NAfGvFbgEg6tP/44ow
 I0Fx8jB9NdgVfmAz8KNxuDrXKo5tqcOz2VFa2Ww1BHq1TgFr9sYoVGaQYrcwNRQEYwZ0
 6TVRxmgX5S78sCylTjQXTmMbMR0Emo262VJ4ruZ7N+fc+fluh6TkyffB5pn8dMyWwenY
 hTrJFis89C7e174g96gKuLVA8+GJNjGDnsdGL5j/5m6TYIOPh6UR02Oa2RXyj0TmQPUp
 dGf9fpm7ws8pE6YSYO2/4PLm7+LRiXQS6aGkV4cA/UuuCC2IxlRW3MlYImc+BeSoOiSL
 kGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720118206; x=1720723006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQJ05o1jVN71hTnXWfiLF2GTxY/ASb+HHdgiIzEl/2g=;
 b=kOU077KshzWUgqw4rXc8a4BJG5E85zCCWEL6mWD+aPs25auSluRum+qD3ciqWQQ0b6
 G6Dfn6paf6VmHYaUYWijr7uOfyQ+OD6p10FtS6ExznL98rcOolhn3FeuarS1S5SIraU/
 BPO4hGX2KWpThxTBmGSrTKY0qMZaUy/OOLGM2/rRaGk7W4PIofgO/kDppGPyz7cseFga
 vR7que88jeGJE+ZFwFp6eEOBcIv6LXPWXd0EX3pJtIE2uQA6K41nR0UJOtBM0B+snkte
 V6eX3MRU7Cv9AMOaqB03BXhHySiPtNgtCmJdm9W+b2xc6c5YF8Wd91bNZV1/IbU+T36M
 bkWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVveBfztFUKadxBjT909kVbXcte7dadz5TS7JRjiPbxUx4sEzotzc4H7oGwBUvNae/un+WUX7frL/IH8OaMCEQvfpFoz7Y=
X-Gm-Message-State: AOJu0YwEVPrTEDLmUl4So4aiIu9uU7C2w0NQFzaAO4aR+rXT3DuAg8iw
 UzMZgdxvpv2BBdKlLvJDas4UEOXfNQFKL4v0M/q58oIxU7+woXy6Rw66RoFrcok=
X-Google-Smtp-Source: AGHT+IGokwTm5e8a3miuCKcpayITWYncAoisbP3rsOcbAs3Wu37k7C2k1MTHKpur3TH5UtezYhSKdA==
X-Received: by 2002:a05:651c:1511:b0:2ea:e57c:a55b with SMTP id
 38308e7fff4ca-2ee8edb760cmr22754801fa.31.1720118206197; 
 Thu, 04 Jul 2024 11:36:46 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679d07708bsm2302129f8f.40.2024.07.04.11.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:36:45 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:36:58 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 18/19] hw/arm/smmuv3: Advertise S2FWB
Message-ID: <20240704183658.GO1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-19-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-19-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x22e.google.com
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

On Mon, Jul 01, 2024 at 11:02:40AM +0000, Mostafa Saleh wrote:
> QEMU doesn's support memory attributes, so FWB is NOP, this
> might change in the future if memory attributre would be supported.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 807f26f2da..88378e83dd 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
>          /* XNX is a stage-2-specific feature */
>          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
> +        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {

Why is this check needed?

> +            /*
> +             * QEMU doesn's support memory attributes, so FWB is NOP, this

doesn't

Thanks,
Jean

> +             * might change in the future if memory attributre would be
> +             * supported.
> +             */
> +           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
> +        }
>      }
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

