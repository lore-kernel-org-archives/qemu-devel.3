Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB55C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdogx-0007yQ-Ip; Tue, 13 Aug 2024 06:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sdogt-0007bp-8j
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:23:48 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sdogr-0006UV-L6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:23:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so4816457a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723544624; x=1724149424; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KCTQopeDa50VboYWAaOeZFagQj228o0sJa12bfyGY44=;
 b=lXXNdUogdx3R7JXIv9Cie23ivpAFI2swfsS7ytBT5qE0F2quAGhf4GQFUlZ9s5FleV
 BQ7d0095lOfkyZ6EGJCdbhXmAq2c+em+BsgZDptxgjtVqkIeIgc7PFCWEFAaTRgdQz7q
 kmynKaSTf3XDoUp9mhQX9dvVGOmbUwZLdG4mBh1ZrKv9dV/aEOx0XuEmN2kJ0HO+Bzao
 wTi1kIvTYvT90fvRk7exg29ML4ewzopSEpDltmvOazFe7LrD8qwp+GhpqY6MtWQMDJrv
 Gvv2HfI5zjsttkmGv9m9Acs2i62YVAPa8z3LHQBMaYME2IQNEfGwf5+65b2DkHXzKvKD
 Zu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723544624; x=1724149424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KCTQopeDa50VboYWAaOeZFagQj228o0sJa12bfyGY44=;
 b=jTOhp5ULe4bazWoJCzfo0kla1fcCrJF0r/FShezgTOV54MiDJDSwSZt7qDSBJTJnja
 WWoP5et7kPZASnFQWyiFC9RR7XsMH6nl0gPWJcZ2AiBaPD6MAqtkGqnwot4heEDK0QDq
 zohUGRBxTAep6r31deenW4C/CX0c1ei9GneDyoi2E00Q8ORgeWYbw1vHWcaptPNGW5Rt
 X1s1w9ElHLA2W7+2vlbyM3VEhCviAKXOIn8hcLCxcXZdLN3v38nnPmVefs0FOyYpTOx1
 60R6bieJpyaBMYT/tZneILXw2mNSYFJiZXYCJ6c4wTh+z1eVchQkp8iRTop2yNtDflfR
 y8Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp0HIvdu26F3NWZOslX5ImW34ar09NqPF1v0cMw+ycaR3xFVo91kLU/ofintCySUFfqVph9H/egKm/m8W+q/ZrZwu6MDQ=
X-Gm-Message-State: AOJu0YzQiHSA7PkMZunDd795wmfnXfMgqpf5P2oJxhOAPLfjg5DZT2C/
 ++abkyG5Cl4cPR5AhVtmW5ggwYOT4mN2soX47nAE71j6CqCWXjAt8/zDJIMc+2I=
X-Google-Smtp-Source: AGHT+IHo1ntf3RmSyynlUUTq9OkWGRrP2kW+Sj4WGnG9YecAddNE6bEp+0pTF36o6zrCIVdzclVIpA==
X-Received: by 2002:a05:6402:4150:b0:5a1:40d9:6a46 with SMTP id
 4fb4d7f45d1cf-5bd44c79e76mr2397272a12.36.1723544623341; 
 Tue, 13 Aug 2024 03:23:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd196a7ae8sm2871494a12.54.2024.08.13.03.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 03:23:42 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:23:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, zong.li@sifive.com,
 liwei1518@gmail.com, cwshu@andestech.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH] target/riscv32: Fix masking of physical address
Message-ID: <20240813-94c16c9efc943fe891ba7724@orel>
References: <20240813071355.310710-2-ajones@ventanamicro.com>
 <aa7facef-acda-4846-98d5-2f7584515035@linaro.org>
 <20240813-e2c6dc0e68f76be576c72996@orel>
 <3f1accd0-33b8-4656-944f-f6637ee315b9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f1accd0-33b8-4656-944f-f6637ee315b9@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52b.google.com
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

On Tue, Aug 13, 2024 at 10:21:13AM GMT, Philippe Mathieu-Daudé wrote:
> On 13/8/24 10:00, Andrew Jones wrote:
> > On Tue, Aug 13, 2024 at 05:43:07PM GMT, Richard Henderson wrote:
> > > On 8/13/24 17:13, Andrew Jones wrote:
> > > > C doesn't extend the sign bit for unsigned types since there isn't a
> > > > sign bit to extend. This means a promotion of a u32 to a u64 results
> > > > in the upper 32 bits of the u64 being zero. If that result is then
> > > > used as a mask on another u64 the upper 32 bits will be cleared. rv32
> > > > physical addresses may be up to 34 bits wide, so we don't want to
> > > > clear the high bits while page aligning the address. The fix is to
> > > > revert to using target_long, since a signed type will get extended.
> > > > 
> > > > Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
> > > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > > ---
> > > >    target/riscv/cpu_helper.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > > index 395a1d914061..dfef1b20d1e8 100644
> > > > --- a/target/riscv/cpu_helper.c
> > > > +++ b/target/riscv/cpu_helper.c
> > > > @@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > > >        int ret = TRANSLATE_FAIL;
> > > >        int mode = mmuidx_priv(mmu_idx);
> > > >        /* default TLB page size */
> > > > -    target_ulong tlb_size = TARGET_PAGE_SIZE;
> > > > +    target_long tlb_size = TARGET_PAGE_SIZE;
> > > 
> > > If rv32 physical addresses are 34 bits, then you probably didn't want target_*long at all.
> > 
> > Yes, just using hwaddr for everything that only touches physical addresses
> > would probably be best, but, ifaict, it's pretty common to use target_long
> > for masks used on both virtual and physical addresses (TARGET_PAGE_MASK,
> > for example). This 'tlb_size' variable is used on both as well.
> 
> Then maybe you want vaddr ("exec/vaddr.h"):
> 
> /**
>  * vaddr:
>  * Type wide enough to contain any #target_ulong virtual address.
>  */
>

I think hwaddr would fit better in this case since riscv32 virtual
addresses are 32-bit, but I see vaddr is a u64, so it would work too. I
personally don't mind changing the type of tlb_size to hwaddr, but I went
with target_long in this patch since that's what it was originally and
masking with a signed long mask appears to be a common pattern in QEMU.

Thanks,
drew

