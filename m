Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D3606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lHrUP3KM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iFJ5U0tJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1IT-0005PJ-Th; Thu, 19 Nov 2026 07:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU1IR-0005OF-Ng
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:31:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU1IP-0007cx-Sm
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:31:23 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBk45J1655318
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NMSeImhOUfO4wq1pEpD3upwea3WlqCrwu+1XCEp7ELU=; b=lHrUP3KMZ2wd7/WR
 9fs1V6JgJmsQZ+3l2WzvVixwSfNYDlT7d5UekOQYUkVAiWSZF2HAcfNXZdLMOCRR
 Gfq5PPYwS4CYNHKz4IuBUPCamRV626la+htmAucATLi1EoocG3jPcBECOQ5vJY9G
 CbPUQ52FAlnmCK0g6mxp6YS2tQ4lX4KHGB4c939cAtFcivgGwdGB4+HM68UPalPC
 RvpEL+SRrlApQDssL/dyKDbDJ/aVPFhdYjxsRxTpjc5D5Dg8N15hMkmMRjUHypKS
 ClviM97HxtdpYSVUkDCAzxiYZ7G1p26Z7UKIltX7GwKWJctdi6yRIeIr+8IN11/s
 chLm/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yghgdn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:31:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-947a607ec40so242203785a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 04:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795091479; x=1795696279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NMSeImhOUfO4wq1pEpD3upwea3WlqCrwu+1XCEp7ELU=;
 b=iFJ5U0tJN+ltLA8uteO78Txtx0WyDmNJR+smi915T+rg2cbWekjs6Nm/xPZQVnOo2H
 CA1Kv0/v/n2aAh7wT+aEBPT0m7fslFx9mRLcHcpGhWoBqsfAmglz9YsKD5SuJpfhqlwb
 QH8GpIlEu9pMwH82BsKNHY7s+L3Ob+FEJMADc4F5Qetq1p0yPVrQEm/FUeOovgFgo+7G
 WVsQidtUbXgu2Yri7/Q7aQFLkVBj0hH2z6XXCRmh88SYu0N2Pg8i+sL3JiDzsBrmtK/z
 Y21AffTuofn9Jr265HPvhfifGO0YAv8qNaiAtzkl8b8HPlyzDvJll/PgBjl3z0u2HGSL
 aVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795091479; x=1795696279;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NMSeImhOUfO4wq1pEpD3upwea3WlqCrwu+1XCEp7ELU=;
 b=d46dSx0Ch61jzssW40ekFoHWoKZtHQzA6j5n8fjuWNFH+wtYkLfPMfZKD0grcfhXt4
 /9cjendFbXxRDBNEOCvvI05e/QgESodRM3TbJHOGSrSJOZaECewE/wakmnokSXOrgraE
 3a0wCSnS1U2XPll8WCKd9nSMrLqnyN++aIaaC0V6MoV+AaWBnYsCtEC4+HPuHWLEy1v3
 TV9qIrMPonIH0PCS1aA6oCa9VPzjA/lMT7u5O8158NiyKj5tuImiJ0+UBbKHYO60IMWp
 JJpWWwVquNrQBRYQAW43IRZgGGQCYtv/NNbmZ0IokSy6wo3PGPZSMTsnNjJjNV+5N+2Y
 UOWg==
X-Forwarded-Encrypted: i=1;
 AL+hErGsARlgGfCSHaqqWXM1rQSEZSyyADzOkqnjMgkjpmRRFIQs7xTZCecnVZYn1SSOsu1HaJZ9VlGq5vaK@nongnu.org
X-Gm-Message-State: APuU4Z/yhpj8SZ0XxzDJSHGUl3+W504+8qKQtc34g19YJEj3UFT7pLxj
 v8G/60w7RY1XIsIdLnkx4nndnhgk/HMwzAGVSnfkGyUGiU0agnlSehmGIbKhsaGL9sXDPhFNhmg
 iaW9NAL3w9+h3DyUovH0oa8OCMkZruaVB6MEUZm9kdWqvwUMgNhqpJbRDjQ==
X-Gm-Gg: AYBFou1TmS2ol2Dno7r+IqmXMh2H0Ym6o2nje0r6u4btcU0T5w191pmvYPRxjDHn8xl
 Pkf7rl/QT6BsJpX3gFyscZ7JZEk4yg5UTUh5B5jAh8e0pZ8F62mpjPDEbxWqeGCmhmPcamxNM0l
 uKnzvKJWOXEEv1PVsiUgjwGp0YI824U7Qni83UXeiRmR+pKLor2A0J3q7b5MBTNwt6ELF8tgefG
 Bp1C/FrM/u0QQ7OCZLt7laOjCayWaMzF4ZhnVBcabOR96lsCaVpJo+1MlKxGkgeMw2lgH5y7X2M
 3ZFMcaKA/j0bJsgGqgxjtjNpsW945YJ5qJVsG3Az0IqRcMnf+KUCdApFPzCnyZnHe+J/o0BniKv
 tv2eu8C5mMJ3zSN6OOMURmhueZm2DLlqLdJF66zjWOjKLFNsmabvDcJSkg5ri1Jueu5/P
