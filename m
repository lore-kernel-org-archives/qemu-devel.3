Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF2C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 16:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVgu-0001NG-Rl; Mon, 12 May 2025 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEVgj-0001LD-3p; Mon, 12 May 2025 12:07:35 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEVgb-0002GC-Gc; Mon, 12 May 2025 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747066030; bh=nqNm99JPiaM7yC2YO4Ww21WrA70G895YjBAhNh2GbZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DYNbGipDxW4Hf3GJEYSfXQCxgg6+bOS7r683MY2D5KTuMOyPB7Cg39xiugGE113C8
 3nRLfSRvoevrl7EiMqtwFZzVfNghn2CLzct5IHyXpLlFDUimSLKIOxzW3z8BIRRg6a
 trfJpyHdbdla+eDuHes2nfriEUx5ylIp1vqDp2JM=
Received: from localhost.localdomain ([117.147.34.74])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 39A4E0F; Tue, 13 May 2025 00:00:57 +0800
X-QQ-mid: xmsmtpt1747065657tjogufvjp
Message-ID: <tencent_A7998CB3DFA6461A093A09394FD2FD417506@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIs9vLtnpk7smKL8EWzsdy31PVS9J6zTWfd26iV+bN50V5UJ4r4V1
 PDW3ZCiLLkh+vtDeuYbZouAfdSPgzifSBH5ukbaNr2sthIGNTsvYhgRKUIGzfu/v4XpFarq56ljW
 ckbASACv1PDr9Ju6E50Bm6/O1el7eF9JTr422lW8JZeuRf4o8mTr9MxevvltRD2s78JQ9fB9Wtxj
 w2RxHcGMK0AYi6HrVudA/WziVPyBVX0AAVSR7e/UrZc8mxDs+C6HLN8nqPxS3KxpU8LkGZ2gBhAJ
 F0o4Eg+aNAfoHoebbWSy74EyUNWVS7xPYlOLRPAshzyq37IJE9BLeE7/R4PHe8SwTe5Z3obg49g6
 IFLJgsVMhW/M/bW69PkMgxv2dcRj193yeETPyATWNURdBUDlLIV2jz1EFVUgpor4F5AVLIfvJ2Nl
 PEfOhxYagvQSxjcuAd00WX3jtupODG98qGECCZmjTEqrl4sQ+3krZk7xXRfSAprMDQMqGVQqdUdy
 nQ78kXlFQFvJJ8d8R/uodPy9BuhoAUHvRt95lPvs2Rem/ikaWZkH0TOi88404k2IyyhKvQw93sIh
 2Agg5xg6mlGLj5PS1feakIztudqeFGji2IxqR3Ol+NgTKap9Q6lrmqENetvMZ5XBECRvFTL0MKQn
 zRKi9B2STWPA9Z5tb70ylz48KQJsOkdNBdYHB7qBR/os09vcm8sTxk5HdWwF9Uv3gbZYo/iObnxT
 agGcEJbEaRJg0Jmh4ThDMOkv9Q7oq/Yf1znLlC4BeSMa4o+r6Vf5gaFDyoSEbdMujABalh7/1PSD
 AOD5MO4wcDmdSa5ndXC09LONs3xBs4I27KLHw2eTehuAXpy6nGDyIFY3P6RSzJ3HE7h1u+5mlbip
 QfHS+/1wY5ziTin8jRxaZJaV6eLW5FC0ex+gAUh/4VgxiYfBf6tcnwOLFCZeaSSbvf8J3BDNiud7
 3E7H7HDisbxYHZjFSBlkZw7TMURRglg90YPM8UIftl1oXqu+4y+3o01ZcfHxTqYjxd/o1m/Mcmj6
 Kx6nrS80NamQSLFKqw
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: armbru@redhat.com, hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 08/13] mirror: Allow QMP override to declare target
 already zero
