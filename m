Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C34606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gAGNGZ0z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KWWfH6bH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOAx-0007Hp-V3; Tue, 17 Nov 2026 13:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOAt-0007H8-9x
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:45:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOAr-0007tL-OC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:44:58 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR6oj1663618
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OGJRYpmVcnKWImUMVM1A92dMYUdZNadd9Wkzfnydu5w=; b=gAGNGZ0z8xXi4nhc
 +KFH29BQoFdmppqg7pkqEe8v+lc5JUNCceryRWGZPy4NlvCGNLhcfzycQXKWftgM
 zfPqVhr8Zd+UI0cWT2zZqNMZeOIJ5k49T3uXLUlWJnrnqXYkkCCyxm8V1zWvsPkl
 aAKkWLj/bnREzUn1n3G9z7q+YBKFBlXzOp3qkP/as5UqNYcu16tjnJauk/lDLU6m
 S21Sq93CMK05sx2i3nO5i4pOmlVo0em3C9BbamHI27aHWnAl2HNtz77u5ikaUyjE
 M//9tTGmA8C5veIUDiC99nH0Keiuj2MPeYmxdpgpNpbKId8iHGdh/zW82gPwKYGi
 2H4syQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kccak08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:44:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-38131260a5dso517623eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941095; x=1795545895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OGJRYpmVcnKWImUMVM1A92dMYUdZNadd9Wkzfnydu5w=;
 b=KWWfH6bHCl3T7+BTPLzJtmTyXJ5UYEy+1clThsUyryWxp/Rb1JXc5gBNjKUPK/GreE
 NR0C2Lh7yLcQDXPkmuqA/eLnZdOpO2Al6w9v8cvaRExBgXZpDui6+2Bs+KQF5Jm9iyWX
 sZ6FTFU6M/SxXMXnqR9EJr89+v1+8dCTVlkeqzO5vg67yJLvNroDMveULPTULqcV0XQq
 Zxs63HUdSLQNR+f4hLC9v4KfFYZkhJOSp0j64gvMXmffzRDzv0yYNifMKK2Krm/R7Xdw
 Tma+cWpA2cIILllzv9el97VfXBDccbb+R+IGMU6n53kHuruA8yod5GNceC7OLDdHkAtv
 PfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941095; x=1795545895;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OGJRYpmVcnKWImUMVM1A92dMYUdZNadd9Wkzfnydu5w=;
 b=Iz/fL9JIfXwUnJ5IGe0lvpwmNKvkBMQRLfgBsJ99tMPMKIi4mgxNIDGSHwPUQQGPVR
 zUJycyu0YCf4DaqfpiSUmM3LWrhZVYuwMDQuZ10eRSl4+itUtaVRYnZeCbr7hVJ8+02V
 hCc0W9CCH39+RAjXk434WzJooi0UZ137pCv6xg6r0HYpgH6G39Kfwll3pPdUxpqFhTp7
 /BnlJAghCVX4mwChAwca06Rpdelpu/2mGWlio+ijGepe4uXTRMcGaS0WEyCzuAyI7ycC
 d/BhsKOp6YqOHGxpRrOY1wZXXVpTvwwZ6F77CkTE/0O2UtC392ePEK53LaEaPt+pVp68
 kIOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFQcOyIhBuNanNJNOgUzlQYCmH//9fLWMmDnqDDQgv3qybLtz5miak2nkMc7pGZ8Yz+NfgsbAAkM1XX@nongnu.org
X-Gm-Message-State: APuU4Z/Kn+BPVUua+lIuu7R75d1bp66MvQNptwhd1klV67PD8vI/UqEj
 lQXRUV2TAE9hOay9YyDdZ5mLihsY6hS7p9Fjfo0R77VIXNKGzVK7a4GFd6ESpFJ57fDcBiYqpCz
 1UywH9D/uv484LQY5+HqEiR97Dk8AHGc/2AgKHQe0HtSXL+pb1uICt3HxRw==
