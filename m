Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EB606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L6p5+31i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NEYCESXN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOt9c-0001JI-Su; Thu, 05 Nov 2026 03:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOt9a-0001IZ-MX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:49:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOt9X-0002fx-RJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:49:02 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56V2iO2588239
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 08:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wjJ85LgyeqsJ8KDinz12ucUbYjwUnfQ/a7Y/maLZRrU=; b=L6p5+31iWBYxlSZV
 Exybqhv+aeWjwGyRcwrgz1BDveXUmTJS9sU4L1CH0DZ653lLj5y4/wOQISVCu0V6
 kSXEOgeVV7dsSDzRAUEkaK55JEjn5GZ7crIgonxIICEFCw0JCX5mBRq3X7t7hKno
 0xEtrkv8rsq7fMrS+Dz07bIEgpDmIsx+qX8nszJm+zLms+2/L8GdNpmJqBj22pkz
 6tHaUQEEKs3lur9bfqSyjiRy0kde9hglKShFjWpVpBRZ59xKWQILd9S1tjiiEp56
 v2lYos4juVRnHpBSVhBcBY/wLld9sy+Q9h/8Wqtgy3+/9d/+BW1dWO0XmhyocYaT
 Jahslg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89sukj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:48:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-542fc61841eso32788151cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793868534; x=1794473334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wjJ85LgyeqsJ8KDinz12ucUbYjwUnfQ/a7Y/maLZRrU=;
 b=NEYCESXNRNBq2N8tIyJYBcuseO0qc78dPK20ihdF5h7r8pWY2nFpgbgSVoQ+FdUAX0
 Nh2lMgCrVzghWmCYBnPDovTY7HJ0Y4204bGa4W6wD9clSb7T4XhgEWp0wpn7T8yrV+4M
 sAUOdO2qaZpnSlGQzIEC3qydlSU4nk7a0vRVtSXP8JUnNFOUAUp9bne+WWcQq1/DBy/m
 4e37PDvTeVvAmDrN0ixzengpInMbjHCxXRxeKyl6W5EvvpvJGOhPf4iH/0JQJiITevsi
 nvnxQapjdvwCsDOheYjueGCIVu8o26ERcRDXkHfoFyTlHyqCdEWOgkibvF89ownxYFSQ
 TZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868534; x=1794473334;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wjJ85LgyeqsJ8KDinz12ucUbYjwUnfQ/a7Y/maLZRrU=;
 b=AMJXqWilLngFuaWIQ0Zjc5+BGLUG1SnbtZebFquJ9ie1v6gmtXb5OVXsjfc3YO7YMa
 LFvUm0BQ/qp1oruz8Jy7xmrN1M1MIJiCU7YzdTcDp4/+iIForFCGnErF1hOiddxmC4Kd
 ECBZPNT0kBGoX8aTyg6xRp5qcGMoO8SJN3Imvhde50kK8O/mGNjsNM4Yz4YXcB3Elits
 KBVGQnP1V8Wet2iM4yXY/HPbG2R8XRY1tjVnNZfYANKZM9Q6gOxs83GYpnPuYhMJwu4R
 KMylHT1ufS001FxeEwPpaOXwqsFR/2UZ5Z95ZNduo3O2gQQ1UAxEbSd6xfiR4Q1FXurr
 iznA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnm06DWr3/Jsif8v0XaRkY0gH7O+MLK3Ir9DeK3yFSINPXMIkC1HERbSWGQIb0LmR0gVDDC0ebBenc@nongnu.org
X-Gm-Message-State: APuU4Z/YLYzt1JC422dJTgh5doV9PTzawcTfTAlJWgAAqm0Id/WWbpPk
 HxTPHvLolkEY4QiX1SlJkLzcKhkYmilsn68kYpEniEHCDfQ4lpRlWngGTqaZKiDdp622avfCyj+
 e7pwTisOU+tGnxG4pdKmgu3RX1T7CwszikiPUsu4An6j3Xszo3/41N2PxMw==
