Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A806FED2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 23:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0pnD-0005uo-VC; Thu, 12 Mar 2026 19:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0pnA-0005uH-IW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 19:50:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0pn8-0008US-6l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 19:50:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso13206305ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773359408; x=1773964208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FohvZ2OnCuoFaoH3lYq+f98RGDVJuIK0GEp3Ifb5oM8=;
 b=kU6S66QgrM7ULCjGdsASgBNQtmzaoU0vfLuICZCdhGKJViusHyMiNKcoM7FES7FpBG
 gEM0ZvYdvaQRChiMe7wORgfCQNi5wdfaKDnukj/me4yIb8mfVQd8+s4mOrMxnS//z/YN
 KrUWg1q3db2GRI0/VzNuG8lr03AYRCL+ZFuwJMyjauK1hAnF5fvacGvwgk2cbrSp48d+
 5Qwx0wD53mFhcRCPN1j536FBE9kUOlER4+8M2DdXpIeQ61lzJNotW/nB6IpA28b/joox
 gtTznSXc/Hy8OpFGqZswe0N2jOVrFSL9Sbo5QkWHrGOqjmwofUje1TC4QBCBS/JYPk9e
 tLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773359408; x=1773964208;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FohvZ2OnCuoFaoH3lYq+f98RGDVJuIK0GEp3Ifb5oM8=;
 b=ZXPs+QxZsvc4MS9kgz2XHdPgklLXlUv7CoADsDwC7N6iROcdsT4n5IDpSjlKxh0lHx
 0TTMxh/J48/v/uj9tRDrONhgMUU/5+o68P6drZ4KAfZExvNTx/yLy5x8+0yY7A+zNXKY
 8T/kMhMj5VMAvOqQh/ejCC+TKrj/GlxGkttIHh8Unh/NDtnOwn2QZGpLndP0rRZ/DGGd
 o+7BBgSNJmW4kCBnj/RFARNjgIhgeNottZ+NPwUJNdpXa3ZlFaxee6eH8KZKsyMmA5iS
 PaKOHs5opSfr6n3LYawD72K63UfSHHrTqzykthY+9OOPJK/ajg3A7HIKndifrANUm0Iu
 6Fwg==
X-Gm-Message-State: AOJu0YzPbfnfpCDeD24EM9lK3r3qNfBi4P/uVVN7GVZ4M84DDen+H3CN
 MSF6WH0JcolfFbf67tfO0mM0QuzsI+kaDH2ZtDLVZWHAYkBgvazp7OoxrY3KSRefjLg=
X-Gm-Gg: ATEYQzzvfDgJb6Fw7A7Xdr6qUybOymWgsYn2RK82FkXYM7vY/G6KaTvbd4CUTV7Z2kd
 g8f+6HJVvhgFKqhFiLAgBOuXCktGJgI6jHT1Q6LQeVSUHtoPdgyGel5KAwycb6w502kRuM8ciBh
 END5bIr8jTKetSInus7BaKMB9TlbYWS5sG7dMx62dgqr3h+Bl3xucouSm44kpsfg8ReGIrKZrBU
 6Thq2HKE/r7PI0IPnDhimmdaU+gypDlhIqeW273djIHnrjvEoNhRPNYd0tuLscNbUSvnKOO/cKe
 zR4FyMoL8ruZ2rmrpjtXh/A0gHy+AjIdZVvDvZDfcQYnnI3a89TSh+JorV3w6A1fx87LKZZGMRq
 OjDBswHbEnGfp4MzfSGzph5C/oMdi091dJ9zhj+LGaP3Bbt5zVEF7j0PzZGh+H4SB5ARwoY/Nnu
 o+UFa7x3IgIUKqVV+gyEQSPZFmR7L9/+/tiTfpkVHdXjFA/GdR7p2CaiJgCuwjXiDjRCLBV8b/F
 fQX9sA=
X-Received: by 2002:a17:903:19c7:b0:2ae:46f9:a115 with SMTP id
 d9443c01a7336-2aeba5158eemr45279105ad.22.1773359408417; 
 Thu, 12 Mar 2026 16:50:08 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece84084bsm1120595ad.82.2026.03.12.16.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 16:50:07 -0700 (PDT)
