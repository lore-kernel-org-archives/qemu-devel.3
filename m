Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB55C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjc47-0006MY-1t; Tue, 14 Jul 2026 08:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc45-0006LL-3i; Tue, 14 Jul 2026 08:16:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc43-0002o3-LA; Tue, 14 Jul 2026 08:16:44 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBgdS51196871; Tue, 14 Jul 2026 12:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/qLONk
 PUmjl9Ki6HC3IUv6hZhgXooLUNlr6AfjCPRmc=; b=pfzSMu0Y54vxUcNQ20E71f
 QNuF9PdJVn3TteYg2TQVKJgFKIMTZBE2B59+MunHfopVGI5xEk6i5KhiLL8wadcH
 lWf3j9I6lNEZJ9nvBMhTJ13T9YT01wloFSS901icYgtzDpYqmceGtKB++2Xqf5j3
 rvCk5ljU3eEh+pkeNJMPHmne7FlQxIdP977fwZWTqB6JrHg1UZEUAa0bXlEBLCIy
 d9N+1w6G447M9ueDl7dtZ/27STEugdPzr4uyBo81+E5R9li3kItco8wMx8+uez5m
 5r2/J/CUmIVB85IrgZeCIgPO9XNkRwVsPhoFOmcR7ezWlFg8wOU0V6MD6X8Uhuxg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnk3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:16:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EC4ePd003061;
 Tue, 14 Jul 2026 12:16:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q2ve5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:16:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECGbLH46793192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:16:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9019D20043;
 Tue, 14 Jul 2026 12:16:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4257020040;
 Tue, 14 Jul 2026 12:16:37 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:16:37 +0000 (GMT)
Message-ID: <57680fd9-2193-4cf8-8cf4-4c191d45f80e@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/51] cpu: Define BreakpointFlags type
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5628a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=6XGGRaPhJGb0HrX91toA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfXySD8NyH0z6Fj
 cFHGZohAp7C20HtScpvClfyN/rfgLH4fpstlXaUPy1QDqVHQ50m+g/0CBHB3YTvkKQ5FvGhoM5l
 UfPDqlZR+fjGGh2LGU6aM7lgKYs9wWFtu7CEA8/K5SauoFRuTYGaq6sK0OeYMBVe6OrBZejA92R
 8QbrEkY1GlYsD+aZo1yC5YvuOZZJXTrzLMd2LhMUJ8u1zLwUVyM1XG6kOQIrHyr2bjBXU2w0hH9
 jj2f8cUg5bH42XO8lpJw5ERD/Kc9xpqbBUtDRJCY4El7r6qEosxxGcDrmllOzhzUYDego6JUqqu
 nNGDVIsI886h6AMhE1ywuJTnQDBFGqRREPNwphU43miSQsf7cSftUbzGwn1Tznf+84Z7d3Mp/4v
 HqGsqtxMWpxwpUeV+9EXO5fxr5Og+Dct1gyc/Qo0X0tRbX+Ia1CdqGvkmFjI/EAeHQZ7umaApNK
 2qRtNQFYDzgjklS9+GA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX93L3WaUTTMzf
 1BKuSi/qiOyvoGejwOljE8+eibFSpzUl9V5OvurHULUZhN18D53od7lNULb70qoEDcXo9hq+VcO
 Aw9nIIXMj9TPC9fpIHA2useQtM0Fj2E=
X-Proofpoint-GUID: WCR0GtaBdGrn5o-mlI0gXFrpd2CoGFWG
X-Proofpoint-ORIG-GUID: 0gt0PVvgtPpCam2Ft-Ceanm8q36w3Y9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Use the BreakpointFlags typedef to better follow when
> we deal with breakpoint flags (BP_*).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Don't rename mask variables to flags]
> Message-ID: <20260630220100.1289-19-philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h |  6 ++++--
>   include/exec/breakpoint.h   |  4 +++-
>   include/exec/watchpoint.h   |  8 +++++---
>   include/hw/core/cpu.h       |  8 ++++----
>   accel/tcg/cputlb.c          | 12 +++++++-----
>   accel/tcg/tcg-accel-ops.c   | 10 +++++-----
>   accel/tcg/user-exec-stub.c  | 11 ++++++-----
>   accel/tcg/watchpoint.c      |  9 +++++----
>   cpu-common.c                |  8 ++++----
>   system/watchpoint.c         |  6 +++---
>   target/arm/tcg/debug.c      |  4 ++--
>   target/arm/tcg/mte_helper.c |  3 ++-
>   target/ppc/cpu.c            |  2 +-
>   target/ppc/kvm.c            |  5 +++--
>   target/riscv/cpu_helper.c   |  2 +-
>   target/riscv/debug.c        |  6 +++---
>   target/s390x/tcg/debug.c    |  3 ++-
>   target/xtensa/dbg_helper.c  |  2 +-
>   18 files changed, 61 insertions(+), 48 deletions(-)

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>


