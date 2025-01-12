Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CB1E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 16:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX0bS-0005rJ-Bi; Sun, 12 Jan 2025 11:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tX0bQ-0005qo-Hs
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 11:14:16 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tX0bO-00082S-Jb
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 11:14:16 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso5809611a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736698452; x=1737303252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/L2LaBSW3CRsxATB05Q+hrFMoWXtO7AFCRavuw2yHaM=;
 b=RqHkWliBSeJcQ3JLJBORvRPJmuXgPtq2emkieSpdbWq8aj+Pu05fEGvBwyCmHmx6AQ
 P2CAmY5hJlvxX+yDNItg0yV8GHu2acL87O/lJIIlDkTmL3fT/MGrvWlwILoXhoyTkoRf
 RS6LRHdMcXB37ou+8pSQOjx3cmlq4wi+BZQy+v3753vDL+LGDMQ7qkK1678O1MZuSnMo
 ToPQJLFGELhAwnuKJ0CxYZ1X1GyGNzKZ0wfxmFKUYj8azhFJFmr0FvaQ3F+2SOX9TxQe
 3vu5wPDCaUgs2rOxPJaauvu5+2DF00Uiq+9x6LoHb9X4YrPlKusdwW5+AM8KIQSSoj3D
 kjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736698452; x=1737303252;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/L2LaBSW3CRsxATB05Q+hrFMoWXtO7AFCRavuw2yHaM=;
 b=BFqi21VREYpAdOKurXVGA05kp58C668sSZI1cw5FLXeP/9sKiB2Wpmi0nlVhCf7iQ+
 qbXnpYmRKyot1pT2V/8JYIuMxo4UCNSAPBHhskLTkFKSUDzVKA6xRyqEBU8E9CYgYWEC
 9BvFoi41GpyE37NuhxlD3STWJfNWwm51im9IfOAvaqDtPlqMbXiYR71XpXWs9IUHFpc/
 XfAbDB2L1Dalonb6UZyy+4Ysy5414PqWZ2qV6xSUflyLB/p0x7DarS/Zt0s0S1m1BL3E
 sYWjKnpvt3DGcdyVqZbAm/Fr3/zoNWVzhJoLhlWmRb4exxVav4wJBl8vkduCkkEx9BCJ
 vVUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj85xePxcyXvizTmG+DJmjAJsWemI/tRsuKSz9rsLIrPJKDTKxR4UhJBIRuLJoX8lSWZylyoGWnywx@nongnu.org
X-Gm-Message-State: AOJu0Yxs//1s7QauW0deY6UyLlPOOxrgvHvc39VV0DFoGSq8A6eqAMX4
 na9xJ5OgRGJh9+ebeRktlxhm1+tFIJnk2otmSw0RFsu/cZL23GAlyh608oB2clw=
X-Gm-Gg: ASbGncvzbcD85bJDowTdvQlVsmVndk+YQa3lizeBu6c8Z/VveoRB5wqg9hyhrT/EN5k
 dLygDM9isZK79fYqRmDziIk5eQFGNk2iY7dnvBSgKQ+Z3eSKCo75qXi/MwrbNX28F4AXlERynEq
 yIJ0prZv5I9TL0eTahRAUXfsV7NTIkPusz+NH8vUjTRn7aEMrSKKjPMoK2FfsjJDmCXyRjZ5w0v
 ve6ylBz6gg/luhVTilTEE6sh+FCatFzTtfP6pvwWDWC1xmHF8W5jqQ=
X-Google-Smtp-Source: AGHT+IGrxq2sIWCRDH1salyDzlM6JssDGqCp0Nf1ZWpoWklj0Ebh4qoGo/UCWsQDCd4Qjw6AfbcZQQ==
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d972e70945mr41420115a12.28.1736698451408; 
 Sun, 12 Jan 2025 08:14:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c913804esm385925666b.84.2025.01.12.08.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 08:14:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A1D25F929;
 Sun, 12 Jan 2025 16:14:09 +0000 (GMT)
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
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
In-Reply-To: <87ikqm4wmp.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 10 Jan 2025 13:38:22 +0000")
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <87ikqm4wmp.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sun, 12 Jan 2025 16:14:09 +0000
Message-ID: <874j24vwku.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>
>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>
>> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
>> DRM native context [1] mediates lower level kernel driver UAPI, which
>> reflects in a less CPU overhead and less/simpler code needed to support =
it.
>> DRM context consists of a host and guest parts that have to be implement=
ed
>> for each GPU driver. On a guest side, DRM context presents a virtual GPU=
 as
