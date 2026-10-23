Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F317606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DRlWCrKs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKN1n-0000M5-Kh; Fri, 23 Oct 2026 17:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xKN1h-0000Lj-Rp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:42:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xKN1b-00072e-Vk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:42:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a018493d57so17255e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 14:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792791723; cv=none;
 d=google.com; s=arc-20260327;
 b=szdZZiVqE8Z/qFMovTACKIH3wz1f+V049JKUXQ7rKxDSNvVTpgpJi1xDNLCtUIkvCM
 jnhctWtIjA8pbvR9seNOKnaQEycEu8FJ4tCwrFs9e8/hVhLJelYP7PKmslra3DeNLnAH
 HWj/IFoRVDKqoTCAo4hvyNwsp+5pBDp0D6tN8b1vM6mRwT2GcB6MsUC2WUMMuSC6wzjK
 YjzrPFJA+XZzWs4BNtpvoh9dSeLaTTIifhpceSjwyvepCGDw3t3/fXomXWkZ4q99AKp1
 TmKnoRHrJS4o7C31/+g0CQ+/4iXvtqDwZSkpi1k+YM6d7sqU3Ld1Cyru2XhyC0jpVEa1
 3Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WEqi1MLcz/HNnxQ0ZF3J+qhLhm4FJoaVJ92k/XQror8=;
 fh=kIMaH1p4WQKPaRtcLyk8jxVqnyj9ufCg+8lQuf1IepY=;
 b=R/mS05blUicEcvOJmxKJsB8VNb0z1W8bQ4iXirxc10ndEaGpB2YdWfR5jdwoqq1Vic
 zE6WeWJLdnYxJmv5+AQ3EfKOSkicWQVrBL5VHx0j1Is8WWKLzKSvgSKwhBng0KYdOI01
 yZYIIX+IP02zcJGMFBbWvEbOL15cjjw+bMq6tqs17k7q165pZWhmazX72V/fDzvrZU0P
 iKrkLVs2lHhVSjgjjfc6jiRkhH8hIhMk4U5Lr1cZVhItJCQ7q2NQ4WF6tz5/hzfj5u/r
 K3FMGmGVaR/AqVq1gZI3DD2l+Vc75YCtUey4zJbSIj56DyajdppmlPGYbXYLYSuyHiNP
 GQqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792791723; x=1793396523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WEqi1MLcz/HNnxQ0ZF3J+qhLhm4FJoaVJ92k/XQror8=;
 b=DRlWCrKsTXqGkwyYSdyicO4vTk/MImeMRuyLIP9dJeavLZn6OiyG77ZkvLTrXAeFfd
 wIiThRjGB5NGu6RSsINzE7/Po3thJdID58GfL8Q8e42Of5LxARPwCs3kr55SuuENd5MB
 tCWohRcr+GdaH65sT6ZXq7OBybUcGICQICFut+6lMQl3MFcwCGO+Hme9ZL58hYWUWguG
 DUcrGSizp0HHRgUUqCU91yLT3Uvte2mK1h3Bs/LRi+FVR2REvpcxBDCMHSgHtlMUqcQY
 9mPcsz6tKtpOM2d8/iCwqPtWp4NzPgYQA2K+FRbQEv8dIwnPRsIE0DikpK95I8aWcC15
 QbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792791723; x=1793396523;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WEqi1MLcz/HNnxQ0ZF3J+qhLhm4FJoaVJ92k/XQror8=;
 b=LF2JNbaj4cMGLtc2YgGG6eZ0yS3z9oYwSDDtBWkipHBXgSr1o4oidnm8heKrrprlwQ
 5okdsqFU6EDQ6ojuvUXj3FBSq4Pc/esfcmN7wId3VWMF3kWCsiDYO+1AzEkxbpsBVgbJ
 75V976a6m8oE3QBYbubNTUQH39r8DvAz/RWPSQhPAxn27iF2PYYUpt2/AMU6C4WjEtuJ
 80r85VFhx2CIBAJOl/uFhRrlviA5ZwMcqIMPOlcUZMnUxvYbu+FTmVssVep/u95XuEna
 bYCdV3nLsYVxT59QFAtuzjHNAEhkFrHAhh8tYgUeDL2sGDFr5FtebDTM+2dumcLlvIJp
 TSKw==
