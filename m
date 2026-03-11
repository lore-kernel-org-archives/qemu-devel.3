Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B331125806
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JVl-0004vo-QW; Wed, 11 Mar 2026 09:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JVj-0004vN-3Z; Wed, 11 Mar 2026 09:22:03 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JVg-0001xu-Ir; Wed, 11 Mar 2026 09:22:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B3524807E2;
 Wed, 11 Mar 2026 16:21:53 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qLGU430AvuQ0-ePQEfJ0V; Wed, 11 Mar 2026 16:21:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773235313;
 bh=yJvGzfTWyPOmlHYTEJo5TJUPWV04olAz8TdIWEY1Yhs=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=Vi0eSqgpZLYrDlAda/TQQ6ZE+WWWxRFWeMFzH+gSZOGyxrtI6hJGbpYuPCRu15il0
 pMJ9Pi9Jn7AdRxnY+U4FbwgWLgonqQmZRRXq1U4ubeadOyStih+8e5Ug79mglSj0a8
 b9GxOhX/Fn6iBsxhX30hitBfIckMSVMNVhvkCkDM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 18:21:52 +0500
Message-Id: <DGZZGGO06GZ5.3UDKO7EUE6XMP@yandex-team.com>
Cc: <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v3 0/4] Fix a few minor issues reported by Coverity
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Sergei Heifetz"
 <heifetz@yandex-team.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <20260208103958.121455-1-heifetz@yandex-team.com>
 <47a14220-139f-4be6-a19d-503924d5e90b@tls.msk.ru>
In-Reply-To: <47a14220-139f-4be6-a19d-503924d5e90b@tls.msk.ru>
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
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

On Wed Mar 11, 2026 at 3:47 PM +05, Michael Tokarev wrote:
> On 08.02.2026 13:39, Sergei Heifetz wrote:
>> Hi. This patch series fixes several minor issues reported by our local
>> Coverity installation.
>>=20
>> Changes in v3:
>> - Nothing. I sent the second version of the series without the correspon=
ding 'v2'
>>    suffix by mistake. I apologise.
>>=20
>> Changes in v2:
>> - Remove assert(block) in system/physmem.c instead of placing it
>>    before the dereference.
>>=20
>> Sergei Heifetz (4):
>>    migration/savevm.c: reorder usage and assertion of mis->from_src_file
>>    dump/dump.c: reorder usage and assertion of block
>>    system/physmem.c: remove useless assertion of block
>>    hw/usb/core.c: reorder usage and assertion of p->ep
>
> Hi!
>
> I applied 3 patches from this series - all but the physmem.c one.
> It's ugly either way, so I'm not picking it up.  Sigh.

I've just resubmitted the series with a change to the commit message of
the `physmem.c` patch. As pointed out by Peter Maydell, there is a good
reason to consider the assertion redundant.

> Sorry it took so long.

It's fine. Thank you.

