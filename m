Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iMA0iD/o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwkSMnwE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8On-0000N8-T3; Wed, 28 Oct 2026 14:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8Ol-0000E1-Q8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:29:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8Ok-0003Xa-4s
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:29:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPgu91580297
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WZuRuHz8wgftnTGZKHef/A0yohcIV7BsCmydx7ra7kk=; b=iMA0iD/oX260+jeu
 8uxygKDFKHhIVLB2nK/iAfMuf/8cLeOhospaK8GEWYRsrV30TDxDWl7RkYEBXn9N
 qpdXupPi23BmP4ZC6IgPfLI/+7d5mrCts0VSnwFZ7FHMgZ4OK1XeDy66A5DyPbr3
 xqT0DnmJzQ6S48GhAXZz1/EC7Sq33+/t2VMss0Jwem8AQc3wPPqeifK26qKDEfH1
 G3OSeFbrvIK9r7eG+GVEGECt9X9fhxZt9+PbTS2UAhQ0HKAI8rhjudbNYupSzqaH
 qG55ylSZl9wPvuQB6ksqQGgrsKpR5Q1PGUCsS8hzIangO/455+aXFl8i4mA85WKV
 q3rAfw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp86ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:29:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so2053411c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793212156; x=1793816956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WZuRuHz8wgftnTGZKHef/A0yohcIV7BsCmydx7ra7kk=;
 b=ZwkSMnwE4TqBiOs+vik+mTJ9xgN26GcYsbQUJLGnDN05prPptXSRmDL6OTnFcVLBnJ
 ksEPA46OojLBUpPIIS1BJa1aDoYjz8CQD+iMtrhXHZbBMiMZlXeS4odWU55C/BvbHqit
 1ElVHhC6t1l8vrzOWL1enBqy1S0fIJcVradWK4In+tRvECgzZMPBeikOwy9RA31ZIOfy
 TtrroOSoDJ+KlALyxjqPABL0258aIMqzpv9cC4PBmLaYMVzOtchUn0uAkeHkj3HVAdBc
 vhHuuqOgJJeassuMquScR9L1jPh9pCy6h+6Z1ZWAKocABcRpxsbDsEUSpho5MP9+mq7E
 HI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212156; x=1793816956;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZuRuHz8wgftnTGZKHef/A0yohcIV7BsCmydx7ra7kk=;
 b=A2wkY6ve6my2qG89A78j5v851fncjn5bwUUz58K3yI0+sA9H+QLISDpm3BFHjJQcWR
 iZCS92y3vpHh+206QuTjhIkZlXQqwasSWqfgIEq4BqWjQVGXOz8oEsChTcwoxovJIKm4
 /vAZrEMs4dlM0cNRJKs5XnQ9JWLvTZilcGKROlsQ0DBdqOwccArFp1HT54nGf/gTFMx8
 Io3zY2Qx6WCQxj5Y4DyWk89TPPL2zYs/dTNf+QqqQQcwRgN4PUw5xPIzrKBdY1vUO/b/
 8LwrZk/W0uM8tHbmxxh7gjRRTyHUARcZ3BLCUOA2aNZ6/mJ88jTUKqeBRGtlkUkmja7k
 ka3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYxD1kfP0ZA76/KY8vDCD+aOJUXycZYmD1Bl1J+le6CFSYwdS0Xj2b8hGUnRtigAalxoQHwuxLp1Id@nongnu.org
X-Gm-Message-State: AFq9FYIDL5TP8yQJtRWBiY83Q2EYsxcZ4UZAMHoIRZ508Rp55/SsvX1+
 TZbAvGxyrTAW7qW4S6zavQ2emkE+BOxpUSJiDPc7pyuMdLcrTNcOz8KoLTM7AaPRUdw0vblYeZN
 OSK4u7L4n62FIvIdR1bw/DZQeS9ecaWGL0N/Lp2qh5ySyKVgBnbtHmx55OA==
X-Gm-Gg: AYBFou3bRZHF+u8rSMuzNVoegEPvlojDQHLdnR+6BsRizy69LY/+mmKDvNI0l1SQ7dC
 Jnm3tWP0dOZDqcoXgy6JJ/mesblJxtXWij3p/xV346/bX2lPjs7ct2C1s2LSvCk3v7hIfsuZIWa
 HTmty4N3yBq5fyY80cS6cJtwDotnUFHVWBACG7fqzNewT1PM++GLBEhjER2IvMbaplkPY5i/wws
 txR8Fxlk8lAdo5Y84TTNjSDZmRD/q2QK8Ea31zh1iQTMiD2HJHs/Dzrp6Hzh6yW+UAVJS4Xd/h8
 lP7PXm/4u/Zx7u5IHBiIe9z5bT3KgYVNYz0fEqDapSZY0DNzfdLnoVkgZv5K+rcLSQszZsdCO1v
 XnRNnjg3smKqkgFRoFH5uZJ1mFAXGhr175dNXvFNp6wcdPUsDDG8n1xSZobEi7zr5lVr07DCf5X
 XyJQbRarEDVOfJHdauDbWeGXr35IJTs4sRTZ0VGCIRJGo=
