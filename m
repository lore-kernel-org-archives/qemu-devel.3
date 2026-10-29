Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C6606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1LBEDNK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQhQ-0004v7-Nt; Thu, 29 Oct 2026 10:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMQhP-0004uy-QK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:01:47 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMQhO-0003x1-0h
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:01:47 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-33fb4680717so1359844eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282504; cv=none;
 d=google.com; s=arc-20260327;
 b=YC6CLQFNnIeBwoBeJyJ8dA2r2DUoy6iYEyzbDXzO7wXhVwTP/5wsTLLBchLs9Ra1d8
 oDMfL7yDO48Ol5p9h2yxvIXbYOMkdE29HjgdI1wyVcfb4dAZbXOTSdTW8KpjDVwgtpys
 PS6b8mBG30wgx5F7MRogouKPbRRNTxxWhPR/rhFFPSK1u/RrWqkQ4G3HntYydWLPdeqV
 qVucqm8NJbQ4jLClEcQN778ff1J8y2rx8REQp8rq9a404REzESv7WbbDnJQWmTUiz0X/
 eGswMSrY8iugJU/sZRo+4obgt0ZVwE+Q1hA1MU2nHk1L35jURpaXnBPmNI7di7eNrYih
 4QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VlKZgRi8dnxBW9ZFmBTvUPhmsHgyloIUdhrjGqYuOJI=;
 fh=sbxuPqjMywa3JYEGeYJMyo5ksfdP/w06LeNzDEfn49s=;
 b=MuBInAgO4Xv7qlW6ydgODg8vPJbmx2HMJCDeEAMEhEBdbW0Mld0Ha762pWxoulbtEE
 uN7Zyx1ivOnJ7hIP69nHSEdJa9B5Hjp6nvm2tIQjLfUeb032tVe3NoDYfKbvyx1B3L5u
 hTgE/7rLNw6DJlGL8LedRcqTZCywSl5JHRIIpmRTtZ/1N8xfSLzRJolDb/2c18eERc1E
 HiD+ulxnhiGEQqGp1Po0zY3XUzv8TQL/5Ks6dSt0n0eKFHbRrgiXF0WHJnR9n158V8H9
 wLZdd92PjyhPj56TQtNJ80xmdhvBzGkrFEs+Uy+Yjpo7k5YSH/zRrW835VDMjaoL8VP7
 qDhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793282504; x=1793887304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VlKZgRi8dnxBW9ZFmBTvUPhmsHgyloIUdhrjGqYuOJI=;
 b=I1LBEDNKLTf/BH7rbumGD+mlqXFhNj6iFk+WKwRK7+TJU2+n0XJ/Wnl1jaeHXUA6MN
 cSj65HalVFYHTHuQRZB95AUeBe0O/QNGlN27zqtpyaH1kaa5tXXWq/HcAIlbu2r8vNOs
 WJS+/o8xcNZ/x9Tr/VHov4wqk46dIkeT7L3Rvp0Osw07EXcVyQv/v1klzB2JE+S8lilm
 G/yT6XLODPBDVP/TlaJ8GWH01Zs7eIZIc7u1O8V+3+bM8eJKZweQ0I4OVdtbh+zb3+x/
 Gsdn6pj62RbbH3SHamg8IVBRAaefPN/F0x20rDRbU/0sCKveGBZ0FkpmtXyQmn/GbdTf
 gZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282504; x=1793887304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VlKZgRi8dnxBW9ZFmBTvUPhmsHgyloIUdhrjGqYuOJI=;
 b=nuqjjDrY6WRiSkLNOGWd7G9qfttErefjWIRKVGVpiZ5bgHLZVPD8Ct+jwv2cOa+EZ9
 /6MyUxY+GArIbn6nzcd1t0jV8jikle3QVQf4/G9NW2NCLehxaaIT9pjjuMpvbmExQhk0
 Ae9NwhlVcyx7MUV3XveYZ7S+cRwo6UPBsJgFAtGSPdV1BzNhkIBMBGjsdsg1bsaIQJed
 uGfmxbNjuwU6fi6QsHSWAiqP4ETxSVHyVHZ6604em3LGfpk2QMOMQ+Z6AaLSSs3LLiAL
 vcgtADIzIBgUiRzwNpXgG+D7lncm5i+thVFtWCnPcUQnF6QK2YZacoqxMOj2uwlD/Shr
 i5Rw==
X-Gm-Message-State: AFq9FYJn5UqeJZFvuB8Jlr/Ibib6YQ6a7aCePpzZCYIVzJaEtR6hLUyo
 E7+D8i9kt/aQUwma8q9SON9NlxssvSSD8NCXXOX+Yx9vsF9dxydztcWc2jOzNH9NEgtIxGMMfRI
 ByCOcyeujTLsTYWFdI0XIxy2K02fKpbNwRUSCo3M=
