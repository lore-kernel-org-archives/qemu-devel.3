Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11EAFCEE89
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDLb-0002H2-TX; Wed, 25 Feb 2026 06:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDLY-0002GO-OI
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:46:28 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDLX-0001HR-7N
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:46:28 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2ba6aa57d5fso6235777eec.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772019986; x=1772624786; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C6WyCjAtlGmGu/acpLfHrEcLGU1hYj0OCr+qPTyqCvE=;
 b=X6/gN/qDo/XpQNKCG95Gq9t4HBq1TbPeOObYF5TvApfyoQH59LK0H2MTm4CNTrRmKa
 IPmg8YXxADCZkk3R2qjXZuhxnI/sDNF84otDFEJReknOmd+CjIDRelMQ3S3xqK5pNBY7
 kFxEUydqmXjw0w4sk16yj9pZT6dbKh5li00EgCSCm6moFnyrgKlQrGBie+VnPZxZrt67
 eIeaWKEuuJLG8Ph8vmzJgHTVSO6zzeUQp04VDZiri/eogcnZtfAr+0QuS7WFcgWH25ob
 rZ8cIAxXtWeDhaTjBYV3QTHn2sX65b51G3FALCTv8ReL+VJjXQSXWDkl936YZ1bJtEQl
 sENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772019986; x=1772624786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6WyCjAtlGmGu/acpLfHrEcLGU1hYj0OCr+qPTyqCvE=;
 b=vGBpKSlP5xhWcLWl1o/6Qe8zCQPYRnRG+j4hLq6XK6hqBCrXdtAUys+k0S0mwegECi
 Ud4uH/+63kgpGlfYZkskiO8zbDftVyNXAHZMEMxqQmhpP3yafZGxfl9t1rDiMtDuljYr
 Y0+1M/s5D1W/mdkidnHEQ7hd/WydneLUTh4enhnzcNymOLKDOoV3VbPO59NwttCAt4VP
 4FTrxCaXHl7OVvxXfVybCAO+oZMvqFungBLxNPIAKDAgSezemgfvS1sA7v9LqtLINkyr
 CcGps6ru7qer52pkV43UVHtUrwnYfU4hkbKoHrDpkvJGPKVe6CLKPuCB2Yj5of6O5nOg
 6VYA==
X-Gm-Message-State: AOJu0YyIQjYEOlmO9wQ/+4MXj9oxEPvXjkQDV3Y5Y50wJaEOr1acLSN0
 ZVL9JK3Ar0GZqxGZ5Ez3j2DC52FjGy5efehzH/376Z7cSSn0x+eXK65S
X-Gm-Gg: ATEYQzz7HBrvwz5G6xDJtrCdF+irWaTicqatwcyPq9URFpV5U+gnFkImLvrqkFn9Md5
 yUG39xBu/UVRRrS7CRUd2bZ/pZvpHOYr2+009P1HBicPV1O0tdPCsUwOGHxksHL/QRwMIXbIBym
 AqcRZXUC9J5j68Sx/7Q2HsymDGhd3SfyYnGoZThUtTJ1OhIhK83BiarkyhudCBEhAn7bmVhCNYQ
 xwHIwI4z1nLODfX3z9x6W5xj31UC4UhItUlCPpdg7ls0HBqfJ4lnQcaVkSgJRZWUDbNyAYI/0Ia
 BEHxJkgTLKknbIbJxpwj6uLJ/4JgMLb4+VEpsjuz+fSVx0yYv8dO5QWseSWhiPlnIOJK5fgJJ9q
 3RwnV8RGPvks1epWWDHtpqFljbqGnNGra/K2S2GMoZViUtjbxFTL8oa4sXtn7QFIKeG4GpjUjpW
 PvWH9UFmZ8565y/YGBAWEX7y3kGOOy25ZDfSyx/oEkvhTr20EiSJYB7gYXJTVDSQEiUc91wi//I
 KmoY/9HPjALNOIWADgRlotsoXQb234=
X-Received: by 2002:a05:7300:7492:b0:2b8:26b8:3426 with SMTP id
 5a478bee46e88-2bdcbf66a0cmr63088eec.13.1772019985565; 
 Wed, 25 Feb 2026 03:46:25 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7da4775dsm8737761eec.2.2026.02.25.03.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:46:24 -0800 (PST)
Date: Wed, 25 Feb 2026 19:46:27 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Subject: Re: [PATCH 2/3] fpu: Fix unexpected exception flags when converting
 infinity to OCP E4M3
Message-ID: <aZ7hA6DkxaSRRbDK@ZEVORN-PC.localdomain>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-3-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225110802.1217946-3-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

On Wed, Feb 25, 2026 at 07:08:01PM +0800, Max Chou wrote:
> Infinity is a special case distinct from numeric overflow:
> - Numeric overflow: finite value exceeds format's max normal
>   -> overflow|inexact
> - Infinity conversion: input is already infinite
>   -> no flags
> 
> This commit fixes the unexpect exception flags by relocating the float
> exception flag update flow to be outside the uncanon_e4m3_overflow.
> And raising the overflow|inexact for numeric overflow in uncanon_normal.
> 
> Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  fpu/softfloat-parts.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index a738758aee..3c323c0cec 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -277,7 +277,6 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
>                                            const FloatFmt *fmt, bool saturate)
>  {
>      assert(N == 64);
> -    float_raise(float_flag_overflow | float_flag_inexact, s);
>      if (saturate) {
>          p->exp = fmt->exp_max;
>          p->frac_hi = E4M3_NORMAL_FRAC_MAX;
> @@ -388,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>                  if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
>                      partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
>                      exp = p->exp;
> +                    flags |= (float_flag_overflow | float_flag_inexact);
>                  }
>                  break;
>  
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

