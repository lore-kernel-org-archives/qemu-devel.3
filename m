Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9148DCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvKC-0004Pt-M2; Wed, 30 Sep 2026 10:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBvJz-0004La-C3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:30:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBvJw-0003j5-RP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:30:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxl1l612262
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KhieZml2ULjTQkHn4bn+IJgvCwmxLdHiW1WUtSeF3xI=; b=XOx+HzzB1XlwMOrr
 o56TdjWqetHQTYXT4FnNBLl2UDvAe4OdAyFiqZ649Zd28UCtmeSGksF1fBdaeSuq
 U1E62dz2+5GR/ho4Z+w4LFKwcvwN4YKBBXcgFoSxVlyzik/v+r+UkGI6odQ+07Oz
 nhpxHmioUIkQ2Ct1wlwdve+YRBE9zC/S5HnXHKvQUiGue8SNwzqbfsA4nY2m0Bqk
 1C5FIDxDCHRG9EaDSdY7xcBXtR4lyfJrK2pEcGiV51noZ1Xdhy/NLvvppuFYqR9I
 MKX1Woor0WwUZnicH5tdRHP3LjVIs10cav1xrNXM/XsVyXWW82qLYzUi9ZfAn6k3
 bfZfEw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh81bhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:30:05 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a7c17166so1893266d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790778605; x=1791383405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KhieZml2ULjTQkHn4bn+IJgvCwmxLdHiW1WUtSeF3xI=;
 b=MxF4Mz9+nu6Y9G7kDomH2sXJcZawfHQxyjk1/g23K3x/BscrlZC6Ym6MOF1YTakYxP
 I0n0i6jEmj8PAHAH9aAmO0nfxhARq7566zPd+ki7AYbUZY1zcxHpRHDM/T89T2DHQajB
 9CQnb2qvWG64X5rH/gTNo3qKnv+ON5R5LX0RvMq/IZxkrI10xGKaQfVFtLMsGqOqKlRi
 82xYklevoW6puo7YGrp2FAybARI+fzrIzg8FLNqe8MrwOzo2oPiCSI9IIRj1xOcbQg8K
 Of2JZYI9TFnTi0Rm9kCHOkqHr8jWLh5b43E/3GJVgHdNx8E4AzsSN0nWEJP0Kzs/LgaH
 Ffng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790778605; x=1791383405;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KhieZml2ULjTQkHn4bn+IJgvCwmxLdHiW1WUtSeF3xI=;
 b=0Tx5V0hJ/vC3U7Mp9OAs0TCT6jz9r3AshIwbGr6CcGGubxFe6QcMZKWNg5qm/4lSEy
 NhtwwP16BfxylKc47KUv/xLcxhcU7eUAVkVUKkk9YzcJ2K+UjDMpykLhOV/bec5K6OFh
 nBn9c2Ff1zR10OCDKmV7pRz7RSQnUOZnwGQQUdNyAdvJyg4mbY7h51yM8OP/yIwCRUGb
 Jv40JZQSbUsWctRODnja9DhZuy4iDkWsePt9rRC+qLO0xmyQROFrJpbu1rothF937INU
 pKA0VPzREh/tWZGoRdB7u6W4EOShcQKuRHZHgrO+JUmS1mKIyHbzZ9cvyll9J026QAsv
 RIsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMrtWKS4w2UrFKwr5fxObewZ2+y94cEsI35iRCHoEPnbAtwjXQrbP+JHJxXr9krFGoZbERsgg8KsX7@nongnu.org
X-Gm-Message-State: AFuF++k5PtVfA0RdGR+VaofiRvuaFxPyEMZ8m5GA8Nok7iZUKjXKQopK
 w/Ae88gCZxHCD4wcxsHE9TgP1QzWdlemOVlfzS5+bOmdrneaRbumw9jBO1wFL3LXChhP93KcvC6
 YMQ+bD8LjoeojhqTeo91hSyz/dUTWirjW94ovSnIMJKSCfXMrgSNOlU5Z4g==
