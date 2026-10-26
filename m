Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cOd9KM0B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdMx1Gf3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJKe-000522-ES; Mon, 26 Oct 2026 07:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLJKc-00051t-D4
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:57:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLJKa-0003x8-4d
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:57:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtWQQ1547930
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i+bG/+hHjr+zP8mbti8gBByokTBk6tgyq6xNjledQUk=; b=cOd9KM0BROZObZD2
 lVAi0b2xLEGsK9agRBXWaIsXP/GFwZ582ovw7PaAF4u1I94Qj6p+t/bUjYvDbysd
 5AcDPhx5s2PHzaUfaN8CDfy3UnokxbW4YQrzNR6aOwjEmcKQYeMhZGa7LvYi6o8m
 AKlDh4jFCBowN0VXVJvtZ8NmxkDCbYpkrrzeZMAaop1s8tSZgPYI7QfCbz7ysDFx
 eC/rcV5dXb6GcFux5Y/PYtY/yS/tBQH70IsVbfBmSXn/bI9h9bDS5DOJTW3rI7Gg
 rDqLv95QkCQnYpmaGCeWfg8NC1hGh88/7JDB5tLW6HL3F7mNDhNBI/hdCHpSELlg
 J+9fZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgstaaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:57:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf6c528aso471080185a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793015852; x=1793620652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i+bG/+hHjr+zP8mbti8gBByokTBk6tgyq6xNjledQUk=;
 b=gdMx1Gf34yzMQ1pr3zqhEDM2jqdE367A/rxtX0uPZmDQ+Kl1Z7XZxQ1yFZvo2P1XkC
 46NdlnRIVBJUTmIVsugP45cYvu2mV8ERGS1X1kRrUmKgFbHKhCmXYwMuG7QF5Y5Bv6Y0
 025B+7ctYOsExQmy5cWzqxEBZTqFTJ31TyVE1k4ek24ZpWa8gkC/12OMJdOcMKJSpthg
 T/JuTNTu4DM8qem8qrIZeAGbBlwCVhBhGWTq5gs8AinI7TGbU2EmenbddPCKbZoVzqNs
 jk/T26fkqEux/mHoUkqMz0f5DlZ5wDHC39lvgOYl2kj92jbDpHlfiGAXR3lb7L057ouT
 IUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793015852; x=1793620652;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i+bG/+hHjr+zP8mbti8gBByokTBk6tgyq6xNjledQUk=;
 b=R+B5BbiqdD5LjFc3zfayMI5z5hpZHq2hPeGn7SNkDWnM+4xOoMAoWK1BzNIzWmjgjT
 81aqTCD/F3LUxfjjOwEvufiMHUh634MGxG2c53jtk9OkqJBvrOy4CCDMzAk3Y8nhuRub
 LadO9u9n2Uyx8gb4rURlD74KCqXA9irfCGiDHwFxcMtAfnXrc01Mo64D4+/NGCqbbOt+
 +KbWdppOr2iWgmUzp7QyyFFtROgY8TGlAD3QYlJ9L86WOYYyNIfYVjpMgtNKquMriH1H
 8A7KAjpda9MG67R/P+jIwyLbFfjy5t5EvR27Lh57fIoToBuIEEeZW/9XlXilPoqyQ7mx
 C4UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9XD5wIKj7HixFKcptDS4JuvzXunSTn2jkhtHuBwziG6oI5FHMJPfqrfxYPQW2xc0yh/kHBsVxg4TT@nongnu.org
X-Gm-Message-State: AFq9FYIRj4+6YHn+uFQnodgmm8PmOaKxqyjcz4hiUJyfDpl8p3yYS2sA
 zdDmHq6/KYd0Yc7kFnIYraOhMB2YUb7oZ3ch1WkYZrJGOpsPLmXnkDZAbZ8brEh/pBcEfmEL76Z
 HLyj+xCIDsfU5YcU5nO6PieokPm+aE6DQmXjqZo1mxdn4+I9tiJzM/X0VOA==
