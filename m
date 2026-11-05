Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD57606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mpY+1t/z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dSJzn7y1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOreV-0006dD-1Z; Thu, 05 Nov 2026 02:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOreR-0006bh-Dz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:12:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOreP-00035g-CY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:12:47 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56TpEg4138156
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 07:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oac5hzHBnE7Cl4l22353AWuFU4IwjLcJQv2+QYxS43Q=; b=mpY+1t/zqC2U6LNu
 ECTKQJlIVuCOgi+6jv/PdZ7INhR5x7/gAnsyUHBT1g8Uz7DGMgx4txcaLmAQzI2x
 sbXsQO3a85VsflkUAzq28Beors0xI+lbozcYjvmuLXd+ULAANIFaNSHbNIIaBrwK
 je0fbUMgqLRCBRMvgzl9ibkcMwk97Ou1RJzHCdLI3vKWJ0DbQQJIHn/zfd7FI4dr
 U1xKqhc5ZsElRYHBLdETgyjHsqLgOJsBWxxm0IEqLocW9/1g0M0lwjiJgBv8rqj5
 Y1wCLEaipFXd3CiVPM2VJR3ZF14JktDF1DllA56kv0vay2vygTLIf2TDADvkgKgd
 3JbtWg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v07gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:12:41 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc36b97a77so431888137.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793862761; x=1794467561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oac5hzHBnE7Cl4l22353AWuFU4IwjLcJQv2+QYxS43Q=;
 b=dSJzn7y1QpZkzuRriJuvQyrP2Z7tvWKRWvFvzAm65Rpl3RtkUXAgDo8L4oTjHNVBfj
 ldSyd9UxY6AGqy9cBnJdmuikwfRLxSlA8igtDT/r3ytwqivx+wLYckwiSIsQx31ktXFo
 6oEnwFVALGfAww0aw4/xEumxdjVBsloPYfejjcEt1zxOBWWNL0B6vp/kKshHtdHMNMHw
 MHbbOfLAD2yBi9Q7wCow1JGS1bLgM6YjN+sBO0l/PhEFOedz2F7bQQqFRCq8wT/CqUqL
 +CrMAL1PnlQRGcdAArfMd9hGiZU70Vj920IRfuaQQR141JPxRO2hdxdT9S14dWye0yA+
 oGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793862761; x=1794467561;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oac5hzHBnE7Cl4l22353AWuFU4IwjLcJQv2+QYxS43Q=;
 b=oHWPalHlNLq0Lg3ZKyy3RhXbEW2czsUE6MICoafOyfiUPDRGFxU3vvgw1Kv7yIs2u9
 QFzaKMqttwcfxJteLIPZtzp9Q8mNI6mRqWWC0waFgRiC79LuIvJAp8eNn8mpRnGl1/h/
 eaQ4L2q0sUfa3GSWbYhO8v0/D5mOwvWA2CXn4PginncjIc8jO23X6TfbIws4NyfAdAck
 f1f7qvTHtbvyKnIHJz9oXtKZ9BSMU+Wzn7G7wtaj88IsNHs7c+DpNnoZ2BjrTWTWWHvH
 9cjSZusawvmKdfTPgPagzTcikusi+5TfEM3ux649wAk6deRZ31HR7zXncpCjPzUvQsUo
 iL0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNlSu7Euo5wQrox6H6ASzEkJRLc4yygyqpKY/pbB49Cvo+H7+fl4/iqxCe6hWlbJNWPkaVO2K7x73W@nongnu.org
X-Gm-Message-State: APuU4Z/qiZlqTN3/RLjcFXRm0XocIKLCTn/O342L9BOl8Ud9s7tBA2RD
 UuiZIlV7g9jI7V59+sI7Wpi6R641LekaZZBOgdQJKz0sndBuks6O++j25tg9ml2MJHbPU6lR6D9
 e/uNs7+LiRuOyh0cMW5TIZ0p029qQXwOjJWZeb0P2W/cSN0mB89/3wnfUfw==
