Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3603C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAA6P-0002dL-8Y; Wed, 30 Apr 2025 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAA6N-0002cz-1a; Wed, 30 Apr 2025 12:16:03 -0400
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAA6G-0005iL-Pu; Wed, 30 Apr 2025 12:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1746029738; bh=1U8bfEqct4CithQPesE+NNzoOicQLLkLY3FP2OuYIK0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cKHBW4+BAJI2wM1aHUSOcTSn/FQMQ4RbiSjSh5tKCLdY/OxN5sO6uaYTq7Un/AnFX
 Fv3Q0WsHGt9HvE9NP4yxrVMs2nk739w4VpyaBtszUAJatB48cYFe6uaf0ct2SA9DfM
 LhIIRoJl1IMGv+6vWTWirkhhrjqmNNiUbEf1p+EY=
Received: from 192.168.182.133 ([117.147.34.111])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 25A970E6; Thu, 01 May 2025 00:09:26 +0800
X-QQ-mid: xmsmtpt1746029366tfdg0mn1a
Message-ID: <tencent_5A9BAC6959E81AE41E493B07736535CE7608@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeHCSVAdCPzgghUKcGCYaYwXiQpvkqAGMAhtxoXHSYtbOdoxWgHo
 Ml6YvkYcYUIixousvck7qLIWOkm+mX+b5K9GH+pjZyUlCbpfrRd0IMPNm4TTV/tqRjKulqAM+2LH
 +7KKgmOtzFpbhnqB9PCTjZIKB18SenzeS91esGrLFVcM4BFehcHYVB60CqBDqsNYnX9o6JeMt7gP
 DngHRYRei3E+6/xCOoY9LFDPMj0CpvLoD0MYlDtBPifJlRYLMyyemWDruIiep30S7d5YG5H+2pbr
 fV1VjpZ6lrusiBVPwIPfa7jE0Kvn6KNu7jwdQSmTlEloQDJyyUfVrcC801vVWxBW5RefTYGN22TA
 niMkSKOOA3cn7cC85OBITyvQycIf8iJBBe/dixieMP9/57cENvURXvR0FSRQUrSY3+iDJdxMV28c
 O9CfO6K6DGFkl3ypdEoibZlLbcCr209zCN6R8bJt+12U37mAzaFU4NSDK4BftQPITuSLgQiIuk7w
 h0Tj49PRejoJodBB6j+9jfa8igrub3wZIb7qYJRI1AtBu1vH1IOJJm3RqKdMkZQZGCWETsX7Sid7
 4/0dIQN1sxOhzA+Mn29qf85TeDntfj89A0CAyRUeTCj2CYOBwhSYy2A7UEmgUTVxctHeUfwbCevK
 hvCtU/x9hV0QnJI96+TmLC/Synp7sj9CHofBZGo94kybYaRbzNQfugHcYNlXWX0rcgd7yxz50cYF
 kDNA9JhkFDHY+gu0Cgu0t61kh3yfvtGuUjyk8o6LF6SacWy2rOMYQJkLpeGwOWy6etQrVmR99r19
 zVdErrx0/4IeuRKi9koYLksCKhmbf8fKLuwXtXBZxr7obK14k570HEXMxd+fhqNMsAQYRuIjgzCc
 +xQ4FqPF0CYLzUCdKA0xTCsjzXFkf9WIflFW328AdD2YNOGy+UbioNXezsdV5gAq70MWvSO9wd1Z
 Fw/VVqRV1RapCHorDSJTqcUfSeMjL7eTy0XjSHXcWN3h7QjtOW5g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 07/11] mirror: Skip pre-zeroing destination if it is
 already zero
Date: Thu,  1 May 2025 00:09:26 +0800
X-OQ-MSGID: <20250430160926.47496-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425005439.2252467-20-eblake@redhat.com>
References: <20250425005439.2252467-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.173; envelope-from=sunnyzhyy@qq.com;
 helo=out203-205-221-173.mail.qq.com
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

> When doing a sync=full mirroring, QMP drive-mirror requests full
> zeroing if it did not just create the destination, and blockdev-mirror
> requests full zeroing unconditionally.  This is because during a full
> sync, we must ensure that the portions of the disk that are not
> otherwise touched by the source still read as zero upon completion.
> 
> However, in mirror_dirty_init(), we were blindly assuming that if the
> destination allows punching holes, we should pre-zero the entire
> image; and if it does not allow punching holes, then treat the entire
> source as dirty rather than mirroring just the allocated portions of
> the source.  Without the ability to punch holes, this results in the
> destination file being fully allocated; and even when punching holes
> is supported, it causes duplicate I/O to the portions of the
> destination corresponding to chunks of the source that are allocated
> but read as zero.
> 
> Smarter is to avoid the pre-zeroing pass over the destination if it
> can be proved the destination already reads as zero.  Note that a
> later patch will then further improve things to skip writing to the
> destination for parts of the image where the source is zero; but even
> with just this patch, it is possible to see a difference for any BDS
> that can quickly report that it already reads as zero.
> 
> Note, however, that if the destination was opened with
> "detect-zeroes": "unmap", then the user wants us to punch holes where
> possible for any zeroes in the source; in that case, we are better off
> doing unmap up front in bulk.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> v3: add exemption for "detect-zeroes":"unmap" on destination
> ---
>  block/mirror.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 34c6c5252e1..4059bf96854 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -849,13 +849,30 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      bdrv_graph_co_rdunlock();
> 
>      if (s->zero_target) {
> +        offset = 0;
> +        bdrv_graph_co_rdlock();
> +        ret = bdrv_co_is_all_zeroes(target_bs);
> +        bdrv_graph_co_rdunlock();
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        /*
> +         * If the destination already reads as zero, and we are not
> +         * requested to punch holes into existing zeroes, then we can
> +         * skip pre-zeroing the destination.
> +         */
> +        if (ret > 0 &&
> +            (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
> +             !bdrv_can_write_zeroes_with_unmap(target_bs))) {
> +            offset = s->bdev_length;

If when bdrv_can_write_zeroes_with_unmap(target_bs) == true, we prefer to
punch holes regardless of whether target_bs already reads as zero, then
execute bdrv_co_is_all_zeroes() in advance might be wasteful.

    if (bdrv_can_write_zeroes_with_unmap(target_bs)) {
        initial_zeroing();
    } else {
        ret = bdrv_co_is_all_zeroes(target_bs);
        ...
    }

> +        }
>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
>              return 0;

When ret > 0, We should not return directly here.

>          }
> 
>          s->initial_zeroing_ongoing = true;
> -        for (offset = 0; offset < s->bdev_length; ) {
> +        while (offset < s->bdev_length) {
>              int bytes = MIN(s->bdev_length - offset,
>                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));


