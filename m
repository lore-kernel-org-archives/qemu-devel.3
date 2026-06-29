Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E700DC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGbq-0008V0-NR; Mon, 29 Jun 2026 14:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1weGbp-0008UR-4E
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:21:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1weGbn-0002jJ-0T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:21:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8478a25f268so768479b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 11:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782757285; cv=none;
 d=google.com; s=arc-20260327;
 b=mmxpBQ9vIRdjKExFSz7Hmf6u94RVtgi3dfhDuK6KL42Aw1UVHPj3tr4We5/sfoEQfz
 zrRC1XaAbLjcO2B/CL0DYkQRqappEXna3kyzmTayrY83HG5W7oFWnk2NmY4kn1gma5k7
 04+3wGwsBn+d/ep4ZWxdOMCRKcY3bQETQjuR9ej+KT/r0tkIHISjNiDuKGAI5eE+IIJi
 55rQEcHzjzaE2cO9YdniNwwOPWd6hxWF/BKeZnQ3RH72U4QYEChpF5eBkvTMM+MmAvIV
 wzTLCH6v7SMbR+7DaGlqRLy2OcjREs9hViyrflj6gDaftJ6ebrMU9TsO1MESFcgO6UVq
 R2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ibSjvJurMKgG+NZuW9rjlu9VE7HfibJBXwcOdV6nEO0=;
 fh=XzYYY6zGuaeK7RpC0JkE3KAzbewp6R2ig/Zl+XwuABE=;
 b=bx8sUOapoA21bQQ+EsyuqmcXoqMaeVkJdHa/Up4YYFlywPNvyPR2Ji8QcRRXvpvuyo
 xUS5m9i4CyuFMGeOieOOTl0IEXgGNH5vz4ZrYI4p5WTlXd1tpkTYmM9dn1mrMC5EmHa3
 Cco8EkiF9ENLi+PHqJdeGLSZVwhQWa5UHiqBEXFsVm1y/a1EtFrsZ8ilm3+Jc3pPaAfp
 av9RfwxYGP+gCOtdfRtrF4Drf5rgg6dTOVa3iSUL8iMJDaMD3l2NvwZv8xbn/g3pYwdG
 GnhlS4/qg29GCCm8sEaSd1IlTMR/Cz0xQeDt7M6sLlWkt80uvA+FMViQLZd13NIDniTb
 tutQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782757285; x=1783362085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibSjvJurMKgG+NZuW9rjlu9VE7HfibJBXwcOdV6nEO0=;
 b=MWKD0hgWsPBouddmhf4fOgbnKwZEyAMBWubECeZVd9uD+9fN+DHENvHx929xygZs1x
 GAtcTlYhtRMhWbTDYmahc+TCFYprL3qMb49FFjPW06+Rnx9Q34lEIiIKdnKOyxC6r7OU
 SYbfRHuGzdBP78nvCZlLmgeDudFbq5DUpKkYD9t/DJlGhEmfILT+iabfAum2645jLPa1
 M1IYLfzRH0otXYXpe6cmQyqitcJE7BckbXMD13cqWy3JdcpXefFNytLqqubV9CLxZIUx
 3k11WhO6bh6aKwm6jFoVM4VOH9k7eBYFVlpuY6sn6ApcguR0MxHYaIGt111zZHJz4LH2
 rM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782757285; x=1783362085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ibSjvJurMKgG+NZuW9rjlu9VE7HfibJBXwcOdV6nEO0=;
 b=KSGHDjWQikJ15Rq+nI5M76ysqiCSoRC8th/3LM72SY5WKpXZxJj18EEophKiOISmGi
 /g1dMNQ/h0rukbcINJqsNRUTegoO/eJPItL3eMNc6rRxp3j5Gh6EDF7O4cHsNeg+wv7u
 qep4yQLwD9J1LtVzeMPqfdsfBDRZFB5P6XFfezqz1QHoA5cy0fUkMCk1m3WKLSJ7LCv+
 m7c1K5wEdKY6IHN8n9KHqvl0ObA/3TxwMkTWy8lDsCozY7SahqLOiFVyq0ipjMIhVS8D
 1dsTUB7I6+EdvU/2cbK/c1BL6jByzZkNMapJGgbqCB5pDHDDsOz0Xr2KZ/ydmlbTNCv4
 0oSg==
