Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1669CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQX9y-0001kk-JO; Fri, 22 May 2026 17:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQX9w-0001k4-Py; Fri, 22 May 2026 17:11:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQX9v-0002W0-3N; Fri, 22 May 2026 17:11:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MFSFxT1853987; Fri, 22 May 2026 21:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QB9EIF
 viCpK3Rb39qeW/20HAoH2ZhjDdEFDtnEw0HBk=; b=Jf1rzs/bZMiC24OKA3TJ8u
 d2cKtJxdW64YncThB2y4an/4LyocqcyRlfYvYk7HSAD0zzLgwy95xFl7tbEg3TUC
 qjIgfycIWOPFYO8s8G6bzkT/eiF88AUQAKtOdtwQ2FJEsq5axHASb792+NBBs6NP
 1HQKhW+WJMWm8ZjYXD+oybCo3VYgeCYRhj5huAZ+86BBXA81YkDtYrEHEpOIsavH
 2PWfkwkKPnYTr28O8mJd8PHBYLNCrEGptct3sBotBtMSMEa8WzG2FfWMKojPpf7F
 LTWL2fasU7NeK5f9SSPdwyFogEWVv29AC1d70tFUUBK7lXvHrWupcJVAkvxJjIoQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8v9aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 21:11:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ML9AYF022205;
 Fri, 22 May 2026 21:11:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739wassy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 21:11:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MLBlSo56492502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 21:11:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFE8720040;
 Fri, 22 May 2026 21:11:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AD2020043;
 Fri, 22 May 2026 21:11:44 +0000 (GMT)
Received: from [9.124.217.149] (unknown [9.124.217.149])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 21:11:44 +0000 (GMT)
Message-ID: <f5738174-6b83-491e-9709-6286560ccba9@linux.ibm.com>
Date: Sat, 23 May 2026 02:40:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>, Shivang Upadhyay
 <shivangu@linux.ibm.com>, Misbah Anjum N <misanjum@linux.ibm.com>
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
 <20260522164309.470506c2-b8-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260522164309.470506c2-b8-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMCBTYWx0ZWRfX9X7E770lGPqD
 UcjTrFQ11DNrjuiJ8wo8ezfD65ruIxtqcb805RsKmn/77BKum+ZMIe1y02QYNO5YUN3WLJWzAKF
 drYN2W1jER5e65qsKDQHc1kYfBpg0pcZ0gkhdOIZSR3QDHNMqUfBYh0gKgZlB1VVxU0pTwbtOD0
 ZZRtR0XFHXPu/pkfidytiGvG9LgZ/5/aaBAO+tgUJV4fD/WzQzSNh0ZLJXnT257OVhTt+FxihA5
 13vZ59nkLIfor3K9BV2GItUeKC5p8UvnnSBa6MpCDiiKkWnFop3N3Vh3aaHa8xTAH0we/ICs3WA
 2xwOFHZ/YtAuxDXvHPL0wT8FdK7qB3RaH7P5kQ9ZTHRLZxOVFbdOmaYjA6oZVM4aG+PKKl/cvat
 6DnSk12LKkzE296GaAwce5/Y4HBNp/moMJgXkyn2rYLfU6ikiU+Qgy1m3MBkLZeLLoBBN/BiuJn
 N+1LnmKJp7WyTWGc8yw==
X-Proofpoint-GUID: QjH5bwHCw4huOHnqHrxp7V_HU-1Vb_Ir
X-Proofpoint-ORIG-GUID: SJmcGz_dY3McohOKq3OuWtLmO9S6KqnV
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a10c697 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=wpjxc1-X7eD2FNGAARAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220210
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


On 22/05/26 16:59, Amit Machhiwal wrote:
> Hi Aditya,
>
> Thanks for the patches.
>
> On 2026/05/22 01:38 AM, Aditya Gupta wrote:
>> Overview
>> ========
>>
>> Power11 is the newest supported Power processor merged last year.
>> Make it the default processor for PSeries and PowerNV.
> I gave the patches a try and I see the default CPU without the patches is
> Power10 while with the patches, the default CPU becomes as Power11.
>
> PowerNV:
> ========
>    Without the patches:
>    --------------------
>    # cat /proc/cpuinfo
>    processor	: 0
>    cpu		: POWER10, altivec supported
>    clock		: 3800.000000MHz
>    revision	: 2.0 (pvr 0080 1200)
>
>    timebase	: 512000000
>    platform	: PowerNV
>    model		: IBM PowerNV (emulated by qemu)
>    machine	: PowerNV IBM PowerNV (emulated by qemu)
>    firmware	: OPAL
>    MMU		: Radix
>
>    With the patches:
>    -----------------
>    # cat /proc/cpuinfo
>    processor	: 0
>    cpu		: Power11, altivec supported
>    clock		: 3800.000000MHz
>    revision	: 18.0 (pvr 0082 1200)
>
>    platform	: PowerNV
>    model		: IBM PowerNV (emulated by qemu)
>    machine	: PowerNV IBM PowerNV (emulated by qemu)
>    firmware	: OPAL
>    MMU		: Radix
>
> pSeries:
> ========
>
>    Without the patches:
>    --------------------
>    # cat /proc/cpuinfo
>    processor	: 0
>    cpu		: POWER10 (architected), altivec supported
>    clock		: 1000.000000MHz
>    revision	: 2.0 (pvr 0080 1200)
>
>    timebase	: 512000000
>    platform	: pSeries
>    model		: IBM pSeries (emulated by qemu)
>    machine	: CHRP IBM pSeries (emulated by qemu)
>    MMU		: Radix
>
>    With the patches:
>    -----------------
>    # cat /proc/cpuinfo
>    processor	: 0
>    cpu		: Power11 (architected), altivec supported
>    clock		: 1000.000000MHz
>    revision	: 18.0 (pvr 0082 1200)
>
>    timebase	: 512000000
>    platform	: pSeries
>    model		: IBM pSeries (emulated by qemu)
>    machine	: CHRP IBM pSeries (emulated by qemu)
>    MMU		: Radix
>
> Also, the changes look good to me. Hence:
>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Tested-by: Amit Machhiwal <amachihw@linux.ibm.com>

Thanks for the tags, Amit !



