Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB19C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBfH-0006Hk-Fn; Fri, 12 Jul 2024 04:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBfF-0006H9-Uk
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBf7-0006Gh-5l
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720772990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsBR8omjVFEyMdE2QquvGZbdOlV2/upk/UjMLPrXh20=;
 b=MXQvEko/mYPXbs+/Yy306dEoXspI13DnAzXFhsf1UWn+h9rR8o1v1BPwCgXrMIMd8pHz6e
 tThOLPSRG9GxJTfU7UWZCOmDgsRgJLkFhFRcj11gE5nTJgA0W6BbJrUZH2s0FT4X2tnkAS
 hnUiCfzp7h9T3WKvLqTUAtRy7EVw6zE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675--5iJ28B5OfayRcXsTNeELg-1; Fri, 12 Jul 2024 04:29:43 -0400
X-MC-Unique: -5iJ28B5OfayRcXsTNeELg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-64f30b1f8ecso26894727b3.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720772983; x=1721377783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fsBR8omjVFEyMdE2QquvGZbdOlV2/upk/UjMLPrXh20=;
 b=BU7467V+X/tut3JYa3C/U2CypOTUsP7avhcbNKEuVZXaNM3GegQksn0xhQ6z/BlbOj
 XVYEQ3l+q/jwV5l0/WPCpN7h5E1RORNR0bjSdsNXdLSCfPqwdUO9y5sDNQw2D0hJGpVF
 Nsp/PCXJWmBFALzoHQKKz8eyYqvzJ2TKzPZw28+NsIEUSWbEjCcuuJzv11WZNBWUNHQD
 LG0GVVZa1oEHdl5MfGZRLqqueoRmrQTYXsOETRK/3xJ53K+5m7binEBe7W32OEc8vUSD
 ZbIw7ZQOWEKiDQk3pf7AmrZS3klAu1jqVTtZlriti+5Q3w2v0NewUeC/omHDW51kTQs9
 Likw==
X-Gm-Message-State: AOJu0Yx+JX2luY51BDtT/ITR8iqmeDBBCS7Mez/rJ0zGFKK9B3nreL7c
 rKp5whjeGgVrobN17tsaEBHPVBvgeyhqHTWw8iiXFNyxOvANGXW3UNinDaYqTvorM0xMwemxlKt
 Vm5mHiZVVkRGrh3HNppjYitTtbdBdKvGqI62yc0KL4z2CK5i2Zf1rcPaDELOBZr2A/kSEcu2ENa
 EhvryAuQ2zQXASLRnj4IlYtxjXs04=
X-Received: by 2002:a0d:c386:0:b0:64a:5ff5:73ef with SMTP id
 00721157ae682-658ebbb7f3bmr99749557b3.0.1720772983059; 
 Fri, 12 Jul 2024 01:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQa7WzB6QCY8uV7ZYDCrs9kv9FlWqW2A7WkGeOS+9IUVxyG6ph73SoDvBjoaVmw5brZp+UtqJ4s7OSxSRCiI=
X-Received: by 2002:a0d:c386:0:b0:64a:5ff5:73ef with SMTP id
 00721157ae682-658ebbb7f3bmr99749347b3.0.1720772982514; Fri, 12 Jul 2024
 01:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-5-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-5-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:29:31 +0300
