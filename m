Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C0BF588E7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEqqa-0005w7-88; Mon, 20 Apr 2026 11:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEqqS-0005vZ-Nk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:47:33 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEqqQ-0004et-AF
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:47:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6E23180752;
 Mon, 20 Apr 2026 18:47:22 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:54b::1:34] (unknown
 [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id KlTRS10LGqM0-eM2sbo2e; Mon, 20 Apr 2026 18:47:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776700041;
 bh=yk1Bn1GydhHsT4AQsmbUHUQ8K0bjyVTlEKhSpOjPUso=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0KhEAyDxMFKRorhpxeCDMPbosNLyZjj1w4a8l3VF9sxC7f4MWK9or+WWyQMB1ln0U
 ybBB9t6AqIIm4pjtkCwFeT7YoCOlviqSYDFGOy4Y/yoZftOq9AMr2LZysz5rrGi2V7
 Rlzh5/2bEL9eYTQZsKOwZw2aPtGHIxJ/83RIqdxY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4515898a-2374-4bf0-b8d3-d6fcf488bb32@yandex-team.ru>
Date: Mon, 20 Apr 2026 18:47:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] net: refactoring and fixes
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
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

ping :)

On 18.03.26 14:31, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here are some refactoring and fixes, mostly in net/tap.c I'm making on
> my way to implementing TAP fd migration (through UNIX domain socket).
> 
> v4:
> 01-12: add r-b by Ben
> 10: fix bug in tap_parse_vhost_fds(), keep r-b
> 
> Vladimir Sementsov-Ogievskiy (13):
>    net/af-xdp: fix type overflow
>    net/tap: net_init_tap_one(): add return value
>    net/tap: net_init_tap(): drop extra vhostfdname variable
>    net/tap: net_init_tap(): refactor parameter checking
>    net/tap: net_init_tap(): common fail label
>    net/tap: net_init_tap_one() refactor to get vhostfd param
>    net/tap: net_init_tap_one(): drop model parameter
>    net: introduce net_parse_fds()
>    net/tap: move fds parameters handling to separate functions
>    net/tap: fix vhostfds/vhostfd parameters API
>    net/tap: net_init_tap(): merge fd=, fds= and helper= cases into one
>    net/tap: net_init_tap(): relax QEMU hubs check
>    net/tap: check that user tries to define zero queues
> 
>   net/af-xdp.c |  44 ++-----
>   net/tap.c    | 324 +++++++++++++++++++++------------------------------
>   net/util.c   |  55 +++++++++
>   net/util.h   |  14 +++
>   4 files changed, 211 insertions(+), 226 deletions(-)
> 


-- 
Best regards,
Vladimir

