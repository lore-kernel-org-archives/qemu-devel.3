Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C25C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4h1-0000qu-BL; Thu, 20 Aug 2026 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx4gx-0000my-Gf
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:28:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx4gt-0003sp-8X
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:28:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KE8G2T3146695
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D5tEUgkATbXtPs1itPNBDCfx+mXdUP7NE+SgBr2PHD0=; b=Op6Z8uouz/3587yi
 AtpW2oA32elrE7qdvuNLUL7/zrRvZ1dRqm+jg/g8QHGzorCwayTGcu5gDJzw40jy
 Ckuwvz8jT5RFEIwAbDDqy8SgFeWQsqTdgvOLT7QeedGN+WddV5GFf9lW1W/1j2Vy
 ANMnb8f4DAPvIJCbYv1pg+s8zuLh060FmzXaA7AEYvOagCDy/UJuf48iw8yqA11M
 UmWE3JpaeYyVKnlN9YecqJtpKmsPWgn858jootZLhaJpu4679maVQOL7p/Kofb0O
 juwyy+EB4goMYcK+HkKJku5KVkJhxZZ0MibsOeyzdEXipb6EbbFlirjZH6j0WVIm
 yXHFMA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7t2vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:28:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5276aa86d00so27184221cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787239700; x=1787844500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D5tEUgkATbXtPs1itPNBDCfx+mXdUP7NE+SgBr2PHD0=;
 b=gxGq9mtECPu6cCDyaY54EHzLBueNpyHHBpw76+slnhAyIg4e0UnEY/4AmJPM1Iarwu
 pu+1n5HNRifE7h4m84WcyDLaz46C5qWSshGlYS0aFxsYLPta3Zv4jhIHOp0oGwYz3ZM/
 CDdYZ7qikigpyCYTmpdYeuqpNo7D7sRZwgqNqHYpviqH1i5Zte5XmbKWWspFMWD3HKiF
 uxNx6n4+Cg4kaIMtR2gGYSC8bavbA1ntkdjFhF7YEyFmJgLDCNXKy6fLwhhoCrd/97ll
 +zqM+JCwBK+f9hhr6w8zM1HYBriLXvs2s7Z8ztoocvedH4UyYwKa3vdKgPfrnNpzSmwz
 Vb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787239700; x=1787844500;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5tEUgkATbXtPs1itPNBDCfx+mXdUP7NE+SgBr2PHD0=;
 b=nUORJhgmj2MW/B0vTCl7b2EKsDIEiFMYeth6AtfL+R/5uJ98DVSAPLouf8wIMd1xax
 TcqHOT9pertuRdXgLpAKJcFihOisNfdQQCiV0OVzGQ1gEt5e18j7q+ewOXblBDRBy4lG
 dLCtUDI4I9fNKJBEoSrGXm+S7qYAPSX4jrbkyhxFRu1H1HD7XvGAf+DuhrJaz7JofGy9
 yOgFTumou/7XxplMJ+tz+8hGoKNzPO6lh/EruWkbrQiv+HF5ZKkXVBOm5/z7gygaE5cN
 W5MXWPLi3NhPF1+jFmplQCHQlk3Dw1bFoO0pw81Zy9uKZUgM2k5mPtyoNSXlLo12yG8u
 Q8/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpH+mMZEQQPFJE8exmi7LHR3H1P+2JqPcgGTr5J1C2xVWKx8Ik8IpjKUjEl46hCVev/LMfyo6WiZl8C@nongnu.org
X-Gm-Message-State: AOJu0YxAVBquAUdVFcFWi124q7CzJq32tElod6mF8AKqjEnMJyXASqtB
 qq5v03+xylnovRiq4nDbndzjnlanSB+qYjiO/nbCZohQzPvY70XaZrAJboRk2WSVNQ2Poe2pD3F
 H222AmuubgXGhBhjujCGrgwDhNz5i+dKs6nynnK14hxQYifYnFjJTdvaxrg==
