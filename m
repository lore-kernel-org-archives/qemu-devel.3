Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968CDCD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPQl6-0002Vj-05; Tue, 19 May 2026 16:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPQkz-0002UN-3j
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPQkv-0000xR-LY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779221370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+O1GrX1fBqzVDcoyySoS/y3ChAmA2Uz09Bcbhy0iLw=;
 b=EB4BTMsy/I90unZuPcI0MJsnAHxHfjQWLufyM+tVjp2xbN5CS8+20v95w9sDo/wyqORteD
 40lnRZ9IjnqGsxstvy1W82PF5jdFx+/XNzlTafTwu9A4zStNhwfvQRHspgu4ia+mosSsyH
 0wzem+2IgxhvfPYzTu9e8MfVWTiLAMY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-v1-XOe7VM5-uN8L9UThEJw-1; Tue, 19 May 2026 16:09:28 -0400
X-MC-Unique: v1-XOe7VM5-uN8L9UThEJw-1
X-Mimecast-MFC-AGG-ID: v1-XOe7VM5-uN8L9UThEJw_1779221368
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b49424ad88so136898856d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779221368; x=1779826168; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W+O1GrX1fBqzVDcoyySoS/y3ChAmA2Uz09Bcbhy0iLw=;
 b=NNOujyR35bW0ojVif9UsPI4KeFqXlSfNwQQKOBFfWhBQCOwwk6zPj5VfIJWRRg/4wW
 TKCelfJDWP3PkoNtY3lvkIf6aNmBWPdcQkTiirKgY2nl36/H+GswjeFsNKyw2l/oMvqr
 Sq98rv8bOR16FDqGEn21JWovgiAXpFaEIWfBTeGFo4ArBFy4h+AsY/3puqF+w95amFMQ
 TWATiRQ5tx+w1PnykW60kVAyR1Yw3yRqq9ErFvnpYgMNrRIya48tFOI4Al+YHgkaQon6
 wTAu/fEDR49HL5rsGIi3bYX+Gkv6a5jw18NeAaILtrwv79IvYqwigHui/fLj6JfFEfKE
 eOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779221368; x=1779826168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+O1GrX1fBqzVDcoyySoS/y3ChAmA2Uz09Bcbhy0iLw=;
 b=VWfKx+Iy767zBmhm9qoDiHxpKAcgHi3swH7pJWZv/0EhqZU1n0A+iOZy0joR2zGqoG
 c0u38mcyvlg12wd2cXnuPiEpYgB7wzqZiK1wTZj0uuLi9UyTKVBieiq3tpJJm4o1yW9+
 Cw/1eFuWfLvTvt5eXSDOJwmSSQPKmPyYhZRPEK1veqlo0QvmyGaYk1xQZA62/WE7Eoip
 683Jq+AKtnAr66lTSR2jSJ8wdjPv+DwQQ47bD9nZQ7+DaHSAsfWrRTnTyWuMJWSZ2dVp
 LMqRhvqBbbo6aK773pL1kerdIl1NisLV/9Lt1rNjsYkkn2JQgtER74PAvOeJzoQ62hEx
 5Lyw==
X-Gm-Message-State: AOJu0Yw6ukIMvrBDDxHpkW5K+Wg2I7qDLM65EOPaGjIdH0vN6psdbbgx
 /tIW/W1s+Y9bR0XegCjzBav2ircpG426GDqWUyyKyDuwC5RjJkYy8kmlrJrhn2Blmo4l/qTFvsn
 4NaWG1XQJzHgAcDDh3qLxLA86G9Mqgq9IGG0SROBfxK916hLKloceQY5h
X-Gm-Gg: Acq92OGEa7OzM2PwdC7iDdICJnGr8uQf2/rPRrYZii8VaNMKSKpcExqq/m1624BhC2t
 Rvxmfcy7TmuOe2IPOZZvemgRt5gTGeMyrjRSAOvn3Y4VsjnpRLt1fXMxZXjHptzGWZiCy3im6cy
 a/kgLigkyEviwY8/C4xUCL+mB93KpIDe4YCCd72wZmXvn+E7fh06h2Z8BdlJ366NIvTB8sZCPn+
 INbqlGEiHHu010IUED2ZWi/Xy/gXDphtT/I35AvIhS46ictUokltGsYOTtIh4IfxCESPLLHdRuL
 +hsGMgMOylH2vSkwxUD4o0kLUy6fowWU9kII0vnmbHiyKM3Mx/FSgEqfonSAxGOQmFqzPKZyKGe
 LtJF5NmRXk5Aia5AcdVBM4V6tEQfq6fmV42QW2iVYiwWe8Mw=
X-Received: by 2002:a05:620a:3188:b0:8cf:c272:9721 with SMTP id
 af79cd13be357-911ccd8b9d3mr3131173085a.6.1779221367764; 
 Tue, 19 May 2026 13:09:27 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:8cf:c272:9721 with SMTP id
 af79cd13be357-911ccd8b9d3mr3131164985a.6.1779221367168; 
 Tue, 19 May 2026 13:09:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc936407sm1950783685a.22.2026.05.19.13.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:09:26 -0700 (PDT)
Date: Tue, 19 May 2026 16:09:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Message-ID: <agzDdH5vClAqwjAs@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 05, 2026 at 11:14:09AM +0300, Avihai Horon wrote:
> Performance tests were done by migrating a single VM with:
> * 8 GB RAM
> * 4 mlx5 VFIO devices:
>   - One device with 1GB of device data (stopcopy data) that runs
>     workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
>     (generate new initial_bytes chunks during precopy).

Could you elaborate a bit more on what workload is executed, and how that
will affect REINIT reportings (e.g. is only one REINIT generated, or it
keeps generating)?

