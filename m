Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5AAC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmUnc-0006u1-Jz; Wed, 22 Jul 2026 07:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmUna-0006tZ-Rr
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:07:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmUnY-0003gw-L2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:07:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x4ks524026
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 11:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dLZ/YF1HqtycZwLoxFkLoSsMsJaSh/8XppFQXN3Ks4M=; b=myls1NX8jBfiz9z4
 dVchU8Of8NUkeigo304zgOiS3llrQ7LuKWRQCY150TQ8PQObGEh6pzgJNIWSe+sR
 P3lhqD94XMAT0bP966tHRkDhnfTFfk1BjV32PCV0QfpimKCt90LaezUqKaL0lCu9
 K+RrYyHKJMw/BydcphaH1txElCkh3VdrMeLtJ02AmIBVxZkt293vZWRm+3Dswhg+
 A7O19Q7G4ZwV8xzb42DhE1QNx6oGVtv3bx1qBMTCZjtPVeJ56YZBHUOqHzs1xX7x
 XgNsTxHNxu2cRMWrSJGaAg+HPvB62XlGsEQGZQU8pnPKmSXEWfe1BJY2y5nv99aC
 W06MCA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt12ef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 11:07:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so216571191cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784718453; x=1785323253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dLZ/YF1HqtycZwLoxFkLoSsMsJaSh/8XppFQXN3Ks4M=;
 b=j8AdJz3NB+qv5NG3kSwRbgTEGgEr9GPqLMMVlN/d3WxQ0mki1wdxMb7Mg8q3RL6coX
 wpFeRIp004OASMVfFeiFXucwggmNVQ9SvUnSPWqUBvHXOaZFAeka8HB1gOJMPOSi30Ki
 CyJq35YqO50mWjQ6uHhdq8p2uGUerPbDd5y4yqXNH47weWRy26XlGXKHxG58KjleZAuv
 g1XPJN30CTS2Iitn5dmSJjXFxVkBLYi4ECNOdKlU6pJ1R8aUbkw28VJ/ayTSXIc4XJ/p
 67OEPAf4peZgoEN2kOJkK8MVD7n54nB4os5pS9UN6SbGCmkQCAcCuLgZrBaN/ax9o9+W
 AVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784718453; x=1785323253;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dLZ/YF1HqtycZwLoxFkLoSsMsJaSh/8XppFQXN3Ks4M=;
 b=E4tzwegPCsu0QASzSRfgAUQsARH01/n4wADaX3dh+4WxHhzh/cYfLA73blXKd5v3wH
 +X/yQNuo0t1gQyq1fRmtT/ihZCa+lxO3rH1GZbJiKGs5tKDUH4SsJKIofkQUGC2MKSTx
 5N9Tsj7iE0RQjhxreN9hqZ8fOP6vF54aYNE+jKauyHaOSoE0vmXQPmekkAH9/zj0oK6M
 T114y31znTIUbpqZb6TxMJAY8JYlnXWjAsCkwxkv8gx6qWL7tKLexPis6+yhaqQK733R
 KUltKGS4JA7Qy2MoHSLNHsOj7weeCgHI1lZXKyN66rUCv5rR0zdT/d3IxwgxWyUUELYm
 CJ3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rri83E7F5peaaEJ2L6kdXCyfqX/Cfo1ceLJW2oaTgZ58LFzvF/h5235xI/oIIeLH9bcSNxDjMbT7Gse@nongnu.org
X-Gm-Message-State: AOJu0YxyvL7VXFPkKKP1Qh2xUqkcrMrIUfbOkEx1pPQr7Tuhg4EK+orJ
 XDG/vJhB9pC+F8oRsVpMRHOnBSnatAj26hojb0k7sbG24JwomC49q5eiLhHEo1IlxsDP3p5OaTq
 KFf+so2OY60yk9N2nQ6r/eNZsTazOmbTyyEJp578brp9OzMETNtq1d+UmO/jT8y2JNQ==
X-Gm-Gg: AR+sD12ViuLWOBGgcx7x4vtCXxfJn0BaGmnLKv7ZnE3HwWxGXTnLVSUGY1fA9a1PWCn
 IwoTxx3Sh44InYD9HnAL7eMD+cSeUfUMxSICJ/jbRcPVJ1ZW90bLY5tS93XczJp2uUe89oZeUCC
 dnKMoJMtj9NRsmagxKAfHngeRU5fa7a//JVnmQ5+V7L6HDGD+8dXh+9WXHFqTVa3Qqf5JoRr30Y
 q36Ey6hfVeVJeBj/XN18ZNTqBMPRBPpCZyE9QuABCBB29cDGKddkGPhFQi3UuGa6hyVWZFKCRkK
 lztbWJq/xt6k6VZ1G6ufH2UnVdPL4o3TmRzmk/VzOHIvHeLdFNRTFIPvaCBzkX6aiFo0HzZR8Qo
 e2uiJatsXt+Nwd7bIZFf8iyJoZRl0k/DH1evfRxlH2ZfnFMUMstI=
