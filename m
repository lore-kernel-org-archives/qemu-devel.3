Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97517CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGj6-0005DQ-GW; Thu, 01 Oct 2026 09:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCGj3-0005D6-Sk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:21:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCGj1-0004j5-Tp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:21:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691CJA3G2176834
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QjMj3UNX45tYDk5eBDrT/FSZMSedvI9dNb3p7v7DHo8=; b=kaVK7pLDHmj+quWO
 YuaoiEF2a8pdU2VAdLQFZIUQlf7obTqa9B4O9GeoGyXNm9/xdGuErrSLvLJgN283
 rLrpD4S7Mmsp6Wm7itudkorCnWfmNYl9m8PuHhzfL8NuK/iJAZFjHFPx+PrPBQmj
 2SUxkvYB45YLInQ90QmajuHbDCwBBcXXoJy6zp/xIPytWCHGxKfvjeyHDujrQknl
 TcS6ILNxKs5w1Lqk+5xBARVyGyFIVlsfPBSwMh/2er5jQmjQHW+QokgfAPKAEsLl
 JU9he8e75DLzJcZUXZH2MhQTXpMrGRumuTIaePTurETeHfBpk8wD2RRduaJ9gn5o
 eQTkLg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nt19n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:21:26 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6768c955661so1213189d50.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790860886; x=1791465686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QjMj3UNX45tYDk5eBDrT/FSZMSedvI9dNb3p7v7DHo8=;
 b=ktCIrOEpvsrAcLUqaFBZ1zx0SvHXRgqabtRf/Ugk94G6j2EnkKerSdHXhGfvGlkoSV
 Egkf49v6++s/8/Q1bONSSHTz0PQ4vObzffwefm5FZefAtlcu1haKnMfzMb7xXEYu5I12
 GkJAo15pbIsraA76zEJNQ/byG9ApZU1SrvKaEa2RH64iQFgJpDdZeXxI2O29Nr5/BWkO
 P8HTroEzBgKLZ4L8L5PzpW3Mzks+MWauERk0iitI4owbfhySX8pyW8y1B5Qthi82na+4
 qwux151jHI46TSiF0ip5VwgyP8nHmyu1sG2GNT//4eKsAEE3oLa3gYw867oEvH/OtJyU
 dFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790860886; x=1791465686;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QjMj3UNX45tYDk5eBDrT/FSZMSedvI9dNb3p7v7DHo8=;
 b=sDD4yT9rbme5ODCpzJg02DT6OKXKrKCtYYu0BP6B/r35Iqt9hgDmw1po8WTKsU940/
 9r+9yJ5hXgY5kZYtfqZRrzya+Wu+sSNWLw5GXpgXwRaD5qBqqiA/7/DJKkzAusVUUdTn
 5TaKZDzoPl6a2Rtlje1w2Uve1JeMXsOLwtH7qotYfKeu7RPi3Fdltht5qfNizo44qtXo
 qKdYKlkmfnzckXppQcsTiH++LpPAXF0Z4RtoF/jO7OUGL0s5i7YwYp0NSQMpNX/4VrvD
 45k2Oo5a8F30tUXFSkQRmCAXAaDMpynScOp2zTAc8NO/lOIR/Ir6omusDmyYStDd6+AD
 VspQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByIy2sjk6QRmlDaRZX2MpB3XoZm3mcBYcx2vlvNwuaXQkBE2dBFJ/z+tz79o1zRXN3iYyG7wGBGcYz9@nongnu.org
X-Gm-Message-State: AFq9FYJsC6igSPCnecue9z9r+ZoRQSHHL0filiKic1Jn+P29EUNeH6iZ
 Nm12VESOY2J+BvllDzvsZ1tC2aFCGG74VBl4LpBHl/q81Mh3zvhPh+KfQcoRxIJ1okXRC/vPq8H
 g8Dp5HmRNvnw2D/eIDQbWfLa8kPt8MXUrsTucSxRdQKEl+PHVFWd6vneQng==
