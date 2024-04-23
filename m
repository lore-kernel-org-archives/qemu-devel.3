Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 08:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzBXv-0004pG-7t; Tue, 23 Apr 2024 04:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rzBXt-0004or-6H
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:30:33 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rzBXr-0007Au-3V
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:30:32 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-516d2600569so6687210e87.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713861028; x=1714465828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6KOjnBzdVHg3Y3ZAHXv+65BtE3//7g/7c/W6xeaLoc=;
 b=sp+AN03pSyaBbzl8nvkiDVC8Md0XnUgNa+zL05ypv8Fh+QffVAVZPwvjUExZd9zzQA
 M84KVUQ8nch2gZlPc97imAG2h8PNZf4su2M3M3XGSQyok7f6H7YTscTpiSQ1A3nb1TLX
 PEvRCqInBYZJKBMFpTou4dZmYd/xl+SIjfSklwIz4bztGBmE9Lwi60JK2A3VwkVZI1bb
 dZDD/U1L5ZsjhAYxCbuNv59Uda4/F6wMa7kcru9FTysxNeJ8uvV1y+Te+ZdXOjxSX8XV
 1FzyUTG08e2+WhJPa8DqW2pU90gD708a6ZnQ/ciNfEPwlFXxXcoI8mhKnKl3naJjOtlM
 VRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713861028; x=1714465828;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T6KOjnBzdVHg3Y3ZAHXv+65BtE3//7g/7c/W6xeaLoc=;
 b=WiiW4JINX3Gd15Ze8D5QDTQDYyKN8r6f4ocv/nrTU5zsB38bM/GbBV+3kRHm+AvaSD
 NXPqLlnisJhQPL0i781RT5AvDTMDT0TsARZEJWuBwgZjod1iusX6NEu1XHhrxE9bbFvS
 iSf5q+rPbVAwAPP3RNdt9ZFodjMlFM4X7mUm0Mo698T0RTZ7yKAwyBYTbfU75/BU1X29
 keqbtja8C0lmPvhG3m/kHst0CHT5PCoVfy0yzEd0gpFZXV1sm6qPHcqiTcIJABLyCgWu
 jRqClro8F/wz+MbKEYR2PKHOJa1ILB4vFCjKUOxHOgh25KMhRpeg5MG9LoFjzwJ/0oPK
 VM8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFNgPSGWGoXfi/DzOn7MuoV3rmr8htmvkbaFo9/1ucVNiI6LbbTRy/28eatWext9jyzfOtG37+4cLahI+bsQQ2ZgTVSfA=
X-Gm-Message-State: AOJu0YwCwIii+NyRSpfBkcNB7NBB1s0WLfaQnYz8vm/ii0QVJKecJgNx
 m3cjiWqHc19EAFE3bjL74xEBYyxCrkPcYEVGCVDc9SE/qf9WLXuWIVu/AKfOJeQ=
X-Google-Smtp-Source: AGHT+IHiBhwf82EjZWglS/4UA8aHdDly24yYtSm2T5mYk92F7Zf/5Rwi1dS3YeowbLGmGObIiiKnhw==
X-Received: by 2002:a05:6512:2247:b0:51b:a710:d6c7 with SMTP id
 i7-20020a056512224700b0051ba710d6c7mr872726lfu.14.1713861027999; 
 Tue, 23 Apr 2024 01:30:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q21-20020a170906771500b00a51d408d446sm6765404ejm.26.2024.04.23.01.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 01:30:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EC8B5F8C1;
 Tue, 23 Apr 2024 09:30:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony.perard@citrix.com>,  Antonio Caggiano
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
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v8 00/11] Support blob memory and venus on qemu
In-Reply-To: <20240418190040.1110210-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Thu, 18 Apr 2024 22:00:29 +0300")
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.4; emacs 29.2
Date: Tue, 23 Apr 2024 09:30:26 +0100
Message-ID: <87jzkoqy59.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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
> [1]
> https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/

Following the link for the TTM/KVM patches on the kernel side points at
changes for AMD cards getting NAK'ed so I'm a little confused as to what
parts are needed.

Is this only relevant for ensuring the virtual mappings to the
underlying hardware aren't moved around when KVM is exporting those
pages to the guest?

Our interest is in Xen which obviously mediates everything through stage
2 mappings to from the real PA to the IPA the domains see. However AIUI
all the blob allocation is managed by the GEM/TTM layer of whichever
kernel is responsible for driving the GPU. Does this layer work with
kernel vaddr or the underlying IPA of the resources? We shouldn't
expect the IPA to change between allocations should we?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

