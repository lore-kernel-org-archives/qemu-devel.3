Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C18E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNELo-0003LE-MD; Mon, 16 Dec 2024 11:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tNELm-0003H1-Bb; Mon, 16 Dec 2024 11:53:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tNELk-00054y-1A; Mon, 16 Dec 2024 11:53:41 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGFHuBj019557;
 Mon, 16 Dec 2024 16:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XTyRHI
 PLnaL0A4Ai6PvPW0VlIdEYJ8t2/4KCteWnrSs=; b=HBdJlo7Su62+yzfsJApSaH
 eu/mGFjpbHnsK0bPni5hAKKRCoT64sPK7m1VR9zDfhg8k0+lJx/xH6Ka0b+I+v6M
 IcbsppnimL4H5ziWfsdf+uVfC3d0YXjxuZRGOjSlQanCjeRWTYFft7LwP6NsDBlN
 l5VYGWuNVVjj2iWXPb6ZWi/ia04Wpc2iXML3J9IrR+Let4ArEmsBpBHEf9gnO7I2
 N4FUCPJGU4mQ1Y4mbRxaglhTwf8oOELgkHHZTQ6xr6o4Q4BM1TYwWp+/SjeV2vgk
 yf16v7XDws0bBgOVKnaOb/zovrV/4vQOAKwkJ4XYvx05yJYIDxFcgvCYOi/A9BNQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpguky0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 16:53:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGD6Z0q014323;
 Mon, 16 Dec 2024 16:53:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxxwyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 16:53:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BGGrXvI52036066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 16:53:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE21958059;
 Mon, 16 Dec 2024 16:53:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 658485805F;
 Mon, 16 Dec 2024 16:53:32 +0000 (GMT)
Received: from [9.61.117.46] (unknown [9.61.117.46])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2024 16:53:32 +0000 (GMT)
Message-ID: <f1cba8bd-b15a-456c-8640-7c0ed221b2d3@linux.ibm.com>
Date: Mon, 16 Dec 2024 11:53:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] s390x/pci: add support for guests that request
 direct mapping
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
 <20241213225440.571382-2-mjrosato@linux.ibm.com>
 <7e07ef1e-4fa5-40d7-85f9-d7a199901b4f@linaro.org>
 <46acb391-154e-43a1-a459-1646dc27fb33@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <46acb391-154e-43a1-a459-1646dc27fb33@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y15MQbnYgQo-m_LpZOt8OseJeE05ji2w
X-Proofpoint-ORIG-GUID: y15MQbnYgQo-m_LpZOt8OseJeE05ji2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160137
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.13, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


>>> +{
>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>> +
>>> +    /*
>>> +     * For direct-mapping we must map the entire guest address space.  Rather
>>> +     * than using an iommu, create a memory region alias that maps GPA X to
>>> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
>>> +     */
>>> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
>>> +                                            iommu->pbdev->uid);
>>> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
>>> +                             0, ms->ram_size);
>>
>> Is it a good idea to take the whole machine ram-size here?
>> Could it be better to pass it as qdev property?
> 
> I think we want all guest RAM, just like ordinary vfio on !s390x without a viommu would do.
> 
> Matthew, I assume to handle virtio-mem, we would actually pass in here the result from s390_get_memory_limit(), which will cover initial+device RAM, correct? Until then, this would map initial RAM only.
> 

Good point.  Using s390_get_memory_limit() sounds good to me; That will make v3 of this series dependent on the s390x virtio-mem series but sounds like you're sending that sometime this week anyway.

I'll start testing on top of that with something like..

memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
                         0, s390_get_memory_limit(s390ms));


