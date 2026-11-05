Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA938606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6TWX4yj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuBr7XfL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsa5-0002ga-OG; Thu, 05 Nov 2026 03:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsa3-0002fj-LT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:12:19 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsa1-0007CT-Oz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:12:19 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56U4XG3073642
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 08:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q3xdU1s65N044DqLVYZOU0ShsZknbB+9fK+x06gPOeY=; b=W6TWX4yj7r+m0w9i
 /JQHPzCRn24+wRospM7JdBO6q2RjM03+gQ2uieUPllplXO4o8sk9P5TAWCvQhv0p
 /6xQ+jkPiOK9FQeB4CdqeQa/lXLOXaJEGIE8OOJiIAF+YhHXtmrEtsFHjo7wV1X0
 3NrxK6ozmuMnmal2LK3bv1p65XC054p8D8AfryI8OzDQ4KLrvFRhM4OlYVfWsGoK
 s5wtJKs1VwfJiR5ckfh6UfvcX+S2wvMfOkpKuEkEwVktH97xXIUEyMEcMulHT7u7
 RHTqkQ7WE5qmbzO1sfRgMyPJeJAG4tpjyXNvkOjx4yur9MgQYUZm57bIwxYKocXm
 IO7nEw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq8k8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:12:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1902475eec.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866335; x=1794471135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q3xdU1s65N044DqLVYZOU0ShsZknbB+9fK+x06gPOeY=;
 b=IuBr7XfLVwMFJKleCm12bxRzGPAZPdL9SPn5iNDaO0r3b45pudb0k7tq9vhzaR6Umy
 5H6ad7X7Ftj+LKPFJDwxADQpUncz5joIFZGyWOeeQz1Bmd3FB91Ro0lsWWgPOyLs63tm
 JMAwMS3LQW07oNP8lK5OTgpg4P+izCDmIya4VbM6X+PU4uUeRQb/NW0IEu7SIC+OqUiD
 0XQwi8dKOyOMSocptCbiK3XyDl4M/Wro+A0/ld2ptwxVqmE3MQHnkUUNRWl1mMYsmGNz
 Zj7zs/WUM57U6B+N+8lZ2lL3qvatuptA5eZ2v1y+DzM32QvTsrDVQlPuialWGqWcingE
 us8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866335; x=1794471135;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q3xdU1s65N044DqLVYZOU0ShsZknbB+9fK+x06gPOeY=;
 b=AfTIcPO6u5ZYMje9emY2uCX/EmTLvvY0e8ky9SFLhYDoA6obFnTOAKFX3VE0iIzaQQ
 54rp8GOEsROsjjGisfTc/LDSyGlBRmn3wXpXdLU14WVkFwy6Fot424QrIQrzMsO0vpwB
 WV/xg4JkQa7/KECScSuv2vZqN4T0UmXiel869UI+Ax71nQoLMMn9a5aLnQ/84XrNV9ZK
 RzOZqhxguTXF7eZYqHt2aiqTULewHaaNu3Z37Rihbbzb4s7Y2x5zgCp/21O4tYe01zSG
 Sryn1TJwB8/IbueHCJkpRPd4xL4DGPZrKO1PNY0YhJZgCb8L5Uax2WpNmgP8p5L4+W7x
 XZIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByVhgUi3ccWqxxAIWylIVaMdAxcZDqXGQNZ8cVgy8+BjzzGOm+DcK+PATuGfo4p7WbCbrNBSKoYRSWi@nongnu.org
X-Gm-Message-State: APuU4Z9nOO7MDp/P3MWF5kScCwMXITxCm2dluABFgfnkXPVtCSrn5neB
 ItN61lIvgSeriAQ6r58JZ682sBiPnO1Rerr04ND4ce15flIbA9VAwuYHAJeRzzaEmnCoVJqTOBF
 ifa9buSwzKxX6gI5D20yXYuTQJSzD8vjNS3dNyKJoCvtIw40YxzRxZI7DlQ==
