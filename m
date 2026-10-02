Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2665CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWRF-0001ff-0Y; Fri, 02 Oct 2026 02:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWQt-0001cT-Qz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:07:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWQp-0003FE-N8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:07:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6925impP1542526
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 06:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cZcRlbEbQSFkLvG/VLZ4ojOCuFdAe6w46adCLuCG0n8=; b=EPylnJAoLnVOryYC
 r7LzOkbfULEAOYTRh36eekKUr9bWw1RbrnUewrImkcq0G19CB2L7ONuinYMw2m0F
 w35b0oA4j7GE0m9IuJ04TzlAAm2DAa39b+lOOKPS/+AzDQT5R9LN3XwM5TxYZJ7a
 LdIru3pWxvUM1sdW/ptMvCFvtgjZjob4E3qqAOGuxuikpqQd8jiqxr5l8VrATaiu
 WK1rWpgiQgvvLIWJoros18Y1M1YxQzriqMNfveQM9nj+4nEr9P5r6C8icSzK3uSI
 Lc0y6BxdTXnD0CIN2usO1mp96hn4fs0hp3reOApquDqCG8lodFm+wHhhvgAzEzQj
 ISRRNw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mra4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 06:07:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc7a6e4e1so176755985a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790921261; x=1791526061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cZcRlbEbQSFkLvG/VLZ4ojOCuFdAe6w46adCLuCG0n8=;
 b=UO98Nh0wI4vhjATv0HNF1FGfaWeOWCa4u0txRhnQ596CpJCXEB+zV+q5VJOC5zusGT
 N3MCcMX4qZDkW7jqf3X8o9ffZ9P6w7NoKJLt7hZJXTvyh8/0SbTfj9EENBdWq8P9FtAU
 Yurg7mh0KjtfyDuoneASXCLsseUYLJ6Lr2uH1ouqq+wz4DPoP6iVYryDqvxx3UqgQt5d
 +adEE6GDPDb3lCC/FZ6yruSdlYw8K2AtICBZgOSCYpfICM7vMP9SsI2yWHk6qSdRYzrv
 4TrJM+raCMu9+Z2t5kNcBhciXLgyGCWT0QYiFSizHwunmYI8Bkn90eplgNvO3Vy0kw4d
 UqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790921261; x=1791526061;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZcRlbEbQSFkLvG/VLZ4ojOCuFdAe6w46adCLuCG0n8=;
 b=MdPvgIP6jlryDW+Yv7mz1llxG1F8bgw9xVzeBT+jo6K/y/GbkLQumSFdz8pVIBj1A7
 Hpk85/KaQNVseXWoEAIpzhj2EF4eDNcNY/rbBAzJVrzoFpuriwdkSgGUG6avGt/lzwGU
 SZmA3zAxarXsXTZWccT1FxOgHRlgpbdwykcuQScKssEMoARp2JVOknlmFzdnyPfiolev
 Eh4qClKe4fSdw1vjpM9+15sNSFxBx7X4QSoh36Cr9qcX1pCL9rqTOvMwc1N+DZIz73/+
 e0ex+rXr2sGnzvnyLblyQuErc/pvlFKFNklOlyFk2fPYZfuZlKwIJOGEAWpviTNozc+y
 dGMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAEu7lAOW5v8fEJO62N+CXsDwC3yV9YwFN1WYhoUwI0AemGlbpH92JX8fzAhJ8TH9uWNo1ClGLVtBh@nongnu.org
X-Gm-Message-State: AFuF++lxtLy/8q++Yt3rifkzJ9F34YUMdChAFzub9T1LbFD99s8CQ0Zo
 5IpawqJkLHkdGN+4fhLcDbJUNu43Y/t6H9+95Lo5U+6dyXoPCCEwfnnApdWjP7L1/EVPs4avOck
 WkBIuQMCuAXiG3BOzOciThD2JfACqxO2tisUWhwCyydsfsMiQdeXruZ8MSQ==
X-Gm-Gg: AYBFou1ghLlWdLxC1q7Fj1Tce9E7BCR21aDFsAqr8OVeuHykqNKOZyEc5dNQ+8onlCD
 9AveosHJhLLA8A6P9QceUgzC5Gthr1pUsKFAX78+4zc4cZBKnUsoU5Px/k4uqJVWbn54Y+n0Mqm
 Ev4oXNXuJqu7tT0Qy6EU0LRpyXAMkykED43/Muj+VQUUO/RyIPri6q7vgSM1q33O5d5zBA2ldwp
 DZcR83MC1oxhbmqnRAEuyFlp+iwFfVODyCRGO7AZvdU3fy+1Q2g965JoUrupIKrTkqIga57X/Wy
 QUmVA/cg55mAN0kmaxfh+yNpdHYzofMi0x60J1wOYz8TCB8wrE/GaI5po50JRQlPBD48OBf4vS7
 hZOfRjo0fyceJUTUZPsYLaGhw28mUONGVZA==
