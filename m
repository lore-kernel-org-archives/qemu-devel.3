Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D5CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBtEW-0001TJ-3K; Wed, 30 Sep 2026 08:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBtET-0001Sa-4J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:16:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBtEQ-0001Ju-OP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:16:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7bZ53135736
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 goEbtEfeRtJMDPsvnvy+NTFIkM9CHsUM+9pQjtFe+LI=; b=XDw3/6WWIQzjY+9H
 hDn7khGop09DpVeo4gOke/FbEj6toQduTAJbz57I/+FQAbNjVuQ8FNGdE6uXD3ua
 UkrBDun3ttpGDylcl5dQQf2anD5uHNfhg024j1N8AJEwGR3Efnx2zHTBFl7qgQ8/
 JEGC6KujBvJAjBOo2VcUo+Ow4gwckDmvzGCRsu+DEqtUMpms5JswJrym6bdhoTFV
 sjp9xXC+ZAlNNWHA33BIP2CgO4MjWSz8LeZIAtp8uZ3ZY1wKQrdZf7MfsIsvtqLN
 uKhIXOnc2WzRb+z+fp11AJbz+Ln8/aami9WdVyyL7rRyNv5RAqGpHGKoV0D9YP87
 i6OeNg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27h988-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:16:16 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf1e774404so40629137.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790770576; x=1791375376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=goEbtEfeRtJMDPsvnvy+NTFIkM9CHsUM+9pQjtFe+LI=;
 b=ERXwTnwxq4NIWTwEQovkToKLXwDGfN/ycwLJ0XTse6t3KgwRTaO9el15OEIBsYTHvg
 fgXJFInVnsO3j/RUrsNbk7V3rwzTmCzp0FYc+z5OtaCOud/XzoQUCPGK+oJsVpUFkIQg
 bhhcmCJR2feqV+e/52agH2eLLOJd/yhTZhVPA/7sQWdD0FEnOHqJuQK0kxGvw8jc+PDK
 Nu3Jru/ygOCyJR79Gr32WZINva7KF+D1x9GFaMEYGUQ5SKHP1Jn7D3Wn43fX4EFlY3Rv
 jbPxApexnJZNIJkrqir4QuG/yTOTXKWVwacNgVxvWOX3L1YUPbLJdyzUr6oBNc2x0fPy
 NgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790770576; x=1791375376;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=goEbtEfeRtJMDPsvnvy+NTFIkM9CHsUM+9pQjtFe+LI=;
 b=CeZR1ans0wfqOCelNQHi8+3R0qBmPp5rf+718DYkl3UNYlK58bThBUtZu2zHbGLYC8
 WbnlgFnx6nb9ELnpRcqxCazcYFxbx0uuxoN99rhD2X4k9f+HxHeJeIqQHsroWy3LTfEU
 +LUE6aI9PUgfql5FUVrO4Fz31xIAEi6QNtm0+Gbk6uIVAUjtGcJ1+MNOWF09dCNL1GMK
 P/iCJOODhsALde84D1xcNA4KVxADRsIU4wOx89MYF+hYsb2Ftu8QarmVRCBl//dVTkVy
 rNVzIcULeat8mdv2uHHw76JcxQidNxss7PVgF8k4Qgl/AT8aFxrNAc0//B0N1PAB9D6C
 dA7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPJyIS7eLmftTQSlMZxaoLQvrtcSJ0AbIePQ1A2iLkllhgOLwnM59yanbpoFySmOYgwdtaqUDMGtFa@nongnu.org
X-Gm-Message-State: AFq9FYLFCRQS47ZqIt+5V84H9T85soZoeMa3qnVZXpYFPqqDmoG8JqgY
 TCSDmyiJ0akpRSGQx0WrclgYqPKP0saV09EMwJqiYIhZOggsLrD2d1n7H09oteYhDyoSQ3oOGoi
 P+tl31r+nrS/rRDmhEfWUfv9SXGWApawPO1VskOkHz+HUgv+D4HkckIsJZA==