Message-ID: <8dae5368-4584-40d6-a460-51b90b2491eb@linaro.org>
Date: Thu, 12 Mar 2026 16:50:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
 <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
 <CANCZdfo8cEp8_078o4bEwCo63vL+W5NW9ukeQR0nMACJBQXysw@mail.gmail.com>
 <68903178-92ef-4956-b815-dc4c4533507d@linaro.org>
 <CANCZdfqCu13nJysw3Rwhe7GJWzdSkstKCKkQAR7u0cJFOJaY-g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CANCZdfqCu13nJysw3Rwhe7GJWzdSkstKCKkQAR7u0cJFOJaY-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/12/26 4:17 PM, Warner Losh wrote:
> 
> 
> On Thu, Mar 12, 2026 at 4:36 PM Pierrick Bouvier 
> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> wrote:
> 
>     On 3/12/26 1:19 PM, Warner Losh wrote:
>      >
>      >
>      > On Thu, Mar 12, 2026 at 11:52 AM Pierrick Bouvier
>      > <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>
>     <mailto:pierrick.bouvier@linaro.org
>     <mailto:pierrick.bouvier@linaro.org>>> wrote:
>      >
>      >     On 3/12/26 6:10 AM, Warner Losh wrote:
>      >      > thunk.c is the same between linux-user and bsd-user (out
>     of tree),
>      >      > so share it between the two.
>      >      >
>      >      > Signed-off-by: Warner Losh <imp@bsdimp.com
>     <mailto:imp@bsdimp.com> <mailto:imp@bsdimp.com <mailto:imp@bsdimp.com>>>
>      >      > ---
>      >      > As part of upstream blitz bsd-user, I've discovered that
>     bsd-user and
>      >      > linux-user have the same thunk.c file. Rather than copy
>     it, put
>      >     it into
>      >      > the common-user directory and share it. It has to be compiled
>      >      > per-target, unlike the rest of common-user, so modify
>     linux-user and
>      >      > bsd-user to grab it from there.
>      >      > ---
>      >      >   bsd-user/meson.build                | 1 +
>      >      >   {linux-user => common-user}/thunk.c | 0
>      >      >   linux-user/meson.build              | 2 +-
>      >      >   3 files changed, 2 insertions(+), 1 deletion(-)
>      >      >
>      >
>      >     Indeed, thunk.c seems to be highly target specific.
>      >     A good solution would be to move common functions to common-user/
>      >     thunk.c
>      >     and the rest in include/user/thunk.h. It may be cleaner than
>     doing the
>      >     meson hack. Or leave it duplicated for now, except if you plan on
>      >     modifying it.
>      >
>      >
>      > My concern with leaving it duplicated is the process. I create a
>     patch
>      > to create
>      > bsd-user/thunk.c that's a verbatim copy of linux-user/thunk.c.
>     Despite
>      > putting in
>      > my cover that this is copied code, if past is prologue, then I'll be
>      > asked to fix the
>      > copyright and style, plus lots of suggestions to improve the
>     code. But
>      > it's just a
>      > verbatim copy, so that's a lot of hassle just to copy it.
>      >
> 
>     I understand, and it's a good intention to want to remove this
>     duplication. However, I'm not convinced a build system hack is better
>     than a duplication.
> 
> 
> Yup, if it were frictionless to duplicated, I'd just do that. But 
> there's always
> some hassle or another that comes from it. And it's a dependency on doing
> the ioctl round of upstreaming.
>
>      > Moving like this, though, is almost 0 friction. A small tweak to
>     meson
>      > is all that's
>      > needed. I suppose I could do the #include "../linux-user/trunk.c"
>     trick
>      > to make it
>      > less ugly in the build system, but then it's not clear it's
>     shared, etc
>      > and more ugly
>      > in the code, imho.
>      >
> 
>     Yes, it's a hack, that's what it's for, "quick and that works but not a
>     proper solution".
> 
>      > I tried to move this stuff into thunk.h as much as possible so we
>     could
>      > have one
>      > compilation, and that didn't work. It really assumes that it can
>     include
>      > qemu.h for
>      > the tswap, etc macros. So it's impossible to just build once.
>      >
> 
>     Yes, not all functions can be compiled once because they have target
>     dependencies. That's why I invited you to simply extract common
>     functions to common-user/thunk.c and leave the target specific bits in
>     thunk.h (with static inline functions), or in a thunk-target.h
>     header if
>     you really want to do it cleanly. That's the proper solution here.
> 
>     Build systems and preprocessor are not a shortcut to proper software
>     architecture, even though QEMU abused both of them to this end.
> 
> 
> Yea. I'm looking for a reasonable tradeoff. I'm open to suggestions, and am
> even willing to split things up: "now the hack, I'll remove it within a 
> year" sort
> of thing just to get this years-long process of upstreaming done.
>

