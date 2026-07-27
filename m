Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4C6C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGBb-0000fp-Mu; Mon, 27 Jul 2026 03:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGBZ-0000fC-Mm
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:55:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGBY-0001GV-9H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:55:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7UANa3150899
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8gV7faiF21ufhrTi3z/TyNKetJ6XDbMrrMYL4D7G/xI=; b=MxyetsQ1Tto5gITM
 rGEKZtDRxGvUWcomoboPnpKm07pu3doI7Xq1u8ko4J5CdfPeEhdcbZey1Prnis8t
 MmwMFi4hHGDKCBBmgvc9+FeSS2hnN4eS+o8GKPlCcdTry8yncqEXfiBc/eGdStkh
 Q1F+ObfksfNTD5reGA3agXMoiBUVOdvbhm+SqfZGx1mFltggv1jD0IIc5Somuyp/
 LC0c0cQ5pqJRPVXCepddvaKzoPk4smvqX0HZHL1GxwAW8kU17FFu9KmFUsGCgar8
 vM8TlqbdlpX4zZUtR7MWrIaGVvFMoeJ4YwZm+wmwqoyBW4KInXX3jL1RFd6E12eN
 1s5w4A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g032e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:55:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e695a3b28so474492585a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785138938; x=1785743738; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8gV7faiF21ufhrTi3z/TyNKetJ6XDbMrrMYL4D7G/xI=;
 b=KV6SFdlY+dkqt1W3hH5OWtC1qo86VUBAFxb7FIwD1cCOz85qDSnT1IabQGjizPQ2e0
 OFZemBbaW1zNod+mN7TtblyHyh3jOD8zLXCq/njhFgngMA586/Uu7qX04cMpzkw/0I7z
 xxiB0v39/Pwdptvjs8BChJLk+mRFzIFrEaSqOx+o6FmjabKQxHsH7uIi1tDpa8s6OrRe
 IMTPm5I4t8h7AuzI//sZ2bmdMGZ7NLfyidfNJ/+TA+BG9SNU4Q4ZAyrwryrUpiaOjMi0
 FiqfWwkfHYYQwj6O2J5JZNZu9XPaMGQ/D2vD/I5q8ggaIaFlpuw4w2U7VtoUhP1YJbL8
 k0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785138938; x=1785743738;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8gV7faiF21ufhrTi3z/TyNKetJ6XDbMrrMYL4D7G/xI=;
 b=Kxxt3xwjJ05D5rRVwSFWO8RlkOruHH4OImkIAsVgZF+CsYCR96FSblvT03kbEU6mG4
 xrGn+sctcsYx9O8OHJR+I2VKMh/sKKu2Z285ZPBW+CCdLSTIYcYmhJQTh76DwM+/TqQr
 EKEnMjqCxnqIVY+7sXK5aNSh6S0l0tf+N/tjFWlY21fIFAX5uqCbwK6vZTgLqNLflbua
 oqc2mX67FycvMUs9+myKf2PcLeMcVFI9bwjcf0bLg72IYUKGjPnEdllvffY8ls608wKZ
 8ZZJIt+yD4iefE6W7s7IFnOLOLy8CT+YyxfL7ym59KLNC82wyz/QFXjgFPHllvDnCuVg
 OrHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpX5b38YoMT0Z+2l7nD7L7GwiqTe6F+JBD7s8lzkyx/vkQgfxqRqy0baylLRWMR5IFk5vOpvQn8byTu@nongnu.org
X-Gm-Message-State: AOJu0YzDnDA2+8tqxZLYCDNiZhgpt5gzMb4fK7wqZWr83uigwT3YivhQ
 uCyiqxa6bHviY8lnb2rqCwL/Jmx+yQKl2cJx6QeUejzpniFcdQUtDh77vVqzdHemUa5w2+AUGQb
 sv1tANIL3UUMVyISEMU6rRqE1AGJUHE39z7GKcdX4CW1XTAmaFlQDtldFNA==
