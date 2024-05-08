Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02FFC25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eUt-0005GJ-AQ; Wed, 08 May 2024 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eUf-0005A6-PR
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:25:49 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eUb-0001WZ-6m
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:25:47 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59ce1e8609so124589966b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163943; x=1715768743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IQUGn/mB5g+k/cBb8VnnAxL1e7dRKQZocnuvyNoXaC4=;
 b=h7YH/f5lF6eZf/GacWY+G1NTjfllW8jggUzrxzxN56HpMTGbrd7mJWfF3QhAZ65NH9
 lbjw1dWKtBU1ZAGBVD44xjiOq6j2Q3EUSA8luRizU0w9QbsCRUP7Fx7FxdUeEJ3IO76E
 aSvZ/5XhCdPdIQFTaZWWXgjci/NLd/2+M4ulZNf6Zw71n0gwHSF43Mihfo2sWEMWCry+
 Ph3cj5fLz4zx9Hq5QXyw5ulKgPmAEowwMmyCk75MWnC8QeTIbzokTn89FDnCYaoO9gcG
 LolKxvWcgjY0k7MNK5rDw3nIvra0qnv/fSU1lK60+yXAQrr1ot9GpCtZuIEMsNCSoBXy
 noMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163943; x=1715768743;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQUGn/mB5g+k/cBb8VnnAxL1e7dRKQZocnuvyNoXaC4=;
 b=cBevFZB7KJBkHgcC4dQPBUlaVlzjyxdOcuZUepiwVFSNVtLGXSfbsm39SFGTD+6gTN
 FVKH3HoXVy5EeoRgldbH9Pwmr7EY2KyRwLJKYqzwc3ebGE1I2ytwObqFRqPfpkJBxOCp
 a/L40PRcyrQbYNwUsOH25uHAl7i0My2V6sJTD+hVmUvLrdLdKrISy+0BnyPjtvV+uuav
 pd4M9kn4OWsipgfLrEW0RQ0OCw1gG02z0GTH16Q9mPPZV+Hjorrt2tLZvyTDFi03IfI5
 hEQS22KyHUnux4lyPEIrAS4R8Rx8ZQkciu+KAgxw7OwLLYH3Sz3Rpxibw9BuKjlPJ0ED
 3hiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhaIH4z+tqcZ2bvTfuA79DGbjYY/iiIWexyuxBg2+oySSxFxYXFgrG/OaIR599nfnVhd5LFEt0JAaBvUbbJukYQ7pwmGE=
X-Gm-Message-State: AOJu0Yzw7s/bOc/aZ2M/yxubj4LjQZa7f2d7dAHfJdGEoRwBQzkcDmJd
 /Y2gF1Ic2JLKCiRTiZchqP94XeBqopoJ/Xp6gu1LsggllzALflIqL7wvw6+EMWk=
X-Google-Smtp-Source: AGHT+IFVkO4y6kHbVeQHnIamL90xz7OYklIeqOmHKjS8H6UtuwIJnUXQ6ZXJ4IHeRd2vIJkzOtq9xw==
X-Received: by 2002:a17:906:6852:b0:a59:92b0:e0d3 with SMTP id
 a640c23a62f3a-a59e4e86143mr410512766b.34.1715163943056; 
 Wed, 08 May 2024 03:25:43 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 jw24-20020a17090776b800b00a599b64c09dsm6152508ejc.128.2024.05.08.03.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:25:42 -0700 (PDT)
Message-ID: <230985c9-fbd1-4a12-aba2-a74ca7def167@linaro.org>
Date: Wed, 8 May 2024 12:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] contrib/vhost-user-*: use QEMU bswap helper
 functions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-7-sgarzare@redhat.com>
 <d69b52ef-d801-47b2-9095-4c830cc58386@linaro.org>
Content-Language: en-US
In-Reply-To: <d69b52ef-d801-47b2-9095-4c830cc58386@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 8/5/24 12:13, Philippe Mathieu-Daudé wrote:
> On 8/5/24 09:44, Stefano Garzarella wrote:
>> Let's replace the calls to le*toh() and htole*() with qemu/bswap.h
>> helpers to make the code more portable.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>   contrib/vhost-user-blk/vhost-user-blk.c |  9 +++++----
>>   contrib/vhost-user-input/main.c         | 16 ++++++++--------
>>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
> Thanks,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



