Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E6606A328
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GKDyNYwL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W14aV4V2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPEoQ-0002tP-JA; Fri, 06 Nov 2026 02:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPEoO-0002sr-Rf
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:56:36 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPEoM-0005BA-GY
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:56:36 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RSeQ3284394
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 07:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ADzjNa5cS2uvBbb0pIsUl12hAPQwwvozYzWH2H5FqOI=; b=GKDyNYwLONCWvlxE
 ItXyfhyjodoLI+XBavu57jAcEVvh7UarUHM0kLaXsmw1c/y2mDNoOBMnMxWtl/fL
 OCp3eFz+sY8sdzYsPfJ4CptjUccWPZVyFIfhcIwQXVE83slqwF24Mj6xb7SntXz3
 l+gXaGbOLkVce+ySN9k2jKNZvZiLjy5TrMUbdSi5BMQbxMvwuTOQAeDlZmOLWqNJ
 DXfFcZip9fp2ZI8bOpV+NmXhXM38djBU86lJQO8z2h6sgd1HdNu6Z5rKvQyFUAU8
 K0w/MsCW6qgc/z4yHU9lL0IoxgscVkxbsmPKPy0CrewZbr7Omzsqz8c1e8csE8JA
 CWvGMg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa1qgj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:56:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ed08be1c84so6756025ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 23:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793951790; x=1794556590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ADzjNa5cS2uvBbb0pIsUl12hAPQwwvozYzWH2H5FqOI=;
 b=W14aV4V2M7ouQSI9NOW5GGw327nOnlmrqVdVt5FpT+/s8HR/6F/3hcuCeckZ6xafe2
 IRlWS1ONEChvAuldffaWBJCAdVh6yE0b1O57QSu9EF991h0zZodd+eOdwz/o5XDNO3xD
 0rYTXbuQ9b0zdA57hfYJepXHOaWqqhLg+ZS0c9IOHgVK1H9ZsBYO8iRRuH+mGnffgvWS
 MW47S+iPkMK4zf/DI3nI3HmWItq1plYi31suQ+bbxvcF+4nN1bWE2c9EuSKddnYetnpP
 ueWRQROM+AU+vQLlzhFK1OK7+28fePaVVKSQNv6ZKy0mr7dHZPZuIsBpB7l7ka7J/YPY
 LMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793951790; x=1794556590;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ADzjNa5cS2uvBbb0pIsUl12hAPQwwvozYzWH2H5FqOI=;
 b=HeVtlmXeaAzd0u3YPIaGbcGUh4Z8FWKCsEeUPoBpHi6F+GIefpGh9bm1TXX9iMOcwT
 GuOz6ZBEbVtC7CwuwYlvzA99ZtMfUV3idy12JWLm0ARNxuTuX/k6U7+rr96N1f0ejhHV
 9Qp9kvg1dJIu7ZGmO6zZtYLC9LxeXe55b5ytfT1UnzTkYwVrtutrPLZJB0ffyU92uZ4u
 D3djHOH/nxTTvqqgy/buUbhoX65moeOrwjo47e/2UdplY7mSUSVypwdGZrJ04ROa6P4z
 GvVgyCLeetiwIWqsKzPkJ1jWnYf+SLfLTygKp9tb0BRiyUd7CFowwHVIdPkgNh6iiViS
 L5vA==
X-Forwarded-Encrypted: i=1;
 AL+hErGWlzddQHeAnjZfqrBMM05GdhR5Vq1ftsiM8a2hjcZkcPfULrTXMHpeNf55CcgVVuaLFyBYf+V0vsog@nongnu.org
X-Gm-Message-State: APuU4Z+o/5Zd6o5StamM0pmEl9U9LUIWlVplyNn1fXUYlPNEerKR/wWx
 PUrbovSUYiVRi1aiQxCBozPT/jAiZGJ1VoXXPIcDXzmsPiJx187yTlXD5vKTwClMi32XCZuHCVJ
 1F+OBH2UcUDpb7jRFoNX8P+C4L22PCKqWtqAO/6ykXyEbP4IUeZqrn5nTVQ==
