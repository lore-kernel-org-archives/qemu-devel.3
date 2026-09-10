Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D620C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4i7g-0005Di-Df; Thu, 10 Sep 2026 12:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1x4i7f-0005DZ-Da
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 12:59:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1x4i7d-0007cn-L1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 12:59:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AFD3lK3280461; Thu, 10 Sep 2026 16:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=mYDaT1Z4Ay5bQKavjE/RCxGG+sHX2QCFIWeJ7wcRr4A=; b=DaGn8AClGd7r
 dkB2MaKjwfsAVOnd1y6MP/UiF9zPrci0XrDUo2XgtgSEwotVZNYOvoOKt62dELdh
 2jqRnsvMmzmOJDRurUHK4KNdLcQIuedCXPBV0O04KFBwJjomarRgPD6zfriXI8Kc
 9j6ZxYaNDN53Yi2zhEjpPL0o8EfWFTsGJ/MPNw20lXwGZmzS5+rLI+6/tLA4P44G
 fJgjz3lDONeSlxQGMQmN5dU0OoUMSog271uYRtQSFjZOff+CCdioTerYZhPS97Tt
 yaq3ZLGVUgCfAsHP2jn0s29HNypOeDFHOsJ6kMrTSVocNv49AOSAPQAQ7RlZRDjo
 7yYUs+D7LA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sx50f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 16:59:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF7ed0168826; Thu, 10 Sep 2026 16:59:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvr9ama-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 16:59:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68AGxUvu26542666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2026 16:59:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03FAB58059;
 Thu, 10 Sep 2026 16:59:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FF2D58058;
 Thu, 10 Sep 2026 16:59:29 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2026 16:59:29 +0000 (GMT)
Message-ID: <7f4620558ac861573fc83d6569189432de77493b.camel@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/7] qmp: add pmemload command
From: Miles Glenn <milesg@linux.ibm.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite
 <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric
 Blake <eblake@redhat.com>, Caleb Schlossin <calebs@linux.ibm.com>
Date: Thu, 10 Sep 2026 11:59:28 -0500
In-Reply-To: <cover.1542290622.git.simon@ruderich.org>
References: <cover.1542290622.git.simon@ruderich.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIwMSBTYWx0ZWRfX9uj/m2Qd4gVW
 li29OwWT+XCxRM3P1mVf4urVHUbl1jfTOh1xPExjh6HTyHEGkktpGfMsFmFODmv+YIiKlJRIQo1
 d4ys3bobz+4qaJiv5l0OlGLjiFSoG1g=
X-Proofpoint-ORIG-GUID: 6Q0hEh1E_2JUL6W-PV3QcXqM7VD2zxZF
X-Proofpoint-GUID: vSwgkX4Z9Iax7KGhKyNJXNdvaulN9_nW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIwMSBTYWx0ZWRfX4ntwvd74O8VH
 5jiWvLqgpcOC2UPGIChSwAcjpCl5WWaA0Qk+dQMQLIvUfUpyZM6AobS7FMJwtewitPgjnSOQlog
 Ts7G1TY8mgVZASWpIfJv2pW0MgNVuP5ZWDf+6x+a/RKNJqbPfK7EPO7H6Mhku9RrnlbSHp3YIgu
 OwY/4+TwNWVXLW6YndWCn0822n9kvqEItRppm27mZX8Ew1BYm6RyaIzaw9qsBvVLyOrwvM+xe4I
 SZZQEKkKd+jkrICKG8uNjo2mvtbwrFsg/CBARyF6+jEp6ou4vDgDBX2SUFDBN5Cv8jAuj79fcF3
 oU0rhmu+N8lZgzf4BtXY9BCyD+Sb3xhKmH+2k1gJ0hDaQhmZcuHGsIBTdW3lwwdclMO5cJ8XB0z
 9RCpBefv2meZf8FMvSjLObCOUSCh7YLxmtEEKfzFdyGAt7iT+/RiOEhTn/QV/uYiDbxCJV+evVc
 X4K3hOZU0U1VaksA0Aw==
X-Authority-Analysis: v=2.4 cv=PIGaavqC c=1 sm=1 tr=0 ts=6aa2e1f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=YDZNUCDIDsX5OQHn9esA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100201
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

It seems that this patch set stalled several years ago for no apparent
reason.  Does anybody know why?

I find myself needing the functionality of a command like `pmemload`. 
Our user needs to be able to load a binary file into a physical address
of their VM and it would need to be done every time they start the VM
(not just for debug or experimentation). It also needs to be done at
some point after the VM has already started.  I understand that the gdb
stub could possibly be used, but we don't want to prevent the user from
being able to use GDB themselves.  The pmemload command uses QMP, so it
seems that it would be the perfect solution for us.

Thanks,

Glenn

On Thu, 2018-11-15 at 15:07 +0100, Simon Ruderich wrote:
> Hello,
> 
> This time as a new thread to help patchew. The only change is to use the
> correct next version.
> 
> Regards
> Simon Ruderich
> 
> Simon Ruderich (7):
>   cpus: correct coding style in qmp_memsave/qmp_pmemsave
>   cpus: convert qmp_memsave/qmp_pmemsave to use qemu_open
>   cpus: use size_t in qmp_memsave/qmp_pmemsave
>   hmp: use l for size argument in memsave/pmemsave
>   hmp: use F for filename arguments in memsave/pmemsave
>   qmp: add pmemload command
>   hmp: add pmemload command
> 
>  cpus.c          | 85 +++++++++++++++++++++++++++++++++++++++++--------
>  hmp-commands.hx | 18 +++++++++--
>  hmp.c           | 16 ++++++++--
>  hmp.h           |  1 +
>  qapi/misc.json  | 20 ++++++++++++
>  5 files changed, 122 insertions(+), 18 deletions(-)
> 
> Diff between v7 and v8:
> 
>     diff --git a/qapi/misc.json b/qapi/misc.json
>     index 39f5e7dd38..e4f39e31e5 100644
>     --- a/qapi/misc.json
>     +++ b/qapi/misc.json
>     @@ -1201,7 +1201,7 @@
>     #
>     # Returns: Nothing on success
>     #
>     -# Since: 3.2
>     +# Since: 4.0
>     ##
>     { 'command': 'pmemload',
>     'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }
> 