Message-ID: <CAPMcbCqDXmfdecAEGBCMQ5q+74RfzNGqx5VEzcG00i+5qtBGwQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] qga: move linux fs/disk command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005cc8b2061d08ae38"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000005cc8b2061d08ae38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The qmp_guest_{fstrim, get_fsinfo, get_disks} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-linux.c | 904 ++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-posix.c | 909 -------------------------------------------
>  2 files changed, 904 insertions(+), 909 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 3fabf54882..084e6c9e85 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -14,10 +14,21 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qga-qapi-commands.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "commands-common.h"
>  #include "cutils.h"
>  #include <mntent.h>
>  #include <sys/ioctl.h>
> +#include <mntent.h>
> +#include <linux/nvme_ioctl.h>
> +#include "block/nvme.h"
> +
> +#ifdef CONFIG_LIBUDEV
> +#include <libudev.h>
> +#endif
> +
> +#include <sys/statvfs.h>
>
>  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
>  static int dev_major_minor(const char *devpath,
> @@ -286,6 +297,899 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>  }
>  #endif /* CONFIG_FSFREEZE */
>
> +#if defined(CONFIG_FSFREEZE)
> +
> +static char *get_pci_driver(char const *syspath, int pathlen, Error
> **errp)
> +{
> +    char *path;
> +    char *dpath;
> +    char *driver =3D NULL;
> +    char buf[PATH_MAX];
> +    ssize_t len;
> +
> +    path =3D g_strndup(syspath, pathlen);
> +    dpath =3D g_strdup_printf("%s/driver", path);
> +    len =3D readlink(dpath, buf, sizeof(buf) - 1);
> +    if (len !=3D -1) {
> +        buf[len] =3D 0;
> +        driver =3D g_path_get_basename(buf);
> +    }
> +    g_free(dpath);
> +    g_free(path);
> +    return driver;
> +}
> +
> +static int compare_uint(const void *_a, const void *_b)
> +{
> +    unsigned int a =3D *(unsigned int *)_a;
> +    unsigned int b =3D *(unsigned int *)_b;
> +
> +    return a < b ? -1 : a > b ? 1 : 0;
> +}
> +
> +/* Walk the specified sysfs and build a sorted list of host or ata
> numbers */
> +static int build_hosts(char const *syspath, char const *host, bool ata,
> +                       unsigned int *hosts, int hosts_max, Error **errp)
> +{
> +    char *path;
> +    DIR *dir;
> +    struct dirent *entry;
> +    int i =3D 0;
> +
> +    path =3D g_strndup(syspath, host - syspath);
> +    dir =3D opendir(path);
> +    if (!dir) {
> +        error_setg_errno(errp, errno, "opendir(\"%s\")", path);
> +        g_free(path);
> +        return -1;
> +    }
> +
> +    while (i < hosts_max) {
> +        entry =3D readdir(dir);
> +        if (!entry) {
> +            break;
> +        }
> +        if (ata && sscanf(entry->d_name, "ata%d", hosts + i) =3D=3D 1) {
> +            ++i;
> +        } else if (!ata && sscanf(entry->d_name, "host%d", hosts + i) =
=3D=3D
> 1) {
> +            ++i;
> +        }
> +    }
> +
> +    qsort(hosts, i, sizeof(hosts[0]), compare_uint);
> +
> +    g_free(path);
> +    closedir(dir);
> +    return i;
> +}
> +
> +/*
> + * Store disk device info for devices on the PCI bus.
> + * Returns true if information has been stored, or false for failure.
> + */
> +static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
> +                                           GuestDiskAddress *disk,
> +                                           Error **errp)
> +{
> +    unsigned int pci[4], host, hosts[8], tgt[3];
> +    int i, nhosts =3D 0, pcilen;
> +    GuestPCIAddress *pciaddr =3D disk->pci_controller;
> +    bool has_ata =3D false, has_host =3D false, has_tgt =3D false;
> +    char *p, *q, *driver =3D NULL;
> +    bool ret =3D false;
> +
> +    p =3D strstr(syspath, "/devices/pci");
> +    if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
> +                     pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
> +        g_debug("only pci device is supported: sysfs path '%s'", syspath=
);
> +        return false;
> +    }
> +
> +    p +=3D 12 + pcilen;
> +    while (true) {
> +        driver =3D get_pci_driver(syspath, p - syspath, errp);
> +        if (driver && (g_str_equal(driver, "ata_piix") ||
> +                       g_str_equal(driver, "sym53c8xx") ||
> +                       g_str_equal(driver, "virtio-pci") ||
> +                       g_str_equal(driver, "ahci") ||
> +                       g_str_equal(driver, "nvme") ||
> +                       g_str_equal(driver, "xhci_hcd") ||
> +                       g_str_equal(driver, "ehci-pci"))) {
> +            break;
> +        }
> +
> +        g_free(driver);
> +        if (sscanf(p, "/%x:%x:%x.%x%n",
> +                          pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=
=3D 4) {
> +            p +=3D pcilen;
> +            continue;
> +        }
> +
> +        g_debug("unsupported driver or sysfs path '%s'", syspath);
> +        return false;
> +    }
> +
> +    p =3D strstr(syspath, "/target");
> +    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
> +                    tgt, tgt + 1, tgt + 2) =3D=3D 3) {
> +        has_tgt =3D true;
> +    }
> +
> +    p =3D strstr(syspath, "/ata");
> +    if (p) {
> +        q =3D p + 4;
> +        has_ata =3D true;
> +    } else {
> +        p =3D strstr(syspath, "/host");
> +        q =3D p + 5;
> +    }
> +    if (p && sscanf(q, "%u", &host) =3D=3D 1) {
> +        has_host =3D true;
> +        nhosts =3D build_hosts(syspath, p, has_ata, hosts,
> +                             ARRAY_SIZE(hosts), errp);
> +        if (nhosts < 0) {
> +            goto cleanup;
> +        }
> +    }
> +
> +    pciaddr->domain =3D pci[0];
> +    pciaddr->bus =3D pci[1];
> +    pciaddr->slot =3D pci[2];
> +    pciaddr->function =3D pci[3];
> +
> +    if (strcmp(driver, "ata_piix") =3D=3D 0) {
> +        /* a host per ide bus, target*:0:<unit>:0 */
> +        if (!has_host || !has_tgt) {
> +            g_debug("invalid sysfs path '%s' (driver '%s')", syspath,
> driver);
> +            goto cleanup;
> +        }
> +        for (i =3D 0; i < nhosts; i++) {
> +            if (host =3D=3D hosts[i]) {
> +                disk->bus_type =3D GUEST_DISK_BUS_TYPE_IDE;
> +                disk->bus =3D i;
> +                disk->unit =3D tgt[1];
> +                break;
> +            }
> +        }
> +        if (i >=3D nhosts) {
> +            g_debug("no host for '%s' (driver '%s')", syspath, driver);
> +            goto cleanup;
> +        }
> +    } else if (strcmp(driver, "sym53c8xx") =3D=3D 0) {
> +        /* scsi(LSI Logic): target*:0:<unit>:0 */
> +        if (!has_tgt) {
> +            g_debug("invalid sysfs path '%s' (driver '%s')", syspath,
> driver);
> +            goto cleanup;
> +        }
> +        disk->bus_type =3D GUEST_DISK_BUS_TYPE_SCSI;
> +        disk->unit =3D tgt[1];
> +    } else if (strcmp(driver, "virtio-pci") =3D=3D 0) {
> +        if (has_tgt) {
> +            /* virtio-scsi: target*:0:0:<unit> */
> +            disk->bus_type =3D GUEST_DISK_BUS_TYPE_SCSI;
> +            disk->unit =3D tgt[2];
> +        } else {
> +            /* virtio-blk: 1 disk per 1 device */
> +            disk->bus_type =3D GUEST_DISK_BUS_TYPE_VIRTIO;
> +        }
> +    } else if (strcmp(driver, "ahci") =3D=3D 0) {
> +        /* ahci: 1 host per 1 unit */
> +        if (!has_host || !has_tgt) {
> +            g_debug("invalid sysfs path '%s' (driver '%s')", syspath,
> driver);
> +            goto cleanup;
> +        }
> +        for (i =3D 0; i < nhosts; i++) {
> +            if (host =3D=3D hosts[i]) {
> +                disk->unit =3D i;
> +                disk->bus_type =3D GUEST_DISK_BUS_TYPE_SATA;
> +                break;
> +            }
> +        }
> +        if (i >=3D nhosts) {
> +            g_debug("no host for '%s' (driver '%s')", syspath, driver);
> +            goto cleanup;
> +        }
> +    } else if (strcmp(driver, "nvme") =3D=3D 0) {
> +        disk->bus_type =3D GUEST_DISK_BUS_TYPE_NVME;
> +    } else if (strcmp(driver, "ehci-pci") =3D=3D 0 || strcmp(driver,
> "xhci_hcd") =3D=3D 0) {
> +        disk->bus_type =3D GUEST_DISK_BUS_TYPE_USB;
> +    } else {
> +        g_debug("unknown driver '%s' (sysfs path '%s')", driver, syspath=
);
> +        goto cleanup;
> +    }
> +
> +    ret =3D true;
> +
> +cleanup:
> +    g_free(driver);
> +    return ret;
> +}
> +
> +/*
> + * Store disk device info for non-PCI virtio devices (for example s390x
> + * channel I/O devices). Returns true if information has been stored, or
> + * false for failure.
> + */
> +static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
> +                                                 GuestDiskAddress *disk,
> +                                                 Error **errp)
> +{
> +    unsigned int tgt[3];
> +    char *p;
> +
> +    if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
> +        g_debug("Unsupported virtio device '%s'", syspath);
> +        return false;
> +    }
> +
> +    p =3D strstr(syspath, "/target");
> +    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
> +                    &tgt[0], &tgt[1], &tgt[2]) =3D=3D 3) {
> +        /* virtio-scsi: target*:0:<target>:<unit> */
> +        disk->bus_type =3D GUEST_DISK_BUS_TYPE_SCSI;
> +        disk->bus =3D tgt[0];
> +        disk->target =3D tgt[1];
> +        disk->unit =3D tgt[2];
> +    } else {
> +        /* virtio-blk: 1 disk per 1 device */
> +        disk->bus_type =3D GUEST_DISK_BUS_TYPE_VIRTIO;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Store disk device info for CCW devices (s390x channel I/O devices).
> + * Returns true if information has been stored, or false for failure.
> + */
> +static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,
> +                                           GuestDiskAddress *disk,
> +                                           Error **errp)
> +{
> +    unsigned int cssid, ssid, subchno, devno;
> +    char *p;
> +
> +    p =3D strstr(syspath, "/devices/css");
> +    if (!p || sscanf(p + 12, "%*x/%x.%x.%x/%*x.%*x.%x/",
> +                     &cssid, &ssid, &subchno, &devno) < 4) {
> +        g_debug("could not parse ccw device sysfs path: %s", syspath);
> +        return false;
> +    }
> +
> +    disk->ccw_address =3D g_new0(GuestCCWAddress, 1);
> +    disk->ccw_address->cssid =3D cssid;
> +    disk->ccw_address->ssid =3D ssid;
> +    disk->ccw_address->subchno =3D subchno;
> +    disk->ccw_address->devno =3D devno;
> +
> +    if (strstr(p, "/virtio")) {
> +        build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
> +    }
> +
> +    return true;
> +}
> +
> +/* Store disk device info specified by @sysfs into @fs */
> +static void build_guest_fsinfo_for_real_device(char const *syspath,
> +                                               GuestFilesystemInfo *fs,
> +                                               Error **errp)
> +{
> +    GuestDiskAddress *disk;
> +    GuestPCIAddress *pciaddr;
> +    bool has_hwinf;
> +#ifdef CONFIG_LIBUDEV
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +#endif
> +
> +    pciaddr =3D g_new0(GuestPCIAddress, 1);
> +    pciaddr->domain =3D -1;                       /* -1 means field is
> invalid */
> +    pciaddr->bus =3D -1;
> +    pciaddr->slot =3D -1;
> +    pciaddr->function =3D -1;
> +
> +    disk =3D g_new0(GuestDiskAddress, 1);
> +    disk->pci_controller =3D pciaddr;
> +    disk->bus_type =3D GUEST_DISK_BUS_TYPE_UNKNOWN;
> +
> +#ifdef CONFIG_LIBUDEV
> +    udev =3D udev_new();
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udev =3D=3D NULL || udevice =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +    } else {
> +        const char *devnode, *serial;
> +        devnode =3D udev_device_get_devnode(udevice);
> +        if (devnode !=3D NULL) {
> +            disk->dev =3D g_strdup(devnode);
> +        }
> +        serial =3D udev_device_get_property_value(udevice, "ID_SERIAL");
> +        if (serial !=3D NULL && *serial !=3D 0) {
> +            disk->serial =3D g_strdup(serial);
> +        }
> +    }
> +
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +#endif
> +
> +    if (strstr(syspath, "/devices/pci")) {
> +        has_hwinf =3D build_guest_fsinfo_for_pci_dev(syspath, disk, errp=
);
> +    } else if (strstr(syspath, "/devices/css")) {
> +        has_hwinf =3D build_guest_fsinfo_for_ccw_dev(syspath, disk, errp=
);
> +    } else if (strstr(syspath, "/virtio")) {
> +        has_hwinf =3D build_guest_fsinfo_for_nonpci_virtio(syspath, disk=
,
> errp);
> +    } else {
> +        g_debug("Unsupported device type for '%s'", syspath);
> +        has_hwinf =3D false;
> +    }
> +
> +    if (has_hwinf || disk->dev || disk->serial) {
> +        QAPI_LIST_PREPEND(fs->disk, disk);
> +    } else {
> +        qapi_free_GuestDiskAddress(disk);
> +    }
> +}
> +
> +static void build_guest_fsinfo_for_device(char const *devpath,
> +                                          GuestFilesystemInfo *fs,
> +                                          Error **errp);
> +
> +/* Store a list of slave devices of virtual volume specified by @syspath
> into
> + * @fs */
> +static void build_guest_fsinfo_for_virtual_device(char const *syspath,
> +                                                  GuestFilesystemInfo *f=
s,
> +                                                  Error **errp)
> +{
> +    Error *err =3D NULL;
> +    DIR *dir;
> +    char *dirpath;
> +    struct dirent *entry;
> +
> +    dirpath =3D g_strdup_printf("%s/slaves", syspath);
> +    dir =3D opendir(dirpath);
> +    if (!dir) {
> +        if (errno !=3D ENOENT) {
> +            error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
> +        }
> +        g_free(dirpath);
> +        return;
> +    }
> +
> +    for (;;) {
> +        errno =3D 0;
> +        entry =3D readdir(dir);
> +        if (entry =3D=3D NULL) {
> +            if (errno) {
> +                error_setg_errno(errp, errno, "readdir(\"%s\")", dirpath=
);
> +            }
> +            break;
> +        }
> +
> +        if (entry->d_type =3D=3D DT_LNK) {
> +            char *path;
> +
> +            g_debug(" slave device '%s'", entry->d_name);
> +            path =3D g_strdup_printf("%s/slaves/%s", syspath,
> entry->d_name);
> +            build_guest_fsinfo_for_device(path, fs, &err);
> +            g_free(path);
> +
> +            if (err) {
> +                error_propagate(errp, err);
> +                break;
> +            }
> +        }
> +    }
> +
> +    g_free(dirpath);
> +    closedir(dir);
> +}
> +
> +static bool is_disk_virtual(const char *devpath, Error **errp)
> +{
> +    g_autofree char *syspath =3D realpath(devpath, NULL);
> +
> +    if (!syspath) {
> +        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> +        return false;
> +    }
> +    return strstr(syspath, "/devices/virtual/block/") !=3D NULL;
> +}
> +
> +/* Dispatch to functions for virtual/real device */
> +static void build_guest_fsinfo_for_device(char const *devpath,
> +                                          GuestFilesystemInfo *fs,
> +                                          Error **errp)
> +{
> +    ERRP_GUARD();
> +    g_autofree char *syspath =3D NULL;
> +    bool is_virtual =3D false;
> +
> +    syspath =3D realpath(devpath, NULL);
> +    if (!syspath) {
> +        if (errno !=3D ENOENT) {
> +            error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> +            return;
> +        }
> +
> +        /* ENOENT: This devpath may not exist because of container confi=
g
> */
> +        if (!fs->name) {
> +            fs->name =3D g_path_get_basename(devpath);
> +        }
> +        return;
> +    }
> +
> +    if (!fs->name) {
> +        fs->name =3D g_path_get_basename(syspath);
> +    }
> +
> +    g_debug("  parse sysfs path '%s'", syspath);
> +    is_virtual =3D is_disk_virtual(syspath, errp);
> +    if (*errp !=3D NULL) {
> +        return;
> +    }
> +    if (is_virtual) {
> +        build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
> +    } else {
> +        build_guest_fsinfo_for_real_device(syspath, fs, errp);
> +    }
> +}
> +
> +#ifdef CONFIG_LIBUDEV
> +
> +/*
> + * Wrapper around build_guest_fsinfo_for_device() for getting just
> + * the disk address.
> + */
> +static GuestDiskAddress *get_disk_address(const char *syspath, Error
> **errp)
> +{
> +    g_autoptr(GuestFilesystemInfo) fs =3D NULL;
> +
> +    fs =3D g_new0(GuestFilesystemInfo, 1);
> +    build_guest_fsinfo_for_device(syspath, fs, errp);
> +    if (fs->disk !=3D NULL) {
> +        return g_steal_pointer(&fs->disk->value);
> +    }
> +    return NULL;
> +}
> +
> +static char *get_alias_for_syspath(const char *syspath)
> +{
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +    char *ret =3D NULL;
> +
> +    udev =3D udev_new();
> +    if (udev =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +        goto out;
> +    }
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udevice =3D=3D NULL) {
> +        g_debug("failed to query udev for path: %s", syspath);
> +        goto out;
> +    } else {
> +        const char *alias =3D udev_device_get_property_value(
> +            udevice, "DM_NAME");
> +        /*
> +         * NULL means there was an error and empty string means there is
> no
> +         * alias. In case of no alias we return NULL instead of empty
> string.
> +         */
> +        if (alias =3D=3D NULL) {
> +            g_debug("failed to query udev for device alias for: %s",
> +                syspath);
> +        } else if (*alias !=3D 0) {
> +            ret =3D g_strdup(alias);
> +        }
> +    }
> +
> +out:
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +    return ret;
> +}
> +
> +static char *get_device_for_syspath(const char *syspath)
> +{
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +    char *ret =3D NULL;
> +
> +    udev =3D udev_new();
> +    if (udev =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +        goto out;
> +    }
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udevice =3D=3D NULL) {
> +        g_debug("failed to query udev for path: %s", syspath);
> +        goto out;
> +    } else {
> +        ret =3D g_strdup(udev_device_get_devnode(udevice));
> +    }
> +
> +out:
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +    return ret;
> +}
> +
> +static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
> +{
> +    g_autofree char *deps_dir =3D NULL;
> +    const gchar *dep;
> +    GDir *dp_deps =3D NULL;
> +
> +    /* List dependent disks */
> +    deps_dir =3D g_strdup_printf("%s/slaves", disk_dir);
> +    g_debug("  listing entries in: %s", deps_dir);
> +    dp_deps =3D g_dir_open(deps_dir, 0, NULL);
> +    if (dp_deps =3D=3D NULL) {
> +        g_debug("failed to list entries in %s", deps_dir);
> +        return;
> +    }
> +    disk->has_dependencies =3D true;
> +    while ((dep =3D g_dir_read_name(dp_deps)) !=3D NULL) {
> +        g_autofree char *dep_dir =3D NULL;
> +        char *dev_name;
> +
> +        /* Add dependent disks */
> +        dep_dir =3D g_strdup_printf("%s/%s", deps_dir, dep);
> +        dev_name =3D get_device_for_syspath(dep_dir);
> +        if (dev_name !=3D NULL) {
> +            g_debug("  adding dependent device: %s", dev_name);
> +            QAPI_LIST_PREPEND(disk->dependencies, dev_name);
> +        }
> +    }
> +    g_dir_close(dp_deps);
> +}
> +
> +/*
> + * Detect partitions subdirectory, name is "<disk_name><number>" or
> + * "<disk_name>p<number>"
> + *
> + * @disk_name -- last component of /sys path (e.g. sda)
> + * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
> + * @disk_dev -- device node of the disk (e.g. /dev/sda)
> + */
> +static GuestDiskInfoList *get_disk_partitions(
> +    GuestDiskInfoList *list,
> +    const char *disk_name, const char *disk_dir,
> +    const char *disk_dev)
> +{
> +    GuestDiskInfoList *ret =3D list;
> +    struct dirent *de_disk;
> +    DIR *dp_disk =3D NULL;
> +    size_t len =3D strlen(disk_name);
> +
> +    dp_disk =3D opendir(disk_dir);
> +    while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {
> +        g_autofree char *partition_dir =3D NULL;
> +        char *dev_name;
> +        GuestDiskInfo *partition;
> +
> +        if (!(de_disk->d_type & DT_DIR)) {
> +            continue;
> +        }
> +
> +        if (!(strncmp(disk_name, de_disk->d_name, len) =3D=3D 0 &&
> +            ((*(de_disk->d_name + len) =3D=3D 'p' &&
> +            isdigit(*(de_disk->d_name + len + 1))) ||
> +                isdigit(*(de_disk->d_name + len))))) {
> +            continue;
> +        }
> +
> +        partition_dir =3D g_strdup_printf("%s/%s",
> +            disk_dir, de_disk->d_name);
> +        dev_name =3D get_device_for_syspath(partition_dir);
> +        if (dev_name =3D=3D NULL) {
> +            g_debug("Failed to get device name for syspath: %s",
> +                disk_dir);
> +            continue;
> +        }
> +        partition =3D g_new0(GuestDiskInfo, 1);
> +        partition->name =3D dev_name;
> +        partition->partition =3D true;
> +        partition->has_dependencies =3D true;
> +        /* Add parent disk as dependent for easier tracking of hierarchy
> */
> +        QAPI_LIST_PREPEND(partition->dependencies, g_strdup(disk_dev));
> +
> +        QAPI_LIST_PREPEND(ret, partition);
> +    }
> +    closedir(dp_disk);
> +
> +    return ret;
> +}
> +
> +static void get_nvme_smart(GuestDiskInfo *disk)
> +{
> +    int fd;
> +    GuestNVMeSmart *smart;
> +    NvmeSmartLog log =3D {0};
> +    struct nvme_admin_cmd cmd =3D {
> +        .opcode =3D NVME_ADM_CMD_GET_LOG_PAGE,
> +        .nsid =3D NVME_NSID_BROADCAST,
> +        .addr =3D (uintptr_t)&log,
> +        .data_len =3D sizeof(log),
> +        .cdw10 =3D NVME_LOG_SMART_INFO | (1 << 15) /* RAE bit */
> +                 | (((sizeof(log) >> 2) - 1) << 16)
> +    };
> +
> +    fd =3D qga_open_cloexec(disk->name, O_RDONLY, 0);
> +    if (fd =3D=3D -1) {
> +        g_debug("Failed to open device: %s: %s", disk->name,
> g_strerror(errno));
> +        return;
> +    }
> +
> +    if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd)) {
> +        g_debug("Failed to get smart: %s: %s", disk->name,
> g_strerror(errno));
> +        close(fd);
> +        return;
> +    }
> +
> +    disk->smart =3D g_new0(GuestDiskSmart, 1);
> +    disk->smart->type =3D GUEST_DISK_BUS_TYPE_NVME;
> +
> +    smart =3D &disk->smart->u.nvme;
> +    smart->critical_warning =3D log.critical_warning;
> +    smart->temperature =3D lduw_le_p(&log.temperature); /* unaligned fie=
ld
> */
> +    smart->available_spare =3D log.available_spare;
> +    smart->available_spare_threshold =3D log.available_spare_threshold;
> +    smart->percentage_used =3D log.percentage_used;
> +    smart->data_units_read_lo =3D le64_to_cpu(log.data_units_read[0]);
> +    smart->data_units_read_hi =3D le64_to_cpu(log.data_units_read[1]);
> +    smart->data_units_written_lo =3D le64_to_cpu(log.data_units_written[=
0]);
> +    smart->data_units_written_hi =3D le64_to_cpu(log.data_units_written[=
1]);
> +    smart->host_read_commands_lo =3D le64_to_cpu(log.host_read_commands[=
0]);
> +    smart->host_read_commands_hi =3D le64_to_cpu(log.host_read_commands[=
1]);
> +    smart->host_write_commands_lo =3D
> le64_to_cpu(log.host_write_commands[0]);
> +    smart->host_write_commands_hi =3D
> le64_to_cpu(log.host_write_commands[1]);
> +    smart->controller_busy_time_lo =3D
> le64_to_cpu(log.controller_busy_time[0]);
> +    smart->controller_busy_time_hi =3D
> le64_to_cpu(log.controller_busy_time[1]);
> +    smart->power_cycles_lo =3D le64_to_cpu(log.power_cycles[0]);
> +    smart->power_cycles_hi =3D le64_to_cpu(log.power_cycles[1]);
> +    smart->power_on_hours_lo =3D le64_to_cpu(log.power_on_hours[0]);
> +    smart->power_on_hours_hi =3D le64_to_cpu(log.power_on_hours[1]);
> +    smart->unsafe_shutdowns_lo =3D le64_to_cpu(log.unsafe_shutdowns[0]);
> +    smart->unsafe_shutdowns_hi =3D le64_to_cpu(log.unsafe_shutdowns[1]);
> +    smart->media_errors_lo =3D le64_to_cpu(log.media_errors[0]);
> +    smart->media_errors_hi =3D le64_to_cpu(log.media_errors[1]);
> +    smart->number_of_error_log_entries_lo =3D
> +        le64_to_cpu(log.number_of_error_log_entries[0]);
> +    smart->number_of_error_log_entries_hi =3D
> +        le64_to_cpu(log.number_of_error_log_entries[1]);
> +
> +    close(fd);
> +}
> +
> +static void get_disk_smart(GuestDiskInfo *disk)
> +{
> +    if (disk->address
> +        && (disk->address->bus_type =3D=3D GUEST_DISK_BUS_TYPE_NVME)) {
> +        get_nvme_smart(disk);
> +    }
> +}
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskInfoList *ret =3D NULL;
> +    GuestDiskInfo *disk;
> +    DIR *dp =3D NULL;
> +    struct dirent *de =3D NULL;
> +
> +    g_debug("listing /sys/block directory");
> +    dp =3D opendir("/sys/block");
> +    if (dp =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "Can't open directory
> \"/sys/block\"");
> +        return NULL;
> +    }
> +    while ((de =3D readdir(dp)) !=3D NULL) {
> +        g_autofree char *disk_dir =3D NULL, *line =3D NULL,
> +            *size_path =3D NULL;
> +        char *dev_name;
> +        Error *local_err =3D NULL;
> +        if (de->d_type !=3D DT_LNK) {
> +            g_debug("  skipping entry: %s", de->d_name);
> +            continue;
> +        }
> +
> +        /* Check size and skip zero-sized disks */
> +        g_debug("  checking disk size");
> +        size_path =3D g_strdup_printf("/sys/block/%s/size", de->d_name);
> +        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
> +            g_debug("  failed to read disk size");
> +            continue;
> +        }
> +        if (g_strcmp0(line, "0\n") =3D=3D 0) {
> +            g_debug("  skipping zero-sized disk");
> +            continue;
> +        }
> +
> +        g_debug("  adding %s", de->d_name);
> +        disk_dir =3D g_strdup_printf("/sys/block/%s", de->d_name);
> +        dev_name =3D get_device_for_syspath(disk_dir);
> +        if (dev_name =3D=3D NULL) {
> +            g_debug("Failed to get device name for syspath: %s",
> +                disk_dir);
> +            continue;
> +        }
> +        disk =3D g_new0(GuestDiskInfo, 1);
> +        disk->name =3D dev_name;
> +        disk->partition =3D false;
> +        disk->alias =3D get_alias_for_syspath(disk_dir);
> +        QAPI_LIST_PREPEND(ret, disk);
> +
> +        /* Get address for non-virtual devices */
> +        bool is_virtual =3D is_disk_virtual(disk_dir, &local_err);
> +        if (local_err !=3D NULL) {
> +            g_debug("  failed to check disk path, ignoring error: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            local_err =3D NULL;
> +            /* Don't try to get the address */
> +            is_virtual =3D true;
> +        }
> +        if (!is_virtual) {
> +            disk->address =3D get_disk_address(disk_dir, &local_err);
> +            if (local_err !=3D NULL) {
> +                g_debug("  failed to get device info, ignoring error: %s=
",
> +                    error_get_pretty(local_err));
> +                error_free(local_err);
> +                local_err =3D NULL;
> +            }
> +        }
> +
> +        get_disk_deps(disk_dir, disk);
> +        get_disk_smart(disk);
> +        ret =3D get_disk_partitions(ret, de->d_name, disk_dir, dev_name)=
;
> +    }
> +
> +    closedir(dp);
> +
> +    return ret;
> +}
> +
> +#else
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
> +#endif
> +
> +/* Return a list of the disk device(s)' info which @mount lies on */
> +static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
> +                                               Error **errp)
> +{
> +    GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
> +    struct statvfs buf;
> +    unsigned long used, nonroot_total, fr_size;
> +    char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
> +                                    mount->devmajor, mount->devminor);
> +
> +    fs->mountpoint =3D g_strdup(mount->dirname);
> +    fs->type =3D g_strdup(mount->devtype);
> +    build_guest_fsinfo_for_device(devpath, fs, errp);
> +
> +    if (statvfs(fs->mountpoint, &buf) =3D=3D 0) {
> +        fr_size =3D buf.f_frsize;
> +        used =3D buf.f_blocks - buf.f_bfree;
> +        nonroot_total =3D used + buf.f_bavail;
> +        fs->used_bytes =3D used * fr_size;
> +        fs->total_bytes =3D nonroot_total * fr_size;
> +        fs->total_bytes_privileged =3D buf.f_blocks * fr_size;
> +
> +        fs->has_total_bytes =3D true;
> +        fs->has_total_bytes_privileged =3D true;
> +        fs->has_used_bytes =3D true;
> +    }
> +
> +    g_free(devpath);
> +
> +    return fs;
> +}
> +
> +GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> +{
> +    FsMountList mounts;
> +    struct FsMount *mount;
> +    GuestFilesystemInfoList *ret =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    QTAILQ_INIT(&mounts);
> +    if (!build_fs_mount_list(&mounts, &local_err)) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    QTAILQ_FOREACH(mount, &mounts, next) {
> +        g_debug("Building guest fsinfo for '%s'", mount->dirname);
> +
> +        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            qapi_free_GuestFilesystemInfoList(ret);
> +            ret =3D NULL;
> +            break;
> +        }
> +    }
> +
> +    free_fs_mount_list(&mounts);
> +    return ret;
> +}
> +#endif /* CONFIG_FSFREEZE */
> +
> +#if defined(CONFIG_FSTRIM)
> +/*
> + * Walk list of mounted file systems in the guest, and trim them.
> + */
> +GuestFilesystemTrimResponse *
> +qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
> +{
> +    GuestFilesystemTrimResponse *response;
> +    GuestFilesystemTrimResult *result;
> +    int ret =3D 0;
> +    FsMountList mounts;
> +    struct FsMount *mount;
> +    int fd;
> +    struct fstrim_range r;
> +
> +    slog("guest-fstrim called");
> +
> +    QTAILQ_INIT(&mounts);
> +    if (!build_fs_mount_list(&mounts, errp)) {
> +        return NULL;
> +    }
> +
> +    response =3D g_malloc0(sizeof(*response));
> +
> +    QTAILQ_FOREACH(mount, &mounts, next) {
> +        result =3D g_malloc0(sizeof(*result));
> +        result->path =3D g_strdup(mount->dirname);
> +
> +        QAPI_LIST_PREPEND(response->paths, result);
> +
> +        fd =3D qga_open_cloexec(mount->dirname, O_RDONLY, 0);
> +        if (fd =3D=3D -1) {
> +            result->error =3D g_strdup_printf("failed to open: %s",
> +                                            strerror(errno));
> +            continue;
> +        }
> +
> +        /* We try to cull filesystems we know won't work in advance, but
> other
> +         * filesystems may not implement fstrim for less obvious reasons=
.
> +         * These will report EOPNOTSUPP; while in some other cases ENOTT=
Y
> +         * will be reported (e.g. CD-ROMs).
> +         * Any other error means an unexpected error.
> +         */
> +        r.start =3D 0;
> +        r.len =3D -1;
> +        r.minlen =3D has_minimum ? minimum : 0;
> +        ret =3D ioctl(fd, FITRIM, &r);
> +        if (ret =3D=3D -1) {
> +            if (errno =3D=3D ENOTTY || errno =3D=3D EOPNOTSUPP) {
> +                result->error =3D g_strdup("trim not supported");
> +            } else {
> +                result->error =3D g_strdup_printf("failed to trim: %s",
> +                                                strerror(errno));
> +            }
> +            close(fd);
> +            continue;
> +        }
> +
> +        result->has_minimum =3D true;
> +        result->minimum =3D r.minlen;
> +        result->has_trimmed =3D true;
> +        result->trimmed =3D r.len;
> +        close(fd);
> +    }
> +
> +    free_fs_mount_list(&mounts);
> +    return response;
> +}
> +#endif /* CONFIG_FSTRIM */
>
>  #define LINUX_SYS_STATE_FILE "/sys/power/state"
>  #define SUSPEND_SUPPORTED 0
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index ef21da63be..98aafc45f3 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -24,23 +24,12 @@
>  #include "qemu/base64.h"
>  #include "qemu/cutils.h"
>  #include "commands-common.h"
> -#include "block/nvme.h"
>  #include "cutils.h"
>
>  #ifdef HAVE_UTMPX
>  #include <utmpx.h>
>  #endif
>
> -#if defined(__linux__)
> -#include <mntent.h>
> -#include <sys/statvfs.h>
> -#include <linux/nvme_ioctl.h>
> -
> -#ifdef CONFIG_LIBUDEV
> -#include <libudev.h>
> -#endif
> -#endif
> -
>  #ifdef HAVE_GETIFADDRS
>  #include <arpa/inet.h>
>  #include <sys/socket.h>
> @@ -842,904 +831,6 @@ static void guest_fsfreeze_cleanup(void)
>  }
>  #endif
>
> -/* linux-specific implementations. avoid this if at all possible. */
> -#if defined(__linux__)
> -#if defined(CONFIG_FSFREEZE)
> -
> -static char *get_pci_driver(char const *syspath, int pathlen, Error
> **errp)
> -{
> -    char *path;
> -    char *dpath;
> -    char *driver =3D NULL;
> -    char buf[PATH_MAX];
> -    ssize_t len;
> -
> -    path =3D g_strndup(syspath, pathlen);
> -    dpath =3D g_strdup_printf("%s/driver", path);
> -    len =3D readlink(dpath, buf, sizeof(buf) - 1);
> -    if (len !=3D -1) {
> -        buf[len] =3D 0;
> -        driver =3D g_path_get_basename(buf);
> -    }
> -    g_free(dpath);
> -    g_free(path);
> -    return driver;
> -}
> -
> -static int compare_uint(const void *_a, const void *_b)
> -{
> -    unsigned int a =3D *(unsigned int *)_a;
> -    unsigned int b =3D *(unsigned int *)_b;
> -
> -    return a < b ? -1 : a > b ? 1 : 0;
> -}
> -
> -/* Walk the specified sysfs and build a sorted list of host or ata
> numbers */
> -static int build_hosts(char const *syspath, char const *host, bool ata,
> -                       unsigned int *hosts, int hosts_max, Error **errp)
> -{
> -    char *path;
> -    DIR *dir;
> -    struct dirent *entry;
> -    int i =3D 0;
> -
> -    path =3D g_strndup(syspath, host - syspath);
> -    dir =3D opendir(path);
> -    if (!dir) {
> -        error_setg_errno(errp, errno, "opendir(\"%s\")", path);
> -        g_free(path);
> -        return -1;
> -    }
> -
> -    while (i < hosts_max) {
> -        entry =3D readdir(dir);
> -        if (!entry) {
> -            break;
> -        }
> -        if (ata && sscanf(entry->d_name, "ata%d", hosts + i) =3D=3D 1) {
> -            ++i;
> -        } else if (!ata && sscanf(entry->d_name, "host%d", hosts + i) =
=3D=3D
> 1) {
> -            ++i;
> -        }
> -    }
> -
> -    qsort(hosts, i, sizeof(hosts[0]), compare_uint);
> -
> -    g_free(path);
> -    closedir(dir);
> -    return i;
> -}
> -
> -/*
> - * Store disk device info for devices on the PCI bus.
> - * Returns true if information has been stored, or false for failure.
> - */
> -static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
> -                                           GuestDiskAddress *disk,
> -                                           Error **errp)
> -{
> -    unsigned int pci[4], host, hosts[8], tgt[3];
> -    int i, nhosts =3D 0, pcilen;
> -    GuestPCIAddress *pciaddr =3D disk->pci_controller;
> -    bool has_ata =3D false, has_host =3D false, has_tgt =3D false;
> -    char *p, *q, *driver =3D NULL;
> -    bool ret =3D false;
> -
> -    p =3D strstr(syspath, "/devices/pci");
> -    if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
> -                     pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
> -        g_debug("only pci device is supported: sysfs path '%s'", syspath=
);
> -        return false;
> -    }
> -
> -    p +=3D 12 + pcilen;
> -    while (true) {
> -        driver =3D get_pci_driver(syspath, p - syspath, errp);
> -        if (driver && (g_str_equal(driver, "ata_piix") ||
> -                       g_str_equal(driver, "sym53c8xx") ||
> -                       g_str_equal(driver, "virtio-pci") ||
> -                       g_str_equal(driver, "ahci") ||
> -                       g_str_equal(driver, "nvme") ||
> -                       g_str_equal(driver, "xhci_hcd") ||
> -                       g_str_equal(driver, "ehci-pci"))) {
> -            break;
> -        }
> -
> -        g_free(driver);
> -        if (sscanf(p, "/%x:%x:%x.%x%n",
> -                          pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=
=3D 4) {
> -            p +=3D pcilen;
> -            continue;
> -        }
> -
> -        g_debug("unsupported driver or sysfs path '%s'", syspath);
> -        return false;
> -    }
> -
> -    p =3D strstr(syspath, "/target");
> -    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
> -                    tgt, tgt + 1, tgt + 2) =3D=3D 3) {
> -        has_tgt =3D true;
> -    }
> -
> -    p =3D strstr(syspath, "/ata");
> -    if (p) {
> -        q =3D p + 4;
> -        has_ata =3D true;
> -    } else {
> -        p =3D strstr(syspath, "/host");
> -        q =3D p + 5;
> -    }
> -    if (p && sscanf(q, "%u", &host) =3D=3D 1) {
> -        has_host =3D true;
> -        nhosts =3D build_hosts(syspath, p, has_ata, hosts,
> -                             ARRAY_SIZE(hosts), errp);
> -        if (nhosts < 0) {
> -            goto cleanup;
> -        }
> -    }
> -
> -    pciaddr->domain =3D pci[0];
> -    pciaddr->bus =3D pci[1];
> -    pciaddr->slot =3D pci[2];
> -    pciaddr->function =3D pci[3];
> -
> -    if (strcmp(driver, "ata_piix") =3D=3D 0) {
> -        /* a host per ide bus, target*:0:<unit>:0 */
> -        if (!has_host || !has_tgt) {
> -            g_debug("invalid sysfs path '%s' (driver '%s')", syspath,
> driver);
> -            goto cleanup;
> -        }
> -        for (i =3D 0; i < nhosts; i++) {
> -            if (host =3D=3D hosts[i]) {
> -                disk->bus_type =3D GUEST_DISK_BUS_TYPE_IDE;
> -                disk->bus =3D i;
> -                disk->unit =3D tgt[1];
> -                break;
> -            }
> -        }
> -        if (i >=3D nhosts) {
> -            g_debug("no host for '%s' (driver '%s')", syspath, driver);
> -            goto cleanup;
> -        }
> -    } else if (strcmp(driver, "sym53c8xx") =3D=3D 0) {
> -        /* scsi(LSI Logic): target*:0:<unit>:0 */
> -        if (!has_tgt) {
> -            g_debug("invalid sysfs path '%s' (driver '%s')", syspath,
> driver);
> -            goto cleanup;
> -        }
> -        disk->bus_type =3D GUEST_DISK_BUS_TYPE_SCSI;
> -        disk->unit =3D tgt[1];
> -    } else if (strcmp(driver, "virtio-pci") =3D=3D 0) {
> -        if (has_tgt) {
> -            /* virtio-scsi: target*:0:0:<unit> */
> -            disk->bus_type =3D GUEST_DISK_BUS_TYPE_SCSI;
> -            disk->unit =3D tgt[2];
> -        } else {
> -            /* virtio-blk: 1 disk per 1 device */
> -            disk->bus_type =3D GUEST_DISK_BUS_TYPE_VIRTIO;
> -        }
> -    } else if (strcmp(driver, "ahci") =3D=3D 0) {
> -        /* ahci: 1 host per 1 unit */
> -        if (!has_host || !has_tgt) {
> -            g_debug("invalid sysfs path '%s' (driver '%s')", syspath,
> driver);
> -            goto cleanup;
> -        }
> -        for (i =3D 0; i < nhosts; i++) {
> -            if (host =3D=3D hosts[i]) {
> -                disk->unit =3D i;
> -                disk->bus_type =3D GUEST_DISK_BUS_TYPE_SATA;
> -                break;
> -            }
> -        }
> -        if (i >=3D nhosts) {
> -            g_debug("no host for '%s' (driver '%s')", syspath, driver);
> -            goto cleanup;
> -        }
> -    } else if (strcmp(driver, "nvme") =3D=3D 0) {
> -        disk->bus_type =3D GUEST_DISK_BUS_TYPE_NVME;
> -    } else if (strcmp(driver, "ehci-pci") =3D=3D 0 || strcmp(driver,
> "xhci_hcd") =3D=3D 0) {
> -        disk->bus_type =3D GUEST_DISK_BUS_TYPE_USB;
> -    } else {
> -        g_debug("unknown driver '%s' (sysfs path '%s')", driver, syspath=
);
> -        goto cleanup;
> -    }
> -
> -    ret =3D true;
> -
> -cleanup:
> -    g_free(driver);
> -    return ret;
> -}
> -
> -/*
> - * Store disk device info for non-PCI virtio devices (for example s390x
> - * channel I/O devices). Returns true if information has been stored, or
> - * false for failure.
> - */
> -static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
> -                                                 GuestDiskAddress *disk,
> -                                                 Error **errp)
> -{
> -    unsigned int tgt[3];
> -    char *p;
> -
> -    if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
> -        g_debug("Unsupported virtio device '%s'", syspath);
> -        return false;
> -    }
> -
> -    p =3D strstr(syspath, "/target");
> -    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
> -                    &tgt[0], &tgt[1], &tgt[2]) =3D=3D 3) {
> -        /* virtio-scsi: target*:0:<target>:<unit> */
> -        disk->bus_type =3D GUEST_DISK_BUS_TYPE_SCSI;
> -        disk->bus =3D tgt[0];
> -        disk->target =3D tgt[1];
> -        disk->unit =3D tgt[2];
> -    } else {
> -        /* virtio-blk: 1 disk per 1 device */
> -        disk->bus_type =3D GUEST_DISK_BUS_TYPE_VIRTIO;
> -    }
> -
> -    return true;
> -}
> -
> -/*
> - * Store disk device info for CCW devices (s390x channel I/O devices).
> - * Returns true if information has been stored, or false for failure.
> - */
> -static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,
> -                                           GuestDiskAddress *disk,
> -                                           Error **errp)
> -{
> -    unsigned int cssid, ssid, subchno, devno;
> -    char *p;
> -
> -    p =3D strstr(syspath, "/devices/css");
> -    if (!p || sscanf(p + 12, "%*x/%x.%x.%x/%*x.%*x.%x/",
> -                     &cssid, &ssid, &subchno, &devno) < 4) {
> -        g_debug("could not parse ccw device sysfs path: %s", syspath);
> -        return false;
> -    }
> -
> -    disk->ccw_address =3D g_new0(GuestCCWAddress, 1);
> -    disk->ccw_address->cssid =3D cssid;
> -    disk->ccw_address->ssid =3D ssid;
> -    disk->ccw_address->subchno =3D subchno;
> -    disk->ccw_address->devno =3D devno;
> -
> -    if (strstr(p, "/virtio")) {
> -        build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
> -    }
> -
> -    return true;
> -}
> -
> -/* Store disk device info specified by @sysfs into @fs */
> -static void build_guest_fsinfo_for_real_device(char const *syspath,
> -                                               GuestFilesystemInfo *fs,
> -                                               Error **errp)
> -{
> -    GuestDiskAddress *disk;
> -    GuestPCIAddress *pciaddr;
> -    bool has_hwinf;
> -#ifdef CONFIG_LIBUDEV
> -    struct udev *udev =3D NULL;
> -    struct udev_device *udevice =3D NULL;
> -#endif
> -
> -    pciaddr =3D g_new0(GuestPCIAddress, 1);
> -    pciaddr->domain =3D -1;                       /* -1 means field is
> invalid */
> -    pciaddr->bus =3D -1;
> -    pciaddr->slot =3D -1;
> -    pciaddr->function =3D -1;
> -
> -    disk =3D g_new0(GuestDiskAddress, 1);
> -    disk->pci_controller =3D pciaddr;
> -    disk->bus_type =3D GUEST_DISK_BUS_TYPE_UNKNOWN;
> -
> -#ifdef CONFIG_LIBUDEV
> -    udev =3D udev_new();
> -    udevice =3D udev_device_new_from_syspath(udev, syspath);
> -    if (udev =3D=3D NULL || udevice =3D=3D NULL) {
> -        g_debug("failed to query udev");
> -    } else {
> -        const char *devnode, *serial;
> -        devnode =3D udev_device_get_devnode(udevice);
> -        if (devnode !=3D NULL) {
> -            disk->dev =3D g_strdup(devnode);
> -        }
> -        serial =3D udev_device_get_property_value(udevice, "ID_SERIAL");
> -        if (serial !=3D NULL && *serial !=3D 0) {
> -            disk->serial =3D g_strdup(serial);
> -        }
> -    }
> -
> -    udev_unref(udev);
> -    udev_device_unref(udevice);
> -#endif
> -
> -    if (strstr(syspath, "/devices/pci")) {
> -        has_hwinf =3D build_guest_fsinfo_for_pci_dev(syspath, disk, errp=
);
> -    } else if (strstr(syspath, "/devices/css")) {
> -        has_hwinf =3D build_guest_fsinfo_for_ccw_dev(syspath, disk, errp=
);
> -    } else if (strstr(syspath, "/virtio")) {
> -        has_hwinf =3D build_guest_fsinfo_for_nonpci_virtio(syspath, disk=
,
> errp);
> -    } else {
> -        g_debug("Unsupported device type for '%s'", syspath);
> -        has_hwinf =3D false;
> -    }
> -
> -    if (has_hwinf || disk->dev || disk->serial) {
> -        QAPI_LIST_PREPEND(fs->disk, disk);
> -    } else {
> -        qapi_free_GuestDiskAddress(disk);
> -    }
> -}
> -
> -static void build_guest_fsinfo_for_device(char const *devpath,
> -                                          GuestFilesystemInfo *fs,
> -                                          Error **errp);
> -
> -/* Store a list of slave devices of virtual volume specified by @syspath
> into
> - * @fs */
> -static void build_guest_fsinfo_for_virtual_device(char const *syspath,
> -                                                  GuestFilesystemInfo *f=
s,
> -                                                  Error **errp)
> -{
> -    Error *err =3D NULL;
> -    DIR *dir;
> -    char *dirpath;
> -    struct dirent *entry;
> -
> -    dirpath =3D g_strdup_printf("%s/slaves", syspath);
> -    dir =3D opendir(dirpath);
> -    if (!dir) {
> -        if (errno !=3D ENOENT) {
> -            error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
> -        }
> -        g_free(dirpath);
> -        return;
> -    }
> -
> -    for (;;) {
> -        errno =3D 0;
> -        entry =3D readdir(dir);
> -        if (entry =3D=3D NULL) {
> -            if (errno) {
> -                error_setg_errno(errp, errno, "readdir(\"%s\")", dirpath=
);
> -            }
> -            break;
> -        }
> -
> -        if (entry->d_type =3D=3D DT_LNK) {
> -            char *path;
> -
> -            g_debug(" slave device '%s'", entry->d_name);
> -            path =3D g_strdup_printf("%s/slaves/%s", syspath,
> entry->d_name);
> -            build_guest_fsinfo_for_device(path, fs, &err);
> -            g_free(path);
> -
> -            if (err) {
> -                error_propagate(errp, err);
> -                break;
> -            }
> -        }
> -    }
> -
> -    g_free(dirpath);
> -    closedir(dir);
> -}
> -
> -static bool is_disk_virtual(const char *devpath, Error **errp)
> -{
> -    g_autofree char *syspath =3D realpath(devpath, NULL);
> -
> -    if (!syspath) {
> -        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> -        return false;
> -    }
> -    return strstr(syspath, "/devices/virtual/block/") !=3D NULL;
> -}
> -
> -/* Dispatch to functions for virtual/real device */
> -static void build_guest_fsinfo_for_device(char const *devpath,
> -                                          GuestFilesystemInfo *fs,
> -                                          Error **errp)
> -{
> -    ERRP_GUARD();
> -    g_autofree char *syspath =3D NULL;
> -    bool is_virtual =3D false;
> -
> -    syspath =3D realpath(devpath, NULL);
> -    if (!syspath) {
> -        if (errno !=3D ENOENT) {
> -            error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> -            return;
> -        }
> -
> -        /* ENOENT: This devpath may not exist because of container confi=
g
> */
> -        if (!fs->name) {
> -            fs->name =3D g_path_get_basename(devpath);
> -        }
> -        return;
> -    }
> -
> -    if (!fs->name) {
> -        fs->name =3D g_path_get_basename(syspath);
> -    }
> -
> -    g_debug("  parse sysfs path '%s'", syspath);
> -    is_virtual =3D is_disk_virtual(syspath, errp);
> -    if (*errp !=3D NULL) {
> -        return;
> -    }
> -    if (is_virtual) {
> -        build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
> -    } else {
> -        build_guest_fsinfo_for_real_device(syspath, fs, errp);
> -    }
> -}
> -
> -#ifdef CONFIG_LIBUDEV
> -
> -/*
> - * Wrapper around build_guest_fsinfo_for_device() for getting just
> - * the disk address.
> - */
> -static GuestDiskAddress *get_disk_address(const char *syspath, Error
> **errp)
> -{
> -    g_autoptr(GuestFilesystemInfo) fs =3D NULL;
> -
> -    fs =3D g_new0(GuestFilesystemInfo, 1);
> -    build_guest_fsinfo_for_device(syspath, fs, errp);
> -    if (fs->disk !=3D NULL) {
> -        return g_steal_pointer(&fs->disk->value);
> -    }
> -    return NULL;
> -}
> -
> -static char *get_alias_for_syspath(const char *syspath)
> -{
> -    struct udev *udev =3D NULL;
> -    struct udev_device *udevice =3D NULL;
> -    char *ret =3D NULL;
> -
> -    udev =3D udev_new();
> -    if (udev =3D=3D NULL) {
> -        g_debug("failed to query udev");
> -        goto out;
> -    }
> -    udevice =3D udev_device_new_from_syspath(udev, syspath);
> -    if (udevice =3D=3D NULL) {
> -        g_debug("failed to query udev for path: %s", syspath);
> -        goto out;
> -    } else {
> -        const char *alias =3D udev_device_get_property_value(
> -            udevice, "DM_NAME");
> -        /*
> -         * NULL means there was an error and empty string means there is
> no
> -         * alias. In case of no alias we return NULL instead of empty
> string.
> -         */
> -        if (alias =3D=3D NULL) {
> -            g_debug("failed to query udev for device alias for: %s",
> -                syspath);
> -        } else if (*alias !=3D 0) {
> -            ret =3D g_strdup(alias);
> -        }
> -    }
> -
> -out:
> -    udev_unref(udev);
> -    udev_device_unref(udevice);
> -    return ret;
> -}
> -
> -static char *get_device_for_syspath(const char *syspath)
> -{
> -    struct udev *udev =3D NULL;
> -    struct udev_device *udevice =3D NULL;
> -    char *ret =3D NULL;
> -
> -    udev =3D udev_new();
> -    if (udev =3D=3D NULL) {
> -        g_debug("failed to query udev");
> -        goto out;
> -    }
> -    udevice =3D udev_device_new_from_syspath(udev, syspath);
> -    if (udevice =3D=3D NULL) {
> -        g_debug("failed to query udev for path: %s", syspath);
> -        goto out;
> -    } else {
> -        ret =3D g_strdup(udev_device_get_devnode(udevice));
> -    }
> -
> -out:
> -    udev_unref(udev);
> -    udev_device_unref(udevice);
> -    return ret;
> -}
> -
> -static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
> -{
> -    g_autofree char *deps_dir =3D NULL;
> -    const gchar *dep;
> -    GDir *dp_deps =3D NULL;
> -
> -    /* List dependent disks */
> -    deps_dir =3D g_strdup_printf("%s/slaves", disk_dir);
> -    g_debug("  listing entries in: %s", deps_dir);
> -    dp_deps =3D g_dir_open(deps_dir, 0, NULL);
> -    if (dp_deps =3D=3D NULL) {
> -        g_debug("failed to list entries in %s", deps_dir);
> -        return;
> -    }
> -    disk->has_dependencies =3D true;
> -    while ((dep =3D g_dir_read_name(dp_deps)) !=3D NULL) {
> -        g_autofree char *dep_dir =3D NULL;
> -        char *dev_name;
> -
> -        /* Add dependent disks */
> -        dep_dir =3D g_strdup_printf("%s/%s", deps_dir, dep);
> -        dev_name =3D get_device_for_syspath(dep_dir);
> -        if (dev_name !=3D NULL) {
> -            g_debug("  adding dependent device: %s", dev_name);
> -            QAPI_LIST_PREPEND(disk->dependencies, dev_name);
> -        }
> -    }
> -    g_dir_close(dp_deps);
> -}
> -
> -/*
> - * Detect partitions subdirectory, name is "<disk_name><number>" or
> - * "<disk_name>p<number>"
> - *
> - * @disk_name -- last component of /sys path (e.g. sda)
> - * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
> - * @disk_dev -- device node of the disk (e.g. /dev/sda)
> - */
> -static GuestDiskInfoList *get_disk_partitions(
> -    GuestDiskInfoList *list,
> -    const char *disk_name, const char *disk_dir,
> -    const char *disk_dev)
> -{
> -    GuestDiskInfoList *ret =3D list;
> -    struct dirent *de_disk;
> -    DIR *dp_disk =3D NULL;
> -    size_t len =3D strlen(disk_name);
> -
> -    dp_disk =3D opendir(disk_dir);
> -    while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {
> -        g_autofree char *partition_dir =3D NULL;
> -        char *dev_name;
> -        GuestDiskInfo *partition;
> -
> -        if (!(de_disk->d_type & DT_DIR)) {
> -            continue;
> -        }
> -
> -        if (!(strncmp(disk_name, de_disk->d_name, len) =3D=3D 0 &&
> -            ((*(de_disk->d_name + len) =3D=3D 'p' &&
> -            isdigit(*(de_disk->d_name + len + 1))) ||
> -                isdigit(*(de_disk->d_name + len))))) {
> -            continue;
> -        }
> -
> -        partition_dir =3D g_strdup_printf("%s/%s",
> -            disk_dir, de_disk->d_name);
> -        dev_name =3D get_device_for_syspath(partition_dir);
> -        if (dev_name =3D=3D NULL) {
> -            g_debug("Failed to get device name for syspath: %s",
> -                disk_dir);
> -            continue;
> -        }
> -        partition =3D g_new0(GuestDiskInfo, 1);
> -        partition->name =3D dev_name;
> -        partition->partition =3D true;
> -        partition->has_dependencies =3D true;
> -        /* Add parent disk as dependent for easier tracking of hierarchy
> */
> -        QAPI_LIST_PREPEND(partition->dependencies, g_strdup(disk_dev));
> -
> -        QAPI_LIST_PREPEND(ret, partition);
> -    }
> -    closedir(dp_disk);
> -
> -    return ret;
> -}
> -
> -static void get_nvme_smart(GuestDiskInfo *disk)
> -{
> -    int fd;
> -    GuestNVMeSmart *smart;
> -    NvmeSmartLog log =3D {0};
> -    struct nvme_admin_cmd cmd =3D {
> -        .opcode =3D NVME_ADM_CMD_GET_LOG_PAGE,
> -        .nsid =3D NVME_NSID_BROADCAST,
> -        .addr =3D (uintptr_t)&log,
> -        .data_len =3D sizeof(log),
> -        .cdw10 =3D NVME_LOG_SMART_INFO | (1 << 15) /* RAE bit */
> -                 | (((sizeof(log) >> 2) - 1) << 16)
> -    };
> -
> -    fd =3D qga_open_cloexec(disk->name, O_RDONLY, 0);
> -    if (fd =3D=3D -1) {
> -        g_debug("Failed to open device: %s: %s", disk->name,
> g_strerror(errno));
> -        return;
> -    }
> -
> -    if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd)) {
> -        g_debug("Failed to get smart: %s: %s", disk->name,
> g_strerror(errno));
> -        close(fd);
> -        return;
> -    }
> -
> -    disk->smart =3D g_new0(GuestDiskSmart, 1);
> -    disk->smart->type =3D GUEST_DISK_BUS_TYPE_NVME;
> -
> -    smart =3D &disk->smart->u.nvme;
> -    smart->critical_warning =3D log.critical_warning;
> -    smart->temperature =3D lduw_le_p(&log.temperature); /* unaligned fie=
ld
> */
> -    smart->available_spare =3D log.available_spare;
> -    smart->available_spare_threshold =3D log.available_spare_threshold;
> -    smart->percentage_used =3D log.percentage_used;
> -    smart->data_units_read_lo =3D le64_to_cpu(log.data_units_read[0]);
> -    smart->data_units_read_hi =3D le64_to_cpu(log.data_units_read[1]);
> -    smart->data_units_written_lo =3D le64_to_cpu(log.data_units_written[=
0]);
> -    smart->data_units_written_hi =3D le64_to_cpu(log.data_units_written[=
1]);
> -    smart->host_read_commands_lo =3D le64_to_cpu(log.host_read_commands[=
0]);
> -    smart->host_read_commands_hi =3D le64_to_cpu(log.host_read_commands[=
1]);
> -    smart->host_write_commands_lo =3D
> le64_to_cpu(log.host_write_commands[0]);
> -    smart->host_write_commands_hi =3D
> le64_to_cpu(log.host_write_commands[1]);
> -    smart->controller_busy_time_lo =3D
> le64_to_cpu(log.controller_busy_time[0]);
> -    smart->controller_busy_time_hi =3D
> le64_to_cpu(log.controller_busy_time[1]);
> -    smart->power_cycles_lo =3D le64_to_cpu(log.power_cycles[0]);
> -    smart->power_cycles_hi =3D le64_to_cpu(log.power_cycles[1]);
> -    smart->power_on_hours_lo =3D le64_to_cpu(log.power_on_hours[0]);
> -    smart->power_on_hours_hi =3D le64_to_cpu(log.power_on_hours[1]);
> -    smart->unsafe_shutdowns_lo =3D le64_to_cpu(log.unsafe_shutdowns[0]);
> -    smart->unsafe_shutdowns_hi =3D le64_to_cpu(log.unsafe_shutdowns[1]);
> -    smart->media_errors_lo =3D le64_to_cpu(log.media_errors[0]);
> -    smart->media_errors_hi =3D le64_to_cpu(log.media_errors[1]);
> -    smart->number_of_error_log_entries_lo =3D
> -        le64_to_cpu(log.number_of_error_log_entries[0]);
> -    smart->number_of_error_log_entries_hi =3D
> -        le64_to_cpu(log.number_of_error_log_entries[1]);
> -
> -    close(fd);
> -}
> -
> -static void get_disk_smart(GuestDiskInfo *disk)
> -{
> -    if (disk->address
> -        && (disk->address->bus_type =3D=3D GUEST_DISK_BUS_TYPE_NVME)) {
> -        get_nvme_smart(disk);
> -    }
> -}
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    GuestDiskInfoList *ret =3D NULL;
> -    GuestDiskInfo *disk;
> -    DIR *dp =3D NULL;
> -    struct dirent *de =3D NULL;
> -
> -    g_debug("listing /sys/block directory");
> -    dp =3D opendir("/sys/block");
> -    if (dp =3D=3D NULL) {
> -        error_setg_errno(errp, errno, "Can't open directory
> \"/sys/block\"");
> -        return NULL;
> -    }
> -    while ((de =3D readdir(dp)) !=3D NULL) {
> -        g_autofree char *disk_dir =3D NULL, *line =3D NULL,
> -            *size_path =3D NULL;
> -        char *dev_name;
> -        Error *local_err =3D NULL;
> -        if (de->d_type !=3D DT_LNK) {
> -            g_debug("  skipping entry: %s", de->d_name);
> -            continue;
> -        }
> -
> -        /* Check size and skip zero-sized disks */
> -        g_debug("  checking disk size");
> -        size_path =3D g_strdup_printf("/sys/block/%s/size", de->d_name);
> -        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
> -            g_debug("  failed to read disk size");
> -            continue;
> -        }
> -        if (g_strcmp0(line, "0\n") =3D=3D 0) {
> -            g_debug("  skipping zero-sized disk");
> -            continue;
> -        }
> -
> -        g_debug("  adding %s", de->d_name);
> -        disk_dir =3D g_strdup_printf("/sys/block/%s", de->d_name);
> -        dev_name =3D get_device_for_syspath(disk_dir);
> -        if (dev_name =3D=3D NULL) {
> -            g_debug("Failed to get device name for syspath: %s",
> -                disk_dir);
> -            continue;
> -        }
> -        disk =3D g_new0(GuestDiskInfo, 1);
> -        disk->name =3D dev_name;
> -        disk->partition =3D false;
> -        disk->alias =3D get_alias_for_syspath(disk_dir);
> -        QAPI_LIST_PREPEND(ret, disk);
> -
> -        /* Get address for non-virtual devices */
> -        bool is_virtual =3D is_disk_virtual(disk_dir, &local_err);
> -        if (local_err !=3D NULL) {
> -            g_debug("  failed to check disk path, ignoring error: %s",
> -                error_get_pretty(local_err));
> -            error_free(local_err);
> -            local_err =3D NULL;
> -            /* Don't try to get the address */
> -            is_virtual =3D true;
> -        }
> -        if (!is_virtual) {
> -            disk->address =3D get_disk_address(disk_dir, &local_err);
> -            if (local_err !=3D NULL) {
> -                g_debug("  failed to get device info, ignoring error: %s=
",
> -                    error_get_pretty(local_err));
> -                error_free(local_err);
> -                local_err =3D NULL;
> -            }
> -        }
> -
> -        get_disk_deps(disk_dir, disk);
> -        get_disk_smart(disk);
> -        ret =3D get_disk_partitions(ret, de->d_name, disk_dir, dev_name)=
;
> -    }
> -
> -    closedir(dp);
> -
> -    return ret;
> -}
> -
> -#else
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -#endif
> -
> -/* Return a list of the disk device(s)' info which @mount lies on */
> -static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
> -                                               Error **errp)
> -{
> -    GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
> -    struct statvfs buf;
> -    unsigned long used, nonroot_total, fr_size;
> -    char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
> -                                    mount->devmajor, mount->devminor);
> -
> -    fs->mountpoint =3D g_strdup(mount->dirname);
> -    fs->type =3D g_strdup(mount->devtype);
> -    build_guest_fsinfo_for_device(devpath, fs, errp);
> -
> -    if (statvfs(fs->mountpoint, &buf) =3D=3D 0) {
> -        fr_size =3D buf.f_frsize;
> -        used =3D buf.f_blocks - buf.f_bfree;
> -        nonroot_total =3D used + buf.f_bavail;
> -        fs->used_bytes =3D used * fr_size;
> -        fs->total_bytes =3D nonroot_total * fr_size;
> -        fs->total_bytes_privileged =3D buf.f_blocks * fr_size;
> -
> -        fs->has_total_bytes =3D true;
> -        fs->has_total_bytes_privileged =3D true;
> -        fs->has_used_bytes =3D true;
> -    }
> -
> -    g_free(devpath);
> -
> -    return fs;
> -}
> -
> -GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> -{
> -    FsMountList mounts;
> -    struct FsMount *mount;
> -    GuestFilesystemInfoList *ret =3D NULL;
> -    Error *local_err =3D NULL;
> -
> -    QTAILQ_INIT(&mounts);
> -    if (!build_fs_mount_list(&mounts, &local_err)) {
> -        error_propagate(errp, local_err);
> -        return NULL;
> -    }
> -
> -    QTAILQ_FOREACH(mount, &mounts, next) {
> -        g_debug("Building guest fsinfo for '%s'", mount->dirname);
> -
> -        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            qapi_free_GuestFilesystemInfoList(ret);
> -            ret =3D NULL;
> -            break;
> -        }
> -    }
> -
> -    free_fs_mount_list(&mounts);
> -    return ret;
> -}
> -#endif /* CONFIG_FSFREEZE */
> -
> -#if defined(CONFIG_FSTRIM)
> -/*
> - * Walk list of mounted file systems in the guest, and trim them.
> - */
> -GuestFilesystemTrimResponse *
> -qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
> -{
> -    GuestFilesystemTrimResponse *response;
> -    GuestFilesystemTrimResult *result;
> -    int ret =3D 0;
> -    FsMountList mounts;
> -    struct FsMount *mount;
> -    int fd;
> -    struct fstrim_range r;
> -
> -    slog("guest-fstrim called");
> -
> -    QTAILQ_INIT(&mounts);
> -    if (!build_fs_mount_list(&mounts, errp)) {
> -        return NULL;
> -    }
> -
> -    response =3D g_malloc0(sizeof(*response));
> -
> -    QTAILQ_FOREACH(mount, &mounts, next) {
> -        result =3D g_malloc0(sizeof(*result));
> -        result->path =3D g_strdup(mount->dirname);
> -
> -        QAPI_LIST_PREPEND(response->paths, result);
> -
> -        fd =3D qga_open_cloexec(mount->dirname, O_RDONLY, 0);
> -        if (fd =3D=3D -1) {
> -            result->error =3D g_strdup_printf("failed to open: %s",
> -                                            strerror(errno));
> -            continue;
> -        }
> -
> -        /* We try to cull filesystems we know won't work in advance, but
> other
> -         * filesystems may not implement fstrim for less obvious reasons=
.
> -         * These will report EOPNOTSUPP; while in some other cases ENOTT=
Y
> -         * will be reported (e.g. CD-ROMs).
> -         * Any other error means an unexpected error.
> -         */
> -        r.start =3D 0;
> -        r.len =3D -1;
> -        r.minlen =3D has_minimum ? minimum : 0;
> -        ret =3D ioctl(fd, FITRIM, &r);
> -        if (ret =3D=3D -1) {
> -            if (errno =3D=3D ENOTTY || errno =3D=3D EOPNOTSUPP) {
> -                result->error =3D g_strdup("trim not supported");
> -            } else {
> -                result->error =3D g_strdup_printf("failed to trim: %s",
> -                                                strerror(errno));
> -            }
> -            close(fd);
> -            continue;
> -        }
> -
> -        result->has_minimum =3D true;
> -        result->minimum =3D r.minlen;
> -        result->has_trimmed =3D true;
> -        result->trimmed =3D r.len;
> -        close(fd);
> -    }
> -
> -    free_fs_mount_list(&mounts);
> -    return response;
> -}
> -#endif /* CONFIG_FSTRIM */
> -
> -#endif /* __linux__ */
> -
>  #if defined(__linux__) || defined(__FreeBSD__)
>  void qmp_guest_set_user_password(const char *username,
>                                   const char *password,
> --
> 2.45.1
>
>

--0000000000005cc8b2061d08ae38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:02=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The qmp_guest_{fstrim, get_fsinfo, get_disks} command i=
mpls in<br>
commands-posix.c are surrounded by &#39;#ifdef __linux__&#39; so should<br>
instead live in commands-linux.c<br>
<br>
Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@=
linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 904 ++++++++++++++++++++++++++++++++++++++++++=
<br>
=C2=A0qga/commands-posix.c | 909 ------------------------------------------=
-<br>
=C2=A02 files changed, 904 insertions(+), 909 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 3fabf54882..084e6c9e85 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -14,10 +14,21 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qga-qapi-commands.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qapi/qmp/qerror.h&quot;<br>
=C2=A0#include &quot;commands-common.h&quot;<br>
=C2=A0#include &quot;cutils.h&quot;<br>
=C2=A0#include &lt;mntent.h&gt;<br>
=C2=A0#include &lt;sys/ioctl.h&gt;<br>
+#include &lt;mntent.h&gt;<br>
+#include &lt;linux/nvme_ioctl.h&gt;<br>
+#include &quot;block/nvme.h&quot;<br>
+<br>
+#ifdef CONFIG_LIBUDEV<br>
+#include &lt;libudev.h&gt;<br>
+#endif<br>
+<br>
+#include &lt;sys/statvfs.h&gt;<br>
<br>
=C2=A0#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)<br>
=C2=A0static int dev_major_minor(const char *devpath,<br>
@@ -286,6 +297,899 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
<br>
+#if defined(CONFIG_FSFREEZE)<br>
+<br>
+static char *get_pci_driver(char const *syspath, int pathlen, Error **errp=
)<br>
+{<br>
+=C2=A0 =C2=A0 char *path;<br>
+=C2=A0 =C2=A0 char *dpath;<br>
+=C2=A0 =C2=A0 char *driver =3D NULL;<br>
+=C2=A0 =C2=A0 char buf[PATH_MAX];<br>
+=C2=A0 =C2=A0 ssize_t len;<br>
+<br>
+=C2=A0 =C2=A0 path =3D g_strndup(syspath, pathlen);<br>
+=C2=A0 =C2=A0 dpath =3D g_strdup_printf(&quot;%s/driver&quot;, path);<br>
+=C2=A0 =C2=A0 len =3D readlink(dpath, buf, sizeof(buf) - 1);<br>
+=C2=A0 =C2=A0 if (len !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[len] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D g_path_get_basename(buf);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_free(dpath);<br>
+=C2=A0 =C2=A0 g_free(path);<br>
+=C2=A0 =C2=A0 return driver;<br>
+}<br>
+<br>
+static int compare_uint(const void *_a, const void *_b)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int a =3D *(unsigned int *)_a;<br>
+=C2=A0 =C2=A0 unsigned int b =3D *(unsigned int *)_b;<br>
+<br>
+=C2=A0 =C2=A0 return a &lt; b ? -1 : a &gt; b ? 1 : 0;<br>
+}<br>
+<br>
+/* Walk the specified sysfs and build a sorted list of host or ata numbers=
 */<br>
+static int build_hosts(char const *syspath, char const *host, bool ata,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0unsigned int *hosts, int hosts_max, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 char *path;<br>
+=C2=A0 =C2=A0 DIR *dir;<br>
+=C2=A0 =C2=A0 struct dirent *entry;<br>
+=C2=A0 =C2=A0 int i =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 path =3D g_strndup(syspath, host - syspath);<br>
+=C2=A0 =C2=A0 dir =3D opendir(path);<br>
+=C2=A0 =C2=A0 if (!dir) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;opendir(\&=
quot;%s\&quot;)&quot;, path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (i &lt; hosts_max) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D readdir(dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!entry) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ata &amp;&amp; sscanf(entry-&gt;d_name, &q=
uot;ata%d&quot;, hosts + i) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!ata &amp;&amp; sscanf(entry-&gt;d_=
name, &quot;host%d&quot;, hosts + i) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qsort(hosts, i, sizeof(hosts[0]), compare_uint);<br>
+<br>
+=C2=A0 =C2=A0 g_free(path);<br>
+=C2=A0 =C2=A0 closedir(dir);<br>
+=C2=A0 =C2=A0 return i;<br>
+}<br>
+<br>
+/*<br>
+ * Store disk device info for devices on the PCI bus.<br>
+ * Returns true if information has been stored, or false for failure.<br>
+ */<br>
+static bool build_guest_fsinfo_for_pci_dev(char const *syspath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GuestDiskAddress *disk,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int pci[4], host, hosts[8], tgt[3];<br>
+=C2=A0 =C2=A0 int i, nhosts =3D 0, pcilen;<br>
+=C2=A0 =C2=A0 GuestPCIAddress *pciaddr =3D disk-&gt;pci_controller;<br>
+=C2=A0 =C2=A0 bool has_ata =3D false, has_host =3D false, has_tgt =3D fals=
e;<br>
+=C2=A0 =C2=A0 char *p, *q, *driver =3D NULL;<br>
+=C2=A0 =C2=A0 bool ret =3D false;<br>
+<br>
+=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/devices/pci&quot;);<br>
+=C2=A0 =C2=A0 if (!p || sscanf(p + 12, &quot;%*x:%*x/%x:%x:%x.%x%n&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pci, pci + 1, pci + 2, pci + 3, &amp;pcilen) &lt; 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;only pci device is supported: sy=
sfs path &#39;%s&#39;&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 p +=3D 12 + pcilen;<br>
+=C2=A0 =C2=A0 while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D get_pci_driver(syspath, p - syspath=
, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (driver &amp;&amp; (g_str_equal(driver, &qu=
ot;ata_piix&quot;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;sym53c8xx&quot;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;virtio-pci&quot;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;ahci&quot;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;nvme&quot;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;xhci_hcd&quot;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;ehci-pci&quot;))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(driver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(p, &quot;/%x:%x:%x.%x%n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pci, pci + 1, pci + 2, pci + 3, &amp;pcilen) =3D=3D 4) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p +=3D pcilen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;unsupported driver or sysfs path=
 &#39;%s&#39;&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/target&quot;);<br>
+=C2=A0 =C2=A0 if (p &amp;&amp; sscanf(p + 7, &quot;%*u:%*u:%*u/%*u:%u:%u:%=
u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt,=
 tgt + 1, tgt + 2) =3D=3D 3) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_tgt =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/ata&quot;);<br>
+=C2=A0 =C2=A0 if (p) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D p + 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_ata =3D true;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/host&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D p + 5;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (p &amp;&amp; sscanf(q, &quot;%u&quot;, &amp;host) =3D=3D=
 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_host =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nhosts =3D build_hosts(syspath, p, has_ata, ho=
sts,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(hosts), errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nhosts &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pciaddr-&gt;domain =3D pci[0];<br>
+=C2=A0 =C2=A0 pciaddr-&gt;bus =3D pci[1];<br>
+=C2=A0 =C2=A0 pciaddr-&gt;slot =3D pci[2];<br>
+=C2=A0 =C2=A0 pciaddr-&gt;function =3D pci[3];<br>
+<br>
+=C2=A0 =C2=A0 if (strcmp(driver, &quot;ata_piix&quot;) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* a host per ide bus, target*:0:&lt;unit&gt;:=
0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_host || !has_tgt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;invalid sysfs path=
 &#39;%s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; nhosts; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host =3D=3D hosts[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =
=3D GUEST_DISK_BUS_TYPE_IDE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus =3D i=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D =
tgt[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D nhosts) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;no host for &#39;%=
s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;sym53c8xx&quot;) =3D=3D 0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* scsi(LSI Logic): target*:0:&lt;unit&gt;:0 *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_tgt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;invalid sysfs path=
 &#39;%s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_SCSI=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D tgt[1];<br>
+=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;virtio-pci&quot;) =3D=3D 0) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_tgt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-scsi: target*:0:0:&lt;=
unit&gt; */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK=
_BUS_TYPE_SCSI;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D tgt[2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-blk: 1 disk per 1 devi=
ce */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK=
_BUS_TYPE_VIRTIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;ahci&quot;) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ahci: 1 host per 1 unit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_host || !has_tgt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;invalid sysfs path=
 &#39;%s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; nhosts; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host =3D=3D hosts[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D =
i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =
=3D GUEST_DISK_BUS_TYPE_SATA;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D nhosts) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;no host for &#39;%=
s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;nvme&quot;) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_NVME=
;<br>
+=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;ehci-pci&quot;) =3D=3D 0 || =
strcmp(driver, &quot;xhci_hcd&quot;) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_USB;=
<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;unknown driver &#39;%s&#39; (sys=
fs path &#39;%s&#39;)&quot;, driver, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D true;<br>
+<br>
+cleanup:<br>
+=C2=A0 =C2=A0 g_free(driver);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/*<br>
+ * Store disk device info for non-PCI virtio devices (for example s390x<br=
>
+ * channel I/O devices). Returns true if information has been stored, or<b=
r>
+ * false for failure.<br>
+ */<br>
+static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0GuestDiskAddress *disk,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int tgt[3];<br>
+=C2=A0 =C2=A0 char *p;<br>
+<br>
+=C2=A0 =C2=A0 if (!strstr(syspath, &quot;/virtio&quot;) || !strstr(syspath=
, &quot;/block&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Unsupported virtio device &#39;%=
s&#39;&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/target&quot;);<br>
+=C2=A0 =C2=A0 if (p &amp;&amp; sscanf(p + 7, &quot;%*u:%*u:%*u/%*u:%u:%u:%=
u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;tgt[0], &amp;tgt[1], &amp;tgt[2]) =3D=3D 3) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-scsi: target*:0:&lt;target&gt;:&lt;u=
nit&gt; */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_SCSI=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus =3D tgt[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;target =3D tgt[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D tgt[2];<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-blk: 1 disk per 1 device */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_VIRT=
IO;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ * Store disk device info for CCW devices (s390x channel I/O devices).<br>
+ * Returns true if information has been stored, or false for failure.<br>
+ */<br>
+static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GuestDiskAddress *disk,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int cssid, ssid, subchno, devno;<br>
+=C2=A0 =C2=A0 char *p;<br>
+<br>
+=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/devices/css&quot;);<br>
+=C2=A0 =C2=A0 if (!p || sscanf(p + 12, &quot;%*x/%x.%x.%x/%*x.%*x.%x/&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;cssid, &amp;ssid, &amp;subchno, &amp;devno) &lt; 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;could not parse ccw device sysfs=
 path: %s&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 disk-&gt;ccw_address =3D g_new0(GuestCCWAddress, 1);<br>
+=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;cssid =3D cssid;<br>
+=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;ssid =3D ssid;<br>
+=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;subchno =3D subchno;<br>
+=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;devno =3D devno;<br>
+<br>
+=C2=A0 =C2=A0 if (strstr(p, &quot;/virtio&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_nonpci_virtio(syspath, =
disk, errp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/* Store disk device info specified by @sysfs into @fs */<br>
+static void build_guest_fsinfo_for_real_device(char const *syspath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GuestFilesystemInfo *fs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskAddress *disk;<br>
+=C2=A0 =C2=A0 GuestPCIAddress *pciaddr;<br>
+=C2=A0 =C2=A0 bool has_hwinf;<br>
+#ifdef CONFIG_LIBUDEV<br>
+=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
+=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 pciaddr =3D g_new0(GuestPCIAddress, 1);<br>
+=C2=A0 =C2=A0 pciaddr-&gt;domain =3D -1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* -1 means field is inval=
id */<br>
+=C2=A0 =C2=A0 pciaddr-&gt;bus =3D -1;<br>
+=C2=A0 =C2=A0 pciaddr-&gt;slot =3D -1;<br>
+=C2=A0 =C2=A0 pciaddr-&gt;function =3D -1;<br>
+<br>
+=C2=A0 =C2=A0 disk =3D g_new0(GuestDiskAddress, 1);<br>
+=C2=A0 =C2=A0 disk-&gt;pci_controller =3D pciaddr;<br>
+=C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_UNKNOWN;<br>
+<br>
+#ifdef CONFIG_LIBUDEV<br>
+=C2=A0 =C2=A0 udev =3D udev_new();<br>
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
+=C2=A0 =C2=A0 if (udev =3D=3D NULL || udevice =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *devnode, *serial;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devnode =3D udev_device_get_devnode(udevice);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devnode !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;dev =3D g_strdup(devnod=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial =3D udev_device_get_property_value(udev=
ice, &quot;ID_SERIAL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (serial !=3D NULL &amp;&amp; *serial !=3D 0=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;serial =3D g_strdup(ser=
ial);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 udev_unref(udev);<br>
+=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 if (strstr(syspath, &quot;/devices/pci&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D build_guest_fsinfo_for_pci_dev(s=
yspath, disk, errp);<br>
+=C2=A0 =C2=A0 } else if (strstr(syspath, &quot;/devices/css&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D build_guest_fsinfo_for_ccw_dev(s=
yspath, disk, errp);<br>
+=C2=A0 =C2=A0 } else if (strstr(syspath, &quot;/virtio&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D build_guest_fsinfo_for_nonpci_vi=
rtio(syspath, disk, errp);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Unsupported device type for &#39=
;%s&#39;&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (has_hwinf || disk-&gt;dev || disk-&gt;serial) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(fs-&gt;disk, disk);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestDiskAddress(disk);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void build_guest_fsinfo_for_device(char const *devpath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
uestFilesystemInfo *fs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
rror **errp);<br>
+<br>
+/* Store a list of slave devices of virtual volume specified by @syspath i=
nto<br>
+ * @fs */<br>
+static void build_guest_fsinfo_for_virtual_device(char const *syspath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestFilesystemInfo *fs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 DIR *dir;<br>
+=C2=A0 =C2=A0 char *dirpath;<br>
+=C2=A0 =C2=A0 struct dirent *entry;<br>
+<br>
+=C2=A0 =C2=A0 dirpath =3D g_strdup_printf(&quot;%s/slaves&quot;, syspath);=
<br>
+=C2=A0 =C2=A0 dir =3D opendir(dirpath);<br>
+=C2=A0 =C2=A0 if (!dir) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;opendir(\&quot;%s\&quot;)&quot;, dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (;;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D readdir(dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(e=
rrp, errno, &quot;readdir(\&quot;%s\&quot;)&quot;, dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry-&gt;d_type =3D=3D DT_LNK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *path;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot; slave device &#39=
;%s&#39;&quot;, entry-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D g_strdup_printf(&quot;%=
s/slaves/%s&quot;, syspath, entry-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_device(pa=
th, fs, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(path);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(er=
rp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(dirpath);<br>
+=C2=A0 =C2=A0 closedir(dir);<br>
+}<br>
+<br>
+static bool is_disk_virtual(const char *devpath, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *syspath =3D realpath(devpath, NULL);<br>
+<br>
+=C2=A0 =C2=A0 if (!syspath) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;realpath(\=
&quot;%s\&quot;)&quot;, devpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return strstr(syspath, &quot;/devices/virtual/block/&quot;) =
!=3D NULL;<br>
+}<br>
+<br>
+/* Dispatch to functions for virtual/real device */<br>
+static void build_guest_fsinfo_for_device(char const *devpath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
uestFilesystemInfo *fs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
rror **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
+=C2=A0 =C2=A0 g_autofree char *syspath =3D NULL;<br>
+=C2=A0 =C2=A0 bool is_virtual =3D false;<br>
+<br>
+=C2=A0 =C2=A0 syspath =3D realpath(devpath, NULL);<br>
+=C2=A0 =C2=A0 if (!syspath) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;realpath(\&quot;%s\&quot;)&quot;, devpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ENOENT: This devpath may not exist because =
of container config */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fs-&gt;name) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;name =3D g_path_get_basen=
ame(devpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!fs-&gt;name) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;name =3D g_path_get_basename(syspath);<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;=C2=A0 parse sysfs path &#39;%s&#39;&quot;, sy=
spath);<br>
+=C2=A0 =C2=A0 is_virtual =3D is_disk_virtual(syspath, errp);<br>
+=C2=A0 =C2=A0 if (*errp !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (is_virtual) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_virtual_device(syspath,=
 fs, errp);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_real_device(syspath, fs=
, errp);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+#ifdef CONFIG_LIBUDEV<br>
+<br>
+/*<br>
+ * Wrapper around build_guest_fsinfo_for_device() for getting just<br>
+ * the disk address.<br>
+ */<br>
+static GuestDiskAddress *get_disk_address(const char *syspath, Error **err=
p)<br>
+{<br>
+=C2=A0 =C2=A0 g_autoptr(GuestFilesystemInfo) fs =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 fs =3D g_new0(GuestFilesystemInfo, 1);<br>
+=C2=A0 =C2=A0 build_guest_fsinfo_for_device(syspath, fs, errp);<br>
+=C2=A0 =C2=A0 if (fs-&gt;disk !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;fs-&gt;disk-&gt;va=
lue);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+static char *get_alias_for_syspath(const char *syspath)<br>
+{<br>
+=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
+=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
+=C2=A0 =C2=A0 char *ret =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 udev =3D udev_new();<br>
+=C2=A0 =C2=A0 if (udev =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
+=C2=A0 =C2=A0 if (udevice =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev for path: %=
s&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *alias =3D udev_device_get_property=
_value(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udevice, &quot;DM_NAME&quot;);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* NULL means there was an error and empt=
y string means there is no<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* alias. In case of no alias we return N=
ULL instead of empty string.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (alias =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query ud=
ev for device alias for: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*alias !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(alias);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 udev_unref(udev);<br>
+=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static char *get_device_for_syspath(const char *syspath)<br>
+{<br>
+=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
+=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
+=C2=A0 =C2=A0 char *ret =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 udev =3D udev_new();<br>
+=C2=A0 =C2=A0 if (udev =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
+=C2=A0 =C2=A0 if (udevice =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev for path: %=
s&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(udev_device_get_devnode(udevi=
ce));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 udev_unref(udev);<br>
+=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *deps_dir =3D NULL;<br>
+=C2=A0 =C2=A0 const gchar *dep;<br>
+=C2=A0 =C2=A0 GDir *dp_deps =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* List dependent disks */<br>
+=C2=A0 =C2=A0 deps_dir =3D g_strdup_printf(&quot;%s/slaves&quot;, disk_dir=
);<br>
+=C2=A0 =C2=A0 g_debug(&quot;=C2=A0 listing entries in: %s&quot;, deps_dir)=
;<br>
+=C2=A0 =C2=A0 dp_deps =3D g_dir_open(deps_dir, 0, NULL);<br>
+=C2=A0 =C2=A0 if (dp_deps =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to list entries in %s&quo=
t;, deps_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 disk-&gt;has_dependencies =3D true;<br>
+=C2=A0 =C2=A0 while ((dep =3D g_dir_read_name(dp_deps)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *dep_dir =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add dependent disks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dep_dir =3D g_strdup_printf(&quot;%s/%s&quot;,=
 deps_dir, dep);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(dep_dir);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding depe=
ndent device: %s&quot;, dev_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(disk-&gt;depen=
dencies, dev_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_dir_close(dp_deps);<br>
+}<br>
+<br>
+/*<br>
+ * Detect partitions subdirectory, name is &quot;&lt;disk_name&gt;&lt;numb=
er&gt;&quot; or<br>
+ * &quot;&lt;disk_name&gt;p&lt;number&gt;&quot;<br>
+ *<br>
+ * @disk_name -- last component of /sys path (e.g. sda)<br>
+ * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)<br>
+ * @disk_dev -- device node of the disk (e.g. /dev/sda)<br>
+ */<br>
+static GuestDiskInfoList *get_disk_partitions(<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *list,<br>
+=C2=A0 =C2=A0 const char *disk_name, const char *disk_dir,<br>
+=C2=A0 =C2=A0 const char *disk_dev)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *ret =3D list;<br>
+=C2=A0 =C2=A0 struct dirent *de_disk;<br>
+=C2=A0 =C2=A0 DIR *dp_disk =3D NULL;<br>
+=C2=A0 =C2=A0 size_t len =3D strlen(disk_name);<br>
+<br>
+=C2=A0 =C2=A0 dp_disk =3D opendir(disk_dir);<br>
+=C2=A0 =C2=A0 while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *partition_dir =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskInfo *partition;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(de_disk-&gt;d_type &amp; DT_DIR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(strncmp(disk_name, de_disk-&gt;d_name, l=
en) =3D=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((*(de_disk-&gt;d_name + len) =
=3D=3D &#39;p&#39; &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-&gt;d_name + l=
en + 1))) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-=
&gt;d_name + len))))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition_dir =3D g_strdup_printf(&quot;%s/%s&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir, de_disk-&gt;d_name);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(partition_=
dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get devi=
ce name for syspath: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;name =3D dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;partition =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;has_dependencies =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add parent disk as dependent for easier tra=
cking of hierarchy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(partition-&gt;dependencies, =
g_strdup(disk_dev));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, partition);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 closedir(dp_disk);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static void get_nvme_smart(GuestDiskInfo *disk)<br>
+{<br>
+=C2=A0 =C2=A0 int fd;<br>
+=C2=A0 =C2=A0 GuestNVMeSmart *smart;<br>
+=C2=A0 =C2=A0 NvmeSmartLog log =3D {0};<br>
+=C2=A0 =C2=A0 struct nvme_admin_cmd cmd =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .opcode =3D NVME_ADM_CMD_GET_LOG_PAGE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .nsid =3D NVME_NSID_BROADCAST,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .addr =3D (uintptr_t)&amp;log,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .data_len =3D sizeof(log),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cdw10 =3D NVME_LOG_SMART_INFO | (1 &lt;&lt; 1=
5) /* RAE bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (((sizeof(=
log) &gt;&gt; 2) - 1) &lt;&lt; 16)<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 fd =3D qga_open_cloexec(disk-&gt;name, O_RDONLY, 0);<br>
+=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to open device: %s: %s&qu=
ot;, disk-&gt;name, g_strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &amp;cmd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get smart: %s: %s&quot=
;, disk-&gt;name, g_strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 disk-&gt;smart =3D g_new0(GuestDiskSmart, 1);<br>
+=C2=A0 =C2=A0 disk-&gt;smart-&gt;type =3D GUEST_DISK_BUS_TYPE_NVME;<br>
+<br>
+=C2=A0 =C2=A0 smart =3D &amp;disk-&gt;smart-&gt;u.nvme;<br>
+=C2=A0 =C2=A0 smart-&gt;critical_warning =3D log.critical_warning;<br>
+=C2=A0 =C2=A0 smart-&gt;temperature =3D lduw_le_p(&amp;log.temperature); /=
* unaligned field */<br>
+=C2=A0 =C2=A0 smart-&gt;available_spare =3D log.available_spare;<br>
+=C2=A0 =C2=A0 smart-&gt;available_spare_threshold =3D log.available_spare_=
threshold;<br>
+=C2=A0 =C2=A0 smart-&gt;percentage_used =3D log.percentage_used;<br>
+=C2=A0 =C2=A0 smart-&gt;data_units_read_lo =3D le64_to_cpu(log.data_units_=
read[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;data_units_read_hi =3D le64_to_cpu(log.data_units_=
read[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;data_units_written_lo =3D le64_to_cpu(log.data_uni=
ts_written[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;data_units_written_hi =3D le64_to_cpu(log.data_uni=
ts_written[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;host_read_commands_lo =3D le64_to_cpu(log.host_rea=
d_commands[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;host_read_commands_hi =3D le64_to_cpu(log.host_rea=
d_commands[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;host_write_commands_lo =3D le64_to_cpu(log.host_wr=
ite_commands[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;host_write_commands_hi =3D le64_to_cpu(log.host_wr=
ite_commands[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;controller_busy_time_lo =3D le64_to_cpu(log.contro=
ller_busy_time[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;controller_busy_time_hi =3D le64_to_cpu(log.contro=
ller_busy_time[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;power_cycles_lo =3D le64_to_cpu(log.power_cycles[0=
]);<br>
+=C2=A0 =C2=A0 smart-&gt;power_cycles_hi =3D le64_to_cpu(log.power_cycles[1=
]);<br>
+=C2=A0 =C2=A0 smart-&gt;power_on_hours_lo =3D le64_to_cpu(log.power_on_hou=
rs[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;power_on_hours_hi =3D le64_to_cpu(log.power_on_hou=
rs[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;unsafe_shutdowns_lo =3D le64_to_cpu(log.unsafe_shu=
tdowns[0]);<br>
+=C2=A0 =C2=A0 smart-&gt;unsafe_shutdowns_hi =3D le64_to_cpu(log.unsafe_shu=
tdowns[1]);<br>
+=C2=A0 =C2=A0 smart-&gt;media_errors_lo =3D le64_to_cpu(log.media_errors[0=
]);<br>
+=C2=A0 =C2=A0 smart-&gt;media_errors_hi =3D le64_to_cpu(log.media_errors[1=
]);<br>
+=C2=A0 =C2=A0 smart-&gt;number_of_error_log_entries_lo =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64_to_cpu(log.number_of_error_log_entries[0]=
);<br>
+=C2=A0 =C2=A0 smart-&gt;number_of_error_log_entries_hi =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64_to_cpu(log.number_of_error_log_entries[1]=
);<br>
+<br>
+=C2=A0 =C2=A0 close(fd);<br>
+}<br>
+<br>
+static void get_disk_smart(GuestDiskInfo *disk)<br>
+{<br>
+=C2=A0 =C2=A0 if (disk-&gt;address<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (disk-&gt;address-&gt;bus_type =3D=
=3D GUEST_DISK_BUS_TYPE_NVME)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_nvme_smart(disk);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *ret =3D NULL;<br>
+=C2=A0 =C2=A0 GuestDiskInfo *disk;<br>
+=C2=A0 =C2=A0 DIR *dp =3D NULL;<br>
+=C2=A0 =C2=A0 struct dirent *de =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;listing /sys/block directory&quot;);<br>
+=C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/block&quot;);<br>
+=C2=A0 =C2=A0 if (dp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;Can&#39;t =
open directory \&quot;/sys/block\&quot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 while ((de =3D readdir(dp)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *disk_dir =3D NULL, *line =3D =
NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size_path =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (de-&gt;d_type !=3D DT_LNK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping en=
try: %s&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check size and skip zero-sized disks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 checking disk size&quot;)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_path =3D g_strdup_printf(&quot;/sys/block=
/%s/size&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_file_get_contents(size_path, &amp;line,=
 NULL, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to r=
ead disk size&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strcmp0(line, &quot;0\n&quot;) =3D=3D 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping ze=
ro-sized disk&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding %s&quot;, de-&gt;d=
_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir =3D g_strdup_printf(&quot;/sys/block/=
%s&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(disk_dir);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get devi=
ce name for syspath: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;name =3D dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;partition =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;alias =3D get_alias_for_syspath(disk_=
dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, disk);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get address for non-virtual devices */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_virtual =3D is_disk_virtual(disk_dir, =
&amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to c=
heck disk path, ignoring error: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_get_pretty(l=
ocal_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t try to get the addr=
ess */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_virtual =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_virtual) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;address =3D get_disk_ad=
dress(disk_dir, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=
=A0 failed to get device info, ignoring error: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_get_pretty(local_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_disk_deps(disk_dir, disk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_disk_smart(disk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_disk_partitions(ret, de-&gt;d_name=
, disk_dir, dev_name);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 closedir(dp);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+#else<br>
+<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+#endif<br>
+<br>
+/* Return a list of the disk device(s)&#39; info which @mount lies on */<b=
r>
+static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));<br>
+=C2=A0 =C2=A0 struct statvfs buf;<br>
+=C2=A0 =C2=A0 unsigned long used, nonroot_total, fr_size;<br>
+=C2=A0 =C2=A0 char *devpath =3D g_strdup_printf(&quot;/sys/dev/block/%u:%u=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mount-&gt;devmajor, mo=
unt-&gt;devminor);<br>
+<br>
+=C2=A0 =C2=A0 fs-&gt;mountpoint =3D g_strdup(mount-&gt;dirname);<br>
+=C2=A0 =C2=A0 fs-&gt;type =3D g_strdup(mount-&gt;devtype);<br>
+=C2=A0 =C2=A0 build_guest_fsinfo_for_device(devpath, fs, errp);<br>
+<br>
+=C2=A0 =C2=A0 if (statvfs(fs-&gt;mountpoint, &amp;buf) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fr_size =3D buf.f_frsize;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 used =3D buf.f_blocks - buf.f_bfree;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nonroot_total =3D used + buf.f_bavail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D used * fr_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D nonroot_total * fr_size=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes_privileged =3D buf.f_blocks=
 * fr_size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes_privileged =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(devpath);<br>
+<br>
+=C2=A0 =C2=A0 return fs;<br>
+}<br>
+<br>
+GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 FsMountList mounts;<br>
+=C2=A0 =C2=A0 struct FsMount *mount;<br>
+=C2=A0 =C2=A0 GuestFilesystemInfoList *ret =3D NULL;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_INIT(&amp;mounts);<br>
+=C2=A0 =C2=A0 if (!build_fs_mount_list(&amp;mounts, &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_FOREACH(mount, &amp;mounts, next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Building guest fsinfo for &#39;%=
s&#39;&quot;, mount-&gt;dirname);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, build_guest_fsinfo(moun=
t, &amp;local_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestFilesystemInfoLis=
t(ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free_fs_mount_list(&amp;mounts);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+#endif /* CONFIG_FSFREEZE */<br>
+<br>
+#if defined(CONFIG_FSTRIM)<br>
+/*<br>
+ * Walk list of mounted file systems in the guest, and trim them.<br>
+ */<br>
+GuestFilesystemTrimResponse *<br>
+qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestFilesystemTrimResponse *response;<br>
+=C2=A0 =C2=A0 GuestFilesystemTrimResult *result;<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+=C2=A0 =C2=A0 FsMountList mounts;<br>
+=C2=A0 =C2=A0 struct FsMount *mount;<br>
+=C2=A0 =C2=A0 int fd;<br>
+=C2=A0 =C2=A0 struct fstrim_range r;<br>
+<br>
+=C2=A0 =C2=A0 slog(&quot;guest-fstrim called&quot;);<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_INIT(&amp;mounts);<br>
+=C2=A0 =C2=A0 if (!build_fs_mount_list(&amp;mounts, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 response =3D g_malloc0(sizeof(*response));<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_FOREACH(mount, &amp;mounts, next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_malloc0(sizeof(*result));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;path =3D g_strdup(mount-&gt;dirname=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(response-&gt;paths, result);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D qga_open_cloexec(mount-&gt;dirname, O_R=
DONLY, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error =3D g_strdup_pr=
intf(&quot;failed to open: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We try to cull filesystems we know won&#39;=
t work in advance, but other<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* filesystems may not implement fstrim f=
or less obvious reasons.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* These will report EOPNOTSUPP; while in=
 some other cases ENOTTY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be reported (e.g. CD-ROMs).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Any other error means an unexpected er=
ror.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r.start =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r.len =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r.minlen =3D has_minimum ? minimum : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ioctl(fd, FITRIM, &amp;r);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOTTY || errno=
 =3D=3D EOPNOTSUPP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error =
=3D g_strdup(&quot;trim not supported&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error =
=3D g_strdup_printf(&quot;failed to trim: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_minimum =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;minimum =3D r.minlen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_trimmed =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;trimmed =3D r.len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free_fs_mount_list(&amp;mounts);<br>
+=C2=A0 =C2=A0 return response;<br>
+}<br>
+#endif /* CONFIG_FSTRIM */<br>
<br>
=C2=A0#define LINUX_SYS_STATE_FILE &quot;/sys/power/state&quot;<br>
=C2=A0#define SUSPEND_SUPPORTED 0<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index ef21da63be..98aafc45f3 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -24,23 +24,12 @@<br>
=C2=A0#include &quot;qemu/base64.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;commands-common.h&quot;<br>
-#include &quot;block/nvme.h&quot;<br>
=C2=A0#include &quot;cutils.h&quot;<br>
<br>
=C2=A0#ifdef HAVE_UTMPX<br>
=C2=A0#include &lt;utmpx.h&gt;<br>
=C2=A0#endif<br>
<br>
-#if defined(__linux__)<br>
-#include &lt;mntent.h&gt;<br>
-#include &lt;sys/statvfs.h&gt;<br>
-#include &lt;linux/nvme_ioctl.h&gt;<br>
-<br>
-#ifdef CONFIG_LIBUDEV<br>
-#include &lt;libudev.h&gt;<br>
-#endif<br>
-#endif<br>
-<br>
=C2=A0#ifdef HAVE_GETIFADDRS<br>
=C2=A0#include &lt;arpa/inet.h&gt;<br>
=C2=A0#include &lt;sys/socket.h&gt;<br>
@@ -842,904 +831,6 @@ static void guest_fsfreeze_cleanup(void)<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
-/* linux-specific implementations. avoid this if at all possible. */<br>
-#if defined(__linux__)<br>
-#if defined(CONFIG_FSFREEZE)<br>
-<br>
-static char *get_pci_driver(char const *syspath, int pathlen, Error **errp=
)<br>
-{<br>
-=C2=A0 =C2=A0 char *path;<br>
-=C2=A0 =C2=A0 char *dpath;<br>
-=C2=A0 =C2=A0 char *driver =3D NULL;<br>
-=C2=A0 =C2=A0 char buf[PATH_MAX];<br>
-=C2=A0 =C2=A0 ssize_t len;<br>
-<br>
-=C2=A0 =C2=A0 path =3D g_strndup(syspath, pathlen);<br>
-=C2=A0 =C2=A0 dpath =3D g_strdup_printf(&quot;%s/driver&quot;, path);<br>
-=C2=A0 =C2=A0 len =3D readlink(dpath, buf, sizeof(buf) - 1);<br>
-=C2=A0 =C2=A0 if (len !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[len] =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D g_path_get_basename(buf);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 g_free(dpath);<br>
-=C2=A0 =C2=A0 g_free(path);<br>
-=C2=A0 =C2=A0 return driver;<br>
-}<br>
-<br>
-static int compare_uint(const void *_a, const void *_b)<br>
-{<br>
-=C2=A0 =C2=A0 unsigned int a =3D *(unsigned int *)_a;<br>
-=C2=A0 =C2=A0 unsigned int b =3D *(unsigned int *)_b;<br>
-<br>
-=C2=A0 =C2=A0 return a &lt; b ? -1 : a &gt; b ? 1 : 0;<br>
-}<br>
-<br>
-/* Walk the specified sysfs and build a sorted list of host or ata numbers=
 */<br>
-static int build_hosts(char const *syspath, char const *host, bool ata,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0unsigned int *hosts, int hosts_max, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 char *path;<br>
-=C2=A0 =C2=A0 DIR *dir;<br>
-=C2=A0 =C2=A0 struct dirent *entry;<br>
-=C2=A0 =C2=A0 int i =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 path =3D g_strndup(syspath, host - syspath);<br>
-=C2=A0 =C2=A0 dir =3D opendir(path);<br>
-=C2=A0 =C2=A0 if (!dir) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;opendir(\&=
quot;%s\&quot;)&quot;, path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 while (i &lt; hosts_max) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D readdir(dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!entry) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ata &amp;&amp; sscanf(entry-&gt;d_name, &q=
uot;ata%d&quot;, hosts + i) =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!ata &amp;&amp; sscanf(entry-&gt;d_=
name, &quot;host%d&quot;, hosts + i) =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 qsort(hosts, i, sizeof(hosts[0]), compare_uint);<br>
-<br>
-=C2=A0 =C2=A0 g_free(path);<br>
-=C2=A0 =C2=A0 closedir(dir);<br>
-=C2=A0 =C2=A0 return i;<br>
-}<br>
-<br>
-/*<br>
- * Store disk device info for devices on the PCI bus.<br>
- * Returns true if information has been stored, or false for failure.<br>
- */<br>
-static bool build_guest_fsinfo_for_pci_dev(char const *syspath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GuestDiskAddress *disk,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 unsigned int pci[4], host, hosts[8], tgt[3];<br>
-=C2=A0 =C2=A0 int i, nhosts =3D 0, pcilen;<br>
-=C2=A0 =C2=A0 GuestPCIAddress *pciaddr =3D disk-&gt;pci_controller;<br>
-=C2=A0 =C2=A0 bool has_ata =3D false, has_host =3D false, has_tgt =3D fals=
e;<br>
-=C2=A0 =C2=A0 char *p, *q, *driver =3D NULL;<br>
-=C2=A0 =C2=A0 bool ret =3D false;<br>
-<br>
-=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/devices/pci&quot;);<br>
-=C2=A0 =C2=A0 if (!p || sscanf(p + 12, &quot;%*x:%*x/%x:%x:%x.%x%n&quot;,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pci, pci + 1, pci + 2, pci + 3, &amp;pcilen) &lt; 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;only pci device is supported: sy=
sfs path &#39;%s&#39;&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 p +=3D 12 + pcilen;<br>
-=C2=A0 =C2=A0 while (true) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D get_pci_driver(syspath, p - syspath=
, errp);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (driver &amp;&amp; (g_str_equal(driver, &qu=
ot;ata_piix&quot;) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;sym53c8xx&quot;) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;virtio-pci&quot;) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;ahci&quot;) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;nvme&quot;) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;xhci_hcd&quot;) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_str_equal(driver, &quot;ehci-pci&quot;))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(driver);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(p, &quot;/%x:%x:%x.%x%n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pci, pci + 1, pci + 2, pci + 3, &amp;pcilen) =3D=3D 4) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p +=3D pcilen;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;unsupported driver or sysfs path=
 &#39;%s&#39;&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/target&quot;);<br>
-=C2=A0 =C2=A0 if (p &amp;&amp; sscanf(p + 7, &quot;%*u:%*u:%*u/%*u:%u:%u:%=
u&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt,=
 tgt + 1, tgt + 2) =3D=3D 3) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_tgt =3D true;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/ata&quot;);<br>
-=C2=A0 =C2=A0 if (p) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D p + 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_ata =3D true;<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/host&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D p + 5;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (p &amp;&amp; sscanf(q, &quot;%u&quot;, &amp;host) =3D=3D=
 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_host =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 nhosts =3D build_hosts(syspath, p, has_ata, ho=
sts,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(hosts), errp);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nhosts &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 pciaddr-&gt;domain =3D pci[0];<br>
-=C2=A0 =C2=A0 pciaddr-&gt;bus =3D pci[1];<br>
-=C2=A0 =C2=A0 pciaddr-&gt;slot =3D pci[2];<br>
-=C2=A0 =C2=A0 pciaddr-&gt;function =3D pci[3];<br>
-<br>
-=C2=A0 =C2=A0 if (strcmp(driver, &quot;ata_piix&quot;) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* a host per ide bus, target*:0:&lt;unit&gt;:=
0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_host || !has_tgt) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;invalid sysfs path=
 &#39;%s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; nhosts; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host =3D=3D hosts[i]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =
=3D GUEST_DISK_BUS_TYPE_IDE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus =3D i=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D =
tgt[1];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D nhosts) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;no host for &#39;%=
s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;sym53c8xx&quot;) =3D=3D 0) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* scsi(LSI Logic): target*:0:&lt;unit&gt;:0 *=
/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_tgt) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;invalid sysfs path=
 &#39;%s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_SCSI=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D tgt[1];<br>
-=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;virtio-pci&quot;) =3D=3D 0) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_tgt) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-scsi: target*:0:0:&lt;=
unit&gt; */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK=
_BUS_TYPE_SCSI;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D tgt[2];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-blk: 1 disk per 1 devi=
ce */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK=
_BUS_TYPE_VIRTIO;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;ahci&quot;) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ahci: 1 host per 1 unit */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_host || !has_tgt) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;invalid sysfs path=
 &#39;%s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; nhosts; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host =3D=3D hosts[i]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D =
i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =
=3D GUEST_DISK_BUS_TYPE_SATA;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D nhosts) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;no host for &#39;%=
s&#39; (driver &#39;%s&#39;)&quot;, syspath, driver);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;nvme&quot;) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_NVME=
;<br>
-=C2=A0 =C2=A0 } else if (strcmp(driver, &quot;ehci-pci&quot;) =3D=3D 0 || =
strcmp(driver, &quot;xhci_hcd&quot;) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_USB;=
<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;unknown driver &#39;%s&#39; (sys=
fs path &#39;%s&#39;)&quot;, driver, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 ret =3D true;<br>
-<br>
-cleanup:<br>
-=C2=A0 =C2=A0 g_free(driver);<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-/*<br>
- * Store disk device info for non-PCI virtio devices (for example s390x<br=
>
- * channel I/O devices). Returns true if information has been stored, or<b=
r>
- * false for failure.<br>
- */<br>
-static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0GuestDiskAddress *disk,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 unsigned int tgt[3];<br>
-=C2=A0 =C2=A0 char *p;<br>
-<br>
-=C2=A0 =C2=A0 if (!strstr(syspath, &quot;/virtio&quot;) || !strstr(syspath=
, &quot;/block&quot;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Unsupported virtio device &#39;%=
s&#39;&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/target&quot;);<br>
-=C2=A0 =C2=A0 if (p &amp;&amp; sscanf(p + 7, &quot;%*u:%*u:%*u/%*u:%u:%u:%=
u&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;tgt[0], &amp;tgt[1], &amp;tgt[2]) =3D=3D 3) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-scsi: target*:0:&lt;target&gt;:&lt;u=
nit&gt; */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_SCSI=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus =3D tgt[0];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;target =3D tgt[1];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;unit =3D tgt[2];<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* virtio-blk: 1 disk per 1 device */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_VIRT=
IO;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
-/*<br>
- * Store disk device info for CCW devices (s390x channel I/O devices).<br>
- * Returns true if information has been stored, or false for failure.<br>
- */<br>
-static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GuestDiskAddress *disk,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 unsigned int cssid, ssid, subchno, devno;<br>
-=C2=A0 =C2=A0 char *p;<br>
-<br>
-=C2=A0 =C2=A0 p =3D strstr(syspath, &quot;/devices/css&quot;);<br>
-=C2=A0 =C2=A0 if (!p || sscanf(p + 12, &quot;%*x/%x.%x.%x/%*x.%*x.%x/&quot=
;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;cssid, &amp;ssid, &amp;subchno, &amp;devno) &lt; 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;could not parse ccw device sysfs=
 path: %s&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 disk-&gt;ccw_address =3D g_new0(GuestCCWAddress, 1);<br>
-=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;cssid =3D cssid;<br>
-=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;ssid =3D ssid;<br>
-=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;subchno =3D subchno;<br>
-=C2=A0 =C2=A0 disk-&gt;ccw_address-&gt;devno =3D devno;<br>
-<br>
-=C2=A0 =C2=A0 if (strstr(p, &quot;/virtio&quot;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_nonpci_virtio(syspath, =
disk, errp);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
-/* Store disk device info specified by @sysfs into @fs */<br>
-static void build_guest_fsinfo_for_real_device(char const *syspath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GuestFilesystemInfo *fs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestDiskAddress *disk;<br>
-=C2=A0 =C2=A0 GuestPCIAddress *pciaddr;<br>
-=C2=A0 =C2=A0 bool has_hwinf;<br>
-#ifdef CONFIG_LIBUDEV<br>
-=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
-=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
-#endif<br>
-<br>
-=C2=A0 =C2=A0 pciaddr =3D g_new0(GuestPCIAddress, 1);<br>
-=C2=A0 =C2=A0 pciaddr-&gt;domain =3D -1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* -1 means field is inval=
id */<br>
-=C2=A0 =C2=A0 pciaddr-&gt;bus =3D -1;<br>
-=C2=A0 =C2=A0 pciaddr-&gt;slot =3D -1;<br>
-=C2=A0 =C2=A0 pciaddr-&gt;function =3D -1;<br>
-<br>
-=C2=A0 =C2=A0 disk =3D g_new0(GuestDiskAddress, 1);<br>
-=C2=A0 =C2=A0 disk-&gt;pci_controller =3D pciaddr;<br>
-=C2=A0 =C2=A0 disk-&gt;bus_type =3D GUEST_DISK_BUS_TYPE_UNKNOWN;<br>
-<br>
-#ifdef CONFIG_LIBUDEV<br>
-=C2=A0 =C2=A0 udev =3D udev_new();<br>
-=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
-=C2=A0 =C2=A0 if (udev =3D=3D NULL || udevice =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *devnode, *serial;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 devnode =3D udev_device_get_devnode(udevice);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devnode !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;dev =3D g_strdup(devnod=
e);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial =3D udev_device_get_property_value(udev=
ice, &quot;ID_SERIAL&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (serial !=3D NULL &amp;&amp; *serial !=3D 0=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;serial =3D g_strdup(ser=
ial);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 udev_unref(udev);<br>
-=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
-#endif<br>
-<br>
-=C2=A0 =C2=A0 if (strstr(syspath, &quot;/devices/pci&quot;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D build_guest_fsinfo_for_pci_dev(s=
yspath, disk, errp);<br>
-=C2=A0 =C2=A0 } else if (strstr(syspath, &quot;/devices/css&quot;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D build_guest_fsinfo_for_ccw_dev(s=
yspath, disk, errp);<br>
-=C2=A0 =C2=A0 } else if (strstr(syspath, &quot;/virtio&quot;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D build_guest_fsinfo_for_nonpci_vi=
rtio(syspath, disk, errp);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Unsupported device type for &#39=
;%s&#39;&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_hwinf =3D false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (has_hwinf || disk-&gt;dev || disk-&gt;serial) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(fs-&gt;disk, disk);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestDiskAddress(disk);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static void build_guest_fsinfo_for_device(char const *devpath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
uestFilesystemInfo *fs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
rror **errp);<br>
-<br>
-/* Store a list of slave devices of virtual volume specified by @syspath i=
nto<br>
- * @fs */<br>
-static void build_guest_fsinfo_for_virtual_device(char const *syspath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestFilesystemInfo *fs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 Error *err =3D NULL;<br>
-=C2=A0 =C2=A0 DIR *dir;<br>
-=C2=A0 =C2=A0 char *dirpath;<br>
-=C2=A0 =C2=A0 struct dirent *entry;<br>
-<br>
-=C2=A0 =C2=A0 dirpath =3D g_strdup_printf(&quot;%s/slaves&quot;, syspath);=
<br>
-=C2=A0 =C2=A0 dir =3D opendir(dirpath);<br>
-=C2=A0 =C2=A0 if (!dir) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;opendir(\&quot;%s\&quot;)&quot;, dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 for (;;) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D readdir(dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(e=
rrp, errno, &quot;readdir(\&quot;%s\&quot;)&quot;, dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry-&gt;d_type =3D=3D DT_LNK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *path;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot; slave device &#39=
;%s&#39;&quot;, entry-&gt;d_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D g_strdup_printf(&quot;%=
s/slaves/%s&quot;, syspath, entry-&gt;d_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_device(pa=
th, fs, &amp;err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(path);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(er=
rp, err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 g_free(dirpath);<br>
-=C2=A0 =C2=A0 closedir(dir);<br>
-}<br>
-<br>
-static bool is_disk_virtual(const char *devpath, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 g_autofree char *syspath =3D realpath(devpath, NULL);<br>
-<br>
-=C2=A0 =C2=A0 if (!syspath) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;realpath(\=
&quot;%s\&quot;)&quot;, devpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return strstr(syspath, &quot;/devices/virtual/block/&quot;) =
!=3D NULL;<br>
-}<br>
-<br>
-/* Dispatch to functions for virtual/real device */<br>
-static void build_guest_fsinfo_for_device(char const *devpath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
uestFilesystemInfo *fs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
rror **errp)<br>
-{<br>
-=C2=A0 =C2=A0 ERRP_GUARD();<br>
-=C2=A0 =C2=A0 g_autofree char *syspath =3D NULL;<br>
-=C2=A0 =C2=A0 bool is_virtual =3D false;<br>
-<br>
-=C2=A0 =C2=A0 syspath =3D realpath(devpath, NULL);<br>
-=C2=A0 =C2=A0 if (!syspath) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;realpath(\&quot;%s\&quot;)&quot;, devpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ENOENT: This devpath may not exist because =
of container config */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fs-&gt;name) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;name =3D g_path_get_basen=
ame(devpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (!fs-&gt;name) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;name =3D g_path_get_basename(syspath);<=
br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 g_debug(&quot;=C2=A0 parse sysfs path &#39;%s&#39;&quot;, sy=
spath);<br>
-=C2=A0 =C2=A0 is_virtual =3D is_disk_virtual(syspath, errp);<br>
-=C2=A0 =C2=A0 if (*errp !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (is_virtual) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_virtual_device(syspath,=
 fs, errp);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_guest_fsinfo_for_real_device(syspath, fs=
, errp);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-#ifdef CONFIG_LIBUDEV<br>
-<br>
-/*<br>
- * Wrapper around build_guest_fsinfo_for_device() for getting just<br>
- * the disk address.<br>
- */<br>
-static GuestDiskAddress *get_disk_address(const char *syspath, Error **err=
p)<br>
-{<br>
-=C2=A0 =C2=A0 g_autoptr(GuestFilesystemInfo) fs =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 fs =3D g_new0(GuestFilesystemInfo, 1);<br>
-=C2=A0 =C2=A0 build_guest_fsinfo_for_device(syspath, fs, errp);<br>
-=C2=A0 =C2=A0 if (fs-&gt;disk !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;fs-&gt;disk-&gt;va=
lue);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-static char *get_alias_for_syspath(const char *syspath)<br>
-{<br>
-=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
-=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
-=C2=A0 =C2=A0 char *ret =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 udev =3D udev_new();<br>
-=C2=A0 =C2=A0 if (udev =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
-=C2=A0 =C2=A0 if (udevice =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev for path: %=
s&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *alias =3D udev_device_get_property=
_value(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udevice, &quot;DM_NAME&quot;);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* NULL means there was an error and empt=
y string means there is no<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* alias. In case of no alias we return N=
ULL instead of empty string.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (alias =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query ud=
ev for device alias for: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*alias !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(alias);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-out:<br>
-=C2=A0 =C2=A0 udev_unref(udev);<br>
-=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-static char *get_device_for_syspath(const char *syspath)<br>
-{<br>
-=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
-=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
-=C2=A0 =C2=A0 char *ret =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 udev =3D udev_new();<br>
-=C2=A0 =C2=A0 if (udev =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
-=C2=A0 =C2=A0 if (udevice =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev for path: %=
s&quot;, syspath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(udev_device_get_devnode(udevi=
ce));<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-out:<br>
-=C2=A0 =C2=A0 udev_unref(udev);<br>
-=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)<br>
-{<br>
-=C2=A0 =C2=A0 g_autofree char *deps_dir =3D NULL;<br>
-=C2=A0 =C2=A0 const gchar *dep;<br>
-=C2=A0 =C2=A0 GDir *dp_deps =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 /* List dependent disks */<br>
-=C2=A0 =C2=A0 deps_dir =3D g_strdup_printf(&quot;%s/slaves&quot;, disk_dir=
);<br>
-=C2=A0 =C2=A0 g_debug(&quot;=C2=A0 listing entries in: %s&quot;, deps_dir)=
;<br>
-=C2=A0 =C2=A0 dp_deps =3D g_dir_open(deps_dir, 0, NULL);<br>
-=C2=A0 =C2=A0 if (dp_deps =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to list entries in %s&quo=
t;, deps_dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 disk-&gt;has_dependencies =3D true;<br>
-=C2=A0 =C2=A0 while ((dep =3D g_dir_read_name(dp_deps)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *dep_dir =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add dependent disks */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dep_dir =3D g_strdup_printf(&quot;%s/%s&quot;,=
 deps_dir, dep);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(dep_dir);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding depe=
ndent device: %s&quot;, dev_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(disk-&gt;depen=
dencies, dev_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 g_dir_close(dp_deps);<br>
-}<br>
-<br>
-/*<br>
- * Detect partitions subdirectory, name is &quot;&lt;disk_name&gt;&lt;numb=
er&gt;&quot; or<br>
- * &quot;&lt;disk_name&gt;p&lt;number&gt;&quot;<br>
- *<br>
- * @disk_name -- last component of /sys path (e.g. sda)<br>
- * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)<br>
- * @disk_dev -- device node of the disk (e.g. /dev/sda)<br>
- */<br>
-static GuestDiskInfoList *get_disk_partitions(<br>
-=C2=A0 =C2=A0 GuestDiskInfoList *list,<br>
-=C2=A0 =C2=A0 const char *disk_name, const char *disk_dir,<br>
-=C2=A0 =C2=A0 const char *disk_dev)<br>
-{<br>
-=C2=A0 =C2=A0 GuestDiskInfoList *ret =3D list;<br>
-=C2=A0 =C2=A0 struct dirent *de_disk;<br>
-=C2=A0 =C2=A0 DIR *dp_disk =3D NULL;<br>
-=C2=A0 =C2=A0 size_t len =3D strlen(disk_name);<br>
-<br>
-=C2=A0 =C2=A0 dp_disk =3D opendir(disk_dir);<br>
-=C2=A0 =C2=A0 while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *partition_dir =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskInfo *partition;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(de_disk-&gt;d_type &amp; DT_DIR)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(strncmp(disk_name, de_disk-&gt;d_name, l=
en) =3D=3D 0 &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((*(de_disk-&gt;d_name + len) =
=3D=3D &#39;p&#39; &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-&gt;d_name + l=
en + 1))) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-=
&gt;d_name + len))))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition_dir =3D g_strdup_printf(&quot;%s/%s&=
quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir, de_disk-&gt;d_name);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(partition_=
dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get devi=
ce name for syspath: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition =3D g_new0(GuestDiskInfo, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;name =3D dev_name;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;partition =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;has_dependencies =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add parent disk as dependent for easier tra=
cking of hierarchy */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(partition-&gt;dependencies, =
g_strdup(disk_dev));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, partition);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 closedir(dp_disk);<br>
-<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-static void get_nvme_smart(GuestDiskInfo *disk)<br>
-{<br>
-=C2=A0 =C2=A0 int fd;<br>
-=C2=A0 =C2=A0 GuestNVMeSmart *smart;<br>
-=C2=A0 =C2=A0 NvmeSmartLog log =3D {0};<br>
-=C2=A0 =C2=A0 struct nvme_admin_cmd cmd =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .opcode =3D NVME_ADM_CMD_GET_LOG_PAGE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .nsid =3D NVME_NSID_BROADCAST,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .addr =3D (uintptr_t)&amp;log,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .data_len =3D sizeof(log),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cdw10 =3D NVME_LOG_SMART_INFO | (1 &lt;&lt; 1=
5) /* RAE bit */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (((sizeof(=
log) &gt;&gt; 2) - 1) &lt;&lt; 16)<br>
-=C2=A0 =C2=A0 };<br>
-<br>
-=C2=A0 =C2=A0 fd =3D qga_open_cloexec(disk-&gt;name, O_RDONLY, 0);<br>
-=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to open device: %s: %s&qu=
ot;, disk-&gt;name, g_strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &amp;cmd)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get smart: %s: %s&quot=
;, disk-&gt;name, g_strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 disk-&gt;smart =3D g_new0(GuestDiskSmart, 1);<br>
-=C2=A0 =C2=A0 disk-&gt;smart-&gt;type =3D GUEST_DISK_BUS_TYPE_NVME;<br>
-<br>
-=C2=A0 =C2=A0 smart =3D &amp;disk-&gt;smart-&gt;u.nvme;<br>
-=C2=A0 =C2=A0 smart-&gt;critical_warning =3D log.critical_warning;<br>
-=C2=A0 =C2=A0 smart-&gt;temperature =3D lduw_le_p(&amp;log.temperature); /=
* unaligned field */<br>
-=C2=A0 =C2=A0 smart-&gt;available_spare =3D log.available_spare;<br>
-=C2=A0 =C2=A0 smart-&gt;available_spare_threshold =3D log.available_spare_=
threshold;<br>
-=C2=A0 =C2=A0 smart-&gt;percentage_used =3D log.percentage_used;<br>
-=C2=A0 =C2=A0 smart-&gt;data_units_read_lo =3D le64_to_cpu(log.data_units_=
read[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;data_units_read_hi =3D le64_to_cpu(log.data_units_=
read[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;data_units_written_lo =3D le64_to_cpu(log.data_uni=
ts_written[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;data_units_written_hi =3D le64_to_cpu(log.data_uni=
ts_written[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;host_read_commands_lo =3D le64_to_cpu(log.host_rea=
d_commands[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;host_read_commands_hi =3D le64_to_cpu(log.host_rea=
d_commands[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;host_write_commands_lo =3D le64_to_cpu(log.host_wr=
ite_commands[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;host_write_commands_hi =3D le64_to_cpu(log.host_wr=
ite_commands[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;controller_busy_time_lo =3D le64_to_cpu(log.contro=
ller_busy_time[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;controller_busy_time_hi =3D le64_to_cpu(log.contro=
ller_busy_time[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;power_cycles_lo =3D le64_to_cpu(log.power_cycles[0=
]);<br>
-=C2=A0 =C2=A0 smart-&gt;power_cycles_hi =3D le64_to_cpu(log.power_cycles[1=
]);<br>
-=C2=A0 =C2=A0 smart-&gt;power_on_hours_lo =3D le64_to_cpu(log.power_on_hou=
rs[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;power_on_hours_hi =3D le64_to_cpu(log.power_on_hou=
rs[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;unsafe_shutdowns_lo =3D le64_to_cpu(log.unsafe_shu=
tdowns[0]);<br>
-=C2=A0 =C2=A0 smart-&gt;unsafe_shutdowns_hi =3D le64_to_cpu(log.unsafe_shu=
tdowns[1]);<br>
-=C2=A0 =C2=A0 smart-&gt;media_errors_lo =3D le64_to_cpu(log.media_errors[0=
]);<br>
-=C2=A0 =C2=A0 smart-&gt;media_errors_hi =3D le64_to_cpu(log.media_errors[1=
]);<br>
-=C2=A0 =C2=A0 smart-&gt;number_of_error_log_entries_lo =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64_to_cpu(log.number_of_error_log_entries[0]=
);<br>
-=C2=A0 =C2=A0 smart-&gt;number_of_error_log_entries_hi =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64_to_cpu(log.number_of_error_log_entries[1]=
);<br>
-<br>
-=C2=A0 =C2=A0 close(fd);<br>
-}<br>
-<br>
-static void get_disk_smart(GuestDiskInfo *disk)<br>
-{<br>
-=C2=A0 =C2=A0 if (disk-&gt;address<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (disk-&gt;address-&gt;bus_type =3D=
=3D GUEST_DISK_BUS_TYPE_NVME)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_nvme_smart(disk);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestDiskInfoList *ret =3D NULL;<br>
-=C2=A0 =C2=A0 GuestDiskInfo *disk;<br>
-=C2=A0 =C2=A0 DIR *dp =3D NULL;<br>
-=C2=A0 =C2=A0 struct dirent *de =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 g_debug(&quot;listing /sys/block directory&quot;);<br>
-=C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/block&quot;);<br>
-=C2=A0 =C2=A0 if (dp =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;Can&#39;t =
open directory \&quot;/sys/block\&quot;&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 while ((de =3D readdir(dp)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *disk_dir =3D NULL, *line =3D =
NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size_path =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (de-&gt;d_type !=3D DT_LNK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping en=
try: %s&quot;, de-&gt;d_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check size and skip zero-sized disks */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 checking disk size&quot;)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_path =3D g_strdup_printf(&quot;/sys/block=
/%s/size&quot;, de-&gt;d_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_file_get_contents(size_path, &amp;line,=
 NULL, NULL)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to r=
ead disk size&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strcmp0(line, &quot;0\n&quot;) =3D=3D 0)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping ze=
ro-sized disk&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding %s&quot;, de-&gt;d=
_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir =3D g_strdup_printf(&quot;/sys/block/=
%s&quot;, de-&gt;d_name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(disk_dir);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get devi=
ce name for syspath: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk =3D g_new0(GuestDiskInfo, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;name =3D dev_name;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;partition =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;alias =3D get_alias_for_syspath(disk_=
dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, disk);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get address for non-virtual devices */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_virtual =3D is_disk_virtual(disk_dir, =
&amp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to c=
heck disk path, ignoring error: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_get_pretty(l=
ocal_err));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t try to get the addr=
ess */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_virtual =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_virtual) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;address =3D get_disk_ad=
dress(disk_dir, &amp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=
=A0 failed to get device info, ignoring error: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_get_pretty(local_err));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_disk_deps(disk_dir, disk);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_disk_smart(disk);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_disk_partitions(ret, de-&gt;d_name=
, disk_dir, dev_name);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 closedir(dp);<br>
-<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-#else<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-#endif<br>
-<br>
-/* Return a list of the disk device(s)&#39; info which @mount lies on */<b=
r>
-static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));<br>
-=C2=A0 =C2=A0 struct statvfs buf;<br>
-=C2=A0 =C2=A0 unsigned long used, nonroot_total, fr_size;<br>
-=C2=A0 =C2=A0 char *devpath =3D g_strdup_printf(&quot;/sys/dev/block/%u:%u=
&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mount-&gt;devmajor, mo=
unt-&gt;devminor);<br>
-<br>
-=C2=A0 =C2=A0 fs-&gt;mountpoint =3D g_strdup(mount-&gt;dirname);<br>
-=C2=A0 =C2=A0 fs-&gt;type =3D g_strdup(mount-&gt;devtype);<br>
-=C2=A0 =C2=A0 build_guest_fsinfo_for_device(devpath, fs, errp);<br>
-<br>
-=C2=A0 =C2=A0 if (statvfs(fs-&gt;mountpoint, &amp;buf) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fr_size =3D buf.f_frsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 used =3D buf.f_blocks - buf.f_bfree;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 nonroot_total =3D used + buf.f_bavail;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D used * fr_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D nonroot_total * fr_size=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes_privileged =3D buf.f_blocks=
 * fr_size;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes_privileged =3D true;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D true;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 g_free(devpath);<br>
-<br>
-=C2=A0 =C2=A0 return fs;<br>
-}<br>
-<br>
-GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 FsMountList mounts;<br>
-=C2=A0 =C2=A0 struct FsMount *mount;<br>
-=C2=A0 =C2=A0 GuestFilesystemInfoList *ret =3D NULL;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 QTAILQ_INIT(&amp;mounts);<br>
-=C2=A0 =C2=A0 if (!build_fs_mount_list(&amp;mounts, &amp;local_err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 QTAILQ_FOREACH(mount, &amp;mounts, next) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Building guest fsinfo for &#39;%=
s&#39;&quot;, mount-&gt;dirname);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, build_guest_fsinfo(moun=
t, &amp;local_err));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestFilesystemInfoLis=
t(ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 free_fs_mount_list(&amp;mounts);<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-#endif /* CONFIG_FSFREEZE */<br>
-<br>
-#if defined(CONFIG_FSTRIM)<br>
-/*<br>
- * Walk list of mounted file systems in the guest, and trim them.<br>
- */<br>
-GuestFilesystemTrimResponse *<br>
-qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestFilesystemTrimResponse *response;<br>
-=C2=A0 =C2=A0 GuestFilesystemTrimResult *result;<br>
-=C2=A0 =C2=A0 int ret =3D 0;<br>
-=C2=A0 =C2=A0 FsMountList mounts;<br>
-=C2=A0 =C2=A0 struct FsMount *mount;<br>
-=C2=A0 =C2=A0 int fd;<br>
-=C2=A0 =C2=A0 struct fstrim_range r;<br>
-<br>
-=C2=A0 =C2=A0 slog(&quot;guest-fstrim called&quot;);<br>
-<br>
-=C2=A0 =C2=A0 QTAILQ_INIT(&amp;mounts);<br>
-=C2=A0 =C2=A0 if (!build_fs_mount_list(&amp;mounts, errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 response =3D g_malloc0(sizeof(*response));<br>
-<br>
-=C2=A0 =C2=A0 QTAILQ_FOREACH(mount, &amp;mounts, next) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_malloc0(sizeof(*result));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;path =3D g_strdup(mount-&gt;dirname=
);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(response-&gt;paths, result);=
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D qga_open_cloexec(mount-&gt;dirname, O_R=
DONLY, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error =3D g_strdup_pr=
intf(&quot;failed to open: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We try to cull filesystems we know won&#39;=
t work in advance, but other<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* filesystems may not implement fstrim f=
or less obvious reasons.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* These will report EOPNOTSUPP; while in=
 some other cases ENOTTY<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be reported (e.g. CD-ROMs).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Any other error means an unexpected er=
ror.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 r.start =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 r.len =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 r.minlen =3D has_minimum ? minimum : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ioctl(fd, FITRIM, &amp;r);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOTTY || errno=
 =3D=3D EOPNOTSUPP) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error =
=3D g_strdup(&quot;trim not supported&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error =
=3D g_strdup_printf(&quot;failed to trim: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_minimum =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;minimum =3D r.minlen;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_trimmed =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;trimmed =3D r.len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 free_fs_mount_list(&amp;mounts);<br>
-=C2=A0 =C2=A0 return response;<br>
-}<br>
-#endif /* CONFIG_FSTRIM */<br>
-<br>
-#endif /* __linux__ */<br>
-<br>
=C2=A0#if defined(__linux__) || defined(__FreeBSD__)<br>
=C2=A0void qmp_guest_set_user_password(const char *username,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *password,<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000005cc8b2061d08ae38--