X-Gm-Gg: AYBFou1f0hQHHZbW3XuOd3wvOSsj84dWVS1n9ADhvN0nyNKx/A4sREnGnlS3AhJA2xc
 yGsvUwrrLCpxCUbB/UG2YCPqvVFMU8m7eBGMsEuwWDv3FrrpKhZXi1G+LdATsaUNo2ilJMj7yTK
 DOOFlpjP7Ng1EOdlvIfD/HY0woRnD3C3GMuFV5vXLSmMtkZj/oxsyWPpUdpee0iu7t2uKdmnjMw
 FMRdj9XOIXI/U1kmkdjE4qEBXfI+4SepVPfWSSkf85w6iOeztU3vXxP9EcbwYX5AQ5XdzjAoQxe
 yB/+dbxSZ0ewf9C8JsrEUc4hEqiewGBOLB6Gc9N+JtpEgRr3zsJ0JhDwy49tChs5R5rw/xsDsDY
 wLqMZqjJJkQr7EbFewZDmADqQcR43VUgCwmNwvftk4u7K9uFcVIU0VTfSwa45Zl0U38MN6R6YTA
 5/rK6ENsv6
X-Received: by 2002:ac8:5d46:0:b0:537:5488:a6ea with SMTP id
 d75a77b69052e-542b7334c27mr330106461cf.46.1793868534282; 
 Thu, 05 Nov 2026 00:48:54 -0800 (PST)
X-Received: by 2002:ac8:5d46:0:b0:537:5488:a6ea with SMTP id
 d75a77b69052e-542b7334c27mr330106241cf.46.1793868533643; 
 Thu, 05 Nov 2026 00:48:53 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b10a6ca24sm47434901cf.14.2026.11.05.00.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:48:52 -0800 (PST)
Message-ID: <c5eb34c2-dfd4-49aa-96d0-9ac162d13204@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 05:48:48 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/riscv: do not realize the device in
 riscv_create_iommu_sys()
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
 <20261023160913.24992-2-daniel.barboza@oss.qualcomm.com>
 <3bdd1bbf2a30ce25c4019b0ac4f3f6ab95058715.camel@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3bdd1bbf2a30ce25c4019b0ac4f3f6ab95058715.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R84d6xvWJZa1rqPmdgfg1VyiSltvw5-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX6A1rvcqXa4OE
 MGIc0rXVQMXv0QAMavFzTJS5mQsi3PwiEQeWLhvFktnGsv3pV/v/5eabOma5y7YRemWL5BlJYAq
 x3mqvD0u9+aopRP5qc6CDLD9pJL6a+kkql8u3oA4zhVgwZ8agco44dffDVBudRPXV+6OfyTHNkd
 n7hQtG/ol8XgjRLo7P2hD25Hv7vExlFevtqJeDfMl0vEufrjiavuSEr8t3ifAOYTyuG2o0E2TLa
 NOckgp/7alimtLvAu9N7PMMrdZ0RGs3EZrDt+HgAEEmjrOCb7WGsKiRJrAuqVvzZZ4c7Brw/p6F
 Xo/piZnyTEBOWR0iav5sTqC2rx0kuNt8ZAUA4MinZCbo/+S0c8WbVaGUYzfy6B0rvYprXMoOt/K
 yTvDVOYoyTATPPFQUSBaujDP2yF5Ncy6lDczp9A1ux0DQ3O9SehqZG0TpQH0B02HpJZZxWxPhf5
 hqrpzV9Oc90oerWQdgw==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aec42f7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LQvE5zGBNe+6ot3hfEwogQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hPZfh_vYXEPJFLOR3nUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: R84d6xvWJZa1rqPmdgfg1VyiSltvw5-3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX3OB0UQAzn9i1
 a3P+iz7IId5IIE23cgeGh/PrZNHMpjen6eLkjMk3Bgx2i84RhuTPehydfpYfboLRly1esFOAMDc
 vBbMWs6Qjamrh0gOpmZQM8fFePvvKPw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/2026 1:58 AM, Alistair Francis wrote:
