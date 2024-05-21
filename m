Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1D8C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Qvc-0007LT-7S; Tue, 21 May 2024 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9Qvb-0007LI-3E
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:57:23 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9QvZ-0006Kk-9V
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:57:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so8882936a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716303439; x=1716908239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B/AgJgRXY0kQ2Ljr65a55AU5yMBaHGM7X5ViwwnLDao=;
 b=AkGVrWK2mUWjTpojnRCQXC5UvYRdgGKXDtshdBSd5K/ekpov+JtyK5V+GT0eLUyZG8
 h6rU8t29A7FIpyAybJzWtooCSNzTI8pInKpNclVQj/OrY40mBpeY32KQ6Uhc0jPQLmVU
 Ttr+qfEmbuCqvzgeyGKdDPrNdfKg2PksyGTHSfacf0x6K+T7yQmtPLz6erJMKwEAu7TI
 lT5yAQ98J57mFdG9abwpTwbjcS5MvxefCDNdd2YUbO3BDRim1dGwimo1J+7WsbmfN2Nv
 j8YkkVusJI/GQYyJhNgypYl/1ujsyQ8WxjMxgDSl9K/EeNT1W++ucXD5r5Nu6o4HMtsg
 GguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716303439; x=1716908239;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/AgJgRXY0kQ2Ljr65a55AU5yMBaHGM7X5ViwwnLDao=;
 b=LHH82jGyULDpdc8K4wlwZ3iRza62GLs6BeQ3Klx+d/MrPEBn45huD9UgQdGYduifqu
 qHphGiVGw4bFNESx5WBx8lti9AWLyNFWCR4+Jdfu80pEVsS01cwTzojG2dDaULUSqpFI
 IOaXEiI48tyL16MaqHG1biWw2od6vKa+Y+P4So88eMC1etD0jEupeFvAdxh0DsIDJ46r
 tqItCyGcMpqRajFeMnVnxhjZEenxukoFtddEYeBPQ21Re9/Xykk8A5+g8xJ+8iq2jXGt
 1sF/XZeKf2UKgg2eVjUwibnlO17URBLWdRZ6AaHyNqWFMb1z2H3Q3SThawMF8KKFAdWK
 VVlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6bMB0NXC/g04l9zk2rBop6/X2agRHyJk8+bYjB4FPF2uQhMlSxqpRcfJbcyqOH1N+l/sQGsdJ74lpOkuHDb3IvMGPpSM=
X-Gm-Message-State: AOJu0Yz7RhPR50+BXRmENIXmqzo0dNxE9c1OZaQ0wXWC56AwxgR2uWhh
 7GalSe17JbNRHgoTgUJwgafq3fBJj38zpOhQ7OcalMCckZc2NON0XCjT9zf6dr4=
X-Google-Smtp-Source: AGHT+IEdOFezVd2xv9JfOdkMZSn6iwxeYj9vaX0pJWD2aFZQeSZPxZXOA86M8gd13sYknDJCkoXCLw==
X-Received: by 2002:a17:907:320b:b0:a59:b177:22d7 with SMTP id
 a640c23a62f3a-a5a2d53b75emr3905285866b.8.1716303439511; 
 Tue, 21 May 2024 07:57:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a69148b97sm1166235466b.114.2024.05.21.07.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 07:57:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64C9F5F8B0;
 Tue, 21 May 2024 15:57:18 +0100 (BST)
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
Subject: Re: [PATCH v12 00/13] Support blob memory and venus on qemu
In-Reply-To: <87o78zi9wb.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Tue, 21 May 2024 14:15:16 +0100")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <87o78zi9wb.fsf@draig.linaro.org>
Date: Tue, 21 May 2024 15:57:18 +0100
Message-ID: <87jzjni569.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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
>> Hello,
>>
>> This series enables Vulkan Venus context support on virtio-gpu.
>>
>> All virglrender and almost all Linux kernel prerequisite changes
>> needed by Venus are already in upstream. For kernel there is a pending
>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>> from Qemu.
>>
>> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google=
.com/
>>
>> You'll need to use recent Mesa version containing patch that removes
>> dependency on cross-device feature from Venus that isn't supported by
>> Qemu [2].
>>
>> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e269=
87befae78b6ccbb7ae242b
>>
>> Example Qemu cmdline that enables Venus:
>>
>>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,venu=
s=3Dtrue \
>>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G
>
> What is the correct device for non-x86 guests? We have virtio-gpu-gl-pci
> but when doing that I get:
>
>   -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,venus=3Dtrue
>   qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue=
,venus=3Dtrue: opengl is not available
>
> According to 37f86af087 (virtio-gpu: move virgl realize + properties):
>
>   Drop the virgl property, the virtio-gpu-gl-device has virgl enabled no
>   matter what.  Just use virtio-gpu-device instead if you don't want
>   enable virgl and opengl.  This simplifies the logic and reduces the test
>   matrix.
>
> but that's not a good solution because that needs virtio-mmio and there
> are reasons to have a PCI device (for one thing no ambiguity about
> discovery).

Oops my mistake forgetting:

  --display gtk,gl=3Don

Although I do see a lot of eglMakeContext failures.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

