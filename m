Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DD606A32E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jXxLdwfo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iZrdr+N9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrfg-0007U3-9r; Thu, 05 Nov 2026 02:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOrfU-0007Pr-8m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:13:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOrfS-00037j-7C
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:13:51 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56UJi93819874
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 07:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gr8tudBe+DJIIfIYzWqBYQVX7VU/vsEv4xppGqZtmYA=; b=jXxLdwfouncJxRwb
 KXuWwNcwUmXmeqqzHhpLHPt3uumJ+EWOf9eSPxwTLKQOmBFFnFhKC1Hc1arN/tOL
 JdmRwnDQAiBj9xuKbxW8mHx1KJCVAFHwEh1xL1wRwSCd7/u1LSLMpTt5B9zl0ALZ
 +t2f3+AQuXiVFcN2DD0I2auDlrkp4EMNpMreXFM0nl2LVypL1y7ZS+uKDV4p/esD
 OayW5LROWwq9pVTYNcM6UMeiKcLiW3xiOT4MI/PzXuFp9AhwH2J4QNs5wx2/ht7R
 +yeV1bM9C2FnFmvLJBEgj5TLgHwHHcKSRSMWbP1ohMAeVhfDEW2MNkt9GB5MdUKi
 wTwFJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hra5tjna0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:13:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso363127885a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793862828; x=1794467628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gr8tudBe+DJIIfIYzWqBYQVX7VU/vsEv4xppGqZtmYA=;
 b=iZrdr+N9pr+CXVchfv7t6G3ojdviLQ87v8WnYK8AqZk7gTw2GVSWrclerVrKEdc/j3
 5jBs3l7SJqox9MgtecfNkph2vqZ2AEHjlvj2FCTtWqTs0rYEpZdDnwlqbGYHpudxcx1L
 CC0FkrYj5GBBs1emQDvC8cwhZ9G9srItBOif9u93/tj+hJfRXPXO7MX0GFkoqzEowdIa
 tmaqI5aMeFyH1Oq906nxHTlZDRYQnEyQyrLJRI5pg0It9V8cWdToXq4NBoYC25u4hnoH
 FsxckNo4nq/w4omLFikOWr+FTL751DntuVZ6y8sJRPOtJ41wRtwzdAUcgLUJWL96hbeM
 B79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793862828; x=1794467628;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gr8tudBe+DJIIfIYzWqBYQVX7VU/vsEv4xppGqZtmYA=;
 b=sr52hIzlPTIW9f2eHAdNRIjxp5IvA8GJCFaVe/K+uYzrMEsY0d4R5ilxSnMr7fEx4+
 RQyOEIMWA3F253G3bDjHRzO6enJE7kZJvoC6ylNNh3b2hmN6md63PNu8dkpprIL4Zp1E
 u9aKHwadtXcjayWKbVHaq7oCwSeH84rqZmo4bqy9QEXGITAzbwtUeEe/w2RRJs9xDovE
 D2kvnf6G97rBqL5XQSW0BHzxIAGuQj6dr2m50XDue4ChaZwNvHkNrN7rZGXbUlWNiE4/
 +HZbHr4DcmFYBs0dEmk2C7bGxv06Q8/1jHQdD3HPHGfsGRZnbUAIF8LJ5g1ixozWBNjN
 CvJA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCIkghmiW0CMrp5l21/eTwImSDBGoIObNaIXWA0YhrGwWjyXh98vyfgv2VZqD4OXh6CnkdxTehfwLH@nongnu.org
X-Gm-Message-State: APuU4Z9tVMkwtoW5MQGVLebNH54SQwO9zr1iyQLNcUbvniNXyK6r5QO7
 Ar53hJvckkAAZw2CUT3atczHuCPTqghRpXjv2+waOv6D6iEyzjJRZucFtNa5OLZglicE/sdzB9k
 ABuV/ouY6phQ7qb3BHrohqy9ZO/nIjPNgoXFQ/CGjmunRrw5pqUf0G11okw==
X-Gm-Gg: AYBFou1cEPvgXTP6PPCTBNne2lmoVBluXMm4kiX8qTfn8vnqs0LXHWwHqoU7V1ojxcM
 lzeRxrMaa+fkg1qLg1cmnCLyP/Ae3C/CEjEzqt0xUBOILOWpebDtCnYEMUwLTUKYGHoMdt20j8F
 2EV8QRUwfKp8DsuJJdUA6qPmfVEHHctGZ5D2+kKgzFsv3Jdv+P/lwT0w/3FaUpvTjVAd0Sdxm1n
 +gXQty68KDWFjGfiJIQK9hJA0zNI7tEPz8rWUfR8tEICqrn10suMw3ajWD2uyBE0YiWF17ZOZIq
 eOI/NHLpV+3AfeSru4aloMhMQsEllz127wqkxdTi6Bu00z9P7eyO23bJUP78Hm/nfpEdJl2y3Hw
 k3GIJ7y24KOPljTvGNMQeA3uWRiis2WfmczuCu/I+ibq0Vpb8cE0vgw3Gewiac6FAgE2euTog6A
 SI2FUDuQ==
X-Received: by 2002:a05:620a:2901:b0:93e:58a1:3da6 with SMTP id
 af79cd13be357-944216dc3a3mr3146737085a.60.1793862828066; 
 Wed, 04 Nov 2026 23:13:48 -0800 (PST)
