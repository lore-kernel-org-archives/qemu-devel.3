Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0683CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHNb-0005nO-T3; Thu, 02 Jul 2026 09:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHNX-0005jx-6I
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:22:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHNV-0001tx-Ij
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:22:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0flX519110
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EyO1bZCqbCVh06dSEeP0DgsMFXM/A4buwjLCjKxWrC8=; b=TEQFUw3NVqfTYCNF
 l7CFdW1da/TC7n7KoP6jD13qlPeKZay1/a5fr1fTa4nz40IX60uGlz3GzeV5N7Lw
 Kob4csk8Og4cgYQnjREi/gAiICFNzNrQtOmQ7SYOeugZRd1ymioa/vt454tdyBbO
 chLtF0dgShRdEaysvxapAVHQKJqE7ODbpAoaYhVSAV/rxtEnssT7k4cPa8IsCBG+
 hZWdBvu/P7qqO1QviqnOMIR8hl/7XoU3Gx5r2EjAemQyJgvZXRDhBvyEFmMkRkF+
 L4OPL6qXEO6RGRuNROfEbh2Gjs5EwIIMI+H8U02EsnUQek5BYYK0hgPhBYsj+orv
 JcvHXQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnp8amw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:22:52 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-59d595bfd94so403524e0c.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998572; x=1783603372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EyO1bZCqbCVh06dSEeP0DgsMFXM/A4buwjLCjKxWrC8=;
 b=Pnx7JVlVrxHiVPuIsultieedEElzc8VqaZHupGd0t9skgvnr3m4f46xoW30YlF3+qd
 r1PgQfZcvwuGzgi0NY/CMUbv23pkaBkDuS3kubEYL88K6Fkyq0HM4tyHKOqougo38SAd
 sZlrgtg11ABZu/0bdovohShzI8RrJUzXoWeF6n/xoF1Zr7y5fEveQ/Wt9VUa1pwNsn+u
 htMXb52eufW/W6cDOITRrrtsssEVvKhEeW4atTWE3IygtlCKtyauY85mpv5iauwzVlsR
 6tOs1U2H3A1ueWv09ToexB5NGGcpKt5gP6h/2bfSUWsNEHMFaKe5yvLwp51aBp6jdBzm
 ZbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998572; x=1783603372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyO1bZCqbCVh06dSEeP0DgsMFXM/A4buwjLCjKxWrC8=;
 b=ovmbqX3LZ1+mEEb+A+tCFBidJgGataxEktlYDdCC8cdc3GOmsHy9xyKDar5bX9WIPp
 afxoFTOsISePEG/7s57dSFLdkbt902lvCie15YMu54es5AuE43eRMJ7ojjmnd4W+gZjA
 h3YZUzvODKiT/eGkr8VywGMUR43KcordPDmG4ljbJx5fQC1bUpSsgVgI+fjPdwKE2yQG
 IDWRQ8TkChLJTh/fIfzH7TQaKe42UuaRDZf9jIQ1w6D4pH3n+PaTb5Tu9/R4FpAEdokF
 qT/C7jLPDxzCiTSfx5LoB02GV5A2FgoKbzmx9q/9s6v330g0Tj8JYhoxswMxhxB1irwL
 xmHg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8qAllVvAtFuKUgeKRPaZXY4zkSxTxHH+FNTaLlwAuXSvS8GfCHcSPyFQhqs7SCdJ+/6Q/h8gbVANi@nongnu.org
X-Gm-Message-State: AOJu0YzRvAexbWs38jf//93+PHPd5v++LZa/1ATHerruhBSffQ1dqCRF
 BWMyjbr5+0Yz/YNqWOir79JCVcsLnAOnljXbs2wsH4e2q65oLSrtQIwJFXYGvVOxM2/4u+wDF1p
 xvYl4PrHf4EF+5UclXZNrNgW2Rn9+wRTibPi21WGTzCq+taNxDDKvrBlrig==
X-Gm-Gg: AfdE7cmBHF0hcQF/wjymY2eW1gEPN4FC5xBYLnw49T0uiM99Uy7AZElT5a7sNAV9nm/
 P+Fw/HsmITIBFapqrVsJ+1uHz1Vr1bC6VLPTkUJtulk2J/+u7VAoGjdWXL5rbjB7x+Oh8JS+UpA
 oLZI7j9RMVbQ+cfnk+KRAYZUgFmTknNM+5s6WC0P3lH0DUyxp5oq7OPFVEwKki2rz5mAhERuE91
 r1AJT6VOlWLI2MDDsQ3TSSlLVfaisaDlsdgry5CX6K9rmVeEwXX/mNIsYfA7vrzDlQ0zp2ucpZR
 wkHIH8dJbW+jlWfv+dak6zP2PLoHNDTy5bP0z7h7WYI2sGUp6jtx8g1bP5NkIJnrQ49tUEDIS5L
 gtbHe1oQ47Wdod0q4PK2JIOfL+5AHyp8XHBkYPD16/n6O
