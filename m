Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9975CCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBQHH-0003B2-H9; Tue, 29 Sep 2026 01:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBQHE-0003Ac-T8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:21:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBQHD-00018V-2K
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:21:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47BKP3643065
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W2XZTiCtdp6e3IMexvjR7U5io+YYIZPaQA1t5PJO66g=; b=EEa/9RWOg9LSijHI
 mSaYH/6wPcJO4jK35Sa1D2QlBTS0v/RyWr2wcYEg6mWiYzQA2AtEKMACzEmrJFud
 /msjKrUAkKccu+iWjtZe8ID0YaQbe60wxIuKwP5bCkoToxg5x92+MLMVnpStF3OU
 eX5wBlgEsd8iBTGgSiGxt8BpUXSCMMf9/jRf1OIVZkZUUjPRKG3sLIH5I0Ai9Zfk
 jC/te42ePIfi1qK964Bva38/dNALKfC8LLX5oGUqiAGAs45/fx6p8x2H9X0rSER7
 U8MWEmamHwhG9EoD1VyUimPjUjzCqjWEnF51OlH3nvCCjEEfdds0Icl3gGFChfDq
 3CdzUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4s9rn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:21:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5e9c2ec1so99150985a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790659271; x=1791264071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W2XZTiCtdp6e3IMexvjR7U5io+YYIZPaQA1t5PJO66g=;
 b=XCWcQKotZMfQPAB/lQydpEYEk7OyXJH+QjPlcXPAl5cvWZK6awSoa5xd+MAQW9oPHF
 wj+LeHi/OPClMSxuS1RnZ0bCsXe17q3WSrI9gGzFU2d5qmjMe7VfdZSzXsrWZLz/ufnU
 eKKRFxsBs2fhP4TlgHH0P5hLHR96qVv7WUqQ8keXwiBwqWJDaZNUnd47rpigkvR7LXNM
 3gKTuyW4XKRnkQtRN4kwOyavGTkgIAvIi6SNaYY3Fly7qctyzVXPNWVthQRxA+i5U/Qr
 ZrYDUxceHUyh0W1GxpucWK66rifkHp5FLy8AXblZ4eU2+TVoeh3+rCu0UI3rGwfvq78H
 jtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790659271; x=1791264071;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W2XZTiCtdp6e3IMexvjR7U5io+YYIZPaQA1t5PJO66g=;
 b=JgJF31suz2lYccx7pswZr/WGSVYTDps914dJRK00VwqQabf8YCRugw+oo8DtQavrPx
 dHBWBJ/6sq05kuYbxSLMg+I1W7L5yq0Qy9IrskzgZRo1CAyEQNEXy4b7+sZ4SSzE/Cv5
 RjoF468HMSaTlNZfyjWnsm/X2E+gsDSOKJnDXhTo7yEd2+wua0Fphp3Pm8i93NdNGcaE
 ip5Chs5kXdVRztBvu6SbKwvWvn2T0brO+m+t9KcnrnqPhusQjh3eDMQhsEKIdUCnEo6T
 13TMCmY59H/G8Y8a29YtcBxiIr7m04SsryV5GEiOVal7xl3cArqt8YJNyOQpGg8Hz451
 K+rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/u4j8PqTtzXhcapWF9EORy7NjtwMphd17CwtuDXg779uNK+iNS27QlqzzaOw5AuSbiuqepoLGuLnj@nongnu.org
X-Gm-Message-State: AFuF++nR3k81I3AflCocjdDLa+lVlfrNRNN1RmiWWV6RoNhWTaPeCqhP
 dJPliuGi6g5GTTLh990TtkS0EtmHbwuchGEiU9XJxekl+47oyVUvzRjq/uyEl8TW6v4MW1xmVZn
 XJT1o327OQUoivabDkYHFE8Su4CbWsFE++TVJUEDxkiSthtz4BtGczxRd2A==
X-Gm-Gg: AYBFou22n6fIAPnifAGJTy/L4U4iSGHdUIbiR/88q6NUEOI7/lVLSendI0Kwsvt40wS
 ssdRkZjyvFH+5anuU8LMvB5sSPrTQfUYZO8lGfgTGnZFBY5KcUbfOZyN/LVQGCFSHpBaTkYcE8p
 0ev7oPthlfD8DBSn26BKFx2CLaLD67/babnl37+mZ9C0/KHakgUmeeYtvCM/7XP4PbPEvq7nM40
 t3TpTt2UKxMUi3NXTdt29sy6siI1C7LEDtFHwdNP/ZA1l7kLLtS5qRY+Zq7vmP9SPCn3cf5kxqH
 l9E9Aj8f3RkyouS/MHQpdh1kNWlzaSf89K702Tk7oOvWHAdvmqX0MxfaVA+q+EwXmIzBHIOyC59
 y4D4Ou1h92cV6kCUhj8IqT193ZXMH/DFfYA==
