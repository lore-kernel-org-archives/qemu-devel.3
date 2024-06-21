Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70755C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKa75-0001BA-Df; Fri, 21 Jun 2024 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKa74-00019a-Gh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:59:18 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKa72-0001KZ-PF
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:59:18 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d2fc03740so415531a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718960355; x=1719565155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpU4KRyMBsBefao3kLWaqPXGoJSXbQkrYrsM46x5TE0=;
 b=fup08uv1yvvKv/qzyvJ+Dqmvtvd9bNXTa9TxhEBwVFeuH4WIm0fVGukzttk2na+kta
 IO3Lg71bA3G56X2iKN9gjxZty6V/ubHMeKQWzJJBHPhpjkwicGDSlGAi39rWnyq2SVwJ
 2Zw2KCFBPX1WAYwfpm1TkvW0mrAZs1Q3/41OLr1B9jYQAUz1KXRWTJArZDIbyAUjGU/M
 bss/EoSPc+mgUyN+b9PhXT5HQ6OxtGZ6i39/z/tyMJsvqiaaokoaWJvtjJduouff43Qo
 PXMcUbFuQUuCiAulg5r3Dvl4peht1CrFmSGUOGKiiknglIzI1S3l4OKeyYDbF246DYQF
 NaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718960355; x=1719565155;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpU4KRyMBsBefao3kLWaqPXGoJSXbQkrYrsM46x5TE0=;
 b=oOoPiXXwOqkCsgTw2/rYg/hb+nEwIt5IArfYozdp4JSez4ZlL4n1xM61lbLgJazWLS
 6a/4zhQiMdJH/pIX2LjB3oe6UW9YDSj8fpQdJXA9zhbm31+QDrQtALZ2qkjl5fdIC6nQ
 HpqHJnA+j5aGxXU+l81Kb5UcuEYi+DmyhyYQ9VQIRuAVz6armAK53FS49az8w6mElaw6
 cuENlb1LdIEFfoLNYxYCkb3sGdEdiXCYqYeF1cKD5PUfxH5heZmL6JU88ls2rUCOgXG5
 r6tEUYK3Y/pcMrv249OFC8xwwcyKna63g6US9wN8ZAkwOKHXal3/oNu3L/jSJS0H9YVd
 PWhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZlpsreyR4Xj6gdCfx01Ch7VUZ1wixGzYYeGhY0Yn32lbPQQ4wwg9lno5QdZbBjqjgyS1p8Hb+YJJ56WV1UdS2w5OjkuQ=
X-Gm-Message-State: AOJu0Yz9pBfJ/m3m7LUYNSC+JeB3Gx5rZxDf1iqHBmicU2q7J/82Kjfe
 JgFOMkzL+vesZhVpQGvV/9/AdUW4gyqoySRtdqfgn/jj8dJHf5whbPFSzx1+wjQ=
X-Google-Smtp-Source: AGHT+IHJHA8C+TKJGG8k5fZlj5yLGQ7Xj9/GIBCXMo7uzUUNj3MAkT0u9BuJAi9ZCZ0W/iCsDuMCUA==
X-Received: by 2002:a17:907:7e97:b0:a6f:10d0:fb85 with SMTP id
 a640c23a62f3a-a6fab62bbd8mr564940066b.19.1718960354751; 
 Fri, 21 Jun 2024 01:59:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf4289c8sm60859066b.30.2024.06.21.01.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 01:59:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA10B5F7A3;
 Fri, 21 Jun 2024 09:59:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v14 00/14] Support blob memory and venus on qemu