Date: Sat,  3 May 2025 07:57:24 +0800
X-OQ-MSGID: <20250502235724.47186-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509204341.3553601-23-eblake@redhat.com>
References: <20250509204341.3553601-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.53; envelope-from=sunnyzhyy@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 09, 2025 at 03:40:25PM -0500, Eric Blake wrote:
> QEMU has an optimization for a just-created drive-mirror destination
> that is not possible for blockdev-mirror (which can't create the
> destination) - any time we know the destination starts life as all
> zeroes, we can skip a pre-zeroing pass on the destination.  Recent
> patches have added an improved heuristic for detecting if a file
> contains all zeroes, and we plan to use that heuristic in upcoming
> patches.  But since a heuristic cannot quickly detect all scenarios,
> and there may be cases where the caller is aware of information that
> QEMU cannot learn quickly, it makes sense to have a way to tell QEMU
> to assume facts about the destination that can make the mirror
> operation faster.  Given our existing example of "qemu-img convert
> --target-is-zero", it is time to expose this override in QMP for
> blockdev-mirror as well.
> 
> This patch results in some slight redundancy between the older
> s->zero_target (set any time mode==FULL and the destination image was
> not just created - ie. clear if drive-mirror is asking to skip the
> pre-zero pass) and the newly-introduced s->target_is_zero (in addition
> to the QMP override, it is set when drive-mirror creates the
> destination image); this will be cleaned up in the next patch.
> 
> There is also a subtlety that we must consider.  When drive-mirror is
> passing target_is_zero on behalf of a just-created image, we know the
> image is sparse (skipping the pre-zeroing keeps it that way), so it
> doesn't matter whether the destination also has "discard":"unmap" and
> "detect-zeroes":"unmap".  But now that we are letting the user set the
> knob for target-is-zero, if the user passes a pre-existing file that
> is fully allocated, it is fine to leave the file fully allocated under
> "detect-zeroes":"on", but if the file is open with
> "detect-zeroes":"unmap", we should really be trying harder to punch
> holes in the destination for every region of zeroes copied from the
> source.  The easiest way to do this is to still run the pre-zeroing
> pass (turning the entire destination file sparse before populating
> just the allocated portions of the source), even though that currently
> results in double I/O to the portions of the file that are allocated.
> A later patch will add further optimizations to reduce redundant
> zeroing I/O during the mirror operation.
> 
> Since "target-is-zero":true is designed for optimizations, it is okay
> to silently ignore the parameter rather than erroring if the user ever
> sets the parameter in a scenario where the mirror job can't exploit it
> (for example, when doing "sync":"top" instead of "sync":"full", we
> can't pre-zero, so setting the parameter won't make a speed
> difference).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> ---
> 
> v4: hoist earlier in series. QMP design is unchanged, but logic in
> mirror_dirty_init is different (in many aspects simpler, but now
> catering to "detect-zeroes":"unmap") so Acked-by on QMP kept, but
> Reviewed-by dropped.
> ---
>  qapi/block-core.json                   |  8 +++++++-
>  include/block/block_int-global-state.h |  3 ++-
>  block/mirror.c                         | 27 ++++++++++++++++++++++----
>  blockdev.c                             | 18 ++++++++++-------
>  tests/unit/test-block-iothread.c       |  2 +-
>  5 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e19..7f70ec6d3cb 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2538,6 +2538,11 @@
>  #     disappear from the query list without user intervention.
>  #     Defaults to true.  (Since 3.1)
>  #
> +# @target-is-zero: Assume the destination reads as all zeroes before
> +#     the mirror started.  Setting this to true can speed up the
> +#     mirror.  Setting this to true when the destination is not
> +#     actually all zero can corrupt the destination.  (Since 10.1)

It appears feasible to add target-is-zero to the drive-mirror qmp as well,
provided this is done under the NEW_IMAGE_MODE_EXISTING scenario. This would
allow users to pass target-is-zero for optimizations whether using blockdev-mirror
or drive-mirror when they have pre-prepared destination image.

