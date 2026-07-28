Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53A3C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woa1I-0005Gs-Te; Tue, 28 Jul 2026 01:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woa1H-0005GW-N4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:06:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woa1G-0004sC-62
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:06:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46WB71821206
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YfwZGn/EzMiI5tNz7oLqs5ISXl4QmUglwDUteh7F4ck=; b=Txww2GGWeS1o5Vz5
 JYSKkY7hWIoGrcwKzOYpEwYU7a/0qYwBFFKBDUUhNjR4qnjYH4KunHqM3CWIEdB6
 43yEnqv7t7ThF9SdUdoVK4yREnb9VACZwpMKRHdkKq+ZhpHGvwZc5xf7TaH1ifzp
 1mJEEF1IzvFcD3nE01uCzfctAzOZUiMYSPdfgMwq5MmKTIQRkjHfcIAmKGmvItQk
 qUieE6Xjid8seC+d0Cqa6LfIfWjbM2F1pK0D+EEqWsgpx9EP0cmpRwtsOfBhhwBK
 nQ0Cw9M+ViQs2VuD6Wt8Uq/GlfDKX8YKGrvO6VODMJFacLmkkh3JryiMfjxh3JYr
 6kEQIw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y05tm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:06:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e7ee64b25so513226285a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785215180; x=1785819980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YfwZGn/EzMiI5tNz7oLqs5ISXl4QmUglwDUteh7F4ck=;
 b=IvqfyJryd1z7R6gF8y9x51zJ+2OGSpxcbg5RrNQLba5VvmlgKQObuikypukANjOpze
 y6TH56QNaSK1l7v7bEScF/k8gMHl5J5L3dqwhYKGPZ29VdFShPz/YEMPo8bNYiiEpAdE
 qzadd1yU5kxC0imm96dbOkIjmvkBQDYG38piFiH45dBtmp9tB+/lbSaC7RXfhCD/Pmut
 BMdkd0sK5j6HvI5uheoDOQA1V5v2qZfVL5GmnGVFl2NNpnA2TRPoifsvVY34VpujfpaG
 z5PeMV+9Wv11amIgM+iqwb6Wf6DSCR4MMbAHuwaVfNfE0PIQQXAnKPdvPvoWibzYSanH
 dehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785215180; x=1785819980;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfwZGn/EzMiI5tNz7oLqs5ISXl4QmUglwDUteh7F4ck=;
 b=BeUNAulE4R3WwHv4e+wS6OtfQRnNUNWdN+QgMTVPIrfnX9mL6X3l6/iSn9d/x2RJpK
 Xsia0Pzwx63Ec0m6iPR2v21TWlOkVidXpYKEUlFDQYw+kCZdKBX/TngpuC/oUiN+uEMS
 GvdJZe4Xb94QioUPg3/IQURp00OdrOibYCWZDljk3OKYjW7dXqrAcqcmoaAerdYjMBn4
 6fRr+Os2sFYl2Ks00eTmHli6NPho/0h3o6kfsxRTLoNxjV4Oxm4I8GhBVksFqAClLR0/
 rq/ojQu4ewSL0vphA58OGwqMlE/DtsZFtsg5ZIcuNOXJE4PnVfzMVJHso65E4tEyIEB2
 JBZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoprkWH9faW/cgtp4f2T5P5e3hMGUDnQlFIHMtNcTetYQ2U1eAz7o5nUVndHn8N9jAw0VvA2EZgjLYS@nongnu.org
X-Gm-Message-State: AOJu0Yzyx3RucdC+/cxe7OCAXPNETaSOzbgG9bRGMzESWeh9nKzEpznX
 QtHoq8wkT8ep+oaONHJL98OvKt2cHJsPbpeF67ObKuZdsvBVA2rFbSCOfdjc6BEMLg7DT1IrWcr
 30v40q3Bo3YwcQrWRIbZwon9HRk6GcOY5/yW5NvRkonJJoGgofelIasYSxg==
X-Gm-Gg: AR+sD10rnXk4opZIrKgF1Lp/BESKN0V3LskU8x7ChffvRmWmV6oedcWyJm0kxZ0s/2D
 FR7FjFeH7cYPIvGNuwGQ7BhO2FjuWLMG6dYt1cvm05BCEgCYpOOB3z+Bb+rAhm1UEsKdS5ylfdR
 0PfVjmffNFfFafP1+x3+iwNW17pmeZhoNi7HbjlPGKrRFfEhHMkLI/VL7BV+YXlhN3zddGD5ETl
 XlOLHBy8ZLoBoZ217fxyOS3kHANLsTmOVOVnueTovDYlCg6roIdC5cLMDVwFO+cdgU0gC9TbvW6
 ywWS0Hdh/xEhsuAEtzJ5MGXOo2mOjvFv7LfFYJGNkBaBvszeWklfMDCNvrQLU+aMaE+cKyk4KBt
 MbKP8NY05XK2E+b7vD1zXAoAN6tSTZQ3BVF1WLkMmckVu0izhaWA=
