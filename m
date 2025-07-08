Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61810C83F10
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFM1-0006gY-DV; Tue, 08 Jul 2025 16:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEbP-0006z2-NT
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:07:47 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEbL-0004cG-PX
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:07:43 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ade5b8aab41so1007355366b.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752005257; x=1752610057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4XBodQSROD8wkglC7LQNsiAxFO/V5HnbCa2RbyfuTVw=;
 b=Vl7u4v6Z2bZpbnfe9v1OzWUBCoEUyhJKm41hXZvcIUs6GzSqP+QadDOvF3YvMcL/g8
 ZU+OUl3dsria83Qm7LEo85r/X1vSxHWlx5VtCd2921Z3YreD7OUZFxs12WafCQYSL6kE
 uES3Nj7Rm4bxd2BCcusnV1WFx9LrDvq2AwomyoD/lnGwKSt7wJ7+kERHFacOOjpwfdxA
 gQ59OPEzgR0Mc7xOVoZWDZG2ov2eqATsLFC0hN3BAAvCTHUJ7wtLK3tNr4oPUjjOGQtl
 JHRDVE9w7h3nbJoqQh7J8n7uoQcBQKrMJvkXEnD2m5rRv90co9RQvPJij0zgo9ZeIsRI
 hxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005257; x=1752610057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4XBodQSROD8wkglC7LQNsiAxFO/V5HnbCa2RbyfuTVw=;
 b=rvmMjSyaxJ4xCLPopEmD6VXx+zigblfmdSMjskLTDU6QhqrQz03uBX3YDvA7BiUaIE
 yDmRW/GMvN5oOQdHvHYuHOwyFfzkxlqgY7x0j23My06nv0sNCCosNagrR2GFyPA4pBQd
 mgSuXfunBo8fg848TmkjopCjoZBT0BFqwh50k3bqAh85y/aOHPKecBC67vZbt8u7HyAP
 kGjgpzz47Iy3U5UwEXMlPayzM6Q7crzm4iotSWu8G45gRGQErNFt3uLUB59Y7SWHHosf
 WcYQaMUbklTg7j+EmkwqAZZ6oEHb+p2x4zgkwHiR15Jz0rjzLg/VxtYUT5hqDtBtNg3w
 lQyw==
X-Gm-Message-State: AOJu0Yzrpd9fAW19jqU9eZj0S82+RNLQFpw9xMiNldtEyK/vV4Z/kl7v
 bOrcdDpV55VP5w15Ircgh8wWzEvIEApJaPy23LQrdKyEgCFpUar9o7XzZGS/ukyfq9TaoFpg1kS
 JiPNYd4U=
X-Gm-Gg: ASbGncv4hx9fSL1DVhDBkWFj13e9tfO1PjC0rrhstYiL87q/ZMABFcqVZh7W6aRCttE
 51GmYm3U10GToiQYuG/AkhxbiwlfrMJFEPQDcIxINeFq7m7boIOD18ndihMe7lNHCsFlWGMrHZo
 v/T67+0vltpiMQYCzNtUyYtGvWIL9OsWvZ8qv0AawPRpqONjzRrU47QpDhOCIYe8ufnvphUn4zn
 j6LWoRajbMEc+dr9wE+Dv+tkdP4VD0J+KEw4k3QcgD2KcnZB3KZdUhWmeRzFEDSPefz0W5tteSV
 0fKnxWce+Y2jN8Oez/hmZd+KHJOQgxXgVvHyJVObcsg9rosGAumXn4buELTeXC1pgL5oHhAnJ05
 yBtVZqhicNw0IAdY383uoa57XZiagow==
X-Google-Smtp-Source: AGHT+IFYrA0gK6QeZ2HxMQl3p/ZUhSkytREMZ1X9mDDfs8B1Np5M4o/aiK8fRXsF3TIg/X2pS/+SjQ==
X-Received: by 2002:a05:6000:2b0e:b0:3b5:dfc2:f0ca with SMTP id
 ffacd0b85a97d-3b5dfc2f414mr843121f8f.40.1751969863893; 
 Tue, 08 Jul 2025 03:17:43 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0a5csm12387002f8f.29.2025.07.08.03.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 03:17:43 -0700 (PDT)
Message-ID: <64700490-e94b-405e-92cf-2ffc25537aea@linaro.org>
Date: Tue, 8 Jul 2025 12:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v6 09/14] hw/virtio: Build various files once
To: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-10-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707172009.3884-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(Forgot to Cc Manos)

On 7/7/25 19:20, Philippe Mathieu-Daudé wrote:
> Now than various VirtIO files don't use target specific
> API anymore, we can move them to the system_ss[] source
> set to build them once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-config-io.c |  1 -
>   hw/block/meson.build         |  6 ++++--
>   hw/virtio/meson.build        | 20 +++++++++++---------
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/virtio/virtio-config-io.c b/hw/virtio/virtio-config-io.c
> index ad78e0b9bc5..f58d90b6e31 100644
> --- a/hw/virtio/virtio-config-io.c
> +++ b/hw/virtio/virtio-config-io.c
> @@ -11,7 +11,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/virtio/virtio.h"
> -#include "cpu.h"
>   
>   uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr)
>   {
> diff --git a/hw/block/meson.build b/hw/block/meson.build
> index 655704471a5..43ed296cf47 100644
> --- a/hw/block/meson.build
> +++ b/hw/block/meson.build
> @@ -13,7 +13,9 @@ system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
>   system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
>   system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
>   
> -specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c', 'virtio-blk-common.c'))
> -specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c', 'virtio-blk-common.c'))
> +specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
> +system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-common.c'))
> +specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
> +system_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('virtio-blk-common.c'))
>   
>   subdir('dataplane')
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 164f6fd995a..3ea7b3cec83 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -1,6 +1,7 @@
>   system_virtio_ss = ss.source_set()
>   system_virtio_ss.add(files('virtio-bus.c'))
>   system_virtio_ss.add(files('iothread-vq-mapping.c'))
> +system_virtio_ss.add(files('virtio-config-io.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
> @@ -10,11 +11,11 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c')
>   
>   specific_virtio_ss = ss.source_set()
>   specific_virtio_ss.add(files('virtio.c'))
> -specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
> +specific_virtio_ss.add(files('virtio-qmp.c'))
>   
>   if have_vhost
>     system_virtio_ss.add(files('vhost.c'))
> -  specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
> +  system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
>     if have_vhost_user
>       # fixme - this really should be generic
>       specific_virtio_ss.add(files('vhost-user.c'))
> @@ -43,22 +44,22 @@ if have_vhost
>     endif
>     if have_vhost_vdpa
>       system_virtio_ss.add(files('vhost-vdpa.c'))
> -    specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
> +    system_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
>     endif
>   else
>     system_virtio_ss.add(files('vhost-stub.c'))
>   endif
> +system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
> +system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
>   
>   specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
>   specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
>   specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
>   specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm.c', 'cbor-helpers.c'), libcbor])
>   specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
> -specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
> +system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
> +system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
> +system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
>   
>   virtio_pci_ss = ss.source_set()
>   virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
> @@ -67,6 +68,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-
>   virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi-pci.c'))
>   
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
> @@ -85,7 +87,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
>   virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
>   
> -specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
> +system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>   
>   system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))


