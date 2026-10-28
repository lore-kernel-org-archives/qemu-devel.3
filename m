Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AC606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OUXVXksn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iod9A7Yk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAiP-0007uo-U6; Wed, 28 Oct 2026 16:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAiO-0007r5-4Y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:57:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAiM-0006MX-4b
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:57:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIQECI1581355
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EOpEFWSisjrT5c6fkFMdm8vPVVb4c31jg+avCBk0qvo=; b=OUXVXksndQnUd2h9
 jnjZI6zKKWvZpOyRGVeaJ3xqPyJxYGG4U8J/3oFAknX9kvsaMLB1Yu4O/XwBwtWq
 kkm4zWAWe6Td0n0hGwTv4xFqloSXW5CBlxFCJKbkwgt1XOBziznsGtVOOY/wuvZf
 ZwEC0cZaHCAE2U3DQhMvi1D7gwQ7pfjymxUsw76n+PhVLfNAVJ+xHkMct+bp4wMg
 O/QgWQl5ULZ5xYawB4NZqYlw37OlahIerRX5ZN8JRz467iY5lr5beOsKzTRhM00E
 l5UG98tSCnGFn2ile3KiJWWINaIwLcwiptzP3XztgYGUJUHIrtAQEvQ8afYEE2zt
 J4ECvA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8qmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:57:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso27861eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793221060; x=1793825860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EOpEFWSisjrT5c6fkFMdm8vPVVb4c31jg+avCBk0qvo=;
 b=Iod9A7YkwgpLyV++U0lr0jPPn9ZbgxEUiFXw897RhVV3du3slVWJbZYgCjqyuLSccO
 zqV5c52j3wIvXlaEtaLsaEYxqvpQclzZKQjgweZZHR3V4EaXI2r2fbWizugLT9smfhGJ
 XOKXZwl0lT2m/u0cygVu5MxaJvsHCt4rhdZnkyxvLk/kV2SjdIocdpKg7bwBvtC6EE06
 ms+5YtrJraSJIhHaP8bdBGtsutdeeRFsL7wTHA2W/Q2f2fZQClz5C1J0v9sh61X+qtLO
 bCT3WadiQWtzrFr6tuWf06XXy5o8xLidJxipPg4fYvv6nWi8lfigQCbQkvB9FmTrtlK5
 Fsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793221060; x=1793825860;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EOpEFWSisjrT5c6fkFMdm8vPVVb4c31jg+avCBk0qvo=;
 b=M2arkqiO7Ioo1W+LtDGBQCF8ebrm0qi7kzYOVuPoDbaN0i0pMRgt9BFO5y1DKF74j9
 MxJ3o+tlCxs1n9NtS2qEomZdzzSOq5XT10hDpz6/E07PHJRbgVbjA4ug40iPsqpp2UZA
 7F4kzZa5d64E2fnPIc3NZkovJLXO9lZl6W0jh+Lul+dHi87xiQKQgtU5m0to45mb3Wg2
 s486EBobmgi6Y+A2aMm+Bwjv7Ccbck18fi5Elov9ckqPRyRJ69P/jKAwetXn3u+Fe3Lt
 y02iqMo5/ZJ1pLCr0HujZcPXZR/V3bLCN4ag7pASuc/e+OberZIAXPKZMGtO9yzJ3kkG
 ojDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCGLGizpr3PU86lRjJ+qg9qQEmOX7rg3myYHXOTcejdpQVMgbQD+vBkT41EGwyxIYjTvnuBUfEgxL5@nongnu.org
X-Gm-Message-State: AFq9FYLnU8wqsBChR+y4UWUV9/GEu1kA6812HBdAV18m6ocM2cvWjm4i
 bGw1XvHjKNrLZbslkMa+LikWsv5llA+fW0llfphfkam0OKJ0RdLqyu3TeKbG559wZp8wp9O7nxQ
 TgWL2tkVm0o6k52xgmGjNCPd6EcgUkc5JdsDUvFE1Lsxm2qybT4/D15yRQQ==
