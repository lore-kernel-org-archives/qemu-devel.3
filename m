Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43113D29C2D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq1E-0001nO-VA; Mon, 19 Jan 2026 09:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjrT-0008S5-JL; Mon, 19 Jan 2026 02:39:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjrR-00017N-Tg; Mon, 19 Jan 2026 02:39:43 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60ILHRvg025199;
 Mon, 19 Jan 2026 07:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ueK27K
 jA/FMl/+8YSWPfz45Jrk87OQGu4nqPmBzNIvM=; b=mc+gP9LJHNlRbYZKJiiNf6
 Okdp00Eriha6m1qsQbiIUJ8E89xJPZ2z17Tr6JeixB9v2wh1zbalFyFY/dlt/um8
 RFmJI6EaGU03y9K3a+vVQLtHe9ZGzdkEz3v/fgfOkVEmuYe8t2UaxbS3IFnL7GtY
 Zj1AmxVL3H/lG+7A6cFjIxcJ8phYLWG216XAHx+9nkn4EUWVwTH6CWfwumefR0QW
 U8SqHna5TD308B3RQkh/YKuYPLcpZ8rKdRgPgU7nTEveFZYw+NyYfwnE88qpnIXH
 YDV7hdYbdPNKXfPquctKhYBcZAFsh/7b/2Z4CLP3niRQrf820JxAnZcRLdj5QzsA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rq0dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:39:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6ct26016611;
 Mon, 19 Jan 2026 07:39:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xnhxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:39:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7dYBs25231686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:39:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB93020049;
 Mon, 19 Jan 2026 07:39:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A023C20040;
 Mon, 19 Jan 2026 07:39:33 +0000 (GMT)
Received: from [9.43.98.125] (unknown [9.43.98.125])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 07:39:33 +0000 (GMT)
Message-ID: <7c6031bb-14ab-4c9b-82cc-5a0b67c6d02e@linux.ibm.com>
Date: Mon, 19 Jan 2026 13:09:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Implement MPIPL for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -yl1uIlk_FlGkUf3j3_97R1_pBUdMSoa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OSBTYWx0ZWRfX2665eGnEKevR
 Pb+8cH8LzGO5AFl5Q6kOwSW7zd7Tf7mg/1Y9vjvgwUd+ueaxpqC+C+Dot5k/EWVPQC8EsWoehMt
 fj1XuryWlHDehYkzfDWArPcOtW7Wijw3/4h6GwxOz2I2TKUmLVwSzNZbvDBvxzE94fr4czHQ3Za
 oOBih1Z2r29F8a9u3YlMl0LiQ/meygOTKPhyuSG31hOK1PWo2Iswxh+7Ztw2keEqhAAAb6LKp98
 lyxfBInqLSZRD5Mmaeq35ruDusC+8lvNdxYIqQNT8+buv9nkU2arYLvpDSinMiqSHY1Xz91bDMo
 yMC3hsjbhjV5SKGYlsrRl0/cwLwZdd7uwZPkuLU38BCf3B7gtm4hqZQTBq8Fsa7GY3//J0llGw7
 eWm0pDrtt4Pq1edx4wcbbCQ5QT4oLKKRKzJhnzZ060tRZ7gE7Nd2ZNeY6DKubdDpvjscW0XoqA7
 +YJerFES5zHjde+17lA==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696ddfbc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wKXm-OcLlGojyDf9JHMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -yl1uIlk_FlGkUf3j3_97R1_pBUdMSoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190059
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=hbathini@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jan 2026 09:14:03 -0500
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



On 06/12/25 11:26 am, Aditya Gupta wrote:
> Overview
> =========
> 
> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
> in QEMU.
> 
> Note: It's okay if this isn't merged as there might be less users. Sending
> for archieval purpose, as the patches can be referred for how fadump/mpipl
> can be implemented in baremetal/PowerNV/any other arch QEMU.
> 
> Fadump is an alternative dump mechanism to kdump, in which we the firmware
> does a memory preserving boot, and the second/crashkernel is booted fresh
> like a normal system reset, instead of the crashed kernel loading the
> second/crashkernel in case of kdump.
> 
> MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
> preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
> Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)
> 
> For implementing in baremetal/powernv QEMU, we need to export a
> "ibm,opal/dump" node in the device tree, to tell the kernel we support
> MPIPL
> 
> Once kernel sees the support, and "fadump=on" is passed on commandline,
> kernel will register memory regions to preserve with Skiboot.
> 
> Kernel sends these data using OPAL calls, after which skiboot/opal saves
> the memory region details to MDST and MDDT tables (S-source, D-destination)
> 
> Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
> along with OPAL's relocated base address.
> 
> SBE then stops all core clocks, and only does particular ISteps for a
> memory preserving boot.
> 
> Then, hostboot comes up, and with help of the relocated base address, it
> accesses MDST & MDDT tables (S-source and D-destination), and preserves the
> memory regions according to the data in these tables.
> And after preserving, it writes the preserved memory region details to MDRT
> tables (R-Result), for the kernel to know where/whether a memory region is
> preserved.
> 

> Both SBE's and hostboot responsiblities have in implemented in the SBE code
> in QEMU.

s/have in implemented/are implemented/

