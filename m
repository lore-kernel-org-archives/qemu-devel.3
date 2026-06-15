Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6187DCD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4nK-0007y7-IO; Mon, 15 Jun 2026 06:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4nB-0007wi-Pk
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:43:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4n8-0000Dn-Lq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:43:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAImuQ2410432
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CNhQ9AGMnN8F1cIqsszspMDnBvZnFuEHeLILN6wlbYo=; b=OBccwb78zWsklsgb
 BSJYR/JPb8SQUpX0kiX7usGzGzCPhfe614wUSqOOR3Tg+OCSCDeuc/OvjvUblcj7
 l5Ulojo+aYGlCQSyHbhbqtL0PeoEC/eZctftaF9cJbV1gTa6gcrISRA3JUTEbPpd
 7Ao2VIQRQabB0/FVQCzy1nBgy8NzleoDOseima9mAe/CnV+4V5OOT9LUQ0niINM1
 na5DdhXf8tA3O+HKQr+sK64DZF1NlIc2Rdv87ds0HEXUxWKsMHmuzttebkny4kQk
 1zeovAXundxfcmPnzSOZIoW2fS+8r5xjqUi58nMDdD7F72tfbA3oQH8hR7J2PzJd
 X2fZ1g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete980f47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:43:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915ba226a9bso824871285a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781520219; x=1782125019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CNhQ9AGMnN8F1cIqsszspMDnBvZnFuEHeLILN6wlbYo=;
 b=H0TIMZdQZroUHfsN3vwXfvHNh6QBSEgRiQHsGJ5WeO2Z6xF/XslDJY3D3RJqg8VKcC
 VfDlIDC6uAXVyyZtW2XZ6vLmhz6HLlC24sWaeM4eVoqocOA/7RlZ/GRyEbq7WRWEyT7a
 XNKG80mV1SI4UUHJYLE7TyrlJ301U7ueiWQwo4eU0wLIn+8sUsENUFSLQ6ZmGqIMtxdT
 lLrOrkoiLMqJaSaBfoVJ2xomsOovYgGgi6f7IAoWK62zaNGrsvxlFgKeovjRVUf81DIU
 vVzwb/t2OLln9/ycGfJX8NeH9kuzseBlIOmupFrSzrzhiCaujd/BeHU2tjjX8Vrk1F1x
 CMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520219; x=1782125019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNhQ9AGMnN8F1cIqsszspMDnBvZnFuEHeLILN6wlbYo=;
 b=bR63JS//syc2ady5ub2cWuGUJXrRw25K6jhtDQo/9qO0svEx1QnxWP4PSSp5S/OtQl
 FohwvVRXWQ084FFy1xoKKrIZ78F5s7gGwq6h29XvirM10+Ja1nkfX5BmIxOqpJ5nCusW
 A1oR5sgdnl8QJ51U0wAV/Vw59T+2T1o3/4IIxEdx+Bzm2OiZlCqrL6r4CI3lAGAq2yjN
 Bj8zfRprNm8oWE4Hrr8Gm6naAbXgN4F3koqb93I16nZN0BmEYoZkEkPaUXF1M1DiMjEL
 LypISlwqs4/x7TRDEkEfx/J8JkatmBKDWMuX62AE08xOA4BIC3Z1v00iQDguesbwCjzg
 AY+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IeYl209ZFWxtlTvXdPYVUIfLEK7bDLJ4cHnSkZ3T2mKOVkxa72lNoOD/83yzcj948tD8lOe+SuvxB@nongnu.org
X-Gm-Message-State: AOJu0Yw7IPUkeI1B6Kvln6xUucSkXWjeg17tQc4r6vYQv4CudAOkDDKE
 6X1pbCQdntqqixGeOpNx83BXF6JBEtU4NMGvWf5DTBmvtEb+vO57WqMSQwk8ZenDDMrnfcMRvPV
 Xn4G7FAM+mCxnojHhjI5V6SdLHpxKumR74byqF5alDBuDsRDwO+4KB5fjaw==
X-Gm-Gg: Acq92OH703Rk5gHJooaiAS6y7l1RlYrNWiTIbpXVyBmePQtfkHRJhinLguf6vV0hZeM
 CzQzTxiYN3m3KSsSBJrHEumXxE+wAy1SJ1krMQe279qX0faj3aMyONr+dgelWHWKZJWfEdABI/2
 ZGYRQu2ZXGwJYhHWD6TE0jBY4L7ulAAWpk8joNGGrMspwo5PAzq/7otEBAWmx3Q7zXS/UwBVhfv
 62iqoR4FgiHn8+U4XdXhzwHSS3ZIVXqiOaVA+E0A59FH1CTp/bIRk6W0xtz7WnWO2hlHWUfEva4
 K0EAMBxR0XYsTQmlDpyh4TQfzv4/a/syuNQc7AcbxjWm/KEWNhunm3MLWUuS2Cx9jRNByZEBFxF
 o49+fGg6IahT3dIONsTa5nAfhR+gMQ7HTTRD/bD/dn7/4ymnQjyWN4nOz3qFh80w+J2ECUjkz
X-Received: by 2002:a05:620a:1a12:b0:915:9e84:85df with SMTP id
 af79cd13be357-917efcb2401mr1633174485a.17.1781520219316; 
 Mon, 15 Jun 2026 03:43:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1a12:b0:915:9e84:85df with SMTP id
 af79cd13be357-917efcb2401mr1633169885a.17.1781520218765; 
 Mon, 15 Jun 2026 03:43:38 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c01ee8286c9sm156208566b.5.2026.06.15.03.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 03:43:38 -0700 (PDT)