X-Received: by 2002:a05:620a:880c:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c8bcd0262mr272687985a.3.1790659271386; 
 Mon, 28 Sep 2026 22:21:11 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c8bcd0262mr272684485a.3.1790659270896; 
 Mon, 28 Sep 2026 22:21:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50513c7sm969440f8f.16.2026.09.28.22.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 22:21:10 -0700 (PDT)
Message-ID: <2f039184-d0a6-4556-a514-72a39ebfedf0@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 07:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/24] target/hppa: convert excp to raise_excp
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Glenn Miles <milesg@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
References: <20260928052051.251-1-luoyonggang@gmail.com>
 <20260928052051.251-15-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260928052051.251-15-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMSBTYWx0ZWRfX/9NYADgKm3rR
 51awSqZFWML/hMs9kYnnKvzgRzzeRidqJer83ll75In30UyBOm18o3/hGYCHJnr7AxyjrInS0FV
 P09FrqCqL78OwF8IwvL98u1bUzW6AYo=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb4ac8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=OjroqGzRqyjf1ntX9NUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMSBTYWx0ZWRfX0rzuBsiKJ2OI
 rI5ZMkEUCbPAVwzZMDQ0IO8Fun3AP9F8AE6bKbGFGPKykwcsH4+UCnHvZ65bfSeUUlxH14pRj5v
 COSAgk4zr8SQ74BztHn2ixUM4nxF1js10asgUPbwig/3sBt3BqUlDhjXazcAxsSB8kYxwMVf8S7
 xsaUTt1sO1dV0t/2/uMgpbJeymqOV0jk8/UGxAaz+9bRgpQh4rC/JKIUa8N/S9fyeT/xFKT4VWQ
 24nJA8z0SBXKhVpdMxpN4TBbE60kzQ+to51p67lIWipQKgxcy+DjV0NMUzHKrBafYJA+O1VNpnw
 p68IGLiPl9ez9ANBmKHEWowd9RRM6KtI9Rmh6wq367+hy1DqKLoFXBLC9Jsh9dcBKuoRCcvlerW
 UXioDQPauYsqYDBWIaB9qETGcJWWjavcKKUw/WgZr4jPr/ZFLIosioqp4eX0NbAFzqfQZVb/2uk
 R9+TY3i3nL4U43vgdpg==
X-Proofpoint-GUID: xqi00NEy4TTufpEoAIhNViT2rnPrFRHG
X-Proofpoint-ORIG-GUID: xqi00NEy4TTufpEoAIhNViT2rnPrFRHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290021
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

On 28/9/26 07:20, Yonggang Luo wrote:
> Drop TCG excp and call raise_excp. Keep C hppa_dynamic_excp and use
> cpu_loop_exit_excp. Route leftover C callers through
> hppa_dynamic_excp instead of helper_excp.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/hppa/helper.h     |  2 --
>   target/hppa/op_helper.c  | 15 ++-------------
>   target/hppa/sys_helper.c |  4 ++--
>   target/hppa/translate.c  |  2 +-
>   4 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/target/hppa/helper.h b/target/hppa/helper.h
> index 8369855d78e..5ed39e01e31 100644
> --- a/target/hppa/helper.h
> +++ b/target/hppa/helper.h
> @@ -1,5 +1,3 @@
> -DEF_HELPER_2(excp, noreturn, env, int)
> -
>   DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
>   DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
>   DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 76a8d8a0d34..c4651f0d85a 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -30,20 +30,9 @@
>   #include "user/page-protection.h"
>   #endif
>   
> -G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
> -{
> -    CPUState *cs = env_cpu(env);
> -
> -    cs->exception_index = excp;
> -    cpu_loop_exit(cs);
> -}
> -
>   G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
>   {
> -    CPUState *cs = env_cpu(env);
> -
> -    cs->exception_index = excp;
> -    cpu_loop_exit_restore(cs, ra);
> +    cpu_loop_exit_excp(env_cpu(env), excp, ra);

cpu_loop_exit_excp() replacement is one logical change, ...

>   }
>   
>   static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
> @@ -341,7 +330,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
>           if (excp == EXCP_DTLB_MISS) {
>               excp = EXCP_NA_DTLB_MISS;
>           }
> -        helper_excp(env, excp);
> +        hppa_dynamic_excp(env, excp, 0);

... removing helper_excp() and calling hppa_dynamic_excp()
another one. Please split in 2 distinct patches.

>       }
>       return (want & prot) != 0;
>   #endif


