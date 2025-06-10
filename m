Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46DAC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26s-0001pK-FE; Tue, 10 Jun 2025 12:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP0cg-000085-RR
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:10:46 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP0cd-00027q-Tz
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:10:46 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGsdz75N9z6D94m;
 Tue, 10 Jun 2025 23:09:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EAE6C1405F9;
 Tue, 10 Jun 2025 23:10:06 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 17:10:00 +0200
Date: Tue, 10 Jun 2025 16:09:59 +0100
To: Fan Ni <nifan.cxl@gmail.com>
CC: <anisa.su887@gmail.com>, <qemu-devel@nongnu.org>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <20250610160959.000010b9@huawei.com>
In-Reply-To: <aEMW2SDuAE10Iyuf@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-7-anisa.su887@gmail.com>
 <aEMW2SDuAE10Iyuf@debian>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Jun 2025 09:27:05 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Thu, Jun 05, 2025 at 11:42:20PM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> >=20
> > FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section =
7.6.7.6.3
> >=20
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > --- =20
>=20
> One minor comment, otherwise LGTM.
>=20
> >  hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3.c           |  6 +--
> >  include/hw/cxl/cxl_device.h  |  3 ++
> >  include/hw/cxl/cxl_mailbox.h |  6 +++
> >  4 files changed, 98 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 1b5c7216f9..47b1509a0e 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -121,6 +121,7 @@ enum {
> >      FMAPI_DCD_MGMT =3D 0x56,
> >          #define GET_DCD_INFO    0x0
> >          #define GET_HOST_DC_REGION_CONFIG   0x1
> > +        #define SET_DC_REGION_CONFIG        0x2
> >  };
> > =20
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3387,6 +3388,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_conf=
ig(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> > =20
> > +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcod=
e 5602) */
> > +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cm=
d,
> > +                                              uint8_t *payload_in,
> > +                                              size_t len_in,
> > +                                              uint8_t *payload_out,
> > +                                              size_t *len_out,
> > +                                              CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint8_t reg_id;
> > +        uint8_t rsvd[3];
> > +        uint64_t block_sz;
> > +        uint8_t flags;
> > +        uint8_t rsvd2[3];
> > +    } QEMU_PACKED *in =3D (void *)payload_in;
> > +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> > +    CXLEventDynamicCapacity dcEvent =3D {};
> > +    CXLDCRegion *region =3D &ct3d->dc.regions[in->reg_id];
> > +
> > +    /*
> > +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> > +     * This command shall fail with Unsupported when the Sanitize on R=
elease
> > +     * field does not match the region=E2=80=99s configuration... and =
the device
> > +     * does not support reconfiguration of the Sanitize on Release set=
ting.
> > +     *
> > +     * Currently not reconfigurable, so always fail if sanitize bit (b=
it 0)
> > +     * doesn't match.
> > +     */
> > +    if ((in->flags & 0x1) !=3D (region->flags & 0x1)) {
> > +        return CXL_MBOX_UNSUPPORTED;
> > +    }
> > +
> > +    if (in->reg_id >=3D DCD_MAX_NUM_REGION) {
> > +        return CXL_MBOX_UNSUPPORTED;
> > +    }
> > +
> > +    /* Return success if new block size =3D=3D current block size */
> > +    if (in->block_sz =3D=3D region->block_size) {
> > +        return CXL_MBOX_SUCCESS;
> > +    } =20
>=20
> Should we move this below, after checking the bitmap?
Yes.  The text is a little confusing but the list of what should
fail with unsupported doesn't allow an exception for a noop
request. I've made that tweak on the updated tree I'm building now.

If there is another version of this series please make this change.

Jonathan
>=20
> Fan
> > +
> > +    /* Check that no extents are in the region being reconfigured */
> > +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_=
size)) {
> > +        return CXL_MBOX_UNSUPPORTED;
> > +    }
> > +
> > +    /* Check that new block size is supported */
> > +    if (!test_bit(BIT((int) log2(in->block_sz)),
> > +                  &region->supported_blk_size_bitmask)) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    /* Free bitmap and create new one for new block size. */
> > +    qemu_mutex_lock(&region->bitmap_lock);
> > +    g_free(region->blk_bitmap);
> > +    region->blk_bitmap =3D bitmap_new(region->len / in->block_sz);
> > +    qemu_mutex_unlock(&region->bitmap_lock);
> > +    region->block_size =3D in->block_sz;
> > +
> > +    /* Create event record and insert into event log */
> > +    cxl_assign_event_header(&dcEvent.hdr,
> > +                            &dynamic_capacity_uuid,
> > +                            (1 << CXL_EVENT_TYPE_INFO),
> > +                            sizeof(dcEvent),
> > +                            cxl_device_get_timestamp(&ct3d->cxl_dstate=
));
> > +    dcEvent.type =3D DC_EVENT_REGION_CONFIG_UPDATED;
> > +    dcEvent.validity_flags =3D 1;
> > +    dcEvent.host_id =3D 0;
> > +    dcEvent.updated_region_id =3D in->reg_id;
> > +
> > +    if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                         CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                         (CXLEventRecordRaw *)&dcEvent)) {
> > +        cxl_event_irq_assert(ct3d);
> > +    }
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] =3D {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPERATION=
_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3505,6 +3584,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[2=
56][256] =3D {
> >          cmd_fm_get_dcd_info, 0, 0 },
> >      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] =3D { "GET_HOST_DC_REG=
ION_CONFIG",
> >          cmd_fm_get_host_dc_region_config, 4, 0 },
> > +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] =3D { "SET_DC_REGION_CONFIG=
",
> > +        cmd_fm_set_dc_region_config, 16,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >  };
> > =20
> >  /*
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b872a26173..ee554a77be 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char =
*path, CxlCorErrorType type,
> >      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
> >  }
> > =20
> > -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> > -                                    const QemuUUID *uuid, uint32_t fla=
gs,
> > -                                    uint8_t length, uint64_t timestamp)
> > +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> > +                             const QemuUUID *uuid, uint32_t flags,
> > +                             uint8_t length, uint64_t timestamp)
> >  {
> >      st24_le_p(&hdr->flags, flags);
> >      hdr->length =3D length;
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 96ef9be444..76af75d2d0 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -721,4 +721,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3=
d, uint64_t dpa,
> >                                     uint64_t len);
> >  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >                                    uint64_t len);
> > +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> > +                             const QemuUUID *uuid, uint32_t flags,
> > +                             uint8_t length, uint64_t timestamp);
> >  #endif
> > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> > index 9008402d1c..a05d7cb5b7 100644
> > --- a/include/hw/cxl/cxl_mailbox.h
> > +++ b/include/hw/cxl/cxl_mailbox.h
> > @@ -8,6 +8,7 @@
> >  #ifndef CXL_MAILBOX_H
> >  #define CXL_MAILBOX_H
> > =20
> > +#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
> >  #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >  #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
> >  #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -15,5 +16,10 @@
> >  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
> >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> > +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> > +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> > +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> > +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> > +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
> > =20
> >  #endif
> > --=20
> > 2.47.2
> >  =20


