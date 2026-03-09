Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117CDF3C268
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbA3-00053I-7y; Mon, 09 Mar 2026 10:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzb9f-00051D-Tt; Mon, 09 Mar 2026 10:00:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzb9d-0007ht-TH; Mon, 09 Mar 2026 10:00:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629BgQ0o313479; Mon, 9 Mar 2026 14:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tYhv/x
 caJHTy6i1ob7qg66WlmcAkMA/VBMfp7n8Gok8=; b=mznz3cgj1JaDpyrUo8gj+m
 5K/5OhwPfPUKwJwPgRCCxsd5EB7tOtkHRmatf5yrKRWNQGJOEOsXz0E5ZZAldT0E
 2ce8Q6PhQy7Etgs1Y3MdCSDEmGmIx4ouMihp0D1kMCC9KHLlaHIwzV9o3IbEfnpN
 y0lUYdro8sQF0xFAbiKyHObYqz1Rtq+p8WNE6OLRVRWHi1fBB3w+/WoeKYRVsHkq
 03+Oepe17eAgezRrcSo0pmJ16IFreyxi9gExnhXJ6b/eB5OhtcD2kQN8AkgH7vQi
 ZHlvyLp7BZraRg3s4ZZlKiEy43PNnK2Zb1i8u/eIJZHUBSb4wAzgzuX7mjVE5/iw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuy6t2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 14:00:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629DWZvY029360;
 Mon, 9 Mar 2026 14:00:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uht9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 14:00:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629E0D7930737096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 14:00:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C0CB58061;
 Mon,  9 Mar 2026 14:00:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC7B75805A;
 Mon,  9 Mar 2026 14:00:12 +0000 (GMT)
Received: from [9.61.138.24] (unknown [9.61.138.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 14:00:12 +0000 (GMT)
Message-ID: <4bef56aa-8b2c-43c7-9449-fea7c31d00b2@linux.ibm.com>
Date: Mon, 9 Mar 2026 10:00:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/15] s390x: Add support for virtio-blk-pci IPL device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69aed26f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=M_lMVc4j4dWZTQOC06kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEyMyBTYWx0ZWRfX1uqbxuMLyVkp
 iT2/mZmlILZRty1SKmyYuN2ZECpVxCpUOD70zl7QH+MEZ3CwLG0NheiiPqMl+mI3sD3UdJD/ldj
 ku3gbZdEyhBKoPQxrTOk5UsODU7Nq/I6lpGXfZeHuJLHMowfgcfRnTiGUQ/bvKqnVyKGv93AU6n
 5wFNOiVx9GWzblN7PjNpqvE9rvY3z4b13OBneXHufw/F27XN1Av4ZiWCkZAmsgfNs7swfPJ+hAR
 +m1mTEfZm5duhfXGbEAY867MW3SoDRa6mriXgjhr6WsVV63qGMEAjN4BXAH+Yd9R6xnFACRAXzs
 h0WxvYp9Yt6wL+yL8jMM3YZIXHn0FRZwwWKEJGCgjIjOa0HWIaVT8qKsWjAPCZsP5tt8pnDB0RK
 vI9032HYe5Jjp9RV4Oa42g2wcrCjIj+vRVeiC7+2Ca5F/xGyflEIDD7MpHjtl9znNuqYO/uACdd
 /Z6jxv3faFVof7wKE6g==
X-Proofpoint-GUID: Ka6GYBoR_zIPnh36iOsUjUNCgwsz7k22
X-Proofpoint-ORIG-GUID: Ka6GYBoR_zIPnh36iOsUjUNCgwsz7k22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090123
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/8/26 8:35 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> This patch series introduces an IPLB subtype to support PCI devices, which may
> be built if a device has been assigned a boot index and is identified as a PCI
> device with a corresponding s390 PCI Bus device.
> 
> Boot support is only added for virtio-blk-pci at this time and is limited to
> devices with an assigned bootindex.
> 
> A "loadparm" property is added to virtio-blk-pci boot devices on s390x.
> 
> A simple test to check basic functionality is added to the cdrom-tests in qtest.
> 
> Changes v4 -> v5:
>     - Fix incorrect switch/case for virtio block device ID
>     - Use target_s390x() instead of qemu_arch_available(QEMU_ARCH_S390X)
>     - Properly denote switch fallthrough
>     - Remove reduntant RC checks in PCI read/write
> 

Rather than reply to individual patches, I noticed new copyright lines with 2025 dates on the following patches that should be updated to 2026:

6: pc-bios/s390-ccw: Split virtio-ccw and generic virtio
8: pc-bios/s390-ccw: Introduce CLP Architecture
10: pc-bios/s390-ccw: Introduce PCI device
11: pc-bios/s390-ccw: Introduce virtio-pci functions

Thomas, if there are no further comments would you still like Jared to respin for that kind of change or would you just fix up when you pick up the series?

Thanks,
Matt	



