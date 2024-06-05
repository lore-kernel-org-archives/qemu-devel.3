Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C710AC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsP5-0003ec-OK; Wed, 05 Jun 2024 11:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sEsP2-0003eA-WD
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:18:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sEsOw-0004Wv-Ug
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:18:16 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VvWJY0Tbrzclq4;
 Wed,  5 Jun 2024 23:16:29 +0800 (CST)
Received: from dggems706-chm.china.huawei.com (unknown [10.3.19.183])
 by mail.maildlp.com (Postfix) with ESMTPS id 44FF218007A;
 Wed,  5 Jun 2024 23:17:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 23:17:47 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039; 
 Wed, 5 Jun 2024 16:17:45 +0100
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "yuan1.liu@intel.com" <yuan1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "linwenkai (C)" <linwenkai6@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, huangchenghai
 <huangchenghai2@huawei.com>
Subject: RE: [PATCH 4/7] migration/multifd: Add UADK initialization
Thread-Topic: [PATCH 4/7] migration/multifd: Add UADK initialization
Thread-Index: AQHasa8ma9zlPdHpIkSgR6GeVHMe97G5PWQAgAAVbqA=
Date: Wed, 5 Jun 2024 15:17:45 +0000
Message-ID: <cc603b9630bf4505a308d069ac3a5eac@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-5-shameerali.kolothum.thodi@huawei.com>
 <87zfrzfnd1.fsf@suse.de>
In-Reply-To: <87zfrzfnd1.fsf@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Sent: Wednesday, June 5, 2024 3:58 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> peterx@redhat.com; yuan1.liu@intel.com
> Cc: qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; linwenkai
> (C) <linwenkai6@hisilicon.com>; zhangfei.gao@linaro.org; huangchenghai
> <huangchenghai2@huawei.com>
> Subject: Re: [PATCH 4/7] migration/multifd: Add UADK initialization
>=20
> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
>=20
> > Initialize UADK session and allocate buffers required. The actual
> > compression/decompression will only be done in a subsequent patch.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  migration/multifd-uadk.c | 207
> ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 206 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
> > index c2bb07535b..3172e4d5ca 100644
> > --- a/migration/multifd-uadk.c
> > +++ b/migration/multifd-uadk.c
> > @@ -12,9 +12,214 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/module.h"
> > +#include "qapi/error.h"
> > +#include "migration.h"
> > +#include "multifd.h"
> > +#include "options.h"
> > +#include "uadk/wd_comp.h"
> > +#include "uadk/wd_sched.h"
> > +
> > +struct wd_data {
> > +    handle_t handle;
> > +    uint8_t *buf;
> > +    uint32_t *buf_hdr;
> > +};
> > +
> > +static bool uadk_hw_initialised(void)
>=20
> The first time this is called it will actually do the initialization,
> no? If so, it should be uadk_hw_init().

Ok. Makes sense.

>=20
> > +{
> > +    char alg[] =3D "zlib";
> > +    int ret;
> > +
> > +    ret =3D wd_comp_init2(alg, SCHED_POLICY_RR, TASK_HW);
> > +    if (ret && ret !=3D -WD_EEXIST) {
> > +        return false;
> > +    } else {
> > +        return true;
> > +    }
> > +}
> > +
> > +static struct wd_data *multifd_uadk_init_sess(uint32_t count,
> > +                                              uint32_t page_size,
> > +                                              bool compress, Error **e=
rrp)
> > +{
> > +    struct wd_comp_sess_setup ss =3D {0};
> > +    struct sched_params param =3D {0};
> > +    uint32_t size =3D count * page_size;
> > +    struct wd_data *wd;
> > +
> > +    if (!uadk_hw_initialised()) {
> > +        error_setg(errp, "multifd: UADK hardware not available");
>=20
> Does the lib provide a software fallback path that we could use like QPL
> does?

Unfortunately not. That is why I added patch #6 where we will just send
raw data to take care the CI test.

>=20
> > +        return NULL;
> > +    }
> > +
> > +    wd =3D g_new0(struct wd_data, 1);
> > +    ss.alg_type =3D WD_ZLIB;
> > +    if (compress) {
> > +        ss.op_type =3D WD_DIR_COMPRESS;
> > +        /* Add an additional page for handling output > input */
> > +        size +=3D page_size;
> > +    } else {
> > +        ss.op_type =3D WD_DIR_DECOMPRESS;
> > +    }
> > +    param.type =3D ss.op_type;
> > +    ss.sched_param =3D &param;
>=20
> What about window size and compression level? Don't we need to set them
> here? What do they default to?

Level 1 and 4K. I will add a comment here.
=20
> > +
> > +    wd->handle =3D wd_comp_alloc_sess(&ss);
> > +    if (!wd->handle) {
> > +        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
> > +        goto out;
> > +    }
> > +
> > +    wd->buf =3D g_try_malloc(size);
> > +    if (!wd->buf) {
> > +        error_setg(errp, "multifd: out of mem for uadk buf");
> > +        goto out_free_sess;
> > +    }
> > +    wd->buf_hdr =3D g_new0(uint32_t, count);
> > +    return wd;
> > +
> > +out_free_sess:
> > +    wd_comp_free_sess(wd->handle);
> > +out:
> > +    wd_comp_uninit2();
> > +    g_free(wd);
> > +    return NULL;
> > +}
> > +
> > +static void multifd_uadk_uninit_sess(struct wd_data *wd)
> > +{
> > +    wd_comp_free_sess(wd->handle);
> > +    wd_comp_uninit2();
> > +    g_free(wd->buf);
> > +    g_free(wd->buf_hdr);
> > +    g_free(wd);
> > +}
> > +
> > +/**
> > + * multifd_uadk_send_setup: setup send side
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    struct wd_data *wd;
> > +
> > +    wd =3D multifd_uadk_init_sess(p->page_count, p->page_size, true, e=
rrp);
> > +    if (!wd) {
> > +        return -1;
> > +    }
> > +
> > +    p->compress_data =3D wd;
> > +    assert(p->iov =3D=3D NULL);
> > +    /*
> > +     * Each page will be compressed independently and sent using an IO=
V.
> The
> > +     * additional two IOVs are used to store packet header and compres=
sed
> data
> > +     * length
> > +     */
> > +
> > +    p->iov =3D g_new0(struct iovec, p->page_count + 2);
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_uadk_send_cleanup: cleanup send side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error
> **errp)
> > +{
> > +    struct wd_data *wd =3D p->compress_data;
> > +
> > +    multifd_uadk_uninit_sess(wd);
> > +    p->compress_data =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_uadk_send_prepare: prepare data to be able to send
> > + *
> > + * Create a compressed buffer with all the pages that we are going to
> > + * send.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error
> **errp)
> > +{
> > +    return -1;
> > +}
> > +
> > +/**
> > + * multifd_uadk_recv_setup: setup receive side
> > + *
> > + * Create the compressed channel and buffer.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    struct wd_data *wd;
> > +
> > +    wd =3D multifd_uadk_init_sess(p->page_count, p->page_size, false, =
errp);
> > +    if (!wd) {
> > +        return -1;
> > +    }
> > +    p->compress_data =3D wd;
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_uadk_recv_cleanup: setup receive side
> > + *
> > + * For no compression this function does nothing.
>=20
> This line makes no sense here.

Ok.

Thanks,
Shameer

