Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13617F4210B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD50Q-0002Dw-4J; Wed, 15 Apr 2026 14:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD50P-0002DT-9q
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:30:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD50M-0004cz-St
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:30:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FEIKqK764418
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /IdsrcYcpvwIkeKLjtv2ENG4xhn9aWKyhvQXOQSINFo=; b=UKnmC/jyvlYwwBgA
 kn0UHQKUmKfh6+6wbSqgZE2lWVumhXzKpePm0pj1xpkK8F5un0kkzGDkzOvFyStF
 IZrFUtTfozB4/6yVr3HuohJWxLji9uWegDREubw9ii1bbJPO/uZTlAyhZqLyXXC+
 7C/J7xuIlmrlBJB0gjzylivDfOjW97mAT/3RTjo4j5sviUPLrexr8T5Hk5gDg/nN
 FBH2m9ZIrtW6KFhCoZ0G7+0fJrk+1Wuj906c+FNBd7RpQayYgGVmISpnuYokmTev
 KybA+1gdLIrP+RiJojGKGtVwAr1wjefg80tNLFQaHNcIKveOIloC3S8jBS06lFMn
 KBsVOg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj6q7take-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:30:24 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c5bf2c182so7619629c88.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776277824; x=1776882624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/IdsrcYcpvwIkeKLjtv2ENG4xhn9aWKyhvQXOQSINFo=;
 b=eqDDdih9ITioAJ4UDtrocxJ/C8nxnp5Av0LuVOlmplMit+VnElbaH6MlqDV6/bydXG
 UBN5Z5p8lfHqIlDeQ8fkrzmOAL8DX+niIaOvG6aSl9zfXDwPwjEQp1oJGyMfeODvkH8E
 4/lCu/RmgEPRxEkmuPwhLh4zudZQeIOOZF7Spv2c1z6HQFhys1Nid0OMv69FvkdzRktm
 ElSFSTGq1/JWaDRORv9iB1sQvguPiiW6J/a9+cu127bjJ9kgUBuLPskYesJqEWgWStvl
 +kyTOjNCYheB9ym5bm1MKN3yiYg2UgutecwJr6DIodhp9nY2Z4GixdwG/cddVMuYrmQ7
 BLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277824; x=1776882624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/IdsrcYcpvwIkeKLjtv2ENG4xhn9aWKyhvQXOQSINFo=;
 b=eC96B8gZkN9ynUb6NJ2G/0fHJqn91NPJV5txbYHG6WSbBtN/UbcIqDAYHFiueOp+U9
 PUBo28RT3quns7WwjfnNWU6XYbkzP750QbJ96LG719kJo4bJnP+CzWiSxLRBvMxwDNa2
 Zb+jOPwPMwZoJnBinceaygTI9bX4sDRcgbiGh3/fr1qv/leAn42DTcanqIuNHyQ8/40j
 fcV0DWbfG4weNwjxYNskXb1yTQga0Qe0oqP5keqdjoyXPaUEdwdeVhVQRqPQqXBBTUvK
 eXLlFa7y+iVJVF4d00ckgAjgZAgbe4dCCqva8WN7z/wYx2S+cx9IHMjo/JGmKLxgNIHp
 r9Sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O8dZcq8h4saP90v0SmYlU68okCMUJfk4M263SgST89srSPhmELewFJbbM9OuPU4SoeEW05HLbNvP4@nongnu.org
X-Gm-Message-State: AOJu0YzsPEVCNR6l8n6jlqGE9naiUjj+Lo1IDA1Slq5JZDU19a1c45if
 YwCLQuSbch4e4N95LzshAeBNwNBl/5CpCnOlPipaCHKbtLA80U+GOMwcLUS0qgk+eUAnrSI4q6J
 wCPmATomEsy7y4dMcUJzYJ4lHV6c6S2Fa1k4HXSP1QEN3fcP+EgmfDTmwOA==
X-Gm-Gg: AeBDieuiPu7Z+p+rdnAUD2nIwZQVUXeBuM5bAlOzGb9ZOzyzjY0zlXrTF0ATdqQCNp8
 dh0eL3WGlLzfieVW8dckpl3G8x5MHjX49CG5gVEiz4m8MtXWqsHJlLV0UTqLJ7Lopkg0joCfJVn
 4I4UCTGAB7odIvxW7vZh3UNO7WqHGYo152MZ/O1w/0+oYYZlNUU6UHE57Il7CzqecbOSCuFBJ3b
 nlLg9TFk5+X+1H8CqoLUxU8ikEXpuJheIfgpscLdSi54bai8XKPsouETET+d1/jEcagJWFkMWkX
 /LM5qXEd/CR1+72Y/xvrr2ZQ7Voa8TIiq3YBsKZryn+ZdMIfEAVWvXOtwBwmw4RjJSgfDLRBQ9/
 8ysu6XLRoma2KfPBeqUZdqzSiV5vrGJ83YAitJOKegLf+YcPPII06CzQg6mD6XgOvlus9KDEV1a
 N6f1ACnnspqg==
X-Received: by 2002:a05:7301:6788:b0:2d1:a3ea:d8cb with SMTP id
 5a478bee46e88-2d5873ad992mr14147024eec.4.1776277823762; 
 Wed, 15 Apr 2026 11:30:23 -0700 (PDT)
X-Received: by 2002:a05:7301:6788:b0:2d1:a3ea:d8cb with SMTP id
 5a478bee46e88-2d5873ad992mr14146977eec.4.1776277822985; 
 Wed, 15 Apr 2026 11:30:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a688sm5121974eec.4.2026.04.15.11.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 11:30:22 -0700 (PDT)
Message-ID: <e6ec25da-03b9-47c8-9256-30cfdb7c930e@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:30:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/27] monitor/meson: Use SPICE with migration HMP
 commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69dfd940 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bQ1BS5QBeQHsm1KAlAEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KK3LEjtq4pzXh0EauCriNNW8LaWIvwxM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MiBTYWx0ZWRfX3zGf5kD2Kzmg
 R16JGST7Ti6VPbJnauDurAtaYbGzY4kU2FJtjPwjqEE9cXZdyYS8aL8o50DeqJjeuEOVxrWQTVG
 VYQ8hIXcO74yjJIx4U/s0oCdvmEuGmvo13oKWalOAse0s312wq2kcsdjBhK6+TjgWAAbju0AH/A
 nDIUHmlXNKFBFlgyK8h60FS+lZLfR53enoXASofsn94z//S2mdJJy5Wdlt64Cv9E7r5yvJICJFF
 vu6bu9K8wsjRqyz9+GI4B+Dt0K7GAIW6a4dJ8Rbril+Vw3IpVMnqIDV2w6BPpMZwu72bZh8Dms3
 h0sTgQ05jmEc1he93aKXzaACGMwBRHgfy4/qC38BJup9lUYDFojTSCq7Qp6NGgArKOVr9rc2G8C
 v3fEr+lGhoNyxaf/xVAlMNmgdRhTNL0breSLxYMWiEpDeSTvlGKEHETOL7W6bZ81hhi+BhrWITO
 AsuMWbzySy0Xb3B9QQw==
X-Proofpoint-ORIG-GUID: KK3LEjtq4pzXh0EauCriNNW8LaWIvwxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/2026 12:53 PM, Philippe Mathieu-Daudé wrote:
> When moving code around in commit 27be86351ec ("migration: Move
> the QMP command from monitor/ to migration/") we forgot to update
> the meson rule about SPICE pkg-config flags.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   migration/meson.build | 2 +-
>   monitor/meson.build   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

