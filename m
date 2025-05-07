Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7253DC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCfrW-0001w2-No; Wed, 07 May 2025 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCfrV-0001sM-Cq
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:35:05 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCfrS-0005sv-E3
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:35:05 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so2846127a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746628500; x=1747233300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cGbk00wschHTDzIh42NRR/zUnxCx6sruCGnznQznNHg=;
 b=e8dDDrH0zkcJNZYYfMMRhF0I5VJ+7RAf9D5WiKXzsj7urJonCjT+vML5DWHnmPszKU
 slGOHmz5g2fcH/DRdJIvrT9nkieqaOT0I5Z8wwyHY6/XfrSYR5ErxQxEhyjp9yaX3RQa
 fRCWhOHxMZJq28RnaNm8erHzQwnfa5Zph3neAgZOxrHOfUkY61sN1sQphyMr/6Y5f2jg
 ujvKIsDD5sS7gWvN5p0JLRGtUA0m2gt8BeWMwIBJhgNIPNe6CXEOJDVeVh/kegvG0zXu
 sIU/rlSZ7LfumE5T/jVQfpypS/1v6hnSUaUnHzhMv96rmF0zOFzrbzEUC7/BXGDdqvwq
 v/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746628500; x=1747233300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGbk00wschHTDzIh42NRR/zUnxCx6sruCGnznQznNHg=;
 b=N4UTd5xMmhnfLvULRexlHQ+9u5xDmUJkXWUXZE2tG0O+I5maE6DfIrq+x9AOF3PwHZ
 Z/+ovIE8edKCID7qQCi4clmtBI8IbyLehu5cI+7p5a55GLmYnoPzeKFBHrZGqfZMYAqV
 WrFpKHNT/g/CfMzMMlrKmHQ3qx7xrLokAjkaHYZ72t/LQehsn8LMeXyw1gC1zUoxjO5w
 YWgdM3CgHqFl1COWxMVHcx7tBHFrVJxqWt8Lvq08cbruGE73kHSvX3Tdn4hbrZR2Ed06
 gSZlbJa53iGX0hJzXWiKerWUzxgb1hP8byVeHOvadmQniMLA3UwHNOIUp+LD91yu/x0q
 BAeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Vh0gXBGrkCKmTl6jwi/fOJZgc2tpjVpIT5b+NWAx283YvFRPKNkYfYRYva4Ng8s7GlfhRca7Yewx@nongnu.org
X-Gm-Message-State: AOJu0YxblBv65uRRcjpILP8Oofbm4jk8hGFygFkPEPgQdhd1lZfdZAXP
 rLFYJR6NaBzxiJB8pbmsud0u8I/LafqkVfLUyNGTrvtySsKfEVmVpt4KC7U5YCgAzXlS6/UMJaJ
 NpVg=
X-Gm-Gg: ASbGncuCDxQdTTX8aVp9NwR/99+/Ok22jpapMN7UJaNDduRLAm7AqG2DKl+KQs3jggt
 RRdovlt5HTYPEpXiqOIazFmTve6Oub24EYHUS4LeWBX1yjBjQQ0JohmKQZITOrrIXSAQ96K68tS
 HfT8OhdgG1kT3Y2sN5N28JgsymeQk0oJJhP6yLtFWmys5pDWknkTwZRW/BFaCI49GmSfC6YHA5x
 XsjYKsNGALv3WwmW3WK2BG0rMS/CWVAeH3FFewtMraK+2Ao7rAlLpVmAbtfWEQSVK9C6xRR7B6a
 xsW/2HFMeH/FzKEl8rSUgiKjB5NirOlSqMjVN/lBK1tiiODXOf5ifxwRkpsjlmy/Jd9XJ7bnIA9
 uDYpo6XMrxtI=
X-Google-Smtp-Source: AGHT+IFBqacrUUcdztyIMaiFv6zlBckApykFHIfsOZVfx6THlWFCCYFZ/etGZd396iqq3OLAK+BpIw==
X-Received: by 2002:a05:6402:3588:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5fbe9d77c6dmr3048756a12.6.1746628489889; 
 Wed, 07 May 2025 07:34:49 -0700 (PDT)
