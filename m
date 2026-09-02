Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627ADC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ckf-0005ya-CA; Wed, 02 Sep 2026 00:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cke-0005yH-CV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ckc-0008Dq-TV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KT8a43108174
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b/pNZg736zO3XvyoGqWxYWjFArhvWlOVgwBbISA1KQU=; b=a7EdZWEcJbhbBzRw
 3bpjjm+G+rRSE6NhN+Q747BIYUUq0gcdn+2clv8Bvz5UxREOt6QImLfddPH04r0P
 zvL0Ge8AxazA2KoZ34NBzQel00lCqh5cOWt4R1RMMlf3xip/0GCCf2PhbyW18KM6
 820A4xx1RabS34uACLc91iOvjKcpvdITYVcs5WZWtLE+erJ/HwDYGkO3Vzo6vL+y
 T7dP0j7p7qXpGYqelTaPygj0KjvNSMiiZU34R4qUsC47QqtrfOhIo5EUvG9GO9py
 59ALeXV9MW/CCiremnzqsoRRMBYQxfJSBIJ6g/S1m1GlJln5FrZbp4haawCOtAM9
 3JwoUA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpamst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:39:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so145713785a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323944; x=1788928744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/pNZg736zO3XvyoGqWxYWjFArhvWlOVgwBbISA1KQU=;
 b=hJCBREReqGtMIrQGNQK+l/E1UTGbiQAvPqz/E/InehaWEmDQmBJscKOQntk1cbXCPo
 sZMqpZWK5go3pFU5Skv1eKXnJdegHFg1PrMvmu140xk5Eh3IjU/sEOpTozGqz4lpKo8P
 jnmqfzGo1L+W1O6LawcktZbOQ1usVZcYfgqefYZo86K/A3v0Q50QAK5AtIa03de0caDc
 +HdUyPoPUBUpIFbXekihYPq0m5QWgBfGmvztNXrtnL7S2UQ9P+Iq6qAUphpR7JJEmq7s
 aoaYx5hqPTHGE+JqqPNHOzKNJMnNwxxl07ASitpqBSTo1e7Mbrw6GOWmS4VZRkZ8J0D1
 pKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323944; x=1788928744;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/pNZg736zO3XvyoGqWxYWjFArhvWlOVgwBbISA1KQU=;
 b=B2qJ+6SlH26UIuAPuca1z+4fNR5fwTOWUfXcEke9/go85/YHHDbt6om2ruS8A4gfpu
 xVMxKzVZjMvwmgOt6TTZFLsldC3m/SvTN+XMVsvlO2e6zaFPBJOpCrfEuCx+1sGzYDOQ
 3YgJFgcpw9Mp9C6yp5syHZDb3E4TW5KzEEk/TtsQC5ShMSDl9qTOx628eH+QsUwN0LIZ
 0L1CWREddOM8BGJS6/RU/NyBSW+jlmDWhZJmBBQkkb27ZjWSLJZKt44lo8K/8j8Y83l/
 b0S3EXp9C3mDIjHcWZdxX6037Qi9Yu1dSQS0LioxcXS7jwlUizpDpDJMUQHjv6Hnjg7c
 m9zQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUwjacGdieu5GfGNlzAgTeNENgmUKTZCPD1/HXCZnExOCF+dtbygJu3iGMPm0c2pNjvQlFTqmcu5Dq@nongnu.org
X-Gm-Message-State: AFuF++nhq+98A65Dnq+apLBsFq2NbrbI11sGLJe4/lnT82uRdulluYJU
 U1hlBVf0kCJ0qBjHGp9fKln1QHsdlWfJMz4tRQEsPLXn8PHupDzZEMmF4nJHpZPUBMyqLs9M8zc
 wztCdNcvOIjdjfhwG2zS7fUghwtSIuMjDuk/pdMNPTACHz9ODpeYSxAFszg==
