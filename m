Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52A6C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQRj-00061e-1o; Mon, 27 Jan 2025 09:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcQRg-0005su-8x
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:50:36 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcQRe-0007LD-6o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:50:36 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so991189966b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989431; x=1738594231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCmeRAh1LH/WLoZWeKl0vztx2RIs7neNURmYrcEgZQc=;
 b=VkD8wAzj1Fo3cCseRDfuw28TlvPPwnDN0Xt+repmMc0XGTx9S2fxbCr23euvmJyk7m
 OYIeg7/Q7C3tB74WsWdcCPEf8w1Awb6gvvXmsMJJlDjpkvQfgE3KWOgJk1iHYWK09jji
 BRiskMkhTZld+joXW8UZa2QGxpspvyLwrU9Fkr1nZYThbFgZZh2vaQbWeAGudVuY8TYt
 3rXuDeG1AOqqsIWENavmT/YZXk82u5VMU4QcJ3TqMwHv0aWYg0yXu9lG11ZBYv0qTkik
 97USK+IFiM4+EgXXLf7E/peRjZAD0r7I+jTysE+aWiyGzoJcWxL66FjRIkKQwfNse9ob
 Z76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989431; x=1738594231;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mCmeRAh1LH/WLoZWeKl0vztx2RIs7neNURmYrcEgZQc=;
 b=rulmfuT9gnStsPGrx6Xb6OGNNCAN/4G6qAJ2Fxyo+x41mGz3mbvzR+DM0QWp5w7ta+
 lkexEYkA4wBlHrmJOEUEZfHdR1Rp9UxdsZDjSjov14JlbNYtFlj077h29vfxt+6JXgSk
 jTI8Elor0OU9qh2lkrIZmS5Gz2MKD/49HSBEoEllPo4twp+et3cMsNAvchDgrG75WSG4
 +3z0CZ1V9YhO/+QBRZpV2nXAn39d9HJVHHkA1HZTWH/RbvWx/U+oKmqnizbKJBDJKUhP
 sKoMsa6nHPfZyzlSnar6s3WgRtEHi17HZty1CnnnhHsdraIUFyuCOpMdKpv3Lc3D3FDt
 jkpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuiFkYB5+mZAPPnK/c3ZaT544GHvGWKiNX78t/9+iwHlQvciBX6KFP/vQWLUIPnpWZfqx5MX5c7aGB@nongnu.org
X-Gm-Message-State: AOJu0YyQ1+6L4IOWMDpulPN0ZIKu2AQ+OUfKCdwmgMC4su3Bt92/dt4H
 vFudfFMaIZWgADKR8VdfMHNYBayrr1jdVeZaXpPnpW8mvOaLB2CXwIMZ5K5ESJw=
X-Gm-Gg: ASbGncvoTzvjMbjOZIFgdtvPIng2NhlO6SVZhqFfZ8OOIMQgnO32Mf32lbTLUTH5BHZ
 bR/Dqpwz9fTUaL7TxTVN9GLHQo92eNalLAo6HUsuxS5bNy3YRFTBXt3c/PWFBYUn9HDhSBtnU9n
 ZWJFM7fbXqblf6rCEDO5VzQJToPiQgOh2D4Ycr/f19X/93oQLPOmCaDFZzUj4T43Pg3xo4F2A2w
 aRJor14R93nfA2u9Ses4aI/zHBuEOjzQ+6cvPtNFScK6s2lHdrXzsjiGZsRi7QRxsO4gXWDoOUC
 +3A=
X-Google-Smtp-Source: AGHT+IEVpVmyOaS5+RUErK3PoRCd1IIu3wUqrAr3bC2DEtNTSyoIajkFpRozLWB/5Q5stSLjKiduXQ==
X-Received: by 2002:a17:907:3f9a:b0:aae:ee49:e000 with SMTP id
 a640c23a62f3a-ab38b106513mr3729256966b.18.1737989431087; 
 Mon, 27 Jan 2025 06:50:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab676117437sm603792166b.179.2025.01.27.06.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:50:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F0C35F910;
 Mon, 27 Jan 2025 14:50:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v5 0/8] Support virtio-gpu DRM native context
