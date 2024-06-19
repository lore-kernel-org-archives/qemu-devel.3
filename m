Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC56C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzG0-0008SN-22; Wed, 19 Jun 2024 13:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJzFy-0008S7-AO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:38:02 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJzFt-0005WT-Tl
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:38:02 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso1969366b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718818676; x=1719423476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qWatuN+pj8S9fB3uzevK8Pgd0jSHmcoJCDBmLEXX/Po=;
 b=p4Gsasqu6BB6oSDWKbTn+i1wRRwOIL8bX1kFpAAZCuz5y3E/UtKvAAENQZN4Br6oT/
 ieIN1mcadmxM4YSpSok8ynzP+vu5WC5SluQMTpVrbwEWDHWyQgT0DeCmK0hoVweILH1T
 GaZ9J4b7VlQkNuncgJyaLKu8Op87ZHpq2AcyNPw7dvfSMNR7FOsFrOp9gPAmK0h59g+R
 Mxr9hGtZeIDh8cmB6NvsNo6aW763HHI4OJqGYDGfumilDf6dMEgXuA3vsXmSYizZ/8fm
 u6peEkrJVKMOzSmoAv16pLTBA1tgt1i1KNdb8shIZS00YNQ5BJ5CCP+ZfnOZ4Pz9IBS/
 QDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718818676; x=1719423476;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWatuN+pj8S9fB3uzevK8Pgd0jSHmcoJCDBmLEXX/Po=;
 b=dP2vvaTPuoGdFtZ9jge48Swa2sDoZiwXD2YxykUJ9JCsNQH5KArc5DqGXVvt/h2z6G
 ASvnjhLMpCezBfF/xcjiwGW/SnYGQxVpWbjW+6uL/gka59ilK0cAFmzI6GMQWu6eGxAv
 vHAf4qiJip2XV4WqvNNf0RNx/NUvNwcqx28gcyHby12d9W5NBl4/UNaw5iU0OQoQ0uiD
 b1V/vUJCpanM4WZQte1GOF5Y/iWZwoWZdHJL3pS1tcebmeHxYiuM9zj0WwzunLD6d9PE
 JNu1wQlK4BBaFZfEfaqi9YqlL8OOcLZFSZeHzaBy3z9LfQPnE941Ua75emee+rVEdap3
 0pwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwaB9KMqHGWliFz0Pi3QPLT0IWTgT6RWpd74V5b2mURhu+mX/c77zrT6cXrfKWZeh5zw+S6ecF5wBtjGGaH9mRhJC03xg=
X-Gm-Message-State: AOJu0YzjdrQwyzgH5WwzcZyp2y5fusqfZx2TPI3Cl97sykZ8+kMYzi7w
 P2QuybSje6MljBFFEWYcKAqhxpgHqh7fJfT0YH1d3BYl4tvC7RsHRoAvPHl02co=
X-Google-Smtp-Source: AGHT+IF05Jcrzdr8a3zhgyqtTsHKo+oki0+iFsagoOeXyeCRzhEOzoA2UzClFP3AlAybQYC1MmSLWg==
X-Received: by 2002:a17:907:1686:b0:a6f:b34c:76f3 with SMTP id
 a640c23a62f3a-a6fb34c7888mr166959166b.55.1718818675772; 
 Wed, 19 Jun 2024 10:37:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa674bsm685757466b.210.2024.06.19.10.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 10:37:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD31C5F919;
 Wed, 19 Jun 2024 18:37:50 +0100 (BST)
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
In-Reply-To: <20240616010357.2874662-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 16 Jun 2024 04:03:43 +0300")
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
Date: Wed, 19 Jun 2024 18:37:50 +0100
Message-ID: <87bk3wdea9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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
> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
> from Qemu.

So I've been experimenting with Aarch64 TCG with an Intel backend like
this:

./qemu-system-aarch64 \
           -M virt -cpu cortex-a76 \
           -device virtio-net-pci,netdev=3Dunet \
           -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
           -m 8192 \
           -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
           -serial mon:stdio \
           -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/boot/=
Image \
           -append "console=3DttyAMA0" \
           -device qemu-xhci -device usb-kbd -device usb-tablet \
           -device virtio-gpu-gl-pci,blob=3Dtrue,venus=3Dtrue,hostmem=3D4G \
           -display sdl,gl=3Don -d plugin,guest_errors,trace:virtio_gpu_cmd=
_res_create_blob,trace:virtio_gpu_cmd_res_back_\*,trace:virtio_gpu_cmd_res_=
xfer_toh_3d,trace:virtio_gpu_cmd_res_xfer_fromh_3d,trace:address_space_map=
=20

And I've noticed a couple of things. First trying to launch vkmark to
run a KMS mode test fails with:

  vkr_context_add_object: 5 -> 0x7f24b81d7198=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:18 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  vkr_context_add_object: 6 -> 0x7f24b81d7240=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:18 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  vkr_context_add_object: 7 -> 0x7f24b81d71e0=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:48 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac690:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac570:20 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x101d64300:40 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac590:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac720:20 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac740:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virtio_gpu_cmd_res_back_attach res 0x5, 4 entries=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x109fd5000:2b000 write:0 attrs:=
0x1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x102200000:100000 write:0 attrs=
:0x1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x100e00000:200000 write:0 attrs=
:0x1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x10a000000:bd000 write:0 attrs:=
0x1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:48 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac690:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac720:20 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:20 write:0 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac740:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac570:20 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac590:18 write:1 attrs:0x1
  virtio_gpu_cmd_res_back_attach res 0x6, 2 entries=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x10a0bd000:343000 write:0 attrs=
:0x1
  address_space_map as:0x561b48ec48c0 addr 0x11a800000:a5000 write:0 attrs:=
