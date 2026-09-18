Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45EAC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7R5u-0000Va-LV; Fri, 18 Sep 2026 01:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7R5m-0000Pr-TD; Fri, 18 Sep 2026 01:24:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7R5h-0002EL-Qh; Fri, 18 Sep 2026 01:24:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2WNG22366279; Fri, 18 Sep 2026 05:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hCBf42
 nrUYHh91jHHxb9bZBGSpLxNWDLvvia1MdM0pA=; b=QXzemwul/j0St0QAgavCs3
 PJfH/wza5p3LYBJkUBR3t4gGkBg885Tkuvqz2zPa7WCRJZ/hJPDkNbUCimWgCIFo
 CD0BRoeeAv7zcJRBpPRBBEbed6ium9yEhf7U2qBDM72C//FLy8yOU452hlZkAF4C
 ym/nhOwAV6OuWd5KalOpvYio9JYrfoOPJf6xzW7kHsG5sShKmciClc54Bjzxt9+t
 OU9L0crr0bDZQidzcaVTcRbOfIoRUQfGsK5N2hhavmIVnZKTYKNVem2bVfdOluC5
 ubIKemjGfLArpKybvG/d2JbSakGKrMePk1KO5fn9dMxSSAYl9K4lctJ4e7/2xB0Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqpbs2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:24:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2ZBGu015834; Fri, 18 Sep 2026 05:24:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yvyc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:24:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68I5OfN548497142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 05:24:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A9DC20043;
 Fri, 18 Sep 2026 05:24:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C765620040;
 Fri, 18 Sep 2026 05:24:38 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Sep 2026 05:24:38 +0000 (GMT)
Message-ID: <a389ef6f-54bd-4f73-9043-05ce62ae9739@linux.ibm.com>
Date: Fri, 18 Sep 2026 10:54:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/8] spapr_vscsi: add VOF disk nodes to the device tree
To: uverma@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, avnish@linux.ibm.com
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-7-uverma@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260817102733.605346-7-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX5UpdighxSrpx
 3xgOtiO9HeQQvlr8xJQrULVjW9Q6BMjnIpfbEifx+naFmf8zATpASTpkSerAH3p7CBY2Og2dtiR
 nS0YJLqCL1K/JR3VW1+Os6dJlke0jFpWbWEbKJ5YnoMGq4FCVQn8r+vZ3GAwYXoKy9aXbSo5sPR
 Pn+y9uGjG6uMhB2Izf+X/lHeB/PL/ovOJ15Uih0eKilakQAGx0iGW/MYRkN5gIG7/xWTw1elTXx
 b8m6r+MRMhKfqxh7aDbNeJiHNSTtIl69Qq8ERM2LO9/W2GH+E8BEk8tw1ZDeX1uNicJfg/sikG5
 VZqUO2Fn72cFw+n/VRH91PX89l4KZZi9HQ+61pLFEpuFEMovx3cf/+Y27rq+MTM+9msvbGo8URP
 /uNFiSaDF+HYj9tutBL5RcPaHC60vP3N+jfU4PevS8dhAuap1KMe8kEy9p2vbnsKMvWeKNWvCXQ
 tGVmCyyzV9bGq8uH8tw==
X-Proofpoint-GUID: 343OXfm8npCJ0zhpwh6ovykS_jRSEFrv
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaccb1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=egB_odwYocRQA0WEMpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LJgrIjxSDDwOR4SQWk47KMlnKipibVBy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX43Jjd9uS75we
 YbS+ib1sOIIV5v1RlvsbjJUqnceLLSXiNVOI3psynd9Nn9T/LGlehD+UxCeb0YE3qUjj49V8GWU
 YhZ8Gltrojg/nQ/MAv1LnVYXrQjXBaQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Utkarsh,

On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> Populate the vSCSI device tree node with child disk nodes for VOF
> guests.
> 
> This lets Open Firmware clients such as GRUB open fully-qualified
> paths like /vdevice/v-scsi@.../disk@<srp-lun> for attached vSCSI
> disks.
> 
> Each child node is named from the encoded SRP LUN and includes a reg
> property with the 64-bit LUN value, along with device_type set to
> "block".
> 
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>   hw/scsi/spapr_vscsi.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index b4c8f94d22..03f5f27f5f 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -1243,6 +1243,8 @@ void spapr_vscsi_create(SpaprVioBus *bus)
>   
>   static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
>   {
> +    VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(dev);
> +    BusChild *kid;
>       int ret;
>   
>       ret = fdt_setprop_cell(fdt, node_off, "#address-cells", 2);
> @@ -1255,6 +1257,44 @@ static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
>           return ret;
>       }
>   
> +    /*
> +     * In VOF mode, add a child FDT node for each attached SCSI disk so that OF
> +     * clients (e.g. GRUB via VOF) can open a fully-qualified path like
> +     * /vdevice/v-scsi@.../disk@<srp-lun>.
> +     */
> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    if (spapr->vof) {
> +        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
> +            SCSIDevice *sdev = SCSI_DEVICE(kid->child);
> +            char disk_name[32];
> +            uint64_t srp_lun;
> +            uint32_t reg[2];
> +            int disk_off;
> +
> +            srp_lun = ((uint64_t)(0x8000 | (sdev->id << 8) |
> +                                   (sdev->channel << 5) | sdev->lun)) << 48;
This matches the decoder introduced in patch 5 for the corresponding bit 
ranges, but patch 8 constructs SRP LUNs using a different expression.

Avoid hard coded values, define or use existing relative MACRO definitions.

> +
> +            snprintf(disk_name, sizeof(disk_name), "disk@%"PRIx64, srp_lun);
> +
> +            disk_off = fdt_add_subnode(fdt, node_off, disk_name);
> +            if (disk_off < 0) {
> +                return disk_off;
> +            }
> +
> +            reg[0] = cpu_to_be32((uint32_t)(srp_lun >> 32));
> +            reg[1] = cpu_to_be32((uint32_t)(srp_lun & 0xFFFFFFFF));
> +            ret = fdt_setprop(fdt, disk_off, "reg", reg, sizeof(reg));
> +            if (ret < 0) {
> +                return ret;
> +            }
> +
> +            ret = fdt_setprop_string(fdt, disk_off, "device_type", "block");
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +    }
> +
>       return 0;
>   }
Could we please introduce a single helper for SRP-LUN encoding and 
decoding and use it in patches 5, 6 and 8?

Something along the lines of:

spapr_vscsi_encode_srp_lun(channel, id, lun)
spapr_vscsi_decode_srp_lun(srplun, ...)

That would also make it straightforward to add tests for:

id      = 0, 1, 31, 32, 63
channel = 0 .. 7
lun     = 0, 1, 31

At the moment the common channel=0/id=0 case can hide inconsistencies 
between the three implementations.


Thanks,
Narayana Murty N.
>   


