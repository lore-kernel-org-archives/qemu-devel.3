Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE66C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ7l-0006XM-2U; Fri, 10 Jul 2026 17:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ7g-0006In-Mh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:51:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ7e-0005oi-J0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:51:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDcJF1811767
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 84ec3fgK8/jEOWef5W0keF0/v+uLogAqU/+LIXNJukw=; b=S4XPX8VzBX9R0xuY
 f5g4wA6OIz1RhRLIsua69rgautEsTdLjTQNN19tZPU/12Dsq57JnLTL0Eu/lvEBC
 FDHppkkidzKYxSHQZMvh7htUXOMySmftwZFQO9x8V7UzMTIw8q4Mw+eUJyS8qYiC
 5yiheq1teeRnSzfOuhsqv4rYVyWjaBy1cJPF8ydCXHU6Klp3xkVOCqFsTVM8w8zs
 Qhkvn5cXffHnb8fY/svjAbK4meH9CsxAK6oBDqNuB2tJgRodLlVjfgU2I8/SabVb
 blcn5MQwPK9ma++nP0mh4m6obQBxbtarWdqjgLAJwACmc38cYOkk14xkJaTM6zbl
 PlmuNQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5faja0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:50:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c075c1e25so11337451cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720251; x=1784325051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=84ec3fgK8/jEOWef5W0keF0/v+uLogAqU/+LIXNJukw=;
 b=E4B4gqodDOppf+FLfD4JJcZCSs1+nPenvLYu/I3V0Qjl8xkO744iuP7ayouegs8tma
 F4C6tZIF9VNoL9OvHmMkHnmOg1HxKWMhcD9hK27skDobbDpsp/zPdSk4ktqISuCIKCjr
 k3SIHLmkt1Bo17ychBUMUphy8zsgcSZu1WXCCMRpKpB1OiiBsqF8q20hbHF15WYyy2sJ
 8MxZpfn1qyoHYnZ4cZEbK0nVYEp4/bDMNMq1GddJfbzj8E8BFniNBZzxPIhiLr5A3pLS
 mcesMb2TGNmsy++JAG/C+ehSxtUH7LrdIfagBTuAkiONmk+SqyyxddQdclVbMZburILP
 QPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720251; x=1784325051;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=84ec3fgK8/jEOWef5W0keF0/v+uLogAqU/+LIXNJukw=;
 b=raYk2XZHXtxM0H90W6hCaXiqENPoOldhCwZjS8WhdCZbfpEjIW52/5trO5iyz2+0Vd
 lzGpkkpbzhS9rb/sv0IODROtVfhXb9XLKJu1nz/qL6x6jh4LziWYdW2LxSTSh9rHulo2
 Mzh8ny6+ya7TdxhkbEwPlTKupVqBnnkw3M492p8OXzkePb1IueUImqr8EtOUGyblK3DR
 oqDHSJ+f7WqRGhPKE2xMjPhNLRdPTQFRmTzOpJzCxVEN3T+bQwPreElPDfjfkx+6AI8b
 Eylko39Gsb0nudJRHb2TKea2rswLw2Ju9tfRdUJWhpFrF/HGp/0fyzSHldMt+xCJA18m
 N9Rg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy4mLnxogwKBtcMGxQz4EG8XQ/MdO0A8UWftB8NdQsyveAG3dCIj8rJvmdxXV8Ch7Vrswu7B4ovcRT@nongnu.org
X-Gm-Message-State: AOJu0YxBLfx+/LSjErnbxaKi9kdxZ+CuPQxH5RxHZEhGtm7WgYCTD/R4
 pvONacNeT3mNSSPdFXGV1tvIANR5xxA3F4z2LyTQBXPVs0eTOuu5b6wvqtYhXwzYHzMTSHJnBWi
 hXd3nouqlt3payBo+Gakbkjdjw2V0GidNUmyKXNHiNunFW8eoNJvIyVQNCw==