0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:18 write:0 attrs:0x1=
=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1
  vkr_context_add_object: 8 -> 0x7f24b81d7180=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:18 write:0 attrs:0x1=
=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1=
=20=20=20=20
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:18 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac648:20 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x109dc5be0:18 write:0 attrs:0x1
  address_space_map as:0x561b48ec48c0 addr 0x1008ac668:18 write:1 attrs:0x1
  virgl_render_server[1875931]: vkr: failed to import resource: invalid res=
_id 5
  virgl_render_server[1875931]: vkr: vkAllocateMemory resulted in CS error=
=20
  virgl_render_server[1875931]: vkr: ring_submit_cmd: vn_dispatch_command f=
ailed

More interestingly when shutting stuff down we see weirdness like:

  address_space_map as:0x561b48ec48c0 addr 0x1008ac4b0:18 write:1 attrs:0x1=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virgl_render_server[1875931]: vkr: destroying context 3 (vkmark) with a v=
alid instance=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  virgl_render_server[1875931]: vkr: destroying device with valid objects=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
  vkr_context_remove_object: -7438602987017907480=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  vkr_context_remove_object: 7=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
  vkr_context_remove_object: 5=20=20=20=20=20=20=20

which indicates something has gone very wrong. I'm not super familiar
with the memory allocation patterns but should stuff that is done as
virtio_gpu_cmd_res_back_attach() be find-able in the list of resources?

I tried running under RR to further debug but weirdly I can't get
working graphics with that. I did try running under threadsan which
complained about a potential data race:

  vkr_context_add_object: 1 -> 0x7b2c00000288
  vkr_context_add_object: 2 -> 0x7b2c00000270
  vkr_context_add_object: 3 -> 0x7b3800007f28
  vkr_context_add_object: 4 -> 0x7b3800007fa0
  vkr_context_add_object: 5 -> 0x7b48000103f8
  vkr_context_add_object: 6 -> 0x7b48000104a0
  vkr_context_add_object: 7 -> 0x7b4800010440
  virtio_gpu_cmd_res_back_attach res 0x5
  virtio_gpu_cmd_res_back_attach res 0x6
  vkr_context_add_object: 8 -> 0x7b48000103e0
  virgl_render_server[1751430]: vkr: failed to import resource: invalid res=
_id 5
  virgl_render_server[1751430]: vkr: vkAllocateMemory resulted in CS error
  virgl_render_server[1751430]: vkr: ring_submit_cmd: vn_dispatch_command f=
ailed
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  WARNING: ThreadSanitizer: data race (pid=3D1751256)
    Read of size 8 at 0x7f7fa0ea9138 by main thread (mutexes: write M0):
      #0 memcpy <null> (qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77c=
b6782341ee3407e44af7267974025)
      #1 iov_to_buf_full /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../util/iov.c:51:13 (qemu-system-aarch64+0x19839cf) (BuildId: 0bab171e77c=
b6782341ee3407e44af7267974025)
      #2 iov_to_buf /home/alex/lsrc/qemu.git/include/qemu/iov.h:62:16 (qemu=
-system-aarch64+0xe3db91) (BuildId: 0bab171e77cb6782341ee3407e44af726797402=
5)
      #3 virtio_gpu_virgl_process_cmd /home/alex/lsrc/qemu.git/builds/syste=
m.threadsan/../../hw/display/virtio-gpu-virgl.c:914:5 (qemu-system-aarch64+=
0xe3d178) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #4 virtio_gpu_process_cmdq /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../hw/display/virtio-gpu.c:1055:9 (qemu-system-aarch64+0xe308ca) =
(BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #5 virtio_gpu_gl_handle_ctrl /home/alex/lsrc/qemu.git/builds/system.t=
hreadsan/../../hw/display/virtio-gpu-gl.c:100:5 (qemu-system-aarch64+0xe3c8=
fd) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #6 virtio_gpu_ctrl_bh /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../hw/display/virtio-gpu.c:1134:5 (qemu-system-aarch64+0xe3173a) (Buil=
dId: 0bab171e77cb6782341ee3407e44af7267974025)
      #7 aio_bh_call /home/alex/lsrc/qemu.git/builds/system.threadsan/../..=
/util/async.c:171:5 (qemu-system-aarch64+0x19643e7) (BuildId: 0bab171e77cb6=
782341ee3407e44af7267974025)
      #8 aio_bh_poll /home/alex/lsrc/qemu.git/builds/system.threadsan/../..=
/util/async.c:218:13 (qemu-system-aarch64+0x1964723) (BuildId: 0bab171e77cb=
6782341ee3407e44af7267974025)
      #9 aio_dispatch /home/alex/lsrc/qemu.git/builds/system.threadsan/../.=
./util/aio-posix.c:423:5 (qemu-system-aarch64+0x192ab55) (BuildId: 0bab171e=
77cb6782341ee3407e44af7267974025)
      #10 aio_ctx_dispatch /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../util/async.c:360:5 (qemu-system-aarch64+0x1966d94) (BuildId: 0bab171=
e77cb6782341ee3407e44af7267974025)
      #11 g_main_context_dispatch <null> (libglib-2.0.so.0+0x547a8) (BuildI=
d: 9f90bd7bbfcf84a1f1c5a6102f70e6264837b9d4)
      #12 os_host_main_loop_wait /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../util/main-loop.c:310:5 (qemu-system-aarch64+0x1967f14) (BuildI=
d: 0bab171e77cb6782341ee3407e44af7267974025)
      #13 main_loop_wait /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../util/main-loop.c:589:11 (qemu-system-aarch64+0x1967d78) (BuildId: 0bab=