X-Gm-Message-State: AOJu0YxJ8p5WraoXoNELKatIdk2em9RzzJgPm+73zCtySlV2e5oF3qYU
 GcEPhcGvUDGjbqpCDmAnuADHHG9e8ai6vr3F/S+9lJQEFnePgsQVDu1cLrF6io9P7+94V+lauA+
 pe9GrgWmcCyuSyXwRvYKWiL7aWN/kv9s=
X-Gm-Gg: AfdE7clyL9q1QIx9RUHl3S4Y4EpoR3qAk430dmNkp2AvSDrTW4j0KTsweniGsUba52b
 YuQ1g46O4iqULdI+ohUuI+EANWXSZS1cvsr/UR55z44P18PcRzII3CbrpAcZLsa/olZjmtlUtst
 tN7oJWn+y2J+E6y4o/50Sa+iQO4ka9uP6CUgrmsNojOwgMKXhqXcbbY0Gqf/4/bLnrmYhcYxBLE
 n3AMiyB3Wt6gsbxw/dJnTgb3mB1TmuMEliOccxawcu3Vkzjd0P0/BT+zXOVemaQne+SrB/eL19n
 1SDwuED7iYNzDkjdqaxQ+9mOwjT76z3C2zS6x0fuws5RnQs7CT++8LZMcJGkT9A=
X-Received: by 2002:a05:6a21:9d84:b0:3bf:c126:baf2 with SMTP id
 adf61e73a8af0-3bfc52c5e47mr501784637.47.1782757284971; Mon, 29 Jun 2026
 11:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-5-faithilikerun@gmail.com>
 <20260629174006.GA376767@fedora>
In-Reply-To: <20260629174006.GA376767@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 29 Jun 2026 20:20:59 +0200
X-Gm-Features: AVVi8CcEJuGTZVK-CBSFoL7ee69Znr3dHr-U4thyu9BzooI-lZTOo6Ht7kHY3KY
Message-ID: <CAAAx-8J9JETp4M9wWMfdAtUdELGko7C50HNOGLDOZVf70XmiNQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] qcow2: add zoned emulation capability
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org, 
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 29, 2026 at 7:40=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 08:48:29PM +0200, Sam Li wrote:
> > +/*
> > + * Read/Write the new wp value for zone `index` through write pointe
>
> pointe -> pointer
>
> > +static int coroutine_fn
> > +qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
> > +                     unsigned int *nr_zones, BlockZoneDescriptor *zone=
s)
> > +{
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    uint64_t zone_size =3D s->zoned_header.zone_size;
> > +    uint64_t zone_capacity =3D s->zoned_header.zone_capacity;
> > +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> > +    int64_t size =3D bs->bl.nr_zones * zone_size;
> > +    unsigned int nrz;
> > +    int i =3D 0;
> > +    int si;
>
> Should i and si be unsigned int since nr_zones is an unsigned int?
>
> > +static int coroutine_fn GRAPH_RDLOCK
> > +qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
> > +                            int64_t len)
> > +{
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    int nrz =3D bs->bl.nr_zones;
> > +    int64_t zone_size =3D bs->bl.zone_size;
> > +    int n, ret =3D 0;
> > +    bool any_dirtied =3D false;
>
> nr_zones is an unsigned int. Variables holding numbers of zones like
> nrz, i, and n should be unsigned int, too. That way they behave
> correctly over their full range instead of behaving unexpectedly when
> they become negative (e.g. in a for loop with i < n).

Makes sense.

>
> > +
> > +    qemu_co_mutex_lock(&bs->wps->colock);
> > +    uint64_t *wp =3D &bs->wps->wp[index];
> > +    if (len =3D=3D bs->total_sectors << BDRV_SECTOR_BITS) {
> > +        n =3D nrz;
> > +        index =3D 0;
> > +        wp =3D &bs->wps->wp[0];
> > +    } else {
> > +        n =3D len / zone_size;
> > +    }
> > +
> > +    for (int i =3D 0; i < n; ++i) {
> > +        uint64_t *wp_i =3D (uint64_t *)(wp + i);
> > +        uint64_t wpi_v =3D *wp_i;
> > +        if (QCOW2_ZT_IS_CONV(wpi_v)) {
> > +            continue;
> > +        }
> > +
> > +        /* Reject if any write is in flight for this zone. */
> > +        if (s->zone_wp_state &&
> > +            !QTAILQ_EMPTY(&s->zone_wp_state[index + i].in_flight)) {
> > +            ret =3D -EBUSY;
> > +            goto unlock;
> > +        }
>
> This is a coroutine function and it should yield to wait instead of
> returning -EBUSY. If -EBUSY is propagated to the guest that would result
> in unexpected behavior - I think real devices don't do this and the
> guest will not be prepared to handle -EBUSY.