X-Gm-Gg: AYBFou2xXsY8NIsJ/JhiwZLaRh3zC/Fexb4+SbZAGCNebtjXbgrY+GDl7Fea5vx2Zta
 uII8r2GJF+Vs+mllb7fqVRCBxw6IFayt1PDqyJLGOiGRl/rRV7bQ6PUQLyhTqhyCWAOVyKdVwao
 J1qdA9jvLGGifOgWDfOnPVMaWaFZsNsCKEyJ35R3h2Sdua7Bj4KOWlz9cDprfabk6LfSf77mXqO
 8NZPwK/Jx4nWU3xml7R4eE0AhXL2DRRaG3eRACMLN4tvtG3Jf983G5wsl6Yce3K2HlMI5SMkmjJ
 rvFSVmzBaxeiTerTq3EqtMH+HVY+L21gJpjV63RbGs8lqex78KvnnZSYiUEEApMv+PXo9A1Y2lC
 V9o7ZFvoaqxYbMrvuP9emPan8avPzVyB5bk1A2eGQ2G2kK+Du0Uz3FF3SIyXQca6oXL3sHzNAy0
 5t8yHtiVpNuxiA7dHTiQ6WElUtId2fTbqad+ThJgA8AQ==
X-Received: by 2002:a05:7300:148f:b0:36e:16d6:f45 with SMTP id
 5a478bee46e88-36e16d614d0mr2895755eec.23.1793866334658; 
 Thu, 05 Nov 2026 00:12:14 -0800 (PST)
X-Received: by 2002:a05:7300:148f:b0:36e:16d6:f45 with SMTP id
 5a478bee46e88-36e16d614d0mr2894436eec.23.1793866315799; 
 Thu, 05 Nov 2026 00:11:55 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3966daasm18519113eec.23.2026.11.05.00.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:11:55 -0800 (PST)
Message-ID: <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 00:11:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXwmwU9fb88iTS
 bor/irsmGJKQDcJyB0B66Dm8GQi88IP3qTo82iEjZyjpe1APDo5EHGwyQxOhRRH1psRR+rpSxch
 9vnED/28utwXJzQGKwWOphPqNH4tm3OWaQ56l7oGzxs04kxPPI4L4GTqLJqegD0QpaZ3REqUgBz
 VYLzVngcrCmRls5fzzzfkP+oojv4QauoIUlaUREmZZyZjI7/hP9KuF7BLPa00zYNEgjtF1PCF96
 WG2D2UGQMpJWZ0x1mSG/znuwvWBXM6I3EhIJQq/C6+1y72ypIZo1BpT8WL+5OL9zU/eokjh6RAW
 DiaT2YLOqmXzHRDj0CfILIXHj5bFvJ6AKPlkjGoS5GUQuvI5F43JY4lyN0Z07fRdlfV+JTLhroq
 qdXW6gp9b53VZD7kN+lynp+jexYAgXvR9ZEgCub8GdVXcMpk8S3YMLYa6vOnmv6p6+MpVeFfGk1
 Xdf0Pg8HAJ16bV2oDLA==
X-Proofpoint-ORIG-GUID: nSFTTKPLkhZhAmF837JyCzk3Rr1ehEgH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX260lxcerQrZ9
 +RdWku4yhwz/ikW4d+EQSLaPUnTPnUZv3SE0aKfXo5vvR98VRWoJc22s59ASWVHf3xt+AYY1xXt
 to0cYpHbuY+fYwYtAwhmFEC6ifylRyQ=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec3a5f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=5BzGauNo-O7mRAc17TAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nSFTTKPLkhZhAmF837JyCzk3Rr1ehEgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 11/4/2026 11:12 PM, Philippe Mathieu-Daudé wrote:
