Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FCEC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYJR-0006qK-Ie; Tue, 30 Jun 2026 09:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1weYJQ-0006q7-QB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:15:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1weYJO-0005NC-2P
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:15:40 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso8104684a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782825336; x=1783430136; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BPiaEk3+CCk+AmYMD67qlsorRZzNw46lcqOGFjH8LzU=;
 b=TZxMct63nqs/IQxOiv4akuIL+Pml9eknwA6kAHvsUah8SZfqWGy/RMGRSUF8LruaaN
 G5WyG+Pqz0J78/AddYuBvU4H8GK4b3XcGPqOCOsiijP72E1+bBtvx6lPsmys9YFdiZld
 1oAJAElkM+zZ4TUvMxr/hmGgwE0bV9s4tDryUAxSovOqkjiZHxdyJsxgWZXs9TqpvwdM
 JCWrRM+eY43XNjoNd13XymZ2AmQvuDjjB5c31D8RkwAQRg7QGkdR1HGShWTzxrMHDt1z
 9lY1x7oHHBRGtGfeljD39uNINvmVd34uVKZlJHbVMTzfaJBj9FwuM3HwCEH2J/sbwPLg
 J1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782825336; x=1783430136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPiaEk3+CCk+AmYMD67qlsorRZzNw46lcqOGFjH8LzU=;
 b=DSRV9UQHpw/hkB93c1qLmIUzqoGDNRUQFTmKbl+bMBLas1Re/oCF0gbFbolHDNGLhX
 78tNJ0pfAonPEF6UzjzjbqtjSv4heyQ3/GzZS3NHFn86IC1UUv/znvQjZ5/lUZCf/ejL
 uZYkZqU7+yal47mcK2UsUHa5i4I2QFRbA8mnLIZ8bHnFpIVZaeoDvU5c0ioQ5a9rvAzI
 n5QVpEpBax3GLzk+IICZhIy1Xr2QVI/4rYi7iP+CemT6RDfmV4NHMtMtqiloSBX1KFFQ
 W0LuP0mfUGDZ1Qs5r5+hmrrggXmQBHCuXPyBPuHnludN9DukNt9KakEQ9IRO975u2FqR
 cJVA==
X-Gm-Message-State: AOJu0YylHl8OUManVzqzI/LOB/dE+HOMA9wW5zLgOwWIGsz5PH6YufKf
 sNIKqvX/TFda13vwEtt7cwRHOj2XELdcn2aWI52dCP0nxf3zsj8/KEhsK+tClSpKN10=
X-Gm-Gg: AfdE7cllVADb9n0AsvgswsccrBJVb/Wg0dz82i0VjyIgH6pjtej9RfAxJ+1ayQ6XkOU
 oH0Uoxz+B8MXj/OL0AI/UApSnzRAEemZxEIus/t3aUjty24wMqjfiZyPwbKtsakIFcKjiofJnAv
 VFCiYaCjjGR8UIdgASfYmUB22W1DqFglk1kKik5OWUzHUKJeH4FkPGOynLEVYokXSZAXm1+1dAo
 WmGD3o3FKGZxuU+PXIR1BwGLi8cgDIc9dmqUYLuEkXBerwsMMAvTrhyhwHiXmIU2qlpVgbes5T1
 FruW5WEIl/O9+sAWiM7Rw0V1MTJV0G6GclJOoK5dstZffFWlPK0b4ZRGRF55PmQ7lAwlhSJiyNC
 wQCRODOfwy1EruEUUkZ6TgRSzM5O2T/OVannXgbs15Ye2BRBQSyWeC4QFh1KK/OHmlsPPH5jl1e
 xPLj0SE+ofeoD6qHnp7uD0NBiS
X-Received: by 2002:a17:907:d716:b0:c12:34ed:da13 with SMTP id
 a640c23a62f3a-c12873a8823mr156028666b.63.1782825335624; 
 Tue, 30 Jun 2026 06:15:35 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:a648:9a45:1aff:ca47])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288d16b06sm123829866b.8.2026.06.30.06.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:15:35 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:15:33 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 4/6] target/arm/cpu-features.h: x-rme now means GPC3
Message-ID: <akPBdRdfL7aE4bpQ@linaro.org>
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
 <20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org>
 <CAFEAcA_M0Z770FApDyhNcYaP89JP3Q8MDj5bMjYKSpmONYrr7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_M0Z770FApDyhNcYaP89JP3Q8MDj5bMjYKSpmONYrr7A@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, Jun 29, 2026 at 01:00:05PM +0100, Peter Maydell wrote:
> On Thu, 18 Jun 2026 at 17:33, Jim MacArthur <jim.macarthur@linaro.org> wrote:
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
> thanks
> -- PMM

I think we should, good spot. I'll follow up with another patch to do that.

Jim

