Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2534F55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSrl-00071J-8a; Wed, 22 Apr 2026 04:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wFSrd-0006y9-ED
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:23:19 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wFSrb-0006ha-BZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:23:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B8A9880725;
 Wed, 22 Apr 2026 11:23:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:781::1:26] (unknown
 [2a02:6bf:8080:781::1:26])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 9NO2XU0K4mI0-JZyi2uq0; Wed, 22 Apr 2026 11:23:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776846191;
 bh=9GOYWkfRc8gg1pfZE5ruWPzgPv/ur9PEnr4cXLuVd7U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VXC+c4/HG4li6sSbt1QAaHvyhclLm+8qTHIV27z8bu3gEiJQONJ0czhZy1j9BxyHb
 FCZb/t9X84PA/tT0VX9nC32WPZ+Lw3CxFBEI+cG+Qasl0vRlnFlYPkRmTjJMNUzAO4
 mSVh0gcE5/zmrnf65PBJO1RgPh5uRJ31O4cW5CNg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9ca99d28-d36b-4b01-98f7-f79b8db0485f@yandex-team.ru>
Date: Wed, 22 Apr 2026 11:23:09 +0300
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
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)

Shouldn't we save this bit of information as part of MigPendingData documentation?


Currently it seems incomplete, and it uses "can" in a bit different meanings:

+typedef struct MigPendingData {
+    /* Amount of pending bytes can be transferred in precopy or stopcopy */

this "can" is restrictive: these bytes can be transferred ONLY in precopy or stopcopy

+    uint64_t precopy_bytes;
+    /* Amount of pending bytes can be transferred in postcopy */

this "can" _looks_ like permissive, it seems obvious that we should be able to transfer
these bytes in precopy as well. And that's true for RAM but wrong for block dirty bitmaps.

+    uint64_t postcopy_bytes;
+} MigPendingData;
+

-- 
Best regards,
Vladimir

