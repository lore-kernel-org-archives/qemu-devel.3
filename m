Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6D5C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXiM-0006oL-4Z; Mon, 24 Aug 2026 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyXiK-0006ng-H2; Mon, 24 Aug 2026 12:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyXiI-0007yt-Gi; Mon, 24 Aug 2026 12:40:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OG1a28500978; Mon, 24 Aug 2026 16:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sOuPtm
 TEu7zxiukE8pTzttVceDbyWwERbfRwzeZ28Hk=; b=QSG+uonkM2E2hbfnCIyEi8
 o1uiovXOQfK26oXaf6wMMCMlk9PbrTVchcffjYQlWhIzWGUsD96R8luJ88GkhtO9
 thJAxlwDgZ+J4YvyONEu+f6+L/7JH1uCXDvOffSlyLjpVBtjkBPRj8uR+TXF4TZS
 7X64QssJQRdNFenX/qwwDJaN+CIBjD8T2ixggYry79aZeyFFShIBMvuT53QX5cLJ
 GufDmZSw5niZubcy/zD7tYkhH9psAri3Srp+8CoHtEanswyxR8VIDiATGsiDT5hh
 V5K+PE57V1RF0A0Z9NoAR6bcdfKGPIcFznIW4IIxCm6TmnrfyqXtvf5eCbUAJz3A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqjq5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 16:39:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGQKCe028220;
 Mon, 24 Aug 2026 16:39:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgy3he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 16:39:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OGdpJo29295212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 16:39:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E1F58056;
 Mon, 24 Aug 2026 16:39:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAB5E58052;
 Mon, 24 Aug 2026 16:39:50 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 16:39:50 +0000 (GMT)
Message-ID: <21439612-9d8a-4e95-8ed2-7e74822aef10@linux.ibm.com>
Date: Mon, 24 Aug 2026 12:39:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-4-jdaley@linux.ibm.com>
 <f2f3b5de-e1de-4e8c-82c8-2379b78e9ff9@linux.ibm.com>
 <2c98040b-f6c7-43cf-a768-5089258e723e@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <2c98040b-f6c7-43cf-a768-5089258e723e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VShwJQ97JkdgfcaSC2k42aTV7U7mgJN6
X-Proofpoint-ORIG-GUID: VShwJQ97JkdgfcaSC2k42aTV7U7mgJN6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfXxQXqF/Fy1VXh
 9LK68h6tXoZRv/7ft85MS97ej7ha47KJDWD9HfUY8WhLGeJJc47BZaTeSDKaLczO8V9rKEGTmrg
 9Cj6pAkJQL27rjSD+mDvZE58DARozR1AisWeZcduD0bpDzh78WRn/xkYlqVx+VUDAaMgke4LPDL
 CEGOLsRJAvjfEybT0D5McEvLS5zk8yY+5phWmkxPPtI5ScnT8WgfGZySzxuSijWEawnnkdvJAmo
 8pIB6fqxB+u0lcLONjKOt7JUnMg7D//yS81f6m5cts18HRENNthRv1I1xSBfARqAJ5Th1ZUk7Lu
 3QZlQsX74NC/b457xkhUI0cIQObMmK/WGFTOgUQmbTjS9gTNyLnKX8RliPdTdVyl2CePFM6orGw
 sV0Bpb6tvyiVTfw8LRoDiNDP7Do8Nf1mdjdtdacGutzxOKcuI8DuoA6j5fygNBFXB3+YHb1mNra
 /ijObgto1YX4bd/X3oA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c73da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=AVNu2gD-8LlSp6Ms5TcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfXwhujNN38Bfza
 V7/yB53EiT5Luxfu5VvP4DRBmgV8Kb0vW5Vupkm8nc56hq/stGKEfVMyz2gzg6azKJ8OGf5jQ9r
 lrBi/+m/htQkBNmnFogzzzdBihDb5nU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240139
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


>> Unless this is really time consuming, I think the simple answer is to
>> just let the setup run twice and don't try to share between the 2
>> instances?
>>
>> Thanks,
>> Matt
>>
> The setup is time consuming compared to the verification step. On my
> machine, the entire test takes about 120s, and about 90% of that is setup.

Bleh.  OK, that seems worth the extra complexity.

> 
> A simple solution is to scrap the subtest idea and just have:
> 
> @skipBigDataTest()
> def test_s390x_secure_ipl(self):
>     self.require_accelerator('kvm')
>     self.setup_s390x_secure_ipl()
>     self.verify_s390x_secure_ipl('ccw')
>     self.verify_s390x_secure_ipl('pci')
> 
> But if we value separating the ccw and pci cases into separate subtests,
> I have a solution using setUpClass() and class-level vars to run the
> setup only once. It just makes the code a bit uglier. I'll proceed with
> it for v2, unless other opinions arise.
Sounds good.

Thanks,
Matt

