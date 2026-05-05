Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CBBCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKB25-0000Dl-O9; Tue, 05 May 2026 04:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKB22-000096-OL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:21:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKB20-0000VX-9H
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:21:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso54450665e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777969286; x=1778574086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSp0mLAgmSUyVbl9AWwZvDg9RFlWna0URbCEyUC8Jx8=;
 b=qHo4g5KcQ/6Cz1i5JxV1FP9Urv9Imn7U9YqbC0Ws97ybrHhAqEnnRS3Y7xwK8cyOZq
 P+MLhtyrBwtxv+KgSIt1VSIK6N7JfF/V47J6jPlTM0P5KLEeUHqvfAkfjMmqTkUPewgt
 MC/vmuESrLTwRNRy9SK/+gl5vSLpcdouJ1juU0S2eOfTXmDoq7v92zon6cMap1QW67qT
 8fn7V0eMRJAhyK8RmMUzCf/Tu9KV7M/zw2iyGpb+7+9CPkJ2AwEwjJH8tL7fzoLhcGGO
 6bhPK3PrvfpX6jh2+AePNhauqwPHAsCV96LpVsnBd40aSqOFR0faVmlnHGpX++KMJgyd
 1riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777969286; x=1778574086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSp0mLAgmSUyVbl9AWwZvDg9RFlWna0URbCEyUC8Jx8=;
 b=ArdNoDkfj7lnKLTWv5mxaWc+IOU9XvY3mABOpM4rVpT0OcIf4T0/Q3eX/0ejTos+Xu
 MtzPUcgnvtEvvtwWLUhvBnUepFmPUVLn/QTFiUBTTloodKerNbV7bX4GApM4rcJhpX+l
 NJgRU0TRSop9ZKDlxhe52R2fBK44XLL5jT/2gzokj0Wop1h9BCo07zgGixaYBm14p9Ed
 fhMuL5IzARiiRQD0S3Ji8V1AaPOZkZwzW/Ik9lY/5pE0I7bSs5F1NuIHo+XAVZ+5KAYZ
 LDXdZ7Ss9g4teLcajzV8IJnh2m8UV6fApJMjyRneFy0xuSBmUD+0KJajfKo5R+MTbFS0
 MwpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eJqdk7Z6w/pQNzDiUPwe1rZUBym7Q2A50P+n/O8dwhuKmzHoHGV/Ln0XD9Kyeuwh1VQqKmb6Vg0+4@nongnu.org
X-Gm-Message-State: AOJu0Yz2evw/IRP+nXO5qSzPSUQ6at/xU1wef0gCjAypjN4q+h7RiYjE
 q+l0gA2JZMuS2gBfKn3wRBVy2YBeqp5tuIqhh5Ya/VHbLAsU9MHyxKzcac2ZeMzaFWo=
X-Gm-Gg: AeBDies6rqMLW6SumMIKKKKKArNfBj/QfY4l1Z0QAjj8TWwuOdm2F4FKGJHmP6x9yWi
 IEqlgQjLM0OKCaZVqxDi4gCZP9EEidUsbxut5H2+JLaKJI/bpH68Ozek6OdzfBBIB1bJAoZktBL
 ygZRV6TzUgKn/S5SaKUXp66tiFuzjY58ZKOC2A9BDyVDc8omC/B7700rC40FydaPF1igVM7lwnx
 L3IghSCXHIqo6uZR9HHyLlErvLZGzbnGyQWH7tqSF18gJyzr5K9mCBUvJmvg4W5ZRbNo61K0VnN
 M/T3BZAETt9g+G34V/el0LVswJrApvg5D4O7F9kwKTKSsk8zFJwq4UARarxQHnjMSp0zcgn0B/R
 3xjCbKnHcU9oOB6yng7w5OlkPhcnO6w7Bhp3oILwOGoO7yylrdFkVLBWm4CrbQ46vo6IXebSo9w
 fvVaMSHBRQlSxKn9nJWWWNNBvARq+qYuHUd+DBrjeg9Wv1jIUC9PY89Ewc9v+o0YeuDr4dolc=
X-Received: by 2002:a05:600c:c096:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48d142331dcmr30467275e9.4.1777969285752; 
 Tue, 05 May 2026 01:21:25 -0700 (PDT)
