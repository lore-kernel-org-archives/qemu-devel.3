Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A573AC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 05:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAjBq-00044Q-3u; Fri, 02 May 2025 01:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAjBm-00043T-PG; Fri, 02 May 2025 01:43:58 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAjBi-0001oI-H3; Fri, 02 May 2025 01:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1746164620; bh=5Pijun/UoNJIImz2qgv+8kD5hnI+A86FHXeYKjrPqPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q/oFHINrsudq3+YVJ0+wRtwB3N9AJUOV64gRUqkQeuRpWLbcgUQmI9xlzgJ/3sfd0
 4QF8qxdxGxvc8zm1aX0RvmC2lFNCPEzFP2uBTAW85vWB9EM+fth5JsjP+vkxNvLvTL
 HkuKfdQJoBNrKts5/tgtzrUUt0UgUHGXL7NoFlbM=
Received: from 192.168.182.133 ([117.147.34.111])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id AE594E57; Fri, 02 May 2025 13:43:37 +0800
X-QQ-mid: xmsmtpt1746164617t4p8z0q9u
Message-ID: <tencent_12496107E765F6CE079B92697BE880E40708@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70/FONIn8sJRmTzLb9Z536hraNX82zZ9d0Wzz0JSPZJ/BoHUB/HY
 IAAkmjLRWT1MuzxFRElP+l3oxmp3lhLRenYS4Mgp2lJAMi/xcmN6fjMnM4YEHs0EjA5CHgnMZitl
 6Zn6Dt6h4GIJAEVW4mNFsx/6g8c1ZVE4JXzCgmDoz6SVWqtr5JHewYnXdVHzeDYCuYdYfYSbE2YD
 2E6Fj6LLMzHFZZSL7eHo+bRwnyrJwrXIhfH1kGEWe9xPnWJRv1chKkluxiUenUNabp6BpR0XxiPI
 57ZVXvtcJmYDStK2A40FSWn2SZt/xj7YL69pZUjRfEZuua+O0Zwjxjje+ICVXCpqGyJak1j4jf0b
 sA8nXWRltBvqrgGuWnzPuFSKaWFXfVBtwqoFxWnRSjKMW2T41MEAXQc99CvEkjzx5UBvja5X82kJ
 h9/d8fQIpZCgexAHGOMnNo1By+CCeEedB6ebAo/tfXKUyX4KXl2ZVMTSNR9AcZ788YzZgEDp7mOj
 OiC7VTcIrzj47o9FQK4NdFdq1trAQd+dYPsjk9h6RqL/U409AjjU3DTC9OmLWFu3BnlmtOm1MS3I
 1Aln6LOwS2dcGefhClgxXuM2fOt7AoIZkVIR1et6PVrGA+9EzQvuGSuKcubJnXzr9gZVoYKjmc73
 Uy62B5RMPFzFFjkhCeMwoznsGH6wvIRV4l7hd7V4aGAICpj5E+QacFkVWGsw0wnJ7XKESKfXYYn8
 YdW79EvLCpZ2Byrr3lBGihXFJ5miSEPNyfzIJ6wonHxWdQaQKn7FcZWvdmBtvQRI+Ym70vNduL8f
 OSeg3xdaXVPP+Wyuzw0nH62OVIENOY0Ab7guaot/I9vXbR0muy9Ae/OWM6cv2Jms07D7eIkIRTOO
 PHqSRAiBLGR7BmgkKN9lSYk1F8sCB2wTI/wHnafaoUSGEI3Up1E9a52kGRdp5mrLHJ8YyJmFPzf0
 nEFa3YHXbRzPrFQBx+Cw4+zPnWyVjIMBNjQD36mnnYE6dHLAsIuA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re [PATCH v3 08/11] mirror: Skip writing zeroes when target is
 already zero
