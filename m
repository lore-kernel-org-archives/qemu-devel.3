Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0B4C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Nlh-0005fp-JT; Fri, 10 May 2024 06:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s5NlW-0005dx-P6
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:46:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s5NlU-0000xP-UP
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:46:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0508so10822125e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715337966; x=1715942766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KgJOnQwl9JhI5CyhmJ0xRwMDn0YiGrrAK3h5qtdYD98=;
 b=Bav9KA+EvR9j8Ke2p16WmdtHZ5YFL3yURewryGbh24WVjCzMBg9DedSHuzyle0wMpf
 0mlYauPD7WqP7gIHMh5iTpV7fC+SCBxz7HlvNvFmnOMOGkoY3CnOxmfy8pU50Bj1i/sx
 zhBmBzOSrxa1SuCLMQrLVdeDXLuwrLFSDsf8XefkElPmqzvBKbdCBhcghEbtIgMPgJdH
 qW9etMtzhaZcbteAGt6N7+lGczbNvP8V9I77n11Mbr6fVd5j8sDi0ELb8EJeZI7sy4tQ
 6IAAJLjEW3LCRxkFMEXMSDi/c4wy1d9n0nDDPU1/qUwmbJDV4Zue/u/64CvzcOFRWbEz
 QoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715337966; x=1715942766;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgJOnQwl9JhI5CyhmJ0xRwMDn0YiGrrAK3h5qtdYD98=;
 b=Ul7b56KhE0ocipHBbAxmlL1QwWlru4vo7weDZxyzgNpYrZLOZ6EjcSp+oTlvzBeZLc
 K8UCrZW8j3BeFs57cXrweApv847LtZ43kHclTT3o3eiZl0sqJ2e5kAlkgGJNQ+ny4OxS
 JfWFwbfEz8y5vzsx16+Gy9Ze5PdUtogNxx9175CxGviKeosuAduG2sVhur5o8+5f8MRg
 uZybP7Su24PMQo1Lio5jdN+2D0+1R8vd7+HGt3jqmIjdKYWRY8HNE0WoXJkC5YtKp6CT
 vS1kXtk6EfdEfgNZAxmQGvGZmwPJKOWCaSAecYIQs+dgf2MHMFoocwg9t/cVN6jIRavv
 xtWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCrkI5E+boaurGd3WwqpWE1SYahCK4FYpFDvdw3YU0Zu9BDr0uSSyw8WubVt8s2rdzwtnvdFIjOLVC35Xp5W+0eJy4xMg=
X-Gm-Message-State: AOJu0YwMEWaopTOWwhVbCN3IlTB+7QUIMeQT06kiJ4VmWObIRxoVt96X
 i1un9GPyS+xrVOMvYkjzp/WO/UCo3XUHgUwV9m9wUd73yd073zsTqUYBqaVZdeA=