X-Gm-Gg: AYBFou2k1gf8NsTGq6eQGbei65qKl1QH6MskQlhby1FVieiAKcfZcun17r4DUzQP7wr
 6ZVX0qtSsE9OMdCpaPDLNlGIcTQGCSOLR4agMXmkOpgi3ZL3vO8V1jt0069m8T4RTX1uwNQtoEs
 E3jDEf+CNJEeEWCzF2ZOVYFZYb2EdeLXALNF18G0qsaZfK96McvEuIvox2gUXyyH8bPzDw9M8OU
 VL0Kuy4XwSTbOhZLQEsyFx7RIuhtbZ2W0rZCHcGtZhCUG0b4c/sAzQC4+1Nb4hzhkX+vrQkC1Wu
 pBl9kIyDSL7v+NVygKWH5bOjsjlOatwvmkYXEQNXYPCcvGukr8EnQUJc5I/bsY2dfnxzaPlYwXB
 xjKr8QK/zB9ajkskAd6oflP64XBPPaPGkGgixRXWj0JTUkflSd2R9B8R/UgMFCy3fVQIIpB1iWW
 P+UM8K9sz6bM0STjmJN89vmOQMOQMnIO+b3RfQ1a1nCz4=
X-Received: by 2002:a05:7023:a8b:b0:1af:d88f:fc51 with SMTP id
 a92af1059eb24-1b543d264e1mr407956c88.30.1794941095056; 
 Tue, 17 Nov 2026 10:44:55 -0800 (PST)
X-Received: by 2002:a05:7023:a8b:b0:1af:d88f:fc51 with SMTP id
 a92af1059eb24-1b543d264e1mr407922c88.30.1794941094321; 
 Tue, 17 Nov 2026 10:44:54 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447c5ec9sm99157c88.8.2026.11.17.10.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:44:53 -0800 (PST)
Message-ID: <a08126f5-bd7d-4c54-b2cf-f37a8b336746@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:44:52 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/hexagon: allow writes to V85 USR coprocessor
 fields
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-3-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117183629.2002840-3-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXzVzPFmjAEJvO
 Bx8Z0XKqj0eQugHURfRaR4GVyg/engvcM7oD85E455V0VzxB6Qc6Ca9DAyz3b1zNXutIlnLjuh6
 PXjKvoSLXed+iw3DLeRq9XC70p5VSTs=
X-Proofpoint-ORIG-GUID: xTLmRXTCPbGB_WuLMU1tGP-9JE7V_SGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX2x5pbO5LpXHo
 yFsaj6NMlBuM59/878nBMhVOFnkSnBptceQbTsC82HFO6CZw3He7d7WwpRcWHPR/LLsIUHvIEDY
 4dg04LWkt8ju1MPiO22cqBqpVYgsrzC5odDISd5vqSCeTLwE5G/A8INRckhs0DFmYVazlajpf2j
 njuPgHnQ0iunLUKVQYWkTsdimZ1NBfg1MfTUy1ocyOhz9VPstCUTCfJEuSbJsQw+vtiTq+aWXht
 6X/Mn+puaj71dy+pMS/aJ2SWeNXm2rmFZgJzfXzZR1iGAfrqpMh9iD8fWzTYML2y3Nbv7apKnmZ
 l+8X/0sGwKacEfSASO4TXmFqWn7ILvp8ptk8K2FNyFHhxpEEskhYBEY2yxHE4UGWc18VTzxCQAf
 NTVQgbyFsDcaXHuCl5bcHHYRaDHqfVMFOjk3oVPGau9qyKEZ+IVgz8Lzsbf4ZrY+zUxMyLZ/WVH
 IHmldPkftNDh8rWz8Bg==
X-Proofpoint-GUID: xTLmRXTCPbGB_WuLMU1tGP-9JE7V_SGa
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afca0a8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sYVtdisgnmDsw7If4Q8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/2026 10:36 AM, Marco Liebel wrote:
> NPC and FPCOPROC are writable on V85. Remove them from the immutable
> mask for that revision, without changing older CPU models.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c             |  6 ++++++
>  target/hexagon/reg_fields_def.h.inc |  2 ++
>  tests/tcg/hexagon/meson.build       |  3 ++-
>  tests/tcg/hexagon/packet_user.c     | 18 ++++++++++++++++++
>  4 files changed, 28 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

