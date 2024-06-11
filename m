Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7950CC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxaB-0007x8-St; Tue, 11 Jun 2024 05:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGxa0-0007w8-SZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:14:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGxZy-0004VA-N3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:14:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c6994e2f1so2023620a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718097249; x=1718702049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=psvciP/sk9qfS9xCb26Yf49XGU91OjCAXlXIert47MM=;
 b=w3GgjLMCUXcXuTXqnUOqR/dKrw6/gbMJs5xYVIRGFzpgPpb0C31keyN+ywvSp3f/Vj
 XH9pKSwa5U2qX2tS5kLoZU2GCorp8y3SDdOY34V4g3IiyuzZnb8srDw7jZepa/pfG+g/
 F6NZSEUnWNUjQ5BFt9GYbashnaz8xcy0biMeAhYRZ6JorlgB2GLKCH3CLE2655COpOaO
 cTstohe2O9FTN6X9bBmRYNG/yB1rWnuDnk1UpCOITtGQxfUuI3hF1IBzcGn3eg93Z3li
 V9Lx5X03fHI1Ky2v06aTTfGAlKMsxdpQHqmImIJgXa4Mtce72mGdxeLuX1kEdFVIJOLL
 omkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718097249; x=1718702049;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=psvciP/sk9qfS9xCb26Yf49XGU91OjCAXlXIert47MM=;
 b=YI+YhfBMRXfmtcwrq2hDNY9Lv/+1hGtiJUwxlsEz2yswO2X0qML0wWQBbONGnR1ioZ
 Pnp6AgNx9VEVK+ltXnc8wvwtvM7KWtvzIACVGgBzDZtAqzxj86Hq83Oeuta+n4CUVnYe
 XKR3e0LAqWFzhRdxL1FNQtr865q++dT1MoGQlddT9aeYm6lZQd+EJc0Ubj3cfv+Tlm1t
 9sotNIbTZpzRy0ctjMD1eTgtgQxO5kGlPqQGigPCoGZwG24Olh566cawNeYEU3xfePwp
 pgnSZvoHOjj65aRC3k8maQAVvAMoZbee8nMilfOlY9hzVKEJxlpmwm5ANJejZaw6sbNM
 ULGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvETdVdoBzx79tOj+mbmtq8SdlRFopNhbyI1neAxOA1bWm+ETLkvwh2R6iJ3AlPu5jtfyKVFoHJAbMcp9IWIp7edn3mo=
X-Gm-Message-State: AOJu0YxwyLL25gxB+qjx/orAEEcDaxMCr0U3xQK2j9+THQNaYzQ+bqz/
 11d8Tu/mLzzN0E6j67B4RMP4p+kssZKgDvOQeixv1Hc8xYOKH32VNqwsA4fXL8IW2KLgW+uSU3B
 a
X-Google-Smtp-Source: AGHT+IG7mRBizrberc6kojnC2g3HkyFOH9gdNbAA9EDLGWNjEl9IfajiPcQHJ0hqx1lbVYbpeCWl+g==
X-Received: by 2002:a50:c2da:0:b0:57c:7c44:74df with SMTP id
 4fb4d7f45d1cf-57c7c447531mr4436553a12.29.1718097248682; 
 Tue, 11 Jun 2024 02:14:08 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f2706d8ebsm166490666b.114.2024.06.11.02.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 02:14:08 -0700 (PDT)
Message-ID: <4231f244-e247-4fd6-8e90-44051ac98a3c@linaro.org>
Date: Tue, 11 Jun 2024 11:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Remove libumad dependence
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com
References: <20240611082407.57154-1-pizhenwei@bytedance.com>
 <5d7981cf-6d18-4915-bb6b-985998a0c953@linaro.org>
Content-Language: en-US
In-Reply-To: <5d7981cf-6d18-4915-bb6b-985998a0c953@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 11/6/24 11:09, Philippe Mathieu-Daudé wrote:
> On 11/6/24 10:24, zhenwei pi wrote:
>> RDMA based migration has no dependence on libumad, libibverbs and
>> librdmacm are enough.
>> libumad was used by rdmacm-mux which has been already removed. It's
>> remained mistakenly.
> 
> Great!
> 
> Please also update tests/lcitool/projects/qemu.yml,

(see 
https://www.qemu.org/docs/master/devel/testing#adding-new-build-pre-requisites)

> with that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> Fixes: 1dfd42c4264b ("hw/rdma: Remove deprecated pvrdma device and 
>> rdmacm-mux helper")
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   meson.build | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index ec59effca2..226b97ea26 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1885,11 +1885,9 @@ endif
>>   rdma = not_found
>>   if not get_option('rdma').auto() or have_system
>> -  libumad = cc.find_library('ibumad', required: get_option('rdma'))
>>     rdma_libs = [cc.find_library('rdmacm', has_headers: 
>> ['rdma/rdma_cma.h'],
>>                                  required: get_option('rdma')),
>> -               cc.find_library('ibverbs', required: get_option('rdma')),
>> -               libumad]
>> +               cc.find_library('ibverbs', required: get_option('rdma'))]
>>     rdma = declare_dependency(dependencies: rdma_libs)
>>     foreach lib: rdma_libs
>>       if not lib.found()
> 


