Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D7C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmYO-00031B-FR; Thu, 28 Mar 2024 06:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpmYD-0002zK-8P
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpmY7-00039a-Mc
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711619994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azsmWgF7HAWVnxkclhkzvmOEbzF9YQbWRc4KlSwEEjE=;
 b=TjHGeR3FryDdMvlwEz8GqtVgV6TqGGILvjUd6uzAhV62h9N8Zq8LplCdaqZui42zJCtLON
 RsoQU9AaMOTkKEuCMpmvJZIGhu8zhSsaYR5OwexjScd7CRW8T3xpxTQNWDUXBOp5tYTlut
 phjsbLYHyks0EkY0izLnKiWiHF2qEF0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-xFclMYONOfi7tvkNKa3qFw-1; Thu, 28 Mar 2024 05:59:50 -0400
X-MC-Unique: xFclMYONOfi7tvkNKa3qFw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56c1b105949so530434a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 02:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711619989; x=1712224789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azsmWgF7HAWVnxkclhkzvmOEbzF9YQbWRc4KlSwEEjE=;
 b=vnWSg5MXS98fcJMI/coRf+2aIjKT/p6pttS3cxN0p3e9hKLqDhYr/J1MMC+eGBB/EU
 NsmcHY+eZwUUe36glL+KdQIR2NGwyItDZvSedJ/Wip6dnum1k1Us6LAwFBnepy6uwJ2c
 MooYjuHBerg4FKSLo1SILyG8zyNLxsFl1t6y8ctx1hgzFGf6LxtyMjB2R6zOcKpdlRc0
 UamfK4XUdxS9JC0RAbmj3In/PEwfOaOoMmGtRLLrDHEiwI3tk/rI84x7TZ0/BGwL1MkS
 GAPPfNTjorDs2JIb80WTdT/WFqfRPvOhSJgDqV9LjX9hKW9tU7SXuS4cCoQRVLYt6CxY
 9kyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTmNeSWLoVz7I9aUAA/E/O+mE/62BBf3tE5dh/em6/UmLGCEDCbT4LIpLwJRdPeucjfySac3WckynxNYNSRkdV4gjboqs=
X-Gm-Message-State: AOJu0YyuwwhQ3UJIljO64bXROyHo9oqocfejRy9ljOizkaNEieQhadr7
 rRIrVjTEEFyXQsPHnjTCV0f+6Gfb48qFKsq5herzoyOX03dfnNvqjM+LZUe8iqLmDqey3uY+Q4k
 Q8WLxw3d0WVjBlrQluDipY3GPYOFWxPxZCez3BXp5O/Lbj4xpLCxH
X-Received: by 2002:a17:907:7216:b0:a46:7323:6ab3 with SMTP id
 dr22-20020a170907721600b00a4673236ab3mr1839256ejc.49.1711619988719; 
 Thu, 28 Mar 2024 02:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW7D/IhHqpKCEpfnsrBsdnchk0iM0Sd6r0NBmhQDPbvrJSqceN1yeElf9FD8F0K9ETaQu/QA==
X-Received: by 2002:a17:907:7216:b0:a46:7323:6ab3 with SMTP id
 dr22-20020a170907721600b00a4673236ab3mr1839221ejc.49.1711619988191; 
 Thu, 28 Mar 2024 02:59:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a170906339200b00a4df78425dbsm553587eja.36.2024.03.28.02.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 02:59:47 -0700 (PDT)
Date: Thu, 28 Mar 2024 05:59:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 integration@gluster.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, devel@lists.libvirt.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH-for-9.1] rdma: Remove RDMA subsystem and pvrdma device
Message-ID: <20240328055821-mutt-send-email-mst@kernel.org>
References: <20240327105549.1824-1-philmd@linaro.org>
 <4a43ca17-fc42-402e-8df9-925bc4da8d2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a43ca17-fc42-402e-8df9-925bc4da8d2c@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Mar 28, 2024 at 07:43:06AM +0100, Thomas Huth wrote:
