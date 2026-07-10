Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA37C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJO9-0000VE-3m; Fri, 10 Jul 2026 18:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJO1-0000Ut-Cn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:07:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJNz-0001nD-70
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:07:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKt08A1948335
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 edxfYdjs9n2uONBA87GQT31qFxavQckdhkYrChh4Ul8=; b=FELOdaOLCxXkv3KZ
 XXAsO9SXJADdpRU+efcyGc8jVVxTDp+IXRKaWn679ko7eyQYIRXH9VHY9y0EBm90
 3qyOS2YBcGT1xEWqwOf28TtKBl8+x41JT13OGCAabQSZfaSccKslKiwcTeksVMT8
 umgd+3xTc3L/OC639bGY3OOxgZnVNdG/qRUOdJE+NaJqqeRFuVkYN0R+XtOaHATi
 l252F2z1g9PeTqErXb6OMfEE1lZbj4fxLPOnL8APzfmUCzUMZJmQpbxP+Df6FEqm
 wZgnkxyr4c3vh5MtmzfPpaVhEKBMXbUWH9A+QBH1Lv5ylHYuwyl92TDSOT/P2zZj
 3CEZeg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg69s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:07:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0408254aso31015861cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783721273; x=1784326073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=edxfYdjs9n2uONBA87GQT31qFxavQckdhkYrChh4Ul8=;
 b=Pu7EnpqlYQtidmmpqT/+Zy10YM68pdbZUKW3KZTR4VxiFPJpbK1ULUXRtqLpW3DaHC
 nszjtJYHR2xk4F4kEwdNU28LB9uQrGK7bYtnt0inCkzEicXsO6RxrCVwS0m1yPb2TI6m
 V7bdrdZtidcjz8Jp9LxfouV9HPtaKI/Q8s4eONXRDtv0Lik3JU3thMmPvwOd36VRJpvE
 lR3nrOWxJCMpsXKOxWfmtBr8HhktsSVtY2PecxN0JkSRhiOuKiOyEl+pgNGhSc3SfzdW
 5dAwp++kL1CXOWTcJJpu+QQB4F9EXc9Yy2Q05ZH/71xow68JrZDNy6EsMUYN3XghlHiY
 GHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721273; x=1784326073;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=edxfYdjs9n2uONBA87GQT31qFxavQckdhkYrChh4Ul8=;
 b=lPHadwogjY6ebj5M3iQcxFeNsyEVRnyEGz5WbBxFjp1qW4k4zu/UvpD2K3ilxUWUu8
 5P8CL7QZ9w80XHBb3l2tHQ2+wOGAPmYhCbTljKNY0hmF3H5T3cxfDh7r+zpduSSopIL5
 Iz0iSYE8cHHCGafEXjnWlNBIqu012q+4HuR1xEAT/BJOdvEzxH94gMk6MloAMr/rvshP
 WmqfKHRwHUkN6ok/JtApLjhshypM5WR+5QwUCSMQbYC7fNoEoOAIDIJVdcjO7P8QaHTG
 m9k5ydFaVn/dwKu6tljkXvP9KoGmNzI+K/fjwGSqhWQJXLXwvvDaYn4etf+sGx9yM81o
 CrZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKtkShhA0uRNwH7JKjC7K3pEznCUkxkEXy6RHDIhlgb8aNxy+vaF9zb3W2qV9lO1khzub9bmSXOs2d@nongnu.org
X-Gm-Message-State: AOJu0Yz0QEE+czaK+Eak1ec2RRqNfyS4zoMCX0qpUZaQskFaGt01qV5O
 DZ+C+LFiqVRop1lnDpF2/QXfF00LqhqN/xTsMBc8Kc3hKueYfmwVoH8rr55DEWwfZ+ZnI5fekoT
 kLI54LgdpQ3kvcJ/ssZssXjJOpxLJTBSX+THAySb835TY7a6MvTpurkqSZw4FSBQAlg==
X-Gm-Gg: AfdE7ckRrGiDz5rNghF+Ti2keJHGyboWWC+KhMdhsM5ShfKRmOmGtZJAuIW1e0T4ty7
 fFx7UpFuYaBj0662yMRvvcJ2LcmVQ5G6lneOHuSYSTyScNKk7UPUcdVDmrSzXB+hAwwNKWRyhbx
 ccq+NU3DtA+3kZCP3b2sY4K7pPZBdIIRX6YM/8WY/LeDmlT8qppIAAc/djJ76pWf8HVUiBVFtyo
 u7MOko3oi/Zwyk6eKUzqgHZrB0bD90ldXHBzslxz1yRJqCUPVDj7qAgsIkv9OM2Re6Seh/3PP+1
 hy0sAPyFUOt6BfF40NM086E3GDH5XFidbaJlR1Ea4bmOeMVQo7/edXWQG+t65dDczH0rLIZrLgT
 aetPtRbvgRpUbXDakd9WaFd8/ECVMeJS1smpW1uG8xoNOWNBgh0IuFq8/rsMttg==
