Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671AECD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgxy-0006vD-7P; Thu, 28 May 2026 16:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSgxw-0006uX-Oq
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:04:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSgxu-0004ys-G0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:04:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so607565f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998664; x=1780603464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0IR+/7mSU/LAFE/aI6HSEfewT9NbGi67S6N8rWFuUk=;
 b=W+cLq6bciCar6o+hlr6knEOa8DUqO89Iw6gd8uQZpOzDQYDXn+1j/1ODJJaggOSRLV
 JIPIOIFwwMtZKBexv3hFMjg0LQp8yIvD38XW46RiyRUWe7pgOU82j2+ICOdnrsrE8duf
 40+OQ59ueTBx5hlZoXf43D170yPKFyClLibA/CeoruCtOChp5lOUBzKbJuOuACg6knUK
 eVbHnunRkIQDls9KUM2rcAwQHBh5wgwzHFpws6fnnBg0b3Zan3k0ZCkHRKOWDOo0JeZI
 ++EMSgvm35DW8tnIzT8SkHE2qpoAAFJXCNxqDIhMHZvVW8koU8v4a+tebExNr7RsVBm4
 bo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998664; x=1780603464;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v0IR+/7mSU/LAFE/aI6HSEfewT9NbGi67S6N8rWFuUk=;
 b=D+WtVuEWe3BqwFWgKEPmUGunMyDnVvKzw9YCPBAD+FumbH9A09VT8U8oDwJd+SsIPZ
 RyXSKwT1og431XtMT1Mh5su4UA2FNF2hdEv127BekHAzwUQ1WCOYnuzzB2atD1pO84sZ
 AfHueLYuux1JKzHb6VlO/gIr1kwom9PdcKPmIVAbk0Dc/XL/uxE/sW0ZGNWqKTUAY+Zh
 iNBfb1H0hSbamXYz0a2JIGk0AyL9NSD440MJq7wwJU/PFb7zeejbLU1cF2OcEuM1msrE
 AedChWJk2p67AnCb7dktdIzAmuVSdc3JGoW4F6Y1wkQI8yOtN5yVDMnmK+kU6NsQQuzE
 ttNA==
X-Gm-Message-State: AOJu0YwpEVoTtsogQSKZsgoGHnz8VWKuBwLVrTk092+Yl10Gx2F6gDy2
 kmzq4/ocop3gHwB6ytlz0g7MAn9su0nQfWSZXGLejZ0vjAjFZZiKJGJNJRVBeL1b4vE=
X-Gm-Gg: Acq92OHWE9oUJsJ7+qIx0BOdXe7ZpH0POgh96gsM/sJpv4ozDwoU1TR3j4tvezIIHI9
 U5YjLDC3MMmDaywYFYnDdX1fRWQSled58uqCUG7oTfVP+U4PU+o32MU8/7q4EzFcWBDVNypxTF/
 HLNfCUcCKgeouqL570QT0Hbp0V8UpelMbYHGJsMsSsRafnAVIX8tDMoLanSdz1FC+haOMJP+F6Y
 cWOG2PRvRQdswb3aswU/4fnR/wauv5gsUE3nJzl2tpEVN5+OTYYSmBuOdm9BSOhbWCNvUst6AeI
 WqstiyBcvdiCD7koSumcmJkyX45vfNTl4gYeojzbZicPr4GIiFm0b6nuY2j6B1+aDhBBmpXNiv3
 SwV+Qz5SZFjAX2RSfmxDIw7uiyP8x9fCTTsTanPeQdn/V2D2BCpbBBqUkM1gAnp6qw/ruve6gxV
 9LPGnLz/DUc+FRGAMiV24mkOSM4LqxxiJWSSawa1vSqlfz