X-Gm-Gg: AYBFou2ivhUvmTK8PchWrXup3SMArw2lrlPUwqkUB97DnZzVMyO/9bpDnmWMGpmenq2
 0f5zgs+EqG0QcvpOuKtREp951te3o3Cv7ws2EQzrkROyrma2H5P+xo7ppYCKOgadtQZz3fDS7Au
 APJHZS2J0RnvlE7BDdkSwz93AdEqv8K7fw0T3QSGX2kqp8B2QPd1YJcWAqBpg8IPkbmZP6mS0eX
 x9joYTJJSAjboeADJPkPppKcDXi1MfoxCIgubkhBj8Q9HDmQzT7NoxVHd1Pv/Y9Js4bK5a63zGL
 EG22BvMYEb4yDDtswzLi0iFQtnlIifSsKrZy6iLVHQdHY+NFVtkOMr0O4Jgwyg06E392heBjtzR
 fuacrYm84zG1A/9HMeVeo5ER7fRHquFbYfdDA5QbbPFwO
X-Received: by 2002:a05:6214:2029:b0:915:bec:310b with SMTP id
 6a1803df08f44-917a09e70c2mr27504996d6.5.1790778604649; 
 Wed, 30 Sep 2026 07:30:04 -0700 (PDT)
X-Received: by 2002:a05:6214:2029:b0:915:bec:310b with SMTP id
 6a1803df08f44-917a09e70c2mr27504256d6.5.1790778604030; 
 Wed, 30 Sep 2026 07:30:04 -0700 (PDT)
