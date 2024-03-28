Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0527C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 06:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpjU0-0000i9-88; Thu, 28 Mar 2024 02:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpjTq-0000hY-AI
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpjTn-0004eF-SI
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711608194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5qmtW71V42Y5BVkepxOwObkaJK5JGfOw2TplHUjcLfY=;
 b=fonR4yJfuENDlNzzuMf7X4NtnEYLQF7VfPqqv7SdylBB57B7uvhaWQNJIUtiEm2l/EWFP+
 oYIbgYNvPuYGiXO46nK8ekEvSxNVqXZLZlcSBpfM3v8/4IQYMLdPsQvnSWJoZCqrUrrzCG
 7UHvGIOh6yiVuWQXNi17PBQAPdFmAsY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-DRWnQHnANmSJGN7-kMvvHg-1; Thu, 28 Mar 2024 02:43:10 -0400
X-MC-Unique: DRWnQHnANmSJGN7-kMvvHg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ed22e92c2so357430f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711608189; x=1712212989;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qmtW71V42Y5BVkepxOwObkaJK5JGfOw2TplHUjcLfY=;
 b=NKXLrfolwlobAabv3qGO8KobaCcRUu2DEmHb+byzfWV8pH1lc8vUvfj4snROLYrxjl
 bG4p0j9ogyDNOf46wk/ZhnF70I0iQFuWn5VaRdrVPv5MWGje+vw/Nsq10d5LLH1X9AIJ
 8bIQRW+iFA+1HDKR2M6q+PgS7UAkSeYjsoLgjmxDBrnSUbSiYKuAvUvqyzCcTUC3cl7/
 R0H6Yv3qwmyS1GaJk00PbiNcYvLUW8zvWM1RyE32tI5Fpd1vveKWCOJN2RiBVB81VHzP
 Snmiiu3oTmBQDlMaPjvvbO6qZFbJen3XcpoTO5Rx2l2dM1GPWo1VaqBYrAUEqLqPtvKs
 +5Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSslvc1gTL/7drJaKpA45IaAgayQz0yE6eU5ZQhk6v6VIf2z3jwnmPkLfOp4nvUu9q5ttoqxwWK5adsx4oP4rOY+vdzF8=
X-Gm-Message-State: AOJu0YzVGva2kUkmyiqFLB1WbLxVMaU4eJb7d18oGAjNSSjdEVpszl6e
 +XtzeAfG5NJznDY0NSLpwr5Qk3Re36Y2pBAylmyKy9Zj0HUnd/HjCoIDgzxI1KAkkgWFF09JvK1
 aVRo2wIRHI4Hfhdm6EKA8ruQ6LGvg9u6JwvA94WbJ4MqE9aJDCBwh
X-Received: by 2002:a5d:648b:0:b0:341:c14b:9120 with SMTP id
 o11-20020a5d648b000000b00341c14b9120mr1785004wri.70.1711608189822; 
 Wed, 27 Mar 2024 23:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2ETizkRx+2rJ5PRJvcq6SqTLJgyJO1cl/oULtbRVB6FCPEfBw1VS9zAsqIe7dNiVHZqqqGA==
X-Received: by 2002:a5d:648b:0:b0:341:c14b:9120 with SMTP id
 o11-20020a5d648b000000b00341c14b9120mr1784982wri.70.1711608189392; 
 Wed, 27 Mar 2024 23:43:09 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 u6-20020adfa186000000b00341e2146b53sm858986wru.106.2024.03.27.23.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 23:43:09 -0700 (PDT)