X-Received: by 2002:a05:620a:1a1a:b0:949:7f53:b3ce with SMTP id
 af79cd13be357-949995c9e45mr1031193585a.32.1795091478879; 
 Thu, 19 Nov 2026 04:31:18 -0800 (PST)
X-Received: by 2002:a05:620a:1a1a:b0:949:7f53:b3ce with SMTP id
 af79cd13be357-949995c9e45mr1031187485a.32.1795091478368; 
 Thu, 19 Nov 2026 04:31:18 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65609389dsm9880387f8f.37.2026.11.19.04.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 04:31:17 -0800 (PST)
Message-ID: <c95dace6-1c4f-409c-8878-d4c68ec16d62@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 13:31:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] RISC-V TCG PMU correctness fixes
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX15a/KbraPXTy
 kXCz7zH9cqYKKYawQlye6h771hi6ycKENFycJx2zuz+ES6grGjFJbAGCd1iqdJQ1Emz6Ddv8c66
 Xkv/4FYqzuTdN/qg8S4xS/+Zeobejks+LWNeRajJ31l3pRgb8iaw8sAzBswWYJQX8MfIjzqg7HY
 uKQAiq/nnhGdbby8lSarePrVTxRQuoYbvn9C1BOhO/MyxBfUf4nPe8rz3ievZoN3uAnWA3jRld2
 vNnRy1ajgTePY8HFkk3blkgbppM+uqyuA9x/96GxHXD0CtLJENe8uE0onDK6i8pJeNkpghyOgVh
 2ushNWU/2l9gzG6MrIrBrAQqioGmY84Z/msrBDENlVraqY/NiprqfUG15jZuRQoMeqxEkPkQdeQ
 4oc5DMMGMLnMhcoM/DSgpv8Dfj2QpPrIiX1qDRRpK+2VyJ1I1KaTWiugy1wKDnBL8IO6ysMukGg
 tAmJ+gMZzU1maXfI14Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX0S/gxtHtN/5T
 NBluy9WmQMHhPT1MwTKZ1UjrNUoWCKM3iIIP+6bTG8VREpJVh3L4HihZQ6gNaFf6jUe/PyaljiC
 WGXYe33331OXRyWFjocPrBQiQUKN+eI=
X-Authority-Analysis: v=2.4 cv=Vvi2kO2n c=1 sm=1 tr=0 ts=6afeec17 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dMDxPF1GtEdq01UuaR/ERg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=_nmiL5eQyvQyZKiaMXEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: pfQp7jAAZkUxB4KkTT5iDFFQkbMA6QLq
X-Proofpoint-ORIG-GUID: pfQp7jAAZkUxB4KkTT5iDFFQkbMA6QLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190049
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-11-12 10:49, TANG Tiancheng wrote:

> TCG tests cover RV32/RV64 counter accesses, delegated registers, selector
> and filter changes, multiple counters per event, overflow notification
> with and without Sscofpmf, instruction exceptions, and reset. The RV32
> HPM tests also cover full-width accesses through the shared counter path.


> ---
> TANG Tiancheng (14):
>        target/riscv: Preserve PMU state across event selector writes
>        target/riscv: Support multiple counters per PMU event
>        target/riscv: Use VM-elapsed sources for fixed PMU events
>        target/riscv: Preserve MINH on delegated config reads
>        target/riscv: Preserve minstretcfgh on RV32 minstretcfg writes
>        target/riscv: Fix RV32 accesses to delegated PMU registers
>        target/riscv: Preserve fixed counters across PMU state changes
>        target/riscv: Require Sscofpmf for non-fixed event overflow
>        target/riscv: Rebuild fixed-event PMU overflow deadlines
>        target/riscv: Apply minstret exception accounting to HPM counters
>        target/riscv: Process PMU timer expiry on the owner vCPU
>        target/riscv: Migrate fixed PMU counter state
>        target/riscv: Clear virtualization mode on reset
>        target/riscv: Preserve fixed PMU state across reset
>   tests/tcg/riscv32/pmu-fixed-rv32.S          |  90 ++++
>   tests/tcg/riscv32/pmu-minstretcfg-rv32.S    |  52 ++
>   tests/tcg/riscv32/smcdeleg-minh-rv32.S      |  78 +++
>   tests/tcg/riscv32/smcdeleg-rv32.S           | 115 ++++
>   tests/tcg/riscv32/sscofpmf-event-rv32.S     |  99 ++++
>   tests/tcg/riscv32/system/meson.build        |  35 ++
>   tests/tcg/riscv64/pmu-cycle-controls.S      | 107 ++++
>   tests/tcg/riscv64/pmu-lpad.S                |  72 +++
>   tests/tcg/riscv64/pmu-reset-vs.S            | 105 ++++
>   tests/tcg/riscv64/smcdeleg-minh.S           |  78 +++
>   tests/tcg/riscv64/smcdeleg-sxl32.S          | 233 ++++++++
>   tests/tcg/riscv64/sscofpmf-cycle-overflow.S |  58 ++
>   tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++
>   tests/tcg/riscv64/sscofpmf-overflow.S       | 134 +++++
>   tests/tcg/riscv64/system/meson.build        |  88 +++
>   tests/tcg/riscv64/test-minstret-ecall.S     |  26 +
Do the tests need the 'AI-used-for: Regression tests' mention?

