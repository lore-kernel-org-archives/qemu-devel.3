Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A3C36018
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXL5-0003uB-K2; Tue, 17 Sep 2024 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqXL1-0003sv-Pq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:29:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqXKz-0000iW-Cx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:29:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374b9761eecso4472636f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726576183; x=1727180983; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cDwJqjT39P7l+wmzkodQCGVmKW8RyhC5f8lT0NFE48I=;
 b=AIUYU1OdoDRxxRglFOrbdTc9Hq5MRnRfXNANXPBc85qlUVc6/GXqeyoUEv4Q68bDvl
 Ch5SER+QTtDCyvcQHgXj1pLuiKTrdKqYNO3rqArk3Z7+XH2bJj0xJFy8yuJMg/OVWQuK
 0WxFMOC5b7EkSLoV+Ojz4ZxSiepHpyqa8UWZVAdV6o67C1m4VVKpqjW6ST6u4qJe/S9E
 IOM9SbprW8s8Bds7sPw7+VzTXZmgqeYw8cqc43xUGEK3ZdQu47pTMtEU/PjS9eCRNGPi
 K/0RoBC5a2aSkn0Cru5PkLiqY0C9SYzqzxGpTjqGW65Wj2GHw8b0Pbb8sYH/a99Xohe/
 aSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576183; x=1727180983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDwJqjT39P7l+wmzkodQCGVmKW8RyhC5f8lT0NFE48I=;
 b=tfxb4SHZgy79miARFcLQkO6YcprouRPMrheYNPC0LUqer9Rg6d9uMjb95m36hRdQeE
 tZnZnt7oRWNp8MGb0nlCFJU0wkyXaTAErataEVVJfRBnuHwYRka53fGrpqRuIzV6m4aA
 D6Qk8dmJ2kVGxNeYZuLh5em+BiUR3C85eN0rDR/9NxXSq5As1uZbFGiJr8LTdd4Mm5TB
 LnmLFLYQhByzg9xDn0mddnl1L8CzMlzTff95dbk8DyGLCdlnR8DGMZuy/JIUKfdTyeYU
 2Gg1N6PrHCv6hiy9iymPU4lzLvlAMko4guSwcxytDKMV0Pd7EgtWkrQf0w1WqPmfdQs7
 +BSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ67UyBPO/9EgFqfvKQcMr4ck+HlkSiktVr1ALvDzNIrCVIArgZB8RN+6c9GOi1T1DEntuZqiS5Akv@nongnu.org
X-Gm-Message-State: AOJu0YwpxtZNxThfWRmkSJI3zAmKSecoZq68My4BetbDyjcNh/ETKR+b
 OLbQLW59JuYrpuaBSQyfSKYdP/lpvi5Bki3v4M/J13T1mNJNHBvksWonPkeiJQE=
X-Google-Smtp-Source: AGHT+IGoGLCoJThzqQAu/NfFkIZ2VYBcdN+6Phs4T7Bx8M0Yjpd+25ONDLaZRkwAh/sK9knOvdFSpA==
X-Received: by 2002:a05:6000:11c7:b0:368:633d:f111 with SMTP id
 ffacd0b85a97d-378c2d4c92dmr10453302f8f.40.1726576182374; 
 Tue, 17 Sep 2024 05:29:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780e14fsm9425127f8f.117.2024.09.17.05.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:29:41 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:29:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: alistair.francis@wdc.com, alistair23@gmail.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v9] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240917-4c642a7fb52b49f470c9f29a@orel>
References: <20240626-1420003b7d88d892be22a719@orel>
 <20240917115433.38503-1-alexei.filippov@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917115433.38503-1-alexei.filippov@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42f.google.com
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

On Tue, Sep 17, 2024 at 02:54:33PM GMT, Alexei Filippov wrote:
> kvm_riscv_handle_sbi() may return not supported return code to not
> trigger qemu abort with vendor-specific sbi.
> 
> Add new error path to provide proper error in case of
> qemu_chr_fe_read_all() may not return sizeof(ch), because exactly zero
> just means we failed to read input, which can happen, so
> telling the SBI caller we failed to read, but telling the caller of this
> function that we successfully emulated the SBI call, is correct. However,
> anything else, other than sizeof(ch), means something unexpected happened,
> so we should return an error.
> 
> Added SBI related return code's defines.
> 
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")

Fixes tag goes above s-o-b and 8 hex digits is a bit small. Most
commit references in QEMU are using 10 or 12 digits.

> ---
>  target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
>  target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f6e3156b8d..9f2ca67c9f 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1517,19 +1517,21 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>          ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
>          if (ret == sizeof(ch)) {
>              run->riscv_sbi.ret[0] = ch;
> -        } else {
> +            ret = 0;
> +        } else if (ret == 0) {
>              run->riscv_sbi.ret[0] = -1;
> +        } else {
> +            ret = -1;
>          }
> -        ret = 0;

Looks good!

>          break;
>      case SBI_EXT_DBCN:
>          kvm_riscv_handle_sbi_dbcn(cs, run);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> +                      "%s: Unhandled SBI exit with extension-id %lu\n",
>                        __func__, run->riscv_sbi.extension_id);
> -        ret = -1;
> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;

This, along with the addition of the SBI_* defines below, should be a
separate patch. If we were just naming the -1, then I wouldn't mind it
slipping in with the same patch, but this is changing behavior since
SBI_ERR_NOT_SUPPORTED is -2. I agree with the change, though, it just
needs to be a separate patch. And the separate patch should have the
same Fixes tag.

Thanks,
drew

>          break;
>      }
>      return ret;
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
> index 7dfe5f72c6..4df0accd78 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -86,4 +86,16 @@
>  #define SBI_EXT_VENDOR_END              0x09FFFFFF
>  /* clang-format on */
>  
> +/* SBI return error codes */
> +#define SBI_SUCCESS                  0
> +#define SBI_ERR_FAILURE             -1
> +#define SBI_ERR_NOT_SUPPORTED       -2
> +#define SBI_ERR_INVALID_PARAM       -3
> +#define SBI_ERR_DENIED              -4
> +#define SBI_ERR_INVALID_ADDRESS     -5
> +#define SBI_ERR_ALREADY_AVAILABLE   -6
> +#define SBI_ERR_ALREADY_STARTED     -7
> +#define SBI_ERR_ALREADY_STOPPED     -8
> +#define SBI_ERR_NO_SHMEM            -9
> +
>  #endif
> -- 
> 2.34.1
> 