X-Gm-Gg: AYBFou3KpjowXYE39ztFVzzKjgZIts65ZZBGub7wc4wRsT8xyZR6MkF6ehsXhMu6xPZ
 c3Qw8qiH3EN19XBucNxcr5HEqKIVTiIiEjCXX9/vYmV20hMlq6eDb0CuFGjW18JfXpBA3bFO8Dp
 VyeNKRpCLElTICgsvYIkFUBtiwWn71B87d/T2EG1b4WV6bIf2zzpXI17LEqrhO4Ec2+h0MFAKe3
 oRzbZL/9GNXeek/uB7Gkb0MFzlIyQG7FfA4FLNDyJY/uCtqP136BwI4V8wkgaxaZALK7oXUg/IH
 16rZcBCWS+FP2HUnthb771PQoDNo5pgxxv1tgK+ApLO2olEkVtiilPC9WWjGtzgP1m9R9MMbB/z
 88hCGAIKmDNvJ88lFL34SQizj8qvH7F9pO8DAZwC4+vJfK4xUrEiJ48uMk2xJZpsVvtBFjgMcg+
 tX+LGqbQ==
X-Received: by 2002:a05:6102:5811:b0:7c3:9a36:bbda with SMTP id
 ada2fe7eead31-7d0727ad784mr8254448137.5.1793862760811; 
 Wed, 04 Nov 2026 23:12:40 -0800 (PST)
X-Received: by 2002:a05:6102:5811:b0:7c3:9a36:bbda with SMTP id
 ada2fe7eead31-7d0727ad784mr8254435137.5.1793862760288; 
 Wed, 04 Nov 2026 23:12:40 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed551dc5sm8412514f8f.34.2026.11.04.23.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 23:12:39 -0800 (PST)
Message-ID: <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 08:12:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyOCBTYWx0ZWRfX6/qioT+0EEUd
 wLdK9L+uBiTvwjO3+q1W07pDHbAGtKsvsI0MBX5BKcPEErZ5WhbEj+MyjlB4Rrd9H9MCY/c2ZEW
 N5LNgmUmFO2iP6z2X87vWyO9FcxWe/w=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec2c6a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=yjPruoQEW4Rz8LWmnvYA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyOCBTYWx0ZWRfX24e+UEBauagK
 LCyJadLzbes/3NJZ4Zk4GNYucs58o8DSRS0qMEKPocuVPAYiFyXRO5w9xYIzaLpqNIK1cgmzRqO
 e86hjmjwqIl5YN2jVBHT4OwWPKYuFCWvZcuZNR2xeNOw0cfOEkp5V5YPIxw28IvE6BoceAdnT6x
 5sa3XDgcZZpmBE0d8Ln9vMy7pdNonh7p7PVS6Vf3OGriWU3hxqEDsiRz4iX7ponJi/xotaQOM3c
 GLEbWR/+zyqmcZ6DGWjczd/+RoRQCr/Em+oCfdgGJyV8t20g5l2iSuJNW8wvvTjhWC4mNeghQON
 c1hdm4ywgwkuottpEry64/jl0DT08zaRWGmfOo+sPPEIxaajLAhrb0HlS+/zq2SL8y7OVfV1Lpn
 9wJlfszOeBG0Esqlw15/lVZPgCAuWYHblnjMo+BdQ6Wt9pwxQaX5wx4On+zNv9HHaVwEN+z4k7y
 3uf2avchg6EN5z9ix2w==
