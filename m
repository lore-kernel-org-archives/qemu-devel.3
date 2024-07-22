Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65CDC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0T2-0001N6-Hp; Mon, 22 Jul 2024 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0T0-00017r-6o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:21:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Sv-0007eX-LR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:21:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so41352775e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721683264; x=1722288064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30aPkM3X7mxw2kxFZg/Kh76te2T/et6iLr23Tg+qzTw=;
 b=ejp00cRLwMBL3lMm39cMUQ/BX7SdzrG0j6EKKOQSIWkJZa8ZH9bSRyA51z4yjm1YfE
 4mOMkDYaO2hf6jo/IQuQ5+/gzD9PoW6x5tfl3zvNOh61++pW3StvEDvdhqFeDilcdFx7
 ufBlfehRIk9Qqv6xOHI1d9XZL5StCKOoLvC++OQU0jfZtASysBCXp21WGsAS5l7w5JdE
 j8EXr7FPGvdtJJU8DC+Xt/wSCkJGzWRsA3KD5NQa93PvNPzM4lkOUa5FUe3kEiQdS5Tr
 Dx0Qu98v0FrT5FH+8B9/eU1//r2VlFHgpoQpVSDACtY4HUknzmN1/fLkypz86aF6AdFH
 Xj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721683264; x=1722288064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30aPkM3X7mxw2kxFZg/Kh76te2T/et6iLr23Tg+qzTw=;
 b=qCaOKoyLEFVRd9+Eoano34mcNOELwUYVTeMyyM1P1Rd/VD1LoDuLrzMvjJJXeEugho
 o8I3VoJNzF/lPlKNSj2ecy1VR12M0aKQfGs/ltgMUWXm2eE964aQVncOXJrUEIAZ32PE
 r/w80OtRJriyA8+MQ6kuE64tbI67DOdvGbn6Uo3s83bP4d725Cavb3ll/e3Fm+TjhsdH
 EChyI+pyYjeHcOLgxBGPeUKs5l9edONnEodn0u/nMg7E6ecmyy3VBDf2H9oIgIBW+ups
 wmsJoGFLEPULEfu1GsfSsoHt+mh4Wk8/Vj/G2Q/GdAxKWhZEw3dygjMu4VZcFAJNyLgQ
 DT7g==
X-Gm-Message-State: AOJu0Yw/K5LofpU9L08nMv1zZx+LsgCjZPFKULNmCS1iej6nDcPiNJKH
 obzDtBGB7PZNQMIrtWOfJCgzxBtKvQX9Z2ehCaYVE+oARJCRJYm8YlpT7GA9dTEjlzBBUYTtctk
 K
X-Google-Smtp-Source: AGHT+IHQvyQ/oeKM21mJmszng41wVQTbyzdn0iHjnA4ixkxOsBxe68my1vWaiaAYl530U2mVbtn3Lg==
X-Received: by 2002:a05:600c:1987:b0:426:52a5:1ca4 with SMTP id
 5b1f17b1804b1-427dc5292e6mr65605545e9.21.1721683263802; 
 Mon, 22 Jul 2024 14:21:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d690152esm142117875e9.13.2024.07.22.14.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:21:03 -0700 (PDT)
Message-ID: <b7af15a6-252b-456f-bfc9-7e69f5781b68@linaro.org>
Date: Mon, 22 Jul 2024 23:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
 nubus_virtio_mmio_realize()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <ZpeqoZC02URH4847@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZpeqoZC02URH4847@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

+Markus/Eric for review

On 17/7/24 13:27, Zhao Liu wrote:
> Hi Philippe,
> 
> If possible, can this one catch a ride with your PULL too?
> 
> Many thanks!
> Zhao
> 
> On Mon, Jul 15, 2024 at 05:59:37PM +0800, Zhao Liu wrote:
>> Date: Mon, 15 Jul 2024 17:59:37 +0800
>> From: Zhao Liu <zhao1.liu@intel.com>
>> Subject: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
>>   nubus_virtio_mmio_realize()
>> X-Mailer: git-send-email 2.34.1
>>
>> As the comment in qapi/error, dereferencing @errp requires
>> ERRP_GUARD():
>>
>> * = Why, when and how to use ERRP_GUARD() =
>> *
>> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>> * - It must not be dereferenced, because it may be null.
>> ...
>> * ERRP_GUARD() lifts these restrictions.
>> *
>> * To use ERRP_GUARD(), add it right at the beginning of the function.
>> * @errp can then be used without worrying about the argument being
>> * NULL or &error_fatal.
>> *
>> * Using it when it's not needed is safe, but please avoid cluttering
>> * the source with useless code.
>>
>> But in nubus_virtio_mmio_realize(), @errp is dereferenced without
>> ERRP_GUARD().
>>
>> Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
>> method - doesn't get the NULL @errp parameter, it hasn't triggered the
>> bug that dereferencing the NULL @errp. It's still necessary to follow
>> the requirement of @errp, so add missing ERRP_GUARD() in
>> nubus_virtio_mmio_realize().
>>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/nubus/nubus-virtio-mmio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
>> index 58a63c84d0be..a5558d3ec28b 100644
>> --- a/hw/nubus/nubus-virtio-mmio.c
>> +++ b/hw/nubus/nubus-virtio-mmio.c
>> @@ -23,6 +23,7 @@ static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
>>   
>>   static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
>>       NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
>>       NubusDevice *nd = NUBUS_DEVICE(dev);
>> -- 
>> 2.34.1
>>


