Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C4FCD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkSG-0002k5-Eq; Wed, 17 Jun 2026 03:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkSD-0002it-Vt; Wed, 17 Jun 2026 03:12:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkSC-0005rz-Az; Wed, 17 Jun 2026 03:12:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnJ0l2726354; Wed, 17 Jun 2026 07:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=omLII5
 wDelXDnzUF2r5+y7QGfpFO7dvJz99xhEnk4TA=; b=s4Qf9t21wt91/kcVHQfcnD
 ag/rT6kUoGjpj3UwyBPhCDpGgi0NjosybCuLyHQ9YA+1leFbwB4YAyTqOsLwx1/o
 vbTqBfVfPmIGtOC4DZ2223Q5mnGCQlhs69/RDG0V2uZJ0VvzboTansInLZ6P3pnZ
 ixqY6tCkRYvhXXCE0F2VVI1RxIIyHU8oGK8KuSsoshpRtG9mhhJgRMyebXxjP4tO
 11GRCuF3dgdOeDA2vDSh+W3atqMYILE5x4V1LxgujynAiaCTwrd0IYhRRXmJhEeR
 4gf0xwhwSiGZ9UcDR65sWtXlJIXO6XBN64vad1UqPHk9odRFOiJzNKEl363PEmzQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvspev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:12:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H74dYf014970;
 Wed, 17 Jun 2026 07:12:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaj02n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:12:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H7Cens17826340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 07:12:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 710725805A;
 Wed, 17 Jun 2026 07:12:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91E0F58063;
 Wed, 17 Jun 2026 07:12:35 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 07:12:35 +0000 (GMT)
Message-ID: <9e26e834-63d4-4498-90e9-e4c498926537@linux.ibm.com>
Date: Wed, 17 Jun 2026 12:42:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] pnv/phb4: Implement IODA PCT table
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-9-saif.abrar@linux.vnet.ibm.com>
 <af9MlXbuexdd9FQQ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9MlXbuexdd9FQQ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX05OdNlzSTtI0
 aSQJ1xOCQtMvS51j4mT4Ke5T/cLQlrgx2z36CXuOBoIt8yDQIXiziDRUoS7s1PjzXN9k3eC8lRI
 KChrnvX8MAMCqLCGuoV9HNwOQl2T4Gk=
X-Proofpoint-GUID: sBRtsTlRGV2ImkUSiQ_T8FmG2yPb0T4n
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a3248eb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=bXWNTka-gqkNdIOlxVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: phPM_ejIkPIBVsitwcmazdDOvF6Ox2XR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfXxidUXumOdKcD
 LE2jlvoFSG7JgwE5Tt8ilELpsnqDrVQAZTIcM4O03T4i/GRqqtnDjCIwTRHrqGiJBKS6ucssFx9
 n05em0laH97XCfTL5SUFzMt7Kxo/VZq+fo6msJlNUD3OLXsAc19l48AkK8kFEMDGvkir785Db0v
 Hf9i+9GxtCfjs8lM+LBHzcQHn+vWsTK2Qa5sQQDjkHmdfPzI0rkETkFWl3/cwiJTODw0pCfFgdu
 ddawKEcn8FN0BOi5PRpJxfWF+Tx8UIZVqXx6oVrtvCAjEFLIYmeLIm8+YLYC2kPlRX/q3LMDk7m
 wM0DpmJ0ULxGKfNCg7rWHT+1V86mYWUQF1vbaIyd+jXaWe1vkaY1JtGfMvfAnZSEtbzkgrpiM30
 2sUfPvyN66qQx/5vdeNnYLHhte2nR1bduXguC4L8t+UQ61ThIkpUFvQ4c4abU0nGeIzNvzUHFId
 TmIU6E2iswwQlpnhugA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 09-05-2026 20:33, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> IODA PCT table (#3) is implemented
> nit: '#3' is probably from github, can remove


Removed.


>
>> without any functionality, being a debug table.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> rest of the patch looks good to me.
>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>
> - Aditya G

Thanks,

Saif