Received: from [192.168.15.22] ([177.188.45.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a881d2e2sm950896d6.3.2026.09.30.07.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 07:30:03 -0700 (PDT)
Message-ID: <e230f37e-05f0-45ea-bfae-4d39dbf97776@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:29:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv/atlantis: Use dw8250 UART model
To: portias@oss.tenstorrent.com, qemu-devel@nongnu.org
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
 <20260929031644.1016354-3-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929031644.1016354-3-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NyBTYWx0ZWRfX5pVXG8OiwZW3
 MjviAL3Meo2gwLB6Un2orFWXBwU25n+asud9Huf2PhriI7mkcn043o73tggWMY+4JOBgMUWVCyS
 5FtdcGws44vC27+hgCwBFtwQA3gOXIEFK3dEhGUEO5I+G56j3q2iQqhi1PA/rEJPbIirRNBeDlL
 zxVRZz8fZ9rQfPVOhnEu0RJruynq8uflNW8AAK5wZL321TMsZmsq0TgQpwGhA1UwQKcszEq+3XK
 HWgG2NKDkQeL4P08Zi1HMnjvpkaaOFyF5o9thZDQzHCSOq64Ze/AwY7zpeBGvy4j4KOyyIiahDh
 j1eIXMgOffe4+3h+HlFi12TqC+1/UmMvYJQVgimyPVFZ1dTpzXdiECvuo9oHHaIvfjrcwNUgro2
 l26e1h+/V8Uvb5XHI5J2CxOXxvWyYkGKl0tnVgSvoDGa59NrpRA1s8RrHu8Mkpl3F+zA770RnQp
 l5zXX8//ZoCcPsmftqw==
X-Proofpoint-ORIG-GUID: 38PeyX_oXiPM4bKGPp6AoX5uZLdg-397
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abd1ced cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=6l5rUruYTVaW9RSjPQzg2g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=t9496tuAAAAA:8 a=mtco-8agIgxlSA0twTAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-GUID: 38PeyX_oXiPM4bKGPp6AoX5uZLdg-397
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NyBTYWx0ZWRfXwc5Kuj8syYko
 LGEovzIhBNgKCIoM3nyaLJxwtuuRFVZqm13jmSp/KuhymAYaL3UB5c6HBm4cldigtwZzG7rv9Pv
 n21JZyKYRzXfohS4kAlTXtOgQBmHDIg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300057
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/29/2026 12:16 AM, portias@oss.tenstorrent.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> Replace the ns16550 UART with a Designware UART now that a model is
> available. The hack which sets the rest of the UART register space as
> unimplemented can be removed.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   hw/riscv/Kconfig               |  2 +-
>   hw/riscv/tt_atlantis.c         | 41 +++++++++-------------------------
>   include/hw/riscv/tt_atlantis.h |  4 ++--
>   3 files changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..5d2abdbb67 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -127,7 +127,7 @@ config TENSTORRENT
>       select RISCV_ACLINT
>       select RISCV_APLIC
>       select RISCV_IMSIC
> -    select SERIAL_MM
> +    select DW8250
>       select DEVICE_TREE
>       select DESIGNWARE_I2C
>       select DS1338
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 8a219afef7..e889951677 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -24,7 +24,7 @@
>   #include "hw/riscv/fdt-common.h"
>   #include "hw/riscv/riscv_hart.h"
>   
> -#include "hw/char/serial-mm.h"
> +#include "hw/char/dw8250.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/misc/unimp.h"
>   
> @@ -262,11 +262,12 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
>   static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
>                               int irqchip_phandle)
>   {
> +    static const char compat[] = "snps,dw-apb-uart\0ns16550a";
>       g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
>                                               mem->base);
>   
>       qemu_fdt_add_subnode(fdt, name);
> -    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop(fdt, name, "compatible", compat, sizeof(compat));

We have some instances of a string array being declared with qemu_fdt_setprop(), and this
works as long as the compat string has NULL chars between the strings.

However I suggest using qemu_fdt_setprop_string_array() instead like we're doing in newer
FDT code.  It's a bit easier to read and debug than dealing with \0 in the middle of the
char array.

Here's an example from fdt-common.c:


         static const char * const compat[3] = {
             "sifive,test1", "sifive,test0", "syscon"
         };

         qemu_fdt_setprop_string_array(fdt, name, "compatible",
                                       (char **)&compat, ARRAY_SIZE(compat));

In your case this would be:


         static const char * const compat[2] = {
             "snps,dw-apb-uart", "ns16550a"
         };
         (...)
         qemu_fdt_setprop_string_array(fdt, name, "compatible",
                                       (char **)&compat, ARRAY_SIZE(compat));


Thanks,
Daniel

>       qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
>       qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
>       qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> @@ -409,17 +410,6 @@ static void load_fdt(TTAtlantisState *ams)
>       create_fdt_memory(ms->fdt, &ams->soc);
>   }
>   
> -static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
> -                                   const char *name, hwaddr addr, uint64_t size)
> -{
> -    qdev_prop_set_string(DEVICE(dev), "name", name);
> -    qdev_prop_set_uint64(DEVICE(dev), "size", size);
> -    sysbus_realize(dev, &error_abort);
> -
> -    memory_region_add_subregion_overlap(memory, addr,
> -                                        sysbus_mmio_get_region(dev, 0), -1000);
> -}
> -
>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>   {
>       TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
> @@ -488,8 +478,7 @@ static void tt_atlantis_soc_init(Object *obj)
>   
>       object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
>   
> -    object_initialize_child(obj, "uart1", &s->uart1,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
> +    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
>   
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
>           object_initialize_child(obj, "i2c[*]", &s->i2c[i],
> @@ -584,21 +573,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>                                   &s->bootrom);
>   
>       /* UART1, the soc console (UART0 is for the boot microcontroller) */
> -    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
> -                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
> -                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> -    /*
> -     * Atlantis contains a DesignWare uart while the QEMU machine
> -     * uses the serial_mm model with the base ns16550 register set.
> -     * Linux's dw driver writes outside of serial_mm's 0x20 sized
> -     * mapping and faults.
> -     *
> -     * Create an unimplemented device region so writes don't fault
> -     * and reads return zero, which keeps Linux happy.
> -     */
> -    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
> -                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
> -                           s->memmap[TT_ATL_UART1].size);
> +    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
> +    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
> +    memory_region_add_subregion(s->memory,
> +                                s->memmap[TT_ATL_UART1].base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
> +                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
>   
>       /* I2C */
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 3923308b7c..000988c037 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -13,7 +13,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/i2c/designware_i2c.h"
>   #include "hw/intc/riscv_imsic.h"
> -#include "hw/misc/unimp.h"
> +#include "hw/char/dw8250.h"
>   #include "hw/riscv/riscv_hart.h"
>   
>   #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
> @@ -39,7 +39,7 @@ struct TTAtlantisSoCState {
>       RISCVHartArrayState cpus;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> -    UnimplementedDeviceState uart1;
> +    DW8250State uart1;
>       MemoryRegion bootrom;
>   
>       uint32_t num_harts;