171e77cb6782341ee3407e44af7267974025)
      #14 qemu_main_loop /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../system/runstate.c:795:9 (qemu-system-aarch64+0xce803c) (BuildId: 0bab1=
71e77cb6782341ee3407e44af7267974025)
      #15 qemu_default_main /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../system/main.c:37:14 (qemu-system-aarch64+0x1583c15) (BuildId: 0bab1=
71e77cb6782341ee3407e44af7267974025)
      #16 main /home/alex/lsrc/qemu.git/builds/system.threadsan/../../syste=
m/main.c:48:12 (qemu-system-aarch64+0x1583c8a) (BuildId: 0bab171e77cb678234=
1ee3407e44af7267974025)

    Previous write of size 8 at 0x7f7fa0ea9138 by thread T3:
      #0 memset <null> (qemu-system-aarch64+0x41fbdd) (BuildId: 0bab171e77c=
b6782341ee3407e44af7267974025)
      #1 helper_dc_zva /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../target/arm/tcg/helper-a64.c:974:5 (qemu-system-aarch64+0x1305506) (Build=
Id: 0bab171e77cb6782341ee3407e44af7267974025)
      #2 <null> <null> (0x7f82e14300aa)
      #3 cpu_loop_exec_tb /home/alex/lsrc/qemu.git/builds/system.threadsan/=
../../accel/tcg/cpu-exec.c:917:10 (qemu-system-aarch64+0x15383fd) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #4 cpu_exec_loop /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../accel/tcg/cpu-exec.c:1031:13 (qemu-system-aarch64+0x153746f) (BuildId: 0=
bab171e77cb6782341ee3407e44af7267974025)
      #5 cpu_exec_setjmp /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../accel/tcg/cpu-exec.c:1048:12 (qemu-system-aarch64+0x15354db) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #6 cpu_exec /home/alex/lsrc/qemu.git/builds/system.threadsan/../../ac=
cel/tcg/cpu-exec.c:1074:11 (qemu-system-aarch64+0x1535040) (BuildId: 0bab17=
1e77cb6782341ee3407e44af7267974025)
      #7 tcg_cpu_exec /home/alex/lsrc/qemu.git/builds/system.threadsan/../.=
./accel/tcg/tcg-accel-ops.c:78:11 (qemu-system-aarch64+0x157aabe) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #8 mttcg_cpu_thread_fn /home/alex/lsrc/qemu.git/builds/system.threads=
an/../../accel/tcg/tcg-accel-ops-mttcg.c:95:17 (qemu-system-aarch64+0x157bb=
7b) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #9 qemu_thread_start /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../util/qemu-thread-posix.c:541:9 (qemu-system-aarch64+0x19363d1) (Buil=
dId: 0bab171e77cb6782341ee3407e44af7267974025)

    Mutex M0 (0x562c55066680) created at:
      #0 pthread_mutex_init <null> (qemu-system-aarch64+0x41746f) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #1 qemu_mutex_init /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../util/qemu-thread-posix.c:71:11 (qemu-system-aarch64+0x19345d9) (BuildI=
d: 0bab171e77cb6782341ee3407e44af7267974025)
      #2 qemu_init_cpu_loop /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../system/cpus.c:423:5 (qemu-system-aarch64+0xccd145) (BuildId: 0bab17=
1e77cb6782341ee3407e44af7267974025)
      #3 qemu_init_subsystems /home/alex/lsrc/qemu.git/builds/system.thread=
san/../../system/runstate.c:825:5 (qemu-system-aarch64+0xce83a7) (BuildId: =
0bab171e77cb6782341ee3407e44af7267974025)
      #4 qemu_init /home/alex/lsrc/qemu.git/builds/system.threadsan/../../s=
ystem/vl.c:2795:5 (qemu-system-aarch64+0xcea0f3) (BuildId: 0bab171e77cb6782=
341ee3407e44af7267974025)
      #5 main /home/alex/lsrc/qemu.git/builds/system.threadsan/../../system=
/main.c:47:5 (qemu-system-aarch64+0x1583c78) (BuildId: 0bab171e77cb6782341e=
e3407e44af7267974025)

    Thread T3 'CPU 0/TCG' (tid=3D1751259, running) created by main thread a=
t:
      #0 pthread_create <null> (qemu-system-aarch64+0x415c6d) (BuildId: 0ba=
b171e77cb6782341ee3407e44af7267974025)
      #1 qemu_thread_create /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../util/qemu-thread-posix.c:581:11 (qemu-system-aarch64+0x193619b) (Bu=
ildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #2 mttcg_start_vcpu_thread /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../accel/tcg/tcg-accel-ops-mttcg.c:144:5 (qemu-system-aarch64+0x1=
57b940) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #3 qemu_init_vcpu /home/alex/lsrc/qemu.git/builds/system.threadsan/..=
/../system/cpus.c:680:5 (qemu-system-aarch64+0xcce7a0) (BuildId: 0bab171e77=
cb6782341ee3407e44af7267974025)
      #4 arm_cpu_realizefn /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../target/arm/cpu.c:2588:5 (qemu-system-aarch64+0xfd9023) (BuildId: 0ba=
b171e77cb6782341ee3407e44af7267974025)
      #5 device_set_realized /home/alex/lsrc/qemu.git/builds/system.threads=
an/../../hw/core/qdev.c:510:13 (qemu-system-aarch64+0x158e205) (BuildId: 0b=
ab171e77cb6782341ee3407e44af7267974025)
      #6 property_set_bool /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../qom/object.c:2354:5 (qemu-system-aarch64+0x159dffb) (BuildId: 0bab17=
1e77cb6782341ee3407e44af7267974025)
      #7 object_property_set /home/alex/lsrc/qemu.git/builds/system.threads=
