Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7933CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 21:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT79E-0002oH-2A; Thu, 25 Jan 2024 16:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rT79C-0002o0-Tq
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 16:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rT79A-0005bI-Qz
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 16:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706217622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2QQqPiaaVwpeUdebjBMS6BJmwEKQzrI7u6VH3bIqyQ=;
 b=I07C+PS6+Dqwu4buti+dEC2dTU9tagPG4zR9kVs2Hpo7Y5i7rq/+1g7IC44W8RbqLtLtZ4
 f6WFc5qcZG0iDk2c37ec/hDQngn+kcqzgrIe62+yX1TuwGGWEDMVFRPfdgSqENmOOWHr2g
 kIyEbPoz0olV5SH42dgtOiF7mhyAp2k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-FVkVQQTXO2ONiyI0iqOKtA-1; Thu, 25 Jan 2024 16:20:19 -0500
X-MC-Unique: FVkVQQTXO2ONiyI0iqOKtA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d740687d8dso11038545ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 13:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706217618; x=1706822418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2QQqPiaaVwpeUdebjBMS6BJmwEKQzrI7u6VH3bIqyQ=;
 b=bvgXvm5eyH+bsueidgx0aSOq3C4yPqqw1KRpBlZY0Uh7j0sBHulMnVrnsquQr8PodV
 NP02C+jQJhEJcCevqxab5DcFED/o5XxsfdwREm4wxdetJ3jD12qjZnxc/abbrnDuAW72
 sealu7xcHk+3TCMRuZafdEi+5+UgXhomyq3AwQzBfZsMGK7z9uEu40k2OkF2lmUPTLbx
 t9smIQJG5RmwZGS6gQc1wjr8QKTVAs0TBQGnhL/ibfDwKWurYoOYicbHwqIBjpTi8Vjy
 bJtWSyEP0k2DfreKIE7/h+6M3hQT+Z5ywII00Rw6cloTDD+IXmlsaRuQ6radH9OXN0+a
 KJRg==
X-Gm-Message-State: AOJu0YwkXs2WPSmxtOu1k1AjFefb/5A6PHhEVfYP6iQuYv5wJ3zQTDMT
 UxCdRMKRtDLZvpKnP8PbPkoiKAr5Omvzomgi49S4g6vxeZrg+OGp3pT7BVx3gTGitKcv6t/KhME
 chnrMxUryEk9xBTZTmYb4csqarheNGHMsHoaBsTNZp52imcd6qV1A
X-Received: by 2002:a17:903:451:b0:1d4:462a:60bd with SMTP id
 iw17-20020a170903045100b001d4462a60bdmr181701plb.55.1706217618194; 
 Thu, 25 Jan 2024 13:20:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/fJi5/Izdlc47BdAF7+PSRQHXgPqI6KFXh92vqtB+mdoLn5KqFkzHCBwUtDJne50vypTykg==
X-Received: by 2002:a17:903:451:b0:1d4:462a:60bd with SMTP id
 iw17-20020a170903045100b001d4462a60bdmr181688plb.55.1706217617801; 
 Thu, 25 Jan 2024 13:20:17 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 f5-20020a170902860500b001d7623fc8a5sm5701859plo.143.2024.01.25.13.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 13:20:17 -0800 (PST)
Date: Thu, 25 Jan 2024 14:20:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann
 <kraxel@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Message-ID: <20240125142014.6c62126a.alex.williamson@redhat.com>
In-Reply-To: <8d85ff1d-fed9-49c9-9fe3-b401e0921533@redhat.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
 <8d85ff1d-fed9-49c9-9fe3-b401e0921533@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 25 Jan 2024 09:18:02 +0100
Eric Auger <eauger@redhat.com> wrote:

> Hi Vivek,
>=20
> On 1/18/24 20:20, Vivek Kasireddy wrote:
> > Recent updates in OVMF and Seabios have resulted in MMIO regions
> > being placed at the upper end of the physical address space. As a
> > result, when a Host device is assigned to the Guest via VFIO, the
> > following mapping failures occur when VFIO tries to map the MMIO
> > regions of the device:
> > VFIO_MAP_DMA failed: Invalid argument
> > vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 0x7f98ac400000)=
 =3D -22 (Invalid argument)
