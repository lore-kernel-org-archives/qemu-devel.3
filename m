Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B2C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrNF-0003Ev-RY; Thu, 11 Jul 2024 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sRrNB-0003DY-Qw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:50:01 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sRrN9-0005cz-Nd
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:50:01 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea34ffcdaso859924e87.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720694998; x=1721299798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DoOydcMVbUJJ/RwXHVe5Gdr2o4qifse1CVSUD+HZfss=;
 b=IGH7+6CMr/JDYwvVUtLHJUi2xrlCWDrVr0XXdoMAOvNvC5CzlGZU2+HQEYahjTxAqd
 N3UxeePbzfW2sjzYmjLeDNCak0fM4NjwQAVkUamlB0D9mmaDRPBVEJvwac5WPpwb9rEo
 b1bmw3amzw98311n5ms4MMhwUlmFVfBGNq/JB4V8LZDEGwydjVnoZcHSomOfZGDOwJDX
 6BOxI/24GAPGqC4cA34/RnS9nm8ETdv3aZuPZ7cP9heENHF0fD/aVtw58dzjG/mSrXup
 7o+9Ra1p5UrYYjsrbfuSfqdJU6okfo00yGk3HrB403TEvu0FFZEbBFeeU+9W0PWj9/Wv
 dJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720694998; x=1721299798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DoOydcMVbUJJ/RwXHVe5Gdr2o4qifse1CVSUD+HZfss=;
 b=SF+P0URROKxEP6KcLP0Oyi9jrjoTZO3XhreYD/YJw509JjSJk4F4KX7/HV9MlMF74G
 nSMm1tPFdIk5YctkPcb2AgPx63BgqDoEY4i9ExVLzB44FEDZzk5NPXYBmh3zdgIN7HxG
 rXmtL/bGtSoJv0DFgE8wU7/WAxyVjkt0VqXBiiZSGbH6WWQO3VLW9gju8nEnd3oXDlbj
 lLfTrPo+bYWWZcXFDUdSoKJrO/SbwzV+gKPA6gDmgTmhWhu/g8zLeKOaQ6gDrn0ll2ay
 LtdO2uKtB9ixyZ+wmiv4HpkaYk2SmhmTaUbsDQ51znsoCQAlELW7XNb1ZfEn4k/cFPdp
 danQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+n8/E9s34etPZnLP16RpEljegHILwtqiTt0Z7vYjWpMru1JhoniSpZrAH3HYfJyGeFBRWj10vzoFp5pgKndq/M+kSMPE=
X-Gm-Message-State: AOJu0Yz5JKATBDm5/HapvQiNG1BDJMk/7FMnu5cmm7W3/2zYBbif4EBK
 YFlHiH1KOr6U6+yXV45rhpNT1zjTAoQSGhgbDe8iSaXNk09yu085OXnqP1Z4KCg=
X-Google-Smtp-Source: AGHT+IHPAxEvR7swT6UVmUDs99ElJWd5uHiVOdjCrb5wHoWsmzwgBkfgSl1iIZTXjHe7Wour1tKFfA==
X-Received: by 2002:a05:6512:114d:b0:52c:dbee:bdb0 with SMTP id
 2adb3069b0e04-52eb99d4e86mr6226794e87.59.1720694997507; 
 Thu, 11 Jul 2024 03:49:57 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279c933c63sm908435e9.19.2024.07.11.03.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 03:49:57 -0700 (PDT)
Message-ID: <86749cab-8c25-4dbf-970e-60d226c0dbf3@opnsrc.net>
Date: Thu, 11 Jul 2024 10:49:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 4/8] hw/acpi: Update GED _EVT method AML with CPU scan
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
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-5-salil.mehta@huawei.com>
 <20240706162845.3baf5568@imammedo.users.ipa.redhat.com>
 <27cc0420-df0b-481e-a58f-e17fa4d02367@opnsrc.net>
 <20240711103403.2eadac1e@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240711103403.2eadac1e@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-lf1-x133.google.com
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


On 11/07/2024 08:34, Igor Mammedov wrote:
> On Thu, 11 Jul 2024 03:29:40 +0000
> Salil Mehta <salil.mehta@opnsrc.net> wrote:
> 
>> Hi Igor,
>>
>>
>> On 06/07/2024 14:28, Igor Mammedov wrote:
>>> On Fri, 7 Jun 2024 12:56:45 +0100
>>> Salil Mehta <salil.mehta@huawei.com> wrote:
>>>   
>>>> OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
>>>> results in start of the CPU scan. Scan figures out the CPU and the kind of
>>>> event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
>>>> method with the call to \\_SB.CPUS.CSCN
>>>>
>>>> Also, macro CPU_SCAN_METHOD might be referred in other places like during GED
>>>> intialization so it makes sense to have its definition placed in some common
>>>> header file like cpu_hotplug.h. But doing this can cause compilation break
>>>> because of the conflicting macro definitions present in cpu.c and cpu_hotplug.c
>>> one of the reasons is that you reusing legacy hw/acpi/cpu_hotplug.h,
>>> see below for suggestion.
>>>   
>>>> and because both these files get compiled due to historic reasons of x86 world
>>>> i.e. decision to use legacy(GPE.2)/modern(GED) CPU hotplug interface happens
>>>> during runtime [1]. To mitigate above, for now, declare a new common macro
>>>> ACPI_CPU_SCAN_METHOD for CPU scan method instead.
>>>> (This needs a separate discussion later on for clean-up)
>>>>
>>>> Reference:
>>>> [1] https://lore.kernel.org/qemu-devel/1463496205-251412-24-git-send-email-imammedo@redhat.com/
>>>>
>>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>>> Tested-by: Zhao Liu <zhao1.liu@intel.com>

[...]

> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 2d6e91b124..33addb6275 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -117,6 +117,9 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                              aml_notify(aml_name("\\_SB.NVDR"),
>                                         aml_int(0x80)));
>                   break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0("\\_SB.GED.CPEV"));
> +                break
>               default:
>                   /*
>                    * Please make sure all the events in ged_supported_events[]
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f4e366f64f..8b4f422652 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1536,7 +1536,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>           };
>           build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
> +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_SB.GED.CPEV");
>       }
>   
> this way build_cpus_aml() will create and populate with scan
> \\_SB.GED.CPEV method.


I see. Perhaps, I failed to realise the semantics in the AML
sense i.e. exporting a call to a method belonging to one scope
to another (\\_SB.CPUS to \\_SB.GED). Yes, with above change
we can avoid calling \\_SB.CPUS.CSCN method direclty from
within GED _EVT. Sorry for the noise.

I will do the change.

Thanks


> PS:
> For legacy cphp handling acpi/cpu.c has only _INI method
> that is created when opts.has_legacy_cphp is true.
> we should be able to get rid of it when 2.6 machine type is removed.
> But ARM [or anything else] don't have to be aware of it
> if you use static initializer like it's done in hw/i386/acpi-build.c
> and just ignore non relevant fields.

ok. thanks for the clarification.

Best regards
Salil.

