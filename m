Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241CAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 08:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryomj-0006Yb-Vp; Mon, 22 Apr 2024 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ryomi-0006YG-HJ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:12:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ryomg-0004XX-9N
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 04:12:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so2839603f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713773532; x=1714378332; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fggq9oYCBlIRb5b5tr+qKUNaj5SgLfnkKOtUpB7WGuA=;
 b=j/gqFKh0+L0ARNZYpnX+lC5Z6PZusC6ZUQS48xC0zbkriTQop0KbFDeXLtzNFzNrzE
 YxVO76lKNMOIuR0SY8eKvtM0XhOOVzpIV8K4hieEztwMBniKABOdVHSx7djni8EqPJXw
 YyYydz4A/mslqmQxZD2NvG8TEnXVC7vYiY6UoJkF8CIz5Ho8ynMAjnx5TbXi6pKYkt+S
 WDcM8cvb7vHSlePKT7tPzQYyxEAFdEke8hQHQy2VHOZOFyCtGAe8bT+gK03wPShTiBlO
 wG283oPI1Gb01PpNYQqtiEJZxpkJoVywB9ZjyfQ9zt/zULFWNfAt6rybuEmgdSS8RMIz
 5l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713773532; x=1714378332;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fggq9oYCBlIRb5b5tr+qKUNaj5SgLfnkKOtUpB7WGuA=;
 b=KI9u9Huh2+8ut1uaAPD9wmmO7QMEtYSuIHgjE2IAAf+S9SmyV0D8HdQmBU6d5CAIJC
 kD5/QulzoOxphkl9FisBwj2FGSVC/jrzgC6SNAagMgu3DRqRa2nLUyNQpE5RUx6GMJpg
 4DPokWNZ8lBi6NZjxDjtsDnrj4IM4ZJb7cP7smq9075Ut0yPVZxTrZ4pX1lMgLD7oS4C
 gmGJQZkYUz4h+gQSPqDPAHqO6MpeCC8uiKDfSfWEQNsyh2BBQsJ3QTXQc43N98GYw4v3
 eqERn0dm8HHn15D1Wj0HcqKKK35EEl0+1RIXzhgliefenrvuhZEabxqgO3JMCnyD3OJ0
 xNMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqGnKCHb4yMspOkljUbjE7TAPd9cZ+nLoJP0ihVtGqVG+1klMHsYZxCWl6QwQp457fiasiwSpTG1vBkH8+zjcynDF9rbk=
X-Gm-Message-State: AOJu0YxLNxSHe9VdclLGy1W270oq40BGTypsYg1TdQnRDhUM3GnUFnNt
 rbgk/OL2zBgjrq7nWQ9yyZ/3RlbulMaqvu4cmm4J9bb7ktzi9EylEdaJjxqLMjM=
X-Google-Smtp-Source: AGHT+IHjZrUO6GARDJlAs2Q1swQIQ4+FXtOX5Wbs+/tHrcC5FSoAI4gL9cAZWPz6vcOmQU7UmlS1xQ==
X-Received: by 2002:a05:6000:12c7:b0:34a:3254:23e0 with SMTP id
 l7-20020a05600012c700b0034a325423e0mr5378675wrx.44.1713773532119; 
 Mon, 22 Apr 2024 01:12:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 q2-20020adfab02000000b00349d8717feasm11363471wrc.56.2024.04.22.01.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 01:12:11 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:12:10 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alexei Filippov <alexei.filippov@syntacore.com>, 
 alistair.francis@wdc.com, apatel@ventanamicro.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v4] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240422-e78b28f00a168518c5d4937a@orel>
References: <20240326-672b9d2fa4066ec883a9f037@orel>
 <20240413112526.8748-1-alexei.filippov@syntacore.com>
 <CAKmqyKN1ATWcSqNXXG-81shqRj_XPG0hSVPVtW3gjeOCgNNfuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKN1ATWcSqNXXG-81shqRj_XPG0hSVPVtW3gjeOCgNNfuw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42c.google.com
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

