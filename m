Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8FBEF8FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxowq-0001WI-Dw; Wed, 04 Mar 2026 11:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxowf-0001Sg-US
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:19:35 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxowe-0002oW-J3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:19:33 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12732165d1eso7556509c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641171; x=1773245971; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WrMqk3hnnydfvngnXpo9kzDHmEWuwTQZ8gd4YCCXfoQ=;
 b=kgFJ4rfiZ8dZMNbc/dlXCtoqtDPR+7JmircFnuK9Cds4cltusAIsY/idOFnT3OrCM6
 hG2fLmwrrtpU4yA8i1d2PZWMXwORJLnJkgX7AakG9vw5c7PNAVKKelFJp/1fe+q2tMTG
 uCBWA7WCxkxeTqRHqQm6KjBSXbwIclJ8JlXYiMHMycqW0W14L/ubAhQkdKULUq4kek+t
 lHX64SGElVsvC/A3kwL4xvXl2ji825Yw5vkTwAbMDzOF7/poLkkqIyCs9txncsA4kFeT
 paPs0uhHXW5pV+Iqed0V+RJ87bwtpV0V6fgD/ZhoDZ2Tv845n8CCzb5zDmnsOvrTc2uu
 9OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641171; x=1773245971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrMqk3hnnydfvngnXpo9kzDHmEWuwTQZ8gd4YCCXfoQ=;
 b=dMpxlSZZXo95Cuva7QbR+/6HXtImCcDbPME21PyA7RmLR8kA0wVzV2ED/Jtc5hdvEo
 KEtlpJSe4VnMAF3RPUz20EKl1QICJF4xs4UQpWepEqtlcOeHE22GyD/aVHr3H8YGNlBW
 RZEwZMqRDkocE48q/BkAXqoZlN8kRWBH0tHEHDoFfKa23VRpgDIi6DnJ7re74X7EekBA
 ga9xHmdfnRPzYmFBMpP08UWqmw8C5UeaEHOb/GoDVRzbWmRV+VCy9/IjkhTrqxK8/Yk2
 egisKZ6WLeOmk+PXmMF37gSrwcM6MwEcwC/r5C9JwRe7hm6BZ8Aw5PSqBiFrEKRzTE1A
 +icw==
X-Gm-Message-State: AOJu0YwOFo9Y+xHu/gaDaF5djOForGR0dmRWWXRLtHQ5fpC0ZXlAFRl8
 vKqOiJiiqjEDdihTtqox9onXQa3Fh+xxhuIITdhWKE+avHBP0HbHVC7d
X-Gm-Gg: ATEYQzwvEBBaYV5EahYJ9Q787rS9cliGd+OwSqYBgx1JPG8epIxKM2LAkIMs78iSOWx
 0cahpo35gU64rkWcLyjhebGXBnjk48GQvcRBB2XIeDHpKwIGN/xoi5lpDwl33NxzR6BlhdObV3T
 F5kIZNXg2kloAQnl1OzF9Zg/ukwdK/zc7/M+lpv8af8UtG4ay44T8D9V5ezdoL6LBialpTB6yGi
 yDiqygbdk4voYGXJdxnR6NQY9x5lkCsp4IUVUC8L+OifxGeGV1E1RYC4fOsJynnYZ+7KBxk1Uy9
 7PWcEYD/5+DSFkncgiuHT8p8FRkUOCESMQhFdxb5qs2HeI2nffHSenJSPXQx+BIf5TdwsTc8Oso
 YmsEtS9+kTm62+zSFhBwVm1beirpsJjbp0d2WpGXBSIGu1/P/bS913d46+WtTsdE+QR3hLLZBRS
 Px9g+5u0n65JXYXmmjRME92oWBWapNSV3nIjV4bURYhEk7yQ8E7/NF9HoWQBzafT2MaUUknS3+l
 xboxYTVHhk0pJDnsmM/3iZHq/wkKukL8+RXi0ITSQ==
X-Received: by 2002:a05:7022:6ba8:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-128b7094ademr1142422c88.11.1772641170899; 
 Wed, 04 Mar 2026 08:19:30 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a43c12sm20381941c88.14.2026.03.04.08.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:19:30 -0800 (PST)
Date: Thu, 5 Mar 2026 00:19:06 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 4/9] target/riscv: rvv: Introduce reset_ill_vtype to
 reset illegal vtype CSR
Message-ID: <aahbbHLzE2CjtoBy@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-5-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-5-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 04, 2026 at 09:25:08PM +0800, Max Chou wrote:
> Replace the same vill reset flow by reset_ill_vtype function.
> 
Clean refactoring. LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/vector_helper.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 7575e24084..b7105627ed 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      return reserved;
>  }
>  
> +static inline void reset_ill_vtype(CPURISCVState *env)
> +{
> +    /* only set vill bit. */
> +    env->vill = 1;
> +    env->vtype = 0;
> +    env->vl = 0;
> +    env->vstart = 0;
> +}
> +
>  target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                              target_ulong s2, target_ulong x0)
>  {
> @@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      }
>  
>      if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> +        reset_ill_vtype(env);
>          return 0;
>      }
>  
> @@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      }
>  
>      if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> +        reset_ill_vtype(env);
>          return 0;
>      }
>  
> -- 
> 2.52.0
> 

