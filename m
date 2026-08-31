Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600FEC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x13JJ-0004yT-Mn; Mon, 31 Aug 2026 10:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x13JI-0004yD-8A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:48:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x13JF-0004D1-L1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:48:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VETHvs3215371
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wFpVblKoRZIVazwbVqbu0YEC41HNlanBPzb7zR697s4=; b=EMx/FZPrjt2mk0CQ
 BVxWQC+BGUwCQ8SAh4Kv/xA/dj4dHXZb8T0nwUl23m5RHlxAG+cbxXw+np0ykMHW
 qeW6Isl/xrf/7b9kYsHEZ3YavKmEhDDWB43QmuGOIuHH6aHXPUpcA43i/ARIGc6w
 0QZNjbwdL0TNxg98RvjYZ5Y3CnSVYMcKRp7r1Ct0DSr8wLzTtgs3FUpChVbzDQFZ
 S41/nj7V8rDJ9eGs5Gr0aAopAr7tEj1JUzRPzPeCIG2/70r8KETLWBu5Ll1cBYB3
 0NYVNQzwbhGrGPSbBcRBJoDq+8Y60VTLNXkCz102XFVB6EsApiMuleY3LvzqwmRK
 RFffzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcsb2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:48:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939062ecda9so430516085a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788187706; x=1788792506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wFpVblKoRZIVazwbVqbu0YEC41HNlanBPzb7zR697s4=;
 b=ihBoV2xB/Q53qohVreu19w1GZTcOA9glzCNGHZ1aJs7P2+6hZgzvSIEmR4k9G8aZVc
 CEERmvki9tIxCM4+E0JlCO8o3Yy/hM1jlyRGwha5qpUZCk2XvYXmb7PdhzHihMMDl34F
 REFm8MKZQmV1WdHPtZPhvVxcq0qHbEbebJP+ii/Et5LYd+7g7l5tcOieunZgwpLhVBkK
 Bb28x4phHokjqDvlSmOLnxibrA+3tSnSCLzB7PkHv+JKklQwkRQFPoBBgfh8lQKEY1rl
 ZV/Y8lSqEI1CLj9D090a5rSWGvlCH/INbyHTbVLM1+6NdSjHdiHvCB8kGrlS/RzfgKYP
 13zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788187706; x=1788792506;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wFpVblKoRZIVazwbVqbu0YEC41HNlanBPzb7zR697s4=;
 b=ZnmPCc1FEbtN9X0nX7SwrUK9TauQaPbdAFfzhSQWNL9JAn1a4YLLnP0pX0iXaxmeI2
 bA1egLIBiTBew10uDVtBoOWXX+5ejIlbBcASo+VT7MJHnLGryD8FcGASl8blnetIjO7w
 AYZYsFr6iOrstytGPCaklGdeiRDkc/nhiRgG6n3mb4MMe1DIskuDWGDfp1MA2R5XfYZ4
 29wl2yqJwqGosJZ0ZXwpCtJHUiLkyqpmxlUP0owC0I5w5trM5zNJYgt1eLXUZOnq7LR8
 upLWFwEbTXEssVZhVz65yu7tTs1JWarKMk9t2iPhVrscp0GQ475WzUUYSGm5m3vJE3qf
 Mn8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbBbnrSCVOuC1FykUwX4YyWhMCDw7mTOctWGl31xIEVJewkJL4ArTqcaIWvKljTpo2nrllqbYkfIjs@nongnu.org
X-Gm-Message-State: AFuF++nXJOlpHMnl7fPhgiYAyeN+IhqY/j8uOZX4Xi105fRj9QnBjgiE
 FrMVLVMTSTTFWkJ6BaVGZEreNznHQaQfq4GNVxlhcyvh3hj85xJ+3NKwa/gJSPBQKQvAi+U9Nzx
 GgVZXhJucToW0ibLaJP6v1YHezT/E1yY7QTgFaGl1UmM/N68H8sqgNfdX0g==
X-Gm-Gg: AR+sD118dKi5mbdqnYKchQrgV6tZTI9T6XCXB3Spb3oJ13/XHROVxkMS/0qlZHnfwrJ
 9ON3tGXVGkVL1I4PekC1FWU1jgTh02EiA+dLMTzPk0KnAJD+UvuO8iQEuj4K3g2wiqfeFAhPaCz
 mDxSKMc4xLjUKyylTGi2pN2CKqUWhM9880nveMZ/JGPj+obhxPrWyUzjQtGB0+mNA/L2e8RwOI1
 u7yKvRnoUeC85FyJlnQFdoEcrAHwQCfG/isciqCE8NU+X8LMeRz4psI6hYHIFh40PKibBUXnc5m
 uel5olo5pkU0zgKatM/KBVq0wFYg66ViKdz4poS7Lvm4tBbpBBE+Z3XC7QQaiJS8DKKKNwwKFZ1
 9ZvM/5qGR2hAmhod36bNg
X-Received: by 2002:a05:620a:a404:20b0:939:365b:37d8 with SMTP id
 af79cd13be357-9394817f9d9mr188122485a.36.1788187706380; 
 Mon, 31 Aug 2026 07:48:26 -0700 (PDT)
X-Received: by 2002:a05:620a:a404:20b0:939:365b:37d8 with SMTP id
 af79cd13be357-9394817f9d9mr188114285a.36.1788187705685; 
 Mon, 31 Aug 2026 07:48:25 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c52fdbsm221446615e9.0.2026.08.31.07.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:48:24 -0700 (PDT)
