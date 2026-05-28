Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C88DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSf54-0002EG-9x; Thu, 28 May 2026 14:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSf4l-000256-TT
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:03:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSf4i-0000RP-MG
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:03:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso112547655e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779991398; x=1780596198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEuNShT1CRtydCNhDUQ/LK1KvSXueI2+if9K0j5F6Gc=;
 b=qRZ2RIJskPuQrcEoUML1hSXWq38U5+yQJNJs3VL2X9Pk5cN5ShkmOi1jFW3w33n89B
 Fjrev7rRjshhCqvx7u1FdxYxdxWmnLVUSc4xCqmZrsJSe1opQ2MGlGjYb3luKbyMOsku
 GZRW3gZ1RdgdYvp8UkQot/E8bmP6RCgo7sszqApWIEqx9GVH2aSzLwBPooSb9nB1ZDIu
 /O/OyY72ta96O5BjGWMLivMTmQFJzEn4KM8trifCDOPkzDdINWdvoMaqO8wXl73sXgKr
 qBoYSzwnLX5+pfKS7gwmKdGrq1RAB7xRyHak2Nv80y2aQ5Y5xgvlxX+3Y1QRmI6N3XR5
 ScFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779991398; x=1780596198;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEuNShT1CRtydCNhDUQ/LK1KvSXueI2+if9K0j5F6Gc=;
 b=L0+gy1L45LNIRKo2Op9JJKnhilijncCN4GQn5R+yS1bzNOH7C/9SXc2iHjt3aQAZLN
 YhVNJz71GrgPVRpXMR0BarE+Y1/AyMPzS5PXalk89tJrpp8Gc/J72ebxQEbGT4rDkDcn
 1vMKL12qKfcqMooj7TkpLrB/VHmIFQLWjeve2WmA4Pej78eAuddpZSIPwkwFxbpCKs6m
 hES7oShOfWmn+QaUJx9WSAdMPt8xVH00DhDXp2+dlvaDvbrcE6/D/DdDmbAbTrUPWbnM
 E0SFYYDkCVDMIn5BW4+D08C81Y2CYIJnOWuzfOh1CK0IBIR83AzJlQMzxaFHaYxn73de
 4lOA==
X-Gm-Message-State: AOJu0YzYXYjOGESaNJCrvHE4YJ4Ggi/+EKT6sf5ziNPzUiB6ocQ1CeXt
 cE2tPmZ0Pkjt4zaUX1VYV6NvbbiNy5XeI8pysRj0jV6MJ/Qo0xhF9ou2DqG/SXQ6mpY=
X-Gm-Gg: Acq92OFCUUFBEg9J4RbE3pqi0umdzrfbaRg4yuN0ftgmI/5kYlPnKKl8CRq5TUFb6d3
 qAoOFmBMFC+7NJ8d5u/Vl2+zIiiHJThuquUJExHEXgc6LclxtStXwgrUFlTeN04RHYV6p/S63Os
 VJXFN6Bb9XiOxxxoDnverHs797ASSS5U432+M4u5uluNXh9aichGGK5zRK/NA+kJ081zAiqa0sj
 caJ8/RIUxrrbK9uwCMyHELSQZUQU1F+B7Ewj3cAx0hAI7sTvr6trQ7cJ5avssUbAy6R/gYbHsWo
 ocpTkso/qOQnFL9v4p6y8Yqk4ocVgqi+Fq2mxCJWKv3uNY2vk5uH2bzqIAlSnNM+N1RMTDumzma
 A71zqPiUEfgV+J4u83gUNmm3azPaL9F9tQrhOFsFEoB4sBUAxUo+UYUKo+QqFG2w8oYtZ5ArQm4
 rRAdd7tgAW23ty9+sY8YjZgPlEi17BWf+17PwCZgCNwJFt
