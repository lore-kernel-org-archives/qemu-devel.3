Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90971C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrZX-0006rk-Pi; Mon, 03 Aug 2026 08:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqrZV-0006nd-Sd; Mon, 03 Aug 2026 08:15:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqrZU-0008K7-Bf; Mon, 03 Aug 2026 08:15:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LlmWk223089; Mon, 3 Aug 2026 12:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=P1xwtL
 oz6TVf86LrwAGS1FXWJnWdoT4VusDZTnVQFbo=; b=GIs1L8n7zwpka4kiFhO4Pt
 /v8Aw0JVHzYhm8gI2MjWDV9VIUuAMMc0wH6WNrB/7Ihnr0vVbdG3nrCOdS//FE/8
 fHlytu2raUJVTkGX/dU112kfZoB4N3riB76E8CcBYVq4aCQv76vApCA8ooxHUFnU
 JpddxkqrG4K4FkW+ZRSH/nTsZlhTLyi2FkkMQf+xWxyIX8Nklic5NbadxUagP2Q9
 AvauWoZ5PKj5KBHoKCNGa4mtet5ZoGHoyE0TzyNYLCiLd4FW0yPUJrsJqAT4ZZj+
 j408+kRRgCYR8GlEpcbRIUQFwpRWLnoojamFOQwYNRHU18dQY9142Voz9aW7eF1w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3rn2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:15:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBa6Z006620;
 Mon, 3 Aug 2026 12:15:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5272-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:15:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673CF1BZ30409086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 12:15:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DB6920043;
 Mon,  3 Aug 2026 12:15:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1799B20040;
 Mon,  3 Aug 2026 12:15:01 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 12:15:01 +0000 (GMT)
Message-ID: <104bd2bc-e97c-456e-b299-660d34cfb1bd@linux.ibm.com>
Date: Mon, 3 Aug 2026 14:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/s390x: Use op_ld for LOAD REVERSED
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-13-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a708649 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=oiD5hlvI7uZKwdzwUzgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uw014Nj2Dfg4Ru0hYIhRi6j1uQ3Z72Di
X-Proofpoint-GUID: uw014Nj2Dfg4Ru0hYIhRi6j1uQ3Z72Di
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX5XU43WCr79Nj
 G5NMSycpzQ6CuW/sExALP/eWGzzKfru0WeKqIcxywDAcFLchOEofqdpNcG2r0LGd6J2JGOa5VHv
 1DH26e2hB9yX3VAMwDwLEokCEsGIDNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX5zAb3mInr74Y
 8iVt47UiTakT7DjgvEwV2L9zNDKWcgkuSaBXmFof6KkZgJvjSDRe42Xe33y1tv9nczA8KXma8ot
 WD/fFHoJ81O1C35UCnyEYGN0qDscx0lKeeU63jpVp7BFbgjwgI1vP/hBFrJem4mxcVl5Q2ywsN7
 Nsyet/Mv31Kx1u1PYzGVQ/wUvpzx5WD5/TLjFQtzYchV58o1eBBZAA4vEnUciHGhfUdihew2Bky
 OtK+WwlgUJd0+nAbn1MqsaDFbaTvDYMgpYkmuP2bh7MgGfZVAlJKq0j9S20dWFLanZZq3GmYgme
 xtZGe4356XTgHTQCJrdZ5Jxs7Y/yCiwYbmxMQtSKmEivGe4rDzFpp+7NtAJ9e9U34v3uXDxGF1U
 oJk5FPtohWuIW3uxEdZSF6YVb/vvhRrOYgSdyyF8xyV+GIvxsnNbKMPOprEPigvDgT7oZhXyCjc
 jlmOIBeNlsggvDKx/eA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030105
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



On 7/31/26 20:56, Richard Henderson wrote:
> Use the MemOp parameter to op_ld to directly perform a
> little-endian load, rather than a separate byte reverse
> after the load.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



