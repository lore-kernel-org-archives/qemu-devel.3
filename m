Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvvIN-0006nS-Vb; Mon, 17 Aug 2026 07:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvvII-0006ir-9j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:14:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvvIG-0001XF-BZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:14:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dgfw2470510
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7YiE7383FwpyDp32goc1hPgbaLG4034Pzreh6sCEwOE=; b=X+4Lkc53wjZLtV0g
 vx5cqPp8xvKYZvjDHK7O96G0NDY6d1JHdCRdAFnRxdD9uFFKO7hNuTM5TzczXYzV
 U5i8SvoS8q/yjuCv0gWvn9fqhb4cz27elV4B1aNm+3tso5Vs2oaZbU6BKoFaS4jQ
 a7gyO1WscZSvKmVuGFY4JY/iNG7pVNUDAwZ/PH9ZU8ECBTqn9pauy3NowxHwKI7U
 9tDp+eVRYI+q7hakkf3A8bdnqASrg4/6Z/9ZDRE7BxRZu1Mow9ISWtOQwuOMR3HR
 ZuaoLe1xenlBcqtoBT4a1kQaB5sHHyxM2kJ9rviFp17BFbshAG4IiJs1EEvN36gC
 ZYXjDg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wm7rx0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:14:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so310510785a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786965251; x=1787570051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7YiE7383FwpyDp32goc1hPgbaLG4034Pzreh6sCEwOE=;
 b=F1PU1Fuw61CSseroaw00gfg7N6tydvCeQZlKIdUXxwfMMdf2IEGdLeif3K6A72mA5b
 bd/E0jWyKDNtqrze+O+koyUB2UD7vGX8HrFBSkdiBpsVWwOAY2rfk93ZM6neU71RLb0g
 MSY1Erlo+iKMKDpBOE5OKqFdoYWB84LGpXPY9dJDbIEeYinGlx0EnoHyuI38XFdngzCj
 HfzHa4nl3lS0y0XN8jn1Gi8+9Swt/3DIoVyJ2XMJn0B9t9B4FrLxlGZaNJxFnJRw5qFc
 M/nlQ0VfGWKBqdDS7TITUVJ2nl+7Bj33BkRTX+H7JZA9kXuUt8jaSf4NCP/MfayVOhzT
 Qxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786965251; x=1787570051;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7YiE7383FwpyDp32goc1hPgbaLG4034Pzreh6sCEwOE=;
 b=SSoIHZNdPyeeZduOEDcZQHWOVd43/C13wOIHMTwsiNXK7Uo4LRAMmQBxbjtL1Cl6Go
 29SePkLZP61+XObh+kyUCaypu6EoyRzF0gdYX6TQ6OkYqjM9aaWhOXaWRCdP9cNrn1OI
 u8iSSADSsFx3bMJ6LSQIYWCkM1XFVquVahVVPkoWTVYMIIAfggcjm5afaySeSywz7U7A
 eM1zWEdI53iO//6aIVvG6+El1P9gjrLxaDcYArkRFjsfme4uoEP/2A1L4FdtTWPMeg6x
 tCQOMDEe9suOPU9C2EP7bBaAnfP65W7Axq/NWBfdjCRo5hcpNVNszqCFKYjFDjdB4NIp
 10Ag==
X-Forwarded-Encrypted: i=1;
 AHgh+RoG0za4gYEy+Fiq/VsAHqC1fgSyRujrW6n2RzJnXX7ickfwrpuLqASLxFOu1MslV3TwZfjabJYYbYoC@nongnu.org
X-Gm-Message-State: AOJu0Yzf+4/9wPfO4p04w7RP/f0nbZBAHKv4Z7huqUjjHPGa2lrIejN9
 ydcSAu3Tm89uM8sdGRsnoKwqrNiGYoXOz1w4cE4py4WmUTFqsRarfL+iJGNIkE/lSH2bDYTKvP1
 I5eDs5/XaMvWWSdiszoTC1G4cdS3wm83a5wARsBER77tXafqnNGiq3HSBGg==
X-Gm-Gg: AR+sD11UgS8f2hmywxrsl/2tcoCIE+sRqqB1P/LMOAAW8P61N0pYuwV3zEuhmIQ3qx0
 NzfEKpTCuwN47/JupzFU4Z9sKyi4RZGOteB67R9W3Tc7ZI+9MLIXRrH/R97+qpjG2tkacHPz/bp
 YrzGOgNRUgQSPQ2z7CZGpib8yf5GIyBwVib/MowhfDK1CfGZLhyhA//Lj8bv1KBoWJJ7sYlFgdq
 Vlhxs5B2EssrUbS3zLF2Yv/ISpjLU61CRpoK2pAFKye1LoVNApMPLB2ZLJLYD4fL5IUrQUhu0Nw
 lH6tHV5rADjkz6dge7ihFesLKeUk8rBfZzXEhCHO1F+vUwdC1Lg5wOE1vwqdenZ8kVQBC9L5nkS
 oa9xNv3JvblxRc8KlmNkI7AY=
