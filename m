Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312BEC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RTd-0002Em-1J; Fri, 04 Sep 2026 06:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RTb-0002EW-FY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:48:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RTZ-0005kM-PZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:48:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIZVJ3783254
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 10:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +bvNM3wZUvKzo+xhF2KpVPwfaQdvI2hAOLpGVpByISw=; b=aL8WutwQsSw6lMBb
 a+R55VeTSVzjWT03i4LIuRDm3r7czf6CkA2t+g3zitsoFPn/xd9e1VM8Y/dXPzLz
 UyUczEmPVkMAZgx+QVcWhUJaOanCRgOUkQCE8BvNan/s/DBnUoQkIPmUctzNxB61
 CBBRlLb9Gt/nfTSVaft65LbaAZC9Ykbjfy9eJsN0awj7LXiLR+XXxlqrAUBgalaP
 J0uj7nCl2iVjNfTXfHBrA521crfvX/NFMYP/T/dz1+d6Gts+tQwQ1V5Dyo2JoANv
 yrnWhgKyRcb3q1aGLHmZLzhxsPzLHdKugNKUc/3G93xEdEDhb2/NGrx9PwIwoeqb
 DNxHrA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfhc9t8nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 10:48:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930edb4362dso134594485a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788518932; x=1789123732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+bvNM3wZUvKzo+xhF2KpVPwfaQdvI2hAOLpGVpByISw=;
 b=dDjvd32UceDDisJV7KGF617aKq8E6spQMbhpPURzTatBd7mpI1uFTVu9Ee/AMyU8CS
 VYq2Z6hwb6Wdrup6QnXMvrEvZYKJ5+IgVMQlV1N++dArow4xwIzk/XtNFP6X9jSGcaOV
 z8+a/FmcKzvhtLRekZcFA2aDFxyDGnHgzO6bOchvJzABmj1TeaTF/PNvRuCMt7Jx93Nf
 VELpTNe7BghE9MnkXguE+yM7vnB0SdjQsqvICSFeKK+56wVdrg32JH7XwfOhD10h1Epi
 aVqrwBtgE6+43eQ6Tsgl1hy+MNDaoenHV9GQbhSkDSQH8fUqDOw95zwK3OdFWno56Ow2
 UxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518932; x=1789123732;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+bvNM3wZUvKzo+xhF2KpVPwfaQdvI2hAOLpGVpByISw=;
 b=BM86lcQTel3Pddc3cylUYkVcZYVhb6x24wU5eFcpxjMdqbtCqgRKX1iHUeHqNuVnOE
 6clHXNfQWOfNWHaEH8o5FH2sAep0aSitxYZEV7Sd/KTQ4jlXfiE0icS2Uy6rLw+ymKkd
 KPk5ufpsIyxnuP7P00KcLQ+Z/4rJyZa61QhgT0JZDP/vZDw4QyOsE1CvBbpa1NHkJR0o
 6jBAkh2YZFO/a1XRowJIMH0yQ6jgvb6xPChYzvBgnrl0VOtXTdf5n8mwv1hyRppmVyPP
 WHWdCqDBjN/AT8gme7RNv+KBY/w7eGaQZcmx9wC+eVYGOHqwuQsO2sMApNq0hhPevNJn
 rJAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy//CQBmEBA79yx25cZmzzHJRvdB8OI7kiKnMud8B7ZuBFr1qglrtLSm5J6Isz4IdUzgwEgQKaAX3/M@nongnu.org
X-Gm-Message-State: AFuF++lkQGCaGhrcveuFlC7ZOHlIt5XavabyZ5xZ1SXYyXWZFz6A+fNl
 LhsUwO6/6Z5UxnBRF5IfQO87HC+DDKJuK5WGNR7RjYOtltHN9dE/8plK+SFrsmTMyQmAEfpJ7RY
 JX2GjqczngSG0p1++jXCWqnzYqKHle2zD5H0IrdeTTxZQvc0DEYnjjyti3w==
X-Gm-Gg: AYBFou3d3uFEvC98e5zo8RO5UXkQCm6W9HHnumOmoummeQq/kotBfrPZmPRV+yq7usp
 pBYqnSl7MSuXchozoJVgM/hH5VPP4Ie1eTaSx5dGe1PbnOZ8gdesjSjQEZ4zUUIAQu67ct5FWTF
 fIdd/VQqmjP3jrVQYytimGDQNK7M5D19QQt7wg3eouwfwxZE/SjPryHO3CKxfzodbpcfCaZc/WL
 TzdBLQuS/ynu/w/Go+rMkdN2d2+iKTUWr8MM+GcpaqAoBCUcZ5uFmHE/G+sP/GLNWFZUxKRAfMg
 Fffh5X8FNb47zvHa77tkcw1/l0qrfk5AWl4DTUf5ikRxXT9RG6kqDjo76DGp/2hY9poOZ1P5T0f
 OgLl/lTFq1D+IypRas0MuL3GatVIdCMINVw==
X-Received: by 2002:a05:620a:28c9:b0:939:6c4d:9f64 with SMTP id
 af79cd13be357-93980324691mr461122785a.1.1788518931626; 
 Fri, 04 Sep 2026 03:48:51 -0700 (PDT)
X-Received: by 2002:a05:620a:28c9:b0:939:6c4d:9f64 with SMTP id
 af79cd13be357-93980324691mr461118485a.1.1788518931195; 
 Fri, 04 Sep 2026 03:48:51 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm71115875e9.10.2026.09.04.03.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 03:48:49 -0700 (PDT)
