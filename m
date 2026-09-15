Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6517AC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HOd-0000P4-Sk; Mon, 14 Sep 2026 20:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HOc-0000OS-18
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:51:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HOa-0004f3-9G
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:51:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN03tl1813057
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lg70FpsVKvCHqIOgr8+MV6Z26h0UIAiXZ7Pcb2AjNYE=; b=eMNbgjAlnlCwZo71
 zHIO7N1oU4O5UyJq9yGmvZbqR/1DC0E/l/Rg7Qa9nBAqbzsS1R8EBtl1iiib8yI/
 /G4f9irEcblwfHdDuxfD8EDn59XT9EXqDMLgf1F+4mnZXdIXRQbws9ffQiDHWYOv
 ShpbAdTWNo8acpmpQa61gsS8zWHyFfoORo7A6XJFBso/PcPWaa4Iqa05dTRoLT0S
 qqeTyIzMOVREbmkh3fcmWP9lQ/B2hbpkQCpcyHXl+ne9KRwV6uiBX1vzhgvO/2UH
 dWUot4ZBzMuC5aYkB9aJkuz9niabMOp0xgxkysQyyTuxCgr3DRWyOz+xBC4g4bLq
 zPXSXw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtjrps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:51:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso690756085a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433492; x=1790038292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lg70FpsVKvCHqIOgr8+MV6Z26h0UIAiXZ7Pcb2AjNYE=;
 b=G8D+CFKH6HlqUHEsL1LRdl4YnDc6Bu2FujuNL4x/ZQIeFqgmvMTe8wAYNQVzhxvnRi
 UHttp6UDiycy8F1PhEfDwFtJPmDcENJyQ0swU35AlxoaXPjqV9rYBhfkyBWJ/iDGgjpN
 FwLFLMnDEccgt8vUYeQsjmTUS+OFUPvLFxPf4pi1sl7rU07T3V71flB8GHsQxYXj6kQf
 ykaCoTSquqmGVlneN6iPDhJJP8L8dYIL7L4agGXqE/mBD/9ri+/anTMGryuF6xB5RRvj
 RW2azMHoBWPMSpzYScVJ0RqBCegs6huQ/iMOW1WURJQsu4E3vNf4+eYjiXw1j/h56KUQ
 MUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433492; x=1790038292;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lg70FpsVKvCHqIOgr8+MV6Z26h0UIAiXZ7Pcb2AjNYE=;
 b=ZGcrIyDXXU095XfV5LP0Yh8i0jxPTlREnUY4ztiTrDFytqqxu+JZcPkTgk+dXeDL9c
 9Vy8U2lMVM5sdXX9pnEX6rTCCZso14EnDcPCRIAY5FjAdh5Ftrz5rei8nuTH08gOzuv5
 KZbRai239m5z1IQSyFAxMpeQjGCcJlPwZYjLoWwBDCd6FE9QbgaUv02rJoxuqjr5d5Od
 RK6bk2PPamn8zGMrVB/+ASiJ2EpXwqZ8E/MOuhbi2Eqy1n/SrRPByjh3SaQgtldaQH7/
 D4g66/s/ubFftmUgzAe5sVYIWyh4hGfwnMcczzgtoxz/ZsQHU5oQLGSnaczcsdGr8bYI
 7tLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBykjFLZ8evWmCEaWMZgi7HGYrLTzhkcBrpR7bMg5/7PCi7DY7iwRTXAaQb+Dqy1xiBJlwk90p5dN21h@nongnu.org
X-Gm-Message-State: AFuF++lsUvWT6cD+pPBxJfnZ1Bsj+812zxgZN67ESa1BCDSyuHIfZWyf
 LQD/xLKMqmP3DPudx4RJAUeDQbMjR+V58HlnYJFu7UIky6/CoiJAMq5lD8IiXPZ8WCHDv0n18OS
 jnck6gKfpYvzjGAoIYh6YZz9ittr0ZWNnDWnPhBSi3fRudNoeu7jVZX/DAQ==
X-Gm-Gg: AYBFou1EH/JcO9Uir8yGbk1BoKLl1rWIIiWMPW56TXphN77/6AUyhzU74//l9DYySCE
 5buVfgsZdHOVsAMhJH2ZMppw/Pdny7HuvKRsYC6SBWjrXbI01JXrGWDmi1sA3FDguwi9BvJKEEl
 AsCInpY6LDqx3dchzNAk1LuJihXNRkaL9VOHjxv3xQbQhqTQPbwYSnuBCPL8VhkQ1s1yVr/JT6K
 EISo/e0QJFcoDCx/TAYNOYTBhL9eh7GaEoWHLt8zHFplAxxmgCL7mdeQQwK6jfAgW21e2+NVYVk
 kAh0CAm+WrCwVM2lcAmDGtcYON95upqaLnD3QubQAq04AkLjIRQZikS45qoMQsxooT2hAjNAdqx
 70OleEG+CDHIEG7HticTeSY8h0RgRQmJwym9Hc3ZlyUk+uwupjju6EYI0R8qx
