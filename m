Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10C7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 11:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rVV-00006o-3u; Fri, 03 May 2024 07:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s2rVN-0008Jg-28
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:55:09 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s2rVK-0002XK-JK
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:55:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5966ea4fafso352533966b.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714737303; x=1715342103; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XPmmVB2NIQMrFdtHs/DkWgUhXnPTMJp4eJItgyjhvcI=;
 b=Kku6VBMH3mgV+bRJS2M2HVdhoS8lHaYHC/IwnVY67xbdLcD2KmsOPa6+NXCUDG17zN
 nLu3ZtYGd3/mCga1OmPHEHO8gkz14hN2EoN5jibLR4ADGoI+DazDBr9O13g4tpP0kTc9
 568yFfLh5Bir9VhpTtAcMOLw8xrFvI1WbqnfwUq34CXbP4wzpKs1twmObza/iRtt9LJL
 bLTeDdkAk5Uy7xdlpHfdST8fQq/OIeNgJmjDU+mJj9MiqLZ3JXEyPWUYtp1lU4PUrew9
 LPGS48WbLy7RBeNHFp+BNRsjUq5QprFpxwiFN/oKeiWcDHda/kbsIIQTOZUx8pTql6yt
 a0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714737303; x=1715342103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPmmVB2NIQMrFdtHs/DkWgUhXnPTMJp4eJItgyjhvcI=;
 b=uZcTtSs1i0qNGz2dSdhSevTEh+bSzKC8SyDODZCRANqXbesPxHgQK1mOydbtee0GJd
 iUxy5w94M/ws0Wf/g3nB/0OZNQYnwAAO27hvF6+2ZS9RHZhkqAIoieUafgxrU8FHLbjR
 CO4ou5xW+VpAoUFZymH0+qvr96L/aGZZx+6Dhbp0oPIjQ2rwU6scmhG1x0DggufnwFtA
 kdS4cJt/bcq5lS2YYn98ukFgCQ8xRPloNM6oMONDh/GrcI+6+xM8Aew4mkdhYv1QIVcu
 YuvNyxl50pyJbDmUOV1JQiTS/VeYdmUgWKQ+SvvP4NwBlhNKqxUddM4FquONSE/q4n3u
 r+ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF8KtUfNDvTqnz76AgJTuOb4zBlQbIqy1jm8I2b1Mzm92hCcJpNdCwLulz/zd/ReLLGIMAkgBft+jjqYvUsIC2hmYqx5M=
X-Gm-Message-State: AOJu0YxXbG0GWct1HkCbOBIUpvv0ig024NQ+UOhAm0TSMJZnKq8DJKzi
 X8a7qDaYxgHGy2IwiiGIcWwjQv+Nj6eRbA2HxbChO07PbxeQ7ADqNk81kxUo6Oc=
X-Google-Smtp-Source: AGHT+IHabr4V0on42EpFuBZCtspfGWwMqtfKlMFysjY56S+e5VICmjD/MWpwfpxrs05KG8PBE266sA==
X-Received: by 2002:a17:906:309b:b0:a59:9c2f:c7d4 with SMTP id
 27-20020a170906309b00b00a599c2fc7d4mr338918ejv.19.1714737303572; 
 Fri, 03 May 2024 04:55:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a1709061c8200b00a59937ec4c4sm518079ejh.87.2024.05.03.04.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 04:55:02 -0700 (PDT)
Date: Fri, 3 May 2024 13:55:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Aleksei Filippov <alexei.filippov@syntacore.com>
Cc: alistair.francis@wdc.com, alistair23@gmail.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v6] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240503-1417868a079951810dadb71c@orel>
References: <20240422-e78b28f00a168518c5d4937a@orel>
 <20240422114254.13839-1-alexei.filippov@syntacore.com>
 <20240422-fd9fc07462257b6da42d8eb5@orel>
 <20240425-7ae473e720f2879f34c957f6@orel>
 <e7acd34f-956c-47ea-acfd-0b9ef82ff90c@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7acd34f-956c-47ea-acfd-0b9ef82ff90c@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 03, 2024 at 01:39:32PM GMT, Aleksei Filippov wrote:
