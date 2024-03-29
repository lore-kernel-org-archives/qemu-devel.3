Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733BFCD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 09:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq8Mt-0005zr-JH; Fri, 29 Mar 2024 05:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rq8Ms-0005zG-6V
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 05:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rq8Mq-0006HF-2z
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 05:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711703861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLlTag7zAekgbagmIw8mbm18yzUY9EFJ0TfikZDTNPw=;
 b=cwqDAzhu2ac9dEZA+b6MeFNtTcYm0pptqadhhG0Hkm8389N0oXFMS17Yxrq6qnlwwAQsai
 YakQIZwODJPPF3dr4T6IUzRvx2b/5w+59DpM1D2j+SC4K/Gpkitw2OGoI+nWI6lexwuQmS
 +U8/iGxDB3o5mSpQNMhPcfx2AwjN2Yk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640--MPWjVFgNgKjucJcIO6ZgA-1; Fri, 29 Mar 2024 05:17:39 -0400
X-MC-Unique: -MPWjVFgNgKjucJcIO6ZgA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3419f517aceso804704f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 02:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711703858; x=1712308658;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLlTag7zAekgbagmIw8mbm18yzUY9EFJ0TfikZDTNPw=;
 b=AagMg0UTeM9n0GQyP3Yrp2YEyUr/uDmPi1H8OnGNQTfj8qrO+IkffAu8hNXSEbNPfT
 Kqc45K5YhLaOoZNAyad7Y2JP4X5eE81DX7oB9Nrm3a9Punwf/XJadwgWOLjflHF07rR2
 VsLSScAjcu1aZpl+BsRmwXTYDJ0v/O34XdxMzEVFWL5XCwk31JQJ+81HZObkk32gXJax
 tq5dliwKuoFcgFr98zmOdC9sukJvjr+0vLWzBoHRUHvaFho3ALWy/iKqQ/0mwcOyEwZt
 Y1uj6LUO+HFPUeNE6O5aCYIZzCdTj1RUlVir5ACAIWfYneL6wzFXH3xxFBuZeUajOowu
 QQWw==
X-Gm-Message-State: AOJu0Yw5jOo2ToSXQTUkUhtNowU5Okdv9+ZKQ9ElVWnsj9hhr7pgIhzo
 trox9JHmRWGm7Cs7qKfaSX/+6SPC8eYzWzG/cmmqgGUiDGHanH3uyyYdgImXuednMwbBrMWmBzG
 MSVNgAlk540+OHsHgToGYa9snaxQhqvZ3PYECsqQ9i7A3UtHj4aQU
X-Received: by 2002:a05:6000:366:b0:33e:c389:69ff with SMTP id
 f6-20020a056000036600b0033ec38969ffmr864974wrf.68.1711703858264; 
 Fri, 29 Mar 2024 02:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTyhRGICXbOTjkDKJhe8gKToavRFoY4b0C0k4aX0IC1e/LJzugAgbLdlTF3D9d+f35ASogIQ==
X-Received: by 2002:a05:6000:366:b0:33e:c389:69ff with SMTP id
 f6-20020a056000036600b0033ec38969ffmr864942wrf.68.1711703857708; 
 Fri, 29 Mar 2024 02:17:37 -0700 (PDT)
Received: from redhat.com ([2.52.20.36]) by smtp.gmail.com with ESMTPSA id
 by7-20020a056000098700b0033ec94c6277sm3738954wrb.115.2024.03.29.02.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 02:17:37 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:17:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Peter Xu <peterx@redhat.com>, integration@gluster.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Hanna Reitz <hreitz@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH-for-9.1 v2 0/3] rdma: Remove RDMA subsystem and pvrdma
 device
Message-ID: <20240329051727-mutt-send-email-mst@kernel.org>
References: <20240328130255.52257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328130255.52257-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 28, 2024 at 02:02:52PM +0100, Philippe Mathieu-Daudé wrote:
> Since v1:
> - split in 3 (Thomas)
> - justify gluster removal


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Philippe Mathieu-Daudé (3):
>   hw/rdma: Remove pvrdma device and rdmacm-mux helper
>   migration: Remove RDMA protocol handling
>   block/gluster: Remove RDMA protocol handling
> 
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
>  .../org.centos/stream/8/build-environment.yml |    1 -
>  .../ci/org.centos/stream/8/x86_64/configure   |    3 -
>  scripts/ci/setup/build-environment.yml        |    4 -
>  scripts/coverity-scan/run-coverity-scan       |    2 +-
>  scripts/meson-buildoptions.sh                 |    6 -
>  scripts/update-linux-headers.sh               |   27 -
>  tests/lcitool/projects/qemu.yml               |    3 -
>  tests/migration/guestperf/engine.py           |    4 +-
>  75 files changed, 20 insertions(+), 12997 deletions(-)
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
>  delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
>  delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
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
> -- 
> 2.41.0


