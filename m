Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E21C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1W8u-00032l-C1; Tue, 01 Sep 2026 17:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1W8n-00031k-Sl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:35:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1W8l-0008Oa-3K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:35:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTG9f3664083
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 21:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BUWquQaq3GvcAD9FUO0RusH2AWXHQ8v8k5dH2+OpDpE=; b=bzrnH969XDokTC4G
 ugzqPK8xQYWn2TH1Nlobu0mMx0U17qPrbj5vSdw42L4J2DkXP6wBKQ9Dy2UZvYtf
 eifXtXXlYFv/Sln/nG972bMoV6ZrfQLtjxbydNzhrczP4O+g+jnsW+8LWWaOZOPI
 SO77ykokGb8ZqFEy9CEQhE/Zgs30qlgaVEnJuYqyDb6oIUJ0MiL0IR5OlTdwR7WT
 y7TxgoXSzavSbh7SsIWvc4HCDzfmrYWpx+LBYsWt1HfiMT2Gj9bD+aldCBzxuirE
 n4AiZ54R+Vy6aBPYgLdPATsHIeisXp4rlJNUh++v9CMnLSWSaJrLP5z3D4PwMett
 bNLaBg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j0xjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:35:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530006c6d43so5969381cf.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788298530; x=1788903330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BUWquQaq3GvcAD9FUO0RusH2AWXHQ8v8k5dH2+OpDpE=;
 b=MN/Lvt/TsOLjLjpqbInHIk+JwM61IgI7CG5plpwAAOBP97DxNBNJttwA/SffVszUUV
 OgEsZOJZmVv4UzT6fXh8gZC1elOW4z208JQxt1+wBAFEv8SBUFLrl8AVvv18h/dFdtQe
 /2nXFwEViunqaAUxZCDKQSjUUgNNFpcTMWAVKabD5iKxz0J6maEROdWfXUssonIikFDR
 UPbr/wTGsjznxcXgTRrJi5vucPqKyH9lkVOwRVvOjSrUIsO3vC/1Vjy7YRv1IGLp5Oor
 oTyLimesy1F/IAgL/qwgYj4rfM4Fv6FtZZZgu8y5tbZf9OL4Aqnewfd4J5uvkZhcFbPc
 Mnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788298530; x=1788903330;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BUWquQaq3GvcAD9FUO0RusH2AWXHQ8v8k5dH2+OpDpE=;
 b=CtTK3VPIPll/2XjhYu9k1Fb+21waRsZ/iyw0wIeIoJ6aodEu5OGt+XgLceK4FGPPet
 kbn2prAXHbt/ZJRk9/JGNvQ37uU/pQkWPFnRsSSpGzsvwjam1gGMQwkJDbpXMNS77Z2h
 ApZHXFoKeYkPZRXTcZ0GAWD7ujjx9HhPfEEu+T1HNmcYHFEZDqEZeb+o7gm6K9dKKcnr
 A4OBC6MH+SXe5Cz2E0t6d8vcFWfWNo3WDCLKpvtWaswQ1g7ceX7FsyEUbdrAFT6HUyXR
 OgUxJ1Pv2RXi6LbN2SU7ji30vE/JyDLG/khmThlAxByrav42gFWS0y4mfNoivebMWtEz
 u/Tw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdxVAv6mt6+RYMMtmBDsYpn6mJCQPoxYa6L3p5lV19s/CKpICKCm806hcLntWMiElLXRpH9MORsaWm@nongnu.org
X-Gm-Message-State: AFuF++lRZ6DoWokZuA+glIMqORaUH8H/GtBvejM6tSZlqvmW+esDxD60
 J7fV5w4nJM/zo9uQYA/4h/Er21Am0zIrgC7JODqBVzU9mDNEo2EbM6+VYI/k/U720FADTz0V7c4
 1kYoOhMEuMyH7MQYiaghr6g5L7cro1+s9mZ/RSVXzK2Z7TzNRZS+QWMUrYQ==
X-Gm-Gg: AR+sD13/HsaHSXuDe4k1yJxpYoFuNucP/dPLQwnCCcfGv30v1TaGni09mZTvBNvuoi+
 Omq5OKIzHpDCCp6MVLTgS258jxVsjdtRsS+czT/+RLmSpcsGmIv6k5LUjRGRoGgmuS/Y1McCagp
 U6UWLOhJ/5s3ipBa5HCHxtEN8UnW6AxhmkEyv9zGiWbZMXqrbpAfu54ayThkiKXMh1TQ/fu5iMO
 CQs8gX5oojIgFeQxi9LGsppA3gMA0f0Hm4EgYQ5E+1+KoXMWJdJ9mR3Oxcn3Whsvd5sKxlN/xfO
 RFsIACK/gC2/s3EiSwRIYtzeCMp7DWyNPd8DDLvlhclUgbCAOdHVMmWrmBGjZp15Xrhxh3od/wn
 9+XqO12GDrnEsl3NzcECUldKHJtSbh3wW3wr+
