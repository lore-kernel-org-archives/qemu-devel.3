Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E97CFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNc7-0006vW-Px; Fri, 21 Nov 2025 04:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vMNc0-0006hU-0h; Fri, 21 Nov 2025 04:39:28 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vMNbx-0004Jv-Kr; Fri, 21 Nov 2025 04:39:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EDA68C11AE;
 Fri, 21 Nov 2025 12:39:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:91b::1:b] (unknown [2a02:6bf:8080:91b::1:b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HdU9G80FMa60-gTjksPgg; Fri, 21 Nov 2025 12:39:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763717958;
 bh=VDeVNMkReBI/BPstY2yz61g7SJSpp39XHTG2gZHJarc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wAWkNKSwEMbevPzC9xmE1wEE4YbV1U4giBqkPKxeR4DGOBRh/qI3PDpLtvLm1DlfC
 DIXvi2ebEfkWHLEuDarDChkuC0c5t7/1hTLxtJk8SkuRGQagEWS+gdo8Lrc2hqe7It
 45qENlXWwhyxCrII+rjokg0Y/DNXPML3GS6b8JP0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <573c13aa-a2e5-4644-b14f-c08e94b3a8a5@yandex-team.ru>
Date: Fri, 21 Nov 2025 12:39:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] block-job patches 2025-04-29
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
 <7522aad8-ba24-44fc-aeee-723159f45142@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7522aad8-ba24-44fc-aeee-723159f45142@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15.11.25 02:00, Michael Tokarev wrote:
> On 4/29/25 14:33, Vladimir Sementsov-Ogievskiy wrote:
> ...> block-job patches
>>
>> - deprecate some old block-job- APIs
>> - on-cbw-error option for backup
>> - more efficient zero handling in block commit
>>
>> ----------------------------------------------------------------
>> Raman Dzehtsiar (1):
>>        blockdev-backup: Add error handling option for copy-before-write jobs
>>
>> Vincent Vanlaer (5):
>>        block: get type of block allocation in commit_run
>>        block: move commit_run loop to separate function
>>        block: refactor error handling of commit_iteration
>>        block: allow commit to unmap zero blocks
>>        block: add test non-active commit with zeroed data
> 
> There's a bug report in debian, for 10.0.x series of qemu, here:
> https://bugs.debian.org/1120389 .  This looks like it's about
> this very series, in particular, commit v10.0.0-369-g6f3199f996
> "block: allow commit to unmap zero blocks".  Does it look similar? :)
> (I haven't yet verified if this commit actually fixed the issue
> reported in the debian bug).
> 
> But if it it, it looks like it should be a good idea to pick this
> series up for 10.0.x stable series too, what do you think?
> (it all applies cleanly and seems to work too).
> 

Agree, looks like the series may fix https://bugs.debian.org/1120389,
but of course, better to check it explicitly.

Picking it into 10.0.* is not bad I think.


-- 
Best regards,
Vladimir

