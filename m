Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C85C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 07:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnCU0-0007BR-Mq; Thu, 21 Mar 2024 03:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnCTy-0007Al-Fb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 03:04:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnCTw-0007md-GX
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 03:04:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4146d750dcdso3549125e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711004694; x=1711609494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hM9KPDd7TCRO0xFfqq3UNYJu1HqsDuDHNUd4p3yDyiY=;
 b=PnS+y+GjoyahbelWgJkDPWRLhQROhiBc5HE4UKdufFFzVlL4GiieUR780MKYVp+0GB
 WC653AHE2dKc4hUl1ICNyIZoCzHtDhqhFvNKk7ZozcDX1BhjOaJCsnHKXmIJV6qOV/cF
 VY3qc54EHP1EifiIFWqP4/sZhgz8gQtqvgo+WpJNmiiIPi4DMZyax2OkgBfWOblC2ZQd
 U2rP229lNTx/FKuaYQrN5Bjox7Dvh/bO4+jEpXNJCtLU70QHLNlWH2fQN6i3XqWGL7FS
 b7ziuLRc04EcmqO2o0UFp1M6YNfeg6+JmQjB4mVXjPpThCHZGEV3gdRwL11Ff0DwmTKX
 fkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711004694; x=1711609494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hM9KPDd7TCRO0xFfqq3UNYJu1HqsDuDHNUd4p3yDyiY=;
 b=RAMwrgwbrhakJb2Rf1EGuf16GZt7Z/VQE9p4NYeWO73SoDSc+PklD28HRwPRBfFTDZ
 pEK8L8ENTFeNtAUtZqkgNEGM6XhVjMIi4lmyorUN8E4XXxnQaEX+wniaHeqC6ZNzpOQ7
 o45pMiugyutXtBF1bo3c1hSHL4ZYxV3gyAk+z4Z//hxQmYtf8Z01Qiq00v/QgHxaObTl
 goZLGoRmtY3AKcX4e0wjn1AGWMqk3KdTUMH3/M+R548RIhWq60yKX/kvoXFIDx7v3DUh
 HZefhRvougXREDlVN9i50wH3IQB6wzJ+ws+OPDAe7l8y4vrqLK/L5uE/mO368LsM37uS
 sInw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw7Ie4ySF2LUpILnrR60GD1QFzDjMprhJXi3Le1q9HteYR++3DbguNFybYZMXw2u/SHg97F3fldECPkt0t+MQphRRnQP0=
X-Gm-Message-State: AOJu0Yzv9fRXPU8Wy1JUXVsi6betdxPxJu928jeqNYvZUw4MFcIYF8QQ
 7hZZiGMbZD0ft+qujh7ZwPFL5NHbpvyAWxwHmHsJGCn/yTnjEjOeQTzX9wGbAOs=
X-Google-Smtp-Source: AGHT+IEwGenohNKCRIC+JKpkviIaxJ/VEPGH2731F08pJ8kegpMXDwdYd0zznsvyWZa9do6Co/9EbQ==
X-Received: by 2002:a05:600c:1d17:b0:414:43e:4aaf with SMTP id
 l23-20020a05600c1d1700b00414043e4aafmr1504501wms.1.1711004693743; 
 Thu, 21 Mar 2024 00:04:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 fm22-20020a05600c0c1600b004147266a37dsm1571324wmb.30.2024.03.21.00.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 00:04:53 -0700 (PDT)
Message-ID: <6d608e2b-d515-4e7a-8d87-d47b19f76d67@linaro.org>
Date: Thu, 21 Mar 2024 08:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
Content-Language: en-US
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
 <9617e174-1aef-4caf-9f15-2ce3c455527c@linaro.org>
 <PH8PR11MB687990BDC78BD650F5FDA391FA322@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <PH8PR11MB687990BDC78BD650F5FDA391FA322@PH8PR11MB6879.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/3/24 08:01, Kim, Dongwon wrote:
> Hi Phlippe,
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Wednesday, March 20, 2024 11:57 PM
>> To: Kim, Dongwon <dongwon.kim@intel.com>; qemu-devel@nongnu.org
>> Cc: marcandre.lureau@redhat.com
>> Subject: Re: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
>>
>> Hi Dongwon,
>>
>> On 20/3/24 21:50, dongwon.kim@intel.com wrote:
>>> From: Dongwon Kim <dongwon.kim@intel.com>
>>>
>>> QemuDmaBuf struct is defined and primarily used by ui/console/gl so it
>>> is better to handle its creation, initialization and access within
>>> ui/console rather than within hw modules such as hw/display/virtio-gpu
>>> and hw/vfio/display.
>>>
>>> To achieve this, new methods for allocating, initializing the struct,
>>> and accessing certain fields necessary for hardware modules have been
>>> introduced in ui/console.c.
>>> (3rd patch)
>>>
>>> Furthermore, modifications have been made to hw/display/virtio-gpu and
>>> hw/vfio/display to utilize these new methods instead of setting up the
>>> struct independently.
>>> (1st and 2nd patches)
>>
>> Thanks for splitting, unfortunately the series isn't buildable / bisectable since the
>> methods use in patches 1&2 are only introduced in patch 3 :/
> [Kim, Dongwon]  Maybe changing order of patches like 3-1-2 would be acceptable?

No, because of the g_free() call in dpy_gl_release_dmabuf().

Maybe Marc-André is OK with the previous version...

> 
>>
>>> Dongwon Kim (3):
>>>     hw/virtio: intialize QemuDmaBuf using the function from ui/console
>>>     hw/vfio: intialize QemuDmaBuf using the function from ui/console
>>>     ui/console: add methods for allocating, intializing and accessing
>>>       QemuDmaBuf
> 


