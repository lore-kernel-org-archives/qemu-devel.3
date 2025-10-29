Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1F9CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2Py-00073W-7c; Wed, 29 Oct 2025 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vE2Pu-00073G-Q4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:24:32 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vE2Pq-0005wW-C4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:24:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B0576C0198;
 Wed, 29 Oct 2025 12:24:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:57b::1:4] (unknown [2a02:6bf:8080:57b::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JOaq210FCeA0-3lOKPLfJ; Wed, 29 Oct 2025 12:24:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761729860;
 bh=sYmWLr+DRm36SqehwEMpCa0Jb0AeJxJ+RDOkMtEtoeE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0fk5ZyiH0TUoIu67Gw8lQtqP6AfLPulXhZOT8+CWM+lXwVELd+8fYRYNoYbsHeUcQ
 KMvTc0sE2NunQfwDMa/t2zLL6RH4vtoaF6rs1nx8PPI5VFlgyWPNhpidQugwikwSxu
 yx+WbiJebf6ExTq5vdJiyJlXP3SE8iAKRPvHmnGI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ccda71ab-8070-4068-a774-d32fa0057eec@yandex-team.ru>
Date: Wed, 29 Oct 2025 12:24:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between
 sentences
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
 <87sef2qdm4.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87sef2qdm4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 29.10.25 12:08, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Hi all!
>>
>> Let's bring the documentation in line with the requirements. And
>> do check these requirements in QAPI parser.
> 
> Prior art:
> 
>      01bed0ff14 qapi: Refill doc comments to conform to conventions
>      7270819384 qga/qapi-schema: Refill doc comments to conform to current conventions
>      209e64d9ed qapi: Refill doc comments to conform to current conventions
> 
> These only touched prose.
> 
> Your series also touches examples, is split per source file, and adds
> code to enforce the rules automatically.
> 
> Automatic enforcement makes a ton of sense.  Should've tried to code it
> up long ago.  Much appreciated!  However, it's in the first patch.  It
> needs to go last to not break bisection.
> 
> I don't think splitting per source file is necessary.
> 
> I'd prefer to put aside examples for now and focus on prose, since the
> case for prose is much stronger.
> 
> Since I already split off the prose changes for my own review purposes,
> there's no need for you to do that again.  I'll take care of it.
> 
> However, we need to adjust the enforcement code to skip examples.
> 
> Examples are marked up with ReST directive qmp-example.  They look like
> this:
> 
>      # .. qmp-example::
>      #
>      #     the example
>      #         text is
>      #     indented
> 
> The stupidest solution that could possibly work is to start skipping the
> checks at
> 
>      # .. qmp-example::
> 
> and resume it at the first unindented line.
> 
> This is of course a hack: it second-guesses the ReST parser.  I think
> it's good enough.
> 
> If we in a later step decide reflowing the examples is usful, the hack
> goes away.
> 
> Would you be willing to take care of that part?
> 

Of course. Will you send a detached prose changes, so I can base changed
patch 01 on top of it?

-- 
Best regards,
Vladimir

