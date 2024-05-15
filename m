Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33194C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ENS-0002Mo-Pt; Wed, 15 May 2024 09:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7ENR-0002Me-J5
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:09:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7ENM-0003jC-Mz
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:09:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so20848425e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715778535; x=1716383335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0wY6hjhf+TFAn+0X38/5PEmm473bMEKUDftovXcX3Ek=;
 b=KB8DPYgQ/m1LyEldx7o4NQiTzHhBdLQ5ZZg2wpNkTbI1OaFEaKS1LL+H9jAHmVi6ph
 M2RwijFvdG9FzBK/TIp4M0IftbQ7Ih0OpcpC5uxKBnLAbdrtxhV5ZClDxquJGoDucV9q
 g6OKeZAsit28w/87EKdc+5qM6zIzP+vQvPY8RgGX5oWUbhLnDrW/1vJcv8sS3Z1c8Wx1
 wDWk7DLRgb/hVMPFkj9VFRRdrg+SV/TJ5RHOr7GKsR4ftYIBoIhGAHziiG5Jx5G7RXWg
 lMags0T7vw/1SBGx6pUgrU0RZFVFLlSzYdmgGAtbbu++FguakXc+rpHKVqfldQBnNPEA
 Ht2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715778535; x=1716383335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wY6hjhf+TFAn+0X38/5PEmm473bMEKUDftovXcX3Ek=;
 b=hmqJzN8yOi1EdSXiYRDdN5M29CUaUWviBPrOk6XQ9APJiMlGddrpRdk8K+8ch0khms
 rkzQYzHxsVtskOwFwylCEi402dZMamcFt817A37tt4U0p0fRVs5MruTPWNGQB2pLUP0P
 KcGi6btkcY60nHVehZ5J3B4Cgo7oTc5SNReQCFzPAhpNUq9zgig0fwbjlpn5G9lxlBTV
 YXs2CJz5SAAAccBcsijNrW0x3zJ0bmE8K1jgZgZDjZMIPMmnCYp/Z/+vqWTD4s5ArZvF
 +iYZSe/aQhMaZP6disNHl6xhJjn1cxtXmQLi2MGHrBZ9a9VT5uJprooaUpaeQbI62VDy
 vNwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV24t2p3cjVbIxNn5GFyzt/I1blhZLKheNFnhIhjmjROnYBdImSccrUc/GGfzMMHL3a+HJvUerUlRRhiLPIEHV4dEXSs0g=
X-Gm-Message-State: AOJu0YxnReY8TEYdiNj0soz1igQGABmqgBRIIJKqHQ7+rrl0eLPhBjyU
 8w9g0JPgoTxBiVcXtR/nhM4g5NQFZzPvEeAi3QOK+0u2UOYUS8A2mI6bg08yq8o=
X-Google-Smtp-Source: AGHT+IGlsmgbQz3SUf/ygcRD12yXj9IdYGjCFFvPyIx56+rzPPUqF4myJG87zEJPcvcXKPB+TgSqKA==
X-Received: by 2002:a05:600c:46d3:b0:41b:da7b:9b94 with SMTP id
 5b1f17b1804b1-41fea93a341mr114384165e9.2.1715778534775; 
 Wed, 15 May 2024 06:08:54 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420193b0903sm95015265e9.47.2024.05.15.06.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:08:54 -0700 (PDT)
Message-ID: <74974fe2-3955-4962-9359-a4b40b8a0dd4@linaro.org>
Date: Wed, 15 May 2024 15:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] configure: Enable loongarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Song Gao <gaosong@loongson.cn>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 2f7c580..39275a2 100755
> --- a/configure
> +++ b/configure
> @@ -54,6 +54,8 @@ guess_arch() {
>           ARCH="arm"
>       elif check_define __i386__ || check_define __x86_64__ ; then
>           ARCH="i386"
> +    elif check_define __loongarch__ ; then
> +        ARCH="loongarch64"
>       elif check_define __m68k__ ; then
>           ARCH="m68k"
>       elif check_define __powerpc64__ ; then
> @@ -141,7 +143,7 @@ Some influential environment variables:
>                  prefixed with the given string.
>   
>     ARCH         force target architecture instead of trying to detect it.
> -               Valid values=[arm|aarch64|m68k|ppc64|ppc64le|s390x]
> +               Valid values=[arm|aarch64|loongarch64|m68k|ppc64|ppc64le|s390x]
>   
>     CC           C compiler command
>     CFLAGS       C compiler flags

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


