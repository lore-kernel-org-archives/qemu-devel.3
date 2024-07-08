Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9985AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQk0G-0002rU-GE; Mon, 08 Jul 2024 04:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQk08-0002pX-FZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQjzs-000669-Ho
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720428319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AAsUG7VIkwkjdf4MIUWI9q4sjklgv/bMkuot8YRjWzs=;
 b=DcJBRNeMNxpOOC8PA3o/TFqTvTDsSDfTt8fen2ZGytu2tiM82N+/ZvTV2YqVHOJL7u1eOZ
 OT4346Svdlr+nhOAwEyoJK2/l3uwyoDL38+Q9mIJNGfN8Lsh34nI6wHsXKXAJBBEFW1gNc
 hv9wtQKmuxbvjmwHEije40s8tDGZDRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-wTStp47zN3S0-WjKe034EQ-1; Mon,
 08 Jul 2024 04:45:16 -0400
X-MC-Unique: wTStp47zN3S0-WjKe034EQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE9951956080; Mon,  8 Jul 2024 08:45:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93C9A3000184; Mon,  8 Jul 2024 08:45:10 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:45:08 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 10/10] block/iscsi: add persistent reservation in/out
 driver
Message-ID: <20240708084508.GE38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
 <20240705105614.3377694-11-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dbvqLtj0lAk26G9w"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-11-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--dbvqLtj0lAk26G9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 06:56:14PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations for iscsi driver.
