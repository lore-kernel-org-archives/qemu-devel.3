Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A2FC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28Ti-0007B6-FD; Thu, 03 Sep 2026 10:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x28Tg-0007AR-LN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x28Te-0008SN-2e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788445900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDkTa0RSVNlIfE5Kcn//jTb5ZFsQX/qvCk22aj/mcZs=;
 b=ZntZfCFkN5aR2rSoL+gjMn7AIODofr76T4N+l56KQpC9kh6gM4KlW3BajM3e2lnkpBxZ4L
 iWvGfy3b82AKkvurEfscNI0aEt07TkfwDVOeXMvwBSgVVOwFz/6AcSZa4/IPKuobS0vbJt
 ts6jE3PmNuZIYDqretDVIilg5mHNl8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-IMT6gMIDNN6cFXnUCnCQQw-1; Thu,
 03 Sep 2026 10:31:37 -0400
X-MC-Unique: IMT6gMIDNN6cFXnUCnCQQw-1
X-Mimecast-MFC-AGG-ID: IMT6gMIDNN6cFXnUCnCQQw_1788445896
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A2B41882810; Thu,  3 Sep 2026 14:30:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA4AD1955F05; Thu,  3 Sep 2026 14:30:57 +0000 (UTC)
Date: Thu, 3 Sep 2026 10:30:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 7/9] block: Add delay-alert-ms property
Message-ID: <20260903143055.GE825275@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-8-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V+LUTt/h8TRGJQAz"
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-8-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--V+LUTt/h8TRGJQAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 03:52:03PM +0200, Hanna Czenczek wrote:
> This device property allows setting up an I/O latency threshold for when
> to emit a delay QMP event.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/block/block.h   |  5 ++++-
>  blockdev.c                 | 16 +++++++++++++++-
>  hw/block/block.c           |  4 +++-
>  tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index df941df19f2..e7e401dd303 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -36,6 +36,7 @@ typedef struct BlockConf {
>      BlockdevOnError werror;
>      uint32_t num_stats_intervals;
>      uint32_t *stats_intervals;
> +    uint32_t delay_alert_ms;
>  } BlockConf;
> =20
>  static inline unsigned int get_physical_block_exp(BlockConf *conf)
> @@ -83,7 +84,9 @@ static inline unsigned int get_physical_block_exp(Block=
Conf *conf)
>                              _conf.account_failed, ON_OFF_AUTO_AUTO),    \
>      DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
>                       _conf.num_stats_intervals, _conf.stats_intervals,  \
> -                     qdev_prop_uint32, uint32_t)
> +                     qdev_prop_uint32, uint32_t),                       \
> +    DEFINE_PROP_UINT32("delay-alert-ms", _state, _conf.delay_alert_ms,  \
> +                       0)                                               \

The latency histogram feature uses nanoseconds (64-bit integer) whereas
this patch series uses delay-alert-ms (uint32) and a double
floating-point seconds value in the QMP event. Maybe stick to 64-bit
integer nanoseconds everywhere for consistency?