> >=20
> > The above failures are mainly seen on some Intel platforms where
> > the physical address width is larger than the Host's IOMMU
> > address width. In these cases, VFIO fails to map the MMIO regions
> > because the IOVAs would be larger than the IOMMU aperture regions.
> >=20
> > Therefore, one way to solve this problem would be to ensure that
> > cpu->phys_bits =3D <IOMMU phys_bits>
> > This can be done by parsing the IOMMU caps value from sysfs and
> > extracting the address width and using it to override the
> > phys_bits value as shown in this patch.
> >=20
> > Previous attempt at solving this issue in OVMF:
> > https://edk2.groups.io/g/devel/topic/102359124
> >=20
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Dongwon Kim <dongwon.kim@intel.com>
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > Tested-by: Yanghang Liu <yanghliu@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >=20
> > ---
> > v2:
> > - Replace the term passthrough with assigned (Laszlo)
> > - Update the commit message to note that both OVMF and Seabios
> >   guests are affected (C=C3=A9dric)
> > - Update the subject to indicate what is done in the patch
> > ---
> >  target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> > index 92ecb7254b..5c9fcd7dc2 100644
> > --- a/target/i386/host-cpu.c
> > +++ b/target/i386/host-cpu.c
> > @@ -12,6 +12,8 @@
> >  #include "host-cpu.h"
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> > +#include "qemu/config-file.h"
> > +#include "qemu/option.h"
> >  #include "sysemu/sysemu.h"
> > =20
> >  /* Note: Only safe for use on x86(-64) hosts */
> > @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
> >      env->features[FEAT_1_ECX] |=3D CPUID_EXT_MONITOR;
> >  }
> > =20
> > +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error **err=
p)
> > +{
> > +    g_autofree char *dev_path =3D NULL, *iommu_path =3D NULL, *caps =
=3D NULL;
> > +    const char *driver =3D qemu_opt_get(opts, "driver");
> > +    const char *device =3D qemu_opt_get(opts, "host");
> > +    uint32_t *iommu_phys_bits =3D opaque;
> > +    struct stat st;
> > +    uint64_t iommu_caps;
> > +
> > +    /*
> > +     * Check if the user requested VFIO device assignment. We don't ha=
ve
> > +     * to limit phys_bits if there are no valid assigned devices.
> > +     */
> > +    if (g_strcmp0(driver, "vfio-pci") || !device) {
> > +        return 0;
> > +    }
> > +
> > +    dev_path =3D g_strdup_printf("/sys/bus/pci/devices/%s", device);
> > +    if (stat(dev_path, &st) < 0) {
> > +        return 0;
> > +    }
> > +
> > +    iommu_path =3D g_strdup_printf("%s/iommu/intel-iommu/cap", dev_pat=
h);
> > +    if (stat(iommu_path, &st) < 0) {
> > +        return 0;
> > +    }
> > +
> > +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
> > +        if (sscanf(caps, "%lx", &iommu_caps) !=3D 1) {
> > +            return 0;
> > +        }
> > +        *iommu_phys_bits =3D ((iommu_caps >> 16) & 0x3f) + 1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static uint32_t host_iommu_phys_bits(void)
> > +{
> > +    uint32_t iommu_phys_bits =3D 0;
> > +
> > +    qemu_opts_foreach(qemu_find_opts("device"),
> > +                      intel_iommu_check, &iommu_phys_bits, NULL);
> > +    return iommu_phys_bits;
> > +}
> > +
> >  static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
> >  {
> >      uint32_t host_phys_bits =3D host_cpu_phys_bits();
> > +    uint32_t iommu_phys_bits =3D host_iommu_phys_bits();
> >      uint32_t phys_bits =3D cpu->phys_bits;
> > -    static bool warned;
> > +    static bool warned, warned2;
> > =20
> >      /*
> >       * Print a warning if the user set it to a value that's not the
> > @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *c=
pu)
> >          }
> >      }
> > =20
> > +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
> > +        phys_bits =3D iommu_phys_bits; =20
> are you allowed to change the host cpu characteristics without taking
> care of compats for migration?

Not only is migration an issue, but so is hotplug.  Anything that
aligns the VM configuration to the host is going to have migration
issues and anything that does so conditionally based on the current set
of attached devices will have hotplug issues.

It'd be more prudent to find the least common denominator under
/sys/class/iommu/dmar*/intel-iommu/cap regardless of attached devices,
but it still affects migration compatibility between hosts.

Also note that vfio-pci can specify the device with either host=3D or
sysfsdev=3D and with vfio cdev support and iommufd the file descriptor
for the vfio device might be passed via SCM rights, so we may not have
a reference to it in sysfs.  The above appears to only work with the
host=3D device specification.  Thanks,

Alex