As mentioned, I think that extracting common part in a file and put the 
rest in thunk-target.h is the best approach here.

If creating a new file creates too much frustration, I would be happy to 
give you a reviewed-by on simply moving all functions as static inline 
ones in thunk-target.h.

And if even this is still too complicated, I would be happy to give a 
reviewed-by on any copyright change for this file.

You have now 3 solutions without any hack :)

>      > Now looking at the code, a lot of it would be a lot simpler with
>      > 'Generic', but that's
>      > a battle for another day. As is the notion of just generating
>     this data
>      > from the .h files
>      > rather than hard-coding it here, but that too is a battle for
>     another
>      > day. I'd like to
>      > get this upstreamed so I'm spending my time on these sorts of
>     battle.s
>      >
> 
>     I totally get it, and we have been dealing with a lot of things like
>     this for the single-binary topic, trying to find the good compromises
>     between refactoring APIs and doing limited changes.
> 
>     If extracting the common and target part looks like too much work, just
>     leave it and simply change the copyright header, it's not a big
>     thing to
>     do, and you can modify both in the same series, no one will yell at you
>     for changing comments in one file in linux-user.
> 
> 
> Yea. You should have seen the pushback I got from changing the copyright 
> header when I had the permissions to do it....  If I copy the file, it's 
> a full copy, verbatim, no changes. It's not my code, so I can't change 
> things.  I have a similar issue from some code I plan on copying from 
> FreeBSD to avoid having to chase the strace.list stuff. Since I can 
> easily hack upstream FreeBSD to be what I need for qemu, I'll evolve 
> things there (ideally, just making it a private library I can hook into 
> the bsd-user build for tracing so qemu gets whatever FreeBSD does in 
> truss for free...
>

I indeed read this thread, which was pointed to me by other people who 
read it also. Our general opinion was that it's totally unfair to push 
all this on you, and that idealism on license comments is absolutely not 
worth all the hassle, especially for someone trying to help on his free 
time. Even for someone paid to do it, it would not be worth.

I ran as well into issues of pragmatism vs idealism with the concerned 
person on this thread, and there is alas no proper solution to end this 
behavior. The simplest way to deal with it is to stick to rationale 
arguments, not let it go and don't apologize for saying "No, it's 
unreasonable to ask for this".
If enough people do this, it might end up triggering a positive change 
in the community, instead of implicitely validating this behavior 
blocking contributions.

For concerned bsd-user files, and using a rationale approach, I would 
simply suggest to contact past contributors of those files to collect a 
OK, or ideally ask them to answer on this thread and mention "I'm ok". 
If they don't answer after one week, consider it's an implicit ok. Then 
move on, and pull the changes. No one will come sue you or QEMU for a 
copyright comment.

> But maybe the next round is all but the ioclts and see if some other 
> solution can be found in the interim.
> 
> Or maybe I'll find the right people that can sign off on 'just copy it' 
> so I can get on with things :)
> 
>     As you said, pick up the right battles and ignore the rest.
> 
> 
> Yea. Maybe the next round will just be the simple stuff w/o battles....
> 
>      > Warner
> 
>     Regards,
>     Pierrick
> 

Thanks for all the work you're doing on bsd side, this part really needs 
some love, and it's really good to see someone giving it.

Regards,
Pierrick

