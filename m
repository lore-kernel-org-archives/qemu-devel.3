Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6986CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblgc-0005Lw-D3; Mon, 22 Jun 2026 16:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblgY-0005Lf-5b
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:56:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblgW-00081I-RW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:56:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJax4I1902562
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PaP+qaMDo1CgQZrggNHNPkwszx3orazhfgdIKlt88Qg=; b=Y+BRcf0C+yaNnLZf
 Be6eQ7WJZXXMrjTlc/FaVM5jf65hBrAiFNAsR4GZRwRhr+nm0fkDPFFliaAjVPx+
 29y3nnaEcJvukZB7kTZmHXi8fIlNqHr1GIFVlZtXPE14nWPw0PoHNLcpCe1dHGTb
 7rtuvXsRtyOaSg9lGiN6/K/i8W6nfyVnaK3itF5tSAzTeIviJ3SJQ5Dk2nTDAoyW
 ZFwLiDXsivRGUhQds1WirTHbdFDbKxt/NeejS7nxZur+yJqaMyQxDpB6YHYtUwhd
 C0E98Gaa7BXonE+FKngnMlDwXAVb6gcbqqFvC97+lvEmkidnf3N7vFjZwLV4g+uu
 NeXV2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1uamc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:55:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9158e75cbc0so801853985a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782161759; x=1782766559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PaP+qaMDo1CgQZrggNHNPkwszx3orazhfgdIKlt88Qg=;
 b=XyltyOxpDaRLP0S59HGDxjxT9KMfbJrzlK4+7Crmd8vwPVvkjFOS9ryStAOPYTFKr+
 k9p+tMmd9bE0bqk4TKcnGW97R49xqzfu0aL3WOQdxjPCLXwmTEZma/fLq1NuwDwj1uCd
 mxuQpM2+lS8myv8GCg5skPQgg27zVhUMBDLfwMKo+QJ7wJ6BKNfrDNQiV5wMMSHPpWac
 F/ysdJka/avXN4f6EXQwH6Coy2OYjuBC47QUKqKI9AbFqCn8D7uwFbCsBvnRRZEfKWf5
 g2dDyRWlbeZbrlqNqYivfQ4ZmWSGqjzZlrOJm2KUX4eWbfGhy4PbcAcOB1qKJR1t/yHV
 v9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782161759; x=1782766559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PaP+qaMDo1CgQZrggNHNPkwszx3orazhfgdIKlt88Qg=;
 b=GGsaf3fS/psEehWAzyOjaE2cd419uGd1/fNUW3QKnoy1144rOgkPmCBSiUMEV7CUuC
 gUFKZ+m87bzG3FrUIi/XYVEUmmp00JJUtFJINZXITyyum2hl5hsFYtxDuYEszWDhZSsY
 OMuShKwJz86PmAp78n/Jmd3PGwN2Mi252fQV0iTViqGIh3zR0OEa4OiFwboLR+UBpgzt
 BmUJ4aVFCUjDwaaV95o4D/d1VjP7nGvz7JSy02ZVlbwoNtVbCuarLtD9f9DsMIKEBfUQ
 ZjdJdEVLeJFj6Tfdc9w0Ls2mdKC672HOja2SIsiiTKmC93TI3kQJ2C59i/qNDvSI+Ova
 YuJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OtjA4u1ZbcUDJaGMTeaQLK+QNOT55l5ogqMfy/EFsCZrtCKdKAFDnTaM118jVj+u2C36mlXi1GoUZ@nongnu.org
X-Gm-Message-State: AOJu0YxO6XREkLR2tVvzPaKnrJ/fSINMKC6TmW/bCSgZIMcXmDp+7pp2
 816DTKGOuUOwsmGEDTst7BGTw7G5kIrqIP5WfIpGLnwcNBXTC70pSNMPtN4W4E/gjffFUFOiiLc
 WUUeqApuAC8XM78G5eJSyeQaZtANukJPZccD5348r7+ZSQ0sQVlz1mKkYtQ==
