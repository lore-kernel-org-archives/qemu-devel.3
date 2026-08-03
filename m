Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85970C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr9D-0007lc-3g; Mon, 03 Aug 2026 07:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr9B-0007lO-5R; Mon, 03 Aug 2026 07:47:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr99-0003lr-MG; Mon, 03 Aug 2026 07:47:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LmVNn169288; Mon, 3 Aug 2026 11:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T8HADt
 q0fSPe6Qcj7AvVAR1p1zlD3rWd6t2I9FOlqRk=; b=Ln+WfrRb4NvBNbsudM9+j/
 QjFFyhKWoKdnHAewhe6Njys+BKofMo4SLvKKD1mhUyoxDYIgxIF3z4AuIakkm4zo
 /sjhEHdycQ0iTr4I1T2QAzoA76pfSc43TRPpucih0O2rtgak8Bd0Zw+atwZKnvs5
 1zTyC6//FD3sOpd4xC6/ERWMiI858fvWWptfev0tl+KeQILJHs3TsM0e2QCep0YZ
 cbWI9YLTGhV79g9wl15fUmPv+aIQU8qlWR/9YHQK0/3CwIXf8+Xj+kBSD+0l3fOZ
 +NmzhufwSScFZWu2rAn8vpvtMqw4JCMcKubUL5K9kK9uLGW6BGGmnYtgmV3E+wiQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0bta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:47:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BfFra006932;
 Mon, 3 Aug 2026 11:47:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jw662-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:47:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673Blpjg43188608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:47:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 277EF20040;
 Mon,  3 Aug 2026 11:47:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F004D20043;
 Mon,  3 Aug 2026 11:47:50 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:47:50 +0000 (GMT)
Message-ID: <7448b481-30b3-4b92-b276-6a6d9f22973d@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] target/s390x: Convert op_st32 to op_st
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-11-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX2nGzTDPFZzKQ
 m7EeaK91DoYzXnTuXvOQfrsWO+UashivPVfZRlx1KJoFr+oEVK+PBoc5mNmdRyKGaCZIChuj0K4
 DhcAclXgv4p0aQj9Q1Kc1GlLRgKaVMA6nd0OU/hGGUiBtRjpgtEIJv+DOykQnk67thc06RXnx5t
 6Bj87IpsW9vTMJEFQeQtJBota1UsV9i444jSDrgCjgBMQK8ELNRmgf546Ymm6iISumffZEUYmt/
 odgbF3A4N1RSPWej69uqLYSRbBj9qU14MncrkaZ6MLe4+QmvM+CSx2eZD6/owiDm0jyCuThO24u
 ODys+dAuBWvBBDFR3aOC52Knl8xg+EKXERFuRwlvqXyEf6NJA0uvZsMFcyhwH7vNZObDALLQBXc
 VTp+q0y++ZgS0Szei1gAmMNnyWWapKc930BuTy8psc/VvrkmvEN/qEWlAZZPE+EmnoPNgawm9Ln
 L9Nk1VTp3kxppj39J/w==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a707fea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=mEGLa8EhC7ux-r8M_m0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FldhabKUZm5FzveMcRXIdOnei74qKuMQ
X-Proofpoint-ORIG-GUID: FldhabKUZm5FzveMcRXIdOnei74qKuMQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX9oSrokrOAVFM
 OKN6Z9dw9b/q6622axXIY8SLn+eSqgWTUctan9t3Dg/bdfp0h723gB0I0BRGTTcGdjMqmbdBSFY
 L31oPmwTcE7eTtfz5qnNwWcdxExpJkY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030105
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



On 7/31/26 20:56, Richard Henderson wrote:
> Note that op_st32 already or'd in insn->data, with the only use
> being MO_ALIGN.  We now put the entire MemOp in insn->data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  7 -------
>   target/s390x/tcg/insn-data.h.inc | 12 ++++++------
>   2 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



