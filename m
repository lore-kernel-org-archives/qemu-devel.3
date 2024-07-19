Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF60C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUj1W-00078D-14; Fri, 19 Jul 2024 04:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUj1P-00076c-A6; Fri, 19 Jul 2024 04:31:27 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUj1J-0003Ud-Ud; Fri, 19 Jul 2024 04:31:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:958d:0:640:7be4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CF8BC608DC;
 Fri, 19 Jul 2024 11:31:09 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b721::1:1f] (unknown
 [2a02:6b8:b081:b721::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7VF2KE0IcuQ0-ftV95JLa; Fri, 19 Jul 2024 11:31:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1721377869;
 bh=RUfSZxe2ohkx1mkMk91w8uYXc8eudmhBN8xnIvgmLSE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OGLRkcR0E2IIXlfJ+SizmWZuxa0JUBHENYcDwItTl9gyb6ZhgkN0Xb9+inwU4PgjJ
 aH0fc0eh+tm+ZfbBYFVGK/vY5ST3+2k3/L4ZfKk0RzjJhiaYluBa3Qr4yvTEUf3DPs
 dkfc0miLvvOraeAoLqxbnaNB74Qv95MEq9ExkIlk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <91cda3d7-0d25-44de-be1c-ddcc7d93d2b7@yandex-team.ru>
Date: Fri, 19 Jul 2024 11:31:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] qapi: introduce device-sync-config
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 qemu-devel@nongnu.org, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, yc-core@yandex-team.ru
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <20240625121843.120035-4-vsementsov@yandex-team.ru>
 <87cynbm7fj.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87cynbm7fj.fsf@pond.sub.org>
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

On 18.07.24 11:27, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add command to sync config from vhost-user backend to the device. It
>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>> triggered interrupt to the guest or just not available (not supported
>> by vhost-user server).
>>
>> Command result is racy if allow it during migration. Let's allow the
>> sync only in RUNNING state.
> 
> Is this still accurate?  The runstate_is_running() check is gone in
> v4, the migration_is_running() check remains.

Right, better to fix commit message like:

Command result is racy if allow it during migration. Let's not allow it.

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> QAPI schema and QMP part:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 

-- 
Best regards,
Vladimir


