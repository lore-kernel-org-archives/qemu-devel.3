Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AABECD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 07:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnOG-00046U-Om; Fri, 15 May 2026 03:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNnOC-000463-Eh
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:55:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNnOA-0006vW-HI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:55:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso4274387f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778831714; x=1779436514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zi+jHsGDDc0WKjYxfz2qk2cVKBzn6/2CQT7bKy12gI=;
 b=i0U6ukAFirxuzGCJFEzwEWR7MaaqZS/ZmZY3lmOdcAW0DsmPIcB8FJGkK9UdR1KrG7
 wyK6O1i93RpApoez/3+H3XUcJ/7PxrySRUbN/YP4Cis5BBlg65my2cYbe9/x3Gihw/+n
 kqwccz0Gm0QGnmgkCP2rSwwm+piYFk5Wd7tV6dYOAucwrFBGecV798wly6FTf6V0zIxH
 xEwoZu8JUTjZHygMmsNSV8m47cqBGMAxcziLufi9cXgo63CvZZ76z+qel4gYOpLu2aeW
 MetnHIyYxyvqnIQNPlOsYIXd6TwUZQJXkGbQ17xWhCHO+eP6MjJ7SN6apnCwSGTquu6m
 ooNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778831714; x=1779436514;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Zi+jHsGDDc0WKjYxfz2qk2cVKBzn6/2CQT7bKy12gI=;
 b=RFbIPxXymuwlN477TBjBErPTVWhUrrlafagVZhFmXXWJ+eK9oF81wHV8gb8VvCRb/3
 Hs19CuKJAEveQMI4z7h/Xqz8umfxTlepO4143cD5DXXHY1pkgQL+vd/TdwsNGHBatZ3H
 eTeC9Hyqo5FXSe0i1u/4WjKTS5gqP8DMfUwiKRB25Uzacg5YMwVHAsY9vZgmRMdX4Uep
 Ez/n9jmrtC+43DuGpxkMr+YxcyrlEfLPqsUPvNIgoUjp3evlOnSo1kQ5Xqr+sssnXoTo
 1IJrwWCJejPx3UvXd0lrCtvDsVo95be2mCcBH7mCDxfZO4LaHNTmsHqO4aXaVhnWnOg+
 0Ciw==
X-Gm-Message-State: AOJu0YzBVdxq1WGxis6Q7Iobe0Zh99Bws4ukrjsKmm3YPkasTGj6HBUR
 MbdsFfzi/v5PLE/4qyQGZEem1aQvuHAQvsPGOxU7vME2xq66TI9VN2DTCIyPRxQfzb/ToxEoB4V
 W7opuzSs=
X-Gm-Gg: Acq92OHlXVhbGWdCt1yZ1lv+XtNwJJealtfRwmWwzzDJoU0TsZ76LQ/xPDJwJmPk2k2
 SNx94xlUpqPcbyK+AD1Zas1riDIik2aPerux95FLWItLo+H2pOKs5tBSKUlW20rWWfR1r5Fc4Z1
 zWweztYeoMJJLaQJ42bGE5sS85xjTFfgMA6/qmLqLg1cRBQX80NSn+8N7YoTtQ2NyvSv9jOHs/w
 EHlx99OE4xTowS7akKFlbHeTVeNTlWn8bLn09oxI12/8NczSiEnJ/acHp2bFOaIQZ2O8R8VOK6o
 IcNnIowNydFcR0Wy3ZB7OCS+N8G2oNWzisEQM1Vaq6+A1IGkeUnvA3E5Q1leAYcnL0E0cRpUikV
 tnLe62SOmucwF84iNrQW9wjGvBN0rbHABBOGhp9Fcj8hEu58aOHHGHdb75vWc5fIiR4pcLK3fr2
 Pgr6LYE8o7SwR4H/tf/GBcqvw=
X-Received: by 2002:a05:6000:1ac7:b0:452:6aaf:76cb with SMTP id
 ffacd0b85a97d-45e5c57d369mr3456829f8f.1.1778831713852; 
 Fri, 15 May 2026 00:55:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6454sm12319245f8f.34.2026.05.15.00.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 00:55:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A0955F811;
 Fri, 15 May 2026 08:55:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] AGENTS.md: add basic AGENTS.md for QEMU