X-Gm-Gg: AR+sD10MWrDNKhPcsTWBgVUjla0vnRiDHeGkgjd/Tyn5Qv5YzwxbM+11x2MK7bhsq49
 Qr4u8ghK7K3e1gPyjeRbBG2VpjGck40OCGgEIkLXDZBEbFxQiZ5+BCpOUwApSmkPrFER6K5lk4G
 QF1ByyIMtvyZDE7FNIaYwW5iBrKDGXV+ZoVP0NwaikuphI21IzLKzCPvn20TSJKzHeQP5A6aPGw
 TLKFvrixXYDn/Nq2ZnmefQi0JThCBIGSllbI/v7LSWLB68HIyFQfk36VWeguY1OZiQQ91x6B5+Q
 PPXHzMQEbBrADFU2cg+U4MUbMyunKMrDdss0Y8gso0UjkTPcyuXvh5PV3rNpJMRWi7OW5Sa7g1Z
 ZTFrGb2uADkkwPqAee355aolxFQcoUheBdRtXvIHnHlcFXIIaP4Y=
X-Received: by 2002:ac8:6f11:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-5295d2708e6mr101165701cf.1.1785138937643; 
 Mon, 27 Jul 2026 00:55:37 -0700 (PDT)
X-Received: by 2002:ac8:6f11:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-5295d2708e6mr101165621cf.1.1785138937241; 
 Mon, 27 Jul 2026 00:55:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4866ddbsm236152845e9.7.2026.07.27.00.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:55:36 -0700 (PDT)
Message-ID: <4350e006-8ca2-417c-9eff-60634c5def28@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] hw/hexagon/virt: instantiate virtio-mmio
 transports
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
 <20260724183648.190531-7-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724183648.190531-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a670efa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VUvIJ_r51-j5cc6DzBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NiBTYWx0ZWRfX3vtXl9G2DAd/
 WzBkwKlkS6rG2hLEfBdS12dC2s3d/TOYrjVNtk1Co5oSa/QCD8LB/LXXBPYIwLb+B+4XWokKylv
 YX5g2xAEa+vvHYLmMnYqeV5LCQBddUc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NiBTYWx0ZWRfX1AMddQd6zgCo
 RN1xUQ3JTG0Ubq53jVT2tA4dfUnwrwjMaL2PoK+wk92a7mlCrFxPEN6jhU1H75Pk5dEs1957m+a
 /GGK4wKoeOfMhdeRSVlAFZhoD0NYYEPMRQWr8QyI5jgBmakss6Ndr5w+cdMIPu/6q8PG05x2g4o
 8jWP//117gFq54C8wnSjgXc8OeRyerVWKpbesgj2uG+Djwc2eMtiPfet/A+vhKyuLppWNDNA8l0
 53ZZWDXkkbmukfA/7syr2TUdIMoqsmLeekztySNRO6eqNcoQAlHN1lq1tzR9Fr3qqqAaR6z7E5M
 TDoCr/Q5ZjtdIhmNxIQUcqcQNFpC7Zl0+cUtzcVsG+MYtknyTjLIrh9eehu44UrW2t/BWQmWq2w
 2tVykmCiINFOqrXL9JmtrN3qm/lEd430Q0StfuMYMI5KChkl2wsCzXM3lyah5/wDyTwhcvCWFxT
 0SHJbBE5iPQRmaY2C5g==
X-Proofpoint-GUID: A6onIdf4-Q4YWUS3osbM-qtyu0U4lhEO
X-Proofpoint-ORIG-GUID: A6onIdf4-Q4YWUS3osbM-qtyu0U4lhEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270076
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

On 24/7/26 20:36, Brian Cain wrote:
> Add a VIRT_MMIO region and virtio-mmio transports, wired into l2vic.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/virt.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)


> +static void create_virtio_devices(const HexagonVirtMachineState *vms)
> +{
> +    hwaddr size = base_memmap[VIRT_MMIO].size;
>   
> +    for (int i = 0; i < VIRTIO_DEV_COUNT; i++) {
> +        int irq = VIRTIO_IRQ_BASE + i;
> +        hwaddr base = base_memmap[VIRT_MMIO].base + i * size;
> +        DeviceState *dev = qdev_new("virtio-mmio");

Better to keep a reference in HexagonVirtMachineState, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +        object_property_add_child(OBJECT(MACHINE(vms)), "virtio-mmio[*]",
> +                                  OBJECT(dev));
> +        sysbus_realize_and_unref(s, &error_fatal);
> +        sysbus_mmio_map(s, 0, base);
> +        sysbus_connect_irq(s, 0,
> +                           qdev_get_gpio_in(vms->parent_obj.l2vic, irq));
> +    }
> +}