X-Gm-Gg: AYBFou34Y5+95yIfABbi06l0MBfI5cI0BRL2FcsXbtUDujWZny6l5WV44ymYcGn9hA/
 sCmAM7OQC5LEmasJo91u96WwYohlHAVKJARGBH3s3Uu0WGCEctyicfsSmIQRLIBX6I+1avweHfu
 1ypUHsGIBVRWfE7EyWg47ADlmIv4S842L3+v4EWOMqlGNeVZbCToWVshotcqrAf6EJbf5Re/emi
 muB5oQ/yKf/9YZphC9QqnB/l+GlZCSXXdV50FfIDqBcSSBRlX3b8XuINbMcF4Hv6Q9LDVrp+YgV
 QPQRYaisBuEIFL11ihOxa4YxBjcVSh6zoRkV6JlN9mHHKplHyLyVqcjLhGAmAVorWdbze2AFkml
 tR36vHvWveFLHn7Br4Vf9GmjLcRZ7MN+v31uDk4I9Uyy0arDzHiw05q6/OXG47Wj1zGh5JfrnV1
 LEOSd+r5PCzNl3adkmMUXe2cgqJhw7
X-Received: by 2002:a17:90b:2f87:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3b0db6fe0f5mr1834092a91.55.1793951790365; 
 Thu, 05 Nov 2026 23:56:30 -0800 (PST)
X-Received: by 2002:a17:90b:2f87:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3b0db6fe0f5mr1834079a91.55.1793951789831; 
 Thu, 05 Nov 2026 23:56:29 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b323a1fdsm6718535a91.5.2026.11.05.23.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 23:56:29 -0800 (PST)
Message-ID: <41ef0bbb-1da2-427c-920f-ffe94d36d864@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 00:56:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "jim.macarthur@linaro.org" <jim.macarthur@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "mst@redhat.com" <mst@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "tangtao1634@phytium.com.cn" <tangtao1634@phytium.com.cn>,
 "den@openvz.org" <den@openvz.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
 <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
 <8b590f1f1d3e6ff6c650d25078fe1f1bc9dd5211.camel@wdc.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8b590f1f1d3e6ff6c650d25078fe1f1bc9dd5211.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CFOaoGyMuv6FesFhbM9gHROlOcGvfBqO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMSBTYWx0ZWRfX9J+BA0oURMKH
 ShGTRSgsQHn8Lsdcd7r2KkmVfgkx/BLquEo8BEFetqDGHmXoHm4iyvsymC9g2khlMY57yCGQ85z
 2SaCPkMt/nvztRpk7Gq3mUVsFY+Rpgg=
X-Authority-Analysis: v=2.4 cv=e7WT2qp/ c=1 sm=1 tr=0 ts=6aed882f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=b45o4kL6AAAA:8 a=KKAkSRfTAAAA:8
 a=lIfsO31yjNEGtRe96dwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=dhdsR-PFWuPJUldTnwXm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMSBTYWx0ZWRfX50QfMQXEiSFW
 v9rGE0yWHL5FbcGreTm9xy3fgu7nm1Er87/cUKUKYbUHuzLJcCmbX/utQ4WZYK8Zs9/sGgUM/xH
 i3N3HPKc809rVsLpkQ2d6FW9l0NmP+0/iIJCKXOWRXyk9JNtKpYfS68ddeV9Z8CLUEzh3JC9kEC
 cXc7Bv8Cu2ii0gP9Po+m9lPWsLyxNBwYUX9jiVyck+Il7IFTaO4IZWiHzs0SwZ6EKtp90qaL2ah
 M78u5qDh1JCMa8NAvLi9rch6+f+YQf59MYj9Pfraabp/JGQu7MlC0dYmx4izPPYAGh3rTqxQ7WM
 2z92LHhPlG2451jmsNevW46DMfFatezYjaS7s4ioXkZyzAh2SBmQXRJ2pnk/1Trt+PNVl4U1NrA
 tZgJQtTk7ydGCk48GeId3S8v+I0c/slMUjTgw2RFesPL8KNLvY2SjsJCiInZn+clGfmWr81zZ2c
 cbDZMHgM/FzehocN/Qg==