> On 27/03/2024 11.55, Philippe Mathieu-Daudé wrote:
> > The whole RDMA subsystem was deprecated in commit e9a54265f5
> > ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> > released in v8.2. Time to remove it.
> > 
> > Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> > in old migration streams.
> > 
> > Remove the dependencies on libibumad and libibverbs.
> > 
> > Remove the generated vmw_pvrdma/ directory from linux-headers.
> > 
> > Remove RDMA handling from migration.
> > 
> > Remove RDMA handling in GlusterFS block driver.
> > 
> > Remove rdmacm-mux tool from contrib/.
> > 
> > Remove PVRDMA device.
> > 
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >   MAINTAINERS                                   |   17 -
> >   docs/about/deprecated.rst                     |    9 -
> >   docs/about/removed-features.rst               |    4 +
> >   docs/devel/migration/main.rst                 |    6 -
> >   docs/pvrdma.txt                               |  345 --
> >   docs/rdma.txt                                 |  420 --
> >   docs/system/device-url-syntax.rst.inc         |    4 +-
> >   docs/system/loongarch/virt.rst                |    2 +-
> >   docs/system/qemu-block-drivers.rst.inc        |    1 -
> >   meson.build                                   |   59 -
> >   qapi/machine.json                             |   17 -
> >   qapi/migration.json                           |   31 +-
> >   qapi/qapi-schema.json                         |    1 -
> >   qapi/rdma.json                                |   38 -
> >   contrib/rdmacm-mux/rdmacm-mux.h               |   61 -
> >   hw/rdma/rdma_backend.h                        |  129 -
> >   hw/rdma/rdma_backend_defs.h                   |   76 -
> >   hw/rdma/rdma_rm.h                             |   97 -
> >   hw/rdma/rdma_rm_defs.h                        |  146 -
> >   hw/rdma/rdma_utils.h                          |   63 -
> >   hw/rdma/trace.h                               |    1 -
> >   hw/rdma/vmw/pvrdma.h                          |  144 -
> >   hw/rdma/vmw/pvrdma_dev_ring.h                 |   46 -
> >   hw/rdma/vmw/pvrdma_qp_ops.h                   |   28 -
> >   hw/rdma/vmw/trace.h                           |    1 -
> >   include/hw/rdma/rdma.h                        |   37 -
> >   include/monitor/hmp.h                         |    1 -
> >   .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  685 ---
> >   .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  348 --
> >   .../standard-headers/rdma/vmw_pvrdma-abi.h    |  310 --
> >   migration/migration-stats.h                   |    6 +-
> >   migration/migration.h                         |    9 -
> >   migration/options.h                           |    2 -
> >   migration/rdma.h                              |   69 -
> >   block/gluster.c                               |   39 -
> >   contrib/rdmacm-mux/main.c                     |  831 ----
> >   hw/core/machine-qmp-cmds.c                    |   32 -
> >   hw/rdma/rdma.c                                |   30 -
> >   hw/rdma/rdma_backend.c                        | 1401 ------
> >   hw/rdma/rdma_rm.c                             |  812 ----
> >   hw/rdma/rdma_utils.c                          |  126 -
> >   hw/rdma/vmw/pvrdma_cmd.c                      |  815 ----
> >   hw/rdma/vmw/pvrdma_dev_ring.c                 |  141 -
> >   hw/rdma/vmw/pvrdma_main.c                     |  735 ---
> >   hw/rdma/vmw/pvrdma_qp_ops.c                   |  298 --
> >   migration/migration-stats.c                   |    5 +-
> >   migration/migration.c                         |   31 -
> >   migration/options.c                           |   16 -
> >   migration/qemu-file.c                         |    1 -
> >   migration/ram.c                               |   86 +-
> >   migration/rdma.c                              | 4184 -----------------
> >   migration/savevm.c                            |    2 +-
> >   monitor/qmp-cmds.c                            |    1 -
> >   Kconfig.host                                  |    3 -
> >   contrib/rdmacm-mux/meson.build                |    7 -
> >   hmp-commands-info.hx                          |   13 -
> >   hw/Kconfig                                    |    1 -
> >   hw/meson.build                                |    1 -
> >   hw/rdma/Kconfig                               |    3 -
> >   hw/rdma/meson.build                           |   12 -
> >   hw/rdma/trace-events                          |   31 -
> >   hw/rdma/vmw/trace-events                      |   17 -
> >   meson_options.txt                             |    4 -
> >   migration/meson.build                         |    1 -
> >   migration/trace-events                        |   68 +-
> >   qapi/meson.build                              |    1 -
> >   qemu-options.hx                               |    6 -
> >   .../ci/org.centos/stream/8/x86_64/configure   |    1 -
> >   scripts/ci/setup/build-environment.yml        |    2 -
> >   scripts/coverity-scan/run-coverity-scan       |    2 +-
> >   scripts/meson-buildoptions.sh                 |    6 -
> >   scripts/update-linux-headers.sh               |   27 -
> >   tests/lcitool/projects/qemu.yml               |    2 -
> >   tests/migration/guestperf/engine.py           |    4 +-
> >   74 files changed, 20 insertions(+), 12991 deletions(-)
> >   delete mode 100644 docs/pvrdma.txt
> >   delete mode 100644 docs/rdma.txt
> >   delete mode 100644 qapi/rdma.json
> >   delete mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
> >   delete mode 100644 hw/rdma/rdma_backend.h
> >   delete mode 100644 hw/rdma/rdma_backend_defs.h
> >   delete mode 100644 hw/rdma/rdma_rm.h
> >   delete mode 100644 hw/rdma/rdma_rm_defs.h
> >   delete mode 100644 hw/rdma/rdma_utils.h
> >   delete mode 100644 hw/rdma/trace.h
> >   delete mode 100644 hw/rdma/vmw/pvrdma.h
> >   delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
> >   delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
> >   delete mode 100644 hw/rdma/vmw/trace.h
> >   delete mode 100644 include/hw/rdma/rdma.h
> >   delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> >   delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> >   delete mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h
> >   delete mode 100644 migration/rdma.h
> >   delete mode 100644 contrib/rdmacm-mux/main.c
> >   delete mode 100644 hw/rdma/rdma.c
> >   delete mode 100644 hw/rdma/rdma_backend.c
> >   delete mode 100644 hw/rdma/rdma_rm.c
> >   delete mode 100644 hw/rdma/rdma_utils.c
> >   delete mode 100644 hw/rdma/vmw/pvrdma_cmd.c
> >   delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
> >   delete mode 100644 hw/rdma/vmw/pvrdma_main.c
> >   delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
> >   delete mode 100644 migration/rdma.c
> >   delete mode 100644 contrib/rdmacm-mux/meson.build
> >   delete mode 100644 hw/rdma/Kconfig
> >   delete mode 100644 hw/rdma/meson.build
> >   delete mode 100644 hw/rdma/trace-events
> >   delete mode 100644 hw/rdma/vmw/trace-events
> 
>  Hi Philippe!
> 
> Looking at this rdma stuff again after I while, I realized that there are
> actually 3 parts in QEMU related to RDMA:
> 1) The "pvrdma" device in hw/rdma/vmw/
> 2) The rdma subsystem in hw/rda/*.[ch]
> 3) The rdma migration code in the migration/ folder.
> 
> While the deprecation note in docs/about/deprecated.rst clearly talks about
> the "pvrdma" device and the rdma subsystem, I'm unsure whether that includes
> the rdma migration code or not.
> 
> Anyway, could you please split your patch at least in two (maybe even in
> three) parts, so that the removal of the rdma migration code is in a
> separate patch? That way we can discuss that separately (and maybe also
> revert it more easily in the future if necessary).
> 
>  Thanks,
>   Thomas


I agree. E.g. rdma migration would be up to migration maintainers.


-- 
MST