X-Received: by 2002:a05:701b:281c:b0:16e:c820:b20d with SMTP id
 a92af1059eb24-1a6c87bcdabmr3308423c88.5.1793212155769; 
 Wed, 28 Oct 2026 11:29:15 -0700 (PDT)
X-Received: by 2002:a05:701b:281c:b0:16e:c820:b20d with SMTP id
 a92af1059eb24-1a6c87bcdabmr3308385c88.5.1793212154956; 
 Wed, 28 Oct 2026 11:29:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a37093esm6288336c88.3.2026.10.28.11.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 11:29:14 -0700 (PDT)
Message-ID: <f6c2ff81-12db-47e7-a4a6-46e8da87087b@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 10:29:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/mips: Constify and remove TARGET_BIG_ENDIAN
 uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae23efc cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bRRLoD_7Xr9FFaaR4XMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: GjcR9eAskCrz7J7KBa_bpPKcWlAN9eoS
X-Proofpoint-GUID: GjcR9eAskCrz7J7KBa_bpPKcWlAN9eoS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MyBTYWx0ZWRfX8QoMUaZAx0Mn
 Ps7jIaH+n8t/SGREyuyCMOiq66tAGDnq+YlUVIc2W4JzkCm3+oufBBDZiqvoKguktpQ+2PzDdtJ
 7GFqYNod5wWvNx4o+4EFx8jXY0E2cVE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MyBTYWx0ZWRfXymEIb6ajnxHH
 PET4QTGD+2ICGA4RLFflh5E55DjYLgLOPBSOVxMuFm8UeyCxfNuwqZCAHFzIeCdfzGHOS8NpTBy
 fAumPqxcGmI499FgSNr0w7C1gwaV2l5gwGfvtr2tx926qD5P74OR6yr6aOG5g3AToJTAnV64FeZ
 AgSC83B+9KifozQmVctcj/yv0N8Xvu0158Vd8JMZSvQKiukCskcXPZs20IkFYwa7Qoz4WvzMdtO
 wenBe0liNqOTZFcL49NCcEgdLi9SkSYgR3JAVof0AV9kXCPES85ot4+TYcD6PDpU40h3eAUgs/2
 9LslSTujBGgqU4JeNmPvumpKwPq3Cy4cGyXG4ZuZQBcAauDlPaFwG/AJv76xqdLTC/O9Fbw6Mwx
 Rw2/ciGjIcGkqkVkIMTLeFHaQK0w0qCFKmbDuSUn+7JmCzs/O7p94sSSlPaDQrk82Ed6hKqQGmV
 uDYIo/w+1uBZ7wyyjOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 10:00 AM, Philippe Mathieu-Daudé wrote:
> Patches 1-3 progressively constify CPUState,
> then 4 and 5 remove dependencies on TARGET_BIG_ENDIAN.
> 
> Philippe Mathieu-Daudé (5):
>   target/mips: Constify CPUMIPSTLBContext::map_address() handlers
>   target/mips: Constify get_physical_address()
>   target/mips: Constify read-only CPUMIPSState arguments
>   target/mips: Do not use TARGET_BIG_ENDIAN in cpu.c
>   target/mips: Use CPU endianness in MSA LD.D / ST.D helpers
> 
>  target/mips/cpu.h                   |  4 ++--
>  target/mips/internal.h              | 10 +++++-----
>  target/mips/tcg/tcg-internal.h      |  2 +-
>  target/mips/cpu.c                   | 13 ++++++++-----
>  target/mips/system/cp0.c            |  2 +-
>  target/mips/system/physaddr.c       |  9 +++++----
>  target/mips/tcg/dsp_helper.c        |  2 +-
>  target/mips/tcg/exception.c         |  2 +-
>  target/mips/tcg/msa_helper.c        | 18 ++++++++++++++----
>  target/mips/tcg/system/cp0_helper.c |  2 +-
>  target/mips/tcg/system/tlb_helper.c |  9 +++++----
>  11 files changed, 44 insertions(+), 29 deletions(-)
> 

Series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


