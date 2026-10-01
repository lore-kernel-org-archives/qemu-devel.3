Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38986CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBbR-0003t1-05; Thu, 01 Oct 2026 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCBbO-0003sJ-Nf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:53:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCBbM-0007xj-BP
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:53:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xOf01932342
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 07:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jobQL0NL7gyPfwCx0thkR7MpsCc51neupv1GL6WP+4U=; b=Qas5SBj5qkPbPjtv
 OCfWfyH9ey9nACVVjS01eqDdaEHHKgXEsstRNtggMZtvtnHX/8ipcXYci/TdijNh
 b8ZWZMbmQVian7SQ9i14VL9Isc8KluqcqvPWJF9BOX6LDARZem92jhuNzM/iUWN3
 WEnKBuvJtSofygJnEylSMr/pvEY/4quVXMGmsJpTClA1D5y4gNnVS4451oiuqTc2
 wVlhk/ZsvsaYtYyTzTMKl5mQYTv4m1nW9wYhkFcuO0N/vx4RfcREFlbZ4hL0Aqfo
 3StcRYMUWDDjpziwq29hygogT2PrafW5xxFrLkAv5VDFS7GFl58XP+xuvy2HXUrD
 DvWH9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh59pc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 07:53:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so1602430385a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790841188; x=1791445988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jobQL0NL7gyPfwCx0thkR7MpsCc51neupv1GL6WP+4U=;
 b=E84nirQxJAzDeCEeI7T6dOk/3iGyknQKjlS4DQLddHjKUGQqi1gE+769/XORCqJmic
 s5k6LjMYPLHBxlWvVMnzH51qCAYYVNZGgUFsZwrCh6hpaMlxZok9qH5HWPI18hjdkaR8
 /tavJ/j2XZcsZG6UJqqlCrBWNwBRmZLpEbMa1mk6w/SDnESggo6oPWlsYMR4CXolMQpq
 iQartBLbbYBjh4ocaXCNtMcqm0ebnIrMJTgCPI22sj2wFxd0Gj4N9YCvgEsYuAZ85DU0
 7ftmBKv41eRLJgAntMo2mC2SN5yFqGlvs/fN9vni8om/q1qXInjCJqOg+VvIbAJo2h6k
 Xsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790841188; x=1791445988;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jobQL0NL7gyPfwCx0thkR7MpsCc51neupv1GL6WP+4U=;
 b=MZgCDJwQLcomMCHkwJRYoHCqZ0NLJly+VT9R51/Nh4w01aBcn3fv0/Iac8q/v6Ct1J
 K7bcttyaKas8YYaH6Fjvj5z4pIrFJMXllb180/kuUtByq0eIHwzokgbGN/vAsDtEXGCn
 Qr26PiwyfeDBk1DqsjmOEUZyMzU7+dp7xJLQQCDh5JskWCT4uAyGeARD5JhKxCiF27cT
 jVI5fKsF658mYx4d6DBAZD4leMpIvKWXZOS2i2Kh/8e1lZbEXhpoSVgPNFc3BVLMX5AW
 liPMnQIOZeKzN42R+iq6xWCyG2W4i4WJTd0kVOkOd+vkb/6QamJnCbLwXbyYHnwvo52f
 dbxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwScfJ4IamcF+34nIitEuih6blYfq4rfu++5kOiAX6Yun33ZhO3hOq9AuCZHnlRbKKW2aT9SyrbFVaT@nongnu.org
X-Gm-Message-State: AFuF++n5ok/604Tti+nN5che2kdGN/o0eDOk/pZ5wTLqkmgd0Jee7r0I
 /xQEYRvzfjfuZuTQ9wR1DSXNkDHPbafJRpYiRBv2fEz1nQunD1/sh7ZC6b0A48c/0UwbmswwvcT
 irYumzSoA43nO00aXyAjeZAnkuIxAcgHMuj0aP9gZPsgoqxiPvLhHOHHfKA==
X-Gm-Gg: AYBFou32gC0HAb2cWDZ+UHnY0AE25ClMDxEkkFCF9NAJaKVgjT4KKmptvCegtKg+JLO
 /9JQFS8H8J1UMa4I0Uv+4reMMDMBDddGJH45pa6YVJo1Ky+a4ym2uMRdm7M/yqCkrjYuCxvaqso
 DV/TFFOUsJxBonMCU3vzmGKgS6vLPbU2XRLVJ1ANRLyKmp5g6cb0lZi4cWy2NvxmJ05PhDOV/Ri
 vTT0wSoLgoM/C7+HAQZvG3eKySwca8taat+I1vlYl8YT8Uc/ElTn/JVDCg2zT7eZxe4XYfhrAzb
 kY8+Vv6Z4+FgQ8wmpD1bUVhKi2euDPahUk7GiC7ej+qe768CTy+VeWTAYvkjJ3VnmJr5l6sI8h1
 EuxXa3k/uF7nKmQ/kxE+dOKwA+B6rnwzG0A==