> =20
>  #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
>      DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
> diff --git a/blockdev.c b/blockdev.c
> index 195bac8af01..9c76e89ef38 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -496,6 +496,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
>      BlockdevDetectZeroesOptions detect_zeroes =3D
>          BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
>      const char *throttling_group =3D NULL;
> +    uint64_t delay_alert_ns;
> =20
>      /* Check common options by copying from bs_opts to opts, all other o=
ptions
>       * stay in bs_opts for processing by bdrv_open(). */
> @@ -580,6 +581,14 @@ static BlockBackend *blockdev_init(const char *file,=
 QDict *bs_opts,
> =20
>      read_only =3D qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false);
> =20
> +    delay_alert_ns =3D qemu_opt_get_number(opts, "delay-alert-ms", 0);
> +    if (delay_alert_ns > (uint64_t)INT64_MAX / SCALE_MS) {
> +        error_setg(errp, "delay-alert-ms must not exceed %" PRId64,
> +                   INT64_MAX / SCALE_MS);
> +        goto early_err;
> +    }
> +    delay_alert_ns *=3D SCALE_MS;
> +
>      /* init */
>      if ((!file || !*file) && !qdict_size(bs_opts)) {
>          BlockBackendRootState *blk_rs;
> @@ -618,7 +627,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
>          bs->detect_zeroes =3D detect_zeroes;
> =20
>          block_acct_setup(blk_get_stats(blk), account_invalid, account_fa=
iled,
> -                         NULL, 0, 0, NULL);
> +                         NULL, 0, delay_alert_ns, NULL);
> =20
>          if (!parse_stats_intervals(blk_get_stats(blk), interval_list, er=
rp)) {
>              blk_unref(blk);
> @@ -3753,6 +3762,11 @@ QemuOptsList qemu_common_drive_opts =3D {
>              .type =3D QEMU_OPT_BOOL,
>              .help =3D "whether to account for failed I/O operations "
>                      "in the statistics",
> +        },{
> +            .name =3D "delay-alert-ms",
> +            .type =3D QEMU_OPT_NUMBER,
> +            .help =3D "threshold in ms when to emit an I/O operation "
> +                    "delay QMP event",
>          },
>          { /* end of list */ }
>      },
> diff --git a/hw/block/block.c b/hw/block/block.c
> index 19301c6f995..be0ea89cb79 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -207,6 +207,7 @@ bool blkconf_apply_backend_options(BlockConf *conf, b=
ool readonly,
>      BlockBackend *blk =3D conf->blk;
>      BlockdevOnError rerror, werror;
>      uint64_t perm, shared_perm;
> +    uint64_t delay_alert_ns;
>      bool wce;
>      int ret;
> =20
> @@ -249,9 +250,10 @@ bool blkconf_apply_backend_options(BlockConf *conf, =
bool readonly,
>      blk_set_enable_write_cache(blk, wce);
>      blk_set_on_error(blk, rerror, werror);
> =20
> +    delay_alert_ns =3D (uint64_t)conf->delay_alert_ms * SCALE_MS;
>      if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
>                            conf->account_failed, conf->stats_intervals,
> -                          conf->num_stats_intervals, 0, errp)) {
> +                          conf->num_stats_intervals, delay_alert_ns, err=
p)) {
>          return false;
>      }
>      return true;
> diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
> index a023cd407de..ea6a1875eb3 100644
> --- a/tests/qemu-iotests/172.out
> +++ b/tests/qemu-iotests/172.out
> @@ -31,6 +31,7 @@ Testing:
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
> =20
> =20
> @@ -61,6 +62,7 @@ Testing: -fda TEST_DIR/t.qcow2
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -98,6 +100,7 @@ Testing: -fdb TEST_DIR/t.qcow2
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -113,6 +116,7 @@ Testing: -fdb TEST_DIR/t.qcow2
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
>  floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -154,6 +158,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -169,6 +174,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -211,6 +217,7 @@ Testing: -fdb
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -226,6 +233,7 @@ Testing: -fdb
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
> =20
> =20
> @@ -256,6 +264,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -293,6 +302,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2,i=
ndex=3D1
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -308,6 +318,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2,i=
ndex=3D1
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
>  floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -349,6 +360,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -=
drive if=3Dfloppy,file=3DTEST_DIR/t
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -364,6 +376,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -=
drive if=3Dfloppy,file=3DTEST_DIR/t
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -409,6 +422,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -de=
vice floppy,drive=3Dnone0
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -446,6 +460,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -de=
vice floppy,drive=3Dnone0,unit=3D1
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -483,6 +498,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -dr=
ive if=3Dnone,file=3DTEST_DIR/t.qco
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -498,6 +514,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -dr=
ive if=3Dnone,file=3DTEST_DIR/t.qco
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -549,6 +566,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -564,6 +582,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -606,6 +625,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -621,6 +641,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -663,6 +684,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 1 (0x1)
> @@ -678,6 +700,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -720,6 +743,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 1 (0x1)
> @@ -735,6 +759,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -786,6 +811,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -=
drive if=3Dnone,file=3DTEST_DIR/t.q
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -801,6 +827,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -=
drive if=3Dnone,file=3DTEST_DIR/t.q
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -843,6 +870,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -=
drive if=3Dnone,file=3DTEST_DIR/t.q
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>                dev: floppy, id ""
>                  unit =3D 0 (0x0)
> @@ -858,6 +886,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -=
drive if=3Dnone,file=3DTEST_DIR/t.q
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/unattached/device[N]
> @@ -906,6 +935,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -gl=
obal floppy.drive=3Dnone0 -device
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -973,6 +1003,7 @@ Testing: -device floppy
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
> =20
>  Testing: -device floppy,drive-type=3D120
> @@ -1000,6 +1031,7 @@ Testing: -device floppy,drive-type=3D120
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "120"
> =20
>  Testing: -device floppy,drive-type=3D144
> @@ -1027,6 +1059,7 @@ Testing: -device floppy,drive-type=3D144
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
> =20
>  Testing: -device floppy,drive-type=3D288
> @@ -1054,6 +1087,7 @@ Testing: -device floppy,drive-type=3D288
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
> =20
> =20
> @@ -1084,6 +1118,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -=
device floppy,drive=3Dnone0,drive-t
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "120"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -1121,6 +1156,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -=
device floppy,drive=3Dnone0,drive-t
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "288"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -1161,6 +1197,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -=
device floppy,drive=3Dnone0,logical
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> @@ -1198,6 +1235,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -=
device floppy,drive=3Dnone0,physica
>                  account-invalid =3D "auto"
>                  account-failed =3D "auto"
>                  stats-intervals =3D <null>
> +                delay-alert-ms =3D 0 (0x0)
>                  drive-type =3D "144"
>  none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>      Attached to:      /machine/peripheral-anon/device[N]
> --=20
> 2.55.0
>=20

--V+LUTt/h8TRGJQAz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqZhJ8ACgkQnKSrs4Gr
c8i4Kwf/cnz+JyBmig9RNlW8hPHySl5JlMW+4WYU6Txtt6G8FNdLySsV91R6Wwrq
nASwsxUkfadqfB/f0K0cslOP5gARIhcrSZKoqk5r5ufLnC3EYos3mr9vEFDP7+i/
1TEcJhrFBcFL8PH75aepZNVWvmeE9xW90Vk6LXAy1IbfAAbMiu+oFyhk/u/IDwkv
W145ba/HaIY1ptd3wyVNODgtYJkE4g0dg2U3eJiOFgfNkgWqOMS4Vw1JWbUm5FHX
tn0GE0e5c8WLUfhh3S2VyH/JVdZxvTaSAiQsadrH/0vu2iBnloArjPBpd/vf4aaX
V0+7sR4nAP6HaBeRN89zfqJUCsGn4Q==
=Ao+5
-----END PGP SIGNATURE-----

--V+LUTt/h8TRGJQAz--