>> a real/native host GPU device for GL/VK applications.
>>
>> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>>
>> Today there are four known DRM native context drivers existing in a wild:
>>
>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>   - AMDGPU, mostly merged into upstreams
>>   - Intel (i915), merge requests are opened
>>   - Asahi (Apple SoC GPUs), WIP status
>>
>>
>> # How to try out DRM context:
>>
>> 1. DRM context uses host blobs and requires latest developer version=20
>> of Linux kernel [2] that has necessary KVM fixes.
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>>
>> 2. Use latest libvirglrenderer from upstream git/main for Freedreno
>> and AMDGPU native contexts. For Intel use patches [3].
>>
>> [3] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/=
1384
>>
>> 3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
>> Mesa patches [4], for Intel [5].
>>
>> [4] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
>> [5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
>>
>> 4. On guest, use latest Linux kernel v6.6+. Apply patch [6] if you're
>>    running Xorg in guest.
>
> Have you seen this failure before:
>
>   =E2=9E=9C  ./qemu-system-x86_64 \
>                     -machine type=3Dq35,accel=3Dkvm,kernel-irqchip=3Dspli=
t \
>                     -cpu host \
>                     -smp 4 \
>                     -device virtio-net-pci,netdev=3Dunet \
>                     -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>                     -drive driver=3Dqcow2,file=3Dtrixie-x86_64.qcow2 \
>                     -serial mon:stdio \
>                     -m 24G \
>                     -object memory-backend-memfd,id=3Dmem,size=3D24G,shar=
e=3Don \
>                     -device virtio-vga-gl,hostmem=3D4G,blob=3Don,drm_nati=
ve_context=3Don \
>                     -display gtk,gl=3Don,show-cursor=3Don \
>                     -device virtio-tablet-pci -device virtio-keyboard-pci=
 \
>                     -d guest_errors,unimp,trace:virtio_gpu_cmd_get_displa=
y_info
>   vmport: unknown command 56
>   virtio_gpu_cmd_get_display_info=20
>   context 4 failed to dispatch CREATE_VIDEO_BUFFER: 22
>   vrend_decode_ctx_submit_cmd: context error reported 4 "gst-plugin-scan"=
 Illegal command buffer 327735
>   context 4 failed to dispatch CREATE_VIDEO_BUFFER: 22
>   vrend_decode_ctx_submit_cmd: context error reported 4 "gst-plugin-scan"=
 Illegal command buffer 327735
>   context 4 failed to dispatch CREATE_VIDEO_BUFFER: 22
>   vrend_decode_ctx_submit_cmd: context error reported 4 "gst-plugin-scan"=
 Illegal command buffer 327735
>   error: kvm run failed Bad address
>   RAX=3D00007fb1e8fbefa0 RBX=3D00005649f1f4fb34 RCX=3D00000000fffffffc RD=
X=3D0000000000000004
>   RSI=3D0000000000000000 RDI=3D0000000000100000 RBP=3D00005649f2063710 RS=
P=3D00007ffe221807d0
>   R8 =3D0000000000000003 R9 =3D00007ffe22180808 R10=3D0000000000000302 R1=
1=3D0000000000000000
>   R12=3D0000000000000001 R13=3D00007ffe22180800 R14=3D0000000000000002 R1=
5=3D0000000000000001
>   RIP=3D00007fb20bfc3f7f RFL=3D00010202 [-------] CPL=3D3 II=3D0 A20=3D1 =
SMM=3D0 HLT=3D0
>   ES =3D0000 0000000000000000 ffffffff 00c00000
>   CS =3D0033 0000000000000000 ffffffff 00a0fb00 DPL=3D3 CS64 [-RA]
>   SS =3D002b 0000000000000000 ffffffff 00c0f300 DPL=3D3 DS   [-WA]
>   DS =3D0000 0000000000000000 ffffffff 00c00000
>   FS =3D0000 00007fb203aace80 ffffffff 00c00000
>   GS =3D0000 0000000000000000 ffffffff 00c00000
>   LDT=3D0000 0000000000000000 ffffffff 00c00000
>   TR =3D0040 fffffe67eec85000 00004087 00008b00 DPL=3D0 TSS64-busy
>   GDT=3D     fffffe67eec83000 0000007f
>   IDT=3D     fffffe0000000000 00000fff
>   CR0=3D80050033 CR2=3D00005646b7f7d018 CR3=3D000000012852a000 CR4=3D0075=
0ef0
>   DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR=
3=3D0000000000000000=20
>   DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
>   EFER=3D0000000000000d01
>   Code=3Df3 0f 11 40 58 f3 0f 10 43 08 f3 0f 11 40 5c f3 0f 10 43 0c <f3>=
 0f 11 78 64 f3 0f 11 50 68 f3 44 0f 11 40 6c f3 0f 11 48 70 f3 0f 11 60 74=
 f3 0f 11 40

So this goes away with:

  Linux draig 6.13.0-rc6-ajb-00144-g8c8d54116fa2-dirty #27 SMP PREEMPT_DYNA=
MIC Fri Jan 10 16:57:29 GMT 2025 x86_64 GNU/Linux

So I think is an artefact of the PFN page locking failing. I guess
native context is more prone to issues? It is a bit odd as I have loads
of memory and I think the intel graphics are unified memory but I don't
know how you would check.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