X-Gm-Gg: AYBFou3cT517QJGC9VU//ET5hcommdA4vMtL4GAI4PBoJhfJ9gAjh922RLl+WgOlAjq
 SJK4UeqRMIgz9guKwMK4zp2fiZaMMSvxopR2lv8M3ph1KysDEGijEWdUA3Od3b0k8jv/P2ZIPHj
 ENI9bW/r9XSYuH3w7dAhPzbz7SUcpXVqfSVNudwhbauZpU/SvSocrYv41c0O84qlwj8IsDGVavi
 MjqM+/AC4sONmuY3EqI9t0rQP5guqvdUo6RZ6h0GHRwTu070t2eb8/1G0eL48m1H5avbOhdthe+
 ofv2wd74Y9j8CfJN9K4RdRNm/36XVtatsIORvzDJk1wRuwUKRzr5BHws9L+gSUbwHEQBwX5a5XW
 MVW03J/RU3jIfgyvhOFfvmb3vDF39r4Xajw==
X-Received: by 2002:a05:6102:5691:b0:7a7:19aa:f0cf with SMTP id
 ada2fe7eead31-7be73e9a332mr174422137.28.1790770575675; 
 Wed, 30 Sep 2026 05:16:15 -0700 (PDT)
X-Received: by 2002:a05:6102:5691:b0:7a7:19aa:f0cf with SMTP id
 ada2fe7eead31-7be73e9a332mr174412137.28.1790770575053; 
 Wed, 30 Sep 2026 05:16:15 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm3097737f8f.27.2026.09.30.05.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 05:16:14 -0700 (PDT)
Message-ID: <1197c1ca-14d5-48c1-b497-0c03a781c258@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 14:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and table
 for unimplemented devices
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-2-jamin_lin@aspeedtech.com>
 <941d7bb6-3205-44cf-8d76-ffbb322a6f4e@oss.qualcomm.com>
 <0cd87753-da91-44ed-a629-43099bfb820d@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0cd87753-da91-44ed-a629-43099bfb820d@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0OCBTYWx0ZWRfX7VT6H0jvGV9k
 MPv70nPIRqF6k1SgrxJvlivs6dKU8x9CPW0G8bo5LWbkxRJaY+pfxsBIZF6cF8TUYaEeHqwU5Sa
 4f2rP07oLoLXOSoMkAcNqNyDkhus0WU=
X-Proofpoint-GUID: TOt60bzWKXb6tr4R93SbW17lvSSLoN0W
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abcfd90 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bypl4A9ATimtlkDC95sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0OCBTYWx0ZWRfXyr7Su4+tqHWY
 LIqjS+ZYHrSo9x+CHKN+FusTlW8SSPYOEYnBfSmM+PZ6xQeZDlThpkS2ZoKzI8CLTd7fejf4vFg
 cUVPLUtrXI8O3YDCarwhORHke+n/5IQYLixHJkRX/YmWRQ5sMYQYJplQ9CZWYtz8bpSvmpD7Ita
 lhlslsDLKlVxueALvXx+bOn4t91vLhvonJHVCqpMIDgSNn9RbFfX10wXzzpCcTdXHmQv5qr1Tj/
 yWH6syohKeivOio2OUOG3P1YHLRMaUYCtdHOgla+guwHxDFnjDyYqHU3zB6GtB+jgIa3JOt+r9E
 kn169uoXSnSc/nYDEdJsiO6ByVy9TXDolL4nUMcaKTmnAOIlrmJU3906VLGE6tzdTzVGFNLBMdw
 yV+R2DuCgncs5vhl7SMAkxJwYLqa1XuRlwzCRZLRbG6DHyOH/mjY3BFbRLyN6lu2vjKDLWxw0Cy
 s++UcWw6Y0kwQLnXdUw==
X-Proofpoint-ORIG-GUID: TOt60bzWKXb6tr4R93SbW17lvSSLoN0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/9/26 13:50, CÃ©dric Le Goater wrote:
>> Note to Peter: I really think keeping duplicating the
>> UnimplementedDeviceConfig structure is a basic software
>> development antipattern. Could you reconsider your objection?
> What's the background ?

I think that was discussed on IRC, the only ref on the list is:
https://lore.kernel.org/qemu-devel/CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmcqkk-gJH+s1mHuvFp8g@mail.gmail.com/