In-Reply-To: <48195564-a5e4-45f1-906b-68c6ba7d7f81@collabora.com> (Dmitry
 Osipenko's message of "Thu, 23 Jan 2025 15:37:41 +0300")
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <87jzamn5ri.fsf@draig.linaro.org>
 <f5c8e901-5d36-47b0-91d3-40699c51c259@collabora.com>
 <874j1plp27.fsf@draig.linaro.org>
 <48195564-a5e4-45f1-906b-68c6ba7d7f81@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 27 Jan 2025 14:50:29 +0000
Message-ID: <87ikq048ga.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 1/23/25 14:58, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> On 1/22/25 20:00, Alex Benn=C3=A9e wrote:
>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>>
>>>>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>>>>
>>>>> Contarary to Virgl and Venus contexts that mediates high level GFX AP=
Is,
>>>>> DRM native context [1] mediates lower level kernel driver UAPI, which
>>>>> reflects in a less CPU overhead and less/simpler code needed to suppo=
rt it.
>>>>> DRM context consists of a host and guest parts that have to be implem=
ented
>>>>> for each GPU driver. On a guest side, DRM context presents a virtual =
GPU as
>>>>> a real/native host GPU device for GL/VK applications.
>>>>>
>>>>> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>>>>>
>>>>> Today there are four known DRM native context drivers existing in a w=
ild:
>>>>>
>>>>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>>>>   - AMDGPU, mostly merged into upstreams
>>>>
>>>> I tried my AMD system today with:
>>>>
>>>> Host:
>>>>   Aarch64 AVA system
>>>>   Trixie
>>>>   virglrenderer @ v1.1.0/99557f5aa130930d11f04ffeb07f3a9aa5963182
>>>>   -display sdl,gl=3Don (gtk,gl=3Don also came up but handled window re=
sizing
>>>>   poorly)
>>>>=20=20=20
>>>> KVM Guest
>>>>
>>>>   Aarch64
>>>>   Trixie
>>>>   mesa @ main/d27748a76f7dd9236bfcf9ef172dc13b8c0e170f
>>>>   -Dvulkan-drivers=3Dvirtio,amd -Dgallium-drivers=3Dvirgl,radeonsi -Da=
mdgpu-virtio=3Dtrue
>>>>
>>>> However when I ran vulkan-info --summary KVM faulted with:
>>>>
>>>>   debian-trixie login: error: kvm run failed Bad address
>>>>    PC=3D0000ffffb9aa1eb0 X00=3D0000ffffba0450a4 X01=3D0000aaaaf7f32400
>>>>   X02=3D000000000000013c X03=3D0000ffffba045098 X04=3D0000aaaaf7f3253c
>>>>   X05=3D0000ffffba0451d4 X06=3D00000000c0016900 X07=3D000000000000000e
>>>>   X08=3D0000000000000014 X09=3D00000000000000ff X10=3D0000aaaaf7f32500
>>>>   X11=3D0000aaaaf7e4d028 X12=3D0000aaaaf7edbcb0 X13=3D0000000000000001
>>>>   X14=3D000000000000000c X15=3D0000000000007718 X16=3D0000ffffb93601f0
>>>>   X17=3D0000ffffb9aa1dc0 X18=3D00000000000076f0 X19=3D0000aaaaf7f31330
>>>>   X20=3D0000aaaaf7f323f0 X21=3D0000aaaaf7f235e0 X22=3D000000000000004c
>>>>   X23=3D0000aaaaf7f2b5e0 X24=3D0000aaaaf7ee0cb0 X25=3D00000000000000ff
>>>>   X26=3D0000000000000076 X27=3D0000ffffcd2b18a8 X28=3D0000aaaaf7ee0cb0
>>>>   X29=3D0000ffffcd2b0bd0 X30=3D0000ffffb86c8b98  SP=3D0000ffffcd2b0bd0
>>>>   PSTATE=3D20001000 --C- EL0t
>>>>   QEMU 9.2.50 monitor - type 'help' for more information
>>>>   (qemu) quit
>>>>
>>>> Which looks very much like the PFN locking failure. However booting up
>>>> with venus=3Don instead works. Could there be any differences in the w=
ay
>>>> device memory is mapped in the two cases?
>>>
>>> Memory mapping works exactly the same for nctx and venus. Are you on
>>> 6.13 host kernel?
>>=20
>> Yes - with the Altra PCI workaround patches on both host and guest
>> kernel.
>>=20
>> Is there anyway to trace the sharing of device memory on the host so I
>> can verify its an attempt at device access? The PC looks like its in
>> user-space but once this fails the guest is suspended so I can't poke
>> around in its environment.
>
> I'm adding printk's to kernel in a such cases. Likely there is no other
> better way to find why it fails.
>
> Does your ARM VM and host both use 4k page size?
>
> Well, if it's a page refcounting bug on ARM/KMV, then applying [1] to
> the host driver will make it work and we will know where the problem is.
> Please try.
>
> [1]
> https://patchwork.kernel.org/project/kvm/patch/20220815095423.11131-1-dmi=
try.osipenko@collabora.com/

That makes no difference.

AFAICT the fault is triggered in userspace:

  error: kvm run failed Bad address
   PC=3D0000ffffb1911eb0 X00=3D0000ffffb1eb60a4 X01=3D0000aaaaeb1f5400
  X02=3D000000000000013c X03=3D0000ffffb1eb6098 X04=3D0000aaaaeb1f553c
  X05=3D0000ffffb1eb61d4 X06=3D00000000c0016900 X07=3D000000000000000e
  X08=3D0000000000000014 X09=3D00000000000000ff X10=3D0000aaaaeb1f5500
  X11=3D0000aaaaeb110028 X12=3D0000aaaaeb19ecb0 X13=3D0000000000000001
  X14=3D000000000000000c X15=3D0000000000007718 X16=3D0000ffffb11d01f0
  X17=3D0000ffffb1911dc0 X18=3D00000000000076f0 X19=3D0000aaaaeb1f4330
  X20=3D0000aaaaeb1f53f0 X21=3D0000aaaaeb1e65e0 X22=3D000000000000004c
  X23=3D0000aaaaeb1ee5e0 X24=3D0000aaaaeb1a3cb0 X25=3D00000000000000ff
  X26=3D0000000000000076 X27=3D0000ffffc7db4e58 X28=3D0000aaaaeb1a3cb0
  X29=3D0000ffffc7db4180 X30=3D0000ffffb0538b98  SP=3D0000ffffc7db4180
  PSTATE=3D20001000 --C- EL0t
  QEMU 9.2.50 monitor - type 'help' for more information
  (qemu) quit

  Thread 4 received signal SIGABRT, Aborted.
  [Switching to Thread 1.4]
  cpu_do_idle () at /home/alex/lsrc/linux.git/arch/arm64/kernel/idle.c:32
  32              arm_cpuidle_restore_irq_context(&context);
  (gdb) alex
  Undefined command: "alex".  Try "help".
  (gdb) bt
  #0  cpu_do_idle () at /home/alex/lsrc/linux.git/arch/arm64/kernel/idle.c:=
32
  #1  0xffff800081962180 in arch_cpu_idle () at /home/alex/lsrc/linux.git/a=
rch/arm64/kernel/idle.c:44
  #2  0xffff8000819622c4 in default_idle_call () at /home/alex/lsrc/linux.g=
it/kernel/sched/idle.c:117
  #3  0xffff80008013af8c in cpuidle_idle_call () at /home/alex/lsrc/linux.g=
it/kernel/sched/idle.c:185
  #4  do_idle () at /home/alex/lsrc/linux.git/kernel/sched/idle.c:325
  #5  0xffff80008013b208 in cpu_startup_entry (state=3Dstate@entry=3DCPUHP_=
AP_ONLINE_IDLE) at /home/alex/lsrc/linux.git/kernel/sched/idle.c:423
  #6  0xffff800080043668 in secondary_start_kernel () at /home/alex/lsrc/li=
