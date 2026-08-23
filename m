Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F87C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 06:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy1O5-0000Xw-Nv; Sun, 23 Aug 2026 02:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy1O3-0000XK-48; Sun, 23 Aug 2026 02:08:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy1O0-0004Hq-Uy; Sun, 23 Aug 2026 02:08:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N4VtMl334251; Sun, 23 Aug 2026 06:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YpRxF5
 57t5dlyKPe6J6neu4+WFFJrBU34cxHeZ0cjKQ=; b=XpyCuMlKZqg5xtXK5+AWZq
 +7OqlzUDfZAittVhAtZXQ1tdGMXkoTY9hzv2wlOys6X2wlOw+VawwSQr6lq9xW94
 SALDw8jJPEQnjVbNPm1bqBSXkXl4Va3y0nP8ajCHxn8IMLVXo+C/KK3aFSHxS10W
 GBNgrrk6barjjOEkeIF+DiaxUoNePNdfA97xl2D4IXP5D2x8DYElJ1lAMOHIdNIU
 qlVEdK8yuBI88ctZcnU3FC//xD5Cs1u2hXkGwgDtdnJozGVIc6HAStR5IT54KDmG
 7l5vSkDfWKG7MLEMkbvmLz0a6IEf4vDDtqn5N5lb09j4mhkdMX7PbrTUvhB2rKOA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqbu7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 06:08:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N5uQHK029114;
 Sun, 23 Aug 2026 06:08:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3prrq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 06:08:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N68mRZ24052272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 06:08:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9EE858055;
 Sun, 23 Aug 2026 06:08:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 527AD58063;
 Sun, 23 Aug 2026 06:08:46 +0000 (GMT)
Received: from [9.39.19.238] (unknown [9.39.19.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 06:08:45 +0000 (GMT)
Message-ID: <ac216284-b531-434a-b83b-e7fcf5e557bd@linux.ibm.com>
Date: Sun, 23 Aug 2026 11:38:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/ppc: Add lower bound check for watchdogNumber
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, bubblehuntr@gmail.com
References: <20260818104551.76023-1-rathc@linux.ibm.com>
 <01070c86-0a61-43e5-8f55-7f217a3f96a9@linux.ibm.com>
 <1a184add-d994-4635-a9ca-f1a74aefd27d@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <1a184add-d994-4635-a9ca-f1a74aefd27d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Lnos8r1yaqkLD5Fw1CdhADgO1jWDfIxz
X-Proofpoint-ORIG-GUID: 1itDnQcS6Lb5D9YCsQNpD4wUC_ikWT1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA1MyBTYWx0ZWRfXxn29obua1RDZ
 iTaiRRNbhZR2ZHbIybjoSq+EpFo5d0+yiWI73Rn4X4YXMyRrWTOy4Bs2AqYnIR78OIGw0c6yFTZ
 G7MpNdbVwhryLRlypCUgaZqbWDw1Yxu31aMVYYqNQDqhVnlPNdFDK6k86F/OjLOLvjpdflXayyA
 XLp5Sfd34x6fcfsO0tWXFx862S+Jl0pEtXWoRsoHqa5JcJzkmYUGcTlmDBhCgIUm0ZQqa1enRlH
 WaZdV5uz5XEKfThOlRJK6qSAPcvLOnfo2OT9b8TDnX+66tErRvVxJofocEdgJJtZd0c8WbI2vYF
 CoYHYetgPWADaWulAE2m7J7dFbsl+3wmPT4Z7T6KZKhWphp6RQuvG33SE3sYIMLl07i+D2+0EJR
 GGodYuXTHGPWmKNa7DmOWwUEr+UC/WiZ8DK5+vYINCjMub7qsKNtjRYx2mdh1+Mp1r7wGHS+KOe
 6BY98OKSxhaKMNb6EwA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8a8e72 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=khlrxgviVr3phq_44noA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA1MyBTYWx0ZWRfXznwNYxkexu7i
 9RM4jYVp0yMWBXwpDWYCUQQPw3hF1jy9iWtPI2zQTocpMOP2Yv3ivE9OmU+015NVhwR6s0Vhffz
 VbH8gRoZL4fNnXIApmAE0IqvpKc4J44=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230053
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 19/08/26 3:34 pm, Chinmay Rath wrote:
> 
> On 8/18/26 17:11, Chinmay Rath wrote:
>>
>> On 8/18/26 16:15, Chinmay Rath wrote:
>>> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber 
>>> parameter
>>> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
>>>
>>> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
>>> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>> Reported-by: huntr bubble <bubblehuntr@gmail.com>
> Hi Harsh,
> I missed adding the correct commit message header here. Should have use 
> hw/watchdog instead of target/ppc.
> If possible please correct this while you pull in the patch along with 
> the extra Reported-by tag.
> Lemme know if that works.

Taken care, queued for 11.2, thanks.

