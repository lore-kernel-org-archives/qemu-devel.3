Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB6BE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8UI-0004px-3n; Thu, 19 Feb 2026 13:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8UH-0004p9-5S
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:10:53 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8UE-0002hb-Ow
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:10:52 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C3D4380773;
 Thu, 19 Feb 2026 21:10:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:192::1:26] (unknown
 [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kAgkZW4A5W20-BtuRyf2i; Thu, 19 Feb 2026 21:10:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771524647;
 bh=YameO7jqv6BgNGynNqOvcEpyQIivrihWzC/mgkAjhtQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mcbkKonCL6ZccGi5XoRaB3lT1OFJbR2PD2LRRhmJDaqHgrfLGzAbz7juUjF9zgB8q
 pmRrzUFZFVKjcJuY/G7+B6E0k2Ha2LmijkIpiL2xX/tH4pv9IZm0TCcByT4OT0owU/
 OayFkDMRC/A/ToV70tfXyYB2o4f6Iox+qHhKl8Kg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6a72da59-7360-43ab-8044-57e9c1e3bb0c@yandex-team.ru>
Date: Thu, 19 Feb 2026 21:10:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] net: refactoring and fixes
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <6B3E0042-4C30-467E-87AB-613551599F0B@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <6B3E0042-4C30-467E-87AB-613551599F0B@akamai.com>
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

On 19.02.26 20:00, Chaney, Ben wrote:
>> Here are some refactoring and fixes, mostly in net/tap.c I'm making on
>> my way to implementing TAP fd migration (through UNIX domain socket).
>>
>>
>> v3:
>>
>>
>> 01: fix checking, switch to int type for queues
>> 08: drop MAX_TAP_QUEUES constant
>> 09,10: prefer int type for queues
> 
> Reviewed-by: Ben Chaney <bchaney@akamai.com>
> 

Thanks!!

-- 
Best regards,
Vladimir

