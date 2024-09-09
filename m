Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A061ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbsf-0001dm-Li; Mon, 09 Sep 2024 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1snbse-0001d6-1W
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:44:24 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1snbsX-00040X-6S
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:44:23 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.140.134])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4X2Njx4TtpzyGx;
 Mon,  9 Sep 2024 10:44:05 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:44:05 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00243b92349-918b-4cbc-87e9-0b495e029398,
 7EAE0107AF05AD730B93A3A59062D005920DE2DA) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 9 Sep 2024 12:43:43 +0200
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] virtio-9p: remove virtfs-proxy-helper
Message-ID: <20240909124343.52c46e5a@bahia>
In-Reply-To: <20240905082259.360983-1-pbonzini@redhat.com>
References: <20240905082259.360983-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: a4e8ef58-f9e4-4878-8039-26bc0ac59425
X-Ovh-Tracer-Id: 15092969728985569690
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfdufeeuieegveeiudejueeivefhueeivdekleekteekkeekgedvheehuedvhefgnecuffhomhgrihhnpehqvghmuhdrohhrghdpghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleekpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=cfYBf3sG6gdrywaxPPl6QLXwuNXxsUltyvC3UKgRet0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1725878645; v=1;
 b=Kvoxo7zkfUY9ERRpISAHYWlUTtiddT18HDHkKjug7z2j1VE8QeuxEub1Hdxrop4zyuOnMo9Q
 f4SlEP/9htK0JUKMFxa48nivw2BJuM0I/GKXE1k7Bq8T9vvhwDpI917pgzUVIq4xdyzCPFuuwHk
 iWqIqO4jqZ2aYYb4V8mzMnChdx81r74nEJqwqdgj2LMFXjjSmV3VN4Rbknu8UW1os2ONl0rGfRu
 YfXjNkYcOvurxCHo5JcFGCbCuX2B3aG+Ejc2wuAllbAjtSftMcTN3l/V8nIBppfNsZ0/JwIDrj7
 aUh2OppOnhmGNQQYBzJDfYnD6Cz1GzcPkKJd24t+ImGNw==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=groug@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu,  5 Sep 2024 10:22:59 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> It has been deprecated since 8.1; remove it and suggest using permission mapping
> or virtiofsd.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Thanks Paolo !

Acked-by: Greg Kurz <groug@kaod.org>

