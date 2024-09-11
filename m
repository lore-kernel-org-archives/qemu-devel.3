Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733ADEE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCIK-0000zB-UM; Tue, 10 Sep 2024 21:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCIK-0000yg-Bu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:37:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCII-0004qB-S4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:37:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2057c6c57b5so2175265ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726018637; x=1726623437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPVgihqH5yXl8T84RG35QI3I/qy7UxIKd+F1sSitLEY=;
 b=c5910NJ3KGzYEyZ5790LFlj0tjrb9WliIcKSefUi9/6apPJOjL+xUOcnMNdHdYW3NR
 M/4hl+tMR5oR39YThvzN1Xmpuh1CM3SJ29T1qfOjy+sP+bBYpahMvEbYUiuerSi3z0S+
 zrsUnweW7XRUMXpKT/3AdnPdAJ5HZdbEIkWJQivq+3sntTdRE58I3u3apyWjzQzAkJqc
 FATG+Qk8EGN/nOPXIT1o+z10jvuxu0uoQGaDcDkSH2+9jRrHVRSpkbTVU6QsQYWXZSLJ
 MWD7jxSnehe93AgK7y834xq3apNGICix3fnKbQ+3OeQ0qBysB2+TrWe9hJfrkQ4sWGYA
 /Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726018637; x=1726623437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPVgihqH5yXl8T84RG35QI3I/qy7UxIKd+F1sSitLEY=;
 b=FuiXgtV+pMnvw88DrLogMMOQq6WAJZpS7nEE+XokxWNzmvumXOzyskuiHgNQ8OqfHs
 PAtSYLkDco06faAquSTLujbpLh1oTSVRgZKwAd5+EUzZVbdKUFTEghkz+qHcISDw+BQW
 oaJ0A+zCqM/JkS3DHLm9clQU8b+lTSree43aDWKwrz2RnyL6pGyY4dfopTNID3yImTyt
 fhOot7kc3tlcb7gUg/q1huHS8XTlTGeLa8WnTAmWSKflfEhBRGXNQeZnuLnsEGDkeIng
 wD1a3gx7zQHQnVbGV3F7fgxOMoXdKhgrTFQHMVi5SJEKYXxYeSEcmmV802xrwslcXIiz
 DXwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNtnhS6NWeIV3CvfRGOrKqFwZNdRTBxnqvKbEcFXzd3EAkEv7PpgnoZOobe8yRqNVFqnatdYWnZvRf@nongnu.org
X-Gm-Message-State: AOJu0YwEn4tfTzX3TcsOxg/BazyQDRfKQVrtnpal/W+ennFV7MRf4YT+
 PD2jS+Vrz1y6FhpklOpRLZ2iSyaGU3b2rUTTUWlkVVhTRe008IY2h4c4tWtayWjfXI5lAEAQlNg
 3
X-Google-Smtp-Source: AGHT+IF/FPEOnnqYbJaPhhUc8aaHNqrmiReMVlZQfU0AfA4elX/UJHXc8BKHZalzFaSjuZW9d2Q1pQ==
X-Received: by 2002:a17:903:11d0:b0:205:656d:5f46 with SMTP id
 d9443c01a7336-2074c79f8d9mr37613465ad.28.1726018637386; 
 Tue, 10 Sep 2024 18:37:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710ee70bbsm54076005ad.151.2024.09.10.18.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 18:37:16 -0700 (PDT)
Message-ID: <2d7ae6cd-6454-4f44-beb5-1a57eb47fb19@linaro.org>
Date: Tue, 10 Sep 2024 18:37:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/39] hw/acpi: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/acpi/aml-build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe3..006c506a375 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -534,7 +534,7 @@ void aml_append(Aml *parent_ctx, Aml *child)
>       case AML_NO_OPCODE:
>           break;
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>           break;
>       }
>       build_append_array(parent_ctx->buf, buf);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

