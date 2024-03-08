Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D08C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVO8-0004ZJ-4w; Fri, 08 Mar 2024 03:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVO1-0004Gb-Id
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVNz-0006f3-E1
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qz0t4VAlb9hDr3hFHLVB6VLuwIKi4YzP5caT6M4b2qU=;
 b=JtC/eQnnzN1EUpGRcFwXq8papIeK3LHgU1SflTXEFCzUV5G8JRMMnOIceyC/IkpiciLV0i
 kYIFW4jdL6JxPTO3eAy0QMcosG47+p6yAzcZzqjsNDs3A5ZW37hXDX21hlGmV42ynUvhAp
 FoC2q7JjKeN2zMCTTn5y35wSvK2p5LY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-jwvsoBYxO1aXofdva4P0AQ-1; Fri, 08 Mar 2024 03:15:20 -0500
X-MC-Unique: jwvsoBYxO1aXofdva4P0AQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so392296a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885719; x=1710490519;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qz0t4VAlb9hDr3hFHLVB6VLuwIKi4YzP5caT6M4b2qU=;
 b=dHAkyCd1ysnXzYHJUeUTPlbbPJ5r9GB3t48awtGhau2bhYK3YxhUsKuiL/HZeaLgGp
 fOpx8rQPR1cyXYP263ldL2pUOI9STUA6difHdHEnFDId08SLaBUN8vj3LrrLMu3aSpNd
 av0Z3wdk1Z9jDHaZk4pf0bpMpcw0DL6UXLhFRYPXD8qj9IZhvjbw5iBzgDTWUqXeOaTm
 AEPbcW6MKXnKmhTPJ7aMbpzELlL6oQAmRezhC23fpq0kdMBVq0DR90OO93MC06DRSZKV
 LzbKzZIt8+zcPN2EFpfywzkSOFGiSpeyg6UbE0r5Ze5u9HCQaGOlZP08v5glfLKLYzmk
 VHaw==
X-Gm-Message-State: AOJu0Ywq2hkcuacyzVB3QFR/QZ/EGC6CbKIhQyOSHGSnbPwJkfkUhikL
 nCwYudWgO6OVelcxMs8wHsHULAcstVM/MgmrIQOo9phitZ7RZkrTlNHnXvgngK+DjCNhD59oN9e
 Fg9/S+1Vl2aDOrurJxTWFt4JUCbKokQUoHYa2RkjnsZLkdg19FN+T
X-Received: by 2002:a05:6a20:8e1e:b0:1a1:472b:1730 with SMTP id
 y30-20020a056a208e1e00b001a1472b1730mr1695590pzj.0.1709885718978; 
 Fri, 08 Mar 2024 00:15:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF9MrKl5fK7AUDTrrEEEntz0UQ+AIjA70l0s8hp6mz1W/j03lfm1n/R9xbDYeHMpRv3uh18Q==
X-Received: by 2002:a05:6a20:8e1e:b0:1a1:472b:1730 with SMTP id
 y30-20020a056a208e1e00b001a1472b1730mr1695573pzj.0.1709885718573; 
 Fri, 08 Mar 2024 00:15:18 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 d15-20020a170903230f00b001dc3c4e7a12sm15806143plh.14.2024.03.08.00.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:15:18 -0800 (PST)
Date: Fri, 8 Mar 2024 16:15:08 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Message-ID: <ZerJDAdaakTCtECF@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
> * [1-4] already queued in migration-next.
>   
>   migration: Report error when shutdown fails
>   migration: Remove SaveStateHandler and LoadStateHandler typedefs
>   migration: Add documentation for SaveVMHandlers
>   migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
>   
> * [5-9] are prequisite changes in other components related to the
>   migration save_setup() handler. They make sure a failure is not
>   returned without setting an error.
>   
>   s390/stattrib: Add Error** argument to set_migrationmode() handler
>   vfio: Always report an error in vfio_save_setup()
>   migration: Always report an error in block_save_setup()
>   migration: Always report an error in ram_save_setup()
>   migration: Add Error** argument to vmstate_save()
> 
> * [10-15] are the core changes in migration and memory components to
>   propagate an error reported in a save_setup() handler.
> 
>   migration: Add Error** argument to qemu_savevm_state_setup()
>   migration: Add Error** argument to .save_setup() handler
>   migration: Add Error** argument to .load_setup() handler

Further queued 5-12 in migration-staging (until here), thanks.

