Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D02C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLEx-0007c0-Hs; Tue, 06 Aug 2024 10:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbLEv-0007Sb-2p
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:32:41 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbLEt-0006pa-FA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:32:40 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2689e7a941fso472976fac.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722954757; x=1723559557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9enE+N86rc0OMhWJaoc4qqt4Kajo85D6WLft29fW+w=;
 b=OTYkeNqjZPuJI3TImTeWLcyZ/kEmzdWSvr6QRvDs/W5u7zcKTRvOLpQEhQbhW+dEpP
 +/1hTQO/K1YhfojzS7WM818AbXIPn3k5ec/4b8H0fDTDHvdK182sznVoXhsLE3c4FNBU
 L7ABy6gaOG0ac4eLiYZVUj1Ac9nu0w3auWiF1gBhIi+RZFVERblpJ0xrvA5BqvnR8JCb
 kmnT7Lqv3lXLmkaS9eV7SJFIULczOcLg1xCINew0kz4DlFvd98aJoZ2jk383rhlvn+eh
 MQ76SKYqfmtTaawUbVLZ9OK2PScBkfkYWKZcW7MU4PLjY4imVSKG9lT8dLq0HfM6nl8u
 iBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722954757; x=1723559557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9enE+N86rc0OMhWJaoc4qqt4Kajo85D6WLft29fW+w=;
 b=UzUGWsa0A/Zxx9sdiKNFkB8fpta3XesKngFVmIePVozYHT5Zj5VP9BC68CW2mYbxJ/
 tctcaSZgaMhXHaA/xvFymatahJDNO4LzTKookRrHlilG+G2yjzKVOTlGEe0xwktlWvIz
 CO/w8IKH08UeQGIiUpYUiM+yseDtK7jkLygJGoCicTsyFedIlscgwCJPeVukWEeaN4HN
 J0p8LS5agIdRjd9NGqPzQWkAwUJW+Pfaicd3OwODGoppjNVCS7h+65cXNn45ynn9gcxC
 Nr0HP2LjbchOQex4iZJgaiEc0tYgsnkq76gD772U37uDxXsCybAseRAQY/FCy5g6Zwdt
 PC9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLj46RNzWU4KbnnPZe/FDN30yeCAU3U6KjB6LapUBw1Qr4a0t2ad2UIT3UAYbPhDmncxq82Xl+4pSvK8eWAnDpqWCDhS8=
X-Gm-Message-State: AOJu0YyGdqFcoJSqfPUVBP/0PrT8M+6BZs4K9gA3fyo4s/wucwPgHWRi
 TeRPQJyDSr6qYGde4KjungowH32n3TbBrCJWEz3w3Xg4VjGGBZHHzH9MbqJ1O+w=
X-Google-Smtp-Source: AGHT+IEwl3GvtR+Plyrg1iZO5BOabimwCsntzx61CAHmV3e1IXdBy5bZMvl1eT88RQOa+D007iXqeQ==
X-Received: by 2002:a05:6870:970c:b0:261:236c:2bb8 with SMTP id
 586e51a60fabf-26891d1f9ddmr20273734fac.12.1722954757525; 
 Tue, 06 Aug 2024 07:32:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7650aeb43sm6807689a12.66.2024.08.06.07.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 07:32:37 -0700 (PDT)
Message-ID: <a37ece8a-3fcf-476c-a943-d48b1ace0337@linaro.org>
Date: Wed, 7 Aug 2024 00:32:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1?] qapi/util: Include missing 'qapi/error.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
References: <20240806124138.90636-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806124138.90636-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 8/6/24 22:41, Philippe Mathieu-Daudé wrote:
> qapi_enum_parse() uses the Error type which is
> declared in "qapi/error.h". Include "qapi/error.h"
> in order to avoid:
> 
>    include/qapi/util.h:27:30: error: unknown type name 'Error'
>                      int def, Error **errp);
>                               ^
> 
> Note we include it after the QEnumLookup declaration
> to avoid:
> 
>    In file included from include/qapi/error.h:275:
>    qapi/qapi-types-error.h:30:14: error: unknown type name 'QEnumLookup'
>    extern const QEnumLookup QapiErrorClass_lookup;
>                 ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qapi/util.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index b8254247b8..568f31ac9e 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -22,6 +22,8 @@ typedef struct QEnumLookup {
>       const int size;
>   } QEnumLookup;
>   
> +#include "qapi/error.h"
> +
>   const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
>   int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
>                       int def, Error **errp);

Error is in qemu/typedefs.h, which is included from qemu/osdeps.h, which is always first.

There is should be no need for this patch.  Why do you think it is needed?


r~