X-Proofpoint-GUID: YtjLbisTLtwtzQUDweQ6CTCf2IjJNSPq
X-Proofpoint-ORIG-GUID: YtjLbisTLtwtzQUDweQ6CTCf2IjJNSPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 4/11/26 17:34, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Rationale?

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   hw/ide/ich.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> index b00987f08d..58e2d3b998 100644
> --- a/hw/ide/ich.c
> +++ b/hw/ide/ich.c
> @@ -70,6 +70,7 @@
>   #include "hw/ide/pci.h"
>   #include "hw/ide/ahci-pci.h"
>   #include "ahci-internal.h"
> +#include "system/spdm-socket.h"
>   
>   #define ICH9_MSI_CAP_OFFSET     0x80
>   #define ICH9_SATA_CAP_OFFSET    0xA8
> @@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
>       },
>   };
>   
> +static const Property ich_props[] = {
> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> +};
> +
>   static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int level)
>   {
>       PCIDevice *pci_dev = opaque;
> @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
>       d->ahci.irq = &d->irq;
>   }
>   
> +/* Sends an SPDM message and receives the response */
> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> +{
> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
> +    void *rsp = doe_cap->read_mbox;
> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
> +
> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
> +                             SPDM_TRANSPORT_TYPE_DOE,
> +                             req, req_len, rsp, rsp_len);
> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
> +
> +    return recvd != 0;
> +}
> +
> +/* SPDM protocols: plain and secured SPDM messages */
> +static DOEProtocol doe_spdm_prot[] = {
> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
> +    { }
> +};
> +
>   static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>   {
>       AHCIPCIState *d;
>       int sata_cap_offset;
>       uint8_t *sata_cap;
> -    d = ICH9_AHCI(dev);
>       int ret;
> +    uint16_t cap_offset; /* Next offset for extended capabilities */
> +
> +    cap_offset = PCI_CONFIG_SPACE_SIZE;
> +    d = ICH9_AHCI(dev);
>   
>       d->ahci.ports = 6;
>       ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
>                        &d->ahci.mem);
>   
> +    /* Legacy capability for ICH9_SATA_CAP */
>       sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
>                                             ICH9_SATA_CAP_OFFSET, SATA_CAP_SIZE,
>                                             errp);
> @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>       /* Any error other than -ENOTSUP(board's MSI support is broken)
>        * is a programming error.  Fall back to INTx silently on -ENOTSUP */
>       assert(!ret || ret == -ENOTSUP);
> +
> +    /*
> +     * Initialise a capability in the legacy space after the ICH9_SATA_CAP.
> +     */
> +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET + SATA_CAP_SIZE);
> +
> +    if (dev->spdm_port) {
> +        /* Set up the DOE extended capability, mailboxes etc */
> +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
> +                      doe_spdm_prot, true, 0);
> +        cap_offset += PCI_DOE_SIZEOF;
> +
> +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
> +                                                            errp);
> +        assert(dev->doe_spdm.spdm_socket > 0);
> +    }
> +
> +    /* IDE extended capability */
> +    pcie_ide_init(dev, cap_offset);
> +    cap_offset += PCI_IDE_SIZEOF;
> +
> +    /* TEE capability bit in legacy space*/
> +    pcie_cap_tee_init(dev);

Which section of the ICH9 spec describes that? AFAICT ICH9 predates
DOE / IDE. Is there some amendment? Otherwise this might not be the
correct place to add that capability. Either use a Frankenstein ICH9
with a distinct model name, or add at the SATA layer, possibly like
a class interface (we only need the SATA_CAP_OFFSET IIUC).

Michael, Tao, what are your view on this?

>   }
>   
>   static void pci_ich9_uninit(PCIDevice *dev)
> @@ -176,18 +231,41 @@ static void pci_ich9_uninit(PCIDevice *dev)
>       ahci_uninit(&d->ahci);
>   }
>   
> +static uint32_t ich_read_config(PCIDevice *dev, uint32_t address, int len)
> +{
> +    uint32_t val;
> +    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
> +        if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
> +            return val;
> +        }
> +    }
> +    return pci_default_read_config(dev, address, len);
> +}
> +
> +static void ich_write_config(PCIDevice *dev, uint32_t address,
> +                                  uint32_t val, int len)
> +{
> +    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
> +        pcie_doe_write_config(&dev->doe_spdm, address, val, len);
> +    }
> +    pci_default_write_config(dev, address, val, len);
> +}
> +
>   static void ich_ahci_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
>       k->realize = pci_ich9_ahci_realize;
> +    k->config_write = ich_write_config;
> +    k->config_read = ich_read_config;
>       k->exit = pci_ich9_uninit;
>       k->vendor_id = PCI_VENDOR_ID_INTEL;
>       k->device_id = PCI_DEVICE_ID_INTEL_82801IR;
>       k->revision = 0x02;
>       k->class_id = PCI_CLASS_STORAGE_SATA;
>       dc->vmsd = &vmstate_ich9_ahci;
> +    device_class_set_props(dc, ich_props);
>       device_class_set_legacy_reset(dc, pci_ich9_reset);
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>   }
> @@ -199,7 +277,7 @@ static const TypeInfo ich_ahci_info = {
>       .instance_init = pci_ich9_ahci_init,
>       .class_init    = ich_ahci_class_init,
>       .interfaces = (const InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { INTERFACE_PCIE_DEVICE },
>           { },
>       },
>   };
> 