X-Received: by 2002:a05:620a:4d8a:b0:939:df7:6ce3 with SMTP id
 af79cd13be357-93960f3bd3amr27435485a.26.1788298529810; 
 Tue, 01 Sep 2026 14:35:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4d8a:b0:939:df7:6ce3 with SMTP id
 af79cd13be357-93960f3bd3amr27430385a.26.1788298529248; 
 Tue, 01 Sep 2026 14:35:29 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f38b193sm37043385a.32.2026.09.01.14.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 14:35:28 -0700 (PDT)
Message-ID: <c1d032f7-765d-41fc-90cf-2de1e4c38a28@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:35:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: extract sfence_vma_allowed() from
 helper_tlb_flush()
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
 <20260831-riscv_tlb_page_flush-v1-1-4fc6af95673a@baylibre.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831-riscv_tlb_page_flush-v1-1-4fc6af95673a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2GMXmmCmJxodJ_Cn5UvFY_-sH7qs2hpB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE4OSBTYWx0ZWRfX8oCJVSSxSptp
 p7YGbLIf8pL6aUA+oP7ICVZseUamBgU19BbV8wpl0N1Bc8w2uD22wjww2gbco8y8GVUXB/5W2dL
 HdCIpd3Ez5RFmMYGzimFnssso6de7dc=
X-Proofpoint-ORIG-GUID: 2GMXmmCmJxodJ_Cn5UvFY_-sH7qs2hpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE4OSBTYWx0ZWRfX11lwpdE4ti1s
 vk8VG99qRCbDzzZZWMRxHtuYrVElCih3D/raOAkrjkHP3GdKHm/JF0G55glpVs1wHiu0xlIaeR5
 uxuBd+Bbuxd48Ig4Og7OhCFfbfMacjvA0T384kYel1fhQuTflL8cdPXLd5tt+T9HZ816K7UAzjF
 lyA9MYP6uS7GpbXUfL2jQmXcwihK3ct9ilMJ24UTdKV7LqGMInEk1szPgL6eHZ/09MmO9+qFR+u
 zd6fe2BScMFwPtyUiGA49HZgjnPIhBT+Ko6hidsJnWweKMbR39XwE2zU6+04NtPKsWEsNuL/Z8I
 OsA+Z8UeGllcCCeqBa77Df1Y4r7SE4zU6GwfiFTmRJESONTRjg968WWFrVCeFXeWTQ5mR3Ao5i6
 HKGU0B7RqeJJmxeH76GItH6Ne/STbHbHJTuao48T12Q0kbivRgVRuswkXwcaVjxTDb5yC5CH6qi
 kdWb8wyhYun9lH7GZpw==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a974523 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=IpJZQVW2AAAA:8 a=iy1MT0xDfmKu5e-TptgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010189
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



On 8/31/2026 3:59 PM, Trevor Gamblin wrote:
> Create a new function to encapsulate the privilege/hypervisor checks
> performed inside helper_tlb_flush(). The idea is to pass GETPC() as an
> argument directly to it inside the helper_tlb_flush() function.

Seems to me that the idea is to use sfence_vma_allowed() in the future
helper_tlb_flush_page().  In this case I think it's a good idea to mention
it in the commit message (e.g.: "we'll use this new function in the next patch
for ...).

Otherwise this patch as is is changing code without doing anything with it.

> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   target/riscv/tcg/op_helper.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 3e94005d2b..8039df2b48 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -588,18 +588,25 @@ void helper_wrs_nto(CPURISCVState *env)
>       }
>   }
>   
> -void helper_tlb_flush(CPURISCVState *env)
> +static bool sfence_vma_allowed(CPURISCVState *env, uintptr_t ra)
>   {
> -    CPUState *cs = env_cpu(env);
>       if (!env->virt_enabled &&
>           (env->priv == PRV_U ||
>            (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
> -        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
> +        return false;
>       } else if (env->virt_enabled &&
>                  (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
> -        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
> -    } else {
> -        tlb_flush(cs);
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
> +        return false;
> +    }
> +    return true;
> +}

If you read riscv_raise_exception() you'll notice that it won't return to the caller.
It has a G_NORETURN:

G_NORETURN void riscv_raise_exception(CPURISCVState *env, (...)


This means that everything that comes after it will not be executed.  Case in point:
these 'return false/true' from the function.

I suggest to turn this function into a "check_sfence_vma" style function, like we do
in other places like "check_ret_from_m_mode".  The idea is to call the function and,
if execution resumes after it, it means that no exception was thrown.

Something like this (note: untested code):

static void check_sfence_vma(CPURISCVState *env, uintptr_t ra)
     CPUState *cs = env_cpu(env);
     if (!env->virt_enabled &&
         (env->priv == PRV_U ||
          (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     } else if (env->virt_enabled &&
                (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
     }
}


And then:

void helper_tlb_flush(CPURISCVState *env)
{
     check_sfence_vma(env, GETPC());
     tlb_flush(cs);
}


Thanks,
Daniel


> +
> +void helper_tlb_flush(CPURISCVState *env)
> +{
> +    if (sfence_vma_allowed(env, GETPC())) {
> +        tlb_flush(env_cpu(env));
>       }
>   }
>   
> 


