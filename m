Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A51C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxjy-0007bb-3t; Mon, 17 Aug 2026 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvxjk-0007ax-Hg; Mon, 17 Aug 2026 09:50:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvxjh-0003Lk-12; Mon, 17 Aug 2026 09:50:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 08B718068E;
 Mon, 17 Aug 2026 16:50:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d2f::1:33] (unknown
 [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id eoUWrp0XWKo0-QSUuCV7L; Mon, 17 Aug 2026 16:50:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786974640;
 bh=doe2QbnVK14OEjfbV6isaDfhVnUTN8dWcp69Q/G32i8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eqzodoZV4YSBHpO9pdJFbtEZOXm+1Y/u4yMn6vKAU1ks+jH41WJPF7hWQdC+/yYsT
 ukYw3bEwhZ25F9ZJKmDpsfmNBU98yQCEp5BEnhffN7WU0E74cYkG+11i3CVO64Ibjx
 56o/aDKqFsAP3iKiOvf0FFz2lBlWbmVMmxTwmqr0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d4a7f707-ff47-4d55-abcb-17a8c99e8c59@yandex-team.ru>
Date: Mon, 17 Aug 2026 16:50:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: remove unused 'owner=' variable assignment
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260810141206.525581-1-berrange@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260810141206.525581-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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

On 10.08.26 17:12, Daniel P. Berrangé wrote:
> Most, but not all, of the shell I/O tests assign an email address to
> the 'owner' shell variable. This variable is never used for anything
> so gets reported as a dead assignment by shellcheck. The same is also
> not done for the python I/O tests, though some include owner= in a
> comment.
> 
> Mostly the 'owner=' variable seems to be an alternative to expressing
> an "Author: NAME <EMAIL>" comment, but without the NAME. While they
> could be converted to Author comments, this does not have a benefit
> over using Git history and are not widely used in QEMU source code.
> Git records activity over time so is more representative than the
> initial author. Meanwhile the MAINTAINERS file, also expresses a
> notion of ownership over the maint of files.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

