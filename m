Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905F5CD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLW2N-0003cu-S8; Fri, 08 May 2026 20:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLW2L-0003cm-Q7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:59:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLW2K-0006VS-6S
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:59:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GTgQQ145197
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mtlcyq4gW2kekOHPEsMKa9ui5E+y29feXr6fBtrcslI=; b=WyJIy0tMdVKt+Ke/
 b+gVABQcClqDma+rIWOWd2RxdVrynDBMM0tzPHox+EsNPJ3ASDpmaoIkjRq+c1ae
 BkjsA8S7jUwKtTKWWoKGiM8OvGMZFF1Ynju8HXvVYuV0imD61FlYhIbIes75hjTD
 f1MnMVBNwTJKnmh2FIjB2Hfx/MofmHgqLBTRTP0rykRh3ib8CrbbpLdxHyh37NMr
 8ieweIQlhNKiq5r7UfjAP28NRyK1LRWShCzJA1pnh7LBcN+h61LU6ccwsA1SFqjr
 MeWn7rTzqT0LZMdNmsnKW1uaPzPIVEOozgSEKoZUg7rhO71FYnH93kK+DGbRvq8j
 tQDqng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1kdc1c8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:59:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ef62078ee7so3184454eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288357; x=1778893157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mtlcyq4gW2kekOHPEsMKa9ui5E+y29feXr6fBtrcslI=;
 b=kQY1E2XuqEP2i2pEIrQn2jl8OqKkQ7rv7HWnXvSL1k/Uin6YWKpV/V/KoKD6CEg4D6
 iC5BGEQVEvzgesgxqPFgpdNWN/LLcczyp4SV7zHeh3BftNp+EImRDvycf6DYapA5k4aI
 8I7f5DTrrNO0r2u1WqBkcVD7NeddtrU7pAdLJlUsp2WU86lwFxDUgL1M2qvQtBXlnQyw
 CBYIGTLYyaJPkYOdA/bw24BrNZDmjm/3LKZ7ksuSDdTYbjImVNvlv9pAO0xnmQu/qlw1
 y6ZXQcgAO3ookLKduw54q6fO7Gh1LiGXZ8Q81T4b8J080QV67KxN0f0QqwQhI1RM2iNg
 gvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288357; x=1778893157;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtlcyq4gW2kekOHPEsMKa9ui5E+y29feXr6fBtrcslI=;
 b=CrPRQ8w0Pl/WyG+4e9iKIDajnzjFF47N2n4VdI4adNm4TYZR8kB2n4tR0nBoOGToA2
 T+XsfsmttSjJPjhwjXxxHZUrvuQwUdP14kKwthsVHanOCNH77k9LOrZFM8DoLboOCnqM
 U2BPocG1PSfHU95vtm3dGTfxS0elJgCIeJGQJYIljOqertfcMkVqHGWMr+Y0zTYmlQ1Z
 3v93jUXalLzPKfYbd/nmnTpzhoFGMlNPZyHmCyIlHPM3tsvo6Lq0M4q6ZqBlHb16zpBe
 Aw05f4FeJiag+CesNmI9VJTsZ8QCte7QaQnYLnlXz6CGF8scNGeuHPCVvVoi4p23TJJi
 zWXg==
X-Gm-Message-State: AOJu0YzfAbBKNFK5jP7lTpj5XRquFlSMqJ9almrdXeYJYagwTtP33yIm
 izPL5soSaH3KmSf+TCdNBhl+yvjHuzqzwOq+KnBEmAMkcRFHQVykATdnwwlCpy4Eu7wV9WMExql
 WU4n41Zx1uVsmfwASmq4cP/0+BcdFokArnQsRrNG4F3gk15J2Aog+0wSOmgCRJjuosgw7
X-Gm-Gg: AeBDiesQbED/hjzj3d8txhXB9wdlEuQCSrr+J0Vfrw5a94uSKrdJdHiYCmGZkBXS3Cy
 dUTpYbWc0HFAMvkcGtLNOrCNfeRThRc8FvnXIK6Q9tEj13LqOk3NyKXhHebdNWu6fPU1/JyroDP
 Ntes2O9jM3DYEKJj60J7sGTNnNsbceRUglJqmFtD0VCLP9ocVuwicMz/wiY3yOsT3K3K3st4h5f
 UZV6fs/lPNcB4o/htAZKPRCLKVQ7bQI6oKbKmZdSPOkxx3Q4lovqUZ65L/uE9FgWbygpau8L8eH
 c6zBJIw4X0BXSWEDEkcrl/z/HjypEWz0TdPsgI9NWbt8UvNf6SwlkvGPCYWCRyFIaednySUcJkN
 2KnoVEfipbYLD3OjxO8p5PxRfGzRS4tKCQnuUD9/2LqfNqzF4dZMgEHEQ/eWXUdIqHyHj6xaQWI
 9qUzxkW3myn4bzqQ==
X-Received: by 2002:a05:7022:4594:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-131853e5b5amr6478633c88.17.1778288356908; 
 Fri, 08 May 2026 17:59:16 -0700 (PDT)
