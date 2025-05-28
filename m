Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD61C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKG0D-0005fg-US; Wed, 28 May 2025 08:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKG0B-0005Yw-4w
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:35:23 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKG05-0006J9-Tn
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:35:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6pfv1vtgz6L5Gp;
 Wed, 28 May 2025 20:27:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B04791402F1;
 Wed, 28 May 2025 20:31:08 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 May
 2025 14:31:08 +0200
Date: Wed, 28 May 2025 13:31:06 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan
 Wang <wangyuquan1236@phytium.com.cn>, Sweta Kumari <s5.kumari@samsung.com>,
 Vinayak Holikatti <vinayak.kh@samsung.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ajay Joshi <ajay.opensrc@micron.com>, <cpgs@samsung.com>
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for
 Get Log Capabilities (Opcode 0402h)
Message-ID: <20250528133106.000003c8@huawei.com>
In-Reply-To: <1983025922.01747408682214.JavaMail.epsvc@epcpadp2new>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
 <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
 <20250512043011-mutt-send-email-mst@kernel.org>
 <20250512093638-mutt-send-email-mst@kernel.org>
 <20250512174038.00000beb@huawei.com>
 <CGME20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043@epcas5p3.samsung.com>
 <1983025922.01747408682214.JavaMail.epsvc@epcpadp2new>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 16 May 2025 19:12:45 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 12/05/25 05:40PM, Jonathan Cameron wrote:
