Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F64CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGa9u-0006S0-LN; Tue, 13 Oct 2026 06:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGa9s-0006R5-Cw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:55:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGa9q-0006R8-Nq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:55:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D9r4E2173984
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hvWuEvNP+3saozX8oJUV0OWaeiW78/Qzn3EIdx3RLVY=; b=cqnH4UfgXWcyWBvW
 3gUhyGLoXTEio8hx/vDEwfl706fTG/Wg3V+yUJetAYA1r4TxslmppkY6tzQSv3Gq
 KHSXp8AQpsMiTVTG1dTqoaNPUxoPPqHolI+KGVbyiSDo1PQ0iYZRF7SSyqVH579A
 BiDvi//6/GFPY6qfJvbOiy3qfd1uYmpy2rvAQ4+NzIrMPlC9/yJt/kkSiNnVU9V6
 8oI73eU6Ah99yoj0vFJ6GRJlN8bXsHFgfWKM8nouTGtFAGtvfkqgDIKwBgDsi8HQ
 kwCvshFnJKLMrdZdV08yVf6wL/GBPNtUwHaq09MZn/3NCyz6FT+b+dRo15Wb1OFK
 9xoftA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqskys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:54:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so655352385a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791888895; x=1792493695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hvWuEvNP+3saozX8oJUV0OWaeiW78/Qzn3EIdx3RLVY=;
 b=VchrnNfOhGRWzLJSEm07XreFQws2T/BazFUfqhkNsofv3e4wyFPRwF51R5Nyt1gq2p
 yD8yifOVjyITcN3MvZDU0I2oiNLBiXFsz8bVGiGdOVEDv86MoUAiV/VY7l+gANurNP5x
 Bu7XFBQ8A3G76k9pHSS2K6hHXHgBQpcX6S1EKakUZeLf4r9ggiPZnmraWyFVG1DQHzjB
 JTOXQ5zoG/G0+HmofXbAS/4lnb5HsUDzTqzK2TeC2OY+oT81rmLd5T1oGVXeLFtVAQ9x
 E4xIsW77uTQ8IJtlkFa2VTNbEf/IAq/2JmACd0JehDZdw8KCL+PQx/x9RxUwAcSr/atf
 9O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888895; x=1792493695;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hvWuEvNP+3saozX8oJUV0OWaeiW78/Qzn3EIdx3RLVY=;
 b=LHrv2hw+iY9tzewMbIw+f+w0P8Fige+uXRAAxf7kosJsYjKlW3KM4zXcz+rN/mRyoD
 2Vg6+f+jXXDXSyBv8Bhw3KpRzQuDR9YGDqBPhLPb+6vrK3+aMwEGquedCKQihvHIkdGp
 2FPKcmcxWUKRWruCTrzfyLudYdz77TBnuTq6+KTCbCEjMB0hkMiNaZ+7AUy9HSBzKGsJ
 cke8GONcsYpFUMfjK+lzTgLsunBfW6rS8sur76KXkomvMTu3mEKNFbOBSK5DDOZ/rRtl
 2qIuQ3GJrya0Pn3G7gTuVbJd7DPAuzW/+O+d/OyYbONuefalhmihhvqhl5dC3s54j4FQ
 jPyA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTS6KM4DJWnvS1wO7u4aeBUTOQzXLyjy5vtS1/Cf+//O8x1dnN1U2zmgXoWf51II9llH73lPeYTS6z@nongnu.org
X-Gm-Message-State: AFq9FYLSe+8pKim8lUSEMDgCX2jixZ06pdraJbBFvAs+bfebfBtdkWhF
 YE79wwiH0RVGV237eXcCw5ftqSS68kDl+hKd2daHJlse+q8zcmTe/4InaXBArkBL3CRXzXHuNZN
 5bLeSLmsPuBOR/Z7qaI6me4YdxndXrdOW/ZxYgkkLlgeopMTGynedqycSbg==
X-Gm-Gg: AYBFou0uF3uJF4gQ5mSTbShXx/60WSC/V5oTeFescbR5eLrMiMFZ1rytazIRFxBSLpH
 MicJsANqoxHWmf15KcNwLyyvhCWm2yOgGSvZ14ipC8u2bMTVCL97cbQGZP5BTK98fvzoCJbsT6G
 Jwv3U4E6zqVAt1EcYLY7s+jD1Wcu8EsB2JMia575862bPaM2JcCP679QF5L/aCqjrrlqy+C0HNs
 7IQQvTUy3b7Ah3zHfqP0Grn6aD/HC65+7mdIS5AzGHCp89SwBed7F1Rp2g88nmxIM/cQ2q+TnDt
 n853/hMpdjqLCJ3qwG79pZNeg0ft5yXEII5Z5tUCSYfAf8Yfo/s5CT8LJYb2pGMIODhkr+3HJAu
 4hSC6+OQOvhRkkLb4k2jCgL3+0YbKBdvbRg==
X-Received: by 2002:a05:620a:1991:b0:93b:db80:e0cf with SMTP id
 af79cd13be357-93ebd281acbmr2046762685a.60.1791888895404; 
 Tue, 13 Oct 2026 03:54:55 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:93b:db80:e0cf with SMTP id
 af79cd13be357-93ebd281acbmr2046760685a.60.1791888894904; 
 Tue, 13 Oct 2026 03:54:54 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm507270015e9.6.2026.10.13.03.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:54:54 -0700 (PDT)