X-Received: by 2002:adf:e58f:0:b0:455:7d77:1d25 with SMTP id
 ffacd0b85a97d-45ef05d9398mr808255f8f.27.1779998664295; 
 Thu, 28 May 2026 13:04:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed496112sm3811175f8f.15.2026.05.28.13.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 13:04:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BF3A5F92B;
 Thu, 28 May 2026 21:04:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,
 Song Gao <gaosong@loongson.cn>,  John Snow <jsnow@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Brad Smith
 <brad@comstyle.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency
 to run-tcg-tests-% rules
In-Reply-To: <98156f95-e6bf-4061-8e3e-9e884ebc3e5e@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 28 May 2026 11:43:26 -0700")
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
 <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
 <877bor9vor.fsf@draig.linaro.org>
 <7d58926d-a36d-430f-828e-7ebdd9cc4eb5@oss.qualcomm.com>
 <87qzmyzbut.fsf@draig.linaro.org>
 <06092208-1b56-4fea-8d92-bf035fbd0fa3@oss.qualcomm.com>
 <87fr3eyrvp.fsf@draig.linaro.org>
 <8a878679-733c-451c-8053-663a74f8d4a7@oss.qualcomm.com>
 <87a4tlz897.fsf@draig.linaro.org>
 <86385e93-5425-4145-8a9f-0f72ed5de022@oss.qualcomm.com>
 <87o6hzx2np.fsf@draig.linaro.org>
 <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com>
 <871pevqumz.fsf@draig.linaro.org>
 <98156f95-e6bf-4061-8e3e-9e884ebc3e5e@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 28 May 2026 21:04:22 +0100
