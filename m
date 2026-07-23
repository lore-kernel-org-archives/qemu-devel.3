Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64D4C531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wms4R-0003LC-78; Thu, 23 Jul 2026 07:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wms4Q-0003Ke-0X
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 07:58:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wms4N-0002Dw-52
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 07:58:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qTv73260940
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NK4dhrme4XrzquhYr7cLM+zPTtgLCUpN/ePFbxvjOwA=; b=PWd2QkLsWS3i9wDo
 jUVXmg76VRzvPgQmBwg3F5Fn+x+crLj9xq2PgLz0AvojrUlE+pb6zaj1O8YI2MQL
 sDLBJra2zPqd6F0nzX/S4/SthlmqE9PcoV0lFYRG1Xj6MzNS5dgav96zR/kdgNZE
 wXXHDGhj1vKhoAWP8nJlFcaFdC0VgSudSEw6XYwm3dtNCxTqQ4/vm59/TwXZa2ZY
 sWN1NnWcgrBOHkhkzg/5/aNYYDfF65nIbp5pGpI212UovhvVooCq1jztyljbigNt
 LNrOEVwLiaBUAF61liOSzwhATr+Quhw0Owu0cwa6XhlBG2nkYiQmZD4IJ7wDlMPW
 DdCHUQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkafw20sh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:58:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eec6acbe21so16691046d6.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784807907; x=1785412707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NK4dhrme4XrzquhYr7cLM+zPTtgLCUpN/ePFbxvjOwA=;
 b=Pit/ARjxBKlmkysgG/LuXQBheDeF7MUZotxJTOWJRScIOX/3fGjachmSg8omIvOc2S
 DLhFLzVTJcW0Xu0Zt1jAgRP1E4wXyLRtqveutuiWdpEvhyKsv7dmV1cZ/3V1asLh2WV6
 8A77SA5e7w4rgJGyt5qHqm6lioXTYYM0RqRS5ADnqeLalyxnt3Ah2Iv712eY9dRhadmB
 /c9k7rVd6I0IhJhlOFQ8abhFZMbTReqTCqjDu8HKfD/MJbHFsY35LYy7XMhrOGi7WoDC
 Eb2kjyDH5KkY3wxiewGSrO3myUIKlhPK9x19toGaJlV7QYMPGeBr9L5t1vI1gqWl6/6H
 c8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784807907; x=1785412707;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NK4dhrme4XrzquhYr7cLM+zPTtgLCUpN/ePFbxvjOwA=;
 b=pZNZJZSNF28gtCZCpOBuKdI6A/Y41TpuLPfX/P7oTZuJepz7CBk7W85un+kSQwxn/v
 ITING0DGk6KFmYvLcz9uEEdYoD5sa7jL2cxbStDzqorspP98qtkU+0UGO14C6pNCZfPl
 MzY82dzvUcybRUQsCu6I+YisSWN6KpKnPqYo7uIZBz5sOLPh7T3m7xZJvl9GfKKDwRbf
 Mk3TsyLp9/6ftUrtVMqhzcjJ3/1qJq7yKWUd3hqQcHnT1ZioTJVtW93OljK8nOBaJzav
 qbNfaSvLO7wB3kPEGQ+b4fDsde/EWNPEBbxLlgogKQPlhDFIzqEsole1AWWLKLgiECHV
 YN6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9uUY5NMA/wY+/55rcKuv65jJI9Du6oLu0zd0zq8It4Y4jV8WZNSVHIGbik0/o0p56O/42TOcUzFYj@nongnu.org
X-Gm-Message-State: AOJu0YygmCQqs8qHLMg6mF/RFqk5hWfpQpmHt9Bc4I9msnNitEpPvl1V
 7t6K2RV/+/8HhUoWPR6DtfFbQuCiMbsz++1Dv4YYyCwIslPkMWZazeqYLEeeImiuEiPSMGQ8rf8
 uFZ5LsjZ+fG2lbbBBgsJyFNjVml1bpRwNVklu4Cs+JYlIrzPSefsmt1RbsQ==
X-Gm-Gg: AR+sD10Gorq7gBmp1btB3+IjNiIG6TzwpZzKqSZiaBRRwKZdDSWxtQVJ+lHF3ZB737N
 nvNYeuEDgef2G/kXLjPK6XiT3aRa4c1WvcPtdwhkBd+adVq4Fk/GRYc184nBlCPZVCCx8be+czn
 GYABeDNRrEHHQCCyo3fmYjI9FVsJ0bTJ3RF/Lz3XV/de/i96caDb/S+YgoWbu61tKlVYuAiCcLF
 P3du2c5t751F6dFDubXXnLW6I6gPBmrKY9rEritYsyUs9JwcqetibrNZFEajU2M6cC7EqOo0TAe
 ETYQ+7MWKHytQXKHhiwTatPB5NJP+/ZWsjeu4gB5L6E4bqdVQ44cB96NRF8sdoaMiJAQulzVQu0
 jM3seetYGWflRDmC8olggLt+ZEwIRViSnbQ5TbQ==
