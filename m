Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56D4CA5FAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBuMW-0001Vg-87; Wed, 30 Sep 2026 09:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBuMV-0001VC-61
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:28:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBuMS-0005Eh-Vi
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:28:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB8K8p2898194
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 13:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ux+Un8La7SMWUwwEVlRIyK8IC8A+J44ndr4b1g+IhtQ=; b=FckE+va+kou/Dn54
 dCeZ/rt4Ub8VQiPSNGcrRk2Nw4zZ5UBvCIpGQa1QrXVHXKvmJQ+le3odkvnY7Kn0
 SeyHTMqBcxb92rxzTgcXj1G5/sKZnYXWQZaBubCY7tdES5SPLW9RNk50CPRGD1n/
 P46KeUUeL/WYrKeocEwU3ZbMYqCPf5hvbEP/oY+KogedLg6VdVcYHOOJ8NBX3ZI1
 cK75vJ4AciEgnSU/gYYPSTUNYeVwJWYt0Wmnvz+m/DiZj+bdEec53EpLFrQuKlfr
 iynX6rVMkp88pACkaUgseVI5tegPrzDDk5avJ+8xKnbruFAuZzkDSb2ByJjbFLX6
 1b1nBw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn2f82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 13:28:38 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7b497a7878cso637484137.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790774918; x=1791379718; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ux+Un8La7SMWUwwEVlRIyK8IC8A+J44ndr4b1g+IhtQ=;
 b=P5RlMJ2tZfys66GCQKmqMpFqpFtrYX/TVoItgN796nIZNuwBqT1ru4cobXq5mB3kc6
 zL1k3dxRCx0IU5y0A3xqTQPK8U9tUyDkg29LPgdACcgLoqVHn8pKh7tNy+Az6+LEopBG
 dB0lm+SWvfHkHoRySN5cBNRwzbBkRg2O0M6uzLQuA2Jkne0R9ZStMlb/2KaI/csmBG6j
 vW8rW1uPyaihcszzIBgzfJ+hplj6+feteCy0G/T1K0HpDJr8VYCjkFhiWQGhS9ZpqEaH
 feEhz0Mk7z2ouS+xAEMzAr2z/Cg6J77UouOa/rrtEbAf9rixvGS1XZgcP5Cs33JSlggL
 r21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774918; x=1791379718;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ux+Un8La7SMWUwwEVlRIyK8IC8A+J44ndr4b1g+IhtQ=;
 b=gfKbOYapW8kwxvKFKP7O5hVJFEPcnIp68Cr7rmzKVOXQWtu1QNohhCyJKp9vx73qWk
 /TZjxspe5lstWcQPFO6v9rqhX5eOqFyQNhVDeEI7Hmifllku0aO10/kgb/dK80ViEjP9
 g4POcIEZbqNnZ3nJjI94Ey0dn9FkbtQciglZCMQyGt5dqZ6Zpx+3VI8O88zWlU3dHZYK
 T4XAw5HetxdYPFVic9LrV9sb3bNl4XdXNFLxSL2CbUCNzi51xIZ5F8kfcGF7k/K6V+hK
 SwIm2C7To1gs2AnMwcRkSgg1i6KRNKMVK9A261WMtwSGWVcojZhOAgi5k7pqI9Ak5C0C
 7SDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBya99AEJwLt7z/D3HesINK2TB9pRVh+RUdVE0riQeBbBCGRgjdI3PY2yW1e+NSkbQQdVrCQf6M1RmPi@nongnu.org
X-Gm-Message-State: AFq9FYIePPzcoLgfBG7RLqs+EKNZdSIH4yvobvt5GUSDR0KGt/yVEH4n
 QpzMfZaAofkKomJxptkJ8bHo/oR04W3tvyAci4picfg9hOqNGjvMipWfG+OADW6tzc4/kfg2VaZ
 B/hFZdsW49ncUic48LWfbb/a8bamgmD2UGDo5IV4Mja0Njznqc8NRkBIN8Q==
X-Gm-Gg: AYBFou17i8S8TGSJuqG2uxVPl4t8ELswwlrrr/5f7HQRHP8JQtvkOwJwsIHd2P7CWS2
 UolqO7kgLDWPWty5lCg1o+kvSFkKs7qcM8wuEUKgNfCwv8ytkOkvUBBfMeszo9GrzQqoJwx/iVr
 b3LseqejSLegfn7T0zSkWFeu4snxGzPc9/bEpA7J5kGWotsyoiwKFtvZDw7mx4m2CWC1BBGrveI
 3391cHkahp67bVmMVRRHfRSs57/UhKuDuYaydLI6eMrwUreCfW4Gjxf+8aXHfNVXcIIqX5GSWP1
 Ye5wbxDk+3wxjbnaEKp3sQsAuffKcL6pafhhikXrBPXSzSGOqZDoj8nYv55iOTksj+Owpm/nZi6
 3DQ1RIwCAgEpybLlsgwAtXCAYcJBeYapcmQ==
X-Received: by 2002:a05:6102:6a91:b0:7a1:f7d2:e846 with SMTP id
 ada2fe7eead31-7be7319bd53mr251433137.22.1790774917575; 
 Wed, 30 Sep 2026 06:28:37 -0700 (PDT)
X-Received: by 2002:a05:6102:6a91:b0:7a1:f7d2:e846 with SMTP id
 ada2fe7eead31-7be7319bd53mr251400137.22.1790774917086; 
 Wed, 30 Sep 2026 06:28:37 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31d80d24sm789566b.52.2026.09.30.06.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 06:28:35 -0700 (PDT)