Can I understand it in this way: without REINIT, device is forced to put
those data into stopcopy size; then with REINIT, some stopcopy size is
essentially moved back to precopy phase?

Thanks,

>   - The other 3 devices are idle.
> 
> In this setup, VFIO_PRECOPY_INFO_REINIT reduced total migration downtime by
> about 43%, and downtime attributed to the busy VFIO device by about 67%:
> 
> With VFIO_PRECOPY_INFO_REINIT:
>   1335ms total (~520ms from the VFIO device running the workload).
> 
> Without VFIO_PRECOPY_INFO_REINIT:
>   2352ms total (~1600ms from the VFIO device running the workload).
> 
> Functional tests covered the main code paths and combinations, including
> legacy and new switchover-ack across versions, for example:
> * Migration between QEMU 11.0 (old binary) and 11.1 (new binary).
> * Migration between two 11.1 binaries with different machine versions.
> * Migration when the VFIO device has no VFIO_PRECOPY_INFO_REINIT.
> * Migration when the VFIO device has no VFIO precopy support.
> 
> === Patch Breakdown ===
> 
> * Patches 1-2: Update Linux headers
> * Patches 3-8,14: Migration cleanups and the new switchover-ack mechanism
> * Patches 9-13: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT
> 
> Thanks.
> 
> [1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
> [2] https://lore.kernel.org/qemu-devel/20260421202110.306051-1-peterx@redhat.com/
> 
> Avihai Horon (14):
>   scripts/update-linux-headers: Add typelimits.h
>   linux-headers: Update to Linux v7.1-rc1
>   migration: Propagate errors in migration_completion_precopy()
>   migration: Log the approver in qemu_loadvm_approve_switchover()
>   migration: Replace switchover_ack_needed SaveVMHandler
>   migration: Rename switchover-ack code to legacy
>   migration: Make switchover-ack re-usable
>   migration: Check switchover-ack during switchover phase
>   vfio/migration: Re-query precopy size before sending
>     VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>   vfio/migration: Add Error ** parameter to vfio_migration_init()
>   vfio/migration: Add new switchover-ack mechanism
>   vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
>   vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
>   migration: Enable new switchover-ack
> 
>  docs/devel/migration/vfio.rst                 |   4 +-
>  hw/vfio/vfio-migration-internal.h             |   2 +
>  include/migration/client-options.h            |   1 +
>  include/migration/misc.h                      |   2 +
>  include/migration/register.h                  |  21 +-
>  include/standard-headers/drm/drm_fourcc.h     |  28 +-
>  include/standard-headers/linux/const.h        |  18 +
>  include/standard-headers/linux/ethtool.h      |  28 +-
>  .../linux/input-event-codes.h                 |  13 +
>  include/standard-headers/linux/pci_regs.h     |  71 ++-
>  include/standard-headers/linux/typelimits.h   |   8 +
>  include/standard-headers/linux/virtio_ring.h  |   3 +-
>  include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>  include/standard-headers/linux/vmclock-abi.h  |  20 +
>  linux-headers/asm-arm64/kvm.h                 |   1 +
>  linux-headers/asm-arm64/unistd_64.h           |   1 +
>  linux-headers/asm-generic/unistd.h            |   5 +-
>  linux-headers/asm-loongarch/kvm.h             |   5 +
>  linux-headers/asm-loongarch/kvm_para.h        |   1 +
>  linux-headers/asm-loongarch/unistd_64.h       |   2 +
>  linux-headers/asm-mips/unistd_n32.h           |   1 +
>  linux-headers/asm-mips/unistd_n64.h           |   1 +
>  linux-headers/asm-mips/unistd_o32.h           |   1 +
>  linux-headers/asm-powerpc/unistd_32.h         |   1 +
>  linux-headers/asm-powerpc/unistd_64.h         |   1 +
>  linux-headers/asm-riscv/kvm.h                 |  11 +-
>  linux-headers/asm-riscv/ptrace.h              |  37 ++
>  linux-headers/asm-riscv/unistd_32.h           |   1 +
>  linux-headers/asm-riscv/unistd_64.h           |   1 +
>  linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>  linux-headers/asm-s390/unistd_64.h            |   1 +
>  linux-headers/asm-x86/kvm.h                   |  21 +-
>  linux-headers/asm-x86/unistd_32.h             |   1 +
>  linux-headers/asm-x86/unistd_64.h             |   1 +
>  linux-headers/asm-x86/unistd_x32.h            |   1 +
>  linux-headers/linux/const.h                   |  18 +
>  linux-headers/linux/iommufd.h                 |  48 ++
>  linux-headers/linux/kvm.h                     |  46 +-
>  linux-headers/linux/mshv.h                    |   4 +-
>  linux-headers/linux/psp-sev.h                 |   2 +-
>  linux-headers/linux/stddef.h                  |   4 +
>  linux-headers/linux/vduse.h                   |  85 +++-
>  linux-headers/linux/vfio.h                    |  30 +-
>  migration/migration.h                         |  17 +-
>  migration/savevm.h                            |   4 +-
>  hw/core/machine.c                             |   4 +-
>  hw/vfio/migration.c                           | 195 +++++++-
>  migration/migration.c                         |  65 ++-
>  migration/options.c                           |   9 +
>  migration/savevm.c                            | 146 ++++--
>  hw/vfio/trace-events                          |   5 +-
>  migration/trace-events                        |   8 +-
>  scripts/update-linux-headers.sh               |   2 +
>  53 files changed, 1109 insertions(+), 580 deletions(-)
>  create mode 100644 include/standard-headers/linux/typelimits.h
>  create mode 100644 include/standard-headers/linux/virtio_rtc.h
>  delete mode 100644 linux-headers/asm-s390/unistd_32.h
> 
> -- 
> 2.40.1
> 

-- 
Peter Xu


