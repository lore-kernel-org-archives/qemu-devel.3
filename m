Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1015FED2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 06:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ZgJ-000509-DO; Thu, 12 Mar 2026 02:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0ZgF-0004zO-C7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:38:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0ZgB-0004z0-C9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:37:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0B89F80763;
 Thu, 12 Mar 2026 09:37:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nbAuLG0A3uQ0-5qbpvVFD; Thu, 12 Mar 2026 09:37:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773297470;
 bh=f9PwkDjPNfo/kroMFU40+/3Ofzjmd4ren7VSpB1mnaU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=kKXwgIoXZcMC1iPnTulJejOkH26f0P2unwBwXxlJk3FzcCgeUyRubGFLm1QEsbRa6
 ZpPFXgGAE6liotiqRk7pp6M3j5CuCmhG6IBKtGraXUe3gLuaga4z7cCV6nFHPYPct8
 6SQx1YBHG1NO16UTj4xtrj2hQfvYcli+ZLxdDeXE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <59d0d488-c680-4c7e-a2be-25079eaa66a3@yandex-team.ru>
Date: Thu, 12 Mar 2026 09:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] net: refactoring and fixes
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <CACGkMEuE3LQGmSK6tTa7xhYCio1nHQcAf0Fw1uD=6ipiUGtAwg@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEuE3LQGmSK6tTa7xhYCio1nHQcAf0Fw1uD=6ipiUGtAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12.03.26 05:59, Jason Wang wrote:
> On Thu, Feb 19, 2026 at 4:28 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Hi all!
>>
>> Here are some refactoring and fixes, mostly in net/tap.c I'm making on
>> my way to implementing TAP fd migration (through UNIX domain socket).
>>
>> v3:
>>
>> 01: fix checking, switch to int type for queues
>> 08: drop MAX_TAP_QUEUES constant
>> 09,10: prefer int type for queues
>>
>>
>> Vladimir Sementsov-Ogievskiy (12):
>>    net/af-xdp: fix type overflow
>>    net/tap: net_init_tap_one(): add return value
>>    net/tap: net_init_tap(): drop extra vhostfdname variable
>>    net/tap: net_init_tap(): refactor parameter checking
>>    net/tap: net_init_tap(): common fail label
>>    net/tap: net_init_tap_one() refactor to get vhostfd param
>>    net/tap: net_init_tap_one(): drop model parameter
>>    net: introduce net_parse_fds()
>>    net/tap: move fds parameters handling to separate functions
>>    net/tap: fix vhostfds/vhostfd parameters API
>>    net/tap: net_init_tap(): merge fd=, fds= and helper= cases into one
>>    net/tap: net_init_tap(): relax QEMU hubs check
>>
>>   net/af-xdp.c |  44 ++-----
>>   net/tap.c    | 319 +++++++++++++++++++++------------------------------
>>   net/util.c   |  50 ++++++++
>>   net/util.h   |  14 +++
>>   4 files changed, 201 insertions(+), 226 deletions(-)
>>
>> --
>> 2.52.0
>>
> 
> If I understand this correctly, there would be a v4 for this?
> 
> (https://patchew.org/QEMU/20260218202829.1322088-1-vsementsov@yandex-team.ru/20260218202829.1322088-10-vsementsov@yandex-team.ru/)
> 
> Thanks
> 

No, 09/12 kept as is, I just added 13/12 for the check that Ben asked for. I don't think it should be merged somewhere,
as it was preexisting (we did not check for queues==0, and for fds="").

So, no changes is planned now for making a v4.

-- 
Best regards,
Vladimir

