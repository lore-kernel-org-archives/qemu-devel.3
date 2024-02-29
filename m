Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2366C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfd2B-0007LR-Mh; Thu, 29 Feb 2024 04:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfd27-0007L8-Lj
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:48:55 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfd25-0001FY-I1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:48:54 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5a0a19c9bb7so460365eaf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709200130; x=1709804930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OHdFkI4m87tQEp9MzSFNb/fULYSpHPD3AO4HHB1IFAU=;
 b=utjZ+YYUCZ8OQPOFcrRLs2CyJEA8F1vghYodXk686uVi/dmQQFky1GR85px9w++G2j
 In96LfD7Gu5fRGIWDuw5Rp/ZuUEdn9aFB8zOlHFY8ZwyGGDf1S6zO7guNUa7MP3IBLyl
 L72dA+e1sDfVlcPXMecOSNE0Fw18w/bGm2WNO4+TJhh89af0HpcSwoXHhkpK4hz+0QQ+
 LlbAt8kjk7ocaFLbd/7ekZEjmunTosXlzTly1hl/3J9tYm65JJBSwrqgCeHSgwp9jWi0
 8VRlZHzz6/x4SASRiLqj+SoTBOEXpV9EI85dN+JMlSRWTO6EvkP/fZV5ZV3WwNgK7ayO
 XkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709200130; x=1709804930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHdFkI4m87tQEp9MzSFNb/fULYSpHPD3AO4HHB1IFAU=;
 b=n0BUF7AmzM9lBZGNvAuDXe1vXHfTtFvAbNZFI/p7YJRdaowxicbDwm7IX7hCc6tyTL
 TA3sLtiySP9ueUmnHcfiEnBdRvRNVLh7RJntHK/33WNWuTUd4vKD0fjrIQ8VRUeSPp9+
 PgSOIKgbyHt6GisnQg+HXFtTgtTZXM7dSl32Y1Fh9aBEhAp8mKsfN3+F2okFwBWP67yQ
 +cEOxE3QtB5hAII9zL/vAoTxYLOHiyAI/FJ3NGXj/AGJQQWM8xXU8OW0tTMibvSOSj3w
 45/XHlN5FB0o0dIPuDJ2IPrMeJmeeERWqZhpthXw8qNFfgxG+xezo22QxVJ1R0l7rh0n
 NvWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5f79GUFmsx4zkfNSlr0WoZU6XnuKsiSNYlfOr1euIttr49uuqZ7R0kM/zQ9HINdMQUQy3RdC3aL/BhAfKJ1CjP0V6S+0=
X-Gm-Message-State: AOJu0YyKc31k7OMLBl5C+EWNm5rKi3zgvQs1Y8Tvu/ZxQbopGxYokD5m
 XFc3H/c2Y4xUnzJbNXql2U1nkYB2J+nP/FJ7tfb22G1YNeHNIgYtFemNZZusdr8=
X-Google-Smtp-Source: AGHT+IGtRjIhYUNquLssekrM2tWDO0yyz9ho5h4iRpjoKDqeJ74cnZM60RlMxC8BKNz/AX36k68jug==
X-Received: by 2002:a4a:9bcf:0:b0:5a0:573f:9b22 with SMTP id
 b15-20020a4a9bcf000000b005a0573f9b22mr1629310ook.7.1709200129967; 
 Thu, 29 Feb 2024 01:48:49 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a4a848a000000b0059f5da15e99sm205843oog.38.2024.02.29.01.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 01:48:49 -0800 (PST)
Message-ID: <cc19bbac-5557-439b-833c-643da6d22168@linaro.org>
Date: Thu, 29 Feb 2024 10:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] linux-user/x86_64: Handle the vsyscall page in
 open_self_maps_{2, 4}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com
References: <20240228202518.33180-1-richard.henderson@linaro.org>
 <20240228202518.33180-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240228202518.33180-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc35.google.com
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

On 28/2/24 21:25, Richard Henderson wrote:
> This is the only case in which we expect to have no host memory backing
> for a guest memory page, because in general linux user processes cannot
> map any pages in the top half of the 64-bit address space.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2170
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e384e14248..bc8c06522f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7994,6 +7994,10 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
>           path = "[heap]";
>       } else if (start == info->vdso) {
>           path = "[vdso]";
> +#ifdef TARGET_X86_64

Alternatively "#ifdef TARGET_VSYSCALL_PAGE" like in
i386_tr_translate_insn()?

> +    } else if (start == TARGET_VSYSCALL_PAGE) {
> +        path = "[vsyscall]";
> +#endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