>   memory: Add Error** argument to .log_global_start() handler
>   memory: Add Error** argument to the global_dirty_log routines
>   migration: Modify ram_init_bitmaps() to report dirty tracking errors
> 
> * [16-19] contains the VFIO changes we are interested in. Can go
>   through vfio-next.
> 
>   vfio: Add Error** argument to .set_dirty_page_tracking() handler
>   vfio: Add Error** argument to vfio_devices_dma_logging_start()
>   vfio: Add Error** argument to vfio_devices_dma_logging_stop()
>   vfio: Use new Error** argument in vfio_save_setup()
> 
> * [20-25] are followups for better error handling in VFIO. Good to
>   have but not necessary for the issue described in the intro. Can go
>   through vfio-next.
> 
>   vfio: Add Error** argument to .vfio_save_config() handler
>   vfio: Reverse test on vfio_get_dirty_bitmap()
>   memory: Add Error** argument to memory_get_xlat_addr()
>   vfio: Add Error** argument to .get_dirty_bitmap() handler
>   vfio: Also trace event failures in vfio_save_complete_precopy()
>   vfio: Extend vfio_set_migration_error() with Error* argument
> 
> Thanks,
> 
> C.
> 
> Changes in v4:
> 
>  - Fixed frenchism futur to future
>  - Fixed typo in set_migrationmode() handler
>  - Added error_free() in hmp_migrationmode()
>  - Fixed state name printed out in error returned by vfio_save_setup()
>  - Fixed test on error returned by qemu_file_get_error()
>  - Added an error when bdrv_nb_sectors() returns a negative value 
>  - Dropped log_global_stop() and log_global_sync() changes
>  - Dropped MEMORY_LISTENER_CALL_LOG_GLOBAL
>  - Modified memory_global_dirty_log_start() to loop on the list of
>    listeners and handle errors directly.
>  - Introduced memory_global_dirty_log_rollback() to revert operations
>    previously done
> 
> Changes in v3:
> 
>  - New changes to make sure an error is always set in case of failure.
>    This is the reason behing the 5/6 extra patches. (Markus)
>  - Documentation fixup (Peter + Avihai)
>  - Set migration state to MIGRATION_STATUS_FAILED always
>  - Fixed error handling in bg_migration_thread() (Peter)
>  - Fixed return value of vfio_listener_log_global_start/stop(). 
>    Went unnoticed because value is not tested. (Peter)
>  - Add ERRP_GUARD() when error_prepend is used 
>  - Use error_setg_errno() when possible
>     
> Changes in v2:
> 
> - Removed v1 patches addressing the return-path thread termination as
>   they are now superseded by :  
>   https://lore.kernel.org/qemu-devel/20240226203122.22894-1-farosas@suse.de/
> - Documentation updates of handlers
> - Removed call to PRECOPY_NOTIFY_SETUP notifiers in case of errors
> - Modified routines taking an Error** argument to return a bool when
>   possible and made adjustments in callers.
> - new MEMORY_LISTENER_CALL_LOG_GLOBAL macro for .log_global*()
>   handlers
> - Handled SETUP state when migration terminates
> - Modified memory_get_xlat_addr() to take an Error** argument
> - Various refinements on error handling
> 
> Cédric Le Goater (25):
>   migration: Report error when shutdown fails
>   migration: Remove SaveStateHandler and LoadStateHandler typedefs
>   migration: Add documentation for SaveVMHandlers
>   migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
>   s390/stattrib: Add Error** argument to set_migrationmode() handler
>   vfio: Always report an error in vfio_save_setup()
>   migration: Always report an error in block_save_setup()
>   migration: Always report an error in ram_save_setup()
>   migration: Add Error** argument to vmstate_save()
>   migration: Add Error** argument to qemu_savevm_state_setup()
>   migration: Add Error** argument to .save_setup() handler
>   migration: Add Error** argument to .load_setup() handler
>   memory: Add Error** argument to .log_global_start() handler
>   memory: Add Error** argument to the global_dirty_log routines
>   migration: Modify ram_init_bitmaps() to report dirty tracking errors
>   vfio: Add Error** argument to .set_dirty_page_tracking() handler
>   vfio: Add Error** argument to vfio_devices_dma_logging_start()
>   vfio: Add Error** argument to vfio_devices_dma_logging_stop()
>   vfio: Use new Error** argument in vfio_save_setup()
>   vfio: Add Error** argument to .vfio_save_config() handler
>   vfio: Reverse test on vfio_get_dirty_bitmap()
>   memory: Add Error** argument to memory_get_xlat_addr()
>   vfio: Add Error** argument to .get_dirty_bitmap() handler
>   vfio: Also trace event failures in vfio_save_complete_precopy()
>   vfio: Extend vfio_set_migration_error() with Error* argument
> 
>  include/exec/memory.h                 |  25 ++-
>  include/hw/s390x/storage-attributes.h |   2 +-
>  include/hw/vfio/vfio-common.h         |  29 ++-
>  include/hw/vfio/vfio-container-base.h |  35 +++-
>  include/migration/register.h          | 273 +++++++++++++++++++++++---
>  include/qemu/typedefs.h               |   2 -
>  migration/savevm.h                    |   2 +-
>  hw/i386/xen/xen-hvm.c                 |   5 +-
>  hw/ppc/spapr.c                        |   2 +-
>  hw/s390x/s390-stattrib-kvm.c          |  12 +-
>  hw/s390x/s390-stattrib.c              |  15 +-
>  hw/vfio/common.c                      | 161 +++++++++------
>  hw/vfio/container-base.c              |   9 +-
>  hw/vfio/container.c                   |  19 +-
>  hw/vfio/migration.c                   |  99 ++++++----
>  hw/vfio/pci.c                         |   5 +-
>  hw/virtio/vhost-vdpa.c                |   5 +-
>  hw/virtio/vhost.c                     |   3 +-
>  migration/block-dirty-bitmap.c        |   4 +-
>  migration/block.c                     |  19 +-
>  migration/dirtyrate.c                 |  13 +-
>  migration/migration.c                 |  27 ++-
>  migration/qemu-file.c                 |   5 +-
>  migration/ram.c                       |  46 ++++-
>  migration/savevm.c                    |  59 +++---
>  system/memory.c                       |  56 +++++-
>  26 files changed, 713 insertions(+), 219 deletions(-)
> 
> -- 
> 2.44.0
> 
> 

-- 
Peter Xu


