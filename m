Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44423C52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmSZ-00017d-O6; Tue, 13 Aug 2024 04:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sdmSK-00013P-RG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:00:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sdmSI-0001iK-WD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:00:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1680235a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723536033; x=1724140833; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iyM7LiHcQRe8KaM/KoBlJTcbWRNr8/ceb7oLFAsUQxk=;
 b=fMSMW5bVjlO62FQvFR92RC+nTrl8xRXgFDHr5BYZnv9jAcf+C8npH/Q30V44RVktjc
 Js1cmhgi14KxqdZFzhZ52Zux5FrcCciil+RI9RpTny4QJTxvnQFNR1TmPRQvmlzii0ls
 0YBXXKc61dd/UECmomx5YDoO65M5ng4eM6rGoB8v8fpaJDjcOQF3YCXPv4XK/RwGzFMC
 4z0idWcz9lxdELBvDZD74i5lqmus4DcgxOCmPIGHXdAbW23eu4OtHfje3TKW/70Kh+8z
 BPu2Vfd5f+PcpXFvAxD0K/pZReJOeJTq/oX6uoMs9PDJlF3K0P2+/Nu/duJww34k28bN
 0uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723536033; x=1724140833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyM7LiHcQRe8KaM/KoBlJTcbWRNr8/ceb7oLFAsUQxk=;
 b=ukUh6CC3u/pjvK75lFtb/5YnA3K/Qu7XUobs8t8rY7jL0ylxJu5ygHsN/PpsyR+sPn
 S9yTmHag9FwyLUrjZNH2A9qnw2dWA1kx5SabqUPqmWHxVZBpxo0UvkcCtwbmgX4alPPW
 4MUs59Z5jbqvkQqQ37xMJ3vkYaCYjQLZeItEH00qUVgqKDqzHNAn69KD63mKGF5F9lyu
 FjBlYlECZzG4ZGz52GoVUf0WtgVkCT1k+BsgxaMT4hVNC8n1A88LWGoZV0+4MF98fxB+
 mos21kInOVIqJzsbmmXba8M98UbdPVuuQNOCTj+Wx4Fihwq3OC3TIZvejK1BrfX+LmNk
 SanQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM85nU3Hq/Z2L+eqikTc204d4sZhODGT3WBMPfh6SwgevaxzzjAsZVf0a82uSOm0q/9b/XfEkUhcTdhMykjPe7F2Dt06w=
X-Gm-Message-State: AOJu0YzODLgiPIV6LrEjmvNgu8bOZp5mR/7r0reb5vhASrRFF/hdKPxR
 py0f90XKTsCiGgod236SmiOSL3jiCjHaZX3rpFDbC5qizVgOTESTUdXRqNnTlvY=
X-Google-Smtp-Source: AGHT+IGnRfqr83No38vTk7R1Je1hlkbirCWo8htCU4nwCpbn7xGAthh7VWAb1mjQ+Kcoqf+QN/P8BQ==
X-Received: by 2002:a17:907:d17:b0:a7a:130e:fb6e with SMTP id
 a640c23a62f3a-a80f0b16469mr161003066b.15.1723536032623; 
 Tue, 13 Aug 2024 01:00:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f4cfcesm46979166b.2.2024.08.13.01.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 01:00:32 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:00:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, zong.li@sifive.com,
 liwei1518@gmail.com, cwshu@andestech.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH] target/riscv32: Fix masking of physical address
Message-ID: <20240813-e2c6dc0e68f76be576c72996@orel>
References: <20240813071355.310710-2-ajones@ventanamicro.com>
 <aa7facef-acda-4846-98d5-2f7584515035@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7facef-acda-4846-98d5-2f7584515035@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x531.google.com
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

On Tue, Aug 13, 2024 at 05:43:07PM GMT, Richard Henderson wrote:
> On 8/13/24 17:13, Andrew Jones wrote:
> > C doesn't extend the sign bit for unsigned types since there isn't a
> > sign bit to extend. This means a promotion of a u32 to a u64 results
> > in the upper 32 bits of the u64 being zero. If that result is then
> > used as a mask on another u64 the upper 32 bits will be cleared. rv32
> > physical addresses may be up to 34 bits wide, so we don't want to
> > clear the high bits while page aligning the address. The fix is to
> > revert to using target_long, since a signed type will get extended.
> > 
> > Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >   target/riscv/cpu_helper.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 395a1d914061..dfef1b20d1e8 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >       int ret = TRANSLATE_FAIL;
> >       int mode = mmuidx_priv(mmu_idx);
> >       /* default TLB page size */
> > -    target_ulong tlb_size = TARGET_PAGE_SIZE;
> > +    target_long tlb_size = TARGET_PAGE_SIZE;
> 
> If rv32 physical addresses are 34 bits, then you probably didn't want target_*long at all.

Yes, just using hwaddr for everything that only touches physical addresses
would probably be best, but, ifaict, it's pretty common to use target_long
for masks used on both virtual and physical addresses (TARGET_PAGE_MASK,
for example). This 'tlb_size' variable is used on both as well.

Thanks,
drew