X-Received: by 2002:a05:622a:1186:b0:517:6804:3732 with SMTP id
 d75a77b69052e-5213e77cf30mr193079161cf.55.1784718452611; 
 Wed, 22 Jul 2026 04:07:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1186:b0:517:6804:3732 with SMTP id
 d75a77b69052e-5213e77cf30mr193078691cf.55.1784718451966; 
 Wed, 22 Jul 2026 04:07:31 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab2f0a2sm42972815e9.1.2026.07.22.04.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 04:07:30 -0700 (PDT)
Message-ID: <90bbd0b0-dce4-4945-8ad9-96c895e712ed@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 13:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/71] target/arm: teach arm_cpu_has_work about halting
 reasons
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
 <20260610161202.2235298-21-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610161202.2235298-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ughG2QZFoNf5kGRFRMB90Wfbn3wMvJw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwOCBTYWx0ZWRfXxwoxQCmNz20C
 iC5bnr6VtF5F9mzrdmaaAxJxDZf2tHl43ZKVNkffBiA+ti4aYGjEeqk/hE2oeGOH17DHOz2neEY
 3DxJBkWTTURt+undcsgLf8CZQcHtU0HIjrBqLIViuLdTXQvcA84Dge5jmnEShFdh/jiyMrkYCvN
 7B3x+wh0xf7Km70P2+blnpKJGoRvb0lHxu85NKO2m7cx3+38Ru08ZEUAFS3g04mRzruP2bren3m
 2fi1e4c/FusN8lnLThA98cBrnNdjoJfjDU+aD6fm4e3x2Y/p9cmA1JmicY/2HONFRy/Yn7dV/h5
 2TKLtmD6EnBrawSz98kqnEyv+qqulJ1648CvGPI+b+uLE6Rt6JncbQpmd2SXkTItD2WfH8Ug2zu
 6e6/NMXZe/DpDgHJMGfAPeyemVAIAXY8Awd5ibWZuRqmB4NJ5QeVB3UI45ArFW7NrntPfJOm4FO
 zBszaKjWHbLQ/o/5e7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwOCBTYWx0ZWRfX9d2vBFh4vpSx
 RqD2xPEm0TV5NRjsY3Pbh+yv126cXPGSu7moYsXOusVKCsmnXIyoJLNcrHUwF6UmArgAGhOzacU
 l2uIMACRRPqIjPn7PRtPMlduBXVIM/g=
X-Proofpoint-GUID: ughG2QZFoNf5kGRFRMB90Wfbn3wMvJw7
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60a476 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=U-1Abfq3Vh_TbXKsFRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220108
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

Hi,

On 10/6/26 18:11, Peter Maydell wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> With the advent of WFE and WFI we need to pay closer attention to the
> reason why the vCPU may be sleeping to figure out if we should wake
> it up.
> 
> Create env->halt_reason to track this and then re-order the tests so
> we:
> 
>    - ignore everything is the vCPU is powered off
>    - wake up if the event_register is set and we were in a WFE
>    - otherwise any IRQ event does wake the vCPU up.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-id: 20260529082948.363931-3-alex.bennee@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/arm-powerctl.c  |  6 +++---
>   target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
>   target/arm/cpu.h           | 16 +++++++++++++++
>   target/arm/internals.h     | 11 +++++++++++
>   target/arm/kvm.c           |  5 +++--
>   target/arm/machine.c       |  2 +-
>   target/arm/tcg/op_helper.c |  3 +++
>   7 files changed, 66 insertions(+), 17 deletions(-)

This patch updated TCG and KVM but missed HVF and WHPX:

  - target/arm/hvf/hvf.c
  - target/arm/whpx/whpx-all.c


> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 21cbd2b1db..b2035b9417 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -2063,4 +2063,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
>                                          ARMCPRegMigToleranceType type);
>   
>   
> +/**
> + * arm_set_cpu_power_state() - set power state synced with halt_reason
> + */
> +static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
> +{
> +    CPUARMState *env = &cpu->env;
> +
> +    cpu->power_state = state;
> +    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
> +}
> +
>   #endif
Why not add/use a getter()?

