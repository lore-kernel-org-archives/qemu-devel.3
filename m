Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832A6C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rixBT-0003Mr-WD; Sat, 09 Mar 2024 08:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rixBR-0003M7-HH
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:56:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rixBP-0007UN-C6
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:56:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41312c3ab40so13026065e9.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709992562; x=1710597362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j/HsoclK8oFQ4qi18yZzZcW2qu6FHeVgS9jILiPGy6w=;
 b=aBUthxm+GtpfGhBsBx589lYjXY8KzNlrdqUWfhnb2GPkHEDv28fHgFLWfUU67OutlG
 i4oOKYE9pUz0QA+lr/hj1pHDVxCPhonsneCUZ47kTE+BWpUjOVtx3YPozTXAoPdGKLta
 fPpwz9isZ2O6fbQjgpVXfP/54+bfc1uI+Y04J+glz4Gt06XZnS170yQs4Ui40+s2dtFb
 pr/ON5LfkZC4goqFH4gE08gRaOORdQSb9+1NUoOEYb8noLTmQEZLwse3tkWqGbqO1EoG
 yEd++w/xuSrX/IcCzhrykOKEpshjbxJX55Teq26NgkZfnyWzH/mrsjUact2wZjUX5iMT
 uy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709992562; x=1710597362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/HsoclK8oFQ4qi18yZzZcW2qu6FHeVgS9jILiPGy6w=;
 b=cDN0vDBBBg/vwPj6DJ1vLC7JxeoT7SDROy3vp38T8CjdZB7uIpk2VHMJaYwIqv8AZm
 +/XIW+mrEywueN11iGDmk6s22npzix1AfVQUTEXII7FYz9Nb+Y3/5s+FtYxX5EH4nL7K
 IXs8uBj0F2CdjT6MpJ2o6TCusuV448VLvEQe/1MqxPF3Yg7aiYa6Y504737anXM7nHGM
 VX2jBQjGB44AwWSsG3LwxHD/YxSf7vPCQUG64J4nVsoA24UIcRQ4NaIMwrX0MZn/V1v/
 VE1f9CO6Rzwsjcd45mkgT76oLPbh5ZNg71+aO/QXn3auLSu4uRdpj3PQLboEI1aXsdfX
 rT3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg4wbUNQkpgUF0UIUT8FGEOr3nKK8rpEAn+c+K2xFiIW2++UiL2tFpcQIH0z3vLfvmrdIglp3h2LgyWfPZmlj/BlGJLtk=
X-Gm-Message-State: AOJu0YzBXmaxcJMTfVre73VFviY6TIURCEjXAtqcbEKGbDUTDwO1IweA
 kU8Ds+JIux05An+DqojzXA/IE3dLi6b1DZcJgdj2bQZq9G2xfC+TWNO/CnnLkMez5ix9mIyxlN9
 K
X-Google-Smtp-Source: AGHT+IHKLUNBAr4YLdH9TGDIUQwct/XsTIrbBBU17nMuxSw56x0i+whSOUvjDh/dd6RFzwAxA4ZfQQ==
X-Received: by 2002:a05:600c:548e:b0:412:ed9b:621c with SMTP id
 iv14-20020a05600c548e00b00412ed9b621cmr1460363wmb.24.1709992562128; 
 Sat, 09 Mar 2024 05:56:02 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b0041312855081sm2643627wmb.5.2024.03.09.05.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 05:56:01 -0800 (PST)
Message-ID: <d58b22bb-43b4-42aa-8ed2-1975beb1f31c@linaro.org>
Date: Sat, 9 Mar 2024 14:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <17444096-9602-43e1-9042-2a7ce02b5e79@linaro.org>
 <ZeuyN8Eacq1Twsvg@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZeuyN8Eacq1Twsvg@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Zhao,

On 9/3/24 01:49, Zhao Liu wrote:
> On Fri, Mar 08, 2024 at 05:36:38PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Fri, 8 Mar 2024 17:36:38 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
>>
>> On 27/2/24 11:32, Zhao Liu wrote:
>>
>>> ---
>>> Zhao Liu (20):
>>>     hw/core/machine: Introduce the module as a CPU topology level
>>>     hw/core/machine: Support modules in -smp
>>>     hw/core: Introduce module-id as the topology subindex
>>>     hw/core: Support module-id in numa configuration
>>
>> Patches 1-4 queued, thanks!
> 
> Thanks Philippe!

I dropped this 4 patches in favor of "Cleanup on SMP and its test"
v2 
(https://lore.kernel.org/qemu-devel/20240308160148.3130837-1-zhao1.liu@linux.intel.com/)
which seems more important, to get the "parameter=0" deprecation
in the next release. (Patch 2 diverged).

Regards,

Phil.

