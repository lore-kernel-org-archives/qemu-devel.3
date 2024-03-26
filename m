Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5E5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpB43-0008Qa-5i; Tue, 26 Mar 2024 13:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpB41-0008QK-KT
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpB3z-0003EM-4g
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711475896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhdtxwQH0naeGYU38q4i+lcqVqXoH3uri6VJsinOV18=;
 b=HvG+kEEoY5fvTK+k6KrriGMILhEHbjIe+EwQdxL4ZSjZVwp8YI8P3mtBi0/KDNx/QcdndW
 4NI5Fsg7bygv4djgMwr8SwUs8Qk9rag8hw3+h8UP435cLrwA1p78aHGkqps3iiwTk+BwjZ
 A3lt2YRLZ4kX/ZUkcO6ZZ+GV4SgWV/w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-eaTPGWu8P52gO7NLQGG3Rw-1; Tue, 26 Mar 2024 13:58:12 -0400
X-MC-Unique: eaTPGWu8P52gO7NLQGG3Rw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4311dd10102so23592551cf.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711475891; x=1712080691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhdtxwQH0naeGYU38q4i+lcqVqXoH3uri6VJsinOV18=;
 b=P+IZvJlHZHHQdrEzrR28Kgha8W+6/PC3gnSm9/sf+YS1nHTmTLOYUZrUg0VeO3UyTz
 g3BhfOeChJ0oXlunxatJrn+0L/ifGRJQoDr4j5clw9xG+MJMFUrqoy3qATegeN4F08O9
 rrDh6CHTZG3IpgVm8mzDwRKDSgRXdP39ogi2M5yuzOgMD9Rl74gGkErl2o6l69jhjf4n
 elfKYl/onoveRQTbTVR/NS2QyOyoBQflZuTkUgc7jgJ9w0UxTKMiKFfh13Ur8aoI7Xua
 89+I2nfmDuEJU1iQwMmTNNBXQQacNL7Knb4/QxUIZEwNoKNl+ndNoVVh4HUeGFkgqmRj
 wKpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0fncdb68mzCsfbBdkTZKEzrsEdWMbXpz0bIh588v60dDsDKkH/7+KzTonKgOvKC+xMTvXiEgYqwfd5iR1Vnu9JidHHzk=
X-Gm-Message-State: AOJu0Ywfi4B3y9gG+MN1ajXplYh01Wl+VQP+MXibynvyr73lnR/zmzLR
 GZD8gOSMY8a7IsmcX4kLgZTnrl3i8BSgMVwVjONnRqQDuutTVHxpM9fH9nSj03IRAxuOgPJ2f9z
 X/d9QSW7RvL5VxLCLmxM1xQ6UrnvCdraw3goZjdblCtPePdJSOXKF
X-Received: by 2002:a05:6214:5f10:b0:690:9db6:f410 with SMTP id
 lx16-20020a0562145f1000b006909db6f410mr12511113qvb.3.1711475890992; 
 Tue, 26 Mar 2024 10:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXt8qOEntUmzQ0tlg1mRy3h4tNZzWQpFQouuB4OTuHuLCnYhQglPmS7Qml3i7rrudhTcZ+Fg==
X-Received: by 2002:a05:6214:5f10:b0:690:9db6:f410 with SMTP id
 lx16-20020a0562145f1000b006909db6f410mr12511085qvb.3.1711475890305; 
 Tue, 26 Mar 2024 10:58:10 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 kd9-20020a056214400900b00696a3367c2asm535744qvb.28.2024.03.26.10.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 10:58:10 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:58:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, nanhai.zou@intel.com
Subject: Re: [PATCH v5 1/7] docs/migration: add qpl compression feature
Message-ID: <ZgMMsFWPClvF5Gm6@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-2-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319164527.1873891-2-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 20, 2024 at 12:45:21AM +0800, Yuan Liu wrote:
> add Intel Query Processing Library (QPL) compression method
> introduction
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  docs/devel/migration/features.rst        |   1 +
>  docs/devel/migration/qpl-compression.rst | 231 +++++++++++++++++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 docs/devel/migration/qpl-compression.rst
> 
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index d5ca7b86d5..bc98b65075 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -12,3 +12,4 @@ Migration has plenty of features to support different use cases.
>     virtio
>     mapped-ram
>     CPR
> +   qpl-compression
> diff --git a/docs/devel/migration/qpl-compression.rst b/docs/devel/migration/qpl-compression.rst
> new file mode 100644
> index 0000000000..42c7969d30
> --- /dev/null
> +++ b/docs/devel/migration/qpl-compression.rst
> @@ -0,0 +1,231 @@
> +===============
> +QPL Compression
> +===============
> +The Intel Query Processing Library (Intel ``QPL``) is an open-source library to
> +provide compression and decompression features and it is based on deflate
> +compression algorithm (RFC 1951).
> +
> +The ``QPL`` compression relies on Intel In-Memory Analytics Accelerator(``IAA``)
> +and Shared Virtual Memory(``SVM``) technology, they are new features supported
> +from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire Rapids
> +processor(``SPR``).
> +
> +For more ``QPL`` introduction, please refer to:
> +
> +https://intel.github.io/qpl/documentation/introduction_docs/introduction.html

