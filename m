Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096B606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o58SIusm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Chzn2Ei6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWgW-0005HO-Lp; Wed, 21 Oct 2026 09:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJWg9-00056R-Ie
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:48:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJWg5-0007BT-2L
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:48:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg1Ei1568136
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4cvY2rgnyN708/WhzFc46mxE40s9Qeuz3hdkAlBffXU=; b=o58SIusmBopzcv4H
 BtWHuFvhBLUPVP4qdthggKCyowV/86K8YYG+V+s+UbbZ/cVK9RFK450bwNkYmHIx
 ng6+HWM6vOUbLXTCm+Xe/pVqufH+Pq9hsp3W1Qp3WeMMKNUCErF8YemBm7W0ZEM7
 MUC68iBnQjau3eKGn1/9Fr/4BZ2Va0AQCrSs2w2Y4DrgVdudm4t+GZ5gOtqpvbkh
 aLmZB0T141ubwM7XFTD2EElSe4+iZ6UennZ//iV3tNIOHaR9bpifE3tWeHogtn+E
 AfNZMCsBmrscSySx9G/Gjovd5c6JhLoK17PRLEoE3jjEvUSoIWwJoKDRlMuTnzFE
 99Ka/w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4v6wq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:48:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso27674666d6.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792590501; x=1793195301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4cvY2rgnyN708/WhzFc46mxE40s9Qeuz3hdkAlBffXU=;
 b=Chzn2Ei69Q4UFIQ4UGFPpAttAP90rDqmUWfIJn8bInInRXLy8d6oEXbx51wg4D5zBp
 4w965xTtYILKPbJFzbkH7EEbnoMycwOuLTlOSygQZdiEMRRwuT6Piq02UkY7eRBAKuSt
 5rlFvg4clUhzVUw/YXU2N1p8yXjVq5201WaoHrJLMJAQimT7StU3IRr29KEBxFncmho1
 N2gcMfCYTHQkb0SD/sGpBCHMEAIMYVN+kn7654lOIoxCvpZeUuS2aQPNbAVIOyrb4dN0
 cRoDC7ThweYlKQJCN3SOIGwJmvo5Tq3442fyc0CCH5T748R3sqG03c6nl6zsIXA6HVfC
 uJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590501; x=1793195301;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4cvY2rgnyN708/WhzFc46mxE40s9Qeuz3hdkAlBffXU=;
 b=NKUPPLRLUHMYZXBTDOQhCwAL4pFzSAzyACm7E5LBz1IHGG1/K68C4dRbYpFcR9KZiv
 OxohuTKjKJyY7wertBf2+gWB2lnPJZVj84P7f25f2J1mz7wvTTWXLbTKEd4bEKvjNjij
 Kn7qdZKvnBXQuGM85MUAfFGdZV0XEQJqckAqQPHN0E5d6tT5XUmzAcL5rw3H0xjWplVS
 +WtimU0fuEW4V3yCamFhcCOe2s3xDX5KVkQrDlx9RthJOf3u536q7x6e8JCpJN/sOhrU
 2DWY5J+NGWJowBjdtROEf9OCc28toN1UEy4WMUdq8eSf4aHtCMOuFSN0JjPv0doqXvoZ
 v1JQ==
X-Gm-Message-State: AFq9FYJ9xd8QN3HsAVsnKqDw3F28QvSS8lizxLc9VNLMhtzZeUF7ewRE
 ZWw5uNiEb0AtqKOahrzxWYV8RyfEPygpQ3LAPLWpbMAKc4cNeVkQgeto5P98eFaOpBFKchMmcfl
 WteVm12ql4J+BVQBrgKjtuB6KQnENd0Rr6dMt2tHYMoIKrNGmDm++ZZMZBUTjdrsLIQ==
X-Gm-Gg: AYBFou1OpSXYi5Oik+0CziNgj+XkRG1YUweBY+7OI5L/cQmUPJlk9TEcnQJkYPj6kD7
 Ptm8DoXFQJobKuHeY/bVbtOuokj3uz9JMzm4u/HLEsFaGmpmgTPmbhL0NhvBbtiNOMHw9xhACz+
 KUfo7Q2xwxpav7Fub4smIJg+sZkjMTohGoAqLNUI1g6ePMvZZG6pGpzgM5uyQS7FE0NhXzjRB0M
 IWuTDyO1xrW32U9x41QYX+JegLauX4ne0srW2VUtz6GMu6zPs/qTkGr7pXdkJhoo96jnMOSll2l
 2wU+YxRb4PnvYY3fd1Zm23KvWCIhZbEATwTj7C1YWdzn4j6aP9xIn8GWNw3mTNpuRv2GuZLjbhb
 VfKeRLxCnDUMaQfzFSZf95IwWEDfxcXnNYr79hSPal1DDbhH4uXV42SNC7gPagVGk
