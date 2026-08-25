Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6868FC61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyngy-000756-Iq; Tue, 25 Aug 2026 05:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wyngw-00074b-P5; Tue, 25 Aug 2026 05:43:38 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wyngu-0003ct-En; Tue, 25 Aug 2026 05:43:38 -0400
Received: from [IPV6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1] (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 988371520EDA;
 Tue, 25 Aug 2026 11:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1787651011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1kKicoEDtPxEP5aF4hQZk1MSMkaEN3fLXrGFoYkLR4=;
 b=Y46dHmW3mgx4KVTxzMUK/5zNFbDJUScNmdGXz7QkbmL7mYqxRpYv8JAu2wVHQyV3pPX8Oi
 pRiMG4qqWXgVzG3UaqYN3Ecp/0ZvBBlBCPkZh/znZgdNnnQGrWmP8DdetgQjCbp+YyQ/1f
 8cZA2dmpuBlQWXLEzEb5Nh04vBVbu/+RiX5R2zMlriaQHvjF0Yb+4D/VH35clVShovoiia
 /7fmy+Q0M/aaTvSMOXeukR4xYXRy/T1rtxT7ur0WfUffB0xPl471+TkAwIRG9c1W0+RmFW
 uLZKhH7R0ScKS4q71WAYxGHMCJQiU66SnMClWUmwnK0TAdvDHCcYlTh8owwL8w==
Message-ID: <34805728-b3a6-4efb-a52d-ca444c9e816a@dupond.be>
Date: Tue, 25 Aug 2026 11:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] qcow2: add functionality to repair bitmaps
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260713081304.84812-1-jean-louis@dupond.be>
 <20260713081304.84812-2-jean-louis@dupond.be>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20260713081304.84812-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Ping for the v6 version of the patch.

Every previous comment was addressed.

Thanks
Jean-Louis

