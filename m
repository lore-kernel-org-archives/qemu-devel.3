Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC830C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFy1-0004AP-Vf; Mon, 01 Jul 2024 08:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOFxz-0004A9-Mv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:17:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOFxv-0006BL-UZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:17:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fab50496f0so15089775ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719836222; x=1720441022;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q9hUVzu2906VBKOyZdqa94VDDPFMg/0uYuzuiJ9d+vg=;
 b=c+j93o8HfESG2PQTwYQjByNYjEaBBiG/BWKcpKf0Jw08T2HYlp1Wbwa+SCnNVtyDNB
 iT8f7XvDQUkimrZC7sXQddX3pQ0KZG3MvuvttizZ/3MOHFwSX7atQyOg8DMXnW+CoxNO
 mKipmYdVK174ibe/+1SeOTYKSoDaeE5bga8nq+XXAOFNSE1YGHzWyALlvx56hWQ5Evhx
 P1CBrgJtUycEeNpQzuucn1gMVUvheF3HUZN+SRcLUuksAVQKMdATFbSmgnZq2Xouslj7
 iW1zPrPJcfI/poTL2tUxLz1G+e9A9tnqsXGh4U207zloV019Y+02oEW1nZpbYb9hO9Xx
 DnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719836222; x=1720441022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9hUVzu2906VBKOyZdqa94VDDPFMg/0uYuzuiJ9d+vg=;
 b=dZxlHcCRKvDv4JcFZCKnunTwmLkVBzMzNWYGBGFUfDbT5GXlC9SBAPOtwKzZ1frHfX
 fqa5T7zYGLxI/+9xcq4u/1LIkhclzRqsl+2wMKEndUH0UPzm+PRYLzbWNrjFBxamFy+A
 cRJ6w120AedaDkJVRZHXWCINE3pe54NTytyFKR4SokKzBZoc112U5oQr/emRqHlymvAk
 6O7qxiWwA3z8ATnonYBuKGbG2HrxFVxyf8MxS1nSLYiGB1Bh1HoznWMtZmMGLJULsGtS
 avDKMm02GdYMM1Fa4c+H6sEhhwVlS57PDTv70gfsPzU3CrAQFnL8N0FMij6yUrs3YW5p
 /tXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgSTOv7/XIur7JLIhmk8/zoDpqa3OYqzDiyY65hliaDtoV/W0hMQVt7qaAbHa6Bwol7ckbcu1G+rCA7LcuycdPtOXIY2w=
X-Gm-Message-State: AOJu0YwpCDEqrsjXcZi2VyyvcNMIok/+1lZp+OUGCLUXPDfFnfFlH38/
 PC57H+lizH/DHBe0kaYXcWo+UZEnAxTF2rZEolKTukZR1+pkbfNaCYxmRwj/jX8=
X-Google-Smtp-Source: AGHT+IHSe6tUFVB9YqxIhqtRaeznFbomrPOiudIFmafdzWMK3YD0v4mheXDvr99RxdYzrHOZeZP8HQ==
X-Received: by 2002:a17:902:f542:b0:1f6:ed89:6bca with SMTP id
 d9443c01a7336-1fadbcb2019mr29959495ad.39.1719836221855; 
 Mon, 01 Jul 2024 05:17:01 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15695b4sm63354995ad.225.2024.07.01.05.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:17:01 -0700 (PDT)
Message-ID: <1b5608aa-5cd5-48b1-bc7c-e356afdc9865@daynix.com>
Date: Mon, 1 Jul 2024 21:16:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Always add pmu property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
 <20240629-pmu-v1-2-7269123b88a4@daynix.com>
 <CAFEAcA8FQLQF69XZmbooBThA=LeeRPDZq+WYGUCS7cEBiQ+Bsg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA8FQLQF69XZmbooBThA=LeeRPDZq+WYGUCS7cEBiQ+Bsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/01 20:54, Peter Maydell wrote:
> On Sat, 29 Jun 2024 at 13:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> kvm-steal-time and sve properties are added for KVM even if the
>> corresponding features are not available. Always add pmu property too.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/arm/cpu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 35fa281f1b98..0da72c12a5bd 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1770,9 +1770,10 @@ void arm_cpu_post_init(Object *obj)
>>
>>       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>>           cpu->has_pmu = true;
>> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>>       }
>>
>> +    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> 
> This will allow the user to set the ARM_FEATURE_PMU feature
> bit on TCG CPUs where that doesn't make sense. If we want to
> make the property visible on all CPUs, we need to make it
> be an error to set it when it's not valid to set it (probably
> by adding some TCG/hvf equivalent to the "raise an error
> in arm_set_pmu()" code branch we already have for KVM).

Doesn't TCG support PMU though?
Certainly hvf needs some care on the other hand.

Regards,
Akihiko Odaki

