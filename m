Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0B8CF043C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNgK-0005Qk-2m; Tue, 08 Oct 2024 23:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syNgI-0005QP-Gj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:48:10 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syNgG-0007Qx-Vg
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:48:10 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5e98a16e81dso27763eaf.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728445687; x=1729050487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJOFNzATeBHoGeg1xV77Hj0/vC2Ij8uz3QrdjssuV6I=;
 b=uK03PjZ8buYXTmVrxGsh13pRbRWCh5Mk/NW4iO7iS3lRdrGaOAJZnwOMCEuTM5yLYk
 6gnMiRJS4l4g1rnD9NODWAXOxSq3kfuacVKn3qRiIT3haSXZsvoALK1SuES8KO7aNZcz
 M6fcY2WmpNJ2aXYWtt47JK8F0e6ZfsfbHnaF7Z0DWUynWHBFgcs7RVYVjpSfx2Tpttwc
 e1+VFV/G36N+TkKM0YZqZhE1S2AZPlIa1g0Vtc0BCu66hXijaTEuzyZuXi6ZcAUvjK0t
 wh7td+zmZNWCsAdwU4029jH95u5/7JWZy9eVo6vsXjaQEM/oFySDVyFfk1MS4x/fq7Pp
 dzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728445687; x=1729050487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJOFNzATeBHoGeg1xV77Hj0/vC2Ij8uz3QrdjssuV6I=;
 b=Bb0zbJg45VBlDAXSNsbAZqjzy13AWQb2cKzr+fPOoSEbRzHMKER3m2llLggNWivGv3
 3ZiyvK0n1O5UxEh085xtjtZ8y6vxtM4PsQb/5/QDDLvcmTAsELr6KLFvvuEKyOggg2+K
 9Us1AJRxUKhClTZaHOpUNMVD4Oez60fiVFVe8FrYYZB/wpyuKLM6OEONPIg3DiGisIs9
 8gwXlDuc/uqIsCpo+XvcpTqFG6c5Bz2A/gVfOpHn1TYszAJffimkRbljmgYlp96iV17P
 sGGrWDp7o2pVLJF6L5aKbToyEU0/Rcu3+1Ia8UtkDekQkyLSPfZu4Gd+O+rag3pSfvHI
 AU0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUir2uNkdQSodpJ36saXm5grI0g763RK6HBZs2aQUfnRESZegcJcMFzuCeoFHTS9O1/uol+Ny7LDsbj@nongnu.org
X-Gm-Message-State: AOJu0Yxd8CVgKlF7wO+Ygf/5sf+/R44Qmh1QRcop8p1YgwWqvRvV4rOC
 ZBqLM+s3pdCDnWWO0Z18bvCL+eSdmMpdUy5//sPBJi78F1Z6ndBRaqNuZobPOgM=
X-Google-Smtp-Source: AGHT+IF6DSn8rUYGWnr7sLm2ynxCDf7G++T27WlkTOJ4HY3v1luIdsUNZE5TwIsI0ovIVEpT4QjY3Q==
X-Received: by 2002:a05:6871:582a:b0:278:3de:c8de with SMTP id
 586e51a60fabf-288343c7eb6mr847212fac.24.1728445687341; 
 Tue, 08 Oct 2024 20:48:07 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c33d0dsm6407416a12.63.2024.10.08.20.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 20:48:06 -0700 (PDT)
Message-ID: <6bb33897-348e-4a0d-9027-2c86bef2ce3a@linaro.org>
Date: Wed, 9 Oct 2024 00:48:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Use probe_access_full_mmu in ptw_translate
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20241009002029.317490-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241009002029.317490-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc2c.google.com
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

On 8/10/24 21:20, Richard Henderson wrote:
> The probe_access_full_mmu function was designed for this purpose,
> and does not report the memory operation event to plugins.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 8fb05b1f53..8f4dc08535 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -62,12 +62,11 @@ typedef struct PTETranslate {
>   
>   static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)

We can remove the @ra argument; maybe clearer to do it in a
separate commit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


