Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB33CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 09:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl3TC-0004Su-6g; Mon, 02 Sep 2024 05:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl3T7-0004S6-RF
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:35:29 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl3T5-0001a9-UH
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:35:29 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c210e23651so4160956a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725269725; x=1725874525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhKgpoDGiY++AMQHwQc2tRVqwgMwYSV8OERwKGYuCAo=;
 b=c9gDX3h+RlItL2HfKG2R6x5J9k93aaF1IzHGspJEwrVLchWI587DPRN16VYBWZpAfT
 27CPARVBT4iwJK5UAgOIv0+YVM9QeTEHfzkWs5k+btctWlJK9kPWkmo7EsrbszpX43nq
 JxqK2SO+YFFPoMlMamtsAX4cyJvS/BN/71pGCXgSe2EyPvx2VFusO1Gc8uGFxGai0yp7
 KXHPuEsb2dTKhC7363nlM4C8ujJpYbnYRQv9vWYFJaC+aHBBMmqJGasOBBEdCB+aIXVX
 wT2RrEEOCUMUWdg4lLgfPoBYLt9fBrawMu99de0H7v4w1mBsul7jTw3SNJmva6EXKWDJ
 PLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725269725; x=1725874525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhKgpoDGiY++AMQHwQc2tRVqwgMwYSV8OERwKGYuCAo=;
 b=FCPnGbwQy2/PVUDYWOmZmtT5tYafsxv4dhuu8E6qNWb6Gc/S7ufNczrGy3z00kzLMI
 fDkddfGmXz5cz0gekPi1w11CTOaH9GhuVSjTEZeb9BiUcKm/Ot6f7wF2443shh1WrrZm
 UipdJ6REczCFCK7443ZsL43L9Xi/F19fxRavkqHfjVjkQOYblY7kaMUgICaekx4tS9vx
 qNYMngD08rXoi+TrSptg+EBpTM+xsPoeF/sLrMG8yx1rbyqTgPIiLLxhVDcdR1/jLx49
 N1fjkbNC2qZ7Cbny3kzro3uAIFRraZD0YBQKaiGEWTJz95QARtSqMvK+oOA2BwLoYWhl
 RPWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5kkMRtIVTRaQQqilSF6btT76auoDFdquIi8kXQznnR7cq4hgZBVqoCtvWJlblBn3BpbinFpJo+JTg@nongnu.org
X-Gm-Message-State: AOJu0Yyp7v2zj2PCsJs3NBr/+SQyS6IwQ7suhdEQEENCv9iTC0ahDXpe
 wz/tkA/mQJaBQ9JhnIA0Q5cSk3wI+XlSDAj42WNQAnuW8d87+vqp9MocH0wymB4PVzHkm5Llomb
 MEjqPQ5Mguow17zK2sf60iu+ZUhL+vJYkdYDbuQ==
X-Google-Smtp-Source: AGHT+IEwH8eR+VPU9T8Y/mpxJQ9AoeQhD+dJrD9Q/TbD6kM2eQgpXqq16vIpFBOoOwSNr2ns79e19x4+bePoKiOS7OU=
X-Received: by 2002:a05:6402:360b:b0:5c2:60ac:fdd8 with SMTP id
 4fb4d7f45d1cf-5c260acfe54mr892434a12.13.1725269725118; Mon, 02 Sep 2024
 02:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
 <87bk1acl4s.fsf@pond.sub.org>
 <CAFn=p-a=ob68-_8fkfFMj2AkVtOgL081j4d385n1qXMsN+ehFQ@mail.gmail.com>
 <ZtV8eQfPyuuwHHkq@redhat.com>
In-Reply-To: <ZtV8eQfPyuuwHHkq@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Sep 2024 10:35:13 +0100
Message-ID: <CAFEAcA-s=aAtzKe81pkFS=u4e7K632yq4aybVf+sTMQ5kr+LOQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Sept 2024 at 09:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Aug 30, 2024 at 02:22:50PM -0400, John Snow wrote:
> > Gave Dan a related answer. For you, my explanation is:
> >
> > - It's nice to have just one configuration for static analysis in just =
one
> > place
> > - It's nice to have that configuration follow python ecosystem norms
> > - It's nice to use standard python management tools to configure and te=
st
> > the supported versions of static analysis tools, again kept in one plac=
e.
> > - Just moving the folder costs virtually nothing.
> > - Moving it here makes it easier for me to test the eventual integratio=
n
> > with make check in one place.
> > - I like being able to say that anything under `python/` is fiercely
> > guarded by high standards (and the gitlab pipelines) and everything els=
e is
> > not. I consider this to be organizationally simple and easy to communic=
ate.
> > i.e., I find it attractive to say that "python is maintained, scripts a=
re
> > YMMV." I am *not* willing to maintain everything under `scripts/` with =
the
> > same level of effort I apply to `python/`. I think it's important to al=
low
> > people to commit low-development-cost scripts ("contrib quality") that =
they
> > can run from time to time and not everything needs to be held to a
> > crystalline perfect standard, but some stuff does.
>
> FYI, I was NOT suggesting that you maintain anything under scripts/.
>
> Rather I'm saying that if we want to apply python code standards, we
> should (ultimately) apply them to all python code in the tree, and
> that *ALL* maintainers and contributors should comply.

To be clear up front: this is more of a tangential musing than anything
else, and I'm not making a concrete proposal wrt this patchset.

scripts/, like contrib/, is a bit of an odd directory structure from my
point of view. I don't think something happening to be a script
ought to affect where we put it in our source tree -- scripts/
is really more like "tooling used at build time and by developers".
If we had a user-facing utility that happened to be written in
python or in shell, that ought to go in tools/ I think, for instance.
To the extent that our standards are lower in scripts/ it should
be because we know that the audience and usage pattern for those
utilities is limited and so it's not necessarily worth the effort to
bring them up to the standards we'd apply to user-facing code.
(Similarly we're a bit sloppier in C code in tests/ than we are
in C code that goes into QEMU proper.)

IMHO half of contrib/ ought to be in tools/, and for contrib/
I'm particularly not a fan of having a bit of the directory tree
that's labelled as "put stuff here that we don't care about". Either
we care about it and it should go in the appropriate place in
the tree for what it is, or else we don't care about it and it
should live out-of-tree...

-- PMM

