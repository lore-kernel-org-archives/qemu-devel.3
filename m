Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FB0CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9f-0000JH-4N; Wed, 07 Oct 2026 04:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xEI81-0001nO-9b; Tue, 06 Oct 2026 23:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xEI7p-0002GT-JS; Tue, 06 Oct 2026 23:15:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696I5NCe2622476; Tue, 6 Oct 2026 20:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XAn3Zc
 iBCAjHGN4Y5X3V1Ro/Ny2o/92hOsAUije3E0A=; b=o9EyD0rWJCFBnPq/mgfI43
 UragH2UFq5e14r5TivlwFBfVP80ANyVhUQq6dRdZyTP/kMXVRukSmwaw78EVwqr2
 ij76M2GMtYYcXk+1C4PAA9dApTeXgCvCdNTzNWgMd7jIaF7FHhvqNwQajkZvinWi
 b7f42gssWZgO7BoVy5PWNlpElufiui+q/xnsahfOguaLxfE4VhAICneUI6QNO9ni
 dFUHEzYW6ZYT05d9IAtDXXZxx4ADDy3rXNx5UrX/m22ePYO1D7/Ha2a4Mzxxlo7i
 OzvKIenI9M98M132x9EKq2ES7lUHcSE61BTFNndoFHyBCFX9HI7xHa2F8JhpDL4A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrj4dj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 20:13:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696I2Oec642052; Tue, 6 Oct 2026 20:13:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvuqrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 20:13:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696KDPTJ33423944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 20:13:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5359558056;
 Tue,  6 Oct 2026 20:13:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 937D35803F;
 Tue,  6 Oct 2026 20:13:24 +0000 (GMT)
Received: from [9.61.251.167] (unknown [9.61.251.167])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 20:13:24 +0000 (GMT)
Message-ID: <e3261ca6-e7fc-451b-bad4-8732bfb2e096@linux.ibm.com>
Date: Tue, 6 Oct 2026 13:13:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/17] s390x/pci: Provide each zpci device with a
 unique stable bus "path"
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20261006001643.420929-1-kshk@linux.ibm.com>
 <20261006001643.420929-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261006001643.420929-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4MCBTYWx0ZWRfXywYE3LfistKK
 ldad9gXUo8rX3VWT42hEo5AXn1cj3Z+VUR6qGfPamnPHS0z9m/2HkaIb2V1eLb1B7RcIvXU1u6G
 QSZhWk+a4Jqgoi8iPeI5Ke/+5ttxlO8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4MCBTYWx0ZWRfX5CPYMLUOePZd
 Vi59ER2hSZfMqbzGmTZVxekrhKv9KmboH3jHAqn+tbwzUCgANYHzWyN2mEsmsOvifHPrUENrDyb
 hsSbiuHrNSmvh6ekpUULs3hEpgoLseNVeG8rxCyI5Mc118p/RqiReKpCDhhl7pXbfjKirP0spoa
 0RxbR3+YlX4VBa4cjGMgaj0qOKEiQ524eArT0B12V+mgkk7nF5sk9GHxk27q5njEdTRN3SiPQyI
 1Ww1ZmCY4I/RpRt1m0FdfeXsJy/J+f8EwDBG04qByU1XsuFQTEKxZIEEbvn7EqxIgTB26oD2sni
 D5ZdTiErPfDyR7VNLgIjJo6GZRg2Q+3xBUjv3bd0B33sPt2FY1aXh1wc6bBNw7ltJzLYSWoHaXt
 xcAIs0etRdFRmQr6RD7ACfanhxKSANafmOAkTJenrqRFwUr/YcuWN8NGrjbNMhMKSp9hCaznSYx
 M0LJHVg22LHUxHK4LPQ==
X-Proofpoint-GUID: tuh_jGaR4RmZDNVze7Q7CExYy__jOrxK
X-Proofpoint-ORIG-GUID: tuh_jGaR4RmZDNVze7Q7CExYy__jOrxK
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac55667 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=1OaBWXuRFuCUTItNd-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 10/5/2026 5:16 PM, Konstantin Shkolnyy wrote:
> This is necessary for the follow-on migration support. The new unique
> UID-based bus "path" is used as part of idstr in the migration stream,
> making idstr unique and instance_id always 0.
>
> For migration to succeed, (idstr+instance_id) must match those generated
> during QEMU start. Without unique idstr, QEMU will generate variable
> instance_id to distinguish devices, and that instance_id can change
> if a device is unplugged and plugged back, preventing migration.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