X-Gm-Gg: AfdE7ckGA+2ClPG0OZCZe4lTiq2erNMeL8n6dYPems6APdhzUMGN7I14DEjABy1l0rO
 BadKHnlQvrnOjLB6wSPaCOxZx7HZju1R3XSoP8WnWmN4KMRBB8Gsg85Dotn6ORfLJr7mU4drtQ4
 F//NLDTCeVy6KaYiIxSJbSoPRSlp/HiuMfw9x1/cmc7zwificU9NPXzEc+6Kp9d6HXvDhFNnn9u
 iBzQuQU0Ebb/bHlyrQXScpH0HRaatd6rlt8UifrsSqVihipsNnezrtk8wMAMg+2FJOOeiZzuFzV
 c+lyIANdMW/kdPw/3lMs4HC2ZC6Htud32FHN4cHTkKD6xbotWE1nUnfEhH+OHYA7B4kOkGQh787
 0Gts8YWtLJK657YGM1UufmWrTAHzy2AFLnvPgPn0guQ3bhzUoYrXzZ9apMnphYA==
X-Received: by 2002:a05:622a:1b27:b0:51c:168d:3ae0 with SMTP id
 d75a77b69052e-51cbf07129dmr7848421cf.1.1783720250901; 
 Fri, 10 Jul 2026 14:50:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1b27:b0:51c:168d:3ae0 with SMTP id
 d75a77b69052e-51cbf07129dmr7846281cf.1.1783720245684; 
 Fri, 10 Jul 2026 14:50:45 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm71706636f8f.17.2026.07.10.14.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:50:44 -0700 (PDT)
Message-ID: <7eec8cbc-e5db-4ad6-95e5-27d208298a6d@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/51] target/xtensa: Use bp argument in
 xtensa_debug_check_breakpoint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a51693b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8iTtmLh_eV7-T8uE9KsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LAfiffluTcVc7Sx_eHiHPRQw4wu08D7J
X-Proofpoint-GUID: LAfiffluTcVc7Sx_eHiHPRQw4wu08D7J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2P8H20vsqCT+
 dTXLwO+ueVoIpJKk42XJyNeokGPYb4m4oO3YB9L4vOLJVNknb04ft+EIu6KxPdziPULzkxsZf4L
 9oRHwZ9s116kfqijNdOPtZlCvunvS8E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX6sz7+sS8FPyf
 RFROByJC/v4KnZBGxD2yT24Qh+jibDbscehNPTKUrFWEyTAWCjowBw01S705bL18rhjoCXrsR6n
 s/XmoLx2TUkflJlLXOF0IfjJ32F3ikiew9AGwRJs7CywAcNlHJI5BXpSMAI7DkAi6xN8mZvabyJ
 NJk1YN20YA7djSBL496rDbRt9AgMf6wGJphc1MQXEDojJZ0NyXbXvily1LW4EcbTqCC6jvS1qUv
 SvpGsuSquAnNc6DgIbm/y3STRJovsC7oerc7b2ADuVkIg6cQg/OsWw3wwXntIH4XcgIS55X2Y/2
 5PZ5s4QFlmG8TEy7hHTzUuY6W8OzgVLhmdVNoQcNrE6Lyw0J6GNKvBaRWZ+3c2ajnImxI0XaRJs
 pfYdhLrdLZMkXtR7O/IqAZNmlIPQpTPXbkYSEFJ4JDIdcto+sXLo2hfrSYyRYjSO01y2EZGfM1Q
 s5NBHdKPQeL1BmFfe7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> Use the ID of the breakpoint instead of a loop over all.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/xtensa/dbg_helper.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
> index 557a7852c8..b08bd03435 100644
> --- a/target/xtensa/dbg_helper.c
> +++ b/target/xtensa/dbg_helper.c
> @@ -67,18 +67,11 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
>   bool xtensa_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
>   {
>       CPUXtensaState *env = cpu_env(cs);
> -    unsigned int i;
>   
>       if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
>           return false;
>       }
> -    for (i = 0; i < env->config->nibreak; ++i) {
> -        if (env->sregs[IBREAKENABLE] & (1 << i) &&
> -            env->sregs[IBREAKA + i] == env->pc) {
> -            return true;
> -        }
> -    }
> -    return false;
> +    return (env->sregs[IBREAKENABLE] >> bp->id) & 1;

or

        return extract32(env->sregs[IBREAKENABLE], bp->id, 1);

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>   }
>   
>   static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,


