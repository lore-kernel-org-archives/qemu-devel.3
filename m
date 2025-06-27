Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A57DC83013
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVAka-00044A-Ll; Fri, 27 Jun 2025 11:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uVAkS-00042Q-0W; Fri, 27 Jun 2025 11:12:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uVAkP-0005Yv-Al; Fri, 27 Jun 2025 11:12:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R7NbaX030899;
 Fri, 27 Jun 2025 15:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EUW99o
 LiqsKymA6/BXMsOx1MFXiIZYBoPNEpGOlzqjs=; b=qCbtLqwD+MJElWQ431RjAO
 3qHqVCLYcdmVsadYXr/sq/M1GBB1HlvX2LkBFSOMOLeTPNVxAA0Y0PKikyooq/k2
 gHHweB6EAZL4Bt9mb3AfUtI+TKHbOSi/RWa+wMgCnAnLekgGqFgZkAhPC496SrrL
 mV9RVDNHVtxRmpBAHNWgU6P5PmLuzZ6E7sQBidOQ5LxUbmdINY8t0UoNFbDRkfZi
 p2GStgFR9A+Qg7ditwEAx6GosSWF1Vu9UdvZ5PGJC8/GjP9u3VYRL5SJiOv37dVG
 0LzO5KlhiZfslokdQup132atk5A+PhfO01wEWHXvnsU31PEe8vmVsDZ0iO1Y1GFg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk64drsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 15:12:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCb3rQ006414;
 Fri, 27 Jun 2025 15:12:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pmquv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 15:12:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55RFC8QH24117606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 15:12:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA3CA58056;
 Fri, 27 Jun 2025 15:12:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 186ED5803F;
 Fri, 27 Jun 2025 15:12:07 +0000 (GMT)
Received: from [9.61.76.9] (unknown [9.61.76.9])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Jun 2025 15:12:06 +0000 (GMT)
Message-ID: <732ff972-ad09-4ce1-bbf2-0b39f436e8c5@linux.ibm.com>
Date: Fri, 27 Jun 2025 11:12:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v13 4/4] s390: implementing CHSC SEI for AP config
 change
To: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
 <20250609164418.17585-5-rreyes@linux.ibm.com>
 <5c6f7f80-cfa3-432f-9ff3-ae57f8b4cf5a@linux.ibm.com>
 <0f172637-0cd8-4b98-a095-9542c9a551fc@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <0f172637-0cd8-4b98-a095-9542c9a551fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfXxFoKoTqIxMHB
 575MdMofZMKQ4ZFDL28aOp/GtqSZbFveDqJiQ9bHXihi9n2VhAQUR3IuL0JuN8UG5/itEMgWdfO
 B1gNjAXPZaCEy+/QVBJWeAa72TYntOfJ9mRAxyTAy5Fx0nybirEmun43g4IGH4qO2gP28hq/A7d
 nsh4fC/CpOuYb6YJvmCiVkySSAhwrfIhCySNTlWs/i2BGivVjZ8ZVTBzPtIL5uam7/0ioFDgQ1N
 wREmkFVVD3Ml/8SKu3d0QNAqlNVZg1OuZToBhBs1nAq61PfCpRiVyWRUytB5sZDSAxDw1US3qNq
 w1Co2L87KvGLYfESIFB6RQhskXzSdcheh7fuPFlw2rSq9/yg/ol8pnlJ26AiZHXKmywIGGPqvCl
 oVBiW3UXLvtWJ6nDy7KwW3uvQEdpSScW6UXv+9mD0TZRxhgxdXOQk2R7YZQWl6EA6ea/BiuN
X-Proofpoint-ORIG-GUID: hC97JhOyiAd8wwMcumEUmnx7zvIVhzz7
X-Proofpoint-GUID: hC97JhOyiAd8wwMcumEUmnx7zvIVhzz7
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685eb4ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=k4c_didN9VAgbBhQ5cIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270120
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


>>
>> AFAICT this portion of the handler including mutex should be moved out of ap.c into chsc_sei_nt0_get_event().  When vfio_ap is not in use, we can't call into it.  Can't you also build without VFIO_AP?  I didn't try it but that sure seems like it would cause issues too.
> 
> If that were the case, I think the checks I mentioned above would be sufficient because
> the S390_FEAT_AP feature could not be set.
> 

OK, I tested it quick (remove VFIO_AP from config) and that appears to be the case; this also restores zPCI hotplug capability since we won't call info hw/vfio/ap.c/.

> 
> What about moving lock initialization to the vfio_ap_class_init() function?
> 

I tried a quick hack of that too and it appears to work, at least for the zPCI regression (note: I did not test the AP portion).

This approach is probably not the way I would have designed it initially...  But it does seem to be the simplest thing to do from a fix perspective.  

Can you or Rorie prepare a proper patch w/ a fixes tag and send (please add me to CC). Also please test the change against the vfio-ap environment; you can also test zPCI but I would also like to run some tests.

