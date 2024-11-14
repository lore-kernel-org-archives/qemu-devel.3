Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE4AD68B29
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBaxY-0008Lt-DT; Thu, 14 Nov 2024 09:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBaxU-0008LJ-Ri
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:36:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBaxS-0005GQ-Ur
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:36:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cf7567f369so929084a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594989; x=1732199789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DCJJiXIBzUsncYN3q3FtbPCRu4Meq0TnfF39Y258hRg=;
 b=BsHLxY9WXCtRz483gYSk2wshhEwRiyU0vOoK+xSdTqzbibCf3wTK7PdLMoI5WRrVbc
 ox5wcYD52rdB+W65P5lrrgJt+lNXqAGBHyZpFjhR01EeODsZ4BSWLnxo9BS1wuBvIrI7
 37oP/Nvd668IR08ZJKiJ4f/hjvEGEqATjVdqFzjE0nejPaEfUhpkZexljZ08A9Ue+FD6
 3V/0bvPajImWVkJ/fGGu5cBq/xRvUjazJOrQlVJOP3zzDiUIxm0HzxdBva5gNZngBUHO
 dLSywPyW5PgE4sar3IpVNpR0QA9ZxsndRbANtNLhmxQnH5ARjdE6hot01UF4ATCzs2Ix
 V27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594989; x=1732199789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DCJJiXIBzUsncYN3q3FtbPCRu4Meq0TnfF39Y258hRg=;
 b=Mwkf9cZ1wYTw1o48laIm7xZFNl6KxIhgdTi8qCj0sKkWRlx+KQ/hCG80O8oPzYdUth
 cXUAEq+12mjHg8ydfr2eBV9ocowlAeEy+RPyjpi/KkevCn4jbv5f9CsFN03QXfCPyX+F
 oFo57qdtv9Cm4qEYnknX3rVxkMvZoK90qOIzPy3Y54fAfumvrn9FFdwoLwwYI6XZUNNl
 DE0NnrvQNZ8HLshKFWiz0nVrx7IW93x8Cvwnx1AAD8K99fgxh9VM40CH4KSYV7/2dEuD
 6KdxmxzuYDAViOmMcqekoASlCOHppoY06p1BG80h96AGjp7N3ijjQN7U/Xn/3FAw4C6o
 99MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+BaARtS1II3upBRxrCNLQb2Iz+sczAXilDTFdj/UFqJOYMFJOTkgTRo2h4TFmO46THiUghxM2QwHm@nongnu.org
X-Gm-Message-State: AOJu0YwMFLzTAmKop8GsiqXLhAIv/ArppVO7MVx5UwqpG3PanMWWliEX
 hboahLZJ9ucJTgnj9ng1O+1MNJPYxWUy0Kvgzi5Zheik91csjHP0BShNuMgMWSRTNsLxDJxG9zd
 S
X-Google-Smtp-Source: AGHT+IFsoU3AKTX21EhD+tTAoyK6SKP3m0HjWvOfP2Ogm/iQa53qvbZuBancIBU7KNUX4lyo4ExyLA==
X-Received: by 2002:a17:906:99c4:b0:a99:caf5:c897 with SMTP id
 a640c23a62f3a-aa1f805886emr673074566b.20.1731594989148; 
 Thu, 14 Nov 2024 06:36:29 -0800 (PST)
Received: from [192.168.69.174] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e043552sm69861766b.149.2024.11.14.06.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 06:36:28 -0800 (PST)
Message-ID: <177d6006-001d-4393-9996-8ceb9dd563b6@linaro.org>
Date: Thu, 14 Nov 2024 15:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: mark struct ip_header as QEMU_PACKED
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <ybendito@redhat.com>
References: <20241114141619.806652-1-peter.maydell@linaro.org>
 <20241114141619.806652-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114141619.806652-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 14/11/24 14:16, Peter Maydell wrote:
> The ip_header is not actually guaranteed to be aligned. We attempt to
> deal with this in some places such as net_checksum_calculate() by
> using stw_be_p and so on to access the fields, but this is not
> sufficient to be correct, because even accessing a byte member
> within an unaligned struct is undefined behaviour. The clang
> sanitizer will emit warnings like these if net_checksum_calculate()
> is called:
> 
>       Stopping network: ../../net/checksum.c:106:9: runtime error: member access within misaligned address 0x556aad9b502e for type 'struct ip_header', which requires 4 byte alignment
>      0x556aad9b502e: note: pointer points here
>       34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
>                   ^
>      SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:106:9 in
>      ../../net/checksum.c:106:9: runtime error: load of misaligned address 0x556aad9b502e for type 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
>      0x556aad9b502e: note: pointer points here
>       34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
>                   ^
> 
> Fix this by marking the ip_header struct as QEMU_PACKED, so that
> the compiler knows that it might be unaligned and will generate
> the right code for accessing fields.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/net/eth.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Should this series be tagged for qemu-stable@?