There're a bunch of links in this page, please consider switching all of
them to use the link formats of .rST:

  Please refer to `QPL introduction page <https://...>`_.

> +
> +QPL Compression Framework
> +=========================
> +
> +::
> +
> +  +----------------+       +------------------+
> +  | MultiFD Service|       |accel-config tool |
> +  +-------+--------+       +--------+---------+
> +          |                         |
> +          |                         |
> +  +-------+--------+                | Setup IAA
> +  |  QPL library   |                | Resources
> +  +-------+---+----+                |
> +          |   |                     |
> +          |   +-------------+-------+
> +          |   Open IAA      |
> +          |   Devices +-----+-----+
> +          |           |idxd driver|
> +          |           +-----+-----+
> +          |                 |
> +          |                 |
> +          |           +-----+-----+
> +          +-----------+IAA Devices|
> +      Submit jobs     +-----------+
> +      via enqcmd
> +
> +
> +Intel In-Memory Analytics Accelerator (Intel IAA) Introduction
> +================================================================
> +
> +Intel ``IAA`` is an accelerator that has been designed to help benefit
> +in-memory databases and analytic workloads. There are three main areas
> +that Intel ``IAA`` can assist with analytics primitives (scan, filter, etc.),
> +sparse data compression and memory tiering.
> +
> +``IAA`` Manual Documentation:
> +
> +https://www.intel.com/content/www/us/en/content-details/721858/intel-in-memory-analytics-accelerator-architecture-specification
> +
> +IAA Device Enabling
> +-------------------
> +
> +- Enabling ``IAA`` devices for platform configuration, please refer to:
> +
> +https://www.intel.com/content/www/us/en/content-details/780887/intel-in-memory-analytics-accelerator-intel-iaa.html
> +
> +- ``IAA`` device driver is ``Intel Data Accelerator Driver (idxd)``, it is
> +  recommended that the minimum version of Linux kernel is 5.18.
> +
> +- Add ``"intel_iommu=on,sm_on"`` parameter to kernel command line
> +  for ``SVM`` feature enabling.
> +
> +Here is an easy way to verify ``IAA`` device driver and ``SVM``, refer to:
> +
> +https://github.com/intel/idxd-config/tree/stable/test
> +
> +IAA Device Management
> +---------------------
> +
> +The number of ``IAA`` devices will vary depending on the Xeon product model.
> +On a ``SPR`` server, there can be a maximum of 8 ``IAA`` devices, with up to
> +4 devices per socket.
> +
> +By default, all ``IAA`` devices are disabled and need to be configured and
> +enabled by users manually.
> +
> +Check the number of devices through the following command
> +
> +.. code-block:: shell
> +
> +  # lspci -d 8086:0cfe
> +  # 6a:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # 6f:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # 74:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # 79:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # e7:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # ec:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # f1:02.0 System peripheral: Intel Corporation Device 0cfe
> +  # f6:02.0 System peripheral: Intel Corporation Device 0cfe
> +
> +IAA Device Configuration
> +------------------------
> +
> +The ``accel-config`` tool is used to enable ``IAA`` devices and configure
> +``IAA`` hardware resources(work queues and engines). One ``IAA`` device
> +has 8 work queues and 8 processing engines, multiple engines can be assigned
> +to a work queue via ``group`` attribute.
> +
> +One example of configuring and enabling an ``IAA`` device.
> +
> +.. code-block:: shell
> +
> +  # accel-config config-engine iax1/engine1.0 -g 0
> +  # accel-config config-engine iax1/engine1.1 -g 0
> +  # accel-config config-engine iax1/engine1.2 -g 0
> +  # accel-config config-engine iax1/engine1.3 -g 0
> +  # accel-config config-engine iax1/engine1.4 -g 0
> +  # accel-config config-engine iax1/engine1.5 -g 0
> +  # accel-config config-engine iax1/engine1.6 -g 0
> +  # accel-config config-engine iax1/engine1.7 -g 0
> +  # accel-config config-wq iax1/wq1.0 -g 0 -s 128 -p 10 -b 1 -t 128 -m shared -y user -n app1 -d user
> +  # accel-config enable-device iax1
> +  # accel-config enable-wq iax1/wq1.0
> +
> +.. note::
> +   IAX is an early name for IAA
> +
> +- The ``IAA`` device index is 1, use ``ls -lh /sys/bus/dsa/devices/iax*``
> +  command to query the ``IAA`` device index.
> +
> +- 8 engines and 1 work queue are configured in group 0, so all compression jobs
> +  submitted to this work queue can be processed by all engines at the same time.
> +
> +- Set work queue attributes including the work mode, work queue size and so on.
> +
> +- Enable the ``IAA1`` device and work queue 1.0
> +
> +.. note::
> +  Set work queue mode to shared mode, since ``QPL`` library only supports
> +  shared mode
> +
> +For more detailed configuration, please refer to:
> +
> +https://github.com/intel/idxd-config/tree/stable/Documentation/accfg
> +
> +IAA Resources Allocation For Migration
> +--------------------------------------
> +
> +There is no ``IAA`` resource configuration parameters for migration and
> +``accel-config`` tool configuration cannot directly specify the ``IAA``
> +resources used for migration.
> +
> +``QPL`` will use all work queues that are enabled and set to shared mode,
> +and use all engines assigned to the work queues with shared mode.
> +
> +By default, ``QPL`` will only use the local ``IAA`` device for compression
> +job processing. The local ``IAA`` device means that the CPU of the job
> +submission and the ``IAA`` device are on the same socket, so one CPU
> +can submit the jobs to up to 4 ``IAA`` devices.
> +
> +Shared Virtual Memory(SVM) Introduction
> +=======================================
> +
> +An ability for an accelerator I/O device to operate in the same virtual
> +memory space of applications on host processors. It also implies the
> +ability to operate from pageable memory, avoiding functional requirements
> +to pin memory for DMA operations.
> +
> +When using ``SVM`` technology, users do not need to reserve memory for the
> +``IAA`` device and perform pin memory operation. The ``IAA`` device can
> +directly access data using the virtual address of the process.
> +
> +For more ``SVM`` technology, please refer to:
> +
> +https://docs.kernel.org/next/x86/sva.html
> +
> +
> +How To Use QPL Compression In Migration
> +=======================================
> +
> +1 - Installation of ``accel-config`` tool and ``QPL`` library

