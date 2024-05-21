Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5FBC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PL0-0002cK-LZ; Tue, 21 May 2024 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9PKr-0002KR-G6
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:15:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9PKp-0002AI-Bw
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:15:21 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so9094097a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716297317; x=1716902117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0w6mFp776tF8d5SkGhpyi3V37ejb2ZZMeAVJAz5wJMY=;
 b=Qva1fmsSAMVck/glVQ2ofyK1MF3JRHi/sp7YVa6aU5dfCw33/5HgXu1YQDJ5YEiv8j
 BMlM5iAhMzoOt+hGDVzS4FFD+aKFVFIcSxFqQSBpNg/h1xBl/oXWzpjIq5CBdXqq5N5R
 8k2aZ6RVJBVZdHmc9BcxjTZ52TNeVrv6AQp18TXa2RGd/kn6GZ8tjF6UgbYDknYAjROa
 rW42WgeigXc5SBMW0DouzwrxRfsWBJcehEqrMWY/yoyIqr7nk6l23me710hBRwJBYIoJ
 JNrKbCjnrnHFR3t+pMBB4/Rz5AqEPlT2I55Mu7to8lPvrc1PRRCpofmwC5RayL5IB602
 zlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716297317; x=1716902117;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0w6mFp776tF8d5SkGhpyi3V37ejb2ZZMeAVJAz5wJMY=;
 b=b/HK61T4m3j0h+OsAuieJxwNxiULsEKHAadKVjG3wkJReRGvG+THxh+ts4gKzfRWeE
 aVAf06vK94Ocn91s2uRgNQ3vmyYCYYK+AtZCsp7uJxnSZEi29n3a2Rd999OQ3CrZiSKk
 ArrB+hcIKfTUAik7e95ubgGbRyU8EuLNbNv8El5Lil4iFRlEjys58sjgt1bBCH44JjtL
 4E4cEfCej1J4mKbVr6ceaoQTGrTXivm9XrIaCz+PVUookP3EXtuqkc/dL43OtVfFAjsK
 wGmlal3e9EGZ+V/5Odq4xXPvmOXOjaQYZojpoIkEsbCWeWbr0UowXSMp7zQjggyQaxsJ
 Utag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6JG3VpLxC665CAqSaP1+7vLcwm3jJy2DIcg/SoKb608Hqzx43MIP+MfHFNnJL8S3o1U1xXB6+5WPV1MB88bgnpN5Q4pI=
X-Gm-Message-State: AOJu0YzTbA9FRXGlC6NL+7DOiCtN8fo+ovR7djjm6b/IJaBxEFAcHYfU
 NSkMD5Z4aPtBaLFXwqAJpLF8kpeUoh14UXJnaakSjKtwPiVDWodnbddVL4C38KA=
X-Google-Smtp-Source: AGHT+IEUUa0pz+ChNXDYTE7CRZWhRDaeXaDYdQxzihk//jgajNT/26HgVC/V0wOeZcx9gAn/B+9FfQ==
X-Received: by 2002:a50:cc48:0:b0:573:5c4c:a87a with SMTP id
 4fb4d7f45d1cf-5735c4ca8b7mr19903810a12.27.1716297317210; 
 Tue, 21 May 2024 06:15:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb73esm16692331a12.31.2024.05.21.06.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 06:15:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 108FD5F8B0;
 Tue, 21 May 2024 14:15:16 +0100 (BST)
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
In-Reply-To: <20240519212712.2605419-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 20 May 2024 00:26:59 +0300")
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
Date: Tue, 21 May 2024 14:15:16 +0100
Message-ID: <87o78zi9wb.fsf@draig.linaro.org>
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

> Hello,
>
> This series enables Vulkan Venus context support on virtio-gpu.
>
> All virglrender and almost all Linux kernel prerequisite changes
> needed by Venus are already in upstream. For kernel there is a pending
> KVM patchset that fixes mapping of compound pages needed for DRM drivers
> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
> from Qemu.
>
> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.=
com/
>
> You'll need to use recent Mesa version containing patch that removes
> dependency on cross-device feature from Venus that isn't supported by
> Qemu [2].
>
> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e2698=
7befae78b6ccbb7ae242b
>
> Example Qemu cmdline that enables Venus:
>
>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,venus=
=3Dtrue \
>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G

What is the correct device for non-x86 guests? We have virtio-gpu-gl-pci
but when doing that I get:

  -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,venus=3Dtrue
  qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=3D4G,blob=3Dtrue,v=
enus=3Dtrue: opengl is not available

According to 37f86af087 (virtio-gpu: move virgl realize + properties):

  Drop the virgl property, the virtio-gpu-gl-device has virgl enabled no
  matter what.  Just use virtio-gpu-device instead if you don't want
  enable virgl and opengl.  This simplifies the logic and reduces the test
  matrix.

but that's not a good solution because that needs virtio-mmio and there
are reasons to have a PCI device (for one thing no ambiguity about
discovery).


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

