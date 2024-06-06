Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3507BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7IJ-0005Bx-MA; Thu, 06 Jun 2024 03:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sF7ID-0005BN-Qb
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:12:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sF7Hz-0003V5-Ow
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:12:13 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VvwQc0mMpz1S6Hh;
 Thu,  6 Jun 2024 15:08:08 +0800 (CST)
Received: from dggems706-chm.china.huawei.com (unknown [10.3.19.183])
 by mail.maildlp.com (Postfix) with ESMTPS id 95BB71A0188;
 Thu,  6 Jun 2024 15:11:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 15:11:49 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039; 
 Thu, 6 Jun 2024 08:11:46 +0100
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "yuan1.liu@intel.com" <yuan1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "linwenkai (C)" <linwenkai6@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, huangchenghai
 <huangchenghai2@huawei.com>
Subject: RE: [PATCH 5/7] migration/multifd: Add UADK based compression and
 decompression
Thread-Topic: [PATCH 5/7] migration/multifd: Add UADK based compression and
 decompression
Thread-Index: AQHasbajCqOR38g3MUmGZQqzWaZJrrG5gB4AgADdjJA=
Date: Thu, 6 Jun 2024 07:11:46 +0000
Message-ID: <6394a36cdb024c7eab5cb651b43212c3@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-6-shameerali.kolothum.thodi@huawei.com>
 <87a5jzp69r.fsf@suse.de>
