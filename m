Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHK2-0004NY-Gm; Thu, 02 Jul 2026 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHK0-0004MV-Jw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:19:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHJy-0000e4-AA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:19:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ct1406514
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSvzOmd3QHuyRWM5QFBPZlKP+U2F2hKomRRLDSN4iTA=; b=pSVF2xZgRfhPgA/I
 JmXS+DyY2bq3fISWSuwUOPfY7H1Mi5tgsf5wlQ4lbqaCL+ymYc6Nsi75OcFbG0Wf
 VE8FVWnEQMhfOcmzxh2jzFeNC7LqEYLwoWfSrU349stTRI1UVP1Bl9tbJxA4ctt6
 WKs+zML0oA0zhUxS1WgGb2rJlTDGoNdi2y0LvG3ZAO1nkntHPCn3uNxRMDTn02YE
 tG/pmoQg158kqKDfPkQko6Pnf9HIjvCqRZMGGl5nbIco9gUDTNTuD23AILnGmgFR
 yhQqE19llkzQXUa0fcvrqCih2CrGNIpuiKadAVUU7wS+dS5HaTgQI5kindecZPVE
 WlGiPQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98hvbn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:19:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso19380171cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998352; x=1783603152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kSvzOmd3QHuyRWM5QFBPZlKP+U2F2hKomRRLDSN4iTA=;
 b=bAhiYWUiAate0s0MA6dsGp68VbrtGVGMUiXBr9cJ+Lk9GRnPozfyNynjV3sJjsrNzs
 Q+3VCXIzIVHsDqvsOyuDQf4fcYRO0IfgauqPvb1Z+8FzFFZDn2FKmpN/2kjXu1RzdZPe
 NBd2tr4aNnW0Hf1luDhIwV4ktCePFGz5lFDDQz46KSzgTyUbCn7y38G2/G4lbA7Hu/oO
 kfQY2KAtWE3qsUtHgkC++rTUEu0pnPxqYlP/o2YJJYevI5iL5N+QkK4Q/sE4AsxD9YaX
 Ot+HxLKFddRnobrqToPZsgtSkhfszAAHceJ/HP7ARFOYCcXSf1PJFPl06iVUCsUumHBD
 Hhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998352; x=1783603152;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kSvzOmd3QHuyRWM5QFBPZlKP+U2F2hKomRRLDSN4iTA=;
 b=iTbgm0Hpn1/7X20O4xBJPbS0l5fqaaEe27lmHqNI6mqbW6PzzK5gO5LLiQ6MpR4o/2
 fYtk7UvtVw8IRinNupC9eJj0WiJMVDa06fU3qlGQfsnViMzlvx1glPY8j92biVWNNVKd
 pjDZH5ctWJXZV8mQhFAobLW/YTtJZQ7VK3qoSAZj4vL5sX58HlMHRBuz+IEW+qxoOUWx
 Ot7H8TyBmmMgQCp9QLc0meoTiYbO/PvjHsxWzzP+/KAE6FI5pGza1YuyA+NRSkoBjGUe
 RK266sgD/x33Om9IQFvBUm+kbDnydi2JYfwNSZS7rIYdqCb5oJlNqRFNWn2s7jsgMccF
 p//g==
X-Forwarded-Encrypted: i=1;
 AFNElJ98aBY2z2cctfKbIuyGP0yMh2VpalZ/W1o2CNfeuOgVAxBWFHiPyQftrSHSuz8BnT20qOd8FQdMuxsM@nongnu.org
X-Gm-Message-State: AOJu0YyMwCBSgcFKzy56p1Iu/9iuTIIyoDnJ3UDWL7sOuaC/trGFXUko
 +m3pdRE2sjqKF3Boft/3+U/Pvc2V+SVxFFNFMz+GgTPbW6R8aUZV1Lgwr6ZZI5G+FtwxVd1aKcG
 7uBzy3gnX35SVvFX2IvSREETewCGmySazj6vJGf2TUm8k+kkDCYXF6nY7OQ==