In-Reply-To: <f9880609-741b-4d18-b9b0-a9b3c28c930b@collabora.com> (Dmitry
 Osipenko's message of "Thu, 20 Jun 2024 20:34:41 +0300")
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
 <87bk3wdea9.fsf@draig.linaro.org>
 <f9880609-741b-4d18-b9b0-a9b3c28c930b@collabora.com>
Date: Fri, 21 Jun 2024 09:59:12 +0100
Message-ID: <875xu2hdsv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

> On 6/19/24 20:37, Alex Benn=C3=A9e wrote:
>> So I've been experimenting with Aarch64 TCG with an Intel backend like
>> this:
>>=20
>> ./qemu-system-aarch64 \
>>            -M virt -cpu cortex-a76 \
>>            -device virtio-net-pci,netdev=3Dunet \
>>            -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>>            -m 8192 \
>>            -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
>>            -serial mon:stdio \
>>            -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/bo=
ot/Image \
>>            -append "console=3DttyAMA0" \
>>            -device qemu-xhci -device usb-kbd -device usb-tablet \
>>            -device virtio-gpu-gl-pci,blob=3Dtrue,venus=3Dtrue,hostmem=3D=
4G \
>>            -display sdl,gl=3Don -d plugin,guest_errors,trace:virtio_gpu_=
cmd_res_create_blob,trace:virtio_gpu_cmd_res_back_\*,trace:virtio_gpu_cmd_r=
es_xfer_toh_3d,trace:virtio_gpu_cmd_res_xfer_fromh_3d,trace:address_space_m=
ap=20
>>=20
>> And I've noticed a couple of things. First trying to launch vkmark to
>> run a KMS mode test fails with:
>>=20
> ...
>>   virgl_render_server[1875931]: vkr: failed to import resource: invalid =
res_id 5
>>   virgl_render_server[1875931]: vkr: vkAllocateMemory resulted in CS err=
or=20
>>   virgl_render_server[1875931]: vkr: ring_submit_cmd: vn_dispatch_comman=
d failed
>>=20
>> More interestingly when shutting stuff down we see weirdness like:
>>=20
>>   address_space_map as:0x561b48ec48c0 addr 0x1008ac4b0:18 write:1 attrs:=
0x1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>>   virgl_render_server[1875931]: vkr: destroying context 3 (vkmark) with =
a valid instance=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>   virgl_render_server[1875931]: vkr: destroying device with valid object=
s=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>>   vkr_context_remove_object: -7438602987017907480=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>   vkr_context_remove_object: 7=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
>>   vkr_context_remove_object: 5=20=20=20=20=20=20=20
>>=20
>> which indicates something has gone very wrong. I'm not super familiar
>> with the memory allocation patterns but should stuff that is done as
>> virtio_gpu_cmd_res_back_attach() be find-able in the list of resources?
>
> This is expected to fail. Vkmark creates shmem virgl GBM FB BO on guest
> that isn't exportable on host. AFAICT, more code changes should be
> needed to support this case.

There are a lot of acronyms there. If this is pure guest memory why
isn't it exportable to the host? Or should the underlying mesa library
be making sure the allocation happens from the shared region?

Is vkmark particularly special here?


> Note that "destroying device with valid objects" msg is fine, won't hurt
> to silence it in Venus to avoid confusion. It will happen every time
> guest application is closed without explicitly releasing every VK
> object.

I was more concerned with:

>>   vkr_context_remove_object: -7438602987017907480=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

which looks like a corruption of the object ids (or maybe an offby one)

>
>> I tried running under RR to further debug but weirdly I can't get
>> working graphics with that. I did try running under threadsan which
>> complained about a potential data race:
>>=20
>>   vkr_context_add_object: 1 -> 0x7b2c00000288
>>   vkr_context_add_object: 2 -> 0x7b2c00000270
>>   vkr_context_add_object: 3 -> 0x7b3800007f28
>>   vkr_context_add_object: 4 -> 0x7b3800007fa0
>>   vkr_context_add_object: 5 -> 0x7b48000103f8
>>   vkr_context_add_object: 6 -> 0x7b48000104a0
>>   vkr_context_add_object: 7 -> 0x7b4800010440
>>   virtio_gpu_cmd_res_back_attach res 0x5
>>   virtio_gpu_cmd_res_back_attach res 0x6
>>   vkr_context_add_object: 8 -> 0x7b48000103e0
>>   virgl_render_server[1751430]: vkr: failed to import resource: invalid =
res_id 5
>>   virgl_render_server[1751430]: vkr: vkAllocateMemory resulted in CS err=
or
>>   virgl_render_server[1751430]: vkr: ring_submit_cmd: vn_dispatch_comman=
d failed
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   WARNING: ThreadSanitizer: data race (pid=3D1751256)
>>     Read of size 8 at 0x7f7fa0ea9138 by main thread (mutexes: write M0):
>>       #0 memcpy <null> (qemu-system-aarch64+0x41fede) (BuildId: 0bab171e=
77cb6782341ee3407e44af7267974025)
> ..
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   SUMMARY: ThreadSanitizer: data race (/home/alex/lsrc/qemu.git/builds/s=
ystem.threadsan/qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77cb6782341=
ee3407e44af7267974025) in __interceptor_memcpy
>>=20
>> This could be a false positive or it could be a race between the guest
>> kernel clearing memory while we are still doing
>> virtio_gpu_ctrl_response.
>>=20
>> What do you think?
>
> The memcpy warning looks a bit suspicion, but likely is harmless. I
> don't see such warning with TSAN and x86 VM.

TSAN can only pick up these interactions with TCG guests because it can
track guest memory accesses. With a KVM guest we have no visibility of
the guest accesses.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