In-Reply-To: <agaXcTwX9PiV6Mqr@ZEVORN-PC.localdomain> (Chao Liu's message of
 "Fri, 15 May 2026 12:26:18 +0800")
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-2-alex.bennee@linaro.org>
 <agU4-pUgXDvyA2dI@ZEVORN-PC.localdomain>
 <87bjeicxbi.fsf@draig.linaro.org>
 <agaXcTwX9PiV6Mqr@ZEVORN-PC.localdomain>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 15 May 2026 08:55:12 +0100
Message-ID: <87zf21ayzj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Chao Liu <chao.liu.zevorn@gmail.com> writes:

> On Thu, May 14, 2026 at 07:36:01AM +0100, Alex Benn=C3=A9e wrote:
>> Chao Liu <chao.liu.zevorn@gmail.com> writes:
>>=20
>> > Hi Alex,
>> > On Mon, May 11, 2026 at 06:04:50PM +0100, Alex Benn=C3=A9e wrote:
>> >> This was written initially written by ECA based on its understanding =
of the
>> >> code base. I then expanded it with links to the various documents and
>> >> the general coding style.
>> >>=20
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >>=20
>> >> ---
>> >> v4
>> >>   - will add AGENTS to list as we go
>> >>   - moved QOM, QAPI and trace details into qemu-code-explorer skill
>> >>   - add section on Security policy
>> >> v3
>> >>   - More MUST
>> >>   - Remove build and test in favour of agent reference
>> >> v2
>> >>   - more build details and source overview
>> >>   - more on commit style
>> >>   - give plan files a place to live
>> >>   - add Daniel's agent suggestion
>> >> ajb:
>> >>   - I made a slight tweak to use pyenv to run single tests
>> >> ---
>> >>  .gitignore |  1 +
>> >>  AGENTS.md  | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>> >>  2 files changed, 79 insertions(+)
>> >>  create mode 100644 AGENTS.md
>> >>=20
>> > Do you think we should add CLAUDE.md, GEMINI.md, or other agent-specif=
ic
>> > prompt files that simply link to AGENTS.md, to better support different
>> > agent CLIs?
>>=20
>> Surely all the mainline agents will read AGENTS.md by now?
>>=20
> That's true, but in terms of skill compatibility specifically, there are
> still some subtle differences. I ran detailed tests on opencode, claude,
> gemini, and codex, and here are the results:
>
>                        | codex    | claude     | opencode  | gemini
>   ---------------------+----------+------------+-----------+----------
>   AGENTS.md            | yes (1=C2=B0) | yes (fb)   | yes (1=C2=B0)  | no=
 (1)
>   .agents/skills/      | yes      | no (2)     | yes       | yes
>   SKILL.md             | yes      | yes        | yes       | yes
>   native dir           | .codex/  | .claude/   | .opencode/| .gemini/
>   x-tool compat        | none     | none       | .cl/.ag(3)| .agents/
>   auto-trigger         | yes      | yes        | yes       | yes
>
>   (1=C2=B0) =3D primary, (fb) =3D fallback.
>
>   (1) Gemini CLI natively reads GEMINI.md, not AGENTS.md.  Redirect via
>       .gemini/settings.json: { "context": { "fileName": ["AGENTS.md"] } }.
>
>   (2) Claude Code only scans .claude/skills/; .agents/skills/ silently
>       ignored.  Workaround: symlink .claude/skills -> ../.agents/skills.
>
>   (3) OpenCode scans both .claude/skills/ and .agents/skills/ as compat
>       paths, in addition to its native .opencode/skills/.
>
> The current impl maintains maximum compatibility. If we need to fill
> the gaps, a good approach might be to add a script that registers
> .agents/skills/ for agents with poorer compatibility.
>
> Also, I'm still trying to test these skills with as many models as
> possible. I'll report back once I have results. Thanks Alex for the
> contribution.

Thanks for trying them all out. I don't think the model itself makes too
much difference (I've been using Gemini and Opus) but my agent framework
is ECA. I must admit I haven't tried any of the TUI agent apps.

I should post v3 later today with a split AGENTS.md (basic code-provenance
and security policy for merging, with the rest in a following patch).

>
> Thanks,
> Chao

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

