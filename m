Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C44AFCC9A5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 23:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzkHO-0003WY-6o; Mon, 09 Mar 2026 19:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzkHM-0003W9-5n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 19:44:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzkHJ-0003Cn-Hn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 19:44:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 226CB5969EC;
 Tue, 10 Mar 2026 00:44:47 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LxIuoB0nOxMH; Tue, 10 Mar 2026 00:44:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E7A0A5969E7; Tue, 10 Mar 2026 00:44:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E3B895966F4;
 Tue, 10 Mar 2026 00:44:44 +0100 (CET)
Date: Tue, 10 Mar 2026 00:44:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
In-Reply-To: <905957d4-4d5d-45d1-95e0-f7cdc6f75a97@linaro.org>
Message-ID: <f2690dc7-ef35-3ab4-0f4a-dbe139b48670@eik.bme.hu>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
 <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
 <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
 <e5bef5ed-23e9-119d-3f63-a45343cc9c53@eik.bme.hu>
 <cbc1b812-40f4-4b1e-b206-ed4962cb5dd9@linaro.org>
 <c30ea720-5208-adea-c8a3-788c870fedee@eik.bme.hu>
 <905957d4-4d5d-45d1-95e0-f7cdc6f75a97@linaro.org>
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
> On 3/9/26 11:50 AM, BALATON Zoltan wrote:
>>> Every N months, you can run a manual "archive" command (i.e. move to 
>>> another
>>> INBOX subfolder) on messages older than N months and your qemu-devel INBOX
>>> will keep a constant size.
>> 
>> Glad that it works for you but I have a limited mail quota so I have to
>> delete read messages.
>> 
>
> Let me update my suggestion with something that would work in your case.
>
> Every N *weeks*, you can run a manual "delete" command on messages older than 
> N weeks and your qemu-devel INBOX will keep a constant size under your quota.
>
> The key is to not delete thread as soon as you receive them, but keep context 
> for a few weeks, similar to keeping your git clone to a constant -depth=N 
> because your disk space could be limited.
>
> It's a win-win: you keep semantic context *and* your quota stays under 
> control.

You complained why I want to tell you what you should do but you keep 
telling me what should I do instead. I say again, please let me decide how 
I read the list. I'm fine with the way I do it now. I don't want to keep 
context for months or weeks (there are tools like patchew or list archives 
for that already where I can look it up if needed) so I only keep locally 
what I need in the short term. This is fine as long as the related 
messages come threaded at once but with these mails it would come some 
indefinite time after the pull request and I'd end up with as many 
separate mails as many patches were in a pull request. That can be many 
and the only way to thread them would be to keep at least the covers of 
all pull requests for who knows how long.

>> I'm arguing about if it's useful to send these messages to the list. My
>> workflow is an example but just ignore that for now to avoid
>> misunderstandings. If you say that you need to send these messages because
>> those people won't follow the list then I think it's not useful to spam
>> the list where nobody would read these messages just in case somebody
>> might read them. I don't care if you send them off list or not and if
>> others think that it's useful on the list I'm also OK with that but I
>> don't see what this would add to the already sent pull requests and pull
>> applied messages already sent to the list for those who follow the list.
>> 
>
> They might not be in pull request messages recipients, or didn't configure ad 
> hoc filters for that, so they might have missed that.
>
> As well, for people reading the thread afterward from lore.kernel.org, it 
> confirms the series was merged and the topic is closed, without needing to 
> check manually in git log, parse pull requests, or check on patchew status of 
> series. You'll notice that I always send an update email when posting a new 
> version to link to new version also, to "close" a given version, in a similar 
> way. See it as an email ladder version -> version -> version -> 
> notify_merged.

OK at least this gives a reason why sending to the list might be useful 
for some to track a pull later on lore.kernel.org. There are already other 
similar systems but some may prefer this.

> I didn't invent any of this but simply mimic what GitHub and GitLab (and

But you started doing it on the QEMU list. Some other maintainers cc 
patches in pull requests also to authors, some others don't and you 
introduced yet another solution. So you kind of invented it here as we did 
without it for quite a while and nobody complained. That does not mean 
this can't be useful for some but could you at least consider doing it in 
a way that works for everybody?

> other forges) do. They notify you on new versions, on final merge, and you're 
> free to unsubscribe from a PR if you're not interested.

That's exactly the issue. With those forges I could subscribe or 
unsubscribe to/from these but here you decided I should be subscribed and 
left not much way to unsibscribe.

> Once again, I totally respect you don't find it useful, feel free to delete 
> and ignore those messages.

Could you at least make it easy to filter and delete them? Like sending 
them with a cover letter threaded at once or adding [MERGED] to the 
subject or something similar so they are easily filtered and not just tell 
me to deal with it if I don't like it?

Regards,
BALATON Zoltan