create_unimplemented_device() calls qdev_create() and allocate on the
heap, my motivation was to have another helper for in-place init (when
the UnimplementedDeviceState state is embedded in the parent). Now we
ended with such helpers like aspeed_mmio_map_unimplemented() which
realize in place, make_unimp_dev() and create_unimp() init and realize
in place and Jamin adds yet another pattern. While all are valids,
I'd rather unify. Maybe this is now back to the "qdev alloc vs qdev
struct embedded" discussion we never figured out.

hw/arm/aspeed_ast1040.c:127:    object_initialize_child(obj, "pwm", 
&s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast1040.c:128:    object_initialize_child(obj, "espi", 
&s->espi, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast1040.c:129:    object_initialize_child(obj, "udc", 
&s->udc, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast10x0.c:165:    object_initialize_child(obj, "iomem", 
&s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast10x0.c:166:    object_initialize_child(obj, "pwm", 
&s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast10x0.c:167:    object_initialize_child(obj, "espi", 
&s->espi, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast10x0.c:168:    object_initialize_child(obj, "udc", 
&s->udc, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast2400.c:243:    object_initialize_child(obj, "iomem", 
&s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast2400.c:244:    object_initialize_child(obj, "video", 
&s->video, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast2600.c:285:    object_initialize_child(obj, "iomem", 
&s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast2600.c:286:    object_initialize_child(obj, "video", 
&s->video, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/aspeed_ast2600.c:287:    object_initialize_child(obj, "dpmcu", 
&s->dpmcu, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/bcm2835_peripherals.c:40:    object_initialize_child(OBJECT(ps), 
name, uds, TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/mps2-tz.c:440:    object_initialize_child(OBJECT(mms), name, uds, 
TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/musca.c:146:    object_initialize_child(OBJECT(mms), name, uds, 
TYPE_UNIMPLEMENTED_DEVICE);
hw/arm/bcm2835_peripherals.c:36:void 
create_unimp(BCMSocPeripheralBaseState *ps,
hw/arm/bcm2835_peripherals.c:521:    create_unimp(s, &s->txp, 
"bcm2835-txp", TXP_OFFSET, 0x1000);
hw/arm/bcm2835_peripherals.c:522:    create_unimp(s, &s->armtmr, 
"bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
hw/arm/bcm2835_peripherals.c:523:    create_unimp(s, &s->i2s, 
"bcm2835-i2s", I2S_OFFSET, 0x100);
hw/arm/bcm2835_peripherals.c:524:    create_unimp(s, &s->smi, 
"bcm2835-smi", SMI_OFFSET, 0x100);
hw/arm/bcm2835_peripherals.c:525:    create_unimp(s, &s->bscsl, 
"bcm2835-spis", BSC_SL_OFFSET, 0x100);
hw/arm/bcm2835_peripherals.c:526:    create_unimp(s, &s->dbus, 
"bcm2835-dbus", DBUS_OFFSET, 0x8000);
hw/arm/bcm2835_peripherals.c:527:    create_unimp(s, &s->ave0, 
"bcm2835-ave0", AVE0_OFFSET, 0x8000);
hw/arm/bcm2835_peripherals.c:528:    create_unimp(s, &s->v3d, 
"bcm2835-v3d", V3D_OFFSET, 0x1000);
hw/arm/bcm2835_peripherals.c:529:    create_unimp(s, &s->sdramc, 
"bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
hw/arm/bcm2838_peripherals.c:182:    create_unimp(s_base, &s->clkisp, 
"bcm2835-clkisp", CLOCK_ISP_OFFSET,
hw/arm/bcm2838_peripherals.c:196:    create_unimp(s_base, &s->asb, 
"bcm2838-asb", BRDG_OFFSET, 0x24);
hw/arm/mps2-tz.c:429:static MemoryRegion 
*make_unimp_dev(MPS2TZMachineState *mms,
hw/arm/mps2-tz.c:981:                { "i2s-audio", make_unimp_dev, 
&mms->i2s_audio,
hw/arm/mps2-tz.c:988:                { "gfx", make_unimp_dev, &mms->gfx, 
0x41000000, 0x140000 },
hw/arm/mps2-tz.c:989:                { "gpio0", make_unimp_dev, 
&mms->gpio[0], 0x40100000, 0x1000 },
hw/arm/mps2-tz.c:990:                { "gpio1", make_unimp_dev, 
&mms->gpio[1], 0x40101000, 0x1000 },
hw/arm/mps2-tz.c:991:                { "gpio2", make_unimp_dev, 
&mms->gpio[2], 0x40102000, 0x1000 },
hw/arm/mps2-tz.c:992:                { "gpio3", make_unimp_dev, 
&mms->gpio[3], 0x40103000, 0x1000 },
hw/arm/mps2-tz.c:1035:                { "i2s-audio", make_unimp_dev, 
&mms->i2s_audio,
hw/arm/mps2-tz.c:1045:                { "clcd", make_unimp_dev, 
&mms->cldc, 0x4130a000, 0x1000 },
hw/arm/mps2-tz.c:1051:                { "gpio0", make_unimp_dev, 
&mms->gpio[0], 0x41100000, 0x1000 },
hw/arm/mps2-tz.c:1052:                { "gpio1", make_unimp_dev, 
&mms->gpio[1], 0x41101000, 0x1000 },
hw/arm/mps2-tz.c:1053:                { "gpio2", make_unimp_dev, 
&mms->gpio[2], 0x41102000, 0x1000 },
hw/arm/mps2-tz.c:1054:                { "gpio3", make_unimp_dev, 
&mms->gpio[3], 0x41103000, 0x1000 },
hw/arm/mps2-tz.c:1102:                { "i2s-audio", make_unimp_dev, 
&mms->i2s_audio, 0x49301000, 0x1000 },
hw/arm/mps2-tz.c:1111:                { "clcd", make_unimp_dev, 
&mms->cldc, 0x4930a000, 0x1000 },
hw/arm/mps2-tz.c:1117:                { "gpio0", make_unimp_dev, 
&mms->gpio[0], 0x41100000, 0x1000 },
hw/arm/mps2-tz.c:1118:                { "gpio1", make_unimp_dev, 
&mms->gpio[1], 0x41101000, 0x1000 },
hw/arm/mps2-tz.c:1119:                { "gpio2", make_unimp_dev, 
&mms->gpio[2], 0x41102000, 0x1000 },
hw/arm/mps2-tz.c:1120:                { "gpio3", make_unimp_dev, 
&mms->gpio[3], 0x41103000, 0x1000 },
hw/arm/mps2-tz.c:1141:                { "sram-timing-adapter", 
make_unimp_dev, &mms->ta[0], 0x41700000, 0x1000 },
hw/arm/mps2-tz.c:1142:                { "qspi-timing-adapter", 
make_unimp_dev, &mms->ta[1], 0x41701000, 0x1000 },
hw/arm/mps2-tz.c:1143:                { "ddr4-timing-adapter", 
make_unimp_dev, &mms->ta[2], 0x41702000, 0x1000 },
hw/arm/mps2-tz.c:1167:                { "i2s-audio", make_unimp_dev, 
&mms->i2s_audio, 0x49301000, 0x1000 },
hw/arm/mps2-tz.c:1176:                { "clcd", make_unimp_dev, 
&mms->cldc, 0x4930a000, 0x1000 },
hw/arm/mps2-tz.c:1182:                { "gpio0", make_unimp_dev, 
&mms->gpio[0], 0x41100000, 0x1000 },
hw/arm/mps2-tz.c:1183:                { "gpio1", make_unimp_dev, 
&mms->gpio[1], 0x41101000, 0x1000 },
hw/arm/mps2-tz.c:1184:                { "gpio2", make_unimp_dev, 
&mms->gpio[2], 0x41102000, 0x1000 },
hw/arm/mps2-tz.c:1185:                { "gpio3", make_unimp_dev, 
&mms->gpio[3], 0x41103000, 0x1000 },
hw/arm/mps2-tz.c:1195:                { "qspi-controller0", 
make_unimp_dev, &mms->qspi_controller[0],
hw/arm/mps2-tz.c:1197:                { "qspi-controller1", 
make_unimp_dev, &mms->qspi_controller[1],
hw/arm/mps2-tz.c:1199:                { "qspi-controller2", 
make_unimp_dev, &mms->qspi_controller[2],
hw/arm/musca.c:137:static MemoryRegion *make_unimp_dev(MuscaMachineState 
*mms,
hw/arm/musca.c:325:        { "spi", make_unimp_dev, &mms->spi, 0x3000, 
0x1000 },
hw/arm/musca.c:326:        { "i2c0", make_unimp_dev, &mms->i2c[0], 
0x4000, 0x1000 },
hw/arm/musca.c:327:        { "i2c1", make_unimp_dev, &mms->i2c[1], 
0x5000, 0x1000 },
hw/arm/musca.c:328:        { "i2s", make_unimp_dev, &mms->i2s, 0x6000, 
0x1000 },
hw/arm/musca.c:329:        { "pwm0", make_unimp_dev, &mms->pwm[0], 
0x7000, 0x1000 },
hw/arm/musca.c:331:        { "qspi", make_unimp_dev, &mms->qspi, 0xa000, 
0x1000 },
hw/arm/musca.c:332:        { "timer", make_unimp_dev, &mms->timer, 
0xb000, 0x1000 },
hw/arm/musca.c:333:        { "scc", make_unimp_dev, &mms->scc, 0xc000, 
0x1000 },
hw/arm/musca.c:334:        { "pwm1", make_unimp_dev, &mms->pwm[1], 
0xe000, 0x1000 },
hw/arm/musca.c:335:        { "pwm2", make_unimp_dev, &mms->pwm[2], 
0xf000, 0x1000 },
hw/arm/musca.c:336:        { "gpio", make_unimp_dev, &mms->gpio, 
0x10000, 0x1000 },
hw/arm/musca.c:463:                { "eflash0", make_unimp_dev, 
&mms->eflash[0],
hw/arm/musca.c:465:                { "eflash1", make_unimp_dev, 
&mms->eflash[1],
hw/arm/musca.c:467:                { "qspi", make_unimp_dev, &mms->qspi, 
0x42800000, 0x100000 },
hw/arm/musca.c:472:                { "mhu0", make_unimp_dev, 
&mms->mhu[0], 0x42600000, 0x100000 },
hw/arm/musca.c:473:                { "mhu1", make_unimp_dev, 
&mms->mhu[1], 0x42700000, 0x100000 },
hw/arm/musca.c:484:                { "pwm0", make_unimp_dev, 
&mms->pwm[0], 0x40101000, 0x1000 },
hw/arm/musca.c:485:                { "pwm1", make_unimp_dev, 
&mms->pwm[1], 0x40102000, 0x1000 },
hw/arm/musca.c:486:                { "pwm2", make_unimp_dev, 
&mms->pwm[2], 0x40103000, 0x1000 },
hw/arm/musca.c:487:                { "i2s", make_unimp_dev, &mms->i2s, 
0x40104000, 0x1000 },
hw/arm/musca.c:490:                { "i2c0", make_unimp_dev, 
&mms->i2c[0], 0x40108000, 0x1000 },
hw/arm/musca.c:491:                { "i2c1", make_unimp_dev, 
&mms->i2c[1], 0x40109000, 0x1000 },
hw/arm/musca.c:492:                { "spi", make_unimp_dev, &mms->spi, 
0x4010a000, 0x1000 },
hw/arm/musca.c:493:                { "scc", make_unimp_dev, &mms->scc, 
0x5010b000, 0x1000 },
hw/arm/musca.c:494:                { "timer", make_unimp_dev, 
&mms->timer, 0x4010c000, 0x1000 },
hw/arm/musca.c:496:                { "pvt", make_unimp_dev, &mms->pvt, 
0x4010e000, 0x1000 },
hw/arm/musca.c:497:                { "sdio", make_unimp_dev, &mms->sdio, 
0x4010f000, 0x1000 },
hw/arm/musca.c:503:                { "gpio", make_unimp_dev, &mms->gpio, 
0x41000000, 0x1000 },


