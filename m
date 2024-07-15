Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452B6C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIHF-0000Jm-Ol; Mon, 15 Jul 2024 05:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIH9-0008NJ-2J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:45:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIH7-0005qu-Gg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:45:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266f344091so29399415e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036738; x=1721641538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PtMKmWDIJNHQwV+uoj77VsPuBuqd+52I+yrh1pXwqzI=;
 b=w/wXhV0onZS+utJottJNo/3AiMfx4nJvYSu6+aULpHoyFTLmuxDzxPtGHC8RmW5yiU
 p51QCeicF7lwEJE7KzPC4z4+T1Ya+MqmuBnhs6IGbfVolk1Y4M2gWvZ1DwMvcwOVHdcV
 8YfB8T56udqv+B2WivEi/CjGyGw9h3roRR2+QJbl5sza897Prd+CIBYGUx1NmVm9EMfE
 0VgAWP7qtfS+WhwckZfWadhFl3rwhoS6XuN2Sb1Ha5lqZPWLTtMIsopzVN/wNaAiiTuW
 juMfJ2k5MruXeWwXCA9LSGUgbmQl/sk9KmtiPR5+8E//cyJKELn2kH5cY4O8pb7t1T1Y
 iLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036738; x=1721641538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PtMKmWDIJNHQwV+uoj77VsPuBuqd+52I+yrh1pXwqzI=;
 b=dES6zkbQ67FwmXM9dIUPykdy/wZULVvNZWlExzppD3gCNFBhv20HYOMvAGA0i3kApR
 zEz0zZGOAQhUy2ICDiKGxXaEoks+ZOHaKILRzhZmvbkUXSi16pfsGEKxkC7N3hFFXmcJ
 /WfeV82oUKXkp9qti1N9aspWbNorMp6hFfK7RCR9cL7iHMQ5ozKwGMpKGyEWdK51Andl
 0fmcy1sKHeDJb0hUy9uduo8j6U9n9/7JkBzRW+NcPrFDJI3ixy87YpLC600U2Pyg0Dd1
 FExVlKvOCzPFJCKsCsEgxOWiBo18+Zpkd+xhbuOgKLp08wOLNSV4P87VAwzFLESHdlW9
 JARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrFsgYMyrXqWFRRq7hysfq+KJ2AdK6vJMSbZmwjmfKdV5Z8SyQjkk59N2Dy9oO6U3NplVQcihjHWLBQMAx/TlWTu03C38=
X-Gm-Message-State: AOJu0Yx9kKHlQwwXAVnxYYQ/N0g6qzG28TM4mSXilgDVo6dapcnN9KN5
 4+f+Qk+0NpRC4LgsBoVMyXOwGYzORUGwXu5b/9bSIKuJp1+0ZqKry0J0bC+k9DpKLoohDmvo4fh
 IWH8=
X-Google-Smtp-Source: AGHT+IHs9PUUzkmJf8S3W924f0HpNzeBGa/URZYU73LyH3UZr/XtuUwG8YT4MR6I2oLqCToJ5mO/Xw==
X-Received: by 2002:a05:600c:4850:b0:426:627d:5542 with SMTP id
 5b1f17b1804b1-426707f9088mr113112395e9.28.1721036738568; 
 Mon, 15 Jul 2024 02:45:38 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a14d32e8sm105851445e9.17.2024.07.15.02.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:45:38 -0700 (PDT)
Message-ID: <2fba3e7e-b5f3-4129-9628-954b727a25c5@linaro.org>
Date: Mon, 15 Jul 2024 11:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] backends/hostmem-epc: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-6-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715082155.28771-6-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/7/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   backends/hostmem-epc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