an/../../qom/object.c:1463:5 (qemu-system-aarch64+0x159a6a7) (BuildId: 0bab=
171e77cb6782341ee3407e44af7267974025)
      #8 object_property_set_qobject /home/alex/lsrc/qemu.git/builds/system=
.threadsan/../../qom/qom-qobject.c:28:10 (qemu-system-aarch64+0x15a35e2) (B=
uildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #9 object_property_set_bool /home/alex/lsrc/qemu.git/builds/system.th=
readsan/../../qom/object.c:1533:15 (qemu-system-aarch64+0x159b00e) (BuildId=
: 0bab171e77cb6782341ee3407e44af7267974025)
      #10 qdev_realize /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../hw/core/qdev.c:291:12 (qemu-system-aarch64+0x158b989) (BuildId: 0bab171e=
77cb6782341ee3407e44af7267974025)
      #11 machvirt_init /home/alex/lsrc/qemu.git/builds/system.threadsan/..=
/../hw/arm/virt.c:2295:9 (qemu-system-aarch64+0xef0028) (BuildId: 0bab171e7=
7cb6782341ee3407e44af7267974025)
      #12 machine_run_board_init /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../hw/core/machine.c:1583:5 (qemu-system-aarch64+0x607380) (Build=
Id: 0bab171e77cb6782341ee3407e44af7267974025)
      #13 qemu_init_board /home/alex/lsrc/qemu.git/builds/system.threadsan/=
../../system/vl.c:2621:5 (qemu-system-aarch64+0xce9b30) (BuildId: 0bab171e7=
7cb6782341ee3407e44af7267974025)
      #14 qmp_x_exit_preconfig /home/alex/lsrc/qemu.git/builds/system.threa=
dsan/../../system/vl.c:2713:5 (qemu-system-aarch64+0xce98df) (BuildId: 0bab=
171e77cb6782341ee3407e44af7267974025)
      #15 qemu_init /home/alex/lsrc/qemu.git/builds/system.threadsan/../../=
system/vl.c:3759:9 (qemu-system-aarch64+0xced7ca) (BuildId: 0bab171e77cb678=
2341ee3407e44af7267974025)
      #16 main /home/alex/lsrc/qemu.git/builds/system.threadsan/../../syste=
m/main.c:47:5 (qemu-system-aarch64+0x1583c78) (BuildId: 0bab171e77cb6782341=
ee3407e44af7267974025)

  SUMMARY: ThreadSanitizer: data race (/home/alex/lsrc/qemu.git/builds/syst=
em.threadsan/qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77cb6782341ee3=
407e44af7267974025) in __interceptor_memcpy
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  WARNING: ThreadSanitizer: data race (pid=3D1751256)
    Write of size 8 at 0x7f7fa0ea9158 by main thread (mutexes: write M0):
      #0 memcpy <null> (qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77c=
b6782341ee3407e44af7267974025)
      #1 iov_from_buf_full /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../util/iov.c:32:13 (qemu-system-aarch64+0x1983771) (BuildId: 0bab171e7=
7cb6782341ee3407e44af7267974025)
      #2 iov_from_buf /home/alex/lsrc/qemu.git/include/qemu/iov.h:49:16 (qe=
mu-system-aarch64+0xe2c471) (BuildId: 0bab171e77cb6782341ee3407e44af7267974=
025)
      #3 virtio_gpu_ctrl_response /home/alex/lsrc/qemu.git/builds/system.th=
readsan/../../hw/display/virtio-gpu.c:173:9 (qemu-system-aarch64+0xe2c2bb) =
(BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #4 virtio_gpu_ctrl_response_nodata /home/alex/lsrc/qemu.git/builds/sy=
stem.threadsan/../../hw/display/virtio-gpu.c:192:5 (qemu-system-aarch64+0xe=
2c5b1) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #5 virtio_gpu_virgl_process_cmd /home/alex/lsrc/qemu.git/builds/syste=
m.threadsan/../../hw/display/virtio-gpu-virgl.c:1006:9 (qemu-system-aarch64=
+0xe3da2a) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #6 virtio_gpu_process_cmdq /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../hw/display/virtio-gpu.c:1055:9 (qemu-system-aarch64+0xe308ca) =
(BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #7 virtio_gpu_gl_handle_ctrl /home/alex/lsrc/qemu.git/builds/system.t=
hreadsan/../../hw/display/virtio-gpu-gl.c:100:5 (qemu-system-aarch64+0xe3c8=
fd) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #8 virtio_gpu_ctrl_bh /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../hw/display/virtio-gpu.c:1134:5 (qemu-system-aarch64+0xe3173a) (Buil=
dId: 0bab171e77cb6782341ee3407e44af7267974025)
      #9 aio_bh_call /home/alex/lsrc/qemu.git/builds/system.threadsan/../..=
/util/async.c:171:5 (qemu-system-aarch64+0x19643e7) (BuildId: 0bab171e77cb6=
782341ee3407e44af7267974025)
      #10 aio_bh_poll /home/alex/lsrc/qemu.git/builds/system.threadsan/../.=
./util/async.c:218:13 (qemu-system-aarch64+0x1964723) (BuildId: 0bab171e77c=
b6782341ee3407e44af7267974025)
      #11 aio_dispatch /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../util/aio-posix.c:423:5 (qemu-system-aarch64+0x192ab55) (BuildId: 0bab171=
e77cb6782341ee3407e44af7267974025)
      #12 aio_ctx_dispatch /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../util/async.c:360:5 (qemu-system-aarch64+0x1966d94) (BuildId: 0bab171=
e77cb6782341ee3407e44af7267974025)
      #13 g_main_context_dispatch <null> (libglib-2.0.so.0+0x547a8) (BuildI=
