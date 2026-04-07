Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1143FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABRd-00037J-Uz; Tue, 07 Apr 2026 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wABRZ-0002em-0Z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:46:33 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wA9iq-000196-BW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 12:56:17 -0400
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d880e6fbbso1018121cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775580972; x=1776185772; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xAu+uDvQJ2Ng9RFWEjPwEjctixPjdJqujlb83VbpOnI=;
 b=p1bdEmJE2+1hQm5nH/HkpI39/jMa+6K4RQbuGhAd/vIjR1CYCro2ANQXMg489ZsK5a
 H2GMR5lWFycC6/5RxMSTXHTY42yv2AstgTDXLwgB21QhhvS6UdF1Sup+ApXgAvTmowq/
 cAEBg7ybl2d5YTbGCW1OBtCDcCB/IrDOnWXgd+LHP2u1m/CgmonMPtkLqrnx1LAoeVD/
 ZkmOvLMCLtU/3xCbodalWv49S6uOxOQ6mbA40eOy588nU19smhcVCfBmPnxBYt5Jrq6l
 L+emUrhJoeDo0HgAfamGpfxGPtK8cZvmhEMWlWVT1w5q75D/L2RQRLGRACm61i3vkl8J
 jGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775580972; x=1776185772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAu+uDvQJ2Ng9RFWEjPwEjctixPjdJqujlb83VbpOnI=;
 b=D3Djq/0+6LCTYVhdMHNXBJMfqZyUmEilNIvMtp9fcM8MgaDkNhXacVhgeV9QqhK67f
 ZOc8NfAfBo428GTlysEabECJgurzUVHZwM2rVfD+r2TcNg7fzIJxhEFBlZLGgwMZdIAc
 vslZUJsky4JRW1BEwva40USor8gbnvCcHaiwmUH2Gyjr9+SDzAnK/mYG9UchV/CWL287
 Ilg5VA6NImgxePQViPIf7/leif6PjOaW31R8BJXW+5HSnu3JbMRld0ucuCxMaAEp1vXC
 qlEr9o+KNWTDhD0xMXpB17oqEX5JoGN0lkmD7C2W5LwmyKjVhs4P4HsaHPRQDecqFPn/
 3Onw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO8CserZctyR2brO0TSpVDrzSdauDRN71Tk8xVVMEY88hSQF3/B+7yb2J4sIkPIvZYLeZcetZtmAZD@nongnu.org
X-Gm-Message-State: AOJu0YxrV4Pl76US9OWXisXgolcfBimfxTZuF67XBvaGlKm6h0grOfuI
 KbEHxGdk3uWwclZIfMn4lOBsR9wzLFiEqCb50644Oo/6ZSsMCmVVRhPT
X-Gm-Gg: AeBDiet7d9J9lASIRV56h6m0fXX9ThPOdpxoY2xfn8nEXhYFn39R8ZZjDwbnkiEtunn
 aQSsvpeb2j/E6Ki6oUwsRWuyyNqrqCZeOP6m8OoZ5UsAXVdxz76Dq1E3KPs2TcUvijzUtpyWtmA
 JeaWF5KVSQwvhjzuQhMfINuMm0FkqrTRyQo8dxwBtHQhnrAVT199fKKlLk1SEliQJ1yCxwTBJxw
 Ddc301yUqPPUypUDlH+VI0uNhMQkSDwFv/99WHc6X8ZGSRUpyTPZXV1817oCWTrTeETyIfRkNiM
 d/wmPWYhqdHfCQJilqGixs7ghGZ3YhRXsjBDLdKWsmPUHpf46tldwIfzovONSbmcgpfoNkFCiGt
 AQlbSc2J47sMoXhyMVpcqUQnN5iFMKxcxsrtCtMx3hfeEkNglDUA/GAOTNOg6wXGAcu0xG12kAH
 SSpim+uXqu2a6qVISnRF9a7qkp0QrKLiPXW2dR1sb2HXZ/a35L8Hqa64TdIuFp2yaIUyY+5N/i
X-Received: by 2002:a05:622a:1902:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-50d6fd307damr224051291cf.6.1775580972019; 
 Tue, 07 Apr 2026 09:56:12 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d521952c4sm133732451cf.4.2026.04.07.09.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:56:10 -0700 (PDT)
Date: Wed, 8 Apr 2026 00:55:51 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/5] linux-user/strace: Add a wrapper for read and write
Message-ID: <adUycpyM7bUjmC_7@ZEVORN-PC.localdomain>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407043614.372871-3-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x844.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 07, 2026 at 02:36:11PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The stack pointer is being truncated as 32-bits for qemu-riscv64, so
> let's add a print_read_write helper that ensures all of the bits are
> printed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/strace.c    | 14 ++++++++++++++
>  linux-user/strace.list |  4 ++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 2cbaf94c89..023173857b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4309,6 +4309,20 @@ print_tgkill(CPUArchState *cpu_env, const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_read) || defined(TARGET_NR_write)
> +static void
> +print_read_write(CPUArchState *cpu_env, const struct syscallname *name,
> +        abi_long arg0, abi_long arg1, abi_long arg2,
> +        abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_pointer(arg1, 0);
> +    print_raw_param("%d", arg2, 1);
If TARGET_NR_read and TARGET_NR_write support 64-bit targets,
abi_long is int64_t, so %d will be truncated. We can use
TARGET_ABI_FMT_ld to replace it.

Otherwise LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #if defined(TARGET_NR_pread64) || defined(TARGET_NR_pwrite64)
>  static void
>  print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 35f001fecd..239b9e18b4 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1114,7 +1114,7 @@
>  { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_read
> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_read, "read" , NULL, print_read_write, NULL },
>  #endif
>  #ifdef TARGET_NR_readahead
>  { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> @@ -1674,7 +1674,7 @@
>                       print_syscall_ret_waitpid },
>  #endif
>  #ifdef TARGET_NR_write
> -{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_write, "write" , NULL, print_read_write, NULL },
>  #endif
>  #ifdef TARGET_NR_writev
>  { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
> -- 
> 2.53.0
> 

