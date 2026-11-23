Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0B606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K+IwcN9W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVafR-0003Us-Sl; Mon, 23 Nov 2026 15:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVafP-0003TP-EN
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:29:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVafN-00015u-F3
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:29:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so36775045e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795465771; x=1796070571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tZz399pSNMVOWWeTC5xSNdVRaIZTN00Helj0Tneu61U=;
 b=K+IwcN9WA/zO+38PdOcyfN5rAcNcEPsFeJ5FxTesGvEZFJ0WFgOlDVRcmRlMlZRSEN
 OL4kYF1IYm9l0dm+tVjjMdN1IaQ+z1+rMEQz6l//7yYHa9jAK3PBGELC9kqUfP0yyK6P
 expRtyctUwTIzhJbNRy0R5G01faTUWoxC7KlAgxrad47hy+FHmO0ugNJNKCRI/30XyM4
 wAq7qbH9nv2gkJnmQj0qKwrepLow4HR5iWLsy4uePPquLz/F9kPXVgfCNo7gi6ntagBz
 NIi2h64iW1bsp2AUDsLMY9VyOm1zNhJe109rkc/Beej+qB/1wOt2g7MKXx5oh9CPu2Kd
 jiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795465771; x=1796070571;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZz399pSNMVOWWeTC5xSNdVRaIZTN00Helj0Tneu61U=;
 b=r4m2ThJpVmKKBQy8xIdaJ9LUXj3dia6kOh/L4SVbnWv0qmRRDH+T/tRnO/dv2kKpmi
 U4N2JIijiu9Lg6pOaflM39Dp0ZtBQao4dBZLbLPZ/2MB6TNhBJ+44NZjtWnQoHFDgq74
 A2ZhP0++qXd/CLONwdaFegAg6iYBFSBSd2IsmO7bRD2R+ETJLUtXpUEuGQrBE2ZU95of
 yATjbeoJaXhzY2Yu1IWayrmiQeSrd29XTfF+h4xb/zRCcD5dkQZ7ud4U8fpE9AtNJrjy
 cuStepadnS3uGlYWZ1935K4RKz/wRN1COtyVhYFyAXePTpaT8SwIAusMZG+YgyTNjSAF
 EuCA==
X-Forwarded-Encrypted: i=1;
 AL+hErHUFRD6PSHDexwhC6sodC5u0gmcizNt+rywR/oXN7NweYPSYwO1LqKOuvHkBot8+a7lUL5vJH6IusN/@nongnu.org
X-Gm-Message-State: APuU4Z/IvfREvMn+p654zGb9NpXUl3Cza/cWzxfxGTOGGyi3PgA518eY
 qhUbOpUsn3TzlBrj/+smGRP3ZthT8THfuyULvuE5JMyEe4XXQvFGYh+Fst/1JEoWvJU=
X-Gm-Gg: AZFdTZcFVnZTmTzhT2si4WpfuiItXHg4ewo/VTrl5+1BMRFOT0z9Vd0oQ1lSJsNxAgl
 lR9vGbJ0hD3qlmkRwsu6+UhRplTH/gjPPe/dFUk/JebMBArOPnfDyexGdG3JrpobNdTH4mj+vOb
 KTmnoM5nCkmO99GFg1fLRRzXRlA811AbhXio9ZgOmExCfasafL63U7aE6rPkJoKpWYq2MrGobr+
 9+GXies6wyaT6P+mlgFK50TD9bilE0ANsc0riyahPUXdHOtoWGHzmc0lnEeoaRghrgWH1E34B8a
 3FmH/Vgrzj4zGEUOVApM6FBNlQnoS/r1dfxAfMAgM8rDrd2m0suqg3pnbwlXEbmIDVMxqlo4/aY
 OGov7Fgg/R8Bldyx2MeUOZVnMepSJFjq2akTDBuTu9UfPgUFv3/TpUFBZUVkhPtLDiecBWCqEww
 +6U+Dj7EZzP04DOddpP8OBKFHsf+TNZimVTBqaT3h0gP+gkcNu51+Uwl6uwZlqaMKJFS+6lOi/E
 LXJcyuDREZ+oPjZL/BNNT/0hxcSNvy54wgEvpH02pnqi+xCRdfa/wWLIjwfvbIN8ZXKxD8/GBIa
 IWvyN5m1/G+9HgsLa73KOFXD/+rl