X-Gm-Gg: AYBFou02zL+sgxJWzFeQT4MnxQ6IY5vNiOLz+po7WsaIzzUVm9VhVt1saQpiDGyOJIR
 XWJ77GjLmk3/gEvCyG30bIx3MN3TuJCFRgOTQG7gCXMvznq63sQjPcXoj0LyCz1jFOWv5tOQk0/
 izCKu78MQRQuO+maa1DRJEqmnFtHv/JzS+50SW4dl/WOXTVJpXfvLuydEX94F2+FvpbdCKSB6iI
 dIRGpqYjmHnT9Y7lp3wUX+hP9zH6uUvjSkG0DrQlljFo/RWN8rdcI2aQ83AZSrqFdiVsgOtBu0P
 lErRnTwf33qVoalH6QKyurnHS6Qe80t82fySvAFyJOhx1EdwbZc7xqXgoi24EBuf2NqFMkPxhQB
 powtO2vIOJ2nqyj2EpbOWs3codWCCAof0ag==
X-Received: by 2002:a05:620a:6841:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-940ef999c76mr841560885a.57.1793015852109; 
 Mon, 26 Oct 2026 04:57:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6841:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-940ef999c76mr841557185a.57.1793015851519; 
 Mon, 26 Oct 2026 04:57:31 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm15950628f8f.53.2026.10.26.04.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 04:57:30 -0700 (PDT)
Message-ID: <3b1e0087-fd62-4149-b8dc-273885ee9e14@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:57:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/vapic: fix a deadlock between vapic_write() and
 machine reset
Content-Language: en-US
To: Qingbo Zhang <QingboZhang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 jan.kiszka@siemens.com, mohamed@unpredictable.fr
References: <20261026100933.12715-1-QingboZhang@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261026100933.12715-1-QingboZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX5CG7QEz6bosp
 jgEtFogCfe0ImKmEldI2+c70VVyTPIsgBPAVCuNlyhrYZ/0aMxUAeKOnRR9GCaUbLHxgxy9M8nU
 eBXVygKlmPy61hW94U6kAAihk1a9urM=
X-Proofpoint-GUID: -sloiVPDPAjv_JBsTk5w_gEzUoSsc0xc
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf402d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=GIQppDIzn4e7d-k7XTwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: -sloiVPDPAjv_JBsTk5w_gEzUoSsc0xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX6YUcVfLxnh1W
 FSEUK3q+6YyN4j21am7p9+oJxfbJae0/5/yA/A9V4RVH4Dlk6B+UU3phU4fH8o1ZZZPZglk1T9a
 pdaD6/4iyacP5RhEeydFoNhMOVzkitFcqiSwkfxwPsgXxprV6Y0WzoNTlwYit1pDWhEF6xfrO8q
 3SFf9SA3FkAHah4l+LbCcdtoSLEOSgs+1wIMjVZ8d/n/5b+/4gacKNpMdq4iG2ItYNIax4Q9m4h
 L4fDeeUoOtidWyCsh8czvFB4BCdGNR0oD4Gfb54XbatpYE5mT2wE9z94DqQVFcYuMhIjWgVxbnv
 gVrlGS6RZx2Y4r1l1S3RqXGch19VT52AcjJBXk7qaRkhSpb0UsA/1u+l4STp1vqXf7/yFH2adn9
 8zuIMvN7qn325lXpkkQUGnwiSr+XVm9mnzvCn0/QkQ56lNsp3VggfiVrntA7n7pLofUptI9CZ5C
 VlYGMQrSRXAqc3/YyrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 26/10/26 11:09, Qingbo Zhang wrote:
