Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA069C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNUx-00087u-8A; Fri, 21 Aug 2026 07:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxNUu-00086z-DX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:33:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxNUs-00072R-HZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:33:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9LtoD2324786
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 11:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SOJeYJSpXyGgE7VXGw+KzG0orot/jQE0gKzCsU1Wp8A=; b=VUzA5+M5OJ3dRxde
 POqeW58cZaHvx7I2eSrQuDugJXLMvn+IlpuEhyMHr357Rtv08oWv+7A7IehwLDwp
 H9eLaQwoj7zT3p4eM9hhcKmBz1lixgWUJ9aV7P+Q/3fI/fbD8Wpk7gZVKt8CSj+b
 HuZRu3FKQ2MRFu241fFCEtDA6fwnHXmEj1e3geslNzJjwf0tRWeGQR/IQA/aXG9u
 fCLXpDNbhtilqy9mO7+FMbp/Vv7fOy3l2N660mZLa1eFJLW3HBLQjXQzMKFbvQ2C
 DNuL5nm0vQZEwH4BebR7KfpWxDB2HFWLIzJ8WPKD3hbV8o6e+npHK8yDjU7Xrsgn
 wmoTqw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdf19qq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 11:33:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f1e4e0eac1so5895976d6.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787311991; x=1787916791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SOJeYJSpXyGgE7VXGw+KzG0orot/jQE0gKzCsU1Wp8A=;
 b=Dyl6WwRQk0B7lBi5UbRNoVeazPFUYGxsUxP2/R7G6klhkOUJiG6i09IQhL7m/ha3YV
 lpIkE/zNU53/vEBLHqdAVU+UV3H0hElt70VNy5kvVKrUqJqrJ0hKVx+qAqkSAV8609l0
 GVIUFgDa1zUwA1fFjZb6FTNmyrzLZ6l0aAxSYYJtH1hNGU0ZF+4HuLLQsOlcELfcvqxR
 DRifHs7Apt6ZrCWzqh9peMNe20/TSJFNADZmjkYx+UvfzXaEPqXYWoeEn3YkG0hW4URE
 kBLboZPjvAE/zG2RuI0xwUAtW+4BeM6GY7LnfrRuZ9Yq/jSi7oPxuY0pSMSg2N/vv1ua
 d8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787311991; x=1787916791;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SOJeYJSpXyGgE7VXGw+KzG0orot/jQE0gKzCsU1Wp8A=;
 b=e7C4yiLXkr9PTqG0iUo8MrK9NC60KB6SCNgLZRcPpjCJqLFE222cyip3u4niitL6hX
 AylU8ilKTZ9F7oQ3YiS/AOYKqRZkMsriQAmX2at24yKPL5tVrV5A5TUzgd25E540Pqdq
 dPa+gk1DJiYzwtVoXv6uGLt87BdwDj3hzHS9RVosCdoAV6LFIPPz+MVHL5vMx7MH483V
 4in7zsajssTojj2J4i8vFOXsjIKZzXHklEWAPjXlxV+3o7wOcDSiAGArIK8u0BpBgI9Y
 bLn5AihBG7rIFqtsatsJ/vdLeSga+7pubZnCJUx1ODQzTHqtHPiZt8GRvIrmMoTKKV2U
 yhzQ==
X-Gm-Message-State: AOJu0Yxu0JO6BQgYDZjgH8vRWLk15v3cparlc0BeWtonb1kt4laWzY3d
 yxkKGFUmSX7Nhi6wKkpO8PTxY+cSgeRBZU8vj71Q+T5+j9qEOXezGW364IV1MnLfv1DeljQdRZg
 o7VkNGOTibl3amSfU7CWA8h1xBG4IoYMIhwyyyjEE6ARxeu38omaCvRpF3MyggZz+ov94
X-Gm-Gg: AR+sD12NHt7LITF+LVgMLlIUQ/SlIACzGtAwhA8wsIkXYSxn6ilXMoKSHYdO2R5afhB
 dTKrDruV4UCb/qRG13gl1hfrnHWifjNG9XrH0tYCzgtJf5UZxcIBx0f7DiS7tHibZ3fuNeGOaDP
 3CBKWQq2OmS9aaMu+L/TNJiJAVcsX8SydWajz/EN2BxA8vqv7nbaYgNLqlYynh7dhLgb27X/eSs
 9GzL0GAV3Pz/Baf1irqvGV/w0O29rvg+S0rGxGpsiQMPKmVPQ49r9TMXUXBMDrd3MsB4eVVO+wt
 mzWwMluJiLUMYUT/97l/GMh2JX6zRXxfszukbzfrNKk2PE/B73rDBl8rQDkny4DRiIHNT1SRsWZ
 5uLi2qUc6+QRjeDgSLXmVl3wBarqbJdVgap0=
X-Received: by 2002:ac8:5d08:0:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52df5ba63d9mr43997791cf.40.1787311991176; 
 Fri, 21 Aug 2026 04:33:11 -0700 (PDT)
X-Received: by 2002:ac8:5d08:0:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52df5ba63d9mr43997141cf.40.1787311990679; 
 Fri, 21 Aug 2026 04:33:10 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441725sm15941138f8f.3.2026.08.21.04.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 04:33:09 -0700 (PDT)
