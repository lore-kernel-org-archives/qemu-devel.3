Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D637BC44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTJ0-0003iL-O4; Thu, 16 Jul 2026 17:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTIz-0003hs-0s; Thu, 16 Jul 2026 17:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTIx-00027F-CQ; Thu, 16 Jul 2026 17:07:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKC25N2320899; Thu, 16 Jul 2026 21:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=S3VYnm
 aXIHXaWn88Q9VNxXFeKZbq8YvHf341r1PPFao=; b=deCirSMXRCxzB9ekCuLQn7
 zC0Cy8MUHNfpVZXJWsBT4spIaBDKIMJnLNnbli8qilGLvYvv0rS0JjiBfRUbiTk1
 t+piXiFUUNktEhZWmQXPGwkrW/rZh8whi3vbxKIRxnh1vK5KV73oTvo27qo53F12
 J8eK0IvyImmbwjcrtQd3KoK5BIRbDsmnzKMs/6viIfIwpW90EkyyDg5e19mifLZi
 WD4n8SUGmgK8FRNTPd8/4qk7NNeyc9+BZDVvElgEuFyrF9XXJT2n92gg/Sfz1Kt4
 kxH0mL2yLl8e1FVWvKxtoMW0WJgYjnjEThtEAT/fh4xrddRvFD17HSHmVPFsQ2cQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33kn25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:07:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GL4b5N016346;
 Thu, 16 Jul 2026 21:07:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k6thw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:07:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GL7W8o49676686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 21:07:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 358E020043;
 Thu, 16 Jul 2026 21:07:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7816620040;
 Thu, 16 Jul 2026 21:07:31 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 21:07:31 +0000 (GMT)
Message-ID: <4bf52b08-b835-496b-a90e-fe9a597b0cd2@linux.ibm.com>
Date: Thu, 16 Jul 2026 23:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/51] exec/breakpoint: Return the new wp from
 cpu_watchpoint_insert
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-22-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX3a4ewpbYJj04
 f1A1bXusZCj7Q96eOaDTVVCpAiJ9VlrpUDrpiJL59WyAYybkzLW+9S908WsT+P77NztfSZW2QVi
 75Q+oqB8gqYOnN4Z4+CupWgf2dyuCL8=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a594817 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=iEHWvvDq4-ptc5kxTzQA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: b_FDPyRgQQDhaiP9PnnqrRkFan185wAO
X-Proofpoint-ORIG-GUID: SLo9WSkeY1RgG0k9scm7WjFUJ_8gsJj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX1p61ouNT2EX4
 uhmLlQbU0JSraSmCwhtceVkQBEqtHfIpTzVygcd0IBZG7TvD4ZNyBF/ltzfHQRnUCT5V8Qy+AeA
 99mjO5K4tkneIaUVZnkF5o7bU40pRDsM6PNB7+34HvL18utkPTUwlPSJL9wZ5G1uMZ4m2zQTIQV
 BXR0TIIGpwtPPua+5WskkGX5NUaehyRY77X0bAmGEEnUbYbHT162ucLYqwb7OLL8nsZjJraY6MM
 cCRzrili6bPocpRgruQbmW8EODcir2/vT/72LUPny64faYwz6OSPSC4Drse59vAlvpd/nGLkli7
 DsVjX/GI4IXlPC5qbL0W7M29ZyJetY7+QqT6f7yE6ycCKY5AC0vI4dXr58FGknoz+IRptn3pcar
 pBTXBlZsriamiv4G2YQZqndgB3d3dvQ2/KWr3+J6siolKZRIU7wUIDrY5YdxfSKmW18ApjOTipY
 wHJczDbpI1bOVoPO9BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160211
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
> The cpu_watchpoint_insert function cannot fail, so the error
> return value isn't actually used.  Instead of returning the
> new watchpoint by reference, return it directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  5 ++---
>   accel/tcg/tcg-accel-ops.c           |  9 ++-------
>   accel/tcg/user-exec-stub.c          |  7 +++----
>   system/watchpoint.c                 | 11 +++--------
>   target/arm/tcg/debug.c              |  4 ++--
>   target/i386/tcg/system/bpt_helper.c | 20 ++++++++------------
>   target/ppc/cpu.c                    |  4 ++--
>   target/riscv/debug.c                | 28 +++++++++-------------------
>   target/s390x/tcg/debug.c            | 10 +++++-----
>   target/xtensa/dbg_helper.c          | 10 +++-------
>   10 files changed, 39 insertions(+), 69 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



