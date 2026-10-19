Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19436606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JA4cRL+H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eO2npEg0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1l-0002S3-N2; Mon, 19 Oct 2026 18:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIw1f-0002Qn-Uz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:40:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIw1Y-00048c-IY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:40:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZgHN2457966
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YwSxhhVTsQwI4NF169M+ws74XhOpoB9sxHQEVhHo1tw=; b=JA4cRL+HEDGkg+wZ
 DblE99g2cSiYS9kVkuM/f1rE0KHKx311mtwngGBdocPRBN9AqwEIHm6ndItLmyZR
 4EYZAfZ3/ZXuskh07ngdDvtIOG8IktlRGFetm/bQk1LApgsNjWmIAsLZynKcHkfs
 Ozcqp60eKmYajsa/ff2y4ft2d7h1lvKiGYHMIbLKcxAMcVVF+ttvTTC0eb5PbDGY
 fE0XHLlicXFeKY+mned4+maJ8i2FpAlOpvAptdFCFZ5YWQAECE0pgkckZgDTYtn+
 7ghkizCcRMq7Sg60HhpNA88Ha5eCYvDNiy2kRs/Jy8lvgrAxSt/gBTVVPoQFBB+k
 BNpAPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65khyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:40:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso6645052eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449604; x=1793054404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YwSxhhVTsQwI4NF169M+ws74XhOpoB9sxHQEVhHo1tw=;
 b=eO2npEg0gKRtS+HXPImLhjKhHlPZi71rqX7x73G3TD0SAitTTe7AGSJW0Zbu2PCA52
 smkTgQk3q27uc+/LKinWK0jiU2fkA6sK6Ms+0NUh9kGzhZm2TAy9s22+KKL+UF+0uwJm
 OBM60NFsFjwj4uDn8DVXyUSmwyxvxSH4txGnGxFBJDocWCy+8QanIQtRSGXKo8s8YijH
 PAe+sRc4qdv7FVu3Q/VCsWjcbfUwJnsDNXPg6tRscJCAvSFWNfm8B4CmVHp5TLsvcvtW
 yGkP+MxtqkokWrom91cRkZQyv1r1iaGDvCCDrJXihYxp3lqQ8UW22OJ8z7ROCQdljkG/
 6xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449604; x=1793054404;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YwSxhhVTsQwI4NF169M+ws74XhOpoB9sxHQEVhHo1tw=;
 b=am6QAc1WXfPa+nTbIFs1mC4N52f20H8CMMzfwm6ClGfW1I6SUqmVJQu/gjnIOtEKbK
 g4yfABN8Tq6YY4vBttpTgn0Ymo2zwKvtCvx4nipGr0JIgKlALwABDiSJMciTpdMxvAty
 xOr0zd4soRSIye8EpU7xy2zC8YRv34MJfql3S5NGCvjiLq7erMCqrMXMuBDomrHaFzmD
 QWPrqCXUGG0O3K+lMJngaW1mRdnMQ4d2/l7ugB8nyBCaz3mseZioQJHh4OG6jqd+kCpC
 61dfuncpE54jOkzLlBivO125m2bDB1HVTWzJAnSs5iFGA2IGhip91uaHvaN0gbemG9gX
 0/1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsOuqxQ/fWl3UmF3iFdR+c2bCMKNWOeQSHHlA+j6mrc8Mk6VzGBdjIFBZZcmNC7oiuOhqF3/AXxL02@nongnu.org
X-Gm-Message-State: AFq9FYIQQIlynFhVvmBy8b3dtYnCMgMcQgoU+axxlNtbAMBe7Rc2cqkU
 GxcglMNRqkOlkbropEP7ODmIHUi4tO7NTtKuwg1Xv0ZlautQvlYi/Uvoz0didk2gRdGGYmg79Av
 3X3KweYgzkIdtmJ+dFBQTcgaEjnlBbAf1jpZ7g2ODHUXo1CW1yi5Ri9sv0Q==