X-Gm-Gg: AR+sD11L/xkiduuhBX6frf9PQZwAH/121GNvB6lDCiqna6Zlv744kDSVskELCYxdzt1
 JMbgBTQJ3VzqVU9ZCMHZ6R00EJikwACeQTwBPBTwxD+tLhdJ7c5t8rHQYt8F/ZwWsch1UhlWLIb
 vjfSVN67i+zy58jk0uzfujPmoxqZY3iZAia531ecCJxjt27Xsrw6/xmaHxV83vgEjA9bxT52HdK
 YjFiVY/xuzxiqgGBElPAiDSEzQ7bmmSNNrCRVFSF7uF1f3CwFIUoRT1Cc7PqD0sBY/oaEebnACw
 EqMy/5eKPtN3iqYqgvSDxdCkoUFy1lxFsK7fBtGj1II5SB98Lz6ANuf29tAzQ7mZOOZu3UsI30v
 oyTbJ2gma+14hPm2avQMabYbfUdQ4+FCFgghG/U0e8Sn44wHklkAdKcJn2+YX9vcI
X-Received: by 2002:a05:622a:147:b0:52d:9879:8532 with SMTP id
 d75a77b69052e-52dd5cd7b84mr104163411cf.20.1787239700345; 
 Thu, 20 Aug 2026 08:28:20 -0700 (PDT)
X-Received: by 2002:a05:622a:147:b0:52d:9879:8532 with SMTP id
 d75a77b69052e-52dd5cd7b84mr104162521cf.20.1787239699721; 
 Thu, 20 Aug 2026 08:28:19 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd857b049sm32667231cf.4.2026.08.20.08.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 08:28:17 -0700 (PDT)
Message-ID: <fd1d2cd6-c470-4d77-8df9-3511737642e4@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:28:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/13] target/hexagon: Constify CPUHexagonState in
 hexagon_thread_is_enabled()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-12-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260820104730.25462-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExNiBTYWx0ZWRfX6d3JG3HuFwqp
 V4xe9uog3KWbIqt2KhBDD7ba1lvbfwDR73Zu5iNAjYbfLfEmJR1P/FcpJw63qPzIcnnyyKmGU2g
 gDZO9jjToNs3zopW6GFtTXW2PfQDZDKk98wydK9frKpoAflTzvmvMC96/y7xzIBJtZ1cDXaWV6E
 JDVrmMK4/NiHQaY+YvjS5mgSErGWr8RjiEAwAOD1g9wfGLU7uUyfDd1zkgh7Qv05HzK1x2D+wkI
 8eEWSWEJ+JRe1WoenkmIQmX1SHHcntCWaS22OvJkxyz2aDhMJXS6vQ43qgDrgNXvm9M1UfjNfAH
 tH2+QscEoLOwI+lQ5sfZK579Cggp8IYEGr7G86IKaD1hhtPkzak4d0oBHgzMuWFJusZmyX8CL//
 jY5BoJmh6UWqzQkJd680vHX8C0nj41u07D+sYKSunanH2rYdLgsmyQvxNX5P2FINLjbkSQb0ltV
 ielzStoJzpy0NVv6H2A==
X-Proofpoint-ORIG-GUID: vsjTFve52aLFZDy3xPu3e-_q3x4TwpPa
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a871d15 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GFBKWpBzVshaxgVpWEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExNiBTYWx0ZWRfX9tkWTPsp1lYr
 Z1BLCL6TJ2g+EBvTM2uqW+ac2xN1kRKuHzdnxZlvAE9cBanR+q9btWS6Xrw5ackxyE7G/pd+6/6
 AJkaepVHHFslss1C6i0afQhXgmx/FaE=
X-Proofpoint-GUID: vsjTFve52aLFZDy3xPu3e-_q3x4TwpPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 8/20/2026 5:47 AM, Philippe Mathieu-Daudé wrote:
> Use the recently introduced env_archcpu_const() helper and
> qualify @env as being const in hexagon_thread_is_enabled().
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu.h | 2 +-
>   target/hexagon/cpu.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index c50fbb3f72a..e4f120eda17 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -216,7 +216,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>    * @return true if the @a thread_env hardware thread is
>    * not stopped.
>    */
> -bool hexagon_thread_is_enabled(CPUHexagonState *thread_env);
> +bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
>   uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
>   void hexagon_cpu_soft_reset(CPUHexagonState *env);
>   #endif
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 9765716b516..7ae5740899b 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -345,9 +345,9 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> -bool hexagon_thread_is_enabled(CPUHexagonState *env)
> +bool hexagon_thread_is_enabled(const CPUHexagonState *env)
>   {
> -    HexagonCPU *cpu = env_archcpu(env);
> +    const HexagonCPU *cpu = env_archcpu_const(env);
>       uint32_t modectl;
>       uint32_t thread_enabled_mask;
>       bool E_bit;

