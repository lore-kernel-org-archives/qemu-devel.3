Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85093C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eKi-00073F-8s; Mon, 21 Sep 2026 09:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eKc-00072u-7V
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:45:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eKZ-00041H-MJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:45:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAe3bx1564420
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8eXbYIE2ilEqoXk1Q9DsY34hvGje6m1hnl1ZFFvZSv4=; b=Dw6TlhWOQfm5ftz2
 dO6Q0pGavtF5IF+MJ1hAD4F46zTszqR8cL5HGveV6crYgiePfqXWKTL6dLGZodjz
 iYjiD4gyJ1O4mnkM4yY33Bx9zFRg7IDayuKUXRCFO9YEcF3tt3l3fz5wJAHV/68Z
 NO73SoKdQ3sgfm1Mk/OL4g6/j/8NQkeycQQ8aJXGCLd2k6hE7z7/wECmgUtcO/6W
 R4CJPITbvyTX2WWlFNJn9ycxDFRjqlXNu7ZEzY0pnGt1hNCX8+ars6w4OVjCecwT
 n83qAGHAYlPenMDvpdI3469zryBbYzmGbn7QupsUoydgpw2M5/glIOcOEG1RQlvA
 /HMImw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw1hwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:45:12 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c82fe2ba8aso3806759e0c.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789998312; x=1790603112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8eXbYIE2ilEqoXk1Q9DsY34hvGje6m1hnl1ZFFvZSv4=;
 b=gxkx5sVIFlXjkTa9H5vr6j/O2tfgB9skz4zSPAAPrMZue4rjmvJOr9fGJ2ndLQ/Q86
 sBc/9OXQoETO5CuQ/qHSQ3RkO1CRorXOmxQomgbuBCSj1LmGUQCYB+vKUOPU4jeyyTxS
 QjTZWTRCoOa5rdIlOcrQxJrvJ0z3D7CrsHUuGHbg3Q590HLOe303qpLVy5HHf8NHoNU2
 aMuQUHvJKCvdFL9ijRj2CTE4hvnEwPJZUHMJ/wPdgPXHndaePOFNz6BTlcZZwgXGYXBd
 TuctN63dz28GefufvTp5H0dPfGaHniJ/YaePs7kfAhGcvaiQ/+CrpPCOzTw4cPo7saBg
 NKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998312; x=1790603112;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8eXbYIE2ilEqoXk1Q9DsY34hvGje6m1hnl1ZFFvZSv4=;
 b=GSrEsabW2Tw7bWdsvta4fEUZUCzbDXxF77WfhqK1e/mLRup0ODwd1S6elyPFP/LKBX
 gdMvnwwB/OePduJeT0693U4OYnlPEwGyrqrZVhTQB06equ5QXn/o95StNzLmZFd/vV3G
 1673zRYc9BPET8YmU8R4e550ZhYuvDLLwliwtaPJBxWj0HyhvBbDVYGfEBBvA7lq9UYv
 VzgmStbN81o130CZfHIsdzqe96EacFNk/3EWpoe1alW8kUZQ8MXL6olhcNWmyODd4Kgw
 y5kutK/yrwbaEW2X0u8gZafijk8tMlOy9Co9enDuch62+EfSlvY8MZDuCTrFHw7ULYoN
 zVdg==
X-Forwarded-Encrypted: i=1;
 AKwUvByEhvQ/FdJpxr9bpKxTXlQht9WJe5aA8Sui77cQkVLLGB36BBJWqscMfN0F6FV6UY/9XBsPwUv2jT6E@nongnu.org
X-Gm-Message-State: AFuF++nV76QxMgMJD6yUZdwMMZvNaYFPDG8+CD1EppVluXoHDfZ0uvwq
 Rex8R8dE0d98FFhTcG3ANrZucygJycSDblhctv1vM4Ys8keTqo7wVAvdviKlR4NXsC2OYIYBw7f
 hdMiBK/atX/68bDgg5Zv1vvue5Utytant6sTXh8o9D3d6d8cljku8VQOVww==
X-Gm-Gg: AYBFou1zQg3sh5a665PaA4oxLFnVQEUE81c9qOhXuOPPzOANsWqdp99qVkKoEW8gC/h
 AJ/p4i+0o+Ao9M76nrt8FT3t9pQ1A7R/k/yxzQS+cEkoyC2Je9E4j18894a8q766GAB5zOvEExJ
 /XelGgjkpLO8ID+5++Uukdo9kkR5TaLWaeegL8eGQZXQgy6V381/3vnY/Iw4xfoU5PEfLuy9o3K
 cKBk7S8U4amJpjNXc3zmAIekrUIjdGz9KRiS/i3xEjZ+jZeDe6Y1+A8/sn4QmXFhFMgU35r4D3f
 rKabUIdW6IDf1jETkMB/wLNuceUMDUNNsDxpKwFXIsD1dzfC42A+SVRXx3EI7gFmUVOXD9Z5iTa
 FLyjXTt7apk/+xa5wTPc=
X-Received: by 2002:a05:6122:1c02:b0:5c9:a60b:e5a5 with SMTP id
 71dfb90a1353d-5c9b59afdc9mr5150436e0c.16.1789998310989; 
 Mon, 21 Sep 2026 06:45:10 -0700 (PDT)
X-Received: by 2002:a05:6122:1c02:b0:5c9:a60b:e5a5 with SMTP id
 71dfb90a1353d-5c9b59afdc9mr5150311e0c.16.1789998309876; 
 Mon, 21 Sep 2026 06:45:09 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724593bbfsm20585552f8f.27.2026.09.21.06.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:45:08 -0700 (PDT)
