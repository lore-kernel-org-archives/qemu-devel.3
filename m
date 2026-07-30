Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40D8C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpM2l-0004XP-Nz; Thu, 30 Jul 2026 04:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpM2h-0004XC-GC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:23:03 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpM2g-00031s-2J
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:23:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id C5D5FC025D;
 Thu, 30 Jul 2026 11:23:00 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown
 [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 0NaEVnMWOa60-XsEc6m2u; Thu, 30 Jul 2026 11:23:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785399780;
 bh=/KKUiIcvwrpbeOaS2SLHjKrp8BBuYShSBRDyHDvmrt0=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=MhwVHi67mYcxdmGdU1Ktk8SCLjP1cy2VvVM7cC8uVAN+3tAPFvF1PRx1yywiEO0gs
 ++XUa6kUfMBegTZ6O9Qy4HwigePUbAwMcook36EcyY0nXuEOWN5Oe6lWAByNEmhZNJ
 itZRydTMZKAsk8busZgMkNE4nvUpzy+BFUDNbSv8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <56164547-64a0-491f-87e4-bef38a97b9e4@yandex-team.ru>
Date: Thu, 30 Jul 2026 11:23:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] migration: Remove redundant flags
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-4-farosas@suse.de>
 <7ceba470-8416-475b-beca-a6c82daa4b4b@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <7ceba470-8416-475b-beca-a6c82daa4b4b@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 30.07.26 11:11, Vladimir Sementsov-Ogievskiy wrote:
>> +
>> +impl VMStateOffset {
> 
> This looks like part of patch 01? And may be some other changes in rust.

02 I wanted to say

-- 
Best regards,
Vladimir

