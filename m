Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04ECF9B61C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 11:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFVLU-0005w4-FH; Wed, 22 Apr 2026 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wFVLP-0005tH-AL; Wed, 22 Apr 2026 07:02:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wFVLI-0000C9-N7; Wed, 22 Apr 2026 07:02:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LImJsT971859; Wed, 22 Apr 2026 11:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sFEzM5
 CPr/gIqhN3HirsVnUJtKKu4/I9HljMGiwcbj4=; b=AtNIjlRD7XRn/NsYEznKtK
 MQsQyA/xLsZo06u4t82+kQYIW1jvUYsApw30Hs1EQ524AD3yNes7LfPGhkZK6al2
 SWYPC6pmmt9eKv6id3E/BpkasSbyq1Y/GXs2TjUkWW+HcZpxMP2o5EHGEnZ3lm8J
 XrIyMsUEyS8iFPs3ZIu0tPio714uD9Ajd76n5qG5L0EH6ZKLujYOXNNMZ73OplpL
 kVmHccLiUu2ipL5h6xFH/RLd5105cNvSKr08e2YC6m4dZG7MhaMw7i/24duRUuVr
 8c4qQeDa20poV/dCOWfd+H0r/DP0XSC+rCGl10eWVIUR7VUdR1C0Z7G4irizL2ww
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3ju41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 11:01:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MAoK98019865;
 Wed, 22 Apr 2026 11:01:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky9wmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 11:01:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63MB1jkr38207956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 11:01:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6735120043;
 Wed, 22 Apr 2026 11:01:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F8482004D;
 Wed, 22 Apr 2026 11:01:43 +0000 (GMT)
Received: from [9.39.31.91] (unknown [9.39.31.91])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2026 11:01:42 +0000 (GMT)
Message-ID: <877044ea-3e21-4f71-adce-828c4277292e@linux.ibm.com>
Date: Wed, 22 Apr 2026 16:31:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] As reported in qemu-project/qemu#3324
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Zexiang Zhang <chan9yan9@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20260326152733.344926-1-chan9yan9@gmail.com>
 <acjT4ENff_tcJQtz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <87tstyxtln.fsf@draig.linaro.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <87tstyxtln.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EIn8lX0iVP_197OYOvd8P5h_4nGaxRZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMyBTYWx0ZWRfX4Cyzjhd6Eu34
 w+ZQ6ICvlfa9NBfq73Dq33kMfxmgp4EMxaIec5XSZoiHMCARITiOFjDHgxl8P9XED33YDnoJTAw
 p2H6k1gMNzJ0tZK6H2SPfb+IzNOgtj8bmw+f8+pTpQv+hOHLAi959aD/67jj44t0/kBIebcrpv9
 zsh/piWw+ldDM4G4pI2Zu2dCdvYt9LuwSHHR8w67s/cD4Dj9rl2RYk70PnkxFNBpyb9DQa1ELbD
 DAHmHf6cb+1eeuM39Ez/W7jbgsjmsJrtlO6SX9c5IZ6gwjL0wHOUh30Ms67eO7CXicQdu/Q8qUi
 yj+xiLA1q3lVnrrW3dnhiWySh9pM1tz89jajTRUn8nQMRET8pF1NSiULeDWyj/6bhGP6wjwoHEo
 tQcK6Y1BaHTRD89VRF4qkSQwiSAwBJHIOMRLdVpybdxaOhcX0tkiF46KkUJGxlq5MC9PlkZsbcJ
 bJXtJvb2eYDOSg/1XhQ==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e8aa9e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=kv5Lg-RpFPpmmXE_Fh8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r20B9gpYe6JMEKX45lU-sHngPy0kSMYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220103
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 30/03/26 02:04, Alex Bennée wrote:
> Aditya Gupta <adityag@linux.ibm.com> writes:
> ...
>       if ((priority >= CPPR(icp))
>           || (XISR(icp) && (icp->pending_priority <= priority))) {
>           ics_reject(ics, nr);
>> The change looks good to me. Can you post a v2 with the subject and
>> build fixed ?
> The bug fix link can go in:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3324
>
> just above your sign off.


Hey Zexiang,

Ping, planning to send a v2 for this ?

cc +gautam


Thanks,

- Aditya G



