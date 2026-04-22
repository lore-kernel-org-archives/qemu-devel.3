Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A225F9B5E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSxT-0001vp-HN; Wed, 22 Apr 2026 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wFSxS-0001vh-LR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:29:18 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wFSxQ-0008IS-Ny
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:29:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C9A2E8075C;
 Wed, 22 Apr 2026 11:29:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:781::1:26] (unknown
 [2a02:6bf:8080:781::1:26])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BTOEwP0MweA0-pTyamGYv; Wed, 22 Apr 2026 11:29:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776846552;
 bh=O7NpyBa9rIKmtYYGmuzmbMDrq+AOQtVdeE/h+Hr5AO0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jFEvBgrOkVOZa10chmi0QS82Ao00hWMTGKfeR7tcP1w8ZcMb/fSg9Pk4Hx2cMKhQ6
 SDp4NAX2SivBPDk3rjBU44Xr5IuKmdPyALjBVHMXqz+5Eh83rAI+lF3TIKhmP8c3r3
 ILfKoVxc92RM7N8x6Lsk+OinDtcVDDD3h/9Gqg4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <13359e7d-be22-4165-acf2-67de2fa3e7fd@yandex-team.ru>
Date: Wed, 22 Apr 2026 11:29:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-6-peterx@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260421202110.306051-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21.04.26 23:20, Peter Xu wrote:
> These two APIs are a slight duplication.  For example, there're a few users
> that directly pass in the same function.
> 
> It might also be error prone to provide two hooks, so that it's easier to
> happen one module report different things via the two hooks.
> 
> In reality, they should always report the same thing, only about whether we
> should use a fast-path when the slow path might be too slow, as QEMU may
> query these information quite frequently during migration process.
> 
> Merge it into one API, provide a bool showing if the query is an exact
> query or not.  No functional change intended.
> 
> Export qemu_savevm_query_pending().  We should use the new API here
> provided when there're new users to do the query.  This will happen very
> soon.
> 
> Cc: Halil Pasic<pasic@linux.ibm.com>
> Cc: Christian Borntraeger<borntraeger@linux.ibm.com>
> Cc: Eric Farman<farman@linux.ibm.com>
> Cc: Matthew Rosato<mjrosato@linux.ibm.com>
> Cc: Richard Henderson<richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich<iii@linux.ibm.com>
> Cc: David Hildenbrand<david@kernel.org>
> Cc: Cornelia Huck<cohuck@redhat.com>
> Cc: Eric Blake<eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> Cc: John Snow<jsnow@redhat.com>
> Reviewed-by: Jason J. Herne<jjherne@linux.ibm.com>
> Reviewed-by: Juraj Marcin<jmarcin@redhat.com>
> Reviewed-by: Avihai Horon<avihaih@nvidia.com>
> Signed-off-by: Peter Xu<peterx@redhat.com>


Probably too late after all these r-b-s, but it would be simpler to review,
if renaming and reworking the documentation of the fields, moving them
to a separate structure, and combining two handler functions into one
would all be different patches.

-- 
Best regards,
Vladimir