X-Received: by 2002:a05:620a:2901:b0:93e:58a1:3da6 with SMTP id
 af79cd13be357-944216dc3a3mr3146732785a.60.1793862827193; 
 Wed, 04 Nov 2026 23:13:47 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56fca22e1sm50789265e9.14.2026.11.04.23.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 23:13:46 -0800 (PST)
Message-ID: <64dc312b-f2b7-4156-8d65-d8894dceb1a9@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 08:13:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
In-Reply-To: <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyOCBTYWx0ZWRfX2COKoVwnRYiN
 zn1mwIfo/hrhyXCU6FZRsY75WKtguR7cwHteSV1BlvTcqWpU6IWv7BhL3yqTGLGBSaS5x4MU8PY
 dmsYiIG5ZzOapyrZSo9flWZ9C/L0q7Y=
X-Proofpoint-ORIG-GUID: 9NMSBG1lDcCZ_o2mrXK-4EFoub0KYDLX
X-Authority-Analysis: v=2.4 cv=P/6vFSAu c=1 sm=1 tr=0 ts=6aec2cac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EZ-dVcApbixcmiaftBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9NMSBG1lDcCZ_o2mrXK-4EFoub0KYDLX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyOCBTYWx0ZWRfX9l04OGPqCyw4
 P1VEmMMCJAhUKsTWR2iZUCXCZylNCgR26S7CL164gVK8eYp6buc4NBc3yH/KB0FEsKfZ4t9PBvI
 a5t1oCaw9bs7eQSJReYwXLNRbsCfgFk78PQ8XFRIOO0uI3IKkmf5pIuDlcz1eEb1g2zr4YL9odw
 rDxidMxkcoxRzH5rBjzZ072XxQsqG9VFQ2dCkSpZCpfKP8gf2bMvbTBCrpARlQBYo4tmyoXD2ok
 5MufnyKlgxK5tXvOcCwY8eRMXNtd9FX3ifz5FqWer1ojwNwvRUwvPbygd1TNYGNQuXygD0XMZXM
 0hOZdz9PZQNrHzUys9pi+3LTrIc68ba11vnCrXRdiePwf4MkWQ3YlmZLCmHWkz+pqL8byd1IDMc
 F8w+WnKkmt4KaD2OUBq2llbq0ZASP0TbfZaCIpsK5NeGr3n5jNiTrCLjBZbCdi8WFfUCW3PJyj9
 En9io9LriqrOl1w3Kyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050028
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

(Cc'ing Jonathan)

On 5/11/26 08:12, Philippe Mathieu-Daudé wrote:
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
>>   #define ICH9_MSI_CAP_OFFSET     0x80
>>   #define ICH9_SATA_CAP_OFFSET    0xA8
>> @@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
>>       },
>>   };
>> +static const Property ich_props[] = {
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
>> +/* Sends an SPDM message and receives the response */
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
>>       d->ahci.ports = 6;
>>       ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
>> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, 
>> Error **errp)
>>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
>>                        &d->ahci.mem);
>> +    /* Legacy capability for ICH9_SATA_CAP */
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
> Michael, Tao, what are your view on this?
> 
>>   }
>>   static void pci_ich9_uninit(PCIDevice *dev)
>> @@ -176,18 +231,41 @@ static void pci_ich9_uninit(PCIDevice *dev)
>>       ahci_uninit(&d->ahci);
>>   }
>> +static uint32_t ich_read_config(PCIDevice *dev, uint32_t address, int 
>> len)
>> +{
>> +    uint32_t val;
>> +    if (dev->spdm_port && pcie_find_capability(dev, 
>> PCI_EXT_CAP_ID_DOE)) {
>> +        if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
>> +            return val;
>> +        }
>> +    }
>> +    return pci_default_read_config(dev, address, len);
>> +}
>> +
>> +static void ich_write_config(PCIDevice *dev, uint32_t address,
>> +                                  uint32_t val, int len)
>> +{
>> +    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
>> +        pcie_doe_write_config(&dev->doe_spdm, address, val, len);
>> +    }
>> +    pci_default_write_config(dev, address, val, len);
>> +}
>> +
>>   static void ich_ahci_class_init(ObjectClass *klass, const void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>       k->realize = pci_ich9_ahci_realize;
>> +    k->config_write = ich_write_config;
>> +    k->config_read = ich_read_config;
>>       k->exit = pci_ich9_uninit;
>>       k->vendor_id = PCI_VENDOR_ID_INTEL;
>>       k->device_id = PCI_DEVICE_ID_INTEL_82801IR;
>>       k->revision = 0x02;
>>       k->class_id = PCI_CLASS_STORAGE_SATA;
>>       dc->vmsd = &vmstate_ich9_ahci;
>> +    device_class_set_props(dc, ich_props);
>>       device_class_set_legacy_reset(dc, pci_ich9_reset);
>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>   }
>> @@ -199,7 +277,7 @@ static const TypeInfo ich_ahci_info = {
>>       .instance_init = pci_ich9_ahci_init,
>>       .class_init    = ich_ahci_class_init,
>>       .interfaces = (const InterfaceInfo[]) {
>> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>> +        { INTERFACE_PCIE_DEVICE },
>>           { },
>>       },
>>   };
>>
> 


