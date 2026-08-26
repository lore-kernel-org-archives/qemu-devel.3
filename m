Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07445C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFBk-0008IM-8N; Wed, 26 Aug 2026 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzFBj-0008I5-6A
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:05:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzFBh-0002It-Ez
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:05:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDv0tH1120384
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ivHQtH7J1gihc5fUm7h5lY7upQT/cUC9c8mXJEgbi7I=; b=eNW0uXqF2pRUnnrO
 V/6P9/LD05Wr5e8fEYPdZ4FPfbnAdlyVlicQi8zHAv/c4eLGfuk4v2Yu6xvm4o6Y
 qqFP0DjyH0J9h3XOYZs58r/HhFE+OzQqI6F2ads9y0PXgpFZCCSC7t2IhR/4oWaj
 pW4TLAwOTdfJIwya0bFGpofW9BQsOZoWLSqzSM7oikPnwMJXk+DM3pwWfovVM13X
 PfUN/xEWRxcQRFiEChGbVMFal4jEttxpvQpFn0MfU4Fi9JAYRksmxZeP3BbeY7g4
 akjpH0VsAcExpYxgn6tOQKilMORYQx85fVwZKaI7mS5pS6TmpD+ZuZbUtRhRS0pZ
 WLRZKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k2qug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:05:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f946461so89819285a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787756710; x=1788361510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ivHQtH7J1gihc5fUm7h5lY7upQT/cUC9c8mXJEgbi7I=;
 b=f9aSNMs/1Vn4/yd84Q/obcRrhUDZFS+vVgV3GJL8E97amgLM5yg+RrmGVOsJXdC0n/
 5X4BhmHvDZjamSEYivp1vsE8jWMZ4vpklNqWOvEY3+Fbser2nAgjoj/pP9t6nNVXbelD
 y+rR46gZfICysa0TTYAIxEbvy/j5ZhrnWqIA/w6ViMPpJ8JJMKZIc+cO80gxp3ViwE/X
 u8RG4fTcwcfjdxNHeqvglWd6EKfebF1i8QdovJjqOx1yst2Ox8T3ccuICirwz97Vym23
 IN148UG6nDQiYxkJy5XTyBswmx1EQNsuXH62rItuOHyAR1a1Oy5o483MDK//0KeB7UyN
 YCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787756710; x=1788361510;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ivHQtH7J1gihc5fUm7h5lY7upQT/cUC9c8mXJEgbi7I=;
 b=hzr8PzBIAkNxxnRQJSbDXMpJohmoJgepYF6jK9+J/Quz0fJcJB1Ak8ivIQnO7BaAip
 jRo3dAsW8Vea4BSb1BVzYCZ+/gc7OW3EuAoFGtyU5D2L5/NzfxNvkSApdQPzhbvam9xB
 jSOAJCTKEjGzm5CUQrLpdRSZXhtIrqXePw9nfqKBfk0xxdKGYxkju6zCe/30TprTU++B
 +X+ctlB4r/yKCNyeSB97JMFfLBwL/M0W28xT3HS7XBw3FSCVV1xFZfctOzD1N0fNOzeh
 T9xFFqHFkkGu6kb5AS9QOWayaFLbdZG7Zjy4hLRN7Eb47WUS+c6jxmizcCaP9cifi4BE
 NoMA==
X-Gm-Message-State: AFuF++lQWZjPOasTDrk/90QV7Bzqgbi9WbPUmCxmLpK+CFXxeU/PkD95
 X1yI1TXvI3R2B4yElM9OsNqW1+UfMsrXDvupWpBBWjqDDDP/PX5vBooEyOwgC4lR5gUtGFKUG0o
 5r3qlwadbyn+wfQldLxA7M1UQOaAlAsY65phKosR5rWVZDaMZ6bXSOL1+5Q==
X-Gm-Gg: AR+sD11RfWeKF8dhZOvP44wnllq4gEOzWaOIWgkGjM1bHop3HcVqKBZdK/BvxTpgVc+
 1Pjto/4y3PVFlxI3tRD81r4UMGXZlR09CjpER8boZTcGi4SAXTtgqJIxPRaAusEIxKsYKXAwPRY
 emYGpm5EwLPWlV1T42vc20RI3gXONxJU4V1xipFVtDQV9pMjcuvt/FLBXg16RJZ6t6R+GBkTiDj
 +3+ongHJLK+EWqiKZ52vUc7lxUJjS5JomzX2MY6ZcADVJCW57qx4kSM9nauxjkZIEh4RxDAI3TE
 gVv2gImdvZRGn2hrA5SVMxQVnj3F5F0sMJTdNtdBFsHVAiyjwQcJJaGdhkN/r2PKc7m/CCzQZrl
 zBiWrOQsL4vFkK55WFFWvqJEfFzmrpcP2XbS7
X-Received: by 2002:a05:620a:269b:b0:938:fc91:8072 with SMTP id
 af79cd13be357-938fc918a1fmr173728985a.18.1787756709957; 
 Wed, 26 Aug 2026 08:05:09 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:938:fc91:8072 with SMTP id
 af79cd13be357-938fc918a1fmr173689785a.18.1787756708083; 
 Wed, 26 Aug 2026 08:05:08 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e688b35sm225104785a.41.2026.08.26.08.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 08:05:07 -0700 (PDT)
