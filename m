Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD9DC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 18:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzfDa-000292-JN; Thu, 27 Aug 2026 14:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wzfDY-00025r-0A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 14:52:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wzfDW-0002mA-7r
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 14:52:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RIVhX71946949; Thu, 27 Aug 2026 18:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gTStdc
 V1sD739pMZ5ljq9yNYm0Mq9LHkFxVYsW4VsLI=; b=jwQfAORU0BAQE3C3fOIrvH
 ROn/X9/Er8nNSo8Yrzr99R8PF8meh62V/Ic7061MoziYwWVbSgQueRZQUxUonYeO
 M69l25VrI9YJVNWUzSGCwGHPxhZW6quoGzOtLBtM4d9nuGNt9/40Cc6wv7zkf45p
 tkqqJlOhbZX13XMQvWqwmuLEF3Y9uZKEH3r9k5Y4jCZje5r2P7fwHGwM9mNeb4eR
 PlYn/xKylu7uRuvfw+MdFMwksYety3txNVW65qpgvqFoqkCHkMo6oCcrjMvilw2q
 0lPrlERvFiHcyM5XzR69+zuoIlJRnTtLVdIstQsOmBrw/L8GSsNXoVcHImqAP71Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er7a2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 18:52:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RIfLv0024168;
 Thu, 27 Aug 2026 18:52:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwhu4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 18:52:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RIqhxK38404386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 18:52:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF7ED20043;
 Thu, 27 Aug 2026 18:52:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88A7F20040;
 Thu, 27 Aug 2026 18:52:43 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.26.147])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 18:52:43 +0000 (GMT)
Message-ID: <3f5d70c1-f8a6-4b7d-aef5-66aebbb4b623@linux.ibm.com>
Date: Thu, 27 Aug 2026 20:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix PVH entrypoint parsing
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240929180659.3598-1-ardb@kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20240929180659.3598-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6W9LoPr2JjmM-6cjkVNcQk9ab5VRcgT0
X-Proofpoint-ORIG-GUID: 6W9LoPr2JjmM-6cjkVNcQk9ab5VRcgT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1NiBTYWx0ZWRfXx2mgHQSmFSC9
 wlmGmu6/iI9SQ09xePlx1F/j/zONqfvHJw+f7x6EUuVvcHhuMeBbZ4VOT66pVa6S8KR6tPLd5SL
 K5T51xG1jBe0hGHNcKlguT1Knag5bYk34LVsftTPJB+NYXzYTdj1VgKc8V0iAcg3u1YHykP3sLb
 cOx3BhcEEpivG+R8rP+FYH1ksSdT9QIXORJRpY4ryEwGpuse4ee7iwe0nev7yvm9Y2+E8GzS8yg
 0oR9HFPXP3elXhcpFmewVgT6DzjNSipbiS28bJKONrfYAoBz/STVR/i4TqodKj0G2plfz1Zl19x
 eMbZvKrYMuN5IdaNr+9ThIpCNB9IxAiXMxHc09KGux8Jc0O1BbrHsu9ZCOc78SeVBHCQikfdqvy
 KTYmQrI/EymHv77YtKaB8SODtxzIqi9aB2KwwRDQsk+Fh8eQx43nQZNGwHRccXpLNqtjTDudb4p
 2zRlp2iE7GfgN+asKlg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a90877f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Y_vibTiXDuPSj5fsgzcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1NiBTYWx0ZWRfX8HDS/iFgBK4A
 Sqi5S8TUE9AjUVcq4DtA1EMv6T4ErUTiCKxyvhZPJfJNQg/pwrI8U2S+i9RCbSEw0kAJVa+JYns
 o3RfdVLYf8cNvuIZxs7ZXm1VbH34oXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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



On 9/29/24 20:06, Ard Biesheuvel wrote:
> Fix the handling of the ELF note that describes the PVH entrypoint
> 
> v2: fix broken ELF note handling on big endian hosts
> 
> Ard Biesheuvel (2):
>    hw/elf_ops: Implement missing endian swabbing for ELF notes
>    hw/x86: Always treat the PVH entrypoint as a 32-bit LE field
> 
>   hw/i386/x86-common.c     |  7 ++-----
>   include/hw/elf_ops.h.inc | 19 +++++++++++++++++--
>   2 files changed, 19 insertions(+), 7 deletions(-)

This series still applies cleanly and fixes the following test failure
on s390x hosts:

$ make -C build/tests/tcg/x86_64-softmmu run-hello
make: Entering directory 
'/home/user/src/qemu/build/tests/tcg/x86_64-softmmu'
   TEST    hello on x86_64
qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note



Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

