Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461FC9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ubs-00022b-8U; Thu, 24 Sep 2026 21:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9ubp-00021o-R6; Thu, 24 Sep 2026 21:20:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9ubo-00036j-7O; Thu, 24 Sep 2026 21:20:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMZUrr2320929; Fri, 25 Sep 2026 01:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GlRznB
 C0e+LH3VLfNeXwfWFfRxr68IaBdQ8tkei/87g=; b=J97V9iyxk9hv5RqmXYfQVU
 Od2DyYCX/50yd07/StMdhJjl+eo4nsONgtQ/m+RYvsXL4Lw6WmNpiDbOBPFEo62T
 1nVk1VocBepWs/ex/JmFdxSqnrbRFFE0uIgP8t9Gm27w2w/YtqPn5KKcatDdZ1Do
 QTEDSTvrb7+PReFRaubCaMYzWjpzeyG2OdDDb3tZz/ZbzdcWFe3i/7znAxldHxUg
 5acax+NMJ+b8zP3LWLD8RV5NNQui5omcryp7lpWeX+U1VOaBfbOlEeun6euqcRW8
 +CLWrlRWNpPR7Y3RMOCLLLhbN6/9+nYoj3A0D6lxhyCSA+qInbH2Pef2Z+XW8QwQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqukn5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:20:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMWSZG2775101; Fri, 25 Sep 2026 01:20:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt30e1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:20:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P1KAe631392288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 01:20:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D610458055;
 Fri, 25 Sep 2026 01:20:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 741575803F;
 Fri, 25 Sep 2026 01:20:09 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 01:20:09 +0000 (GMT)
Message-ID: <3a2d6897-b130-4357-89e4-1054ad0c2741@linux.ibm.com>
Date: Thu, 24 Sep 2026 21:20:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924222949.147720-1-zycai@linux.ibm.com>
 <20260924222949.147720-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260924222949.147720-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab5cc4c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=IyosQ20mXozG4Y8xlR8A:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNCBTYWx0ZWRfXyM32Sls6tV9C
 /4/eLTQl/V8zojEM5JJBmUWG93Pri2t2lluqTAEcztyjm8E+3BrxXo+01BcEc7DCtsWC6uT4BTh
 vIaipRcdH7CcT8QVzMgrfV72QiA/TAxWOEdbrPyJUSxG6xV7cHmAHn47vhV+qejUOTR6jZcsQcL
 sDp3qpQu+PrLUSFZTFuLjpjgFOkaSqsjwoZeS/UVb5pWck2p3AueuMrgrjixlk9GzaSf7nedXvF
 5FlBwU8opQ4aFKrr8NTr8EbmHPMZqYNSfFmHpJqHcYdTnRMmwgezPs82VraDSTuEav8ZqlSHSil
 dEZkh4+zNqBuCRRUkHrkuVHavhecSlC4lr0TfBgmBoqxzMTE2cBjgHuBlfv7dnujyOux0yIEl0W
 xcPpNdBInLSIgNRK6zdWVpAqGT7i48UXVRP8mKSY6rHydEwSZt8qbmuN12GmxQOn2fbu4oW7VBr
 KBe9PfFJkhIj6P1i2wA==
X-Proofpoint-ORIG-GUID: q0HC_p_vZkI6ykR_7BVuc3Ky8I36TvU9
X-Proofpoint-GUID: q0HC_p_vZkI6ykR_7BVuc3Ky8I36TvU9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNCBTYWx0ZWRfX8vBq8b0Lrg2o
 8V2wlAEFb8C9sHQdz0sMnV7UBQTfX1bNqfd2OWlE2lbKTncdRbwjcLejjpDoshhD937WJQRJI1G
 TMSh8kKR3/l5RWOPflM6BBC2vs/rbHY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250004
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/24/26 6:29 PM, Zhuoying Cai wrote:
> The pxe test for a net device does not fail gracefully when the
> s390-ccw.img in use was built without support for booting that device.
> 
> Add a boot_dev_support check that searches for a known string in the
> bios image to confirm boot support. If absent, the test is skipped
> gracefully instead of failing.
> 
> Also re-enable pxe-test in qtests_s390x, which was accidentally
> removed by commit 973d97feca93.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