> 
> 
> On 25.04.2024 12:21, Andrew Jones wrote:
> > On Mon, Apr 22, 2024 at 02:31:36PM +0200, Andrew Jones wrote:
> > > On Mon, Apr 22, 2024 at 02:42:54PM +0300, Alexei Filippov wrote:
> > > > kvm_riscv_handle_sbi() may return not supported return code to not
> > > > trigger qemu abort with vendor-specific sbi.
> > > > 
> > > > Add new error path to provide proper error in case of
> > > > qemu_chr_fe_read_all() may not return sizeof(ch).
> > > 
> > > I think something more along the lines of what I wrote in my previous
> > > reply will help clarify this more. Here's what I wrote
> > > 
> > > """
> > > Exactly zero just means we failed to read input, which can happen, so
> > > telling the SBI caller we failed to read, but telling the caller of this
> > > function that we successfully emulated the SBI call, is correct. However,
> > > anything else, other than sizeof(ch), means something unexpected happened,
> > > so we should indeed return an error from this function.
> > > """
> > > 
> > > Thanks,
> > > drew
> > > 
> > > > 
> > > > Added SBI related return code's defines.
> > > > 
> > > > Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> > > > ---
> > > > Changes since v4-5:
> > > > 		-Added new error path in case of qemu_chr_fe_read_all() may not
> > > > 		return sizeof(ch).
> > > > 		-Added more comments in commit message.
> > > >   target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
> > > >   target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
> > > >   2 files changed, 18 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > > > index f9dbc18a76..5bb7b74d03 100644
> > > > --- a/target/riscv/kvm/kvm-cpu.c
> > > > +++ b/target/riscv/kvm/kvm-cpu.c
> > > > @@ -1173,16 +1173,18 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
> > > >           ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
> > > >           if (ret == sizeof(ch)) {
> > > >               run->riscv_sbi.ret[0] = ch;
> > > > +            ret = 0;
> > > > +        } else if (ret == 0) {
> > > > +            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
> > 
> > I'd prefer we still explicitly assign ret[0] to -1 here since that's what
> > the spec explicitly says.
> > 
> > Thanks,
> > drew
> 
> Can you please explain it a little bit more, cz I believe SBI_ERR_FAILURE is
> -1 anyway. Defines was added at first place just to came along with Linux
> kernel SBI related defines.

Legacy SBI calls like SBI_EXT_0_1_CONSOLE_GETCHAR don't return a struct
sbiret, they only return a function-specific long. The spec says for
Getchar that it returns "...the byte on success, or -1 for failure."
So we should explicitly set failure to -1, especially since
SBI_ERR_FAILURE isn't defined for legacy SBI calls.

Thanks,
drew

> -- 
> Sincerely,
> Aleksei Filippov
> 
> > > >           } else {
> > > > -            run->riscv_sbi.ret[0] = -1;
> > > > +            ret = -1;
> > > >           }
> > > > -        ret = 0;
> > > >           break;
> > > >       default:
> > > >           qemu_log_mask(LOG_UNIMP,
> > > > -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> > > > +                      "%s: Unhandled SBI exit with extension-id %lu\n"
> > > >                         __func__, run->riscv_sbi.extension_id);
> > > > -        ret = -1;
> > > > +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> > > >           break;
> > > >       }
> > > >       return ret;
> > > > diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
> > > > index 43899d08f6..a2e21d9b8c 100644
> > > > --- a/target/riscv/sbi_ecall_interface.h
> > > > +++ b/target/riscv/sbi_ecall_interface.h
> > > > @@ -69,4 +69,16 @@
> > > >   #define SBI_EXT_VENDOR_END              0x09FFFFFF
> > > >   /* clang-format on */
> > > > +/* SBI return error codes */
> > > > +#define SBI_SUCCESS                  0
> > > > +#define SBI_ERR_FAILURE             -1
> > > > +#define SBI_ERR_NOT_SUPPORTED       -2
> > > > +#define SBI_ERR_INVALID_PARAM       -3
> > > > +#define SBI_ERR_DENIED              -4
> > > > +#define SBI_ERR_INVALID_ADDRESS     -5
> > > > +#define SBI_ERR_ALREADY_AVAILABLE   -6
> > > > +#define SBI_ERR_ALREADY_STARTED     -7
> > > > +#define SBI_ERR_ALREADY_STOPPED     -8
> > > > +#define SBI_ERR_NO_SHMEM            -9
> > > > +
> > > >   #endif
> > > > -- 
> > > > 2.34.1
> > > > 

