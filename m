Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B96C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7dHq-00031l-Jz; Wed, 23 Apr 2025 12:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u7dHm-0002yT-1D; Wed, 23 Apr 2025 12:49:22 -0400
Received: from out203-205-221-236.mail.qq.com ([203.205.221.236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u7dHh-0005TN-Bj; Wed, 23 Apr 2025 12:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1745426938; bh=CXhedZ0BjMBZjD5/kl8r5K85vI68/WhYZz4OTn3eSSs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dGZxSjsPfk8wcFBZJvvJtxXpzlBWa60diu3P+4WSzNJg3U7xexLzu60AtT7Lh7pnW
 b4KBvT60Sllt+G/MRJVGWdN3e/q80XrB7c2Y/uCm0598RU2S49q+pfiY0LdO+HNCmJ
 NE6q7xMsCJMIa65QnEoaaBfxYoFnEHMLuyiqZ4Nc=
Received: from 192.168.182.133 ([117.147.34.254])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id AAD85CE2; Thu, 24 Apr 2025 00:42:45 +0800
X-QQ-mid: xmsmtpt1745426565t3ahhi450
Message-ID: <tencent_85E0A24CC61971732FCD04DD85BC3689E205@qq.com>
X-QQ-XMAILINFO: OAope3s6+8Xpvxpyv8Jc31jgje9BkoOyIu0m723z862UXWpLew4s8HaOXdoFJZ
 tw4jObRl6bsrjHFO/vDMcQ/W7/OUubB/gaPFCjQX9sgMCqmucnmAotsl06Ezdoarp9/ficAfoAXY
 Uc/pMcXmyQLO/0B3u+vRW6piKx5ZxQ9epgoyP6aaOqH1UWAzn7Evimd3A4w4C9vLQsfeXxEv7Att
 kSJ5/FeodUjziwLMew1Vlkf761RxvV5x9nAyox7GTeKFnLbJezspn1K/JW4FRFKnri8HZhmRD7ae
 0Nxy9qjFMrb7DnupqgSXRweAJdMv+tm7AncS6TxyZtrdPG5dwV9byxlWFuEh6WXNVsdNXbkWrWJ9
 vAG5SRUvCsRqNZThb6huyi+9sVGQ6yuFbIE55G249VV/gr2TRsT1Zipr4itujDo25d2KQ2zBLsxQ
 RcxjJTjaxXShCe1ZcgGHjpQWMaBrlysta+shFWwWoQgGnsTO+mUMTQthNO2yeMRM8XSqxiD3Js6k
 y6fVT4SMG2nCf/Wq5rD+Zv0kw5CDTvPxcQKwPmNk/3uA2YDbburHYTv/WWdAJGTnwkGG9WKfR+cw
 RpY+SpZecS1LMcWUovCmNIcdiSQpJi3IcF1LH+6imlVTpSgYN1BxS8gr2kf8NCu6qsRSIBGuPpMi
 n6AQvdb9vsWhuuoZ9xnFxinWUR2JVIg0mmFMyhIChmhWPTSYNT9pN+DeXChKDeptZmFyqMB1/dd6
 92phKEIaY61E3oGtw4JpcDLcsTdXwe9UXGR5Z6xWUmYlZQ5a4ZPq4J9N43/7f6s1lz2rKjpX/m0t
 +xcxhGlR/IlWvauXEP1BfFZB908BJniUkT7feJRZX9G7flXbc6+iMVphvdXks6WIxPxWjnIeRj/G
 V2cl3u4VtshyteaqqctZrDLjWApir+Wei/Z0xhZ/H0tHHcmcyEDq9UW5uQ99xOZXln7ISrYolplu
 ie8ZWoex7ZK6RhW6PZf/elFxRKte9GfNHTYRUdQ9WjeKZianFbzQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 stefanha@redhat.com
Subject: Re: [PATCH v2 08/11] mirror: Skip writing zeroes when target is
 already zero
Date: Thu, 24 Apr 2025 00:42:45 +0800
X-OQ-MSGID: <20250423164245.44228-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417184133.105746-21-eblake@redhat.com>
References: <20250417184133.105746-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.236; envelope-from=sunnyzhyy@qq.com;
 helo=out203-205-221-236.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

on Thu, 17 Apr 2025 13:39:13 -0500, Eric Blake wrote:
> When mirroring, the goal is to ensure that the destination reads the
> same as the source; this goal is met whether the destination is sparse
> or fully-allocated.  However, if the destination cannot efficiently
> write zeroes, then any time the mirror operation wants to copy zeroes
> from the source to the destination (either during the background over
> sparse regions when doing a full mirror, or in the foreground when the
> guest actively writes zeroes), we were causing the destination to
> fully allocate that portion of the disk, even if it already read as
> zeroes.
> 
> The effect is especially pronounced when the source is a raw file.
> That's because when the source is a qcow2 file, the dirty bitmap only
> visits the portions of the source that are allocated, which tend to be
> non-zero.  But when the source is a raw file,
> bdrv_co_is_allocated_above() reports the entire file as allocated so
> mirror_dirty_init sets the entire dirty bitmap, and it is only later
> during mirror_iteration that we change to consulting the more precise
> bdrv_co_block_status_above() to learn where the source reads as zero.
> 
> Remember that since a mirror operation can write a cluster more than
> once (every time the guest changes the source, the destination is also
> changed to keep up), we can't take the shortcut of relying on
> s->zero_target (which is static for the life of the job) in
> mirror_co_zero() to see if the destination is already zero, because
> that information may be stale.  Any solution we use must be dynamic in
> the face of the guest writing or discarding a cluster while the mirror
> has been ongoing.
> 
> We could just teach mirror_co_zero() to do a block_status() probe of
> the destination, and skip the zeroes if the destination already reads
> as zero, but we know from past experience that extra block_status()
> calls are not always cheap (tmpfs, anyone?), especially when they are
> random access rather than linear.  Use of block_status() of the source
> by the background task in a linear fashion is not our bottleneck (it's
> a background task, after all); but since mirroring can be done while
> the source is actively being changed, we don't want a slow
> block_status() of the destination to occur on the hot path of the
> guest trying to do random-access writes to the source.
> 
> So this patch takes a slightly different approach: any time we have to
> transfer the full image, we know that mirror_dirty_init() is _already_
> doing a pre-zero pass over the entire destination.  Therefore, if we
> track which clusters of the destination are zero at any given moment,
> we don't have to do a block_status() call on the destination, but can
> instead just refer to the zero bitmap associated with the job.
> 
> With this patch, if I create a raw sparse destination file, connect it
> with QMP 'blockdev-add' while leaving it at the default "discard":
> "ignore", then run QMP 'blockdev-mirror' with "sync": "full", the
> destination remains sparse rather than fully allocated.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 234e3a55e60..4770d87abf6 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -73,6 +73,7 @@ typedef struct MirrorBlockJob {
>      size_t buf_size;
>      int64_t bdev_length;
>      unsigned long *cow_bitmap;
> +    unsigned long *zero_bitmap;
>      BdrvDirtyBitmap *dirty_bitmap;
>      BdrvDirtyBitmapIter *dbi;
>      uint8_t *buf;
> @@ -408,15 +409,33 @@ static void coroutine_fn mirror_co_read(void *opaque)
>  static void coroutine_fn mirror_co_zero(void *opaque)
>  {
>      MirrorOp *op = opaque;
> -    int ret;
> +    bool write_needed = true;
> +    int ret = 0;
> 
>      op->s->in_flight++;
>      op->s->bytes_in_flight += op->bytes;
>      *op->bytes_handled = op->bytes;
>      op->is_in_flight = true;
> 
> -    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
> -                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
> +    if (op->s->zero_bitmap) {
> +        unsigned long end = DIV_ROUND_UP(op->offset + op->bytes,
> +                                         op->s->granularity);
> +        assert(QEMU_IS_ALIGNED(op->offset, op->s->granularity));
> +        assert(QEMU_IS_ALIGNED(op->bytes, op->s->granularity) ||
> +               op->offset + op->bytes == op->s->bdev_length);
> +        if (find_next_zero_bit(op->s->zero_bitmap, end,
> +                               op->offset / op->s->granularity) == end) {
> +            write_needed = false;
> +        }
> +    }
> +    if (write_needed) {
> +        ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
> +                                   op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
> +    }
> +    if (ret >= 0 && op->s->zero_bitmap) {
> +        bitmap_set(op->s->zero_bitmap, op->offset / op->s->granularity,
> +                   DIV_ROUND_UP(op->bytes, op->s->granularity));
> +    }
>      mirror_write_complete(op, ret);
>  }
> 
> @@ -441,6 +460,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
>      Coroutine *co;
>      int64_t bytes_handled = -1;
> 
> +    assert(QEMU_IS_ALIGNED(offset, s->granularity));
> +    assert(QEMU_IS_ALIGNED(bytes, s->granularity) ||
> +           offset + bytes == s->bdev_length);
>      op = g_new(MirrorOp, 1);
>      *op = (MirrorOp){
>          .s              = s,
> @@ -452,12 +474,21 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
> 
>      switch (mirror_method) {
>      case MIRROR_METHOD_COPY:
> +        if (s->zero_bitmap) {
> +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> +                         DIV_ROUND_UP(bytes, s->granularity));
> +        }
>          co = qemu_coroutine_create(mirror_co_read, op);
>          break;
>      case MIRROR_METHOD_ZERO:
> +        /* s->zero_bitmap handled in mirror_co_zero */
>          co = qemu_coroutine_create(mirror_co_zero, op);
>          break;
>      case MIRROR_METHOD_DISCARD:
> +        if (s->zero_bitmap) {
> +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> +                         DIV_ROUND_UP(bytes, s->granularity));
> +        }
>          co = qemu_coroutine_create(mirror_co_discard, op);
>          break;
>      default:
> 

If we have performed the skip-zero operation, it should not be constrained
by mirror job bandwidth limits. Therefore, it is preferable to exclude it
from rate limiting.
  
  bool skip_write_zero = false;

  io_bytes = mirror_perform(s, offset, io_bytes, mirror_method, &skip_write_zero);
  if (skip_write_zero || (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok)) {
      io_bytes_acct = 0;
  } ..

> @@ -849,6 +880,8 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      bdrv_graph_co_rdunlock();
> 
>      if (s->zero_target) {
> +        int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> +
>          offset = 0;
>          bdrv_graph_co_rdlock();
>          ret = bdrv_co_is_all_zeroes(target_bs);


