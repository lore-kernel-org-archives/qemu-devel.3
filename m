Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B4C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr66-0005HX-I3; Mon, 03 Aug 2026 07:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr61-0005G5-Kt; Mon, 03 Aug 2026 07:44:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr60-0003E5-7i; Mon, 03 Aug 2026 07:44:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672Lm6f9291369; Mon, 3 Aug 2026 11:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vM33H1
 wjiDzEV9vdj6tDugIP2bkqLFB6mjeJe4d7Nos=; b=RYsOvMnLnKeUT2We8WW/Pg
 CfwVrPEZcCTq/zBLCzJ6jJdVdFvFSUOzGVplSqlKF/ZP5mZlWFiJIfrgUu/yoWAS
 f7FOIQusgWmgkvlSSThac5uhNjcsHJHH0VSXplkjrP4yULbGbkjQSvmF+X6zZ05H
 eg9MAKZsl5m9zfvTusLX1fqpeMlTicJVOtlqfxoqlgPERbbYpvZtsn3bzElRZmRv
 Q3ZLU93kC4dOsuFAYVxYu+iBzM9F7Tf8rA7TJXMEbBYvFwiPr7yaxNNlW3eNNwSU
 oY/gyInlX99hYxV0J9tNVGiE8jcfwMTedNpqa7rBTpOaCmmDxj+ctjeO1ZDirvOw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eug5g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:44:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BfIxF012664;
 Mon, 3 Aug 2026 11:44:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvw88k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:44:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BiZsQ33882424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:44:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4FC42004B;
 Mon,  3 Aug 2026 11:44:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B9DD20043;
 Mon,  3 Aug 2026 11:44:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:44:35 +0000 (GMT)
Message-ID: <e7d51408-997d-4e69-a7eb-3f6d006e98bd@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] target/s390x: Convert op_ld32u to op_ld
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sXQINXMTvRptA4cIpas_YqGnTpE4sWdH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfXwCoAWhKi9hao
 6r58AkR7/96mvghz7TBJ+0lm4kk/NUoLNgfLd/PEG4bS1bQ7+TXJEVYoGW18agagBqRNQ5tmX5g
 4udKYTT+2KgVfcgWZtSD2ddmsFXpBxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX7ta9a+NSl/Ab
 BV7zH05uERe9wMlqdow9Au47V9e7LwmRGmmsWTNjOpRh+DsmN9f0n+yyr/X/8p5l1cmsl/92V0l
 LYtqxQ/dTSoZizNeZYnsj0nT3kIKzi0LcmN7ZwcMZYIN33IdbXWum/4o+VFzpTdhgELMAvP87kP
 O6m2cPw68jK0SBCcodpClOtbBerOjBOTa5Isbq+PkxZODTJD1EvtSSZQdRKp9F3thffjGWsZJ5I
 t+XpoBf4nf64FBa4rSk3I1ocnCE8l8l32MALShQTEFI/Ky7pyz7ThgROs/TOp879SyyV5HBmgS6
 Cb5n1/d2eHwuOl7yA8hM626SUC/0L1Z0/cD9PHnj8A5NqJkkrR6pna5GyMCUGaBCJHRLgB836Wt
 IHP9wHaF0gQev1bY8DCgmg42cNcRRSkjz02cHiedNfqTQm2epbYrFs0fSINNgbLLlvNhLjYpvVY
 jx/0rskUp5dQiUEPWgA==
X-Proofpoint-GUID: sXQINXMTvRptA4cIpas_YqGnTpE4sWdH
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a707f26 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=vtlFLEGkmGI1kn2-6cgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

