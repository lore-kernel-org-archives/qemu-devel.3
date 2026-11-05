Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B29606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=alTtl2v5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NS2s/b4c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsiO-0004Si-6J; Thu, 05 Nov 2026 03:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOsiK-0004S5-Be
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:20:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOsiI-0008GV-9A
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:20:52 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56UGPA4179293
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 08:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dQpZo/Sw+/Z0us8Tb25lhC6Emwkgu6P7hGLlm09+01w=; b=alTtl2v5G5/Hqcu5
 9uDUeOs6uQMl9z15BNBectwDTU9Mr9BSQQMyVHk1vblUIVyyKbCdcXQdxyO4TuTc
 mwMJI2/HPXI9QEbnn0crSnlwP13Vc5/+QFId3DN+6QXe6gAOE4CP9jrbTBdBJx/Q
 kH73mWg0SLMR5eY9jcG3Sam8NHcaH8mo9tLyE+S+vyeqf9ZJGeTHZioJ6Q5F0qEg
 GJPA7+bRv8SANi/IobcExT90K5Rzs2tNS9EpISM7sQrSQWM89jx5XjKJ3cSejUaX
 9vgOws4M0VSYbpuntFL16SLXGEYu7+6z0/sqQvuhZ8Ol6ntckIMF08flOYQTa4sQ
 aeT3Yg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn4mg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:20:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso372019785a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866847; x=1794471647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQpZo/Sw+/Z0us8Tb25lhC6Emwkgu6P7hGLlm09+01w=;
 b=NS2s/b4cvTCQNtz1H3WNuh9YYrNdtX1CnDh1mmPzqelbb3OLt1qFQ6nsACyrXkilNN
 zVn+NnqUSrmuLOCNPmQYpQf80wt0PT8lqLaoKWN3cXvjNmMXIgTzuNERk5VKrxWigdH9
 5XlBDCbL2w2L0/yYagsRvX6usoPALQYXfDFGEfFp8zX1fyCN+j+pp/7hCvfsJesayRDh
 ogl2Ns5vgtJoDSvUAtu7lgzfeXZ+0NnLOcegOvAi2umGsuYCFF+i4nWlnlVP9XHitujw
 o084LfWus5BqN7OaBqM7J8kuEFQUKVcr7rSKbzwRag3bRCjm2vytCWQSsWLL98m4p7yI
 I4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866847; x=1794471647;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQpZo/Sw+/Z0us8Tb25lhC6Emwkgu6P7hGLlm09+01w=;
 b=j0ivQ5/SYXioFPmccs8epdidfKkuF79KtrDY3Iv0ikskxmMs3EEvEjbIXut0y+ZiHc
 2YqfFIWvNxcFWYTXGZiJS761nkEVu1jdyryPHSHBSTCS4FvY42Oz2TECyDFwCT9tBQCz
 xkl+WzVoJq+AKz6hi6nuZcSxDjgejFu+KXn8ydC7yPQ1YWXYaQbVsPEi5/DwfUjQhnRN
 0DQFgvjpSJjUVCxXT7nBI75lPs09JqB00LavtN3x7G38fRwd88ZFdkTvPD+Pio/gNVPI
 CvsaHT0/o6uHYCnzcWfSZ8uon5j66O+abXVHE+Ehy2uUQRnvlWLb5wuPu9dly+L6qYeA
 Ul2A==
X-Forwarded-Encrypted: i=1;
 AKwUvByVJwsh62e9BQwMtHI12PsxpDiFaVU7iea3tq6kVoEDXcgqfl8orIfQnytxC4qevkH5Q9lwCCMLZ04J@nongnu.org
X-Gm-Message-State: APuU4Z8SGclQLVhCHrCQbPDjEqz7K3KcfIe4NWshmmDqARNYcp1rxVfx
 0lr5yTnzJG1jGF/1ud+jUyQBjoCUwKD0aVrkDfvDDKudYV3ypXXFB2jssSAJh0Q8hMUbItbVaG1
 DdlTi+sxHsKAPwKYjLXOyR+My2KanNGPkfwvPx4l4XOlYLpdTnxjDykXrDQ==
