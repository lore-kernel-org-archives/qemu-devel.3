Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3639606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqM2-0007dn-MN; Tue, 24 Nov 2026 08:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVqLz-0007cG-JN
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:14:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVqLx-0008JI-2n
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:14:35 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA33160EB44;
 Tue, 24 Nov 2026 14:14:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id kHXg7Heg52xo; Tue, 24 Nov 2026 14:14:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C732060F754; Tue, 24 Nov 2026 14:14:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C43A013C290;
 Tue, 24 Nov 2026 14:14:15 +0100 (CET)
Date: Tue, 24 Nov 2026 14:14:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <CAFEAcA9uvfiwB5TFEbq9ROMumpB+dsta8RNYbqCnkMrDUmj7Tg@mail.gmail.com>
Message-ID: <af1b85cd-1f17-0a60-d07e-c6b419e1a913@eik.bme.hu>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
 <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
 <87y0ajuw9j.fsf@draig.linaro.org>
 <CABgObfbb-+zmxeV5rjLM=7cXAZUqpGr84kBPTfnysiLc+crL-w@mail.gmail.com>
 <CAFEAcA9uvfiwB5TFEbq9ROMumpB+dsta8RNYbqCnkMrDUmj7Tg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-844927789-1795526055=:70435"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-844927789-1795526055=:70435
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 24 Nov 2026, Peter Maydell wrote:
> On Mon, 23 Nov 2026 at 21:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Il lun 23 nov 2026, 21:29 Alex Bennée <alex.bennee@linaro.org> ha scritto:
>>>
>>>> On the other hand: people are already reviewing *clearly* LLM-produced
>>>> patch series (example
>>>> https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNUGU55pcQphR5s81aQ@mail.gmail.com/T/).
>>>
>>> clearly? My reading is the cover letter is thorough but its not giving
>>> off LLM vibes to me. I've only eyeballed the patches themselves but they
>>> seem thought out and split into nicely re-viewable chunks. If it is AI
>>> it certainly seems to be in the hands of someone who knows what they are
>>> doing.
>>
>>
>> Sure, no doubt Denis knows what he's doing. But the commit messages are certainly AI (I have just checked the cover letter and three patches with pangram, including one that didn't give me immediate pause), and there are certain aspects of overengineering that give me serious doubts about the code.
>>
>> In that respect a clear policy would remove all of the pressure to wait and possibly ask later for forgiveness, and would let us provide clear agent instructions without being hypocritical.
>
> Though this new policy even with patch 4 still says that cover
> letters and commit messages should be written by humans, so
> that series would not be in policy under the proposed new rules
> either.

That was an attempt to force people to read the patch before submission 
and try to understand it (or at least follow what their AI does and have 
an idea of what they are doing). Of course those who don't want to or 
can't do that won't comply and may still submit generated patches but if 
it's at least flagged with AI-used-for, that's better than trying to 
review a generated patch and then the submitter won't reply or read the 
review or may send back a generated reply at best. At least with the tag I 
know what to expect and people will know what we expect from them. We 
can't do much about those who would still disregard what we ask from them.

The problem we have I think is that now people have several forks of QEMU 
that they are patching with AI (I know about at least 3 just in the small 
area I'm interested in so it's likely much more for other areas) and some 
of those fix actual problems and could further the project but with a no 
AI at all policy they can't contribute, even if they wanted to so we lose 
all those improvements or have to redo them ourselves. These people may 
not want to do everything themselves without an AI but if there was a way 
to upstream patches maybe they could help. But we want to filter the vibe 
coders with no idea at all and ask for people to test and review the 
generated patches before sending and if they can't understand what it does 
maybe they should first use the AI to teach them before sending patches. 
The part in the policy that says the sumbitter should (be able to) write 
the commit message and cover letter and answer review themselves is a 
measure of that but there are always people who'd disregard these. If 
there aren't that many such people and most folow the rules we're in a 
better position than now where we still get generated patches but they 
aren't even flagged as such or lose a lot of valuable contribution even 
from people who use an AI for what they could do themselves and checked 
the result.

Regards,
BALATON Zoltan
--3866299591-844927789-1795526055=:70435--

