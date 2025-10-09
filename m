Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BD4CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lqs-0004FR-ME; Thu, 09 Oct 2025 04:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6lqo-0004Ez-Up
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:18:15 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6lql-00080w-VG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:18:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 43439C0185;
 Thu, 09 Oct 2025 11:17:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vHFH3v0Fo8c0-dzRS1gbh; Thu, 09 Oct 2025 11:17:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759997878;
 bh=4uAlRvOYApJx+VYwYvrPbRmSGHKXnMw+h4KYzzb/qTA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KbvnSODF3/nu8q8RfeKjj/Zcw0KcED2/Czhi9/la2CQElobc6iRomlooXul67stBN
 xf/N7QAj28rviliuenpuPT1rSEZ4tFrLMysRAAjIYnUvHV6cgGVv+lq3a1XLh6XCBf
 LbVb0mHlJTIGdYS+MxBQdp1nOPmvsmAKY3tCpqfk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8fd866fe-4ea7-4e79-a6fc-44a25e5a18fc@yandex-team.ru>
Date: Thu, 9 Oct 2025 11:17:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250924133309.334631-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

ping)

On 24.09.25 16:33, Vladimir Sementsov-Ogievskiy wrote:
> They were deprecated in 9.2, now we can remove them.
> New options to use are reconnect-ms.
> 
> v2: fixup docs and error messages
> 
> Vladimir Sementsov-Ogievskiy (2):
>    chardev: remove deprecated 'reconnect' option
>    net/stream: remove deprecated 'reconnect' option
> 
>   chardev/char-socket.c           | 24 +++++-------------------
>   chardev/char.c                  |  3 ---
>   docs/about/deprecated.rst       | 15 ---------------
>   docs/about/removed-features.rst | 22 ++++++++++++++++++++++
>   net/stream.c                    | 20 +++++---------------
>   qapi/char.json                  | 14 +-------------
>   qapi/net.json                   | 13 +------------
>   7 files changed, 34 insertions(+), 77 deletions(-)
> 


-- 
Best regards,
Vladimir