>  MAINTAINERS                        |    8 -
>  docs/about/deprecated.rst          |   23 -
>  docs/about/removed-features.rst    |   14 +
>  docs/conf.py                       |    3 -
>  docs/meson.build                   |    1 -
>  docs/tools/index.rst               |    1 -
>  docs/tools/virtfs-proxy-helper.rst |   75 --
>  meson.build                        |    8 -
>  fsdev/qemu-fsdev.h                 |    1 -
>  fsdev/qemu-fsdev.c                 |   19 -
>  fsdev/virtfs-proxy-helper.c        | 1193 --------------------------
>  hw/9pfs/9p-proxy.c                 | 1279 ----------------------------
>  fsdev/meson.build                  |    8 -
>  hw/9pfs/meson.build                |    1 -
>  meson_options.txt                  |    2 -
>  qemu-options.hx                    |   46 -
>  scripts/meson-buildoptions.        |    0
>  scripts/meson-buildoptions.sh      |    4 -
>  18 files changed, 14 insertions(+), 2672 deletions(-)
>  delete mode 100644 docs/tools/virtfs-proxy-helper.rst
>  delete mode 100644 fsdev/virtfs-proxy-helper.c
>  delete mode 100644 hw/9pfs/9p-proxy.c
>  create mode 100644 scripts/meson-buildoptions.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3584d6a6c6d..13e73987060 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2256,20 +2256,12 @@ S: Maintained
>  W: https://wiki.qemu.org/Documentation/9p
>  F: hw/9pfs/
>  X: hw/9pfs/xen-9p*
> -X: hw/9pfs/9p-proxy*
>  F: fsdev/
> -X: fsdev/virtfs-proxy-helper.c
>  F: tests/qtest/virtio-9p-test.c
>  F: tests/qtest/libqos/virtio-9p*
>  T: git https://gitlab.com/gkurz/qemu.git 9p-next
>  T: git https://github.com/cschoenebeck/qemu.git 9p.next
>  
> -virtio-9p-proxy
> -F: hw/9pfs/9p-proxy*
> -F: fsdev/virtfs-proxy-helper.c
> -F: docs/tools/virtfs-proxy-helper.rst
> -S: Obsolete
> -
>  virtio-blk
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  L: qemu-block@nongnu.org
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index be62fa06c29..d45dc4fe62f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -316,29 +316,6 @@ the addition of volatile memory support, it is now necessary to distinguish
>  between persistent and volatile memory backends.  As such, memdev is deprecated
>  in favor of persistent-memdev.
>  
> -``-fsdev proxy`` and ``-virtfs proxy`` (since 8.1)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The 9p ``proxy`` filesystem backend driver has been deprecated and will be
> -removed (along with its proxy helper daemon) in a future version of QEMU. Please
> -use ``-fsdev local`` or ``-virtfs local`` for using the 9p ``local`` filesystem
> -backend, or alternatively consider deploying virtiofsd instead.
> -
> -The 9p ``proxy`` backend was originally developed as an alternative to the 9p
> -``local`` backend. The idea was to enhance security by dispatching actual low
> -level filesystem operations from 9p server (QEMU process) over to a separate
> -process (the virtfs-proxy-helper binary). However this alternative never gained
> -momentum. The proxy backend is much slower than the local backend, hasn't seen
> -any development in years, and showed to be less secure, especially due to the
> -fact that its helper daemon must be run as root, whereas with the local backend
> -QEMU is typically run as unprivileged user and allows to tighten behaviour by
> -mapping permissions et al by using its 'mapped' security model option.
> -
> -Nowadays it would make sense to reimplement the ``proxy`` backend by using
> -QEMU's ``vhost`` feature, which would eliminate the high latency costs under
> -which the 9p ``proxy`` backend currently suffers. However as of to date nobody
> -has indicated plans for such kind of reimplementation unfortunately.
> -
>  RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 5ae730d02ae..41d3affabfc 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -517,6 +517,20 @@ The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
>  and later do not support it because the virtio-scsi device was introduced for
>  full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
>  
> +``-fsdev proxy`` and ``-virtfs proxy`` (since 9.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The 9p ``proxy`` filesystem backend driver was originally developed to
> +enhance security by dispatching low level filesystem operations from 9p
> +server (QEMU process) over to a separate process (the virtfs-proxy-helper
> +binary). However the proxy backend was much slower than the local backend,
> +didn't see any development in years, and showed to be less secure,
> +especially due to the fact that its helper daemon must be run as root.
> +
> +Use ``local``, possibly mapping permissions et al by using its 'mapped'
> +security model option, or switch to ``virtiofs``.   The virtiofs daemon
> +``virtiofsd`` uses vhost to eliminate the high latency costs of the 9p
> +``proxy`` backend.
>  
>  User-mode emulator command line arguments
>  -----------------------------------------
> diff --git a/docs/conf.py b/docs/conf.py
> index 876f6768815..c11a6ead8a0 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -275,9 +275,6 @@
>      ('tools/qemu-trace-stap', 'qemu-trace-stap',
>       'QEMU SystemTap trace tool',
>       [], 1),
> -    ('tools/virtfs-proxy-helper', 'virtfs-proxy-helper',
> -     'QEMU 9p virtfs proxy filesystem helper',
> -     ['M. Mohan Kumar'], 1),
>  ]
>  man_make_section_directory = False
>  
> diff --git a/docs/meson.build b/docs/meson.build
> index 322452c8778..3676f81c4d3 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -54,7 +54,6 @@ if build_docs
>          'qemu-pr-helper.8': (have_tools ? 'man8' : ''),
>          'qemu-storage-daemon.1': (have_tools ? 'man1' : ''),
>          'qemu-trace-stap.1': (stap.found() ? 'man1' : ''),
> -        'virtfs-proxy-helper.1': (have_virtfs_proxy_helper ? 'man1' : ''),
>          'qemu.1': 'man1',
>          'qemu-block-drivers.7': 'man7',
>          'qemu-cpu-models.7': 'man7'
> diff --git a/docs/tools/index.rst b/docs/tools/index.rst
> index 33ad438e86f..1e88ae48cdc 100644
> --- a/docs/tools/index.rst
> +++ b/docs/tools/index.rst
> @@ -15,5 +15,4 @@ command line utilities and other standalone programs.
>     qemu-nbd
>     qemu-pr-helper
>     qemu-trace-stap
> -   virtfs-proxy-helper
>     qemu-vmsr-helper
> diff --git a/docs/tools/virtfs-proxy-helper.rst b/docs/tools/virtfs-proxy-helper.rst
> deleted file mode 100644
> index bd310ebb07b..00000000000
> --- a/docs/tools/virtfs-proxy-helper.rst
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -QEMU 9p virtfs proxy filesystem helper
> -======================================
> -
> -Synopsis
> ---------
> -
> -**virtfs-proxy-helper** [*OPTIONS*]
> -
> -Description
> ------------
> -
> -NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> -removed, along with this daemon, in a future version of QEMU!
> -
> -Pass-through security model in QEMU 9p server needs root privilege to do
> -few file operations (like chown, chmod to any mode/uid:gid).  There are two
> -issues in pass-through security model:
> -
> -- TOCTTOU vulnerability: Following symbolic links in the server could
> -  provide access to files beyond 9p export path.
> -
> -- Running QEMU with root privilege could be a security issue.
> -
> -To overcome above issues, following approach is used: A new filesystem
> -type 'proxy' is introduced. Proxy FS uses chroot + socket combination
> -for securing the vulnerability known with following symbolic links.
> -Intention of adding a new filesystem type is to allow qemu to run
> -in non-root mode, but doing privileged operations using socket IO.
> -
> -Proxy helper (a stand alone binary part of qemu) is invoked with
> -root privileges. Proxy helper chroots into 9p export path and creates
> -a socket pair or a named socket based on the command line parameter.
> -QEMU and proxy helper communicate using this socket. QEMU proxy fs
> -driver sends filesystem request to proxy helper and receives the
> -response from it.
> -
> -The proxy helper is designed so that it can drop root privileges except
> -for the capabilities needed for doing filesystem operations.
> -
> -Options
> --------
> -
> -The following options are supported:
> -
> -.. program:: virtfs-proxy-helper
> -
> -.. option:: -h
> -
> -  Display help and exit
> -
> -.. option:: -p, --path PATH
> -
> -  Path to export for proxy filesystem driver
> -
> -.. option:: -f, --fd SOCKET_ID
> -
> -  Use given file descriptor as socket descriptor for communicating with
> -  qemu proxy fs drier. Usually a helper like libvirt will create
> -  socketpair and pass one of the fds as parameter to this option.
> -
> -.. option:: -s, --socket SOCKET_FILE
> -
> -  Creates named socket file for communicating with qemu proxy fs driver
> -
> -.. option:: -u, --uid UID
> -
> -  uid to give access to named socket file; used in combination with -g.
> -
> -.. option:: -g, --gid GID
> -
> -  gid to give access to named socket file; used in combination with -u.
> -
> -.. option:: -n, --nodaemon
> -
> -  Run as a normal program. By default program will run in daemon mode
> diff --git a/meson.build b/meson.build
> index fbda17c987e..56eef434782 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2197,13 +2197,6 @@ have_virtfs = get_option('virtfs') \
>      .disable_auto_if(not have_tools and not have_system) \
>      .allowed()
>  
> -have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
> -    .require(host_os != 'darwin', error_message: 'the virtfs proxy helper is incompatible with macOS') \
> -    .require(have_virtfs, error_message: 'the virtfs proxy helper requires that virtfs is enabled') \
> -    .disable_auto_if(not have_tools) \
> -    .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
> -    .allowed()
> -
>  qga_fsfreeze = false
>  qga_fstrim = false
>  if host_os == 'linux'
> @@ -4397,7 +4390,6 @@ if have_block
>    summary_info += {'Block whitelist (ro)': get_option('block_drv_ro_whitelist')}
>    summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
>    summary_info += {'VirtFS (9P) support':    have_virtfs}
> -  summary_info += {'VirtFS (9P) Proxy Helper support (deprecated)': have_virtfs_proxy_helper}
>    summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
>    summary_info += {'bochs support':     get_option('bochs').allowed()}
>    summary_info += {'cloop support':     get_option('cloop').allowed()}
> diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
> index 52a53977701..731f1406a81 100644
> --- a/fsdev/qemu-fsdev.h
> +++ b/fsdev/qemu-fsdev.h
> @@ -18,5 +18,4 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp);
>  FsDriverEntry *get_fsdev_fsentry(char *id);
>  extern FileOperations local_ops;
>  extern FileOperations synth_ops;
> -extern FileOperations proxy_ops;
>  #endif
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index f5c953a7105..57877dad0a7 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -89,17 +89,6 @@ static FsDriverTable FsDrivers[] = {
>              NULL
>          },
>      },
> -    {
> -        .name = "proxy",
> -        .ops = &proxy_ops,
> -        .opts = (const char * []) {
> -            COMMON_FS_DRIVER_OPTIONS,
> -            "socket",
> -            "sock_fd",
> -            "writeout",
> -            NULL
> -        },
> -    },
>  };
>  
>  static int validate_opt(void *opaque, const char *name, const char *value,
> @@ -133,14 +122,6 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
>      }
>  
>      if (fsdriver) {
> -        if (strncmp(fsdriver, "proxy", 5) == 0) {
> -            warn_report(
> -                "'-fsdev proxy' and '-virtfs proxy' are deprecated, use "
> -                "'local' instead of 'proxy, or consider deploying virtiofsd "
> -                "as alternative to 9p"
> -            );
> -        }
> -
>          for (i = 0; i < ARRAY_SIZE(FsDrivers); i++) {
>              if (strcmp(FsDrivers[i].name, fsdriver) == 0) {
>                  break;
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> deleted file mode 100644
> index 144aaf585ad..00000000000
> --- a/fsdev/virtfs-proxy-helper.c
> +++ /dev/null
> @@ -1,1193 +0,0 @@
> -/*
> - * Helper for QEMU Proxy FS Driver
> - * Copyright IBM, Corp. 2011
> - *
> - * Authors:
> - * M. Mohan Kumar <mohan@in.ibm.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2. See
> - * the COPYING file in the top-level directory.
> - */
> -
> -/*
> - * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> - * removed in a future version of QEMU!
> - */
> -
> -#include "qemu/osdep.h"
> -#include <glib/gstdio.h>
> -#include <sys/resource.h>
> -#include <getopt.h>
> -#include <syslog.h>
> -#include <sys/fsuid.h>
> -#include <sys/vfs.h>
> -#include <sys/ioctl.h>
> -#include <linux/fs.h>
> -#ifdef CONFIG_LINUX_MAGIC_H
> -#include <linux/magic.h>
> -#endif
> -#include <cap-ng.h>
> -#include "qemu/sockets.h"
> -#include "qemu/xattr.h"
> -#include "9p-iov-marshal.h"
> -#include "hw/9pfs/9p-proxy.h"
> -#include "hw/9pfs/9p-util.h"
> -#include "fsdev/9p-iov-marshal.h"
> -
> -#define PROGNAME "virtfs-proxy-helper"
> -
> -#ifndef XFS_SUPER_MAGIC
> -#define XFS_SUPER_MAGIC  0x58465342
> -#endif
> -#ifndef EXT2_SUPER_MAGIC
> -#define EXT2_SUPER_MAGIC 0xEF53
> -#endif
> -#ifndef REISERFS_SUPER_MAGIC
> -#define REISERFS_SUPER_MAGIC 0x52654973
> -#endif
> -#ifndef BTRFS_SUPER_MAGIC
> -#define BTRFS_SUPER_MAGIC 0x9123683E
> -#endif
> -
> -static const struct option helper_opts[] = {
> -    {"fd", required_argument, NULL, 'f'},
> -    {"path", required_argument, NULL, 'p'},
> -    {"nodaemon", no_argument, NULL, 'n'},
> -    {"socket", required_argument, NULL, 's'},
> -    {"uid", required_argument, NULL, 'u'},
> -    {"gid", required_argument, NULL, 'g'},
> -    {},
> -};
> -
> -static bool is_daemon;
> -static bool get_version; /* IOC getversion IOCTL supported */
> -static char *prog_name;
> -
> -static void G_GNUC_PRINTF(2, 3) do_log(int loglevel, const char *format, ...)
> -{
> -    va_list ap;
> -
> -    va_start(ap, format);
> -    if (is_daemon) {
> -        vsyslog(LOG_CRIT, format, ap);
> -    } else {
> -        vfprintf(stderr, format, ap);
> -    }
> -    va_end(ap);
> -}
> -
> -static void do_perror(const char *string)
> -{
> -    if (is_daemon) {
> -        syslog(LOG_CRIT, "%s:%s", string, strerror(errno));
> -    } else {
> -        fprintf(stderr, "%s:%s\n", string, strerror(errno));
> -    }
> -}
> -
> -static int init_capabilities(void)
> -{
> -    /* helper needs following capabilities only */
> -    int cap_list[] = {
> -        CAP_CHOWN,
> -        CAP_DAC_OVERRIDE,
> -        CAP_FOWNER,
> -        CAP_FSETID,
> -        CAP_SETGID,
> -        CAP_MKNOD,
> -        CAP_SETUID,
> -    };
> -    int i;
> -
> -    capng_clear(CAPNG_SELECT_BOTH);
> -    for (i = 0; i < ARRAY_SIZE(cap_list); i++) {
> -        if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> -                         cap_list[i]) < 0) {
> -            do_perror("capng_update");
> -            return -1;
> -        }
> -    }
> -    if (capng_apply(CAPNG_SELECT_BOTH) < 0) {
> -        do_perror("capng_apply");
> -        return -1;
> -    }
> -
> -    /* Prepare effective set for setugid.  */
> -    for (i = 0; i < ARRAY_SIZE(cap_list); i++) {
> -        if (cap_list[i] == CAP_DAC_OVERRIDE) {
> -            continue;
> -        }
> -
> -        if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE,
> -                         cap_list[i]) < 0) {
> -            do_perror("capng_update");
> -            return -1;
> -        }
> -    }
> -    return 0;
> -}
> -
> -static int socket_read(int sockfd, void *buff, ssize_t size)
> -{
> -    ssize_t retval, total = 0;
> -
> -    while (size) {
> -        retval = read(sockfd, buff, size);
> -        if (retval == 0) {
> -            return -EIO;
> -        }
> -        if (retval < 0) {
> -            if (errno == EINTR) {
> -                continue;
> -            }
> -            return -errno;
> -        }
> -        size -= retval;
> -        buff += retval;
> -        total += retval;
> -    }
> -    return total;
> -}
> -
> -static int socket_write(int sockfd, void *buff, ssize_t size)
> -{
> -    ssize_t retval, total = 0;
> -
> -    while (size) {
> -        retval = write(sockfd, buff, size);
> -        if (retval < 0) {
> -            if (errno == EINTR) {
> -                continue;
> -            }
> -            return -errno;
> -        }
> -        size -= retval;
> -        buff += retval;
> -        total += retval;
> -    }
> -    return total;
> -}
> -
> -static int read_request(int sockfd, struct iovec *iovec, ProxyHeader *header)
> -{
> -    int retval;
> -
> -    /*
> -     * read the request header.
> -     */
> -    iovec->iov_len = 0;
> -    retval = socket_read(sockfd, iovec->iov_base, PROXY_HDR_SZ);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    iovec->iov_len = PROXY_HDR_SZ;
> -    retval = proxy_unmarshal(iovec, 0, "dd", &header->type, &header->size);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    /*
> -     * We can't process message.size > PROXY_MAX_IO_SZ.
> -     * Treat it as fatal error
> -     */
> -    if (header->size > PROXY_MAX_IO_SZ) {
> -        return -ENOBUFS;
> -    }
> -    retval = socket_read(sockfd, iovec->iov_base + PROXY_HDR_SZ, header->size);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    iovec->iov_len += header->size;
> -    return 0;
> -}
> -
> -static int send_fd(int sockfd, int fd)
> -{
> -    struct msghdr msg;
> -    struct iovec iov;
> -    int retval, data;
> -    struct cmsghdr *cmsg;
> -    union MsgControl msg_control;
> -
> -    iov.iov_base = &data;
> -    iov.iov_len = sizeof(data);
> -
> -    memset(&msg, 0, sizeof(msg));
> -    msg.msg_iov = &iov;
> -    msg.msg_iovlen = 1;
> -    /* No ancillary data on error */
> -    if (fd < 0) {
> -        /* fd is really negative errno if the request failed  */
> -        data = fd;
> -    } else {
> -        data = V9FS_FD_VALID;
> -        msg.msg_control = &msg_control;
> -        msg.msg_controllen = sizeof(msg_control);
> -
> -        cmsg = &msg_control.cmsg;
> -        cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
> -        cmsg->cmsg_level = SOL_SOCKET;
> -        cmsg->cmsg_type = SCM_RIGHTS;
> -        memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
> -    }
> -
> -    do {
> -        retval = sendmsg(sockfd, &msg, 0);
> -    } while (retval < 0 && errno == EINTR);
> -    if (fd >= 0) {
> -        close(fd);
> -    }
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    return 0;
> -}
> -
> -static int send_status(int sockfd, struct iovec *iovec, int status)
> -{
> -    ProxyHeader header;
> -    int retval, msg_size;
> -
> -    if (status < 0) {
> -        header.type = T_ERROR;
> -    } else {
> -        header.type = T_SUCCESS;
> -    }
> -    header.size = sizeof(status);
> -    /*
> -     * marshal the return status. We don't check error.
> -     * because we are sure we have enough space for the status
> -     */
> -    msg_size = proxy_marshal(iovec, 0, "ddd", header.type,
> -                             header.size, status);
> -    if (msg_size < 0) {
> -        return msg_size;
> -    }
> -    retval = socket_write(sockfd, iovec->iov_base, msg_size);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    return 0;
> -}
> -
> -/*
> - * from man 7 capabilities, section
> - * Effect of User ID Changes on Capabilities:
> - * If the effective user ID is changed from nonzero to 0, then the permitted
> - * set is copied to the effective set.  If the effective user ID is changed
> - * from 0 to nonzero, then all capabilities are are cleared from the effective
> - * set.
> - *
> - * The setfsuid/setfsgid man pages warn that changing the effective user ID may
> - * expose the program to unwanted signals, but this is not true anymore: for an
> - * unprivileged (without CAP_KILL) program to send a signal, the real or
> - * effective user ID of the sending process must equal the real or saved user
> - * ID of the target process.  Even when dropping privileges, it is enough to
> - * keep the saved UID to a "privileged" value and virtfs-proxy-helper won't
> - * be exposed to signals.  So just use setresuid/setresgid.
> - */
> -static int setugid(int uid, int gid, int *suid, int *sgid)
> -{
> -    int retval;
> -
> -    *suid = geteuid();
> -    *sgid = getegid();
> -
> -    if (setresgid(-1, gid, *sgid) == -1) {
> -        return -errno;
> -    }
> -
> -    if (setresuid(-1, uid, *suid) == -1) {
> -        retval = -errno;
> -        goto err_sgid;
> -    }
> -
> -    if (uid == 0 && gid == 0) {
> -        /* Linux has already copied the permitted set to the effective set.  */
> -        return 0;
> -    }
> -
> -    /*
> -     * All capabilities have been cleared from the effective set.  However
> -     * we still need DAC_OVERRIDE because we don't change supplementary
> -     * group ids, and hence may be subject to DAC rules.  init_capabilities
> -     * left the set of capabilities that we want in libcap-ng's state.
> -     */
> -    if (capng_apply(CAPNG_SELECT_CAPS) < 0) {
> -        retval = -errno;
> -        do_perror("capng_apply");
> -        goto err_suid;
> -    }
> -    return 0;
> -
> -err_suid:
> -    if (setresuid(-1, *suid, *suid) == -1) {
> -        abort();
> -    }
> -err_sgid:
> -    if (setresgid(-1, *sgid, *sgid) == -1) {
> -        abort();
> -    }
> -    return retval;
> -}
> -
> -/*
> - * This is used to reset the ugid back with the saved values
> - * There is nothing much we can do checking error values here.
> - */
> -static void resetugid(int suid, int sgid)
> -{
> -    if (setresgid(-1, sgid, sgid) == -1) {
> -        abort();
> -    }
> -    if (setresuid(-1, suid, suid) == -1) {
> -        abort();
> -    }
> -}
> -
> -/*
> - * Open regular file or directory. Attempts to open any special file are
> - * rejected.
> - *
> - * returns file descriptor or -1 on error
> - */
> -static int open_regular(const char *pathname, int flags, mode_t mode)
> -{
> -    int fd;
> -
> -    fd = open(pathname, flags, mode);
> -    if (fd < 0) {
> -        return fd;
> -    }
> -
> -    if (close_if_special_file(fd) < 0) {
> -        return -1;
> -    }
> -
> -    return fd;
> -}
> -
> -/*
> - * send response in two parts
> - * 1) ProxyHeader
> - * 2) Response or error status
> - * This function should be called with marshaled response
> - * send_response constructs header part and error part only.
> - * send response sends {ProxyHeader,Response} if the request was success
> - * otherwise sends {ProxyHeader,error status}
> - */
> -static int send_response(int sock, struct iovec *iovec, int size)
> -{
> -    int retval;
> -    ProxyHeader header;
> -
> -    /*
> -     * If response size exceeds available iovec->iov_len,
> -     * we return ENOBUFS
> -     */
> -    if (size > PROXY_MAX_IO_SZ) {
> -        size = -ENOBUFS;
> -    }
> -
> -    if (size < 0) {
> -        /*
> -         * In case of error we would not have got the error encoded
> -         * already so encode the error here.
> -         */
> -        header.type = T_ERROR;
> -        header.size = sizeof(size);
> -        proxy_marshal(iovec, PROXY_HDR_SZ, "d", size);
> -    } else {
> -        header.type = T_SUCCESS;
> -        header.size = size;
> -    }
> -    proxy_marshal(iovec, 0, "dd", header.type, header.size);
> -    retval = socket_write(sock, iovec->iov_base, header.size + PROXY_HDR_SZ);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    return 0;
> -}
> -
> -/*
> - * gets generation number
> - * returns -errno on failure and sizeof(generation number) on success
> - */
> -static int do_getversion(struct iovec *iovec, struct iovec *out_iovec)
> -{
> -    uint64_t version;
> -    int retval = -ENOTTY;
> -#ifdef FS_IOC_GETVERSION
> -    int fd;
> -    V9fsString path;
> -#endif
> -
> -
> -    /* no need to issue ioctl */
> -    if (!get_version) {
> -        version = 0;
> -        retval = proxy_marshal(out_iovec, PROXY_HDR_SZ, "q", version);
> -        return retval;
> -    }
> -#ifdef FS_IOC_GETVERSION
> -    retval = proxy_unmarshal(iovec, PROXY_HDR_SZ, "s", &path);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -
> -    fd = open(path.data, O_RDONLY);
> -    if (fd < 0) {
> -        retval = -errno;
> -        goto err_out;
> -    }
> -    if (ioctl(fd, FS_IOC_GETVERSION, &version) < 0) {
> -        retval = -errno;
> -    } else {
> -        retval = proxy_marshal(out_iovec, PROXY_HDR_SZ, "q", version);
> -    }
> -    close(fd);
> -err_out:
> -    v9fs_string_free(&path);
> -#endif
> -    return retval;
> -}
> -
> -static int do_getxattr(int type, struct iovec *iovec, struct iovec *out_iovec)
> -{
> -    int size = 0, offset, retval;
> -    V9fsString path, name, xattr;
> -
> -    v9fs_string_init(&xattr);
> -    v9fs_string_init(&path);
> -    retval = proxy_unmarshal(iovec, PROXY_HDR_SZ, "ds", &size, &path);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    offset = PROXY_HDR_SZ + retval;
> -
> -    if (size) {
> -        xattr.data = g_malloc(size);
> -        xattr.size = size;
> -    }
> -    switch (type) {
> -    case T_LGETXATTR:
> -        v9fs_string_init(&name);
> -        retval = proxy_unmarshal(iovec, offset, "s", &name);
> -        if (retval > 0) {
> -            retval = lgetxattr(path.data, name.data, xattr.data, size);
> -            if (retval < 0) {
> -                retval = -errno;
> -            } else {
> -                xattr.size = retval;
> -            }
> -        }
> -        v9fs_string_free(&name);
> -        break;
> -    case T_LLISTXATTR:
> -        retval = llistxattr(path.data, xattr.data, size);
> -        if (retval < 0) {
> -            retval = -errno;
> -        } else {
> -            xattr.size = retval;
> -        }
> -        break;
> -    }
> -    if (retval < 0) {
> -        goto err_out;
> -    }
> -
> -    if (!size) {
> -        proxy_marshal(out_iovec, PROXY_HDR_SZ, "d", retval);
> -        retval = sizeof(retval);
> -    } else {
> -        retval = proxy_marshal(out_iovec, PROXY_HDR_SZ, "s", &xattr);
> -    }
> -err_out:
> -    v9fs_string_free(&xattr);
> -    v9fs_string_free(&path);
> -    return retval;
> -}
> -
> -static void stat_to_prstat(ProxyStat *pr_stat, struct stat *stat)
> -{
> -    memset(pr_stat, 0, sizeof(*pr_stat));
> -    pr_stat->st_dev = stat->st_dev;
> -    pr_stat->st_ino = stat->st_ino;
> -    pr_stat->st_nlink = stat->st_nlink;
> -    pr_stat->st_mode = stat->st_mode;
> -    pr_stat->st_uid = stat->st_uid;
> -    pr_stat->st_gid = stat->st_gid;
> -    pr_stat->st_rdev = stat->st_rdev;
> -    pr_stat->st_size = stat->st_size;
> -    pr_stat->st_blksize = stat->st_blksize;
> -    pr_stat->st_blocks = stat->st_blocks;
> -    pr_stat->st_atim_sec = stat->st_atim.tv_sec;
> -    pr_stat->st_atim_nsec = stat->st_atim.tv_nsec;
> -    pr_stat->st_mtim_sec = stat->st_mtim.tv_sec;
> -    pr_stat->st_mtim_nsec = stat->st_mtim.tv_nsec;
> -    pr_stat->st_ctim_sec = stat->st_ctim.tv_sec;
> -    pr_stat->st_ctim_nsec = stat->st_ctim.tv_nsec;
> -}
> -
> -static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)
> -{
> -    memset(pr_stfs, 0, sizeof(*pr_stfs));
> -    pr_stfs->f_type = stfs->f_type;
> -    pr_stfs->f_bsize = stfs->f_bsize;
> -    pr_stfs->f_blocks = stfs->f_blocks;
> -    pr_stfs->f_bfree = stfs->f_bfree;
> -    pr_stfs->f_bavail = stfs->f_bavail;
> -    pr_stfs->f_files = stfs->f_files;
> -    pr_stfs->f_ffree = stfs->f_ffree;
> -    pr_stfs->f_fsid[0] = stfs->f_fsid.__val[0];
> -    pr_stfs->f_fsid[1] = stfs->f_fsid.__val[1];
> -    pr_stfs->f_namelen = stfs->f_namelen;
> -    pr_stfs->f_frsize = stfs->f_frsize;
> -}
> -
> -/*
> - * Gets stat/statfs information and packs in out_iovec structure
> - * on success returns number of bytes packed in out_iovec structure
> - * otherwise returns -errno
> - */
> -static int do_stat(int type, struct iovec *iovec, struct iovec *out_iovec)
> -{
> -    int retval;
> -    V9fsString path;
> -    ProxyStat pr_stat;
> -    ProxyStatFS pr_stfs;
> -    struct stat st_buf;
> -    struct statfs stfs_buf;
> -
> -    v9fs_string_init(&path);
> -    retval = proxy_unmarshal(iovec, PROXY_HDR_SZ, "s", &path);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -
> -    switch (type) {
> -    case T_LSTAT:
> -        retval = lstat(path.data, &st_buf);
> -        if (retval < 0) {
> -            retval = -errno;
> -        } else {
> -            stat_to_prstat(&pr_stat, &st_buf);
> -            retval = proxy_marshal(out_iovec, PROXY_HDR_SZ,
> -                                   "qqqdddqqqqqqqqqq", pr_stat.st_dev,
> -                                   pr_stat.st_ino, pr_stat.st_nlink,
> -                                   pr_stat.st_mode, pr_stat.st_uid,
> -                                   pr_stat.st_gid, pr_stat.st_rdev,
> -                                   pr_stat.st_size, pr_stat.st_blksize,
> -                                   pr_stat.st_blocks,
> -                                   pr_stat.st_atim_sec, pr_stat.st_atim_nsec,
> -                                   pr_stat.st_mtim_sec, pr_stat.st_mtim_nsec,
> -                                   pr_stat.st_ctim_sec, pr_stat.st_ctim_nsec);
> -        }
> -        break;
> -    case T_STATFS:
> -        retval = statfs(path.data, &stfs_buf);
> -        if (retval < 0) {
> -            retval = -errno;
> -        } else {
> -            statfs_to_prstatfs(&pr_stfs, &stfs_buf);
> -            retval = proxy_marshal(out_iovec, PROXY_HDR_SZ,
> -                                   "qqqqqqqqqqq", pr_stfs.f_type,
> -                                   pr_stfs.f_bsize, pr_stfs.f_blocks,
> -                                   pr_stfs.f_bfree, pr_stfs.f_bavail,
> -                                   pr_stfs.f_files, pr_stfs.f_ffree,
> -                                   pr_stfs.f_fsid[0], pr_stfs.f_fsid[1],
> -                                   pr_stfs.f_namelen, pr_stfs.f_frsize);
> -        }
> -        break;
> -    }
> -    v9fs_string_free(&path);
> -    return retval;
> -}
> -
> -static int do_readlink(struct iovec *iovec, struct iovec *out_iovec)
> -{
> -    char *buffer;
> -    int size, retval;
> -    V9fsString target, path;
> -
> -    v9fs_string_init(&path);
> -    retval = proxy_unmarshal(iovec, PROXY_HDR_SZ, "sd", &path, &size);
> -    if (retval < 0) {
> -        v9fs_string_free(&path);
> -        return retval;
> -    }
> -    buffer = g_malloc(size);
> -    v9fs_string_init(&target);
> -    retval = readlink(path.data, buffer, size - 1);
> -    if (retval > 0) {
> -        buffer[retval] = '\0';
> -        v9fs_string_sprintf(&target, "%s", buffer);
> -        retval = proxy_marshal(out_iovec, PROXY_HDR_SZ, "s", &target);
> -    } else {
> -        retval = -errno;
> -    }
> -    g_free(buffer);
> -    v9fs_string_free(&target);
> -    v9fs_string_free(&path);
> -    return retval;
> -}
> -
> -/*
> - * create other filesystem objects and send 0 on success
> - * return -errno on error
> - */
> -static int do_create_others(int type, struct iovec *iovec)
> -{
> -    dev_t rdev;
> -    int retval = 0;
> -    int offset = PROXY_HDR_SZ;
> -    V9fsString oldpath, path;
> -    int mode, uid, gid, cur_uid, cur_gid;
> -
> -    v9fs_string_init(&path);
> -    v9fs_string_init(&oldpath);
> -
> -    retval = proxy_unmarshal(iovec, offset, "dd", &uid, &gid);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    offset += retval;
> -    retval = setugid(uid, gid, &cur_uid, &cur_gid);
> -    if (retval < 0) {
> -        goto unmarshal_err_out;
> -    }
> -    switch (type) {
> -    case T_MKNOD:
> -        retval = proxy_unmarshal(iovec, offset, "sdq", &path, &mode, &rdev);
> -        if (retval < 0) {
> -            goto err_out;
> -        }
> -        retval = mknod(path.data, mode, rdev);
> -        break;
> -    case T_MKDIR:
> -        retval = proxy_unmarshal(iovec, offset, "sd", &path, &mode);
> -        if (retval < 0) {
> -            goto err_out;
> -        }
> -        retval = g_mkdir(path.data, mode);
> -        break;
> -    case T_SYMLINK:
> -        retval = proxy_unmarshal(iovec, offset, "ss", &oldpath, &path);
> -        if (retval < 0) {
> -            goto err_out;
> -        }
> -        retval = symlink(oldpath.data, path.data);
> -        break;
> -    }
> -    if (retval < 0) {
> -        retval = -errno;
> -    }
> -
> -err_out:
> -    resetugid(cur_uid, cur_gid);
> -unmarshal_err_out:
> -    v9fs_string_free(&path);
> -    v9fs_string_free(&oldpath);
> -    return retval;
> -}
> -
> -/*
> - * create a file and send fd on success
> - * return -errno on error
> - */
> -static int do_create(struct iovec *iovec)
> -{
> -    int ret;
> -    V9fsString path;
> -    int flags, mode, uid, gid, cur_uid, cur_gid;
> -
> -    v9fs_string_init(&path);
> -    ret = proxy_unmarshal(iovec, PROXY_HDR_SZ, "sdddd",
> -                          &path, &flags, &mode, &uid, &gid);
> -    if (ret < 0) {
> -        goto unmarshal_err_out;
> -    }
> -    ret = setugid(uid, gid, &cur_uid, &cur_gid);
> -    if (ret < 0) {
> -        goto unmarshal_err_out;
> -    }
> -    ret = open_regular(path.data, flags, mode);
> -    if (ret < 0) {
> -        ret = -errno;
> -    }
> -
> -    resetugid(cur_uid, cur_gid);
> -unmarshal_err_out:
> -    v9fs_string_free(&path);
> -    return ret;
> -}
> -
> -/*
> - * open a file and send fd on success
> - * return -errno on error
> - */
> -static int do_open(struct iovec *iovec)
> -{
> -    int flags, ret;
> -    V9fsString path;
> -
> -    v9fs_string_init(&path);
> -    ret = proxy_unmarshal(iovec, PROXY_HDR_SZ, "sd", &path, &flags);
> -    if (ret < 0) {
> -        goto err_out;
> -    }
> -    ret = open_regular(path.data, flags, 0);
> -    if (ret < 0) {
> -        ret = -errno;
> -    }
> -err_out:
> -    v9fs_string_free(&path);
> -    return ret;
> -}
> -
> -/* create unix domain socket and return the descriptor */
> -static int proxy_socket(const char *path, uid_t uid, gid_t gid)
> -{
> -    int sock, client;
> -    struct sockaddr_un proxy, qemu;
> -    socklen_t size;
> -
> -    /* requested socket already exists, refuse to start */
> -    if (!access(path, F_OK)) {
> -        do_log(LOG_CRIT, "socket already exists\n");
> -        return -1;
> -    }
> -
> -    if (strlen(path) >= sizeof(proxy.sun_path)) {
> -        do_log(LOG_CRIT, "UNIX domain socket path exceeds %zu characters\n",
> -               sizeof(proxy.sun_path));
> -        return -1;
> -    }
> -
> -    sock = socket(AF_UNIX, SOCK_STREAM, 0);
> -    if (sock < 0) {
> -        do_perror("socket");
> -        return -1;
> -    }
> -
> -    /* mask other part of mode bits */
> -    umask(7);
> -
> -    proxy.sun_family = AF_UNIX;
> -    strcpy(proxy.sun_path, path);
> -    if (bind(sock, (struct sockaddr *)&proxy,
> -            sizeof(struct sockaddr_un)) < 0) {
> -        do_perror("bind");
> -        goto error;
> -    }
> -    if (chown(proxy.sun_path, uid, gid) < 0) {
> -        do_perror("chown");
> -        goto error;
> -    }
> -    if (listen(sock, 1) < 0) {
> -        do_perror("listen");
> -        goto error;
> -    }
> -
> -    size = sizeof(qemu);
> -    client = accept(sock, (struct sockaddr *)&qemu, &size);
> -    if (client < 0) {
> -        do_perror("accept");
> -        goto error;
> -    }
> -    close(sock);
> -    return client;
> -
> -error:
> -    close(sock);
> -    return -1;
> -}
> -
> -static void usage(void)
> -{
> -    fprintf(stderr, "usage: %s\n"
> -            " -p|--path <path> 9p path to export\n"
> -            " {-f|--fd <socket-descriptor>} socket file descriptor to be used\n"
> -            " {-s|--socket <socketname> socket file used for communication\n"
> -            " \t-u|--uid <uid> -g|--gid <gid>} - uid:gid combination to give "
> -            " access to this socket\n"
> -            " \tNote: -s & -f can not be used together\n"
> -            " [-n|--nodaemon] Run as a normal program\n",
> -            prog_name);
> -}
> -
> -static int process_reply(int sock, int type,
> -                         struct iovec *out_iovec, int retval)
> -{
> -    switch (type) {
> -    case T_OPEN:
> -    case T_CREATE:
> -        if (send_fd(sock, retval) < 0) {
> -            return -1;
> -        }
> -        break;
> -    case T_MKNOD:
> -    case T_MKDIR:
> -    case T_SYMLINK:
> -    case T_LINK:
> -    case T_CHMOD:
> -    case T_CHOWN:
> -    case T_TRUNCATE:
> -    case T_UTIME:
> -    case T_RENAME:
> -    case T_REMOVE:
> -    case T_LSETXATTR:
> -    case T_LREMOVEXATTR:
> -        if (send_status(sock, out_iovec, retval) < 0) {
> -            return -1;
> -        }
> -        break;
> -    case T_LSTAT:
> -    case T_STATFS:
> -    case T_READLINK:
> -    case T_LGETXATTR:
> -    case T_LLISTXATTR:
> -    case T_GETVERSION:
> -        if (send_response(sock, out_iovec, retval) < 0) {
> -            return -1;
> -        }
> -        break;
> -    default:
> -        return -1;
> -        break;
> -    }
> -    return 0;
> -}
> -
> -static int process_requests(int sock)
> -{
> -    int flags;
> -    int size = 0;
> -    int retval = 0;
> -    uint64_t offset;
> -    ProxyHeader header;
> -    int mode, uid, gid;
> -    V9fsString name, value;
> -    struct timespec spec[2];
> -    V9fsString oldpath, path;
> -    struct iovec in_iovec, out_iovec;
> -
> -    in_iovec.iov_base  = g_malloc(PROXY_MAX_IO_SZ + PROXY_HDR_SZ);
> -    in_iovec.iov_len   = PROXY_MAX_IO_SZ + PROXY_HDR_SZ;
> -    out_iovec.iov_base = g_malloc(PROXY_MAX_IO_SZ + PROXY_HDR_SZ);
> -    out_iovec.iov_len  = PROXY_MAX_IO_SZ + PROXY_HDR_SZ;
> -
> -    while (1) {
> -        /*
> -         * initialize the header type, so that we send
> -         * response to proper request type.
> -         */
> -        header.type = 0;
> -        retval = read_request(sock, &in_iovec, &header);
> -        if (retval < 0) {
> -            goto err_out;
> -        }
> -
> -        switch (header.type) {
> -        case T_OPEN:
> -            retval = do_open(&in_iovec);
> -            break;
> -        case T_CREATE:
> -            retval = do_create(&in_iovec);
> -            break;
> -        case T_MKNOD:
> -        case T_MKDIR:
> -        case T_SYMLINK:
> -            retval = do_create_others(header.type, &in_iovec);
> -            break;
> -        case T_LINK:
> -            v9fs_string_init(&path);
> -            v9fs_string_init(&oldpath);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ,
> -                                     "ss", &oldpath, &path);
> -            if (retval > 0) {
> -                retval = link(oldpath.data, path.data);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&oldpath);
> -            v9fs_string_free(&path);
> -            break;
> -        case T_LSTAT:
> -        case T_STATFS:
> -            retval = do_stat(header.type, &in_iovec, &out_iovec);
> -            break;
> -        case T_READLINK:
> -            retval = do_readlink(&in_iovec, &out_iovec);
> -            break;
> -        case T_CHMOD:
> -            v9fs_string_init(&path);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ,
> -                                     "sd", &path, &mode);
> -            if (retval > 0) {
> -                retval = chmod(path.data, mode);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            break;
> -        case T_CHOWN:
> -            v9fs_string_init(&path);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ, "sdd", &path,
> -                                     &uid, &gid);
> -            if (retval > 0) {
> -                retval = lchown(path.data, uid, gid);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            break;
> -        case T_TRUNCATE:
> -            v9fs_string_init(&path);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ, "sq",
> -                                     &path, &offset);
> -            if (retval > 0) {
> -                retval = truncate(path.data, offset);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            break;
> -        case T_UTIME:
> -            v9fs_string_init(&path);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ, "sqqqq", &path,
> -                                     &spec[0].tv_sec, &spec[0].tv_nsec,
> -                                     &spec[1].tv_sec, &spec[1].tv_nsec);
> -            if (retval > 0) {
> -                retval = utimensat(AT_FDCWD, path.data, spec,
> -                                   AT_SYMLINK_NOFOLLOW);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            break;
> -        case T_RENAME:
> -            v9fs_string_init(&path);
> -            v9fs_string_init(&oldpath);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ,
> -                                     "ss", &oldpath, &path);
> -            if (retval > 0) {
> -                retval = rename(oldpath.data, path.data);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&oldpath);
> -            v9fs_string_free(&path);
> -            break;
> -        case T_REMOVE:
> -            v9fs_string_init(&path);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ, "s", &path);
> -            if (retval > 0) {
> -                retval = remove(path.data);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            break;
> -        case T_LGETXATTR:
> -        case T_LLISTXATTR:
> -            retval = do_getxattr(header.type, &in_iovec, &out_iovec);
> -            break;
> -        case T_LSETXATTR:
> -            v9fs_string_init(&path);
> -            v9fs_string_init(&name);
> -            v9fs_string_init(&value);
> -            retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ, "sssdd", &path,
> -                                     &name, &value, &size, &flags);
> -            if (retval > 0) {
> -                retval = lsetxattr(path.data,
> -                                   name.data, value.data, size, flags);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            v9fs_string_free(&name);
> -            v9fs_string_free(&value);
> -            break;
> -        case T_LREMOVEXATTR:
> -            v9fs_string_init(&path);
> -            v9fs_string_init(&name);
> -            retval = proxy_unmarshal(&in_iovec,
> -                                     PROXY_HDR_SZ, "ss", &path, &name);
> -            if (retval > 0) {
> -                retval = lremovexattr(path.data, name.data);
> -                if (retval < 0) {
> -                    retval = -errno;
> -                }
> -            }
> -            v9fs_string_free(&path);
> -            v9fs_string_free(&name);
> -            break;
> -        case T_GETVERSION:
> -            retval = do_getversion(&in_iovec, &out_iovec);
> -            break;
> -        default:
> -            goto err_out;
> -            break;
> -        }
> -
> -        if (process_reply(sock, header.type, &out_iovec, retval) < 0) {
> -            goto err_out;
> -        }
> -    }
> -err_out:
> -    g_free(in_iovec.iov_base);
> -    g_free(out_iovec.iov_base);
> -    return -1;
> -}
> -
> -int main(int argc, char **argv)
> -{
> -    int sock;
> -    uid_t own_u;
> -    gid_t own_g;
> -    char *rpath = NULL;
> -    char *sock_name = NULL;
> -    struct stat stbuf;
> -    int c, option_index;
> -#ifdef FS_IOC_GETVERSION
> -    int retval;
> -    struct statfs st_fs;
> -#endif
> -
> -    fprintf(stderr, "NOTE: The 9p 'proxy' backend is deprecated (since "
> -                    "QEMU 8.1) and will be removed in a future version of "
> -                    "QEMU!\n");
> -
> -    prog_name = g_path_get_basename(argv[0]);
> -
> -    is_daemon = true;
> -    sock = -1;
> -    own_u = own_g = -1;
> -    while (1) {
> -        option_index = 0;
> -        c = getopt_long(argc, argv, "p:nh?f:s:u:g:", helper_opts,
> -                        &option_index);
> -        if (c == -1) {
> -            break;
> -        }
> -        switch (c) {
> -        case 'p':
> -            rpath = g_strdup(optarg);
> -            break;
> -        case 'n':
> -            is_daemon = false;
> -            break;
> -        case 'f':
> -            sock = atoi(optarg);
> -            break;
> -        case 's':
> -            sock_name = g_strdup(optarg);
> -            break;
> -        case 'u':
> -            own_u = atoi(optarg);
> -            break;
> -        case 'g':
> -            own_g = atoi(optarg);
> -            break;
> -        case '?':
> -        case 'h':
> -        default:
> -            usage();
> -            exit(EXIT_FAILURE);
> -        }
> -    }
> -
> -    /* Parameter validation */
> -    if ((sock_name == NULL && sock == -1) || rpath == NULL) {
> -        fprintf(stderr, "socket, socket descriptor or path not specified\n");
> -        usage();
> -        return -1;
> -    }
> -
> -    if (sock_name && sock != -1) {
> -        fprintf(stderr, "both named socket and socket descriptor specified\n");
> -        usage();
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (sock_name && (own_u == -1 || own_g == -1)) {
> -        fprintf(stderr, "owner uid:gid not specified, ");
> -        fprintf(stderr,
> -                "owner uid:gid specifies who can access the socket file\n");
> -        usage();
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (lstat(rpath, &stbuf) < 0) {
> -        fprintf(stderr, "invalid path \"%s\" specified, %s\n",
> -                rpath, strerror(errno));
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (!S_ISDIR(stbuf.st_mode)) {
> -        fprintf(stderr, "specified path \"%s\" is not directory\n", rpath);
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (is_daemon) {
> -        if (daemon(0, 0) < 0) {
> -            fprintf(stderr, "daemon call failed\n");
> -            exit(EXIT_FAILURE);
> -        }
> -        openlog(PROGNAME, LOG_PID, LOG_DAEMON);
> -    }
> -
> -    do_log(LOG_INFO, "Started\n");
> -    if (sock_name) {
> -        sock = proxy_socket(sock_name, own_u, own_g);
> -        if (sock < 0) {
> -            goto error;
> -        }
> -    }
> -
> -    if (chroot(rpath) < 0) {
> -        do_perror("chroot");
> -        goto error;
> -    }
> -    if (chdir("/") < 0) {
> -        do_perror("chdir");
> -        goto error;
> -    }
> -
> -    get_version = false;
> -#ifdef FS_IOC_GETVERSION
> -    /* check whether underlying FS support IOC_GETVERSION */
> -    retval = statfs("/", &st_fs);
> -    if (!retval) {
> -        switch (st_fs.f_type) {
> -        case EXT2_SUPER_MAGIC:
> -        case BTRFS_SUPER_MAGIC:
> -        case REISERFS_SUPER_MAGIC:
> -        case XFS_SUPER_MAGIC:
> -            get_version = true;
> -            break;
> -        }
> -    }
> -#endif
> -
> -    umask(0);
> -    if (init_capabilities() < 0) {
> -        goto error;
> -    }
> -
> -    process_requests(sock);
> -error:
> -    g_free(rpath);
> -    g_free(sock_name);
> -    do_log(LOG_INFO, "Done\n");
> -    closelog();
> -    return 0;
> -}
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> deleted file mode 100644
> index 7aac49ad4ad..00000000000
> --- a/hw/9pfs/9p-proxy.c
> +++ /dev/null
> @@ -1,1279 +0,0 @@
> -/*
> - * 9p Proxy callback
> - *
> - * Copyright IBM, Corp. 2011
> - *
> - * Authors:
> - * M. Mohan Kumar <mohan@in.ibm.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2.  See
> - * the COPYING file in the top-level directory.
> - */
> -
> -/*
> - * Not so fast! You might want to read the 9p developer docs first:
> - * https://wiki.qemu.org/Documentation/9p
> - */
> -
> -/*
> - * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> - * removed in a future version of QEMU!
> - */
> -
> -#include "qemu/osdep.h"
> -#include <sys/socket.h>
> -#include <sys/un.h>
> -#include "9p.h"
> -#include "qapi/error.h"
> -#include "qemu/cutils.h"
> -#include "qemu/error-report.h"
> -#include "qemu/option.h"
> -#include "fsdev/qemu-fsdev.h"
> -#include "9p-proxy.h"
> -
> -typedef struct V9fsProxy {
> -    int sockfd;
> -    QemuMutex mutex;
> -    struct iovec in_iovec;
> -    struct iovec out_iovec;
> -} V9fsProxy;
> -
> -/*
> - * Return received file descriptor on success in *status.
> - * errno is also returned on *status (which will be < 0)
> - * return < 0 on transport error.
> - */
> -static int v9fs_receivefd(int sockfd, int *status)
> -{
> -    struct iovec iov;
> -    struct msghdr msg;
> -    struct cmsghdr *cmsg;
> -    int retval, data, fd;
> -    union MsgControl msg_control;
> -
> -    iov.iov_base = &data;
> -    iov.iov_len = sizeof(data);
> -
> -    memset(&msg, 0, sizeof(msg));
> -    msg.msg_iov = &iov;
> -    msg.msg_iovlen = 1;
> -    msg.msg_control = &msg_control;
> -    msg.msg_controllen = sizeof(msg_control);
> -
> -    do {
> -        retval = recvmsg(sockfd, &msg, 0);
> -    } while (retval < 0 && errno == EINTR);
> -    if (retval <= 0) {
> -        return retval;
> -    }
> -    /*
> -     * data is set to V9FS_FD_VALID, if ancillary data is sent.  If this
> -     * request doesn't need ancillary data (fd) or an error occurred,
> -     * data is set to negative errno value.
> -     */
> -    if (data != V9FS_FD_VALID) {
> -        *status = data;
> -        return 0;
> -    }
> -    /*
> -     * File descriptor (fd) is sent in the ancillary data. Check if we
> -     * indeed received it. One of the reasons to fail to receive it is if
> -     * we exceeded the maximum number of file descriptors!
> -     */
> -    for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> -        if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)) ||
> -            cmsg->cmsg_level != SOL_SOCKET ||
> -            cmsg->cmsg_type != SCM_RIGHTS) {
> -            continue;
> -        }
> -        fd = *((int *)CMSG_DATA(cmsg));
> -        *status = fd;
> -        return 0;
> -    }
> -    *status = -ENFILE;  /* Ancillary data sent but not received */
> -    return 0;
> -}
> -
> -static ssize_t socket_read(int sockfd, void *buff, size_t size)
> -{
> -    ssize_t retval, total = 0;
> -
> -    while (size) {
> -        retval = read(sockfd, buff, size);
> -        if (retval == 0) {
> -            return -EIO;
> -        }
> -        if (retval < 0) {
> -            if (errno == EINTR) {
> -                continue;
> -            }
> -            return -errno;
> -        }
> -        size -= retval;
> -        buff += retval;
> -        total += retval;
> -    }
> -    return total;
> -}
> -
> -/* Converts proxy_statfs to VFS statfs structure */
> -static void prstatfs_to_statfs(struct statfs *stfs, ProxyStatFS *prstfs)
> -{
> -    memset(stfs, 0, sizeof(*stfs));
> -    stfs->f_type = prstfs->f_type;
> -    stfs->f_bsize = prstfs->f_bsize;
> -    stfs->f_blocks = prstfs->f_blocks;
> -    stfs->f_bfree = prstfs->f_bfree;
> -    stfs->f_bavail = prstfs->f_bavail;
> -    stfs->f_files = prstfs->f_files;
> -    stfs->f_ffree = prstfs->f_ffree;
> -#ifdef CONFIG_DARWIN
> -    /* f_namelen and f_frsize do not exist on Darwin */
> -    stfs->f_fsid.val[0] = prstfs->f_fsid[0] & 0xFFFFFFFFU;
> -    stfs->f_fsid.val[1] = prstfs->f_fsid[1] >> 32 & 0xFFFFFFFFU;
> -#else
> -    stfs->f_fsid.__val[0] = prstfs->f_fsid[0] & 0xFFFFFFFFU;
> -    stfs->f_fsid.__val[1] = prstfs->f_fsid[1] >> 32 & 0xFFFFFFFFU;
> -    stfs->f_namelen = prstfs->f_namelen;
> -    stfs->f_frsize = prstfs->f_frsize;
> -#endif
> -}
> -
> -/* Converts proxy_stat structure to VFS stat structure */
> -static void prstat_to_stat(struct stat *stbuf, ProxyStat *prstat)
> -{
> -   memset(stbuf, 0, sizeof(*stbuf));
> -   stbuf->st_dev = prstat->st_dev;
> -   stbuf->st_ino = prstat->st_ino;
> -   stbuf->st_nlink = prstat->st_nlink;
> -   stbuf->st_mode = prstat->st_mode;
> -   stbuf->st_uid = prstat->st_uid;
> -   stbuf->st_gid = prstat->st_gid;
> -   stbuf->st_rdev = prstat->st_rdev;
> -   stbuf->st_size = prstat->st_size;
> -   stbuf->st_blksize = prstat->st_blksize;
> -   stbuf->st_blocks = prstat->st_blocks;
> -   stbuf->st_atime = prstat->st_atim_sec;
> -   stbuf->st_mtime = prstat->st_mtim_sec;
> -   stbuf->st_ctime = prstat->st_ctim_sec;
> -#ifdef CONFIG_DARWIN
> -   stbuf->st_atimespec.tv_sec = prstat->st_atim_sec;
> -   stbuf->st_mtimespec.tv_sec = prstat->st_mtim_sec;
> -   stbuf->st_ctimespec.tv_sec = prstat->st_ctim_sec;
> -   stbuf->st_atimespec.tv_nsec = prstat->st_atim_nsec;
> -   stbuf->st_mtimespec.tv_nsec = prstat->st_mtim_nsec;
> -   stbuf->st_ctimespec.tv_nsec = prstat->st_ctim_nsec;
> -#else
> -   stbuf->st_atim.tv_sec = prstat->st_atim_sec;
> -   stbuf->st_mtim.tv_sec = prstat->st_mtim_sec;
> -   stbuf->st_ctim.tv_sec = prstat->st_ctim_sec;
> -   stbuf->st_atim.tv_nsec = prstat->st_atim_nsec;
> -   stbuf->st_mtim.tv_nsec = prstat->st_mtim_nsec;
> -   stbuf->st_ctim.tv_nsec = prstat->st_ctim_nsec;
> -#endif
> -}
> -
> -/*
> - * Response contains two parts
> - * {header, data}
> - * header.type == T_ERROR, data -> -errno
> - * header.type == T_SUCCESS, data -> response
> - * size of errno/response is given by header.size
> - * returns < 0, on transport error. response is
> - * valid only if status >= 0.
> - */
> -static int v9fs_receive_response(V9fsProxy *proxy, int type,
> -                                 int *status, void *response)
> -{
> -    int retval;
> -    ProxyHeader header;
> -    struct iovec *reply = &proxy->in_iovec;
> -
> -    *status = 0;
> -    reply->iov_len = 0;
> -    retval = socket_read(proxy->sockfd, reply->iov_base, PROXY_HDR_SZ);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    reply->iov_len = PROXY_HDR_SZ;
> -    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> -    assert(retval == 4 * 2);
> -    /*
> -     * if response size > PROXY_MAX_IO_SZ, read the response but ignore it and
> -     * return -ENOBUFS
> -     */
> -    if (header.size > PROXY_MAX_IO_SZ) {
> -        int count;
> -        while (header.size > 0) {
> -            count = MIN(PROXY_MAX_IO_SZ, header.size);
> -            count = socket_read(proxy->sockfd, reply->iov_base, count);
> -            if (count < 0) {
> -                return count;
> -            }
> -            header.size -= count;
> -        }
> -        *status = -ENOBUFS;
> -        return 0;
> -    }
> -
> -    retval = socket_read(proxy->sockfd,
> -                         reply->iov_base + PROXY_HDR_SZ, header.size);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    reply->iov_len += header.size;
> -    /* there was an error during processing request */
> -    if (header.type == T_ERROR) {
> -        int ret;
> -        ret = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> -        assert(ret == 4);
> -        return 0;
> -    }
> -
> -    switch (type) {
> -    case T_LSTAT: {
> -        ProxyStat prstat;
> -        retval = proxy_unmarshal(reply, PROXY_HDR_SZ,
> -                                 "qqqdddqqqqqqqqqq", &prstat.st_dev,
> -                                 &prstat.st_ino, &prstat.st_nlink,
> -                                 &prstat.st_mode, &prstat.st_uid,
> -                                 &prstat.st_gid, &prstat.st_rdev,
> -                                 &prstat.st_size, &prstat.st_blksize,
> -                                 &prstat.st_blocks,
> -                                 &prstat.st_atim_sec, &prstat.st_atim_nsec,
> -                                 &prstat.st_mtim_sec, &prstat.st_mtim_nsec,
> -                                 &prstat.st_ctim_sec, &prstat.st_ctim_nsec);
> -        assert(retval == 8 * 3 + 4 * 3 + 8 * 10);
> -        prstat_to_stat(response, &prstat);
> -        break;
> -    }
> -    case T_STATFS: {
> -        ProxyStatFS prstfs;
> -        retval = proxy_unmarshal(reply, PROXY_HDR_SZ,
> -                                 "qqqqqqqqqqq", &prstfs.f_type,
> -                                 &prstfs.f_bsize, &prstfs.f_blocks,
> -                                 &prstfs.f_bfree, &prstfs.f_bavail,
> -                                 &prstfs.f_files, &prstfs.f_ffree,
> -                                 &prstfs.f_fsid[0], &prstfs.f_fsid[1],
> -                                 &prstfs.f_namelen, &prstfs.f_frsize);
> -        assert(retval == 8 * 11);
> -        prstatfs_to_statfs(response, &prstfs);
> -        break;
> -    }
> -    case T_READLINK: {
> -        V9fsString target;
> -        v9fs_string_init(&target);
> -        retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "s", &target);
> -        strcpy(response, target.data);
> -        v9fs_string_free(&target);
> -        break;
> -    }
> -    case T_LGETXATTR:
> -    case T_LLISTXATTR: {
> -        V9fsString xattr;
> -        v9fs_string_init(&xattr);
> -        retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "s", &xattr);
> -        memcpy(response, xattr.data, xattr.size);
> -        v9fs_string_free(&xattr);
> -        break;
> -    }
> -    case T_GETVERSION:
> -        retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
> -        assert(retval == 8);
> -        break;
> -    default:
> -        return -1;
> -    }
> -    if (retval < 0) {
> -        *status  = retval;
> -    }
> -    return 0;
> -}
> -
> -/*
> - * return < 0 on transport error.
> - * *status is valid only if return >= 0
> - */
> -static int v9fs_receive_status(V9fsProxy *proxy,
> -                               struct iovec *reply, int *status)
> -{
> -    int retval;
> -    ProxyHeader header;
> -
> -    *status = 0;
> -    reply->iov_len = 0;
> -    retval = socket_read(proxy->sockfd, reply->iov_base, PROXY_HDR_SZ);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    reply->iov_len = PROXY_HDR_SZ;
> -    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> -    assert(retval == 4 * 2);
> -    retval = socket_read(proxy->sockfd,
> -                         reply->iov_base + PROXY_HDR_SZ, header.size);
> -    if (retval < 0) {
> -        return retval;
> -    }
> -    reply->iov_len += header.size;
> -    retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> -    assert(retval == 4);
> -    return 0;
> -}
> -
> -/*
> - * Proxy->header and proxy->request written to socket by QEMU process.
> - * This request read by proxy helper process
> - * returns 0 on success and -errno on error
> - */
> -static int v9fs_request(V9fsProxy *proxy, int type, void *response, ...)
> -{
> -    dev_t rdev;
> -    va_list ap;
> -    int size = 0;
> -    int retval = 0;
> -    uint64_t offset;
> -    ProxyHeader header = { 0, 0};
> -    struct timespec spec[2];
> -    int flags, mode, uid, gid;
> -    V9fsString *name, *value;
> -    V9fsString *path, *oldpath;
> -    struct iovec *iovec = NULL, *reply = NULL;
> -
> -    qemu_mutex_lock(&proxy->mutex);
> -
> -    if (proxy->sockfd == -1) {
> -        retval = -EIO;
> -        goto err_out;
> -    }
> -    iovec = &proxy->out_iovec;
> -    reply = &proxy->in_iovec;
> -    va_start(ap, response);
> -    switch (type) {
> -    case T_OPEN:
> -        path = va_arg(ap, V9fsString *);
> -        flags = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sd", path, flags);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_OPEN;
> -        }
> -        break;
> -    case T_CREATE:
> -        path = va_arg(ap, V9fsString *);
> -        flags = va_arg(ap, int);
> -        mode = va_arg(ap, int);
> -        uid = va_arg(ap, int);
> -        gid = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sdddd", path,
> -                                    flags, mode, uid, gid);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_CREATE;
> -        }
> -        break;
> -    case T_MKNOD:
> -        path = va_arg(ap, V9fsString *);
> -        mode = va_arg(ap, int);
> -        rdev = va_arg(ap, long int);
> -        uid = va_arg(ap, int);
> -        gid = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ddsdq",
> -                                    uid, gid, path, mode, rdev);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_MKNOD;
> -        }
> -        break;
> -    case T_MKDIR:
> -        path = va_arg(ap, V9fsString *);
> -        mode = va_arg(ap, int);
> -        uid = va_arg(ap, int);
> -        gid = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ddsd",
> -                                    uid, gid, path, mode);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_MKDIR;
> -        }
> -        break;
> -    case T_SYMLINK:
> -        oldpath = va_arg(ap, V9fsString *);
> -        path = va_arg(ap, V9fsString *);
> -        uid = va_arg(ap, int);
> -        gid = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ddss",
> -                                    uid, gid, oldpath, path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_SYMLINK;
> -        }
> -        break;
> -    case T_LINK:
> -        oldpath = va_arg(ap, V9fsString *);
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ss",
> -                                    oldpath, path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_LINK;
> -        }
> -        break;
> -    case T_LSTAT:
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "s", path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_LSTAT;
> -        }
> -        break;
> -    case T_READLINK:
> -        path = va_arg(ap, V9fsString *);
> -        size = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sd", path, size);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_READLINK;
> -        }
> -        break;
> -    case T_STATFS:
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "s", path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_STATFS;
> -        }
> -        break;
> -    case T_CHMOD:
> -        path = va_arg(ap, V9fsString *);
> -        mode = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sd", path, mode);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_CHMOD;
> -        }
> -        break;
> -    case T_CHOWN:
> -        path = va_arg(ap, V9fsString *);
> -        uid = va_arg(ap, int);
> -        gid = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sdd", path, uid, gid);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_CHOWN;
> -        }
> -        break;
> -    case T_TRUNCATE:
> -        path = va_arg(ap, V9fsString *);
> -        offset = va_arg(ap, uint64_t);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sq", path, offset);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_TRUNCATE;
> -        }
> -        break;
> -    case T_UTIME:
> -        path = va_arg(ap, V9fsString *);
> -        spec[0].tv_sec = va_arg(ap, long);
> -        spec[0].tv_nsec = va_arg(ap, long);
> -        spec[1].tv_sec = va_arg(ap, long);
> -        spec[1].tv_nsec = va_arg(ap, long);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sqqqq", path,
> -                                    spec[0].tv_sec, spec[1].tv_nsec,
> -                                    spec[1].tv_sec, spec[1].tv_nsec);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_UTIME;
> -        }
> -        break;
> -    case T_RENAME:
> -        oldpath = va_arg(ap, V9fsString *);
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ss", oldpath, path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_RENAME;
> -        }
> -        break;
> -    case T_REMOVE:
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "s", path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_REMOVE;
> -        }
> -        break;
> -    case T_LGETXATTR:
> -        size = va_arg(ap, int);
> -        path = va_arg(ap, V9fsString *);
> -        name = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ,
> -                                    "dss", size, path, name);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_LGETXATTR;
> -        }
> -        break;
> -    case T_LLISTXATTR:
> -        size = va_arg(ap, int);
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ds", size, path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_LLISTXATTR;
> -        }
> -        break;
> -    case T_LSETXATTR:
> -        path = va_arg(ap, V9fsString *);
> -        name = va_arg(ap, V9fsString *);
> -        value = va_arg(ap, V9fsString *);
> -        size = va_arg(ap, int);
> -        flags = va_arg(ap, int);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "sssdd",
> -                                    path, name, value, size, flags);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_LSETXATTR;
> -        }
> -        break;
> -    case T_LREMOVEXATTR:
> -        path = va_arg(ap, V9fsString *);
> -        name = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "ss", path, name);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_LREMOVEXATTR;
> -        }
> -        break;
> -    case T_GETVERSION:
> -        path = va_arg(ap, V9fsString *);
> -        retval = proxy_marshal(iovec, PROXY_HDR_SZ, "s", path);
> -        if (retval > 0) {
> -            header.size = retval;
> -            header.type = T_GETVERSION;
> -        }
> -        break;
> -    default:
> -        error_report("Invalid type %d", type);
> -        retval = -EINVAL;
> -        break;
> -    }
> -    va_end(ap);
> -
> -    if (retval < 0) {
> -        goto err_out;
> -    }
> -
> -    /* marshal the header details */
> -    retval = proxy_marshal(iovec, 0, "dd", header.type, header.size);
> -    assert(retval == 4 * 2);
> -    header.size += PROXY_HDR_SZ;
> -
> -    retval = qemu_write_full(proxy->sockfd, iovec->iov_base, header.size);
> -    if (retval != header.size) {
> -        goto close_error;
> -    }
> -
> -    switch (type) {
> -    case T_OPEN:
> -    case T_CREATE:
> -        /*
> -         * A file descriptor is returned as response for
> -         * T_OPEN,T_CREATE on success
> -         */
> -        if (v9fs_receivefd(proxy->sockfd, &retval) < 0) {
> -            goto close_error;
> -        }
> -        break;
> -    case T_MKNOD:
> -    case T_MKDIR:
> -    case T_SYMLINK:
> -    case T_LINK:
> -    case T_CHMOD:
> -    case T_CHOWN:
> -    case T_RENAME:
> -    case T_TRUNCATE:
> -    case T_UTIME:
> -    case T_REMOVE:
> -    case T_LSETXATTR:
> -    case T_LREMOVEXATTR:
> -        if (v9fs_receive_status(proxy, reply, &retval) < 0) {
> -            goto close_error;
> -        }
> -        break;
> -    case T_LSTAT:
> -    case T_READLINK:
> -    case T_STATFS:
> -    case T_GETVERSION:
> -        if (v9fs_receive_response(proxy, type, &retval, response) < 0) {
> -            goto close_error;
> -        }
> -        break;
> -    case T_LGETXATTR:
> -    case T_LLISTXATTR:
> -        if (!size) {
> -            if (v9fs_receive_status(proxy, reply, &retval) < 0) {
> -                goto close_error;
> -            }
> -        } else {
> -            if (v9fs_receive_response(proxy, type, &retval, response) < 0) {
> -                goto close_error;
> -            }
> -        }
> -        break;
> -    }
> -
> -err_out:
> -    qemu_mutex_unlock(&proxy->mutex);
> -    return retval;
> -
> -close_error:
> -    close(proxy->sockfd);
> -    proxy->sockfd = -1;
> -    qemu_mutex_unlock(&proxy->mutex);
> -    return -EIO;
> -}
> -
> -static int proxy_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
> -{
> -    int retval;
> -    retval = v9fs_request(fs_ctx->private, T_LSTAT, stbuf, fs_path);
> -    if (retval < 0) {
> -        errno = -retval;
> -        return -1;
> -    }
> -    return retval;
> -}
> -
> -static ssize_t proxy_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
> -                              char *buf, size_t bufsz)
> -{
> -    int retval;
> -    retval = v9fs_request(fs_ctx->private, T_READLINK, buf, fs_path, bufsz);
> -    if (retval < 0) {
> -        errno = -retval;
> -        return -1;
> -    }
> -    return strlen(buf);
> -}
> -
> -static int proxy_close(FsContext *ctx, V9fsFidOpenState *fs)
> -{
> -    return close(fs->fd);
> -}
> -
> -static int proxy_closedir(FsContext *ctx, V9fsFidOpenState *fs)
> -{
> -    return closedir(fs->dir.stream);
> -}
> -
> -static int proxy_open(FsContext *ctx, V9fsPath *fs_path,
> -                      int flags, V9fsFidOpenState *fs)
> -{
> -    fs->fd = v9fs_request(ctx->private, T_OPEN, NULL, fs_path, flags);
> -    if (fs->fd < 0) {
> -        errno = -fs->fd;
> -        fs->fd = -1;
> -    }
> -    return fs->fd;
> -}
> -
> -static int proxy_opendir(FsContext *ctx,
> -                         V9fsPath *fs_path, V9fsFidOpenState *fs)
> -{
> -    int serrno, fd;
> -
> -    fs->dir.stream = NULL;
> -    fd = v9fs_request(ctx->private, T_OPEN, NULL, fs_path, O_DIRECTORY);
> -    if (fd < 0) {
> -        errno = -fd;
> -        return -1;
> -    }
> -    fs->dir.stream = fdopendir(fd);
> -    if (!fs->dir.stream) {
> -        serrno = errno;
> -        close(fd);
> -        errno = serrno;
> -        return -1;
> -    }
> -    return 0;
> -}
> -
> -static void proxy_rewinddir(FsContext *ctx, V9fsFidOpenState *fs)
> -{
> -    rewinddir(fs->dir.stream);
> -}
> -
> -static off_t proxy_telldir(FsContext *ctx, V9fsFidOpenState *fs)
> -{
> -    return telldir(fs->dir.stream);
> -}
> -
> -static struct dirent *proxy_readdir(FsContext *ctx, V9fsFidOpenState *fs)
> -{
> -    struct dirent *entry;
> -    entry = readdir(fs->dir.stream);
> -#ifdef CONFIG_DARWIN
> -    if (!entry) {
> -        return NULL;
> -    }
> -    int td;
> -    td = telldir(fs->dir.stream);
> -    /* If telldir fails, fail the entire readdir call */
> -    if (td < 0) {
> -        return NULL;
> -    }
> -    entry->d_seekoff = td;
> -#endif
> -    return entry;
> -}
> -
> -static void proxy_seekdir(FsContext *ctx, V9fsFidOpenState *fs, off_t off)
> -{
> -    seekdir(fs->dir.stream, off);
> -}
> -
> -static ssize_t proxy_preadv(FsContext *ctx, V9fsFidOpenState *fs,
> -                            const struct iovec *iov,
> -                            int iovcnt, off_t offset)
> -{
> -    ssize_t ret;
> -#ifdef CONFIG_PREADV
> -    ret = preadv(fs->fd, iov, iovcnt, offset);
> -#else
> -    ret = lseek(fs->fd, offset, SEEK_SET);
> -    if (ret >= 0) {
> -        ret = readv(fs->fd, iov, iovcnt);
> -    }
> -#endif
> -    return ret;
> -}
> -
> -static ssize_t proxy_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
> -                             const struct iovec *iov,
> -                             int iovcnt, off_t offset)
> -{
> -    ssize_t ret;
> -
> -#ifdef CONFIG_PREADV
> -    ret = pwritev(fs->fd, iov, iovcnt, offset);
> -#else
> -    ret = lseek(fs->fd, offset, SEEK_SET);
> -    if (ret >= 0) {
> -        ret = writev(fs->fd, iov, iovcnt);
> -    }
> -#endif
> -#ifdef CONFIG_SYNC_FILE_RANGE
> -    if (ret > 0 && ctx->export_flags & V9FS_IMMEDIATE_WRITEOUT) {
> -        /*
> -         * Initiate a writeback. This is not a data integrity sync.
> -         * We want to ensure that we don't leave dirty pages in the cache
> -         * after write when writeout=immediate is specified.
> -         */
> -        sync_file_range(fs->fd, offset, ret,
> -                        SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);
> -    }
> -#endif
> -    return ret;
> -}
> -
> -static int proxy_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
> -{
> -    int retval;
> -    retval = v9fs_request(fs_ctx->private, T_CHMOD, NULL, fs_path,
> -                          credp->fc_mode);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
> -                       const char *name, FsCred *credp)
> -{
> -    int retval;
> -    V9fsString fullname;
> -
> -    v9fs_string_init(&fullname);
> -    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> -
> -    retval = v9fs_request(fs_ctx->private, T_MKNOD, NULL, &fullname,
> -                          credp->fc_mode, credp->fc_rdev,
> -                          credp->fc_uid, credp->fc_gid);
> -    v9fs_string_free(&fullname);
> -    if (retval < 0) {
> -        errno = -retval;
> -        retval = -1;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
> -                       const char *name, FsCred *credp)
> -{
> -    int retval;
> -    V9fsString fullname;
> -
> -    v9fs_string_init(&fullname);
> -    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> -
> -    retval = v9fs_request(fs_ctx->private, T_MKDIR, NULL, &fullname,
> -                          credp->fc_mode, credp->fc_uid, credp->fc_gid);
> -    v9fs_string_free(&fullname);
> -    if (retval < 0) {
> -        errno = -retval;
> -        retval = -1;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_fstat(FsContext *fs_ctx, int fid_type,
> -                       V9fsFidOpenState *fs, struct stat *stbuf)
> -{
> -    int fd;
> -
> -    if (fid_type == P9_FID_DIR) {
> -        fd = dirfd(fs->dir.stream);
> -    } else {
> -        fd = fs->fd;
> -    }
> -    return fstat(fd, stbuf);
> -}
> -
> -static int proxy_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
> -                       int flags, FsCred *credp, V9fsFidOpenState *fs)
> -{
> -    V9fsString fullname;
> -
> -    v9fs_string_init(&fullname);
> -    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> -
> -    fs->fd = v9fs_request(fs_ctx->private, T_CREATE, NULL, &fullname, flags,
> -                          credp->fc_mode, credp->fc_uid, credp->fc_gid);
> -    v9fs_string_free(&fullname);
> -    if (fs->fd < 0) {
> -        errno = -fs->fd;
> -        fs->fd = -1;
> -    }
> -    return fs->fd;
> -}
> -
> -static int proxy_symlink(FsContext *fs_ctx, const char *oldpath,
> -                         V9fsPath *dir_path, const char *name, FsCred *credp)
> -{
> -    int retval;
> -    V9fsString fullname, target;
> -
> -    v9fs_string_init(&fullname);
> -    v9fs_string_init(&target);
> -
> -    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
> -    v9fs_string_sprintf(&target, "%s", oldpath);
> -
> -    retval = v9fs_request(fs_ctx->private, T_SYMLINK, NULL, &target, &fullname,
> -                          credp->fc_uid, credp->fc_gid);
> -    v9fs_string_free(&fullname);
> -    v9fs_string_free(&target);
> -    if (retval < 0) {
> -        errno = -retval;
> -        retval = -1;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_link(FsContext *ctx, V9fsPath *oldpath,
> -                      V9fsPath *dirpath, const char *name)
> -{
> -    int retval;
> -    V9fsString newpath;
> -
> -    v9fs_string_init(&newpath);
> -    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
> -
> -    retval = v9fs_request(ctx->private, T_LINK, NULL, oldpath, &newpath);
> -    v9fs_string_free(&newpath);
> -    if (retval < 0) {
> -        errno = -retval;
> -        retval = -1;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
> -{
> -    int retval;
> -
> -    retval = v9fs_request(ctx->private, T_TRUNCATE, NULL, fs_path, size);
> -    if (retval < 0) {
> -        errno = -retval;
> -        return -1;
> -    }
> -    return 0;
> -}
> -
> -static int proxy_rename(FsContext *ctx, const char *oldpath,
> -                        const char *newpath)
> -{
> -    int retval;
> -    V9fsString oldname, newname;
> -
> -    v9fs_string_init(&oldname);
> -    v9fs_string_init(&newname);
> -
> -    v9fs_string_sprintf(&oldname, "%s", oldpath);
> -    v9fs_string_sprintf(&newname, "%s", newpath);
> -    retval = v9fs_request(ctx->private, T_RENAME, NULL, &oldname, &newname);
> -    v9fs_string_free(&oldname);
> -    v9fs_string_free(&newname);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
> -{
> -    int retval;
> -    retval = v9fs_request(fs_ctx->private, T_CHOWN, NULL, fs_path,
> -                          credp->fc_uid, credp->fc_gid);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_utimensat(FsContext *s, V9fsPath *fs_path,
> -                           const struct timespec *buf)
> -{
> -    int retval;
> -    retval = v9fs_request(s->private, T_UTIME, NULL, fs_path,
> -                          buf[0].tv_sec, buf[0].tv_nsec,
> -                          buf[1].tv_sec, buf[1].tv_nsec);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_remove(FsContext *ctx, const char *path)
> -{
> -    int retval;
> -    V9fsString name;
> -    v9fs_string_init(&name);
> -    v9fs_string_sprintf(&name, "%s", path);
> -    retval = v9fs_request(ctx->private, T_REMOVE, NULL, &name);
> -    v9fs_string_free(&name);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_fsync(FsContext *ctx, int fid_type,
> -                       V9fsFidOpenState *fs, int datasync)
> -{
> -    int fd;
> -
> -    if (fid_type == P9_FID_DIR) {
> -        fd = dirfd(fs->dir.stream);
> -    } else {
> -        fd = fs->fd;
> -    }
> -
> -    if (datasync) {
> -        return qemu_fdatasync(fd);
> -    } else {
> -        return fsync(fd);
> -    }
> -}
> -
> -static int proxy_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
> -{
> -    int retval;
> -    retval = v9fs_request(s->private, T_STATFS, stbuf, fs_path);
> -    if (retval < 0) {
> -        errno = -retval;
> -        return -1;
> -    }
> -    return retval;
> -}
> -
> -static ssize_t proxy_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
> -                               const char *name, void *value, size_t size)
> -{
> -    int retval;
> -    V9fsString xname;
> -
> -    v9fs_string_init(&xname);
> -    v9fs_string_sprintf(&xname, "%s", name);
> -    retval = v9fs_request(ctx->private, T_LGETXATTR, value, size, fs_path,
> -                          &xname);
> -    v9fs_string_free(&xname);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static ssize_t proxy_llistxattr(FsContext *ctx, V9fsPath *fs_path,
> -                                void *value, size_t size)
> -{
> -    int retval;
> -    retval = v9fs_request(ctx->private, T_LLISTXATTR, value, size, fs_path);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const char *name,
> -                           void *value, size_t size, int flags)
> -{
> -    int retval;
> -    V9fsString xname, xvalue;
> -
> -    v9fs_string_init(&xname);
> -    v9fs_string_sprintf(&xname, "%s", name);
> -
> -    v9fs_string_init(&xvalue);
> -    xvalue.size = size;
> -    xvalue.data = g_malloc(size);
> -    memcpy(xvalue.data, value, size);
> -
> -    retval = v9fs_request(ctx->private, T_LSETXATTR, value, fs_path, &xname,
> -                          &xvalue, size, flags);
> -    v9fs_string_free(&xname);
> -    v9fs_string_free(&xvalue);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
> -                              const char *name)
> -{
> -    int retval;
> -    V9fsString xname;
> -
> -    v9fs_string_init(&xname);
> -    v9fs_string_sprintf(&xname, "%s", name);
> -    retval = v9fs_request(ctx->private, T_LREMOVEXATTR, NULL, fs_path, &xname);
> -    v9fs_string_free(&xname);
> -    if (retval < 0) {
> -        errno = -retval;
> -    }
> -    return retval;
> -}
> -
> -static int proxy_name_to_path(FsContext *ctx, V9fsPath *dir_path,
> -                              const char *name, V9fsPath *target)
> -{
> -    if (dir_path) {
> -        v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
> -    } else {
> -        v9fs_path_sprintf(target, "%s", name);
> -    }
> -    return 0;
> -}
> -
> -static int proxy_renameat(FsContext *ctx, V9fsPath *olddir,
> -                          const char *old_name, V9fsPath *newdir,
> -                          const char *new_name)
> -{
> -    int ret;
> -    V9fsString old_full_name, new_full_name;
> -
> -    v9fs_string_init(&old_full_name);
> -    v9fs_string_init(&new_full_name);
> -
> -    v9fs_string_sprintf(&old_full_name, "%s/%s", olddir->data, old_name);
> -    v9fs_string_sprintf(&new_full_name, "%s/%s", newdir->data, new_name);
> -
> -    ret = proxy_rename(ctx, old_full_name.data, new_full_name.data);
> -    v9fs_string_free(&old_full_name);
> -    v9fs_string_free(&new_full_name);
> -    return ret;
> -}
> -
> -static int proxy_unlinkat(FsContext *ctx, V9fsPath *dir,
> -                          const char *name, int flags)
> -{
> -    int ret;
> -    V9fsString fullname;
> -    v9fs_string_init(&fullname);
> -
> -    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
> -    ret = proxy_remove(ctx, fullname.data);
> -    v9fs_string_free(&fullname);
> -
> -    return ret;
> -}
> -
> -static int proxy_ioc_getversion(FsContext *fs_ctx, V9fsPath *path,
> -                                mode_t st_mode, uint64_t *st_gen)
> -{
> -    int err;
> -
> -    /* Do not try to open special files like device nodes, fifos etc
> -     * we can get fd for regular files and directories only
> -     */
> -    if (!S_ISREG(st_mode) && !S_ISDIR(st_mode)) {
> -        errno = ENOTTY;
> -        return -1;
> -    }
> -    err = v9fs_request(fs_ctx->private, T_GETVERSION, st_gen, path);
> -    if (err < 0) {
> -        errno = -err;
> -        err = -1;
> -    }
> -    return err;
> -}
> -
> -static int connect_namedsocket(const char *path, Error **errp)
> -{
> -    int sockfd;
> -    struct sockaddr_un helper;
> -
> -    if (strlen(path) >= sizeof(helper.sun_path)) {
> -        error_setg(errp, "socket name too long");
> -        return -1;
> -    }
> -    sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
> -    if (sockfd < 0) {
> -        error_setg_errno(errp, errno, "failed to create client socket");
> -        return -1;
> -    }
> -    strcpy(helper.sun_path, path);
> -    helper.sun_family = AF_UNIX;
> -    if (connect(sockfd, (struct sockaddr *)&helper, sizeof(helper)) < 0) {
> -        error_setg_errno(errp, errno, "failed to connect to '%s'", path);
> -        close(sockfd);
> -        return -1;
> -    }
> -
> -    /* remove the socket for security reasons */
> -    unlink(path);
> -    return sockfd;
> -}
> -
> -static void error_append_socket_sockfd_hint(Error *const *errp)
> -{
> -    error_append_hint(errp, "Either specify socket=/some/path where /some/path"
> -                      " points to a listening AF_UNIX socket or sock_fd=fd"
> -                      " where fd is a file descriptor to a connected AF_UNIX"
> -                      " socket\n");
> -}
> -
> -static int proxy_parse_opts(QemuOpts *opts, FsDriverEntry *fs, Error **errp)
> -{
> -    const char *socket = qemu_opt_get(opts, "socket");
> -    const char *sock_fd = qemu_opt_get(opts, "sock_fd");
> -
> -    if (!socket && !sock_fd) {
> -        error_setg(errp, "both socket and sock_fd properties are missing");
> -        error_append_socket_sockfd_hint(errp);
> -        return -1;
> -    }
> -    if (socket && sock_fd) {
> -        error_setg(errp, "both socket and sock_fd properties are set");
> -        error_append_socket_sockfd_hint(errp);
> -        return -1;
> -    }
> -    if (socket) {
> -        fs->path = g_strdup(socket);
> -        fs->export_flags |= V9FS_PROXY_SOCK_NAME;
> -    } else {
> -        fs->path = g_strdup(sock_fd);
> -        fs->export_flags |= V9FS_PROXY_SOCK_FD;
> -    }
> -    return 0;
> -}
> -
> -static int proxy_init(FsContext *ctx, Error **errp)
> -{
> -    V9fsProxy *proxy = g_new(V9fsProxy, 1);
> -    int sock_id;
> -
> -    if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
> -        sock_id = connect_namedsocket(ctx->fs_root, errp);
> -    } else {
> -        sock_id = atoi(ctx->fs_root);
> -        if (sock_id < 0) {
> -            error_setg(errp, "socket descriptor not initialized");
> -        }
> -    }
> -    if (sock_id < 0) {
> -        g_free(proxy);
> -        return -1;
> -    }
> -    g_free(ctx->fs_root);
> -    ctx->fs_root = NULL;
> -
> -    proxy->in_iovec.iov_base  = g_malloc(PROXY_MAX_IO_SZ + PROXY_HDR_SZ);
> -    proxy->in_iovec.iov_len   = PROXY_MAX_IO_SZ + PROXY_HDR_SZ;
> -    proxy->out_iovec.iov_base = g_malloc(PROXY_MAX_IO_SZ + PROXY_HDR_SZ);
> -    proxy->out_iovec.iov_len  = PROXY_MAX_IO_SZ + PROXY_HDR_SZ;
> -
> -    ctx->private = proxy;
> -    proxy->sockfd = sock_id;
> -    qemu_mutex_init(&proxy->mutex);
> -
> -    ctx->export_flags |= V9FS_PATHNAME_FSCONTEXT;
> -    ctx->exops.get_st_gen = proxy_ioc_getversion;
> -    return 0;
> -}
> -
> -static void proxy_cleanup(FsContext *ctx)
> -{
> -    V9fsProxy *proxy = ctx->private;
> -
> -    if (!proxy) {
> -        return;
> -    }
> -
> -    g_free(proxy->out_iovec.iov_base);
> -    g_free(proxy->in_iovec.iov_base);
> -    if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
> -        close(proxy->sockfd);
> -    }
> -    g_free(proxy);
> -}
> -
> -FileOperations proxy_ops = {
> -    .parse_opts   = proxy_parse_opts,
> -    .init         = proxy_init,
> -    .cleanup      = proxy_cleanup,
> -    .lstat        = proxy_lstat,
> -    .readlink     = proxy_readlink,
> -    .close        = proxy_close,
> -    .closedir     = proxy_closedir,
> -    .open         = proxy_open,
> -    .opendir      = proxy_opendir,
> -    .rewinddir    = proxy_rewinddir,
> -    .telldir      = proxy_telldir,
> -    .readdir      = proxy_readdir,
> -    .seekdir      = proxy_seekdir,
> -    .preadv       = proxy_preadv,
> -    .pwritev      = proxy_pwritev,
> -    .chmod        = proxy_chmod,
> -    .mknod        = proxy_mknod,
> -    .mkdir        = proxy_mkdir,
> -    .fstat        = proxy_fstat,
> -    .open2        = proxy_open2,
> -    .symlink      = proxy_symlink,
> -    .link         = proxy_link,
> -    .truncate     = proxy_truncate,
> -    .rename       = proxy_rename,
> -    .chown        = proxy_chown,
> -    .utimensat    = proxy_utimensat,
> -    .remove       = proxy_remove,
> -    .fsync        = proxy_fsync,
> -    .statfs       = proxy_statfs,
> -    .lgetxattr    = proxy_lgetxattr,
> -    .llistxattr   = proxy_llistxattr,
> -    .lsetxattr    = proxy_lsetxattr,
> -    .lremovexattr = proxy_lremovexattr,
> -    .name_to_path = proxy_name_to_path,
> -    .renameat     = proxy_renameat,
> -    .unlinkat     = proxy_unlinkat,
> -};
> diff --git a/fsdev/meson.build b/fsdev/meson.build
> index e20d7255e1e..c751d8cb622 100644
> --- a/fsdev/meson.build
> +++ b/fsdev/meson.build
> @@ -8,11 +8,3 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
>  if host_os in ['linux', 'darwin']
>    system_ss.add_all(fsdev_ss)
>  endif
> -
> -if have_virtfs_proxy_helper
> -  executable('virtfs-proxy-helper',
> -             files('virtfs-proxy-helper.c', '9p-marshal.c', '9p-iov-marshal.c'),
> -             dependencies: [qemuutil, libattr, libcap_ng],
> -             install: true,
> -             install_dir: get_option('libexecdir'))
> -endif
> diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> index f1b62fa8c80..eceffdb81ea 100644
> --- a/hw/9pfs/meson.build
> +++ b/hw/9pfs/meson.build
> @@ -2,7 +2,6 @@ fs_ss = ss.source_set()
>  fs_ss.add(files(
>    '9p-local.c',
>    '9p-posix-acl.c',
> -  '9p-proxy.c',
>    '9p-synth.c',
>    '9p-xattr-user.c',
>    '9p-xattr.c',
> diff --git a/meson_options.txt b/meson_options.txt
> index 0269fa0f16e..f65fead3161 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -301,8 +301,6 @@ option('vhost_user_blk_server', type: 'feature', value: 'auto',
>         description: 'build vhost-user-blk server')
>  option('virtfs', type: 'feature', value: 'auto',
>         description: 'virtio-9p support')
> -option('virtfs_proxy_helper', type: 'feature', value: 'auto',
> -       description: 'virtio-9p proxy helper support')
>  option('libvduse', type: 'feature', value: 'auto',
>         description: 'build VDUSE Library')
>  option('vduse_blk_export', type: 'feature', value: 'auto',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d94e2cbbaeb..20a1ce0d43b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1766,29 +1766,18 @@ DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
>      " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
>      " [[,throttling.iops-total-max=im]|[[,throttling.iops-read-max=irm][,throttling.iops-write-max=iwm]]]\n"
>      " [[,throttling.iops-size=is]]\n"
> -    "-fsdev proxy,id=id,socket=socket[,writeout=immediate][,readonly=on]\n"
> -    "-fsdev proxy,id=id,sock_fd=sock_fd[,writeout=immediate][,readonly=on]\n"
>      "-fsdev synth,id=id\n",
>      QEMU_ARCH_ALL)
>  
>  SRST
>  ``-fsdev local,id=id,path=path,security_model=security_model [,writeout=writeout][,readonly=on][,fmode=fmode][,dmode=dmode] [,throttling.option=value[,throttling.option=value[,...]]]``
>    \ 
> -``-fsdev proxy,id=id,socket=socket[,writeout=writeout][,readonly=on]``
> -  \
> -``-fsdev proxy,id=id,sock_fd=sock_fd[,writeout=writeout][,readonly=on]``
> -  \
>  ``-fsdev synth,id=id[,readonly=on]``
>      Define a new file system device. Valid options are:
>  
>      ``local``
>          Accesses to the filesystem are done by QEMU.
>  
> -    ``proxy``
> -        Accesses to the filesystem are done by virtfs-proxy-helper(1). This
> -        option is deprecated (since QEMU 8.1) and will be removed in a future
> -        version of QEMU. Use ``local`` instead.
> -
>      ``synth``
>          Synthetic filesystem, only used by QTests.
>  
> @@ -1813,8 +1802,6 @@ SRST
>          security model is same as passthrough except the sever won't
>          report failures if it fails to set file attributes like
>          ownership. Security model is mandatory only for local fsdriver.
> -        Other fsdrivers (like proxy) don't take security model as a
> -        parameter.
>  
>      ``writeout=writeout``
>          This is an optional argument. The only supported value is
> @@ -1827,16 +1814,6 @@ SRST
>          Enables exporting 9p share as a readonly mount for guests. By
>          default read-write access is given.
>  
> -    ``socket=socket``
> -        Enables proxy filesystem driver to use passed socket file for
> -        communicating with virtfs-proxy-helper(1).
> -
> -    ``sock_fd=sock_fd``
> -        Enables proxy filesystem driver to use passed socket descriptor
> -        for communicating with virtfs-proxy-helper(1). Usually a helper
> -        like libvirt will create socketpair and pass one of the fds as
> -        sock\_fd.
> -
>      ``fmode=fmode``
>          Specifies the default mode for newly created files on the host.
>          Works only with security models "mapped-xattr" and
> @@ -1889,18 +1866,12 @@ ERST
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>      "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
>      "        [,id=id][,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,multidevs=remap|forbid|warn]\n"
> -    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly=on]\n"
> -    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly=on]\n"
>      "-virtfs synth,mount_tag=tag[,id=id][,readonly=on]\n",
>      QEMU_ARCH_ALL)
>  
>  SRST
>  ``-virtfs local,path=path,mount_tag=mount_tag ,security_model=security_model[,writeout=writeout][,readonly=on] [,fmode=fmode][,dmode=dmode][,multidevs=multidevs]``
>    \ 
> -``-virtfs proxy,socket=socket,mount_tag=mount_tag [,writeout=writeout][,readonly=on]``
> -  \ 
> -``-virtfs proxy,sock_fd=sock_fd,mount_tag=mount_tag [,writeout=writeout][,readonly=on]``
> -  \
>  ``-virtfs synth,mount_tag=mount_tag``
>      Define a new virtual filesystem device and expose it to the guest using
>      a virtio-9p-device (a.k.a. 9pfs), which essentially means that a certain
> @@ -1917,11 +1888,6 @@ SRST
>      ``local``
>          Accesses to the filesystem are done by QEMU.
>  
> -    ``proxy``
> -        Accesses to the filesystem are done by virtfs-proxy-helper(1).
> -        This option is deprecated (since QEMU 8.1) and will be removed in a
> -        future version of QEMU. Use ``local`` instead.
> -
>      ``synth``
>          Synthetic filesystem, only used by QTests.
>  
> @@ -1946,8 +1912,6 @@ SRST
>          security model is same as passthrough except the sever won't
>          report failures if it fails to set file attributes like
>          ownership. Security model is mandatory only for local fsdriver.
> -        Other fsdrivers (like proxy) don't take security model as a
> -        parameter.
>  
>      ``writeout=writeout``
>          This is an optional argument. The only supported value is
> @@ -1960,16 +1924,6 @@ SRST
>          Enables exporting 9p share as a readonly mount for guests. By
>          default read-write access is given.
>  
> -    ``socket=socket``
> -        Enables proxy filesystem driver to use passed socket file for
> -        communicating with virtfs-proxy-helper(1). Usually a helper like
> -        libvirt will create socketpair and pass one of the fds as
> -        sock\_fd.
> -
> -    ``sock_fd``
> -        Enables proxy filesystem driver to use passed 'sock\_fd' as the
> -        socket descriptor for interfacing with virtfs-proxy-helper(1).
> -
>      ``fmode=fmode``
>          Specifies the default mode for newly created files on the host.
>          Works only with security models "mapped-xattr" and
> diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
> new file mode 100644
> index 00000000000..e69de29bb2d
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index c97079a38c9..19626b7b464 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -206,8 +206,6 @@ meson_options_help() {
>    printf "%s\n" '  vhost-vdpa      vhost-vdpa kernel backend support'
>    printf "%s\n" '  virglrenderer   virgl rendering support'
>    printf "%s\n" '  virtfs          virtio-9p support'
> -  printf "%s\n" '  virtfs-proxy-helper'
> -  printf "%s\n" '                  virtio-9p proxy helper support'
>    printf "%s\n" '  vmdk            vmdk image format support'
>    printf "%s\n" '  vmnet           vmnet.framework network backend support'
>    printf "%s\n" '  vnc             VNC server'
> @@ -533,8 +531,6 @@ _meson_option_parse() {
>      --disable-virglrenderer) printf "%s" -Dvirglrenderer=disabled ;;
>      --enable-virtfs) printf "%s" -Dvirtfs=enabled ;;
>      --disable-virtfs) printf "%s" -Dvirtfs=disabled ;;
> -    --enable-virtfs-proxy-helper) printf "%s" -Dvirtfs_proxy_helper=enabled ;;
> -    --disable-virtfs-proxy-helper) printf "%s" -Dvirtfs_proxy_helper=disabled ;;
>      --enable-vmdk) printf "%s" -Dvmdk=enabled ;;
>      --disable-vmdk) printf "%s" -Dvmdk=disabled ;;
>      --enable-vmnet) printf "%s" -Dvmnet=enabled ;;



-- 
Greg

