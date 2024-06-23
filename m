Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE795C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 16:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLQKj-0008S8-R1; Sun, 23 Jun 2024 12:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLQKi-0008Rv-Gc
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 12:44:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLQKg-0000kk-HQ
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 12:44:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so26875275e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719161088; x=1719765888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oXckr5Y9kkzuYG8mMNW7vWG+orp8g2PjYPACq0a8NR8=;
 b=HVDSb8FDPLxvWmnp1JloixcWfZPk1cC22rHvU1ZOFkY/VfpPwllYrTwSJ1XOlU3YYS
 1DU6vc9mteu/NqDDG9ldgTgG9M0KD43hmor1UxsurnExaN1V7VxbhNnlKcOwYfq3Mkfh
 mPvxxp03SqznQAcrMLHKfVn79dfwzLevHwMw7LQyRPKN2V2tKpQBXFHi9Za8ypcued5Y
 FrS8iztnR23T3Yjj61ZUZz3/1TfYYkDun9LtMHJbHNH14Su0uez8YQmPQeBTInhORYma
 f4MOq0wl+zQAmriG6Zrjfz5IvRXCL9RIxcKXtX9OXqyClXhDkqRsVKj5SAbhs4TbrIbh
 e7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719161088; x=1719765888;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXckr5Y9kkzuYG8mMNW7vWG+orp8g2PjYPACq0a8NR8=;
 b=diFChV6LGQ2HdpaafZjtbgTSJ5w7iEYcCuVfhFJKEqOHkbnVicJcJQNqWjuOOLoSwf
 su34EYL3xxrAeeQpsae5flF16Ns+yiJTXZo+BHiXFKvn9Xeu6TB5tlEwIk3jAiPrCx0b
 yVTUluSQVpYOl6l3Mht5Rpypj+vKtPxoRoCBKmfQZQsg3Bd4a7Y+CbQRRAMEeM0GPYc6
 lgq70ss+VF7FgYjbRXO2H3O8/Kdvq3abRqW/4AQhxSqrZ3Jip1hsSsMHSypUSUhyqwS5
 7X8YdFQBoUetVKIYSlyV9j9Mnx9fIaGBgMaUOr/4NgOGm8oAwwWR+3rBCSTpcmOi3dVw
 IiHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/+9Ep08EghUNEQo6z8Bnun3q+waOmc7Xgtq5B5rBvmwZBG3KBjg3dC5F36sMcpcMt167JoNfLcgHH0TUpLjqaLdy07tg=
X-Gm-Message-State: AOJu0Ywn/D97c4uxWimp9qy/+4Bg2fyFyqSkUwe56DJ+9P3UGNdl53yo
 p6dkRQPEwYs7Kz7MAqpwf46l8tvUzx5w/h6Yj/ekSP6jExH8i8LDWuE+XtC/PGY=
