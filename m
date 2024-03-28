Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A473C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpkYW-0004GB-EJ; Thu, 28 Mar 2024 03:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpkYS-0004Fn-Cr
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpkYJ-0001jQ-Bc
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711612318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnXIGHo0LKnJakpBXgm5AxbaO8nMeQLtshiGWxdO7uM=;
 b=QL2W79pwOijKSECp2Hc2/emFdnxmc8DYWb0DuaxYGBQr9qDJp1og+gV66jqHDUZ8IkdnMi
 CQF4Znz9xT2WL1cNeevT33n9GaKshcrQoWM6+YvQyN+cDJ2YK+5RPuQi0OdeW6Aw1qKxuU
 S/MgblFP399e7xmoZEkk1Xo2XO2AH6o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-wuYagLjRO8OxqnmlXwR_fA-1; Thu, 28 Mar 2024 03:51:49 -0400
X-MC-Unique: wuYagLjRO8OxqnmlXwR_fA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ec6c43a9cso510799f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 00:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711612309; x=1712217109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnXIGHo0LKnJakpBXgm5AxbaO8nMeQLtshiGWxdO7uM=;
 b=eEwS00yoONzW6ZzWLj/o8qWyqhiON/Rawp7kS9MlzZVIYQPtWsJMIVJ6aeO3dsEPHW
 yOU9zlMNrYnVftRlzz2xSozflHw49vxvlpyHrt1ckQsoju7wfma2zDrKlmy9O5z6nAeZ
 DSpg10I5dTtkGrdrsNoqKuA4GMptvP5cYvgtpAhRCMqRjB+AP0mYwEmi5n8prlw5kWTE
 vjbYle3K3/00Dy7/o16xel4exlrUfx1AZbaDT6hM+HmKbiuJLYPPMWBgC5h8QRdN5bJ7
 rCzzXdeGNT9gPNM742NvuQsxNhAzBWkLYFWbBPgBrMbaAoFgB9Kag5wsMleqjGZzLkkj
 wXJQ==
X-Gm-Message-State: AOJu0YzDIFaq2/wUBZGly6rAR6pAu6o6SzE6FIMHZ9vkGSvgyZQOCmlY
 Oz0IKNRFqsu6f/goupqi7Pz9GEenzfFO9oZpJgxIzFT1UeJGrmKTDgkY2QkdNqY50Iyq+ftT7NK
 KbsTZ/gsXPZ3ltw06mfEyibaX2YAJnVpT1JiAN7sjpeGL6SZEKGZVvFLNOlQI43pp3rRA36PM50
 FWq8fdhMarS62GoUmEFdAKCv3X0xc=
X-Received: by 2002:adf:a3d1:0:b0:33e:c677:3272 with SMTP id
 m17-20020adfa3d1000000b0033ec6773272mr2223906wrb.56.1711612308408; 
 Thu, 28 Mar 2024 00:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy/IXy55IZ4aJd3huEBlGFeQWDtv0q83TaqYqw23UiJ9eZ05jyAnf/CteJ51EjmreMVVmzp9HUIrpWaqWdE9c=
X-Received: by 2002:adf:a3d1:0:b0:33e:c677:3272 with SMTP id
 m17-20020adfa3d1000000b0033ec6773272mr2223849wrb.56.1711612307456; Thu, 28
 Mar 2024 00:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240327105549.1824-1-philmd@linaro.org>
In-Reply-To: <20240327105549.1824-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Mar 2024 08:51:34 +0100
Message-ID: <CABgObfbHAdDdO2g56u9+=ef12EsZmYXW-evb2sR+k7i7HwD5hA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1] rdma: Remove RDMA subsystem and pvrdma device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, integration@gluster.org, 
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, devel@lists.libvirt.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Song Gao <gaosong@loongson.cn>, 
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000094637e0614b3cbfb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NORMAL_HTTP_TO_IP=0.001, NUMERIC_HTTP_ADDR=1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--00000000000094637e0614b3cbfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 27 mar 2024, 11:56 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> The whole RDMA subsystem was deprecated in commit e9a54265f5
> ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> released in v8.2. Time to remove it.
>
> Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> in old migration streams.
>
> Remove the dependencies on libibumad and libibverbs.
>
> Remove the generated vmw_pvrdma/ directory from linux-headers.
>
> Remove RDMA handling from migration.
>
> Remove RDMA handling in GlusterFS block driver.
>

I don't think these two were deprecated? They are unrelated to pvrdma.

Paolo