Message-ID: <f5882baf-9f06-4bcf-bcc3-3110ad584e7a@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Fix qtest deadlock during unplug
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260918140037.3082357-1-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918140037.3082357-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfX70J46RzjsIiz
 sVALOz25o3jsN4fIEYvXBKkL1vfjH9yncrr11iSq1aMAqBmlX56ucYjvibnBoXqGN4XG1dBnmsZ
 MC5bjLtpssi73ClYqV596uaNPbP7TsayrtlGpJggbNCvRUKwI/iC10OZ7Fr9xBlYhHTBT4r7Riq
 JD0DasytPin0mEdla3sweHFyBgT8FF0QHRoMQxhtdyEvEfDWxRipc+Q+NqtAg3GJoXCiNvB51xS
 sVg/E3H3q8ACsTbwxvraZ85ZKUzseivDroS70DgED8zeUs+8vyL042SXjJaPaox/Lpb/LlyVhzq
 c9wPn42zV7/Gb4X4jvzTq3J+1quFX0iE3bDe5ffN56N84GWb1RJjQxryvaDrCiM5jC1azddSg+8
 2/UKgqNjumvEewDec9dVlW2Td41i2isUKLcMtbWifdpS4q17VMizY+1RTEUkkv8CuekE4bmP/Lu
 Z7Uz2/Qhf5rugYJo6wQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfX3R51au+O5ObC
 uv9YpQ0R3feuehpEB5Cjip0H97buiLcJ2ahPsGxcThaEKJNne4nIqonZE/JQJBXmWoLvgdrf93D
 whFI0q0491l8geS/xXUd4iRLy3ycBfc=
X-Proofpoint-ORIG-GUID: GNlnDXlKbBNcxxJSn-uz91GytxaxAyyD
X-Proofpoint-GUID: GNlnDXlKbBNcxxJSn-uz91GytxaxAyyD
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab134e8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=Dw8lNnU56grtskwsZ0QA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210200
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

Hi Fabiano,

On 2026-09-18 16:00, Fabiano Rosas wrote:
> This is a revert of one hunk of commit d5e33b5f8f ("accel: make all
> calls to qemu_process_cpu_events look the same"). It regressed
> device-plug-test on ppc64. Run this in a loop and it deadlocks before
> 50 iterations:
> 
> QTEST_QEMU_BINARY=./qemu-system-ppc64 ./tests/qtest/device-plug-test -p
> /ppc64/device-plug/spapr-cpu-unplug-request
> 
> The deadlocked stacks are:
> T0:
>   #0  in sigtimedwait
>   #1  in sigwait
>   #2  in dummy_cpu_thread_fn (arg=0x558ed4db8eb0) at ../accel/dummy-cpus.c:52
> 
> T1:
>   #2  in qemu_thread_join (thread=0x55e3803dfc60) at ../util/qemu-thread-posix.c:554
>   #3  in cpu_remove_sync (cpu=0x558ed4db8eb0) at ../system/cpus.c:633
>   #4  in ppc_cpu_unrealize (dev=0x558ed4db8eb0) at ../target/ppc/cpu_init.c:6967
> 
> What the test does is to queue a cpu unplug request to be executed
> during system reset. So we end up with two cpu_exit() calls affecting
> the dummy loop, one via pause_all_cpus() and another via
> cpu_remove_sync().

I don't understand why we have these few per-target cpu_remove_sync()
calls. IMO it should only be called by core vcpu accel scheduler layer.

> 
> Moving qemu_process_cpu_events() to the top of the loop has made the
> release of the halt_cond + the read of cpu->unplug not happen
> atomically regarding the BQL anymore.
> 
> One cpu_exit() call will cause qemu_process_cpu_events() to make
> progress, the BQL be release and the pending SIG_IPI to be consumed by
> sigwait(). But since the BQL is unlocked, the second qemu_cpu_kick()
> invocation can execute entirely while the BQL is unlocked and issue:
> 
> i) another broadcast on halt_cond, which will be queued and,
> ii) another signal, which will be discarded
> 
> After the sigwait() returns and qemu_process_cpu_events() executes
> again in the next loop iteration, it exits right away due to the cond
> already being posted, but the sigwait() call for that loop won't see
> any signal. The thread cannot be joined at this point so there's a
> deadlock.
> 
> Since the dummy_cpu loop is so simple, I think the best way to fix
> this is to revert that part of the change and move
> qemu_process_cpu_events() back to the end of the loop, where it will
> be within the same BQL locking window as the cpu->unplug check.
> 
> Fixes: d5e33b5f8f ("accel: make all calls to qemu_process_cpu_events look the same")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2861429046
> ---
>   accel/dummy-cpus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
> index 5752f6302c..225a47c31f 100644
> --- a/accel/dummy-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -43,7 +43,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>       qemu_guest_random_seed_thread_part2(cpu->random_seed);
>   
>       do {
> -        qemu_process_cpu_events(cpu);
>           bql_unlock();
>   #ifndef _WIN32
>           do {
> @@ -58,6 +57,7 @@ static void *dummy_cpu_thread_fn(void *arg)
>           qemu_sem_wait(&cpu->sem);
>   #endif
>           bql_lock();
> +        qemu_process_cpu_events(cpu);
>       } while (!cpu->unplug);
>   
>       bql_unlock();


