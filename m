Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE438EB105A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyR4-0008PN-CA; Tue, 10 Mar 2026 10:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzyR2-0008Oe-08; Tue, 10 Mar 2026 10:51:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzyQz-0007bB-Gf; Tue, 10 Mar 2026 10:51:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A7pqtC1274613; Tue, 10 Mar 2026 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=be7FAU
 2bqz/bLbVcm4tWgnRZELqRG+r25LPm00skCyI=; b=hZwBJK2N33GZQB7frLOMz4
 WKQ4kJ4lKl5DWvBGa4xUPw2iUaDN0SuVKTXg7Lp21xHI7rzbgBA6W4a6H+ixB8IC
 e7Qcq/iT2QSLXPkBZH8Nz0M7JS1QbYZTZF1nN8vVXWW72oyfu90Y/P97Zu6xMl58
 i6hvdwSE30kZ9RSL86EyivlsA1e/w0jubpjFjPZsOQUxd+IeVw1kawiYxPHrv7gE
 ZX5u/hRf7ARDjDZMcZO+OOfbcsOIj4nXFbsI6L/JMTQzhKRHQt9AYxXHYmd1vvSg
 GHyuu263l9j2fwTtEhutva85bQvBZCUwrIQihmprj6SW1RXGHXHokxZ8LS68Y5Jg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuybc73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:51:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AAi6mt021181;
 Tue, 10 Mar 2026 14:51:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbssnx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:51:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AEpcRj44695932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 14:51:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3689F20040;
 Tue, 10 Mar 2026 14:51:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C22020049;
 Tue, 10 Mar 2026 14:51:35 +0000 (GMT)
Received: from [9.124.215.249] (unknown [9.124.215.249])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 14:51:34 +0000 (GMT)
Message-ID: <3054d7bd-f4d5-44af-8cde-14d940437f30@linux.ibm.com>
Date: Tue, 10 Mar 2026 20:21:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Implement MPIPL for PowerNV
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
 <abAmBV7g_bGNw0Ax@shivang.upadyay>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <abAmBV7g_bGNw0Ax@shivang.upadyay>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b02fff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=9J9Pf-jHrf-NaEm-wmYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyNiBTYWx0ZWRfX+sKFJO0JLuzi
 5v1DM4jjwkzs8A09/srZDXVCndo1jm9fBscc4h/OVSJQ4FCncAUbbA6+3eFG0jLZYsm+8K2Fh3X
 A6SqJACgclE0I+51tYlaJjKGq+Gx7ALs5feNIInJKAYjWJ5fJvV3A4iHleuZ7DhdXhGQFkd7ev4
 8SB/Y0aD9MdXRyvtAdYfaByqqw1liSeJfNGPH7uvXPR/rYBJQCl1UavzlqHfUhJMDmdfjYXqwIG
 FhvTkUO+FCFtX7RAKCqJYkuv6JD7IDVSU9aJMP7ynQnNMOIpRFCmKewb7hilTJ5fGE+Qv3ReIdc
 FJP0q4MNWrtMkC338AZQSol05FsbCD/oHI6Dpn1zoW4A6AGs9YeWLsJH0IXBgm3pBnSDyr26ZrI
 MPmzhBZQY9mp/4uXINtDu8sjL7v97yR5/xtaGEb6tNJ594HOochrrcBbtyQsygRUso2l3guB5eh
 P+hKR3cA/mV0lRo0wDA==
X-Proofpoint-GUID: bAafq9L4rlN0Mwu847QBd2YqiKkZK2Oh
X-Proofpoint-ORIG-GUID: v-2cTRAzzklpttkk13-u8GMJnvVs5AFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/03/26 19:42, Shivang Upadhyay wrote:
> On Tue, Mar 10, 2026 at 06:16:07PM +0530, Aditya Gupta wrote:
>> <...snip...>
> buildroot fadump test and `make check-functional-ppc64` are passing on V5.
>
> 	Welcome to Buildroot
> 	buildroot login: root
> 	# dmesg | grep fadump
> 	[    0.000000][    T0] opal fadump: Kernel metadata addr: 653902a8
> 	[    0.000000][    T0] fadump: Reserved 768MB of memory at 0x00000035390000 (System RAM: 5120MB)
> 	[    0.000000][    T0] fadump: Initialized [0x36000000, 752MB] cma area from [0x35390000, 768MB] bytes of memory reserved for firmware-assisted dump
> 	[    0.000000][    T0] Kernel command line: console=hvc0 rootwait root=/dev/nvme0n1 fadump=on
> 	[    0.473711][    T1] opal fadump: Registration is successful!
> 	# echo c > /proc/sysrq-trigger
>
> 	<snip />
>
> 	Welcome to Buildroot
> 	buildroot login: root
> 	# ls -alh /proc/vmcore
> 	-r--------    1 root     root        4.3G Mar 10 14:07 /proc/vmcore
> 	#
>
>
> 	> make check-functional-ppc64
> 	<snip />
> 	16/16 func-thorough+func-ppc64-thorough+thorough - qemu:func-ppc64-fadump                OK               65.42s   2 subtests passed
>
> 	Ok:                9
> 	Fail:              0
> 	Skipped:           7
>
>
> Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Thank you for testing this series, shivang !


- Aditya G

>
> ~Shivang.