X-Received: by 2002:a05:620a:6413:b0:93c:2356:4e21 with SMTP id
 af79cd13be357-93cac1ab15emr599015085a.41.1790841188332; 
 Thu, 01 Oct 2026 00:53:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6413:b0:93c:2356:4e21 with SMTP id
 af79cd13be357-93cac1ab15emr599012585a.41.1790841187775; 
 Thu, 01 Oct 2026 00:53:07 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cb65c1705sm160673385a.47.2026.10.01.00.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:53:07 -0700 (PDT)
Message-ID: <ba7078a2-2252-4c11-a820-535848551ab9@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 04:53:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/riscv/atlantis: Add machine property to select
 default uart
To: Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
 <20260929031644.1016354-5-portias@oss.tenstorrent.com>
 <706bc560-ee8d-4529-8ece-c849fa8a4602@oss.qualcomm.com>
 <74c91fe7-c3cc-4cb8-af4c-d406851a3690@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <74c91fe7-c3cc-4cb8-af4c-d406851a3690@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QQ1gL-FdrF3Z3iSECTY7IWj5kKa3M4Cl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfXyucX766dTaCB
 vhPBifb6Arxpr5F2TR/u6dxteLXwrin/hzDF28nGaJjbNh2gSxdppBaGPNuIARy+UQTBY39Znxh
 7ORartu4tcqC3CEyqlwNTN7q9m2uFoQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfXwxqCmJYC8e5u
 opcXwSDEllAtw8I2NAtb1DjCGkrXNiSXwKz8f4xZX86kStx5AgTiy0/1qjirDzxQiawUJ3BRrxP
 F4eOwknhkUaWodBZouP69pe2p+yY5rzlBr4GZbjb0j/4ssmhhBXzPL/VOlvK9VKpMBYcmvPEOJv
 8FybNQDKmh6a5wLoErLsy1WNNp5ENIUn8S1RREJCsd3IRWzds8kK2+6eticZv0UKiHBghT0oA8J
 82ANnaNxGWue/4AP3UtpM/+VDEMJPj7/ca7FwF0r4sDCHZ6Em7UpPNV/8OHJk4o1fUyio/nu+qs
 Zffm6e8N2sscnCN6dVrwWYOTyFiLK54ZGExp0ztWG4AGxDaiFBkUDqRptdi0dD4pNC20tywItPj
 WsCljNVmeoQYZsizyW3Er4aQYKV5fGJQftZbe0uEBWk0jq33e/p1aFMPSvF+TIgA3eYrL5HjKWE
 r6uTmrd2GgxRar5oN2Q==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe1165 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=t9496tuAAAAA:8 a=lgtMTc-wgasgzdguBScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: QQ1gL-FdrF3Z3iSECTY7IWj5kKa3M4Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010031
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



On 10/1/2026 12:14 AM, Portia Stephens wrote:
> 
> On 1/10/2026 12:48 AM, Daniel Henrique Barboza wrote:
>>
>>
>> On 9/29/2026 12:16 AM, portias@oss.tenstorrent.com wrote:
>>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>>
>>> The Atlantis SoC has 5 UARTs. This adds a machine property to set
>>> which uart is on the first serial interface. This is the same pattern
>>> that is used by aspeed. The rest of the uart's will be added in
>>> sequential order starting at serial interface 1.
>>>
>>> The default value is uart1 which means the Ascalon console will be on
>>> serial interface 0 by default.
>>>
>>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>>> ---
>>
>> The code LGTM but I wonder if we can make it simpler.
>>
>> IIUC there is a new ams->uart_chosen being added that holds the numeric ID of
>> the first UART.  Then there's a new string property called "console" that needs
>> to be on the format "uartN".  To do that there's a string parsing code in
>> tt_atlantis_set_console() to guarantee it.  And there's code to guarantee that
>> N is also in an acceptable range.  Aside from parsing N the 'console' string is
>> not being used.
>>
>> I believe there's a good case here to make "console" an uint32_t property instead,
>> receiving N, getting rid of all the string parsing code.
>>
>> Also, there's a couple of instances of this:
>>
>>
>> int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
>>
>>
>> You can avoid this ternary by initializing ams->uart_chosen  = TT_ATL_UART1; during
>> tt_atlantis_soc_init().  Coupled with the parsing code from the "console" property
>> there is a guarantee that ams->uart_chosen will always be an acceptable value.
> 
> 
> uart_chosen is part of the machine class, so it would need to be initialized in the machine_init.  The machine property is set from user inputs prior to the machine_init being called.  Initializing uart_chosen in the machine_init will just overwrite the user input value. There is a object_property_set_default_uint() which allows setting a default value for a machine property , I have used this instead in v2 which has the same end result.

I guess I forgot I was talking about a machine property in the middle of my reply
:D

Yes, using set_default_uint() will have the desired effect (set a default value for
uart_chosen that users can overwrite later) and you should use that.


Cheers,
Daniel

