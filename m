Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E582C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Pf-00026U-LI; Tue, 07 Jul 2026 10:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wh6Pd-00025i-7l; Tue, 07 Jul 2026 10:04:37 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wh6PZ-0001VD-W4; Tue, 07 Jul 2026 10:04:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 33585C0A01;
 Tue, 07 Jul 2026 17:04:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a91::1:28] (unknown
 [2a02:6bf:8080:a91::1:28])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Q4JKPF0f3uQ0-LWYAxE6I; Tue, 07 Jul 2026 17:04:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783433066;
 bh=M6SEakVKz8L466o4qaCKdXfwDep7F+SO8pk1wAw4eQM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=khujGKONGm7cIHZEYU6S7xbD7qQ4tKDxwZq3tlVe0GnmhrGPYqqCJbyaJrPzoiH7N
 IUs6b2MPvL2CHtP6aWh4D2syrb1GPs+OR+d8xM0/FiqkPQgYLMAQtcfQxOmKZGKh+v
 xRs5foU56dmrzdwgW2MXLQ73k/4XnVsFiqmKMo8M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4dda6b28-d4e1-48c4-98f4-b574746fdc71@yandex-team.ru>
Date: Tue, 7 Jul 2026 17:04:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block/monitor: force read-only on live-added
 persistent bitmap
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
References: <20260706161645.515304-1-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260706161645.515304-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 06.07.26 19:16, Denis V. Lunev wrote:
> qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
> checking write access to its node. bdrv_create_dirty_bitmap() always
> creates bitmaps writable, so a persistent bitmap added live to an
> already read-only node stays writable in memory on a node that can
> never store it. The next global inactivation (migration completion,
> save, or any other bdrv_inactivate_all() caller) then fails trying to
> flush it back:
> 
>    Lost persistent bitmaps during inactivation of node '<node>': No write access
>    migration_block_inactivate: bdrv_inactivate_all() failed: -22
> 
> qcow2_load_dirty_bitmaps()


Hm, but qcow2_load_dirty_bitmaps() and qmp_block_dirty_bitmap_add() are different:

In qcow2_load_dirty_bitmaps(), we load bitmap from the image, so we are sure,
that the bitmap is already stored. And if image is readonly, we mark bitmap
readonly as well. So, on exit, we assume, that bitmap is already stored,
and don't produce "Lost bitmaps" error.

In qmp_block_dirty_bitmap_add(), we create a new bitmap, that not yet stored.
So, even if we don't modify it, the error "Lost bitmap" would be correct on
exit, as bitmap is not stored at all.

---

Also, this patch breaks the scenario of create and than merge some bitmap
into created one. That's a breaking change, and would need a deprecation
period.

---

Still. Maybe better be more strict, and simply forbid creating persistent
bitmaps in read-only images at all? (this will need a deprecation period
anyway).

What is your scenario?


