Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59146C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12pL-00081a-Ed; Mon, 31 Aug 2026 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x12pJ-00081I-Bg; Mon, 31 Aug 2026 10:17:33 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x12pG-0007iv-Ei; Mon, 31 Aug 2026 10:17:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 54BABC0478;
 Mon, 31 Aug 2026 17:17:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id MHjmaBQWUSw0-GMOoDSo2; Mon, 31 Aug 2026 17:17:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788185842;
 bh=CIAlRH4mU28E2zSu2TF7g51w6GUjSqn5tjRV4PyN8us=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=JIt104t5oEKzsvT+Tubr8rjV73Cw/QRLb/ZUJQ+bR/ol1kBZlPir6tmzaChJ3uV+n
 LN3X0vWKbBTBrYvg27TiEkWVO4qKxegf6kXo/wUweVUhzOiMNko/uFUwpkb1LgeFaQ
 pbgj+KkAp5eQ9ALuiNdjw5zzS1asO6y5QjfY8k3g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <973c7967-d2eb-412a-9632-68b68b218be9@yandex-team.ru>
Date: Mon, 31 Aug 2026 17:17:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] nbd: accept a large NBD_CMD_CACHE, cover the
 transmission commands
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260827161002.310688-1-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260827161002.310688-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 27.08.26 19:09, Denis V. Lunev wrote:
> NBD_CMD_CACHE carries no payload in either direction, yet the server
> rejects any effect length above the advertised maximum payload size.
> The specification explicitly allows the oversize request, and we
> already accept it for NBD_CMD_TRIM and NBD_CMD_WRITE_ZEROES. Patch 2
> drops the check.
> 
> The rest of the series adds tests/qemu-iotests/tests/nbd-commands, a
> small client which speaks the NBD transmission phase itself. Nothing
> in the tree does that today, so the protocol surface of the server -
> reply modes, command flags, error codes, sparse and extended replies -
> is covered only as far as our own client happens to exercise it. It is
> useful both as coverage and as a regression tool.
> 
> Changes since v1:
> - the libnbd handle now lives in setUp() and tearDown() instead of a
>    context manager entered by every test case, which drops a level of
>    indent everywhere (Vladimir)
> - one block_status() helper returning a context to extents map, in
>    place of the three near identical extent collecting callbacks
>    (Vladimir)
> - the unused callback arguments are named with a leading underscore,
>    so that iotest 297 stays pylint clean; v1 added eight
>    unused-argument warnings, which would have failed 297 wherever
>    pylint is installed
> - Vladimir's Reviewed-by is kept on patch 2, which is unchanged, and
>    dropped from the four test patches, since the two points above
>    rewrote most of the test
> 
> v1:https://lore.kernel.org/qemu-devel/20260826165747.3768674-1-den@openvz.org/
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Eric Blake<eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

Thanks,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

and applied to my block branch.

-- 
Best regards,
Vladimir

