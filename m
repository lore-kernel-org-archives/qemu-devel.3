Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC8C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzszS-00076I-LC; Fri, 28 Aug 2026 05:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzszQ-00072w-NJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:35:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzszO-0008Qm-Qs
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:35:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66jOt2045931
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QxLaD4ow/Db+lS11uQhy12T3ZTeX4yo4W/e+BsAVqcU=; b=BGCbGV60MFxZtdWM
 aA+RQNJObW0REMju4grjeAA2O4MVq/w38zhaeFo7BjHvA4p/nNGiNXe/JZtth2ep
 bGigwzVeizIgkntnGrmqpxYjeahbpIRX02D7AOTNcXM5aGTwPGzVxjSIExiFI6u3
 iJMCj3nYTTQtMr3ce3U9vLsJzYp5iudOvIQpCAShoXhXOXZUUFzfbMjbVf4cejbW
 ye9m3vUh3yvu+GX8vrls98D2joHynDjaJpATNQVoktpaybmj8y9+Kd5HJ1nnrI2C
 5dxu3hBLVNhcwvcfVOcBqH+PWSyC32kBmyKezzKdVj66/rpvw/BTZwgZpQRYplaE
 E0IAJg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v39h4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:35:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so16349951cf.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787909708; x=1788514508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QxLaD4ow/Db+lS11uQhy12T3ZTeX4yo4W/e+BsAVqcU=;
 b=HauVwk3Nd2vbgRYnpQECbgODaA4J3IhnmGqpxwvtcBCxbYSR9GAni9T7SlHY094jeC
 z+MAljIBbkZMtF6VajakS26meUJl2TnaIIuVUjy4rW0jQ/CYr7uGn/zNMaxfSgftvnYX
 8YTKH6hH6yhP+krrQVtEGH6pMzjng5cB+bHXuaNvnK/SGz4IocTYcf6lEiSR4q0eiLlc
 Z9gEa1UA9uDtARZzsqGspCswNZh5QdQbey2pjVdsn3aMKbo1RkfVLmrlcEgZXoIEacNJ
 EGOSY7WZI8DRTF2wa9n+w17Z+4ci+YWflkz+KxyKw8hdm4KivvePeG+cD5VkcNBRV2dR
 +4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787909708; x=1788514508;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QxLaD4ow/Db+lS11uQhy12T3ZTeX4yo4W/e+BsAVqcU=;
 b=XoCBuUstypGVYbxkhukIl6n06QEkkyV59v0qDQWG4Wx53paWbLDwb1eV8cF9AIwm40
 B9uPUWZ63/0bQM45toeng4xjTwGDo1JkeQPjl0Q9QYE3fa1eOyvkuDCv7rAaG/Op8FDL
 +hnuUYeldq7Z06IdRS7dipakMziqSmPHOOjzAksCtk0G4ame3RDto4kJdKC8YCrPn9Oo
 qRrzsSLBfqxYU6BHBDobO/ixnw9GydgxrLEjLlu/sfp+ncsiOcBEGTPrZBmK2+pMFVPy
 E+LNcudSCBWI1e3Rzi3CH77HLOpJs5GRPBgUURsSdJs4M2VNdqxV4sCn3n/p52AT4mGC
 QyVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQU5005mKMsYsyBgtjHEySINudfRdLvKGj7VbQcEp9wgQmWfFltxhXxDJ/JeEdK2TOa9MKQM4SnzUI@nongnu.org
X-Gm-Message-State: AFuF++ngMeSeQOVilt3mqORcx0q+DClSUj0X4upANHEQjMlFwPo5NJIF
 3dwB/MP/+qdMAtTlrjk14fajKIoGYHq75u0N3DWl6jqjXH90kN4SCOqmTnN6h5nyDlJrx7n7/9G
 Bau5SQA2D0NI/4PEijRj1EvZKrplIii9j8c4/RmJeaNfrUk7QztT31DKILQ==
X-Gm-Gg: AR+sD12VKY37jx2bpa71CCf9+YMtpFsblDCnzAn3tdNUcTlRPkcjZ4A4vaOgjXfQcCO
 tDri+W7DAF9RPp9+C62CYldcEKKDvVw2Z+9K8plxP2NaXIGJMOvY5sZ6IKnY/NzV9UjtP02qFDu
 Q/daMGS2jKfNbELJ4c/FJThRcpsAbaU1uPBgMbVf7bqqExatD6NAof3KJ68+OU01dbYVCErzt5P
 5qop6mUOJ1CAy5X+brLYC0AG+EH+n2dCc3nHtHl5ANiQrmHyVcKLeYWt6UAZz9VVkiGGcWYC2ST
 pvdgGuBJEUN9maq8bBe83hC74209qjKuA7LjDm2E/p+Y8Wm5H7YYmArWzRNUTiK+cbXqmKf+3Sa
 1A3m0uJvuVPL49hsiPxDs
X-Received: by 2002:a05:622a:89:b0:52f:a2b2:2dcb with SMTP id
 d75a77b69052e-52fb9445df4mr54622231cf.18.1787909707989; 
 Fri, 28 Aug 2026 02:35:07 -0700 (PDT)
X-Received: by 2002:a05:622a:89:b0:52f:a2b2:2dcb with SMTP id
 d75a77b69052e-52fb9445df4mr54621661cf.18.1787909707382; 
 Fri, 28 Aug 2026 02:35:07 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm2769830f8f.25.2026.08.28.02.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 02:35:06 -0700 (PDT)