X-Received: by 2002:a05:600c:1550:b0:490:48a0:b87a with SMTP id
 5b1f17b1804b1-49048a0b90dmr445022045e9.9.1779991397912; 
 Thu, 28 May 2026 11:03:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909236ad1fsm58164965e9.5.2026.05.28.11.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:03:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 17AEE5F92B;
 Thu, 28 May 2026 19:03:16 +0100 (BST)
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
In-Reply-To: <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 28 May 2026 09:41:40 -0700")
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
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 28 May 2026 19:03:16 +0100
Message-ID: <871pevqumz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 5/28/2026 3:13 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 5/26/2026 11:17 PM, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>> <snip>
>>>>
>>>> What do you mean? I run check-tcg all the time.
>>>>
>>>> Which containers fail to build for you? The main cross-compiler one
>>>> (debian-all-test-cross) is built all the time.
<snip>
>>> I'm a bit tired of seeing patches in your subsystems get stuck for
>>> weeks, without any proper review, to finally be (re)posted again in a
>>> new series, blocked for more weeks, and finally reach upstream one month
>>> later or worse. It's truly exhausting for everyone contributing in such
>>> places.
>>=20
>> What can I say - reviews are welcome. I always list what patches are
>> still waiting for review in the cover letter. I should also add for
>> testing/next I try to be extra careful that regressions don't slip in
>> because keeping the testing sub-system stable is important to support
>> things like bisection.
>>=20
>
> The main issue with your personal workflow, which is "reposting existing
> series concatenated in a new single series", is that it adds a lot of
> latency. Basically, if one patch fails, or is not reviewed, the whole
> thing is blocked. And that is a problem. I don't see what it's supposed
> to achieve, since it's halfway between a series, and a PR, without being
> one or the other.
>
> TLDR: the problem is how long things are between receiving reviewed-by,
> and being in a pull request in your subsystems.
>
> For instance, in current series, there are multiple sub series. Some of
> them are fully reviewed and ready to go, they can be sent as PR
> independently.
>
> I remember you mentioned several times that you like to have a "single
> branch". I have the same workflow, and it absolutely does not prevent to
> send multiple PR or series in parallel.

I do split stuff out when it makes sense, but look at testing/next:

e02df7f4810 * testing/next MAINTAINERS: Cover python.docker with Python lib=
rary section
4fcb3a8c07a * MAINTAINERS: Cover debian-tricore-cross.docker with TriCore s=
ection
b554638aea6 * MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa sec=
tion
8417a661600 * MAINTAINERS: Cover debian-loongarch-cross.docker with LoongAr=
ch section
0f57fbac5bc * MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.dock=
er path

Maintainers updates aren't critical to get in now.

f80f388a538 * gitlab: update issue template for binary test cases
4e7de923722 * gitlab: add MacOS 26 job on gitlab runner
e0692ad4b23 * gitlab: add initial MacOS 15 on gitlab runner
1299b5aec2f * ci: drop cirrus MacOS build

None of these matter without bellow

dd2db9273be * accel/tcg: move jit thread manipulation into do_tb_phys_inval=
idate

b60553095bb * tests/Makefile.include: add binary dependency to run-tcg-test=
s-% rules
bcde94b9315 * tests/Makefile.include: fix typo in comment

Why take the chance to break the build when the changes are in service
of the wider patch? The more runs through the CI to shake out anything
the better.

> If tooling is the limitation, please take a look to those (ugly) scripts
> for inspiration. AI can probably rewrite this better than me in 10 min.
> With this, sending a series or a PR is a complete no-op for me, I just
> wait for CI to run, and send it when ready 2h later.

Tooling isn't the issue - but I'm never going to be doing multiple PRs a
week because each one has a degree of latency due to CI coverage.

> Saying "people have to accept my tempo" is not acceptable. Fix the
> tooling instead.

I think it is fundamentally down to the maintainer what tempo they are
happy and able to work at. If you wish to take on responsibility for more
areas of the code base then be my guest.

>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