Message-ID: <a693c8e2-5a15-429c-9427-d8dc68096830@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 68/86] hw/intc/arm_gicv5: Implement gicv5_set_resident()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-69-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-69-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PpG3nrxYMMkERgP9jJoYEsMHoK-YAPbZ
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace0e00 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=ecGInKZYiohcrdBcGAMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX6JAI6rBX84RM
 eTXSvQEKTaKXrdlWmoDbPaElWu1xaZ2LZnC7qfuIJzae8voYuWhcV3tFLs61JbjbVqZAUnPaHk0
 uyvmbt91u45B6WplT9dCjUCmca5ufj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX1TrMrgHy6Nwp
 o17dO42gs8+hTDlPdEkFOuq5lZnPIIDJzWJ937iV3rsiTsBdGAFiB3NzZC94ICFefCyo8o/iAD4
 +c9YCYy4Uwu5FBlVL/eoRr3EFyjQiczJa636DoKcQIhNcBP3Q6xGip2wQWfiJHz0iq2FHC+Wxq4
 YsS427DJAJ0jpnWg6Fl0tapDlH6+PAh+VhmKHP0C3YHrtJ1RNkqVVi806zRL0dXz2s81HzDnG6x
 2KhBGi1VOQBTHj2w0a4A2+85Au0GJte7nCvScpmnMC1AL8V0IiL1eD7CYeax03EI3OrIbJdSg34
 v435ruG5RRTSX+nM49JJy/HzMluV4hU9Ey5WfTsW7eH3rFqG6bF7lDP44wZG59uJH6nrZduIKMU
 np1015w0dDuK5Vn6/vp3FLBuDKefKd0jGInVy1jInYIQmpCphRnPHubBjT5Md1irj/0fc/sFUbv
 87ueI2vV+V9kfPFa+VQ==
X-Proofpoint-ORIG-GUID: PpG3nrxYMMkERgP9jJoYEsMHoK-YAPbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130043
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

On 13/10/26 10:39, Peter Maydell wrote:
> When the GICv5 CPU interface wants to make a VPE resident, it calls
> gicv5_set_resident(). Currently that is a do-nothing placeholder;
> implement the required behaviour of tracking on the IRS side that
> the VPE is resident on this CPU, and remembering the information
> about the doorbell interrupt.
> 
> For each CPU, we keep a note of the current VPE that is resident (if
> any), so we have an easy way to get to that information given the CPU
> index in functions like gicv5_set_priority().  Since the only way to
> make a VPE invalid is to make the entire VM invalid, we only need to
> set this info in gicv5_set_resident() and then clear it when a VM
> becomes invalid or the whole VM table is made invalid.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c         | 115 +++++++++++++++++++++++++++++++++++-
>   hw/intc/trace-events        |   2 +
>   include/hw/intc/arm_gicv5.h |   5 ++

(please enable scripts/git.orderfile to ease mailing list code review)


> @@ -1566,6 +1649,8 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
>               return;
>           }
>           irs_clean_vm_cache(cs, &s->vmt_config[domain]);
> +        /* No VPE is now resident on any CPU */
> +        memset(s->res_vpe, 0, sizeof(VPE) * cs->num_cpus);

res_vpe is declared as:

   VPE **res_vpe;

so IIUC we should use sizeof(*VPE), or the sizeof(*s->res_vpe)
used below to keep the same style.

>           cs->irs_vmt_baser[domain] = FIELD_DP64(cs->irs_vmt_baser[domain],
>                                                  IRS_VMT_BASER, VALID, valid);


> @@ -2884,6 +2985,11 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
>               g_hash_table_remove_all(s->vmt_config[i].vm_cache);
>           }
>       }
> +
> +    if (s->res_vpe) {
> +        /* No VPE is now resident on any CPU */
> +        memset(s->res_vpe, 0, sizeof(*s->res_vpe) * cs->num_cpus);

OK.

> +    }
>   }
>   
>   static void gicv5_set_idregs(GICv5Common *cs)
> @@ -2988,6 +3094,10 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
>               s->hppi[i] = g_new0(GICv5PendingIrq, cs->num_cpus);
>           }
>       }
> +
> +    if (cs->has_virt) {
> +        s->res_vpe = g_new0(VPE *, cs->num_cpus);

OK.

> +    }
>   }


> diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
> index 28417317376..ac85cad3eb5 100644
> --- a/include/hw/intc/arm_gicv5.h
> +++ b/include/hw/intc/arm_gicv5.h
> @@ -40,6 +40,8 @@ typedef struct GICv5VMTConfig {
>       GHashTable *vm_cache;
>   } GICv5VMTConfig;
>   
> +typedef struct VPE VPE;
> +
>   /*
>    * This class is for TCG-specific state for the GICv5.
>    */
> @@ -53,6 +55,9 @@ struct GICv5 {
>   
>       /* We cache the HPPI for each CPU for each domain here */
>       GICv5PendingIrq *hppi[NUM_GICV5_DOMAINS];
> +
> +    /* Array: for each CPU, either NULL or ptr to the resident VPE */
> +    VPE **res_vpe;
>   };
>   
>   struct GICv5Class {


