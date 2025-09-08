Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA49CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvfGY-0003gn-B5; Mon, 08 Sep 2025 13:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvfGM-0003P9-5P
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:02:46 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvfG6-0002oO-TQ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:02:41 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BEE0680669;
 Mon, 08 Sep 2025 20:02:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id H2pXUv5Gj8c0-QAnHMeyp; Mon, 08 Sep 2025 20:02:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757350938;
 bh=aI/kg7eSoNLSXXPZvvTWIJNrmhOBJwcopGdloNsO7eA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=usyb9pa9Vvooe9DPFFNzMv6yvdtcCl5O3vwypx0HITOKHLusrteHrkFtuKZuw2/WR
 32vIbznlGcPggGC9HxJA03j5WGp/LE6qE451/aboDsncm4yennHzZd0KpeI7Ff4y3+
 CufNRHg3e7iuNTfAdBpf3Ro2ZUNLL48Yorqq6Uuo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8de7ad48-e9f5-4783-9bcc-1cd4218289ad@yandex-team.ru>
Date: Mon, 8 Sep 2025 20:02:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.08.25 20:17, Steve Sistare wrote:
> This patch series adds the live migration cpr-exec mode.
> 
> The new user-visible interfaces are:
>    * cpr-exec (MigMode migration parameter)
>    * cpr-exec-command (migration parameter)
> 
> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
> primary difference being that old QEMU directly exec's new QEMU.  The user
> specifies the command to exec new QEMU in the migration parameter
> cpr-exec-command.
> 
> Why?
> 
> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> container and its assigned resources.  By contrast, cpr-transfer mode
> requires a new container to be created on the same host as the target of
> the CPR operation.  Resources must be reserved for the new container, while
> the old container still reserves resources until the operation completes.
> Avoiding over commitment requires extra work in the management layer.
> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> is that the container may include agents with their own connections to the
> outside world, and such connections remain intact if the container is reused.
> 

My two cents:

We considered a possibility to switch to cpr-exec, and even more,
we thought about some kind of loading new version of QEMU binary to running
QEMU process (like library) and switching to it. But finally decided to
keep our current approach (starting new QEMU in a separate process) and
use CPR transfer (and finally come to my current in-list proposals of
just migrating all fds in main migration channel).

First, we don't run QEMU in docker, so probably we don't encounter some
problems around it. The real problem for us is migration downtime for
switching network and disk.

Still, why we don't want cpr-exec? Two reasons:

1. It seems, that current approach is more safe against different errors during
migration: we have more chances just to say "cont" on source process, if something
goes wrong.

2. It seems, that with second process we do have more possibilities to minimize
downtime, as we can do some initializations in a new QEMU process _before_ migration
(when second process starts, the first is still running).

I also thought about, could we do a kind of "exec", but still be able to avoid [2]?
This leads to an idea of loading new qemu binary to the running process (like library),
and .. start executing it in parallel with the old one? But that looks like trying
to reinvent processes again, which is obviously bad idea.


-- 
Best regards,
Vladimir