> On Fri, 2026-10-23 at 13:09 -0300, Daniel Henrique Barboza wrote:
>> The riscv-iommu-sys device inherits all properties from its
>> associated
>> riscv-iommu device via qdev_alias_all_properties() during sys_init().
>>
>> We're also providing riscv_create_iommu_sys(), a helper to
>> instantiate
>> the device and avoid duplicating code between boards.  In its current
>> state the helper is realizing the device before returning it to the
>> caller, prevents any additional setup of the device (we can't change
>> device props after realize).
>>
>> Split the realization code from the helper and make the boards
>> realize
>> the device manually.  It's a small inconvenience to pay to be able to
>> config the iommu-sys device.
>>
>> Signed-off-by: Daniel Henrique Barboza
>> <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/riscv-iommu-sys.c     | 3 +--
>>   hw/riscv/server_platform_ref.c | 7 +++++--
>>   hw/riscv/virt.c                | 9 +++++++--
>>   3 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
>> index 258c171efd..190ab0b646 100644
>> --- a/hw/riscv/riscv-iommu-sys.c
>> +++ b/hw/riscv/riscv-iommu-sys.c
>> @@ -217,6 +217,7 @@ static void riscv_iommu_sys_init(Object *obj)
>>       riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_BOTH);
>>   }
>>   
>> +/* Note: the returned iommu_sys device needs to be realized.  */
> 
> Is this really necessary just to set hpm-counters?
> 
> It seems like this is a bit brittle for one property

If we want to just set 'hpm_counters' we can add a parameter in riscv_create_iommu_sys()
and be done with it.  In case we have the need to set other things in the future we can
add additional parameters, even an 'IOMMUProps' struct like we do with the FDT stuff.

Or we can do what we're doing here and let the board set whatever they want by splitting
init() and realize() of the device.  Both are fine to me.


Thanks,
Daniel

> 
> Alistair
> 
>>   DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
>>                                       hwaddr addr, int base_irq,
>>                                       bool is_32_bit)
>> @@ -237,8 +238,6 @@ DeviceState *riscv_create_iommu_sys(DeviceState
>> *mmio_irqchip,
>>                                is_32_bit ? 34 : 56,
>>                                &error_fatal);
>>   
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys),
>> &error_fatal);
>> -
>>       return iommu_sys;
>>   }
>>   
>> diff --git a/hw/riscv/server_platform_ref.c
>> b/hw/riscv/server_platform_ref.c
>> index 5f485b1c79..e9536515da 100644
>> --- a/hw/riscv/server_platform_ref.c
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -481,6 +481,7 @@ static void
>> rvserver_ref_machine_init(MachineState *machine)
>>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>>       MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
>>       DeviceState *mmio_irqchip, *pcie_irqchip;
>> +    DeviceState *iommu_sys;
>>       int i, base_hartid, hart_count;
>>       int socket_count = riscv_socket_count(machine);
>>       int imsic_bits;
>> @@ -635,8 +636,10 @@ static void
>> rvserver_ref_machine_init(MachineState *machine)
>>           create_fdt(s, memmap);
>>       }
>>   
>> -    riscv_create_iommu_sys(mmio_irqchip, s-
>>> memmap[RVSERVER_IOMMU_SYS].base,
>> -                           IOMMU_SYS_IRQ, false);
>> +    iommu_sys = riscv_create_iommu_sys(mmio_irqchip,
>> +                                       s-
>>> memmap[RVSERVER_IOMMU_SYS].base,
>> +                                       IOMMU_SYS_IRQ, false);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys),
>> &error_fatal);
>>   
>>       s->machine_done.notify = rvserver_ref_machine_done;
>>       qemu_add_machine_init_done_notifier(&s->machine_done);
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index d4b501802f..39381cb21d 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -940,8 +940,13 @@ static void virt_machine_init(MachineState
>> *machine)
>>       }
>>   
>>       if (virt_is_iommu_sys_enabled(s)) {
>> -        riscv_create_iommu_sys(mmio_irqchip, s-
>>> memmap[VIRT_IOMMU_SYS].base,
>> -                               IOMMU_SYS_IRQ, riscv_is_32bit(&s-
>>> soc[0]));
>> +        DeviceState *iommu_sys;
>> +
>> +        iommu_sys = riscv_create_iommu_sys(mmio_irqchip,
>> +                                           s-
>>> memmap[VIRT_IOMMU_SYS].base,
>> +                                           IOMMU_SYS_IRQ,
>> +                                           riscv_is_32bit(&s-
>>> soc[0]));
>> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys),
>> &error_fatal);
>>       }
>>   
>>       s->machine_done.notify = virt_machine_done;


