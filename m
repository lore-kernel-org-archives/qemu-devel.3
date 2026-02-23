Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8597EA4FAE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuU7V-0008Ui-Vq; Mon, 23 Feb 2026 06:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuU7R-0008Tk-5j
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:28:53 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuU7P-0000wT-E0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:28:52 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1275750cf9cso3391814c88.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 03:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771846130; x=1772450930; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3N5y0O6SZJdGXwK0Tt3gMaNOkZ3hwe3A185OO8wRXgs=;
 b=JFIdIhgFEvyJOf+xbxMCabU8Za9wqbf0jqarcxj6heWdov8xc4V9QV8Fzr5RkbKQ30
 6PgGK2Gg/sQ5wrBF5b5NitGLMP13x/U/JhaETfZ9vIZamNKNmYau2sYC/p5fysGONO2i
 klRa0xszRfVN2yHy1wwzk6TIlXG8iGYaplqfdX5NsBeLHeH0e7XiWSBuWp+0px0Vq5qK
 iR3DiFBEQFKTSXp+GvfRalsUTAhfhf4QdlGCsSnCtI7/oT/jnzNaZmGKwnJCNGW2xQQ5
 qhCTUKIpdND10bCPXhENkocGV51T63FqUoktRgxY1PyWwkG1HbN1eooiPugmQ2rZRfJQ
 dSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771846130; x=1772450930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3N5y0O6SZJdGXwK0Tt3gMaNOkZ3hwe3A185OO8wRXgs=;
 b=syMyAhO7HbEClfWDynTasAcIo8csNgoSdVWqhnMOf+QZkVpjeFENlSn9BJz84L0+NB
 pJsboje//GlCcAO4rUQpgAf3Nu2ArwbnBVXZwLa7g2w5XBb4nHU70tlPmZUg/Je5EOKR
 rCmFJ7oL8MeXah1Z89uWCELEiQWR26Lnz+2A6FgtjZk1Y0VInDRfuvgHdeg4C97eIFFb
 SgAGHyx557rKBtT0x5KwJmK68Ikc7yO10ub+M0888csQemrZp7JNw3QWNJN7C0HRCSIl
 +/k5PtiyNddD/VI9QJTOpQ+9kQb/nol6A1xxH2rJS6EHtk+oubMqU3LnAYPk7A3V9Kil
 Bibw==
X-Gm-Message-State: AOJu0YyXSQW0Zbnbf6b6seVo1c9NXIqSb5Fr52W/4nZcXeMJabywLFfK
 uEzch5SST+9IrIhvva2fGgXbn79p2w5HDfnI0Zwzj+ixnmSMPthoRFUy
X-Gm-Gg: AZuq6aI5cQ6+WENEMy0faeWYzVYPQYTv/+ljqsTmJUprqj8B4I6mExgLFg5Z5cPCPIZ
 9r33kPhGbsR7B8BwwAXGdrg9A9auBtrehzLfEh63a+JMvuErohlbPWdLOlAgT6W1J7+lCmKXDrD
 /MBGrF2m+fvJ6XphG9riOL04laqclvOCJSkmdOpHmOcXHW68KZQ5iZcMvsWbZIyv/chqovk+vhc
 vnYDBYbyBuJLtlAmhKMasbw/QFZ3TrwgiUO5MRx6JW1bmvZRocd6zoUGlB7n6vM0qMIwPWEsNqm
 ELh0djMskfZcW0J1BjFYk9WTKVBQKOeAjcHJcyhvnC+MheYPc9CeGxRJ2rflWuYDhQGwd2JUi2L
 nZCVjfW6noJYkQmrKpqAGRz5NVdFnzky8ttfLsgvscyQKEPdUq5o+YwwGTHAA9bzb/ORLjPChGQ
 OtoXxUeBGssl8mNm7WR04mt/kMi+XAeItGZouXAD4qnTToeRSTO+a7P9gU+WNPM3ATad5f/e43L
 7F2k3m47YDHW729jKbb22gBLUIjyGs=
X-Received: by 2002:a05:7022:603:b0:119:e56c:18ae with SMTP id
 a92af1059eb24-1276ad182a5mr3257191c88.22.1771846129897; 
 Mon, 23 Feb 2026 03:28:49 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af7b4c7sm7649536c88.9.2026.02.23.03.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 03:28:49 -0800 (PST)
Date: Mon, 23 Feb 2026 19:28:00 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v5 9/9] fpu: Add conversion routines for OCP FP4 E2M1
Message-ID: <aZw5sjJBIIT4oDCr@ZEVORN-PC.localdomain>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
 <20260223082154.5623-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223082154.5623-10-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
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

On Mon, Feb 23, 2026 at 07:21:54PM +1100, Richard Henderson wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [rth: Update for exp_max_kind]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat-types.h |  1 +
>  include/fpu/softfloat.h       |  4 +++-
>  fpu/softfloat.c               | 26 ++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 9c84a101e5..ead146c22d 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -122,6 +122,7 @@ typedef uint16_t bfloat16;
>  /*
>   * Open Compute Project (OCP) Microscaling Formats
>   */
> +typedef uint8_t float4_e2m1;
>  typedef uint8_t float8_e4m3;
>  typedef uint8_t float8_e5m2;
>  
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 31d3f76d3f..8389a07b04 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -190,9 +190,11 @@ float128 uint64_to_float128(uint64_t, float_status *status);
>  float128 uint128_to_float128(Int128, float_status *status);
>  
>  /*----------------------------------------------------------------------------
> -| OCP FP8 conversion routines.
> +| OCP FP{4,8} conversion routines.
>  *----------------------------------------------------------------------------*/
>  
> +float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
> +
>  bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
>  float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool sat, float_status *status);
>  float8_e4m3 float32_to_float8_e4m3(float32, bool sat, float_status *status);
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 6e21882ab2..91c34307c8 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -574,6 +574,11 @@ typedef struct {
>      .frac_shift     = (-F - 1) & 63,                    \
>      .round_mask     = (1ull << ((-F - 1) & 63)) - 1
>  
> +static const FloatFmt float4_e2m1_params = {
> +    FLOAT_PARAMS(2, 1),
> +    .exp_max_kind = float_expmax_normal,
> +};
> +
>  static const FloatFmt float8_e4m3_params = {
>      FLOAT_PARAMS(4, 3),
>      .exp_max_kind = float_expmax_e4m3
> @@ -641,6 +646,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
>      };
>  }
>  
> +static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
> +{
> +    unpack_raw64(p, &float4_e2m1_params, f);
> +}
> +
>  static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
>  {
>      unpack_raw64(p, &float8_e4m3_params, f);
> @@ -1709,6 +1719,13 @@ static const uint16_t rsqrt_tab[128] = {
>   * Pack/unpack routines with a specific FloatFmt.
>   */
>  
> +static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
> +                                         float_status *s)
> +{
> +    float4_e2m1_unpack_raw(p, f);
> +    parts_canonicalize(p, s, &float4_e2m1_params);
> +}
> +
>  static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
>                                           float_status *s)
>  {
> @@ -2929,6 +2946,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
>      }
>  }
>  
> +float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
> +{
> +    FloatParts64 p;
> +
> +    float4_e2m1_unpack_canonical(&p, a, s);
> +    parts_float_to_float(&p, s);
> +    return float8_e4m3_round_pack_canonical(&p, s, false);
> +}
> +
>  bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
>  {
>      FloatParts64 p;
> -- 
> 2.43.0
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