Message-ID: <f972ec37-676c-42d9-89f0-05879713f75c@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:05:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/riscv/fdt-common, virt.c, tt_atlantis.c: add
 create_fdt_uart()
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
 <20260825212326.1907-9-daniel.barboza@oss.qualcomm.com>
 <CAEev2e8fbPt04kcKh5a+ohXYtWPzC5-cD58gcMFS-NV3QQKwSw@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAEev2e8fbPt04kcKh5a+ohXYtWPzC5-cD58gcMFS-NV3QQKwSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8f00a7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KDr9JptfNnerHhvE1wIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX1hrerXPnrksg
 J1U2oxjw7ae6B2dqbDmuB8kIM3aawYciuVWd9dKltTq8VCXK+qEHo+U42ckoPrIxXl/zYvB6IgR
 xMWywQj+GROzbEnH7GwKp2NqnMblHNw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX4oR23A0PAQWb
 XA/aMfPu9lNv8mH9bEKOR5SW/RchUhxNfqeDo/W1hXQFJheUUJoLIxcRwXcPWerTJmokWmFZNQd
 ADHxr6zur5YR7r4ntF6RehHeMeHEHibHUbJumK/g6/05HolSpDLoPHNdxuxvhpxkhxx6Ei/mGH8
 Ju4ff8Zybpe1K6PgEDFzAqnWabjMUUl+eYaFhmcENdG0MUY7/JtAsYiYBQViaotpzlmy6BubL6X
 OjQ1RiSeYnjd2LuMdfRbYysfrQYfSAWS9ZwMy0w6DL/WhMzKqTLG4HiHzeiZw4+v7/+0kEjJn3e
 AOjVtlL/wjpfuOnXUWSrHinQo0xuo/HaoWpwlCPZ4HlBP+5he7m1YcAST0yoi0k7OWdFhRdPXtj
 1OfhOOxBoCVDcupRqGLsfgV6ARbCiBi71H6SlMZDdlqQ41wEb339Wlzq6Oz1DOGfHm8T7wJz1Hr
 FTZE2oWxlclY0jwpsAw==
X-Proofpoint-ORIG-GUID: 2vBXsXxXhUE-vLi6WpChaVXsusLwrAIW
X-Proofpoint-GUID: 2vBXsXxXhUE-vLi6WpChaVXsusLwrAIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 8/26/2026 11:53 AM, Anirudh Srinivasan wrote:
> Hi Daniel,
> 
> On Tue, Aug 25, 2026 at 4:24 PM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> Add a common uart FDT helper to be used by 'virt' and 'tt-atlantis'.
>>
>> To accomodate both boards the helper is doing the following:
>> - an 'additional_reg_props' flag is used to control whether we want
>>    'reg-shift' and 'reg-io-width' elements added.  OpenSBI won't boot
>>    with the tt-atlantis board without them, but 'virt' can't deal with
>>    them being added unconditionally either.
>> - an 'is_serial0' flag is added to control whether we need to set
>>    additional properties related to the first serial.  This is required
>>    because the 'virt' board adds two uarts in the FDT.
>>
>> No FDT changes intended.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/fdt-common.c         | 39 +++++++++++++++++++++++++++++++
>>   hw/riscv/tt_atlantis.c        | 21 +----------------
>>   hw/riscv/virt.c               | 44 +++++++----------------------------
>>   include/hw/riscv/fdt-common.h |  4 ++++
>>   4 files changed, 52 insertions(+), 56 deletions(-)
>>
>> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
>> index f31cc9d3cc..b3f3af3762 100644
>> --- a/hw/riscv/fdt-common.c
>> +++ b/hw/riscv/fdt-common.c
>> @@ -791,3 +791,42 @@ void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>>           g_free(name);
>>       }
>>   }
>> +
>> +void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>> +                     int uart_irq, int aia_type,
>> +                     bool additional_reg_props, bool is_serial0,
>> +                     uint32_t irq_mmio_phandle)
>> +{
>> +    g_autofree char *name = NULL;
>> +
>> +    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx, uart_mem->base);
>> +    qemu_fdt_add_subnode(fdt, name);
>> +    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
>> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>> +                                 2, uart_mem->base,
>> +                                 2, uart_mem->size);
>> +
>> +    /*
>> +     * The tt-atlantis board requires these extra props in the
>> +     * DT, but adding them unconditionally will break OpenSBI
>> +     * for 'virt'.
>> +     */
>> +    if (additional_reg_props) {
>> +        qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
>> +        qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
>> +    }
> 
> I think the issue is that atlantis uses a uart that has 32 bit
> register spacing (0x0, 0x4, 0x8, 0xc....) rather than 8 bit spacing
> (0x0, 0x1, 0x2...). So rather than "additional_reg_props", would a
> name like "word_addressing" or "32_bit_spacing" make sense?

Works for me.  I'll rename it in v2.

Thanks,
Daniel


> 
> Regards
> Anirudh Srinivasan


