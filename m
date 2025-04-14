Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB7C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 07:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4E83-0003IX-VY; Mon, 14 Apr 2025 03:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4E7y-0003Hn-7k; Mon, 14 Apr 2025 03:21:12 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4E7s-0000ql-Oq; Mon, 14 Apr 2025 03:21:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 58CDC60A77;
 Mon, 14 Apr 2025 10:20:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4ae::1:27] (unknown
 [2a02:6b8:b081:b4ae::1:27])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uKA8g36FYqM0-0RPFbvn6; Mon, 14 Apr 2025 10:20:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744615256;
 bh=L3XwvKo1oF/uEzjL7KIQJhvyJm6RW2nNUnZYPv0P2Vc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zyJX3lkeUZJaCKt/1fskA+77QlTet619wQu+o9a/nyDju53oSAl4Ozwhg8R93dUzh
 FM67lsjvLumxQMPuVy1/N1cFWI+rSBG02CALrTCgMM/yVqeABAOAFRmeI2MjJJVX7X
 fn2DwKK9ULGpPg11/C7pNHoyrEHp3wA+3QGR/3gI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a5eed68b-a9fa-45c0-a17e-276fee240840@yandex-team.ru>
Date: Mon, 14 Apr 2025 10:20:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] deprecate some block-job- APIs
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com
References: <20250409084232.28201-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250409084232.28201-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 09.04.25 11:42, Vladimir Sementsov-Ogievskiy wrote:
> This is for 10.1, of course.
> 
> v3: fix wording, typos
> v2: Update documentation: add patch 01
> 
> v1 was:
> [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
> Supersedes: <20250401155730.103718-1-vsementsov@yandex-team.ru>
> 
> Vladimir Sementsov-Ogievskiy (2):
>    qapi: synchronize jobs and block-jobs documentation
>    qapi/block-core: deprecate some block-job- APIs
> 
>   docs/about/deprecated.rst | 31 +++++++++++++
>   qapi/block-core.json      | 91 ++++++++++++++++++++++++++++-----------
>   qapi/job.json             | 30 ++++++++++++-
>   3 files changed, 125 insertions(+), 27 deletions(-)
> 

Thanks for review, applied to my block branch.

-- 
Best regards,
Vladimir