Message-ID: <58ab4c3f-887a-459c-9853-766d899ff78c@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
References: <20260613173350.99843-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260613173350.99843-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a2fd75c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=yeggUV0Jphf8bAPO87MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: riI1SSWtefAWgPiFVPseoGqku4g65JcA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMyBTYWx0ZWRfX2xRZYzlrIU50
 htlSqJN2fhNIXMiEhn0Th4EBf+pm4X4QpbHlYk6FLI204VpSPIFdo3ENrFIUAdxvf18nJhMmnxE
 cmX/z7V89mVJSBtoemdXFblwkojtfu4=
X-Proofpoint-ORIG-GUID: riI1SSWtefAWgPiFVPseoGqku4g65JcA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMyBTYWx0ZWRfX30+SAKMp3gKE
 2IA+xoRE7GnlLk7EfS1wr+LLNItYzP8RG6SjdBiarW/GKbU7C6ejBR0cyquXfkwuJbUoGbC8QAN
 hd1JW2A52w5jAitQ+Ec2sp5Vzk2E19gRegE5aEh9WDUdyp7yknZmGKwj0GteuRXtCXbJVcv//sV
 dpH/oVX2PCOQI0R0+zaWX5OGcs465utYAxMK7lHop7w9WsKh5zgy51SHCkuNgj9bx4LCRJc6ZNA
 ISdxzTvVnzL6vbD96aGfnQuIkQRISrX4PXBGwnpzJEI/hnikvaHDb8cJ0HWPPTfdMU1JVmW8bNs
 x+jNBPdWccs3CaGQsQo0J7XferTJGKukM6IFiaYQr6YlaGdS0ueIQZc1GGcSZrh53fwsWnOMJ3O
 5cdedxN6PXxFRwxWoRKHo6p7yKF7McL59OyUdqqiYy3mdjygXAInRkjMSluVkZj4S1rcemtVhoO
 Nxq5rQn3TQE0w8DMyDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150113
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

On 13/6/26 19:33, Philippe Mathieu-DaudÃ© wrote:
> Rather than calling a TCG specific method in s390_ipl_reset_request(),
> have handle_diag_308() return whether a vCPU reset is pending, and use
> that in the TCG DIAG helper to return to the main loop.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/s390x/s390x-internal.h  |  3 ++-
>   hw/s390x/ipl.c                 |  5 -----
>   target/s390x/diag.c            | 28 ++++++++++++++++++----------
>   target/s390x/tcg/misc_helper.c |  5 ++++-
>   4 files changed, 24 insertions(+), 17 deletions(-)


> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 01cc802eaed..714ff88e0d0 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -95,44 +95,49 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
>       }
>   }
>   
> -void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       bool valid;
>       CPUState *cs = env_cpu(env);
>       uint64_t addr =  env->regs[r1];
>       uint64_t subcode = env->regs[r3];
>       IplParameterBlock *iplb;
> +    bool reset_requested;
>   
>       if (env->psw.mask & PSW_MASK_PSTATE) {
>           s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> -        return;
> +        return false;
>       }
>   
>       if (subcode & ~0x0ffffULL) {
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -        return;
> +        return false;
>       }
>   
>       if (subcode >= DIAG308_PV_SET && !s390_has_feat(S390_FEAT_UNPACK)) {
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -        return;
> +        return false;
>       }
>   
> +    reset_requested = false;
>       switch (subcode) {
>       case DIAG308_RESET_MOD_CLR:
>           s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
> +        reset_requested = true;
>           break;
>       case DIAG308_RESET_LOAD_NORM:
>           s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
> +        reset_requested = true;
>           break;
>       case DIAG308_LOAD_CLEAR:
>           /* Well we still lack the clearing bit... */
>           s390_ipl_reset_request(cs, S390_RESET_REIPL);
> +        reset_requested = true;
>           break;
>       case DIAG308_SET:
>       case DIAG308_PV_SET:
>           if (diag308_parm_check(env, r1, addr, ra, false)) {
> -            return;
> +            break;
>           }
>           iplb = g_new0(IplParameterBlock, 1);
>           s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
> @@ -159,11 +164,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           env->regs[r1 + 1] = DIAG_308_RC_OK;
>   out:
>           g_free(iplb);
> -        return;
> +        break;
>       case DIAG308_STORE:
>       case DIAG308_PV_STORE:
>           if (diag308_parm_check(env, r1, addr, ra, true)) {
> -            return;
> +            break;
>           }
>           if (subcode == DIAG308_PV_STORE) {
>               iplb = s390_ipl_get_iplb_pv();
> @@ -172,17 +177,17 @@ out:
>           }
>           if (!iplb) {
>               env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
> -            return;
> +            break;
>           }
>   
>           s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
>           env->regs[r1 + 1] = DIAG_308_RC_OK;
> -        return;
> +        break;
>       case DIAG308_PV_START:
>           iplb = s390_ipl_get_iplb_pv();
>           if (!iplb) {
>               env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
> -            return;
> +            break;
>           }
>   
>           if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
> @@ -193,9 +198,12 @@ out:

Oops, missing:

-- >8 --
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -196,3 +196,3 @@ out:
              env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
-            return;
+            return false;
          }
---

>           }
>   
>           s390_ipl_reset_request(cs, S390_RESET_PV);
> +        reset_requested = true;
>           break;
>       default:
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>           break;
>       }
> +
> +    return reset_requested;
>   }


