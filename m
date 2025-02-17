Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF3C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk411-0004Ao-I0; Mon, 17 Feb 2025 11:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk40z-0004AS-Vb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:30:37 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk40x-0006Db-PM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:30:37 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f768e9be1aso45068417b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739809834; x=1740414634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j7y5fwAj/00iKVpT6Y8e40xdu1PrDltjUFeJ8hW3Zk=;
 b=Pg5C/+3d8wu96EmvBosJcy4eqc2MMx/Xe8m+Gz6N7WqocPYuA7OSU/Ty/hxdVxHSRH
 J5YonU4OVA3NwvzwoS7e1+6P7sF9NYqs8qWVmLQzAM2eVGSxfGMOSgizK9aY7+Kdymm9
 fwgFURSLSRQGLlo6b6jEcXZpnfMG+GyRs+AOxjJibNxgBXfS9jJ4KEHKRrlxEMdWT68M
 0ezgZl9zlPPJwaUECrQtfmwpVh0N1bgdEPKuboPX97obqtJtcop4Z9kV+4MwqAGYRRFH
 wyzwMOFDffiQbENbQVOQyP0/RCEr68eXcJJWlWwonbCLWFR7EHuuZuOrXFgluyZJrWAo
 7p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739809834; x=1740414634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6j7y5fwAj/00iKVpT6Y8e40xdu1PrDltjUFeJ8hW3Zk=;
 b=M/LM7Ij2QCL6S1thEBeZUcz53SWPOL2Ox7kWB5yF8HZ6N1fPCFHy//+QhYF+Kq0Jpj
 RFdw3WMrN81S/zZNv20ZkhAvWVsI62DrrmV2W52V5yjW0+PaJSYWWlOGNETSKTr7aHJq
 Db/hTRhvb5WZzv2Cf/d6uHJPQEzO+cLUT19hB+yNiRJA7cU4rxtOAHbvq2/gXi0Ca3ez
 SXlWwo4x6feRzAgFZAJlcg3MUV4MaKI+0eLzS8QSpIpSYAdIH4/NiwqeuVdWvPwNNP1a
 dvmNIhLfq33/j2cGBq03ChROdtnX1v77K936J3mUgev+XvoTa4mpyW2nGYhlqZYVMcjl
 y1Jg==
X-Gm-Message-State: AOJu0Yw2PpgDyCXtc5FZ1nh3hrcBxl3I3FcEThb3JSbz9LwU7QLlxnKp
 dv0fcUcTqgUlP/KSWJAdu5CKddp2+skD+Co08VTujx/8aof6eOiN8lZQTwg8YB2mHA3tzKceQEy
 UX6T1SE4Vr/szeLV65KjpWGbycmQu8BAPRjLvbA==
X-Gm-Gg: ASbGnctVFm4zr2fSo039ybLCirzOLKWSx5Aq9U6Pk3T7nAgRaHzjkMnsCprf0t0WfGh
 NkxIvtZmoYVBMHXg7Pq4BVi0/dDP7wCGYR3MnhiRMCOMubrooQ1EdRR8xRs7sm+CRPOgdSAN9sg
 ==
X-Google-Smtp-Source: AGHT+IF15qdRadTGJh11kJIS86k+95RCNcRPRtQYr+RMTXewIvhn61qZ/iY4776tM2DfO4KRNNW+UvpMHjUbxu657rw=
X-Received: by 2002:a05:6902:3408:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5dc98b2a49mr7287514276.16.1739809833930; Mon, 17 Feb 2025
 08:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
In-Reply-To: <20250110131754.2769814-24-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 16:30:22 +0000
X-Gm-Features: AWEUYZnJJhE-eSMqEP6pcLauS0o1XaV6wHO-47q30QTnWliK5Hx-6pnCF8tc6hA
Message-ID: <CAFEAcA8Kf4eF-nxEsxhPZnV3pwU+9kXLq1zXDi61ODQEQXaAYw@mail.gmail.com>
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 "open list:Virt" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 10 Jan 2025 at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Now that we have virtio-gpu Vulkan support, let's add a test for it.
> Currently this is using images build by buildroot:
>
>   https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.ht=
ml
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>

Hi; this test currently fails for me with a clang sanitizer
build (ubuntu 24.04 host). It seems to run weston in the guest,
which fails with:

