Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9D3CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEleX-0006FN-Dq; Fri, 31 Oct 2025 05:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEleV-0006F9-2y
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:42:35 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEleP-00065h-VG
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:42:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 31279808A1;
 Fri, 31 Oct 2025 12:42:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IgcjDV0FuW20-fcfwmuw9; Fri, 31 Oct 2025 12:42:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761903738;
 bh=bbneMQ3Ec4yCq67o7Tpt8+CymHMsJV/AXXyZVcTe2pw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rk7HN+ccF1s7mpFDZUQlR1d9nLFzI2yZnPmUte5tbmHUhIT3HFKEGnI36uqg4d8Up
 YVIOiXpAL2q32GTnJ86eyKugW860mxfhSmX1uDcljQ/hGOY7G57bDdffd2lA0M8VPO
 XzzLagJkHvaPmeWQq/QGerArH0CbQ5GkRQxW7QPQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7b03b9a4-d9f0-448b-a55f-b42d8fb0099a@yandex-team.ru>
Date: Fri, 31 Oct 2025 12:42:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qapi: Add documentation format validation
To: Markus Armbruster <armbru@redhat.com>
Cc: michael.roth@amd.com, qemu-devel@nongnu.org
References: <20251029173059.378607-1-vsementsov@yandex-team.ru>
 <87ms58fpyn.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ms58fpyn.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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

On 30.10.25 17:01, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add explicit validation for QAPI documentation formatting rules:
>>
>> 1. Lines must not exceed 70 columns in width (including '# ' prefix)
>> 2. Sentences must be separated by two spaces
>>
>> Example sections are excluded, we don't require them to be <= 70,
>> that would be too restrictive.
>>
>> Example sections share common 80-columns recommendations (not
>> requirements).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> This substitutes my previous attempt
>>    "[PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences"
>> Supersedes: <20251011140441.297246-1-vsementsov@yandex-team.ru>
>>
>> v3:
>> 01: ignore example sections
>> other commits: dropped :)
>>
>> Of course, this _does not_ build on top of current master. v3 is
>> to be based on top of coming soon doc-cleanup series by Markus.
> 
> I'll post this today.
> 
>>   scripts/qapi/parser.py | 46 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 9fbf80a541..b9d76fff39 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py

[..]

> 
>          single_space_pattern = r'(\be\.g\.|^ *\d\.|([.!?])) [A-Z0-9(]'
>          for m in list(re.finditer(single_space_pattern, line)):
>              if not m.group(2):
>                  continue
> 
> This uses a common regexp trick: match exception | ... | (wanted), then
> check whether the group containing wanted matched.

Cool, I didn't know this!

> 
>> +            raise QAPIParseError(
>> +                 self, f"documentation has single space after sentence "
>> +                 f"ending. Use two spaces between sentences: "
>> +                 f"...{line[m.start()-5:m.end()+5]}..."
> 

[..]

> 
> I can offer a disgusting hack:
> 
>              # HACK so the error message points to the the offending spot
>              self.pos = self.line_pos + 2 + m.start(2) + 1
>              raise QAPIParseError(
>                   self, "Use two spaces between sentences")
> 
> This results in
> 
>      ../qapi/block-core.json:162:47: Use two spaces between sentences
> 
> Emacs then takes me right to the offending single space.
> 

Great!

>> +            )
>>   
>>       @staticmethod
>>       def _match_at_name_colon(string: str) -> Optional[Match[str]]:
> 

Thanks for careful review, will resend soon.

-- 
Best regards,
Vladimir