X-Received: by 2002:a05:620a:3196:b0:93c:b420:c2b8 with SMTP id
 af79cd13be357-93cf1a50df0mr299726985a.61.1790921260585; 
 Thu, 01 Oct 2026 23:07:40 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:93c:b420:c2b8 with SMTP id
 af79cd13be357-93cf1a50df0mr299724385a.61.1790921260126; 
 Thu, 01 Oct 2026 23:07:40 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104c09sm3245573f8f.32.2026.10.01.23.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 23:07:39 -0700 (PDT)
Message-ID: <e310e72a-da6f-4668-be87-21d0e809e66a@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 08:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] target/riscv: Compile monitor.c once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-18-ea69b07afd31@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261001-rv-dedup-v1-18-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyNCBTYWx0ZWRfX9m/53wZQ+35a
 rx4E/9UTi4E2K45483MbNa044lAoOiGwfvDjjoXLdTVv5xCLqOZq951CzofVBbFNsbLQEL1aNYl
 cEyVRHXWaR1r5qnSD4JTJfJpyUZyy+8=
X-Proofpoint-ORIG-GUID: NVxeBhgNy676NbLl2T-F86HLliBKSVa3
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abf4a2d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=yHN9BbaHq1j3JIoPz00A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: NVxeBhgNy676NbLl2T-F86HLliBKSVa3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyNCBTYWx0ZWRfX3tulmXph3Xiz
 p83PQH8tdxHWJ1Hrxy1TLbUzL8/F4Gm2u7RZBDNMv0rDQuNvnGTRLc/rY+KbzYbeUbYdQZCMQ7+
 +WCQVTmlroXgV4aZGmleRApq5/hG0PtLSXRAGx4aTMmwpViskHZxJ18w9Ylb8ZDj1vh9SzdWLbZ
 CZgdM9GrXJBojzVBH9iPnVZbUhy/NDP5s7hnY8zZyBXr5jl77iXFll+Bi40fXMZJiQFFGTSD1kn
 TEM2TXCJc3FY9JlqnQRl61Mup16v3INZqI3mBPcHv8vz/ATPlBXC6wj3Crfyxl4dQ3U3xIl7XVW
 25rhkOHs03J/31qxS3eTT40L0VnL19OjPQWVjN22v1eYGArfUVaqU4jacUOWfSLezHm8m4hSg/X
 D4g98jIIpLdmeUytsoKeVJwt/nxuCjCb0VQowCdjAVoMn+vVx4UbS/zrvPtAUWPJm9gLV0qwQBM
 mzyW7pOtDgwKXyIQeVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 1/10/26 17:59, Anton Johansson wrote:
> Replaces uses of target_ulong with vaddr/hwaddr/uint64_t where
> appropriate.
> 
> Note: This commit will print all addresses as 64-bit values, even for a
> 32-bit target. If breaking this interface is not an option we can
> instead opt for more runtime branching, as done by Joel Stanley
> in commit 409c7d8682a.

This is just about passing @width... mem_info_svxx() already gets MXL.

> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/monitor.c   | 42 ++++++++++++++++++------------------------
>   target/riscv/meson.build |  2 +-
>   2 files changed, 19 insertions(+), 25 deletions(-)


> -#ifdef TARGET_RISCV64
>   #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
>                                   "size             attr\n"
>   #define PTE_HEADER_DELIMITER    "---------------- ---------------- "\
>                                   "---------------- -------\n"
> -#else
> -#define PTE_HEADER_FIELDS       "vaddr    paddr            size     attr\n"
> -#define PTE_HEADER_DELIMITER    "-------- ---------------- -------- -------\n"

Otherwise unifying this header LGTM.

> -#endif


> @@ -158,10 +152,10 @@ static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
>       AddressSpace *as = env_cpu(env)->as;
>       int levels, ptidxbits, ptesize, vm, va_bits;
>       hwaddr base;
> -    target_ulong vbase;
> +    vaddr vbase;
>       hwaddr pbase;
>       hwaddr last_paddr;
> -    target_ulong last_size;
> +    uint64_t last_size;
>       int last_attr;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
             ^^^