d: 9f90bd7bbfcf84a1f1c5a6102f70e6264837b9d4)
      #14 os_host_main_loop_wait /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../util/main-loop.c:310:5 (qemu-system-aarch64+0x1967f14) (BuildI=
d: 0bab171e77cb6782341ee3407e44af7267974025)
      #15 main_loop_wait /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../util/main-loop.c:589:11 (qemu-system-aarch64+0x1967d78) (BuildId: 0bab=
171e77cb6782341ee3407e44af7267974025)
      #16 qemu_main_loop /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../system/runstate.c:795:9 (qemu-system-aarch64+0xce803c) (BuildId: 0bab1=
71e77cb6782341ee3407e44af7267974025)
      #17 qemu_default_main /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../system/main.c:37:14 (qemu-system-aarch64+0x1583c15) (BuildId: 0bab1=
71e77cb6782341ee3407e44af7267974025)
      #18 main /home/alex/lsrc/qemu.git/builds/system.threadsan/../../syste=
m/main.c:48:12 (qemu-system-aarch64+0x1583c8a) (BuildId: 0bab171e77cb678234=
1ee3407e44af7267974025)

    Previous write of size 8 at 0x7f7fa0ea9158 by thread T3:
      #0 memset <null> (qemu-system-aarch64+0x41fbdd) (BuildId: 0bab171e77c=
b6782341ee3407e44af7267974025)
      #1 helper_dc_zva /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../target/arm/tcg/helper-a64.c:974:5 (qemu-system-aarch64+0x1305506) (Build=
Id: 0bab171e77cb6782341ee3407e44af7267974025)
      #2 <null> <null> (0x7f82e1360e74)
      #3 cpu_loop_exec_tb /home/alex/lsrc/qemu.git/builds/system.threadsan/=
../../accel/tcg/cpu-exec.c:917:10 (qemu-system-aarch64+0x15383fd) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #4 cpu_exec_loop /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../accel/tcg/cpu-exec.c:1031:13 (qemu-system-aarch64+0x153746f) (BuildId: 0=
bab171e77cb6782341ee3407e44af7267974025)
      #5 cpu_exec_setjmp /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../accel/tcg/cpu-exec.c:1048:12 (qemu-system-aarch64+0x15354db) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #6 cpu_exec /home/alex/lsrc/qemu.git/builds/system.threadsan/../../ac=
cel/tcg/cpu-exec.c:1074:11 (qemu-system-aarch64+0x1535040) (BuildId: 0bab17=
1e77cb6782341ee3407e44af7267974025)
      #7 tcg_cpu_exec /home/alex/lsrc/qemu.git/builds/system.threadsan/../.=
./accel/tcg/tcg-accel-ops.c:78:11 (qemu-system-aarch64+0x157aabe) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #8 mttcg_cpu_thread_fn /home/alex/lsrc/qemu.git/builds/system.threads=
an/../../accel/tcg/tcg-accel-ops-mttcg.c:95:17 (qemu-system-aarch64+0x157bb=
7b) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #9 qemu_thread_start /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../util/qemu-thread-posix.c:541:9 (qemu-system-aarch64+0x19363d1) (Buil=
dId: 0bab171e77cb6782341ee3407e44af7267974025)

    Mutex M0 (0x562c55066680) created at:
      #0 pthread_mutex_init <null> (qemu-system-aarch64+0x41746f) (BuildId:=
 0bab171e77cb6782341ee3407e44af7267974025)
      #1 qemu_mutex_init /home/alex/lsrc/qemu.git/builds/system.threadsan/.=
./../util/qemu-thread-posix.c:71:11 (qemu-system-aarch64+0x19345d9) (BuildI=
d: 0bab171e77cb6782341ee3407e44af7267974025)
      #2 qemu_init_cpu_loop /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../system/cpus.c:423:5 (qemu-system-aarch64+0xccd145) (BuildId: 0bab17=
1e77cb6782341ee3407e44af7267974025)
      #3 qemu_init_subsystems /home/alex/lsrc/qemu.git/builds/system.thread=
san/../../system/runstate.c:825:5 (qemu-system-aarch64+0xce83a7) (BuildId: =
0bab171e77cb6782341ee3407e44af7267974025)
      #4 qemu_init /home/alex/lsrc/qemu.git/builds/system.threadsan/../../s=
ystem/vl.c:2795:5 (qemu-system-aarch64+0xcea0f3) (BuildId: 0bab171e77cb6782=
341ee3407e44af7267974025)
      #5 main /home/alex/lsrc/qemu.git/builds/system.threadsan/../../system=
/main.c:47:5 (qemu-system-aarch64+0x1583c78) (BuildId: 0bab171e77cb6782341e=
e3407e44af7267974025)

    Thread T3 'CPU 0/TCG' (tid=3D1751259, running) created by main thread a=
t:
      #0 pthread_create <null> (qemu-system-aarch64+0x415c6d) (BuildId: 0ba=
b171e77cb6782341ee3407e44af7267974025)
      #1 qemu_thread_create /home/alex/lsrc/qemu.git/builds/system.threadsa=
n/../../util/qemu-thread-posix.c:581:11 (qemu-system-aarch64+0x193619b) (Bu=
ildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #2 mttcg_start_vcpu_thread /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../accel/tcg/tcg-accel-ops-mttcg.c:144:5 (qemu-system-aarch64+0x1=
57b940) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #3 qemu_init_vcpu /home/alex/lsrc/qemu.git/builds/system.threadsan/..=
/../system/cpus.c:680:5 (qemu-system-aarch64+0xcce7a0) (BuildId: 0bab171e77=
cb6782341ee3407e44af7267974025)
      #4 arm_cpu_realizefn /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../target/arm/cpu.c:2588:5 (qemu-system-aarch64+0xfd9023) (BuildId: 0ba=