> +#
>  # Since: 2.6
>  #
>  # .. qmp-example::
> @@ -2557,7 +2562,8 @@
>              '*on-target-error': 'BlockdevOnError',
>              '*filter-node-name': 'str',
>              '*copy-mode': 'MirrorCopyMode',
> -            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
> +            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
> +            '*target-is-zero': 'bool'},
>    'allow-preconfig': true }
> 
>  ##
> diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
> index eb2d92a2261..8cf0003ce78 100644
> --- a/include/block/block_int-global-state.h
> +++ b/include/block/block_int-global-state.h
> @@ -140,6 +140,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>   * @mode: Whether to collapse all images in the chain to the target.
>   * @backing_mode: How to establish the target's backing chain after completion.
>   * @zero_target: Whether the target should be explicitly zero-initialized
> + * @target_is_zero: Whether the target already is zero-initialized.
>   * @on_source_error: The action to take upon error reading from the source.
>   * @on_target_error: The action to take upon error writing to the target.
>   * @unmap: Whether to unmap target where source sectors only contain zeroes.
> @@ -159,7 +160,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>                    int creation_flags, int64_t speed,
>                    uint32_t granularity, int64_t buf_size,
>                    MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
> -                  bool zero_target,
> +                  bool zero_target, bool target_is_zero,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
>                    bool unmap, const char *filter_node_name,
> diff --git a/block/mirror.c b/block/mirror.c
> index 2599b75d092..4dcb50c81ad 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -55,6 +55,8 @@ typedef struct MirrorBlockJob {
>      BlockMirrorBackingMode backing_mode;
>      /* Whether the target image requires explicit zero-initialization */
>      bool zero_target;
> +    /* Whether the target should be assumed to be already zero initialized */
> +    bool target_is_zero;
>      /*
>       * To be accesssed with atomics. Written only under the BQL (required by the
>       * current implementation of mirror_change()).
> @@ -844,12 +846,26 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      BlockDriverState *target_bs = blk_bs(s->target);
>      int ret = -EIO;
>      int64_t count;
> +    bool punch_holes =
> +        target_bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
> +        bdrv_can_write_zeroes_with_unmap(target_bs);
> 
>      bdrv_graph_co_rdlock();
>      bs = s->mirror_top_bs->backing->bs;
>      bdrv_graph_co_rdunlock();
> 
> -    if (s->zero_target) {
> +    if (s->zero_target && (!s->target_is_zero || punch_holes)) {
> +        /*
> +         * Here, we are in FULL mode; our goal is to avoid writing
> +         * zeroes if the destination already reads as zero, except
> +         * when we are trying to punch holes.  This is possible if
> +         * zeroing happened externally (s->target_is_zero) or if we
> +         * have a fast way to pre-zero the image (the dirty bitmap
> +         * will be populated later by the non-zero portions, the same
> +         * as for TOP mode).  If pre-zeroing is not fast, or we need
> +         * to punch holes, then our only recourse is to write the
> +         * entire image.
> +         */
>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
>              return 0;
> @@ -1714,7 +1730,7 @@ static BlockJob *mirror_start_job(
>                               uint32_t granularity, int64_t buf_size,
>                               MirrorSyncMode sync_mode,
>                               BlockMirrorBackingMode backing_mode,
> -                             bool zero_target,
> +                             bool zero_target, bool target_is_zero,
>                               BlockdevOnError on_source_error,
>                               BlockdevOnError on_target_error,
>                               bool unmap,
> @@ -1883,6 +1899,7 @@ static BlockJob *mirror_start_job(
>      s->sync_mode = sync_mode;
>      s->backing_mode = backing_mode;
>      s->zero_target = zero_target;
> +    s->target_is_zero = target_is_zero;
>      qatomic_set(&s->copy_mode, copy_mode);
>      s->base = base;
>      s->base_overlay = bdrv_find_overlay(bs, base);
> @@ -2011,7 +2028,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>                    int creation_flags, int64_t speed,
>                    uint32_t granularity, int64_t buf_size,
>                    MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
> -                  bool zero_target,
> +                  bool zero_target, bool target_is_zero,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
>                    bool unmap, const char *filter_node_name,
> @@ -2034,7 +2051,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
> 
>      mirror_start_job(job_id, bs, creation_flags, target, replaces,
>                       speed, granularity, buf_size, mode, backing_mode,
> -                     zero_target, on_source_error, on_target_error, unmap,
> +                     zero_target,
> +                     target_is_zero, on_source_error, on_target_error, unmap,
>                       NULL, NULL, &mirror_job_driver, base, false,
>                       filter_node_name, true, copy_mode, false, errp);
>  }
> @@ -2062,6 +2080,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>      job = mirror_start_job(
>                       job_id, bs, creation_flags, base, NULL, speed, 0, 0,
>                       MIRROR_SYNC_MODE_TOP, MIRROR_LEAVE_BACKING_CHAIN, false,
> +                     false,
>                       on_error, on_error, true, cb, opaque,
>                       &commit_active_job_driver, base, auto_complete,
>                       filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
> diff --git a/blockdev.c b/blockdev.c
> index 1d1f27cfff6..2e2fed539ee 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2798,7 +2798,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>                                     const char *replaces,
>                                     enum MirrorSyncMode sync,
>                                     BlockMirrorBackingMode backing_mode,
> -                                   bool zero_target,
> +                                   bool zero_target, bool target_is_zero,
>                                     bool has_speed, int64_t speed,
>                                     bool has_granularity, uint32_t granularity,
>                                     bool has_buf_size, int64_t buf_size,
> @@ -2909,11 +2909,10 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>      /* pass the node name to replace to mirror start since it's loose coupling
>       * and will allow to check whether the node still exist at mirror completion
>       */
> -    mirror_start(job_id, bs, target,
> -                 replaces, job_flags,
> +    mirror_start(job_id, bs, target, replaces, job_flags,
>                   speed, granularity, buf_size, sync, backing_mode, zero_target,
> -                 on_source_error, on_target_error, unmap, filter_node_name,
> -                 copy_mode, errp);
> +                 target_is_zero, on_source_error, on_target_error, unmap,
> +                 filter_node_name, copy_mode, errp);
>  }
> 
>  void qmp_drive_mirror(DriveMirror *arg, Error **errp)
> @@ -2928,6 +2927,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      int64_t size;
>      const char *format = arg->format;
>      bool zero_target;
> +    bool target_is_zero;
>      int ret;
> 
>      bs = qmp_get_root_bs(arg->device, errp);
> @@ -3044,6 +3044,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
>                     (arg->mode == NEW_IMAGE_MODE_EXISTING ||
>                      !bdrv_has_zero_init(target_bs)));
> +    target_is_zero = (arg->mode != NEW_IMAGE_MODE_EXISTING &&
> +                      bdrv_has_zero_init(target_bs));

Similarly, if the qmp_drive_mirror supports the target-is-zero parameter, we would then 
be able to determine whether the destination image is fully zero-initialized when 
arg->mode is NEW_IMAGE_MODE_EXISTING.

>      bdrv_graph_rdunlock_main_loop();
> 
> 
> @@ -3055,7 +3057,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
> 

thanks.