X-Proofpoint-ORIG-GUID: CFOaoGyMuv6FesFhbM9gHROlOcGvfBqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 10:39 PM, Alistair Francis wrote:
> On Thu, 2026-11-05 at 00:11 -0800, Pierrick Bouvier wrote:
>> On 11/4/2026 11:12 PM, Philippe Mathieu-Daudé wrote:
>>> On 4/11/26 17:34, Jim MacArthur wrote:
>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Rationale?
>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>>>> ---
>>>>    hw/ide/ich.c | 82
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>> ++++++++--
>>>>    1 file changed, 80 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
>>>> index b00987f08d..58e2d3b998 100644
>>>> --- a/hw/ide/ich.c
>>>> +++ b/hw/ide/ich.c
>>>> @@ -70,6 +70,7 @@
>>>>    #include "hw/ide/pci.h"
>>>>    #include "hw/ide/ahci-pci.h"
>>>>    #include "ahci-internal.h"
>>>> +#include "system/spdm-socket.h"
>>>>      #define ICH9_MSI_CAP_OFFSET     0x80
>>>>    #define ICH9_SATA_CAP_OFFSET    0xA8
>>>> @@ -90,6 +91,10 @@ static const VMStateDescription
>>>> vmstate_ich9_ahci = {
>>>>        },
>>>>    };
>>>>    +static const Property ich_props[] = {
>>>> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>>>> +};
>>>> +
>>>>    static void pci_ich9_ahci_update_irq(void *opaque, int irq_num,
>>>> int
>>>> level)
>>>>    {
>>>>        PCIDevice *pci_dev = opaque;
>>>> @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
>>>>        d->ahci.irq = &d->irq;
>>>>    }
>>>>    +/* Sends an SPDM message and receives the response */
>>>> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
>>>> +{
>>>> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
>>>> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
>>>> +    void *rsp = doe_cap->read_mbox;
>>>> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
>>>> +
>>>> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
>>>> +                             SPDM_TRANSPORT_TYPE_DOE,
>>>> +                             req, req_len, rsp, rsp_len);
>>>> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
>>>> +
>>>> +    return recvd != 0;
>>>> +}
>>>> +
>>>> +/* SPDM protocols: plain and secured SPDM messages */
>>>> +static DOEProtocol doe_spdm_prot[] = {
>>>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp
>>>> },
>>>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA,
>>>> pcie_doe_spdm_rsp },
>>>> +    { }
>>>> +};
>>>> +
>>>>    static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>>>    {
>>>>        AHCIPCIState *d;
>>>>        int sata_cap_offset;
>>>>        uint8_t *sata_cap;
>>>> -    d = ICH9_AHCI(dev);
>>>>        int ret;
>>>> +    uint16_t cap_offset; /* Next offset for extended
>>>> capabilities */
>>>> +
>>>> +    cap_offset = PCI_CONFIG_SPACE_SIZE;
>>>> +    d = ICH9_AHCI(dev);
>>>>          d->ahci.ports = 6;
>>>>        ahci_realize(&d->ahci, DEVICE(dev),
>>>> pci_get_address_space(dev));
>>>> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice
>>>> *dev,
>>>> Error **errp)
>>>>        pci_register_bar(dev, ICH9_MEM_BAR,
>>>> PCI_BASE_ADDRESS_SPACE_MEMORY,
>>>>                         &d->ahci.mem);
>>>>    +    /* Legacy capability for ICH9_SATA_CAP */
>>>>        sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
>>>>                                              ICH9_SATA_CAP_OFFSET,
>>>> SATA_CAP_SIZE,
>>>>                                              errp);
>>>> @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice
>>>> *dev,
>>>> Error **errp)
>>>>        /* Any error other than -ENOTSUP(board's MSI support is
>>>> broken)
>>>>         * is a programming error.  Fall back to INTx silently on -
>>>> ENOTSUP */
>>>>        assert(!ret || ret == -ENOTSUP);
>>>> +
>>>> +    /*
>>>> +     * Initialise a capability in the legacy space after the
>>>> ICH9_SATA_CAP.
>>>> +     */
>>>> +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET +
>>>> SATA_CAP_SIZE);
>>>> +
>>>> +    if (dev->spdm_port) {
>>>> +        /* Set up the DOE extended capability, mailboxes etc */
>>>> +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
>>>> +                      doe_spdm_prot, true, 0);
>>>> +        cap_offset += PCI_DOE_SIZEOF;
>>>> +
>>>> +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev-
>>>>> spdm_port,
>>>> +
>>>> errp);
>>>> +        assert(dev->doe_spdm.spdm_socket > 0);
>>>> +    }
>>>> +
>>>> +    /* IDE extended capability */
>>>> +    pcie_ide_init(dev, cap_offset);
>>>> +    cap_offset += PCI_IDE_SIZEOF;
>>>> +
>>>> +    /* TEE capability bit in legacy space*/
>>>> +    pcie_cap_tee_init(dev);
>>>
>>> Which section of the ICH9 spec describes that? AFAICT ICH9 predates
>>> DOE / IDE. Is there some amendment? Otherwise this might not be the
>>> correct place to add that capability. Either use a Frankenstein
>>> ICH9
>>> with a distinct model name, or add at the SATA layer, possibly like
>>> a class interface (we only need the SATA_CAP_OFFSET IIUC).
>>>
>>
>> It's an ad hoc addition, reproducing what Arm has been doing on fvp
>> for
> 
> Can you share any details on how you are testing this?
>