> Remove rdmacm-mux tool from contrib/.
>
> Remove PVRDMA device.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS                                   |   17 -
>  docs/about/deprecated.rst                     |    9 -
>  docs/about/removed-features.rst               |    4 +
>  docs/devel/migration/main.rst                 |    6 -
>  docs/pvrdma.txt                               |  345 --
>  docs/rdma.txt                                 |  420 --
>  docs/system/device-url-syntax.rst.inc         |    4 +-
>  docs/system/loongarch/virt.rst                |    2 +-
>  docs/system/qemu-block-drivers.rst.inc        |    1 -
>  meson.build                                   |   59 -
>  qapi/machine.json                             |   17 -
>  qapi/migration.json                           |   31 +-
>  qapi/qapi-schema.json                         |    1 -
>  qapi/rdma.json                                |   38 -
>  contrib/rdmacm-mux/rdmacm-mux.h               |   61 -
>  hw/rdma/rdma_backend.h                        |  129 -
>  hw/rdma/rdma_backend_defs.h                   |   76 -
>  hw/rdma/rdma_rm.h                             |   97 -
>  hw/rdma/rdma_rm_defs.h                        |  146 -
>  hw/rdma/rdma_utils.h                          |   63 -
>  hw/rdma/trace.h                               |    1 -
>  hw/rdma/vmw/pvrdma.h                          |  144 -
>  hw/rdma/vmw/pvrdma_dev_ring.h                 |   46 -
>  hw/rdma/vmw/pvrdma_qp_ops.h                   |   28 -
>  hw/rdma/vmw/trace.h                           |    1 -
>  include/hw/rdma/rdma.h                        |   37 -
>  include/monitor/hmp.h                         |    1 -
>  .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  685 ---
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  348 --
>  .../standard-headers/rdma/vmw_pvrdma-abi.h    |  310 --
>  migration/migration-stats.h                   |    6 +-
>  migration/migration.h                         |    9 -
>  migration/options.h                           |    2 -
>  migration/rdma.h                              |   69 -
>  block/gluster.c                               |   39 -
>  contrib/rdmacm-mux/main.c                     |  831 ----
>  hw/core/machine-qmp-cmds.c                    |   32 -
>  hw/rdma/rdma.c                                |   30 -
>  hw/rdma/rdma_backend.c                        | 1401 ------
>  hw/rdma/rdma_rm.c                             |  812 ----
>  hw/rdma/rdma_utils.c                          |  126 -
>  hw/rdma/vmw/pvrdma_cmd.c                      |  815 ----
>  hw/rdma/vmw/pvrdma_dev_ring.c                 |  141 -
>  hw/rdma/vmw/pvrdma_main.c                     |  735 ---
>  hw/rdma/vmw/pvrdma_qp_ops.c                   |  298 --
>  migration/migration-stats.c                   |    5 +-
>  migration/migration.c                         |   31 -
>  migration/options.c                           |   16 -
>  migration/qemu-file.c                         |    1 -
>  migration/ram.c                               |   86 +-
>  migration/rdma.c                              | 4184 -----------------
>  migration/savevm.c                            |    2 +-
>  monitor/qmp-cmds.c                            |    1 -
>  Kconfig.host                                  |    3 -
>  contrib/rdmacm-mux/meson.build                |    7 -
>  hmp-commands-info.hx                          |   13 -
>  hw/Kconfig                                    |    1 -
>  hw/meson.build                                |    1 -
>  hw/rdma/Kconfig                               |    3 -
>  hw/rdma/meson.build                           |   12 -
>  hw/rdma/trace-events                          |   31 -
>  hw/rdma/vmw/trace-events                      |   17 -
>  meson_options.txt                             |    4 -
>  migration/meson.build                         |    1 -
>  migration/trace-events                        |   68 +-
>  qapi/meson.build                              |    1 -
>  qemu-options.hx                               |    6 -
>  .../ci/org.centos/stream/8/x86_64/configure   |    1 -
>  scripts/ci/setup/build-environment.yml        |    2 -
>  scripts/coverity-scan/run-coverity-scan       |    2 +-
>  scripts/meson-buildoptions.sh                 |    6 -
>  scripts/update-linux-headers.sh               |   27 -
>  tests/lcitool/projects/qemu.yml               |    2 -
>  tests/migration/guestperf/engine.py           |    4 +-
>  74 files changed, 20 insertions(+), 12991 deletions(-)
>  delete mode 100644 docs/pvrdma.txt
>  delete mode 100644 docs/rdma.txt
>  delete mode 100644 qapi/rdma.json
>  delete mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
>  delete mode 100644 hw/rdma/rdma_backend.h
>  delete mode 100644 hw/rdma/rdma_backend_defs.h
>  delete mode 100644 hw/rdma/rdma_rm.h
>  delete mode 100644 hw/rdma/rdma_rm_defs.h
>  delete mode 100644 hw/rdma/rdma_utils.h
>  delete mode 100644 hw/rdma/trace.h
>  delete mode 100644 hw/rdma/vmw/pvrdma.h
>  delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>  delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>  delete mode 100644 hw/rdma/vmw/trace.h
>  delete mode 100644 include/hw/rdma/rdma.h
>  delete mode 100644
> include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.=
h
>  delete mode 100644
> include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
>  delete mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h
>  delete mode 100644 migration/rdma.h
>  delete mode 100644 contrib/rdmacm-mux/main.c
>  delete mode 100644 hw/rdma/rdma.c
>  delete mode 100644 hw/rdma/rdma_backend.c
>  delete mode 100644 hw/rdma/rdma_rm.c
>  delete mode 100644 hw/rdma/rdma_utils.c
>  delete mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>  delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>  delete mode 100644 hw/rdma/vmw/pvrdma_main.c
>  delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>  delete mode 100644 migration/rdma.c
>  delete mode 100644 contrib/rdmacm-mux/meson.build
>  delete mode 100644 hw/rdma/Kconfig
>  delete mode 100644 hw/rdma/meson.build
>  delete mode 100644 hw/rdma/trace-events
>  delete mode 100644 hw/rdma/vmw/trace-events
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07af6b9d4..05226cea0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3426,13 +3426,6 @@ F: docs/devel/migration.rst
>  F: qapi/migration.json
>  F: tests/migration/
>  F: util/userfaultfd.c
> -X: migration/rdma*
> -
> -RDMA Migration
> -R: Li Zhijian <lizhijian@fujitsu.com>
> -R: Peter Xu <peterx@redhat.com>
> -S: Odd Fixes
> -F: migration/rdma*
>
>  Migration dirty limit and dirty page rate
>  M: Hyman Huang <yong.huang@smartx.com>
> @@ -4060,16 +4053,6 @@ F: block/replication.c
>  F: tests/unit/test-replication.c
>  F: docs/block-replication.txt
>
> -PVRDMA
> -M: Yuval Shaia <yuval.shaia.ml@gmail.com>
> -M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> -S: Odd Fixes
> -F: hw/rdma/*
> -F: hw/rdma/vmw/*
> -F: docs/pvrdma.txt
> -F: contrib/rdmacm-mux/*
> -F: qapi/rdma.json
> -
>  Semihosting
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  S: Maintained
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..29eae69e50 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -376,15 +376,6 @@ recommending to switch to their stable counterparts:
>  - "Zve64f" should be replaced with "zve64f"
>  - "Zve64d" should be replaced with "zve64d"
>
> -``-device pvrdma`` and the rdma subsystem (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The pvrdma device and the whole rdma subsystem are in a bad shape and
> -without active maintenance. The QEMU project intends to remove this
> -device and subsystem from the code base in a future release without
> -replacement unless somebody steps up and improves the situation.
> -
> -
>  Block device options
>  ''''''''''''''''''''
>
> diff --git a/docs/about/removed-features.rst
> b/docs/about/removed-features.rst
> index f9cf874f7b..4d5bdc43b4 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -909,6 +909,10 @@ contains native support for this feature and thus us=
e
> of the option
>  ROM approach was obsolete. The native SeaBIOS support can be activated
>  by using ``-machine graphics=3Doff``.
>
> +``pvrdma`` and the RDMA subsystem (removed in 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The 'pvrdma' device and the whole RDMA subsystem have been removed.
>
>  Related binaries
>  ----------------
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rs=
t
> index 54385a23e5..70278ce1e3 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -47,12 +47,6 @@ over any transport.
>    QEMU interference. Note that QEMU does not flush cached file
>    data/metadata at the end of migration.
>
> -In addition, support is included for migration using RDMA, which
> -transports the page data using ``RDMA``, where the hardware takes care o=
f
> -transporting the pages, and the load on the CPU is much lower.  While th=
e
> -internals of RDMA migration are a bit different, this isn't really visib=
le
> -outside the RAM migration code.
> -
>  All these migration protocols use the same infrastructure to
>  save/restore state devices.  This infrastructure is shared with the
>  savevm/loadvm functionality.
> diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
> deleted file mode 100644
> index 5c122fe818..0000000000
> --- a/docs/pvrdma.txt
> +++ /dev/null
> @@ -1,345 +0,0 @@
> -Paravirtualized RDMA Device (PVRDMA)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -
> -1. Description
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA devic=
e.
> -It works with its Linux Kernel driver AS IS, no need for any special gue=
st
> -modifications.
> -
> -While it complies with the VMware device, it can also communicate with
> bare
> -metal RDMA-enabled machines as peers.
> -
> -It does not require an RDMA HCA in the host, it can work with Soft-RoCE
> (rxe).
> -
> -It does not require the whole guest RAM to be pinned allowing memory
> -over-commit and, even if not implemented yet, migration support will be
> -possible with some HW assistance.
> -
> -A project presentation accompany this document:
> --
> https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4730/ori=
ginal/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
> -
> -
> -
> -2. Setup
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -
> -2.1 Guest setup
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Fedora 27+ kernels work out of the box, older distributions
> -require updating the kernel to 4.14 to include the pvrdma driver.
> -
> -However the libpvrdma library needed by User Level Software is still
> -not available as part of the distributions, so the rdma-core library
> -needs to be compiled and optionally installed.
> -
> -Please follow the instructions at:
> -  https://github.com/linux-rdma/rdma-core.git
> -
> -
> -2.2 Host Setup
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -The pvrdma backend is an ibdevice interface that can be exposed
> -either by a Soft-RoCE(rxe) device on machines with no RDMA device,
> -or an HCA SRIOV function(VF/PF).
> -Note that ibdevice interfaces can't be shared between pvrdma devices,
> -each one requiring a separate instance (rxe or SRIOV VF).
> -
> -
> -2.2.1 Soft-RoCE backend(rxe)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -A stable version of rxe is required, Fedora 27+ or a Linux
> -Kernel 4.14+ is preferred.
> -
> -The rdma_rxe module is part of the Linux Kernel but not loaded by defaul=
t.
> -Install the User Level library (librxe) following the instructions from:
> -https://github.com/SoftRoCE/rxe-dev/wiki/rxe-dev:-Home
> -
> -Associate an ETH interface with rxe by running:
> -   rxe_cfg add eth0
> -An rxe0 ibdevice interface will be created and can be used as pvrdma
> backend.
> -
> -
> -2.2.2 RDMA device Virtual Function backend
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Nothing special is required, the pvrdma device can work not only with
> -Ethernet Links, but also Infinibands Links.
> -All is needed is an ibdevice with an active port, for Mellanox cards
> -will be something like mlx5_6 which can be the backend.
> -
> -
> -2.2.3 QEMU setup
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Configure QEMU with --enable-rdma flag, installing
> -the required RDMA libraries.
> -
> -
> -
> -3. Usage
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -
> -3.1 VM Memory settings
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Currently the device is working only with memory backed RAM
> -and it must be mark as "shared":
> -   -m 1G \
> -   -object memory-backend-ram,id=3Dmb1,size=3D1G,share \
> -   -numa node,memdev=3Dmb1 \
> -
> -
> -3.2 MAD Multiplexer
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -MAD Multiplexer is a service that exposes MAD-like interface for VMs in
> -order to overcome the limitation where only single entity can register
> with
> -MAD layer to send and receive RDMA-CM MAD packets.
> -
> -To build rdmacm-mux run
> -# make rdmacm-mux
> -
> -Before running the rdmacm-mux make sure that both ib_cm and rdma_cm kern=
el
> -modules aren't loaded, otherwise the rdmacm-mux service will fail to
> start.
> -
> -The application accepts 3 command line arguments and exposes a UNIX sock=
et
> -to pass control and data to it.
> --d rdma-device-name  Name of RDMA device to register with
> --s unix-socket-path  Path to unix socket to listen (default
> /var/run/rdmacm-mux)
> --p rdma-device-port  Port number of RDMA device to register with (defaul=
t
> 1)
> -The final UNIX socket file name is a concatenation of the 3 arguments so
> -for example for device mlx5_0 on port 2 this /var/run/rdmacm-mux-mlx5_0-=
2
> -will be created.
> -
> -pvrdma requires this service.
> -
> -Please refer to contrib/rdmacm-mux for more details.
> -
> -
> -3.3 Service exposed by libvirt daemon
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -The control over the RDMA device's GID table is done by updating the
> -device's Ethernet function addresses.
> -Usually the first GID entry is determined by the MAC address, the second
> by
> -the first IPv6 address and the third by the IPv4 address. Other entries
> can
> -be added by adding more IP addresses. The opposite is the same, i.e.
> -whenever an address is removed, the corresponding GID entry is removed.
> -The process is done by the network and RDMA stacks. Whenever an address =
is
> -added the ib_core driver is notified and calls the device driver add_gid
> -function which in turn update the device.
> -To support this in pvrdma device the device hooks into the create_bind a=
nd
> -destroy_bind HW commands triggered by pvrdma driver in guest.
> -
> -Whenever changed is made to the pvrdma port's GID table a special QMP
> -messages is sent to be processed by libvirt to update the address of the
> -backend Ethernet device.
> -
> -pvrdma requires that libvirt service will be up.
> -
> -
> -3.4 PCI devices settings
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -RoCE device exposes two functions - an Ethernet and RDMA.
> -To support it, pvrdma device is composed of two PCI functions, an Ethern=
et
> -device of type vmxnet3 on PCI slot 0 and a PVRDMA device on PCI slot 1.
> The
> -Ethernet function can be used for other Ethernet purposes such as IP.
> -
> -
> -3.5 Device parameters
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -- netdev: Specifies the Ethernet device function name on the host for
> -  example enp175s0f0. For Soft-RoCE device (rxe) this would be the
> Ethernet
> -  device used to create it.
> -- ibdev: The IB device name on host for example rxe0, mlx5_0 etc.
> -- mad-chardev: The name of the MAD multiplexer char device.
> -- ibport: In case of multi-port device (such as Mellanox's HCA) this
> -  specify the port to use. If not set 1 will be used.
> -- dev-caps-max-mr-size: The maximum size of MR.
> -- dev-caps-max-qp:      Maximum number of QPs.
> -- dev-caps-max-cq:      Maximum number of CQs.
> -- dev-caps-max-mr:      Maximum number of MRs.
> -- dev-caps-max-pd:      Maximum number of PDs.
> -- dev-caps-max-ah:      Maximum number of AHs.
> -
> -Notes:
> -- The first 3 parameters are mandatory settings, the rest have their
> -  defaults.
> -- The last 8 parameters (the ones that prefixed by dev-caps) defines the
> top
> -  limits but the final values is adjusted by the backend device
> limitations.
> -- netdev can be extracted from ibdev's sysfs
> -  (/sys/class/infiniband/<ibdev>/device/net/)
> -
> -
> -3.6 Example
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Define bridge device with vmxnet3 network backend:
> -<interface type=3D'bridge'>
> -  <mac address=3D'56:b4:44:e9:62:dc'/>
> -  <source bridge=3D'bridge1'/>
> -  <model type=3D'vmxnet3'/>
> -  <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x10'
> function=3D'0x0' multifunction=3D'on'/>
> -</interface>
> -
> -Define pvrdma device:
> -<qemu:commandline>
> -  <qemu:arg value=3D'-object'/>
> -  <qemu:arg value=3D'memory-backend-ram,id=3Dmb1,size=3D1G,share'/>
> -  <qemu:arg value=3D'-numa'/>
> -  <qemu:arg value=3D'node,memdev=3Dmb1'/>
> -  <qemu:arg value=3D'-chardev'/>
> -  <qemu:arg value=3D'socket,path=3D/var/run/rdmacm-mux-rxe0-1,id=3Dmads'=
/>
> -  <qemu:arg value=3D'-device'/>
> -  <qemu:arg
> value=3D'pvrdma,addr=3D10.1,ibdev=3Drxe0,netdev=3Dbridge0,mad-chardev=3Dm=
ads'/>
> -</qemu:commandline>
> -
> -
> -
> -4. Implementation details
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -
> -
> -4.1 Overview
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -The device acts like a proxy between the Guest Driver and the host
> -ibdevice interface.
> -On configuration path:
> - - For every hardware resource request (PD/QP/CQ/...) the pvrdma will
> request
> -   a resource from the backend interface, maintaining a 1-1 mapping
> -   between the guest and host.
> -On data path:
> - - Every post_send/receive received from the guest will be converted int=
o
> -   a post_send/receive for the backend. The buffers data will not be
> touched
> -   or copied resulting in near bare-metal performance for large enough
> buffers.
> - - Completions from the backend interface will result in completions for
> -   the pvrdma device.
> -
> -
> -4.2 PCI BARs
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -PCI Bars:
> -       BAR 0 - MSI-X
> -        MSI-X vectors:
> -               (0) Command - used when execution of a command is
> completed.
> -               (1) Async - not in use.
> -               (2) Completion - used when a completion event is placed i=
n
> -                 device's CQ ring.
> -       BAR 1 - Registers
> -        --------------------------------------------------------
> -        | VERSION |  DSR | CTL | REQ | ERR |  ICR | IMR  | MAC |
> -        --------------------------------------------------------
> -               DSR - Address of driver/device shared memory used
> -              for the command channel, used for passing:
> -                           - General info such as driver version
> -                           - Address of 'command' and 'response'
> -                           - Address of async ring
> -                           - Address of device's CQ ring
> -                           - Device capabilities
> -               CTL - Device control operations (activate, reset etc)
> -               IMG - Set interrupt mask
> -               REQ - Command execution register
> -               ERR - Operation status
> -
> -       BAR 2 - UAR
> -        ---------------------------------------------------------
> -        | QP_NUM  | SEND/RECV Flag ||  CQ_NUM |   ARM/POLL Flag |
> -        ---------------------------------------------------------
> -               - Offset 0 used for QP operations (send and recv)
> -               - Offset 4 used for CQ operations (arm and poll)
> -
> -
> -4.3 Major flows
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -4.3.1 Create CQ
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    - Guest driver
> -        - Allocates pages for CQ ring
> -        - Creates page directory (pdir) to hold CQ ring's pages
> -        - Initializes CQ ring
> -        - Initializes 'Create CQ' command object (cqe, pdir etc)
> -        - Copies the command to 'command' address
> -        - Writes 0 into REQ register
> -    - Device
> -        - Reads the request object from the 'command' address
> -        - Allocates CQ object and initialize CQ ring based on pdir
> -        - Creates the backend CQ
> -        - Writes operation status to ERR register
> -        - Posts command-interrupt to guest
> -    - Guest driver
> -        - Reads the HW response code from ERR register
> -
> -4.3.2 Create QP
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    - Guest driver
> -        - Allocates pages for send and receive rings
> -        - Creates page directory(pdir) to hold the ring's pages
> -        - Initializes 'Create QP' command object (max_send_wr,
> -          send_cq_handle, recv_cq_handle, pdir etc)
> -        - Copies the object to 'command' address
> -        - Write 0 into REQ register
> -    - Device
> -        - Reads the request object from 'command' address
> -        - Allocates the QP object and initialize
> -            - Send and recv rings based on pdir
> -            - Send and recv ring state
> -        - Creates the backend QP
> -        - Writes the operation status to ERR register
> -        - Posts command-interrupt to guest
> -    - Guest driver
> -        - Reads the HW response code from ERR register
> -
> -4.3.3 Post receive
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    - Guest driver
> -        - Initializes a wqe and place it on recv ring
> -        - Write to qpn|qp_recv_bit (31) to QP offset in UAR
> -    - Device
> -        - Extracts qpn from UAR
> -        - Walks through the ring and does the following for each wqe
> -            - Prepares the backend CQE context to be used when
> -              receiving completion from backend (wr_id, op_code,
> emu_cq_num)
> -            - For each sge prepares backend sge
> -            - Calls backend's post_recv
> -
> -4.3.4 Process backend events
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -    - Done by a dedicated thread used to process backend events;
> -      at initialization is attached to the device and creates
> -      the communication channel.
> -    - Thread main loop:
> -        - Polls for completions
> -        - Extracts QEMU _cq_num, wr_id and op_code from context
> -        - Writes CQE to CQ ring
> -        - Writes CQ number to device CQ
> -        - Sends completion-interrupt to guest
> -        - Deallocates context
> -        - Acks the event to backend
> -
> -
> -
> -5. Limitations
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -- The device obviously is limited by the Guest Linux Driver features
> implementation
> -  of the VMware device API.
> -- Memory registration mechanism requires mremap for every page in the
> buffer in order
> -  to map it to a contiguous virtual address range. Since this is not the
> data path
> -  it should not matter much. If the default max mr size is increased, be
> aware that
> -  memory registration can take up to 0.5 seconds for 1GB of memory.
> -- The device requires target page size to be the same as the host page
> size,
> -  otherwise it will fail to init.
> -- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is
> attached,
> -  so it can't work with huge pages. The limitation will be addressed in
> the future,
> -  however QEMU allocates Guest RAM with MADV_HUGEPAGE so if there are
> enough huge
> -  pages available, QEMU will use them. QEMU will fail to init if the
> requirements
> -  are not met.
> -
> -
> -
> -6. Performance
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -By design the pvrdma device exits on each post-send/receive, so for smal=
l
> buffers
> -the performance is affected; however for medium buffers it will became
> close to
> -bare metal and from 1MB buffers and  up it reaches bare metal performanc=
e.
> -(tested with 2 VMs, the pvrdma devices connected to 2 VFs of the same
> device)
> -
> -All the above assumes no memory registration is done on data path.
> diff --git a/docs/rdma.txt b/docs/rdma.txt
> deleted file mode 100644
> index bd8dd799a9..0000000000
> --- a/docs/rdma.txt
> +++ /dev/null
> @@ -1,420 +0,0 @@
> -(RDMA: Remote Direct Memory Access)
> -RDMA Live Migration Specification, Version # 1
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Wiki: https://wiki.qemu.org/Features/RDMALiveMigration
> -Github: git@github.com:hinesmr/qemu.git, 'rdma' branch
> -
> -Copyright (C) 2013 Michael R. Hines <mrhines@us.ibm.com>
> -
> -An *exhaustive* paper (2010) shows additional performance details
> -linked on the QEMU wiki above.
> -
> -Contents:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -* Introduction
> -* Before running
> -* Running
> -* Performance
> -* RDMA Migration Protocol Description
> -* Versioning and Capabilities
> -* QEMUFileRDMA Interface
> -* Migration of VM's ram
> -* Error handling
> -* TODO
> -
> -Introduction:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -RDMA helps make your migration more deterministic under heavy load becau=
se
> -of the significantly lower latency and higher throughput over TCP/IP.
> This is
> -because the RDMA I/O architecture reduces the number of interrupts and
> -data copies by bypassing the host networking stack. In particular, a
> TCP-based
> -migration, under certain types of memory-bound workloads, may take a mor=
e
> -unpredictable amount of time to complete the migration if the amount of
> -memory tracked during each live migration iteration round cannot keep pa=
ce
> -with the rate of dirty memory produced by the workload.
> -
> -RDMA currently comes in two flavors: both Ethernet based (RoCE, or RDMA
> -over Converged Ethernet) as well as Infiniband-based. This implementatio=
n
> of
> -migration using RDMA is capable of using both technologies because of
> -the use of the OpenFabrics OFED software stack that abstracts out the
> -programming model irrespective of the underlying hardware.
> -
> -Refer to openfabrics.org or your respective RDMA hardware vendor for
> -an understanding on how to verify that you have the OFED software stack
> -installed in your environment. You should be able to successfully link
> -against the "librdmacm" and "libibverbs" libraries and development heade=
rs
> -for a working build of QEMU to run successfully using RDMA Migration.
> -
> -BEFORE RUNNING:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Use of RDMA during migration requires pinning and registering memory
> -with the hardware. This means that memory must be physically resident
> -before the hardware can transmit that memory to another machine.
> -If this is not acceptable for your application or product, then the use
> -of RDMA migration may in fact be harmful to co-located VMs or other
> -software on the machine if there is not sufficient memory available to
> -relocate the entire footprint of the virtual machine. If so, then the
> -use of RDMA is discouraged and it is recommended to use standard TCP
> migration.
> -
> -Experimental: Next, decide if you want dynamic page registration.
> -For example, if you have an 8GB RAM virtual machine, but only 1GB
> -is in active use, then enabling this feature will cause all 8GB to
> -be pinned and resident in memory. This feature mostly affects the
> -bulk-phase round of the migration and can be enabled for extremely
> -high-performance RDMA hardware using the following command:
> -
> -QEMU Monitor Command:
> -$ migrate_set_capability rdma-pin-all on # disabled by default
> -
> -Performing this action will cause all 8GB to be pinned, so if that's
> -not what you want, then please ignore this step altogether.
> -
> -On the other hand, this will also significantly speed up the bulk round
> -of the migration, which can greatly reduce the "total" time of your
> migration.
> -Example performance of this using an idle VM in the previous example
> -can be found in the "Performance" section.
> -
> -Note: for very large virtual machines (hundreds of GBs), pinning all
> -*all* of the memory of your virtual machine in the kernel is very
> expensive
> -may extend the initial bulk iteration time by many seconds,
> -and thus extending the total migration time. However, this will not
> -affect the determinism or predictability of your migration you will
> -still gain from the benefits of advanced pinning with RDMA.
> -
> -RUNNING:
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -First, set the migration speed to match your hardware's capabilities:
> -
> -QEMU Monitor Command:
> -$ migrate_set_parameter max-bandwidth 40g # or whatever is the MAX of
> your RDMA device
> -
> -Next, on the destination machine, add the following to the QEMU command
> line:
> -
> -qemu ..... -incoming rdma:host:port
> -
> -Finally, perform the actual migration on the source machine:
> -
> -QEMU Monitor Command:
> -$ migrate -d rdma:host:port
> -
> -PERFORMANCE
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Here is a brief summary of total migration time and downtime using RDMA:
> -Using a 40gbps infiniband link performing a worst-case stress test,
> -using an 8GB RAM virtual machine:
> -
> -Using the following command:
> -$ apt-get install stress
> -$ stress --vm-bytes 7500M --vm 1 --vm-keep
> -
> -1. Migration throughput: 26 gigabits/second.
> -2. Downtime (stop time) varies between 15 and 100 milliseconds.
> -
> -EFFECTS of memory registration on bulk phase round:
> -
> -For example, in the same 8GB RAM example with all 8GB of memory in
> -active use and the VM itself is completely idle using the same 40 gbps
> -infiniband link:
> -
> -1. rdma-pin-all disabled total time: approximately 7.5 seconds @ 9.5 Gbp=
s
> -2. rdma-pin-all enabled total time: approximately 4 seconds @ 26 Gbps
> -
> -These numbers would of course scale up to whatever size virtual machine
> -you have to migrate using RDMA.
> -
> -Enabling this feature does *not* have any measurable affect on
> -migration *downtime*. This is because, without this feature, all of the
> -memory will have already been registered already in advance during
> -the bulk round and does not need to be re-registered during the successi=
ve
> -iteration rounds.
> -
> -RDMA Protocol Description:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -
> -Migration with RDMA is separated into two parts:
> -
> -1. The transmission of the pages using RDMA
> -2. Everything else (a control channel is introduced)
> -
> -"Everything else" is transmitted using a formal
> -protocol now, consisting of infiniband SEND messages.
> -
> -An infiniband SEND message is the standard ibverbs
> -message used by applications of infiniband hardware.
> -The only difference between a SEND message and an RDMA
> -message is that SEND messages cause notifications
> -to be posted to the completion queue (CQ) on the
> -infiniband receiver side, whereas RDMA messages (used
> -for VM's ram) do not (to behave like an actual DMA).
> -
> -Messages in infiniband require two things:
> -
> -1. registration of the memory that will be transmitted
> -2. (SEND only) work requests to be posted on both
> -   sides of the network before the actual transmission
> -   can occur.
> -
> -RDMA messages are much easier to deal with. Once the memory
> -on the receiver side is registered and pinned, we're
> -basically done. All that is required is for the sender
> -side to start dumping bytes onto the link.
> -
> -(Memory is not released from pinning until the migration
> -completes, given that RDMA migrations are very fast.)
> -
> -SEND messages require more coordination because the
> -receiver must have reserved space (using a receive
> -work request) on the receive queue (RQ) before QEMUFileRDMA
> -can start using them to carry all the bytes as
> -a control transport for migration of device state.
> -
> -To begin the migration, the initial connection setup is
> -as follows (migration-rdma.c):
> -
> -1. Receiver and Sender are started (command line or libvirt):
> -2. Both sides post two RQ work requests
> -3. Receiver does listen()
> -4. Sender does connect()
> -5. Receiver accept()
> -6. Check versioning and capabilities (described later)
> -
> -At this point, we define a control channel on top of SEND messages
> -which is described by a formal protocol. Each SEND message has a
> -header portion and a data portion (but together are transmitted
> -as a single SEND message).
> -
> -Header:
> -    * Length               (of the data portion, uint32, network byte
> order)
> -    * Type                 (what command to perform, uint32, network byt=
e
> order)
> -    * Repeat               (Number of commands in data portion, same typ=
e
> only)
> -
> -The 'Repeat' field is here to support future multiple page registrations
> -in a single message without any need to change the protocol itself
> -so that the protocol is compatible against multiple versions of QEMU.
> -Version #1 requires that all server implementations of the protocol must
> -check this field and register all requests found in the array of command=
s
> located
> -in the data portion and return an equal number of results in the respons=
e.
> -The maximum number of repeats is hard-coded to 4096. This is a
> conservative
> -limit based on the maximum size of a SEND message along with empirical
> -observations on the maximum future benefit of simultaneous page
> registrations.
> -
> -The 'type' field has 12 different command values:
> -     1. Unused
> -     2. Error                      (sent to the source during bad things=
)
> -     3. Ready                      (control-channel is available)
> -     4. QEMU File                  (for sending non-live device state)
> -     5. RAM Blocks request         (used right after connection setup)
> -     6. RAM Blocks result          (used right after connection setup)
> -     7. Compress page              (zap zero page and skip registration)
> -     8. Register request           (dynamic chunk registration)
> -     9. Register result            ('rkey' to be used by sender)
> -    10. Register finished          (registration for current iteration
> finished)
> -    11. Unregister request         (unpin previously registered memory)
> -    12. Unregister finished        (confirmation that unpin completed)
> -
> -A single control message, as hinted above, can contain within the data
> -portion an array of many commands of the same type. If there is more tha=
n
> -one command, then the 'repeat' field will be greater than 1.
> -
> -After connection setup, message 5 & 6 are used to exchange ram block
> -information and optionally pin all the memory if requested by the user.
> -
> -After ram block exchange is completed, we have two protocol-level
> -functions, responsible for communicating control-channel commands
> -using the above list of values:
> -
> -Logically:
> -
> -qemu_rdma_exchange_recv(header, expected command type)
> -
> -1. We transmit a READY command to let the sender know that
> -   we are *ready* to receive some data bytes on the control channel.
> -2. Before attempting to receive the expected command, we post another
> -   RQ work request to replace the one we just used up.
> -3. Block on a CQ event channel and wait for the SEND to arrive.
> -4. When the send arrives, librdmacm will unblock us.
> -5. Verify that the command-type and version received matches the one we
> expected.
> -
> -qemu_rdma_exchange_send(header, data, optional response header & data):
> -
> -1. Block on the CQ event channel waiting for a READY command
> -   from the receiver to tell us that the receiver
> -   is *ready* for us to transmit some new bytes.
> -2. Optionally: if we are expecting a response from the command
> -   (that we have not yet transmitted), let's post an RQ
> -   work request to receive that data a few moments later.
> -3. When the READY arrives, librdmacm will
> -   unblock us and we immediately post a RQ work request
> -   to replace the one we just used up.
> -4. Now, we can actually post the work request to SEND
> -   the requested command type of the header we were asked for.
> -5. Optionally, if we are expecting a response (as before),
> -   we block again and wait for that response using the additional
> -   work request we previously posted. (This is used to carry
> -   'Register result' commands #6 back to the sender which
> -   hold the rkey need to perform RDMA. Note that the virtual address
> -   corresponding to this rkey was already exchanged at the beginning
> -   of the connection (described below).
> -
> -All of the remaining command types (not including 'ready')
> -described above all use the aforementioned two functions to do the hard
> work:
> -
> -1. After connection setup, RAMBlock information is exchanged using
> -   this protocol before the actual migration begins. This information
> includes
> -   a description of each RAMBlock on the server side as well as the
> virtual addresses
> -   and lengths of each RAMBlock. This is used by the client to determine
> the
> -   start and stop locations of chunks and how to register them dynamical=
ly
> -   before performing the RDMA operations.
> -2. During runtime, once a 'chunk' becomes full of pages ready to
> -   be sent with RDMA, the registration commands are used to ask the
> -   other side to register the memory for this chunk and respond
> -   with the result (rkey) of the registration.
> -3. Also, the QEMUFile interfaces also call these functions (described
> below)
> -   when transmitting non-live state, such as devices or to send
> -   its own protocol information during the migration process.
> -4. Finally, zero pages are only checked if a page has not yet been
> registered
> -   using chunk registration (or not checked at all and unconditionally
> -   written if chunk registration is disabled. This is accomplished using
> -   the "Compress" command listed above. If the page *has* been registere=
d
> -   then we check the entire chunk for zero. Only if the entire chunk is
> -   zero, then we send a compress command to zap the page on the other
> side.
> -
> -Versioning and Capabilities
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -Current version of the protocol is version #1.
> -
> -The same version applies to both for protocol traffic and capabilities
> -negotiation. (i.e. There is only one version number that is referred to
> -by all communication).
> -
> -librdmacm provides the user with a 'private data' area to be exchanged
> -at connection-setup time before any infiniband traffic is generated.
> -
> -Header:
> -    * Version (protocol version validated before send/recv occurs),
> -                                               uint32, network byte orde=
r
> -    * Flags   (bitwise OR of each capability),
> -                                               uint32, network byte orde=
r
> -
> -There is no data portion of this header right now, so there is
> -no length field. The maximum size of the 'private data' section
> -is only 192 bytes per the Infiniband specification, so it's not
> -very useful for data anyway. This structure needs to remain small.
> -
> -This private data area is a convenient place to check for protocol
> -versioning because the user does not need to register memory to
> -transmit a few bytes of version information.
> -
> -This is also a convenient place to negotiate capabilities
> -(like dynamic page registration).
> -
> -If the version is invalid, we throw an error.
> -
> -If the version is new, we only negotiate the capabilities that the
> -requested version is able to perform and ignore the rest.
> -
> -Currently there is only one capability in Version #1: dynamic page
> registration
> -
> -Finally: Negotiation happens with the Flags field: If the primary-VM
> -sets a flag, but the destination does not support this capability, it
> -will return a zero-bit for that flag and the primary-VM will understand
> -that as not being an available capability and will thus disable that
> -capability on the primary-VM side.
> -
> -QEMUFileRDMA Interface:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -QEMUFileRDMA introduces a couple of new functions:
> -
> -1. qemu_rdma_get_buffer()               (QEMUFileOps rdma_read_ops)
> -2. qemu_rdma_put_buffer()               (QEMUFileOps rdma_write_ops)
> -
> -These two functions are very short and simply use the protocol
> -describe above to deliver bytes without changing the upper-level
> -users of QEMUFile that depend on a bytestream abstraction.
> -
> -Finally, how do we handoff the actual bytes to get_buffer()?
> -
> -Again, because we're trying to "fake" a bytestream abstraction
> -using an analogy not unlike individual UDP frames, we have
> -to hold on to the bytes received from control-channel's SEND
> -messages in memory.
> -
> -Each time we receive a complete "QEMU File" control-channel
> -message, the bytes from SEND are copied into a small local holding area.
> -
> -Then, we return the number of bytes requested by get_buffer()
> -and leave the remaining bytes in the holding area until get_buffer()
> -comes around for another pass.
> -
> -If the buffer is empty, then we follow the same steps
> -listed above and issue another "QEMU File" protocol command,
> -asking for a new SEND message to re-fill the buffer.
> -
> -Migration of VM's ram:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -At the beginning of the migration, (migration-rdma.c),
> -the sender and the receiver populate the list of RAMBlocks
> -to be registered with each other into a structure.
> -Then, using the aforementioned protocol, they exchange a
> -description of these blocks with each other, to be used later
> -during the iteration of main memory. This description includes
> -a list of all the RAMBlocks, their offsets and lengths, virtual
> -addresses and possibly includes pre-registered RDMA keys in case dynamic
> -page registration was disabled on the server-side, otherwise not.
> -
> -Main memory is not migrated with the aforementioned protocol,
> -but is instead migrated with normal RDMA Write operations.
> -
> -Pages are migrated in "chunks" (hard-coded to 1 Megabyte right now).
> -Chunk size is not dynamic, but it could be in a future implementation.
> -There's nothing to indicate that this is useful right now.
> -
> -When a chunk is full (or a flush() occurs), the memory backed by
> -the chunk is registered with librdmacm is pinned in memory on
> -both sides using the aforementioned protocol.
> -After pinning, an RDMA Write is generated and transmitted
> -for the entire chunk.
> -
> -Chunks are also transmitted in batches: This means that we
> -do not request that the hardware signal the completion queue
> -for the completion of *every* chunk. The current batch size
> -is about 64 chunks (corresponding to 64 MB of memory).
> -Only the last chunk in a batch must be signaled.
> -This helps keep everything as asynchronous as possible
> -and helps keep the hardware busy performing RDMA operations.
> -
> -Error-handling:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Infiniband has what is called a "Reliable, Connected"
> -link (one of 4 choices). This is the mode in which
> -we use for RDMA migration.
> -
> -If a *single* message fails,
> -the decision is to abort the migration entirely and
> -cleanup all the RDMA descriptors and unregister all
> -the memory.
> -
> -After cleanup, the Virtual Machine is returned to normal
> -operation the same way that would happen if the TCP
> -socket is broken during a non-RDMA based migration.
> -
> -TODO:
> -=3D=3D=3D=3D=3D
> -1. Currently, 'ulimit -l' mlock() limits as well as cgroups swap limits
> -   are not compatible with infiniband memory pinning and will result in
> -   an aborted migration (but with the source VM left unaffected).
> -2. Use of the recent /proc/<pid>/pagemap would likely speed up
> -   the use of KSM and ballooning while using RDMA.
> -3. Also, some form of balloon-device usage tracking would also
> -   help alleviate some issues.
> -4. Use LRU to provide more fine-grained direction of UNREGISTER
> -   requests for unpinning memory in an overcommitted environment.
> -5. Expose UNREGISTER support to the user by way of workload-specific
> -   hints about application behavior.
> diff --git a/docs/system/device-url-syntax.rst.inc
> b/docs/system/device-url-syntax.rst.inc
> index 7dbc525fa8..43b5c2596b 100644
> --- a/docs/system/device-url-syntax.rst.inc
> +++ b/docs/system/device-url-syntax.rst.inc
> @@ -87,8 +87,8 @@ These are specified using a special URL syntax.
>
>  ``GlusterFS``
>     GlusterFS is a user space distributed file system. QEMU supports the
> -   use of GlusterFS volumes for hosting VM disk images using TCP, Unix
> -   Domain Sockets and RDMA transport protocols.
> +   use of GlusterFS volumes for hosting VM disk images using TCP and Uni=
x
> +   Domain Sockets transport protocols.
>
>     Syntax for specifying a VM disk image on GlusterFS volume is
>
> diff --git a/docs/system/loongarch/virt.rst
> b/docs/system/loongarch/virt.rst
> index c37268b404..0a8e0766e4 100644
> --- a/docs/system/loongarch/virt.rst
> +++ b/docs/system/loongarch/virt.rst
> @@ -39,7 +39,7 @@ can be accessed by following steps.
>
>  .. code-block:: bash
>
> -  ./configure --disable-rdma --disable-pvrdma --prefix=3D/usr \
> +  ./configure --prefix=3D/usr \
>                --target-list=3D"loongarch64-softmmu" \
>                --disable-libiscsi --disable-libnfs --disable-libpmem \
>                --disable-glusterfs --enable-libusb --enable-usb-redir \
> diff --git a/docs/system/qemu-block-drivers.rst.inc
> b/docs/system/qemu-block-drivers.rst.inc
> index 105cb9679c..384e95ba76 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -737,7 +737,6 @@ Examples
>    |qemu_system| -drive
> file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
>    |qemu_system| -drive file=3Dgluster+tcp://
> server.domain.com:24007/testvol/dir/a.img
>    |qemu_system| -drive
> file=3Dgluster+unix:///testvol/dir/a.img?socket=3D/tmp/glusterd.socket
> -  |qemu_system| -drive file=3Dgluster+rdma://1.2.3.4:24007/testvol/a.img
>    |qemu_system| -drive file=3Dgluster://
> 1.2.3.4/testvol/a.img,file.debug=3D9,file.logfile=3D/var/log/qemu-gluster=
.log
>    |qemu_system| 'json:{"driver":"qcow2",
>                             "file":{"driver":"gluster",
> diff --git a/meson.build b/meson.build
> index c9c3217ba4..bd65abad13 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1854,21 +1854,6 @@ if numa.found() and not cc.links('''
>    endif
>  endif
>
> -rdma =3D not_found
> -if not get_option('rdma').auto() or have_system
> -  libumad =3D cc.find_library('ibumad', required: get_option('rdma'))
> -  rdma_libs =3D [cc.find_library('rdmacm', has_headers: ['rdma/rdma_cma.=
h'],
> -                               required: get_option('rdma')),
> -               cc.find_library('ibverbs', required: get_option('rdma')),
> -               libumad]
> -  rdma =3D declare_dependency(dependencies: rdma_libs)
> -  foreach lib: rdma_libs
> -    if not lib.found()
> -      rdma =3D not_found
> -    endif
> -  endforeach
> -endif
> -
>  cacard =3D not_found
>  if not get_option('smartcard').auto() or have_system
>    cacard =3D dependency('libcacard', required: get_option('smartcard'),
> @@ -2246,7 +2231,6 @@ endif
>  config_host_data.set('CONFIG_OPENGL', opengl.found())
>  config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
>  config_host_data.set('CONFIG_RBD', rbd.found())
> -config_host_data.set('CONFIG_RDMA', rdma.found())
>  config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>  config_host_data.set('CONFIG_SDL', sdl.found())
> @@ -2399,12 +2383,6 @@ if rbd.found()
>                                         dependencies: rbd,
>                                         prefix: '#include <rbd/librbd.h>'=
))
>  endif
> -if rdma.found()
> -  config_host_data.set('HAVE_IBV_ADVISE_MR',
> -                       cc.has_function('ibv_advise_mr',
> -                                       dependencies: rdma,
> -                                       prefix: '#include
> <infiniband/verbs.h>'))
> -endif
>
>  have_asan_fiber =3D false
>  if get_option('sanitizers') and \
> @@ -2829,37 +2807,6 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN',
> cc.compiles('''
>      void foo(uint8x16_t *p) { *p =3D vaesmcq_u8(*p); }
>    '''))
>
> -have_pvrdma =3D get_option('pvrdma') \
> -  .require(rdma.found(), error_message: 'PVRDMA requires OpenFabrics
> libraries') \
> -  .require(cc.compiles(gnu_source_prefix + '''
> -    #include <sys/mman.h>
> -    int main(void)
> -    {
> -      char buf =3D 0;
> -      void *addr =3D &buf;
> -      addr =3D mremap(addr, 0, 1, MREMAP_MAYMOVE | MREMAP_FIXED);
> -
> -      return 0;
> -    }'''), error_message: 'PVRDMA requires mremap').allowed()
> -
> -if have_pvrdma
> -  config_host_data.set('LEGACY_RDMA_REG_MR', not cc.links('''
> -    #include <infiniband/verbs.h>
> -    int main(void)
> -    {
> -      struct ibv_mr *mr;
> -      struct ibv_pd *pd =3D NULL;
> -      size_t length =3D 10;
> -      uint64_t iova =3D 0;
> -      int access =3D 0;
> -      void *addr =3D NULL;
> -
> -      mr =3D ibv_reg_mr_iova(pd, addr, length, iova, access);
> -      ibv_dereg_mr(mr);
> -      return 0;
> -    }'''))
> -endif
> -
>  if get_option('membarrier').disabled()
>    have_membarrier =3D false
>  elif host_os =3D=3D 'windows'
> @@ -2993,7 +2940,6 @@ host_kconfig =3D \
>    (have_vhost_kernel ? ['CONFIG_VHOST_KERNEL=3Dy'] : []) + \
>    (have_virtfs ? ['CONFIG_VIRTFS=3Dy'] : []) + \
>    (host_os =3D=3D 'linux' ? ['CONFIG_LINUX=3Dy'] : []) + \
> -  (have_pvrdma ? ['CONFIG_PVRDMA=3Dy'] : []) + \
>    (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=3Dy'] : []) + \
>    (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=3Dy'] : =
[])
> + \
>    (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=3Dy'] : [])
> @@ -3357,8 +3303,6 @@ if have_system
>      'hw/pci',
>      'hw/pci-host',
>      'hw/ppc',
> -    'hw/rdma',
> -    'hw/rdma/vmw',
>      'hw/rtc',
>      'hw/s390x',
>      'hw/scsi',
> @@ -4028,7 +3972,6 @@ if have_tools
>      }]
>    endforeach
>
> -  subdir('contrib/rdmacm-mux')
>    subdir('contrib/elf2dmp')
>
>    executable('qemu-edid', files('qemu-edid.c',
> 'hw/display/edid-generate.c'),
> @@ -4433,8 +4376,6 @@ summary_info +=3D {'Multipath support': mpathpersis=
t}
>  summary_info +=3D {'Linux AIO support': libaio}
>  summary_info +=3D {'Linux io_uring support': linux_io_uring}
>  summary_info +=3D {'ATTR/XATTR support': libattr}
> -summary_info +=3D {'RDMA support':      rdma}
> -summary_info +=3D {'PVRDMA support':    have_pvrdma}
>  summary_info +=3D {'fdt support':       fdt_opt =3D=3D 'disabled' ? fals=
e :
> fdt_opt}
>  summary_info +=3D {'libcap-ng support': libcap_ng}
>  summary_info +=3D {'bpf support':       libbpf}
> diff --git a/qapi/machine.json b/qapi/machine.json
> index e8b60641f2..e9f0f0c49a 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1737,23 +1737,6 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>
> -##
> -# @x-query-rdma:
> -#
> -# Query RDMA state
> -#
> -# Features:
> -#
> -# @unstable: This command is meant for debugging.
> -#
> -# Returns: RDMA state
> -#
> -# Since: 6.2
> -##
> -{ 'command': 'x-query-rdma',
> -  'returns': 'HumanReadableText',
> -  'features': [ 'unstable' ] }
> -
>  ##
>  # @x-query-roms:
>  #
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c65b90328..9a56d403be 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -221,8 +221,8 @@
>  #
>  # @setup-time: amount of setup time in milliseconds *before* the
>  #     iterations begin but *after* the QMP command is issued.  This is
> -#     designed to provide an accounting of any activities (such as
> -#     RDMA pinning) which may be expensive, but do not actually occur
> +#     designed to provide an accounting of any activities which may be
> +#     expensive, but do not actually occur
>  #     during the iterative migration rounds themselves.  (since 1.6)
>  #
>  # @cpu-throttle-percentage: percentage of time guest cpus are being
> @@ -430,10 +430,6 @@
>  #     for certain work loads, by sending compressed difference of the
>  #     pages
>  #
> -# @rdma-pin-all: Controls whether or not the entire VM memory
> -#     footprint is mlock()'d on demand or all at once.  Refer to
> -#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
> -#
>  # @zero-blocks: During storage migration encode blocks of zeroes
>  #     efficiently.  This essentially saves 1MB of zeroes per block on
>  #     the wire.  Enabling requires source and target VM to support
> @@ -547,7 +543,7 @@
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> +  'data': ['xbzrle', 'auto-converge', 'zero-blocks',
>             { 'name': 'compress', 'features': [ 'deprecated' ] },
>             'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
> @@ -606,7 +602,6 @@
>  #     -> { "execute": "query-migrate-capabilities" }
>  #     <- { "return": [
>  #           {"state": false, "capability": "xbzrle"},
> -#           {"state": false, "capability": "rdma-pin-all"},
>  #           {"state": false, "capability": "auto-converge"},
>  #           {"state": false, "capability": "zero-blocks"},
>  #           {"state": false, "capability": "compress"},
> @@ -1654,14 +1649,12 @@
>  #
>  # @exec: Direct the migration stream to another process.
>  #
> -# @rdma: Migrate via RDMA.
> -#
>  # @file: Direct the migration stream to a file.
>  #
>  # Since: 8.2
>  ##
>  { 'enum': 'MigrationAddressType',
> -  'data': [ 'socket', 'exec', 'rdma', 'file' ] }
> +  'data': [ 'socket', 'exec', 'file' ] }
>
>  ##
>  # @FileMigrationArgs:
> @@ -1701,7 +1694,6 @@
>    'data': {
>      'socket': 'SocketAddress',
>      'exec': 'MigrationExecCommand',
> -    'rdma': 'InetSocketAddress',
>      'file': 'FileMigrationArgs' } }
>
>  ##
> @@ -1804,14 +1796,6 @@
>  #     -> { "execute": "migrate",
>  #          "arguments": {
>  #              "channels": [ { "channel-type": "main",
> -#                              "addr": { "transport": "rdma",
> -#                                        "host": "10.12.34.9",
> -#                                        "port": "1050" } } ] } }
> -#     <- { "return": {} }
> -#
> -#     -> { "execute": "migrate",
> -#          "arguments": {
> -#              "channels": [ { "channel-type": "main",
>  #                              "addr": { "transport": "file",
>  #                                        "filename": "/tmp/migfile",
>  #                                        "offset": "0x1000" } } ] } }
> @@ -1879,13 +1863,6 @@
>  #                                                  "/some/sock" ] } } ] =
}
> }
>  #     <- { "return": {} }
>  #
> -#     -> { "execute": "migrate-incoming",
> -#          "arguments": {
> -#              "channels": [ { "channel-type": "main",
> -#                              "addr": { "transport": "rdma",
> -#                                        "host": "10.12.34.9",
> -#                                        "port": "1050" } } ] } }
> -#     <- { "return": {} }
>  ##
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 8304d45625..5e33da7228 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -54,7 +54,6 @@
>  { 'include': 'dump.json' }
>  { 'include': 'net.json' }
>  { 'include': 'ebpf.json' }
> -{ 'include': 'rdma.json' }
>  { 'include': 'rocker.json' }
>  { 'include': 'tpm.json' }
>  { 'include': 'ui.json' }
> diff --git a/qapi/rdma.json b/qapi/rdma.json
> deleted file mode 100644
> index 195c001850..0000000000
> --- a/qapi/rdma.json
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -# -*- Mode: Python -*-
> -# vim: filetype=3Dpython
> -#
> -
> -##
> -# =3D RDMA device
> -##
> -
> -##
> -# @RDMA_GID_STATUS_CHANGED:
> -#
> -# Emitted when guest driver adds/deletes GID to/from device
> -#
> -# @netdev: RoCE Network Device name
> -#
> -# @gid-status: Add or delete indication
> -#
> -# @subnet-prefix: Subnet Prefix
> -#
> -# @interface-id: Interface ID
> -#
> -# Since: 4.0
> -#
> -# Example:
> -#
> -#     <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
> -#         "event": "RDMA_GID_STATUS_CHANGED",
> -#         "data":
> -#             {"netdev": "bridge0",
> -#             "interface-id": 15880512517475447892,
> -#             "gid-status": true,
> -#             "subnet-prefix": 33022}}
> -##
> -{ 'event': 'RDMA_GID_STATUS_CHANGED',
> -  'data': { 'netdev'        : 'str',
> -            'gid-status'    : 'bool',
> -            'subnet-prefix' : 'uint64',
> -            'interface-id'  : 'uint64' } }
> diff --git a/contrib/rdmacm-mux/rdmacm-mux.h
> b/contrib/rdmacm-mux/rdmacm-mux.h
> deleted file mode 100644
> index 07a4722913..0000000000
> --- a/contrib/rdmacm-mux/rdmacm-mux.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/*
> - * QEMU paravirtual RDMA - rdmacm-mux declarations
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMACM_MUX_H
> -#define RDMACM_MUX_H
> -
> -#include "linux/if.h"
> -#include <infiniband/verbs.h>
> -#include <infiniband/umad.h>
> -#include <rdma/rdma_user_cm.h>
> -
> -typedef enum RdmaCmMuxMsgType {
> -    RDMACM_MUX_MSG_TYPE_REQ   =3D 0,
> -    RDMACM_MUX_MSG_TYPE_RESP  =3D 1,
> -} RdmaCmMuxMsgType;
> -
> -typedef enum RdmaCmMuxOpCode {
> -    RDMACM_MUX_OP_CODE_REG   =3D 0,
> -    RDMACM_MUX_OP_CODE_UNREG =3D 1,
> -    RDMACM_MUX_OP_CODE_MAD   =3D 2,
> -} RdmaCmMuxOpCode;
> -
> -typedef enum RdmaCmMuxErrCode {
> -    RDMACM_MUX_ERR_CODE_OK        =3D 0,
> -    RDMACM_MUX_ERR_CODE_EINVAL    =3D 1,
> -    RDMACM_MUX_ERR_CODE_EEXIST    =3D 2,
> -    RDMACM_MUX_ERR_CODE_EACCES    =3D 3,
> -    RDMACM_MUX_ERR_CODE_ENOTFOUND =3D 4,
> -} RdmaCmMuxErrCode;
> -
> -typedef struct RdmaCmMuxHdr {
> -    RdmaCmMuxMsgType msg_type;
> -    RdmaCmMuxOpCode op_code;
> -    union ibv_gid sgid;
> -    RdmaCmMuxErrCode err_code;
> -} RdmaCmUHdr;
> -
> -typedef struct RdmaCmUMad {
> -    struct ib_user_mad hdr;
> -    char mad[RDMA_MAX_PRIVATE_DATA];
> -} RdmaCmUMad;
> -
> -typedef struct RdmaCmMuxMsg {
> -    RdmaCmUHdr hdr;
> -    int umad_len;
> -    RdmaCmUMad umad;
> -} RdmaCmMuxMsg;
> -
> -#endif
> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> deleted file mode 100644
> index 225af481e0..0000000000
> --- a/hw/rdma/rdma_backend.h
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -/*
> - *  RDMA device: Definitions of Backend Device functions
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMA_BACKEND_H
> -#define RDMA_BACKEND_H
> -
> -#include "qapi/error.h"
> -#include "chardev/char-fe.h"
> -
> -#include "rdma_rm_defs.h"
> -#include "rdma_backend_defs.h"
> -
> -/* Vendor Errors */
> -#define VENDOR_ERR_FAIL_BACKEND     0x201
> -#define VENDOR_ERR_TOO_MANY_SGES    0x202
> -#define VENDOR_ERR_NOMEM            0x203
> -#define VENDOR_ERR_QP0              0x204
> -#define VENDOR_ERR_INV_NUM_SGE      0x205
> -#define VENDOR_ERR_MAD_SEND         0x206
> -#define VENDOR_ERR_INVLKEY          0x207
> -#define VENDOR_ERR_MR_SMALL         0x208
> -#define VENDOR_ERR_INV_MAD_BUFF     0x209
> -#define VENDOR_ERR_INV_GID_IDX      0x210
> -
> -/* Add definition for QP0 and QP1 as there is no userspace enums for the=
m
> */
> -enum ibv_special_qp_type {
> -    IBV_QPT_SMI =3D 0,
> -    IBV_QPT_GSI =3D 1,
> -};
> -
> -static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)
> -{
> -    return qp->ibqp ? qp->ibqp->qp_num : 1;
> -}
> -
> -static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr)
> -{
> -    return mr->ibmr ? mr->ibmr->lkey : 0;
> -}
> -
> -static inline uint32_t rdma_backend_mr_rkey(const RdmaBackendMR *mr)
> -{
> -    return mr->ibmr ? mr->ibmr->rkey : 0;
> -}
> -
> -int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
> -                      RdmaDeviceResources *rdma_dev_res,
> -                      const char *backend_device_name, uint8_t port_num,
> -                      struct ibv_device_attr *dev_attr,
> -                      CharBackend *mad_chr_be);
> -void rdma_backend_fini(RdmaBackendDev *backend_dev);
> -int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname=
,
> -                         union ibv_gid *gid);
> -int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname=
,
> -                         union ibv_gid *gid);
> -int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
> -                               union ibv_gid *gid);
> -void rdma_backend_start(RdmaBackendDev *backend_dev);
> -void rdma_backend_stop(RdmaBackendDev *backend_dev);
> -void rdma_backend_register_comp_handler(void (*handler)(void *ctx,
> -                                                        struct ibv_wc
> *wc));
> -void rdma_backend_unregister_comp_handler(void);
> -
> -int rdma_backend_query_port(RdmaBackendDev *backend_dev,
> -                            struct ibv_port_attr *port_attr);
> -int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD
> *pd);
> -void rdma_backend_destroy_pd(RdmaBackendPD *pd);
> -
> -int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void
> *addr,
> -                           size_t length, uint64_t guest_start, int
> access);
> -void rdma_backend_destroy_mr(RdmaBackendMR *mr);
> -
> -int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *c=
q,
> -                           int cqe);
> -void rdma_backend_destroy_cq(RdmaBackendCQ *cq);
> -void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res,
> RdmaBackendCQ *cq);
> -
> -int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
> -                           RdmaBackendPD *pd, RdmaBackendCQ *scq,
> -                           RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,
> -                           uint32_t max_send_wr, uint32_t max_recv_wr,
> -                           uint32_t max_send_sge, uint32_t max_recv_sge)=
;
> -int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQ=
P
> *qp,
> -                               uint8_t qp_type, uint32_t qkey);
> -int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP
> *qp,
> -                              uint8_t qp_type, uint8_t sgid_idx,
> -                              union ibv_gid *dgid, uint32_t dqpn,
> -                              uint32_t rq_psn, uint32_t qkey, bool
> use_qkey);
> -int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
> -                              uint32_t sq_psn, uint32_t qkey, bool
> use_qkey);
> -int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
> -                          int attr_mask, struct ibv_qp_init_attr
> *init_attr);
> -void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources
> *dev_res);
> -
> -void rdma_backend_post_send(RdmaBackendDev *backend_dev,
> -                            RdmaBackendQP *qp, uint8_t qp_type,
> -                            struct ibv_sge *sge, uint32_t num_sge,
> -                            uint8_t sgid_idx, union ibv_gid *sgid,
> -                            union ibv_gid *dgid, uint32_t dqpn, uint32_t
> dqkey,
> -                            void *ctx);
> -void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
> -                            RdmaBackendQP *qp, uint8_t qp_type,
> -                            struct ibv_sge *sge, uint32_t num_sge, void
> *ctx);
> -
> -int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
> -                            uint32_t max_wr, uint32_t max_sge,
> -                            uint32_t srq_limit);
> -int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr
> *srq_attr);
> -int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr
> *srq_attr,
> -                            int srq_attr_mask);
> -void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,
> -                              RdmaDeviceResources *dev_res);
> -void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
> -                                RdmaBackendSRQ *srq, struct ibv_sge *sge=
,
> -                                uint32_t num_sge, void *ctx);
> -
> -#endif
> diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
> deleted file mode 100644
> index 4e6c0ad695..0000000000
> --- a/hw/rdma/rdma_backend_defs.h
> +++ /dev/null
> @@ -1,76 +0,0 @@
> -/*
> - *  RDMA device: Definitions of Backend Device structures
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMA_BACKEND_DEFS_H
> -#define RDMA_BACKEND_DEFS_H
> -
> -#include "qemu/thread.h"
> -#include "chardev/char-fe.h"
> -#include <infiniband/verbs.h>
> -#include "contrib/rdmacm-mux/rdmacm-mux.h"
> -#include "rdma_utils.h"
> -
> -typedef struct RdmaDeviceResources RdmaDeviceResources;
> -
> -typedef struct RdmaBackendThread {
> -    QemuThread thread;
> -    bool run; /* Set by thread manager to let thread know it should exit
> */
> -    bool is_running; /* Set by the thread to report its status */
> -} RdmaBackendThread;
> -
> -typedef struct RdmaCmMux {
> -    CharBackend *chr_be;
> -    int can_receive;
> -} RdmaCmMux;
> -
> -typedef struct RdmaBackendDev {
> -    RdmaBackendThread comp_thread;
> -    PCIDevice *dev;
> -    RdmaDeviceResources *rdma_dev_res;
> -    struct ibv_device *ib_dev;
> -    struct ibv_context *context;
> -    struct ibv_comp_channel *channel;
> -    uint8_t port_num;
> -    RdmaProtectedGQueue recv_mads_list;
> -    RdmaCmMux rdmacm_mux;
> -} RdmaBackendDev;
> -
> -typedef struct RdmaBackendPD {
> -    struct ibv_pd *ibpd;
> -} RdmaBackendPD;
> -
> -typedef struct RdmaBackendMR {
> -    struct ibv_pd *ibpd;
> -    struct ibv_mr *ibmr;
> -} RdmaBackendMR;
> -
> -typedef struct RdmaBackendCQ {
> -    RdmaBackendDev *backend_dev;
> -    struct ibv_cq *ibcq;
> -} RdmaBackendCQ;
> -
> -typedef struct RdmaBackendQP {
> -    struct ibv_pd *ibpd;
> -    struct ibv_qp *ibqp;
> -    uint8_t sgid_idx;
> -    RdmaProtectedGSList cqe_ctx_list;
> -} RdmaBackendQP;
> -
> -typedef struct RdmaBackendSRQ {
> -    struct ibv_srq *ibsrq;
> -    RdmaProtectedGSList cqe_ctx_list;
> -} RdmaBackendSRQ;
> -
> -#endif
> diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
> deleted file mode 100644
> index d69a917795..0000000000
> --- a/hw/rdma/rdma_rm.h
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -/*
> - * RDMA device: Definitions of Resource Manager functions
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMA_RM_H
> -#define RDMA_RM_H
> -
> -#include "qapi/error.h"
> -#include "rdma_backend_defs.h"
> -#include "rdma_rm_defs.h"
> -
> -int rdma_rm_init(RdmaDeviceResources *dev_res,
> -                 struct ibv_device_attr *dev_attr);
> -void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                  const char *ifname);
> -
> -int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                     uint32_t *pd_handle, uint32_t ctx_handle);
> -RdmaRmPD *rdma_rm_get_pd(RdmaDeviceResources *dev_res, uint32_t
> pd_handle);
> -void rdma_rm_dealloc_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle=
);
> -
> -int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
> -                     uint64_t guest_start, uint64_t guest_length,
> -                     void *host_virt, int access_flags, uint32_t
> *mr_handle,
> -                     uint32_t *lkey, uint32_t *rkey);
> -RdmaRmMR *rdma_rm_get_mr(RdmaDeviceResources *dev_res, uint32_t
> mr_handle);
> -void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle=
);
> -
> -int rdma_rm_alloc_uc(RdmaDeviceResources *dev_res, uint32_t pfn,
> -                     uint32_t *uc_handle);
> -RdmaRmUC *rdma_rm_get_uc(RdmaDeviceResources *dev_res, uint32_t
> uc_handle);
> -void rdma_rm_dealloc_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle=
);
> -
> -int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                     uint32_t cqe, uint32_t *cq_handle, void *opaque);
> -RdmaRmCQ *rdma_rm_get_cq(RdmaDeviceResources *dev_res, uint32_t
> cq_handle);
> -void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t
> cq_handle,
> -                           bool notify);
> -void rdma_rm_dealloc_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle=
);
> -
> -int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
> -                     uint8_t qp_type, uint32_t max_send_wr,
> -                     uint32_t max_send_sge, uint32_t send_cq_handle,
> -                     uint32_t max_recv_wr, uint32_t max_recv_sge,
> -                     uint32_t recv_cq_handle, void *opaque, uint32_t *qp=
n,
> -                     uint8_t is_srq, uint32_t srq_handle);
> -RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn);
> -int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                      uint32_t qp_handle, uint32_t attr_mask, uint8_t
> sgid_idx,
> -                      union ibv_gid *dgid, uint32_t dqpn,
> -                      enum ibv_qp_state qp_state, uint32_t qkey,
> -                      uint32_t rq_psn, uint32_t sq_psn);
> -int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                     uint32_t qp_handle, struct ibv_qp_attr *attr,
> -                     int attr_mask, struct ibv_qp_init_attr *init_attr);
> -void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle=
);
> -
> -RdmaRmSRQ *rdma_rm_get_srq(RdmaDeviceResources *dev_res, uint32_t
> srq_handle);
> -int rdma_rm_alloc_srq(RdmaDeviceResources *dev_res, uint32_t pd_handle,
> -                      uint32_t max_wr, uint32_t max_sge, uint32_t
> srq_limit,
> -                      uint32_t *srq_handle, void *opaque);
> -int rdma_rm_query_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
> -                      struct ibv_srq_attr *srq_attr);
> -int rdma_rm_modify_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle=
,
> -                       struct ibv_srq_attr *srq_attr, int srq_attr_mask)=
;
> -void rdma_rm_dealloc_srq(RdmaDeviceResources *dev_res, uint32_t
> srq_handle);
> -
> -int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t
> *cqe_ctx_id,
> -                          void *ctx);
> -void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t
> cqe_ctx_id);
> -void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t
> cqe_ctx_id);
> -
> -int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                    const char *ifname, union ibv_gid *gid, int gid_idx)=
;
> -int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev
> *backend_dev,
> -                    const char *ifname, int gid_idx);
> -int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
> -                                  RdmaBackendDev *backend_dev, int
> sgid_idx);
> -static inline union ibv_gid *rdma_rm_get_gid(RdmaDeviceResources *dev_re=
s,
> -                                             int sgid_idx)
> -{
> -    return &dev_res->port.gid_tbl[sgid_idx].gid;
> -}
> -void rdma_format_device_counters(RdmaDeviceResources *dev_res, GString
> *buf);
> -
> -#endif
> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> deleted file mode 100644
> index 534f2f74d3..0000000000
> --- a/hw/rdma/rdma_rm_defs.h
> +++ /dev/null
> @@ -1,146 +0,0 @@
> -/*
> - * RDMA device: Definitions of Resource Manager structures
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMA_RM_DEFS_H
> -#define RDMA_RM_DEFS_H
> -
> -#include "rdma_backend_defs.h"
> -
> -#define MAX_PORTS             1 /* Do not change - we support only one
> port */
> -#define MAX_PORT_GIDS         255
> -#define MAX_GIDS              MAX_PORT_GIDS
> -#define MAX_PORT_PKEYS        1
> -#define MAX_PKEYS             MAX_PORT_PKEYS
> -#define MAX_UCS               512
> -#define MAX_MR_SIZE           (1UL << 27)
> -#define MAX_QP                1024
> -#define MAX_SGE               4
> -#define MAX_CQ                2048
> -#define MAX_MR                1024
> -#define MAX_PD                1024
> -#define MAX_QP_RD_ATOM        16
> -#define MAX_QP_INIT_RD_ATOM   16
> -#define MAX_AH                64
> -#define MAX_SRQ               512
> -
> -#define MAX_RM_TBL_NAME             16
> -#define MAX_CONSEQ_EMPTY_POLL_CQ    4096 /* considered as error above
> this */
> -
> -typedef struct RdmaRmResTbl {
> -    char name[MAX_RM_TBL_NAME];
> -    QemuMutex lock;
> -    unsigned long *bitmap;
> -    size_t tbl_sz;
> -    size_t res_sz;
> -    void *tbl;
> -    uint32_t used; /* number of used entries in the table */
> -} RdmaRmResTbl;
> -
> -typedef struct RdmaRmPD {
> -    RdmaBackendPD backend_pd;
> -    uint32_t ctx_handle;
> -} RdmaRmPD;
> -
> -typedef enum CQNotificationType {
> -    CNT_CLEAR,
> -    CNT_ARM,
> -    CNT_SET,
> -} CQNotificationType;
> -
> -typedef struct RdmaRmCQ {
> -    RdmaBackendCQ backend_cq;
> -    void *opaque;
> -    CQNotificationType notify;
> -} RdmaRmCQ;
> -
> -/* MR (DMA region) */
> -typedef struct RdmaRmMR {
> -    RdmaBackendMR backend_mr;
> -    void *virt;
> -    uint64_t start;
> -    size_t length;
> -    uint32_t pd_handle;
> -    uint32_t lkey;
> -    uint32_t rkey;
> -} RdmaRmMR;
> -
> -typedef struct RdmaRmUC {
> -    uint64_t uc_handle;
> -} RdmaRmUC;
> -
> -typedef struct RdmaRmQP {
> -    RdmaBackendQP backend_qp;
> -    void *opaque;
> -    uint32_t qp_type;
> -    uint32_t qpn;
> -    uint32_t send_cq_handle;
> -    uint32_t recv_cq_handle;
> -    enum ibv_qp_state qp_state;
> -    uint8_t is_srq;
> -} RdmaRmQP;
> -
> -typedef struct RdmaRmSRQ {
> -    RdmaBackendSRQ backend_srq;
> -    uint32_t recv_cq_handle;
> -    void *opaque;
> -} RdmaRmSRQ;
> -
> -typedef struct RdmaRmGid {
> -    union ibv_gid gid;
> -    int backend_gid_index;
> -} RdmaRmGid;
> -
> -typedef struct RdmaRmPort {
> -    RdmaRmGid gid_tbl[MAX_PORT_GIDS];
> -    enum ibv_port_state state;
> -} RdmaRmPort;
> -
> -typedef struct RdmaRmStats {
> -    uint64_t tx;
> -    uint64_t tx_len;
> -    uint64_t tx_err;
> -    uint64_t rx_bufs;
> -    uint64_t rx_bufs_len;
> -    uint64_t rx_bufs_err;
> -    uint64_t rx_srq;
> -    uint64_t completions;
> -    uint64_t mad_tx;
> -    uint64_t mad_tx_err;
> -    uint64_t mad_rx;
> -    uint64_t mad_rx_err;
> -    uint64_t mad_rx_bufs;
> -    uint64_t mad_rx_bufs_err;
> -    uint64_t poll_cq_from_bk;
> -    uint64_t poll_cq_from_guest;
> -    uint64_t poll_cq_from_guest_empty;
> -    uint64_t poll_cq_ppoll_to;
> -    uint32_t missing_cqe;
> -} RdmaRmStats;
> -
> -struct RdmaDeviceResources {
> -    RdmaRmPort port;
> -    RdmaRmResTbl pd_tbl;
> -    RdmaRmResTbl mr_tbl;
> -    RdmaRmResTbl uc_tbl;
> -    RdmaRmResTbl qp_tbl;
> -    RdmaRmResTbl cq_tbl;
> -    RdmaRmResTbl cqe_ctx_tbl;
> -    RdmaRmResTbl srq_tbl;
> -    GHashTable *qp_hash; /* Keeps mapping between real and emulated */
> -    QemuMutex lock;
> -    RdmaRmStats stats;
> -};
> -
> -#endif
> diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
> deleted file mode 100644
> index 54e4f56edd..0000000000
> --- a/hw/rdma/rdma_utils.h
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -/*
> - * RDMA device: Debug utilities
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMA_UTILS_H
> -#define RDMA_UTILS_H
> -
> -#include "qemu/error-report.h"
> -#include "sysemu/dma.h"
> -
> -#define rdma_error_report(fmt, ...) \
> -    error_report("%s: " fmt, "rdma", ## __VA_ARGS__)
> -#define rdma_warn_report(fmt, ...) \
> -    warn_report("%s: " fmt, "rdma", ## __VA_ARGS__)
> -#define rdma_info_report(fmt, ...) \
> -    info_report("%s: " fmt, "rdma", ## __VA_ARGS__)
> -
> -typedef struct RdmaProtectedGQueue {
> -    QemuMutex lock;
> -    GQueue *list;
> -} RdmaProtectedGQueue;
> -
> -typedef struct RdmaProtectedGSList {
> -    QemuMutex lock;
> -    GSList *list;
> -} RdmaProtectedGSList;
> -
> -void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t len);
> -void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
> -void rdma_protected_gqueue_init(RdmaProtectedGQueue *list);
> -void rdma_protected_gqueue_destroy(RdmaProtectedGQueue *list);
> -void rdma_protected_gqueue_append_int64(RdmaProtectedGQueue *list,
> -                                        int64_t value);
> -int64_t rdma_protected_gqueue_pop_int64(RdmaProtectedGQueue *list);
> -void rdma_protected_gslist_init(RdmaProtectedGSList *list);
> -void rdma_protected_gslist_destroy(RdmaProtectedGSList *list);
> -void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,
> -                                        int32_t value);
> -void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,
> -                                        int32_t value);
> -
> -static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)
> -{
> -    memcpy(eui, addr, 3);
> -    eui[3] =3D 0xFF;
> -    eui[4] =3D 0xFE;
> -    memcpy(eui + 5, addr + 3, 3);
> -    eui[0] ^=3D 2;
> -}
> -
> -#endif
> diff --git a/hw/rdma/trace.h b/hw/rdma/trace.h
> deleted file mode 100644
> index b3fa8ebc51..0000000000
> --- a/hw/rdma/trace.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include "trace/trace-hw_rdma.h"
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> deleted file mode 100644
> index 4cbc10c980..0000000000
> --- a/hw/rdma/vmw/pvrdma.h
> +++ /dev/null
> @@ -1,144 +0,0 @@
> -/*
> - * QEMU VMWARE paravirtual RDMA device definitions
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef PVRDMA_PVRDMA_H
> -#define PVRDMA_PVRDMA_H
> -
> -#include "qemu/units.h"
> -#include "qemu/notify.h"
> -#include "hw/pci/msix.h"
> -#include "hw/pci/pci_device.h"
> -#include "chardev/char-fe.h"
> -#include "hw/net/vmxnet3_defs.h"
> -
> -#include "../rdma_backend_defs.h"
> -#include "../rdma_rm_defs.h"
> -
> -#include
> "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
> -#include "pvrdma_dev_ring.h"
> -#include "qom/object.h"
> -
> -/* BARs */
> -#define RDMA_MSIX_BAR_IDX    0
> -#define RDMA_REG_BAR_IDX     1
> -#define RDMA_UAR_BAR_IDX     2
> -#define RDMA_BAR0_MSIX_SIZE  (16 * KiB)
> -#define RDMA_BAR1_REGS_SIZE  64
> -#define RDMA_BAR2_UAR_SIZE   (0x1000 * MAX_UCS) /* each uc gets page */
> -
> -/* MSIX */
> -#define RDMA_MAX_INTRS       3
> -#define RDMA_MSIX_TABLE      0x0000
> -#define RDMA_MSIX_PBA        0x2000
> -
> -/* Interrupts Vectors */
> -#define INTR_VEC_CMD_RING            0
> -#define INTR_VEC_CMD_ASYNC_EVENTS    1
> -#define INTR_VEC_CMD_COMPLETION_Q    2
> -
> -/* HW attributes */
> -#define PVRDMA_HW_NAME       "pvrdma"
> -#define PVRDMA_HW_VERSION    17
> -#define PVRDMA_FW_VERSION    14
> -
> -/* Some defaults */
> -#define PVRDMA_PKEY          0xFFFF
> -
> -typedef struct DSRInfo {
> -    dma_addr_t dma;
> -    struct pvrdma_device_shared_region *dsr;
> -
> -    union pvrdma_cmd_req *req;
> -    union pvrdma_cmd_resp *rsp;
> -
> -    PvrdmaRingState *async_ring_state;
> -    PvrdmaRing async;
> -
> -    PvrdmaRingState *cq_ring_state;
> -    PvrdmaRing cq;
> -} DSRInfo;
> -
> -typedef struct PVRDMADevStats {
> -    uint64_t commands;
> -    uint64_t regs_reads;
> -    uint64_t regs_writes;
> -    uint64_t uar_writes;
> -    uint64_t interrupts;
> -} PVRDMADevStats;
> -
> -struct PVRDMADev {
> -    PCIDevice parent_obj;
> -    MemoryRegion msix;
> -    MemoryRegion regs;
> -    uint32_t regs_data[RDMA_BAR1_REGS_SIZE];
> -    MemoryRegion uar;
> -    uint32_t uar_data[RDMA_BAR2_UAR_SIZE];
> -    DSRInfo dsr_info;
> -    int interrupt_mask;
> -    struct ibv_device_attr dev_attr;
> -    uint64_t node_guid;
> -    char *backend_eth_device_name;
> -    char *backend_device_name;
> -    uint8_t backend_port_num;
> -    RdmaBackendDev backend_dev;
> -    RdmaDeviceResources rdma_dev_res;
> -    CharBackend mad_chr;
> -    VMXNET3State *func0;
> -    Notifier shutdown_notifier;
> -    PVRDMADevStats stats;
> -};
> -typedef struct PVRDMADev PVRDMADev;
> -DECLARE_INSTANCE_CHECKER(PVRDMADev, PVRDMA_DEV,
> -                         PVRDMA_HW_NAME)
> -
> -static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t *val=
)
> -{
> -    int idx =3D addr >> 2;
> -
> -    if (idx >=3D RDMA_BAR1_REGS_SIZE) {
> -        return -EINVAL;
> -    }
> -
> -    *val =3D dev->regs_data[idx];
> -
> -    return 0;
> -}
> -
> -static inline int set_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t val)
> -{
> -    int idx =3D addr >> 2;
> -
> -    if (idx >=3D RDMA_BAR1_REGS_SIZE) {
> -        return -EINVAL;
> -    }
> -
> -    dev->regs_data[idx] =3D val;
> -
> -    return 0;
> -}
> -
> -static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
> -{
> -    PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> -
> -    if (likely(!dev->interrupt_mask)) {
> -        dev->stats.interrupts++;
> -        msix_notify(pci_dev, vector);
> -    }
> -}
> -
> -int pvrdma_exec_cmd(PVRDMADev *dev);
> -
> -#endif
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.=
h
> deleted file mode 100644
> index d231588ce0..0000000000
> --- a/hw/rdma/vmw/pvrdma_dev_ring.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/*
> - * QEMU VMWARE paravirtual RDMA ring utilities
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef PVRDMA_DEV_RING_H
> -#define PVRDMA_DEV_RING_H
> -
> -
> -#define MAX_RING_NAME_SZ 32
> -
> -typedef struct PvrdmaRingState {
> -    int prod_tail; /* producer tail */
> -    int cons_head; /* consumer head */
> -} PvrdmaRingState;
> -
> -typedef struct PvrdmaRing {
> -    char name[MAX_RING_NAME_SZ];
> -    PCIDevice *dev;
> -    uint32_t max_elems;
> -    size_t elem_sz;
> -    PvrdmaRingState *ring_state; /* used only for unmap */
> -    int npages;
> -    void **pages;
> -} PvrdmaRing;
> -
> -int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
> -                     PvrdmaRingState *ring_state, uint32_t max_elems,
> -                     size_t elem_sz, dma_addr_t *tbl, uint32_t npages);
> -void *pvrdma_ring_next_elem_read(PvrdmaRing *ring);
> -void pvrdma_ring_read_inc(PvrdmaRing *ring);
> -void *pvrdma_ring_next_elem_write(PvrdmaRing *ring);
> -void pvrdma_ring_write_inc(PvrdmaRing *ring);
> -void pvrdma_ring_free(PvrdmaRing *ring);
> -
> -#endif
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
> deleted file mode 100644
> index bf2b15c5ce..0000000000
> --- a/hw/rdma/vmw/pvrdma_qp_ops.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * QEMU VMWARE paravirtual RDMA QP Operations
> - *
> - * Copyright (C) 2018 Oracle
> - * Copyright (C) 2018 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *     Marcel Apfelbaum <marcel@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef PVRDMA_QP_OPS_H
> -#define PVRDMA_QP_OPS_H
> -
> -#include "pvrdma.h"
> -
> -int pvrdma_qp_ops_init(void);
> -void pvrdma_qp_ops_fini(void);
> -void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle);
> -void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle);
> -void pvrdma_srq_recv(PVRDMADev *dev, uint32_t srq_handle);
> -void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle);
> -
> -#endif
> diff --git a/hw/rdma/vmw/trace.h b/hw/rdma/vmw/trace.h
> deleted file mode 100644
> index 3ebc9fb7ad..0000000000
> --- a/hw/rdma/vmw/trace.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include "trace/trace-hw_rdma_vmw.h"
> diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
> deleted file mode 100644
> index 80b2e531c4..0000000000
> --- a/include/hw/rdma/rdma.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/*
> - * RDMA device interface
> - *
> - * Copyright (C) 2019 Oracle
> - * Copyright (C) 2019 Red Hat Inc
> - *
> - * Authors:
> - *     Yuval Shaia <yuval.shaia@oracle.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef RDMA_H
> -#define RDMA_H
> -
> -#include "qom/object.h"
> -
> -#define INTERFACE_RDMA_PROVIDER "rdma"
> -
> -typedef struct RdmaProviderClass RdmaProviderClass;
> -DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,
> -                       INTERFACE_RDMA_PROVIDER)
> -#define RDMA_PROVIDER(obj) \
> -    INTERFACE_CHECK(RdmaProvider, (obj), \
> -                    INTERFACE_RDMA_PROVIDER)
> -
> -typedef struct RdmaProvider RdmaProvider;
> -
> -struct RdmaProviderClass {
> -    InterfaceClass parent;
> -
> -    void (*format_statistics)(RdmaProvider *obj, GString *buf);
> -};
> -
> -#endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 13f9a2dedb..f4cf8f6717 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -37,7 +37,6 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict);
>  void hmp_info_balloon(Monitor *mon, const QDict *qdict);
>  void hmp_info_irq(Monitor *mon, const QDict *qdict);
>  void hmp_info_pic(Monitor *mon, const QDict *qdict);
> -void hmp_info_rdma(Monitor *mon, const QDict *qdict);
>  void hmp_info_pci(Monitor *mon, const QDict *qdict);
>  void hmp_info_tpm(Monitor *mon, const QDict *qdict);
>  void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
> diff --git
> a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_ap=
i.h
> b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_ap=
i.h
> deleted file mode 100644
> index a5a1c8234e..0000000000
> ---
> a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_ap=
i.h
> +++ /dev/null
> @@ -1,685 +0,0 @@
> -/*
> - * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of EITHER the GNU General Public License
> - * version 2 as published by the Free Software Foundation or the BSD
> - * 2-Clause License. This program is distributed in the hope that it
> - * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
> - * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
> - * See the GNU General Public License version 2 for more details at
> - * <http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html>

--00000000000094637e0614b3cbfb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 27 mar 2024, 11:56 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">The whole RDMA subsystem was de=
precated in commit e9a54265f5<br>
(&quot;hw/rdma: Deprecate the pvrdma device and the rdma subsystem&quot;)<b=
r>
released in v8.2. Time to remove it.<br>
<br>
Keep the RAM_SAVE_FLAG_HOOK definition since it might appears<br>
in old migration streams.<br>
<br>
Remove the dependencies on libibumad and libibverbs.<br>
<br>
Remove the generated vmw_pvrdma/ directory from linux-headers.<br>
<br>
Remove RDMA handling from migration.<br>
<br>
Remove RDMA handling in GlusterFS block driver.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t think these two =
were deprecated? They are unrelated to pvrdma.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Remove rdmacm-mux tool from contrib/.<br>
<br>
Remove PVRDMA device.<br>
<br>
Cc: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">peterx@redhat.com</a>&gt;<br>
Cc: Li Zhijian &lt;<a href=3D"mailto:lizhijian@fujitsu.com" target=3D"_blan=
k" rel=3D"noreferrer">lizhijian@fujitsu.com</a>&gt;<br>
Cc: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">yuval.shaia.ml@gmail.com</a>&gt;<br>
Cc: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">marcel.apfelbaum@gmail.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A017 -<br>
=C2=A0docs/about/deprecated.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 -<br>
=C2=A0docs/about/removed-features.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +<br>
=C2=A0docs/devel/migration/main.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 -<br>
=C2=A0docs/pvrdma.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 345 --<b=
r>
=C2=A0docs/rdma.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 420 -=
-<br>
=C2=A0docs/system/device-url-syntax.rst.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 4 +-<br>
=C2=A0docs/system/loongarch/virt.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A0docs/system/qemu-block-drivers.rst.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 1 -<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A059 -<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A017 -<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A031 +-<br>
=C2=A0qapi/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 -<br>
=C2=A0qapi/rdma.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A038 -=
<br>
=C2=A0contrib/rdmacm-mux/rdmacm-mux.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A061 -<br>
=C2=A0hw/rdma/rdma_backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 129 -<br>
=C2=A0hw/rdma/rdma_backend_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A076 -<br>
=C2=A0hw/rdma/rdma_rm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A097 -<br>
=C2=A0hw/rdma/rdma_rm_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 146 -<br>
=C2=A0hw/rdma/rdma_utils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A063 -<br>
=C2=A0hw/rdma/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1=
 -<br>
=C2=A0hw/rdma/vmw/pvrdma.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 144 -<br>
=C2=A0hw/rdma/vmw/pvrdma_dev_ring.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A046 -<br>
=C2=A0hw/rdma/vmw/pvrdma_qp_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A028 -<br>
=C2=A0hw/rdma/vmw/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 -<br>
=C2=A0include/hw/rdma/rdma.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A037 -<br>
=C2=A0include/monitor/hmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 -<br>
=C2=A0.../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |=C2=A0 685 ---<br>
=C2=A0.../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h=C2=A0 =C2=A0|=C2=A0 348 -=
-<br>
=C2=A0.../standard-headers/rdma/vmw_pvrdma-abi.h=C2=A0 =C2=A0 |=C2=A0 310 -=
-<br>
=C2=A0migration/migration-stats.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +-<br>
=C2=A0migration/migration.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 -<br>
=C2=A0migration/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 -<br>
=C2=A0migration/rdma.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A069 -<br>
=C2=A0block/gluster.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A039=
 -<br>
=C2=A0contrib/rdmacm-mux/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 831 ----<br>
=C2=A0hw/core/machine-qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A032 -<br>
=C2=A0hw/rdma/rdma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A030 -=
<br>
=C2=A0hw/rdma/rdma_backend.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1401 ------<br>
=C2=A0hw/rdma/rdma_rm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 812 ----<br>
=C2=A0hw/rdma/rdma_utils.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 126 -<br>
=C2=A0hw/rdma/vmw/pvrdma_cmd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 815 ----<br>
=C2=A0hw/rdma/vmw/pvrdma_dev_ring.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 141 -<br>
=C2=A0hw/rdma/vmw/pvrdma_main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 735 ---<br>
=C2=A0hw/rdma/vmw/pvrdma_qp_ops.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 298 --<br>
=C2=A0migration/migration-stats.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 5 +-<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A031 -<br>
=C2=A0migration/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A016 -<br>
=C2=A0migration/qemu-file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 -<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A086=
 +-<br>
=C2=A0migration/rdma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4184 ---------------=
--<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A0monitor/qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -<br>
=C2=A0Kconfig.host=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 3 -<br>
=C2=A0contrib/rdmacm-mux/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 -<br>
=C2=A0hmp-commands-info.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A013 -<br>
=C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 1 -<br>
=C2=A0hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -=
<br>
=C2=A0hw/rdma/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3=
 -<br>
=C2=A0hw/rdma/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A012 -<br>
=C2=A0hw/rdma/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A031 -<br>
=C2=A0hw/rdma/vmw/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A017 -<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 -<br>
=C2=A0migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 -<br>
=C2=A0migration/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A068 +-<br>
=C2=A0qapi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6=
 -<br>
=C2=A0.../ci/org.centos/stream/8/x86_64/configure=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 1 -<br>
=C2=A0scripts/ci/setup/build-environment.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 2 -<br>
=C2=A0scripts/coverity-scan/run-coverity-scan=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 2 +-<br>
=C2=A0scripts/meson-buildoptions.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 -<br>
=C2=A0scripts/update-linux-headers.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A027 -<br>
=C2=A0tests/lcitool/projects/qemu.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 -<br>
=C2=A0tests/migration/guestperf/engine.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 4 +-<br>
=C2=A074 files changed, 20 insertions(+), 12991 deletions(-)<br>
=C2=A0delete mode 100644 docs/pvrdma.txt<br>
=C2=A0delete mode 100644 docs/rdma.txt<br>
=C2=A0delete mode 100644 qapi/rdma.json<br>
=C2=A0delete mode 100644 contrib/rdmacm-mux/rdmacm-mux.h<br>
=C2=A0delete mode 100644 hw/rdma/rdma_backend.h<br>
=C2=A0delete mode 100644 hw/rdma/rdma_backend_defs.h<br>
=C2=A0delete mode 100644 hw/rdma/rdma_rm.h<br>
=C2=A0delete mode 100644 hw/rdma/rdma_rm_defs.h<br>
=C2=A0delete mode 100644 hw/rdma/rdma_utils.h<br>
=C2=A0delete mode 100644 hw/rdma/trace.h<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma.h<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h<br>
=C2=A0delete mode 100644 hw/rdma/vmw/trace.h<br>
=C2=A0delete mode 100644 include/hw/rdma/rdma.h<br>
=C2=A0delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw=
_pvrdma/pvrdma_dev_api.h<br>
=C2=A0delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw=
_pvrdma/pvrdma_verbs.h<br>
=C2=A0delete mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h<br>
=C2=A0delete mode 100644 migration/rdma.h<br>
=C2=A0delete mode 100644 contrib/rdmacm-mux/main.c<br>
=C2=A0delete mode 100644 hw/rdma/rdma.c<br>
=C2=A0delete mode 100644 hw/rdma/rdma_backend.c<br>
=C2=A0delete mode 100644 hw/rdma/rdma_rm.c<br>
=C2=A0delete mode 100644 hw/rdma/rdma_utils.c<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma_cmd.c<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma_main.c<br>
=C2=A0delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c<br>
=C2=A0delete mode 100644 migration/rdma.c<br>
=C2=A0delete mode 100644 contrib/rdmacm-mux/meson.build<br>
=C2=A0delete mode 100644 hw/rdma/Kconfig<br>
=C2=A0delete mode 100644 hw/rdma/meson.build<br>
=C2=A0delete mode 100644 hw/rdma/trace-events<br>
=C2=A0delete mode 100644 hw/rdma/vmw/trace-events<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index a07af6b9d4..05226cea0a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3426,13 +3426,6 @@ F: docs/devel/migration.rst<br>
=C2=A0F: qapi/migration.json<br>
=C2=A0F: tests/migration/<br>
=C2=A0F: util/userfaultfd.c<br>
-X: migration/rdma*<br>
-<br>
-RDMA Migration<br>
-R: Li Zhijian &lt;<a href=3D"mailto:lizhijian@fujitsu.com" target=3D"_blan=
k" rel=3D"noreferrer">lizhijian@fujitsu.com</a>&gt;<br>
-R: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">peterx@redhat.com</a>&gt;<br>
-S: Odd Fixes<br>
-F: migration/rdma*<br>
<br>
=C2=A0Migration dirty limit and dirty page rate<br>
=C2=A0M: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank" rel=3D"noreferrer">yong.huang@smartx.com</a>&gt;<br>
@@ -4060,16 +4053,6 @@ F: block/replication.c<br>
=C2=A0F: tests/unit/test-replication.c<br>
=C2=A0F: docs/block-replication.txt<br>
<br>
-PVRDMA<br>
-M: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">yuval.shaia.ml@gmail.com</a>&gt;<br>
-M: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">marcel.apfelbaum@gmail.com</a>&gt;<br>
-S: Odd Fixes<br>
-F: hw/rdma/*<br>
-F: hw/rdma/vmw/*<br>
-F: docs/pvrdma.txt<br>
-F: contrib/rdmacm-mux/*<br>
-F: qapi/rdma.json<br>
-<br>
=C2=A0Semihosting<br>
=C2=A0M: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" tar=
get=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br>
=C2=A0S: Maintained<br>
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst<br>
index 7b548519b5..29eae69e50 100644<br>
--- a/docs/about/deprecated.rst<br>
+++ b/docs/about/deprecated.rst<br>
@@ -376,15 +376,6 @@ recommending to switch to their stable counterparts:<b=
r>
=C2=A0- &quot;Zve64f&quot; should be replaced with &quot;zve64f&quot;<br>
=C2=A0- &quot;Zve64d&quot; should be replaced with &quot;zve64d&quot;<br>
<br>
-``-device pvrdma`` and the rdma subsystem (since 8.2)<br>
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
-<br>
-The pvrdma device and the whole rdma subsystem are in a bad shape and<br>
-without active maintenance. The QEMU project intends to remove this<br>
-device and subsystem from the code base in a future release without<br>
-replacement unless somebody steps up and improves the situation.<br>
-<br>
-<br>
=C2=A0Block device options<br>
=C2=A0&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;<br>
<br>
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.=
rst<br>
index f9cf874f7b..4d5bdc43b4 100644<br>
--- a/docs/about/removed-features.rst<br>
+++ b/docs/about/removed-features.rst<br>
@@ -909,6 +909,10 @@ contains native support for this feature and thus use =
of the option<br>
=C2=A0ROM approach was obsolete. The native SeaBIOS support can be activate=
d<br>
=C2=A0by using ``-machine graphics=3Doff``.<br>
<br>
+``pvrdma`` and the RDMA subsystem (removed in 9.1)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+The &#39;pvrdma&#39; device and the whole RDMA subsystem have been removed=
.<br>
<br>
=C2=A0Related binaries<br>
=C2=A0----------------<br>
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst<=
br>
index 54385a23e5..70278ce1e3 100644<br>
--- a/docs/devel/migration/main.rst<br>
+++ b/docs/devel/migration/main.rst<br>
@@ -47,12 +47,6 @@ over any transport.<br>
=C2=A0 =C2=A0QEMU interference. Note that QEMU does not flush cached file<b=
r>
=C2=A0 =C2=A0data/metadata at the end of migration.<br>
<br>
-In addition, support is included for migration using RDMA, which<br>
-transports the page data using ``RDMA``, where the hardware takes care of<=
br>
-transporting the pages, and the load on the CPU is much lower.=C2=A0 While=
 the<br>
-internals of RDMA migration are a bit different, this isn&#39;t really vis=
ible<br>
-outside the RAM migration code.<br>
-<br>
=C2=A0All these migration protocols use the same infrastructure to<br>
=C2=A0save/restore state devices.=C2=A0 This infrastructure is shared with =
the<br>
=C2=A0savevm/loadvm functionality.<br>
diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt<br>
deleted file mode 100644<br>
index 5c122fe818..0000000000<br>
--- a/docs/pvrdma.txt<br>
+++ /dev/null<br>
@@ -1,345 +0,0 @@<br>
-Paravirtualized RDMA Device (PVRDMA)<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-<br>
-1. Description<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-PVRDMA is the QEMU implementation of VMware&#39;s paravirtualized RDMA dev=
ice.<br>
-It works with its Linux Kernel driver AS IS, no need for any special guest=
<br>
-modifications.<br>
-<br>
-While it complies with the VMware device, it can also communicate with bar=
e<br>
-metal RDMA-enabled machines as peers.<br>
-<br>
-It does not require an RDMA HCA in the host, it can work with Soft-RoCE (r=
xe).<br>
-<br>
-It does not require the whole guest RAM to be pinned allowing memory<br>
-over-commit and, even if not implemented yet, migration support will be<br=
>
-possible with some HW assistance.<br>
-<br>
-A project presentation accompany this document:<br>
-- <a href=3D"https://blog.linuxplumbersconf.org/2017/ocw/system/presentati=
ons/4730/original/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://blog.linuxplumbersconf.org=
/2017/ocw/system/presentations/4730/original/lpc-2017-pvrdma-marcel-apfelba=
um-yuval-shaia.pdf</a><br>
-<br>
-<br>
-<br>
-2. Setup<br>
-=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-<br>
-2.1 Guest setup<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-Fedora 27+ kernels work out of the box, older distributions<br>
-require updating the kernel to 4.14 to include the pvrdma driver.<br>
-<br>
-However the libpvrdma library needed by User Level Software is still<br>
-not available as part of the distributions, so the rdma-core library<br>
-needs to be compiled and optionally installed.<br>
-<br>
-Please follow the instructions at:<br>
-=C2=A0 <a href=3D"https://github.com/linux-rdma/rdma-core.git" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">https://github.com/linux-rdma/rdma-cor=
e.git</a><br>
-<br>
-<br>
-2.2 Host Setup<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-The pvrdma backend is an ibdevice interface that can be exposed<br>
-either by a Soft-RoCE(rxe) device on machines with no RDMA device,<br>
-or an HCA SRIOV function(VF/PF).<br>
-Note that ibdevice interfaces can&#39;t be shared between pvrdma devices,<=
br>
-each one requiring a separate instance (rxe or SRIOV VF).<br>
-<br>
-<br>
-2.2.1 Soft-RoCE backend(rxe)<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
-A stable version of rxe is required, Fedora 27+ or a Linux<br>
-Kernel 4.14+ is preferred.<br>
-<br>
-The rdma_rxe module is part of the Linux Kernel but not loaded by default.=
<br>
-Install the User Level library (librxe) following the instructions from:<b=
r>
-<a href=3D"https://github.com/SoftRoCE/rxe-dev/wiki/rxe-dev:-Home" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://github.com/SoftRoCE/rxe-de=
v/wiki/rxe-dev:-Home</a><br>
-<br>
-Associate an ETH interface with rxe by running:<br>
-=C2=A0 =C2=A0rxe_cfg add eth0<br>
-An rxe0 ibdevice interface will be created and can be used as pvrdma backe=
nd.<br>
-<br>
-<br>
-2.2.2 RDMA device Virtual Function backend<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-Nothing special is required, the pvrdma device can work not only with<br>
-Ethernet Links, but also Infinibands Links.<br>
-All is needed is an ibdevice with an active port, for Mellanox cards<br>
-will be something like mlx5_6 which can be the backend.<br>
-<br>
-<br>
-2.2.3 QEMU setup<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-Configure QEMU with --enable-rdma flag, installing<br>
-the required RDMA libraries.<br>
-<br>
-<br>
-<br>
-3. Usage<br>
-=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-<br>
-3.1 VM Memory settings<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-Currently the device is working only with memory backed RAM<br>
-and it must be mark as &quot;shared&quot;:<br>
-=C2=A0 =C2=A0-m 1G \<br>
-=C2=A0 =C2=A0-object memory-backend-ram,id=3Dmb1,size=3D1G,share \<br>
-=C2=A0 =C2=A0-numa node,memdev=3Dmb1 \<br>
-<br>
-<br>
-3.2 MAD Multiplexer<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-MAD Multiplexer is a service that exposes MAD-like interface for VMs in<br=
>
-order to overcome the limitation where only single entity can register wit=
h<br>
-MAD layer to send and receive RDMA-CM MAD packets.<br>
-<br>
-To build rdmacm-mux run<br>
-# make rdmacm-mux<br>
-<br>
-Before running the rdmacm-mux make sure that both ib_cm and rdma_cm kernel=
<br>
-modules aren&#39;t loaded, otherwise the rdmacm-mux service will fail to s=
tart.<br>
-<br>
-The application accepts 3 command line arguments and exposes a UNIX socket=
<br>
-to pass control and data to it.<br>
--d rdma-device-name=C2=A0 Name of RDMA device to register with<br>
--s unix-socket-path=C2=A0 Path to unix socket to listen (default /var/run/=
rdmacm-mux)<br>
--p rdma-device-port=C2=A0 Port number of RDMA device to register with (def=
ault 1)<br>
-The final UNIX socket file name is a concatenation of the 3 arguments so<b=
r>
-for example for device mlx5_0 on port 2 this /var/run/rdmacm-mux-mlx5_0-2<=
br>
-will be created.<br>
-<br>
-pvrdma requires this service.<br>
-<br>
-Please refer to contrib/rdmacm-mux for more details.<br>
-<br>
-<br>
-3.3 Service exposed by libvirt daemon<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-The control over the RDMA device&#39;s GID table is done by updating the<b=
r>
-device&#39;s Ethernet function addresses.<br>
-Usually the first GID entry is determined by the MAC address, the second b=
y<br>
-the first IPv6 address and the third by the IPv4 address. Other entries ca=
n<br>
-be added by adding more IP addresses. The opposite is the same, i.e.<br>
-whenever an address is removed, the corresponding GID entry is removed.<br=
>
-The process is done by the network and RDMA stacks. Whenever an address is=
<br>
-added the ib_core driver is notified and calls the device driver add_gid<b=
r>
-function which in turn update the device.<br>
-To support this in pvrdma device the device hooks into the create_bind and=
<br>
-destroy_bind HW commands triggered by pvrdma driver in guest.<br>
-<br>
-Whenever changed is made to the pvrdma port&#39;s GID table a special QMP<=
br>
-messages is sent to be processed by libvirt to update the address of the<b=
r>
-backend Ethernet device.<br>
-<br>
-pvrdma requires that libvirt service will be up.<br>
-<br>
-<br>
-3.4 PCI devices settings<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r>
-RoCE device exposes two functions - an Ethernet and RDMA.<br>
-To support it, pvrdma device is composed of two PCI functions, an Ethernet=
<br>
-device of type vmxnet3 on PCI slot 0 and a PVRDMA device on PCI slot 1. Th=
e<br>
-Ethernet function can be used for other Ethernet purposes such as IP.<br>
-<br>
-<br>
-3.5 Device parameters<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-- netdev: Specifies the Ethernet device function name on the host for<br>
-=C2=A0 example enp175s0f0. For Soft-RoCE device (rxe) this would be the Et=
hernet<br>
-=C2=A0 device used to create it.<br>
-- ibdev: The IB device name on host for example rxe0, mlx5_0 etc.<br>
-- mad-chardev: The name of the MAD multiplexer char device.<br>
-- ibport: In case of multi-port device (such as Mellanox&#39;s HCA) this<b=
r>
-=C2=A0 specify the port to use. If not set 1 will be used.<br>
-- dev-caps-max-mr-size: The maximum size of MR.<br>
-- dev-caps-max-qp:=C2=A0 =C2=A0 =C2=A0 Maximum number of QPs.<br>
-- dev-caps-max-cq:=C2=A0 =C2=A0 =C2=A0 Maximum number of CQs.<br>
-- dev-caps-max-mr:=C2=A0 =C2=A0 =C2=A0 Maximum number of MRs.<br>
-- dev-caps-max-pd:=C2=A0 =C2=A0 =C2=A0 Maximum number of PDs.<br>
-- dev-caps-max-ah:=C2=A0 =C2=A0 =C2=A0 Maximum number of AHs.<br>
-<br>
-Notes:<br>
-- The first 3 parameters are mandatory settings, the rest have their<br>
-=C2=A0 defaults.<br>
-- The last 8 parameters (the ones that prefixed by dev-caps) defines the t=
op<br>
-=C2=A0 limits but the final values is adjusted by the backend device limit=
ations.<br>
-- netdev can be extracted from ibdev&#39;s sysfs<br>
-=C2=A0 (/sys/class/infiniband/&lt;ibdev&gt;/device/net/)<br>
-<br>
-<br>
-3.6 Example<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-Define bridge device with vmxnet3 network backend:<br>
-&lt;interface type=3D&#39;bridge&#39;&gt;<br>
-=C2=A0 &lt;mac address=3D&#39;56:b4:44:e9:62:dc&#39;/&gt;<br>
-=C2=A0 &lt;source bridge=3D&#39;bridge1&#39;/&gt;<br>
-=C2=A0 &lt;model type=3D&#39;vmxnet3&#39;/&gt;<br>
-=C2=A0 &lt;address type=3D&#39;pci&#39; domain=3D&#39;0x0000&#39; bus=3D&#=
39;0x00&#39; slot=3D&#39;0x10&#39; function=3D&#39;0x0&#39; multifunction=
=3D&#39;on&#39;/&gt;<br>
-&lt;/interface&gt;<br>
-<br>
-Define pvrdma device:<br>
-&lt;qemu:commandline&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;-object&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;memory-backend-ram,id=3Dmb1,size=3D1G,sha=
re&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;-numa&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;node,memdev=3Dmb1&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;-chardev&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;socket,path=3D/var/run/rdmacm-mux-rxe0-1,=
id=3Dmads&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;-device&#39;/&gt;<br>
-=C2=A0 &lt;qemu:arg value=3D&#39;pvrdma,addr=3D10.1,ibdev=3Drxe0,netdev=3D=
bridge0,mad-chardev=3Dmads&#39;/&gt;<br>
-&lt;/qemu:commandline&gt;<br>
-<br>
-<br>
-<br>
-4. Implementation details<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
-<br>
-<br>
-4.1 Overview<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-The device acts like a proxy between the Guest Driver and the host<br>
-ibdevice interface.<br>
-On configuration path:<br>
- - For every hardware resource request (PD/QP/CQ/...) the pvrdma will requ=
est<br>
-=C2=A0 =C2=A0a resource from the backend interface, maintaining a 1-1 mapp=
ing<br>
-=C2=A0 =C2=A0between the guest and host.<br>
-On data path:<br>
- - Every post_send/receive received from the guest will be converted into<=
br>
-=C2=A0 =C2=A0a post_send/receive for the backend. The buffers data will no=
t be touched<br>
-=C2=A0 =C2=A0or copied resulting in near bare-metal performance for large =
enough buffers.<br>
- - Completions from the backend interface will result in completions for<b=
r>
-=C2=A0 =C2=A0the pvrdma device.<br>
-<br>
-<br>
-4.2 PCI BARs<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-PCI Bars:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BAR 0 - MSI-X<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSI-X vectors:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0) Command - used =
when execution of a command is completed.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1) Async - not in =
use.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(2) Completion - us=
ed when a completion event is placed in<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device&#39;s=
 CQ ring.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BAR 1 - Registers<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----------------------------------------------=
----------<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | VERSION |=C2=A0 DSR | CTL | REQ | ERR |=C2=
=A0 ICR | IMR=C2=A0 | MAC |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----------------------------------------------=
----------<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSR - Address of dr=
iver/device shared memory used<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for the command channel, =
used for passing:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- General info such as driver version<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- Address of &#39;command&#39; and &#39;response&#3=
9;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- Address of async ring<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- Address of device&#39;s CQ ring<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- Device capabilities<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CTL - Device contro=
l operations (activate, reset etc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IMG - Set interrupt=
 mask<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REQ - Command execu=
tion register<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR - Operation sta=
tus<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BAR 2 - UAR<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----------------------------------------------=
-----------<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | QP_NUM=C2=A0 | SEND/RECV Flag ||=C2=A0 CQ_NU=
M |=C2=A0 =C2=A0ARM/POLL Flag |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----------------------------------------------=
-----------<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Offset 0 used for=
 QP operations (send and recv)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Offset 4 used for=
 CQ operations (arm and poll)<br>
-<br>
-<br>
-4.3 Major flows<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-4.3.1 Create CQ<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-=C2=A0 =C2=A0 - Guest driver<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Allocates pages for CQ ring<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Creates page directory (pdir) to hold CQ rin=
g&#39;s pages<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Initializes CQ ring<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Initializes &#39;Create CQ&#39; command obje=
ct (cqe, pdir etc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Copies the command to &#39;command&#39; addr=
ess<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Writes 0 into REQ register<br>
-=C2=A0 =C2=A0 - Device<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Reads the request object from the &#39;comma=
nd&#39; address<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Allocates CQ object and initialize CQ ring b=
ased on pdir<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Creates the backend CQ<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Writes operation status to ERR register<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Posts command-interrupt to guest<br>
-=C2=A0 =C2=A0 - Guest driver<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Reads the HW response code from ERR register=
<br>
-<br>
-4.3.2 Create QP<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-=C2=A0 =C2=A0 - Guest driver<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Allocates pages for send and receive rings<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Creates page directory(pdir) to hold the rin=
g&#39;s pages<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Initializes &#39;Create QP&#39; command obje=
ct (max_send_wr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_cq_handle, recv_cq_handle, pdir et=
c)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Copies the object to &#39;command&#39; addre=
ss<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Write 0 into REQ register<br>
-=C2=A0 =C2=A0 - Device<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Reads the request object from &#39;command&#=
39; address<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Allocates the QP object and initialize<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Send and recv rings based on p=
dir<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Send and recv ring state<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Creates the backend QP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Writes the operation status to ERR register<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Posts command-interrupt to guest<br>
-=C2=A0 =C2=A0 - Guest driver<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Reads the HW response code from ERR register=
<br>
-<br>
-4.3.3 Post receive<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-=C2=A0 =C2=A0 - Guest driver<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Initializes a wqe and place it on recv ring<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Write to qpn|qp_recv_bit (31) to QP offset i=
n UAR<br>
-=C2=A0 =C2=A0 - Device<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Extracts qpn from UAR<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Walks through the ring and does the followin=
g for each wqe<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Prepares the backend CQE conte=
xt to be used when<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receiving completion from=
 backend (wr_id, op_code, emu_cq_num)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - For each sge prepares backend =
sge<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Calls backend&#39;s post_recv<=
br>
-<br>
-4.3.4 Process backend events<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
-=C2=A0 =C2=A0 - Done by a dedicated thread used to process backend events;=
<br>
-=C2=A0 =C2=A0 =C2=A0 at initialization is attached to the device and creat=
es<br>
-=C2=A0 =C2=A0 =C2=A0 the communication channel.<br>
-=C2=A0 =C2=A0 - Thread main loop:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Polls for completions<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Extracts QEMU _cq_num, wr_id and op_code fro=
m context<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Writes CQE to CQ ring<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Writes CQ number to device CQ<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Sends completion-interrupt to guest<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Deallocates context<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Acks the event to backend<br>
-<br>
-<br>
-<br>
-5. Limitations<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-- The device obviously is limited by the Guest Linux Driver features imple=
mentation<br>
-=C2=A0 of the VMware device API.<br>
-- Memory registration mechanism requires mremap for every page in the buff=
er in order<br>
-=C2=A0 to map it to a contiguous virtual address range. Since this is not =
the data path<br>
-=C2=A0 it should not matter much. If the default max mr size is increased,=
 be aware that<br>
-=C2=A0 memory registration can take up to 0.5 seconds for 1GB of memory.<b=
r>
-- The device requires target page size to be the same as the host page siz=
e,<br>
-=C2=A0 otherwise it will fail to init.<br>
-- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is a=
ttached,<br>
-=C2=A0 so it can&#39;t work with huge pages. The limitation will be addres=
sed in the future,<br>
-=C2=A0 however QEMU allocates Guest RAM with MADV_HUGEPAGE so if there are=
 enough huge<br>
-=C2=A0 pages available, QEMU will use them. QEMU will fail to init if the =
requirements<br>
-=C2=A0 are not met.<br>
-<br>
-<br>
-<br>
-6. Performance<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-By design the pvrdma device exits on each post-send/receive, so for small =
buffers<br>
-the performance is affected; however for medium buffers it will became clo=
se to<br>
-bare metal and from 1MB buffers and=C2=A0 up it reaches bare metal perform=
ance.<br>
-(tested with 2 VMs, the pvrdma devices connected to 2 VFs of the same devi=
ce)<br>
-<br>
-All the above assumes no memory registration is done on data path.<br>
diff --git a/docs/rdma.txt b/docs/rdma.txt<br>
deleted file mode 100644<br>
index bd8dd799a9..0000000000<br>
--- a/docs/rdma.txt<br>
+++ /dev/null<br>
@@ -1,420 +0,0 @@<br>
-(RDMA: Remote Direct Memory Access)<br>
-RDMA Live Migration Specification, Version # 1<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-Wiki: <a href=3D"https://wiki.qemu.org/Features/RDMALiveMigration" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://wiki.qemu.org/Features/RDM=
ALiveMigration</a><br>
-Github: git@github.com:hinesmr/qemu.git, &#39;rdma&#39; branch<br>
-<br>
-Copyright (C) 2013 Michael R. Hines &lt;<a href=3D"mailto:mrhines@us.ibm.c=
om" target=3D"_blank" rel=3D"noreferrer">mrhines@us.ibm.com</a>&gt;<br>
-<br>
-An *exhaustive* paper (2010) shows additional performance details<br>
-linked on the QEMU wiki above.<br>
-<br>
-Contents:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-* Introduction<br>
-* Before running<br>
-* Running<br>
-* Performance<br>
-* RDMA Migration Protocol Description<br>
-* Versioning and Capabilities<br>
-* QEMUFileRDMA Interface<br>
-* Migration of VM&#39;s ram<br>
-* Error handling<br>
-* TODO<br>
-<br>
-Introduction:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-RDMA helps make your migration more deterministic under heavy load because=
<br>
-of the significantly lower latency and higher throughput over TCP/IP. This=
 is<br>
-because the RDMA I/O architecture reduces the number of interrupts and<br>
-data copies by bypassing the host networking stack. In particular, a TCP-b=
ased<br>
-migration, under certain types of memory-bound workloads, may take a more<=
br>
-unpredictable amount of time to complete the migration if the amount of<br=
>
-memory tracked during each live migration iteration round cannot keep pace=
<br>
-with the rate of dirty memory produced by the workload.<br>
-<br>
-RDMA currently comes in two flavors: both Ethernet based (RoCE, or RDMA<br=
>
-over Converged Ethernet) as well as Infiniband-based. This implementation =
of<br>
-migration using RDMA is capable of using both technologies because of<br>
-the use of the OpenFabrics OFED software stack that abstracts out the<br>
-programming model irrespective of the underlying hardware.<br>
-<br>
-Refer to <a href=3D"http://openfabrics.org" rel=3D"noreferrer noreferrer" =
target=3D"_blank">openfabrics.org</a> or your respective RDMA hardware vend=
or for<br>
-an understanding on how to verify that you have the OFED software stack<br=
>
-installed in your environment. You should be able to successfully link<br>
-against the &quot;librdmacm&quot; and &quot;libibverbs&quot; libraries and=
 development headers<br>
-for a working build of QEMU to run successfully using RDMA Migration.<br>
-<br>
-BEFORE RUNNING:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-Use of RDMA during migration requires pinning and registering memory<br>
-with the hardware. This means that memory must be physically resident<br>
-before the hardware can transmit that memory to another machine.<br>
-If this is not acceptable for your application or product, then the use<br=
>
-of RDMA migration may in fact be harmful to co-located VMs or other<br>
-software on the machine if there is not sufficient memory available to<br>
-relocate the entire footprint of the virtual machine. If so, then the<br>
-use of RDMA is discouraged and it is recommended to use standard TCP migra=
tion.<br>
-<br>
-Experimental: Next, decide if you want dynamic page registration.<br>
-For example, if you have an 8GB RAM virtual machine, but only 1GB<br>
-is in active use, then enabling this feature will cause all 8GB to<br>
-be pinned and resident in memory. This feature mostly affects the<br>
-bulk-phase round of the migration and can be enabled for extremely<br>
-high-performance RDMA hardware using the following command:<br>
-<br>
-QEMU Monitor Command:<br>
-$ migrate_set_capability rdma-pin-all on # disabled by default<br>
-<br>
-Performing this action will cause all 8GB to be pinned, so if that&#39;s<b=
r>
-not what you want, then please ignore this step altogether.<br>
-<br>
-On the other hand, this will also significantly speed up the bulk round<br=
>
-of the migration, which can greatly reduce the &quot;total&quot; time of y=
our migration.<br>
-Example performance of this using an idle VM in the previous example<br>
-can be found in the &quot;Performance&quot; section.<br>
-<br>
-Note: for very large virtual machines (hundreds of GBs), pinning all<br>
-*all* of the memory of your virtual machine in the kernel is very expensiv=
e<br>
-may extend the initial bulk iteration time by many seconds,<br>
-and thus extending the total migration time. However, this will not<br>
-affect the determinism or predictability of your migration you will<br>
-still gain from the benefits of advanced pinning with RDMA.<br>
-<br>
-RUNNING:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-First, set the migration speed to match your hardware&#39;s capabilities:<=
br>
-<br>
-QEMU Monitor Command:<br>
-$ migrate_set_parameter max-bandwidth 40g # or whatever is the MAX of your=
 RDMA device<br>
-<br>
-Next, on the destination machine, add the following to the QEMU command li=
ne:<br>
-<br>
-qemu ..... -incoming rdma:host:port<br>
-<br>
-Finally, perform the actual migration on the source machine:<br>
-<br>
-QEMU Monitor Command:<br>
-$ migrate -d rdma:host:port<br>
-<br>
-PERFORMANCE<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-Here is a brief summary of total migration time and downtime using RDMA:<b=
r>
-Using a 40gbps infiniband link performing a worst-case stress test,<br>
-using an 8GB RAM virtual machine:<br>
-<br>
-Using the following command:<br>
-$ apt-get install stress<br>
-$ stress --vm-bytes 7500M --vm 1 --vm-keep<br>
-<br>
-1. Migration throughput: 26 gigabits/second.<br>
-2. Downtime (stop time) varies between 15 and 100 milliseconds.<br>
-<br>
-EFFECTS of memory registration on bulk phase round:<br>
-<br>
-For example, in the same 8GB RAM example with all 8GB of memory in<br>
-active use and the VM itself is completely idle using the same 40 gbps<br>
-infiniband link:<br>
-<br>
-1. rdma-pin-all disabled total time: approximately 7.5 seconds @ 9.5 Gbps<=
br>
-2. rdma-pin-all enabled total time: approximately 4 seconds @ 26 Gbps<br>
-<br>
-These numbers would of course scale up to whatever size virtual machine<br=
>
-you have to migrate using RDMA.<br>
-<br>
-Enabling this feature does *not* have any measurable affect on<br>
-migration *downtime*. This is because, without this feature, all of the<br=
>
-memory will have already been registered already in advance during<br>
-the bulk round and does not need to be re-registered during the successive=
<br>
-iteration rounds.<br>
-<br>
-RDMA Protocol Description:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
-<br>
-Migration with RDMA is separated into two parts:<br>
-<br>
-1. The transmission of the pages using RDMA<br>
-2. Everything else (a control channel is introduced)<br>
-<br>
-&quot;Everything else&quot; is transmitted using a formal<br>
-protocol now, consisting of infiniband SEND messages.<br>
-<br>
-An infiniband SEND message is the standard ibverbs<br>
-message used by applications of infiniband hardware.<br>
-The only difference between a SEND message and an RDMA<br>
-message is that SEND messages cause notifications<br>
-to be posted to the completion queue (CQ) on the<br>
-infiniband receiver side, whereas RDMA messages (used<br>
-for VM&#39;s ram) do not (to behave like an actual DMA).<br>
-<br>
-Messages in infiniband require two things:<br>
-<br>
-1. registration of the memory that will be transmitted<br>
-2. (SEND only) work requests to be posted on both<br>
-=C2=A0 =C2=A0sides of the network before the actual transmission<br>
-=C2=A0 =C2=A0can occur.<br>
-<br>
-RDMA messages are much easier to deal with. Once the memory<br>
-on the receiver side is registered and pinned, we&#39;re<br>
-basically done. All that is required is for the sender<br>
-side to start dumping bytes onto the link.<br>
-<br>
-(Memory is not released from pinning until the migration<br>
-completes, given that RDMA migrations are very fast.)<br>
-<br>
-SEND messages require more coordination because the<br>
-receiver must have reserved space (using a receive<br>
-work request) on the receive queue (RQ) before QEMUFileRDMA<br>
-can start using them to carry all the bytes as<br>
-a control transport for migration of device state.<br>
-<br>
-To begin the migration, the initial connection setup is<br>
-as follows (migration-rdma.c):<br>
-<br>
-1. Receiver and Sender are started (command line or libvirt):<br>
-2. Both sides post two RQ work requests<br>
-3. Receiver does listen()<br>
-4. Sender does connect()<br>
-5. Receiver accept()<br>
-6. Check versioning and capabilities (described later)<br>
-<br>
-At this point, we define a control channel on top of SEND messages<br>
-which is described by a formal protocol. Each SEND message has a<br>
-header portion and a data portion (but together are transmitted<br>
-as a single SEND message).<br>
-<br>
-Header:<br>
-=C2=A0 =C2=A0 * Length=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(of the data portion, uint32, network byte order)<br>
-=C2=A0 =C2=A0 * Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(what command to perform, uint32, network byte order)<br>
-=C2=A0 =C2=A0 * Repeat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(Number of commands in data portion, same type only)<br>
-<br>
-The &#39;Repeat&#39; field is here to support future multiple page registr=
ations<br>
-in a single message without any need to change the protocol itself<br>
-so that the protocol is compatible against multiple versions of QEMU.<br>
-Version #1 requires that all server implementations of the protocol must<b=
r>
-check this field and register all requests found in the array of commands =
located<br>
-in the data portion and return an equal number of results in the response.=
<br>
-The maximum number of repeats is hard-coded to 4096. This is a conservativ=
e<br>
-limit based on the maximum size of a SEND message along with empirical<br>
-observations on the maximum future benefit of simultaneous page registrati=
ons.<br>
-<br>
-The &#39;type&#39; field has 12 different command values:<br>
-=C2=A0 =C2=A0 =C2=A01. Unused<br>
-=C2=A0 =C2=A0 =C2=A02. Error=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (sent to the source during bad things)<br>
-=C2=A0 =C2=A0 =C2=A03. Ready=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (control-channel is available)<br>
-=C2=A0 =C2=A0 =C2=A04. QEMU File=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (for sending non-live device state)<br>
-=C2=A0 =C2=A0 =C2=A05. RAM Blocks request=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(used right after connection setup)<br>
-=C2=A0 =C2=A0 =C2=A06. RAM Blocks result=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (used right after connection setup)<br>
-=C2=A0 =C2=A0 =C2=A07. Compress page=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (zap zero page and skip registration)<br>
-=C2=A0 =C2=A0 =C2=A08. Register request=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(dynamic chunk registration)<br>
-=C2=A0 =C2=A0 =C2=A09. Register result=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (&#39;rkey&#39; to be used by sender)<br>
-=C2=A0 =C2=A0 10. Register finished=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (reg=
istration for current iteration finished)<br>
-=C2=A0 =C2=A0 11. Unregister request=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unp=
in previously registered memory)<br>
-=C2=A0 =C2=A0 12. Unregister finished=C2=A0 =C2=A0 =C2=A0 =C2=A0 (confirma=
tion that unpin completed)<br>
-<br>
-A single control message, as hinted above, can contain within the data<br>
-portion an array of many commands of the same type. If there is more than<=
br>
-one command, then the &#39;repeat&#39; field will be greater than 1.<br>
-<br>
-After connection setup, message 5 &amp; 6 are used to exchange ram block<b=
r>
-information and optionally pin all the memory if requested by the user.<br=
>
-<br>
-After ram block exchange is completed, we have two protocol-level<br>
-functions, responsible for communicating control-channel commands<br>
-using the above list of values:<br>
-<br>
-Logically:<br>
-<br>
-qemu_rdma_exchange_recv(header, expected command type)<br>
-<br>
-1. We transmit a READY command to let the sender know that<br>
-=C2=A0 =C2=A0we are *ready* to receive some data bytes on the control chan=
nel.<br>
-2. Before attempting to receive the expected command, we post another<br>
-=C2=A0 =C2=A0RQ work request to replace the one we just used up.<br>
-3. Block on a CQ event channel and wait for the SEND to arrive.<br>
-4. When the send arrives, librdmacm will unblock us.<br>
-5. Verify that the command-type and version received matches the one we ex=
pected.<br>
-<br>
-qemu_rdma_exchange_send(header, data, optional response header &amp; data)=
:<br>
-<br>
-1. Block on the CQ event channel waiting for a READY command<br>
-=C2=A0 =C2=A0from the receiver to tell us that the receiver<br>
-=C2=A0 =C2=A0is *ready* for us to transmit some new bytes.<br>
-2. Optionally: if we are expecting a response from the command<br>
-=C2=A0 =C2=A0(that we have not yet transmitted), let&#39;s post an RQ<br>
-=C2=A0 =C2=A0work request to receive that data a few moments later.<br>
-3. When the READY arrives, librdmacm will<br>
-=C2=A0 =C2=A0unblock us and we immediately post a RQ work request<br>
-=C2=A0 =C2=A0to replace the one we just used up.<br>
-4. Now, we can actually post the work request to SEND<br>
-=C2=A0 =C2=A0the requested command type of the header we were asked for.<b=
r>
-5. Optionally, if we are expecting a response (as before),<br>
-=C2=A0 =C2=A0we block again and wait for that response using the additiona=
l<br>
-=C2=A0 =C2=A0work request we previously posted. (This is used to carry<br>
-=C2=A0 =C2=A0&#39;Register result&#39; commands #6 back to the sender whic=
h<br>
-=C2=A0 =C2=A0hold the rkey need to perform RDMA. Note that the virtual add=
ress<br>
-=C2=A0 =C2=A0corresponding to this rkey was already exchanged at the begin=
ning<br>
-=C2=A0 =C2=A0of the connection (described below).<br>
-<br>
-All of the remaining command types (not including &#39;ready&#39;)<br>
-described above all use the aforementioned two functions to do the hard wo=
rk:<br>
-<br>
-1. After connection setup, RAMBlock information is exchanged using<br>
-=C2=A0 =C2=A0this protocol before the actual migration begins. This inform=
ation includes<br>
-=C2=A0 =C2=A0a description of each RAMBlock on the server side as well as =
the virtual addresses<br>
-=C2=A0 =C2=A0and lengths of each RAMBlock. This is used by the client to d=
etermine the<br>
-=C2=A0 =C2=A0start and stop locations of chunks and how to register them d=
ynamically<br>
-=C2=A0 =C2=A0before performing the RDMA operations.<br>
-2. During runtime, once a &#39;chunk&#39; becomes full of pages ready to<b=
r>
-=C2=A0 =C2=A0be sent with RDMA, the registration commands are used to ask =
the<br>
-=C2=A0 =C2=A0other side to register the memory for this chunk and respond<=
br>
-=C2=A0 =C2=A0with the result (rkey) of the registration.<br>
-3. Also, the QEMUFile interfaces also call these functions (described belo=
w)<br>
-=C2=A0 =C2=A0when transmitting non-live state, such as devices or to send<=
br>
-=C2=A0 =C2=A0its own protocol information during the migration process.<br=
>
-4. Finally, zero pages are only checked if a page has not yet been registe=
red<br>
-=C2=A0 =C2=A0using chunk registration (or not checked at all and unconditi=
onally<br>
-=C2=A0 =C2=A0written if chunk registration is disabled. This is accomplish=
ed using<br>
-=C2=A0 =C2=A0the &quot;Compress&quot; command listed above. If the page *h=
as* been registered<br>
-=C2=A0 =C2=A0then we check the entire chunk for zero. Only if the entire c=
hunk is<br>
-=C2=A0 =C2=A0zero, then we send a compress command to zap the page on the =
other side.<br>
-<br>
-Versioning and Capabilities<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
-Current version of the protocol is version #1.<br>
-<br>
-The same version applies to both for protocol traffic and capabilities<br>
-negotiation. (i.e. There is only one version number that is referred to<br=
>
-by all communication).<br>
-<br>
-librdmacm provides the user with a &#39;private data&#39; area to be excha=
nged<br>
-at connection-setup time before any infiniband traffic is generated.<br>
-<br>
-Header:<br>
-=C2=A0 =C2=A0 * Version (protocol version validated before send/recv occur=
s),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32, network byte order<br>
-=C2=A0 =C2=A0 * Flags=C2=A0 =C2=A0(bitwise OR of each capability),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32, network byte order<br>
-<br>
-There is no data portion of this header right now, so there is<br>
-no length field. The maximum size of the &#39;private data&#39; section<br=
>
-is only 192 bytes per the Infiniband specification, so it&#39;s not<br>
-very useful for data anyway. This structure needs to remain small.<br>
-<br>
-This private data area is a convenient place to check for protocol<br>
-versioning because the user does not need to register memory to<br>
-transmit a few bytes of version information.<br>
-<br>
-This is also a convenient place to negotiate capabilities<br>
-(like dynamic page registration).<br>
-<br>
-If the version is invalid, we throw an error.<br>
-<br>
-If the version is new, we only negotiate the capabilities that the<br>
-requested version is able to perform and ignore the rest.<br>
-<br>
-Currently there is only one capability in Version #1: dynamic page registr=
ation<br>
-<br>
-Finally: Negotiation happens with the Flags field: If the primary-VM<br>
-sets a flag, but the destination does not support this capability, it<br>
-will return a zero-bit for that flag and the primary-VM will understand<br=
>
-that as not being an available capability and will thus disable that<br>
-capability on the primary-VM side.<br>
-<br>
-QEMUFileRDMA Interface:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-QEMUFileRDMA introduces a couple of new functions:<br>
-<br>
-1. qemu_rdma_get_buffer()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(QEMUFileOps rdma_read_ops)<br>
-2. qemu_rdma_put_buffer()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(QEMUFileOps rdma_write_ops)<br>
-<br>
-These two functions are very short and simply use the protocol<br>
-describe above to deliver bytes without changing the upper-level<br>
-users of QEMUFile that depend on a bytestream abstraction.<br>
-<br>
-Finally, how do we handoff the actual bytes to get_buffer()?<br>
-<br>
-Again, because we&#39;re trying to &quot;fake&quot; a bytestream abstracti=
on<br>
-using an analogy not unlike individual UDP frames, we have<br>
-to hold on to the bytes received from control-channel&#39;s SEND<br>
-messages in memory.<br>
-<br>
-Each time we receive a complete &quot;QEMU File&quot; control-channel<br>
-message, the bytes from SEND are copied into a small local holding area.<b=
r>
-<br>
-Then, we return the number of bytes requested by get_buffer()<br>
-and leave the remaining bytes in the holding area until get_buffer()<br>
-comes around for another pass.<br>
-<br>
-If the buffer is empty, then we follow the same steps<br>
-listed above and issue another &quot;QEMU File&quot; protocol command,<br>
-asking for a new SEND message to re-fill the buffer.<br>
-<br>
-Migration of VM&#39;s ram:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-At the beginning of the migration, (migration-rdma.c),<br>
-the sender and the receiver populate the list of RAMBlocks<br>
-to be registered with each other into a structure.<br>
-Then, using the aforementioned protocol, they exchange a<br>
-description of these blocks with each other, to be used later<br>
-during the iteration of main memory. This description includes<br>
-a list of all the RAMBlocks, their offsets and lengths, virtual<br>
-addresses and possibly includes pre-registered RDMA keys in case dynamic<b=
r>
-page registration was disabled on the server-side, otherwise not.<br>
-<br>
-Main memory is not migrated with the aforementioned protocol,<br>
-but is instead migrated with normal RDMA Write operations.<br>
-<br>
-Pages are migrated in &quot;chunks&quot; (hard-coded to 1 Megabyte right n=
ow).<br>
-Chunk size is not dynamic, but it could be in a future implementation.<br>
-There&#39;s nothing to indicate that this is useful right now.<br>
-<br>
-When a chunk is full (or a flush() occurs), the memory backed by<br>
-the chunk is registered with librdmacm is pinned in memory on<br>
-both sides using the aforementioned protocol.<br>
-After pinning, an RDMA Write is generated and transmitted<br>
-for the entire chunk.<br>
-<br>
-Chunks are also transmitted in batches: This means that we<br>
-do not request that the hardware signal the completion queue<br>
-for the completion of *every* chunk. The current batch size<br>
-is about 64 chunks (corresponding to 64 MB of memory).<br>
-Only the last chunk in a batch must be signaled.<br>
-This helps keep everything as asynchronous as possible<br>
-and helps keep the hardware busy performing RDMA operations.<br>
-<br>
-Error-handling:<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-Infiniband has what is called a &quot;Reliable, Connected&quot;<br>
-link (one of 4 choices). This is the mode in which<br>
-we use for RDMA migration.<br>
-<br>
-If a *single* message fails,<br>
-the decision is to abort the migration entirely and<br>
-cleanup all the RDMA descriptors and unregister all<br>
-the memory.<br>
-<br>
-After cleanup, the Virtual Machine is returned to normal<br>
-operation the same way that would happen if the TCP<br>
-socket is broken during a non-RDMA based migration.<br>
-<br>
-TODO:<br>
-=3D=3D=3D=3D=3D<br>
-1. Currently, &#39;ulimit -l&#39; mlock() limits as well as cgroups swap l=
imits<br>
-=C2=A0 =C2=A0are not compatible with infiniband memory pinning and will re=
sult in<br>
-=C2=A0 =C2=A0an aborted migration (but with the source VM left unaffected)=
.<br>
-2. Use of the recent /proc/&lt;pid&gt;/pagemap would likely speed up<br>
-=C2=A0 =C2=A0the use of KSM and ballooning while using RDMA.<br>
-3. Also, some form of balloon-device usage tracking would also<br>
-=C2=A0 =C2=A0help alleviate some issues.<br>
-4. Use LRU to provide more fine-grained direction of UNREGISTER<br>
-=C2=A0 =C2=A0requests for unpinning memory in an overcommitted environment=
.<br>
-5. Expose UNREGISTER support to the user by way of workload-specific<br>
-=C2=A0 =C2=A0hints about application behavior.<br>
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url=
-syntax.rst.inc<br>
index 7dbc525fa8..43b5c2596b 100644<br>
--- a/docs/system/device-url-syntax.rst.inc<br>
+++ b/docs/system/device-url-syntax.rst.inc<br>
@@ -87,8 +87,8 @@ These are specified using a special URL syntax.<br>
<br>
=C2=A0``GlusterFS``<br>
=C2=A0 =C2=A0 GlusterFS is a user space distributed file system. QEMU suppo=
rts the<br>
-=C2=A0 =C2=A0use of GlusterFS volumes for hosting VM disk images using TCP=
, Unix<br>
-=C2=A0 =C2=A0Domain Sockets and RDMA transport protocols.<br>
+=C2=A0 =C2=A0use of GlusterFS volumes for hosting VM disk images using TCP=
 and Unix<br>
+=C2=A0 =C2=A0Domain Sockets transport protocols.<br>
<br>
=C2=A0 =C2=A0 Syntax for specifying a VM disk image on GlusterFS volume is<=
br>
<br>
diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rs=
t<br>
index c37268b404..0a8e0766e4 100644<br>
--- a/docs/system/loongarch/virt.rst<br>
+++ b/docs/system/loongarch/virt.rst<br>
@@ -39,7 +39,7 @@ can be accessed by following steps.<br>
<br>
=C2=A0.. code-block:: bash<br>
<br>
-=C2=A0 ./configure --disable-rdma --disable-pvrdma --prefix=3D/usr \<br>
+=C2=A0 ./configure --prefix=3D/usr \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--target-list=3D&quo=
t;loongarch64-softmmu&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-libiscsi -=
-disable-libnfs --disable-libpmem \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-glusterfs =
--enable-libusb --enable-usb-redir \<br>
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-bloc=
k-drivers.rst.inc<br>
index 105cb9679c..384e95ba76 100644<br>
--- a/docs/system/qemu-block-drivers.rst.inc<br>
+++ b/docs/system/qemu-block-drivers.rst.inc<br>
@@ -737,7 +737,6 @@ Examples<br>
=C2=A0 =C2=A0|qemu_system| -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24=
007/testvol/dir/a.img<br>
=C2=A0 =C2=A0|qemu_system| -drive file=3Dgluster+tcp://<a href=3D"http://se=
rver.domain.com:24007/testvol/dir/a.img" rel=3D"noreferrer noreferrer" targ=
et=3D"_blank">server.domain.com:24007/testvol/dir/a.img</a><br>
=C2=A0 =C2=A0|qemu_system| -drive file=3Dgluster+unix:///testvol/dir/a.img?=
socket=3D/tmp/glusterd.socket<br>
-=C2=A0 |qemu_system| -drive file=3Dgluster+rdma://<a href=3D"http://1.2.3.=
4:24007/testvol/a.img" rel=3D"noreferrer noreferrer" target=3D"_blank">1.2.=
3.4:24007/testvol/a.img</a><br>
=C2=A0 =C2=A0|qemu_system| -drive file=3Dgluster://<a href=3D"http://1.2.3.=
4/testvol/a.img,file.debug=3D9,file.logfile=3D/var/log/qemu-gluster.log" re=
l=3D"noreferrer noreferrer" target=3D"_blank">1.2.3.4/testvol/a.img,file.de=
bug=3D9,file.logfile=3D/var/log/qemu-gluster.log</a><br>
=C2=A0 =C2=A0|qemu_system| &#39;json:{&quot;driver&quot;:&quot;qcow2&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;file&quot;:{&quot;driver&quot;:&quot;gluster=
&quot;,<br>
diff --git a/meson.build b/meson.build<br>
index c9c3217ba4..bd65abad13 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1854,21 +1854,6 @@ if numa.found() and not cc.links(&#39;&#39;&#39;<br>
=C2=A0 =C2=A0endif<br>
=C2=A0endif<br>
<br>
-rdma =3D not_found<br>
-if not get_option(&#39;rdma&#39;).auto() or have_system<br>
-=C2=A0 libumad =3D cc.find_library(&#39;ibumad&#39;, required: get_option(=
&#39;rdma&#39;))<br>
-=C2=A0 rdma_libs =3D [cc.find_library(&#39;rdmacm&#39;, has_headers: [&#39=
;rdma/rdma_cma.h&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_option(&#39;rdma&#39;))=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.find_library(&#3=
9;ibverbs&#39;, required: get_option(&#39;rdma&#39;)),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libumad]<br>
-=C2=A0 rdma =3D declare_dependency(dependencies: rdma_libs)<br>
-=C2=A0 foreach lib: rdma_libs<br>
-=C2=A0 =C2=A0 if not lib.found()<br>
-=C2=A0 =C2=A0 =C2=A0 rdma =3D not_found<br>
-=C2=A0 =C2=A0 endif<br>
-=C2=A0 endforeach<br>
-endif<br>
-<br>
=C2=A0cacard =3D not_found<br>
=C2=A0if not get_option(&#39;smartcard&#39;).auto() or have_system<br>
=C2=A0 =C2=A0cacard =3D dependency(&#39;libcacard&#39;, required: get_optio=
n(&#39;smartcard&#39;),<br>
@@ -2246,7 +2231,6 @@ endif<br>
=C2=A0config_host_data.set(&#39;CONFIG_OPENGL&#39;, opengl.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_PLUGIN&#39;, get_option(&#39;plugins=
&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_RBD&#39;, rbd.found())<br>
-config_host_data.set(&#39;CONFIG_RDMA&#39;, rdma.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_RELOCATABLE&#39;, get_option(&#39;re=
locatable&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_SAFESTACK&#39;, get_option(&#39;safe=
_stack&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_SDL&#39;, sdl.found())<br>
@@ -2399,12 +2383,6 @@ if rbd.found()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependen=
cies: rbd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix: =
&#39;#include &lt;rbd/librbd.h&gt;&#39;))<br>
=C2=A0endif<br>
-if rdma.found()<br>
-=C2=A0 config_host_data.set(&#39;HAVE_IBV_ADVISE_MR&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cc.has_function(&#39;ibv_advise_mr&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependenc=
ies: rdma,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix: &=
#39;#include &lt;infiniband/verbs.h&gt;&#39;))<br>
-endif<br>
<br>
=C2=A0have_asan_fiber =3D false<br>
=C2=A0if get_option(&#39;sanitizers&#39;) and \<br>
@@ -2829,37 +2807,6 @@ config_host_data.set(&#39;CONFIG_ARM_AES_BUILTIN&#39=
;, cc.compiles(&#39;&#39;&#39;<br>
=C2=A0 =C2=A0 =C2=A0void foo(uint8x16_t *p) { *p =3D vaesmcq_u8(*p); }<br>
=C2=A0 =C2=A0&#39;&#39;&#39;))<br>
<br>
-have_pvrdma =3D get_option(&#39;pvrdma&#39;) \<br>
-=C2=A0 .require(rdma.found(), error_message: &#39;PVRDMA requires OpenFabr=
ics libraries&#39;) \<br>
-=C2=A0 .require(cc.compiles(gnu_source_prefix + &#39;&#39;&#39;<br>
-=C2=A0 =C2=A0 #include &lt;sys/mman.h&gt;<br>
-=C2=A0 =C2=A0 int main(void)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 char buf =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 void *addr =3D &amp;buf;<br>
-=C2=A0 =C2=A0 =C2=A0 addr =3D mremap(addr, 0, 1, MREMAP_MAYMOVE | MREMAP_F=
IXED);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 return 0;<br>
-=C2=A0 =C2=A0 }&#39;&#39;&#39;), error_message: &#39;PVRDMA requires mrema=
p&#39;).allowed()<br>
-<br>
-if have_pvrdma<br>
-=C2=A0 config_host_data.set(&#39;LEGACY_RDMA_REG_MR&#39;, not cc.links(&#3=
9;&#39;&#39;<br>
-=C2=A0 =C2=A0 #include &lt;infiniband/verbs.h&gt;<br>
-=C2=A0 =C2=A0 int main(void)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 struct ibv_mr *mr;<br>
-=C2=A0 =C2=A0 =C2=A0 struct ibv_pd *pd =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 size_t length =3D 10;<br>
-=C2=A0 =C2=A0 =C2=A0 uint64_t iova =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 int access =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 void *addr =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 mr =3D ibv_reg_mr_iova(pd, addr, length, iova, access=
);<br>
-=C2=A0 =C2=A0 =C2=A0 ibv_dereg_mr(mr);<br>
-=C2=A0 =C2=A0 =C2=A0 return 0;<br>
-=C2=A0 =C2=A0 }&#39;&#39;&#39;))<br>
-endif<br>
-<br>
=C2=A0if get_option(&#39;membarrier&#39;).disabled()<br>
=C2=A0 =C2=A0have_membarrier =3D false<br>
=C2=A0elif host_os =3D=3D &#39;windows&#39;<br>
@@ -2993,7 +2940,6 @@ host_kconfig =3D \<br>
=C2=A0 =C2=A0(have_vhost_kernel ? [&#39;CONFIG_VHOST_KERNEL=3Dy&#39;] : [])=
 + \<br>
=C2=A0 =C2=A0(have_virtfs ? [&#39;CONFIG_VIRTFS=3Dy&#39;] : []) + \<br>
=C2=A0 =C2=A0(host_os =3D=3D &#39;linux&#39; ? [&#39;CONFIG_LINUX=3Dy&#39;]=
 : []) + \<br>
-=C2=A0 (have_pvrdma ? [&#39;CONFIG_PVRDMA=3Dy&#39;] : []) + \<br>
=C2=A0 =C2=A0(multiprocess_allowed ? [&#39;CONFIG_MULTIPROCESS_ALLOWED=3Dy&=
#39;] : []) + \<br>
=C2=A0 =C2=A0(vfio_user_server_allowed ? [&#39;CONFIG_VFIO_USER_SERVER_ALLO=
WED=3Dy&#39;] : []) + \<br>
=C2=A0 =C2=A0(hv_balloon ? [&#39;CONFIG_HV_BALLOON_POSSIBLE=3Dy&#39;] : [])=
<br>
@@ -3357,8 +3303,6 @@ if have_system<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/pci&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/pci-host&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/ppc&#39;,<br>
-=C2=A0 =C2=A0 &#39;hw/rdma&#39;,<br>
-=C2=A0 =C2=A0 &#39;hw/rdma/vmw&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/rtc&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/s390x&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/scsi&#39;,<br>
@@ -4028,7 +3972,6 @@ if have_tools<br>
=C2=A0 =C2=A0 =C2=A0}]<br>
=C2=A0 =C2=A0endforeach<br>
<br>
-=C2=A0 subdir(&#39;contrib/rdmacm-mux&#39;)<br>
=C2=A0 =C2=A0subdir(&#39;contrib/elf2dmp&#39;)<br>
<br>
=C2=A0 =C2=A0executable(&#39;qemu-edid&#39;, files(&#39;qemu-edid.c&#39;, &=
#39;hw/display/edid-generate.c&#39;),<br>
@@ -4433,8 +4376,6 @@ summary_info +=3D {&#39;Multipath support&#39;: mpath=
persist}<br>
=C2=A0summary_info +=3D {&#39;Linux AIO support&#39;: libaio}<br>
=C2=A0summary_info +=3D {&#39;Linux io_uring support&#39;: linux_io_uring}<=
br>
=C2=A0summary_info +=3D {&#39;ATTR/XATTR support&#39;: libattr}<br>
-summary_info +=3D {&#39;RDMA support&#39;:=C2=A0 =C2=A0 =C2=A0 rdma}<br>
-summary_info +=3D {&#39;PVRDMA support&#39;:=C2=A0 =C2=A0 have_pvrdma}<br>
=C2=A0summary_info +=3D {&#39;fdt support&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0f=
dt_opt =3D=3D &#39;disabled&#39; ? false : fdt_opt}<br>
=C2=A0summary_info +=3D {&#39;libcap-ng support&#39;: libcap_ng}<br>
=C2=A0summary_info +=3D {&#39;bpf support&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0l=
ibbpf}<br>
diff --git a/qapi/machine.json b/qapi/machine.json<br>
index e8b60641f2..e9f0f0c49a 100644<br>
--- a/qapi/machine.json<br>
+++ b/qapi/machine.json<br>
@@ -1737,23 +1737,6 @@<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;HumanReadableText&#39;,<br>
=C2=A0 =C2=A0&#39;features&#39;: [ &#39;unstable&#39; ] }<br>
<br>
-##<br>
-# @x-query-rdma:<br>
-#<br>
-# Query RDMA state<br>
-#<br>
-# Features:<br>
-#<br>
-# @unstable: This command is meant for debugging.<br>
-#<br>
-# Returns: RDMA state<br>
-#<br>
-# Since: 6.2<br>
-##<br>
-{ &#39;command&#39;: &#39;x-query-rdma&#39;,<br>
-=C2=A0 &#39;returns&#39;: &#39;HumanReadableText&#39;,<br>
-=C2=A0 &#39;features&#39;: [ &#39;unstable&#39; ] }<br>
-<br>
=C2=A0##<br>
=C2=A0# @x-query-roms:<br>
=C2=A0#<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 8c65b90328..9a56d403be 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -221,8 +221,8 @@<br>
=C2=A0#<br>
=C2=A0# @setup-time: amount of setup time in milliseconds *before* the<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0iterations begin but *after* the QMP command is =
issued.=C2=A0 This is<br>
-#=C2=A0 =C2=A0 =C2=A0designed to provide an accounting of any activities (=
such as<br>
-#=C2=A0 =C2=A0 =C2=A0RDMA pinning) which may be expensive, but do not actu=
ally occur<br>
+#=C2=A0 =C2=A0 =C2=A0designed to provide an accounting of any activities w=
hich may be<br>
+#=C2=A0 =C2=A0 =C2=A0expensive, but do not actually occur<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0during the iterative migration rounds themselves=
.=C2=A0 (since 1.6)<br>
=C2=A0#<br>
=C2=A0# @cpu-throttle-percentage: percentage of time guest cpus are being<b=
r>
@@ -430,10 +430,6 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0for certain work loads, by sending compressed di=
fference of the<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0pages<br>
=C2=A0#<br>
-# @rdma-pin-all: Controls whether or not the entire VM memory<br>
-#=C2=A0 =C2=A0 =C2=A0footprint is mlock()&#39;d on demand or all at once.=
=C2=A0 Refer to<br>
-#=C2=A0 =C2=A0 =C2=A0docs/rdma.txt for usage.=C2=A0 Disabled by default.=
=C2=A0 (since 2.0)<br>
-#<br>
=C2=A0# @zero-blocks: During storage migration encode blocks of zeroes<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0efficiently.=C2=A0 This essentially saves 1MB of=
 zeroes per block on<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0the wire.=C2=A0 Enabling requires source and tar=
get VM to support<br>
@@ -547,7 +543,7 @@<br>
=C2=A0# Since: 1.2<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;MigrationCapability&#39;,<br>
-=C2=A0 &#39;data&#39;: [&#39;xbzrle&#39;, &#39;rdma-pin-all&#39;, &#39;aut=
o-converge&#39;, &#39;zero-blocks&#39;,<br>
+=C2=A0 &#39;data&#39;: [&#39;xbzrle&#39;, &#39;auto-converge&#39;, &#39;ze=
ro-blocks&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &#39;name&#39;: &#39;compress&#=
39;, &#39;features&#39;: [ &#39;deprecated&#39; ] },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;events&#39;, &#39;postcopy-r=
am&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &#39;name&#39;: &#39;x-colo&#39=
;, &#39;features&#39;: [ &#39;unstable&#39; ] },<br>
@@ -606,7 +602,6 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-migrate=
-capabilities&quot; }<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: [<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;state&quot;: false, =
&quot;capability&quot;: &quot;xbzrle&quot;},<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;state&quot;: false, &quot=
;capability&quot;: &quot;rdma-pin-all&quot;},<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;state&quot;: false, =
&quot;capability&quot;: &quot;auto-converge&quot;},<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;state&quot;: false, =
&quot;capability&quot;: &quot;zero-blocks&quot;},<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;state&quot;: false, =
&quot;capability&quot;: &quot;compress&quot;},<br>
@@ -1654,14 +1649,12 @@<br>
=C2=A0#<br>
=C2=A0# @exec: Direct the migration stream to another process.<br>
=C2=A0#<br>
-# @rdma: Migrate via RDMA.<br>
-#<br>
=C2=A0# @file: Direct the migration stream to a file.<br>
=C2=A0#<br>
=C2=A0# Since: 8.2<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;MigrationAddressType&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;socket&#39;, &#39;exec&#39;, &#39;rdma&#39;,=
 &#39;file&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;socket&#39;, &#39;exec&#39;, &#39;file&#39; =
] }<br>
<br>
=C2=A0##<br>
=C2=A0# @FileMigrationArgs:<br>
@@ -1701,7 +1694,6 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0&#39;socket&#39;: &#39;SocketAddress&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;exec&#39;: &#39;MigrationExecCommand&#39;,<br>
-=C2=A0 =C2=A0 &#39;rdma&#39;: &#39;InetSocketAddress&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;file&#39;: &#39;FileMigrationArgs&#39; } }<br>
<br>
=C2=A0##<br>
@@ -1804,14 +1796,6 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;migrate&quot;=
,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;channels&quot=
;: [ { &quot;channel-type&quot;: &quot;main&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;addr&quot;: { &quot;transport&quot;: =
&quot;rdma&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ho=
st&quot;: &quot;10.12.34.9&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;po=
rt&quot;: &quot;1050&quot; } } ] } }<br>
-#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
-#<br>
-#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;migrate&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;channels&quot;: [ =
{ &quot;channel-type&quot;: &quot;main&quot;,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;addr&quot;: { &quot;transport&=
quot;: &quot;file&quot;,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;filename&quot;: &quot;/tmp/migfile&quot;,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;offset&quot;: &quot;0x1000&quot; } } ] } }<br>
@@ -1879,13 +1863,6 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/some/sock&quot; ] } } ] } }<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0#<br>
-#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;migrate-incoming&q=
uot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: {<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;channels&quot;: [ =
{ &quot;channel-type&quot;: &quot;main&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;addr&quot;: { &quot;transport&quot;: =
&quot;rdma&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ho=
st&quot;: &quot;10.12.34.9&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;po=
rt&quot;: &quot;1050&quot; } } ] } }<br>
-#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;migrate-incoming&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;data&#39;: {&#39;*uri=
&#39;: &#39;str&#39;,<br>
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json<br>
index 8304d45625..5e33da7228 100644<br>
--- a/qapi/qapi-schema.json<br>
+++ b/qapi/qapi-schema.json<br>
@@ -54,7 +54,6 @@<br>
=C2=A0{ &#39;include&#39;: &#39;dump.json&#39; }<br>
=C2=A0{ &#39;include&#39;: &#39;net.json&#39; }<br>
=C2=A0{ &#39;include&#39;: &#39;ebpf.json&#39; }<br>
-{ &#39;include&#39;: &#39;rdma.json&#39; }<br>
=C2=A0{ &#39;include&#39;: &#39;rocker.json&#39; }<br>
=C2=A0{ &#39;include&#39;: &#39;tpm.json&#39; }<br>
=C2=A0{ &#39;include&#39;: &#39;ui.json&#39; }<br>
diff --git a/qapi/rdma.json b/qapi/rdma.json<br>
deleted file mode 100644<br>
index 195c001850..0000000000<br>
--- a/qapi/rdma.json<br>
+++ /dev/null<br>
@@ -1,38 +0,0 @@<br>
-# -*- Mode: Python -*-<br>
-# vim: filetype=3Dpython<br>
-#<br>
-<br>
-##<br>
-# =3D RDMA device<br>
-##<br>
-<br>
-##<br>
-# @RDMA_GID_STATUS_CHANGED:<br>
-#<br>
-# Emitted when guest driver adds/deletes GID to/from device<br>
-#<br>
-# @netdev: RoCE Network Device name<br>
-#<br>
-# @gid-status: Add or delete indication<br>
-#<br>
-# @subnet-prefix: Subnet Prefix<br>
-#<br>
-# @interface-id: Interface ID<br>
-#<br>
-# Since: 4.0<br>
-#<br>
-# Example:<br>
-#<br>
-#=C2=A0 =C2=A0 =C2=A0&lt;- {&quot;timestamp&quot;: {&quot;seconds&quot;: 1=
541579657, &quot;microseconds&quot;: 986760},<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;event&quot;: &quot;RDMA_GID_STATU=
S_CHANGED&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;data&quot;:<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;netdev&quot;: &quo=
t;bridge0&quot;,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;interface-id&quot;:=
 15880512517475447892,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;gid-status&quot;: t=
rue,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;subnet-prefix&quot;=
: 33022}}<br>
-##<br>
-{ &#39;event&#39;: &#39;RDMA_GID_STATUS_CHANGED&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;netdev&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &#3=
9;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;gid-status&#39;=C2=A0 =C2=
=A0 : &#39;bool&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;subnet-prefix&#39; : &#39;u=
int64&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;interface-id&#39;=C2=A0 : &=
#39;uint64&#39; } }<br>
diff --git a/contrib/rdmacm-mux/rdmacm-mux.h b/contrib/rdmacm-mux/rdmacm-mu=
x.h<br>
deleted file mode 100644<br>
index 07a4722913..0000000000<br>
--- a/contrib/rdmacm-mux/rdmacm-mux.h<br>
+++ /dev/null<br>
@@ -1,61 +0,0 @@<br>
-/*<br>
- * QEMU paravirtual RDMA - rdmacm-mux declarations<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMACM_MUX_H<br>
-#define RDMACM_MUX_H<br>
-<br>
-#include &quot;linux/if.h&quot;<br>
-#include &lt;infiniband/verbs.h&gt;<br>
-#include &lt;infiniband/umad.h&gt;<br>
-#include &lt;rdma/rdma_user_cm.h&gt;<br>
-<br>
-typedef enum RdmaCmMuxMsgType {<br>
-=C2=A0 =C2=A0 RDMACM_MUX_MSG_TYPE_REQ=C2=A0 =C2=A0=3D 0,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_MSG_TYPE_RESP=C2=A0 =3D 1,<br>
-} RdmaCmMuxMsgType;<br>
-<br>
-typedef enum RdmaCmMuxOpCode {<br>
-=C2=A0 =C2=A0 RDMACM_MUX_OP_CODE_REG=C2=A0 =C2=A0=3D 0,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_OP_CODE_UNREG =3D 1,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_OP_CODE_MAD=C2=A0 =C2=A0=3D 2,<br>
-} RdmaCmMuxOpCode;<br>
-<br>
-typedef enum RdmaCmMuxErrCode {<br>
-=C2=A0 =C2=A0 RDMACM_MUX_ERR_CODE_OK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_ERR_CODE_EINVAL=C2=A0 =C2=A0 =3D 1,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_ERR_CODE_EEXIST=C2=A0 =C2=A0 =3D 2,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_ERR_CODE_EACCES=C2=A0 =C2=A0 =3D 3,<br>
-=C2=A0 =C2=A0 RDMACM_MUX_ERR_CODE_ENOTFOUND =3D 4,<br>
-} RdmaCmMuxErrCode;<br>
-<br>
-typedef struct RdmaCmMuxHdr {<br>
-=C2=A0 =C2=A0 RdmaCmMuxMsgType msg_type;<br>
-=C2=A0 =C2=A0 RdmaCmMuxOpCode op_code;<br>
-=C2=A0 =C2=A0 union ibv_gid sgid;<br>
-=C2=A0 =C2=A0 RdmaCmMuxErrCode err_code;<br>
-} RdmaCmUHdr;<br>
-<br>
-typedef struct RdmaCmUMad {<br>
-=C2=A0 =C2=A0 struct ib_user_mad hdr;<br>
-=C2=A0 =C2=A0 char mad[RDMA_MAX_PRIVATE_DATA];<br>
-} RdmaCmUMad;<br>
-<br>
-typedef struct RdmaCmMuxMsg {<br>
-=C2=A0 =C2=A0 RdmaCmUHdr hdr;<br>
-=C2=A0 =C2=A0 int umad_len;<br>
-=C2=A0 =C2=A0 RdmaCmUMad umad;<br>
-} RdmaCmMuxMsg;<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h<br>
deleted file mode 100644<br>
index 225af481e0..0000000000<br>
--- a/hw/rdma/rdma_backend.h<br>
+++ /dev/null<br>
@@ -1,129 +0,0 @@<br>
-/*<br>
- *=C2=A0 RDMA device: Definitions of Backend Device functions<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMA_BACKEND_H<br>
-#define RDMA_BACKEND_H<br>
-<br>
-#include &quot;qapi/error.h&quot;<br>
-#include &quot;chardev/char-fe.h&quot;<br>
-<br>
-#include &quot;rdma_rm_defs.h&quot;<br>
-#include &quot;rdma_backend_defs.h&quot;<br>
-<br>
-/* Vendor Errors */<br>
-#define VENDOR_ERR_FAIL_BACKEND=C2=A0 =C2=A0 =C2=A00x201<br>
-#define VENDOR_ERR_TOO_MANY_SGES=C2=A0 =C2=A0 0x202<br>
-#define VENDOR_ERR_NOMEM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x203<br=
>
-#define VENDOR_ERR_QP0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2=
04<br>
-#define VENDOR_ERR_INV_NUM_SGE=C2=A0 =C2=A0 =C2=A0 0x205<br>
-#define VENDOR_ERR_MAD_SEND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x206<br>
-#define VENDOR_ERR_INVLKEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x207<br>
-#define VENDOR_ERR_MR_SMALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x208<br>
-#define VENDOR_ERR_INV_MAD_BUFF=C2=A0 =C2=A0 =C2=A00x209<br>
-#define VENDOR_ERR_INV_GID_IDX=C2=A0 =C2=A0 =C2=A0 0x210<br>
-<br>
-/* Add definition for QP0 and QP1 as there is no userspace enums for them =
*/<br>
-enum ibv_special_qp_type {<br>
-=C2=A0 =C2=A0 IBV_QPT_SMI =3D 0,<br>
-=C2=A0 =C2=A0 IBV_QPT_GSI =3D 1,<br>
-};<br>
-<br>
-static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)<br>
-{<br>
-=C2=A0 =C2=A0 return qp-&gt;ibqp ? qp-&gt;ibqp-&gt;qp_num : 1;<br>
-}<br>
-<br>
-static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr)<br>
-{<br>
-=C2=A0 =C2=A0 return mr-&gt;ibmr ? mr-&gt;ibmr-&gt;lkey : 0;<br>
-}<br>
-<br>
-static inline uint32_t rdma_backend_mr_rkey(const RdmaBackendMR *mr)<br>
-{<br>
-=C2=A0 =C2=A0 return mr-&gt;ibmr ? mr-&gt;ibmr-&gt;rkey : 0;<br>
-}<br>
-<br>
-int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 RdmaDeviceResources *rdma_dev_res,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *backend_device_name, uint8_t port_num,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ibv_device_attr *dev_attr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 CharBackend *mad_chr_be);<br>
-void rdma_backend_fini(RdmaBackendDev *backend_dev);<br>
-int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0union ibv_gid *gid);<br>
-int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0union ibv_gid *gid);<br>
-int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0union ibv_gid *gid);<br>
-void rdma_backend_start(RdmaBackendDev *backend_dev);<br>
-void rdma_backend_stop(RdmaBackendDev *backend_dev);<br>
-void rdma_backend_register_comp_handler(void (*handler)(void *ctx,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_wc *wc));<br>
-void rdma_backend_unregister_comp_handler(void);<br>
-<br>
-int rdma_backend_query_port(RdmaBackendDev *backend_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_port_attr *port_attr);<br>
-int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)=
;<br>
-void rdma_backend_destroy_pd(RdmaBackendPD *pd);<br>
-<br>
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *add=
r,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0size_t length, uint64_t guest_start, int access);<b=
r>
-void rdma_backend_destroy_mr(RdmaBackendMR *mr);<br>
-<br>
-int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int cqe);<br>
-void rdma_backend_destroy_cq(RdmaBackendCQ *cq);<br>
-void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ=
 *cq);<br>