On Mon, Apr 22, 2024 at 01:55:31PM +1000, Alistair Francis wrote:
> On Sat, Apr 13, 2024 at 9:26 PM Alexei Filippov
> <alexei.filippov@syntacore.com> wrote:
> >
> > kvm_riscv_handle_sbi() may return not supported return code to not trigger
> > qemu abort with vendor-specific sbi.
> >
> > Added SBI related return code's defines.
> >
> > Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> > Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
> > ---
> >
> > Changes since v3:
> >         -Clear Reviewed-by tags
> >  target/riscv/kvm/kvm-cpu.c         | 13 +++++--------
> >  target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index 6a6c6cae80..844942d9ba 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1392,7 +1392,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
> >
> >  static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
> >  {
> > -    int ret = 0;
> >      unsigned char ch;
> >      switch (run->riscv_sbi.extension_id) {
> >      case SBI_EXT_0_1_CONSOLE_PUTCHAR:
> > @@ -1400,22 +1399,20 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
> >          qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
> >          break;
> >      case SBI_EXT_0_1_CONSOLE_GETCHAR:
> > -        ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
> > -        if (ret == sizeof(ch)) {
> > +        if (qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch)) == sizeof(ch)) {
> >              run->riscv_sbi.ret[0] = ch;
> >          } else {
> > -            run->riscv_sbi.ret[0] = -1;
> > +            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
> 
> I'm not sure I follow. This seems like a failure but we report success
> to the caller of this function?
> 
> Can you expand the commit message to explain why we want this change

Looking at this again, I think it would be more clear, and more correct,
if we only do the SBI_ERR_FAILURE path for a return value of exactly zero.

 ...
 ret = qemu_chr_fe_read_all(...);
 if (ret == sizeof(ch)) {
   run->riscv_sbi.ret[0] = ch;
   ret = 0;
 } else if (ret == 0) {
   run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
 }
 break;
 ...
 return ret;


Exactly zero just means we failed to read input, which can happen, so
telling the SBI caller we failed to read, but telling the caller of this
function that we successfully emulated the SBI call, is correct. However,
anything else, other than sizeof(ch), means something unexpected happened,
so we should indeed return an error from this function.

Thanks,
drew


> 
> Alistair
> 
> >          }
> > -        ret = 0;
> >          break;
> >      default:
> >          qemu_log_mask(LOG_UNIMP,
> > -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> > +                      "%s: Unhandled SBI exit with extension-id %lu\n",
> >                        __func__, run->riscv_sbi.extension_id);
> > -        ret = -1;
> > +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> >          break;
> >      }
> > -    return ret;
> > +    return 0;
> >  }
> >
> >  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> > diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
> > index 43899d08f6..a2e21d9b8c 100644
> > --- a/target/riscv/sbi_ecall_interface.h
> > +++ b/target/riscv/sbi_ecall_interface.h
> > @@ -69,4 +69,16 @@
> >  #define SBI_EXT_VENDOR_END              0x09FFFFFF
> >  /* clang-format on */
> >
> > +/* SBI return error codes */
> > +#define SBI_SUCCESS                  0
> > +#define SBI_ERR_FAILURE             -1
> > +#define SBI_ERR_NOT_SUPPORTED       -2
> > +#define SBI_ERR_INVALID_PARAM       -3
> > +#define SBI_ERR_DENIED              -4
> > +#define SBI_ERR_INVALID_ADDRESS     -5
> > +#define SBI_ERR_ALREADY_AVAILABLE   -6
> > +#define SBI_ERR_ALREADY_STARTED     -7
> > +#define SBI_ERR_ALREADY_STOPPED     -8
> > +#define SBI_ERR_NO_SHMEM            -9
> > +
> >  #endif
> > --
> > 2.34.1
> >
> >

