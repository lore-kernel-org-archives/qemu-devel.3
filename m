Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B07C2A069
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 20:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcUzA-0005pn-CI; Sun, 04 Jan 2026 15:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1vcUyx-0005pE-13
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 15:45:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1vcUyu-0005HP-9A
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 15:45:46 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604BPswJ022322;
 Sun, 4 Jan 2026 20:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fQHSHW
 CS7Gu9nGVTLsY4BqEWGHIdNfgdge7O2akImqA=; b=oSlyttbG37L93L575s4bjX
 6Rzg+FJbECtk++yl1s9m7/DkdaucUpXo353suSiJJjutkisOzMb16jDJ/d5vb0MH
 2BK9KZZyQAEAc3xAs+DmY/AeBzUCqMlsPLplrOlpG7fMxnseba+Ad1kuFHcfrs58
 ZBG9et/+gff1UDZnoT9MZ2mkABFYcggWoK7bTbdkjfXc9Wvre8kYye016Utm+OmF
 5eaHmJvWiu+/h7jt9D9H5LivmoRiCm1juSMGIRBCi/QLvvLx8/eAvOVR/UzjJ4IX
 iN4ui293gmsgp9EHBPCty+gpBSTK/aVbI+9q0aghMc2vrl1WsUoGRTfm4hnViqww
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjvafd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Jan 2026 20:45:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604EDHbP014667;
 Sun, 4 Jan 2026 20:45:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemjm1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Jan 2026 20:45:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 604KjaU326936028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 4 Jan 2026 20:45:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE73720043;
 Sun,  4 Jan 2026 20:45:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B99EA20040;
 Sun,  4 Jan 2026 20:45:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.1.137])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  4 Jan 2026 20:45:35 +0000 (GMT)
Message-ID: <76c4d5b1-2d67-428a-90ca-7accea69b810@linux.ibm.com>
Date: Sun, 4 Jan 2026 21:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] gdbstub: re-do unlinking of unix socket before bind
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251225062919.685146-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20251225062919.685146-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695ad172 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=9qUTvQc-AAAA:8 a=VnNF1IyMAAAA:8 a=1kgRwCGjvmI_MkLCpmwA:9
 a=QEXdDO2ut3YA:10 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-ORIG-GUID: L8VyV61fdj_slMvMCksCAXDZ0WLUZeZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE4NyBTYWx0ZWRfX+FJnorNEpN1z
 MPvES9x6EQ+5BP0JEUzlJpcKUH17bA0vMPsBj3kB0m9OD7CjNvHJRaHXtlqNyxx9zrSxSekEqmr
 VVAII8vhflEHxxU327tFirIQaY3b7nH9f8oAVuf0DNIgL1TzP7Y2QBvdF3CZjYf53rG9oUWdMS8
 uRWZAINOG97h+MTudgiHa0ZxHtSr/HwpWJFR5z5HbWCnDz10TIzyVybOi8ychvm0bZCkelydKvQ
 5sqhsXT2qXvAtoDIP6AxjSrts7YqkX6sQfXTQPzGm1RzEXIMRxhbVz2RhA70RbnELujMFdHVdUw
 xBW2I3oPXnVrehrQF+EGRok6P8DolOBfeOnDlhn0I5CBjDrqMDgH4z3QOsOPZV5QaQqfENoFF3p
 LZboJd3NYlFVCvsDwOYmI2euMG6VNIPqB6KLZ923yg8xW873v+fezB8HGspY/FEHIp5eZrrhHcX
 eLr0xbA/kQjQK44n/9Q==
X-Proofpoint-GUID: L8VyV61fdj_slMvMCksCAXDZ0WLUZeZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 12/25/25 07:29, Michael Tokarev wrote:
> Prior discussion is at
> https://lore.kernel.org/qemu-devel/ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru/
>
> In short: when adding unlink() before bind() for unix socket
> in gdbstub/user.c, a previous patch introduced dependency of
> linux-user binaries on qemu-sockets.c, which is more problematic
> for usually-static binaries.  The monitor_get_fd stub which were
> also needed is another example why this might not be the right
> approach.
>
> This patchset reverts the previous commit (with fixes for current
> code), and adds just a single unlink() to the original code which
> handled unix sockets directly.
>
> Michael Tokarev (2):
>    Revert "gdbstub: Try unlinking the unix socket before binding"
>    gdbstub: unlink the unix socket before bind()
>
>   gdbstub/user.c    | 30 +++++++++++++++++++++++++++---
>   stubs/meson.build |  2 --
>   util/meson.build  |  2 --
>   3 files changed, 27 insertions(+), 7 deletions(-)

Thanks!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