Date: Fri,  2 May 2025 13:43:37 +0800
X-OQ-MSGID: <20250502054337.71226-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5juocucf4fkmromqgt7czkkg7sbnb5tlmwup2aajaaaewdrfgn@skc7mm52ch63>
References: <5juocucf4fkmromqgt7czkkg7sbnb5tlmwup2aajaaaewdrfgn@skc7mm52ch63>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.64; envelope-from=sunnyzhyy@qq.com;
 helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SORTED_RECIPS=2.499,
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

On Thu, 1 May 2025 12:58:42 -0500, Eric wrote:
> On Thu, May 01, 2025 at 12:38:30AM +0800, Sunny Zhu wrote:
> > on Thu 24 Apr 2025 19:52:08 -0500, Eric wrote:
> > >      if (s->zero_target) {
> > > +        int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> > > +
> > >          offset = 0;
> > >          bdrv_graph_co_rdlock();
> > >          ret = bdrv_co_is_all_zeroes(target_bs);
> > > @@ -856,6 +898,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> > >          if (ret < 0) {
> > >              return ret;
> > >          }
> > > +        s->zero_bitmap = bitmap_new(bitmap_length);
> > >          /*
> > >           * If the destination already reads as zero, and we are not
> > >           * requested to punch holes into existing zeroes, then we can
> > > @@ -864,6 +907,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> > >          if (ret > 0 &&
> > >              (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
> > >               !bdrv_can_write_zeroes_with_unmap(target_bs))) {
> > > +            bitmap_set(s->zero_bitmap, 0, bitmap_length);
> > 
> > when arg->mode != NEW_IMAGE_MODE_EXISTING && bdrv_has_zero_init(target_bs) is true
> > in drive_mirror (This means the target image is newly created), in which case
> > s->zero_target == false, we still need to execute bitmap_set(s->zero_bitmap, 0, bitmap_length)
> 
> Good catch.  I will fix that in v4.
> 
> Now that I'm thinking a bit more about it, I wonder if s->zero_target
> is the right name.  We have several pieces of information feeding the
> potential optimizations: are we mirroring the full image or just a
> portion of it (if just a portion, pre-zeroing is wrong because we
> shouldn't touch the part of the image not being mirrored), did we just
> create the image (in which case it reads as zero and we can skip
> pre-zeroing), did the user pass target-is-zero (later in this series,
> same effect as if we just created the image), is punching zeroes
> allowed (not all setups allow it; and even when it is allowed, there
> are tradeoffs on whether to punch one big hole and then fill back up
> or to only punch small holes as zeroes are encountered).
> 
> It's a big mess of conditionals, so I'm still trying to figure out if
> there is a more sensible way to arrange the various logic bits.  With
> the addition of target-is-zero, maybe it makes more sense to rename
> s->zero_target to s->full_image, and to set s->full_image=true
> s->target_is_zero in the arg->mode != NEW_IMAGE_MODE_EXISTING &&
> bdrv_has_zero_init(target) case.

Correct. The pre-zero and skip-zero optimizations are only applicable
when sync == MIRROR_SYNC_MODE_FULL. In MIRROR_SYNC_MODE_TOP scenarios,
where the source snapshot chain (excluding the top snapshot) is pre-copied
to the target, the destination image is not an all-zero image. Consequently,
we can neither perform pre-zeroing nor skip-zero operations in this case.

    if (sync == MIRROR_SYNC_MODE_TOP) {
        /* No optimization is needed. */
    } else {
        /* sync == MIRROR_SYNC_MODE_FULL */
        if (mode == NEW_IMAGE_MODE_EXISTING) {
            if (target_is_zero) {
                bitmap_set(zero_bitmap)
            } else {
                pre_zeroing;
                bitmap_set(zero_bitmap);
            }
        } else {
            if (bdrv_has_zero_init(target_bs)) {
                bitmap_set(zero_bitmap);
            } else {
                pre_zeroing;
                bitmap_set(zero_bitmap);
            }
        }
    }

We list all possible scenarios, where some code branches can be merged
during implementation.


