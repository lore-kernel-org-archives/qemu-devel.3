Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB38C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkRYn-00087i-23; Thu, 16 Jul 2026 15:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkRYf-000874-MW; Thu, 16 Jul 2026 15:15:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkRYe-0002wY-3B; Thu, 16 Jul 2026 15:15:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGfgQU1866377; Thu, 16 Jul 2026 19:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a80xvK
 9d6/ju6B5AWXLPGgfZ/NyCqxGjyY4/VoYVdyU=; b=ngtdT8z0mtE1hvpJrvbXYZ
 6RmwlScTQ9jJ+RNvei4i7fkAipnHFhjpcqyqvH+TORH+Rveb/1g67a7Uu7fWEyj3
 /gNjxTSPo/f+M7eZv7q6Demj1KYcbDiv7g3Up+ALLO3LCxO3WseylFuyO0T/mEUI
 TIav47hMp5XK/zVt4Xgf20ucep4dRPrMAkpjQgHSLrVYWrNXGdvnGrrs/MlttXRm
 lYuxch9c7IxqFovzZMym3R2v+ERkfE8CGa+QQH68wI26L/K4F4uKEyaB5iCJkDdZ
 +Fb9RkmAUB4Owoqsf2KjuIb1nsaSIuJ97tb3E0xD1kec1vHsvw2FjkWuPPTun1MQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33k6s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 19:15:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GJ4Z3a007615;
 Thu, 16 Jul 2026 19:15:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgp9um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 19:15:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GJFb2K50725246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 19:15:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51EA12004B;
 Thu, 16 Jul 2026 19:15:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3AB520040;
 Thu, 16 Jul 2026 19:15:36 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 19:15:36 +0000 (GMT)
Message-ID: <ae8f8721-d447-42f3-be67-43f439c76261@linux.ibm.com>
Date: Thu, 16 Jul 2026 21:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/51] exec/breakpoint: Return the new bp from
 cpu_breakpoint_insert
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-20-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX7cs3jTypI7Rt
 TXcrNC2bd6Z95f1zP8qAUbPXYbK6HihTxshLcK9bglfJJ2vqlhi+7Wo2uz77n+sbB8bUQsHkG+B
 5kZJ5YqTDHXl0YP9gGC2EJBXOrHcc+I=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a592ddc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=b7RqGuJXx8hbMOLXtX8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JKaWobGa-kS5ca_r9gkjjEMPhw3d-2TJ
X-Proofpoint-ORIG-GUID: vXoYUPucEP7mfemI6xT0AbzUSLlNTTRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX16XKNhSeBUAY
 eOoJ4VlrsTy0yMcBcsQqicoZ0Tp244OSaOC3NUierEHIiUy3LqrZ/dTq0rFUyqdKFPstczwu9DM
 DDiinU8DUpaE+u6D81/iT9sABrr+/P5BJutiOaq5Scm4IN4dBhQcy5/VWGKJGArmrv6Et3zjtKE
 wEJRBNZiNPxMsNVhtHNaj9AIhAwbOldXhSprInlUaQw+PtGLwdIUcMhX9KR5J1ZrxB7gtIJsApJ
 OmypLtWw3wh/WpztVcXb0k3+oiFcbwvbKCvkD8tiLxGXsz/oT4cUSYwWbgkOihjhEHx17AsnYAe
 HpN82Zd6JyWHfX+xV5QT6qNRgLRSU4/9ggBf0tXJB8QkMFiKW8O3olOPpf5eLwA5uCbsCmG8gI4
 K7FbT2QgMuC3u2nABYl15cJI8p7YNnVaLtGMiRXfwRbVP0rj6KyVG/eUZ5d5mmRjPOub48lGSl4
 M6TsiTFmb2LnIFVZI+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160197
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> The cpu_breakpoint_insert function cannot fail, so the error
> return value isn't actually used.  Instead of returning the
> new breakpoint by reference, return it directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  4 ++--
>   accel/tcg/tcg-accel-ops.c           |  7 ++-----
>   cpu-common.c                        | 11 +++--------
>   gdbstub/user.c                      |  8 ++------
>   linux-user/main.c                   |  2 +-
>   target/arm/tcg/debug.c              |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  3 +--
>   target/ppc/cpu.c                    |  2 +-
>   target/riscv/debug.c                |  5 ++---
>   target/xtensa/dbg_helper.c          |  6 +++---
>   10 files changed, 18 insertions(+), 32 deletions(-)

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>


