Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927BBCD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMclN-000755-GW; Mon, 11 May 2026 22:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMclL-00074g-Ok
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:22:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMclJ-00061w-IW
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:22:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6csL866064
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gf1QIpaCdshf1+rp8VTVGk729QGiOkzCEiopr340xPw=; b=SKNKgKr3W+WYv4s7
 X1Wc4uXj1Bb36Jj+vKvnDiVJzrmssgR/6LEdmozYaWGPQzkEnv0ouONx+BiSM42l
 WLD6QV0sJhxq01O/FAjSXToRtsTAYf3wk4V9cbR6PTvGJw2sd9yS1CK+vrRlQcS6
 G6BGcsAv5qZrUV72EiDf1DO1+j0O4Yl7PV3Cf4mi9XrYfWcf9+Gpk1HH2ARaLvlw
 miY0zDUbt8vRY88+g3lT4Uhn56oTNhmerrC6QSroXbfVWt8cWrF02p+gsftj5SKe
 j0TucLyTPWY/8/lgPzO/J691aIrsvQA4Am4SHEjy3Rc5J1vV6yJFyJ+qGrLzTi0M
 P0z5DA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28vnk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:22:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4099849eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778552538; x=1779157338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gf1QIpaCdshf1+rp8VTVGk729QGiOkzCEiopr340xPw=;
 b=E/vr1BzUV0LWV5Reh2gL4QFNFNbPUibhlFwSqzszc0oObYMQHwvRBfRMWU7YDQn+5b
 NNbt7NQI/x3gu8zVCq6K48IVZQ6yeJljPpwCzLsJl/s0iGZT2ntneyMXKiXA4l5uKxMS
 H0XOLgmLL6BVMcTURDCtsdeD3/ibVnOq//QYMu7LQmEqlEo2rCBZFFYupRRqPPdEnjvR
 L4eTIEl75DmWNmJcgMH8hG3IGYudzl2BN0zNeao50kYn3IocGe6ISFVkjD5Quq9X6hPv
 5ajl9wi27sfM3RQQiqwRkSip9JFPNkMgmUa+s13i7gK/q92KedG6P4DtlmbadhtXtGzs
 uIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778552538; x=1779157338;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf1QIpaCdshf1+rp8VTVGk729QGiOkzCEiopr340xPw=;
 b=APgNPlFzaCNqnq6JKChoUkfz0c273KU3UOd1UgLkzlFL3i7fxIX0J17jvHoD0Z1eY7
 WLS5ulHIc40RnbcAaTHTJghXhucDKddY38HLqjNDx2m2fd2Gf1lBAOmoJYrfI4hSpk6+
 ckD3OiqYWYyOhX4lQudoOIZzx+gr9khOlxM0wqJq+g/R4VupgnHchjZ4zOzqtAFO1WxS
 VWj9DPbjDQu/EmjG6mHpiUv/ZswCl429MWTQBmo1t5I7mYFZjMz//yA5Sbb+/OfgN+pJ
 N4krfS0n5z7OK/lFXsjpsrzumdP/1YZ6diZqxrqcepCrFj/mc0o5gPUoqjKEF41uRrv9
 /5Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8s1OcDw3tX0lbNEIzOqExtfFmYPbuwIayWqKRpeX9CtHKBcfEebyx9N0zK619sAYAeNT+m5wbxN+cM@nongnu.org
X-Gm-Message-State: AOJu0YzFJR2SBhQg5xQ5ZcnOQzbuTxLbcsAC9cgRSNK03sj01YPFFIl4
 vFKF/JpBDWPE2lWWyBXT1h5Lufvl/puUrRvtiOhdKQbH3f0n6R92Vk69WOrjZSXRdyzhMGmR5C4
 9A+qSPz28fNh+AxlZFsflAxDryqRdnacqUHzpdSDTDDmj+eN4YKgXypdn4w==
X-Gm-Gg: Acq92OH+UT98uFaHHFLkFwTv2uVLOnQEynmCWFJ0gJULap2EQ2aMAXg/3+sNMCrISNx
 aYKDR9TdGuEE0xM1LmJAFW6BpE2RbuecIfHfl8hWpE2zmFuEXMTRESl3Jv0lGrEIfNGNGs+QkYs
 d4BguZwhJl9I35pmFiIuc+U4WoXxTalTUsgPOe3my3c2/NoMDnSfvsKw93ZXZBu+UJbtApPjVOt
 eOh10MuBA1JCNrn4nfQaY6yUnsS21tV2M7VqSiWUSXtPWjbQbp5MD5mq6fNrjvjs+/pVnwRfRoo
 7f7K3JsQ28XAw11/AnqmMMFxJGxtiJH44Zz7dnuH/24Y36E/f7biV5Uaey+IwnFgw3kpaal4m/r
 XqBe7I1ZT0XFKVToMtvT2o5Aex+zpi5nRWQjJJLo+/Ib1rzBoQ4lkc24BVqhy69bKJbPHLaQPxP
 udwXw1DqsxmHUSPQ==
