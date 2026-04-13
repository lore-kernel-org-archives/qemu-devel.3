Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC37EBFD10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCBtu-0002VE-4n; Mon, 13 Apr 2026 03:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wCBtq-0002Fe-I8; Mon, 13 Apr 2026 03:40:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wCBto-0006oz-Mt; Mon, 13 Apr 2026 03:40:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CJF39V2897733; Mon, 13 Apr 2026 07:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+Gckv2
 M9p1mNTsqe3ii1JrV33Rbla4jfy+2WAtjSvQo=; b=UCY2Xm5wPQwqsS6kNWfLat
 HMvFveluT+sKZ/2eFBYwln2OIf5JnmA7VsWAWtUqZL6/Q/EtY4K+L4TmXkVWx2Lp
 NsMlAXM/hz/rGsbDF9eBsQNVOVyQ54RLG+RIMfaJwQG9X/mBcwX4joUGt1pH17LA
 wwpwz4aq8/m8DF0gSk+5ZBxhQBzP7/P4q/Lv8/t26yeJ6wCEb+dxd6uFkJEsM+a7
 pb46BgwZVh0pX+40x1jQN71qrcKOEbF9GWMqXPkNf9p1esQIsZCmZJUGu4GpqlMy
 M4MQ8MpSMoz9niKseZU41XUZe+iFC7zrCxt8PkwD/1Dye1T/9Q/+M9GUOO6kbIBg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqpgt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 07:39:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D55vdu025761;
 Mon, 13 Apr 2026 07:39:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1bwsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 07:39:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63D7drH48848076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 07:39:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 260985803F;
 Mon, 13 Apr 2026 07:39:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEEBB58054;
 Mon, 13 Apr 2026 07:39:49 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 07:39:49 +0000 (GMT)
Message-ID: <33b54326-f6f6-4589-9fa8-bc315a9be2eb@linux.ibm.com>
Date: Mon, 13 Apr 2026 13:09:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
Content-Language: en-GB
To: Ani Sinha <anisinha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, balaton@eik.bme.hu,
 qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <87qzomznto.fsf@suse.de> <d4ca5f6a-c810-407b-b089-839e0a7d6d06@linux.ibm.com>
 <A44F57CD-3292-4715-BE26-98DD15D40613@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <A44F57CD-3292-4715-BE26-98DD15D40613@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dc9dcb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=aHC7gpCOpxZIYopdUIsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gOE9PviYbO3wlO3xAiUDLF6Cr7DV9rav
X-Proofpoint-GUID: 9GeYidcRu52NQr-TjExo6576xoH_kxdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA2OSBTYWx0ZWRfX+o2c/QdqN+gT
 J2GJF0uTvBgbWX1Lz9kqPq2gkct/aCHCFj5k+j06Eg85vyVf4ks5WUw5EcxoIsl5F0BLGCg2sKb
 o6MGsPUIA/akdU8fjUGkR6a68YudC897tOGcsJUyMNRZ064P5Yts5BMEw3S9aHwu7P7RTtJ8NfR
 +0dmtDB/p4lvMo5vWOggnqOnRbcpK7O7Odml3oVFdGxBNLW6phMXTKPbb+OMGXdysiERBZYONLz
 mRGYdbSuxNRuIbl2cVxITmm/wNkuDe1rPy4Z4qYqRKx0SR2dOv6rvZ8N0JtCSaOzNF4huJc+GVB
 ctT1RBKoxADispGIHb754abFrdQvIuxivJTYrkyOdpmMKv/pXwS9vIJbfhCw1BuT49BtAH1kfvp
 okVHaPyk0ol6w+fbTVO0C3Y5nksL7q/rRuYiQ3a6zMGAEfxtlwq56STxQ3efkCi0zCZDHBMzOp+
 Ei2SNHa/Pf493unxNVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130069
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 13/04/26 12:43 pm, Ani Sinha wrote:
>> Ani, would you like to post the patch fixing the behaviour change
>> introduced with commit 98884e0cc1 or I can send below patch if looks fine?
> I will post something soon.

Thanks, Ani. Let's get it fixed in -rc4!