You are right. It should yield until drain, then proceed. A zoned
null_blk does this.

>
> > +
> > +        qemu_co_mutex_lock(&s->lock);
> > +        BlockZoneState zs =3D qcow2_get_zone_state(bs, index + i);
> > +        switch (zs) {
> > +        case BLK_ZS_EMPTY:
> > +            break;
> > +        case BLK_ZS_IOPEN:
> > +            qcow2_rm_imp_open_zone(s, index + i);
> > +            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_o=
pen);
> > +            break;
> > +        case BLK_ZS_EOPEN:
> > +            qcow2_rm_exp_open_zone(s, index + i);
> > +            break;
> > +        case BLK_ZS_CLOSED:
> > +            qcow2_rm_closed_zone(s, index + i);
> > +            break;
> > +        case BLK_ZS_FULL:
> > +            break;
> > +        default:
> > +            ret =3D -EINVAL;
> > +            qemu_co_mutex_unlock(&s->lock);
> > +            goto unlock;
> > +        }
> > +        qemu_co_mutex_unlock(&s->lock);
> > +
> > +        if (zs =3D=3D BLK_ZS_EMPTY) {
> > +            continue;
> > +        }
> > +
> > +        /*
> > +         * Zero the data extent first. Date write fires before the WP =
cluster
>
> Date -> Data
>
> > +         * hits disk. So the wp advance cannot become durable while st=
ale data
> > +         * is still readable.
> > +         */
> > +        ret =3D qcow2_co_pwrite_zeroes(bs, (uint64_t)(index + i) * zon=
e_size,
> > +                                     zone_size, 0);
> > +        if (ret < 0) {
> > +            error_report("Failed to clear zone data at zone %u",
> > +                         index + i);
> > +            goto unlock;
> > +        }
> > +
> > +        qemu_co_mutex_lock(&s->lock);
> > +        qcow2_cache_depends_on_flush(s->wp_cache);
> > +        qemu_co_mutex_unlock(&s->lock);
> > +
> > +        *wp_i =3D (uint64_t)(index + i) * zone_size;
> > +        ret =3D qcow2_rw_wp_at(bs, wp_i, index + i, true);
> > +        if (ret < 0) {
> > +            goto unlock;
>
> *wp_i has been modified but the operation will fail. The write pointers
> in memory and the write pointers in the qcow2 cache and on disk are now
> inconsistent. I expect the failure semantics to be that the write
> pointers in memory are consistent with the on-disk write pointers,
> although I haven't checked specs to see if they say anything about this.

Right, on wp-write failure, the in-memory wp needs to be stored so RAM
stays consistent with disk.

>
> > +        }
> > +        any_dirtied =3D true;
> > +    }
> > +
> > +    if (any_dirtied) {
> > +        /* Single flush at the end. */
> > +        qemu_co_mutex_lock(&s->lock);
> > +        ret =3D qcow2_cache_flush(bs, s->wp_cache);
> > +        qemu_co_mutex_unlock(&s->lock);
> > +    }
> > +
> > +unlock:
> > +    qemu_co_mutex_unlock(&bs->wps->colock);
> > +    return ret;
> > +}
> > +
> > +static int coroutine_fn GRAPH_RDLOCK
> > +qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
> > +                                           int64_t offset, int64_t len=
)
>
> Indentation is off here.
>
> > +{
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    int ret =3D 0;
> > +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> > +    int64_t zone_size =3D s->zoned_header.zone_size;
> > +    int64_t zone_size_mask =3D zone_size - 1;
> > +    uint32_t index =3D offset / zone_size;
>
> It would be safer to check that this qcow2 image supports zone emulation
> before getting deeper into this function. zone_size could be 0 here if
> zone emulation is not enabled and it would cause a divide-by-zero
> exception.
>
> All block driver zone callbacks in qcow2 should perform this check just
> in case an emulated device exposes a code path where the guest can
> perform a zoned operation on a non-zoned BlockDriverState.
> Alternatively, you could add a generic check in bdrv_co_zone_mgmt() and
> similar functions.

I'll add this check to bdrv_co_zone_mgmt() to prevent the leak.

>
> > +    BlockZoneWps *wps =3D bs->wps;
> > +
> > +    if (offset >=3D capacity) {
> > +        error_report("offset %" PRId64 " is equal to or greater than t=
he"
> > +                     "device capacity %" PRId64 "", offset, capacity);
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (offset & zone_size_mask) {
> > +        error_report("sector offset %" PRId64 " is not aligned to zone=
 size"
> > +                     " %" PRId64 "", offset / 512, zone_size / 512);
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (((offset + len) < capacity && len & zone_size_mask) ||
>
> Here is how the capacity check is expressed without an integer overflow
> in block/block-backend.c:blk_check_byte_request():
>
>   if (offset > len || len - offset < bytes) {
>                       ^^^^^^^^^^^^^^^^^^^^
>       return -EIO;
>   }
>
> It would be preferrable to use that form to avoid integer overflow.

Nice approach!

>
> > +        offset + len > capacity) {
> > +        error_report("number of sectors %" PRId64 " is not aligned to =
zone"
> > +                     " size %" PRId64 "", len / 512, zone_size / 512);
> > +        return -EINVAL;
> > +    }
> > +
> > +    qemu_co_mutex_lock(&wps->colock);
> > +    uint64_t wpv =3D wps->wp[index];
> > +    qemu_co_mutex_unlock(&wps->colock);
> > +
> > +    if (QCOW2_ZT_IS_CONV(wpv)) {
> > +        /*
> > +         * ZONE_RESET_ALL is a global operation that is allowed when t=
he
> > +         * starting zone is conventional; the zone reset path itself s=
kips
> > +         * conventional zones.
> > +         */
> > +        if (op !=3D BLK_ZO_RESET || len !=3D capacity) {
> > +            error_report("zone mgmt operation 0x%x is not allowed on "
> > +                         "a conventional zone", op);
> > +            return -EIO;
> > +        }
> > +    }
> > +
> > +    switch (op) {
> > +    case BLK_ZO_OPEN:
> > +        ret =3D qcow2_open_zone(bs, index);
> > +        break;
> > +    case BLK_ZO_CLOSE:
> > +        ret =3D qcow2_close_zone(bs, index);
> > +        break;
> > +    case BLK_ZO_FINISH:
> > +        ret =3D qcow2_finish_zone(bs, index);
> > +        break;
> > +    case BLK_ZO_RESET:
> > +        ret =3D qcow2_reset_zone(bs, index, len);
> > +        break;
> > +    default:
> > +        error_report("Unsupported zone op: 0x%x", op);
> > +        ret =3D -ENOTSUP;
> > +        break;
> > +    }
> > +    return ret;
> > +}
> > +
> > +static int coroutine_fn GRAPH_RDLOCK
> > +qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVect=
or *qiov,
> > +                     BdrvRequestFlags flags)
> > +{
> > +    assert(flags =3D=3D 0);
> > +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> > +    int64_t zone_size_mask =3D bs->bl.zone_size - 1;
> > +    int64_t iov_len =3D 0;
> > +    int64_t len =3D 0;
> > +
> > +    if (*offset >=3D capacity) {
> > +        error_report("*offset %" PRId64 " is equal to or greater than =
the"
> > +                     "device capacity %" PRId64 "", *offset, capacity)=
;
> > +        return -EINVAL;
>
> I'm not sure whether this should be -ENOSPC or -EINVAL. Did you look
> into what is most appropriate? pwrite(2) on Linux returns ENOSPC when
> writing beyond the end of the block device.
>
> This also applies to other places in this patch that check if offset >=3D
> capacity.

Ah, it should be -ENOSPC. That's also what a zoned null_blk device
returns when writing at/beyond device capacity.

>
> > +    }
> > +
> > +    /* offset + len should not pass the end of that zone starting from=
 offset */
> > +    if (*offset & zone_size_mask) {
>
> The comment doesn't match the check that is performed here.

Will fix it.

Thanks for reviewing!

Sam