X-Received: by 2002:a05:693c:839c:20b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-2ff907f1630mr852261eec.0.1778552538387; 
 Mon, 11 May 2026 19:22:18 -0700 (PDT)
X-Received: by 2002:a05:693c:839c:20b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-2ff907f1630mr852250eec.0.1778552537771; 
 Mon, 11 May 2026 19:22:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885b87dsm19383510eec.21.2026.05.11.19.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 19:22:17 -0700 (PDT)
Message-ID: <28e6ad6e-ef06-4cc3-bf17-c7a880b5e500@oss.qualcomm.com>
Date: Mon, 11 May 2026 19:22:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target-info: Expose target_info as const data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511190634.472174-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fnz_Tpyl8ZlZJQcvRx0n0A_ba7R07u7f
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a028edb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=8HHMHmjav-g-p7MQSzQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: fnz_Tpyl8ZlZJQcvRx0n0A_ba7R07u7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMCBTYWx0ZWRfX2L46y6+fVZVT
 EHnS936veX9ui8bPorFc0t93qo1eMqoHrSDm6yOHSf7KpSKDqtba9EY5hEObHqn7l6z/40y98oD
 Zs1TaMGOdstd1/4I7arvBAcaIrXvi1Ch6O/3YXIDKC3mESwNjpixWfW47152RuFx5Xo50vVCiN5
 qsiWL3SpSd7gMu/1jgHayOyjtyhQ2KIh6Hkx0OOecX1PKKkLkwEcfYaozusmdWqLBaRnb+U5VF6
 XWJ+BD50MrhohdQQzPTrThwp5ZMNsy5iPqfY0KOb282OalI8rTedJTFX24FGZkJP5YtLq3/S8ah
 Vi9YZxl8pk5KnLAy/UtCY3ZL7Bb85vAgUdor652NiiaoSM0G1IzTPSdSduE0YdWZ2ZG3CMvrsa1
 o1biuUd5SJUq9oNxeK6oT3PUUFmeSJlMA14fed6iegs4Vv4xrxb9MrlNvcmWN4dSGP8BEtYMuPD
 8QDwT9WZ+oZ/R3JIbZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/11/2026 12:06 PM, Richard Henderson wrote:
> Expose a const TargetInfo structure instead of a function
> returning a const pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/target-info-impl.h   | 11 ++++----
>  include/qemu/target-info-init.h   | 45 ++++++++++++++++++++++---------
>  configs/targets/aarch64-softmmu.c | 18 +++----------
>  configs/targets/arm-softmmu.c     | 18 +++----------
>  page-vary-common.c                |  8 ++----
>  page-vary-system.c                |  6 ++---
>  target-info-qom.c                 | 11 +++-----
>  target-info-stub.c                | 28 ++++---------------
>  target-info.c                     | 12 ++++-----
>  9 files changed, 65 insertions(+), 92 deletions(-)
> 

...

> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
> index 75d95b0e74..4f43f3e89a 100644
> --- a/configs/targets/aarch64-softmmu.c
> +++ b/configs/targets/aarch64-softmmu.c
> @@ -7,21 +7,11 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/target-info-impl.h"
> -#include "qemu/target-info-init.h"
>  #include "hw/arm/machines-qom.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/cpu-param.h"
> +#include "qemu/target-info-impl.h"
> +#include "qemu/target-info-init.h"
>  
> -static const TargetInfo target_info_aarch64_system = {
> -    .target_name = "aarch64",
> -    .target_arch = SYS_EMU_TARGET_AARCH64,
> -    .long_bits = 64,
> -    .cpu_type = TYPE_ARM_CPU,
> -    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
> -    .endianness = ENDIAN_MODE_LITTLE,
> -    .page_bits_vary = true,
> -    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
> -};
> -
> -target_info_init(target_info_aarch64_system)
> +DEF_TARGET_INFO(target_info_aarch64_system,
> +                TYPE_ARM_CPU, TYPE_TARGET_AARCH64_MACHINE)

While it's definitely less code to type, I don't think it's really good
to bury that under yet another macro. Code repetition is not always a
bad thing, as long as it's not code we'll have to modify everyday. Those
definitions will probably never be modified in the future.

In a single grep, developer can directly see the specifics of this
target, without having to guess any header name or refer to another
file. As well, the target_info_init patterns follows the x_init pattern
coming from module_init.

Regards,
Pierrick