Message-ID: <284df847-4ea7-497c-9d86-32c19a3d603e@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 12:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] hw/riscv/atlantis: Extract an Atlantis SoC device
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260903055131.257903-1-joel@jms.id.au>
 <20260903055131.257903-16-joel@jms.id.au>
 <5d681d59-4a2f-4068-b36d-4ca40ab7b921@oss.qualcomm.com>
In-Reply-To: <5d681d59-4a2f-4068-b36d-4ca40ab7b921@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=afdRWxot c=1 sm=1 tr=0 ts=6a9aa214 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=kEvLTbNyLp0VmSbRQ0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5NyBTYWx0ZWRfXxMvNwWOKhRUn
 MgwVyAvihakCrEt9i7NQzeaM0H7lDBwwpX9keTJ+2GV0fISjDJ7EgS1fMyz1PKr6LylroiNH/G4
 N/RBJ3HJHX4ny75nTpjMZZcfkq/JUzG7psjJm/TRve6FyXGog4Mt/d/nGZ8BPwCCB+WbOx9OtL0
 Gbj4Opr5d5ltYI8F4W6AGJAkTgf2vIsWo8v13/QFLoLBbpGAwMvOPeow/nJXvRTYX8sRbUBmPTZ
 UmckFt/QgxCUnTwH4S947YDlvpg1e4BuprV8jLmwGK2WWEVu0wko8yxV1KZcptg8xsbKLyoxJSg
 ma1wBOXZT1Sy3ICfm43MW77zPliyA1czeSZye2vFN7mkM23h798C2BRgiYT6HZ4Im/Ntvg8/VFB
 wsc3ygbrAAN+x3r2VEQB5LX1CP1dQVlJg7WeoAe97dExc200dAg9+IFR76z3UkF0iCKd7CGamBo
 NE33GNM025ndDu/rZZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5NyBTYWx0ZWRfX3rpqgj6wvAg2
 juaw2ImYYhifi4hFH/QJ1Ha6Y8VfzB7qyti13j2xYi/DtK3OX6RSHyd6qvhixR7JlQl33hH083P
 Pw9kLh27ri+zZvh4NxiAaFYDEn/Zwp4=
X-Proofpoint-ORIG-GUID: umujTfybZdN8vvkMGxQ0J3gWZz-fCSWE
X-Proofpoint-GUID: umujTfybZdN8vvkMGxQ0J3gWZz-fCSWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040097
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

On 4/9/26 12:47, Philippe Mathieu-DaudÃ© wrote:
> On 3/9/26 07:51, Joel Stanley wrote:
>> Introduce TYPE_TT_ATLANTIS_SOC and move the hart array, AIA, ACLINT,
>> boot ROM, UART and I2C controllers into the new TTAtlantisSoCState. The
>> machine keeps ownership of RAM, device tree generation, firmware
>> loading, and the board-level I2C slaves.
>>
>> This makes it easier to compose the SoC into a more complex machine in
>> the future.
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   include/hw/riscv/tt_atlantis.h |  21 ++++-
>>   hw/riscv/tt_atlantis.c         | 144 +++++++++++++++++++++++----------
>>   2 files changed, 119 insertions(+), 46 deletions(-)
> 
> 
>> -struct TTAtlantisState {
>> +struct TTAtlantisSoCState {
>>       /*< private >*/
> 
> While here please drop these legacy private/public comments (QOM
> style doesn't want them anymore).
> 
>> -    MachineState parent;
>> +    DeviceState parent;
>>       /*< public >*/
>> -    Notifier machine_done;
>>       const MemMapEntry *memmap;
>>       MemoryRegion *memory;
>> @@ -39,6 +41,19 @@ struct TTAtlantisState {
>>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>>       UnimplementedDeviceState uart1;
>>       MemoryRegion bootrom;
>> +
>> +    uint32_t num_harts;
>> +    char *cpu_type;
>> +};
>> +
>> +struct TTAtlantisState {
>> +    /*< private >*/
>> +    MachineState parent;
>> +
>> +    /*< public >*/
> 
> (Ditto).
> 
>> +    Notifier machine_done;
>> +
>> +    TTAtlantisSoCState soc;
>>   };
> 
> 
>> +static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>> +{
>> +    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(dev);
>>       ram_addr_t lo_ram_size, ram_size;
>> -    int hart_count = machine->smp.cpus;
>> +    int hart_count = s->num_harts;
>>       s->memory = get_system_memory();
> 
> For machine layer this was OK but now this is SOC layer and might be
> provided by machine layer via linked property. IOW this should be
> handled like s->dram below.

(Sorry I'm just noticing the next patch exactly addresses that).

>> -    s->dram = machine->ram;
>> +    if (!s->dram) {
>> +        error_setg(errp, "'dram' link is not set");
>> +        return;
>> +    }
>>       ram_size = memory_region_size(s->dram);
>>       s->memmap = tt_atlantis_memmap;
>> -    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
>> -                            TYPE_RISCV_HART_ARRAY);
>> -    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine- 
>> >cpu_type,
>> +    /* CPUs */
>> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", s->cpu_type,
>>                               &error_abort);
>>       object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
>>                               &error_abort);
>> @@ -505,7 +524,9 @@ static void tt_atlantis_machine_init(MachineState 
>> *machine)
>>       object_property_set_int(OBJECT(&s->cpus), "resetvec",
>>                               s->memmap[TT_ATL_BOOTROM].base,
>>                               &error_abort);
>> -    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
>> +        return;
>> +    }
> 
> Patch LGTM otherwise, thanks!
> 