2025-02-17 16:11:10,218: [16:11:10.672] Command line: weston -B
headless --renderer gl --shell kiosk -- vkmark -b:duration=3D1.0
2025-02-17 16:11:10,224: [16:11:10.675] OS: Linux, 6.11.10, #2 SMP Thu
Dec  5 16:27:12 GMT 2024, aarch64
2025-02-17 16:11:10,225: [16:11:10.680] Flight recorder: enabled
2025-02-17 16:11:10,226: [16:11:10.681] warning: XDG_RUNTIME_DIR
"/tmp" is not configured
2025-02-17 16:11:10,226: correctly.  Unix access mode must be 0700
(current mode is 0777),
2025-02-17 16:11:10,226: and must be owned by the user UID 0 (current
owner is UID 0).
2025-02-17 16:11:10,227: Refer to your distribution on how to get it, or
2025-02-17 16:11:10,227:
http://www.freedesktop.org/wiki/Specifications/basedir-spec
2025-02-17 16:11:10,228: on how to implement it.
2025-02-17 16:11:10,240: [16:11:10.695] Starting with no config file.
2025-02-17 16:11:10,253: [16:11:10.707] Output repaint window is 7 ms maxim=
um.
2025-02-17 16:11:10,262: [16:11:10.716] Loading module
'/usr/lib/libweston-14/headless-backend.so'
2025-02-17 16:11:10,313: [16:11:10.768] Loading module
'/usr/lib/libweston-14/gl-renderer.so'
2025-02-17 16:11:21,858: libEGL warning: egl: failed to create dri2 screen
2025-02-17 16:11:21,959: libEGL warning: egl: failed to create dri2 screen
2025-02-17 16:11:22,023: libEGL warning: egl: failed to create dri2 screen
2025-02-17 16:11:22,032: [16:11:22.486] failed to initialize display
2025-02-17 16:11:22,033: [16:11:22.488] EGL error state:
EGL_NOT_INITIALIZED (0x3001)
2025-02-17 16:11:22,036: [16:11:22.490] fatal: failed to create
compositor backend

Then eventually the test framework times it ou and sends it
a SIGTERM, and QEMU SEGVs inside libEGL trying to run an
exit handler:

qemu-system-aarch64: terminating on signal 15 from pid 242824
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/pyth=
on3)
UndefinedBehaviorSanitizer:DEADLYSIGNAL
=3D=3D243045=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknown addres=
s
0x73fbfefe6a31 (pc 0x73fbba9788e9 bp 0x73fbbbe0af80 sp 0x7ffd676fbfe0
T243045)
=3D=3D243045=3D=3DThe signal is caused by a READ memory access.
    #0 0x73fbba9788e9
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #1 0x73fbbaafc178
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16fc178)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #2 0x73fbba62564f
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x122564f)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #3 0x73fbbab067d7
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x17067d7)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #4 0x73fbba63b786
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x123b786)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #5 0x73fbba96290a
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x156290a)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #6 0x73fbba941c5c
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x1541c5c)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
    #7 0x73fbc2041f20
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f20) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #8 0x73fbc2041f68
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f68) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #9 0x73fbc2034ca9
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x34ca9) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #10 0x73fbc203ae90
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3ae90) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #11 0x73fbc203aeda
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3aeda) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #12 0x73fbc20a45f5
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa45f5) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #13 0x73fbc20a2bfc
(/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa2bfc) (BuildId:
6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
    #14 0x73fbd3047a75 in __run_exit_handlers stdlib/exit.c:108:8
    #15 0x73fbd3047bbd in exit stdlib/exit.c:138:3
    #16 0x5a5bab5e3fdb in qemu_default_main
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mai=
n.c:52:5
    #17 0x5a5bab5e3f9e in main
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mai=
n.c:76:9
    #18 0x73fbd302a1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #19 0x73fbd302a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #20 0x5a5ba9c5b554 in _start
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-aar=
ch64+0x15dc554)
(BuildId: 8efda3601b42aa2644dde35d1d63f7b22b649a33)

UndefinedBehaviorSanitizer can not provide additional info.
SUMMARY: UndefinedBehaviorSanitizer: SEGV
(/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
(BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
=3D=3D243045=3D=3DABORTING

thanks
-- PMM