X-Gm-Gg: AYBFou3jXpZC1MGwoEYOtw8eQNNDoVYia/GJ6DgSpphPAjrX4TtOH00iJ9HrvlQd8/h
 kobyHj2aZnmJfKaUL8bR9CdsuEQiXrm1QUr/urA11suqjuZ0nd73s8DWDC6aKrjQgY+X/ipC/cO
 yk1KlkdPQy4gdnJXACwzL7L8xGtDvUTvNpwSy09917wGgH/riqZ038N8Y155Pzm0O7AtRID6Pr9
 XsZoI1j3e0wUGgx5tPr8zBAcqOnQ/lQuGhtGLFaEfdhmIOhPjbsixOL4OZBdKehilIqx6RSoWfH
 oF3YLDlOZKGPMNxuJwFXVq+nPHg0EZ96FhjRlBtzyaogu66tCve7tcT8lQJFzHewhYkSRnagp9U
 Es8CrutwVRsWwoPkHNoOrNZjUqKqjSvUqBtBuZKpYF1dmXxxlPb8CEaGSgiCjnrCSqVet
X-Received: by 2002:a05:7300:d0a8:b0:36a:112d:fae3 with SMTP id
 5a478bee46e88-36a20469b0bmr7609148eec.40.1793282502492; Thu, 29 Oct 2026
 07:01:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
 <dd7ad5bd-fc4f-4b47-840d-84da04144d5b@oss.qualcomm.com>
In-Reply-To: <dd7ad5bd-fc4f-4b47-840d-84da04144d5b@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Oct 2026 18:01:29 +0400
X-Gm-Features: AclHuK_eLwpvtL27dFDlQS379fu_CsHFfgObEH7K_xY61X1d8M8J5sy6mtcBwsA
Message-ID: <CAJ+F1CL3edi4d7ftTSJH4H0sxbsO4vwBE5HVqqQv+=17J4B2DQ@mail.gmail.com>
Subject: Re: QEMU Sashiko
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 29, 2026 at 5:37=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
>
> On 10/28/2026 6:32 PM, Alistair wrote:
> > Hey,
> >
> > Sashiko just merged initial support for QEMU [1].
> >
> > For those who don't know, Sashiko is a LLM powered review bot used for
> > the Linux kernel. When people send patches to LKML Sashiko reviews the
> > patches and responds to the mailing list with any issue that it finds.
> >
> > Like all LLM tools, it is both useful, but also verbose, prone to
> > hallucinations and misses things (like humans do to though). The
> > general consensus in the kernel community is that it's a useful and
> > valuable tool.
> >
> > Sashiko is just a Rust application and prompts, it doesn't include a
> > LLM and you can use a range of different LLM backends.
> >
> > Google sponsors the development and runs a Linux instance. So you can
> > see the hosted Linux instance here: https://sashiko.dev/ and it uses
> > Gemini for the LLM which Google pays for. It seems like there is also a
> > GCC one starting up.
> >
> > The cool thing about Sashiko though is you can run it locally as well,
> > so you can use it to test your patches before sending them to LKML, as
> > long as you have a LLM backend you can use.
> >
> > So, now that Sashiko also supports QEMU there are two exciting use
> > cases:
> >
> > 1. Developers can run it locally to review their patches before sending
> > them to the list. This can catch issues before sending patches
> >
> > 2. Maintainers can run an instance to review patches. How you set this
> > up depends on the maintainer and how many tokens you have. Pointing it
>
> The one time I tried Sashiko (on kernel patches), it seemed to consume a
> mindblowing amount of tokens.  Which model(s) do people normally use
> with this?  Local/open-weight ones or commercial ones?  High-end or low-e=
nd?
>

indeed, I just ran it on 1 patch
(https://patchew.org/QEMU/20261027160606.2668607-2-marcandre.lureau@redhat.=
com/)
with DeepSeek, 7M tokens after, only to give me a Low report that
isn't even quite accurate. It makes me wonder what it's doing compared
to a simple harness like pi (which would typically consume ~200k
tokens for this sort of review I think).

> > at the list directly and running it for all patches might be too much,
> > but some combination of manually triggering it for certain patches
> > seems to work well. The Settings.toml file can be setup based on what
> > you want to do.
> >
> > The hope with this is to save maintainers time as Sashiko can catch
> > issues without requiring much time from a maintainer.
> >
> > QEMU support in Sashiko is very new, so it will take some tweaking to
> > improve things, but it is at least a good starting place.
> >
> > 1:
> > https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d451738591=
6e6c834d8176f70
> >
> > Alistair
>


--=20
Marc-Andr=C3=A9 Lureau