nux.git/arch/arm64/kernel/smp.c:279
  #7  0xffff800080051f78 in __secondary_switched () at /home/alex/lsrc/linu=
x.git/arch/arm64/kernel/head.S:420
  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
  (gdb) info threads
    Id   Target Id                    Frame=20
    1    Thread 1.1 (CPU#0 [running]) cpu_do_idle () at /home/alex/lsrc/lin=
ux.git/arch/arm64/kernel/idle.c:32
    2    Thread 1.2 (CPU#1 [halted ]) 0x0000ffffb1911eb0 in ?? ()
    3    Thread 1.3 (CPU#2 [halted ]) cpu_do_idle () at /home/alex/lsrc/lin=
ux.git/arch/arm64/kernel/idle.c:32
  * 4    Thread 1.4 (CPU#3 [halted ]) cpu_do_idle () at /home/alex/lsrc/lin=
ux.git/arch/arm64/kernel/idle.c:32
  (gdb) thread 2
  [Switching to thread 2 (Thread 1.2)]
  #0  0x0000ffffb1911eb0 in ?? ()
  (gdb) bt
  #0  0x0000ffffb1911eb0 in ?? ()
  #1  0x0000aaaaeb1ea5e0 in ?? ()
  Backtrace stopped: previous frame inner to this frame (corrupt stack?)
  (gdb) frame 0
  #0  0x0000ffffb1911eb0 in ?? ()
  (gdb) x/5i $pc
  =3D> 0xffffb1911eb0:      str     q3, [x0]
     0xffffb1911eb4:      ldp     q2, q3, [x1, #48]
     0xffffb1911eb8:      subs    x2, x2, #0x90
     0xffffb1911ebc:      b.ls    0xffffb1911ee0  // b.plast
     0xffffb1911ec0:      stp     q0, q1, [x3, #16]
  (gdb) p/x $x0
  $1 =3D 0xffffb1eb60a4

I suspect that is memcpy again but I'll try and track it down. The only
other note is:

[  411.509647] kvm [7713]: Unsupported FSC: EC=3D0x24 xFSC=3D0x21 ESR_EL2=
=3D0x92000061

Which is:

  EC 0x24 - Data Abort from lower EL
  DFSC 0x21 - Alignment fault
  WnR 1 - Caused by write
=20=20
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