Received: from [10.115.35.66] (95.170.88.92.rev.sfr.net. [92.88.170.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d149e8bdcsm13651085e9.1.2026.05.05.01.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 01:21:24 -0700 (PDT)
Message-ID: <16f9005a-c7f6-4e1d-8197-93acb2770559@linaro.org>
Date: Tue, 5 May 2026 10:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/48] fpu: Drop parts_round_to_int_normal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com
References: <20260429222445.26301-1-richard.henderson@linaro.org>
 <20260429222445.26301-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260429222445.26301-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/4/26 00:24, Richard Henderson wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 22 +++++++---------------
>   fpu/softfloat-parts.c.inc | 10 +++++-----
>   2 files changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 0a6bc6d580..1f03fcf687 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
>                     FloatParts128 *: parts128_##NAME, \
>                     FloatParts256 *: parts256_##NAME)
>   
> -static bool parts64_round_to_int_normal(FloatParts64 *a, FloatRoundMode rm,
> -                                        int scale, int frac_size);
> -static bool parts128_round_to_int_normal(FloatParts128 *a, FloatRoundMode r,
> -                                         int scale, int frac_size);
> -
> -#define parts_round_to_int_normal(A, R, C, F) \
> -    PARTS_GENERIC_64_128(round_to_int_normal, A)(A, R, C, F)
> -
>   static void parts64_round_to_int(FloatParts64 *a, FloatRoundMode rm,
>                                    int scale, float_status *s,
>                                    const FloatFmt *fmt);
> @@ -3365,7 +3357,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
>   
>       case float_class_normal:
>       case float_class_denormal:
> -        if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
> +        if (parts128_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
>               flags = float_flag_inexact;
>           }
>   
> @@ -3793,7 +3785,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
>   
>       case float_class_normal:
>       case float_class_denormal:
> -        if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
> +        if (parts128_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
>               flags = float_flag_inexact;
>               if (p.cls == float_class_zero) {
>                   r = int128_zero();
> @@ -5482,11 +5474,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
>            * of distinguishing partial quotients, so ignore the exception.
>            */
>           *n = *q;
> -        parts_round_to_int_normal(n,
> -                                  is_q_smallish ?
> -                                      final_quotient_rounding_mode :
> -                                      float_round_to_zero,
> -                                  0, fmt->frac_size);
> +        parts64_round_to_int_normal(n,
> +                                    is_q_smallish
> +                                    ? final_quotient_rounding_mode
> +                                    : float_round_to_zero,
> +                                    0, fmt->frac_size);

Coverity wonders whether we should check for inexact here (CID 1658038).

>   
>           /* Compute precise remainder */
>           r_precise_buf = *b;
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 6e1800b117..9b719ac5cf 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -1127,7 +1127,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
>    * according to the IEC/IEEE Standard for Binary Floating-Point
>    * Arithmetic.
>    *
> - * parts_round_to_int_normal is an internal helper function for
> + * partsN(round_to_int_normal) is an internal helper function for
>    * normal numbers only, returning true for inexact but not directly
>    * raising float_flag_inexact.
>    */
> @@ -1270,7 +1270,7 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
>           break;
>       case float_class_normal:
>       case float_class_denormal:
> -        if (parts_round_to_int_normal(a, rmode, scale, fmt->frac_size)) {
> +        if (partsN(round_to_int_normal)(a, rmode, scale, fmt->frac_size)) {
>               float_raise(float_flag_inexact, s);
>           }
>           break;
> @@ -1316,7 +1316,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
>       case float_class_normal:
>       case float_class_denormal:
>           /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
> -        if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
> +        if (partsN(round_to_int_normal)(p, rmode, scale, N - 2)) {
>               flags = float_flag_inexact;
>           }
>   
> @@ -1384,7 +1384,7 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
>       case float_class_normal:
>       case float_class_denormal:
>           /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
> -        if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
> +        if (partsN(round_to_int_normal)(p, rmode, scale, N - 2)) {
>               flags = float_flag_inexact;
>               if (p->cls == float_class_zero) {
>                   r = 0;
> @@ -1448,7 +1448,7 @@ static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
>       case float_class_normal:
>       case float_class_denormal:
>           /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
> -        if (parts_round_to_int_normal(p, rmode, 0, N - 2)) {
> +        if (partsN(round_to_int_normal)(p, rmode, 0, N - 2)) {
>               flags = float_flag_inexact;
>           }
>   


