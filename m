Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC53CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqKn-00062H-9k; Wed, 30 Sep 2026 05:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqKl-00061v-HR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:10:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqKj-0004Ll-Oz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:10:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U97rrH4151896
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CxBqn4qCBe1rdqreEaDUL6Nv+QorIWeB2RnBVNKSGjo=; b=YclUxTVX2ussE6hi
 4MDHLQVbutheG6uNEvfvWedQpn905LRzeQVPcvG7/eIqeq81x7pUo3Ly92Q6ZNZM
 E9pQihiH+5xRGDMQppsU+CGaKL0vYPG3uKWDIVPlM33BMSN9wj+JOaZ7ImbK5aEo
 mVAgpewTcJVazZWsqqgd2miIH7juyTUP2x8fdEXyCPPSm6dkv22/OFOjrGnJAh78
 hMdxeUUt3N1OHVgBIeq36wb2/QxwUnRS1OkNmblt3ufOYh1/QfjeW4tHIMRDJKuC
 bO5XbLz21eNU/2spmRKy0LNZBv61k3d5pSzyja0cO3PLlHHHuExtWIkey0g4MAba
 tA5adg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh800da-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:10:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cafdbdb7cso8281985a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790759433; x=1791364233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CxBqn4qCBe1rdqreEaDUL6Nv+QorIWeB2RnBVNKSGjo=;
 b=WV9fteQk5bA/NGoqLHoXdy4vmOBJccyClZGWLiVno2BinWKHvZWpD5k0SRLbyHkJkv
 v/VSOcKKfcsf+Nl73oy8f9KXomYpJXHiErQPy1MSXtH7KljaOvFXULZxFYj/uV7BLFcf
 /llQj1VQPVOVCOY3s7F5oY+2fRHpEpHY0vgbp+DL7nP5V1m0uLFwm9o2nl70LozEoiKC
 dR3tk3A512YG/0CzUWNShBnTBLA+QevVJmbxoVoapY8ZdCxRv2lwvt9dGPmFi/+9H4v/
 0ZQAyCSzb6lz1cgsp5bL35D/DGK0E0+V0wq39t0thZPqyIx1QpMYPqw5+t4r2RA2TNmW
 eW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759433; x=1791364233;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CxBqn4qCBe1rdqreEaDUL6Nv+QorIWeB2RnBVNKSGjo=;
 b=OT7SdcReEynoEULciA4SFGwDzeXLWEWsdecm0/Iu4mqDfHuYeJXe1K0kvSAc0aBcRW
 U2nT0bEDbpg5Gk3L2dtDiEI0cjE/v72L5TKA9BdMoYXCW6yHVVevI0jlvG5WKpiwqLH1
 GWppcQQ1xnqoM8w6kPizSS+I14lSsLN+06ZoTdh/K4tu0X9FnTzJpBIrSS5u1IdNoDih
 5AHPdJEky5HSCQBPkbzQj0Ih3M8FeSIPEY7ydhjZbi4u6Q6+D06lDvd2E33TW0HPCSxK
 1CDKmf9KRLmtsCUKAKkKYCHKc/wIGxaDK848VVQ3Gg6nIVLs0adrA+wnzd+NE1Xprox/
 iLkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByey7s7MJELA300TgfFdFRZwytOiZ9V0y66y2/NXbVAqhjMphxvS8gFmaJ+FPLennhE3b6ViD+YbUL6@nongnu.org
X-Gm-Message-State: AFuF++lplp6dpr1QWJ+Y2sD4Ww3hWaPNhtobNO2ZLfRkFKSx8aPp8Bmf
 yaeQgqepdL81Errqdsfi1L6dosQmoOoTMTte6AvAQ5biv6nu9Xq63KqqVYtnbMJdg/8+Aky01cv
 Oqk56xsUo0agEZOHQE0xFCTMTheeKJdEHlSIUyBzfGotaCAN+AtGzV6PwXA==
X-Gm-Gg: AYBFou3vyB03GVMgNcezQ1pJfxm5KIyovSXV6y+xBJdL4kED7cr9jyveAXJLVSlCAID
 HN1kvzfVzp20Yn6WED/ETHDU5bBD8ah5DnZJMGY4C33AsxBe++0SQtBoiIBJoPd6e5K9l4nHqRM
 GNscrG5nCauwaeqR9Jbe0knwT4sB0de+oEhs+XZjSUzBv0fvWa5BWPYdkElmX3jP4uaipbZjy6j
 Dk5xt7tGfh1mVJbUQMfdpvNW+gVpxbukYiUZeqwaP/5BSXyOuAyDR5VgIuprUwmACZaOBlBlu8S
 PqSb90o0RF1bLlT13N/k7ZBh8Vbpd9YcBpahVhXlabmGB4KwDluaD6enXQ+tyAcvh9cQ0/xCPZq
 eXvq7soGkNHY8SL0yXJ3HmNAoBB8Ad/taSQ==