X-Received: by 2002:a05:600c:6708:b0:4ba:7e6:53d6 with SMTP id
 5b1f17b1804b1-4bb88940848mr228468095e9.33.1795465770945; 
 Mon, 23 Nov 2026 12:29:30 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm370577145e9.5.2026.11.23.12.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:29:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 051E95F914;
 Mon, 23 Nov 2026 20:29:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Warner
 Losh <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 23 Nov 2026 17:17:35 +0100")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
 <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Mon, 23 Nov 2026 20:29:28 +0000
Message-ID: <87y0ajuw9j.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Mon, Nov 23, 2026 at 2:19=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>> >> Even larger QMP interfaces may fall under bullet #3 - parts of large
>> >> code changes - but you definitely get a vote if there are substantial
>> >> changes to code you maintain. No doubt about that! This is just normal
>> >> interaction between maintainers; I think we do well in that respect
>> >> and I see no reason for LLMs to change that.
>> >
>> > This is a new situation with LLMs though, and it ties back to the
>> > SFC's (IMHO impossible) guidance that is included in this patch:
>> >
>> >   "the project seeks to both support those contributors who outright r=
eject
>> >    generative AI systems, and to not shun those who choose to use them=
;"
>> >
>> > If the contributor wants to use LLM, and some but not all maintainers
>> > do not, then we've got an impossible situation where someone is going
>> > to come away quite unhappy.
>> >
>> > I don't think the proposal to allow pre-arrangement between contributor
>> > and /a/ maintainer is workable, unless we accept that manitainers of
>> > common code are just going to have to accept the result.
>
> I see your point better now. IMO it's up to the maintainer who
> initially agreed to review the patch to understand the issues that
> arise. The maintainer can do an initial pre-review of the code, can
> take on himself part of the yak shaving, can figure out a way to
> reduce the scope back to something manageable, or can just say sorry.
>
>> > There are plenty of examples of series which start off self-contained,
>> > but grow into changes in common library code maintained by other
>> > people. Often the maintainer of the common code won't get looped in
>> > until v5 or v10 posting of a series.
>>
>> Matches my experience. Such growth is commonly due to
>> reviewers demanding improvements.  The reviewers are
>> commonly right.
>
> I agree, it cannot be fully anticipated. However, in many other cases,
> the changes are there from the beginning, thought to be "small", and
> the second maintainer is only looped in late because of that. This is
> already an antipattern, and one that (like most bad things) LLMs risk
> exacerbating.

I have no problem expanding the requirement to get maintainers buy-in if
the series expands beyond its original borders. As you say we should
discourage over eager changes across API boundaries anyway and we are
taking baby steps here so can LLMs.

> The maintainer who is first approached can ask to see a
> diffstat, loop in other people, etc. both without and with LLMs. And
> in many (more?) cases the changes can be expected to stay
> self-contained.The series I posted at
> https://lore.kernel.org/qemu-devel/20261118122357.659634-1-pbonzini@redha=
t.com/T/
> is an example of something that is *really* large but can reasonably
> be expected to stay within the scope of a single subsystem. Perhaps
> there could be interactions with "make check-python" but those are
> very limited.
>
>> > By that point the LLM usage will be present throughout the
>> > patch series.  There will be way too much pressure to accept
>> > the LLM usage in the common code, for the other maintainers
>> > to be able to say no.
>
> On the other hand: people are already reviewing *clearly* LLM-produced
> patch series (example
> https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNUGU5=
5pcQphR5s81aQ@mail.gmail.com/T/).

clearly? My reading is the cover letter is thorough but its not giving
off LLM vibes to me. I've only eyeballed the patches themselves but they
seem thought out and split into nicely re-viewable chunks. If it is AI
it certainly seems to be in the hands of someone who knows what they are
doing.

> Doesn't that produce the same kind of peer pressure on core
> maintainers, in fact even more so because they are not warned in
> advance?

I certainly prefer up-front declaration of usage because it would inform
my approach to review alongside the experience of the author.

>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

