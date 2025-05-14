Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7944FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEiW-0005ZH-Ag; Wed, 14 May 2025 12:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uFEIV-00033y-3H; Wed, 14 May 2025 11:45:38 -0400
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uFEIL-0002hn-9Y; Wed, 14 May 2025 11:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747237504; bh=Ff40hSDHf23i9uNqj7BBEdJRrJ6S5X3vmaz8E1KcQiM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B8FinTztXeBFZ4+Tv3i65DZ1W5HO7AjMugWO8ElsrWI+PEc/LrdgDm4KX6U0+ROpE
 ds4M8tv4quilGke1lX1jHdz506mNU5xpPdZU8EFIK8+zdFkPAwdph3t0ukk8BdMCz2
 Z3f+uSlYB+xER+3aigF5klcBPXtnZCk9SoTmXHnA=
Received: from localhost.localdomain ([117.147.34.74])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 9B390847; Wed, 14 May 2025 23:38:51 +0800
X-QQ-mid: xmsmtpt1747237131t6ffa1ypv
Message-ID: <tencent_80394492ED0159599D33DE267BDA007A1C06@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLo9ACLs+1+raiu1u9PBH7rrFGLWUTaJz1OXthURDbmELOkvMF2f
 YXiWNQTnVNq+LQp5SCP/uYOeDS+ri/08C9vks7XF9DnWVsFelgtkjm2ibT+AylnXziNjKVwm6QxF
 FZJLOr4qJjX/TeCoF/eearRMaX/qT52WmJO9i6S50g4HQ1e6vsrgJKCo+c5Igli9MYGn7j65VbbF
 Ayo+ST3oIH97Vyn/YDlZgtZ2IMTKN4KklIVdUU9opJ5HvdgRK1ggcAnBXZhuF3QNcPlevi4xDWXc
 wZVu0OJCXmNFPCg9LJ7Zo1pIpf4qHA0RhiyPIncmFgOgA5r/2816jAe70wEoeXHngdvS1rRp4uXb
 8QVEd1A2LtZ78aYMxmtpxgljf6GhXPwzvaMXHvNQqZDyon4/0mFDS/PYAY1BlRPM7lNGfzhEHz9b
 Jcu/30xBMjqHccJmfeVHLAMiCSGDyPqORvSpmHEqP7TxcwaT3c84+xF0DAiXGI+5w+2NxXU5tKed
 6XrAr5zkrZv7z0YKbCos0Xxn93jNeLTyzTA4Pne+URc3Of4VGY0Zq4ufU4MQR4/IR1YNwHUzxGn/
 ymh/qkRDyvnAv1p9yhA/dtyID/gIae8rPIaJ6TejFsVV0R6dNFrcSqfKCuk1hfEY+oIlkql0zP+P
 /wuyFDIYrkRvxk5anOUj0LE887eaqc07RL3ZLmWnT9SJtlM0wVjlY8tnUAp9zbSi2voPTsLQL0S8
 rXOJJw7YF0Tj6vB+l6ARZ3Lb5g2QtN7IwasjI2lTW7VSKRmEErkfQdNQlZaUU9vmmr5FbArD8CU5
 +0x1zPA795GREixOUsBElOtTaB4viKnoSoc45QksclCkjfRUEtys+dRUSa4JSlf0umY5/i8RQLhD
 2AFDvN1bvVpKrL2CLEuYLQ22nWMgvXs5iaJeLlwMe2fEO4nJiUslEuqHUI8MLP7ZPxaE0ZtsMXwI
 PNaAGjrz3fVEOpN0tu6J75c36RYUsSAiMvTsOxcXIvQw7Wsdm6BQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 11/13] mirror: Skip writing zeroes when target is
 already zero
Date: Wed, 14 May 2025 23:37:54 +0800
X-OQ-MSGID: <20250514153754.53829-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509204341.3553601-26-eblake@redhat.com>
References: <20250509204341.3553601-26-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.233; envelope-from=sunnyzhyy@qq.com;
 helo=out203-205-221-233.mail.qq.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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

On Fri, 9 May 2025 15:40:28 -0500, Eric Blake wrote:
> @@ -847,8 +887,10 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      bool punch_holes =
>          target_bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
>          bdrv_can_write_zeroes_with_unmap(target_bs);
> +    int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> 
>      /* Determine if the image is already zero, regardless of sync mode.  */
> +    s->zero_bitmap = bitmap_new(bitmap_length);
>      bdrv_graph_co_rdlock();
>      bs = s->mirror_top_bs->backing->bs;
>      if (s->target_is_zero) {
> @@ -862,7 +904,14 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      if (ret < 0) {
>          return ret;
>      } else if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
> -        /* In TOP mode, there is no benefit to a pre-zeroing pass.  */
> +        /*
> +         * In TOP mode, there is no benefit to a pre-zeroing pass, but
> +         * the zero bitmap can be set if the destination already reads
> +         * as zero and we are not punching holes.
> +         */
> +        if (ret > 0 && !punch_holes) {
> +            bitmap_set(s->zero_bitmap, 0, bitmap_length);

It's ok when ret > 0 is obtained through bdrv_co_is_all_zeroes(target_bs). However,
if ret = 1 originates by target-is-zero == true from qmp_blockdev_mirror, this means
that target-is-zero also takes effect under sync=TOP. I am uncertain whether this
aligns with our intended behavior.

Under sync=TOP, target-is-zero could carry two distinct meanings:
[1] The top snapshot reads as fully zero.
[2] The entire destination snapshot chain reads as fully zero.

Currently, target-is-zero is designed to represent scenario [2] on sync=TOP.

> +        }
>      } else if (ret == 0 || punch_holes) {
>          /*
>           * Here, we are in FULL mode; our goal is to avoid writing
> @@ -871,8 +920,9 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>           * zeroing happened externally (ret > 0) or if we have a fast
>           * way to pre-zero the image (the dirty bitmap will be
>           * populated later by the non-zero portions, the same as for
> -         * TOP mode).  If pre-zeroing is not fast, or we need to punch
> -         * holes, then our only recourse is to write the entire image.
> +         * TOP mode).  If pre-zeroing is not fast, then our only
> +         * recourse is to mark the entire image dirty.  The act of
> +         * pre-zeroing will populate the zero bitmap.


