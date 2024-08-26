Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE4FC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicEk-0001P2-7r; Mon, 26 Aug 2024 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicEj-0001O4-51
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:06:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicEh-0008Iz-Gk
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:06:32 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a86883231b4so578933566b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724688390; x=1725293190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JRwp4nVWmeUtaqyOI1hSymUTISsZW+rEZvibJ0so6s=;
 b=Hbe7CzWoENp9EPo7DOx0C+AHmxL0RRUa4e08RwVT/zNkbHWGQlBnADXAiLg4nohenA
 yY/ZVEx6loi9844LMsRPOWwIuMF8aFswh1JjIAli32yo/vagLOeBq6l2IZuLUS1qP6/s
 RXluQJSDetv39M9gLaKCI92D51QAepCxjsk9iJd6DGpUKReqMiAtOs0HyIGcOfTbXFJJ
 rpujhvKb7qj3u0b48njq84yYFdVZ8QQ8FHC99WlYfTIkpOVAL188S96fYjArzIiS1I+w
 gSsczPYK5a6GkinosKWKOvs4AKIQHQGZS90YmA36mlCRqY579bmFi/r4I1XViytD0OAw
 NX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688390; x=1725293190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JRwp4nVWmeUtaqyOI1hSymUTISsZW+rEZvibJ0so6s=;
 b=s6Eh7jgprMSs4A4UcyQHlg6RpTQc3KE4EJxOAYug0y17FQPoYCN2+LYLhIqc7lbbDv
 ThHj3F4WRF060S0l+sFLcRXDw/S7x4wueeYKyT2u2TF/L5ebOu6l3LLPXFkTaXB8ySYu
 k5jyWHzCI6w2glg9hoAce9437LlYO9iWYyTsRpVNe1wKrblQFB4ysy9A7eKNqE5uZhS5
 qj/Y/DwhuDLOxR4wjsGGpVkPnNRV0n5pe6osQyAQUsdhzL58lK8BOfJUf1fWvcej5h8e
 SSXSKk8+45uQg8yGnpoPR0aKq+T1Z/kDDYey+yUmoBHcaVLYhvaakHGiAr231kKOc933
 OA/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8vynvPqX9ww/u0RJMAE3zliC4YJ75pT0PGQjg6DfHyNZaIazATU4axOUsMgyYwSS3aPxcCEK8izmL@nongnu.org
X-Gm-Message-State: AOJu0YzutD+ZTkEElcHlvS6X7qV7di+1KtHn+9yTXn3PXp7PFHbRQ7kn
 gbJSG52D3QR9bynFCrWwUZZWR6NhCWxs9vB3EQTQdNVrz9xtTsezpmSiOnXUQRo=
X-Google-Smtp-Source: AGHT+IGDJPj5v7IeMQF9mFKN2giO61AzEuzi1dz6wLxPYiC2LaEdYoTHQYvRvF8mGWhnLleEtuu+Ew==
X-Received: by 2002:a17:907:6d07:b0:a86:7514:e646 with SMTP id
 a640c23a62f3a-a86a54d1473mr732956066b.42.1724688389490; 
 Mon, 26 Aug 2024 09:06:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f436390sm680557266b.127.2024.08.26.09.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:06:29 -0700 (PDT)
Message-ID: <45907a7a-0777-4031-9682-963145c2ae49@linaro.org>
Date: Mon, 26 Aug 2024 18:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 07/10] hw: Define new
 device_class_set_legacy_reset()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813165250.2717650-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 13/8/24 18:52, Peter Maydell wrote:
> Define a device_class_set_legacy_reset() function which
> sets the DeviceClass::reset field. This serves two purposes:
>   * it makes it clearer to the person writing code that
>     DeviceClass::reset is now legacy and they should look for
>     the new alternative (which is Resettable)
>   * it makes it easier to rename the reset field (which in turn
>     makes it easier to find places that call it)
> 
> The Coccinelle script can be used to automatically convert code that
> was doing an open-coded assignment to DeviceClass::reset to call
> device_class_set_legacy_reset() instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coccinelle/device-reset.cocci | 30 +++++++++++++++++++++++++++
>   include/hw/qdev-core.h                | 13 ++++++++++++
>   hw/core/qdev.c                        |  5 +++++
>   3 files changed, 48 insertions(+)
>   create mode 100644 scripts/coccinelle/device-reset.cocci

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


