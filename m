Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531F5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvIf-0000oL-TL; Thu, 25 Apr 2024 05:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rzvIa-0000lZ-Hn
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:21:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rzvIW-0002LX-Jy
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:21:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34a7e47d164so581609f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714036902; x=1714641702; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=97rYkhbb8lYmwpMP8YUYjOvJg+pJSX7ahBwYa+G+Qkc=;
 b=Bn1YPmmt/y7J59rHzTJKOtID3fwpwejuHnELO7YZBbEL8rQRxo3vHTHmIaXDf4fWwj
 hEHbSPp/KeyPjd/itAJQ3VEysk+ZFc2jki4SuxBM7ti80FhOVTDnR0hjep7Y+uycfoGQ
 dLsVt+iQEd9tK9fSGx6ixjk6r97Yhrib4Qdja0ZuwqAYRTXp2yJW+8kwDe0hVQdYL/w/
 of/O3Rz629npCeDVMjKX8T6S8NHYQ3xvRAltuNT4IZwkb0hMXam3ZKDd/UBuix+j+ck5
 m3TRSW2ug3mbt6EHb08ZQLYMLWH+bRJOV3zMkD36l+4SeT07ArCtMPvoo3lXKpcwTxx7
 QAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714036902; x=1714641702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97rYkhbb8lYmwpMP8YUYjOvJg+pJSX7ahBwYa+G+Qkc=;
 b=bSQvyl30rYWN1N6mJS2oYuJSxtcBlB9dx9MC8BKRXD330adxb7p9jWuD2HPr6e8Vwp
 9N8bIj56H2G/2rmWLlyjigkY7Pe/qLJpwWx+VvGqAH5h0cHiUq3uXVoElVU+jfV/wAGE
 r5GeKCA24aHCMjFRSxdic1TTC4ajG9SXakEXrkci//vCKffiZhI/E6HhqZSzOZX0HtjF
 rkWv1+PFonIGFR+g/MG2fp2rppiOo8nj72WWvo37NbakOggqjCquLhrpxp1fsW1BFpag
 Uvi56GV55tkY7ywJO99+Rv3mlRmmcmQN+Xykyj6MyjKD8HEIxz0HfINZM2JaKsCorOo9
 8aSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8E/MTpuwxyb46hnNZYeRIChWXrGY5HrFwPKE0PN/hHkyCzkHfnnqZ8CtzDCCyOIPDAHd5Bu/K/+H8aGy3olHYzc1mWMU=
X-Gm-Message-State: AOJu0YzWr6qupserW6F7lvNuyfNaW8LBk4kTZYbYLgmwr7uxgXxixaY0
 84TczS8/2Djl0jhkBYBKmjRZJ6RKHDFBG3jPdvgApjMRSdRljYAPoA+O4L7mf8Y=
X-Google-Smtp-Source: AGHT+IHbmkwgeDmeLwuqPcYAlRYkHqVS2J/oQznlUnUrF/RobpzymoE9nzwh0RIC7lSo97DMZxH66g==
X-Received: by 2002:a05:6000:912:b0:348:b435:273b with SMTP id
 cw18-20020a056000091200b00348b435273bmr3966548wrb.54.1714036902024; 
 Thu, 25 Apr 2024 02:21:42 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a5d4591000000b0034658db39d7sm19493234wrq.8.2024.04.25.02.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 02:21:41 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:21:40 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: alistair.francis@wdc.com, alistair23@gmail.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v6] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240425-7ae473e720f2879f34c957f6@orel>
References: <20240422-e78b28f00a168518c5d4937a@orel>
 <20240422114254.13839-1-alexei.filippov@syntacore.com>
 <20240422-fd9fc07462257b6da42d8eb5@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-fd9fc07462257b6da42d8eb5@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x436.google.com
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

On Mon, Apr 22, 2024 at 02:31:36PM +0200, Andrew Jones wrote:
> On Mon, Apr 22, 2024 at 02:42:54PM +0300, Alexei Filippov wrote:
> > kvm_riscv_handle_sbi() may return not supported return code to not
> > trigger qemu abort with vendor-specific sbi.
> > 
> > Add new error path to provide proper error in case of
> > qemu_chr_fe_read_all() may not return sizeof(ch).
> 
> I think something more along the lines of what I wrote in my previous
> reply will help clarify this more. Here's what I wrote
> 
> """
> Exactly zero just means we failed to read input, which can happen, so
> telling the SBI caller we failed to read, but telling the caller of this
> function that we successfully emulated the SBI call, is correct. However,
> anything else, other than sizeof(ch), means something unexpected happened,
> so we should indeed return an error from this function.
> """
> 
> Thanks,
> drew
> 
> > 
> > Added SBI related return code's defines.
> > 
> > Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> > ---
> > Changes since v4-5:
> > 		-Added new error path in case of qemu_chr_fe_read_all() may not
> > 		return sizeof(ch).
> > 		-Added more comments in commit message.
> >  target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
> >  target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
> >  2 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index f9dbc18a76..5bb7b74d03 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1173,16 +1173,18 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
> >          ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
> >          if (ret == sizeof(ch)) {
> >              run->riscv_sbi.ret[0] = ch;
> > +            ret = 0;
> > +        } else if (ret == 0) {
> > +            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;

I'd prefer we still explicitly assign ret[0] to -1 here since that's what
the spec explicitly says.

Thanks,
drew

> >          } else {
> > -            run->riscv_sbi.ret[0] = -1;
> > +            ret = -1;
> >          }
> > -        ret = 0;
> >          break;
> >      default:
> >          qemu_log_mask(LOG_UNIMP,
> > -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> > +                      "%s: Unhandled SBI exit with extension-id %lu\n"
> >                        __func__, run->riscv_sbi.extension_id);
> > -        ret = -1;
> > +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> >          break;
> >      }
> >      return ret;
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