-<br>
-int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RdmaBackendPD *pd, RdmaBackendCQ *scq,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_send_wr, uint32_t max_recv_wr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_send_sge, uint32_t max_recv_sge);<br>
-int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP =
*qp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t qp_type, uint32_t qkey);<br>
-int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *=
qp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t qp_type, uint8_t sgid_idx,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 union ibv_gid *dgid, uint32_t dqpn,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t rq_psn, uint32_t qkey, bool use_qk=
ey);<br>
-int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t sq_psn, uint32_t qkey, bool use_qk=
ey);<br>
-int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int attr_mask, struct ibv_qp_init_attr *init_attr);<br>
-void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_r=
es);<br>
-<br>
-void rdma_backend_post_send(RdmaBackendDev *backend_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RdmaBackendQP *qp, uint8_t qp_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_sge *sge, uint32_t num_sge,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t sgid_idx, union ibv_gid *sgid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 union ibv_gid *dgid, uint32_t dqpn, uint32_t dqkey=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void *ctx);<br>
-void rdma_backend_post_recv(RdmaBackendDev *backend_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RdmaBackendQP *qp, uint8_t qp_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_sge *sge, uint32_t num_sge, void *ctx);=
<br>
-<br>
-int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t max_wr, uint32_t max_sge,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t srq_limit);<br>
-int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_a=
ttr);<br>
-int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_=
attr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int srq_attr_mask);<br>
-void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RdmaDeviceResources *dev_res);<br>
-void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RdmaBackendSRQ *srq, struct ibv_sge =
*sge,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t num_sge, void *ctx);<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h<br>
deleted file mode 100644<br>
index 4e6c0ad695..0000000000<br>
--- a/hw/rdma/rdma_backend_defs.h<br>
+++ /dev/null<br>
@@ -1,76 +0,0 @@<br>
-/*<br>
- *=C2=A0 RDMA device: Definitions of Backend Device structures<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMA_BACKEND_DEFS_H<br>
-#define RDMA_BACKEND_DEFS_H<br>
-<br>
-#include &quot;qemu/thread.h&quot;<br>
-#include &quot;chardev/char-fe.h&quot;<br>
-#include &lt;infiniband/verbs.h&gt;<br>
-#include &quot;contrib/rdmacm-mux/rdmacm-mux.h&quot;<br>
-#include &quot;rdma_utils.h&quot;<br>
-<br>
-typedef struct RdmaDeviceResources RdmaDeviceResources;<br>
-<br>
-typedef struct RdmaBackendThread {<br>
-=C2=A0 =C2=A0 QemuThread thread;<br>
-=C2=A0 =C2=A0 bool run; /* Set by thread manager to let thread know it sho=
uld exit */<br>
-=C2=A0 =C2=A0 bool is_running; /* Set by the thread to report its status *=
/<br>
-} RdmaBackendThread;<br>
-<br>
-typedef struct RdmaCmMux {<br>
-=C2=A0 =C2=A0 CharBackend *chr_be;<br>
-=C2=A0 =C2=A0 int can_receive;<br>
-} RdmaCmMux;<br>
-<br>
-typedef struct RdmaBackendDev {<br>
-=C2=A0 =C2=A0 RdmaBackendThread comp_thread;<br>
-=C2=A0 =C2=A0 PCIDevice *dev;<br>
-=C2=A0 =C2=A0 RdmaDeviceResources *rdma_dev_res;<br>
-=C2=A0 =C2=A0 struct ibv_device *ib_dev;<br>
-=C2=A0 =C2=A0 struct ibv_context *context;<br>
-=C2=A0 =C2=A0 struct ibv_comp_channel *channel;<br>
-=C2=A0 =C2=A0 uint8_t port_num;<br>
-=C2=A0 =C2=A0 RdmaProtectedGQueue recv_mads_list;<br>
-=C2=A0 =C2=A0 RdmaCmMux rdmacm_mux;<br>
-} RdmaBackendDev;<br>
-<br>
-typedef struct RdmaBackendPD {<br>
-=C2=A0 =C2=A0 struct ibv_pd *ibpd;<br>
-} RdmaBackendPD;<br>
-<br>
-typedef struct RdmaBackendMR {<br>
-=C2=A0 =C2=A0 struct ibv_pd *ibpd;<br>
-=C2=A0 =C2=A0 struct ibv_mr *ibmr;<br>
-} RdmaBackendMR;<br>
-<br>
-typedef struct RdmaBackendCQ {<br>
-=C2=A0 =C2=A0 RdmaBackendDev *backend_dev;<br>
-=C2=A0 =C2=A0 struct ibv_cq *ibcq;<br>
-} RdmaBackendCQ;<br>
-<br>
-typedef struct RdmaBackendQP {<br>
-=C2=A0 =C2=A0 struct ibv_pd *ibpd;<br>
-=C2=A0 =C2=A0 struct ibv_qp *ibqp;<br>
-=C2=A0 =C2=A0 uint8_t sgid_idx;<br>
-=C2=A0 =C2=A0 RdmaProtectedGSList cqe_ctx_list;<br>
-} RdmaBackendQP;<br>
-<br>
-typedef struct RdmaBackendSRQ {<br>
-=C2=A0 =C2=A0 struct ibv_srq *ibsrq;<br>
-=C2=A0 =C2=A0 RdmaProtectedGSList cqe_ctx_list;<br>
-} RdmaBackendSRQ;<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h<br>
deleted file mode 100644<br>
index d69a917795..0000000000<br>
--- a/hw/rdma/rdma_rm.h<br>
+++ /dev/null<br>
@@ -1,97 +0,0 @@<br>
-/*<br>
- * RDMA device: Definitions of Resource Manager functions<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMA_RM_H<br>
-#define RDMA_RM_H<br>
-<br>
-#include &quot;qapi/error.h&quot;<br>
-#include &quot;rdma_backend_defs.h&quot;<br>
-#include &quot;rdma_rm_defs.h&quot;<br>
-<br>
-int rdma_rm_init(RdmaDeviceResources *dev_res,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ibv_d=
evice_attr *dev_attr);<br>
-void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_de=
v,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*ifname);<br>
-<br>
-int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend=
_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t *pd_handle, uint32_t ctx_handle);<br>
-RdmaRmPD *rdma_rm_get_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)=
;<br>
-void rdma_rm_dealloc_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle);=
<br>
-<br>
-int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t guest_start, uint64_t guest_length,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0void *host_virt, int access_flags, uint32_t *mr_handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t *lkey, uint32_t *rkey);<br>
-RdmaRmMR *rdma_rm_get_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)=
;<br>
-void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle);=
<br>
-<br>
-int rdma_rm_alloc_uc(RdmaDeviceResources *dev_res, uint32_t pfn,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t *uc_handle);<br>
-RdmaRmUC *rdma_rm_get_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle)=
;<br>
-void rdma_rm_dealloc_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle);=
<br>
-<br>
-int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend=
_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t cqe, uint32_t *cq_handle, void *opaque);<br>
-RdmaRmCQ *rdma_rm_get_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle)=
;<br>
-void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t cq_handl=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bool notify);<br>
-void rdma_rm_dealloc_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle);=
<br>
-<br>
-int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint8_t qp_type, uint32_t max_send_wr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t max_send_sge, uint32_t send_cq_handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t max_recv_wr, uint32_t max_recv_sge,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t recv_cq_handle, void *opaque, uint32_t *qpn,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint8_t is_srq, uint32_t srq_handle);<br>
-RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn);<br>
-int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backen=
d_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t qp_handle, uint32_t attr_mask, uint8_t sgid_idx,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 union ibv_gid *dgid, uint32_t dqpn,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 enum ibv_qp_state qp_state, uint32_t qkey,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t rq_psn, uint32_t sq_psn);<br>
-int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend=
_dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t qp_handle, struct ibv_qp_attr *attr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int attr_mask, struct ibv_qp_init_attr *init_attr);<br>
-void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle);=
<br>
-<br>
-RdmaRmSRQ *rdma_rm_get_srq(RdmaDeviceResources *dev_res, uint32_t srq_hand=
le);<br>
-int rdma_rm_alloc_srq(RdmaDeviceResources *dev_res, uint32_t pd_handle,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t max_wr, uint32_t max_sge, uint32_t srq_limit,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t *srq_handle, void *opaque);<br>
-int rdma_rm_query_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ibv_srq_attr *srq_attr);<br>
-int rdma_rm_modify_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct ibv_srq_attr *srq_attr, int srq_attr_mask);<br>
-void rdma_rm_dealloc_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle=
);<br>
-<br>
-int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_=
id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 void *ctx);<br>
-void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_i=
d);<br>
-void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ct=
x_id);<br>
-<br>
-int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_=
dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t char *ifname, union ibv_gid *gid, int gid_idx);<br>
-int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_=
dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t char *ifname, int gid_idx);<br>
-int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RdmaBackendDev *backend_dev, =
int sgid_idx);<br>
-static inline union ibv_gid *rdma_rm_get_gid(RdmaDeviceResources *dev_res,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int sgid_idx)<br>
-{<br>
-=C2=A0 =C2=A0 return &amp;dev_res-&gt;port.gid_tbl[sgid_idx].gid;<br>
-}<br>
-void rdma_format_device_counters(RdmaDeviceResources *dev_res, GString *bu=
f);<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h<br>
deleted file mode 100644<br>
index 534f2f74d3..0000000000<br>
--- a/hw/rdma/rdma_rm_defs.h<br>
+++ /dev/null<br>
@@ -1,146 +0,0 @@<br>
-/*<br>
- * RDMA device: Definitions of Resource Manager structures<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMA_RM_DEFS_H<br>
-#define RDMA_RM_DEFS_H<br>
-<br>
-#include &quot;rdma_backend_defs.h&quot;<br>
-<br>
-#define MAX_PORTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 /* Do n=
ot change - we support only one port */<br>
-#define MAX_PORT_GIDS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0255<br>
-#define MAX_GIDS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAX_PORT_=
GIDS<br>
-#define MAX_PORT_PKEYS=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define MAX_PKEYS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX_PORT_=
PKEYS<br>
-#define MAX_UCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0512<=
br>
-#define MAX_MR_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&lt; =
27)<br>
-#define MAX_QP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1024=
<br>
-#define MAX_SGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br=
>
-#define MAX_CQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2048=
<br>
-#define MAX_MR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1024=
<br>
-#define MAX_PD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1024=
<br>
-#define MAX_QP_RD_ATOM=C2=A0 =C2=A0 =C2=A0 =C2=A0 16<br>
-#define MAX_QP_INIT_RD_ATOM=C2=A0 =C2=A016<br>
-#define MAX_AH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 64<b=
r>
-#define MAX_SRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0512<=
br>
-<br>
-#define MAX_RM_TBL_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<=
br>
-#define MAX_CONSEQ_EMPTY_POLL_CQ=C2=A0 =C2=A0 4096 /* considered as error =
above this */<br>
-<br>
-typedef struct RdmaRmResTbl {<br>
-=C2=A0 =C2=A0 char name[MAX_RM_TBL_NAME];<br>
-=C2=A0 =C2=A0 QemuMutex lock;<br>
-=C2=A0 =C2=A0 unsigned long *bitmap;<br>
-=C2=A0 =C2=A0 size_t tbl_sz;<br>
-=C2=A0 =C2=A0 size_t res_sz;<br>
-=C2=A0 =C2=A0 void *tbl;<br>
-=C2=A0 =C2=A0 uint32_t used; /* number of used entries in the table */<br>
-} RdmaRmResTbl;<br>
-<br>
-typedef struct RdmaRmPD {<br>
-=C2=A0 =C2=A0 RdmaBackendPD backend_pd;<br>
-=C2=A0 =C2=A0 uint32_t ctx_handle;<br>
-} RdmaRmPD;<br>
-<br>
-typedef enum CQNotificationType {<br>
-=C2=A0 =C2=A0 CNT_CLEAR,<br>
-=C2=A0 =C2=A0 CNT_ARM,<br>
-=C2=A0 =C2=A0 CNT_SET,<br>
-} CQNotificationType;<br>
-<br>
-typedef struct RdmaRmCQ {<br>
-=C2=A0 =C2=A0 RdmaBackendCQ backend_cq;<br>
-=C2=A0 =C2=A0 void *opaque;<br>
-=C2=A0 =C2=A0 CQNotificationType notify;<br>
-} RdmaRmCQ;<br>
-<br>
-/* MR (DMA region) */<br>
-typedef struct RdmaRmMR {<br>
-=C2=A0 =C2=A0 RdmaBackendMR backend_mr;<br>
-=C2=A0 =C2=A0 void *virt;<br>
-=C2=A0 =C2=A0 uint64_t start;<br>
-=C2=A0 =C2=A0 size_t length;<br>
-=C2=A0 =C2=A0 uint32_t pd_handle;<br>
-=C2=A0 =C2=A0 uint32_t lkey;<br>
-=C2=A0 =C2=A0 uint32_t rkey;<br>
-} RdmaRmMR;<br>
-<br>
-typedef struct RdmaRmUC {<br>
-=C2=A0 =C2=A0 uint64_t uc_handle;<br>
-} RdmaRmUC;<br>
-<br>
-typedef struct RdmaRmQP {<br>
-=C2=A0 =C2=A0 RdmaBackendQP backend_qp;<br>
-=C2=A0 =C2=A0 void *opaque;<br>
-=C2=A0 =C2=A0 uint32_t qp_type;<br>
-=C2=A0 =C2=A0 uint32_t qpn;<br>
-=C2=A0 =C2=A0 uint32_t send_cq_handle;<br>
-=C2=A0 =C2=A0 uint32_t recv_cq_handle;<br>
-=C2=A0 =C2=A0 enum ibv_qp_state qp_state;<br>
-=C2=A0 =C2=A0 uint8_t is_srq;<br>
-} RdmaRmQP;<br>
-<br>
-typedef struct RdmaRmSRQ {<br>
-=C2=A0 =C2=A0 RdmaBackendSRQ backend_srq;<br>
-=C2=A0 =C2=A0 uint32_t recv_cq_handle;<br>
-=C2=A0 =C2=A0 void *opaque;<br>
-} RdmaRmSRQ;<br>
-<br>
-typedef struct RdmaRmGid {<br>
-=C2=A0 =C2=A0 union ibv_gid gid;<br>
-=C2=A0 =C2=A0 int backend_gid_index;<br>
-} RdmaRmGid;<br>
-<br>
-typedef struct RdmaRmPort {<br>
-=C2=A0 =C2=A0 RdmaRmGid gid_tbl[MAX_PORT_GIDS];<br>
-=C2=A0 =C2=A0 enum ibv_port_state state;<br>
-} RdmaRmPort;<br>
-<br>
-typedef struct RdmaRmStats {<br>
-=C2=A0 =C2=A0 uint64_t tx;<br>
-=C2=A0 =C2=A0 uint64_t tx_len;<br>
-=C2=A0 =C2=A0 uint64_t tx_err;<br>
-=C2=A0 =C2=A0 uint64_t rx_bufs;<br>
-=C2=A0 =C2=A0 uint64_t rx_bufs_len;<br>
-=C2=A0 =C2=A0 uint64_t rx_bufs_err;<br>
-=C2=A0 =C2=A0 uint64_t rx_srq;<br>
-=C2=A0 =C2=A0 uint64_t completions;<br>
-=C2=A0 =C2=A0 uint64_t mad_tx;<br>
-=C2=A0 =C2=A0 uint64_t mad_tx_err;<br>
-=C2=A0 =C2=A0 uint64_t mad_rx;<br>
-=C2=A0 =C2=A0 uint64_t mad_rx_err;<br>
-=C2=A0 =C2=A0 uint64_t mad_rx_bufs;<br>
-=C2=A0 =C2=A0 uint64_t mad_rx_bufs_err;<br>
-=C2=A0 =C2=A0 uint64_t poll_cq_from_bk;<br>
-=C2=A0 =C2=A0 uint64_t poll_cq_from_guest;<br>
-=C2=A0 =C2=A0 uint64_t poll_cq_from_guest_empty;<br>
-=C2=A0 =C2=A0 uint64_t poll_cq_ppoll_to;<br>
-=C2=A0 =C2=A0 uint32_t missing_cqe;<br>
-} RdmaRmStats;<br>
-<br>
-struct RdmaDeviceResources {<br>
-=C2=A0 =C2=A0 RdmaRmPort port;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl pd_tbl;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl mr_tbl;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl uc_tbl;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl qp_tbl;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl cq_tbl;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl cqe_ctx_tbl;<br>
-=C2=A0 =C2=A0 RdmaRmResTbl srq_tbl;<br>
-=C2=A0 =C2=A0 GHashTable *qp_hash; /* Keeps mapping between real and emula=
ted */<br>
-=C2=A0 =C2=A0 QemuMutex lock;<br>
-=C2=A0 =C2=A0 RdmaRmStats stats;<br>
-};<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h<br>
deleted file mode 100644<br>
index 54e4f56edd..0000000000<br>
--- a/hw/rdma/rdma_utils.h<br>
+++ /dev/null<br>
@@ -1,63 +0,0 @@<br>
-/*<br>
- * RDMA device: Debug utilities<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMA_UTILS_H<br>
-#define RDMA_UTILS_H<br>
-<br>
-#include &quot;qemu/error-report.h&quot;<br>
-#include &quot;sysemu/dma.h&quot;<br>
-<br>
-#define rdma_error_report(fmt, ...) \<br>
-=C2=A0 =C2=A0 error_report(&quot;%s: &quot; fmt, &quot;rdma&quot;, ## __VA=
_ARGS__)<br>
-#define rdma_warn_report(fmt, ...) \<br>
-=C2=A0 =C2=A0 warn_report(&quot;%s: &quot; fmt, &quot;rdma&quot;, ## __VA_=
ARGS__)<br>
-#define rdma_info_report(fmt, ...) \<br>
-=C2=A0 =C2=A0 info_report(&quot;%s: &quot; fmt, &quot;rdma&quot;, ## __VA_=
ARGS__)<br>
-<br>
-typedef struct RdmaProtectedGQueue {<br>
-=C2=A0 =C2=A0 QemuMutex lock;<br>
-=C2=A0 =C2=A0 GQueue *list;<br>
-} RdmaProtectedGQueue;<br>
-<br>
-typedef struct RdmaProtectedGSList {<br>
-=C2=A0 =C2=A0 QemuMutex lock;<br>
-=C2=A0 =C2=A0 GSList *list;<br>
-} RdmaProtectedGSList;<br>
-<br>
-void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t len);<b=
r>
-void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);<br>
-void rdma_protected_gqueue_init(RdmaProtectedGQueue *list);<br>
-void rdma_protected_gqueue_destroy(RdmaProtectedGQueue *list);<br>
-void rdma_protected_gqueue_append_int64(RdmaProtectedGQueue *list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t =
value);<br>
-int64_t rdma_protected_gqueue_pop_int64(RdmaProtectedGQueue *list);<br>
-void rdma_protected_gslist_init(RdmaProtectedGSList *list);<br>
-void rdma_protected_gslist_destroy(RdmaProtectedGSList *list);<br>
-void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t =
value);<br>
-void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t =
value);<br>
-<br>
-static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)<br>
-{<br>
-=C2=A0 =C2=A0 memcpy(eui, addr, 3);<br>
-=C2=A0 =C2=A0 eui[3] =3D 0xFF;<br>
-=C2=A0 =C2=A0 eui[4] =3D 0xFE;<br>
-=C2=A0 =C2=A0 memcpy(eui + 5, addr + 3, 3);<br>
-=C2=A0 =C2=A0 eui[0] ^=3D 2;<br>
-}<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/trace.h b/hw/rdma/trace.h<br>
deleted file mode 100644<br>
index b3fa8ebc51..0000000000<br>
--- a/hw/rdma/trace.h<br>
+++ /dev/null<br>
@@ -1 +0,0 @@<br>
-#include &quot;trace/trace-hw_rdma.h&quot;<br>
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h<br>
deleted file mode 100644<br>
index 4cbc10c980..0000000000<br>
--- a/hw/rdma/vmw/pvrdma.h<br>
+++ /dev/null<br>
@@ -1,144 +0,0 @@<br>
-/*<br>
- * QEMU VMWARE paravirtual RDMA device definitions<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef PVRDMA_PVRDMA_H<br>
-#define PVRDMA_PVRDMA_H<br>
-<br>
-#include &quot;qemu/units.h&quot;<br>
-#include &quot;qemu/notify.h&quot;<br>
-#include &quot;hw/pci/msix.h&quot;<br>
-#include &quot;hw/pci/pci_device.h&quot;<br>
-#include &quot;chardev/char-fe.h&quot;<br>
-#include &quot;hw/net/vmxnet3_defs.h&quot;<br>
-<br>
-#include &quot;../rdma_backend_defs.h&quot;<br>
-#include &quot;../rdma_rm_defs.h&quot;<br>
-<br>
-#include &quot;standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_de=
v_api.h&quot;<br>
-#include &quot;pvrdma_dev_ring.h&quot;<br>
-#include &quot;qom/object.h&quot;<br>
-<br>
-/* BARs */<br>
-#define RDMA_MSIX_BAR_IDX=C2=A0 =C2=A0 0<br>
-#define RDMA_REG_BAR_IDX=C2=A0 =C2=A0 =C2=A01<br>
-#define RDMA_UAR_BAR_IDX=C2=A0 =C2=A0 =C2=A02<br>
-#define RDMA_BAR0_MSIX_SIZE=C2=A0 (16 * KiB)<br>
-#define RDMA_BAR1_REGS_SIZE=C2=A0 64<br>
-#define RDMA_BAR2_UAR_SIZE=C2=A0 =C2=A0(0x1000 * MAX_UCS) /* each uc gets =
page */<br>
-<br>
-/* MSIX */<br>
-#define RDMA_MAX_INTRS=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-#define RDMA_MSIX_TABLE=C2=A0 =C2=A0 =C2=A0 0x0000<br>
-#define RDMA_MSIX_PBA=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2000<br>
-<br>
-/* Interrupts Vectors */<br>
-#define INTR_VEC_CMD_RING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define INTR_VEC_CMD_ASYNC_EVENTS=C2=A0 =C2=A0 1<br>
-#define INTR_VEC_CMD_COMPLETION_Q=C2=A0 =C2=A0 2<br>
-<br>
-/* HW attributes */<br>
-#define PVRDMA_HW_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pvrdma&quot;<br>
-#define PVRDMA_HW_VERSION=C2=A0 =C2=A0 17<br>
-#define PVRDMA_FW_VERSION=C2=A0 =C2=A0 14<br>
-<br>
-/* Some defaults */<br>
-#define PVRDMA_PKEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xFFFF<br>
-<br>
-typedef struct DSRInfo {<br>
-=C2=A0 =C2=A0 dma_addr_t dma;<br>
-=C2=A0 =C2=A0 struct pvrdma_device_shared_region *dsr;<br>
-<br>
-=C2=A0 =C2=A0 union pvrdma_cmd_req *req;<br>
-=C2=A0 =C2=A0 union pvrdma_cmd_resp *rsp;<br>
-<br>
-=C2=A0 =C2=A0 PvrdmaRingState *async_ring_state;<br>
-=C2=A0 =C2=A0 PvrdmaRing async;<br>
-<br>
-=C2=A0 =C2=A0 PvrdmaRingState *cq_ring_state;<br>
-=C2=A0 =C2=A0 PvrdmaRing cq;<br>
-} DSRInfo;<br>
-<br>
-typedef struct PVRDMADevStats {<br>
-=C2=A0 =C2=A0 uint64_t commands;<br>
-=C2=A0 =C2=A0 uint64_t regs_reads;<br>
-=C2=A0 =C2=A0 uint64_t regs_writes;<br>
-=C2=A0 =C2=A0 uint64_t uar_writes;<br>
-=C2=A0 =C2=A0 uint64_t interrupts;<br>
-} PVRDMADevStats;<br>
-<br>
-struct PVRDMADev {<br>
-=C2=A0 =C2=A0 PCIDevice parent_obj;<br>
-=C2=A0 =C2=A0 MemoryRegion msix;<br>
-=C2=A0 =C2=A0 MemoryRegion regs;<br>
-=C2=A0 =C2=A0 uint32_t regs_data[RDMA_BAR1_REGS_SIZE];<br>
-=C2=A0 =C2=A0 MemoryRegion uar;<br>
-=C2=A0 =C2=A0 uint32_t uar_data[RDMA_BAR2_UAR_SIZE];<br>
-=C2=A0 =C2=A0 DSRInfo dsr_info;<br>
-=C2=A0 =C2=A0 int interrupt_mask;<br>
-=C2=A0 =C2=A0 struct ibv_device_attr dev_attr;<br>
-=C2=A0 =C2=A0 uint64_t node_guid;<br>
-=C2=A0 =C2=A0 char *backend_eth_device_name;<br>
-=C2=A0 =C2=A0 char *backend_device_name;<br>
-=C2=A0 =C2=A0 uint8_t backend_port_num;<br>
-=C2=A0 =C2=A0 RdmaBackendDev backend_dev;<br>
-=C2=A0 =C2=A0 RdmaDeviceResources rdma_dev_res;<br>
-=C2=A0 =C2=A0 CharBackend mad_chr;<br>
-=C2=A0 =C2=A0 VMXNET3State *func0;<br>
-=C2=A0 =C2=A0 Notifier shutdown_notifier;<br>
-=C2=A0 =C2=A0 PVRDMADevStats stats;<br>
-};<br>
-typedef struct PVRDMADev PVRDMADev;<br>
-DECLARE_INSTANCE_CHECKER(PVRDMADev, PVRDMA_DEV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PVRDMA_HW_NAME)<br>
-<br>
-static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t *val)<=
br>
-{<br>
-=C2=A0 =C2=A0 int idx =3D addr &gt;&gt; 2;<br>
-<br>
-=C2=A0 =C2=A0 if (idx &gt;=3D RDMA_BAR1_REGS_SIZE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 *val =3D dev-&gt;regs_data[idx];<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-static inline int set_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t val)<b=
r>
-{<br>
-=C2=A0 =C2=A0 int idx =3D addr &gt;&gt; 2;<br>
-<br>
-=C2=A0 =C2=A0 if (idx &gt;=3D RDMA_BAR1_REGS_SIZE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 dev-&gt;regs_data[idx] =3D val;<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-static inline void post_interrupt(PVRDMADev *dev, unsigned vector)<br>
-{<br>
-=C2=A0 =C2=A0 PCIDevice *pci_dev =3D PCI_DEVICE(dev);<br>
-<br>
-=C2=A0 =C2=A0 if (likely(!dev-&gt;interrupt_mask)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;stats.interrupts++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msix_notify(pci_dev, vector);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-int pvrdma_exec_cmd(PVRDMADev *dev);<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.h<=
br>
deleted file mode 100644<br>
index d231588ce0..0000000000<br>
--- a/hw/rdma/vmw/pvrdma_dev_ring.h<br>
+++ /dev/null<br>
@@ -1,46 +0,0 @@<br>
-/*<br>
- * QEMU VMWARE paravirtual RDMA ring utilities<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef PVRDMA_DEV_RING_H<br>
-#define PVRDMA_DEV_RING_H<br>
-<br>
-<br>
-#define MAX_RING_NAME_SZ 32<br>
-<br>
-typedef struct PvrdmaRingState {<br>
-=C2=A0 =C2=A0 int prod_tail; /* producer tail */<br>
-=C2=A0 =C2=A0 int cons_head; /* consumer head */<br>
-} PvrdmaRingState;<br>
-<br>
-typedef struct PvrdmaRing {<br>
-=C2=A0 =C2=A0 char name[MAX_RING_NAME_SZ];<br>
-=C2=A0 =C2=A0 PCIDevice *dev;<br>
-=C2=A0 =C2=A0 uint32_t max_elems;<br>
-=C2=A0 =C2=A0 size_t elem_sz;<br>
-=C2=A0 =C2=A0 PvrdmaRingState *ring_state; /* used only for unmap */<br>
-=C2=A0 =C2=A0 int npages;<br>
-=C2=A0 =C2=A0 void **pages;<br>
-} PvrdmaRing;<br>
-<br>
-int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PvrdmaRingState *ring_state, uint32_t max_elems,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0size_t elem_sz, dma_addr_t *tbl, uint32_t npages);<br>
-void *pvrdma_ring_next_elem_read(PvrdmaRing *ring);<br>
-void pvrdma_ring_read_inc(PvrdmaRing *ring);<br>
-void *pvrdma_ring_next_elem_write(PvrdmaRing *ring);<br>
-void pvrdma_ring_write_inc(PvrdmaRing *ring);<br>
-void pvrdma_ring_free(PvrdmaRing *ring);<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h<br>
deleted file mode 100644<br>
index bf2b15c5ce..0000000000<br>
--- a/hw/rdma/vmw/pvrdma_qp_ops.h<br>
+++ /dev/null<br>
@@ -1,28 +0,0 @@<br>
-/*<br>
- * QEMU VMWARE paravirtual RDMA QP Operations<br>
- *<br>
- * Copyright (C) 2018 Oracle<br>
- * Copyright (C) 2018 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *=C2=A0 =C2=A0 =C2=A0Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">marcel@redhat.com</a>&gt;<br>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef PVRDMA_QP_OPS_H<br>
-#define PVRDMA_QP_OPS_H<br>
-<br>
-#include &quot;pvrdma.h&quot;<br>
-<br>
-int pvrdma_qp_ops_init(void);<br>
-void pvrdma_qp_ops_fini(void);<br>
-void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle);<br>
-void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle);<br>
-void pvrdma_srq_recv(PVRDMADev *dev, uint32_t srq_handle);<br>
-void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle);<br>
-<br>
-#endif<br>
diff --git a/hw/rdma/vmw/trace.h b/hw/rdma/vmw/trace.h<br>
deleted file mode 100644<br>
index 3ebc9fb7ad..0000000000<br>
--- a/hw/rdma/vmw/trace.h<br>
+++ /dev/null<br>
@@ -1 +0,0 @@<br>
-#include &quot;trace/trace-hw_rdma_vmw.h&quot;<br>
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h<br>
deleted file mode 100644<br>
index 80b2e531c4..0000000000<br>
--- a/include/hw/rdma/rdma.h<br>
+++ /dev/null<br>
@@ -1,37 +0,0 @@<br>
-/*<br>
- * RDMA device interface<br>
- *<br>
- * Copyright (C) 2019 Oracle<br>
- * Copyright (C) 2019 Red Hat Inc<br>
- *<br>
- * Authors:<br>
- *=C2=A0 =C2=A0 =C2=A0Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia@oracle=
.com" target=3D"_blank" rel=3D"noreferrer">yuval.shaia@oracle.com</a>&gt;<b=
r>
- *<br>
- * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
- * See the COPYING file in the top-level directory.<br>
- *<br>
- */<br>
-<br>
-#ifndef RDMA_H<br>
-#define RDMA_H<br>
-<br>
-#include &quot;qom/object.h&quot;<br>
-<br>
-#define INTERFACE_RDMA_PROVIDER &quot;rdma&quot;<br>
-<br>
-typedef struct RdmaProviderClass RdmaProviderClass;<br>
-DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0INTERFACE_RDMA_PROVIDER)<br>
-#define RDMA_PROVIDER(obj) \<br>
-=C2=A0 =C2=A0 INTERFACE_CHECK(RdmaProvider, (obj), \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INTE=
RFACE_RDMA_PROVIDER)<br>
-<br>
-typedef struct RdmaProvider RdmaProvider;<br>
-<br>
-struct RdmaProviderClass {<br>
-=C2=A0 =C2=A0 InterfaceClass parent;<br>
-<br>
-=C2=A0 =C2=A0 void (*format_statistics)(RdmaProvider *obj, GString *buf);<=
br>
-};<br>
-<br>
-#endif<br>
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h<br>
index 13f9a2dedb..f4cf8f6717 100644<br>
--- a/include/monitor/hmp.h<br>
+++ b/include/monitor/hmp.h<br>
@@ -37,7 +37,6 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict);<br=
>
=C2=A0void hmp_info_balloon(Monitor *mon, const QDict *qdict);<br>
=C2=A0void hmp_info_irq(Monitor *mon, const QDict *qdict);<br>
=C2=A0void hmp_info_pic(Monitor *mon, const QDict *qdict);<br>
-void hmp_info_rdma(Monitor *mon, const QDict *qdict);<br>
=C2=A0void hmp_info_pci(Monitor *mon, const QDict *qdict);<br>
=C2=A0void hmp_info_tpm(Monitor *mon, const QDict *qdict);<br>
=C2=A0void hmp_info_iothreads(Monitor *mon, const QDict *qdict);<br>
diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrd=
ma_dev_api.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pv=
rdma_dev_api.h<br>
deleted file mode 100644<br>
index a5a1c8234e..0000000000<br>
--- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_=
api.h<br>
+++ /dev/null<br>
@@ -1,685 +0,0 @@<br>
-/*<br>
- * Copyright (c) 2012-2016 VMware, Inc.=C2=A0 All rights reserved.<br>
- *<br>
- * This program is free software; you can redistribute it and/or<br>
- * modify it under the terms of EITHER the GNU General Public License<br>
- * version 2 as published by the Free Software Foundation or the BSD<br>
- * 2-Clause License. This program is distributed in the hope that it<br>
- * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED<br>
- * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.<br>
- * See the GNU General Public License version 2 for more details at<br>
- * <a href=3D"http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html" re=
l=3D"noreferrer noreferrer" target=3D"_blank"></a></blockquote></div></div>=
</div>

--00000000000094637e0614b3cbfb--


