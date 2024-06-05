Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A457DC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuZW-0007vn-TG; Wed, 05 Jun 2024 13:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEuZV-0007uk-LW
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:37:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEuZR-0007Oh-VC
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:37:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a4ea806a5so44928a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717609027; x=1718213827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WZeHNDywWHAkUQY+OOtQGx/mxQeSzY6erOcxnTz/UcQ=;
 b=bmRzrtsZS3D9egJnYQb1OZ1H3l3mI6NqcECUf9LX1euhlu9pTao6QsEFb9+PZFLhqL
 9Fkx/YZ/Mg3MTEhpSuKirpAVb8R916jKqkD2FtYeZdgozefQOL0RfwHHVnplKSH7lUy/
 Fr6mAnDj9Uy+mKnQwDnSMmUkoNAwJQr3nLw6H0ywYqvNM6AsHVgdK6uGM/1dfxub7/6y
 aKLbhc1iIja4KFaSghFHoKVclgMrieL1+Ey+WYXGczZSBdkeDtw3+eNBI2ydqXVi2VjE
 UkvQ9N44qgYPI7YBMY+1/ozsL4plCelnJ1j7Z20doE8MR1LDqdlYwwO/W0KiNv/K3n9D
 ZnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717609027; x=1718213827;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZeHNDywWHAkUQY+OOtQGx/mxQeSzY6erOcxnTz/UcQ=;
 b=cFNdvWZF33VF5gLrmHjkmU0wjToJwEi2HMNMwL7HY4kRNgu25RNC4OhSW3y8LJHhlg
 jcsM0feLs2KlZizA4sEa/rY37oMjaicCD4P+Um3RKNR+yQ63c2/xdvJi5qAHgoCklMLb
 /cFaCHBv68qBSM5B8V5qH5yukOsGQDOZMJTWzx6XB4H4Iu8ZIAQXmIE5efdqUfReLwjs
 e07i+uzgiS8WrwJ8OiRgxyZLeyfLgQ7FYiC1Bi3bXNB1IVJ0P+fYkc6wEavSKjTj7Xq2
 vLvR9RPEvqdmP9htig/CnHHNcDbqgEocL9yDVcfGj4RIT9YbVGif/4aRn6nBRK43SmoI
 4xkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4M1UlMBfm4rRoYnMKHcAs3bNroHVJA6K5vXdsN07IvmA+FapB2F8Vgtw7w1u0FFwlR+vJ+IrHh3g9kEV0W/WK+o0Rv9w=
X-Gm-Message-State: AOJu0YzyRYfKpNCnV2RSnAfDDwdnrHKoa5u7hEEGUYce3Ghsu2OLrCKO
 sGi9jSiEaSlz2E+7smzrsN6CAPqkPzCABt9BN1cuKIwILzCSqptUDsucbI2011g=
X-Google-Smtp-Source: AGHT+IHYRA8QsRq9mMvDk96nChUmh29V9nty5obigS8JCAlOeCtfFkdi5xQ4rEUyl2B9aGlkA6G7YQ==
X-Received: by 2002:a50:ccdc:0:b0:578:6198:d6fc with SMTP id
 4fb4d7f45d1cf-57a8b6b18dbmr2665446a12.18.1717609027225; 
 Wed, 05 Jun 2024 10:37:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb842asm9599584a12.36.2024.06.05.10.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:37:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 448245F754;
 Wed,  5 Jun 2024 18:37:06 +0100 (BST)
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
In-Reply-To: <159a69c9-11b6-4240-b3c9-b5b8f50bb441@collabora.com> (Dmitry
 Osipenko's message of "Wed, 5 Jun 2024 19:29:40 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <87o78zi9wb.fsf@draig.linaro.org> <87jzjni569.fsf@draig.linaro.org>
 <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com>
 <874jaqi5m0.fsf@draig.linaro.org>
 <6bc5a3fc-8fbc-4449-a5e6-cd654655be35@collabora.com>
 <874ja7fnut.fsf@draig.linaro.org>
 <159a69c9-11b6-4240-b3c9-b5b8f50bb441@collabora.com>
Date: Wed, 05 Jun 2024 18:37:06 +0100
Message-ID: <878qzj1ebh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

> On 6/5/24 17:47, Alex Benn=C3=A9e wrote:
> ....
>> I'm guessing some sort of resource leak, if I run vkcube-wayland in the
>> guest it complains about being stuck on a fence with the iterator going
>> up. However on the host I see:
>>=20
<snip>
>>=20
>> The backtrace (and the 18G size of the core file!) indicates a leak:
>
> The unmap debug-assert tells that BO wasn't mapped because mapping
> failed, likely due to OOM. You won't hit this abort with a release build
> of libvirglrenderer.

AFAIK I should be building a release build (or at least I hope that is
what the wrapper I posted does):

  Message-Id: <20240605133527.529950-1-alex.bennee@linaro.org>
  Date: Wed,  5 Jun 2024 14:35:27 +0100
  Subject: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

Maybe I need to explicitly set builtype=3Drelease in the default options?

> The leak likely happens due to unsignalled fence.
>
> Please try to run vkcube with disabled fence-feedback feature:
>
>  # VN_PERF_NO_FENCE_FEEDBACK=3D1 vkcube-wayland
>
> It fixes hang for me. We had problems with combination of this Venus
> optimization feature + Intel ANV driver for a long time and hoped that
> it's fixed by now, apparently the issue was only masked.

That doesn't help, still causes the crash:

  virtio_gpu_fence_ctrl fence 0xdfd, type 0x204=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
  virtio_gpu_fence_ctrl fence 0xdfe, type 0x207=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_ctrl fence 0xdff, type 0x207=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_ctrl fence 0xe00, type 0x207=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_ctrl fence 0xe01, type 0x207=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_ctrl fence 0xe02, type 0x207=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_ctrl fence 0xe03, type 0x207=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xdfd=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xdfe=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xdff=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xe00=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xe01=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xe02=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_fence_resp fence 0xe03=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  stats: vq req  100,   7 -- 3D   25 (19560)=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
  vrend_renderer_resource_unmap: invalid bits 0x83=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virgl_renderer_resource_unmap: unexpected ret =3D -22, pipe:0x555559e5d0c=
0 fd_type:0

  Thread 1 "qemu-system-aar" received signal SIGABRT, Aborted.=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  44      ./nptl/pthread_kill.c: No such file or directory.=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

Which I think means VREND_STORAGE_GL_MEMOBJ | VREND_STORAGE_GL_TEXTURE |
VREND_STORAGE_GUEST_MEMORY

(I note the sense of has_bits is meant to be mask, bit but I don't think
that makes any difference)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

