Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222C606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E619rlfI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEw7-0007Vf-A2; Tue, 03 Nov 2026 08:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tasmiya@linux.ibm.com>)
 id 1xOEw6-0007VR-D7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:52:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tasmiya@linux.ibm.com>)
 id 1xOEw4-0008Eu-Hn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:52:25 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DiKZV1894049
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 13:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w82bV3
 O4CTnUIOtRe4QKHo0rl8s7//SUTJbVojJ2aQs=; b=E619rlfI/3J9pKIIh5O2TV
 GRKrfEKv6iuEjWtjFRSy8hC9bqSpoXU9iC7tdixaTVp0whtfETNDYh4u+YKiUUYB
 FZ240Bnr/0ht7dGqR+AyaeKDNKXxk4AtWzLKqiaBJJCss0L5ZCeCAhrlO3PdVMLo
 A9stDkfnvwswHz7FZngDPxA4SJvLTiTm5ue5YTmIVJ1tIFUZ9Wf5A4Jf/LZaRuUM
 ip8V3JSO922Wr96z3G8IDkPnnrXDR6T/z0NW9HS96Z/f67eHrLiC+QafCmi5fsZb
 Zs2Pcor8j7cAmttRJsyg/oAq1NxhUxyYO/7gLZk07kQ6rO7C8KD6r5e/OiC81jdg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhp18h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 13:52:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZbSc2643603
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 13:52:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gtjft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 13:52:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A3DqIwA9961734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 13:52:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E242F2004F
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:52:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 791F420043
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:52:18 +0000 (GMT)
Received: from [9.124.210.158] (unknown [9.124.210.158])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:52:18 +0000 (GMT)
Message-ID: <bab0097c-281b-4c7b-81a4-605ccc7cac91@linux.ibm.com>
Date: Tue, 3 Nov 2026 19:22:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] ppc/spapr: Add RTAS error injection support for
 VFIO EEH
To: qemu-devel@nongnu.org
References: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nJq6XhxcUKNQ9HY7CXNx6VyHo9XM1pon
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX1p6YpGRWIu8v
 g6goTg9crJkxD4xpwXPju8eiNWyTLH94VqxsFnEjMaZ+hCJGcxyFmlfy0P8bmTqjIrZGklNSZNn
 x7cAi23HAOJ1kYDOJGIKyi4ePov2FLU=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae9e715 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=wt1o8H50IsT6fsVrqxAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX4PbmvRmq1828
 Bm0349v+7DMZl2DtUHPcxVpeivoiWkzQqZRE7GH/YXebKL7EyyN/gFsFytCMrGO6r01ceeLujAZ
 UA6a5ImUiRrZkK45HM+cozfEPzRWBiiHLoNRGGHYrk5v954F0DRTIvln7BH2OTnz23Tp5+KDWUX
 8QUDJ4ER6FkcptgQvyMuQzj6Dm+iO7egv9ITM4D52SbMvi97b1xFtcCTLhTbd0naATOuRFzrzWY
 TyozmgLAKZAVcrh/1PHN0BMVI8wUxmP3aJxI7P2UlWlBldkQKrF6LEgjbyAtG80speBuXQhbCHk
 LVp6+CgrXk1qMsnfPDcokU0kDdQ69LBvGpqKaRjpjHi7mBV0mL8dRcGiG3uSVmufd7XRB4eLbXk
 Lh1RX2yHgWSGnYYFx9aiu+ut/OUx9PWF1BvmCzLrowLw8V7g4ZSW2dVUxlgUh+g3NY0tV937R2+
 1Jop6/o7p8XhBW+zo7g==
X-Proofpoint-GUID: nJq6XhxcUKNQ9HY7CXNx6VyHo9XM1pon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=tasmiya@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Greetings,

I have tested this patch on my KVM guest environment. I am able to 
inject EEH errors from host console as well as on guest console using 
location code for a VFIO passthrough device.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>



Thank you
Tasmiya

