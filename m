Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3353CC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7i7-0004cA-JL; Fri, 15 Mar 2024 09:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rl7hx-0004aq-Mm; Fri, 15 Mar 2024 09:34:49 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rl7ht-0005Nx-V6; Fri, 15 Mar 2024 09:34:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6141161288;
 Fri, 15 Mar 2024 16:34:38 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b70d::1:34] (unknown
 [2a02:6b8:b081:b70d::1:34])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aYpbLX6OhqM0-0fuI4SDg; Fri, 15 Mar 2024 16:34:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710509677;
 bh=9iimvppycDVq4wRWCEja0AOef3bzQF4UXQEprvJqvww=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HuxOUICS0w5zMHMlTin8AmL/71jG26UjhEJ0bmaZNj7bDF7YH9oWw/QYfpCPHPkwn
 goERQy27Sf4m2f6e15ULfkgpND4WVPvsvmdcZDNW39PbvuOz3iWlUXcLF5oBa44Xhg
 VJTGD5296lOz/jAe9MtKUvW+vCWgJGq/QIZpEt28=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <01bbb149-6338-4a67-9ff5-5965112ed66e@yandex-team.ru>
Date: Fri, 15 Mar 2024 16:34:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] qdev-monitor: add option to report GenericError
 from find_device_state
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 eblake@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-4-vsementsov@yandex-team.ru>
 <87sf12cr1z.fsf@pond.sub.org>
 <063ad24f-714d-48df-a092-75e9fc693082@yandex-team.ru>
 <87jzm3fyja.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87jzm3fyja.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15.03.24 15:51, Markus Armbruster wrote:
> Sorry for the late answer.
> 
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 07.03.24 12:46, Markus Armbruster wrote:
> 
> [...]
> 
>>> I appreciate the attempt to curb the spread of DeviceNotFound errors.
>>> Two issues:
>>>
>>> * Copy-pasting find_device_state() with a false argument is an easy
>>>    error to make.
>>>
>>> * Most uses of find_device_state() are via blk_by_qdev_id() and
>>>    qmp_get_blk().  Any new uses of qemu_get_blk() will still produce
>>>    DeviceNotFound.
>>>
>>> Hmm.
>>
>> Hmm. Right. Wait a bit, I can make the change stricter.
>>
>> Could you still explain (or give a link), why and when we decided to use only GenericError? I think, having different "error-codes" is a good thing, why we are trying to get rid of it?
> 
> We actually got rid of most of them years ago :)
> 
> But you deserve a more complete answer.
> 
> QMP initially specified the following error response[1]:
> 
>      2.4.2 error
>      -----------
>      
>      The error response is issued when the command execution could not be
>      completed because of an error condition.
>      
>      The format is:
>      
>      { "error": { "class": json-string, "data": json-value }, "id": json-value }
>      
>       Where,
>      
>      - The "class" member contains the error class name (eg. "ServiceUnavailable")
>      - The "data" member contains specific error data and is defined in a
>        per-command basis, it will be an empty json-object if the error has no data
>      - The "id" member contains the transaction identification associated with
>        the command execution (if issued by the Client)
> 
> Note the structure of @data depends on @class.  We documented a
> command's possible error classes (well, we tried), but never bothered to
> document the @data it comes with.
> 
> Documentation deficits aside, this is looks quite expressive.  There are
> issues, though:
> 
> 1. Formatting errors in human-readable form is bothersome, and creates a
>     tight coupling between QMP server and client.
> 
>     Consider:
> 
>      {"class": "DeviceNotFound", "data": {"device": "ide1-cd0"}}
> 
>     To format this in human-readable form, you need to know the error.
> 
>     The server does.  Fine print: it has a table mapping JSON templates
>     to human-readable error message templates.
> 
>     The client needs to duplicate this somehow.  If it receives an error
>     it doesn't know, all it can do is barf (possibly dressed up) JSON at
>     the human.  To avoid that, clients need to track the server closely:
>     tight coupling.
> 
> 2. Errors have notational overhead, which leads to bad errors.
> 
>     To create a new error, you have to edit two source files (not
>     counting clients).  Strong incentive to reuse existing errors.  Even
>     when they don't quite fit.  When a name provided by the user couldn't
>     be resolved, reusing DeviceNotFound is easier than creating a new
>     error that is more precise.
> 
> 3. The human-readable error message is hidden from the programmer's
>     view, which leads to bad error messages.
> 
>     At the point in the source where the error is created, we see
>     something like QERR_DEVICE_NOT_FOUND, name.  To see the
>     human-readable message, we have to look up macro
>     QERR_DEVICE_NOT_FOUND's error message template in the table, or
>     actually test (*gasp*) the error.  People generally do neither, and
>     bad error messages proliferate.
> 
> 4. Too little gain for the pain
> 
>     Clients rarely want to handle different errors differently.  More
>     often than not, all they do with @class and @data is log them.  Only
>     occasionally do they switch on @class, and basically never on @data.
> 
> It me took a considerable fight to get the protocol amended to include a
> human-readable message[2].  This addressed issue 1.
> 
> Over the next two years or so, issues 2. to 4. slowly sank in.  We
> eventually tired of the complexity, ripped out @data, and dumbed down
> all error classes to GenericError, except for the few clients actually
> cared for[3].  We also mandated that new errors avoid the QERR_ macros.
> 
> Eliminating the existing QERR_ macros has been slow.  We're down to 13
> in master, with patches deleting 7 on the list.
> 
> This has served us reasonably well.
> 
> Questions?
> 
> 
> [1] Commit f544d174dfc
>      QMP: Introduce specification
>      Dec 2009
> 
> [2] Commit 77e595e7c61q
>      QMP: add human-readable description to error response
>      Dec 2009
> 
> [3] Commit de253f14912
>      qmp: switch to the new error format on the wire
>      Aug 2012
> 

Thanks for full-picture story! Now I'm all for it.

-- 
Best regards,
Vladimir


