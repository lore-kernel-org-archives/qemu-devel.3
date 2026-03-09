Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811C8FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfhC-00070k-Sw; Mon, 09 Mar 2026 14:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzfgw-0006t3-Qf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:51:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzfgj-0006PI-RA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:50:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B486C5969EC;
 Mon, 09 Mar 2026 19:50:41 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wnZjWUh6-sEi; Mon,  9 Mar 2026 19:50:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8CB4E5969E7; Mon, 09 Mar 2026 19:50:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AECF5966F4;
 Mon, 09 Mar 2026 19:50:39 +0100 (CET)
Date: Mon, 9 Mar 2026 19:50:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
In-Reply-To: <cbc1b812-40f4-4b1e-b206-ed4962cb5dd9@linaro.org>
Message-ID: <c30ea720-5208-adea-c8a3-788c870fedee@eik.bme.hu>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
 <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
 <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
 <e5bef5ed-23e9-119d-3f63-a45343cc9c53@eik.bme.hu>
 <cbc1b812-40f4-4b1e-b206-ed4962cb5dd9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
> On 3/9/26 10:35 AM, BALATON Zoltan wrote:
>> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>>> On 3/9/26 9:38 AM, BALATON Zoltan wrote:
>>>> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>>>>> On 3/5/26 9:15 PM, Pierrick Bouvier wrote:
>>>>>> When using llvm-addr2line in replacement of addr2line, it will output
>>>>>> zero sized symbols, which can shadow other binaries depending on where
>>>>>> there location is (happens with arm-trusted-firmware and its different
>>>>>> binaries). Thus, those symbols.
>>>>>> 
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> ---
>>>>>>     contrib/plugins/uftrace_symbols.py | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>> 
>>>>> 
>>>>> This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).
>>>> 
>>>> I doubt the usefulness of such messages. People will know when pulling
>>>> from git and this list already has high enough volume. If you think this
>>>> is useful for contributors could you please send such mails off list only
>>>> to involved parties?
>>>
>>>  From what I understand, since you were not directly CC on this series, 
>>> your
>>> problem is not especially with the message in itself, but with the fact 
>>> that
>>> "this list already has high enough volume". I personally don't suffer from
>>> that, even though being CC on all patches touching docs/, because my email
>>> workflow allows me to follow threads I have specific interest with, and
>>> ignore the rest.
>>> 
>>> In general, a mailing list is not something you are supposed to read
>>> exhaustively. Instead, you're supposed to track your personal interests 
>>> out
>>> of it. For an analogy: When you go to your local supermarket, will you try 
>>> to
>>> follow every conversation happening there?
>>> 
>>> If you feel it's too much for you, then maybe there is something to look 
>>> into
>>> how you track the mailing list, and my advice would be to use a threaded
>>> view, with tags and mail filters to reduce the high volume you seem to
>>> receive on a daily basis. If you're interested, I can share my (simple)
>>> setup, and maybe you can get inspiration from it for your personal usage.
>> 
>> Threaded view does not help because the thread is already deleted when the
>> separate "this patch was merged with commit hash" message arrives so it
>> will show up at top level again. Ignoring everyting not cc'd to me would
>> make me miss useful info about where the project goes or being able to
>> review a few patches because I would not see them.
>> 
>
> So, that's the issue, deleting existing threads breaks the context indeed. 
> It's like working with git repositories at -depth 1 and trying to use 'git 
> log' on a specific file.
>
> Personally, I mark messages as read instead of deleting them and use "View -> 
> Threads -> Threads with Unread". It has the added benefit that you can search 
> efficiently through past conversations also.
>
> Every N months, you can run a manual "archive" command (i.e. move to another 
> INBOX subfolder) on messages older than N months and your qemu-devel INBOX 
> will keep a constant size.

Glad that it works for you but I have a limited mail quota so I have to 
delete read messages.

> If you email client gets in the way, switch to another one.

Please let me decide what I do.

>>> To be honest, I was thinking to organize a small BoF on next KVM Forum to
>>> allow people to share their personal tips with handling emails.
>>> It seems to be a common issue, and some maintainers even missed some 
>>> series
>>> they were supposed to review, or to pull them. For myself as well, it took
>>> quite some time before having a correct workflow. I even went through the
>>> idea of "reading everything" and quickly dropped it as it was unbearable.
>> 
>> This also suggests maybe there's too much traffic on the list so it would
>> be useful to think about how to reduce it. However maintainers are
>> supposed to be cc'd on series they should care about so they should not
>> miss them but maybe the problem here is more that there are a lot of areas
>> without maintainers listed or those in the MAINTAINERS file don't respond
>> even if cc'd. Just email workflow may not help with that.
>> 
>
> That's true, some series fall through the cracks. That's why I applied to 
> maintain docs/ to collect series/patches that might have been missed there. 
> If you care about some specific subsystems, I encourage you to apply for 
> becoming maintainer on the concerned top folder, so you can collect what is 
> not by other maintainers.