X-Received: by 2002:a05:620a:2b99:b0:936:cae5:8b38 with SMTP id
 af79cd13be357-93a29723e50mr734243685a.10.1789433492427; 
 Mon, 14 Sep 2026 17:51:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2b99:b0:936:cae5:8b38 with SMTP id
 af79cd13be357-93a29723e50mr734240585a.10.1789433492002; 
 Mon, 14 Sep 2026 17:51:32 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-226-168.myvzw.com.
 [174.226.168.16]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a00da28absm851668585a.27.2026.09.14.17.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:51:30 -0700 (PDT)
Message-ID: <b6cebc02-b41b-426a-80ea-4ec1688762f8@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 19:51:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] Hexagon (tests/tcg/hexagon) Add tests for vreg
 multiple writes
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-6-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-6-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa89697 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=HnZmebILR7CVcA10YZfY7g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=AHWM3inkkBYVIfo4mQAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX6VWQmCoeVO3q
 ONAL2S2zDTMHUV5VpkVYlF/vzWeyAUilW6WxptlnGo0wXKUd4RrffkE+shQC+30khSCfl0B4lQD
 AqMZbL/+WuJPQq93Yb3899wRxFiveovOmAGZuZ87eUmdCbf9Q1L1gZjE6c2UdlYQfSEK9ziUTA9
 sViQISvNofgxPOGM/4zMqPF1TcjCy796iBCZEYwlREuKZQLaeCyVlzY1dlnUtCeIzln7SWbaHKX
 SPhKaLnn1zpjN6JkReo4o4eQRVYSKa2m2rj0Y6RBAdj+nqgod/5xSbfWWdUcUooisSBbC7/ZbSr
 lLogaDYYMznluzttmpPJsKBkn06MBSdWZdGkxkr798zHF/1TTxImfnpb541jmU9T5DPDDQxjXVR
 k2GtW76hjHw4CaBcrWWqA1H7N7bOtgXOL6SjNGmXstYRc3YF25IT9LD0wesl8+Amo5N7vEMZVto
 K/q4GT3eugsZMK6QTKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX97cunuFdncRo
 qvV+/nGI/WXmDGD+3OobiQgxDfR5jkHedLjCtGKeAvXsiTnIP5oiZRUOurPtWNdjKYqCdWzRDv2
 yF3VN9oUvAHFmPCZ1lbD5EVvOH6cbKw=
X-Proofpoint-ORIG-GUID: PrqFrBaMkva5PdpwBVr3FGaZVUoQSg5H
X-Proofpoint-GUID: PrqFrBaMkva5PdpwBVr3FGaZVUoQSg5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150008
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/14/2026 4:50 PM, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



>   tests/tcg/hexagon/multiple-writes.c | 66 +++++++++++++++++++++++++++++
>   tests/tcg/hexagon/meson.build       |  2 +-
>   2 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
> index 4305903547..62e5828a0a 100644
> --- a/tests/tcg/hexagon/multiple-writes.c
> +++ b/tests/tcg/hexagon/multiple-writes.c
> @@ -199,6 +199,68 @@ static int test_post_increment3(void)
>       return sig;
>   }
>   
> +static int test_vreg_legal_predicated(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        "r2 = #7\n"
> +        "r3 = #13\n"
> +        "p0 = cmp.eq(r2, r3)\n"
> +        "{\n"
> +        "    if (p0) v0 = v1\n"
> +        "    if (!p0) v0 = v2\n"
> +        "}\n"
> +        "1:\n"
> +        "%0 = #23\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "r2", "r3", "p0", "v0", "v1", "memory");
> +
> +    return sig;
> +}
> +
> +static int test_vreg_illegal_mixed(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        ".word 0x1a004100    /* { if (p0) v0 = v1 */\n"
> +        ".word 0x1e03e2e0    /*   v0 = v2  } */\n"
> +        "1:\n"
> +        "%0 = r0\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
> +static int test_vreg_illegal_uncond(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        ".word 0x1e0361e0    /* { v0 = v1 */\n"
> +        ".word 0x1e03e2e0    /*   v0 = v2  } */\n"
> +        "1:\n"
> +        "%0 = r0\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
>   int main()
>   {
>       struct sigaction act;
> @@ -224,6 +286,10 @@ int main()
>       assert(test_post_increment2() == SIGILL);
>       assert(test_post_increment3() == SIGILL);
>   
> +    assert(test_vreg_legal_predicated() == 23);
> +    assert(test_vreg_illegal_mixed() == SIGILL);
> +    assert(test_vreg_illegal_uncond() == SIGILL);
> +
>       puts("PASS");
>       return EXIT_SUCCESS;
>   }
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
> index 4a2826c427..08c6e34c20 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -54,7 +54,7 @@ tests += {
>     'load_unpack.c': {'cflags': cflags},
>     # Build this test with -mv71 to exercise the CABAC instruction
>     'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
> -  'multiple-writes.c': {'cflags': cflags},
> +  'multiple-writes.c': {'cflags': [cflags, '-mhvx']},
>     'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
>     'preg_alias.c': {'cflags': cflags},
>     'dual_stores.c': {'cflags': cflags},