> The following methods are implemented: bdrv_co_pr_read_keys,
> bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
> bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/iscsi.c | 431 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 431 insertions(+)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 2ff14b7472..9a546f48de 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -96,6 +96,7 @@ typedef struct IscsiLun {
>      unsigned long *allocmap_valid;
>      long allocmap_size;
>      int cluster_size;
> +    uint8_t pr_cap;
>      bool use_16_for_rw;
>      bool write_protected;
>      bool lbpme;
> @@ -280,6 +281,10 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int=
 status,
>                      iTask->err_code =3D -error;
>                      iTask->err_str =3D g_strdup(iscsi_get_error(iscsi));
>                  }
> +            } else if (status =3D=3D SCSI_STATUS_RESERVATION_CONFLICT) {
> +                iTask->err_code =3D -EBADE;
> +                error_report("iSCSI Persistent Reservation Conflict: %s",
> +                             iscsi_get_error(iscsi));
>              }
>          }
>      }
> @@ -1792,6 +1797,52 @@ static void iscsi_save_designator(IscsiLun *lun,
>      }
>  }
> =20
> +static void iscsi_get_pr_cap_sync(IscsiLun *iscsilun, Error **errp)
> +{
> +    struct scsi_task *task =3D NULL;
> +    struct scsi_persistent_reserve_in_report_capabilities *rc =3D NULL;
> +    int retries =3D ISCSI_CMD_RETRIES;
> +    int xferlen =3D sizeof(struct scsi_persistent_reserve_in_report_capa=
bilities);
> +
> +    do {
> +        if (task !=3D NULL) {
> +            scsi_free_scsi_task(task);
> +            task =3D NULL;
> +        }
> +
> +        task =3D iscsi_persistent_reserve_in_sync(iscsilun->iscsi,
> +               iscsilun->lun, SCSI_PR_IN_REPORT_CAPABILITIES, xferlen);
> +        if (task !=3D NULL && task->status =3D=3D SCSI_STATUS_GOOD) {
> +                rc =3D scsi_datain_unmarshall(task);
> +                if (rc =3D=3D NULL) {
> +                    error_setg(errp,
> +                    "iSCSI: Failed to unmarshall report capabilities dat=
a.");
> +                } else {
> +                    iscsilun->pr_cap =3D
> +                    scsi_pr_cap_to_block(rc->persistent_reservation_type=
_mask);
> +                    iscsilun->pr_cap |=3D (rc->ptpl_a) ? BLK_PR_CAP_PTPL=
 : 0;
> +                }
> +                break;
> +            }
> +
> +        if (task !=3D NULL && task->status =3D=3D SCSI_STATUS_CHECK_COND=
ITION
> +            && task->sense.key =3D=3D SCSI_SENSE_UNIT_ATTENTION) {
> +            break;
> +        }
> +
> +    } while (task !=3D NULL && task->status =3D=3D SCSI_STATUS_CHECK_CON=
DITION
> +             && task->sense.key =3D=3D SCSI_SENSE_UNIT_ATTENTION
> +             && retries-- > 0);

The if statement is the same condition as the while statement (except
for the retry counter)? It looks like retrying logic won't work in
practice because the if statement breaks early.

> +
> +    if (task =3D=3D NULL || task->status !=3D SCSI_STATUS_GOOD) {
> +        error_setg(errp, "iSCSI: failed to send report capabilities comm=
and");
> +    }

Did you test this function against a SCSI target that does not implement
the optional PERSISTENT RESERVE IN operation? iscsi_open() must succeed
when the target does not implement this.

> +
> +    if (task) {
> +        scsi_free_scsi_task(task);
> +    }
> +}
> +
>  static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
>                        Error **errp)
>  {
> @@ -2024,6 +2075,11 @@ static int iscsi_open(BlockDriverState *bs, QDict =
*options, int flags,
>          bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP;
>      }
> =20
> +    iscsi_get_pr_cap_sync(iscsilun, &local_err);
> +    if (local_err !=3D NULL) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +    }
>  out:
>      qemu_opts_del(opts);
>      g_free(initiator_name);
> @@ -2110,6 +2166,8 @@ static void iscsi_refresh_limits(BlockDriverState *=
bs, Error **errp)
>          bs->bl.opt_transfer =3D pow2floor(iscsilun->bl.opt_xfer_len *
>                                          iscsilun->block_size);
>      }
> +
> +    bs->bl.pr_cap =3D iscsilun->pr_cap;
>  }
> =20
>  /* Note that this will not re-establish a connection with an iSCSI targe=
t - it
> @@ -2408,6 +2466,371 @@ out_unlock:
>      return r;
>  }
> =20
> +static int coroutine_fn
> +iscsi_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
> +                      uint32_t num_keys, uint64_t *keys)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    QEMUIOVector qiov;
> +    struct IscsiTask iTask;
> +    int xferlen =3D sizeof(struct scsi_persistent_reserve_in_read_keys) +
> +                  sizeof(uint64_t) * num_keys;
> +    uint8_t *buf =3D g_malloc0(xferlen);
> +    int32_t num_collect_keys =3D 0;
> +    int r =3D 0;
> +
> +    qemu_iovec_init_buf(&qiov, buf, xferlen);
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_in_task(iscsilun->iscsi,
> +                 iscsilun->lun, SCSI_PR_IN_READ_KEYS, xferlen,
> +                 iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;

buf is leaked. Use g_autofree to avoid having to call g_free() manually.

> +    }
> +
> +    scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *)qiov.iov, qiov=
=2Eniov);
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_IN failed: %s", iTask.err=
_str);
> +        r =3D iTask.err_code;
> +        goto out;
> +    }
> +
> +    memcpy(generation, &buf[0], 4);
> +    *generation =3D be32_to_cpu(*generation);
> +    memcpy(&num_collect_keys, &buf[4], 4);
> +    num_collect_keys =3D be32_to_cpu(num_collect_keys) / sizeof(uint64_t=
);
> +    if (num_collect_keys > num_keys) {
> +        r =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    for (int i =3D 0; i < num_collect_keys; i++) {
> +        memcpy(&keys[i], &buf[8 + i * 8], 8);
> +        keys[i] =3D be64_to_cpu(keys[i]);
> +    }
> +    r =3D num_collect_keys;
> +
> +out:
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +    g_free(iTask.err_str);
> +    g_free(buf);
> +    return r;
> +}
> +
> +static int coroutine_fn
> +iscsi_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
> +                             uint64_t *key, BlockPrType *type)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    QEMUIOVector qiov;
> +    struct IscsiTask iTask;
> +    int xferlen =3D sizeof(struct scsi_persistent_reserve_in_read_reserv=
ation);
> +    uint8_t *buf =3D g_malloc0(xferlen);
> +    uint8_t scope_type =3D 0;
> +    int32_t num_collect_keys =3D 0;
> +    int r =3D 0;
> +
> +    qemu_iovec_init_buf(&qiov, buf, xferlen);
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_in_task(iscsilun->iscsi,
> +                 iscsilun->lun, SCSI_PR_IN_READ_RESERVATION,
> +                 xferlen, iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;

buf is leaked. Use g_autofree to avoid having to call g_free() manually.

> +    }
> +
> +    scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *)qiov.iov, qiov=
=2Eniov);
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_IN failed: %s", iTask.err=
_str);
> +        r =3D iTask.err_code;
> +        goto out;
> +    }
> +
> +    memcpy(generation, &buf[0], 4);
> +    *generation =3D be32_to_cpu(*generation);
> +    memcpy(key, &buf[8], 8);
> +    *key =3D be64_to_cpu(*key);
> +    memcpy(&scope_type, &buf[21], 1);
> +    *type =3D scsi_pr_type_to_block(scope_type & 0xf);
> +    memcpy(&num_collect_keys, &buf[4], 4);
> +    r =3D be32_to_cpu(num_collect_keys) / sizeof(uint64_t);
> +out:
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +    g_free(iTask.err_str);
> +    g_free(buf);
> +    return r;
> +}
> +
> +static int coroutine_fn
> +iscsi_co_pr_register(BlockDriverState *bs, uint64_t old_key,
> +                     uint64_t new_key, BlockPrType type,
> +                     bool ptpl, bool ignore_key)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    struct IscsiTask iTask;
> +    struct scsi_persistent_reserve_out_basic basic;
> +    SCSIPrOutAction action =3D ignore_key ? SCSI_PR_OUT_REG_AND_IGNORE_K=
EY :
> +                                          SCSI_PR_OUT_REGISTER;
> +    int r =3D 0;
> +
> +    basic.reservation_key =3D old_key;
> +    basic.service_action_reservation_key =3D new_key;
> +    basic.aptpl =3D ptpl ? 1 : 0;
> +
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_out_task(iscsilun->iscsi,
> +                 iscsilun->lun, action, 0, block_pr_type_to_scsi(type),
> +                 &basic, iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;
> +    }
> +
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.er=
r_str);
> +        r =3D iTask.err_code;
> +    }
> +
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +
> +    g_free(iTask.err_str);
> +    return r;
> +}
> +
> +static int coroutine_fn
> +iscsi_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    struct IscsiTask iTask;
> +    struct scsi_persistent_reserve_out_basic basic;
> +    int r =3D 0;
> +
> +    basic.reservation_key =3D key;
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_out_task(iscsilun->iscsi,
> +                 iscsilun->lun, SCSI_PR_OUT_RESERVE, 0,
> +                 block_pr_type_to_scsi(type), &basic,
> +                 iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;
> +    }
> +
> +
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.er=
r_str);
> +        r =3D iTask.err_code;
> +    }
> +
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +
> +    g_free(iTask.err_str);
> +    return r;
> +}
> +
> +static int coroutine_fn
> +iscsi_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    struct IscsiTask iTask;
> +    struct scsi_persistent_reserve_out_basic basic;
> +    int r =3D 0;
> +
> +    basic.reservation_key =3D key;
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_out_task(iscsilun->iscsi,
> +                 iscsilun->lun, SCSI_PR_OUT_RELEASE, 0,
> +                 block_pr_type_to_scsi(type), &basic,
> +                 iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;
> +    }
> +
> +
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.er=
r_str);
> +        r =3D iTask.err_code;
> +    }
> +
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +
> +    g_free(iTask.err_str);
> +    return r;
> +}
> +
> +static int coroutine_fn
> +iscsi_co_pr_clear(BlockDriverState *bs, uint64_t key)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    struct IscsiTask iTask;
> +    struct scsi_persistent_reserve_out_basic basic;
> +    int r =3D 0;
> +
> +    basic.reservation_key =3D key;
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_out_task(iscsilun->iscsi,
> +                 iscsilun->lun, SCSI_PR_OUT_CLEAR, 0, 0, &basic,
> +                 iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;
> +    }
> +
> +
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.er=
r_str);
> +        r =3D iTask.err_code;
> +    }
> +
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +
> +    g_free(iTask.err_str);
> +    return r;
> +}
> +
> +static int coroutine_fn
> +iscsi_co_pr_preempt(BlockDriverState *bs, uint64_t old_key,
> +                    uint64_t new_key, BlockPrType type, bool abort)
> +{
> +    IscsiLun *iscsilun =3D bs->opaque;
> +    struct IscsiTask iTask;
> +    struct scsi_persistent_reserve_out_basic basic;
> +    SCSIPrOutAction action =3D abort ? SCSI_PR_OUT_PREEMPT_AND_ABORT :
> +                                     SCSI_PR_OUT_PREEMPT;
> +    int r =3D 0;
> +
> +    basic.reservation_key =3D old_key;
> +    basic.service_action_reservation_key =3D new_key;
> +
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    qemu_mutex_lock(&iscsilun->mutex);
> +retry:
> +    iTask.task =3D iscsi_persistent_reserve_out_task(iscsilun->iscsi,
> +                 iscsilun->lun, action, 0, block_pr_type_to_scsi(type),
> +                 &basic, iscsi_co_generic_cb, &iTask);
> +
> +    if (iTask.task =3D=3D NULL) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return -ENOMEM;
> +    }
> +
> +
> +    iscsi_co_wait_for_task(&iTask, iscsilun);
> +
> +    if (iTask.task !=3D NULL) {
> +        scsi_free_scsi_task(iTask.task);
> +        iTask.task =3D NULL;
> +    }
> +
> +    if (iTask.do_retry) {
> +        iTask.complete =3D 0;
> +        goto retry;
> +    }
> +
> +    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.er=
r_str);
> +        r =3D iTask.err_code;
> +    }
> +
> +    qemu_mutex_unlock(&iscsilun->mutex);
> +
> +    g_free(iTask.err_str);
> +    return r;
> +}
> +
> =20
>  static const char *const iscsi_strong_runtime_opts[] =3D {
>      "transport",
> @@ -2451,6 +2874,14 @@ static BlockDriver bdrv_iscsi =3D {
>      .bdrv_co_writev        =3D iscsi_co_writev,
>      .bdrv_co_flush_to_disk =3D iscsi_co_flush,
> =20
> +    .bdrv_co_pr_read_keys     =3D iscsi_co_pr_read_keys,
> +    .bdrv_co_pr_read_reservation =3D iscsi_co_pr_read_reservation,
> +    .bdrv_co_pr_register      =3D iscsi_co_pr_register,
> +    .bdrv_co_pr_reserve       =3D iscsi_co_pr_reserve,
> +    .bdrv_co_pr_release       =3D iscsi_co_pr_release,
> +    .bdrv_co_pr_clear         =3D iscsi_co_pr_clear,
> +    .bdrv_co_pr_preempt       =3D iscsi_co_pr_preempt,
> +
>  #ifdef __linux__
>      .bdrv_aio_ioctl   =3D iscsi_aio_ioctl,
>  #endif
> --=20
> 2.20.1
>=20

--dbvqLtj0lAk26G9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLpxMACgkQnKSrs4Gr
c8hqgwf9EaFhHY/ysWM+pdJy3EKeG1GWPGXojZw0Sx/HAJO7TySZDre6SOvV34sP
lvdz6DCv2HMQbNSPR9821a4Bq4esZQs1cQ6iYnF3Rlx5S0Gu0RtyOu1Q9WMneQqb
+LBjCmRoyYGLIPcY/IDF2P380oyYoR9SH72Imt9rlazBuoNs3r7NUkm2gO6TyxsO
WOk9EpMPotVzgb7YJC7lp/Qnku9zRZWe5wdcMGi3qcXdeu+E6ksqvxiVX9WL4+a7
dG/Dj6eUaVoeNfnNvS+wb1Ybld6pAsT7ek/joieo9zlEPgqujcabUaRNLKxoSEHu
ulz1eWfPwOdZMNYclyAiYsCS6vlp1w==
=b4YH
-----END PGP SIGNATURE-----

--dbvqLtj0lAk26G9w--


