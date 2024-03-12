Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB11DC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxqO-00047H-FJ; Tue, 12 Mar 2024 04:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjxqF-00043c-2u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjxqA-0005mB-Vt
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710233430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1VRk1c+RLEPigqDbqoCcY3ibvyOTKcjaTe1GsSxEYhE=;
 b=OmMjidiopsir0aXXtEhrufiDd8t5YrTCrKiwpIOQLG1WTJ7ziyTaXNUt/Hn+H6OwU//wO0
 rWnEz/RRqkwpzghfEJZqeEF4NRFpBWXj5kZfstRRDHt/dfg9ew/zCEMyrbS8rP0mNtWER2
 b3s3WggvbamXUTMl9RJ8KTVVIES0WeM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-1Dp_JNUnOy2g6ZH1tw7yiw-1; Tue, 12 Mar 2024 04:50:28 -0400
X-MC-Unique: 1Dp_JNUnOy2g6ZH1tw7yiw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513b3ca9650so979249e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710233427; x=1710838227;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1VRk1c+RLEPigqDbqoCcY3ibvyOTKcjaTe1GsSxEYhE=;
 b=jxxc5FRXkzxORrZT/i6k8ZBU9adOC1pXGEsglh+7Wc4sq4cSJtGqaF25pIgj5dbQ9U
 tMEiH35OHQf33IGYuYwzPrfyQJh294PjEQgm4xgj0xQ0sHq4qYeeNP9UjT8JON7ntSV/
 yiWpH5y6neLQUWoBkSJNPEC4mp2pdHbyYjo5BTiyntYtIUZ3cvF/A5sOaB/zGOeSJXYc
 wqMSZH9hRtdVkxqTwLlemcJKez6gveZHc+RBewvZuYc7/CnYIgM0b2A7FuhAl5BPWvpM
 KRaAfwq5bLiroA3VnRZDXVqWko65B1TM0nM2jIXHimtYCfoE++Ps4zAuH4WPaQMjuDC7
 A2xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrQqZ1o+Hx5E3elR/BTeoDuru+v9kL6jvslMwA3SfVcYviZCSvHzPZdDPwhv+C3zoUZm17hVxXa12kch57pjs8kvqWHuo=
X-Gm-Message-State: AOJu0YxjLcHIzR+wRmX7RWRnd5Z/W7h3e59oLVMOvb70VmKUzkGOnc1D
 vEbjSGla7vD+P58u4qUzxQ04yMyHngYsv7KnvBip4vpX829WpZfFiAsAyY3zLCH5RWmCcaE/N+j
 QmzRLf/CSathOB/P54+5RLSJ/kaspk7Czf4MProWuNKWbMOLsVuqT
X-Received: by 2002:a05:6512:2207:b0:513:b159:e711 with SMTP id
 h7-20020a056512220700b00513b159e711mr3159644lfu.4.1710233427357; 
 Tue, 12 Mar 2024 01:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrbHM8HQNspLfLsZ2yAQl4rOUe4bhtpb/ccCaU+HrxT7o0XBG1Gcyyha1yO8kM8jC9sTvpOA==
X-Received: by 2002:a05:6512:2207:b0:513:b159:e711 with SMTP id
 h7-20020a056512220700b00513b159e711mr3159628lfu.4.1710233427014; 
 Tue, 12 Mar 2024 01:50:27 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c315100b004101f27737asm18150696wmo.29.2024.03.12.01.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:50:26 -0700 (PDT)
Message-ID: <4ba8e5dc-cda0-4ed4-8baa-82687a235627@redhat.com>
Date: Tue, 12 Mar 2024 09:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
 <d48e5d05-0e1e-4bb0-b10a-f0c943b055f6@linaro.org>
 <ZfAVsQTIOgAOjd0Y@intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZfAVsQTIOgAOjd0Y@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/03/2024 09.43, Zhao Liu wrote:
> Hi Thomas/Markus/Michael,
> 
> For the remaing patches, could you please help me merge them next?
> 
> Many thanks!

Yes, I'm currently reviewing the ones that don't have a Reviewed-by yet. I 
can pick up the remaining patches if the other maintainers won't pick them 
up for the softfreeze today.

  Thomas


> On Tue, Mar 12, 2024 at 09:17:30AM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Tue, 12 Mar 2024 09:17:30 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
>>   error_prepend()
>>
>> On 11/3/24 04:37, Zhao Liu wrote:
>>
>>> ---
>>> Zhao Liu (29):
>>
>>>     hw/core/loader-fit: Fix missing ERRP_GUARD() for error_prepend()
>>>     hw/core/qdev-properties-system: Fix missing ERRP_GUARD() for
>>>       error_prepend()
>>>     hw/misc/ivshmem: Fix missing ERRP_GUARD() for error_prepend()
>>
>> I'm queuing these 3 patches, thanks!
> 
> 
> 