X-Received: by 2002:a05:622a:95:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-51caa128585mr59399411cf.22.1783721272926; 
 Fri, 10 Jul 2026 15:07:52 -0700 (PDT)
X-Received: by 2002:a05:622a:95:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-51caa128585mr59399111cf.22.1783721272448; 
 Fri, 10 Jul 2026 15:07:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm71829308f8f.17.2026.07.10.15.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:07:51 -0700 (PDT)
Message-ID: <905b6448-d313-4808-b76b-d42f9ecfae55@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 07/35] target/ppc: Implement watchpoint debug facility for
 v2.07S
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230904090630.725952-1-clg@kaod.org>
 <20230904090630.725952-8-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20230904090630.725952-8-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMiBTYWx0ZWRfXyyolCsHtgGjg
 oq2t0J2jMU8GKwiUIcnuA6ogZ4aEJrZE+Fzn/I2/4QgTD9SSiIcnePiHNQGQPKW+r1SxN/pNPI+
 TJOlUhQUTWU8fKzQBfb9eaaiwc5YvMqqc2C+YcRpwAwtnhGax69eLNskbPHYWGamCJLTdpVUkdD
 IssGsft1gJiCqd7tc+yxmdKPRFqB99/13Jnd/Pk+JLkigVeC+kf5kDSpo6vHC1NVD+qDPwXTbBm
 r4BF4+9xysqW6lyua6ZJcqkCmx7FWRvsHa7fCMHh5A1I7hXr1rJaT6f8K7m4+kdbpKw9KucGRHf
 CR8YHFmOKAVFU68obk0NgTmon4d13zPCRkLKUYjComjx9G8aljUmyQaVTwNqcXIhrISOYPo7wYE
 rWyxUzynMKS7AIIubpQ+yWBBau6JbSY46POmkPTHzDEnZb/bMSajnALakn2vz1zQa0waTzNrqjh
 OWWGe6h1/skDG8sPgxw==
X-Proofpoint-ORIG-GUID: EZR4VGJqijK7XCN-PjtgGPAo2TKekmkG
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a516d39 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=aow-egSQAAAA:8 a=MMo_bjQpZDCiIV022acA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMiBTYWx0ZWRfX0LakR2D+pgPs
 lo4Iupen3ffVH5FdOTt4jeBBeaSRFdBRoRbWujy7x0mOlpXD7xHMRydsBkphCy1fxRyNPJiXL6s
 z3cXzv9Fsr5jld15ifxBqqVUiivNkvg=
X-Proofpoint-GUID: EZR4VGJqijK7XCN-PjtgGPAo2TKekmkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100222
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

Hi,

(committed as d5ee641cfc5c3cbd51282d0c6e996f990b9d62a3)

On 4/9/23 11:06, Cédric Le Goater wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> ISA v2.07S introduced the watchpoint facility based on the DAWR0
> and DAWRX0 SPRs. Implement this in TCG.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   target/ppc/cpu.h         |  4 +++
>   target/ppc/helper.h      |  2 ++
>   target/ppc/internal.h    |  1 +
>   target/ppc/spr_common.h  |  2 ++
>   target/ppc/cpu.c         | 59 ++++++++++++++++++++++++++++++++++++++++
>   target/ppc/cpu_init.c    |  6 ++--
>   target/ppc/excp_helper.c | 52 ++++++++++++++++++++++++++++++++++-
>   target/ppc/machine.c     |  1 +
>   target/ppc/misc_helper.c | 10 +++++++
>   target/ppc/translate.c   | 13 +++++++++
>   10 files changed, 147 insertions(+), 3 deletions(-)


> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index d9c665ce1819..62e1c15e3d33 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -128,6 +128,65 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
>       env->spr[SPR_CIABR] = val;
>       ppc_update_ciabr(env);
>   }
> +
> +void ppc_update_daw0(CPUPPCState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    target_ulong deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
> +    uint32_t dawrx = env->spr[SPR_DAWRX0];
> +    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
> +    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
> +    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
> +    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> +    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> +    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);

Is it deliberate @sv and @pr are the same?

> +    vaddr len;
> +    int flags;
> +
> +    if (env->dawr0_watchpoint) {
> +        cpu_watchpoint_remove_by_ref(cs, env->dawr0_watchpoint);
> +        env->dawr0_watchpoint = NULL;
> +    }
> +
> +    if (!dr && !dw) {
> +        return;
> +    }
> +
> +    if (!hv && !sv && !pr) {
> +        return;
> +    }
> +
> +    len = (mrd + 1) * 8;
> +    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    if (dr) {
> +        flags |= BP_MEM_READ;
> +    }
> +    if (dw) {
> +        flags |= BP_MEM_WRITE;
> +    }
> +
> +    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr0_watchpoint);
> +}