X-Received: by 2002:ad4:4ea9:0:b0:91b:832d:ce5a with SMTP id
 6a1803df08f44-91c12f20711mr35698706d6.48.1792590501289; 
 Wed, 21 Oct 2026 06:48:21 -0700 (PDT)
X-Received: by 2002:ad4:4ea9:0:b0:91b:832d:ce5a with SMTP id
 6a1803df08f44-91c12f20711mr35698056d6.48.1792590500567; 
 Wed, 21 Oct 2026 06:48:20 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10c0f838sm24973906d6.32.2026.10.21.06.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 06:48:19 -0700 (PDT)
Message-ID: <6b756172-f5a8-41bc-ad3d-7445f351dc03@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 08:48:18 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Hexagon: performance improvements - tlb, l2vic
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZelVJrHkxPUxXqLnje7DSexa5QAniGC3
X-Proofpoint-GUID: ZelVJrHkxPUxXqLnje7DSexa5QAniGC3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfXykGdeHya6y9g
 03qORu6ygKM9z7n2zBsBKe3TAfvZR0PbNHjz6u0BV7z9dfumosb35LVyAzzG4WWSsdZU6xp0l0H
 jSJHDcMtQyjZXpM9kYM8TLm8ZOjm9Pk=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8c2a6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dCKMk9F7F6GL16imVxYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX2wflZ44qLlno
 3tVtRRuqHJ3nz2JBLVAQdPbG7glVel1MKcYrs4JMTy0BIODYCM/AJb/OiawSNW8vIP5QZs5LUEG
 40CWqbdsTYYggBSMyLo+oShnZE4rvESuesnuwoSzGxb4datXPBZrKV/9fTSC1ZjGL/eSxdqcB3i
 yHwmFksIrxIlu23+V/Bdt1p+C7iV04Vr4FrZKxPSppPxX+9UPUjYvLVBIMqqFsUoUgDFiH0tf7W
 R/LBqxeA3YjpeLAvJTRTZ/PR40I1yZr9qrDKqLByQI1Hmp4VYZTuKlYA/KnGdASCxnntAfKuGHs
 5bdy6CyQNmvgTacDLFyzgBg2oTUJWWdE4oltR8zFBbFjEMfQtdnhcQNORr+SmnncbotwjTIKhwA
 MTysymx0rM+aVhjuFzyPVgQzYhPz5t1IIb1BZZXCG1/6E0IR1EOvYjmw5ndz7pJNyLs9Vot26bX
 KF+ud9YD7G1ELT+5EJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/20/2026 10:15 PM, Brian Cain wrote:
> In this series we have significant performance improvements for use cases
> like booting linux.  The gains come from avoiding redundant TLB flushes and
> optimizing the critical path of the interrupt controller scan loop.
>
> In v2:
> - clarified the comment in l2vic_update_all()

Whoops - forgot to update the trailers before sending v2.  I'll update 
these for v3 or the pull req.


The only one without a R-b is #3.


>
> v1: https://lore.kernel.org/qemu-devel/20261020151720.728888-1-brian.cain@oss.qualcomm.com/
>
> Brian Cain (3):
>    target/hexagon: flush the softtlb once per tlbinvasid
>    target/hexagon: only flush the softtlb when SSR.ASID changes
>    hw/intc/hex-l2vic: find the next pending irq a word at a time
>
>   include/hw/hexagon/hexagon_tlb.h |  2 ++
>   target/hexagon/cpu.h             |  8 ++++++++
>   target/hexagon/gen_tcg_sys.h     |  3 +++
>   target/hexagon/helper.h          |  1 +
>   target/hexagon/hex_mmu.h         |  3 ++-
>   hw/hexagon/hexagon_tlb.c         | 18 ++++++++++++++++++
>   hw/intc/hex-l2vic.c              | 17 ++++++++++++++---
>   target/hexagon/cpu_helper.c      | 17 +++--------------
>   target/hexagon/hex_mmu.c         | 28 +++++++++++++++++++++++-----
>   target/hexagon/op_helper.c       |  6 ++++++
>   10 files changed, 80 insertions(+), 23 deletions(-)
>