X-Gm-Gg: AYBFou1/p1Z5rOLjLtvUh6TFT8jXWdbioAc20rA0P6/okd9iBX4Qox4YloRfUZfy69C
 O+GxotcXCrmtCoowl/WrVE8RlDr9rm4Klhl3mdXyBgFInXnF2Hs65+ABU0htBGsps1fBHGPAJ/B
 P3AbEyZQyTfTBWPa5eVIiWlAlsvSAc+sW5xjz+/G9Higm/AIyowxG5BbjP3UfaBUBJou6SLA4sQ
 l+Hz7n/UDSv7eIHtYV5fDLi3WkfA4G9MlCTGECJwqbzhbFDIpgJXLxdFuzyv5FJD2zzP9NnvwvT
 zUMqseMzl0WO4AEkPwhURynPE+Rg9b4DdeExdUMJ41jE0QVUdcCLX2fLmhcVpLI9s+mPOffDlTS
 E1iuaQ0oXiyAFlIT0zNu4kEkcJDPLalweDs0pO7TxeoQAG/JvIcdohtW4m8DnG2sLQisQAQ==
X-Received: by 2002:a05:693c:87c2:10b0:34b:4b99:24ab with SMTP id
 5a478bee46e88-361a1e501fbmr14226106eec.22.1792449603349; 
 Mon, 19 Oct 2026 15:40:03 -0700 (PDT)
X-Received: by 2002:a05:693c:87c2:10b0:34b:4b99:24ab with SMTP id
 5a478bee46e88-361a1e501fbmr14226081eec.22.1792449602799; 
 Mon, 19 Oct 2026 15:40:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm58613467eec.28.2026.10.19.15.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:39:59 -0700 (PDT)
Message-ID: <d4840d40-b687-499d-a251-cec93e462ee6@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:39:58 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/hexagon: assert qfloat shift
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
 <20261019223253.3243067-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019223253.3243067-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX5SINnNurTlaC
 Yj3wBxFpKJh3hAIxrZgkULMHc4JiQg9E9LoxYGUNrCbjtBjToD0FJDq32k2A1dJYhpcujolZYHP
 XJKH+gK1bLlPn2VwgvCzK6oAZ+a359M=
X-Proofpoint-ORIG-GUID: KgTRusWAOjrGuH6T_518Sg7GNW-m0H_T
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad69c47 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eLx-3-Ot0qTZY87SafMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX4FQ//XRtHB26
 KT4HCLMMof9o+Ppibnq3lXmK/8LvpqWUrGYJnuM6Z3XwYcnZn3pPjaoezEhKJ6qEiSZKMw9Q8r1
 mlQrw7fgl1W/Yy+K4LbS0QF+IR1rpNDFBXCZr9mF19nDXP9JbfYQ+we1j6yyw7gZB8SkZ7VdD8A
 9VvdX1LtNFT9LMV1Cm5CVW5B+j8TiEpy8URKsNcEr6ScfgDnVgumtLxu0XPinOVYPg+V//EpzuX
 IRlP/wAb1Kcg0J1ObK47hjgwRrXB4vwBYGk3QtxjbHcikSgd3KFfX9roX8c2F5k3NaHjJZOQnIJ
 M+UprMeL2r+EK34Cl1YSdyqwn6pvadx/qZr4KijuaJKBwC+obAHmfNZu2qxIVMDuOCRjN3gloSI
 jQnM/4swp+Smygt648p3L0HVQR+Pin+0nEfUMxqpZWSuIG4iJc25BuJxakM49sQvf1Y90LjDsPs
 s0C94+N184eMFvY+Wpw==
X-Proofpoint-GUID: KgTRusWAOjrGuH6T_518Sg7GNW-m0H_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 3:32 PM, Brian Cain wrote:
> The midpoint rounding thresholds shift by "shift - 3", which Coverity flagged
> as potential undefined behavior.
> 
> The legacy add and multiply paths select exp such that the normalized result
> is at most one bit above it. With the largest legacy fraction width of 23 bits,
> shift is at least 41.  We can safely assert this here.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA_WJ-PYCfiiu44uTQiDoc58_9Ky3uEd-9g14nPgDPT__g@mail.gmail.com/
> Fixes: 2633da1e127f ("target/hexagon: add the QFloat logic")
> Resolves: Coverity CID 1688240
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_qfloat.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

