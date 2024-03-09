Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12E0C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rix4m-0001IE-PA; Sat, 09 Mar 2024 08:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rix4l-0001I3-Ml
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:49:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rix4k-00067R-4P
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:49:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-413216c3ea4so2164435e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709992160; x=1710596960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FFfcaPHfFPOkirNUgsvCDV1qgYkXrUZ1RXVjrcvCM9M=;
 b=mm4N836jaNYk3Nt+6vvBJLIojkVZQd0g1B2gi2bIjVAR6wbYpzGyIaXmnmUeGQIdac
 aq3CqM5lKKswz426aD9zzAX9MJ46C99CNKErw0a4Os7E97B2U7XtMFE2pn8oOA4oUdGc
 0B7BwoBabpqqeem247r9Ed7F6geTTzUoMF+cF4FzIafq15BlwViP27Ztzim21t5IsdUE
 yHw3dGpvNcIoG+Gdkw58pxIECBbZYhHGgn68IcSFmH6EIu7bX1WK+c6Bs5zsyg29VpV8
 3WZHiEuuKsJ8e375DNMzaMC6ztQ96WskPv2GctOEV9RD4HHjqM/tcAQViwNuiZHoRk27
 WgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709992160; x=1710596960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FFfcaPHfFPOkirNUgsvCDV1qgYkXrUZ1RXVjrcvCM9M=;
 b=hdexY4Mq6hEfbOZ2cYxUYkiV5LXgpz47FPEGRorqqaCXIQlxhGqbIku4ztxL9gHU1x
 fN0XqnLlkGs98Ttqxj4BbSN4Qo0aQyOaG8grRbe4A0t3c9hpmxigC4rCc1nO8maVvX2W
 RUhTJ2MawWdL3MCt+JLmJSvMgNnqAifQ8M4ZxMU99/GZNVFH0iIbRgrT0kRjlAqtT5Tz
 8silfvYPixaGxQ3bCnN0ZnMMTiCJNIGoTXMh9ThTLbMrL3F5q8OCrnkWZQo0y4+3cT1b
 GpRcWKlINadh0jqeA8zQ2kyWnM/aRxxXoF//OINsJ8mWhECB6hKC43NeOFzQzOEXDAAL
 Pzxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMGBaHskQziPuKexj9p67gjdeYNQV7BJKa2FCLK52rhmreiJCrKQukeN+/vwfwP2ZvDejJuSs2Kl2e18x/PQpk7NzYe/E=
X-Gm-Message-State: AOJu0Yz9gWyHdbZNHJDQ+3sTBcXcXT5GiUGO1/aEh/XNCJ7DEpce6X+w
 Uil8RjRg//FK0VVYLiYmjBUCEBkyplJUh7cE4RdqaUwZabAb3f4yzBsEvjzxbz0=
X-Google-Smtp-Source: AGHT+IE9HI8JDIQm6/0R+acqIqtMA8sVWqUL82U+g0QDTFt2L46fVvM7kS7TnIx16QOXU622no0yzQ==
X-Received: by 2002:a05:600c:1383:b0:412:ff94:2d60 with SMTP id
 u3-20020a05600c138300b00412ff942d60mr1495887wmf.22.1709992160323; 
 Sat, 09 Mar 2024 05:49:20 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05600c1c0100b00412ee7d65a6sm2598432wms.6.2024.03.09.05.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 05:49:19 -0800 (PST)
Message-ID: <94997958-3cc3-4e4b-bc92-2eb7e501539e@linaro.org>
Date: Sat, 9 Mar 2024 14:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
 <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
 <ZeuxcZmE9Ejr6acx@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZeuxcZmE9Ejr6acx@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/3/24 01:46, Zhao Liu wrote:
> Hi Philippe,
> 
>>
>> Can you share your base commit please?
>>
>> Applying: hw/core/machine-smp: Remove deprecated "parameter=0" SMP
>> configurations
>> Applying: hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
>> configurations
>> error: patch failed: docs/about/deprecated.rst:47
>> error: docs/about/deprecated.rst: patch does not apply
>> Patch failed at 0002 hw/core/machine-smp: Deprecate unsupported
>> "parameter=1" SMP configurations
>>
> 
> The base commit is e1007b6bab5cf ("Merge tag 'pull-request-2024-03-01'
> of https://gitlab.com/thuth/qemu into staging").
> 
> But I think this conflict is because of the first 4 patches of mudule
> series you picked. Let me rebase this series on that module series and
> refresh a v3.

Ah no, it is due to commit 01e449809b ("*-user: Deprecate and
disable -p pagesize").

No need to respin this series, I queued it in favor of the 4 other
patches.