> On 4/11/26 17:34, Jim MacArthur wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Rationale?
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>> ---
>>   hw/ide/ich.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> ++++++++--
>>   1 file changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
>> index b00987f08d..58e2d3b998 100644
>> --- a/hw/ide/ich.c
>> +++ b/hw/ide/ich.c
>> @@ -70,6 +70,7 @@
>>   #include "hw/ide/pci.h"
>>   #include "hw/ide/ahci-pci.h"
>>   #include "ahci-internal.h"
>> +#include "system/spdm-socket.h"
>>     #define ICH9_MSI_CAP_OFFSET     0x80
>>   #define ICH9_SATA_CAP_OFFSET    0xA8
>> @@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
>>       },
>>   };
>>   +static const Property ich_props[] = {
>> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>> +};
>> +
>>   static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int
>> level)
>>   {
>>       PCIDevice *pci_dev = opaque;
>> @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
>>       d->ahci.irq = &d->irq;
>>   }
>>   +/* Sends an SPDM message and receives the response */
>> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
>> +{
>> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
>> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
>> +    void *rsp = doe_cap->read_mbox;
>> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
>> +
>> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
>> +                             SPDM_TRANSPORT_TYPE_DOE,
>> +                             req, req_len, rsp, rsp_len);
>> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
>> +
>> +    return recvd != 0;
>> +}
>> +
>> +/* SPDM protocols: plain and secured SPDM messages */
>> +static DOEProtocol doe_spdm_prot[] = {
>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA,
>> pcie_doe_spdm_rsp },
>> +    { }
>> +};
>> +
>>   static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>   {
>>       AHCIPCIState *d;
>>       int sata_cap_offset;
>>       uint8_t *sata_cap;
>> -    d = ICH9_AHCI(dev);
>>       int ret;
>> +    uint16_t cap_offset; /* Next offset for extended capabilities */
>> +
>> +    cap_offset = PCI_CONFIG_SPACE_SIZE;
>> +    d = ICH9_AHCI(dev);
>>         d->ahci.ports = 6;
>>       ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
>> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev,
>> Error **errp)
>>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
>>                        &d->ahci.mem);
>>   +    /* Legacy capability for ICH9_SATA_CAP */
>>       sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
>>                                             ICH9_SATA_CAP_OFFSET,
>> SATA_CAP_SIZE,
>>                                             errp);
>> @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice *dev,
>> Error **errp)
>>       /* Any error other than -ENOTSUP(board's MSI support is broken)
>>        * is a programming error.  Fall back to INTx silently on -
>> ENOTSUP */
>>       assert(!ret || ret == -ENOTSUP);
>> +
>> +    /*
>> +     * Initialise a capability in the legacy space after the
>> ICH9_SATA_CAP.
>> +     */
>> +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET + SATA_CAP_SIZE);
>> +
>> +    if (dev->spdm_port) {
>> +        /* Set up the DOE extended capability, mailboxes etc */
>> +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
>> +                      doe_spdm_prot, true, 0);
>> +        cap_offset += PCI_DOE_SIZEOF;
>> +
>> +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
>> +                                                            errp);
>> +        assert(dev->doe_spdm.spdm_socket > 0);
>> +    }
>> +
>> +    /* IDE extended capability */
>> +    pcie_ide_init(dev, cap_offset);
>> +    cap_offset += PCI_IDE_SIZEOF;
>> +
>> +    /* TEE capability bit in legacy space*/
>> +    pcie_cap_tee_init(dev);
> 
> Which section of the ICH9 spec describes that? AFAICT ICH9 predates
> DOE / IDE. Is there some amendment? Otherwise this might not be the
> correct place to add that capability. Either use a Frankenstein ICH9
> with a distinct model name, or add at the SATA layer, possibly like
> a class interface (we only need the SATA_CAP_OFFSET IIUC).
>

It's an ad hoc addition, reproducing what Arm has been doing on fvp for
device assignment. It does not really model a real device, and nvme was
(is?) not supported due to other limitations.

IIRC, we found that in the tf-rmm branch supporting device assignment.

While it does not hurt, that's why I never sent patches before because
that's indeed a custom thing, that works for a custom software stack
that was (is?) not yet finalized.

That said, it should not hurt to add it, since it's just an extra
capability.

@Jim: Feel free to complete my answer with links to the code and a spec,
if there is one to share now. I'm sure Mathieu Poirier has all this info
also.

> Michael, Tao, what are your view on this?
>

Regards,
Pierrick

