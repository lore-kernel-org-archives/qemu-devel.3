Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7F5C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyaD1-0006NI-3j; Mon, 24 Aug 2026 15:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyaCx-0006MW-Jb; Mon, 24 Aug 2026 15:19:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyaCv-0005UD-LJ; Mon, 24 Aug 2026 15:19:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OG1p8a2260570; Mon, 24 Aug 2026 19:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5EFOqh
 mQwn+vW2Ws3PclB4K25BhWcXhzLTc/REQ9WCE=; b=mhHWZ+ycYnOcBJ7dtbCOSP
 6wg5tiRM9z7UeyREr36b6y7qKHAmAXs4vpKH6yiNqptEBOIxootVgsCevvh2jv/P
 TGZCmF3eR0/W09JF/xMiKSJGQyn2EikWg+gKwQqDYBrUbC0EdFJIW/vQzJrO4oR0
 N6ht94/mV35L3ixYxCiFi1S6FQZP1O3wtP/MwXzW2WCKR/KOjIXO0R6TJdjSQICJ
 THul3wFRdeIVTEtuCTB3X3xA4LRZ/LpS6wdSWGDyS4eJvIVMRnA0KOaQ5hsueFVg
 004NeCa5LEi9K7HXuvHZl9Tx87mSf0/t6ZUpw2jLUcVBe8wq26KlbxAhGxmaIASw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hkv0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 19:19:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJBKfY025499;
 Mon, 24 Aug 2026 19:19:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgyy12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 19:19:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OJJemU22151906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 19:19:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A70558056;
 Mon, 24 Aug 2026 19:19:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2580A58064;
 Mon, 24 Aug 2026 19:19:40 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 19:19:40 +0000 (GMT)
Message-ID: <0875272c-0095-47bc-b7d2-d5793f270816@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:19:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: Replace straggling CS_ARCH_SYSZ
To: Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260824143033.306201-1-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260824143033.306201-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2MSBTYWx0ZWRfX/qBdxp02fW1a
 7TXELaalN60dSy0guH28LLeXMJ9tUfKrWwdQt2qoxU65tY5By4UY0JrIIdiLCAZFuTzczSXKE8k
 GL+d3sQCJuvA2oUq9dCF8ugVgjYqZA8=
X-Proofpoint-GUID: DxXPpwlYUVgFWyMKjaafqo4c63Yud6Kx
X-Proofpoint-ORIG-GUID: DxXPpwlYUVgFWyMKjaafqo4c63Yud6Kx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2MSBTYWx0ZWRfXxd+oEIcR0BR6
 grhfoiwB2RPtQlMWFtj4uPhV9Ny7vJN2p3V90Z709Uff8B1O5BBnIMEP5L96aM5yc8YsGTIzSrO
 dtDrIarHstU8QX0xvOFtblk1AKAwyEENhn7iMr9l1T1G4igYaLd6WvzYWok6n2f30SD9W/Lq4sU
 U4qOmYFJkoKzmInTqLoxNsGdsPRdu5hgPNlkQbFAot36QD1l6AmpGZYryCN8q76uJk0vcxC/lct
 HJpV3vEpkqhSEjU9mwxOQTfz7QctlAHk9N3eoiNxuHA5yCpxtU5cTe6TwL29JKnRt92jWkRVicF
 xtExMxgB6lztY7rM7XZZU0c4srQe5eRqz8i8ucsQ8O5ZodtAW7NT8sCP0jVkWieEykaTAB5BGgb
 MQKDNMPTY2fyZbwjuYkm4/qQ0oqBICbzGq1TTGGeGT5T2flkctOLXJ4DFGkug+i0oIS+icgbJEZ
 GBkrOaAhEIhcbuKXZzw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c994e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-DuG6ggHnZLhH3crdFAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240161
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

On 8/24/26 10:30 AM, Eric Farman wrote:
> When updating to capstone v6, the define CS_ARCH_SYSZ was replaced
> with CS_ARCH_SYSTEMZ, except here. On systems without capstone-devel
> installed, this causes a compile error:
> 
>   ../disas/disas-host.c: In function ‘initialize_debug_host’:
>   ../disas/disas-host.c:78:24: error: ‘CS_ARCH_SYSZ’ undeclared (first use in this function); did you mean ‘CS_ARCH_SH’?
>      78 |     s->info.cap_arch = CS_ARCH_SYSZ;
>         |                        ^~~~~~~~~~~~
>         |                        CS_ARCH_SH
>   ../disas/disas-host.c:78:24: note: each undeclared identifier is reported only once for each function it appears in
> 
> Rather than making capstone required, replace the constant
> with the same one used elsewhere after that change.
> 
> Fixes: c8220a096f ("target/s390x: Update capstone disassembly to v6")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Thanks Eric, I just noticed the same compile error and this resolved it
for me.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


