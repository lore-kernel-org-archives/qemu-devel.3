Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E706E7C708
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLxO-0005of-8c; Mon, 09 Feb 2026 02:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLxK-0005mF-7Y
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:45:15 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLxH-0006WV-Kk
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:45:13 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6A7D980872;
 Mon, 09 Feb 2026 10:45:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:129::1:13] (unknown
 [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6jLSWF2A3Cg0-4oapOkIZ; Mon, 09 Feb 2026 10:45:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770623107;
 bh=uaVFxo1FlIWtzE4jVRtqr8NGEVheeypsQc77dWPLK+4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=l62axht8WmKYsSwXl1z7hyX1JmrfJbMTmu6dfr6IkU0kfdD7K1vYqYoS3086Js2pS
 6r4Fryet+25rSO0fQXlWRfwdKdl8T2s+C97TCXbodfc91Oemu16aoVPG8z42ZST0zh
 zcGludJuOVIOrw2lpKI2jhvuFBp/1+eCqvENzMLI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2190acba-8aa2-47b1-975e-39e5bac313db@yandex-team.ru>
Date: Mon, 9 Feb 2026 10:45:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] vhost-user: VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 09.02.26 10:38, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a new feature to pass GPA addresses instead of UVA
> to vhost-user server from QEMU. The details are in last patch
> 10/10 the others are preparation and refactoring.
> 
> The series replaces my first attempt
>     "[PATCH] vhost-user: pass GPA instead of UVA"
> Supersedes:<20260204092339.211650-1-vsementsov@yandex-team.ru>

Forget to mention:

Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
   "[PATCH v5 00/23] vhost refactoring and fixes"

-- 
Best regards,
Vladimir