The last setup I used (february 2026) is:
- qemu: https://gitlab.com/p-b-o/qemu/-/tree/smmu-da-2026-02-24
- system: 
https://github.com/p-b-o/qemu-linux-stack/tree/rme_sbsa_device_assignment_v2

It follows all those instructions:
https://git.trustedfirmware.org/plugins/gitiles/TF-RMM/tf-rmm.git/+/b57eb11bb73ed4b0a573f6f44e7379a58fc1bc66/docs/getting_started/building-with-shrinkwrap.rst

Since it's a pain to reproduce and run all this, I automated it.
To build the system, you just need podman and qemu-user-binfmt 
installed, then it's fully reproducible.

$ git checkout rme_sbsa_device_assignment_v2
$ ./build.sh # take a coffee
$ ./run.sh qemu-system-aarch64

This creates a disk, pass it to the vm. vm boots a realm and assign the 
disk. We check disk content is the one expected from the realm, host, 
and outside. spdm-emu is used for TDISP.

see build.sh for which component are used.
see run.sh for disk creation + qemu cmd line + spdm-emu.
see host.sh for how the vm uses it.

qemu branch has additional patches (smmu related to support device 
assignment).

You can also do the same with arm fvp using:
$ ./fvp_build.sh
$ ./fvp_run.sh

>> device assignment. It does not really model a real device, and nvme
>> was
>> (is?) not supported due to other limitations.
> 
> What limitations? NVMe + DOE should work here
>

It's not a limitation from QEMU, but what Arm implementation was 
supporting at this time. IIRC, it was related to not supporting devices 
having BAR mixing msi-x table and PBA. I don't remember if it was a 
firmware or kvmtool issue.
It might be better supported now, I didn't follow this since, being busy 
with my new position at Qualcomm.

> Alistair
> 
>>
>> IIRC, we found that in the tf-rmm branch supporting device
>> assignment.
>>
>> While it does not hurt, that's why I never sent patches before
>> because
>> that's indeed a custom thing, that works for a custom software stack
>> that was (is?) not yet finalized.
>>
>> That said, it should not hurt to add it, since it's just an extra
>> capability.
>>
>> @Jim: Feel free to complete my answer with links to the code and a
>> spec,
>> if there is one to share now. I'm sure Mathieu Poirier has all this
>> info
>> also.
>>
>>> Michael, Tao, what are your view on this?
>>>
>>
>> Regards,
>> Pierrick


