Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC12FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgzN-0005gA-5B; Mon, 08 Jul 2024 01:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgzK-0005di-H7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:32:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgzI-0003Ys-Nd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:32:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-426606f80ebso9019625e9.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720416751; x=1721021551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dm929TgKAN98lOusto7ZMWWlCh02WcjqKU7UMCwZV0A=;
 b=gJ1JEULapAh+tyMdK/Si8Vu4PHFX2Z3PtSWgCVOzIDX3zQU7X6Ra2+HeM/NFjQBdfL
 /PB54KbTgwUwffh+o2mpKr6DSnRxt5TIuGBKX1jMKwZqS8Y6O2jNLX7xhoP4xHQnrM5U
 vBguxRaK6/OIFcCHKHHLY06P4BSQv4hi2VKie3JHePS+6U0CWZXgpH/UObDLQBt47FL4
 hJWyJxBh43uF4coFTLTxHsoIubaKRDI0N6juCfHLZCVjvlyA4S43WcBYG67OAlj3h8vB
 2PtSVli5Uv3sqf9HJBfAmrOgiSyUJpDGBBsXfvF8aXqSG8whfLBszHLg6dD65+Wx6tz5
 zfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720416751; x=1721021551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dm929TgKAN98lOusto7ZMWWlCh02WcjqKU7UMCwZV0A=;
 b=ewJg2s1e9V1tMFf10+/7IJ/MFUUgILveXO0gzgdlRhAym7U9NMn5GYQqT0UPev0cfi
 YNlAKSPiQcIIMc4ujybUYWGPtoEWNNcXThwcE/2k/YdEVkYE7VB1wpBI62B+FKUlrEb+
 6bSoSw0h3awYG4mFLqVb5meyKBYpsal4e+BCFluNKpAmGQVLNs2mbZ/0+S34e26paF5C
 cTDKmMncKYHjriSPSDohXeIVEDHlrGDXuD9u0UyVki6obu3ZcBDlOEBGz2go9XWalcm/
 9HKBAVt3q5LixfZQ8dMvH2bNzMrMeMQO4Uc587Pb4ZIJzw2efjxhOi+TJBibjQ1B+0nl
 m0Fg==
X-Gm-Message-State: AOJu0YwKk2fYa7VWHMqCoTWuls5Xr++tMzQ5vOdkiVjyB190g7aMl6UO
 /awGpMbLsy/fD30FFJils3h55eBV3jJ1wg3P2DNmBjuKtc7hPQV0gJjDrOBrIoI=
X-Google-Smtp-Source: AGHT+IHVJ5VTeuWPCIJDC1Yp7HLKmAtjpWs2Xqm00Rj6FPGTR4xCYYJsOMz/8s58VQKn8Lg+aPBgTw==
X-Received: by 2002:a05:600c:8a7:b0:426:605b:8c53 with SMTP id
 5b1f17b1804b1-426605b8e0fmr27511665e9.19.1720416751108; 
 Sun, 07 Jul 2024 22:32:31 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc8bcsm149719465e9.44.2024.07.07.22.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 22:32:30 -0700 (PDT)
Message-ID: <db8c2a7c-cc40-4fed-98fc-171f70e239ea@opnsrc.net>
Date: Mon, 8 Jul 2024 05:32:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-9-salil.mehta@huawei.com>
 <20240706164519.06c53d77@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706164519.06c53d77@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06/07/2024 14:45, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:49 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
>> and non-hotplug events like system power down event. Each of these can be
>> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
>> the CPU hotplug event.
>>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> suggest to squash this into the patch that introduces this bit [3/8]

I thought, we are introducing a change common to all architectures?

Best, Salil.

>> ---
>>   docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
>> index 0bd3f9399f..3acd6fcd8b 100644
>> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
>> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
>> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
>>          0: Memory hotplug event
>>          1: System power down event
>>          2: NVDIMM hotplug event
>> -    3-31: Reserved
>> +       3: CPU hotplug event
>> +    4-31: Reserved
>>   
>>   **write_access:**
>>   
> :
>