X-Gm-Gg: AR+sD11YNssiNF6z1o+ZAPXcxXcZIE0+DdPok8BVwBfWc6G9mFE9ECemc5vR8e9sob2
 G/ZcUHaBZFYn74O0qQKC22zm7WfgMd33m0B60lzjJVsodEzkbfZGBxzJr0nFcxR5Trwe9hCUQBx
 jiwgfeCor9I/InChjn+QbzVBIjQYUm/JCEYdhyyPsZDPdR7MPotIHxqtd6dlhBByTJeHQiGUze1
 hmAwARxhxmGWkQJAnI/vwOjUg8VRIdJKJDFmJv7QYoGYZpYOcwafrLQF6XfLil850/hHPlVmqhd
 Ox0eb1tLc0d//2UtUlnXMbJJZo1VFR3LagxfD7LXGYVnYH2fclkfAQAxZBdPIJWHKYpACwtzmYL
 oWMcWIhX4zeL0dM+k7NZ95ARx/rA9wMUpBg==
X-Received: by 2002:a05:620a:4397:b0:932:df51:5172 with SMTP id
 af79cd13be357-93960fc55a0mr262908385a.42.1788323944480; 
 Tue, 01 Sep 2026 21:39:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4397:b0:932:df51:5172 with SMTP id
 af79cd13be357-93960fc55a0mr262905585a.42.1788323943977; 
 Tue, 01 Sep 2026 21:39:03 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5936a5esm11385865e9.3.2026.09.01.21.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:39:03 -0700 (PDT)
Message-ID: <eaa0d910-16a0-47aa-90e7-738b4b36703f@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/riscv: remove {riscv32, riscv32_64,
 riscv64}_machine_interfaces
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-13-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-13-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97a869 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 2ILjyNZVdRW6abz5VOdv5KWpdjejFnB3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX6GcZ8xlh7Qpn
 YU9jGNtQ0kdb1IwjIr8m6rTEazFZGuDO7vL+H+MqFG6/FtgZUzQmXe35ZHj7kagiZ8hJXS+CiPp
 VqabOTN/ZLil9JBlq+kyhN9iKJ3Byqw=
X-Proofpoint-ORIG-GUID: 2ILjyNZVdRW6abz5VOdv5KWpdjejFnB3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfXxZGYqgj/gvB1
 XDw23A+ot4chGM/014aoDoPLDYz795uVW7EOdYtoHGiXDSGPDA9/9+l71xfWefmD/Ru9KCZae4f
 P15bGG8uSvfucoG+QWeP+UvvRCSkVZ07kKFeu1BieVnxOHHB73LRmsAsVPFCjct6Gl1fB9jsEfU
 PbIQex+I/OJrIuF58DOOOaryYyhpVTEJxwHhzyB4DyLb2aEON9vx+Iu0BxnXjo0q7eraHRe7b77
 CT8ta4Cs8DL/sVrlxwdbne3vrrSEuxhdYA07ycUnzLgoh4JIo2mej0LvNlaWpBNaF22H7sCaILU
 xzQwH6Cd+kzuMVr8PLCTGhxDvIKYqJKM3D+jjj+uVb1hgNnwuOvMxfKcrI0Leu5eR2fRupuQEA5
 73aMpEcSXlbdvihU8t924fyPkNmxew++QGwi9j/tj0fCjpfr97Pkfzp3Tri6YBzjvzeQZ+0uAPV
 dH5GEd135kgzCCS3Wfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier via qemu development wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/riscv/k230.c                 |  1 -
>   hw/riscv/microchip_pfsoc.c      |  1 -
>   hw/riscv/opentitan.c            |  1 -
>   hw/riscv/shakti_c.c             |  1 -
>   hw/riscv/sifive_e.c             |  1 -
>   hw/riscv/sifive_u.c             |  1 -
>   hw/riscv/spike.c                |  1 -
>   hw/riscv/tt_atlantis.c          |  1 -
>   hw/riscv/xiangshan_kmh.c        |  1 -
>   include/hw/riscv/machines-qom.h | 15 +++------------
>   target/riscv/machine.c          | 12 ------------
>   11 files changed, 3 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

