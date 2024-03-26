Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E8CCD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3Rj-0003pg-Tj; Tue, 26 Mar 2024 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rp3Ri-0003ol-GT
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:50:18 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rp3Rf-0005pK-GD
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:50:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a46dd7b4bcbso646007566b.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711446612; x=1712051412; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8tqhNhpR84gq+U3RYnctvjPwNYRpv1R563RMIXFBceE=;
 b=fGJu0dhAzNqwoo0C07pLgJz8EYdEAqNCHyYKR5pBT0DVovlNB4pohSscy1qodrO4d0
 ZmIuPwBnwGlQMgeBDDJBB4MYF1V+O4joDrjDGxq753W2vYDdVVIEaCPpPURTbYMQh6/G
 Qcqgy8BWNSZVbnhMCbfQD4XIgXMXlWIeJmSb+cWDsi/esxk+p5EVH+FD04dmBvzk71/U
 aQydCSsZAwa+SmuTP9Wrfebr02+qJ2UtaRinj7ao07fgJrOIWtJZyRCer3DontDFpeAM
 avHw9ayLwJpwcO8PK9hBxLtwHUNWUXiVmtCZ/tQAPk/y5nC9P4wkhqB5/I0rpP3tFNBZ
 DlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711446612; x=1712051412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tqhNhpR84gq+U3RYnctvjPwNYRpv1R563RMIXFBceE=;
 b=mUo7bskKwyT6a/drFmz+59Omzopt9bSy5pYGPoJvcM4+t97oPUlJPHsy5VK67C/52e
 ZujtlddoDojiIgVJQYdFG2NF7r8UDjctKYI8/+Bt3Uw2ln7WOyf7l6GjjfRs2pY7htRK
 S1kLmQLkGtMnGULhhJly1BLhMmbqY+9tOZmzm1lTb6ed9tUaqXhWPJGkO83KM4j9KHGy
 4FlJaBm8qjEildFPO0pe7S/iwq6FQHrhexsDuk3UmEn8FsN/Ru6gF7WwQtKny7bI89TJ
 t4zd1MygLDw3Xz0ulvw8PDnTFc6IQcyIPHqr+J4KaBH0LDKReSsynH8JxAtNK3OUI6j8
 Jp2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZL/0p1t67GEv94lvYwNKcue8Q7DElQpZHJp+S/Jyby4dz2RXn+wC3Lo3d67X0LORRS4Wb/X6IsZaN5glOawR6W8C0Q/I=
X-Gm-Message-State: AOJu0Yw9fEho6OgXhBFfUiX7CPKS56AX4t31SrEqYt4DGonWuVwg8da3
 O9i6I4kzUbN7cDFDy9QYIxPMEsGLxIObxBZmpObX0gO+RP8GBWvvd0ml6dWjF/8=
X-Google-Smtp-Source: AGHT+IET8z1vXkdNpUuDSPY+mMi37+GFXhJ1V7OtS7oLm2ZimM9pj2hDpTJt0kCok9wFDUEsIXMVMw==
X-Received: by 2002:a17:906:410d:b0:a47:29ef:f3ca with SMTP id
 j13-20020a170906410d00b00a4729eff3camr554193ejk.31.1711446612430; 
 Tue, 26 Mar 2024 02:50:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a1709062a8c00b00a45f39b2d16sm4043630eje.200.2024.03.26.02.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 02:50:11 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:50:11 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, liwei1518@gmail.com,
 palmer@dabbelt.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v2] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240326-672b9d2fa4066ec883a9f037@orel>
References: <b7fff1e9-f2b3-4a45-8966-1dbd76263457@ventanamicro.com>
 <20240325130116.13194-1-alexei.filippov@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325130116.13194-1-alexei.filippov@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x635.google.com
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

On Mon, Mar 25, 2024 at 04:01:16PM +0300, Alexei Filippov wrote:
> kvm_riscv_handle_sbi() may return not supported return code to not trigger
> qemu abort with vendor-specific sbi.
> 
> Added SBI related return code's defines.
> 
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
> 
> Changes since v1:
>         -Add Fixes and Revied-by lines.
>  target/riscv/kvm/kvm-cpu.c         |  5 +++--
>  target/riscv/sbi_ecall_interface.h | 11 +++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..a4f84ad950 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1404,7 +1404,7 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>          if (ret == sizeof(ch)) {
>              run->riscv_sbi.ret[0] = ch;
>          } else {
> -            run->riscv_sbi.ret[0] = -1;
> +            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
>          }
>          ret = 0;
>          break;
> @@ -1412,7 +1412,8 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: un-handled SBI EXIT, specific reasons is %lu\n",
>                        __func__, run->riscv_sbi.extension_id);

While changing this, can we also change this log to something like

 "%s: Unhandled SBI exit with extension-id %lu\n", __func__, run->riscv_sbi.extension_id


> -        ret = -1;
> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> +        ret = 0;

We don't have any paths that set ret to anything other than zero now.
Let's return zero at the bottom of the function instead. And the top
of the function can then be cleaned up to

 unsigned char ch;
 int ret;

 switch (run->riscv_sbi.extension_id) {


>          break;
>      }
>      return ret;
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
> index 43899d08f6..0279e92a36 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -69,4 +69,15 @@
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

v2 of the spec has SBI_ERR_NO_SHMEM as well.

Thanks,
drew

> +
>  #endif
> -- 
> 2.34.1
> 
> 

