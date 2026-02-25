Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E435FCEE91
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDPG-0003w5-Vw; Wed, 25 Feb 2026 06:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDPE-0003v8-1S
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:50:16 -0500
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDPC-0001af-Kn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:50:15 -0500
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2bdc47747e2so413824eec.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772020213; x=1772625013; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sEcvzxw/uz8PQh34AUUfifGHSbnXeDwmW0UJ8qMSa+E=;
 b=T1hK8iIb7SBj7b+u9tTjZy7Irmcpf2J2zEFha2/koB0Z5UvQoL3eccanPz37KjG+KP
 jqNfvSZbnPJxHa3FvDuXqejR6h5Clsa7HCNtWarQi4rQjo5uFcgrxk6BHaglyJPj7PYG
 z8gVq6SDSj8LEtiadQIgCIhDTIPxgWX7nsUt5e3mqUB1ltynP4+bI+cUxTwVQmfQRetf
 1NO66+thIqNBiHeXqAVzoe6xs3RcnPBBEXtV05MGhdPVLzU8uKArDlW1Ba/M31aYzdm4
 jsARVcozMKvKmfBPBLp3Q0ijBvcSxOEWex0nj3O//J4BE4pbUvd669eT9pwNySVco1F+
 cgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772020213; x=1772625013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEcvzxw/uz8PQh34AUUfifGHSbnXeDwmW0UJ8qMSa+E=;
 b=X3zoz6XJWrj0sSTK1QZlpu+HC8xsNx++Yi6FS0jY7QcWNTqhMN2twdC/55LJyP9gjF
 feJ0HSBeV7OtXNz3T6T/itoqS8m7c9CkrQvJaDTmWUPucwl/3C7vVCS9/ecPpVDdQJSo
 sm+V9Y5m8ZC/jQcjCyJq3CmKZVkOA4FwYIMDg1KA6Cy7mC2HuFpwm1Bl2SUQkXJVDmnc
 N4iil1NUvgT5sWlQQrryM7NCxn5C0BxvzIvZSCC8I/lo43HQQNc/u66FJVHMg9XdyDBg
 apY1mlpPlFf5xmdKmW8V6byrUYNEfviMhRrpKyeJXNlSzUfqZfg9yIcPA8tpaeyTBLGP
 HNeQ==
X-Gm-Message-State: AOJu0YwC58yC1TV3cEChw5vQc4Lo1u4vKm4pNAyg1u9Z7AsFqcWl5Le1
 X/yeyra6MwMr03Ss1xvp6seDF4GLdfJZHazSd/9UW+qQfHcPRPRbYLT/
X-Gm-Gg: ATEYQzx6kJz/D1vmaACJBFRogH/gfwoV+efcGQvW7RwvSdsMH9xNrCQi2VqA6DqVN9s
 iZ/1Wys4if0d4yHaYNgXSWKpywQxh8kue2pOg2Mlds8sDNNbsODhWhnALWAsgBcXm4X6SQ3KDk9
 /G53TaChjKSTdww9MxVLFc4X0yiIjDRQydpkO6wSWOIhy4RGq19a5k1zWHAou+Ncwprsr3GKElY
 5TDIZD6nkQcyMEw5Z1y74HE0cRMz7cVj1P66FHi6MuEPJ9xrClJBh/VaxrFFG18MbVO+6EFowUL
 x7R1hHx9pkMk9UEy9Ions/FxsQZSVOG92e6NxJx1GPb8Pb9n1wp+Eu4rcVZvorurc32/6/d2y90
 pvYiaSRwiI59jXMxRoFocP07ZRTu8pS0XomiRep+SH+JiY0DWDQikl5Ke9Odva6/4FBM4kpBKKq
 o9X5kkOLmC+4WDcDyswY7ruHbNV0PWaRzMqt+UatbVM0mizsa1fTJGNfL22DNm2JRkTCTzcf6yW
 HH9gyxOSAscJpwj8VOjMssPvdCRokQ=
X-Received: by 2002:a05:7300:5727:b0:2ba:9045:28e2 with SMTP id
 5a478bee46e88-2bdcbf67b52mr68452eec.13.1772020212961; 
 Wed, 25 Feb 2026 03:50:12 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7da4775dsm8743820eec.2.2026.02.25.03.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:50:12 -0800 (PST)
Date: Wed, 25 Feb 2026 19:50:16 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Subject: Re: [PATCH 1/3] fpu: Fix repacking issues in the uncanonical step
 for E4M3 overflow
Message-ID: <aZ7h5etAsW66seiZ@ZEVORN-PC.localdomain>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-2-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225110802.1217946-2-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Wed, Feb 25, 2026 at 07:08:00PM +0800, Max Chou wrote:
> In the uncanonical step, the input FloatParts will be repacked to the
> target FloatFmt. This commit fixes following issues after calling
> uncanon_e4m3_overflow in the uncanon/uncanon_normal functions.
> 
> - Add the local exp update after calling uncanon_e4m3_overflow in the
>   parts_uncanon_normal function.
> - Add the fraction shift after calling uncanon_e4m3_overflow in the
>   parts_uncanon function.
> 
> Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  fpu/softfloat-parts.c.inc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 61b07307bf..a738758aee 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -387,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>              case float_expmax_e4m3:
>                  if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
>                      partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
> +                    exp = p->exp;
>                  }
>                  break;
>  
> @@ -496,6 +497,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>                  break;
>              case float_expmax_e4m3:
>                  partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
> +                frac_shr(p, fmt->frac_shift);
>                  break;
>              case float_expmax_normal:
>              default:
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