X-Received: by 2002:a05:620a:3709:b0:93c:7800:bc55 with SMTP id
 af79cd13be357-93ca96eb0bcmr99618385a.18.1790759433031; 
 Wed, 30 Sep 2026 02:10:33 -0700 (PDT)
X-Received: by 2002:a05:620a:3709:b0:93c:7800:bc55 with SMTP id
 af79cd13be357-93ca96eb0bcmr99614585a.18.1790759432507; 
 Wed, 30 Sep 2026 02:10:32 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02949f45sm2006773f8f.2.2026.09.30.02.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 02:10:31 -0700 (PDT)
Message-ID: <43ac1d16-25a6-4745-8919-af1d7985a1b3@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: use vaddr for wait PC
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260930072033.603-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260930072033.603-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzNiBTYWx0ZWRfXw65eCobHEnsI
 coRfQLI8RyYoxa7hYjCar+zeqOWq91Xrcr4ORSRKOPHllgpZojJ43CehmVW65LUdqt4tKN8/Zoq
 GNTuYMFCjoVm0mmW4vgIOQ6K/LUgBeJh8T6OBJ/2QWyPTzVA7Q7bjmT3SIz7PwPFjkxwDsev0bk
 esOOw1MhJXjacQPbq9ojQ3pRiCdluLU2dUHP4PJZiQykGjUcqZ91wD8BM/1OOqYuj68fqgiqzLu
 X42kG//xp0UfeWH6Zwoh0LcFxonA8hI0T7D+lBgCi5+VO+tUqd0uiZR6UdqVTJhpQl48tgI44gL
 89nY4oJteCtBuKlbEjyCtqQOv0iR3ukCWlB/e7Hz8dDQ6lxloRFxDMKhnhBwu5SxsSnznOeVlUm
 kkWSl+uEITHclzQpM40a5JszqNOENA4OsMC1gE5oi2eDWmvH34dUSknlujq6prIti719of1c+zo
 hppfK8bJW9j98Jtzvmw==
X-Proofpoint-ORIG-GUID: ynS0lO7qBD3aAqu_yUb1U1iBH_kkK2PV
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abcd20a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=zCahEECaCX5nmnRZnc8A:9 a=JV_N0x6oktnHyyfP:21
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ynS0lO7qBD3aAqu_yUb1U1iBH_kkK2PV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzNiBTYWx0ZWRfXz6uBD61kKQjF
 3XZn5CaxzhcJ3He6bk0bn4T1WrDqiIhulZOwzz0nhDNU2zRLcT3olJi701fd9SGPGC2tYqRAoyE
 N1NpnfsOs71NF0LXdL1pBOTwSan5rXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300036
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

On 30/9/26 09:20, Yonggang Luo wrote:
> Pass the wait-instruction resume PC as vaddr through the helper
> interface and implementation.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/hexagon/gen_tcg_sys.h | 2 +-
>   target/hexagon/helper.h      | 2 +-
>   target/hexagon/op_helper.c   | 8 ++++----
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
> index af5032214c..de66b85b49 100644
> --- a/target/hexagon/gen_tcg_sys.h
> +++ b/target/hexagon/gen_tcg_sys.h
> @@ -80,7 +80,7 @@
>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>       do { \
>           RsV = RsV; \
> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
> +        gen_helper_wait(tcg_env, tcg_constant_vaddr(ctx->pkt.pc)); \

Just curious, why tcg_constant_vaddr over tcg_constant_i32?

>       } while (0)
>   
>   #define fGEN_TCG_Y2_resume(SHORTCODE) \
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 71c8da4c46..18cff7f4d2 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
>   DEF_HELPER_3(setprio, void, env, i32, i32)
>   DEF_HELPER_2(start, void, env, i32)
>   DEF_HELPER_1(stop, void, env)
> -DEF_HELPER_2(wait, void, env, i32)
> +DEF_HELPER_2(wait, void, env, vaddr)
>   DEF_HELPER_2(resume, void, env, i32)
>   DEF_HELPER_1(resched, void, env)
>   DEF_HELPER_3(modify_ssr, void, env, i32, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 4f00ca773f..0785f1a127 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1741,7 +1741,7 @@ static void set_wait_mode(CPUHexagonState *env)
>       SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
>   }
>   
> -static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
> +static void hexagon_wait_thread(CPUHexagonState *env, vaddr pc)
>   {
>       CPUState *cs;
>   
> @@ -1768,7 +1768,7 @@ static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
>           return;
>       }
>       set_wait_mode(env);
> -    env->wait_next_pc = PC + 4;
> +    env->wait_next_pc = pc + 4;
>   
>       cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>   }
> @@ -1836,12 +1836,12 @@ void HELPER(resched)(CPUHexagonState *env)
>       resched(env);
>   }
>   
> -void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
> +void HELPER(wait)(CPUHexagonState *env, vaddr pc)
>   {
>       BQL_LOCK_GUARD();
>   
>       if (!fIN_DEBUG_MODE(env->threadId)) {
> -        hexagon_wait_thread(env, PC);
> +        hexagon_wait_thread(env, pc);
>       }
>   }
>   