> A 1-byte write to the VAPIC port 0x7e (vapic_write() case 1, the
> reactivation path) patches the ROM trigger instruction to a NOP under
> pause_all_vcpus() / resume_all_vcpus().
> 
> The BQL does not serialize this against a machine reset: both
> pause_all_vcpus() and the run_on_cpu() work in the reset path drop the
> BQL while waiting, so a concurrent reactivation's resume_all_vcpus() can
> slip in mid-reset.  It clears the stopped state of every vCPU,
> restarting one the reset had just stopped.  That vCPU re-enters KVM_RUN
> and, if it does not exit to userspace again (e.g. it halts in the
> kernel), holds its vcpu->mutex indefinitely; the reset's
> KVM_SET_VAPIC_ADDR for it then blocks forever, leaving the main thread
> stuck holding the BQL and the whole VM hung, monitor included.
> 
> Fix this by patching on the current vCPU via async_safe_run_on_cpu()
> instead of pausing all vCPUs.  The patch becomes an exclusive work item
> that, under KVM, runs before the vCPU re-enters the guest; it sleeps the
> other vCPUs without touching the stopped state, so it can no longer
> restart a vCPU that a concurrent reset has stopped.

Maybe worth citing similar TCG fix in commit cb58a6d3611b.

> 
> Reproduced on an 8-vCPU KVM guest issuing 1-byte writes to port 0x7e
> concurrently with machine resets: the unfixed code hangs the VM on the
> first reset, the fixed build survives 500+ resets.
> 
> Fixes: e5ad936b0fd7 ("kvmvapic: Introduce TPR access optimization for Windows guests")
> Signed-off-by: Qingbo Zhang <QingboZhang@linux.alibaba.com>
> ---
> 
> Reproducer: a KVM guest (-smp 8, host kernel 6.12.0, in-kernel irqchip)
> booted via -kernel/-initrd with panic=1, so each reset reboots and
> retries.  /init runs a long unrolled sequence of "outb %al, $0x7e"
> (.rept 200000) on one vCPU (each OUT enters vapic_write() case 1), while
> another vCPU issues machine resets through the i8042 (outb 0xfe -> 0x64)
> after a 200 ms warmup, so the resets race the 0x7e writes.
> 
> Result: without the fix the VM hangs on the first reset; the fixed build
> survives 588 resets with the main thread never blocking on
> KVM_SET_VAPIC_ADDR.
> 
> Hang analysis (unfixed build, -smp 8, captured at the wedge):
> 
>    main thread, State D, ioctl(fd=15, KVM_SET_VAPIC_ADDR):
>      kvm_vcpu_ioctl+0x88/0x7f0 [kvm]     <-- mutex_lock_killable(&vcpu->mutex)
>      __x64_sys_ioctl+0x94/0xd0
>      do_syscall_64+0x7d/0x160
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    the vCPU it targets, "CPU 0/KVM", same fd=15, ioctl(fd=15, KVM_RUN),
>    halted:
>      kvm_vcpu_block+0x4c/0xc0 [kvm]
>      kvm_vcpu_halt+0x185/0x430 [kvm]
>      vcpu_run+0x1d1/0x2a0 [kvm]
>      kvm_arch_vcpu_ioctl_run+0x381/0x520 [kvm]
>      kvm_vcpu_ioctl+0x114/0x7f0 [kvm]    <-- holds vcpu->mutex
>      __x64_sys_ioctl+0x94/0xd0
>      do_syscall_64+0x7d/0x160
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    Both on fd 15 (the same vCPU): the main thread waits at
>    kvm_vcpu_ioctl+0x88 (mutex_lock_killable) while "CPU 0/KVM" holds that
>    mutex at +0x114 inside KVM_RUN and, being halted, never exits to
>    userspace to release it, so the reset never completes.
> 
> Interleaving:
> 
>    Three threads are involved:
>      - vCPU1, which runs the guest "outb 0x7e" and so keeps re-entering
>        vapic_write() case 1, where resume_all_vcpus() restarts a vCPU the
>        reset had stopped;
>      - vCPU2, an idle vCPU, halted in KVM_RUN and holding its vcpu->mutex;
>      - the main thread, which performs the machine reset, and is where the
>        deadlock lands: its KVM_SET_VAPIC_ADDR ioctl for vCPU2 must take
>        vCPU2's vcpu->mutex, but vCPU2 holds it in KVM_RUN and never
>        releases it, so the main thread blocks forever holding the BQL,
>        hanging the whole VM.
>    The BQL does not serialize the reset against vapic_write():
>    pause_all_vcpus() (on both threads) and the reset's run_on_cpu() each
>    drop the BQL while waiting (marked "<-- drops the BQL" below), so the
>    two interleave.
> 
>    main thread:
>      machine reset
>        main_loop_should_exit()
>          pause_all_vcpus()
>            qemu_cond_wait(&qemu_pause_cond, &bql)     <-- drops the BQL
>          qemu_system_reset()
>            cpu_synchronize_all_states()
>              run_on_cpu(GET) -> do_run_on_cpu()
>                qemu_cond_wait(&qemu_work_cond, &bql)  <-- drops the BQL
>            qemu_devices_reset()
>              apic_reset_common() -> vapic_base_update()
>                kvm_vcpu_ioctl(vCPU2, KVM_SET_VAPIC_ADDR)
>                  mutex_lock_killable(&vCPU2->mutex)   <-- blocks forever
> 
>    vCPU1:
>      guest "outb 0x7e"
>        kvm_cpu_exec() -> KVM_EXIT_IO -> kvm_handle_io() -> address_space_rw()
>          prepare_mmio_access(): bql_lock()   <-- re-takes the dropped BQL
>          vapic_write() case 1
>            pause_all_vcpus()
>              qemu_cond_wait(&qemu_pause_cond, &bql)   <-- drops the BQL
>            patch_byte() x2  (NOP the ROM trigger)
>            resume_all_vcpus()
>              cpu_resume(vCPU2): cpu->stop = false; cpu->stopped = false
>              qemu_cpu_kick(vCPU2)
>                -> vCPU2 re-enters kvm_cpu_exec() -> KVM_RUN, holding its
>                   vcpu->mutex; being idle it halts in kvm_vcpu_block() and
>                   never exits to userspace, so the mutex is never released.
> 
>    So vCPU2, which the reset had stopped, is restarted into KVM_RUN
>    mid-reset; the main thread's KVM_SET_VAPIC_ADDR(vCPU2) blocks on
>    vCPU2's mutex while holding the BQL, and vCPU1 is starved of the BQL,
>    so it can no longer kick vCPU2.  The whole VM hangs.
> 
>   hw/i386/vapic.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
> index 5c3911cf9c..8c2b6b0a6b 100644
> --- a/hw/i386/vapic.c
> +++ b/hw/i386/vapic.c
> @@ -657,6 +657,15 @@ static int vapic_prepare(VAPICROMState *s)
>       return 0;
>   }
>   
> +static void do_vapic_nop_patch(CPUState *cs, run_on_cpu_data data)