b171e77cb6782341ee3407e44af7267974025)
      #5 device_set_realized /home/alex/lsrc/qemu.git/builds/system.threads=
an/../../hw/core/qdev.c:510:13 (qemu-system-aarch64+0x158e205) (BuildId: 0b=
ab171e77cb6782341ee3407e44af7267974025)
      #6 property_set_bool /home/alex/lsrc/qemu.git/builds/system.threadsan=
/../../qom/object.c:2354:5 (qemu-system-aarch64+0x159dffb) (BuildId: 0bab17=
1e77cb6782341ee3407e44af7267974025)
      #7 object_property_set /home/alex/lsrc/qemu.git/builds/system.threads=
an/../../qom/object.c:1463:5 (qemu-system-aarch64+0x159a6a7) (BuildId: 0bab=
171e77cb6782341ee3407e44af7267974025)
      #8 object_property_set_qobject /home/alex/lsrc/qemu.git/builds/system=
.threadsan/../../qom/qom-qobject.c:28:10 (qemu-system-aarch64+0x15a35e2) (B=
uildId: 0bab171e77cb6782341ee3407e44af7267974025)
      #9 object_property_set_bool /home/alex/lsrc/qemu.git/builds/system.th=
readsan/../../qom/object.c:1533:15 (qemu-system-aarch64+0x159b00e) (BuildId=
: 0bab171e77cb6782341ee3407e44af7267974025)
      #10 qdev_realize /home/alex/lsrc/qemu.git/builds/system.threadsan/../=
../hw/core/qdev.c:291:12 (qemu-system-aarch64+0x158b989) (BuildId: 0bab171e=
77cb6782341ee3407e44af7267974025)
      #11 machvirt_init /home/alex/lsrc/qemu.git/builds/system.threadsan/..=
/../hw/arm/virt.c:2295:9 (qemu-system-aarch64+0xef0028) (BuildId: 0bab171e7=
7cb6782341ee3407e44af7267974025)
      #12 machine_run_board_init /home/alex/lsrc/qemu.git/builds/system.thr=
eadsan/../../hw/core/machine.c:1583:5 (qemu-system-aarch64+0x607380) (Build=
Id: 0bab171e77cb6782341ee3407e44af7267974025)
      #13 qemu_init_board /home/alex/lsrc/qemu.git/builds/system.threadsan/=
../../system/vl.c:2621:5 (qemu-system-aarch64+0xce9b30) (BuildId: 0bab171e7=
7cb6782341ee3407e44af7267974025)
      #14 qmp_x_exit_preconfig /home/alex/lsrc/qemu.git/builds/system.threa=
dsan/../../system/vl.c:2713:5 (qemu-system-aarch64+0xce98df) (BuildId: 0bab=
171e77cb6782341ee3407e44af7267974025)
      #15 qemu_init /home/alex/lsrc/qemu.git/builds/system.threadsan/../../=
system/vl.c:3759:9 (qemu-system-aarch64+0xced7ca) (BuildId: 0bab171e77cb678=
2341ee3407e44af7267974025)
      #16 main /home/alex/lsrc/qemu.git/builds/system.threadsan/../../syste=
m/main.c:47:5 (qemu-system-aarch64+0x1583c78) (BuildId: 0bab171e77cb6782341=
ee3407e44af7267974025)

  SUMMARY: ThreadSanitizer: data race (/home/alex/lsrc/qemu.git/builds/syst=
em.threadsan/qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77cb6782341ee3=
407e44af7267974025) in __interceptor_memcpy

This could be a false positive or it could be a race between the guest
kernel clearing memory while we are still doing
virtio_gpu_ctrl_response.

