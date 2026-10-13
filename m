Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC1CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXfc-0007Ex-Lk; Tue, 13 Oct 2026 04:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xGXfZ-00079d-QS; Tue, 13 Oct 2026 04:15:33 -0400
Received: from forwardcorp2d.mail.yandex.net ([178.154.239.207])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xGXfW-0004eT-TH; Tue, 13 Oct 2026 04:15:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b81a:0:640:473f:0])
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id A6A75802EE;
 Tue, 13 Oct 2026 11:15:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b35::1:3] (unknown [2a02:6bf:8080:b35::1:3])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id NFO0Gb0XjCg0-aknnYTuR; Tue, 13 Oct 2026 11:15:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1791879324;
 bh=OsypBdgc//6Z3O0sn0Xv22QE3/WVDFLI0NENfQSakTs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=UwiI+ndjtcmjdZeqelt3UmpLc9GJP6DfRATUCWDtZOujEdEtctxT3yynr056J/jH/
 gLLKKIE2E70CYoZhwuyroMH8VEuMo46Jgk6o9P50Cp13UKTRQ4U2+sCMacbyepnhia
 1Id3heX7EU5ebHgGBEGq/ZYxCzwyi/KKTR+NxG5U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <801bb56f-c704-4649-9938-73e9370d7a08@yandex-team.ru>
Date: Tue, 13 Oct 2026 11:15:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mirror: inherit the source node discard flag in
 mirror_top
To: Haoqian He <haoqian.he@smartx.com>, qemu-devel@nongnu.org
Cc: fengli@smartx.com, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20261013060549.3008438-1-haoqian.he@smartx.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20261013060549.3008438-1-haoqian.he@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.207;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2d.mail.yandex.net
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

On 13.10.26 09:05, Haoqian He wrote:
> mirror_start_job() inserts a mirror_top filter above the source node
> for both mirror and active commit jobs. Previously, the filter was
> opened with BDRV_O_RDWR only, even when the source had BDRV_O_UNMAP
> enabled.
> 
> The block layer checks BDRV_O_UNMAP before invoking a node's discard
> callback. Without this flag on mirror_top, discard requests return
> success without reaching bdrv_mirror_top_pdiscard(). Consequently,
> starting a job can silently suppress guest UNMAP/TRIM requests that
> would otherwise reach the discard-enabled source.
> 
> Initialize the filter's open flags with BDRV_O_RDWR and conditionally
> add BDRV_O_UNMAP from bs->open_flags. Pass the resulting flags to
> bdrv_new_open_driver() so that mirror_top follows the source node's
> discard setting.
> 
> This allows discard requests to reach the existing filter callback,
> which forwards them to the source and either tracks the affected
> range in the dirty bitmap or synchronously propagates the discard
> to the target, depending on the copy mode.
> 
> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
> ---
>   block/mirror.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 089856f4a8..a551d392c6 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1854,6 +1854,7 @@ static BlockJob *mirror_start_job(
>       BlockDriverState *mirror_top_bs;
>       bool target_is_backing;
>       uint64_t target_perms, target_shared_perms;
> +    int flags;
>       int ret;
>   
>       GLOBAL_STATE_CODE();
> @@ -1886,8 +1887,13 @@ static BlockJob *mirror_start_job(
>       /* In the case of active commit, add dummy driver to provide consistent
>        * reads on the top, while disabling it in the intermediate nodes, and make
>        * the backing chain writable. */
> -    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
> -                                         BDRV_O_RDWR, errp);
> +    flags = BDRV_O_RDWR;
> +    if (bs->open_flags & BDRV_O_UNMAP) {
> +        flags |= BDRV_O_UNMAP;
> +    }
> +    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top,
> +                                         filter_node_name,
> +                                         flags, errp);
>       if (mirror_top_bs == NULL) {
>           return NULL;
>       }

Cool find!

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks for fixing, applied to my block branch.


-- 
Best regards,
Vladimir

