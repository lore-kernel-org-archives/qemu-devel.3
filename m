Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BFCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHNJ-0005gY-Mp; Thu, 02 Jul 2026 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHNE-0005fn-Tp
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:22:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHND-0001pt-CD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:22:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0bZq522905
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KnEMv28oO3X5R+tUgrwzdam7ujuj/9sa8gXkrjeSqDw=; b=gvfiZJSjiqPFqVbv
 saDIrWuGJlxjZuN9l59nvhK5Fsne5q/vsG2vPdC7JpDACLDfaMHQ5OYZAVVHgk42
 L4iSHOb2K5KYmqftIXweT32E137F1IQW7azKtB5nhcO2nXqo7HPsROcyYPPtm/ll
 cmAVv3rueaZpBf4vaCSb4AU60t2pFrAo82mydcwkQQaf3/uXPchgU1g9fYMNUa+e
 pniGuLxx2W+WYTVksOAcHuOLVyeJG+PrR8pofb5dK1s/J5AX7r12Lcjp+YvRoVUQ
 EGuYJy6HlSqx/t6FwQL78yvMHL+H3W1J7JT84foW0bbPW/aCgAvMCvUI+SFAuemK
 fLIwwA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541vw93-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:22:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ab02fb3054so626703e0c.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998553; x=1783603353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KnEMv28oO3X5R+tUgrwzdam7ujuj/9sa8gXkrjeSqDw=;
 b=JyeFKK6JRhsvqUB0xag126XXkJekam/MtA/mZvQ/qjR7g358QqlRVK/5xiSPSefDDr
 adkTTNy4TKUm+J2NZUv0cypXZcWL1DbKBLlnkKdNbOZnz/rJkyuZMSWA/ef5v7TFey0l
 27/cIgIbDzw/sFFlEqOxKtoVslgE3HuRZ3XHwUjtdNfmqRGQgm2AdxZh1Kr1QAOIqzAl
 kmtb/yGWdfL7UFw/C1yCt75+DN+ojXBPd1M4t+aVhnniTxA2g6P5XpMGydeDifiyCdow
 4juM1McezBiM1rhSqkcQy4appsqa0pvjRG/ugxSWZDSBnfELmvL/JvEYqc1C7sTxXNx5
 HGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998553; x=1783603353;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnEMv28oO3X5R+tUgrwzdam7ujuj/9sa8gXkrjeSqDw=;
 b=r+cqqpGt1oexCvJKQXZT/IWSyhweqwmVYH5PcrJUwBiyAufC+DeUQRazBH5JvfrifM
 RRgCtphZZzQpJABKoOJ5DBiJWbTz/JDfk2uMp3f6iGS9EyCcA4iiTRRnRAbdk84rOMJF
 GbNKDJQ7Kt0BJaGIO+PNYidklbKXcuaiIw4igpp4l+05OUujzOl+sOD1bJ2pp0GjCyii
 ip29gVMRO+3qtFWYBohzcWU4YoTd/wlrRNEqj2FBc+5SIL0AytG6yoB9dN/xSgV7fjEb
 CfJXFogt+NslUbcgS1lf0YD5NppWyaO4/5cItP68A0gsmhDqfaXi0QIcDUsE9Ps1z/AH
 a3qA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFdJg5H35qcSblUDixkFn4Ev8Oe96G33ubiZScJY7MQgOdves6IZ48h9mzIB/n54dIRdBjTmuPUntd@nongnu.org
X-Gm-Message-State: AOJu0YzOiYg1vegsU0mGg4pNrqC0JZX2DOgzoc6HVnyliAGflMu6E57A
 p8ZDgVNq6O+Vse3oEUdQWaujY7xm5xzrCNH55qxnwyv0Bffq6sCbS5Jr1dUdOxPExspjFMDrlL7
 HgE/Zqv19ewejKmQlWuz793bwys0hb40DRmAUbbWDnPxfzFI6iPoG8Od5Tg==
X-Gm-Gg: AfdE7ckjxrftQHFqT+VgaJYL6PyDbt6QpFAwAR41KjJB10MAJKoB/hccv9pvXdh2/Ud
 5tZeXZ6CIgq0K3riqqOScIuRqaAFOvwxVZRu+Xrpz7qyQWSEJ17fPYODuustZpUVgjWIdXONISI
 uMVO3VhRSfgDH7pTtol0HIRLTLdq3WdECAruTyxZl5XM1X59S/h9Tl/+GzAKtSY5AvhMIjILpI7
 604FXrwhZbUXGp1GEzxCZ0Vw151o1wpceUvKNarEeRw1DWjZSGCrext6FtwwNZXIu8Ij6nJUyFZ
 lHU5RY9+nPKDoTfC+2sY68zcKk4Rl04QZucEUHCwEqX54XemOyC23PDikMPq9AgJ3hvkCqmrsiE
 ov24m0O2t25cIOlfx5cZNYoCtCaFva+EwvJij9sPTfXWC
