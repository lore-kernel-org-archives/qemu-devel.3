Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FBFFD45EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvM66-0000dA-FE; Wed, 25 Feb 2026 16:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvM62-0000cD-BP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:07:02 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvM60-0007Nf-Mz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:07:02 -0500
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8cb3dfb3461so5201785a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772053619; x=1772658419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZXlQ2dLvjMSsKM90KJPxBcZL5j6I5sE3kZ8dwp4joco=;
 b=YNcWWDM6dO+ovKT5ryjRKwKa6hyJdIR7/7ma/VINaDrGVRrlblTY9ekJUN8ZaMphr7
 V7j2Z9yRNE3+TFr+KGWVcbQOonFLO5Sp2diWmoL2j6LSIikMhFcrVjXYRfiVHGdk05sn
 fbUKxu1qEBUdmNMlsn93DwlaGqhIMFdYLttLusnUOoWyGoQdrXyaFBnPviP1Y9Ukj9Xw
 rGSABIjQehGVP7vxJhMM6h9v44kiOxLin/bidJ7HwVqDf9lMSOKqiwFkSLSUUQFKVCu3
 Ezp+bxobC4JahjtYYIIBy5TxksL6dHgSQBUV7MUhK/U0e8pgyM1p5s9WTAl8oOZFnR2v
 nSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053619; x=1772658419;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXlQ2dLvjMSsKM90KJPxBcZL5j6I5sE3kZ8dwp4joco=;
 b=J2EDzrgO7RHjm4kjeqWCMXRRFmKM3ohuzsA9bTeFgwrpOltlGYSQKVYyUdAGoPhU4w
 AYFT+MSZmPzrvYRLpA0qKJ6t1EbOCrYeVF9052affGAq7aEh8Ib1yk5JkeWffTmnYjBi
 mjAvTMDYYfM2nRXddH0qu29XYFYlKvIuhZ8N+I6r029jsbb/auRhVo5F8j/skziTA015
 I3rwPNZtXnWTjfAKzBp6xx8gn1XRKQCgbYCLkQ0CuNJipzK5Nm22xFyjIfqAnZfbF7+t
 YOH6akGSJYAluKz+TGzl1DKn7j/kLnT5l3WrfZae5zWd0DSEZaOH+Y3cW8ml8FaSK1fC
 biCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVIIX5/kJgwjLvdkH5H24XdYSGmxafndE7vILtVnk1ttPv4JHBppo/3s5o7w9CcehTiWDVOFP+RTMJ@nongnu.org
X-Gm-Message-State: AOJu0Ywrfts6M29zr/JKK6waHgP/lfqZQ9eQJP/PRMsw9ovZxzVgTmU/
 HDOPfyMHBJU0impZVajzn4Ffbxuop/sBSckxu+7RSSlkCQYgj1uzfwVUsU/jNMsTThg=
X-Gm-Gg: ATEYQzzQSY2E4SXGLtyh99ZzeQ7+ywgfLUSg0hF0rLOueaOMHcKu+9hH0mOKo4t5l1E
 frV2HK1OnsVLnlvOjoOuhXypVPgxbqfOMyP8R6wyO81nD8bTuD6uPn58D7BWTvFvvxRW2bETdWf
 UJ/WmmgMQnKx8zt2CStmf/LUmmQSxYUgddyujQiSqJlGcEEGTu0LVlVYElYHtoDeH7G3WUmUbeA
 44rnboQMu+/Vlek3nc2tW70nLYuueAkhQC06eHuyaEwsiZOs7XA7qEuZrb/y207SQ9g4EUGac20
 74xLwp+8LdBTUhQES2rejkfRL0HxqNSHbJHWOUGs7qxl64XmOwWpWcfJCYuqkYF2YfZmkpWRySS
 G020QA/sJIjzPX6iyjknzo6HJ3vgUmosxoqUy/zTw9Lxkn3ZLvmIDzj4rKPNw4rlPD6319AZ2qF
 xdhZS/MbIIN3+mCDYhoRrU93fNU9wRjTW4OKxnHr93SM5pHdY=
X-Received: by 2002:a05:620a:44d2:b0:8cb:4f63:dac9 with SMTP id
 af79cd13be357-8cb8c9cdc4bmr2386208285a.17.1772053619241; 
 Wed, 25 Feb 2026 13:06:59 -0800 (PST)
Received: from [10.34.149.227] ([172.56.178.189])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66f325sm26634985a.16.2026.02.25.13.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:06:58 -0800 (PST)
Message-ID: <bd43a2b1-2e79-4238-8d11-8f58de1c189e@linaro.org>
Date: Thu, 26 Feb 2026 08:06:48 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fpu: Simplify OCP FP8 E4M3 NaN classification in
 parts_canonicalize
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-4-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225110802.1217946-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x742.google.com
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

On 2/25/26 22:08, Max Chou wrote:
> The OCP FP8 E4M3 format has only a single NaN encoding (0x7F/0xFF),
> Replace the indirect check via parts_is_snan_frac with a direct
> check of no_signaling_nans to make the intent clearer.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   fpu/softfloat-parts.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 3c323c0cec..5ef7e2d921 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -245,8 +245,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
>           case float_expmax_e4m3:
>               if (p->frac_hi == 0b111) {
>                   frac_shl(p, fmt->frac_shift);
> -                p->cls = (parts_is_snan_frac(p->frac_hi, status)
> -                          ? float_class_snan : float_class_qnan);
> +                p->cls = no_signaling_nans(status) ? float_class_qnan :
> +                                                     float_class_snan;
>                   return;
>               }
>               /* otherwise normal */

But parts_is_snan_frac also checks snan_bit_is_one.


r~