Received: from [10.194.152.213] (26.21.205.77.rev.sfr.net. [77.205.21.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa960e99a8sm8638342a12.54.2025.05.07.07.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 07:34:49 -0700 (PDT)
Message-ID: <c819c543-7bf3-4040-8cf6-671368bd2aa8@linaro.org>
Date: Wed, 7 May 2025 16:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <bcain@quicinc.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Neo Jia <cjia@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Wedgwood, Chris" <cw@f00f.org>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Jidong Xiao <jidong.xiao@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Meirav Dean <mdean@redhat.com>,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Wu, Zhiyong" <zwu.kernel@gmail.com>
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 <87a57ydj8y.fsf@pond.sub.org> <aBIGdQab_PufZ2X6@redhat.com>
 <aBsYt/nm/6+8tHtx@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBsYt/nm/6+8tHtx@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Hi Zhao,

On 7/5/25 10:24, Zhao Liu wrote:
> Ping Philippe?
> 
>>> Another example: the KVM PMU filter series linked above wants to define
>>>
>>>      { 'enum': 'KvmPmuEventFormat',
>>>        'data': ['raw', 'x86-select-umask', 'x86-masked-entry'] }
>>>
>>> The enum makes sense only when we have CONFIG_KVM.  Member @raw makes
>>> sense regardless of target then.  The other two only for TARGET_I386.
>>
>> NB, ...makes sense only when we have CONFIG_KVM **and** the QEMU
>> process was launched with '-accel kvm'.
>>
>> It feels strange that we want our reported schema show a difference when
>> we launch "qemu-system-x86_64 -accel tcg" between two builds one with
>> and without CONFIG_KVM, when KVM is not in use ?
>>
>> Or to reverse the question, why does it matter if we report existence
>> of KvmPmuEventFormat unconditionally ?
>>
>>> We could elect to forgo such conditionals.  The main disadvantage is
>>> loss of precision in query-qmp-schema.  Which may or may not matter, and
>>> may or may not box us into corners.
>>
>> Is the precision we have justifiable ?
>>
>> When it comes to runtime configuration QMP is already imprecise.
>>
>> eg set-cpu-topology on x390 is KVM only but still there
>>     when running with TCG
>>
>> eg reporting query-hotpluggable-cpus on machine types that
>>     lack hotplug
>>
>> eg reporting set-numa-node on arches/machines that lack NUMA
>>
>> eg reporting query-balloon when no balloon device is present
>>
>> eg reporting various xen- commands when either the target
>>     or machine type lack Xen support
>>
>> eg reporting many cxl-* commands when either the target
>>     or machine type lacks CXL support.
> 
> Indeed, I think Daniel's examples are great. @Philipppe, are these cases
> considered in the context of single binary/heterogeneous emulation?

This is being actively discussed in this thread:
https://lore.kernel.org/qemu-devel/20250424183350.1798746-1-pierrick.bouvier@linaro.org/

> 
>> IOW the use of TARGET_ conditionals are only addressing a very
>> narrow area of (im)precision, whose rationale is largely an
>> artifact of our historical separate binary / multiple builds
>> choice. The only real justification for continuing with this
>> is that we've always done it.
>>
>> Creating a general runtime conditional mechanism in QAPI feels
>> like opening a pandora's box.
>>
>> We'll have a mechanism but it will be impractical to use it fully
>> enough to be able to claim we are actually precise. The scope of
>> runtime choices/conditions is too huge.
>>
>> It risks creating a mechanism that requires a never ending stream
>> of patches to address continually reported gaps. A potentially
>> significant maintainer burden.
>>
>> By comparison the CONFIG_ conditionals in QAPI, both the scope
>> and semantics clear and it is a fairly tractable problem, although
>> even there we miss them eg lack of CONFIG_XEN conditions on xen
>> commands.
>>


