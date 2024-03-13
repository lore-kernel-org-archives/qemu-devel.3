Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0E3C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 12:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkO36-0000l2-23; Wed, 13 Mar 2024 08:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkO34-0000ki-Uo
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:49:34 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkO33-0001fv-5O
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:49:34 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d46dd8b0b8so5908161fa.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710334171; x=1710938971; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=67IZMwEKKDGF7mCcQNP/wMYA5z/SJyIIi8fEpZu9CgA=;
 b=iDkNYrX1hQ1DaV8TXbJ6ANuIu/QqkemxBDhvnGE1kmWtbts2S3PRXyHo1o746GD1GF
 dg1F6PByBqq7GmmRBha+KnU69LYTyA4/JO23qRmSMTE/bKMC6OztPVr98v/NYkRDmP+t
 T5SVlhInpQHgBBEgwCU7SwUb6U7qXa+1s0QsNUXMgaWxG0XsAc1WEAAgN/xrbQT/9OHu
 DVWnQi9cvescn4ye/ElU0EVZ/EjeFrkd6zdYTu5ylFE1ZZVy5H9lL88jGJAMUBlSX2Tc
 zoX08EtY468xyPFfMq8yFe/Ox47SwRoNhcj73REd64K/Zkv0gKQesPEQWeYZhD9mz+LO
 KV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710334171; x=1710938971;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67IZMwEKKDGF7mCcQNP/wMYA5z/SJyIIi8fEpZu9CgA=;
 b=duSawfUveT0G13rj87CCxHJ+tPmH30na9gMYefWN6uJSYhNKwLb8K2CJCIAdA3xdWa
 6W0E+MA+3N6/OSbhatwUAYa1ts3N0ZQr1Bb8ys/Ptize46uULBxh1GBzTgWoY7E+l4vw
 P7S5cEnudheMoPtOpF+NFfOD+QSH6NkBGqmB5fzMnRYlLPdyhktiFDHMaGxcJ0hnWxy4
 j8vo/gcavuEo8zLrE1KM3fPE3shmXBJsR0j6/jUB7ssYUyLtqqPg/nEtViqDYkJIcWKr
 +3ojgEufr0Dtpf1og0fnnHlU5bRhVLUWN0GlseNyXCQOSSBeN1b5ZaZ6jf24VHjx1/MK
 QmNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuMF0UUQA9pnMycNI1Qi/pyenOXm6T07JT0MYW25sawZAzbWwIjZjVdKYmWjo7U4ta88RHZz0tUO2mIqzkNCHqbeIx3v8=
X-Gm-Message-State: AOJu0YySijDngM0YYO+eNkM4wdhXQMxpIvY7m1jEfymcci27Sd8z5FmL
 qMgiP19R4v91s0E2/5xsXKLJqsH9gnuq0ojbyEq5uekbSjqSvjITVFIYIc9bkQ0=
X-Google-Smtp-Source: AGHT+IFN/2NxpsGdWcYL4ORLZKK6nFRJUjSqBYx0LcSiC8DipyoeVIy2BsxrEpzzaJUObJNy73qU9w==
X-Received: by 2002:a05:6512:1251:b0:513:c47d:c070 with SMTP id
 fb17-20020a056512125100b00513c47dc070mr3204316lfb.42.1710334171418; 
 Wed, 13 Mar 2024 05:49:31 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b00413294ddb72sm2268367wmq.20.2024.03.13.05.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 05:49:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:49:29 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
Message-ID: <20240313-31131fe87882ea953d5aa6d4@orel>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-3-hchauhan@ventanamicro.com>
 <20240313-0ac597594e930a42685aeba5@orel>
 <CAPd4WezTTcYA5grMBrGYx5LUwF2jPT8gbL6CQWMZtsd1AJNuZQ@mail.gmail.com>
 <20240313-8164061a70dafa62c8bb755b@orel>
 <7898E43D-AF22-4170-BEC9-BC172304F483@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7898E43D-AF22-4170-BEC9-BC172304F483@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 13, 2024 at 05:48:16PM +0530, Himanshu Chauhan wrote:
...
> >>>> #ifndef CONFIG_USER_ONLY
> >>>> +    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
> >>>> +         warn_report("Disabling debug property since sdtrig ISA
> >>> extension "
> >>>> +                     "is enabled");
> >>>> +         cpu->cfg.debug = 0;
> >>> 
> >>> If sdtrig is a superset of debug, then why do we need to disable debug?
> >>> 
> >> 
> >> "debug" is not disabled. The flag is turned off. This is for unambiguity
> >> between which spec is in force currently.
> >> May come handy (not now but later) in if conditions.
> > 
> > I know sdtrig/debug functionality remains enabled, but why state that the
> > 'debug' functionality is no longer enabled?
> 
> Got it. The warning can be removed.
> 
> > If sdtrig is a superset, then,
> > when it's enabled, both the debug functionality and the sdtrig
> > functionality are enabled. Actually, sdtrig should do the opposite, it
> > should ensure debug=true. The warning would look odd to users that know
> 
> I would disagree to set debug=true when sdtrig is selected. These are two different specifications and should be treated so. Sdtrig is a superset now but may have another revision not backward compatible. For two different specifications and flags should mirror the same. On the same lines, this patch (as it does) should keep (cfg->debug || cfg->sdtrig) which shows that you are dealing with two different specifications. They behave same for some triggers but are still different. Deprecation isn’t a problem now or later.

sdtrig is frozen, otherwise it would require the 'x-' prefix, so it can
no longer change in a substantial way and therefore if it's a superset of
debug now then it always will be. If a change is made to "debug
functionality" then it will get a new extension name which may not be
compatible with either 'debug' or 'sdtrig', however that's not the case
here. If a platform supports 'sdtrig', then it supports 'debug', as
'sdtrig' is a superset of 'debug'. Pretending like they're mutually
exclusive doesn't make sense when they completely overlap. Indeed
platform's will likely *want* to advertise that they are compatible with
both because software that is only compatible with 'debug' will need to
know if it will work or not. A platform that says it's not compatible
with 'debug', when it is, because it supports sdtrig, is limiting the
software that will run on it for no reason.

Thanks,
drew

> 
> > this and the debug=off would also look odd in the results of cpu model
> > expansion. Keeping debug=true would also avoid needing to change all the
> > if cpu->cfg.debug conditions to if cpu->cfg.debug || cpu->cfg.ext_sdtrig.
> > 
> > If we deprecate 'debug' someday, then we'll add a warning for when
> > there is 'debug' explicitly enabled by a user and also for 'debug'
> > configs which lack 'sdtrig', but we don't need to worry about that now.
> > 
> > Thanks,
> > drew
> 
> 

