Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9C1EF8FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxniy-00043l-LU; Wed, 04 Mar 2026 10:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnic-0003te-1w
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:01:00 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxniZ-0000AK-0R
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:00:57 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1279eced0b9so4606038c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636453; x=1773241253; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YxB/ZohAKO8oWPJWsqKaSnPEux/rkykFI8cuK+m5fuQ=;
 b=AgP8+tsvQ3vdRJ4OrQtUOHktloycEvDX0ITnsLt3H+7r417aWcqdwrhYS4BjzUbX9B
 /9cqppNSW9n110MV2X1uSWDtyGAM1Eo8TH06M2d2cYdsZioUBCyIWHXgltRXriDi6ksX
 JFmjGP5jdLmlW+8eeKGWiIOltSE7NR6TXkx5lE5jdE2wtVVdABV56XE/RIKOvlRaG01F
 /h/URvFIWUraN/fdscr9Nm5lsetDCRb7iVP9VI+3lo8h7qxoy9mLgjQQS/RfEcUn8T61
 WzHT2rI8CnjeNmQGxu1LId343M2Gvy1D0XS+/eqTbqkhDC0J0ZpeH6v3oAcSbnbfemg9
 Jg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636453; x=1773241253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxB/ZohAKO8oWPJWsqKaSnPEux/rkykFI8cuK+m5fuQ=;
 b=H2shD4M4CnzQpd+ZYpRhE4Iv+ZZ6YXAH2Tx9rt58hNbL/0kRqxZFDcQXXdrBZgEeqf
 Z1w2kXfO8iT8mCOAODpwBQiPwgBAlsLSe0fEmlyFgP/xDC2Fs4lEE5UHaICFGnWDvhS+
 uYj2BVpl/efzqd0NF0TzVVxfxtSd1sI9DlePjUtgt2Hop4L7Qp36LZWJsG9rFdWrtA+T
 I6+fvvFhRHtJ5BJfzCSyPAhdNqEUWd2HdMTsXlq7Ogwh6L67B9h2KwAZmxs2vD2jXE/f
 ytLhDnJjyEsnKUUlVyC3SLJnlhH3gBgJwDAswM+KGn+ExOEOzlVgLkQSIIsSWrKP6zMs
 JyUQ==
X-Gm-Message-State: AOJu0Yy40rXL6nIPyawq8QN7MGjlxy1SSSZKKbpbuIm8/0wcn8YhURjT
 cWw41v9UJwRhCOUwESksfEdiAUJp+J0ZigtFCOrZQsfmRPlvZF2wigNW
X-Gm-Gg: ATEYQzxo0IbfpnC1o4sc8zFbE/GPaYcycattgeLFDlnwa1oAk6k3UfzDJ+7u1Spx6vW
 RF8W9IPrpreyNDV7tOO8iKSOrwyaMTnBX5TlkK0YfMM01fSIC5Y7W3UF5H+Yd3Nr1mB9Fl1L01q
 wP9sg6FZdUnC20tE3i7gxiK/hK2p3N8MInV4hprogJYVrYW7fmIAerDvlgKXopT7XK8/6O3hYT8
 PcXi93o+4fjoA4wQL8ofVQxgG40HElN4QXD57FbfCxbQRbcGCaMckCfUb8RMcGYv9U2AXvlunh2
 Z/nyCTvRHIqBb2dpYfZzeQzLlf2oGvVMSKUTHc6Jc+97XJPX8Qxahl6IpY4mikFPcDrWVnpm+Rv
 MYjKs0OaeBGkuO38snQYOHmwDp4JqV+RoK9Hvip772mZEHa6NGVLDTZgOI9emK5KLLtx7nklTl/
 pWzj+7y+ECBH90C+lOyFHcNBR+O8TzOiNOAx3MFF1zKX3iG0nOQvbBL0xc4UnXYxBA7JzJIpIc3
 NZDCAN+5J5V6I97fxBOOiz7KA8KK5k=
X-Received: by 2002:a05:7022:249d:b0:119:e56b:91f6 with SMTP id
 a92af1059eb24-128b70f11ddmr799345c88.39.1772636452296; 
 Wed, 04 Mar 2026 07:00:52 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1279cbd1993sm9881047c88.2.2026.03.04.07.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:00:51 -0800 (PST)
Date: Wed, 4 Mar 2026 23:00:27 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
Subject: Re: [PATCH v4 2/9] target/riscv: Add the Zvfbfa extension implied rule
Message-ID: <aahI68rVQCAexFcu@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-3-max.chou@sifive.com>
 <aahH8AJMazH4q6rM@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahH8AJMazH4q6rM@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 04, 2026 at 10:57:31PM +0800, Chao Liu wrote:
> On Wed, Mar 04, 2026 at 09:25:06PM +0800, Max Chou wrote:
> > According to the Zvfbfa isa spec:
> > The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
> > 
> typo in commit subject -- "properity" should be
> "property".
Sorry for the wrong reply, please ignore.

Thanks,
Chao
> 
> Thanks
> Chao
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >  target/riscv/cpu.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 2ddc26c837..376517755e 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -2619,6 +2619,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
> >      },
> >  };
> >  
> > +static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
> > +    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
> > +    .implied_multi_exts = {
> > +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> >  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
> >      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> >      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> > @@ -2632,8 +2641,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
> >      &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
> >      &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
> >      &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> > -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> > -    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> > +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> > +    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> >      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> >      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> >      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> > -- 
> > 2.52.0
> > 

