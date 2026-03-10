Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8D5FD2D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwSI-0004Ni-Pd; Tue, 10 Mar 2026 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzwSF-0004NP-LH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:44:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzwSD-0002o7-BI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:44:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA79E596A13;
 Tue, 10 Mar 2026 13:44:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2gQ7hYtk8SPc; Tue, 10 Mar 2026 13:44:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C1E6C5969F3; Tue, 10 Mar 2026 13:44:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BFC125969EC;
 Tue, 10 Mar 2026 13:44:47 +0100 (CET)
Date: Tue, 10 Mar 2026 13:44:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
In-Reply-To: <62d96ae5-0b15-4de4-90f8-fb7f6a93afeb@linaro.org>
Message-ID: <f10e3c8e-b1a6-215b-812d-4c4eb8e6c0c1@eik.bme.hu>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
 <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
 <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
 <e5bef5ed-23e9-119d-3f63-a45343cc9c53@eik.bme.hu>
 <cbc1b812-40f4-4b1e-b206-ed4962cb5dd9@linaro.org>
 <c30ea720-5208-adea-c8a3-788c870fedee@eik.bme.hu>
 <905957d4-4d5d-45d1-95e0-f7cdc6f75a97@linaro.org>
 <f2690dc7-ef35-3ab4-0f4a-dbe139b48670@eik.bme.hu>
 <62d96ae5-0b15-4de4-90f8-fb7f6a93afeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>>> As well, for people reading the thread afterward from lore.kernel.org, it
>>> confirms the series was merged and the topic is closed, without needing to
>>> check manually in git log, parse pull requests, or check on patchew status 
>>> of
>>> series. You'll notice that I always send an update email when posting a 
>>> new
>>> version to link to new version also, to "close" a given version, in a 
>>> similar
>>> way. See it as an email ladder version -> version -> version ->
>>> notify_merged.
>> 
>> OK at least this gives a reason why sending to the list might be useful
>> for some to track a pull later on lore.kernel.org. There are already other
>> similar systems but some may prefer this.
>> 
>>> I didn't invent any of this but simply mimic what GitHub and GitLab (and
>> 
>> But you started doing it on the QEMU list. Some other maintainers cc
>> patches in pull requests also to authors, some others don't and you
>> introduced yet another solution. So you kind of invented it here as we did
>> without it for quite a while and nobody complained. That does not mean
>> this can't be useful for some but could you at least consider doing it in
>> a way that works for everybody?
>> 
>
> In this case, feel free to start a topic and forbid this "officially" for 
> everyone, including maintainers that sometimes report that code was merged, 
> or that they pulled it in their own tree, as it's the same kind of semantic 
> message. I would be very happy to obey to any new rule of conduct that would 
> be added for the whole community.

In that case maybe you should start a topic and agree on an official way. 
I don't want to forbid anything, just noted there's an inconsistency here 
and your way just added to that inconsistency besides making my life more 
difficult. I was questioning if it's useful to send such messages to the 
list as the reasoning for them was that people who don't follow the list 
might miss their patches were merged. That to me does not imply the list 
also needs these messages. Above you gave a reason to archive it in the 
list too so a lifecycle of a patch can be followed. OK that answers why 
the list might need these too.

>>> other forges) do. They notify you on new versions, on final merge, and 
>>> you're
>>> free to unsubscribe from a PR if you're not interested.
>> 
>> That's exactly the issue. With those forges I could subscribe or
>> unsubscribe to/from these but here you decided I should be subscribed and
>> left not much way to unsibscribe.
>> 
>
> There is a way to do it, by keeping threads context in your mailbox.
> If you don't want, your need to invent another ad-hoc solution.
>
>>> Once again, I totally respect you don't find it useful, feel free to 
>>> delete
>>> and ignore those messages.
>> 
>> Could you at least make it easy to filter and delete them? Like sending
>> them with a cover letter threaded at once or adding [MERGED] to the
>> subject or something similar so they are easily filtered and not just tell
>> me to deal with it if I don't like it?
>> 
>
> The message body will always be the same, as I use a template in my email 
> client.
> ```
> This was merged into master (.*).
> Thank you for your contribution!
>
> Regards,
> Pierrick
> ```
>
> Second line is optional because I don't thank myself when sending my own 
> series.
>
> So a simple email filter could be:
> from: pierrick.bouvier@linaro.org
> contains: 'This was merged into master (.*)'
>
> Does that sound good to you?

That helps as long as you're the only one sending these otherwise "from" 
is not the same. It would be even better it you could also change the 
label in the subject to [MERGED] as it's easier to filter by headers 
(faster than content search) and that may also help more easily tracking 
the lifecycle later so you'd see [PATCH vXX] -> [PULL] -> [MERGED}. Or add 
some header specific to these messages.

Regards,
BALATON Zoltan

