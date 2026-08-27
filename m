Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED35C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZV9-0006sb-Ti; Thu, 27 Aug 2026 08:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZUw-0006fv-RJ; Thu, 27 Aug 2026 08:46:30 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZUu-00082g-Pf; Thu, 27 Aug 2026 08:46:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 0B93380855;
 Thu, 27 Aug 2026 15:46:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id Ikd4DY3ZRa60-lFTtJ8QO; Thu, 27 Aug 2026 15:46:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787834779;
 bh=46MpByZoGXyC+oICzAQes8sdW2vNYEVmtqF4Kcjykcs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=onYwFL7F0a2syf/w7ve5lQdhSYISu/JiJ+Sv9BBAoSHk41/+SJGVIWcyOdNFutqCx
 ih8UDjCV4ZBLONLS3kOIwmsYclPO24m5RDDKSHqwlwCXGFhXHglQKhfwEcAuHW9LdI
 YtS61HqJGPlM2437bt9/s/Q9kpSJOCUfJW9O49t4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b60c5a13-3db1-49ab-bbe5-172cf6371dec@yandex-team.ru>
Date: Thu, 27 Aug 2026 15:46:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nbd/server: accept NBD_CMD_CACHE above the maximum
 payload size
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260826165747.3768674-1-den@openvz.org>
 <20260826165747.3768674-3-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260826165747.3768674-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
> From: Denis V. Lunev<den@openvz.org>
> 
> NBD_CMD_CACHE carries no payload in either direction. The request is
> a header only, nbd_do_cmd_cache() passes a NULL qiov to
> blk_co_preadv(), and the reply is a bare status. Still the server
> rejects any effect length above NBD_MAX_BUFFER_SIZE with EINVAL,
> which forces a client to split a large prefetch into 32 MiB pieces.
> 
> The specification does not ask for this. The constraint was renamed
> from "maximum block size" to "maximum payload size" precisely to
> separate payload length from effect length, and it says:
> 
>    For commands that do not require a payload in either direction
>    (such as NBD_CMD_TRIM or NBD_CMD_WRITE_ZEROES), the client MAY
>    request an effect length larger than the maximum payload size;
>    the server SHOULD NOT disconnect, but MAY reply with an
>    NBD_EOVERFLOW or NBD_EINVAL error if the oversize request would
>    require too many server resources when compared to the same
>    command with an effect length limited to the maximum payload
>    size (such as an implementation of NBD_CMD_WRITE_ZEROES that
>    utilizes a scratch buffer).
> 
> We already follow that for NBD_CMD_TRIM and NBD_CMD_WRITE_ZEROES,
> which carry no length check at all, and our client assumes a server
> supporting extended headers takes unlimited zero and trim lengths.
> Handle NBD_CMD_CACHE in the same way.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Eric Blake<eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