X-Received: by 2002:a05:7022:4594:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-131853e5b5amr6478622c88.17.1778288356331; 
 Fri, 08 May 2026 17:59:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865a1a4sm4572208c88.10.2026.05.08.17.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 17:59:15 -0700 (PDT)
Message-ID: <7854820a-9879-47ec-95ba-7f7ae65374a0@oss.qualcomm.com>
Date: Fri, 8 May 2026 17:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] target-info-qom: use a single class_init for
 target-info-* classes
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-7-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260509005453.3984184-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNyBTYWx0ZWRfX48nFLEvbD0gl
 5JnkYspa+060r1BXfwuTQbaatXqfck49NOjPEVF2F8LQ0AxtMULO6qpgCKsvxrvCXlIFecuxS8q
 bM60TG37FOMjZRvvb6SQZmDsQlA+zYhiCiWYMV3f/k962kQX/fjA/ZAdXjZuepRCzgvGBOsp7FN
 j0q8cAwKE69TzX+SYm/y8omQLOsuYvk+jMhKSvtCEMMuS1As+XZfSHjOKb6wQupy7SRPWUr1yge
 IVkhXjv+UZHFVdy+bszVJAQ6sF70VZNoQJp0Rzjj/gbk/hrdQbV8dzyuwQZ6B+B9HBZ4nPhp0v+
 OzOaDK848STcjWMPy0Lj11a0r9sSmfGajZJ7kfXr91imwhsCMVljTp+eYXMcNqwQj3AQNUkgL2k
 desPEQRQ2eN3Ib50+UG5rsWCHKbCd0yLsvVHTaxQkmO3tBZnkIr879WUOxhT3p+tSZsuYaveIk7
 93IGaIg3XNbTuBAFG/w==
X-Authority-Analysis: v=2.4 cv=RZOgzVtv c=1 sm=1 tr=0 ts=69fe86e6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=h2DMTY1dD-fEPWrfL-YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0ULXmnpA8lRL276W5h7JXI3Iks6eNSFc
X-Proofpoint-ORIG-GUID: 0ULXmnpA8lRL276W5h7JXI3Iks6eNSFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/8/2026 5:54 PM, Pierrick Bouvier wrote:
> Instead of defining a class_init per class, just use a common
> constructor and set class_data to corresponding TargetInfo structure.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/qemu/target-info-init.h | 14 ++------------
>  include/qemu/target-info-qom.h  |  1 +
>  target-info-qom.c               |  6 ++++++
>  3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
> index 176fd975a16..3945f2998e0 100644
> --- a/include/qemu/target-info-init.h
> +++ b/include/qemu/target-info-init.h
> @@ -37,8 +37,6 @@ const TargetInfo *target_info(void)     \
>  #include "qemu/target-info-qom.h"
>  #include "qom/object.h"
>  
> -#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
> -
>  typedef struct TargetInfoQomTarget {
>      TargetInfoQom parent;
>  } TargetInfoQomTarget;
> @@ -47,24 +45,16 @@ typedef struct TargetInfoQomTargetClass {
>      TargetInfoQomClass parent_class;
>  } TargetInfoQomTargetClass;
>  
> -OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
> -
>  #define target_info_init(ti_var)                                            \
> -static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
> -{                                                                           \
> -    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
> -    klass->parent_class.target_info = &ti_var;                              \
> -}                                                                           \
> -                                                                            \
>  static const TypeInfo target_info_qom_target_type_info = {                  \
> -    .name = TYPE_TARGET_INFO_TARGET,                                        \
> +    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
>      .parent = TYPE_TARGET_INFO,                                             \
>      .instance_size = sizeof(TargetInfoQomTarget),                           \
>      .class_size = sizeof(TargetInfoQomTargetClass),                         \
>      .class_init = target_info_qom_class_init,                               \
> +    .class_data = &ti_var,                                                  \
>      .abstract = false,                                                      \
>  };                                                                          \
> -                                                                            \
>  DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
>  
>  #endif /* CONFIG_USER_ONLY */
> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> index 91be415ed33..a37c3e101e0 100644
> --- a/include/qemu/target-info-qom.h
> +++ b/include/qemu/target-info-qom.h
> @@ -25,6 +25,7 @@ typedef struct TargetInfoQomClass {
>  
>  OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>  
> +void target_info_qom_class_init(ObjectClass *oc, const void * data);
>  void target_info_qom_set_target(void);
>  
>  #endif /* QEMU_TARGET_INFO_QOM_H */
> diff --git a/target-info-qom.c b/target-info-qom.c
> index cc470b3b4d6..5b0498ca654 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -37,6 +37,12 @@ static const TypeInfo target_info_parent_type = {
>  
>  DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
>  
> +void target_info_qom_class_init(ObjectClass *oc, const void * data)
> +{
> +    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
> +    klass->target_info = data;
> +}
> +
>  static const TargetInfo *target_info_ptr;
>  
>  const TargetInfo *target_info(void)

This patch can be squashed with 3, but I thought it might be better for
review to keep it on top for now.

Regards,
Pierrick

