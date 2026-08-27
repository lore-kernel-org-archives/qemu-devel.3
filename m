Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3814EC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZvX-0002YM-8N; Thu, 27 Aug 2026 09:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZvT-0002Xk-IX; Thu, 27 Aug 2026 09:13:51 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZvQ-0005xd-CN; Thu, 27 Aug 2026 09:13:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id D9EA18087E;
 Thu, 27 Aug 2026 16:13:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id hDeDhO3XKGk0-GAjHiyPR; Thu, 27 Aug 2026 16:13:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787836423;
 bh=vOYAQRL49UEiEQGFyGTYnblhwuxUjqWhy+p3NM+bZzQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1j1GA3AVxNnvADn+6mmguJSjnivOVPMrGSUyFziEe6JPXl3AJ53+8duKtNkoCx7UN
 QqD0e5VnLS9k5wfKmMxM1XSfAzUXSEnjOasZc4E3q5PdbMTU+7b6dBH1PRPh0bPTNx
 OX1Gjyw3A43hFWEWDWpJXZF9K5dv8lrLL047QyOc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <799032cb-0f0d-45ac-b915-27588d17ef27@yandex-team.ru>
Date: Thu, 27 Aug 2026 16:13:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iotests/nbd-commands: cover the command flags and
 sparse replies
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260826165747.3768674-1-den@openvz.org>
 <20260826165747.3768674-6-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260826165747.3768674-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 26.08.26 19:57, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> No test sends the NBD command flags, so the server paths behind them
> go unexercised. Send them from the new client.
> 
> A structured read answers a hole with an offset and a length rather
> than a cluster of zeroes. Lay out data, a hole and data again, and
> read the three arrangements a hole can appear in, since a leading hole
> and a hole between two extents take different turns through
> nbd_co_send_sparse_read(). NBD_CMD_FLAG_DF asks for one chunk instead,
> which is the same layout sent as real zeroes. Check the chunk
> boundaries in both forms, and that the data still reads back.
> 
> NBD_CMD_FLAG_REQ_ONE caps the extent array at one entry, so the block
> status reply covers only the first cluster of the three asked about.
> That a reply may describe less than was requested is also how the
> server keeps NBD_MAX_BLOCK_STATUS_EXTENTS from being exceeded on a
> long fragmented range, and a client assuming full coverage believes
> stale status.
> 
> NBD_CMD_FLAG_FAST_ZERO becomes BDRV_REQ_NO_FALLBACK. A cluster aligned
> zero can be done by marking the cluster, while zeroing part of a
> cluster over a backing file needs the read modify write the flag
> forbids, so check both the success and the ENOTSUP.
> 
> NBD_CMD_FLAG_FUA is added to a write and a trim.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/qemu-iotests/tests/nbd-commands     | 86 +++++++++++++++++++++++
>   tests/qemu-iotests/tests/nbd-commands.out |  4 +-
>   2 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
> index 683a8303e3..f727ea3161 100755
> --- a/tests/qemu-iotests/tests/nbd-commands
> +++ b/tests/qemu-iotests/tests/nbd-commands

[..]

> +
> +    def status_extents(self, h, count, flags=0):
> +        extents = []
> +
> +        def cb(meta, offset, entries, err):
> +            if meta == 'base:allocation':
> +                extents.extend(zip(entries[0::2], entries[1::2]))
> +
> +        h.block_status(count, 0, cb, flags)
> +        return extents

duplicates allocation_depth() functions except for meta name and flags passing.
code may be shared.

anyway,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