X-Gm-Gg: AfdE7cm78n1+LntCrt3eGz3YiW3Z4JXesR2kt0kyOE/6gw+xB3NiB3lvFljXAvTXwpx
 GGzP4hfet+KEyWHmDkdXWr1UgdUL6ZYJfG/UFe5m4YADOmQJGoZ7PWcAZJz+42wlzxjLxhP+/hz
 iZpslUGGPMXt4SfhZRkMAUlviiiu+iNZHKxK+uEbI5qLmR7KFnZZAF1mSA45/w++SEbomFW7jF/
 R3ZPdKpaH3l0ow9GaK0clejKvDS07gpclrF04/IncQSVhezfXWCRsZvEbSYvlf7bKUCFqRNjcIu
 xVCMnFwlypivf3uu2E9HCKRHwGI7hQ9kdeOLuPomlJQJxORRhqvweHkQVom+LSMeS+FPhq8kTcu
 0L2kxjMUUa58MiAGSO6POwzYQX2Ey2GbTfj5P4sUcssYK
X-Received: by 2002:ac8:7d85:0:b0:516:e39a:8540 with SMTP id
 d75a77b69052e-51c26b34c93mr74590831cf.48.1782998352337; 
 Thu, 02 Jul 2026 06:19:12 -0700 (PDT)
X-Received: by 2002:ac8:7d85:0:b0:516:e39a:8540 with SMTP id
 d75a77b69052e-51c26b34c93mr74590291cf.48.1782998351786; 
 Thu, 02 Jul 2026 06:19:11 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c30c654b7sm13792651cf.29.2026.07.02.06.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:19:11 -0700 (PDT)
Message-ID: <1e9adb53-14ed-4645-8e42-1ffdacbf6e85@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:19:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] accel/kvm: Always define
 AccelOpsClass::supports_guest_debug
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-9-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qIiqpBh_-KBlzztQPZ0864M2_YvJ2ROM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfXxVg9jxXuq619
 VrAl0xD3/rKcQKOn/FtQECe3nsLs0hRNBCsQukpseHNMvL1rLPWqNneP0jwBg5jscLCfn0pXImf
 pd0MxoyRUvwtqqkjURxuyUBhguFPIwfyRlSF497/g2uHQlg8WSUCBV25uzCK+djwmt5EgLLp6Vn
 KECfBAcRy0W5jNJWNS13wQ9xO5ruZp2+fCnOQ8dsYDcRVzEB/PmQENdr4a4Y04frk1khEiMm4iN
 y05kFCjyCRpZTXXZRPEzOmg7ET4HSkBImu4wsXpDkFiSGMLYcfEjOHO5jF/abthh/iJon+6AyzV
 SR3cIHCOYnQXUGdo5vqkxJCfA9vf/hSUrPS/lQXQsS009/uWh9OkaI5U2ERGr1PWFqXWpq8IXnx
 2v9F7Q75zOndOTEPFsoc6iUfBM8FxOYpQ8VrZbBvj5euG7dXoNs1DG1OAernnggt8kI4H9OB2tb
 rw5zJl/i+lOou7dpgQA==
X-Proofpoint-GUID: qIiqpBh_-KBlzztQPZ0864M2_YvJ2ROM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfXwjMNOCIUnpmQ
 4vLCyx5tqZQJm5M0HbAcle6JDyDvizS7reic8SToCeUiizqHqlGsYzKpGulEzCnF3sC5Fo76/mx
 /dKexNkTl+postuF016xS6qKf2OWplI=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a466551 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Lo7vc7wH-usra2plS0MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Whether TARGET_KVM_HAVE_GUEST_DEBUG is defined or not,
> kvm_supports_guest_debug() still exists and can be called.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   accel/kvm/kvm-accel-ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549f..d7967bc922f 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -105,9 +105,9 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
>       ops->handle_interrupt = generic_handle_interrupt;
>   
> +    ops->supports_guest_debug = kvm_supports_guest_debug;
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       ops->update_guest_debug = kvm_update_guest_debug_ops;
> -    ops->supports_guest_debug = kvm_supports_guest_debug;
>       ops->insert_breakpoint = kvm_insert_breakpoint;
>       ops->remove_breakpoint = kvm_remove_breakpoint;
>       ops->remove_all_breakpoints = kvm_remove_all_breakpoints;