Rename as do_patch_trigger_nop? And mention this runs in exclusive section?

> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    target_ulong addr = (target_ulong)data.target_ptr;

Pre-existing, patch_byte() should take a vaddr, then this cast is not 
needed.

For non-x86 experts:

   /* 2-byte NOP */

> +
> +    patch_byte(cpu, addr, 0x66);
> +    patch_byte(cpu, addr + 1, 0x90);
> +}
> +
>   static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
>                           unsigned int size)
>   {
> @@ -709,16 +718,9 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
>                * Oddly enough, KVM increments EIP _before_ the execution
>                * of the instruction is finished.
>                */
> -            pause_all_vcpus();
> -            if (!kvm_enabled()) {
> -                patch_byte(cpu, env->eip, 0x66);
> -                patch_byte(cpu, env->eip + 1, 0x90);
> -            }
> -            else {
> -                patch_byte(cpu, env->eip - 2, 0x66);
> -                patch_byte(cpu, env->eip - 1, 0x90);
> -            }
> -            resume_all_vcpus();
> +            target_ulong ip = kvm_enabled() ? env->eip - 2 : env->eip;
> +            async_safe_run_on_cpu(current_cpu, do_vapic_nop_patch,
> +                                  RUN_ON_CPU_TARGET_PTR(ip));

Why change on current_cpu, can't we simply use CPU(cpu)? Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>           }
>   
>           if (s->state == VAPIC_ACTIVE) {