In-Reply-To: <87a5jzp69r.fsf@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Wednesday, June 5, 2024 7:57 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> peterx@redhat.com; yuan1.liu@intel.com
> Cc: qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; linwenkai
> (C) <linwenkai6@hisilicon.com>; zhangfei.gao@linaro.org; huangchenghai
> <huangchenghai2@huawei.com>
> Subject: Re: [PATCH 5/7] migration/multifd: Add UADK based compression
> and decompression
>=20
> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
>=20
> > Uses UADK wd_do_comp_sync() API to (de)compress a normal page using
> > hardware accelerator.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
>=20
> A couple of comments below.
>=20
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/multifd-uadk.c | 132
> ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 130 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
> > index 3172e4d5ca..3329819bd4 100644
> > --- a/migration/multifd-uadk.c
> > +++ b/migration/multifd-uadk.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/module.h"
> >  #include "qapi/error.h"
> > +#include "exec/ramblock.h"
> >  #include "migration.h"
> >  #include "multifd.h"
> >  #include "options.h"
> > @@ -140,6 +141,15 @@ static void
> multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
> >      p->compress_data =3D NULL;
> >  }
> >
> > +static inline void prepare_next_iov(MultiFDSendParams *p, void *base,
> > +                                    uint32_t len)
> > +{
> > +    p->iov[p->iovs_num].iov_base =3D (uint8_t *)base;
> > +    p->iov[p->iovs_num].iov_len =3D len;
> > +    p->next_packet_size +=3D len;
> > +    p->iovs_num++;
> > +}
> > +
> >  /**
> >   * multifd_uadk_send_prepare: prepare data to be able to send
> >   *
> > @@ -153,7 +163,56 @@ static void
> multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
> >   */
> >  static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error
> **errp)
> >  {
> > -    return -1;
> > +    struct wd_data *uadk_data =3D p->compress_data;
> > +    uint32_t hdr_size;
> > +    uint8_t *buf =3D uadk_data->buf;
> > +    int ret =3D 0;
> > +
> > +    if (!multifd_send_prepare_common(p)) {
> > +        goto out;
> > +    }
> > +
> > +    hdr_size =3D p->pages->normal_num * sizeof(uint32_t);
> > +    /* prepare the header that stores the lengths of all compressed da=
ta */
> > +    prepare_next_iov(p, uadk_data->buf_hdr, hdr_size);
> > +
> > +    for (int i =3D 0; i < p->pages->normal_num; i++) {
> > +        struct wd_comp_req creq =3D {
> > +            .op_type =3D WD_DIR_COMPRESS,
> > +            .src     =3D p->pages->block->host + p->pages->offset[i],
> > +            .src_len =3D p->page_size,
> > +            .dst     =3D buf,
> > +            /* Set dst_len to double the src to take care of -ve compr=
ession */
>=20
> What's -ve compression?

Just meant the case where output is > input. I can reword this.

>=20
> > +            .dst_len =3D p->page_size * 2,
> > +        };
> > +
> > +        ret =3D wd_do_comp_sync(uadk_data->handle, &creq);
> > +        if (ret || creq.status) {
> > +            error_setg(errp, "multifd %u: failed wd_do_comp_sync, ret =
%d
> status %d",
> > +                       p->id, ret, creq.status);
> > +            return -1;
> > +        }
> > +        if (creq.dst_len < p->page_size) {
> > +            uadk_data->buf_hdr[i] =3D cpu_to_be32(creq.dst_len);
> > +            prepare_next_iov(p, buf, creq.dst_len);
> > +            buf +=3D creq.dst_len;
> > +        } else {
> > +            /*
> > +             * Send raw data if compressed out >=3D page_size. We migh=
t be
> better
> > +             * off sending raw data if output is slightly less than pa=
ge_size
> > +             * as well because at the receive end we can skip the
> decompression.
> > +             * But it is tricky to find the right number here.
> > +             */
> > +            uadk_data->buf_hdr[i] =3D cpu_to_be32(p->page_size);
> > +            prepare_next_iov(p, p->pages->block->host + p->pages->offs=
et[i],
> > +                             p->page_size);
> > +            buf +=3D p->page_size;
> > +        }
> > +    }
> > +out:
> > +    p->flags |=3D MULTIFD_FLAG_UADK;
> > +    multifd_send_fill_packet(p);
> > +    return 0;
> >  }
> >
> >  /**
> > @@ -206,7 +265,76 @@ static void
> multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
> >   */
> >  static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
> >  {
> > -    return -1;
> > +    struct wd_data *uadk_data =3D p->compress_data;
> > +    uint32_t in_size =3D p->next_packet_size;
> > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> > +    uint32_t hdr_len =3D p->normal_num * sizeof(uint32_t);
> > +    uint32_t data_len =3D 0;
> > +    uint8_t *buf =3D uadk_data->buf;
> > +    int ret =3D 0;
> > +
> > +    if (flags !=3D MULTIFD_FLAG_UADK) {
> > +        error_setg(errp, "multifd %u: flags received %x flags expected=
 %x",
> > +                   p->id, flags, MULTIFD_FLAG_ZLIB);
> > +        return -1;
> > +    }
> > +
> > +    multifd_recv_zero_page_process(p);
> > +    if (!p->normal_num) {
> > +        assert(in_size =3D=3D 0);
> > +        return 0;
> > +    }
> > +
> > +    /* read compressed data lengths */
> > +    assert(hdr_len < in_size);
> > +    ret =3D qio_channel_read_all(p->c, (void *) uadk_data->buf_hdr,
> > +                               hdr_len, errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        uadk_data->buf_hdr[i] =3D be32_to_cpu(uadk_data->buf_hdr[i]);
> > +        data_len +=3D uadk_data->buf_hdr[i];
> > +        assert(uadk_data->buf_hdr[i] <=3D p->page_size);
> > +    }
> > +
> > +    /* read compressed data */
> > +    assert(in_size =3D=3D hdr_len + data_len);
> > +    ret =3D qio_channel_read_all(p->c, (void *)buf, data_len, errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        struct wd_comp_req creq =3D {
> > +            .op_type =3D WD_DIR_DECOMPRESS,
> > +            .src     =3D buf,
> > +            .src_len =3D uadk_data->buf_hdr[i],
> > +            .dst     =3D p->host + p->normal[i],
> > +            .dst_len =3D p->page_size,
> > +        };
> > +
> > +        if (uadk_data->buf_hdr[i] =3D=3D p->page_size) {
> > +            memcpy(p->host + p->normal[i], buf, p->page_size);
> > +            buf +=3D p->page_size;
> > +            continue;
> > +        }
> > +
> > +        ret =3D wd_do_comp_sync(uadk_data->handle, &creq);
> > +        if (ret || creq.status) {
> > +            error_setg(errp, "multifd %u: failed wd_do_comp_sync, ret =
%d
> status %d",
> > +                       p->id, ret, creq.status);
>=20
> It would be nice to be able to tell compression from decompression in
> these error messages.

Ok. Will change.

Thanks,
Shameer