X-Gm-Gg: AYBFou3i2c9XBFGg5Y0yjR9j4wkYLPlpRazoomsgfP1kVZ4ftkO0qY+vG8iWeROZ1YC
 PhqZiFshQ2a2Q5+WmC4OEw0EHVJbb9C0ACgKnjtJ6q2UbnOFgOGjTREa7faTbc4EC5PFRfPHCSQ
 +1fpxRXRmy8UUf8DM10NAAR+QsqDTdGc44wO/D6RCU7uSe4GuX5SlX+5TdbmFYcffMMJLrd7sLL
 +ctN4p92AzWtYKxZdILMplgn+3+IqFnqzlUDA+wwD+7gRrIw6MMK5p3H00Kv/TsUKSPXU/xN4zi
 4Inofpq/cFuLnCPxy5k5PbYqJtOOXmMe/HaOJrW+ZGylWOvyMMLkGQ2pjAghVbMuZsZMplXpwQ3
 7QHrGfH313sqr1RGAP+tk69vmwuiMkXauEQ==
X-Received: by 2002:a05:690e:144f:b0:675:5d66:765f with SMTP id
 956f58d0204a3-67683430e9fmr2027195d50.28.1790860885786; 
 Thu, 01 Oct 2026 06:21:25 -0700 (PDT)
X-Received: by 2002:a05:690e:144f:b0:675:5d66:765f with SMTP id
 956f58d0204a3-67683430e9fmr2027146d50.28.1790860884999; 
 Thu, 01 Oct 2026 06:21:24 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a8a9c6d4sm25784596d6.47.2026.10.01.06.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 06:21:24 -0700 (PDT)
Message-ID: <fc894742-db98-4533-a437-a1ec72f304dc@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 10:21:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/riscv/atlantis: Add machine property to select
 default uart
To: 'Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>
References: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
 <20261001031720.2334056-4-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001031720.2334056-4-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe5e56 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=hrHss4VmSoQKFNtAj8wA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX5wqs5/lm3Zjo
 BeVyUnEOjrPezVS00uvJOoF9Yqpze9JSQnnWcEaxm4/0W/HBtYvBJxnxNW5+wXnXEW7s4TuWaEu
 ouhLskn/3cojVuyt2WzLkxiCOnhKlkI=
X-Proofpoint-ORIG-GUID: 1Px98jWAX_PPZEZPm_z85OtHhPQ5ooJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX4Lj7SFACN0Vl
 /iCAgFSsTMx2h93FPfZFmY669O4x8/9yEmg+f5rwOzz+5Fjm1886Xv0Z0WwYGpQ7aUD8GI4NucO
 X6HGXfoaGtzSgFhmE5RsnSGxr6sd796RT6Nq4ssHIgnTYqoXZXFPG+7oyEOJHAKWHrE1NjpxVUR
 qNvyCbUcoc7Z0aTn9nXVCr+KvSWtB6uJqgTLyHf1SmmO1hk0T30niKOgnn98iiUVcIONogJCXzs
 /1VIUfY0L3QdfQxlBYj93jbrp0XLzHY/C9ncDfqvniuWOwcoGlG2wOjajqS9mtHALaoMik6pa4D
 vT6xrxuJyn+sQ60pZhCMpdJ5eSQB2ZibDxpsknpdeFkIcJ89ywGedxOFNfIWAHFsDkDaLcqUjyP
 ThI8F+z5BGD6RxT/rgF4C2LhzYDzkwS92OXKU7+zCF+2ui5Ze6rzvuvOaYkJlrBXumTA3as3Ci8
 oLBqNJjbbGcJ6WQchNQ==
