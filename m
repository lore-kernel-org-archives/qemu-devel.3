Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834ADCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjh3-0002zj-Ot; Wed, 17 Jun 2026 02:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjgy-0002ad-Qa; Wed, 17 Jun 2026 02:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjgx-0004BD-6F; Wed, 17 Jun 2026 02:24:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnbXD2726646; Wed, 17 Jun 2026 06:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DwLRdf
 a+0Q5lqkim6BdE3EQnj6iqA+5nKwrtwq4eSiM=; b=H0VHYvWphmSJ56Zx7Eu+dI
 ABTljAokKyfxLIqrRHCuP31aFHZCltQXrzvAmrBOTE04iMMmuJlMuGL9ZmNfxUGr
 8Maz/5H5rEx843sCjGG+NoWVyEhL5EAiTg69rJSAWXXqJ57xzZEKkgCzMBKgwsic
 KwMm2/bzn9adxn6zsBc/vDBayB7qfEUyKpIv2w9C80QMQddbmCS1q9tbBJobKa5r
 faAIVazq296LIPqh+XdLuHmNH5hKO+3Ce9rVsI3nK7f9YscZXLxWzcRjPZ+ehJT/
 hkSgNPJig33/x50OWdLTKlPHNH5mTSSS4ND/bl1Su0DTUJs3qYFk/guWweym8j6Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvsgxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:23:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JfYM031672;
 Wed, 17 Jun 2026 06:23:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvahtp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:23:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6No9T59900402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:23:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AA3358056;
 Wed, 17 Jun 2026 06:23:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9107F5803F;
 Wed, 17 Jun 2026 06:23:45 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:23:45 +0000 (GMT)
Message-ID: <210088ac-2a9a-44ad-8b32-1e6b589e9d5b@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:53:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] pnv/phb4: Implement read-only and write-only bits
 of registers
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-5-saif.abrar@linux.vnet.ibm.com>
 <a82978fb-98d6-4538-abac-db6c9212d396@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <a82978fb-98d6-4538-abac-db6c9212d396@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfXzXBf8evaOPQp
 VD36CwjqWBI1IrF+3ure9M+kAq4upLvDNURXOCfn5NyhfLT6wHYvA3l97ZbPIZBRHpCoAdNnAhc
 e0A2j46hk7h59cOQqIlpGoT2l7REe3Y=
X-Proofpoint-GUID: V1goaoM2SFnKrXgnwke8-H4KWzVIOZqx
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a323d78 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Vz1Z3UIzIUAG2MwulxIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3QVSjewwvovpG7JLkmC8WmDWNT3wpD72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX+iL3VZHL9dGe
 7kYCd0HeoO2+rWLJiPL9NkJSLpGZu/sbEhkxvpmR/kIFYjRQqzdV7E+0e1+7VhrOTFJPJjfO5Fr
 g5lqn3Bv926k+s1Zz23z6f9MPmhkuGDscE7QfbsT5M8oVomnPkgGMYxexvYuJNnYXMS20E61z9R
 Zs94vDr/oqPd1m4Wr8tseHaRCAF235qJ8DiIZKefyfhufztFRCDPiZScbop4RCTbLkzo0cGR8y2
 GW6MewRKCtzAHMo2iuh6Dv67mRO6ObUXV+NTXOrS/LeYceRisGWEP7To5DH/2PSViFRxMm/v+uc
 0HYiD9Wx5sBSQ9LWXviMpNCs2YQJq6sckvFop2Q9kh94jBFnnXrA/d+e1tHDbx92Bor9H3AAgfq
 uC3lwBKnvEL8ESNbI4ec+gURdeTvTAsyhnfCeOKHoa4WAxoKekf1pajm+n+ni7p0Ny2BTfUiW75
 2PBiDlnVboDPIIFa0kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
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


On 05-05-2026 20:25, Harsh Prateek Bora wrote:
>
>
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> @@ -1755,6 +1819,9 @@ static void pnv_phb4_instance_init(Object *obj)
>>         /* XIVE interrupt source object */
>>       object_initialize_child(obj, "source", &phb->xsrc, 
>> TYPE_XIVE_SOURCE);
>> +
>> +    /* Initialize RO-mask of registers */
>> +    pnv_phb4_ro_mask_init(phb);
>>   }
>>     void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
>> @@ -1934,6 +2001,7 @@ static const TypeInfo pnv_phb4_type_info = {
>>       .parent        = TYPE_DEVICE,
>>       .instance_init = pnv_phb4_instance_init,
>>       .instance_size = sizeof(PnvPHB4),
>> +    .class_size    = sizeof(PnvPHB4Class),
>>       .class_init    = pnv_phb4_class_init,
>
> PnvPHB4Class is introducing per-register RO masks which is supposed to 
> be a class data, but this is being initialized in instance_init which 
> is odd. Shouldn't this be taken care via class_init ?
> I am not a QOM expert, but this looks like a design issue.


Moved to class_init() method.


Thanks,

Saif



