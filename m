Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C843C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmr1-000383-3Z; Wed, 07 Aug 2024 16:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbmqy-0002yt-5I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:01:48 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbmqw-0003RF-4x
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:01:47 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f189a2a841so1673911fa.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723060903; x=1723665703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQfe7b24ytV5b+TihytdQ0daRUhuQDyctLSVEw58RDM=;
 b=MNjPz+hrb7b7wgngOOHPahjv6ZOujLRkAzhqz9BpmcB/n8ImVvzne0WduZ6YQfeJYr
 j5IvcZKHlB4jqKoPzOksvTYY5WDa5174r2tRzb7WwWhQ1ABHVlsJnIO1b2bzbxs300nO
 1t7YIRMsiEpn/+tuP7Ibomy0v75iQrstND4+ok5tpq3dN4d5tLOw55VbVrhFtZSUvwHT
 R3y8ZK7/CFJ2Ofyev0pst8+0+SeS2Y9fVY5r+94y7ue6PwvXh0w0UMG+H5OMObnoKypn
 T0TkDir2sTacZR+RtXBc7DewWHF4JrZWEmhiInmAfG6EPfaCTs4rA7Fso7RjVn9+wZC/
 7zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060903; x=1723665703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tQfe7b24ytV5b+TihytdQ0daRUhuQDyctLSVEw58RDM=;
 b=AWuIZyaJkVWsuIgfrkCFkfunREEYK/ssHEzJDPcmU1ro9qbKUDF1uq9DjT0py21UdS
 WMwG/29FFgSpYiugfB2CvDICqvBSSj89s2A5JFGiPisYJp1CKBg1QpXv9tCItCfqwp2V
 7FFPudON6YMlmX7scB9G/T7XUIO8sHxsHLVWEsGtGodhsa8rxMJ9T/ZHSLC+LuS7M6S9
 4uNzzVsX5njmBVjiiUB2/SHWCxruVRCsLpgLQJXsh6EdUjsiQNZkxicSdo/uDym7xRok
 c/kKr1c1iNuWU0dc1eq4IePGBNZdCU4j3ebDSvsAOw/2nFD/0lbQReDHxjiWYD8r+v8F
 x9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLjwHVXxUytlItV9LV0ZVaEswyHX3drh+vVNIVqWXLEt5wM7h93Gnp8eqmDQ5GZMmRx1yx+XbQjzfh@nongnu.org
X-Gm-Message-State: AOJu0Yy+QzKFtw/88xXU0tJy4biowuqqODtQ4w//NPdE+DJtf8rsXC3j
 45MlRFpFd4jX3j0jg6tMWshjr1+VH6+KXFwoWjtxRvB8Buln4br0IlybBlhb8+c=
X-Google-Smtp-Source: AGHT+IGTKRKjxezjbRbA91FGCUoztmRY0eiFQ9IZN9mD7GRxB1QMcp36VZERTEf2nC3shTu1fpkVxg==
X-Received: by 2002:a05:651c:90:b0:2ef:29fd:8e65 with SMTP id
 38308e7fff4ca-2f15ab0bfb9mr119360651fa.39.1723060903260; 
 Wed, 07 Aug 2024 13:01:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c2f3sm16877832f8f.10.2024.08.07.13.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 13:01:42 -0700 (PDT)
Message-ID: <ad028c76-dd83-4795-85a4-cbd6b528a9b5@linaro.org>
Date: Wed, 7 Aug 2024 22:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
To: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, clg@kaod.org, peter.maydell@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alejandro,

On 7/8/24 21:51, Alejandro Zeise wrote:
> The goal of this patch series is to fix accumulative hashing support in the
> Aspeed HACE module. The issue that stemmed this patch was a failure to boot an
> OpenBMC image using the "ast2600-evb" machine. The U-boot
> 2019.04 loader failed to verify image hashes.


> Alejandro Zeise (15):
>    crypto: accumulative hashing API
>    crypto/hash-glib: Implement new hash API
>    crypto/hash-gcrypt: Implement new hash API
>    crypto/hash-gnutls: Implement new hash API
>    crypto/hash-nettle: Implement new hash API
>    crypto/hash-afalg: Implement new hash API
>    crypto/hash: Implement and use new hash API
>    tests/unit/test-crypto-hash: accumulative hashing
>    crypto/hash-glib: Remove old hash API functions
>    crypto/hash-gcrypt: Remove old hash API functions
>    crypto/hash-gnutls: Remove old hash API functions
>    crypto/hash-nettle: Remove old hash API functions
>    crypto/hash-afalg: Remove old hash API functions
>    crypto/hashpriv: Remove old hash API function
>    hw/misc/aspeed_hace: Fix SG Accumulative hashing

>   13 files changed, 753 insertions(+), 283 deletions(-)

Even without the unit test this is still more than 700 LoC,
which seems a huge patchset to merge while we are in freeze
period. Do you expect this to be in the next v9.1.0 release?

Regards,

Phil.