Message-ID: <3c9fe944-2b51-412c-bd30-26bf013cff46@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 13:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] cpus: Add const-qualified CPU environment
 accessors
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
 <20260821104950.32108-3-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260821104950.32108-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CsqPtH4D c=1 sm=1 tr=0 ts=6a88377b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3vFRysUDMUGlTKh5RFcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NyBTYWx0ZWRfX3sepWc1T0Clm
 8flAWUqZv7lx2VfVyvkOAdGBZA+/YKJwSI29W7Raacy7bV9yVPlimtvsasVGokgfXlftF5S0S8y
 9U6CbEtuf5shlspJnnWxKn+tGf4+ZoGoGqqHqsnmcLNAVHCHMWxvZ9HD5Ipa9Ziy3wv79cO5grX
 t9+eTba4r99B04IRMOeJuF+0L2Z0Z33V1wqMbkHfmI2ee+Frqdz6DuUUhNOkeTG0VJb1V27KEDg
 eLO6TFjxZmT0zUesY2Ifzk/OoVtq9EhfjUSuP0vCVFrCmUTC9q5UvHtlxdSXAvyIIxllOaOhBye
 WA+SMMJjzcxiVK01PszXMmC8IMTgq6Vpw+Kgds4TsL65wwBR3CMqR97epvZuPDqcBuPO+V3UqzQ
 miKtcPtyXAYwvLMHLUs4gzINMikMh71ZB5H5FC4C5RXPAj5/rChJzP9YwdPEmIuO59q1NVDJaHr
 mAxb2hJ3JsODoNH4K7w==
X-Proofpoint-ORIG-GUID: fDnRSJcCr7M1TpNSAfp1qAwnInQGVHRJ
X-Proofpoint-GUID: fDnRSJcCr7M1TpNSAfp1qAwnInQGVHRJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NyBTYWx0ZWRfX+uKo8M3mWO1v
 druB9J8FZ8Xn24rGSZfV9kYdct9DAWdak4KOjjEOzcsJqYcdTeCZMFA4BnAUGC5I4aCNFrp4Mvm
 HOl6ZFiQPEOxYkqNLSdidImPyNxHD8s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 21/8/26 12:49, Philippe Mathieu-DaudÃ© wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Use _Generic() controlling-expression to add the const-qualified
> variants of cpu_env(), env_cpu() and env_archcpu(). This allows to
> safely access CPU architecture state when it should not be modified.
> 
> Alias env_cpu_const() which is still used.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Following checkpatch.pl errors ignored:
> 
>    ERROR: spaces required around that ':' (ctx:VxE)
>    #46: FILE: include/exec/cpu-common.h:89:
>    +            CPUArchState: \
>                             ^
>    ERROR: spaces required around that ':' (ctx:VxE)
>    #62: FILE: include/exec/cpu-common.h:101:
>    +            CPUArchState: \
>                             ^
>    ERROR: spaces required around that ':' (ctx:VxE)
>    #90: FILE: include/hw/core/cpu.h:605:
>    +        CPUState: \
>                     ^
>    total: 3 errors, 0 warnings, 64 lines checked
> ---
>   include/exec/cpu-common.h | 30 +++++++++++-------------------
>   include/hw/core/cpu.h     | 17 ++++++++++++-----
>   2 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6594f7fa1be..bffef677607 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
>    *
>    * Return the ArchCPU associated with the environment.
>    */
> -static inline ArchCPU *env_archcpu(CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUState);
> -}
> -
> -/**
> - * env_cpu_const(env)
> - * @env: The architecture environment
> - *
> - * Return the CPUState associated with the environment.
> - */
> -static inline const CPUState *env_cpu_const(const CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUState);
> -}
> +#define env_archcpu(env) _Generic(*(env), \
> +            CPUArchState: \
> +                (ArchCPU *)((void *)env - sizeof(CPUState)), \
> +            const CPUArchState: \
> +                (const ArchCPU *)((const void *)env - sizeof(CPUState)))
I was testing with a C17-ready compiler. Apparently C11 is ambiguous in
how it treats qualifiers inside _Generic:

../../target/arm/internals.h:1777:25: warning: due to lvalue conversion 
of the controlling expression, association of type 'const CPUArchState' 
(aka 'const struct CPUArchState') will never be selected because it is 
qualified [-Wunreachable-code-generic-assoc]
  1777 |     const ARMCPU *cpu = env_archcpu(env);
       |                         ^
include/exec/cpu-common.h:91:19: note: expanded from macro 'env_archcpu'
    91 |             const CPUArchState: \
       |                   ^

Using typeof() makes it happier:

-- >8 --
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index d67d008236f..e3a5e40899f 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -87,6 +87,6 @@ static inline bool cpu_loop_exit_requested(const 
CPUState *cpu)
   */
-#define env_archcpu(env) _Generic(*(env), \
-            CPUArchState: \
+#define env_archcpu(env) _Generic(typeof(*env), \
+            typeof(CPUArchState): \
                  (ArchCPU *)((void *)env - sizeof(CPUState)), \
-            const CPUArchState: \
+            typeof(const CPUArchState): \
                  (const ArchCPU *)((const void *)env - sizeof(CPUState)))
@@ -99,6 +99,6 @@ static inline bool cpu_loop_exit_requested(const 
CPUState *cpu)
   */
-#define env_cpu(env) _Generic(*(env), \
-            CPUArchState: \
+#define env_cpu(env) _Generic(typeof(*env), \
+            typeof(CPUArchState): \
                  (CPUState *)((void *)env - sizeof(CPUState)), \
-            const CPUArchState: \
+            typeof(const CPUArchState): \
                  (const CPUState *)((const void *)env - sizeof(CPUState)))
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 372485a2e54..ee522e1e705 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -602,7 +602,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
   */
-#define cpu_env(cpu) _Generic(*(cpu), \
+#define cpu_env(cpu) _Generic(typeof(*cpu), \
          /* We validate that CPUArchState follows CPUState in 
cpu-target.c */ \
-        CPUState: \
+        typeof(CPUState): \
              (CPUArchState *)(cpu + 1), \
-        const CPUState: \
+        typeof(const CPUState): \
              (const CPUArchState *)(cpu + 1))
---