X-Received: by 2002:a05:6122:e202:b0:5bd:b2d2:a1bc with SMTP id
 71dfb90a1353d-5bde3b6eccemr1770868e0c.12.1782998553420; 
 Thu, 02 Jul 2026 06:22:33 -0700 (PDT)
X-Received: by 2002:a05:6122:e202:b0:5bd:b2d2:a1bc with SMTP id
 71dfb90a1353d-5bde3b6eccemr1770855e0c.12.1782998552929; 
 Thu, 02 Jul 2026 06:22:32 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec512e67sm841469e0c.5.2026.07.02.06.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:22:32 -0700 (PDT)
Message-ID: <63a33975-747c-43ac-ae19-6071d99b5d3c@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:22:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] accel/kvm: Hold have_guest_supported in KVMState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-16-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-16-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V86uNDYTTf45DadOXP69RB4cmC0sq_Uk
X-Proofpoint-ORIG-GUID: V86uNDYTTf45DadOXP69RB4cmC0sq_Uk
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a46661a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Z2eRk0jm574DIaDhYYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfXxIHckGH753Zh
 qVOVMss4j/sk5ZiRGvXJIJd+JhC0f9gw5IxDRh2XuksVHz7nnQ5DKijdPSywVp+t3t9ELS5H1UP
 ai8mCvCw88fxQ4b6msBU49wic4veozYH5ZeR4FcQe9syEaABdxZ6M7jNq7OnIXKV/GpA+7kGt6i
 V6+uDuVzlJYhSKhQcZvRTCl8JSBj3tar4bFLbHaA54hkRzjzl+y0C/CTkDsSthUspx1IG9pICDm
 7ILdnsKUIemvHSFEIZeNbERyyF/098hIP1C9YDQLcEJ7ZLr6HpSwYiRZi8seinjzelMeH7Dpt3D
 fbK+wSgNAQcY3xFkucr/l16QaO5JudRh56NNW2PUGLdtr0B/KxH7cwTrIxCRiKyZKjku0e5jbxv
 Jv25tfiofebgoDhOHKWzd8xuQaB+K2VWyg2KqH8tpNB8UbM4hoND5WMlULQdlaI9YCZ07eXcNqK
 Arxlm5bmnSRvTBqppXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX0MiMTMbG9F2P
 Q92wdEwRQwpxATYUpbW1QTQXKbAUmaC8Zu8C4keCKdYEP4iqY8G7XiJub7lhydGfMhlASr+/SpL
 StiDO2kEKVUfbKqCFcW+xVHvG3XuB4A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Prefer to store per-accelerator variables in the per-accelerator
> state, rather than as static variables. This is a good practice
> to allow concurrent accelerators in the future.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/system/kvm_int.h | 1 +
>   accel/kvm/kvm-all.c      | 8 ++++----
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938d..49e90cc0235 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -113,6 +113,7 @@ struct KVMState
>       struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
>       bool coalesced_flush_in_progress;
>       int vcpu_events;
> +    bool have_guest_supported;
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
>   #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 1231c010fce..80d8ef1a974 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
>   bool kvm_vm_attributes_allowed;
>   bool kvm_msi_use_devid;
>   bool kvm_pre_fault_memory_supported;
> -static bool kvm_has_guest_debug;
>   static int kvm_sstep_flags;
>   static bool kvm_immediate_exit;
>   static uint64_t kvm_supported_memory_attributes;
> @@ -3040,10 +3039,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       kvm_sstep_flags = 0;
>   
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
> -    kvm_has_guest_debug =
> +    s->have_guest_supported =
>           (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
>   
> -    if (kvm_has_guest_debug) {
> +    if (s->have_guest_supported) {
>           kvm_sstep_flags = SSTEP_ENABLE;
>   
>           int guest_debug_flags =
> @@ -3835,8 +3834,9 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
>   
>   static bool kvm_supports_guest_debug(AccelState *as)
>   {
> +    KVMState *s = KVM_STATE(as);
>       /* probed during kvm_init() */
> -    return kvm_has_guest_debug;
> +    return s->have_guest_supported;
>   }
>   
>   int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)


