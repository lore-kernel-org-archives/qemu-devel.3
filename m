Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A10EC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNWD-000169-VH; Tue, 04 Feb 2025 13:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNW9-0000ya-2E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:19:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNW7-0000Ix-25
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:19:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso41175375e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738693161; x=1739297961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X+V3C13wI19WbwppinARXDTJLUeyMw0OOhmlVqmDOpM=;
 b=tpGhgcqamWly4jJmH67XHcLPf1J0yfNN1dfC5V9wu07rwEsIgSmtPxdXqgvIiU8RI8
 0BOdhvKxST03e7a3pExwzEdWlyO2lsf920BwdPwgZqFwUpz7ho+tMu8/DSe/raK36Vgu
 njwEEU/KYxjpPzAhoa+eh9mj86A3yc+VWW/pOooSTONwk0AwYPVnllTjJsOLEqCyytVP
 0jpEwARPBNRlV6BrLR94JBp8QwnL3VLcj9l0XOmGXizJ13ZbBbdgOOeQED7riJzV14Mf
 bQ22UvZfAKe1Apv0JNn3/HAQQzkpXAoHB3BsRWi8rymNDSQUj62DRUfHm69JhNvjWoS6
 xzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738693161; x=1739297961;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+V3C13wI19WbwppinARXDTJLUeyMw0OOhmlVqmDOpM=;
 b=iRcnCGBscfvIQ4+2vHQVaH+VyZAYgpo4Qf8B3QReFVndC7nCPK/gXXjDtRe5CZCEew
 BieyLluUcD6fyv5oNSjC6mrvqok7bK3k7Ndn2GPEw4nbqBwo/eJaJX5i1QfhmlYv4jOs
 eDazE3U/Th5wrmFBlMDiz6ee9mgN4flypL7GGPZpkrsLtARW6vMoAgL+6xwM/Vf/YZnj
 bvCcjASfei0PCicEHiHW8SdAWXq1XYzBusWP9rahAFPl118r2PQAMKOn8UI1wqK1A2Pq
 IBOklBrfQ2fAeTjCk2CULO1LYImU513GqChjeQNv7ApCmX6SWhN29szTA67ANvW+pAWN
 MEQQ==
X-Gm-Message-State: AOJu0YwtIqBHNZaev9GeG4756hkME23rIbXtPldrw2dYT1THHplMVQdl
 Mo9ZDiIgm0y3v4l364TlTwO8Fw0kQ4ERRVMrwaPou7Nxj2f0kdrQNEeMUkyiH0E=
X-Gm-Gg: ASbGncus7Gh3OEfqOSSW5aUuPVSEQITJ1iVzESoFWvBJYlSqkydQO6UL2KltUeinzia
 07sejLkYbBG0OZ7hn7kseLA5BGpMwU1kOJNHAvUDRoVnHwgE4SKAyld+tmMPvOK7SO3bnP5bz/i
 +NbUtskgzzOcNQGoqpzMSQ7XM5FEoJoZq/tpBVdShAHX0tPlrez7D/QQbb7HIWunWF/1sJB3QtD
 2fRlVM3FEUpTFxJkwlwsmj70zxG6PpTDDTqqIXOliI4DnTN1AiiXDkoH4lt/MCbMSBpP9kqnAy1
 57kXjZmnIt/TXwE0+OkbdGudDvqub2JtcwF6DpO5u+Sbo+/fB2ZNcq2zwFY=
X-Google-Smtp-Source: AGHT+IFoL+flD7toEhvOOU1MHrMf2ey+SaHPko7QFtnwlGwQ7rnef5qlfzSOt7GLSfI7ucu2U776+A==
X-Received: by 2002:a05:600c:350b:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-438dc3cb955mr248206725e9.16.1738693161345; 
 Tue, 04 Feb 2025 10:19:21 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc13202sm239741785e9.5.2025.02.04.10.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 10:19:20 -0800 (PST)
Message-ID: <60fd73a7-cb56-426f-969c-bc715e2462ef@linaro.org>
Date: Tue, 4 Feb 2025 19:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
 <4a2073d0-121e-40c7-b228-d8fb83634061@linaro.org>
Content-Language: en-US
In-Reply-To: <4a2073d0-121e-40c7-b228-d8fb83634061@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 4/2/25 19:17, Philippe Mathieu-Daudé wrote:
> On 4/2/25 14:49, Peter Maydell wrote:
>> On Thu, 16 Jan 2025 at 14:05, David Woodhouse <dwmw2@infradead.org> 
>> wrote:
>>>
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> The vmclock device addresses the problem of live migration with
>>> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
>>> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
>>> counter against an external source of 'real' time, and track the precise
>>> frequency of the counter as it changes with environmental conditions.
>>
>> Hi; I see this has already gone into git, but:
>>
>>> +static void vmclock_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    VmclockState *vms = VMCLOCK(dev);
>>> +
>>> +    /*
>>> +     * Given that this function is executing, there is at least one 
>>> VMCLOCK
>>> +     * device. Check if there are several.
>>> +     */
>>> +    if (!find_vmclock_dev()) {
>>> +        error_setg(errp, "at most one %s device is permitted", 
>>> TYPE_VMCLOCK);
>>> +        return;
>>> +    }
>>> +
>>> +    vms->physaddr = VMCLOCK_ADDR;
>>> +
>>> +    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
>>> +
>>> +    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
>>> +                           VMCLOCK_SIZE, &error_abort);
>>> +    memory_region_set_enabled(&vms->clk_page, true);
>>> +    vms->clk = memory_region_get_ram_ptr(&vms->clk_page);
>>> +    memset(vms->clk, 0, VMCLOCK_SIZE);
>>> +
>>> +    vms->clk->magic = cpu_to_le32(VMCLOCK_MAGIC);
>>> +    vms->clk->size = cpu_to_le16(VMCLOCK_SIZE);
>>> +    vms->clk->version = cpu_to_le16(1);
>>> +
>>> +    /* These are all zero and thus default, but be explicit */
>>> +    vms->clk->clock_status = VMCLOCK_STATUS_UNKNOWN;
>>> +    vms->clk->counter_id = VMCLOCK_COUNTER_INVALID;
>>> +
>>> +    qemu_register_reset(vmclock_handle_reset, vms);
>>
>> No new calls to qemu_register_reset(), please. This is
>> a device, use the device reset API.
> 
> Yeah, mentioned on v7 but then I missed this wasn't considered:
> https://lore.kernel.org/qemu-devel/56e3ad5c-758b-4799-86a4- 
> bb503aa34cea@linaro.org/

Ah, there is not v8, this is v7 where it was mentioned :)
Probably not clearly enough, I shouldn't insisted.