X-Gm-Gg: AYBFou2J0Blt7UDVic8ygIOgdeXNOUrpGkxcB/8mIb/shWtwLXqj5g/n/lFP+EtzsH1
 xQmkvct7+5VbGz3PMuQnluH6OM+f61hYOrzaf++5Wb7pPQrXsfIYffiCq01puNaXojjh10kndLv
 qanpV8SVBd0F0oe62Z5G8NjCP9uNigGG835e778n12YINmyORGDcchxBnb8Ed4aKEa/5+wP3JC+
 K76SadoledUGr5uXKhyh+r0oAZNYFYPwKQL9NktfNYdVFN2JXHwZqCPMrvH0s30qI4XmDDwGV3X
 xouj8XJ28g74VdwctS86iC8UzvnVtogAsbtKbqmezhUJ0914ntoyW6z9RFHL3FH5TN8ey1kfvB4
 lfNvHJ2WL+J958n3QsApxgRv/E0PisVG4uMoHLVJLD6oDj/sJ5IDFVzgIShGJxHZr1DSAOYoLZS
 9M9Gazvg==
X-Received: by 2002:a05:620a:29c3:b0:93e:5016:e3a6 with SMTP id
 af79cd13be357-94421617463mr3237187085a.26.1793866847028; 
 Thu, 05 Nov 2026 00:20:47 -0800 (PST)
X-Received: by 2002:a05:620a:29c3:b0:93e:5016:e3a6 with SMTP id
 af79cd13be357-94421617463mr3237183585a.26.1793866846449; 
 Thu, 05 Nov 2026 00:20:46 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f02386bsm44121795e9.7.2026.11.05.00.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:20:45 -0800 (PST)
Message-ID: <cd20258b-160d-4913-a67b-ed2b4d351ff8@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:20:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
 <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX3BElDBl78pIn
 F9KOOSLU9r/zseQc33/H5u9IPcb9DUWyxp4jHnVXd0NtghziqdnysCWHdDdtKueb2nkxZXeEr8n
 aQwF0ivjy2m8odc9zBaOcs2jL5jGqluZZszNPDm8W/CpLDUITYf2lpnFeIBkcm/Q1D5v1n2brJj
 BtvDTz9lt/1h+1Z/M7bxp21g7UCN2lQ3FLDEAqdWcdxUQJghQyQNAgDhYI8hv3mQncUmV/YKv4/
 0CU1f7lSEyLW5ETedi22jfqqohIUHj8WXKyDPmEUziV78w1NafeXFVOP6MtQ+jP/geiHERIiVgI
 w1NtIOyjg9X4GrGJvQ85Z0AxWTi7EKRenvr7GPueOempVaQgyivZ6BI9afVDPlVb25SKv1KdJwv
 YQy8TVpXqIfH9h5iP2yZxsiOpqWfngyHW/pJskyq4mpSGuhDOflWFR7ZZw30JWLNR8zQMz9RsB4
 uU3JsnKQk9I7EjuFmQw==
X-Proofpoint-GUID: UUoK_XAEzQ2ZfERcKFcotQCekSsE4L4p
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aec3c5f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=DmfTwSA7pyjtfIhDM7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX+ixh3xnffn96
 HGfIq5goA9wzZvsXgZ2JeKY+S6oTGSM+wfkqRb8BlDPcpamhQBqswPu7/QFjVLbBrxDXGFLnlxd
 1BduGf9+cQ2OOAXCoJ+y6pUEy288VZY=