> 
> 
>>
>>
>>
>> Thanks,
>> Daniel
>>
>>
>>>   hw/riscv/tt_atlantis.c         | 77 ++++++++++++++++++++++++++++++----
>>>   include/hw/riscv/tt_atlantis.h |  1 +
>>>   2 files changed, 69 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>>> index d567ec1155..32ba755bbf 100644
>>> --- a/hw/riscv/tt_atlantis.c
>>> +++ b/hw/riscv/tt_atlantis.c
>>> @@ -420,6 +420,29 @@ static void load_fdt(TTAtlantisState *ams)
>>>       create_fdt_memory(ms->fdt, &ams->soc);
>>>   }
>>>   +static inline int tt_atlantis_uart_index(int uart_dev)
>>> +{
>>> +    return uart_dev - TT_ATL_UART0;
>>> +}
>>> +
>>> +static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState *ams)
>>> +{
>>> +    TTAtlantisSoCState *s = &ams->soc;
>>> +
>>> +    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
>>> +    int uart_index = tt_atlantis_uart_index(uart_chosen);
>>> +
>>> +    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev", serial_hd(0));
>>> +
>>> +    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
>>> +        if (uart == uart_index) {
>>> +            continue;
>>> +        }
>>> +        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev", serial_hd(i++));
>>> +    }
>>> +}
>>> +
>>> +
>>>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>>>   {
>>>       TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
>>> @@ -482,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
>>>                                 fdt_load_addr);
>>>   }
>>>   -static inline int tt_atlantis_uart_index(int uart_dev)
>>> -{
>>> -    return uart_dev - TT_ATL_UART0;
>>> -}
>>> -
>>>   static void tt_atlantis_soc_init(Object *obj)
>>>   {
>>>       TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
>>> @@ -590,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>>>       memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
>>>                                   &s->bootrom);
>>>   -    /* UART1, the soc console (UART0 is for the boot microcontroller */
>>> - qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
>>> -                      "chardev", serial_hd(0));
>>> -
>>>       for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
>>>           SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
>>>           if (!sysbus_realize(sbd, errp)) {
>>> @@ -661,6 +675,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
>>>                                OBJECT(&ams->soc_memory), &error_abort);
>>>       object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
>>>                                &error_abort);
>>> +
>>> +    /* Map serial interfaces to uart */
>>> +    tt_atlantis_connect_serial_hds_to_uarts(ams);
>>> +
>>>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>>>         /* I2C peripherals: qemu specific */
>>> @@ -678,6 +696,45 @@ static void tt_atlantis_machine_init(MachineState *machine)
>>> qemu_add_machine_init_done_notifier(&ams->machine_done);
>>>   }
>>>   +static char *tt_atlantis_get_console(Object *obj, Error **errp)
>>> +{
>>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>>> +
>>> +    /* Default to Ascalon console */
>>> +    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
>>> +
>>> +    return g_strdup_printf("uart%d", tt_atlantis_uart_index(uart_chosen));
>>> +}
>>> +
>>> +static void tt_atlantis_set_console(Object *obj, const char *value, Error **errp)
>>> +{
>>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>>> +
>>> +    int val;
>>> +    int uart_first = tt_atlantis_uart_index(TT_ATL_UART0);
>>> +    int uart_last = tt_atlantis_uart_index(TT_ATL_UART4);
>>> +
>>> +    if (sscanf(value, "uart%d", &val) != 1 || val < 0) {
>>> +        error_setg(errp, "Bad value for \"uart\" property");
>>> +        return;
>>> +    }
>>> +
>>> +    if (val < uart_first || val > uart_last) {
>>> +        error_setg(errp, "\"uart\" should be in range [%d - %d]",
>>> +                   uart_first, uart_last);
>>> +        return;
>>> +    }
>>> +    ams->uart_chosen = val + TT_ATL_UART0;
>>> +}
>>> +
>>> +static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
>>> +{
>>> +    object_class_property_add_str(oc, "console", tt_atlantis_get_console,
>>> +                                  tt_atlantis_set_console);
>>> +    object_class_property_set_description(oc, "console",
>>> +                           "Change the default UART to \"uartX\"");
>>> +}
>>> +
>>>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>>>   {
>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>> @@ -691,6 +748,8 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>>>       mc->block_default_type = IF_VIRTIO;
>>>       mc->no_cdrom = 1;
>>>       mc->default_ram_id = "tt_atlantis.ram";
>>> +
>>> +    tt_atlantis_machine_class_props_init(oc);
>>>   }
>>>     static const TypeInfo tt_atlantis_types[] = {
>>> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
>>> index b81b7c8abd..7bd46e9c9b 100644
>>> --- a/include/hw/riscv/tt_atlantis.h
>>> +++ b/include/hw/riscv/tt_atlantis.h
>>> @@ -56,6 +56,7 @@ struct TTAtlantisState {
>>>         MemoryRegion soc_memory;
>>>       TTAtlantisSoCState soc;
>>> +    uint32_t uart_chosen;
>>>   };
>>>     enum {
>>


