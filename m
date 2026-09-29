Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E247CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXIq-0006lP-Cc; Tue, 29 Sep 2026 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXIh-0006kt-WF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:51:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXIf-0007kZ-8Y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:51:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCECBn1491892
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r6pNcaE/ZxmkR2cfu/c90RbDm2TBJUV2IkkO1e7IwAA=; b=HCx5zrkEEFBuatlt
 bWhTiU/sbbbUZKg8SCEF7F/7H4PWnKsWsdyxzfUZVg78swBJGB3jJq8Bzw+WxYpy
 lRbHwiY6PlgEpD/X4dhOjkjA5ykCDws58qSFDnMx3oDP4UFKnGbfMRh2ZbHOjMIR
 ShyiGQkXtD7U6oagP0M1HKUYEjrWiq5Nern49X5f+kz1KFBIjbv1klYn2hPMkWoZ
 gJw9xcdskh5CkojlD46cDviz1vYtdq+EYmv+TCdJlrW+6ZKyBCHjUOLh0iH9kVOD
 S4PNmh9Yw9PloRjEF0odfdqy5bXiJz7PKrWa8vGpibiL03Nj0UYzBtMlBc6gxFN1
 ZKBvsg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4s17p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:51:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so1027313285a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686263; x=1791291063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r6pNcaE/ZxmkR2cfu/c90RbDm2TBJUV2IkkO1e7IwAA=;
 b=U2Hy9i4QsB30T52/1FIcwywRRAKxSC5sOo8PtRcvkpcqJE6lI8w2ykPjwZVZoJPRKh
 NNXDAYF4gKWceMzAdNq0E/2DpGCWDzYU/4+GeQ+ikuBw0pYT5wLsjp7BkrnoU8eJh4Oo
 ggM88JAZqNSo/ry1x3kezWYyb5LTo+sRnrifAgEeiClldyVrKKPMryw6HGK+cEAM0Te7
 JKqn0TC+QHcoWlQT9ifMw4dGT/ERAOuB3GHhxuV0fqafenHNiMlxAz0poxICNwhDcY5o
 pk0x7VZU5/AkXOo9hdzCjAOOJI1rq/EfnrudvD4o5jl+7ji4nEB7Yom5qKpWx1NnLi88
 gSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686263; x=1791291063;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r6pNcaE/ZxmkR2cfu/c90RbDm2TBJUV2IkkO1e7IwAA=;
 b=lqCyY/sgXtaYPnRX3+fbbf4M+EXfK6nB9lYvQ2lZJDRum9XiNI1Ok2NVqotToUjWTY
 Xs/X8tyhLfHFGxI6QqmiRtl0OBoLd4qRKH/LDF5hVNaX02vu4r70uPFaYZ/5BDfVe8dI
 3SSt3Z7fSWHjmKL6+NfdVB0FqD6u9Hf1HgIhkE6v1cSddArt7sIAqgyoNEh5s7fyKrgs
 wE92t/rrGlC8T5sZ7rHNV8KGewvJwd2sdkjeQyy5njH09X7bfkhqkhtcqHbNr0+xzp1v
 ol9hzSgsZyvclHf4vnQQI6JeGx4fNJSkVwrpaRYg0JmUwhtm9rOF/lnpraHrDQJCNzFc
 o0Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBytc6xe+L5lrmui7gsmJp4h4x1DsKOUBZosm+GWMIZdHYhABYJoTP5RSZ1ULJ1Nc3XRKMtE3KIn6c8B@nongnu.org
X-Gm-Message-State: AFuF++lknSI4XirRTyp4lJ1seqRCgI6QScA7aVt/OTKTGqN9LklRmw2n
 fFN5V4KV9DAg5g/xJJe60T0u0bZPS+uoWKpvDCo3ecgvL9NmRNcf1xxq0m8Uxs+xXDAY1il5oXB
 qbA6oRifFHvIPaWRDFN9jNtKBL2blb4ceOPUCN79OPALFw88QW/coraupPw==
X-Gm-Gg: AYBFou22Q58wXX+5wahQ+Rto7G3+KHk1kjP8H7whBKmJy+jerkfspF9JO+jwzMCUyhJ
 c7EjqE/0wYn6MoCfYXJ3SIqbgiBjYs93zyb5j24JUEQWrgmUiDyoV+nhiQb5npr1i63djMVEFKw
 ArGiJvO9ZVetP2GwNCOrMShet5uoLJc8OkOTn7PpTAK4KSJk2tlalu9M6T3KuPDPPgPl7cZkyPO
 CRZO8D8szWUM8yov6DxoydUUziCIP+Ya1RzNDJB/bFnEpP0qQAhaAw60FXxAusfP8jhFOsiaxRO
 wFwNlHKR+d37vxjcdOvimNE/OPbIC2zwMupyvePlsKqdYtyNQiK56zjyAMq01JgvSh5rOrpGMHb
 ONSJggDQXbtEuiqZtvJT3AOrW1ThTSZTzbA==
X-Received: by 2002:a05:620a:3720:b0:93a:1ec:748b with SMTP id
 af79cd13be357-93c43cfd0b1mr2642944085a.20.1790686262847; 
 Tue, 29 Sep 2026 05:51:02 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93a:1ec:748b with SMTP id
 af79cd13be357-93c43cfd0b1mr2642939685a.20.1790686262388; 
 Tue, 29 Sep 2026 05:51:02 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cc98dcsm1368375e9.1.2026.09.29.05.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:51:00 -0700 (PDT)
Message-ID: <35b87a46-4683-4c01-ab0b-870f42a3f408@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 054/101] tcg: Generic expansion of tcg_gen_ctpop_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-55-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-55-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfXxjBNrYi7hsT6
 ZMrBq8nfml9/nRSYfKqHT0M0BqqxiNJN3geDzFO4/Q08lMpvQ3oPbKhBX9iHxLNzzV4bK1xlpzM
 AIAJcZY3CP3BhsDh3Q+QTU4E7u53G08=
X-Proofpoint-GUID: coKMYYpuM54rY61ogxBeeaY6qdrPf3ZL
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abbb437 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: coKMYYpuM54rY61ogxBeeaY6qdrPf3ZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX6G2oREW+a+Q6
 /CZxhuw0KUCCGR5DGNOcR+PXljjBHNpozRvlt1WByPwFcGIWQ41n0gT96VUL517d4ZmY7/qn3uK
 m92M9/sYW6lzj2Y086A/7hhD2UPX8pvGK9zwbiJoWDZiCUaIPoDKkS8q05Ry6GGTZOF5605Oom6
 L3HpeEXXK4Ro0SJM4WG5iXv7z0sa9g1DNJddN73pDeM5GjoDdv+jSsjwrpr1SuMEMkd/6+7t7FS
 bGfAvmNHey0WovB0xb4a2NDaM4t9mR5pIZkb/WlkCLFocKX75LahdB3dsZNacijip8WCtfU862c
 Lj8SAOzAjanMkMcnfO2IoZ+UwKpLJFzutMQjdBg/epQ8rUhbBJcHWE0BWV/VcWmqIuPzINM+q7v
 DMPg1wqbMMLfiAL7tdYnZP2ysaNVMbZWqQGRolz1pawwOCPv5O6Ux73ln0H7725JFo2J8eRRWN/
 H2lloO6P6XDoNoZYARQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 41 +++++++++++++++---------------------
>   3 files changed, 18 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