What do you think?


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
>
>
> Changes from V13 to V14
>
> - Fixed erronous fall-through in renderer_state's switch-case that was
>   spotted by Marc-Andr=C3=A9 Lureau.
>
> - Reworked HOSTMEM_MR_FINISH_UNMAPPING handling as was suggested by
>   Akihiko Odaki. Now it shares the same code path with HOSTMEM_MR_MAPPED.
>
> - Made use of g_autofree in virgl_cmd_resource_create_blob() as was
>   suggested by Akihiko Odaki.
>
> - Removed virtio_gpu_virgl_deinit() and moved all deinit code to
>   virtio_gpu_gl_device_unrealize() as was suggested by Marc-Andr=C3=A9 Lu=
reau.
>
> - Replaced HAVE_FEATURE in mseon.build with virglrenderer's VERSION_MAJOR
>   check as was suggested by Marc-Andr=C3=A9 Lureau.
>
> - Added trace event for cmd-suspension as was suggested by Marc-Andr=C3=
=A9 Lureau.
>
> - Added patch to replace in-flight printf's with trace events as was
>   suggested by Marc-Andr=C3=A9 Lureau
>
> Changes from V12 to V13
>
> - Replaced `res->async_unmap_in_progress` flag with a mapping state,
>   moved it to the virtio_gpu_virgl_hostmem_region like was suggested
>   by Akihiko Odaki.
>
> - Renamed blob_unmap function and added back cmd_suspended argument
>   to it. Suggested by Akihiko Odaki.
>
> - Reordered VirtIOGPUGL refactoring patches to minimize code changes
>   like was suggested by Akihiko Odaki.
>
> - Replaced gl->renderer_inited with gl->renderer_state, like was suggested
>   by Alex Benn=C3=A9e.
>
> - Added gl->renderer state resetting to gl_device_unrealize(), for
>   consistency. Suggested by Alex Benn=C3=A9e.
>
> - Added rb's from Alex and Manos.
>
> - Fixed compiling with !HAVE_VIRGL_RESOURCE_BLOB.
>
> Changes from V11 to V12
>
> - Fixed virgl_cmd_resource_create_blob() error handling. Now it doesn't
>   corrupt resource list and releases resource properly on error. Thanks
>   to Akihiko Odaki for spotting the bug.
>
> - Added new patch that handles virtio_gpu_virgl_init() failure gracefully,
>   fixing Qemu crash. Besides fixing the crash, it allows to implement
>   a cleaner virtio_gpu_virgl_deinit().
>
> - virtio_gpu_virgl_deinit() now assumes that previously virgl was
>   initialized successfully when it was inited at all. Suggested by
>   Akihiko Odaki.
>
> - Fixed missed freeing of print_stats timer in virtio_gpu_virgl_deinit()
>
> - Added back blob unmapping or RESOURCE_UNREF that was requested
>   by Akihiko Odaki. Added comment to the code explaining how
>   async unmapping works. Added back `res->async_unmap_in_progress`
>   flag and added comment telling why it's needed.
>
> - Moved cmdq_resume_bh to VirtIOGPUGL and made coding style changes
>   suggested by Akihiko Odaki.
>
> - Added patches that move fence_poll and print_stats timers to VirtIOGPUGL
>   for consistency with cmdq_resume_bh.
>
> Changes from V10 to V11
>
> - Replaced cmd_resume bool in struct ctrl_command with
>   "cmd->finished + !VIRTIO_GPU_FLAG_FENCE" checking as was requested
>   by Akihiko Odaki.
>
> - Reworked virgl_cmd_resource_unmap/unref_blob() to avoid re-adding
>   the 'async_unmap_in_progress' flag that was dropped in v9:
>
>     1. virgl_cmd_resource_[un]map_blob() now doesn't check itself whether
>        resource was previously mapped and lets virglrenderer to do the
>        checking.
>
>     2. error returned by virgl_renderer_resource_unmap() is now handled
>        and reported properly, previously the error wasn't checked. The
>        virgl_renderer_resource_unmap() fails if resource wasn't mapped.
>
>     3. virgl_cmd_resource_unref_blob() now doesn't allow to unref resource
>        that is mapped, it's a error condition if guest didn't unmap resou=
rce
>        before doing the unref. Previously unref was implicitly unmapping
>        resource.
>
> Changes from V9 to V10
>
> - Dropped 'async_unmap_in_progress' variable and switched to use
>   aio_bh_new() isntead of oneshot variant in the "blob commands" patch.
>
> - Further improved error messages by printing error code when actual error
>   occurrs and using ERR_UNSPEC instead of ERR_ENOMEM when we don't really
>   know if it was ENOMEM for sure.
>
> - Added vdc->unrealize for the virtio GL device and freed virgl data.
>
> - Dropped UUID and doc/migration patches. UUID feature isn't needed
>   anymore, instead we changed Mesa Venus driver to not require UUID.
>
> - Renamed virtio-gpu-gl "vulkan" property name back to "venus".
>
> Changes from V8 to V9
>
> - Added resuming of cmdq processing when hostmem MR is freed,
>   as was suggested by Akihiko Odaki.
>
> - Added more error messages, suggested by Akihiko Odaki
>
> - Dropped superfluous 'res->async_unmap_completed', suggested
>   by Akihiko Odaki.
>
> - Kept using cmd->suspended flag. Akihiko Odaki suggested to make
>   virtio_gpu_virgl_process_cmd() return false if cmd processing is
>   suspended, but it's not easy to implement due to ubiquitous
>   VIRTIO_GPU_FILL_CMD() macros that returns void, requiring to change
>   all the virtio-gpu processing code.
>
> - Added back virtio_gpu_virgl_resource as was requested by Akihiko Odaki,
>   though I'm not convinced it's really needed.
>
> - Switched to use GArray, renamed capset2_max_ver/size vars and moved
>   "vulkan" property definition to the virtio-gpu-gl device in the Venus
>   patch, like was suggested by Akihiko Odaki.
>
> - Moved UUID to virtio_gpu_virgl_resource and dropped UUID save/restore
>   since it will require bumping VM version and virgl device isn't miratab=
le
>   anyways.
>
> - Fixed exposing UUID feature with Rutabaga
>
> - Dropped linux-headers update patch because headers were already updated
>   in Qemu/staging.
>
> - Added patch that updates virtio migration doc with a note about virtio-=
gpu
>   migration specifics, suggested by Akihiko Odaki.
>
> - Addressed coding style issue noticed by Akihiko Odaki
>
> Changes from V7 to V8
>
> - Supported suspension of virtio-gpu commands processing and made
>   unmapping of hostmem region asynchronous by blocking/suspending
>   cmd processing until region is unmapped. Suggested by Akihiko Odaki.
>
> - Fixed arm64 building of x86 targets using updated linux-headers.
>   Corrected the update script. Thanks to Rob Clark for reporting
>   the issue.
>
> - Added new patch that makes registration of virgl capsets dynamic.
>   Requested by Antonio Caggiano and Pierre-Eric Pelloux-Prayer.
>
> - Venus capset now isn't advertised if Vulkan is disabled with vulkan=3Df=
alse
>
> Changes from V6 to V7
>
> - Used scripts/update-linux-headers.sh to update Qemu headers based
>   on Linux v6.8-rc3 that adds Venus capset definition to virtio-gpu
>   protocol, was requested by Peter Maydel
>
> - Added r-bs that were given to v6 patches. Corrected missing s-o-bs
>
> - Dropped context_init Qemu's virtio-gpu device configuration flag,
>   was suggested by Marc-Andr=C3=A9 Lureau
>
> - Added missing error condition checks spotted by Marc-Andr=C3=A9 Lureau
>   and Akihiko Odaki, and few more
>
> - Returned back res->mr referencing to memory_region_init_ram_ptr() like
>   was suggested by Akihiko Odaki. Incorporated fix suggested by Pierre-Er=
ic
>   to specify the MR name
>
> - Dropped the virgl_gpu_resource wrapper, cleaned up and simplified
>   patch that adds blob-cmd support
>
> - Fixed improper blob resource removal from resource list on resource_unr=
ef
>   that was spotted by Akihiko Odaki
>
> - Change order of the blob patches, was suggested by Akihiko Odaki.
>   The cmd_set_scanout_blob support is enabled first
>
> - Factored out patch that adds resource management support to virtio-gpu-=
gl,
>   was requested by Marc-Andr=C3=A9 Lureau
>
> - Simplified and improved the UUID support patch, dropped the hash table
>   as we don't need it for now. Moved QemuUUID to virtio_gpu_simple_resour=
ce.
>   This all was suggested by Akihiko Odaki and Marc-Andr=C3=A9 Lureau
>
> - Dropped console_has_gl() check, suggested by Akihiko Odaki
>
> - Reworked Meson cheking of libvirglrender features, made new features
>   available based on virglrender pkgconfig version instead of checking
>   symbols in header. This should fix build error using older virglrender
>   version, reported by Alex Benn=C3=A9e
>
> - Made enabling of Venus context configrable via new virtio-gpu device
>   "vulkan=3Dtrue" flag, suggested by Marc-Andr=C3=A9 Lureau. The flag is =
disabled
>   by default because it requires blob and hostmem options to be enabled
>   and configured
>
> Changes from V5 to V6
>
> - Move macros configurations under virgl.found() and rename
>   HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.
>
> - Handle the case while context_init is disabled.
>
> - Enable context_init by default.
>
> - Move virtio_gpu_virgl_resource_unmap() into
>   virgl_cmd_resource_unmap_blob().
>
> - Introduce new struct virgl_gpu_resource to store virgl specific members.
>
> - Remove erro handling of g_new0, because glib will abort() on OOM.
>
> - Set resource uuid as option.
>
> - Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state
>   for virtio live migration.
>
> - Use g_int_hash/g_int_equal instead of the default
>
> - Add scanout_blob function for virtio-gpu-virgl
>
> - Resolve the memory leak on virtio-gpu-virgl
>
> - Remove the unstable API flags check because virglrenderer is already 1.0
>
> - Squash the render server flag support into "Initialize Venus"
>
> Changes from V4 (virtio gpu V4) to V5
>
> - Inverted patch 5 and 6 because we should configure
>   HAVE_VIRGL_CONTEXT_INIT firstly.
>
> - Validate owner of memory region to avoid slowing down DMA.
>
> - Use memory_region_init_ram_ptr() instead of
>   memory_region_init_ram_device_ptr().
>
> - Adjust sequence to allocate gpu resource before virglrender resource
>   creation
>
> - Add virtio migration handling for uuid.
>
> - Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS.
>   https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/
>
> - Add meson check to make sure unstable APIs defined from 0.9.0.
>
> Changes from V1 to V2 (virtio gpu V4)
>
> - Remove unused #include "hw/virtio/virtio-iommu.h"
>
> - Add a local function, called virgl_resource_destroy(), that is used
>   to release a vgpu resource on error paths and in resource_unref.
>
> - Remove virtio_gpu_virgl_resource_unmap from
>   virtio_gpu_cleanup_mapping(),
>   since this function won't be called on blob resources and also because
>   blob resources are unmapped via virgl_cmd_resource_unmap_blob().
>
> - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>   and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>   has been fully initialized.
>
> - Memory region has a different life-cycle from virtio gpu resources
>   i.e. cannot be released synchronously along with the vgpu resource.
>   So, here the field "region" was changed to a pointer and is allocated
>   dynamically when the blob is mapped.
>   Also, since the pointer can be used to indicate whether the blob
>   is mapped, the explicite field "mapped" was removed.
>
> - In virgl_cmd_resource_map_blob(), add check on the value of
>   res->region, to prevent beeing called twice on the same resource.
>
> - Add a patch to enable automatic deallocation of memory regions to resol=
ve
>   use-after-free memory corruption with a reference.
>
>
> Antonio Caggiano (2):
>   virtio-gpu: Handle resource blob commands
>   virtio-gpu: Support Venus context
>
> Dmitry Osipenko (8):
>   virtio-gpu: Use trace events for tracking number of in-flight fences
>   virtio-gpu: Move fence_poll timer to VirtIOGPUGL
>   virtio-gpu: Move print_stats timer to VirtIOGPUGL
>   virtio-gpu: Handle virtio_gpu_virgl_init() failure
>   virtio-gpu: Unrealize GL device
>   virtio-gpu: Use pkgconfig version to decide which virgl features are
>     available
>   virtio-gpu: Don't require udmabuf when blobs and virgl are enabled
>   virtio-gpu: Support suspension of commands processing
>
> Huang Rui (2):
>   virtio-gpu: Support context-init feature with virglrenderer
>   virtio-gpu: Add virgl resource management
>
> Pierre-Eric Pelloux-Prayer (1):
>   virtio-gpu: Register capsets dynamically
>
> Robert Beckett (1):
>   virtio-gpu: Support blob scanout using dmabuf fd
>
>  hw/display/trace-events        |   3 +
>  hw/display/virtio-gpu-gl.c     |  62 +++-
>  hw/display/virtio-gpu-virgl.c  | 589 +++++++++++++++++++++++++++++++--
>  hw/display/virtio-gpu.c        |  44 ++-
>  include/hw/virtio/virtio-gpu.h |  32 +-
>  meson.build                    |   5 +-
>  6 files changed, 678 insertions(+), 57 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

