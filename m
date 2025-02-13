Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F22C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 09:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiVTi-0005Mg-99; Thu, 13 Feb 2025 04:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tiVTf-0005MN-Cv; Thu, 13 Feb 2025 04:25:47 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tiVTc-0008NH-Q9; Thu, 13 Feb 2025 04:25:46 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2a9d:0:640:c19b:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2D77560C4C;
 Thu, 13 Feb 2025 12:25:38 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b51c::1:4] (unknown
 [2a02:6b8:b081:b51c::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aPMhFe0IjKo0-389kSS4d; Thu, 13 Feb 2025 12:25:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739438737;
 bh=gJAmvln6RlDZ88eL+BJJrOR7dyebgvY7qB8/yi0mITc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eJ/ZMNlh+w3J68+X6pVAFq6fgTZ4za91Nz8WZkNh0u5wkLk6KhybK+M0JKnD0Sz4l
 pyCsPuddpSvVfphieD/YIlrhYWQak1WYKLe2P6eM680DG9iiS2lXH/fr0cTPQ4T1e8
 CjeKB+cnJZ+h0I5v7Rq0kxy20J+So15+pl5487SU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cbf6f305-38f4-402b-ad4c-0d86998eeba1@yandex-team.ru>
Date: Thu, 13 Feb 2025 12:25:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: merge common parts of NbdServerOptions and
 nbd-server-start data
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com
References: <20250212143351.274931-1-vsementsov@yandex-team.ru>
 <ky3eygomndpcfsxvcwt3aqdnyqmkerzx6zzmusj432gpof4gge@tsxlpcqazel4>
 <875xlel06l.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <875xlel06l.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13.02.25 11:26, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On Wed, Feb 12, 2025 at 05:33:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Instead of comment
>>> "Keep this type consistent with the nbd-server-start arguments", we
>>> can simply merge these things.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>
>>> No problem for me to rebase on top of
>>> [PATCH 0/2] nbd: Allow debugging tuning of handshake limit
>>> if it goes earlier.
>>
>> I just sent the pull request for that, so this will indeed need
>> rebasing.  But it's still worth reviewing as written.
>>
>>>
>>> Also, not that order of nbd-server-start is changed. I think the order
> 
> s/not/note/, I presume.
> 
>>> could not be a contract of JSON interface.
>>
>> Correct - QMP does not mandate wire ordering, so although the change
>> causes C paramter rearrangement, it is not a breaking change.
> 
> Correct.
> 
>>> We could instead of making common base structure go another way
>>> and define two structures with same data=NbdServerOptionsCommon, and
>>> different bases (will have to define additional base strucutres with
>>> SocketAddress and SocketAddressLegacy fields). But it would look a bit
>>> unusual in QAPI.
>>>
>>>   blockdev-nbd.c         |  4 +--
>>>   qapi/block-export.json | 57 ++++++++++++++++++++----------------------
>>>   2 files changed, 29 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>>> index 9e61fbaf2b..b0b8993a1b 100644
>>> --- a/blockdev-nbd.c
>>> +++ b/blockdev-nbd.c
>>> @@ -215,10 +215,10 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
>>>                        arg->max_connections, errp);
>>>   }
>>>   
>>> -void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>> -                          const char *tls_creds,
>>> +void qmp_nbd_server_start(const char *tls_creds,
>>>                             const char *tls_authz,
>>>                             bool has_max_connections, uint32_t max_connections,
>>> +                          SocketAddressLegacy *addr,
>>>                             Error **errp)
>>>   {
>>>       SocketAddress *addr_flat = socket_address_flatten(addr);
>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>> index 117b05d13c..5eb94213db 100644
>>> --- a/qapi/block-export.json
>>> +++ b/qapi/block-export.json
>>> @@ -9,13 +9,7 @@
>>>   { 'include': 'block-core.json' }
>>>   
>>>   ##
>>> -# @NbdServerOptions:
>>> -#
>>> -# Keep this type consistent with the nbd-server-start arguments.  The
>>> -# only intended difference is using SocketAddress instead of
>>> -# SocketAddressLegacy.
>>> -#
>>> -# @addr: Address on which to listen.
>>> +# @NbdServerOptionsBase:
>>>   #
>>>   # @tls-creds: ID of the TLS credentials object (since 2.6).
>>>   #
>>> @@ -30,14 +24,35 @@
>>>   #     server from advertising multiple client support (since 5.2;
>>>   #     default: 100)
>>>   #
>>> -# Since: 4.2
>>> +# Since: 10.0
>>
>> Markus, when refactoring types like this, should Since stay at the
>> point in time where the fields were first introduced (4.2) or at the
>> time where the refactoring introduced the new type (10.0)?  Or does
>> type inlining make it all moot if this tag never shows up in the docs?
> 
> To answer this, we need to consider what doc comments are for:
> documenting our external QMP interface for its users.
> 
> Types are not part of this QMP interface, only their members can be,
> namely as arguments of commands and events, possibly nested into other
> arguments.  Types can change in ways that do not affect the interface.
> Like in this patch.
> 
> Since only members are part of the interface, only members need since
> information.
> 
> Having to write down since information member by member all the time
> would be onerous, so we provide a shorthand: write it down for the type,
> and any members without explicit since use that.

Happily in our case all shared members has explicit "since" equal in both copies pre-patch. So it doesn't really matter which "Since:" we use for the whole shared structure (I propose 10.0, to stress when it actually introduced).

"addr" field doesn't have explicit "since", so we'd better keep 1.3 for command and 4.2 for structure. I can denote it in "Since: " of corresponding small structures.

> 
> This leads us to the answer to your question.  When you refactor types,
> take care to preserve the interface documentation's since information,
> just like you preserve the actual interface.
> 
> Much of the time, this is as trivial as "don't mess with since".
> 
> Sometimes, it involves things like adding a new type with an old since.
> 
> Occasionally, there's a conflict.  Say you unify two similar types into
> one, a perfectly sane refactoring.  But the two types can have
> conflicting since information.  Perhaps one type's member @foo goes back
> to 4.2, and the other's goes back only to 9.1.  We don't have good
> solutions for that.  We do our best in prose.
> 
> Maintaining accurate since information is bothersome and error prone.
> It should be done by the machine, not us.  John and I have pondered ways
> to do this, but we have other projects to finish first.
> 
> Questions?
> 
> [...]
> 

-- 
Best regards,
Vladimir