We can drop "1 " and stick with:

  - item1
    - item1.1
    ...
  - item2

> +
> +  - Install ``accel-config`` tool from https://github.com/intel/idxd-config
> +  - Install ``QPL`` library from https://github.com/intel/qpl
> +
> +2 - Configure and enable ``IAA`` devices and work queues via ``accel-config``
> +
> +3 - Build ``Qemu`` with ``--enable-qpl`` parameter
> +
> +  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qpl``
> +
> +4 - Start VMs with ``sudo`` command or ``root`` permission
> +
> +  Use the ``sudo`` command or ``root`` privilege to start the source and
> +  destination virtual machines, since migration service needs permission
> +  to access ``IAA`` hardware resources.
> +
> +5 - Enable ``QPL`` compression during migration
> +
> +  Set ``migrate_set_parameter multifd-compression qpl`` when migrating, the
> +  ``QPL`` compression does not support configuring the compression level, it
> +  only supports one compression level.
> +
> +The Difference Between QPL And ZLIB
> +===================================
> +
> +Although both ``QPL`` and ``ZLIB`` are based on the deflate compression
> +algorithm, and ``QPL`` can support the header and tail of ``ZLIB``, ``QPL``
> +is still not fully compatible with the ``ZLIB`` compression in the migration.
> +
> +``QPL`` only supports 4K history buffer, and ``ZLIB`` is 32K by default. The
> +``ZLIB`` compressed data that ``QPL`` may not decompress correctly and
> +vice versa.
> +
> +``QPL`` does not support the ``Z_SYNC_FLUSH`` operation in ``ZLIB`` streaming
> +compression, current ``ZLIB`` implementation uses ``Z_SYNC_FLUSH``, so each
> +``multifd`` thread has a ``ZLIB`` streaming context, and all page compression
> +and decompression are based on this stream. ``QPL`` cannot decompress such data
> +and vice versa.
> +
> +The introduction for ``Z_SYNC_FLUSH``, please refer to:
> +
> +https://www.zlib.net/manual.html
> +
> +The Best Practices
> +==================
> +
> +When the virtual machine's pages are not populated and the ``IAA`` device is
> +used, I/O page faults occur, which can impact performance due to a large number
> +of flush ``IOTLB`` operations.

AFAIU the IOTLB issue is not expected and can be fixed, while per our
discussion in the other thread, the DMA fault latency cannot.

I think we can mention the possibility of IOTLB flush issue but that
shouldn't be the major cause of such suggestion.  Again, I think it'll be
great to mention how slow a DMA page fault can be, it can be compared in
migration performance difference, or just describe an average DMA page
fault latency, v.s. a processor fault.  That might explain why we suggest
prefault the pages (comparing to a generic setup where the pages are always
faulted by processors).

> +
> +Since the normal pages on the source side are all populated, ``IOTLB`` caused
> +by I/O page fault will not occur. On the destination side, a large number
> +of normal pages need to be loaded, so it is recommended to add ``-mem-prealloc``
> +parameter on the destination side.
> -- 
> 2.39.3
> 

-- 
Peter Xu


