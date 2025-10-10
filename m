Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34366CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7BuA-0005Dv-4c; Fri, 10 Oct 2025 08:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7Bu6-0005D3-Ja; Fri, 10 Oct 2025 08:07:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7Btw-0001pB-G3; Fri, 10 Oct 2025 08:07:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 58AC4C03A5;
 Fri, 10 Oct 2025 15:06:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a89::1:23] (unknown
 [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id u6KV0F1FFCg0-ll45ekq1; Fri, 10 Oct 2025 15:06:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760098017;
 bh=9ldIcSoY9+ex8JcrVOHWBbM0sJvIVrTUp3aRKgasrTI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eDX5ewYxFxKU03bwPRQXCrmrIaNs3vbbZpBOyN6G0yGot9dLY0bO17mw6AMMHXX4G
 ktRY2DexCvYnwsteeVW+Qg27CQzbu+kyfm3/tvyccgiPMcVO0qatauhygvmjjwWb/u
 Ao7JLLBD5aBFtX6qOJLgOZzI8QWnm4GpKWGKzHEI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6a349ee6-aa94-4417-bbfb-885ece1ed73c@yandex-team.ru>
Date: Fri, 10 Oct 2025 15:06:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 eblake@redhat.com, jasowang@redhat.com, devel@lists.libvirt.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-trivial@nongnu.org
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
 <877bx4p3at.fsf@pond.sub.org>
 <5063033a-9d83-49da-9f15-cc492d124a68@tls.msk.ru>
 <7503ba0e-2596-4919-b4ea-bc61e469564a@yandex-team.ru>
 <87ms5zj8xy.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ms5zj8xy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10.10.25 14:24, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 10.10.25 10:52, Michael Tokarev wrote:
>>> On 10/9/25 17:17, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> They were deprecated in 9.2, now we can remove them.
>>>>> New options to use are reconnect-ms.
>>> Speaking of the option itself.. I'd not remove it, instead,
>>> I'd de-deprecate it, and allow units to be specified for it,
>>> like reconnect=10ms (defaults to s).  Or reconnect=0.1 (in
>>> fractions of second).  But it's just me, it looks like :)
>>
>> QAPI is not for humans) So simple milliseconds integer is better,
>> then parse the variety of suffixes. And it better fit into json
>> (number is number, not a string)
>>
>>> Also, `has_reconnect_ms` becomes redundant after applying this
>>> patch, - it should be enough to use just reconnect_ms, which
>>> defaults to 0.  But this can be done in a subsequent cleanup.
>>>
>>
>> You mean just use sock->reconnect_ms instead of explicit
>>
>>     int64_t reconnect_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;
>>
>> ?
> 
> We routinely exploit that QAPI initializes absent members to zero.

What I'm afraid of: generated code is not the only source of QAPI structures,
sometimes they are initialized by hand. And looking at code like

    bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;

I can't say, does the structure comes from generated code and this check
is redundant, or the structure may come from other place, and we chose
be explicitly safe here..


> 
>> I believe that QMP will zero-initialize everything. But I'm not sure
>> that we do zero initialize this structure on all paths.. Keeping also in mind
>> handling other fields here like
>>
>>      bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
>>      bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
>>      bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
>>      bool is_websock     = sock->has_websocket ? sock->websocket : false;
>>
>> To drop this, we should check for all paths, that incoming structure is
>> zero-initialized. And no guarantee that it does not break in future.
>>
>> Probably, we can implement a new QAPI feature "value with default to zero",
>> so that we can avoid existence of .has_foo field at all for such fields.
>> No field - no problem.. But not in this series)
> 
> The simple way to do "optional" is to have the machinery supply a
> default value.
> 
> The less simple way is to add a distinct extra value that means
> "absent".  This permits "absent" to means something else than any value.
> 
> QAPI does the latter.  Not my choice; I inherited it :)
> 
> For pointers, generated C uses null as distinct extra value.  Works,
> because "present" implies non-null.
> 
> For other types, generated C uses a pair of variables (has_FOO, FOO),
> where
> 
>      (true, V)           means present with value V
>      (false, zero)       means absent
>      (false, non-zero)   is invalid

Existing of invalid combinations is always a headache

> 
> This results in slightly more complicated code.
> 
> Most of the time, code maps "absent" to a default value.  This default
> value is not visible in the schema, it's buried in the C code.  When a
> type gets used in multiple places, each place can pick its own default.
> Bothersome to document, and the system cannot ensure the code matches
> its documentation.  Strong dislike.
> 
> Special case: when the default value is zero, we can ignore has_FOO and
> just use FOO.  See "routinely exploit" above.
> 
> We could extend the QAPI schema language to let us specify the default
> value.  The generator could then elide has_FOO.  Code would become
> simpler.
> 

Yes, I meant something like this. May be in some future day... Some AI agent
will come with patches, after reading our discussion)

-- 
Best regards,
Vladimir