Message-ID: <4a43ca17-fc42-402e-8df9-925bc4da8d2c@redhat.com>
Date: Thu, 28 Mar 2024 07:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] rdma: Remove RDMA subsystem and pvrdma device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>, integration@gluster.org,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 devel@lists.libvirt.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240327105549.1824-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240327105549.1824-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/03/2024 11.55, Philippe Mathieu-Daudé wrote:
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
> Remove rdmacm-mux tool from contrib/.
> 
> Remove PVRDMA device.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                                   |   17 -
>   docs/about/deprecated.rst                     |    9 -
>   docs/about/removed-features.rst               |    4 +
>   docs/devel/migration/main.rst                 |    6 -
>   docs/pvrdma.txt                               |  345 --
>   docs/rdma.txt                                 |  420 --
>   docs/system/device-url-syntax.rst.inc         |    4 +-
>   docs/system/loongarch/virt.rst                |    2 +-
>   docs/system/qemu-block-drivers.rst.inc        |    1 -
>   meson.build                                   |   59 -
>   qapi/machine.json                             |   17 -
>   qapi/migration.json                           |   31 +-
>   qapi/qapi-schema.json                         |    1 -
>   qapi/rdma.json                                |   38 -
>   contrib/rdmacm-mux/rdmacm-mux.h               |   61 -
>   hw/rdma/rdma_backend.h                        |  129 -
>   hw/rdma/rdma_backend_defs.h                   |   76 -
>   hw/rdma/rdma_rm.h                             |   97 -
>   hw/rdma/rdma_rm_defs.h                        |  146 -
>   hw/rdma/rdma_utils.h                          |   63 -
>   hw/rdma/trace.h                               |    1 -
>   hw/rdma/vmw/pvrdma.h                          |  144 -
>   hw/rdma/vmw/pvrdma_dev_ring.h                 |   46 -
>   hw/rdma/vmw/pvrdma_qp_ops.h                   |   28 -
>   hw/rdma/vmw/trace.h                           |    1 -
>   include/hw/rdma/rdma.h                        |   37 -
>   include/monitor/hmp.h                         |    1 -
>   .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  685 ---
>   .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  348 --
>   .../standard-headers/rdma/vmw_pvrdma-abi.h    |  310 --
>   migration/migration-stats.h                   |    6 +-
>   migration/migration.h                         |    9 -
>   migration/options.h                           |    2 -
>   migration/rdma.h                              |   69 -
>   block/gluster.c                               |   39 -
>   contrib/rdmacm-mux/main.c                     |  831 ----
>   hw/core/machine-qmp-cmds.c                    |   32 -
>   hw/rdma/rdma.c                                |   30 -
>   hw/rdma/rdma_backend.c                        | 1401 ------
>   hw/rdma/rdma_rm.c                             |  812 ----
>   hw/rdma/rdma_utils.c                          |  126 -
>   hw/rdma/vmw/pvrdma_cmd.c                      |  815 ----
>   hw/rdma/vmw/pvrdma_dev_ring.c                 |  141 -
>   hw/rdma/vmw/pvrdma_main.c                     |  735 ---
>   hw/rdma/vmw/pvrdma_qp_ops.c                   |  298 --
>   migration/migration-stats.c                   |    5 +-
>   migration/migration.c                         |   31 -
>   migration/options.c                           |   16 -
>   migration/qemu-file.c                         |    1 -
>   migration/ram.c                               |   86 +-
>   migration/rdma.c                              | 4184 -----------------
>   migration/savevm.c                            |    2 +-
>   monitor/qmp-cmds.c                            |    1 -
>   Kconfig.host                                  |    3 -
>   contrib/rdmacm-mux/meson.build                |    7 -
>   hmp-commands-info.hx                          |   13 -
>   hw/Kconfig                                    |    1 -
>   hw/meson.build                                |    1 -
>   hw/rdma/Kconfig                               |    3 -
>   hw/rdma/meson.build                           |   12 -
>   hw/rdma/trace-events                          |   31 -
>   hw/rdma/vmw/trace-events                      |   17 -
>   meson_options.txt                             |    4 -
>   migration/meson.build                         |    1 -
>   migration/trace-events                        |   68 +-
>   qapi/meson.build                              |    1 -
>   qemu-options.hx                               |    6 -
>   .../ci/org.centos/stream/8/x86_64/configure   |    1 -
>   scripts/ci/setup/build-environment.yml        |    2 -
>   scripts/coverity-scan/run-coverity-scan       |    2 +-
>   scripts/meson-buildoptions.sh                 |    6 -
>   scripts/update-linux-headers.sh               |   27 -
>   tests/lcitool/projects/qemu.yml               |    2 -
>   tests/migration/guestperf/engine.py           |    4 +-
>   74 files changed, 20 insertions(+), 12991 deletions(-)
>   delete mode 100644 docs/pvrdma.txt
>   delete mode 100644 docs/rdma.txt
>   delete mode 100644 qapi/rdma.json
>   delete mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
>   delete mode 100644 hw/rdma/rdma_backend.h
>   delete mode 100644 hw/rdma/rdma_backend_defs.h
>   delete mode 100644 hw/rdma/rdma_rm.h
>   delete mode 100644 hw/rdma/rdma_rm_defs.h
>   delete mode 100644 hw/rdma/rdma_utils.h
>   delete mode 100644 hw/rdma/trace.h
>   delete mode 100644 hw/rdma/vmw/pvrdma.h
>   delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>   delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>   delete mode 100644 hw/rdma/vmw/trace.h
>   delete mode 100644 include/hw/rdma/rdma.h
>   delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
>   delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
>   delete mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h
>   delete mode 100644 migration/rdma.h
>   delete mode 100644 contrib/rdmacm-mux/main.c
>   delete mode 100644 hw/rdma/rdma.c
>   delete mode 100644 hw/rdma/rdma_backend.c
>   delete mode 100644 hw/rdma/rdma_rm.c
>   delete mode 100644 hw/rdma/rdma_utils.c
>   delete mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>   delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>   delete mode 100644 hw/rdma/vmw/pvrdma_main.c
>   delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>   delete mode 100644 migration/rdma.c
>   delete mode 100644 contrib/rdmacm-mux/meson.build
>   delete mode 100644 hw/rdma/Kconfig
>   delete mode 100644 hw/rdma/meson.build
>   delete mode 100644 hw/rdma/trace-events
>   delete mode 100644 hw/rdma/vmw/trace-events

  Hi Philippe!

Looking at this rdma stuff again after I while, I realized that there are 
actually 3 parts in QEMU related to RDMA:
1) The "pvrdma" device in hw/rdma/vmw/
2) The rdma subsystem in hw/rda/*.[ch]
3) The rdma migration code in the migration/ folder.

While the deprecation note in docs/about/deprecated.rst clearly talks about 
the "pvrdma" device and the rdma subsystem, I'm unsure whether that includes 
the rdma migration code or not.

Anyway, could you please split your patch at least in two (maybe even in 
three) parts, so that the removal of the rdma migration code is in a 
separate patch? That way we can discuss that separately (and maybe also 
revert it more easily in the future if necessary).

  Thanks,
   Thomas