X-Received: by 2002:a05:620a:640b:b0:92e:76a1:96cf with SMTP id
 af79cd13be357-93302774f9emr79144285a.39.1785215178582; 
 Mon, 27 Jul 2026 22:06:18 -0700 (PDT)
X-Received: by 2002:a05:620a:640b:b0:92e:76a1:96cf with SMTP id
 af79cd13be357-93302774f9emr79132085a.39.1785215176046; 
 Mon, 27 Jul 2026 22:06:16 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm53929055f8f.28.2026.07.27.22.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 22:06:15 -0700 (PDT)
Message-ID: <3b4719d5-6dfe-4bdf-83cf-563d9caa0996@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 07:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 095/103] tests/tcg/xtensa: xtensaeb system tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-96-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728044248.137626-96-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a6838cc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XVtNsFYKaq82qAaS1gcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX1w95Efw1AepK
 dT8ew023toEWLbtatYPD4v5M/9No96+D6mnC0+IZV1DsaeNYgh13Xb0WMxno9WkU7NgXRKAyUE9
 Fje3W4pHS/iaaUiC4L6UJzkesnZYLYU=
X-Proofpoint-ORIG-GUID: PJtLz5iyj8OLlnXKqFLVzrPSnTMW9jGW
X-Proofpoint-GUID: PJtLz5iyj8OLlnXKqFLVzrPSnTMW9jGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX/5DfrNcOilYQ
 QNp4IjenoV340YqyHsOy1scEOzduUZ5eeKzXZRi78jhgJe88xGQRtoskUNy6bwKzHOLaUTxQlPe
 GE5yHsh5OpLEwQ0EhXbTZeecPoDubjKPuw88tOh4V8Sw7AWO8lmO+zhffeK+2Dyjvxux0RWUBz5
 1bqx+TYCYcBI+Y6yjALr7NVIS7TPH4bIZ71NiaVm7CU/ZDg99mEt0hsQ4i8j/0qfcm7ft9rAgfH
 Bf0RvaOeAbaBlnqGJlU4baYb04eh50bZeRbcM8n+NZZDlH7VBD7XJODOY667goGL6bqfClG5WpL
 LP88jwHyGgZcM/1LoU9vE/4jkjN6W1torGC/HWi/0qVil0gvFu2U+yGARawmMyd/ZgbY46nInCz
 MJrannTynea7jEsW7whxXZVg5m+nOkR/5AUmq2ER5/6IEZZjLmNvaThG2s4K7tx+hYQBislr8oK
 9p0AiaGi1hDA7FXnIsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280043
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 28/7/26 06:42, Pierrick Bouvier wrote:
> Deactivate test_timer which is flaky with xtensaeb (25% of the time)
>   ./build/pyvenv/bin/meson test -C build xtensaeb-softmmu-test_timer --repeat 100 -j 100

Is this comment still accurate?

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
>   tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
>   2 files changed, 15 insertions(+), 6 deletions(-)
>   delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
> 
> diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
> index 7c3c4f7cd62..680fa02ff5d 100644
> --- a/tests/tcg/xtensa/meson.build
> +++ b/tests/tcg/xtensa/meson.build
> @@ -1,5 +1,5 @@
>   tests_per_core = {}
> -cores = ['dc232b']
> +cores = ['dc232b', 'test_kc705_be']
>   
>   foreach core: cores
>     tests = []
> @@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
>       }
>     }
>   endif
> +
> +if 'qemu-system-xtensaeb' in emulators
> +  tcg_tests += {
> +    'xtensaeb-softmmu': {
> +      'cc': 'xtensa-test_kc705_be-elf-gcc',
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'folder': 'xtensa',
> +      'gdb_arch': 'xtensaeb',
> +      'qemu': emulators['qemu-system-xtensaeb'],
> +      'tests': tests_per_core['test_kc705_be'],
> +    }
> +  }
> +endif
> diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
> deleted file mode 100644
> index 3df131acea7..00000000000
> --- a/tests/tcg/xtensaeb/Makefile.softmmu-target
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -#
> -# Xtensa system tests
> -#
> -
> -#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target


