Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A3CEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLPYk-0004SH-QH; Tue, 18 Nov 2025 12:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vLPYJ-0004IX-LC
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:31:58 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vLPY8-000196-Vv
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:31:33 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8b2d32b9777so512109985a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 09:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763487072; x=1764091872; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QVPoESxi6UHoAgt8OY3MFpNcL1B4SyjIDkNbru2Grxw=;
 b=XZmPXZvHO1H9REhiv3tFYr4Jn5cgO1/ZVFTdIR0p960kWDqGlXNuugTP4uU8HMwcaH
 PcdBXGBijvOEcfzh6U0kq0znz4rJtsA1fLsGRhsQ+dc8rAfZopRuD8Pmt80wG5Lx4aaK
 o0OV9rgpWeNCtAXruelI6qftX7/88f/HhOtGSGkUpKctxCvzlmcuhzSDr1bGmoGJ0SJt
 AW1ZLuz+HFlXlcdtmhyNJi90MZvFMwxI9Z8gvbz1SUrYVVlAyf+0gDSDtEnaK3nXPLEa
 809/QTYXHatesuHjUgwBYnCrCCCztN3AE8J+i8/0/ROlmaB8rBQhsy19DAMmJK8LpSPZ
 Wfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763487072; x=1764091872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVPoESxi6UHoAgt8OY3MFpNcL1B4SyjIDkNbru2Grxw=;
 b=lQuFTpnP8jyU6rVIJIraOKEvXJXgLrslvGJ+D+Lt5DDMdAPoTT24KxvXLdZTkafH+9
 s6TeBko1CcszSc9QXiByhhPO3YOgMcajiYFa1E6XF7Vnp4E/Vxn+mVEYwJwyt1T0LRFe
 Ts+ZiTRy2EXrNghW6QxD9MFUSW7PQXFr6D0/IiBhtBwdD+5OIKGhWKoBISGpurdZQh1y
 P5tWSaj3Afk3AdAdv1EkYlEqi0RHRNHQapZzsVgeGtGyQ6u5S68pE7z0l8RoIhLsXozh
 9FxMDegpG6HGEC/vqwItCDxyHNlfk7Bvpd+EocyaikghPpc/5781sD4XLfR8TmJ1u4vD
 HbXA==
X-Gm-Message-State: AOJu0YyV6ebKoyHFjmo7rBWRcJX1cd8O18lT58sFsU7uz7ZAtFARjcD1
 5bpai0iiJmFZWMRGzUEm5KpNgXkpQq5gYNfEEhoxay19VB9xvzIjdL2a
X-Gm-Gg: ASbGncuJzddU5GD9Au7ZvBs17srLSZzTsWK+lOqjp4RmmXFnnFY0+NNR3ndcMrdW67S
 PJZZDYYYL37tGr0AsdDr81k2sLeYSoBhdMqoCjXACi5bRBO5pVfowWiGP+PlMkVO90WIfDdqtkO
 xoZSwn2A7GR35vpMB86fdh36LdhUiIGXFZUz7I/3h0KiRp4uC66iaeZbJEAMW+zSVgKgrq16tti
 jm2QeuGnXnO7HWiAgKnKtvlgksWj1zKJ76VwtgvpAR0Ob/uhOtQa8klvOoUa5jTSdip6taSu+8r
 U7PLv13DacQbIxBzok8sjCMTJFrLJzAFYJMWgR0mB0omIVz07K1+IwJEdJAS9OB8nc2L/RcEJFf
 DzxGcArZmHwR9gcyxWIztKvHDd8ZkBoimN3htlYbyMc3JBLrubVugPIztvbbWaZ6oRkeWM1cVve
 xRhPaYaL+LmjRS3Q==
X-Google-Smtp-Source: AGHT+IHQ3YwQbGg+r4tMreMLQSiq3oGsTaz02I7OhR9MGHivYVctSocnIY3DAFJ8Lm+el7nSUi5clQ==
X-Received: by 2002:a05:620a:288e:b0:8b2:f269:f8a4 with SMTP id
 af79cd13be357-8b2f26a07afmr950340985a.62.1763487072007; 
 Tue, 18 Nov 2025 09:31:12 -0800 (PST)
Received: from localhost ([208.89.33.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aeecb087sm1244980485a.26.2025.11.18.09.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 09:31:11 -0800 (PST)
From: brookmangabriel@gmail.com
X-Google-Original-From: archie@gabriellaptop
Date: Tue, 18 Nov 2025 12:31:08 -0500
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC v2 07/10] target/arm: ldg on canonical tag loads the
 tag
Message-ID: <jppfgy3fxrudrgjeyahog5zzu3fipmszjzidv2qj4r736iqbmv@7q63uwsgegbd>
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-7-9a7122b7fa76@gmail.com>
 <b7d5b2dd-bdb2-49f5-8345-d55d5d74a65a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d5b2dd-bdb2-49f5-8345-d55d5d74a65a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Nov 17, 2025 at 05:26:54PM +0100, Richard Henderson wrote:
> On 11/17/25 02:40, Gabriel Brookman wrote:
> > @@ -444,6 +449,11 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
> >           return 0;
> >       }
> > +    if (mtx_check(env, extract64(ptr, 55, 1))) {
> > +        shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
> > +        return (~0) << shift;
> > +    }
> 
> This should load the canonical tag, which is 0 for bit55==0.
> 
> The ~0 is wrong because it's not 64-bit.
> The field also needs to be bound by gm_bs.
> Something like
> 
>   return MAKE_64BIT_MASK(shift, shift + (2 << gm_bs));
> 
> 
> r~
> 

Hey Richard,

Thanks for the review! Expect v3 sometime soon.

Thanks,
Gabriel

