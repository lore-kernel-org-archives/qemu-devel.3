Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DA8C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLrs-0003wi-6D; Fri, 26 Jan 2024 08:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTLrp-0003pm-EJ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:03:33 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTLrn-00089g-HK
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:03:33 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55c1ac8d2f2so259047a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706274209; x=1706879009; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rsmHwy1lmuZLk+LEm6fF2YtQQTk81qK0L1TD5i/tBJ0=;
 b=WMtmvKUoje3FtNeYcsGtKPl2BJxSFm9taaTDLntbjLSm01VD12ow6gWGrSIgGiKpjK
 LphCHeRvBBM3feCy+EdyfGWNqA4UiGer9/B5qRxTQpWT5FU5aYTfX2gHYBAZjHVo+zvS
 X5u/rzCN0o/swkkQtL280rXb1gAO50k0SXZ0V/vQgONPs6Wgq47fVqO0CJZCWo2YcQJ3
 x869HIG+nTkcA2fW5jH3UOQXdXIIIaiD84NZxpEX15B6pJcZsxk9UcinbbryjbnsumrY
 SfFFVwwsmelqVVxE2k0UbHoqBtRzSkX6SpwVMcqo7cVOSgPwO7Z/lG4wbArnYuSJ5FpF
 9IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706274209; x=1706879009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsmHwy1lmuZLk+LEm6fF2YtQQTk81qK0L1TD5i/tBJ0=;
 b=r73GOnJOwq5uehSj/i0Z1xDVKBd98NY1qfQOQjHJyK5ogNJHDLyKOHfQjPl6LIFWgI
 /lmPaFk6u4WkGIAX/cNC1BYogdIJ2yEDfBVsDgHKTpvpDYzBve/2RzDO8Eg6GeQKe4du
 99BsTvcQS10axbI6Zw3VGc73kJmmeaD/iwAClnNWb+QCcKeYtUUlNpdIg7SuVykaNSn6
 xGxRS05RcwfiowtmB4M7A5u0xNRHl7VBR6wkA8yYzlxWpzngc+T8rGJRH0ddSLFdu6gY
 5DRGyzMikTX2Rf7hnm10svP8byABh1XXSGvqWvmaCqwKZzc/ip4bxwUYhrg+IjKP+Z9W
 qWuQ==
X-Gm-Message-State: AOJu0Yz735Pwi0KkEgzYNgT+vIshYpqGrKrWOeCf3pYKzanuvnmBgzqh
 ZfJoBopeVhv3GaoBCQEHizZ2TNXzWTJgh/n7a42/ppK4mFn+dzcKiZxy9itOO0E=
X-Google-Smtp-Source: AGHT+IFh4SAYEqCDdpfCaJJetNnaIVysFKYa16q5xm9h/+C0VuZe0+YpblFaNFuuUl55bnnRaNioqg==
X-Received: by 2002:a17:906:7f97:b0:a31:1b72:9efd with SMTP id
 f23-20020a1709067f9700b00a311b729efdmr787722ejr.66.1706274209086; 
 Fri, 26 Jan 2024 05:03:29 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 vw16-20020a170907a71000b00a2ca97242d5sm601302ejc.120.2024.01.26.05.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:03:28 -0800 (PST)
Date: Fri, 26 Jan 2024 14:03:27 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 6/6] target/riscv: Promote svade to a normal extension
Message-ID: <20240126-a0cd03d186454ff0a98f7911@orel>
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
 <20240125195319.329181-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125195319.329181-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52c.google.com
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

On Thu, Jan 25, 2024 at 04:53:19PM -0300, Daniel Henrique Barboza wrote:
> From: Andrew Jones <ajones@ventanamicro.com>
> 
> Named features are extensions which don't make sense for users to
> control and are therefore not exposed on the command line. However,
> svade is an extension which makes sense for users to control, so treat
> it like a "normal" extension. The default is false, since QEMU has
> always implemented hardware A/D PTE bit updating, so users must opt into
> svade (or get it from a CPU type which enables it by default).
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a56c2ff91d..4ddde25412 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1421,6 +1421,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>  
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> +    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),

I forgot that the 'max' cpu type will ignore this off by default setting
and enable svade by default. I'll send a v2 of this series where I ensure
svade for 'max' also defaults false.

Thanks,
drew

>      MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
> @@ -1528,7 +1529,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>   * and priv_ver like regular extensions.
>   */
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
> -    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>  
>      /*
> @@ -2175,8 +2175,6 @@ static RISCVCPUProfile RVA22U64 = {
>   * Other named features that we already implement: Sstvecd, Sstvala,
>   * Sscounterenw
>   *
> - * Named features that we need to enable: svade
> - *
>   * The remaining features/extensions comes from RVA22U64.
>   */
>  static RISCVCPUProfile RVA22S64 = {
> @@ -2188,11 +2186,11 @@ static RISCVCPUProfile RVA22S64 = {
>      .ext_offsets = {
>          /* rva22s64 exts */
>          CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
> -        CPU_CFG_OFFSET(ext_svinval),
> +        CPU_CFG_OFFSET(ext_svinval), CPU_CFG_OFFSET(ext_svade),
>  
>          /* rva22s64 named features */
>          CPU_CFG_OFFSET(ext_sstvecd), CPU_CFG_OFFSET(ext_sstvala),
> -        CPU_CFG_OFFSET(ext_sscounterenw), CPU_CFG_OFFSET(ext_svade),
> +        CPU_CFG_OFFSET(ext_sscounterenw),
>  
>          RISCV_PROFILE_EXT_LIST_END
>      }
> -- 
> 2.43.0
> 