X-Gm-Message-State: AFq9FYKtHnTAoclBHGYz3m4fNZT6wpg32i8HWgH1VGqpshnkQstLECu/
 GMdhvwblDpAjAL5j222/ZO7X4/mmB/Wz7a21RXndaKyftz5o9XdcSM0OdD5KKgknykgfzAEZgP7
 XhPAKSQnY4pmnYYHPLw2ls2rYjaEsrZL8EoZTzQsO
X-Gm-Gg: AYBFou3KGivkpE8+JnL7/b93xvRD8oYAoYd7rjfNoz4kaTFrAM5/sFzsLUDI7HpAh9/
 MhfhPdLtYeR4ngQrFUVsR1ljxrXwRQ4Q/nybkNg81kSn4+7l7UngdmrVsTWmyzRbtzXP+a5r/wn
 EMWo7ibbxWwTdEKJBU2Hggg3eeOk0rTGEgf+sdIG0IJivaXiFQQKm84TCRB7Qq0rBicBMDvCzqu
 lApztIakFoSGYAUqBAWBNm0P1+R327cTcd7tOL1Fx5OcwFQ2UZNO7vUBMIWbWOAGrEZYOrQPesD
 f9u2Q1bYi1YakvHmdsMthXZa7hqXC1yU8cMvEN6bajUncdlvWMnOu4rYR4mSsLsiZXza8rInLOZ
 ZUUwZ9Lx6a+hLuSGki/0trfHRuWPqmAJ0xutaJkFyR4qzzdzTxKw6cEYdEztbTkU7hg==
X-Received: by 2002:a05:600d:849c:20b0:4a1:fb0d:382d with SMTP id
 5b1f17b1804b1-4a35a9a9048mr65575e9.4.1792791722691; Fri, 23 Oct 2026 14:42:02
 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-5-namangulati@google.com>
 <IA0PR02MB9462F37E7B6D239B434ADD5B8B672@IA0PR02MB9462.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB9462F37E7B6D239B434ADD5B8B672@IA0PR02MB9462.namprd02.prod.outlook.com>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 23 Oct 2026 14:41:47 -0700