X-Google-Smtp-Source: AGHT+IEc0cH62lGbV40bXGg0eqyKFKyi+1TUGeu8esnJ76FJOZzAYbuGSSBrlbcQ9De6qcuen7BlrQ==
X-Received: by 2002:a05:600c:4f07:b0:421:f346:6b06 with SMTP id
 5b1f17b1804b1-4248cc5930emr19523015e9.28.1719161087895; 
 Sun, 23 Jun 2024 09:44:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101a955sm159904795e9.0.2024.06.23.09.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 09:44:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F0B45F944;
 Sun, 23 Jun 2024 17:44:46 +0100 (BST)
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
In-Reply-To: <6e11b143-2310-4d82-a7d6-da2ff73a3261@collabora.com> (Dmitry
 Osipenko's message of "Sat, 22 Jun 2024 01:25:32 +0300")
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
 <87bk3wdea9.fsf@draig.linaro.org>
 <f9880609-741b-4d18-b9b0-a9b3c28c930b@collabora.com>
 <875xu2hdsv.fsf@draig.linaro.org>
 <6e11b143-2310-4d82-a7d6-da2ff73a3261@collabora.com>
Date: Sun, 23 Jun 2024 17:44:46 +0100
Message-ID: <87o77rvcap.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 6/21/24 11:59, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> On 6/19/24 20:37, Alex Benn=C3=A9e wrote:
>>>> So I've been experimenting with Aarch64 TCG with an Intel backend like
>>>> this:
>>>>
>>>> ./qemu-system-aarch64 \
>>>>            -M virt -cpu cortex-a76 \
>>>>            -device virtio-net-pci,netdev=3Dunet \
>>>>            -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>>>>            -m 8192 \
>>>>            -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
>>>>            -serial mon:stdio \
>>>>            -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/=
boot/Image \
>>>>            -append "console=3DttyAMA0" \
>>>>            -device qemu-xhci -device usb-kbd -device usb-tablet \
>>>>            -device virtio-gpu-gl-pci,blob=3Dtrue,venus=3Dtrue,hostmem=
=3D4G \
>>>>            -display sdl,gl=3Don -d plugin,guest_errors,trace:virtio_gp=
u_cmd_res_create_blob,trace:virtio_gpu_cmd_res_back_\*,trace:virtio_gpu_cmd=
_res_xfer_toh_3d,trace:virtio_gpu_cmd_res_xfer_fromh_3d,trace:address_space=
_map=20
>>>>
>>>> And I've noticed a couple of things. First trying to launch vkmark to
>>>> run a KMS mode test fails with:
>>>>
>>> ...
>>>>   virgl_render_server[1875931]: vkr: failed to import resource: invali=
d res_id 5
>>>>   virgl_render_server[1875931]: vkr: vkAllocateMemory resulted in CS e=
rror=20
>>>>   virgl_render_server[1875931]: vkr: ring_submit_cmd: vn_dispatch_comm=
and failed
>>>>
>>>> More interestingly when shutting stuff down we see weirdness like:
>>>>
>>>>   address_space_map as:0x561b48ec48c0 addr 0x1008ac4b0:18 write:1 attr=
s:0x1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>>>>   virgl_render_server[1875931]: vkr: destroying context 3 (vkmark) wit=
h a valid instance=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>>>   virgl_render_server[1875931]: vkr: destroying device with valid obje=
cts=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>>>>   vkr_context_remove_object: -7438602987017907480=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>>>   vkr_context_remove_object: 7=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
>>>>   vkr_context_remove_object: 5=20=20=20=20=20=20=20
>>>>
>>>> which indicates something has gone very wrong. I'm not super familiar
>>>> with the memory allocation patterns but should stuff that is done as
>>>> virtio_gpu_cmd_res_back_attach() be find-able in the list of resources?
>>>
>>> This is expected to fail. Vkmark creates shmem virgl GBM FB BO on guest
>>> that isn't exportable on host. AFAICT, more code changes should be
>>> needed to support this case.
>>=20
>> There are a lot of acronyms there. If this is pure guest memory why
>> isn't it exportable to the host? Or should the underlying mesa library
>> be making sure the allocation happens from the shared region?
>>=20
>> Is vkmark particularly special here?
>
> Actually, you could get it to work to a some degree if you'll compile
> virglrenderer with -Dminigbm_allocation=3Dtrue. On host use GTK/Wayland
> display.

I'll give that a go.

> Vkmark isn't special. It's virglrenderer that has a room for
> improvement. ChromeOS doesn't use KMS in VMs, proper KMS support was
> never a priority for Venus.

Is there a tracking bug for KMS support for Venus? Or Venus should work
fine if virglrenderer can export the buffer to the host?

<snip>
>>>>
>>>> This could be a false positive or it could be a race between the guest
>>>> kernel clearing memory while we are still doing
>>>> virtio_gpu_ctrl_response.
>>>>
>>>> What do you think?
>>>
>>> The memcpy warning looks a bit suspicion, but likely is harmless. I
>>> don't see such warning with TSAN and x86 VM.
>>=20
>> TSAN can only pick up these interactions with TCG guests because it can
>> track guest memory accesses. With a KVM guest we have no visibility of
>> the guest accesses.=20
>
> I couldn't reproduce this issue with my KVM/TCG/ARM64 setups. Fox x86 I
> checked both KVM and TCG, TSAN only warns about vitio-net memcpy's for
> me.

Hmm OK. I'll keep an eye out as I test the next version.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

