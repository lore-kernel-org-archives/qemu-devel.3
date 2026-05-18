Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49B1CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwFf-0008LF-Ne; Mon, 18 May 2026 07:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwFd-0008Hf-TX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:35:13 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwFb-0006GU-5d
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:35:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7433FC01D4;
 Mon, 18 May 2026 14:35:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b95::1:20] (unknown
 [2a02:6bf:8080:b95::1:20])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 8ZO0pT3M1W20-OTp1PI1o; Mon, 18 May 2026 14:35:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779104108;
 bh=pcph23snDTpCxPTIpoSncXJNW1cSRlxkcXqCqhJ/X8w=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dxKPvTBTTRAC8w01gBeU4sQzniDLH9GPxYncsRMPTwf3faU6i/S5qXSZYsG3BG8DX
 kamhzHt/6VYDixVHar1pIatBPon9+OG8KtpkI2irAIBdYntY1/8iJ+SE7NZsnR4JVC
 jhRBppgKV8WiXkh+5dtwEIiZ/gOQCf8qmxpJPb/Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <99f7f6c5-baab-4920-9f4e-92bdd2605220@yandex-team.ru>
Date: Mon, 18 May 2026 14:35:08 +0300
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
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

ping

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