X-Gm-Gg: AfdE7cmSsqphwbDGGlNp5laDS/8u/q1U6hNF7YFaYOIlGiCTQaO8kPa3sUDR5K8ZHAR
 DrRTkpb/y3vuk173ZqVjBYKPPde85mIhY2P7CS+MchvA2Hshode6pnZuXg++tm+4Zd62W7Z1jXz
 ix8XhRybZWAfSNO2yZUoi+nKjA2+Ar826tNJsLxH3+Tj7nuB4ak8gcX4pM+YXtF/Xwsi4dRPiEW
 eSq36BsI74k8kL1xz+leX3hifvMS5ueTCUapZOIb7KEn2GMr0Df6KszZF72+upaD8WBcYQ+M0x0
 bBh/H/+UOzWDSCJfZIMBBsQNEVK6S94Cb7PVJD89zPLxPNMuV4+Z5m7h17SwO7mnoxgNgmVR2M2
 CM0akBjZ2yIlVnum9hyRi3bb9UtuBmq4GNoHyDG2nQb/mLWabwPcZp3pCmVAkMg==
X-Received: by 2002:a05:620a:2996:b0:915:fb92:d599 with SMTP id
 af79cd13be357-926454bed4cmr26325985a.25.1782161758927; 
 Mon, 22 Jun 2026 13:55:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2996:b0:915:fb92:d599 with SMTP id
 af79cd13be357-926454bed4cmr26319085a.25.1782161758326; 
 Mon, 22 Jun 2026 13:55:58 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm228876925e9.1.2026.06.22.13.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:55:57 -0700 (PDT)
Message-ID: <ac42dc66-e9af-4633-b569-9839343bee01@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 22:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] target/riscv: move debug.h to tcg subdir
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-8-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-8-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Dctu4aHd1TPTYjm1YKkmzf5qVlzUQ9v2
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39a15f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMiBTYWx0ZWRfX4NlM4go0ssV9
 jF9g6TsoW0q3QasVPPhNg2tPxe5UHn9j8OmMxsgDUzZxTRNDfloLFGFmn7FwNhAuncikFbq4LHb
 Voo2w9dBAO/9Z6u2PeU/n94srqOQCWQ=
X-Proofpoint-ORIG-GUID: Dctu4aHd1TPTYjm1YKkmzf5qVlzUQ9v2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMiBTYWx0ZWRfX31d8WnZ0IQ9Q
 z+vL3BJ5WczbJ9cu6gs+kGwdwumjNUprKqKUN4W2l4kFbTMj3mlLxaRI2zzQs20VTg8SyqktE7e
 01D4ju62k/wCs4YpB5cRCEJSUAvK/xaxOL5jI5pgKHAocWbV7R/mQxh8S5z5JBgngjp3uiTjli4
 mUwsgh9gjzXSLFng5nRsIQlM2OdxSWOjmchMVeMWnYuB56DK8wJgH4PO/FkJiYeHMBEQVGtjKh2
 WFO9pBG1Dsb+W+aaoQNp4aO/yB8sYrY/D3vwUcFQtsQ6moyFDBMuhd8/B+rvWM0Atq5pKRKruxd
 XaemPaQBwIF16BKaWrpUupFKvvZN0U8IuUTz8g4cC+6flb9dN1DhmZ7RbftfzR9nxpHpKh8rHnr
 tKq1uOnuH+7059cag8K90Q4yVPN7JhQ4pG4hy34uT+aA/6qgJJXnPCG1j3qdf0wrAeq6hZDo6kw
 ZFZhU2asXDspv84ttZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220202
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> riscv_trigger_* APIs are TCG only.  Wrap the usages we have of them
> in cpu.c with CONFIG_TCG.
> 
> After that we can move the header to the tcg subdir.  This will be
> enough to get this out of the way for the --disable-tcg build.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c             | 8 +++++---
>   target/riscv/machine.c         | 2 +-
>   target/riscv/tcg/cpu_helper.c  | 2 +-
>   target/riscv/tcg/csr.c         | 2 +-
>   target/riscv/tcg/debug.c       | 2 +-
>   target/riscv/{ => tcg}/debug.h | 0
>   target/riscv/tcg/tcg-cpu.c     | 2 +-
>   7 files changed, 10 insertions(+), 8 deletions(-)
>   rename target/riscv/{ => tcg}/debug.h (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

