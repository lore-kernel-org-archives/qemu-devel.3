Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51866C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqraT-00073q-27; Mon, 03 Aug 2026 08:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqraL-000704-Th; Mon, 03 Aug 2026 08:16:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqraK-0008Or-GM; Mon, 03 Aug 2026 08:16:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LmUL4161465; Mon, 3 Aug 2026 12:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VsRZKI
 oK3YoS7mE+Cc/j09KeX6VZJ4aFp5Y9ni3boo0=; b=m4uGfsmwT9qHue/WES5BrJ
 y5jfUCRbKsN+/LDTpvC7weTO/B98WzL8vm1N0CXjeB+4DBQGqQ52JX3cyQrljcIl
 OdAqR4UFbTf3N5zyhR/KF+cABkh9DUqLwSQArmJLWw2a2u+6WtdHqTKqrl5P3Tw5
 p/gF8YIcJSUik/LE2b2hqzzDceW+KR4ZHYiG4t7XOY+xcLnQ3PjkJVIVrqXSLxZF
 hW2pthlSw5Oot1BWWYtF4UMrxTHUhoZEPnXf6PCaznCWaGhE+5B7+QTO2IpKe1fu
 54rcnhuwHCVaZfFKWWF59UxKaOXCWIbcxzwzFKNfaprKQmoA12bohAiaN5wOEuZw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgksk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:15:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBoe7010622;
 Mon, 3 Aug 2026 12:15:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jw95a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:15:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673CFu5J32506114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 12:15:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFEFF20043;
 Mon,  3 Aug 2026 12:15:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B64C920040;
 Mon,  3 Aug 2026 12:15:55 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 12:15:55 +0000 (GMT)
Message-ID: <9a790d8e-2cd8-4d6c-ba32-f4f8b7ec45e2@linux.ibm.com>
Date: Mon, 3 Aug 2026 14:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] target/s390x: Use op_st for STORE REVERSED
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-14-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX9tB1Mu1oSPny
 1cjrefQrifRKoOvFF35MWqXay7YpMrGtHaD2yxa49AkZSYpz2YY5ThxlSwWkS5t78RWgwjpJwR4
 LbfzLYj6ERAvkZfNOXinU6bz3Nlv5WM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70867e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=965bf6Zyv5OtCLSX6VYA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX71/+WgwwMvPc
 GpTkUT6KZB+7NNgKdr3DSZRP3u4U13qyy/PFCqharQyzgutPizXBBeXFdHp0JF6nG3pkamI/yCY
 LNUIUdefyT3qjvltxw+pc5uWHstuIL+IXjZ1aKcMqvnuyem/OxOsDsLuL7U2yZVJ0etSUwDmOEg
 l0dFDVeby/OgNlfKEb6dfCGmV6U0OyWkKZL0H9e+hy8aTq3kTQS8QW5Nphc7dWw1bZP9pXrjLvm
 SZeI7JKL+X670JJ6jGyP2eZrJl0Hne11BowMZA4yhwkH69HwvIMmJ5nBYZu4LoFyo7nMiXiSADY
 BtI1LrGg7IZRdvTnK+l+b8VhAZqbF9UiBtIIi1LkU1Rmuektkkz7Z+PhHdHTawHZZtZW7rDsbvV
 C3efdukELJX2IxprTwoZbclu0oCJNe+g8QJzkOO3t/fA/+ZlYgb1IfjJOOPqTxnvxnY0vc4OTF/
 G1redQPiLRkN8E/72vw==
X-Proofpoint-ORIG-GUID: BcZJrPQlFlkxyv8VcfbXA_4nhc00U09S
X-Proofpoint-GUID: BcZJrPQlFlkxyv8VcfbXA_4nhc00U09S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
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
> Use the MemOp parameter to op_st to directly perform a
> little-endian store, rather than a separate byte reverse
> before the store.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 13 -------------
>   target/s390x/tcg/insn-data.h.inc |  6 +++---
>   2 files changed, 3 insertions(+), 16 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


