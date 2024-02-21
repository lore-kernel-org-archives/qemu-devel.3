Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A469DC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcocv-0007y1-H1; Wed, 21 Feb 2024 10:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1rcoaG-00077j-5x
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:32:32 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1rcmmG-00010M-Ji
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:36:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 93B9B60BC3;
 Wed, 21 Feb 2024 16:36:39 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8113::1:1c] (unknown
 [2a02:6b8:b081:8113::1:1c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aaSav20iB4Y0-SNPsgyOg; Wed, 21 Feb 2024 16:36:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1708522598;
 bh=uKgDMQw1Rf7Un0gEEOS0l9WOjKuJSyFOjqqLOXiDoIY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=e2OJ0h4aMdaOw+1P58ly2Jed1iVC5LkLlt5qeYm3+fChsORpXb+CGw9k0akrFGy03
 oFzNoGtz399Ry2UacWxNUnVR4YhlqDhFI0UwN1sFa35St8M0vdhnBBTo+9MUjxVcsK
 uFqqz9FyN+U0Qg7Sn2hBFHw6SmSfcOYGxBCb0p9Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f5435d60-8941-4ad7-b851-c7f320d6522f@yandex-team.ru>
Date: Wed, 21 Feb 2024 18:36:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, yc-core@yandex-team.ru
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru>
 <87il2p0w78.fsf@pond.sub.org>
 <d1f73aaa-f5cb-4366-a567-fad7d965b76e@yandex-team.ru>
 <87le7hrmf0.fsf@pond.sub.org>
From: Roman Khapov <rkhapov@yandex-team.ru>
In-Reply-To: <87le7hrmf0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=rkhapov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The reason in MIGRATION event can be used, when there is some helpful 
message, that can be added to improve debugging\understanding of the 
reason of migration status changing.

I propose the next usage - when qemu sends (MIGRATION status=failed) 
event, the error message describing the problem can be sent in that 
event too. This is more comfortable way to understand the problem 
comparing to reading qemu logs, especially in some cases, where qemu are 
launched and monitored through various automation processes (examples: 
cloud environments, some 'integration' tests of the qemu, etc). 
Probably, there are some other cases when the accompanying message can 
be useful, not only in failed migrations, but now I don't know that cases.

If we have common understanding with that, I will improve the doc 
comment and the commit message of the first path too in the next version 
of the series.

On 2/19/24 11:35, Markus Armbruster wrote:
> Roman Khapov <rkhapov@yandex-team.ru> writes:
>
>> To be clear: you meant that the description of the event must be extended, similar to its description on the commit message? Or you don't see its proper usage at all?
> The commit message doesn't really tell me either why and how anybody
> would use @reason.  Once we have a common understanding there, improving
> the doc comment should be straightforward.

-- 
Best regards,
Roman Khapov


