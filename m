Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AC7C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5S0-0004D8-MO; Wed, 15 Jan 2025 10:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY5Rz-0004Cp-26
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:36:59 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY5Rx-0000qv-Hz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:36:58 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so1332471266b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736955416; x=1737560216; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AZvcO9gYJ5afPb/YV2OTE+Vdosc9Beh7nbZuIeIvLCg=;
 b=AjKFj4KY1rugmaYOinTFlmOM6B824KGHJFV4yMUhVzv9UX0B74UrQcFSUIPuuCOkmQ
 miIfyHVmGWA+YiePCfXb3u7pyFUXITAMNy7cSR4BgJrclCF8QFqBh6B6TeuGsovcwUji
 eM1YwtgWDnU5pH48RC1aGBvoUEiGWf6d48tpQ609PniYYcyn3DPflAEM+78iCSGemc3r
 cPE1yXBPCNTR60UHN1Giithvd9ZIS3/pYuUk3rGgsGWv/Rl+i/OmZflOYoi9GugzbWC/
 jBWDz/k4uOkAP0oDcYv1RNZFY9tkp+GCKevGcaBlaWgyKMFJWiIXTByitHLCM6OAWxx5
 mxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955416; x=1737560216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZvcO9gYJ5afPb/YV2OTE+Vdosc9Beh7nbZuIeIvLCg=;
 b=nMXd4L7a9/rJRnK5jXwgU/dZFg+GQHX4q1A1Yk6zOrvyg70aS7WWOEHRFyHr5HESRE
 16KzS+XB2ZIhjKCz//HrDBNr8CZaVabY1Ou96/bL3P42YTFtQGQFtydRoCT5Y70zOjl+
 VZv72rtfFBZSyWZ8NHjPYLakaXeWYTfrRKeZD/63rtMpYga3XUjlamMoc7C5SnLznLAx
 LCn6WDVT6fulIbD4lAtvctEv8Gri39NkusBQbpcaSq1pQ+arHct5ohfOviEM1GLu6XXy
 z3pgnlTBnDNOjeF7xgTtA/bZ8nUzS0kVo9D0qxNG+7TdRuOOQzw3PzbgjsntAwBeRVMb
 nPXA==
X-Gm-Message-State: AOJu0YwqyUqddv8tMtKLD6UQwfau0VITi5WsHg4309LBel4WRNWz7JTe
 e1gV0Q/FeLQsxQKjbUfxgZz/N8zpn5EPaiWCCQu5nT274BXMFyk8+soKM44VTzM=
X-Gm-Gg: ASbGncvaVSxW7fRU7avAPN844FAXeH7aCOzL+DWz+7nAXwUa21w2xmJ4gStRyG70wuf
 qKPjbVMt1oYVV2dhrYV7ip+OzpvjSjrBDnbXKNGqRyXokYDFCTnU4o8kpMg7xSSHu/jLWA4Onra
 goezqrhxmob7vKmJ1nxnP5aWEXHjsVzkPkHkh2819Ml/6zuEB0yXs4yVloM4dOfb3cvitwVfJVL
 bGKYQm8dvILIzp2Z5DRTqSi35c2tUTkhDVDE1AZc3AUIY8dp8SyD3SFfPsll/DJQQ8MTepHnPRU
 Umj3kyryLLd1PwLGgpVbB/iUgkYhizHWFGMSGzCBDQ==
X-Google-Smtp-Source: AGHT+IGbwL00J3g4oeI8Qqvl6hhyaWh+/Xap2zFUMBqFQ7NRE+8RR69RqKiTtEJCpOi7RfMEAdYWvQ==
X-Received: by 2002:a17:906:c141:b0:aa6:5eae:7ed6 with SMTP id
 a640c23a62f3a-ab2ab6a2f04mr2620694666b.13.1736955415889; 
 Wed, 15 Jan 2025 07:36:55 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905ec4dsm768209166b.35.2025.01.15.07.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:36:55 -0800 (PST)
Date: Wed, 15 Jan 2025 16:36:54 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 4/6] target/riscv: change priv_ver check in
 validate_profile()
Message-ID: <20250115-85f0f95a9d45ab2a27225043@orel>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
 <20250115134957.2179085-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115134957.2179085-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x634.google.com
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

On Wed, Jan 15, 2025 at 10:49:55AM -0300, Daniel Henrique Barboza wrote:
> The S profiles do a priv_ver check during validation to see if the
> running priv_ver is compatible with it. This check is done by comparing
> if the running priv_ver is equal to the priv_ver the profile specifies.
> 
> There is an universe where we added RVA23S64 support based on both
> RVA23U64 and RVA22S64 and this error is being thrown:
> 
> qemu-system-riscv64: warning: Profile rva22s64 requires
>     priv spec v1.12.0, but priv ver v1.13.0 was set
> 
> We're enabling RVA22S64 (priv_ver 1.12) as a dependency of RVA23S64
> (priv_ver 1.13) and complaining to users about what we did ourselves.
> 
> There's no drawback in allowing a profile to run in an env that has a
> priv_ver newer than it's required by it. So, like Hiro Nakamura saves
> the future by changing the past, change the priv_ver check now to allow
> profiles to run in a newer priv_ver. This universe will have one less
> warning to deal with.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c9e5a3b580..f5338f43cb 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -746,7 +746,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>  #endif
>  
>      if (profile->priv_spec != RISCV_PROFILE_ATTR_UNUSED &&
> -        profile->priv_spec != env->priv_ver) {
> +        profile->priv_spec > env->priv_ver) {
>          profile_impl = false;
>  
>          if (send_warn) {
> -- 
> 2.47.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