Message-ID: <e603f6c8-9f7a-4bad-bb41-00abf46226d9@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 11:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
 <20260828090412.981841-3-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828090412.981841-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MSBTYWx0ZWRfXxkvn4g4eWiV6
 NtWiALtvnb1BnHkStMzCmVFflEdnfDib55YFioaDjoHp6aCjBp6YTO5pVxZe/TRkqXv4OYny3ua
 AnqL52zFJiGtQ79bx3EAM+rCpI3iRySW/hQAvcMTbRrSqlRLrc+e6/sLeHVGtDrYkojqOTkT394
 YXU9STWtpDTbCbLBIiYTtq4csb9wyu/YHSmdst1Y+rzUySgUdDRopLQAsuZMNCY9OzrkbglWK8R
 o7zybcjWFLXqaCzxnvUgnOvc9TBtQ7JxjGlaDwcCav2N1/I4eAkua0f02/EwQtJxYedpvSZyYIQ
 cPXMlHRc92JTkFUyJIsgpc/lxM8XIqlq7PKOkWxoyBzOmSYkahwyivE3gHKV9/Jzn0Olb5mKxat
 nlL8fw8TTKvXVTYVMB2/yeuh2ndbsZxgpdZVEsRvXeDHGqMJ2c5rVvQ6lFnbosdou4QpKAPgOa8
 C8BHLidA4hudhvMheig==
X-Proofpoint-ORIG-GUID: _nzFjw-Qz25Erk96Gnnn6a7aUu2Ppkdt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MSBTYWx0ZWRfX1KB5cam13QBY
 4sHwREN+rAO3mb9rGHW+2tF1k3DoQXwmSBjEjPMorttFF+KGX2322NoGKHNimxVTfSwpksGZWdr
 R7tYBCAGz7UcJzqWO42dCKoH6UML5Nc=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a91564c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gmLkG3rbZGpK/HF7jnAN4w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=V2NxCb60AAAA:8 a=Q5iDyHn4pEIuiJPS3BAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: _nzFjw-Qz25Erk96Gnnn6a7aUu2Ppkdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280081
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

Hi Jamin,

On 2026-08-28 11:04, Jamin Lin wrote:
> Present the UDC gadget side to a USB host controller as a USB device
> (TYPE_ASPEED_UDC_GADGET). This is a normal QEMU USB device, so it can be
> attached to any USB host controller bus, not only the BMC's own EHCI. It
> links back to its controller through the "udc" property.
> 
> This patch implements the control endpoint (EP0), which is enough for the
> host to enumerate the gadget. Host control transfers are handled
> asynchronously: the SETUP packet is mirrored into the SETUP data buffer,
> the EP0 interrupt is raised and the host packet is parked (USB_RET_ASYNC).
> The guest gadget driver then drives the data and status stages by writing
> UDC_EP0_CTRL; that moves data to/from the driver's DMA buffer and completes
> the parked packet back to the host.
> 
> SET_ADDRESS is the exception: it is applied synchronously, because the host
> controller keeps the transfer bound to address 0 until it completes.
> 
> The gadget connects to / disconnects from the host bus when the driver
> sets or clears the upstream-enable (pull-up) bit, and is detached on reset.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/usb/aspeed-udc.h |  28 +++
>   hw/usb/aspeed-udc.c         | 360 +++++++++++++++++++++++++++++++++++-
>   hw/usb/trace-events         |   5 +
>   3 files changed, 390 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
> index 58fed5f9a2..ab9d016c61 100644
> --- a/include/hw/usb/aspeed-udc.h
> +++ b/include/hw/usb/aspeed-udc.h
> @@ -10,11 +10,19 @@
>   #define HW_USB_ASPEED_UDC_H
>   
>   #include "hw/core/sysbus.h"
> +#include "hw/usb/usb.h"
>   #include "qom/object.h"
>   
>   #define TYPE_ASPEED_UDC "aspeed.udc"
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
>   
> +/*
> + * The gadget side of the controller is presented to a USB host controller's
> + * bus as a single USB device that delegates back to the AspeedUDCState.
> + */
> +#define TYPE_ASPEED_UDC_GADGET "aspeed.udc-gadget"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)
> +
>   /*
>    * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte bank
>    * per programmable endpoint from 0x200.
> @@ -36,14 +44,34 @@ typedef struct AspeedUDCEP {
>       int index;
>   } AspeedUDCEP;
>   
> +struct AspeedUDCGadget {
> +    USBDevice parent_obj;
> +    AspeedUDCState *udc;
> +};
> +
>   struct AspeedUDCState {
>       SysBusDevice parent_obj;
>   
>       MemoryRegion udc_container;
>       MemoryRegion root_mr;
> +    MemoryRegion *dram_mr;
> +    AddressSpace dram_as;
>       uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];
>       AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
>       qemu_irq irq;
> +
> +    /* gadget USB device bound to this controller (set at its realize) */
> +    AspeedUDCGadget *usbgadget;

Do you mind exposing this as a link property (and using the
proper methods to set it)?

> +
> +    /*
> +     * In-flight EP0 control transfer (host side), deferred until the guest
> +     * gadget driver responds via MMIO.
> +     */
> +    USBPacket *ep0_packet;
> +    uint32_t ep0_setup_len;
> +    uint32_t ep0_offset;
> +    uint8_t *ep0_data;
> +    bool ep0_dir_in;
>   };