X-Gm-Features: AclHuK-mJ76fIeqb7d-lSrakl7r9wWbpZuOu8TfmAXNDBuNS0_FGkLXezvqpwTE
Message-ID: <CAMP57yWyxZwGU-05_HzEDYtn3uu8LymLncjXGewd0tQJdBEYpQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vfio-user: support multiple FDs for sparse mmap
 regions
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Levon <john.levon@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=namangulati@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 2:27=E2=80=AFPM Thanos Makatos
<thanos.makatos@nutanix.com> wrote:
>
>
>
> > -----Original Message-----
> > From: qemu-devel-bounces+thanos.makatos=3Dnutanix.com@nongnu.org <qemu-
> > devel-bounces+thanos.makatos=3Dnutanix.com@nongnu.org> On Behalf Of
> > Naman Gulati
> > Sent: 14 October 2026 22:11
> > To: qemu-devel@nongnu.org
> > Cc: John Levon <john.levon@nutanix.com>; Thanos Makatos
> > <thanos.makatos@nutanix.com>; C=C3=A9dric Le Goater <clg@redhat.com>; A=
lex
> > Williamson <alex@shazbot.org>; Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com>; Matt Evans <matt@ozlabs.org>;
> > Naman Gulati <namangulati@google.com>
> > Subject: [PATCH v5 4/4] vfio-user: support multiple FDs for sparse
> > mmap regions
> >
> > !-------------------------------------------------------------------|
> >   CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > Add client support for capability VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> > (capability ID 0x8001) in vfio-user, and advertise support via the
> > "sparse_mmap_fds" capability in VFIO_USER_VERSION.
> >
> > Update vfio_user_device_io_get_region_info() to receive multiple file
> > descriptors passed in SCM_RIGHTS ancillary data for a region, store
> > them
> > in VFIOUserProxy, and implement setup_sparse_mmaps in
> > vfio_user_device_io_ops_sock to validate and populate per-area file
> > descriptors and fd_offset values.
> >
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> >  hw/vfio-user/protocol.h |  35 ++++++++++--
> >  hw/vfio-user/proxy.h    |   2 +
> >  hw/vfio-user/device.c   | 121 +++++++++++++++++++++++++++++++++++++--
> > -
> >  hw/vfio-user/proxy.c    |  52 +++++++++++++++--
> >  4 files changed, 193 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> > index c478d1353f..b823689254 100644
> > --- a/hw/vfio-user/protocol.h
> > +++ b/hw/vfio-user/protocol.h
> > @@ -15,6 +15,8 @@
> >   * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> > +#define VFIO_USER_MAX_REGIONS 100
> > +
> >  typedef struct {
> >      uint16_t id;
> >      uint16_t command;
> > @@ -69,12 +71,13 @@ typedef struct {
> >  #define VFIO_USER_CAP           "capabilities"
> >
> >  /* "capabilities" members */
> > -#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
> > -#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
> > -#define VFIO_USER_CAP_PGSIZES   "pgsizes"
> > -#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
> > -#define VFIO_USER_CAP_MIGR      "migration"
> > -#define VFIO_USER_CAP_MULTI     "write_multiple"
> > +#define VFIO_USER_CAP_MAX_FDS           "max_msg_fds"
> > +#define VFIO_USER_CAP_MAX_XFER          "max_data_xfer_size"
> > +#define VFIO_USER_CAP_PGSIZES           "pgsizes"
> > +#define VFIO_USER_CAP_MAP_MAX           "max_dma_maps"
> > +#define VFIO_USER_CAP_MIGR              "migration"
> > +#define VFIO_USER_CAP_MULTI             "write_multiple"
> > +#define VFIO_USER_CAP_SPARSE_MMAP_FDS   "sparse_mmap_fds"
> >
> >  /* "migration" members */
> >  #define VFIO_USER_CAP_PGSIZE            "pgsize"
> > @@ -166,6 +169,26 @@ typedef struct {
> >      uint64_t offset;
> >  } VFIOUserRegionInfo;
> >
> > +/*
> > + * VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> > + */
> > +#define VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS 0x8001
> > +
> > +struct vfio_region_sparse_mmap_fd_area {
> > +    uint64_t offset;
> > +    uint64_t fd_offset;
> > +    uint64_t size;
> > +    uint32_t fd_index;
> > +    uint32_t pad;
> > +};
> > +
> > +struct vfio_region_info_cap_sparse_mmap_fds {
> > +    struct vfio_info_cap_header header;
> > +    uint32_t nr_areas;
> > +    uint32_t reserved;
> > +    struct vfio_region_sparse_mmap_fd_area areas[];
> > +};
> > +
> >  /*
> >   * VFIO_USER_DEVICE_GET_IRQ_INFO
> >   * imported from struct vfio_irq_info
> > diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> > index 7b97460cc5..4b9834a436 100644
> > --- a/hw/vfio-user/proxy.h
> > +++ b/hw/vfio-user/proxy.h
> > @@ -72,6 +72,7 @@ typedef struct VFIOUserProxy {
> >      AioContext *ctx;
> >      QEMUBH *req_bh;
> >      bool async_ops;
> > +    VFIOUserFDs *region_fds[VFIO_USER_MAX_REGIONS];
> >
> >      /*
> >       * above only changed when BQL is held
> > @@ -111,6 +112,7 @@ bool vfio_user_validate_version(VFIOUserProxy
> > *proxy, Error **errp);
> >
> >  VFIOUserFDs *vfio_user_getfds(int numfds);
> >  void vfio_user_putfds(VFIOUserMsg *msg);
> > +void vfio_user_free_fds(VFIOUserFDs *fds);
> >
> >  void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
> >
> > diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> > index 1a01e748cd..4fbf536a04 100644
> > --- a/hw/vfio-user/device.c
> > +++ b/hw/vfio-user/device.c
> > @@ -14,12 +14,14 @@
> >
> >  #include "hw/vfio-user/device.h"
> >  #include "hw/vfio-user/trace.h"
> > +#include "hw/vfio/vfio-region.h"
> > +#include "hw/vfio/vfio-helpers.h"
> > +#include "hw/vfio/trace.h"
> >
> >  /*
> >   * These are to defend against a malign server trying
> >   * to force us to run out of memory.
> >   */
> > -#define VFIO_USER_MAX_REGIONS   100
> >  #define VFIO_USER_MAX_IRQS      50
> >
> >  bool vfio_user_get_device_info(VFIOUserProxy *proxy,
> > @@ -209,14 +211,17 @@ static int
> > vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
> >                                                 struct
> > vfio_region_info *info,
> >                                                 int *fd)
> >  {
> > -    VFIOUserFDs fds =3D { 0, 1, fd};
> > -    int ret;
> > +    int fds[VFIO_USER_MAX_MAX_FDS];
> > +    VFIOUserFDs user_fds =3D { 0, VFIO_USER_MAX_MAX_FDS, fds };
> > +    int i, ret;
> > +
> > +    *fd =3D -1;
> >
> >      if (info->index > vbasedev->num_initial_regions) {
> >          return -EINVAL;
> >      }
> >
> > -    ret =3D vfio_user_get_region_info(vbasedev->proxy, info, &fds);
> > +    ret =3D vfio_user_get_region_info(vbasedev->proxy, info,
> > &user_fds);
> >      if (ret) {
> >          return ret;
> >      }
> > @@ -225,10 +230,30 @@ static int
> > vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
> >      if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
> >          (info->cap_offset < sizeof(*info)
> >           || info->cap_offset + sizeof(struct vfio_info_cap_header) >
> > info->argsz)) {
> > -        return -EINVAL;
> > +        ret =3D -EINVAL;
> > +    } else if (vfio_get_region_info_cap(info,
> > +
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS)) {
> > +        if (user_fds.recv_fds > 0) {
> > +            VFIOUserFDs *saved =3D vfio_user_getfds(user_fds.recv_fds)=
;
> > +
> > +            saved->recv_fds =3D user_fds.recv_fds;
> > +            memcpy(saved->fds, fds, user_fds.recv_fds * sizeof(int));
> > +            vfio_user_free_fds(vbasedev->proxy->region_fds[info-
> > >index]);
> > +            vbasedev->proxy->region_fds[info->index] =3D saved;
> > +            return 0;
> > +        }
> > +        ret =3D -EINVAL;
> > +    } else if (user_fds.recv_fds > 0) {
> > +        *fd =3D fds[0];
> > +        fds[0] =3D -1;
> >      }
> >
> > -    return 0;
> > +    for (i =3D 0; i < user_fds.recv_fds; i++) {
> > +        if (fds[i] >=3D 0) {
> > +            close(fds[i]);
> > +        }
> > +    }
> > +    return ret;
> >  }
> >
> >  static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
> > @@ -518,12 +543,94 @@ static int
> > vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
> >  /*
> >   * Socket-based io_ops
> >   */
> > +static int vfio_user_device_io_setup_sparse_mmaps(VFIORegion *region,
> > +                                                  struct
> > vfio_region_info *info,
> > +                                                  Error **errp)
> > +{
> > +    struct vfio_info_cap_header *hdr;
> > +    struct vfio_region_info_cap_sparse_mmap_fds *sparse_fds;
> > +    VFIOUserFDs *user_fds;
> > +    size_t cap_offset;
> > +    int i;
> > +
> > +    hdr =3D vfio_get_region_info_cap(info,
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS);
> > +    if (!hdr) {
> > +        return vfio_default_setup_sparse_mmaps(region, info, errp);
> > +    }
> > +
> > +    if (vfio_get_region_info_cap(info,
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP)) {
> > +        error_setg(errp, "%s: region %d cannot specify both "
> > +                   "SPARSE_MMAP and SPARSE_MMAP_FDS", __func__,
> > region->nr);
> > +        return -EINVAL;
> > +    }
> > +
> > +    sparse_fds =3D container_of(hdr, struct
> > vfio_region_info_cap_sparse_mmap_fds,
> > +                              header);
> > +
> > +    cap_offset =3D (uintptr_t)hdr - (uintptr_t)info;
> > +    if (cap_offset > info->argsz ||
> > +        info->argsz - cap_offset < sizeof(*sparse_fds) ||
> > +        sparse_fds->nr_areas >
> > +            (info->argsz - cap_offset - sizeof(*sparse_fds)) /
> > +            sizeof(sparse_fds->areas[0])) {
> > +        error_setg(errp, "%s: invalid nr_areas %u in region %d",
> > +                   __func__, sparse_fds->nr_areas, region->nr);
> > +        return -EINVAL;
> > +    }
> > +
> > +    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
> > +                                         region->nr, sparse_fds-
> > >nr_areas);
> > +
> > +    user_fds =3D region->vbasedev->proxy->region_fds[region->nr];
> > +    if (!user_fds || user_fds->recv_fds > sparse_fds->nr_areas) {
> > +        error_setg(errp, "%s: invalid fd count %d for %u sparse mmap
> > areas "
> > +                   "in region %d", __func__,
> > +                   user_fds ? user_fds->recv_fds : 0,
> > +                   sparse_fds->nr_areas, region->nr);
> > +        return -EINVAL;
> > +    }
> > +
> > +    region->mmaps =3D g_try_new0(VFIOMmap, sparse_fds->nr_areas);
>
> IMO we should impose a limit on sparse_fds->nr_areas, g_try_new0 does pre=
vent the server from crashing but a malicious client can allocate too much =
memory.

sparse_fds->nr_areas is already bounded by info->argsz via the check just a=
bove:

if (cap_offset > info->argsz ||
        info->argsz - cap_offset < sizeof(*sparse_fds) ||
        sparse_fds->nr_areas >
            (info->argsz - cap_offset - sizeof(*sparse_fds)) /
            sizeof(sparse_fds->areas[0])) {
        error_setg(errp, "%s: invalid nr_areas %u in region %d",
                   __func__, sparse_fds->nr_areas, region->nr);
        return -EINVAL;
    }

And in vfio_user_get_region_info(), info->argsz is capped by
proxy->max_xfer_size (at most VFIO_USER_DEF_MAX_XFER =3D 1 MiB), so
sparse_fds->nr_areas cannot exceed ~32K entries (the same bound that
applies to VFIO_REGION_INFO_CAP_SPARSE_MMAP in
vfio_region_setup_sparse_mmaps()).

Does that existing bound look sufficient to you, or would you still
prefer an explicit smaller limit (e.g. a VFIO_USER_MAX_SPARSE_MMAPS
constant alongside VFIO_USER_MAX_REGIONS)?

>
> > +    if (!region->mmaps) {
> > +        error_setg(errp, "%s: failed to allocate %u mmaps for region
> > %d",
> > +                   __func__, sparse_fds->nr_areas, region->nr);
> > +        return -ENOMEM;
> > +    }
> > +
> > +    for (i =3D 0; i < sparse_fds->nr_areas; i++) {
> > +        struct vfio_region_sparse_mmap_fd_area *area =3D &sparse_fds-
> > >areas[i];
> > +
> > +        if (area->size =3D=3D 0 || area->offset > region->size ||
> > +            area->size > region->size - area->offset ||
> > +            area->fd_index >=3D user_fds->recv_fds) {
> > +            error_setg(errp, "%s: invalid sparse mmap area %d in
> > region %d "
> > +                       "(offset=3D0x%"PRIx64" size=3D0x%"PRIx64
> > +                       " fd_offset=3D0x%"PRIx64" fd_index=3D%u)",
> > +                       __func__, i, region->nr, area->offset, area-
> > >size,
> > +                       area->fd_offset, area->fd_index);
> > +            g_free(region->mmaps);
> > +            region->mmaps =3D NULL;
> > +            return -EINVAL;
> > +        }
> > +
> > +        trace_vfio_region_sparse_mmap_entry(i, area->offset,
> > +                                            area->offset + area->size
> > - 1);
> > +        region->mmaps[i].offset =3D area->offset;
> > +        region->mmaps[i].fd_offset =3D area->fd_offset;
> > +        region->mmaps[i].size =3D area->size;
> > +        region->mmaps[i].fd =3D user_fds->fds[area->fd_index];
> > +    }
> > +
> > +    region->nr_mmaps =3D sparse_fds->nr_areas;
> > +    return 0;
> > +}
> > +
> >  VFIODeviceIOOps vfio_user_device_io_ops_sock =3D {
> >      .device_feature =3D vfio_user_device_io_device_feature,
> >      .get_region_info =3D vfio_user_device_io_get_region_info,
> > +    .setup_sparse_mmaps =3D vfio_user_device_io_setup_sparse_mmaps,
> >      .get_irq_info =3D vfio_user_device_io_get_irq_info,
> >      .set_irqs =3D vfio_user_device_io_set_irqs,
> >      .region_read =3D vfio_user_device_io_region_read,
> >      .region_write =3D vfio_user_device_io_region_write,
> > -
> >  };
> > diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> > index 197aee07bf..ba29085321 100644
> > --- a/hw/vfio-user/proxy.c
> > +++ b/hw/vfio-user/proxy.c
> > @@ -363,6 +363,13 @@ static int vfio_user_recv_one(VFIOUserProxy
> > *proxy, Error **errp)
> >          }
> >
> >          memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> > +    } else if (msg->fds !=3D NULL) {
> > +        /*
> > +         * recv_fds holds the capacity of msg->fds->fds on entry;
> > reset it
> > +         * to 0 when the reply carries no FDs so the caller knows
> > none were
> > +         * received.
> > +         */
> > +        msg->fds->recv_fds =3D 0;
> >      }
> >
> >      /*
> > @@ -740,6 +747,11 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy,
> > VFIOUserHdr *hdr,
> >
> >      qemu_mutex_unlock(&proxy->lock);
> >
> > +    if (!ok && fds !=3D NULL) {
> > +        /* No reply was received; report 0 received FDs to the
> > caller. */
> > +        fds->recv_fds =3D 0;
> > +    }
> > +
> >      return ok;
> >  }
> >
> > @@ -867,17 +879,30 @@ void vfio_user_send_error(VFIOUserProxy *proxy,
> > VFIOUserHdr *hdr, int error)
> >  }
> >
> >  /*
> > - * Close FDs erroneously received in an incoming request.
> > + * Close and free received FDs.
> >   */
> > -void vfio_user_putfds(VFIOUserMsg *msg)
> > +void vfio_user_free_fds(VFIOUserFDs *fds)
> >  {
> > -    VFIOUserFDs *fds =3D msg->fds;
> >      int i;
> >
> > +    if (!fds) {
> > +        return;
> > +    }
> > +
> >      for (i =3D 0; i < fds->recv_fds; i++) {
> > -        close(fds->fds[i]);
> > +        if (fds->fds[i] >=3D 0) {
> > +            close(fds->fds[i]);
> > +        }
> >      }
> >      g_free(fds);
> > +}
> > +
> > +/*
> > + * Close FDs erroneously received in an incoming request.
> > + */
> > +void vfio_user_putfds(VFIOUserMsg *msg)
> > +{
> > +    vfio_user_free_fds(msg->fds);
> >      msg->fds =3D NULL;
> >  }
> >
> > @@ -967,6 +992,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
> >  void vfio_user_disconnect(VFIOUserProxy *proxy)
> >  {
> >      VFIOUserMsg *r1, *r2;
> > +    int i;
> >
> >      qemu_mutex_lock(&proxy->lock);
> >
> > @@ -1027,6 +1053,10 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
> >          vfio_user_iothread =3D NULL;
> >      }
> >
> > +    for (i =3D 0; i < VFIO_USER_MAX_REGIONS; i++) {
> > +        vfio_user_free_fds(proxy->region_fds[i]);
> > +    }
> > +
> >      g_free(proxy->sockname);
> >      g_free(proxy);
> >  }
> > @@ -1214,6 +1244,18 @@ static bool check_multi(VFIOUserProxy *proxy,
> > QObject *qobj, Error **errp)
> >      return true;
> >  }
> >
> > +static bool check_sparse_mmap_fds(VFIOUserProxy *proxy, QObject
> > *qobj,
> > +                                  Error **errp)
> > +{
> > +    QBool *qb =3D qobject_to(QBool, qobj);
> > +
> > +    if (qb =3D=3D NULL) {
> > +        error_setg(errp, "malformed %s",
> > VFIO_USER_CAP_SPARSE_MMAP_FDS);
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> >  static struct cap_entry caps_cap[] =3D {
> >      { VFIO_USER_CAP_MAX_FDS, check_max_fds },
> >      { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
> > @@ -1221,6 +1263,7 @@ static struct cap_entry caps_cap[] =3D {
> >      { VFIO_USER_CAP_MAP_MAX, check_max_dma },
> >      { VFIO_USER_CAP_MIGR, check_migr },
> >      { VFIO_USER_CAP_MULTI, check_multi },
> > +    { VFIO_USER_CAP_SPARSE_MMAP_FDS, check_sparse_mmap_fds },
> >      { NULL }
> >  };
> >
> > @@ -1280,6 +1323,7 @@ static GString *caps_json(void)
> >      qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES,
> > VFIO_USER_DEF_PGSIZE);
> >      qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX,
> > VFIO_USER_DEF_MAP_MAX);
> >      qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
> > +    qdict_put_bool(capdict, VFIO_USER_CAP_SPARSE_MMAP_FDS, true);
> >
> >      qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
> >
> > --
> > 2.56.0.385.gd3acb90ef8-goog
> >
>