X-Google-Smtp-Source: AGHT+IH8102WNxixY+OfuJkHZm6t/+sAI+xJ4Od9FoRl/2OhITMpxLx9ktkiQWNs6mQK/J6CgNaW9A==
X-Received: by 2002:a05:600c:4fcd:b0:41c:2931:e670 with SMTP id
 5b1f17b1804b1-41fea9320acmr16543495e9.2.1715337965620; 
 Fri, 10 May 2024 03:46:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a1dsm4204862f8f.32.2024.05.10.03.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 03:46:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9026F5F88D;
 Fri, 10 May 2024 11:46:04 +0100 (BST)
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
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v8 01/11] linux-headers: Update to Linux v6.9-rc3
In-Reply-To: <20240418190040.1110210-2-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Thu, 18 Apr 2024 22:00:30 +0300")
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-2-dmitry.osipenko@collabora.com>
Date: Fri, 10 May 2024 11:46:04 +0100
Message-ID: <87wmo2j66r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> Update kernel headers to get new VirtIO-GPU capsets, in particular the
> Venus capset.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/i386/x86.c                                 |   8 -
>  include/standard-headers/asm-x86/bootparam.h  |  17 +-
>  include/standard-headers/asm-x86/kvm_para.h   |   3 +-
>  include/standard-headers/asm-x86/setup_data.h |  83 +++
>  include/standard-headers/linux/ethtool.h      |  48 ++
>  include/standard-headers/linux/fuse.h         |  39 +-
>  .../linux/input-event-codes.h                 |   1 +
>  include/standard-headers/linux/virtio_gpu.h   |   2 +
>  include/standard-headers/linux/virtio_pci.h   |  10 +-
>  include/standard-headers/linux/virtio_snd.h   | 154 ++++
>  linux-headers/asm-arm64/kvm.h                 |  15 +-
>  linux-headers/asm-arm64/sve_context.h         |  11 +
>  linux-headers/asm-generic/bitsperlong.h       |   4 +
>  linux-headers/asm-loongarch/kvm.h             |   2 -
>  linux-headers/asm-mips/kvm.h                  |   2 -
>  linux-headers/asm-powerpc/kvm.h               |  45 +-
>  linux-headers/asm-riscv/kvm.h                 |   3 +-
>  linux-headers/asm-s390/kvm.h                  | 315 +++++++-
>  linux-headers/asm-x86/kvm.h                   | 308 +++++++-
>  linux-headers/linux/bits.h                    |  15 +
>  linux-headers/linux/kvm.h                     | 689 +-----------------
>  linux-headers/linux/psp-sev.h                 |  59 ++
>  linux-headers/linux/vhost.h                   |   7 +
>  scripts/update-linux-headers.sh               |   5 +-
>  24 files changed, 1106 insertions(+), 739 deletions(-)
>  create mode 100644 include/standard-headers/asm-x86/setup_data.h
>  create mode 100644 linux-headers/linux/bits.h
>
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index ffbda48917fd..84a48019770b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -679,14 +679,6 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_sta=
te)
>      return dev;
>  }
>=20=20
> -struct setup_data {
> -    uint64_t next;
> -    uint32_t type;
> -    uint32_t len;
> -    uint8_t data[];
> -} __attribute__((packed));
> -
> -

This isn't part of the header import. I'd rather see

  - import the current header set
  - update to the script
  - clean-ups and additions

why are we migrating to using the kernels non-uapi assembler headers?

<snip>
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -62,6 +62,7 @@ cp_portable() {
>                                       -e 'linux/kernel' \
>                                       -e 'linux/sysinfo' \
>                                       -e 'asm-generic/kvm_para' \
> +                                     -e 'asm-x86/setup_data.h' \

some justification for this/

>                                       > /dev/null
>      then
>          echo "Unexpected #include in input file $f".
> @@ -149,9 +150,11 @@ for arch in $ARCHLIST; do
>          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm=
-x86/"
>          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-=
x86/"
>          cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/st=
andard-headers/asm-$arch"
> +        cp_portable "$tmpdir/include/asm/setup_data.h" "$output/include/=
standard-headers/asm-$arch"

is there a portable setup_data.h? why is it asm-x86 above?

>          # Remove everything except the macros from bootparam.h avoiding =
the
>          # unnecessary import of several video/ist/etc headers
>          sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
> +            -e 's/<asm\/\([^>]*\)>/"standard-headers\/asm-x86\/\1"/' \
>                 "$tmpdir/include/asm/bootparam.h" > "$tmpdir/bootparam.h"
>          cp_portable "$tmpdir/bootparam.h" \
>                      "$output/include/standard-headers/asm-$arch"
> @@ -165,7 +168,7 @@ rm -rf "$output/linux-headers/linux"
>  mkdir -p "$output/linux-headers/linux"
>  for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost=
.h \
>                psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h=
 \
> -              vduse.h iommufd.h; do
> +              vduse.h iommufd.h bits.h; do

What do we need bits for here?=20

>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