> and qcow2_reopen_bitmaps_ro() already force
> a persistent bitmap read-only when its node is read-only; do the same
> right after the bitmap is marked persistent, whether it arrived
> through a plain block-dirty-bitmap-add or the transaction action that
> calls the same function. qcow2_reopen_bitmaps_rw() already promotes
> any persistent, read-only bitmap back to writable once its node is
> reopened read-write, so the reverse direction needs no changes.
> 
> Also check BDRV_O_INACTIVE, matching qcow2's private can_write()
> helper, to cover adding a bitmap to a node that is already inactive.
> Document the new behavior on BlockDirtyBitmapAdd.persistent.
> 
> Extend remove-bitmap-from-backing to cover this: add a persistent
> bitmap live to the already read-only "base" node, then inactivate all
> nodes the way migration completion, virsh save and qemu-update do, and
> check the bitmap ends up as protected as one already on disk.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> ---
>   block/monitor/bitmap-qmp-cmds.c                  |  9 +++++++++
>   qapi/block-core.json                             |  4 +++-
>   .../tests/remove-bitmap-from-backing             | 16 ++++++++++++++++
>   .../tests/remove-bitmap-from-backing.out         | 11 +++++++++++
>   4 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
> index a738e7bbf7..1f2c0c9cbc 100644
> --- a/block/monitor/bitmap-qmp-cmds.c
> +++ b/block/monitor/bitmap-qmp-cmds.c
> @@ -141,6 +141,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>       }
>   
>       bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
> +
> +    /*
> +     * A persistent bitmap on a node that can't be written must not be
> +     * writable either, same as one loaded from or reopened onto it.
> +     */
> +    if (persistent &&
> +        (bdrv_is_read_only(bs) || (bdrv_get_flags(bs) & BDRV_O_INACTIVE))) {
> +        bdrv_dirty_bitmap_set_readonly(bitmap, true);
> +    }
>   }
>   
>   BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1f87b07850..a52397922b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2353,7 +2353,9 @@
>   # @persistent: the bitmap is persistent, i.e. it will be saved to the
>   #     corresponding block device image file on its close.  For now
>   #     only Qcow2 disks support persistent bitmaps.  Default is false
> -#     for `block-dirty-bitmap-add`.  (Since: 2.10)
> +#     for `block-dirty-bitmap-add`.  If the node is read-only, the
> +#     bitmap is created read-only instead, the same as a persistent
> +#     bitmap already stored on such a node.  (Since: 2.10)
>   #
>   # @disabled: the bitmap is created in the disabled state, which means
>   #     that it will not track drive changes.  The bitmap may be enabled
> diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing b/tests/qemu-iotests/tests/remove-bitmap-from-backing
> index 15be32dcb9..61e1f3f10f 100755
> --- a/tests/qemu-iotests/tests/remove-bitmap-from-backing
> +++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing
> @@ -66,6 +66,22 @@ result = vm.qmp('blockdev-reopen', **new_base_opts)
>   if result != {'return': {}}:
>       log('Failed to reopen: ' + str(result))
>   
> +# A bitmap added live (not loaded from disk) must be protected the same
> +# way as bitmap0 above once its node is read-only.
> +log('Adding a persistent bitmap live to the r-o base node:')
> +vm.qmp_log('block-dirty-bitmap-add', node='base', name='bitmap1',
> +          persistent=True)
> +
> +# Inactivate globally, like migration completion/save/qemu-update do;
> +# inactivating "base" directly would hit an unrelated guard, since it is
> +# a backing child of the still-active "top".
> +log('Inactivating all nodes must not fail flushing bitmap1:')
> +vm.qmp_log('blockdev-set-active', active=False)
> +vm.qmp_log('blockdev-set-active', active=True)
> +
> +log('Trying to remove the live-added bitmap, should fail same as bitmap0:')
> +vm.qmp_log('block-dirty-bitmap-remove', node='base', name='bitmap1')
> +
>   vm.shutdown()
>   
>   if 'bitmaps' in qemu_img_info(base)['format-specific']['data']:
> diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
> index c28af82c75..ea492d167f 100644
> --- a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
> +++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
> @@ -4,3 +4,14 @@ Trying to remove persistent bitmap from r-o base node, should fail:
>   Remove persistent bitmap from base node reopened to RW:
>   {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
>   {"return": {}}
> +Adding a persistent bitmap live to the r-o base node:
> +{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap1", "node": "base", "persistent": true}}
> +{"return": {}}
> +Inactivating all nodes must not fail flushing bitmap1:
> +{"execute": "blockdev-set-active", "arguments": {"active": false}}
> +{"return": {}}
> +{"execute": "blockdev-set-active", "arguments": {"active": true}}
> +{"return": {}}
> +Trying to remove the live-added bitmap, should fail same as bitmap0:
> +{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap1", "node": "base"}}
> +{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap1' is readonly and cannot be modified"}}


-- 
Best regards,
Vladimir