Message-ID: <87v7c7pagp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 5/28/2026 11:03 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 5/28/2026 3:13 AM, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> On 5/26/2026 11:17 PM, Alex Benn=C3=A9e wrote:
>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>
>>>> <snip>
>>>>>>
>>>>>> What do you mean? I run check-tcg all the time.
>>>>>>
>>>>>> Which containers fail to build for you? The main cross-compiler one
>>>>>> (debian-all-test-cross) is built all the time.
>> <snip>
>>>>> I'm a bit tired of seeing patches in your subsystems get stuck for
>>>>> weeks, without any proper review, to finally be (re)posted again in a
>>>>> new series, blocked for more weeks, and finally reach upstream one mo=
nth
>>>>> later or worse. It's truly exhausting for everyone contributing in su=
ch
>>>>> places.
>>>>
>>>> What can I say - reviews are welcome. I always list what patches are
>>>> still waiting for review in the cover letter. I should also add for
>>>> testing/next I try to be extra careful that regressions don't slip in
>>>> because keeping the testing sub-system stable is important to support
>>>> things like bisection.
>>>>
>>>
>>> The main issue with your personal workflow, which is "reposting existing
>>> series concatenated in a new single series", is that it adds a lot of
>>> latency. Basically, if one patch fails, or is not reviewed, the whole
>>> thing is blocked. And that is a problem. I don't see what it's supposed
>>> to achieve, since it's halfway between a series, and a PR, without being
>>> one or the other.
>>>
>>> TLDR: the problem is how long things are between receiving reviewed-by,
>>> and being in a pull request in your subsystems.
>>>
>>> For instance, in current series, there are multiple sub series. Some of
>>> them are fully reviewed and ready to go, they can be sent as PR
>>> independently.
>>>
>>> I remember you mentioned several times that you like to have a "single
>>> branch". I have the same workflow, and it absolutely does not prevent to
>>> send multiple PR or series in parallel.
>>=20
>> I do split stuff out when it makes sense, but look at testing/next:
>>=20
>> e02df7f4810 * testing/next MAINTAINERS: Cover python.docker with Python =
library section
>> 4fcb3a8c07a * MAINTAINERS: Cover debian-tricore-cross.docker with TriCor=
e section
>> b554638aea6 * MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa =
section
>> 8417a661600 * MAINTAINERS: Cover debian-loongarch-cross.docker with Loon=
gArch section
>> 0f57fbac5bc * MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.d=
ocker path
>>=20
>> Maintainers updates aren't critical to get in now.
>>
>
> The more you wait, the more it might create conflicts. That's basic
> software engineering, and where the term Continuous integration comes
> from. It does not mean "run a GitLab pipeline", it means integrate
> often, *continuously*, with low latency.
>
> There has been concrete examples of why delaying created an issue in the
> past. In the current series, "docker: Remove LegacyKeyValueFormat*"
> basically blocks any other change in concerned files, as soon as it does
> not land. At least those two could have been sent as soon as possible.
>
> If you'd send a PR regularly (at least every week), it would be less a
> problem. Miss the train? get the next one.
>
> If you want a good analogy:
> Problem is that your train is leaving at random time, and it has several
> wagons, which increase the risk of a mechanical failure every time. As a
> result, passengers are stuck waiting.
>
>> f80f388a538 * gitlab: update issue template for binary test cases
>> 4e7de923722 * gitlab: add MacOS 26 job on gitlab runner
>> e0692ad4b23 * gitlab: add initial MacOS 15 on gitlab runner
>> 1299b5aec2f * ci: drop cirrus MacOS build
>>=20
>> None of these matter without bellow
>>=20
>> dd2db9273be * accel/tcg: move jit thread manipulation into do_tb_phys_in=
validate
>>=20
>> b60553095bb * tests/Makefile.include: add binary dependency to run-tcg-t=
ests-% rules
>> bcde94b9315 * tests/Makefile.include: fix typo in comment
>>=20
>> Why take the chance to break the build when the changes are in service
>> of the wider patch? The more runs through the CI to shake out anything
>> the better.
>>=20
>>> If tooling is the limitation, please take a look to those (ugly) scripts
>>> for inspiration. AI can probably rewrite this better than me in 10 min.
>>> With this, sending a series or a PR is a complete no-op for me, I just
>>> wait for CI to run, and send it when ready 2h later.
>>=20
>> Tooling isn't the issue - but I'm never going to be doing multiple PRs a
>> week because each one has a degree of latency due to CI coverage.
>>
>
> Sorry, but this sentence doesn't make any sense at all.
> What is the "degree of latency due to CI coverage"?
>
> CI takes less than 2 hours to run, you can run it 4 times within a
> working day. 5 days a week. That's 20 chances to send a PR.
> The only latency is human based, and a way to solve it is to automate.
> Lack of tooling *is* the problem in this situation.
>
> You can't take a lot of pride in automating things with AI, and claim
> it's impossible to automate sending a series of patch and run a CI
> pipeline from it. Use AI if you want, but please apply it everywhere
> it's needed.
>
>>> Saying "people have to accept my tempo" is not acceptable. Fix the
>>> tooling instead.
>>=20
>> I think it is fundamentally down to the maintainer what tempo they are
>> happy and able to work at. If you wish to take on responsibility for more
>> areas of the code base then be my guest.
>>
>
> There is a difference between being really busy and just adding latency
> artificially because "I said so". We worked together, so I can make the
> difference between the two.
>
> I would be happy to help maintain any part that needs help. Maintaining
> plugins was a suggestion that came from Richard, and yes, I was open to
> do it for a long time, especially after experimenting weeks of latency
> to see patches get merged, and this several times.
>
> I stepped in for docs because we identified there was a need for it.
> I also talked with you in private to help on linux-user and you
> explicitly asked me to wait, without any specific reason. Now Helge is
> maintaining it and doing an excellent job, I'm really glad he stepped in.
>
> I would be happy to help co-maintain tests/tcg and help this move to
> meson. Unfortunately, you snipped that part without even trying to
> answer to my proposal of helping by making a small proof of concept.
>
> Coming back to your proposal, do you wanna share maintainership on
> tests/tcg/multiarch and tests/tcg?

I'm happy to turn over the maintinership of tests/tcg to you with the
new meson based system.

>
>>>
>>> Regards,
>>> Pierrick
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

