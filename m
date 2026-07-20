Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D6BC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqhE-0005XI-JZ; Mon, 20 Jul 2026 12:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlqco-0003WI-Bd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:13:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlqcm-00083a-Qi
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:13:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KFw1b13259623
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 16:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zs/hNqY+WzldLzN7FQpEK0ITMzpW2w/8VuHYwh2P4fI=; b=NBAuJEsZVJk4oB8M
 t2Ra3Eu1WnHPQzaPPHaAj9vZuQebKWzNJhnkkpJizaRbWoo2g3MM0BVr22KOWTlQ
 EuquRsUwRqdrbim7WLug5tAGfyco41nZhKTpSvRpTdzHH6aQyIlDC38/IYts+WGE
 ynn8/4Gpi/+KPtN2CIGR3Cogo61MaSV8IXH5Rp++PEAmqQByZ4CDHbKmC/zTMkv7
 KLuna3sM3aRF3WJ9twY76+M+R6UibZwyuElQ5yqZobaDEM1/IgiFSB2/rrA+LBsv
 9WzxovbxQJrPdjygPnHRvAVAqs5JxAD1nNJ4ONvcH1RoWJJHE0c27T+ywoFzhWls
 MB03TA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcjagb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 16:13:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so7542086a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784564025; x=1785168825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zs/hNqY+WzldLzN7FQpEK0ITMzpW2w/8VuHYwh2P4fI=;
 b=IRBiuEpGH+vJYSj+1W5Q7nXUEoB0r12/A0nRojfPheq4BPYmFIwp4oQmTeRu8GxyYt
 UsAw6UEQXviS5mv4qXyBsKSIS+RogZ4KY2qbtOQSqYzsrElYyelQr+J4+Di0+lVzTLcg
 NQ07zfKwfPAUW5tjnduJCcksvfxaUIkSastPfpjV25JoBEEgtBnhMLPs5Qq24W+4g0/p
 GVrrFesZCo5WgkDT5mTAByf1coRF86yrn/nuMWo9sl3k97sqtzDGHP1/qQrzARRg2GYX
 lKp1p2HITTqYm2vwG0zlWP9eksA2pRRCh9s1SvmNtmw2FKS3jTzZKuF2T4YyM8+CNjXf
 w6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784564025; x=1785168825;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zs/hNqY+WzldLzN7FQpEK0ITMzpW2w/8VuHYwh2P4fI=;
 b=q5ay/QkujgowsO1kn5GkgRyJ1jc3wckz1vXt8VE/S+ePny8VIHUAsBMPg6vOT9Eqq8
 jl9zamNdDspU3At0vUEsZFB5FMzpI0dIib1wch9N5n/494iOgQ0Sma/5z6UUBqkYvHA7
 Zv8aWn/tXzPdmbUXV2at7Bk9SCKqKHrBEP+X4cxvpGA/h9SW/U8e/atZnl/6AB6SYqyb
 TvRP21EJzgNKvpmHg6uWXRGNidH8Ice2eyvZn0rGCoyE0yMfpmueY/n/uuAles2nqQki
 KkJD+NT7aFvNSMey0OGQz6gy4ZYmGdO+qYsPv7LthBSKjlL3u2sf3DovkDu6R2HgUDQ9
 GIWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcGvMtqvBrqsD+qIElEpAz3baigSynPyQvz/f5Pao+zres6EwIXUHnLmj/11h+lWQuWtF+XCjwp8rx@nongnu.org
X-Gm-Message-State: AOJu0Yy2RDKMyxeerBPaZSAmyMbACWs8msHjr2Qj4Vm5N1yr6DagUCS1
 1m+SHybCNgYThABAmcB0XfFuy3LpNdUNS3BogXGhE/1h5WfWVbOkvRnhX/pGWQM5sAbHQZGXAxS
 Ck/BaX1QrxA4eN6u5U70/Qb8eHLJYsH+vEaKn0B4fHYufujhi4XCN8+Cmew==
X-Gm-Gg: AR+sD131rebgbCIYhRkp2I+aLD0SWuF9YDRqjeRfdQi9BwH+mFs9Oqa1wRRRvZEkFD5
 thWgXukxva/zPSsp9oXo/uRz53gNd77UwW4yzW52ArRoXVlkIeOYviXr3UVT97w3ozRn9Kt+wYF
 Rk3ykiBcmxzDp/4kiCi0mJ1eD4NCmvhE6qqQw8Lido1n+h97d+HCajM4Kdk7JRuAZKN871rDvTL
 799G1kKpME0k7pBoPNdxEtR2AwAPDC3f6AZblsjrc1uc0W64H/TswunJx00IXeqKBGbMy+Ir47w
 JG5fuBajV2WLhMYv8ZYvxzpQXDnGLlCLHKLm5BLXJi6QLh+dBcaESLWG3s1C2cCY4xQrEma2LHz
 324ASgBwVWMJXcRIuJfcW9Zg8yGNBd7HjuTjMqNWc3jOADFI4HFz9gplDDoRjdUU16WXq
X-Received: by 2002:a17:90b:2dc1:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-38e4b5166b7mr14165637a91.20.1784564024656; 
 Mon, 20 Jul 2026 09:13:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc1:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-38e4b5166b7mr14165603a91.20.1784564024133; 
 Mon, 20 Jul 2026 09:13:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29ffb13sm32809303c88.6.2026.07.20.09.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 09:13:43 -0700 (PDT)
Message-ID: <691d6a15-d177-4365-97c8-c6e0d9c039a3@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 09:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] gitlab: remove gdb from MacOS jobs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260720160126.2503610-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720160126.2503610-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rc15A2insJr1D3bLRrC-jaOEPIbf77vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE4MCBTYWx0ZWRfXwjJZK/okrL83
 6Ufho5uG06z0zzL2EMPxOv/ofTKrOjp0dvNOKnsB/U0WYNn7yH/t6J5ss2A6WWRqJq0vdTvJPuc
 SKtJAAKdAfy1HdPg5pl+gsEl+AMnzODEjuk9+aUaj7jtfHokCBhv9GY4ezWRzeKkzRew+I1l1s8
 oVPMPeARHxrLTgpbIucv0mERPggEGhj9ZEhKQ2Dt3L5EZK3M4bpv2IvQlAYXC//Ic+b+9zgfs9r
 iQn1yA/2AhztK7z0npeU7vhYmdZ6RsK49Gp79ARgoU2szXBFSX9tZrQWArDtVSWptpGaqrGAEnG
 nja567cWqDakPqGONlmX5zUa3X/6G2voQHDm+qjJDXV/shNxGfTrhff32dAMC2Btceu5a63sRJL
 0WuP5wf2zd6dlqbP/P0l5zUmxCdKBUbWPK2R4aF3vZabw+m7j3xY5AnR91Nq5Qi9yk7faEWyAtA
 c0rRvVU4IBcc81UNLXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE4MCBTYWx0ZWRfX7A5Ir9nWvabS
 Za2s4oY2tinyGxI3IErQioRMUACeK4srjt0gq9MwJ3ZBcpNFdtkcPDgRs2mVRRxIoBHA5JD07Ja
 ZLv7Jb+biYUH6KYzs7NjeMb8R/e0/EE=
X-Proofpoint-GUID: Rc15A2insJr1D3bLRrC-jaOEPIbf77vz
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5e4939 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UGfL_sG-PBHnwUUBT1UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=h1q6ZXiXV6sA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200180
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/20/2026 9:01 AM, Alex Bennée wrote:
> This seems to be hanging in the CI.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/macos.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

