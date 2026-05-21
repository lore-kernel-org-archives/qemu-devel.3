Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170B0CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 04:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPvCz-0000c4-OV; Thu, 21 May 2026 00:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPvCu-0000aK-RW
 for qemu-devel@nongnu.org; Thu, 21 May 2026 00:40:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPvCr-0002NT-EY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 00:40:28 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64L4eB9U049903
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 21 May 2026 13:40:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=h7WrnxUuPJHua8njQQ+sd9PepppLuIchkhHEuuv9XeE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779338412; v=1;
 b=ROyRPw2gYT8ijaoonxD2bxhXyj9HqeVEFPF1B2hUtVVEUa9isobvCNcRsARjHD+E
 DpZrhyWGrpkobeIqr0f5+rJt4xujgXsiPJUmt9mSl0J65hiR8qp+JM4GReQ0TFOe
 K7rYjXhDvh46G7/F/u+Zl9nD6pHzMO5oBdBUpjikz+BqdoyPSLnptzT8U4mp4BsY
 UnEEB1jaFGdSnZDAlOq/rcAienVvc5lCvsTKLtK+7mKqYw4i21BiPUU1847bCh4f
 tX3gdCsJzaRpH7XmnGq/bg9jDR/wGBPD3VzVrViiAY94soHqlpoi9gJY7sZDq0zZ
 qCpX67f1L9SSlVS7+MpR3Q==
Message-ID: <5de52cde-3872-4b5f-acbf-28ca300b7724@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 21 May 2026 13:40:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace my amsat.org email address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>
References: <20221017182005.43015-1-philmd@linaro.org>
 <87pmeohtj1.fsf@pond.sub.org>
 <3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

On 2026/05/21 4:37, Philippe Mathieu-Daudé wrote:
> On 19/10/22 14:44, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> The amsat.org domain is having issues with DMARC / SPF / DKIM:
>>> https://lore.kernel.org/qemu-devel/ 
>>> CAMVc7JUy5NeEN0q=4zfZvn_rppgqn9wicV1z=TsLuHKS3RY3Sw@mail.gmail.com/
>>>
>>> Consolidate all of my MAINTAINERS entries on my work address.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   .mailmap    |  4 +++-
>>>   MAINTAINERS | 62 ++++++++++++++++++++++++++---------------------------
>>>   2 files changed, 34 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index 1f7319b70b..35dddbe27b 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -70,7 +70,9 @@ Paul Burton <paulburton@kernel.org> 
>>> <paul.burton@mips.com>
>>>   Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>>>   Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>>>   Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
>>> -Philippe Mathieu-Daudé <f4bug@amsat.org> <philmd@redhat.com>
>>> +Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
>>> +Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
>>
>> I think this retroactively credits all your contributions to Linaro.
>> Intentional?
> 
> Certainly not intentional. I was seeing this as a git limitation, but
> Alex pointed to me we are doing an invalid use of git-mailmap, since
> it is described as:
> 
>    ... the file .mailmap [...] is used to map author and committer
>    names and email addresses to canonical real names and email addresses.
> 
> so more for typos, not developers changing email addresses. So our
> "replace old addresses by a more recent one" section might not be
> the best use. I think it was useful for the get_maintainer.pl fallback
> option: when a file is not cover in MAINTAINERS then the script look
> at git history. If all files are well covered, then we shouldn't need
> this fallback anymore, nor this .mailmap translation.

Git's own .mailmap contains multiple "replace old addresses by a more 
recent one" entries. For example, the latest commit for that file is 
exactly for that purpose:
https://github.com/git/git/commit/4aa72ea1f64e8ddcd1865c76b24591c0916c0b5d

The situation looks same for .mailmap of Linux kernel too:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/.mailmap?id=1bb54043ff309795c90ccadd8a6e6b13ac40ec4e

My understanding is that Git's handling of .mailmap is designed to find 
out email addresses to be used to reach out. For example, someone may 
git-blame and find I wrote some buggy commit, and ask me to review a fix 
for it; in that case it is nicer if git-blame displays my latest contact 
point (@rsg.ci.i.u-tokyo.ac.jp) instead of one for my previous employer 
(@daynix.com), even though I authored the commit for Daynix.

> 
>>
>>> +Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
>>>   Stefan Brankovic <stefan.brankovic@syrmia.com> 
>>> <stefan.brankovic@rt-rk.com.com>
>>>   Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>>
>> [...]
>>
> 


