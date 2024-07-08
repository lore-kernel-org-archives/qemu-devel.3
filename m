Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCACC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 23:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQy9k-0005rN-Mw; Mon, 08 Jul 2024 19:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQy9j-0005qL-O2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:52:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQy9h-0008BX-Vz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:52:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266f344091so4997315e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 16:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720482742; x=1721087542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uoIxqkkfp6D3byamgWRg4iE8qJKE6OKUgrTUAvLelts=;
 b=cA9ifLf3CAViWJfcCKq63ITBaVNNUGC1h1taoLSpmBMtWSxZuXfAnAjxH5/H+gDm8c
 zDVZeBq15iA8NvXE4qI/S0YsyOyUTFRO54s1iHyM1r658FTVim5FFi393YJj+OlgVje9
 jg2ckUTRo32D+UqlRvqru5iDbumi/CRnt3t6Q0Vug5G2TsRSZMqF+Zet2ZepZylbrlI5
 iDGUHs1+h2khI/G5JKH3QCrpWFDa6BtSC2GweqkLNpp9T+2Jv6zM71Gm2bu0xBsHR8uJ
 KBEA1QDNd6N2e6ETmZ8tBZbLFOpJrUiBlE8hUmLs1W007BzimO2U4442garl66YNk3Xh
 wC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720482742; x=1721087542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uoIxqkkfp6D3byamgWRg4iE8qJKE6OKUgrTUAvLelts=;
 b=uLFd0h6H3uab8a2B5swFprezLKNge5o+rXp5ZR0tSFAA2QWih3hdxFWbgEvxwlEwDj
 uywyu5aXUBff0gVRhmrPF1xeMxEOTkmUxGxyA9QIWXna+HuXWe/XD0UwP90OCuYIuW/c
 BawHciMFO1rvKLB06cXm9xwBDJSqjrXv/OwsVFLuNO0e5U2S8iNjCUOmUfj+4ZC4rcv2
 HsCXaBLOBgW62g9P49sy5u6j2Poa9zMNk+kQchoCEE1783AcgW452qHwy4/AhRTH/jMx
 pOITiJaAbn9MyV9XgtJ3BdbTb16JWrYKjDUn/KoNPhc+wNYedlkS3YRrjRCClNYXN9Lm
 g66Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9j7PBQzAl+RPIZlArNtoSohlh4X++QSyaGnCxcr3fcAHbivfXe/fnqeo40tEUP/5AeAn/Gh/GS6OzWyGjmUGuMb3iwnY=
X-Gm-Message-State: AOJu0Yza1/VPULf+lf4ZcCEggn8gZe1XWMte3WJ8oJu8pX1FgaDNXsGu
 s49p6E0kIHriHxASHpt46D3CRUqNaODBaRUPFPa0RSwtG3OGyW33bO61cyfdva0=
X-Google-Smtp-Source: AGHT+IGYIbwQn90fv+TqAb/NGXWj5dhCw5gWd1YxptU1PeRO63aRM7tsMSGtHHZCr2jOYd5F8GO8gw==
X-Received: by 2002:a05:600c:48aa:b0:426:6e95:78d6 with SMTP id
 5b1f17b1804b1-426706c62d9mr5557445e9.4.1720482741977; 
 Mon, 08 Jul 2024 16:52:21 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266a38f5a5sm53833465e9.43.2024.07.08.16.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 16:52:21 -0700 (PDT)
Message-ID: <f825e5df-ec87-4703-9722-98f1aa7aa33f@opnsrc.net>
Date: Mon, 8 Jul 2024 23:52:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
To: Igor Mammedov <imammedo@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-9-salil.mehta@huawei.com>
 <20240706164519.06c53d77@imammedo.users.ipa.redhat.com>
 <db8c2a7c-cc40-4fed-98fc-171f70e239ea@opnsrc.net>
 <20240708155507.52418191@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240708155507.52418191@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x334.google.com
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


On 08/07/2024 13:55, Igor Mammedov wrote:
> On Mon, 8 Jul 2024 05:32:28 +0000
> Salil Mehta <salil.mehta@opnsrc.net> wrote:
>
>> On 06/07/2024 14:45, Igor Mammedov wrote:
>>> On Fri, 7 Jun 2024 12:56:49 +0100
>>> Salil Mehta <salil.mehta@huawei.com> wrote:
>>>   
>>>> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
>>>> and non-hotplug events like system power down event. Each of these can be
>>>> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
>>>> the CPU hotplug event.
>>>>
>>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>>> suggest to squash this into the patch that introduces this bit [3/8]
>> I thought, we are introducing a change common to all architectures?
> hw reduced hotplug implies GED, so including doc change
> into the patch that introduces bit in the code is better
> option.
>
> it also easier on the folks that come later and find doc
> and code in the same commit (which is easier to follow
> than looking for different commits in git log).

Ok. I'll squash this into the 3rd patch of this series.

Thanks

>
>>> Best, Salil.
>>>> ---
>>>>    docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
>>>> index 0bd3f9399f..3acd6fcd8b 100644
>>>> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
>>>> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
>>>> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
>>>>           0: Memory hotplug event
>>>>           1: System power down event
>>>>           2: NVDIMM hotplug event
>>>> -    3-31: Reserved
>>>> +       3: CPU hotplug event
>>>> +    4-31: Reserved
>>>>    
>>>>    **write_access:**
>>>>      
>>> :
>>>   