X-Gm-Gg: AYBFou0P5lgNcAPNPLGpzFW4SkRkW5c2WYYmODcS0tZDpAsF1r1GTNf8Z3bmEli7KOn
 S+fyU+w87Mxaai6KDdPF/ScVxsnNUjZWX5Ll2/DE/4MdFdsg78a+rEhxOugCMEMX7ykPt/mUeN2
 gGNqGBK2DhCdI/TEYY6gWLm6uOz0AyxpDT/gKguJKSCmQmfkAfSyWfsA7vJHikCab8xaixqsk3z
 I8z9MozErNuam1vk04bhVuUioLgrYKmdwzDHZ430lf0YR/2+aW8BGbbagjLEFTDWB+3Nmy/USdd
 gIsW1vvre/BkkxXmhyEIE73Z8Yj3ONFAFZBA7yWZjlyDq7573NsxrwCSL9ZX1PdK6so59XUdmPa
 8joIl/pBpeIyHVLtgTfr/gdDamViD6wXISrOCdzz/FSwIET1tXFvqw1wax3qC6Ix0XkaK576fSW
 k1KVCwOQmyN/7naYk8xSFwrS+ZF5gY/8IHIQtpTqZnWMU=
X-Received: by 2002:a05:7301:188d:b0:369:f3e3:4277 with SMTP id
 5a478bee46e88-36a204bf28cmr4897794eec.38.1793221059596; 
 Wed, 28 Oct 2026 13:57:39 -0700 (PDT)
X-Received: by 2002:a05:7301:188d:b0:369:f3e3:4277 with SMTP id
 5a478bee46e88-36a204bf28cmr4897749eec.38.1793221058889; 
 Wed, 28 Oct 2026 13:57:38 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238dc80dsm10533122eec.9.2026.10.28.13.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:57:38 -0700 (PDT)
Message-ID: <18efc198-f211-4219-b6c9-9ff34dc94e3b@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:57:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] hw/virtio/virtio-mem: register legacy-guest variant
 with is_available
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-12-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-12-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae261c4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=sjczGJGRD0jTwJJuDEAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: PnVUxF2rUoz0a1p2Jk7JA8xWhOvp6WS7
X-Proofpoint-GUID: PnVUxF2rUoz0a1p2Jk7JA8xWhOvp6WS7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfXw1CZUp6vLw/s
 FiF75op+/DdIZFASGEFhAza8kJsfbkU77QRJ30s3KMk1Qo27YYEg2fpxXbbZ0yzUbeDtgZZsMvL
 EDbq2c7JBY9F7eFB1AiSjW6P2DiGCqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX0s+9DylUJDeQ
 oVw+tWE8qcSryFd5+djBWbLHChlT8Os7Vzjet1rCh4NfLkEmqY+SK13u9k50LA94MByzRD7exaK
 EH8lAH63t35t0AMQPhPxb4mKlXCjM9od2BWrqot4NVtthuSkc4z6yA6ZRb6Yoph6ENbHgHbPTxp
 y4w29nf7b7XghJDaFWFFjzmKoEt33CeCnNUiPREFzXye953tgohzvLJk5DLSE0SYjZJe7/k3q49
 XG4655pXxQj0EuvO0kOOm84pfM5LCa8DVxxOLAb7WPD7dNf2Ir6c0BOpNsAtZ002Iw1CJj/+pEl
 r/MhspJwUHOngbpiaUXJoUvHsJU8wIX2MHLCV0iS/4ZLZtYTcJwKV7NiXbc6txJQvpIANM/OR3+
 VyH8IhQJ0LV5+xyfrc03P+7DiV8+1KvFg6ww1YCRRgxbvzyKkwJCT7TQGRY0SSvv57ZxGP/gCmo
 AK4wAuosbT3J74cUSpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> virtio-mem decided in class_init and realize whether x86 guests can
