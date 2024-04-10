Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC8CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 06:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruR79-0003AT-7x; Wed, 10 Apr 2024 02:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ruR73-0003A5-DH
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ruR70-0006be-Hq
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712729229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xi74fM3467BUSg3C5WYuNlW6f4UIb3ICBsBNHeKmim4=;
 b=DvxOZuKGbvRfX2vWyi17TR9a1ZxUb0JNEOm+LlJ1ZRB7UU62cbxM9zF9LficRA5zsCePuH
 p+RZsltpw/9dtKaxonWGeiU9a27UyRLP/Ni2PHZqDehRU0YMqJXm+oyb5nruNgix4Otrcc
 PvabqPA+rVZ+EzbXbn7HjWO6Vy8+OH4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-8KKDgIvrMkuI79Vx4Jyc8g-1; Wed, 10 Apr 2024 02:07:07 -0400
X-MC-Unique: 8KKDgIvrMkuI79Vx4Jyc8g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56e7810e57eso763781a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 23:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712729226; x=1713334026;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xi74fM3467BUSg3C5WYuNlW6f4UIb3ICBsBNHeKmim4=;
 b=cT1QdLt+CMCmjZwBafHoiQNyZGfL+43xfcSXBfVwhtjBuaQ58/xjvXGXnmNDZCt2Ys
 9XDyE8BAd6xrIPEK8L4050kDa+qa5122DOOZM338Uu3SB5fU717jg7S6BFfOFcxz5bvk
 f8DxGp1LVKjG+u2eXPumAONT3VIrf5MxKMwAQlDJqGAvFUyblZl/8cJi16GR/poMsyfI
 tj08uQ/xH1+KYpG6RziolkdCfDpSZEwrEf1BhqADrYtCeBTlmtXEB3atne8vir6mt5bq
 MVBOkLbXT+idtXsdaRp3AHob96d1jfhmX311s6+eW7he/rACrLLXkr8inkBBmuh29fCv
 2Bpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIM4S+JJXBcD7JTg8+j7LUsZOpOk0/+XIiHyoclu120qwatSfxcaQFSqlubCdUcHYw6xIWo86Z6WKQp3A04pWkLPSUZNY=
X-Gm-Message-State: AOJu0YyMOgLIvippzpKGniuEf72dX2FylDskXyUvSCKoG6aPFCc8Q/Tv
 wpFWVzZdeW4b2bgUkVZULk507DiRf2eCdHLK9jgvk/iQY1lTXJ2tK05FULhvyvowHZpH9DOBEy4
 dW3bKw2vWKXOBOyU5j/5id08uz0SK6T/nqP1YZBruRS6sDzei79r+
X-Received: by 2002:a17:906:4c4f:b0:a52:10c9:661f with SMTP id
 d15-20020a1709064c4f00b00a5210c9661fmr284019ejw.62.1712729226218; 
 Tue, 09 Apr 2024 23:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECZE9JZc0KsUeTvEKUY5rlZCdRjszbCqNBroEEg+d9sbg++nerNfgbgrwjzBPhLX4bC/3gzw==
X-Received: by 2002:a17:906:4c4f:b0:a52:10c9:661f with SMTP id
 d15-20020a1709064c4f00b00a5210c9661fmr284002ejw.62.1712729225873; 
 Tue, 09 Apr 2024 23:07:05 -0700 (PDT)
Received: from [192.168.42.203] (tmo-067-118.customers.d1-online.com.
 [80.187.67.118]) by smtp.gmail.com with ESMTPSA id
 hx2-20020a170906846200b00a46dd1f7dc1sm6602801ejc.92.2024.04.09.23.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 23:07:05 -0700 (PDT)
Message-ID: <227c96c8-4f17-4f79-9378-a15c9dce8d46@redhat.com>
Date: Wed, 10 Apr 2024 08:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240409024940.180107-1-shahuang@redhat.com>
 <d1a76e23-e361-46a9-9baf-6ab51db5d7ba@redhat.com>
 <47e0c03b-0a6f-4a58-8dd7-6f1b85bcf71c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <47e0c03b-0a6f-4a58-8dd7-6f1b85bcf71c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/04/2024 09.47, Shaoqin Huang wrote:
> Hi Thmoas,
> 
> On 4/9/24 13:33, Thomas Huth wrote:
>>> +        assert_has_feature(qts, "host", "kvm-pmu-filter");
>>
>> So you assert here that the feature is available ...
>>
>>>           assert_has_feature(qts, "host", "kvm-steal-time");
>>>           assert_has_feature(qts, "host", "sve");
>>>           resp = do_query_no_props(qts, "host");
>>> +        kvm_supports_pmu_filter = resp_get_feature_str(resp, 
>>> "kvm-pmu-filter");
>>>           kvm_supports_steal_time = resp_get_feature(resp, 
>>> "kvm-steal-time");
>>>           kvm_supports_sve = resp_get_feature(resp, "sve");
>>>           vls = resp_get_sve_vls(resp);
>>>           qobject_unref(resp);
>>> +        if (kvm_supports_pmu_filter) { >
>> ... why do you then need to check for its availability here again?
>> I either don't understand this part of the code, or you could drop the 
>> kvm_supports_pmu_filter variable and simply always execute the code below.
> 
> Thanks for your reviewing. I did so because all other feature like 
> "kvm-steal-time" check its availability again. I don't know the original 
> reason why they did that. I just followed it.
> 
> Do you think we should delete all the checking?

resp_get_feature() seems to return a boolean value, so though these feature 
could be there, they still could be disabled, I assume? Thus we likely need 
to keep the check for those.

  Thomas