X-Received: by 2002:a05:622a:c85:b0:51c:88b:d7e3 with SMTP id
 d75a77b69052e-5283dda2c48mr23464761cf.3.1784807907332; 
 Thu, 23 Jul 2026 04:58:27 -0700 (PDT)
X-Received: by 2002:a05:622a:c85:b0:51c:88b:d7e3 with SMTP id
 d75a77b69052e-5283dda2c48mr23464411cf.3.1784807906847; 
 Thu, 23 Jul 2026 04:58:26 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907baa0f4dasm43209446d6.41.2026.07.23.04.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 04:58:26 -0700 (PDT)
Message-ID: <ab82b172-e605-4a16-b0d6-865caa839b40@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:58:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: use SXL instead of MXL for read_sstatus
To: Abhigyan Kumar <314abh@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260720105612.953478-1-314abh@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720105612.953478-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XNkAjwhE c=1 sm=1 tr=0 ts=6a6201e4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=bBBmsoVW4sAyd_EGzYsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: yavX0mHmcvqzI6R3Dv7CalCfDqDKXEB8
X-Proofpoint-GUID: yavX0mHmcvqzI6R3Dv7CalCfDqDKXEB8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExOCBTYWx0ZWRfXynN735HtHgRu
 mIri11ERh4/bknUWxmHciQAaXysHkOEnctbwOdLl/osAepl+3XBPffmvqs3N0LmEZBZvUPTzrsy
 w6sJoy7D/4UBjDBAVH+tQ1OZtW+PcIs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExOCBTYWx0ZWRfX19DEacDMJovD
 oxIlV+cnEvfVHYaSBxXn0HUUc9lpI4xdHWNuNy9SFCvIPtCbx3jF5PLyjXP5VuLh0txKNBYogUD
 TpXjNh6aBt7TXKxPMY0zYF++rlZM5iSmYsv/WjC3sv2KWQ35vzHVzi0+WFbtnzeMK+VeQVheqWA
 gBRWPKD57pMkYAzD6/39+xaGmb9LxOErBJykJFcQ6ekskNfQJbj2h5rUT7QIJgCmml65t4mqSr3
 /HvgfB0YM4gEAElWMMnR9NMsfxeRTevLPMvqKVSJIEu6Rhj+2gk3Spn3F4YYdbMWt2unDLZcE1A
 7AwDE2VQ+995bnmKMh/1SSLakWTOEpie+5ta0IvKXKq2TEJeQraKlH4njydpnKqGM8THumvudcl
 iaAfVoimDOB4fUIqtlLPNc/0AUJUHHAjCu037orOyguUclazWMjjkZrn8z+5i/hKcTQ39UdboTf
 RQvUFUL2bTaqmWPfZdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

On 7/20/2026 7:56 AM, Abhigyan Kumar wrote:
> According to the RISC-V spec, a 64-bit system can have M-mode in 64-bit
> with S-mode being 32-bit (SXL bits or mstatus[35:34] being 1). In this
> case, read_sstatus should use SXL.
> 
> QEMU doesn't allow changing the SXL bits in mstatus in M-mode. This was
> because of the missing MSTATUS64_SXL mask in write_mstatus. Now, both
> the SXL field in mstatus can be safely modified in M-mode and
> read_sstatus correctly uses SXL not MXL.
> 

Please add:

Fixes: b550f89457 ("target/riscv: Compute mstatus.sd on demand")

> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---

There's a style nit that checkpatch detected:


$ ./scripts/checkpatch.pl 0001-target-riscv-use-SXL-instead-of-MXL-for-read_sstatus.patch
ERROR: trailing whitespace
#32: FILE: target/riscv/tcg/csr.c:2074:
+    $

total: 1 errors, 0 warnings, 21 lines checked

0001-target-riscv-use-SXL-instead-of-MXL-for-read_sstatus.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.



Other than that LGTM.  Thanks,
Daniel

>   target/riscv/tcg/csr.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc..b67a5a301 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2067,6 +2067,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>       }
>   
>       if (xl != MXL_RV32 || env->debugger) {
> +        if ((val & MSTATUS64_SXL) != 0) {
> +            mask |= MSTATUS64_SXL;
> +            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
> +        }
> +
>           if ((val & MSTATUS64_UXL) != 0) {
>               mask |= MSTATUS64_UXL;
>               val = riscv_write_uxl(env, val, MSTATUS64_UXL);
> @@ -4014,8 +4019,8 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
>       if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
>           mask |= SSTATUS_SDT;
>       }
> -    /* TODO: Use SXL not MXL. */
> -    *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
> +
> +    *val = add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
>       return RISCV_EXCP_NONE;
>   }
>   