X-Proofpoint-GUID: 1Px98jWAX_PPZEZPm_z85OtHhPQ5ooJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 10/1/2026 12:17 AM, 'Portia Stephens wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> The Atlantis SoC has 5 UARTs. This adds a machine property to set
> which uart is on the first serial interface. This is the same pattern
> that is used by aspeed. The rest of the uart's will be added in
> sequential order starting at serial interface 1.
> 
> The default value is uart1 which means the Ascalon console will be on
> serial interface 0 by default.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/tt_atlantis.c         | 76 ++++++++++++++++++++++++++++++----
>   include/hw/riscv/tt_atlantis.h |  1 +
>   2 files changed, 68 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 2342edce93..9534ce0031 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -12,6 +12,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/guest-random.h"
>   #include "qemu/units.h"
> +#include "qapi/visitor.h"
>   
>   #include "hw/core/boards.h"
>   #include "hw/core/loader.h"
> @@ -422,6 +423,26 @@ static void load_fdt(TTAtlantisState *ams)
>       create_fdt_memory(ms->fdt, &ams->soc);
>   }
>   
> +static inline int tt_atlantis_uart_index(int uart_dev)
> +{
> +    return uart_dev - TT_ATL_UART0;
> +}
> +
> +static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState *ams)
> +{
> +    TTAtlantisSoCState *s = &ams->soc;
> +    int uart_index = tt_atlantis_uart_index(ams->uart_chosen);
> +
> +    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev", serial_hd(0));
> +
> +    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
> +        if (uart == uart_index) {
> +            continue;
> +        }
> +        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev", serial_hd(i++));
> +    }
> +}
> +
>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>   {
>       TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
> @@ -484,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
>                                 fdt_load_addr);
>   }
>   
> -static inline int tt_atlantis_uart_index(int uart_dev)
> -{
> -    return uart_dev - TT_ATL_UART0;
> -}
> -
>   static void tt_atlantis_soc_init(Object *obj)
>   {
>       TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
> @@ -592,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
>                                   &s->bootrom);
>   
> -    /* UART1, the soc console (UART0 is for the boot microcontroller */
> -    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
> -                      "chardev", serial_hd(0));
> -
>       for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
>           SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
>           if (!sysbus_realize(sbd, errp)) {
> @@ -663,6 +675,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                                OBJECT(&ams->soc_memory), &error_abort);
>       object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
>                                &error_abort);
> +
> +    /* Map serial interfaces to uart */
> +    tt_atlantis_connect_serial_hds_to_uarts(ams);
> +
>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>   
>       /* I2C peripherals: qemu specific */
> @@ -680,6 +696,46 @@ static void tt_atlantis_machine_init(MachineState *machine)
>       qemu_add_machine_init_done_notifier(&ams->machine_done);
>   }
>   
> +static void tt_atlantis_get_console(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
> +    uint32_t uart_index = tt_atlantis_uart_index(ams->uart_chosen);
> +
> +    visit_type_uint32(v, name, &uart_index, errp);
> +}
> +
> +static void tt_atlantis_set_console(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= TT_ATL_NUM_UARTS) {
> +        error_setg(errp, "\"console\" should be in range [%d - %d]",
> +                   0, TT_ATL_NUM_UARTS - 1);
> +        return;
> +    }
> +    ams->uart_chosen = value + TT_ATL_UART0;
> +}
> +
> +static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
> +{
> +    ObjectProperty *console;
> +
> +    console = object_class_property_add(oc, "console", "uint32_t", tt_atlantis_get_console,
> +                                  tt_atlantis_set_console, NULL, NULL);
> +    object_class_property_set_description(oc, "console",
> +            "Change the default UART index on -serial. Valid values are 0 \
> +            through 4 (default: 1, the Ascalon console. 0 for the RCPU console");
> +    /* Default to UART1, the Ascalon console */
> +    object_property_set_default_uint(console, 1);
> +}
> +
>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -693,6 +749,8 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>       mc->block_default_type = IF_VIRTIO;
>       mc->no_cdrom = 1;
>       mc->default_ram_id = "tt_atlantis.ram";
> +
> +    tt_atlantis_machine_class_props_init(oc);
>   }
>   
>   static const TypeInfo tt_atlantis_types[] = {
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index b81b7c8abd..7bd46e9c9b 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -56,6 +56,7 @@ struct TTAtlantisState {
>   
>       MemoryRegion soc_memory;
>       TTAtlantisSoCState soc;
> +    uint32_t uart_chosen;
>   };
>   
>   enum {