Message-ID: <479920ab-cc83-474d-ba1a-89352cb0986c@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/47] target-info: add target_config_multiprocess
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-24-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-24-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNyBTYWx0ZWRfX1XPOq2eTYAM+
 dKeS3bEHDp5xd6Ou6Z/s7055b/jT8zj6JaPHmIL+dCz6ny1zy+RrHscZBF7TtSEom7onDJ7g52W
 TkZuEROMSJBRMzcTw7Kbipz0lZ1ePFRSoAncfcMmaJgtBtiW+djwoM44o/ge5+CQ7HM/TZOaXLa
 O/mplA0RanCaFF3DS7zMwSzPYNlYSD5Gjwq5RQjU8oOmUv+535xY+hnNVU2TX4zycTjXSIEFxVG
 zNeEEyQWyaSivIxZhRYrRZbjcwH8PcM+9LsO99JjddF4v9rwBimOKqRs0I+Y5MZWtDnznEagO6N
 xtSho/c0cah6bAdPJmrrrJfjyTse8KoW3a8ifSylpcV21T7M1ks0WMRu1wpbwuC31VvUSf3oGBp
 eWvvEtnaShla/h2O8r6K0GXSOPLF9xAF615xxyjPsf4eI5eNDBhoSwi5rZW5kmCoXCp25/pz+aR
 w0tHoYicXdkIm0BxpIQ==
X-Proofpoint-GUID: y_m5GgKNbMfL3d1mFdsN7BTiEQdqZzLS
X-Proofpoint-ORIG-GUID: y_m5GgKNbMfL3d1mFdsN7BTiEQdqZzLS
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a95943b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gmLkG3rbZGpK/HF7jnAN4w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-F8gzHD1LAQNaDmWjY8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNyBTYWx0ZWRfX1q8cCkaCq02B
 zFXazirm4ogtg4vOGNNOI3yhGrjrnXyxBFi2fsjjsCFj6TvoFyhZbHPKpa1JhStBSf+e7xvpgiS
 59i5T0TUiacaD/vdz3hNrSX7gVR0Oi0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310127
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

On 2026-08-29 0:58, Pierrick Bouvier wrote:
> For some devices/machines, we'll need to access target configuration,
> but without relying to target headers. Thus, we add the needed
> information in target-info.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-impl.h | 3 +++
>   include/qemu/target-info.h      | 7 +++++++
>   meson.build                     | 1 +
>   target-info-def.c               | 7 +++++++
>   target-info.c                   | 5 +++++
>   5 files changed, 23 insertions(+)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index cf42aabbc8b..dbd7a5a2071 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -30,6 +30,9 @@ typedef struct TargetInfo {
>       unsigned page_bits_init;
>       /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
>       bool page_bits_vary;
> +
> +    /* CONFIG_MULTIPROCESS */
> +    bool config_multiprocess;
>   } TargetInfo;
>   
>   /**
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index b23e5bc5865..579c43332fb 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -42,6 +42,13 @@ const char *target_cpu_type(void);
>    */
>   bool target_big_endian(void);
>   
> +/**
> + * target_config_multiprocess:
> + *
> + * Returns true if target defines CONFIG_MULTIPROCESS.
> + */
> +bool target_config_multiprocess(void);
> +
>   /**
>    * target_base_arm:
>    *
> diff --git a/meson.build b/meson.build
> index 5da6c15551e..8023da4a147 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4259,6 +4259,7 @@ foreach target : target_dirs
>     arch_deps = []
>     c_args = ['-DCOMPILING_PER_TARGET',
>               '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
> +            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target),
>     ]
>     link_args = emulator_link_args
>   
> diff --git a/target-info-def.c b/target-info-def.c
> index d121b8c0170..9d51371f766 100644
> --- a/target-info-def.c
> +++ b/target-info-def.c
> @@ -15,6 +15,10 @@
>   #include "exec/cpu-defs.h"
>   #include "exec/page-vary.h"
>   
> +#ifndef CONFIG_USER_ONLY
> +#include CONFIG_DEVICES
> +#endif
> +
>   /* Validate correct placement of CPUArchState. */
>   QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
>   QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
> @@ -39,6 +43,9 @@ static const TargetInfo target_info_stub = {
>       .page_bits_vary = false,
>       .page_bits_init = TARGET_PAGE_BITS,
>   #endif
> +#ifdef CONFIG_MULTIPROCESS
> +    .config_multiprocess = true,
> +#endif
>   };
>   
>   target_info_init(target_info_stub)
> diff --git a/target-info.c b/target-info.c
> index 012b384036d..5db2a6049ac 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -42,6 +42,11 @@ bool target_big_endian(void)
>       return target_endian_mode() == ENDIAN_MODE_BIG;
>   }
>   
> +bool target_config_multiprocess(void)
> +{
> +    return target_info()->config_multiprocess;
> +}
> +
>   bool target_base_arm(void)
>   {
>       switch (target_arch()) {

To avoid TargetInfo::config_multiprocess we can use:

-- >8 --
diff --git a/include/hw/remote/mpqemu-link.h 
b/include/hw/remote/mpqemu-link.h
index 4ec0915885..2dee94ac64 100644
--- a/include/hw/remote/mpqemu-link.h
+++ b/include/hw/remote/mpqemu-link.h
@@ -98,2 +98,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg);

+static inline bool target_config_multiprocess(void)
+{
+    return IS_ENABLED(CONFIG_MULTIPROCESS_ALLOWED);
+}
+
  #endif
---