> leave unplugged memory accessible. Register a second virtio-mem type
> that adds virtio_mem_legacy_guests_properties and sets
> VirtIOMEMClass.has_legacy_guests. Select the two with
> target_base_i386() and target_not_base_i386().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/virtio/virtio-mem.c         | 47 +++++++++++++++++++---------------
>  include/hw/virtio/virtio-mem.h |  2 ++
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7130ed852d9..bf241a3112b 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -15,6 +15,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
> +#include "qemu/target-info.h"
>  #include "qemu/target-info-qapi.h"
>  #include "system/memory.h"
>  #include "system/numa.h"
> @@ -35,22 +36,6 @@
>  
>  static const VMStateDescription vmstate_virtio_mem_device_early;
>  
> -static bool virtio_mem_has_legacy_guests(void)
> -{
> -    /*
> -     * We only had legacy x86 guests that did not support
> -     * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have
> -     * legacy guests.
> -     */
> -    switch (target_arch()) {
> -    case SYS_EMU_TARGET_I386:
> -    case SYS_EMU_TARGET_X86_64:
> -        return true;
> -    default:
> -        return false;
> -    }
> -}
> -
>  /*
>   * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
>   * bitmap small.
> @@ -859,7 +844,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>      rb = vmem->memdev->mr.ram_block;
>      page_size = qemu_ram_pagesize(rb);
>  
> -    if (virtio_mem_has_legacy_guests()) {
> +    if (VIRTIO_MEM_GET_CLASS(vmem)->has_legacy_guests) {
>          switch (vmem->unplugged_inaccessible) {
>          case ON_OFF_AUTO_AUTO:
>              if (virtio_mem_has_shared_zeropage(rb)) {
> @@ -1635,9 +1620,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
>      RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
>  
>      device_class_set_props(dc, virtio_mem_properties);
> -    if (virtio_mem_has_legacy_guests()) {
> -        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
> -    }
>      dc->vmsd = &vmstate_virtio_mem;
>  
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1660,6 +1642,14 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
>      rdsc->is_populated = virtio_mem_rds_is_populated;
>  }
>  
> +static void virtio_mem_legacy_class_init(ObjectClass *klass, const void *data)
> +{
> +    virtio_mem_class_init(klass, data);
> +    device_class_set_props(DEVICE_CLASS(klass),
> +                           virtio_mem_legacy_guests_properties);
> +    VIRTIO_MEM_CLASS(klass)->has_legacy_guests = true;
> +}
> +
>  static const TypeInfo virtio_mem_info = {
>      .name = TYPE_VIRTIO_MEM,
>      .parent = TYPE_VIRTIO_DEVICE,
> @@ -1668,6 +1658,22 @@ static const TypeInfo virtio_mem_info = {
>      .instance_finalize = virtio_mem_instance_finalize,
>      .class_init = virtio_mem_class_init,
>      .class_size = sizeof(VirtIOMEMClass),
> +    .is_available = target_not_base_i386,
> +    .interfaces = (const InterfaceInfo[]) {
> +        { TYPE_RAM_DISCARD_SOURCE },
> +        { }
> +    },
> +};
> +
> +static const TypeInfo virtio_mem_legacy_info = {
> +    .name = TYPE_VIRTIO_MEM,
> +    .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_size = sizeof(VirtIOMEM),
> +    .instance_init = virtio_mem_instance_init,
> +    .instance_finalize = virtio_mem_instance_finalize,
> +    .class_init = virtio_mem_legacy_class_init,
> +    .class_size = sizeof(VirtIOMEMClass),
> +    .is_available = target_base_i386,
>      .interfaces = (const InterfaceInfo[]) {
>          { TYPE_RAM_DISCARD_SOURCE },
>          { }
> @@ -1677,6 +1683,7 @@ static const TypeInfo virtio_mem_info = {
>  static void virtio_register_types(void)
>  {
>      type_register_static(&virtio_mem_info);
> +    type_register_static(&virtio_mem_legacy_info);
>  }
>  
>  type_init(virtio_register_types)
> diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
> index 5d1d19c6bec..f367959ecb0 100644
> --- a/include/hw/virtio/virtio-mem.h
> +++ b/include/hw/virtio/virtio-mem.h
> @@ -134,6 +134,8 @@ struct VirtIOMEMClass {
>      VirtioDeviceClass parent_class;
>  
>      /* public */
> +    bool has_legacy_guests;
> +
>      void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
>      MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
>      void (*decide_memslots)(VirtIOMEM *vmem, unsigned int limit);

Fine for me, let's see what virtio maintainers think about it.

Regards,
Pierrick

