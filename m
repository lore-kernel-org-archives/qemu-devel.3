Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA2FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMJg-0002bb-N0; Wed, 13 Mar 2024 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkMJe-0002ab-IO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:58:34 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkMJc-0007XR-QK
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:58:34 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4649c6f040so181260866b.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710327511; x=1710932311; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9lpkAjyERa4Rf3DXf4jZhptEiKJ1am8XxbTZuWnw3h4=;
 b=dV8ovxK/m1EZRblYLyY74VgXGRsev+p0YtzFQufz9FkaMMWTk9ImT3H6chQJroHftH
 /jinhManZBCTlLjpOC70nyFn8qFl63/dmfJaQA+mghT4GsQo8I5EJBFOYdeZYQbTLp8h
 HoZnV045jVU0lU5JbeUAV0DGvZ/EDTRsnxB3Pujz0gWTC5jh2lte4Ch+t4BMwRL6K1Sa
 ERIJMtSYlhKBxl4S4Rqtk7QIP2WqJ+mXGsxUcKREQQVChM3KG7VpsE6gIP4bmTMHe1eg
 gbsHINZNWU/LAZBabjys4j4pUgNjP9GRR/UTsiz+QW80mhTrTW8M8AIzsy4/2EzzSWIL
 SY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327511; x=1710932311;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lpkAjyERa4Rf3DXf4jZhptEiKJ1am8XxbTZuWnw3h4=;
 b=OsN/d45a0jRX3PmYKRm246awshESZ3koQhpIAZuRCVU+j4wuZYrqQh4bW6Obv+lGlD
 zZznjK+ptgAAfdcimiGt3aupZrRKvYq+Bc2KgIBebS8HxlcWEpvpwK5SkOCMNtGOLjIk
 5HqT9Xxk3zLPGEHMv3w8FC3GgMtZ03kH4FAf2cyRrdHo+WRNmZ5ki7uxDDp8YKro/Ya6
 GCSNbH6rki4ctRagg6g6xa8kbrdDsWWg/PXqMJxw8wCvosySHQdf7Ie4VFc50D8S7ckq
 pBnLHU6N7c1FTiXa1bubNwETPYjd1pK4iFL0FVdtI0I7BuptgksU8edGxibPn6d+XL8y
 3jsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6ErdDsdvlTJxPox9PHm0vK4luT9EiU3/mb/auXDgcNRkPVmBgCVbtq/iHOEZh6w0B7KMndkiZNNlFYb3Kl+cvp+O3GoY=
X-Gm-Message-State: AOJu0YzAcDy3gPWKpeGuT1NSOXzmbrKRdQPdjdCBTNl2Ev2SHh9i9qh6
 HkZtjC0IaLKMV8V9Bg8g11skbZu6drzH+np58ZGp1+dIVZkXGV7RE6coCEq7DMA=
X-Google-Smtp-Source: AGHT+IEHLudMK7edtAnSwTUUn64Pe2HSE3nYVYh/10nT+TbmI68op0IeH8WGLnA/RlgqYEVz9wHNxQ==
X-Received: by 2002:a17:907:6a13:b0:a46:1d0a:9f17 with SMTP id
 rf19-20020a1709076a1300b00a461d0a9f17mr7958700ejc.11.1710327511008; 
 Wed, 13 Mar 2024 03:58:31 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170906111400b00a46637f8fdasm179350eja.163.2024.03.13.03.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:58:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 11:58:29 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
Message-ID: <20240313-8164061a70dafa62c8bb755b@orel>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-3-hchauhan@ventanamicro.com>
 <20240313-0ac597594e930a42685aeba5@orel>
 <CAPd4WezTTcYA5grMBrGYx5LUwF2jPT8gbL6CQWMZtsd1AJNuZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPd4WezTTcYA5grMBrGYx5LUwF2jPT8gbL6CQWMZtsd1AJNuZQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
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

On Wed, Mar 13, 2024 at 03:50:16PM +0530, Himanshu Chauhan wrote:
> On Wed, Mar 13, 2024 at 3:24 PM Andrew Jones <ajones@ventanamicro.com>
> wrote:
> 
> > On Wed, Mar 13, 2024 at 11:39:30AM +0530, Himanshu Chauhan wrote:
> > > This patch adds "sdtrig" in the ISA string when sdtrig extension is
> > enabled.
> > > The sdtrig extension may or may not be implemented in a system.
> > Therefore, the
> > >            -cpu rv64,sdtrig=<true/false>
> > > option can be used to dynamically turn sdtrig extension on or off.
> > >
> > > Since, the sdtrig ISA extension is a superset of debug specification,
> > disable
> > > the debug property when sdtrig is enabled. A warning is printed when
> > this is
> > > done.
> > >
> > > By default, the sdtrig extension is disabled and debug property enabled
> > as usual.
> > >
> > > Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> > > ---
> > >  target/riscv/cpu.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 2602aae9f5..ab057a0926 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
> > >      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> > >      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> > >      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> > > +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
> > >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> > >      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> > >      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> > > @@ -1008,6 +1009,12 @@ static void riscv_cpu_reset_hold(Object *obj)
> > >      set_default_nan_mode(1, &env->fp_status);
> > >
> > >  #ifndef CONFIG_USER_ONLY
> > > +    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
> > > +         warn_report("Disabling debug property since sdtrig ISA
> > extension "
> > > +                     "is enabled");
> > > +         cpu->cfg.debug = 0;
> >
> > If sdtrig is a superset of debug, then why do we need to disable debug?
> >
> 
> "debug" is not disabled. The flag is turned off. This is for unambiguity
> between which spec is in force currently.
> May come handy (not now but later) in if conditions.

I know sdtrig/debug functionality remains enabled, but why state that the
'debug' functionality is no longer enabled? If sdtrig is a superset, then,
when it's enabled, both the debug functionality and the sdtrig
functionality are enabled. Actually, sdtrig should do the opposite, it
should ensure debug=true. The warning would look odd to users that know
this and the debug=off would also look odd in the results of cpu model
expansion. Keeping debug=true would also avoid needing to change all the
if cpu->cfg.debug conditions to if cpu->cfg.debug || cpu->cfg.ext_sdtrig.

If we deprecate 'debug' someday, then we'll add a warning for when
there is 'debug' explicitly enabled by a user and also for 'debug'
configs which lack 'sdtrig', but we don't need to worry about that now.

Thanks,
drew