> >On Mon, 12 May 2025 09:37:07 -0400
> >"Michael S. Tsirkin" <mst@redhat.com> wrote:
> > =20
> >> On Mon, May 12, 2025 at 04:42:41AM -0400, Michael S. Tsirkin wrote: =20
> >> > On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote: =20
> >> > > From: Arpit Kumar <arpit1.kumar@samsung.com>
> >> > >
> >> > > CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
> >> > > It provides log capabilities supported by specified log.
> >> > >
> >> > > Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> >> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> > > ---
> >> > >  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
> >> > >  include/hw/cxl/cxl_mailbox.h |  5 ++++
> >> > >  hw/cxl/cxl-mailbox-utils.c   | 45 +++++++++++++++++++++++++++++++=
+++++
> >> > >  3 files changed, 70 insertions(+)
> >> > >
> >> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_devi=
ce.h
> >> > > index ed6cd50c67..87a376c982 100644
> >> > > --- a/include/hw/cxl/cxl_device.h
> >> > > +++ b/include/hw/cxl/cxl_device.h
> >> > > @@ -133,6 +133,18 @@ typedef enum {
> >> > >      CXL_MBOX_MAX =3D 0x20
> >> > >  } CXLRetCode;
> >> > >
> >> > > +/* types of logs */
> >> > > +typedef enum {
> >> > > +    CXL_LOG_COMMAND_EFFECT,
> >> > > +    CXL_LOG_VENDOR_DEBUG,
> >> > > +    CXL_LOG_COMPONENT_STATE_DUMP,
> >> > > +    CXL_LOG_ERROR_CHECK_SCRUB,
> >> > > +    CXL_LOG_MEDIA_TEST_CAPABILITY,
> >> > > +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
> >> > > +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
> >> > > +    MAX_LOG_TYPE
> >> > > +} CXLLogType;
> >> > > +
> >> > >  typedef struct CXLCCI CXLCCI;
> >> > >  typedef struct cxl_device_state CXLDeviceState;
> >> > >  struct cxl_cmd;
> >> > > @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
> >> > >      QSIMPLEQ_HEAD(, CXLEvent) events;
> >> > >  } CXLEventLog;
> >> > >
> >> > > +typedef struct CXLLogCapabilities {
> >> > > +    uint32_t param_flags;
> >> > > +    QemuUUID uuid;
> >> > > +} CXLLogCapabilities;
> >> > > +
> >> > >  typedef struct CXLCCI {
> >> > >      struct cxl_cmd cxl_cmd_set[256][256];
> >> > >      struct cel_log {
> >> > > @@ -171,6 +188,9 @@ typedef struct CXLCCI {
> >> > >      } cel_log[1 << 16];
> >> > >      size_t cel_size;
> >> > >
> >> > > +    /* get log capabilities */
> >> > > +    const CXLLogCapabilities *supported_log_cap;
> >> > > +
> >> > >      /* background command handling (times in ms) */
> >> > >      struct {
> >> > >          uint16_t opcode;
> >> > > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mai=
lbox.h
> >> > > index 9008402d1c..8e1c7c5f15 100644
> >> > > --- a/include/hw/cxl/cxl_mailbox.h
> >> > > +++ b/include/hw/cxl/cxl_mailbox.h
> >> > > @@ -16,4 +16,9 @@
> >> > >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> >> > >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> >> > >
> >> > > +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
> >> > > +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> >> > > +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> >> > > +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> >> > > +
> >> > >  #endif
> >> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils=
.c
> >> > > index 299f232f26..f35fc4f112 100644
> >> > > --- a/hw/cxl/cxl-mailbox-utils.c
> >> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> >> > > @@ -81,6 +81,7 @@ enum {
> >> > >      LOGS        =3D 0x04,
> >> > >          #define GET_SUPPORTED 0x0
> >> > >          #define GET_LOG       0x1
> >> > > +        #define GET_LOG_CAPABILITIES   0x2
> >> > >      FEATURES    =3D 0x05,
> >> > >          #define GET_SUPPORTED 0x0
> >> > >          #define GET_FEATURE   0x1
> >> > > @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const st=
ruct cxl_cmd *cmd,
> >> > >      return CXL_MBOX_SUCCESS;
> >> > >  }
> >> > >
> >> > > +static const struct CXLLogCapabilities *find_log_index(QemuUUID *=
uuid, CXLCCI *cci)
> >> > > +{
> >> > > +    for (int i =3D CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++)=
 {
> >> > > +        if (qemu_uuid_is_equal(uuid,
> >> > > +            &cci->supported_log_cap[i].uuid)) {
> >> > > +                return &cci->supported_log_cap[i];
> >> > > +        }
> >> > > +    }
> >> > > +    return NULL;
> >> > > +}
> >> > > +
> >> > > +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402=
h) */
> >> > > +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_=
cmd *cmd,
> >> > > +                                                uint8_t *payload_=
in,
> >> > > +                                                size_t len_in,
> >> > > +                                                uint8_t *payload_=
out,
> >> > > +                                                size_t *len_out,
> >> > > +                                                CXLCCI *cci)
> >> > > +{
> >> > > +    const CXLLogCapabilities *cap;
> >> > > +    struct {
> >> > > +        QemuUUID uuid;
> >> > > +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in =3D (v=
oid *)payload_in;
> >> > > +
> >> > > +    uint32_t *get_log_capabilities_out =3D (uint32_t *)payload_ou=
t;
> >> > > +
> >> > > +    cap =3D find_log_index(&get_log_capabilities_in->uuid, cci);
> >> > > +    if (!cap) {
> >> > > +        return CXL_MBOX_INVALID_LOG;
> >> > > +    }
> >> > > +
> >> > > +    memcpy(get_log_capabilities_out, &cap->param_flags,
> >> > > +           sizeof(cap->param_flags));
> >> > > +    *len_out =3D sizeof(*get_log_capabilities_out);
> >> > > +    return CXL_MBOX_SUCCESS;
> >> > > +}
> >> > > +
> >> > >  /* CXL r3.1 section 8.2.9.6: Features */
> >> > >  /*
> >> > >   * Get Supported Features output payload
> >> > > @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256]=
[256] =3D {
> >> > >      [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED", cmd_logs_ge=
t_supported,
> >> > >                                0, 0 },
> >> > >      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18,=
 0 },
> >> > > +    [LOGS][GET_LOG_CAPABILITIES] =3D { "LOGS_GET_LOG_CAPABILITIES=
",
> >> > > +                                     cmd_logs_get_log_capabilitie=
s, 0x10, 0 },
> >> > >      [FEATURES][GET_SUPPORTED] =3D { "FEATURES_GET_SUPPORTED",
> >> > >                                    cmd_features_get_supported, 0x8=
, 0 },
> >> > >      [FEATURES][GET_FEATURE] =3D { "FEATURES_GET_FEATURE",
> >> > > @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
> >> > >      }
> >> > >  }
> >> > >
> >> > > +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TY=
PE] =3D {
> >> > > +    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D =
cel_uuid },
> >> > > +};
> >> > > + =20
> >> >
> >> >
> >> > causes ci build failures:
> >> >
> >> > https://gitlab.com/mstredhat/qemu/-/jobs/9999980051
> >> >
> >> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is=
 not constant
> >> >      [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D ce=
l_uuid },
> >> >                                                             ^~~~~~~~
> >> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization fo=
r =E2=80=98cxl_get_log_cap[0].uuid=E2=80=99)
> >> >
> >> >
> >> > Fixed it up like this:
> >> >
> >> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >> > index f35fc4f112..13d26e391b 100644
> >> > --- a/hw/cxl/cxl-mailbox-utils.c
> >> > +++ b/hw/cxl/cxl-mailbox-utils.c
> >> > @@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struc=
t cxl_cmd *cmd,
> >> >  }
> >> >
> >> >  /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
> >> > -static const QemuUUID cel_uuid =3D {
> >> > -    .data =3D UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> >> > +#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
> >> >                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> >> > +static const QemuUUID cel_uuid =3D {
> >> > +    .data =3D CEL_UUID
> >> >  };
> >> >
> >> >  /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
> >> > @@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
> >> >  }
> >> >
> >> >  static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE=
] =3D {
> >> > -    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D ce=
l_uuid },
> >> > +    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D CE=
L_UUID },
> >> >  };
> >> >
> >> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >> > =20
> >>
> >>
> >> Actually no, does not help either. Dropped for now.
> >> Next patch does not depend on this one, right? =20
> >
> >Indeed. Unrelated.
> >
> >Thanks,
> >
> >J =20
>=20
> Thanks for pointing this out. The code builds successfully on my setup
> with gcc version: 11.4.0. However, it fails to compile on gcc 7.5.0
> "cc (SUSE Linux) 7.5.0" as used by Michael. This could be a compiler
> issue as per the link:
> https://stackoverflow.com/questions/54135942/why-initializer-
> element-is-not-a-constant-is-not-working-anymore.
>=20
> My setup doesn't allow me to regenerate the error using lower version
> of compiler. A probable fix to it would be
> type casting cel_uuid as: [CXL_LOG_COMMAND_EFFECT] =3D
> { .param_flags =3D 0,.uuid =3D (QemuUUID)cel_uuid }. It will be helpful
> if you could test the same.

I wonder if we are better off just filling it in in cxl_init_cci()
So change the type of the element in struct CXLCCI to
CXLLogCapabiliites supported_log_cap[MAX_LOGS];

then assign the elements at runtime.

That should avoid any issues with whether it is const or not at the
cost of a little more code.

>=20
> Also, In the existing code,
> function: cmd_logs_get_supported(), cel_uuid(const) is assigned to a
> non-const variable but I am unsure of why it is not throwing an error.

Isn't it just copying the content which should be fine?

>=20
> Thanks,
> Arpit
> >> =20
> >> > >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >> > >  {
> >> > >      cci->payload_max =3D payload_max;
> >> > >      cxl_rebuild_cel(cci);
> >> > > +    cci->supported_log_cap =3D cxl_get_log_cap;
> >> > >
> >> > >      cci->bg.complete_pct =3D 0;
> >> > >      cci->bg.starttime =3D 0;
> >> > > --
> >> > > 2.43.0 =20
> >>
> >> =20
> > =20
>=20