I'm already listed as maintainer of the machines I contributed and some 
other devices they use and were orphaned and I try to help reviewing and 
sharing ideas where I can. But I do this unpayed in free time so I would 
not take up more than I can do.

>>>> Getting messages about patches being queued is useful for other
>>>> maintainers and contributors to know the patches are picked up and then
>>>> they will also see the pull request on the list and when the pull request
>>>> got merged. Getting separate messages for each patch in a pull request
>>>> does not add more info to that for people already following the list.
>>>> 
>>> 
>>> Except that some maintainers, including me, don't cc original authors when
>>> sending a PR (that's a deliberate decision). As well, some top maintainers
>>> don't always send back a message once the PR is done. Or they don't 
>>> include
>>> all authors on individual patches.
>> 
>> I don't think that's a problem. If somebody is interested they could
>> follow the list or filter it e.g. for their S-o-b or simliar to get those
>> messages or pull requests even without being cc'd.
>> 
>
> In the case of TCG plugins, a lot of contributors are new comers and are not 
> used to all this. I personally don't want to put the pressure on them to 
> configure this kind of complicated setup, but prefer to offer them a 
> GitHub/GitLab like experience. The series is a PR/MR, and when it's merged, 
> the forge notify them it is.
>
> Sending email patches is already a pain in itself for newcomers, no need to 
> ask them to configure email filters on top of that.

But you have no problem putting that pressure on me :-). Yes I know it can 
be a pain for newcomers and did not say these messages can't be useful to 
them. But I can't follow your logic about sending these to the list. You 
say that they won't see if their patch were merged because they won't 
follow the list because it gets too many messages. So you need to cc them 
but you also send that to the list where they won't read it anyway so it 
just increases the volume of the list even more with messages that those 
on the list will just have to ignore. Wouldn't it be simpler to not send 
these messages to the list if those interested are already cc'd because 
they are not expected to read the list?

>>> So for consistency and the series I personnally track, yes, I believe 
>>> there
>>> is a value in notifiying original series and author.
>> 
>> I'm OK with that, what I doubted is that it is useful to send this to the
>> list too. Wouldn't it be enough to only send it to the people involved off
>> list?
>> 
>
> It does not notify only original author, but other maintainers or reviewers 
> also. As a concrete example, I'm sure you already went through a thread where 
> someone was reviewing code already merged. With such notification, it would 
> not have happened.

I'm not sure about that. If they are not on cc they would miss this 
message on the list the same way they missed the pull request. If they are 
on cc they would see this message without it being sent to the list too.

> If you started arguing about the message itself, it would be an interesting 
> debate. But your point is "My email workflow is A, and I don't like B, please 
> change B". So my polite answer is "Your email workflow is A, and you don't 
> like B, so change A". We can run in circles for hours I guess.

I'm arguing about if it's useful to send these messages to the list. My 
workflow is an example but just ignore that for now to avoid 
misunderstandings. If you say that you need to send these messages because 
those people won't follow the list then I think it's not useful to spam 
the list where nobody would read these messages just in case somebody 
might read them. I don't care if you send them off list or not and if 
others think that it's useful on the list I'm also OK with that but I 
don't see what this would add to the already sent pull requests and pull 
applied messages already sent to the list for those who follow the list.

>>> It's totally right for you to mention you don't like it, feel free to 
>>> ignore
>>> the message. However, I feel it's a bit beyond your rights to decide what
>>> people can or can't send on mailing list when you are not in CC on the
>>> concerned thread, don't you think?
>> 
>> And that's what I did. Mentioned that I don't like it and asked if this is
>> really something others want or think it's useful to get these messages on
>> the list or could it be done without increasing list traffic. How did you
>> get the impression I told you not to send such messages at all? Just asked
>> if it's really necessary for everybody on the list? The same way don't you
>> think it's beyond your right to decide how I choose to read the list? I
>> think this is a misunderstanding and I don't want to tell you what to do
>> but wanted to discuss if there's a better way to do this and tell you my
>> opinion. Don't know why you felt offended.
>> 
>
>> How did you get the impression I told you not to send such messages at all?
> From: If you think this is useful for contributors could you please send such 
> mails off list only to involved parties?
>
> Reading it again, you are right, it can be seen as a polite suggestion, even 
> though I read it as a mandatory request first.
>
> I didn't feel offended, but felt like you were trying to control what someone 
> can or can't send on mailing list, which is a big NO for me. I would react 
> the same way on any other thread where I would read the same kind of message.

No problem, may be a language issue and too direct way of telling things.

Regards,
BALATON Zoltan

