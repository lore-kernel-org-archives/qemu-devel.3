Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58367C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh9C-0007mn-5O; Thu, 01 May 2025 23:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAh8w-00073X-8l; Thu, 01 May 2025 23:32:54 -0400
Received: from out203-205-221-231.mail.qq.com ([203.205.221.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAh8q-0001NA-PL; Thu, 01 May 2025 23:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1746156760; bh=ebi1yvWvYI9qH4a3N9h8LQ/bKRfqs6LYCsQ4sV/ph+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ywpZo2Wtp8XWyixGqsQVaCKUaed4rHjcVff2w2e0HS5IEAZmSKD6ZuG60Sfl3hpsS
 bkpzmWlZRWNgBHRsOxlc6pv9pFqw6X8AoO4LLqdXznGrzSEoyEUDAgFA/PQfSBYfqV
 rLhBGQE8dj7QsXJ6oUWlhE6dmQsuY5MnOPfOOeDY=
Received: from 192.168.182.133 ([117.147.34.111])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 69B84427; Fri, 02 May 2025 11:26:27 +0800
X-QQ-mid: xmsmtpt1746156387t9bme10x1
Message-ID: <tencent_C6F3B25CE7FC4D9F3446F44A7280248D0307@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9iI7t4SP7KHcrZyFJV+CqRSEQFttbVYU/RXeeKIgf3KhVITLwrkL
 8K8MFOQwlmoqrkrcFJthmfyO/DGDmUFvMK160ZQ9ZW2wbHPs4RHiz/o337+HPJdTiOmeTq0FNsYb
 /mvlQYf8AY3Sc4YsxFcX6R2hmq5imf3Xa1vUK+UDZ2BBrgHqwZ5ZABXdFLDoVQs9v0ZeKaQMXaGe
 wiQoYGerKks+nLdRgugtk7FsHADMRbNtiMXcR+jj2M+pRLCcqTBAi+sFA+hiWST+I9k2c52pzhvH
 x0RYtK3k1VAEIfo0r6ie6tWMZ0R/F1go6sobevXSkh6Vj/zXYBp17zZPFFVA0h4dF40AuXHuw69Y
 JU66c2vfVp7Vxynjffxk4SSDVakXR8QjBIO2DAwrdKFs5rEw1XnZtjtsdcnfN4J7TKLsCgg3ElgC
 QXJU3eohMnW6mkuiLGce6mFH2eKD3bpP4xi7giS03pmZg2gyUxlB5sY6tUAQI+3Fzt0ysYX8CmWN
 AodNiKm8i78hp414vpiFXkNbJuoUrDpMcZPf3LADEWlhJ1IRwckBc2Y17ghzT+Ly1GycEy8ZdfcF
 kmRWyon04024rSHI2oM6mtUop2w7eia3rCfyV0J54mQbRauUqMZKayB1TdwY0rDCn+N0pDdAe/5l
 5tvKp5skyBgFprmyZh4AD37m98+Iq51bBRqffFEVnZunT83gOZn2EFLij/mxobWkmNG2UF10BL8Y
 23iJLBsYHQVS3MxjKIsNJXGb3XirdbHVru/xJVvHRjXZ7xuaEpfyMhA5m00FL6Pec/aiUFfJuZt6
 poEykAUFuyxYvUqZln1bQJRoDJBPqQcKXQNxJ0OykHJNFqncdQGi8J/LL4O4O189J7S85uuCKvzR
 U7KEqO2zZS6hWP1imITgFc4I0bQJ0JC1P3xjU94FMmr65KeIetVsYc8Ars+UX1ram1IZuDaPRCt9
 5sOL6wUtTNJI1UAleuEoxXanDdOQEoFB+iSKeYjrQ=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 07/11] mirror: Skip pre-zeroing destination if it is
 already zero
Date: Fri,  2 May 2025 11:26:27 +0800
X-OQ-MSGID: <20250502032627.69424-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <62z5r3pt24o3ng2iumeoz4hmzavveucs3o56yj5mlg3quinkv6@keliqtsk3c54>
References: <62z5r3pt24o3ng2iumeoz4hmzavveucs3o56yj5mlg3quinkv6@keliqtsk3c54>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.231; envelope-from=sunnyzhyy@qq.com;
 helo=out203-205-221-231.mail.qq.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 1 May 2025 12:33:14 -0500, Eric wrote:
> > > +         * If the destination already reads as zero, and we are not
> > > +         * requested to punch holes into existing zeroes, then we can
> > > +         * skip pre-zeroing the destination.
> > > +         */
> > > +        if (ret > 0 &&
> > > +            (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
> > > +             !bdrv_can_write_zeroes_with_unmap(target_bs))) {
> > > +            offset = s->bdev_length;
> > 
> > If when bdrv_can_write_zeroes_with_unmap(target_bs) == true, we prefer to
> > punch holes regardless of whether target_bs already reads as zero, then
> > execute bdrv_co_is_all_zeroes() in advance might be wasteful.
> 
> Hmm.  bdrv_co_is_all_zeroes() is supposed to be fast, but you're right
> that even faster than a syscall or two is no syscalls at all.

Indeed, bdrv_co_is_all_zeroes() is supposed to be fast, and since we are on the
management plane rather than the data plane, the impact here should be negligible.

> 
> > 
> >     if (bdrv_can_write_zeroes_with_unmap(target_bs)) {
> >         initial_zeroing();
> >     } else {
> >         ret = bdrv_co_is_all_zeroes(target_bs);
> >         ...
> >     }
> 
> That's a bigger refactoring; probably worth doing in a separate patch.
> It looks like I should probably do a v4 along those lines, to see how
> it compares.
> 
> > 
> > > +        }
> > >          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
> > >              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
> > >              return 0;
> > 
> > When ret > 0, We should not return directly here.
> 
> That's pre-existing, but correct.  If we can't write zeroes with
> unmap, then we mark the entire image dirty (every zero in the source
> will result in zeroes in the dest - as it was before this series); and
> we have also marked the zero bitmap (writing zeroes will be a no-op if
> the zero bitmap says that is safe).  The rest of this function has two
> purposes: finish pre-zeroing (well, there's nothing to pre-zero if we
> can't punch holes, and especially nothing to pre-zero if we already
> know the image reads as all zero), and populate the dirty bitmap (we
> just populated the entire map here, so it's not worth trying to
> populate the map with finer granularity later), so returning here is
> the right thing to do.

I apologize that my previous explanation missed the key point. What I meant is:
when bdrv_co_is_all_zeroes() > 0 && !bdrv_can_write_zeroes_with_unmap(target_bs),
we set offset = s->bdev_length;

However here, when !bdrv_can_write_zeroes_with_unmap(target_bs) is true, we directly
return, which means that offset = s->bdev_length (i.e., our logic to skip pre-zeroing
the destination) will never take effect.

The appropriate modification here should be:

    if (!ret && !bdrv_can_write_zeroes_with_unmap(target_bs)) {
        bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
        return 0;

> 
> > 
> > >          }
> > > 
> > >          s->initial_zeroing_ongoing = true;
> > > -        for (offset = 0; offset < s->bdev_length; ) {
> > > +        while (offset < s->bdev_length) {
> > >              int bytes = MIN(s->bdev_length - offset,
> > >                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
> > 
> 