X-Received: by 2002:a05:6122:d2a:b0:5a0:afff:78a6 with SMTP id
 71dfb90a1353d-5bddf71453fmr2231690e0c.14.1782998571982; 
 Thu, 02 Jul 2026 06:22:51 -0700 (PDT)
X-Received: by 2002:a05:6122:d2a:b0:5a0:afff:78a6 with SMTP id
 71dfb90a1353d-5bddf71453fmr2231676e0c.14.1782998571608; 
 Thu, 02 Jul 2026 06:22:51 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec83faaesm875396e0c.18.2026.07.02.06.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:22:51 -0700 (PDT)
Message-ID: <fa475add-b958-454b-9933-9f4971d09f63@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:22:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] accel/kvm: Hold gdbstub_sstep_flags in KVMState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-17-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-17-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX0LxEr3KRaRLY
 e9bmgPxgZeFv+7tWKj7UiAg83AgmAioOgymvaX7GbHkPyar5uFNT1bg2SH51vCxmKIySlFmJQ6e
 Z9pKEop2glktQap9Ll/n8MG7O+Yh67o=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a46662c cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-Gn-N_3N14VAyuSf37IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX8hlOprAv2w9p
 RL4aotQqcpHLmA+FqOVANySrLc7s3fhICjJ0dlHyoaUX4O+8V6UusG7OLRw3mMxuvYtDi6PgSK7
 xj5f9VjIPGi6FNudewqr0ep6tbwS9GSzJZNyMRCVlw8s20CTBmZB90LCa3x8Lsf25Zn4FbUmqGN
 q9eoTyfxdxW+5JoXsD8XZp+OioTsihEw2UzehUkge47dhwVlS35mzVWz/ox0hDdAQk3P1kDUFsz
 CnM9dwb6npjVlkW+ZIggs+yRXVgXhRlXKu0F70xd/41Y7GeSOBoj5+CG0zIkRtxh/qwEtR1dIYz
 S4szO4MT7Hl+k5vBjhSx/4Pkxt7idyt5eZ2/7EiB4EqoycR0rojyj4uViF4zRqNRY7HgjL36caj
 3+v5F2+e6z2gx4x+8kfb5zWj+HjV8Td5EBzZ1m6sSDYbLop9XiXN5TNWVaTJuRfFFZNROElmMBW
 0gfnhSK5nvvelEr6arw==
X-Proofpoint-ORIG-GUID: uBPN_d21AbrpTffgobg8Kr8E44LtJfru
X-Proofpoint-GUID: uBPN_d21AbrpTffgobg8Kr8E44LtJfru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020140
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
> Prefer to store per-accelerator variables in the per-accelerator
> state, rather than as static variables. This is a good practice
> to allow concurrent accelerators in the future.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/system/kvm_int.h | 1 +
>   accel/kvm/kvm-all.c      | 7 +++----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 49e90cc0235..062759eaa01 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -114,6 +114,7 @@ struct KVMState
>       bool coalesced_flush_in_progress;
>       int vcpu_events;
>       bool have_guest_supported;
> +    int gdbstub_sstep_flags;
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
>   #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 80d8ef1a974..76c9ae6d4d4 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
>   bool kvm_vm_attributes_allowed;
>   bool kvm_msi_use_devid;
>   bool kvm_pre_fault_memory_supported;
> -static int kvm_sstep_flags;
>   static bool kvm_immediate_exit;
>   static uint64_t kvm_supported_memory_attributes;
>   static bool kvm_guest_memfd_supported;
> @@ -3036,20 +3035,20 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       kvm_vm_attributes_allowed =
>           (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
>   
> -    kvm_sstep_flags = 0;
> +    s->gdbstub_sstep_flags = 0;
>   
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       s->have_guest_supported =
>           (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
>   
>       if (s->have_guest_supported) {
> -        kvm_sstep_flags = SSTEP_ENABLE;
> +        s->gdbstub_sstep_flags = SSTEP_ENABLE;
>   
>           int guest_debug_flags =
>               kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
>   
>           if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
> -            kvm_sstep_flags |= SSTEP_NOIRQ;
> +            s->gdbstub_sstep_flags |= SSTEP_NOIRQ;
>           }
>       }
>   #endif