X-Received: by 2002:a05:620a:1720:b0:936:b923:4832 with SMTP id
 af79cd13be357-936d233d21dmr2470391785a.28.1786965251419; 
 Mon, 17 Aug 2026 04:14:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:936:b923:4832 with SMTP id
 af79cd13be357-936d233d21dmr2470384285a.28.1786965250894; 
 Mon, 17 Aug 2026 04:14:10 -0700 (PDT)
Received: from [10.111.141.238] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c5e7sm3217366f8f.24.2026.08.17.04.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 04:14:09 -0700 (PDT)
Message-ID: <aa4bdaf5-6669-4ed7-90fb-4e766f160118@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 13:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/35] target/avr: call plugin trap callbacks
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Julian Ganz <neither@nut.email>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, Stafford Horne <shorne@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-14-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20251027110344.2289945-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ep-G4RwFJNrm_uraZJA6tDS_nXFls5Ki
X-Proofpoint-ORIG-GUID: ep-G4RwFJNrm_uraZJA6tDS_nXFls5Ki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NCBTYWx0ZWRfX7i8KXGwJouMJ
 8/lda2EDtuzLRdDvlJ4PrRIZZ4+xmp3CBTb6cmVHXh7EFpPtWExTo6FVayRtqWL+nVd1LWYB9ai
 yZg0KP57OwfWln5Z9jiH4yPn5ShRuO8LpHczeRxtLOTun948Tag9qKxUJDBmH+h6JZBqe51/mk6
 z7St/WyCjHgsZHiAyqUruVkiubI5BG3e67wXbFVX4hU3cyuQzg/aUQopnU1GaDpavzi+wyxiKrm
 juulehBDbalSmLM8osrE8HIcgAfX0h6otC5ZcCHaZA5F+/lliZMAzkPTDAkAllX/+1KkaEtgNzH
 Jz2u3AyvCnLA6Ct8QyKmYfbPOV8gjnxpVEoLlwWXWhZcO6VWLSDjmCqPH3DszDD6jOEJd21mQjs
 0vYentX8wLvTLganDIbr1ch2BIbpuQXqpi1fHosR15OhjDa3S8pwg92gdOGucqHogzsOf/uVx41
 IqwFXTmB5aQBA2+3M9w==
X-Authority-Analysis: v=2.4 cv=YqM/gYYX c=1 sm=1 tr=0 ts=6a82ed04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=fJfIHgLxyoL31M7WP3EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NCBTYWx0ZWRfX2VVdu/U0pUbn
 H+tSMxUjE9ih9ebRs4QvCQNp58DwnfVMcWlXeh2QSbc/hH0N1ZTyyQQzUsyo0GyC+9MucrE7GbI
 ZLyfYPtUCJ2tuzy8hu/nYOw1BFuvS/0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170084
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

Hi Julian,

On 2025-10-27 12:03, Alex Bennée wrote:
> From: Julian Ganz <neither@nut.email>
> 
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places the hook for AVR targets. That architecture appears
> to only know interrupts.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/avr/helper.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 4b29ab35263..365c8c60e19 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -28,6 +28,7 @@
>   #include "exec/target_page.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/helper-proto.h"
> +#include "qemu/plugin.h"
>   
>   bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
> @@ -102,6 +103,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
>       env->sregI = 0; /* clear Global Interrupt Flag */
>   
>       cs->exception_index = -1;
> +
> +    qemu_plugin_vcpu_interrupt_cb(cs, ret);
>   }
Expanding a bit ...

  77 void avr_cpu_do_interrupt(CPUState *cs)
  78 {
  79     CPUAVRState *env = cpu_env(cs);
  80
  81     uint32_t ret = env->pc_w;
  82     int vector = 0;
  83     int size = avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
  84     int base = 0;
  85
  86     if (cs->exception_index == EXCP_RESET) {
  87         vector = 0;
  88     } else if (env->intsrc != 0) {
  89         vector = ctz64(env->intsrc) + 1;
  90     }

Unconditionally recording exception vector as interrupt seems wrong,
shouldn't we call qemu_plugin_vcpu_exception_cb() in that case?

  91
  92     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
  93         do_stb(env, env->sp--, ret, 0);
  94         do_stb(env, env->sp--, ret >> 8, 0);
  95         do_stb(env, env->sp--, ret >> 16, 0);
  96     } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
  97         do_stb(env, env->sp--, ret, 0);
  98         do_stb(env, env->sp--, ret >> 8, 0);
  99     } else {
100         do_stb(env, env->sp--, ret, 0);
101     }
102
103     env->pc_w = base + vector * size;
104     env->sregI = 0; /* clear Global Interrupt Flag */
105
106     cs->exception_index = -1;
107
108     qemu_plugin_vcpu_interrupt_cb(cs, ret);
109 }

