Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFC606A335
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i/OspE4Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GmLGk3DC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPjQB-000854-5o; Sat, 07 Nov 2026 11:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPjQ9-00084v-4f
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 11:37:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPjQ7-0008OW-8U
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 11:37:36 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7F03KV3684873
 for <qemu-devel@nongnu.org>; Sat, 7 Nov 2026 16:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I835hDNDxEy/1AYlwyJl+7qNJTXldeKmZVQN4spe/0I=; b=i/OspE4YHnQ5RrIB
 VL4zPPKwgksCZCQQpVgJeLptHCrgtIFdUkKJRKDoxpvSkn0gR84TttYUHmzMC2JF
 09xLkJgyKu3gpNRHIht5iIr4rtO7Xvc5u1Y9by1PK1jYppXoSBgDnb1mulaZEeoZ
 0lHjQaAx4bJyeBQ3cW4/A4jaGdh9xOVb/QmXyCEcL7nGEVI81gDtDAlaOsFq54Mm
 y2kiYyYqROOyrR8ZIVKSLWmTbiWsF/uusOWFEvKTYZxDzNh0p6PWmDO50Qm7wCZx
 Jiw6pdOE0v1IePaJ7EBrz8d9bbeSaXnGUbQsU/pXCy1l6XgotOyC/RHgqOkCwuQk
 /EQLXw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsu06sd43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 16:37:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so3596837eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 08:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794069452; x=1794674252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I835hDNDxEy/1AYlwyJl+7qNJTXldeKmZVQN4spe/0I=;
 b=GmLGk3DCV2mvnRBJp87PFu4bSFCSsdshA6wDYjA6nvfUBfmf0kJ8w6SQPWqzci/htD
 FsS7ij1szQPO0yNHNhrOUGGYp20EPf/pF61PVz7VdmcChS2QFbib4UgHLMkvHi1ktt/E
 25935Si0URbd1zLsi8aGWXgalyq4xIjVgSRddIlx6Ld7jKrcCqCQ6ZmlctiI0ytETtz0
 u3DZFyVY9xEIMD/0Dfx9HDwPqbadBTHqzubNl7Px3p+SGdbV+oJB4NSVFASVAWrVkzkY
 uYgsKXJB8haQr1vVZr3AvszOfV8FMXpFjAME5ZYR/fVUp5dOzu3JPCCWQITvuXGVoHBc
 bf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794069452; x=1794674252;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I835hDNDxEy/1AYlwyJl+7qNJTXldeKmZVQN4spe/0I=;
 b=RF27dwtfTJk3JHzNG//mgJjzGDWWwPreZDLiclivUUVbkBm0//VhqLDLwwQjAxNQE1
 CAWP6zPJoqH6Oz+nW/VxJPjZti7jamxcqJXuB6XkQILcNQOdbYtIJjtKrxavFcekGzI3
 RHW9U0q+3A8Z13k6jwgr3P0NN1Vyp1DjXq6kjSG8is9a9co33gXSjk5tAzLAo00mkNcI
 NTvqKbfvTOfOe80FRxMfl8jBF3DgSvaCXoU3bSrQDzzNug6HJWz9vBqjHDti+X1V9Wg2
 m0Ciyv/ZflVaxunfbiaBlPsZ/46iAstCS0aoBh4uaKY3Ieqy4XAqryJR2xEXFQcAITc7
 rLWg==
X-Forwarded-Encrypted: i=1;
 AL+hErHLUXXOzdluSYn+12kLTaKPNYKJuKAJhWro6uFhsaWtXx+JhDweWC8V4g3ymDy2nwHXc0HUyHUhrxWG@nongnu.org
X-Gm-Message-State: APuU4Z/EeP1Y9vlPrTCmeBymkTkkRuR2MaLsjHuM2qnJPxBf1whllojB
 OCINil3tWoJG8dHOoanA/kXWEUs2QkvqP93Bvm+Ws6WjatD3wi0uXHWW+7pVPalzN94zGrzfl8b
 zMWdEoBElQX8tqkXeTDA8bTS7H5qBEo0dP4UvvhdXQHtisL/wdKlbydPvoQ==
X-Gm-Gg: AYBFou1U9/Fyo436IR93o7UFK8N8FoW56lxBhGGt1OimbfSq6uVMJRJW6ByBB3GEMEP
 RrYdmtACHxgxEdLkkNf5chnG3yzkI/eol9kvyd7brP24/Jb0JiOnbmp3rHHs2cs7SGx3npYk0il
 C0yxDk25lDZj1UTzYSY7OCqXNm+cXbkFu+M9qFx6Ca16VJeExnxoCqNUJV683HMndhuQLFjzixn
 cSoYE0R4yJ2iFgff8FyYhrOUiGtIpWHNX+TOUrdh19cY7+IrftReZLs5kGekeHI5GTvrBlCj+2G
 uEPMS1WkwIaFKGUKrmL4wXWtjxvllJ15kK+uGc60cLXiWGxiswfLC7E3Z+UJI5cxG9gnkf5X/VB
 A18VAZvA4OsFVq49njtm4PMvOBrNG058usnYaimIjy1vd3M8jY8JdwS5g1/JHofNjyL91E125qe
 JSSWB5suooCJYXgla+vCZD4ohgFrAf9r4dAeSKQg2Sww==
