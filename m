Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E895BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woO2h-0000Gl-3o; Mon, 27 Jul 2026 12:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woO2e-0000GV-Gz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:19:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woO2d-0000iy-1b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:19:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDnQcT2298675; Mon, 27 Jul 2026 16:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dTiXz6
 B8tQIeo+Y+w6gYp5AhKCKSoyrHxJ1XjhQZ/Ao=; b=J6Ol4S9dsnrENhz0jjoHRv
 eYIKhv+qfGAHY2VWLxZUr5urnCrLJI76W5iDfg+A0y/xw4aXtcNBonm6SddoPteZ
 wyTnRW7ojRFEUvQHXKbxuSNCX9sm5rYGu+OQM2d8dl2MV2mqfqOiwXKvujEGqeV3
 gBGvGrC51TxKhu+8SRUBM5RF2BsHZr1mp/+LvagRzd2ti7F+5/gkkScnfa/0z3GG
 J0yF/ZaBEuKot1+32kd8Ou86kio2BZIm0KFTofLy+cyIjXowqFh9WAkyuWDAxElp
 VZmwAEu/Al5hHEN5VrFdYF/WOYhoRsVmLlME7Tt8e/b6j5VqUL/WjSCZNwoLk22w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0h8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 16:18:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGBV8N029721;
 Mon, 27 Jul 2026 16:18:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwt8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 16:18:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RGIrOV13238634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 16:18:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2939D20049;
 Mon, 27 Jul 2026 16:18:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0FAF20040;
 Mon, 27 Jul 2026 16:18:52 +0000 (GMT)
Received: from [9.111.60.83] (unknown [9.111.60.83])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 16:18:52 +0000 (GMT)
Message-ID: <81ee0ea5-9158-4671-9e68-2ae8b9007486@linux.ibm.com>
Date: Mon, 27 Jul 2026 18:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVEs and the QEMU 11.1 release
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <CAJSP0QVRaqb6Au+s-64bouKqu7S4yPoQiExUuL45MnAWAp5p8w@mail.gmail.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <CAJSP0QVRaqb6Au+s-64bouKqu7S4yPoQiExUuL45MnAWAp5p8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX01DAv/I48gxK
 6pb1+jrOXNTSplL6u5HyoTm/ep0I9w5Z4R1jqxXUtr91T3JBtzP3ScPYF3SYxNYmje+LiRCir8L
 SPsFqJEfKKQcYuQt4Zv27qmTtsLauOg=
X-Proofpoint-GUID: aK8PM9yO6lt_aUeOBAxroAmTHx_HwVmH
X-Proofpoint-ORIG-GUID: _ZoQQA4vxomsL9QPWZ4CDves6wPb8_-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX0XQWnr9INmjD
 DlGWp8CgeT1U2Ay/ywAbRrXvqajBjDgxR6uhscTr6UuJLv1tVa7c43ujd9492DmGvcQv4N3sx41
 BrENQC8asEN8EFYwhfAK6CUHmkeel/8TY6TTSKNHk4JbgPcv9UYu3AJj4d9wg6rmmQ4O/oZKq/f
 wZrdWxu0+GFuih7fZHQvYBPbrwlT1d5nQn1/OS5RQtvwa9vHy44eeYzoj1EnjAwNY7XRBHC4JBK
 9SIE7D7hfBshZKIW+/UXj2D+YkRSNvWvg/a8bD+2rNs4w7tWqFVt7V1lUeGsPNzw9zt4daJnlQS
 KSWJ/lK3nMXeXngzdh/3FEAeuMnw9lcyeegiUWAiZ+hp9ChCvDt3hT7qPGHDsKrHR4IDGOc5D3k
 pktWEcYUOwa/2ox2hwcZvV7l1lrrnG7vFJgYv4gX/Zd3XhAK7Ijqnh9BLlhfJkxSSZoomSL6aDB
 PlEEaDk2F13cp1aYAqw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6784f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=wGgxwyPMilPNLRfSqNcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270151
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Am 27.07.26 um 15:52 schrieb Stefan Hajnoczi:
> Hi,
> QEMU v11.1.0-rc2 will be tagged tomorrow and -rc3 a week after that.
> The project currently has a backlog of confidential and potentially
> CVE-worthy bugs. Maintainers are triaging these bug reports and fixes
> are being sent to the mailing list.
> 
> Holding up the QEMU 11.1 release for any and all CVE fixes is not
> realistic this time around since there are still a number of upcoming
> fixes expected over the coming weeks. Many CVEs are low severity and
> do not pose enough of a security risk to hold up the 11.1 release.
> 
> I'd like to approach CVEs as follows:
> 1. CVE fix authors and maintainers should indicate the severity in
> cover letters. This will ensure that serious CVE fixes are included in
> v11.1.0 while less serious CVEs do not hold up the release.
> 2. Low severity CVE fixes should go into the -stable branch if they
> cannot make it into v11.1.0.
> 
> I will be looking at CVE fixes on a case-by-case when -rc3 is tagged.
> If you feel a fix is critical, please let me know.
I agree with not holding off. People will continue to run LLMs to find
new bugs and it will take one or two releases to get back to normal.
We should rather have our fixes process working. I fear that Michael
Tokarev will have plenty of work.

