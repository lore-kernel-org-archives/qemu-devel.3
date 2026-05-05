Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56D2FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCv2-0003zL-La; Tue, 05 May 2026 06:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wKCv0-0003yx-Bo
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:22:22 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wKCuy-0008Bx-1S
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:22:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 77FE4C01D0;
 Tue, 05 May 2026 13:22:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:78a::1:25] (unknown
 [2a02:6bf:8080:78a::1:25])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BMd35C0LAGk0-OKCo2x4R; Tue, 05 May 2026 13:22:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1777976532;
 bh=FOsDmUGq6zC0vvjQHTnSeP1ITDRLBmiUKd1+1oLkpKo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EvfQc6EzslS78flK0H6TnxnrpwYo7SxP1QfCHDjfri9Rq4weuAFsNiLk68StBnHzp
 4bTEKPa3eOzfX1eiDYjdbrSjbKcZY9Wd+kndF65bEayjkSANSYcRf8Xxe50brw/pDC
 Fb5GJhVgTo5pwetjOwIdzyGlV2gwuwNAOPM/Y/E0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9296f543-aeb9-4bd8-a035-35990fbb02bb@yandex-team.ru>
Date: Tue, 5 May 2026 13:22:11 +0300
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

ping ping)

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