X-Proofpoint-ORIG-GUID: UUoK_XAEzQ2ZfERcKFcotQCekSsE4L4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 5/11/26 09:11, Pierrick Bouvier wrote:
> On 11/4/2026 11:12 PM, Philippe Mathieu-Daudé wrote:
>> On 4/11/26 17:34, Jim MacArthur wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Rationale?
>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>>> ---
>>>    hw/ide/ich.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>> ++++++++--
>>>    1 file changed, 80 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
>>> index b00987f08d..58e2d3b998 100644
>>> --- a/hw/ide/ich.c
>>> +++ b/hw/ide/ich.c
>>> @@ -70,6 +70,7 @@
>>>    #include "hw/ide/pci.h"
>>>    #include "hw/ide/ahci-pci.h"
>>>    #include "ahci-internal.h"
>>> +#include "system/spdm-socket.h"
>>>      #define ICH9_MSI_CAP_OFFSET     0x80
>>>    #define ICH9_SATA_CAP_OFFSET    0xA8
>>> @@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
>>>        },
>>>    };
>>>    +static const Property ich_props[] = {
>>> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>>> +};
>>> +
>>>    static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int
>>> level)
>>>    {
>>>        PCIDevice *pci_dev = opaque;
>>> @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
>>>        d->ahci.irq = &d->irq;
>>>    }
>>>    +/* Sends an SPDM message and receives the response */
>>> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
>>> +{
>>> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
>>> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
>>> +    void *rsp = doe_cap->read_mbox;
>>> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
>>> +
>>> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
>>> +                             SPDM_TRANSPORT_TYPE_DOE,
>>> +                             req, req_len, rsp, rsp_len);
>>> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
>>> +
>>> +    return recvd != 0;
>>> +}
>>> +
>>> +/* SPDM protocols: plain and secured SPDM messages */
>>> +static DOEProtocol doe_spdm_prot[] = {
>>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
>>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA,
>>> pcie_doe_spdm_rsp },
>>> +    { }
>>> +};
>>> +
>>>    static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>>    {
>>>        AHCIPCIState *d;
>>>        int sata_cap_offset;
>>>        uint8_t *sata_cap;
>>> -    d = ICH9_AHCI(dev);
>>>        int ret;
>>> +    uint16_t cap_offset; /* Next offset for extended capabilities */
>>> +
>>> +    cap_offset = PCI_CONFIG_SPACE_SIZE;
>>> +    d = ICH9_AHCI(dev);
>>>          d->ahci.ports = 6;
>>>        ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
>>> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev,
>>> Error **errp)
>>>        pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
>>>                         &d->ahci.mem);
>>>    +    /* Legacy capability for ICH9_SATA_CAP */
>>>        sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
>>>                                              ICH9_SATA_CAP_OFFSET,
>>> SATA_CAP_SIZE,
>>>                                              errp);
>>> @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice *dev,
>>> Error **errp)
>>>        /* Any error other than -ENOTSUP(board's MSI support is broken)
>>>         * is a programming error.  Fall back to INTx silently on -
>>> ENOTSUP */
>>>        assert(!ret || ret == -ENOTSUP);
>>> +
>>> +    /*
>>> +     * Initialise a capability in the legacy space after the
>>> ICH9_SATA_CAP.
>>> +     */
>>> +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET + SATA_CAP_SIZE);
>>> +
>>> +    if (dev->spdm_port) {
>>> +        /* Set up the DOE extended capability, mailboxes etc */
>>> +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
>>> +                      doe_spdm_prot, true, 0);
>>> +        cap_offset += PCI_DOE_SIZEOF;
>>> +
>>> +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
>>> +                                                            errp);
>>> +        assert(dev->doe_spdm.spdm_socket > 0);
>>> +    }
>>> +
>>> +    /* IDE extended capability */
>>> +    pcie_ide_init(dev, cap_offset);
>>> +    cap_offset += PCI_IDE_SIZEOF;
>>> +
>>> +    /* TEE capability bit in legacy space*/
>>> +    pcie_cap_tee_init(dev);
>>
>> Which section of the ICH9 spec describes that? AFAICT ICH9 predates
>> DOE / IDE. Is there some amendment? Otherwise this might not be the
>> correct place to add that capability. Either use a Frankenstein ICH9
>> with a distinct model name, or add at the SATA layer, possibly like
>> a class interface (we only need the SATA_CAP_OFFSET IIUC).
>>
> 
> It's an ad hoc addition, reproducing what Arm has been doing on fvp for
> device assignment. It does not really model a real device, and nvme was
> (is?) not supported due to other limitations.
> 
> IIRC, we found that in the tf-rmm branch supporting device assignment.
> 
> While it does not hurt, that's why I never sent patches before because
> that's indeed a custom thing, that works for a custom software stack
> that was (is?) not yet finalized.
> 
> That said, it should not hurt to add it, since it's just an extra
> capability.

Well I'm maintaining MIPS board that use the ICH9 and am not keen
on having the model diverge from the spec; we already suffered from
that in the past with PIIX. That said I'm not against contributing
and committing experiments as long as they don't clutter / hinder
our existing specified models.

> @Jim: Feel free to complete my answer with links to the code and a spec,
> if there is one to share now. I'm sure Mathieu Poirier has all this info
> also.
> 
>> Michael, Tao, what are your view on this?
>>
> 
> Regards,
> Pierrick
> 