On 13/07/2026 10:13, Jean-Louis Dupond wrote:
> In some cases, it might happen that bitmaps become corrupt.
> For example when adding/removing bitmaps on a live image.
>
> Of course this should not happen, but in case this happens, the image is
> corrupt and even cannot be opened anymore. You'll get something like the
> following:
> qemu-img: Could not open 'disk.qcow2': Bitmap '' doesn't satisfy the constraints
>
> So the image becomes useless, and cannot be repaired. This while in fact
> only (one) bitmap entry is corrupt, and the rest of the data is just
> intact.
>
> This commit adds a way to fix this corruption, by just replacing the
> bitmap list in the qcow2 image with the valid bitmaps, and dropping the
> bitmaps that are corrupt.
>
> $ qemu-img check disk.qcow2
> qemu-img: Check failed: Invalid argument
> qemu-img: Lost persistent bitmaps during inactivation of node '#block147': Bitmap '' doesn't satisfy the constraints
>
> $ qemu-img check -r all disk.qcow2
> qcow2_free_clusters failed: Invalid argument
> Leaked cluster 3 refcount=1 reference=0
> Leaked cluster 26 refcount=1 reference=0
> ERROR cluster 983214 refcount=0 reference=1
> Rebuilding refcount structure
> Repairing cluster 1 refcount=1 reference=0
> Repairing cluster 2 refcount=1 reference=0
> Repairing cluster 32768 refcount=1 reference=0
> ....
> Repairing cluster 983214 refcount=1 reference=0
> The following inconsistencies were found and repaired:
>
>      2 leaked clusters
>      3 corruptions
>
> Double checking the fixed image now...
> No errors were found on the image.
> 983056/1048576 = 93.75% allocated, 0.05% fragmented, 0.00% compressed clusters
> Image end offset: 64437878784
>
> And the image is valid again!
> Worst case you lose all bitmaps, but at least the image and the data
> itself is useable again.
>
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-bitmap.c   | 42 +++++++++++++++++++++++++++++++++++++++---
>   block/qcow2-refcount.c |  3 ++-
>   block/qcow2.c          | 16 ++++++++++++----
>   block/qcow2.h          |  3 ++-
>   4 files changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 256ec99878..91bd82a9f5 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -100,6 +100,9 @@ typedef enum BitmapType {
>       BT_DIRTY_TRACKING_BITMAP = 1
>   } BitmapType;
>   
> +static int GRAPH_RDLOCK
> +update_ext_header_and_dir(BlockDriverState *bs, Qcow2BitmapList *bm_list);
> +
>   static inline bool can_write(BlockDriverState *bs)
>   {
>       return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
> @@ -655,12 +658,14 @@ fail:
>   int coroutine_fn
>   qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                 void **refcount_table,
> -                              int64_t *refcount_table_size)
> +                              int64_t *refcount_table_size,
> +                              BdrvCheckMode fix)
>   {
>       int ret;
>       BDRVQcow2State *s = bs->opaque;
>       Qcow2BitmapList *bm_list;
> -    Qcow2Bitmap *bm;
> +    Qcow2Bitmap *bm, *bm_next;
> +    bool bitmap_modified = false;
>   
>       if (s->nb_bitmaps == 0) {
>           return 0;
> @@ -677,12 +682,21 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                  s->bitmap_directory_size, NULL);
>       if (bm_list == NULL) {
>           res->corruptions++;
> +
> +        if (fix & BDRV_FIX_ERRORS) {
> +            ret = update_ext_header_and_dir(bs, NULL);
> +            if (ret >= 0) {
> +                res->corruptions_fixed++;
> +            }
> +            goto out;
> +        }
>           return -EINVAL;
>       }
>   
> -    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +    QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, bm_next) {
>           uint64_t *bitmap_table = NULL;
>           int i;
> +        bool bitmap_valid = true;
>   
>           ret = qcow2_inc_refcounts_imrt(bs, res,
>                                          refcount_table, refcount_table_size,
> @@ -695,6 +709,12 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>           ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
>           if (ret < 0) {
>               res->corruptions++;
> +            if (fix & BDRV_FIX_ERRORS) {
> +                QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> +                bitmap_free(bm);
> +                bitmap_modified = true;
> +                continue;
> +            }
>               goto out;
>           }
>   
> @@ -704,6 +724,7 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>   
>               if (check_table_entry(entry, s->cluster_size) < 0) {
>                   res->corruptions++;
> +                bitmap_valid = false;
>                   continue;
>               }
>   
> @@ -720,9 +741,24 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>               }
>           }
>   
> +        if ((fix & BDRV_FIX_ERRORS) && !bitmap_valid) {
> +            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> +            bitmap_free(bm);
> +            bitmap_modified = true;
> +        }
> +
>           g_free(bitmap_table);
>       }
>   
> +    /* If fixing, update the bitmap directory with the repaired list */
> +    if ((fix & BDRV_FIX_ERRORS) && bitmap_modified) {
> +        uint32_t initial_bitmaps = s->nb_bitmaps;
> +        ret = update_ext_header_and_dir(bs, bm_list);
> +        if (ret >= 0) {
> +            res->corruptions_fixed += initial_bitmaps - s->nb_bitmaps;
> +        }
> +    }
> +
>   out:
>       bitmap_list_free(bm_list);
>   
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 6512cda407..df7f6d2f23 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2305,7 +2305,8 @@ calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>       }
>   
>       /* bitmaps */
> -    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table, nb_clusters);
> +    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table,
> +                                        nb_clusters, fix);
>       if (ret < 0) {
>           return ret;
>       }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 19271b10a4..d6aa1cd3a4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1927,11 +1927,19 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
>       if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>           /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
>           bool header_updated;
> -        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
> -            ret = -EINVAL;
> -            goto fail;
> +        Error *local_err = NULL;
> +        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, &local_err)) {
> +            /*
> +             * Allow this to fail in check mode
> +             * because otherwise we can't open the image at all.
> +             */
> +            if (!(flags & BDRV_O_CHECK)) {
> +                ret = -EINVAL;
> +                error_propagate(errp, local_err);
> +                goto fail;
> +            }
> +            error_free(local_err);
>           }
> -
>           update_header = update_header && !header_updated;
>       }
>   
> diff --git a/block/qcow2.h b/block/qcow2.h
> index ce517040c4..ba9fe68130 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -1038,7 +1038,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void *table);
>   int coroutine_fn GRAPH_RDLOCK
>   qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                 void **refcount_table,
> -                              int64_t *refcount_table_size);
> +                              int64_t *refcount_table_size,
> +                              BdrvCheckMode fix);
>   
>   bool coroutine_fn GRAPH_RDLOCK
>   qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,

