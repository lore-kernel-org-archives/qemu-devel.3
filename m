Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E21AC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eMe-0007YO-W2; Mon, 21 Sep 2026 09:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x8eMV-0007Wl-IE; Mon, 21 Sep 2026 09:47:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x8eMT-00049M-MG; Mon, 21 Sep 2026 09:47:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LB5oJk1169640; Mon, 21 Sep 2026 13:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6tzvzp
 d3h6V9wxVGFfvFcNb9zA7QMf8KNUgI95AoZhU=; b=PF0SVC1nA13Mq9XBA3p0vX
 KZmk2YlkrxtYKxOmWCYaTeJypxwcdyao/Tz2oSnxRdT5WfxoxmOPyH3SLIX0wUKH
 XdSkOwIEmw+kaC2CkdtjWgoxFjszm0V6F9i8yUBI97FEg16bUO/dfXT9TuaKhYjk
 8tXqJ5OedXMV/yF91kyHZjg3URaFYD3woXf5/k3O4ITNYuFywS7kQefpypX6C+zD
 mECI3SyBMfz3bjZAVOi+Zh3so3N+KbL6htDc/5cGBt84dRntIdxFf/iU6VbBxEC1
 y9GM4FlTCSPWlsNOuqIxLKnlDsk74JjbGShKMcSbJNv2tuMDZ44VRmhvRERPZE0w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske18pu5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 13:47:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAlU121115361; Mon, 21 Sep 2026 13:47:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gnesv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 13:47:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LDl8VT32899724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 13:47:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C080058055;
 Mon, 21 Sep 2026 13:47:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D085958043;
 Mon, 21 Sep 2026 13:47:07 +0000 (GMT)
Received: from [9.61.148.101] (unknown [9.61.148.101])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Sep 2026 13:47:07 +0000 (GMT)
Message-ID: <078f5d97-2dde-49e5-af52-6053cd418b6d@linux.ibm.com>
Date: Mon, 21 Sep 2026 09:47:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260914193438.526407-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LgzwlMq3NDhLy0pMxWl4YEx4Uy81Lrb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE5NyBTYWx0ZWRfX338hRzlMjCFB
 RosQ+F3n7vVYEFx921v5D0/DGZDhDY/EkdNYbrbkvCs7xK3lYEXTvUld0X32yvw3yOxQ7GrqBiG
 IoqG70XuFPNosMSUTpof3GPovG2CINkj9NgZdqoLJeyXGoAh4+mIhtezmmyknMnZx3fT3Xgasto
 nx7Izp9OHJm6kSPrKcn9FSc1tuOpVJvHc7F0fDq4rYY4rlCwAeRefAZOiO950VFf7Se9oS0cThg
 3+lR8MT3Rx/T46Gsrwent1DvWTL0WbWnscukYe1rlOjHDL0/IcjLIOV9H7mmiM6nML6mk7qdvyG
 2FciQYv0WLIlxkl0fNVQ+h58Aaa2FCHp2/NWEO0pU9r2ZEfkpnvuJnU+EHdUxlmkkL/B1yrfQiz
 K5pT51xqAp1ol93zWRddoYxjVsYuhFcuUrocCDWusAvlqPCsB4XrwOMoHFbRB4WVtpANywmT7hT
 /zEZi0qY9kxnXPoyPNA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab1355e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=M_p5TQ9nyLvd2tX-92UA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE5NyBTYWx0ZWRfX/lppwLzN2ZhK
 98Ak2Q+mfLaWJXzDVs8KitYrMl0EgxnFpBhWiG/PtSqlHTi+SdzCGi2wSD43OQ0Zskq5Rxhs23W
 FdCEgOIkdiwOpsUbZlVZII8rNqQ+wZY=
X-Proofpoint-GUID: LgzwlMq3NDhLy0pMxWl4YEx4Uy81Lrb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210197
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> The virtio-net device used a fixed header size that did not account for
> the num_buffers field used in VirtIO 1.0.
>
> Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
> VirtIO 1.0. This ensures correct packet handling across different
> VirtIO configurations.
>
> The VirtioNetHdr and VirtioNetHdrMrgRxbuf structures replicate the
> same field layout as struct virtio_net_hdr and struct
> virtio_net_hdr_mrg_rxbuf defined in inux/uapi/linux/virtio_net.h.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---

With the correction to the file path that Christian pointed out,

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

