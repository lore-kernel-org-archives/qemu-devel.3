Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82B2C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisww-0000Vu-JF; Tue, 27 Aug 2024 05:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1siswu-0000P8-NI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:57:16 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sisws-0000XP-Sh
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:57:16 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f40a1a2c1aso46394631fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752632; x=1725357432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zmlv+/H2H4IOeK3iYOIt02YrzQd95rRGq2IRetE8nzU=;
 b=Kj6ULqAwn/DDJsGIUfaHKjy/vu1gLCu917Z9YVcRMNgQKD4dnEoQ/LHv95b5B2snjm
 Lt96ICooydvY65NIduvSZQf0KcN0UnBKW/Jb0G5UcTv3EFDlh5eaJR5DBQHTJztGvkZ9
 h0V0ejA8cBo3xuq8Sv/gMDJIzDTVCRF+9MK5/6M8t5x2Ok950PoFJGuHINxwSzeZ9P1u
 G9XQ5qJRBwBfD90CZlzEcQiCSC5gWf9z8niInI3HFaE9quEAqOe7h+6fvIiwaVtg6PUh
 VZiJfEXEpUEdmJb/5+yOhB5mMYthx8aQUXIGsYl4BRvrz78QSjNG0O62PsNS6JwXlNvd
 95UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752632; x=1725357432;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zmlv+/H2H4IOeK3iYOIt02YrzQd95rRGq2IRetE8nzU=;
 b=JRi5fubdfXfr29npKS4skbC8aXe05Y02dWFA4ao93LvAfBU4AUsxgYJmClYwsBvPFV
 n5QCHgRIK7rlxhOm3hniB3V9bhIKCLweSMMtsGrBfG6VQpXUXcvPXOkdXVLA53cm3/M/
 LcmFcRsalj95WqdWV/E37bfA3uJ7KQC3UeSx9cQb07ASWdYpHZD6m5d4zH8UozrnAO9Y
 eulUmIP5+hXK7n0zbV6gZsByLlyJoSreF+pC+gjVmgUzrCf2NbCvF9kZiTnmVj4j/1Mf
 ymGCR0u+pOxUr33df+HveF7NeMpuEuVS3xznm8y90bg+xDwwBLudgqWGMrU9N6KpkGks
 UOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt2M+Q+ms4YP/qMe191MOdbNBtMMKi36Zfv5hN/CwTenfPZg9I9ksa1jxkHqwlSUQhRxH44sd0gOPB@nongnu.org
X-Gm-Message-State: AOJu0YzN4KUSY+EEVRcypNJ9oY2CnbkfMpQO747Z0+x+4lDDjCzUPzAP
 PryYcRwwurYvfpwerrP9M163IAaSc7bC1YOY7G66XIbXO0DuJh/DhcOL6KVE8OQ=
X-Google-Smtp-Source: AGHT+IE6rJ6z4ZKN7IlxKrB3NUJJq0jF7qZlDlbPZ9SoaFBM1BOmxcW6W33btaeszVTTjpvM9BBPyA==
X-Received: by 2002:a05:651c:504:b0:2f5:abe:b6c3 with SMTP id
 38308e7fff4ca-2f50abeb7b6mr48488541fa.33.1724752631406; 
 Tue, 27 Aug 2024 02:57:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb20e99asm858583a12.46.2024.08.27.02.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 02:57:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F30745F7A2;
 Tue, 27 Aug 2024 10:57:09 +0100 (BST)
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
Subject: Re: [PATCH v17 00/13] Support blob memory and venus on qemu
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Thu, 22 Aug 2024 21:50:56 +0300")
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
Date: Tue, 27 Aug 2024 10:57:09 +0100
Message-ID: <87ttf6cmq2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

> Hello,
>
> This series enables Vulkan Venus context support on virtio-gpu.
>
> All virglrender and almost all Linux kernel prerequisite changes
> needed by Venus are already in upstream. For kernel there is a pending
> KVM patchset that fixes mapping of compound pages needed for DRM drivers
> using TTM or huge pages [1], othewrwise hostmem blob mapping will fail
> with a KVM error from Qemu.
>
> [1] https://lore.kernel.org/all/20240726235234.228822-1-seanjc@google.com/
>
> On guest you'll need to use recent Mesa 24.2+ version containing patch
> that removes dependency on cross-device feature from Venus that isn't
> supported by Qemu [2].
>
> [2]
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987bef=
ae78b6ccbb7ae242b

I've expanded the set of working tests so:

x86 host, Intel GPU

 x86/kvm Trixie guest + latest mesa - works
 aarch64/tcg buildroot guest - works

Aarch64 host, AMD GPU

 x86/tcg Trixies guest + latest mesa - works
 aarch64/kvm buildroot guest - works

As the Aarch64 HW I'm testing on (AVA Devbox) needs additional patches
on top of Sean's series to deal with the busted Altra PCI which I
provide here:

 https://git.linaro.org/people/alex.bennee/linux.git/log/?h=3Dreview/pfn-re=
ferences-v12-with-altra-tweaks

Anyway I'll re-state:

  Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

And I think this series is ready to merge once the tree re-opens.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

