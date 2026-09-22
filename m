Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F65C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98al-0000vL-SE; Tue, 22 Sep 2026 18:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x98aV-0000u3-00; Tue, 22 Sep 2026 18:03:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x98aS-0001eb-KH; Tue, 22 Sep 2026 18:03:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7GqF1129632; Tue, 22 Sep 2026 22:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XSnt5b
 gCEL69B+SbkVHxMW1SF2XxkjHBPwLW1wxGVFo=; b=dvsUO7lRW1Yvf7DXXp/Akj
 zSUx1TaEPkbJDDCI430lgJHHXh8mjHKy+Y8F5iM425vQP+J/PpSnzRG8hXzAmn6b
 Ccpf8+9mF/TSIukDiO29usnmc3Q9OHJY3o7g8OJ2n+AqKVUKQH5uAaObMo2VrT1n
 IqY9L7rSI7m7VeNrMUYx1F4VJGu7V0rlqWpaxo6XfzFJUyo/fBzPwEP3OXETb9OA
 5Xr67fxrBvwspSw92DRsItrbuR250GRPf/nXBn8OTbHNsjewRwJXZcnCVx9S7LQk
 ND7gzGVYjnqDENovUe96R6qYhpUHKuiG23+GiaRDW5t90pphDNbP4CDpuZ19E8NA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2g6hp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 22:03:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHbar3220323; Tue, 22 Sep 2026 22:03:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vks25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 22:03:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MM3ZWS17105526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 22:03:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4435058043;
 Tue, 22 Sep 2026 22:03:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C9C158055;
 Tue, 22 Sep 2026 22:03:34 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 22:03:34 +0000 (GMT)
Message-ID: <577d38ad-94a0-45fe-87f1-cb010f8cd279@linux.ibm.com>
Date: Tue, 22 Sep 2026 18:03:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] hw/virtio: Add "loadparm" property to virtio net
 PCI devices booting on s390x
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-6-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260914193438.526407-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IRTYMF9ugIyApBnVZ_SDtdaurqQFu18q
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2fb39 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=qN506RqINZ981zxnCPAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5OSBTYWx0ZWRfX3bnRuRf2SVKX
 tP20FR9/QyO5PR2WTy3EcZIo2h31nHU++VsPYvT/NQA4IaVUqO7DRnz/D5He7Ve/IKNsiX5qPa3
 0p2nRxsZLUI5a1CsqZl63YMbcUtmpAhBMKYoj1ZA4z/XuubyPsfC4ErTVWqlegI12bTezAiQ7Hy
 ZsEOEt2lylbnwgj/r/fOPmmX54snf84LAf824v8H57kIKtBsaoZ8HHOOd4zcOBoKyKcv0JUaESy
 IAHzP1PIRi7RGoRAX7VaJGLZCqw+Ce29BpnexJUEmyDfiCcUBub5LbSrauTy0Vly0aQz5e7NubF
 MgxQIqp9awoox7QnfTqlaIWV8hAWVwmQdqKkzkSks/cF9AB3D6KSbtb7vj1Lc4BYmtVGiaEElJF
 UnlxMMMdqBRmnb4WifGgHWYaT4dXLFvefYL3qdx+VEwSrnR/wyqzlMCl4z7+0au7vd6VIC5zn+Z
 xPIAD608zU6osubyvdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5OSBTYWx0ZWRfX/Nvp25ERVREp
 pCngg1muC418U8oo7bmdg4pylQW0qRWlvoM663LHwIB6ILvoQj69mpmM8+G0iza7y0Aiyjv+hCK
 61i8JZ98akkxjwS9lAACCuH9AAfT4eg=
X-Proofpoint-GUID: IRTYMF9ugIyApBnVZ_SDtdaurqQFu18q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220299
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/14/26 3:34 PM, Zhuoying Cai wrote:
> Add optional loadparm property to virtio-net-pci to allow boot entry
> selection on s390x, consistent with virtio-blk-pci.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  hw/virtio/virtio-net-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
> index fd3e0303f5..893d1905a9 100644
> --- a/hw/virtio/virtio-net-pci.c
> +++ b/hw/virtio/virtio-net-pci.c
> @@ -77,6 +77,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
>      k->sriov_vf_user_creatable = true;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>      device_class_set_props(dc, virtio_net_properties);
> +    pci_qdev_property_add_specifics(dc);
>      vpciklass->realize = virtio_net_pci_realize;
>  }
>  


