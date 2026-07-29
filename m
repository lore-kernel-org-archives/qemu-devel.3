Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC63DC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpAZe-0007Cn-F1; Wed, 29 Jul 2026 16:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wpAZd-0007CX-DI; Wed, 29 Jul 2026 16:08:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wpAZb-0004a8-Gi; Wed, 29 Jul 2026 16:08:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TIliXO729169; Wed, 29 Jul 2026 20:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tGpjxx
 QBPFJ1aGqCv6XFn8BEheIXIBgw37nr7k72oek=; b=X9/2eGlBxhAQUVSCRu4RYK
 DcOc6Hbrwlpau/v9YPJmc2lpJa4KhMgp0osicb9RD15Q2/F5u7Gn2/lpmAu2ZsyZ
 K9HBGmuCJzVe8lcaY/7WO0f5uUWY+esq5kiGREIGHCRCtghSF2px63KDqT33GVFR
 NwNNLo35EuVhsp7xFTkO6PaU6XnVh8mccrv0PcJ8Bu5BnftZaltNlcRpgT6V5wbW
 l6bFc+sBcbte2xx8OYxD8Pfu983GgHzxepmPLUPqR+zgZnZh9ia6s2JY5eDpLoDq
 ts/5zZrgztQnVzfr2Hfh+uJuVjTGyBVthqAvEjaSdmlD6U7hDV4v0Y+hYpTS+7wQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjbqhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 20:08:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TJuOsO004663;
 Wed, 29 Jul 2026 20:08:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqgg86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 20:08:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66TK89rf1901356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 20:08:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C5958052;
 Wed, 29 Jul 2026 20:08:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2A0B58056;
 Wed, 29 Jul 2026 20:08:08 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 20:08:08 +0000 (GMT)
Message-ID: <4f4154c1-f8d2-4ecd-a162-ba27e865a846@linux.ibm.com>
Date: Wed, 29 Jul 2026 16:08:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] pc-bios/s390-ccw: Fix off-by-one errors with
 loadparm and boot entries
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com, jjherne@linux.ibm.com,
 borntraeger@linux.ibm.com, jdaley@linux.ibm.com, qemu-stable@nongnu.org
References: <20260728223013.4047042-1-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728223013.4047042-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX6xOd8qvNe3d7
 2HXbjyh/Z1YjsJdUXzc1tOIP/X4EyiZhkf1/JVvDG7mOrbbNu4NkctA/vKVJTsmTH7+Zod+8nEu
 ivUWLKdCQcQD0yIao1Wh8XNjvkNEx34=
X-Proofpoint-GUID: 61Tuy6beDlo5InC57QWe_BElmDbou40H
X-Proofpoint-ORIG-GUID: 61Tuy6beDlo5InC57QWe_BElmDbou40H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX1RB45EpDAwWK
 5eh/p5aZu1BplfPMOXTL+USw40apqIWiMpyFPYjtNx3uq/rJ5n1T4Wlw2nfbOVLP2MGw1wDQU62
 uCspfILI4BlgAr8+yYewuzsTTy5MkbgeElh5WRd5h/nj+5PZ/hV4lqb6SVuGbuc4eaB6ViNfzQD
 yDgOIkfThvtrcdjn4evALFMmCXmylzlTT48NeDwNbnPZF4knYshyG392aBflvS93VmnLapXQqJ1
 yMReGWsHuD81LrN52gUFk6RGEgFYSoFazvy7pBwpyH9bTQmT0XYgOiNs8s0uUHgh0C3CSK+dA+p
 HVA1oVqX1U1XnzzD9T4mXToVmPySursFUd24Co3Np3756v6oN3VJDdL4gHnFF2PzRn15ZiNONBD
 mm2zgDT9EaxKkBkkNlMxBtCY4YEyhPcoZS0W4fmPoxePv1WW+Zs4wcTtexclH/UDd4FyY4cCTrB
 aZAJimJiJZzmm9FWHLQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a5dad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=23oPQvHkSN1SiTPt77kA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290152
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/28/26 6:30 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The loadparm may optionally be used to select a boot entry, with the
> intended range being 0 through 31 inclusive, for a total of 32 entries.
> Previously, MAX_BOOT_ENTRIES was defined as 31, indicating that it was
> intended to correspond to the index of the boot entry rather than the
> count; however, some guards also used MAX_BOOT_ENTRIES as a count of the
> maximum allowed entries, which resulted in a mismatch between the intended
> and actual range such that index 31 could never be used in practice.
> 
> Move the definition of MAX_BOOT_ENTRIES to qipl.h so it is shared and
> change the value to 32, representing a count of the maximum number of
> allowed boot entries and allowing the loadparm to accept values 0 through
> 31 as intended.  Update some instances in the netboot code where
> MAX_BOOT_ENTRIES was used as the max index so that all guards treat
> MAX_BOOT_ENTRIES as a count across all boot methods.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL path")
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



