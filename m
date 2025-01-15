Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB362C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 21:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYAkq-0001oB-Gb; Wed, 15 Jan 2025 16:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYAkn-0001nQ-7b
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 16:16:45 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYAkl-0005pw-EX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 16:16:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso1066905e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736975801; x=1737580601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zx9QfnzWkzTvP2Cj7/ewvpG3/Bq8aZFDwR7qcT6ksSo=;
 b=RkZbqGLgjurUG+Ke517GzXASk5PJXIm3NfWRqVO8I2q90QrXEXP2GCGI07Qn1BPHqn
 lFFL0aOSN2Lgucj4tZJT/A7z6URp6xSbeAJC+Xp0NMKzpwR1FGLsFrCpncwd1om8Qp34
 gUMIJ/RFKiWv8OxgFnL3FHrjKzXx1SX/OCmKW5isCSHdZeuBGzUROOmFM3xNM/r5Oky7
 4OjLd3Ec/HNfKph9dxv2DxyQjIJXebkwGSYJwM4AcZ44ygBGZJ1T+nf0ww7BLVjSjgWN
 HBmTPkBuzPes64DzyrocGjH6WTni30fiQ3W624w/bjao3wgySJFCETwglybxpdRPdcMo
 coRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736975801; x=1737580601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zx9QfnzWkzTvP2Cj7/ewvpG3/Bq8aZFDwR7qcT6ksSo=;
 b=u09n9PV5mH8wc1AAZX+tdj2VV2+EGJSK5GMRbCwdmNu2qlsY/XePLwAQ2qL90kRqTm
 kaWjkUyqt4V+kfi0N/JmM7ipPzrAtIJYzdNS51LyQhm0eWEdAvTIVRPQTGZC+PjhUUTo
 uNb1iwi3YPYuepGwVAstnFgWmosQpvbxNOHAV3vPUGiDxEMGvRT3SbPsE6p8zdkB2pLT
 qAEUoo2eYxsrNbIMD2oZ+RqYNsYWdyo4VCyqjolpPC4W1EjGo1z8/+PpfGsiwkbz9BZM
 4NyRAbk54mGNtKYXHbVJo+At1pZ0NLxohh2AdivpK62KskwUzmvGJu+dNHYJMGCWw+nN
 /2tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrs7MFUN3f2s1kCcvH5+2MMWLpnfYo4LdvtQhOqXvj1wpdLc33b6EdQcmspTVORPzDSh2f/zQ7SlAw@nongnu.org
X-Gm-Message-State: AOJu0YyzbrjnolXz02VWYjKmbJ4vrRla6QygnwKj9Bqe+lEDLuyN17no
 B5s0dJTUIs1pnGSaPTsvXGHh8Xb67psvR9+l95+nItmZ0v55eF/A0df6pHdWKO4=
X-Gm-Gg: ASbGnct8W5zqPcTansJS3nSD5X7+IRp664jB5jF+j+/37U/MboiO6HW3o8kfvw2TZeZ
 CxvH8E/F+dfjitOjf9bg/erYaIhQ/c+J6CjWtQDCxmHZibYdZfgkZLKbOWNT5puFb7osCBvCBBr
 i/vDTaMxIB11YrTu/iIejTbKvnnCUqOTN8OoJ2vzBjsmjCffzDMIBC9t3yBxmLiZ3sfOGMwtlM0
 TiylBij7JZpdr0CJL09qdE2yPBK1PFoQVF0lFvRr5Tz21XVMycGWb7ppBd84A4BjHIKtShKucQr
 7YHaVlzV5iMMrAV02AjdB2mR
X-Google-Smtp-Source: AGHT+IF21zxOyiybe11cVaSHkOFuUV44K6YgXRqVI4+/G5a/OGTQa3Ul/U3r35B5kFb9eR6SyzvMIg==
X-Received: by 2002:a05:6000:178a:b0:38a:4184:1529 with SMTP id
 ffacd0b85a97d-38a872d2aa5mr21216033f8f.12.1736975800812; 
 Wed, 15 Jan 2025 13:16:40 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38378csm18489494f8f.25.2025.01.15.13.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 13:16:40 -0800 (PST)
Message-ID: <8ce2bb26-b2c3-4665-bb1a-2576859aaaca@linaro.org>
Date: Wed, 15 Jan 2025 22:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/81] tcg: Add TCGOP_FLAGS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/1/25 08:59, Richard Henderson wrote:
> To be used by some integer operations instead of, or in addition to,
> a trailing constant argument.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 5d96cdfc30..e80b1f6efc 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -440,6 +440,7 @@ struct TCGOp {
>   #define TCGOP_CALLO(X)    (X)->param2
>   
>   #define TCGOP_TYPE(X)     (X)->param1
> +#define TCGOP_FLAGS(X)    (X)->param1

I skipped this because there was some code smell around I
couldn't figure. Hopefully a typo :)

>   #define TCGOP_VECE(X)     (X)->param2
>   
>   /* Make sure operands fit in the bitfields above.  */