Message-ID: <238b1bf5-c7a4-4103-9e70-c5bf9efc3691@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 10:28:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/char/dw8250: Fix leak when creating child device
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
 <20260929031644.1016354-2-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929031644.1016354-2-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abd0e86 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t9496tuAAAAA:8 a=jjHZSQ1sJ0xQOcU6r5sA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: JSTcGbB9L_E5lhVAUGURNIYcLLVwZ65d
X-Proofpoint-GUID: JSTcGbB9L_E5lhVAUGURNIYcLLVwZ65d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MyBTYWx0ZWRfX5s/grZYsyzWt
 +YNuxIip2j5SKFKmD5DSQtdY/gKV4w+9nfhYk6azbotD/UbjkOyq0O060tHkYnaEpw2TXEgvgqx
 OoMr184KvvZxd+ARyRo6fM9DyMvWhUOWP0UtSNNYtN5UtPLVRPkjKr88kEgt9OO0RhWmkWcPuVA
 kNt40SoihfbI9kVwlyZXIf7NxWtB/Jw1OYQa03h8vCRDeiNJ/TGIh6QqQuVjtyBvbfoklPs6FcX
 6chuMIJT+k1pxPFgqcTZjxO+jcJlzSU08fMVvwLnZ0sN/KF6V4J0WcyUgEOHjdPV1VhLBQDsdu6
 POgOswZGA2Lj7Wl0POCB74OdFlVRO58wJSyi5J3K/hTcKsKJuUfe0uyMFEigYCyekvq+lnnDJWF
 EH7U/0HPp1JfzP4vieyIP529xADhR915ejzJh5PtHqdgUZlFE8lqYy6kxQ/1GmFjWHPzJQXJvA6
 J/sfRBLKrZIzNVcoh6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MyBTYWx0ZWRfXy2F8bHZDAsPc
 Q5cNm1omshPVor1mc7PFRiU6bqC/5G50uVJbDxiQCJrdUojfgWpH4x32Hn8od5PFWd/cG9ExcVe
 f+s201nevmFxUax/GBksJjLTejtL81Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300053
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

Hi Portia,

I believe this fix should be made by the original patch that introduces the device,
which isn't upstreamed yet:

[PATCH v5 1/7] hw/char: Add dw8250 UART
https://lore.kernel.org/qemu-devel/20260927201326.650943-2-visitorckw@gmail.com/


Thanks,
Daniel

On 9/29/2026 12:16 AM, portias@oss.tenstorrent.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> dw8250_instance_init() creates two references for serial_mm, one from
> qdev_new() and one from object_property_add_child() which leaks the
> serial_mm object. Fix embedding the SerialMM struct in the DW8250State.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   hw/char/dw8250.c         | 11 +++++------
>   include/hw/char/dw8250.h |  3 ++-
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
> index ccf05dd9ad..50baeae62c 100644
> --- a/hw/char/dw8250.c
> +++ b/hw/char/dw8250.c
> @@ -72,23 +72,22 @@ static void dw8250_instance_init(Object *obj)
>   {
>       DW8250State *s = DW8250(obj);
>   
> -    s->serial_mm = qdev_new("serial-mm");
> -    object_property_add_child(obj, "serial-mm", OBJECT(s->serial_mm));
> -    object_property_add_alias(obj, "chardev", OBJECT(s->serial_mm), "chardev");
> +    object_initialize_child(obj, "serial-mm", &s->serial_mm, TYPE_SERIAL_MM);
> +    object_property_add_alias(obj, "chardev", OBJECT(&s->serial_mm), "chardev");
>   }
>   
>   static void dw8250_realize(DeviceState *dev, Error **errp)
>   {
>       DW8250State *s = DW8250(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(s->serial_mm);
> +    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(&s->serial_mm);
>   
>       memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
>                          DW_UART_REGION_SIZE);
>       sysbus_init_mmio(sbd, &s->container);
>   
> -    qdev_prop_set_uint8(s->serial_mm, "regshift", s->regshift);
> -    qdev_prop_set_uint8(s->serial_mm, "endianness", DEVICE_LITTLE_ENDIAN);
> +    qdev_prop_set_uint8(DEVICE(&s->serial_mm), "regshift", s->regshift);
> +    qdev_prop_set_uint8(DEVICE(&s->serial_mm), "endianness", DEVICE_LITTLE_ENDIAN);
>       if (!sysbus_realize(serial_sbd, errp)) {
>           return;
>       }
> diff --git a/include/hw/char/dw8250.h b/include/hw/char/dw8250.h
> index 59396ad202..ce0b97715b 100644
> --- a/include/hw/char/dw8250.h
> +++ b/include/hw/char/dw8250.h
> @@ -10,6 +10,7 @@
>   
>   #include "hw/core/sysbus.h"
>   #include "qom/object.h"
> +#include "hw/char/serial-mm.h"
>   
>   #define TYPE_DW8250 "dw8250"
>   OBJECT_DECLARE_SIMPLE_TYPE(DW8250State, DW8250)
> @@ -19,7 +20,7 @@ struct DW8250State {
>   
>       MemoryRegion container;
>       MemoryRegion ext_iomem;
> -    DeviceState *serial_mm;
> +    SerialMM serial_mm;
>   
>       uint8_t regshift;
>   };