X-Received: by 2002:a05:693c:8097:b0:36d:c2a:7964 with SMTP id
 5a478bee46e88-36f76117e63mr8569425eec.21.1794069451483; 
 Sat, 07 Nov 2026 08:37:31 -0800 (PST)
X-Received: by 2002:a05:693c:8097:b0:36d:c2a:7964 with SMTP id
 5a478bee46e88-36f76117e63mr8569372eec.21.1794069450535; 
 Sat, 07 Nov 2026 08:37:30 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa9be7077sm18566243eec.17.2026.11.07.08.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2026 08:37:30 -0800 (PST)
Message-ID: <98f05b71-6ba8-4781-a775-cdda9518ceff@oss.qualcomm.com>
Date: Sat, 7 Nov 2026 08:37:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix icount trigger exception PC
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261107054527.1024576-1-himanshu.chauhan@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261107054527.1024576-1-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA2NiBTYWx0ZWRfX5jiwue1duoIx
 R4t1a0cPIWv0dvSHE9oddBcAY4M+q+nawWd85LFGNPIlqI+/98KeqmaFCjEvMMT1VcAINDkyO6M
 owmWjMbkH86JOl33koP//KhnZZW3pCs1oGQdIRmGVPF51Xez0j8TcGMr/07ZbpPFmgwr6vgFDXo
 3IQ2GKKozKjc2nsefdnNVRBJR3JflWssRi1EEEotAZqyXkI2By1/mfoIORFkVetJKK3WhWLhp5a
 ApN9YjVvS+DpUbulpUobyJzkwpb7R12V8SZ6ty7PO2+pRUEiaadTLuhkXxlJ4dmMhOB3MeYyo6N
 QizzWkkiDM4spZqsFoLV8GYZJyTfp0fdlFYkypSDVg1JBZyZVs/JRA8pTX1TnNiNykHWuMo74Jx
 bnK9lkNZK/3KA5WUYsCCjaIEOLA2jH/goTTxSLTr/pGQ2zyxukh/Hsfs9PKp2DocxFpNVE3K3ZQ
 j1y5JJXAlQ9NsJ6eBmA==
X-Proofpoint-GUID: o5CH61NP9ZE7KWsyQatNRxzwjXH7tvpt
X-Authority-Analysis: v=2.4 cv=IJGXmQvG c=1 sm=1 tr=0 ts=6aef53cc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=kXtdtA-2LLsiibNKd7IA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: o5CH61NP9ZE7KWsyQatNRxzwjXH7tvpt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA2NiBTYWx0ZWRfX0Od4I9HRdBYO
 31+mT/4cFxoMEF8tAutwaHXiNnAwYMzZxbHXprT2Ani1JEClzNR4dVl+N4YEbQ4IaULG6DzRfGo
 kcBBQ2FfMiqaNBMHm/3Ki1aof/yVj9s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070066
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Himanshu,

On 11/6/2026 9:45 PM, Himanshu Chauhan wrote:
> Per the Sdtrig specification, on a breakpoint exception with icount, the
> xepc must contain the virtual address of the next instruction that must
> be executed to preserve the program flow.
> 
> Since SBI DBTR exposes these trigger encodings to supervisor software, an
> icount trigger used as a one-instruction step must fire only after the
> counted instruction retires and the architectural successor PC is known,
> which for a taken branch is the branch target, not the trigger install
> address or fallthrough.
> 
> QEMU previously disabled the translated-block trigger flag when icount was
> enabled and relied on timer and privilege-change callbacks to update the
> count, so the trigger could fire outside instruction retirement before the
> guest PC advanced, causing Linux to observe the old PC and re-enter the same
> breakpoint while single-stepping with icount.
> 
> Fix this by
>   - publishing the icount trigger flag in translated blocks even with
>     icount enabled
>   - making the helper decrement the trigger count after the
>     instruction has committed its successor PC and raise the trigger
>     action only then
>   - privilege-change callbacks refresh cached enabled state because itriggers
>     tied to privilege mode.
> 
> Also make trigger data CSR availability depend on an implemented trigger slot
> rather than the currently selected trigger type, so software can disable a
> trigger with type zero and still write the rest of the slot state before
> selecting another supported type.
> 
> itrigger timers are completely removed as they are not required now.
> 
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  target/riscv/cpu.h            |   5 +-
>  target/riscv/tcg/cpu_helper.c |  10 +-
>  target/riscv/tcg/debug.c      | 169 ++++++++++------------------------
>  target/riscv/tcg/tcg-cpu.c    |   7 +-
>  4 files changed, 59 insertions(+), 132 deletions(-)
> 

it could be a good idea to repost including concerned maintainers/devs.
At least, you want Alistair, the riscv maintainer, and Daniel Barboza,
which works on riscv support at Qualcomm too.

A simple way is to use git-publish
(https://github.com/stefanha/git-publish), which will automate all the
steps, and build the recipients list for you.

Regards,
Pierrick

