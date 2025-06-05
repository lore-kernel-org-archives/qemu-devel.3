Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33310C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN99Q-0000Je-Jz; Thu, 05 Jun 2025 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uN995-0000I3-Pz
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:52:35 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uN993-0002A8-CI
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:52:31 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-601f278369bso1748627a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749124347; x=1749729147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uqgykc7UBmH7xBrBNtq1nP0rUTs+615TgxgB2uBXjk4=;
 b=C8lQM9MnD5EJMgU9I1yQPTPNCIfcm/Nv3cor5row59j1MlCqH/jpyi/wkkAlYw1ZA5
 2hXwuXgPO9fhsv70KlSVOpE5u8fEHGa/Wh7Axybz6WR/vN2NTQ3N3W8B5uTB9q4ig+Vb
 /X2gjR9nAvjeuLd76Mk2tkUxlytX5fBuYdXF1RyjCCP4aUO/1/O5kbdY2DP5KHOLMLeU
 X+oYAC+YQi0Dl9ReXGJapHSMq52qJcxePlrBGMsPSrY+pDxCvJmldPMfAATdfipcQkbV
 X7bf6zN62DVo7uY6BTmyKAQpfGOj5Z0kxUl8272w7OmHmVEng/PJinRZ8da20xzZcz46
 H1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749124347; x=1749729147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uqgykc7UBmH7xBrBNtq1nP0rUTs+615TgxgB2uBXjk4=;
 b=tWmUnHM7oNXCi7lK3tshwEfhre3IOTZQuj924727NHOr/6I8RuFyCo970cELu1RID1
 SUC3Hysax/eyXxSj7J0WizR4rpaK1qCrwELn8gWX1ExwtKyvd9MAfhzSWnWjk5DnC2tj
 dDn3IIrQKs6pQ1Hdonj8U9yBiRJqfzigx4+3aPmOodcSXFxloazmcBuDRy4294BNxoan
 M74PtgmliR5+map+5yTGWsyEn4vQGdmX+zE20b42SuWuTnE2cP5VLZx/qn9wVpKXLUf6
 LhUb62v8NXOjQctDhHO1Ujg1ooOLZ/j1bhUTR0uCAfBUU0WsReriEnVkJ4Uc8ECl31mA
 XePw==
X-Gm-Message-State: AOJu0YyQonp3VmnvTCwjRznbzOAFAwwDdmuTNPouj8t6vM9LCfgQAAly
 HKXCdbULOZ8iYvicmolnDgYkpfaCD5bnbvxG68RxEQH/zCPQy+Iu20mOqHP/LJsBVyXBJQUfRkM
 5QhQqP6UaND1Dc31gOAC13HJlbNN3HRbArw==
X-Gm-Gg: ASbGncug+c781ua+OZ2OWuJ3RzttDTJAcdvtt5UfHSJhvn1sC5zeya8LhaIP7oXqF2S
 hvTRRaHSo8oOjuW29H2ORZST7dWdrgYObc/KOabiFZz03NZ955X6jyPsLWrJfChZFRJKCEUEt1b
 GIeHlSM95XmOptApNXXTj/TnrJSQrC5ho=
X-Google-Smtp-Source: AGHT+IFFrC3TsxXgdgo3SpGjqAbT4EjVmpFST8RmYVmDKss7mPAMi7xtGBXhyk+VdCTv66Fj2nFZzoQrlQWCXoIkEnM=
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id
 a640c23a62f3a-addf8c30aefmr589620866b.4.1749124346484; Thu, 05 Jun 2025
 04:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250605105219.261925-1-armbru@redhat.com>
In-Reply-To: <20250605105219.261925-1-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Jun 2025 07:52:14 -0400
X-Gm-Features: AX0GCFu2UCWkJDEFExS8qCRLS6IcnLpPQgKIFpQtPzxQu9eAxKpJzGVyAS5I5-k
Message-ID: <CAJSP0QXqSsqxq57TWN0KZGg7-q_gkksb95rF16bAyyBUmQr+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 5, 2025 at 6:54=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> More than a year ago, Daniel posted patches to put an AI policy in
> writing.  Reception was mostly positive.  A v2 to address feedback
> followed with some delay.  But no pull request.
>
> I asked Daniel why, and he told me he was concerned it might go too
> far in its interpretation of the DCO requirements.  After a bit of
> discussion, I think Daniel's text is basically fine.  The policy it
> describes is simple and strict.  Relaxing policy is easier than
> tightening it.  I softened the phrasing slightly, addressed open
> review comments, and fixed a few minor things I found myself.
>
> Here's Daniel's cover letter for v2:
>
> This patch kicks the hornet's nest of AI / LLM code generators.
>
> With the increasing interest in code generators in recent times,
> it is inevitable that QEMU contributions will include AI generated
> code. Thus far we have remained silent on the matter. Given that
> everyone knows these tools exist, our current position has to be
> considered tacit acceptance of the use of AI generated code in QEMU.
>
> The question for the project is whether that is a good position for
> QEMU to take or not ?
>
> IANAL, but I like to think I'm reasonably proficient at understanding
> open source licensing. I am not inherantly against the use of AI tools,
> rather I am anti-risk. I also want to see OSS licenses respected and
> complied with.
>
> AFAICT at its current state of (im)maturity the question of licensing
> of AI code generator output does not have a broadly accepted / settled
> legal position. This is an inherant bias/self-interest from the vendors
> promoting their usage, who tend to minimize/dismiss the legal questions.
> >From my POV, this puts such tools in a position of elevated legal risk.
>
> Given the fuzziness over the legal position of generated code from
> such tools, I don't consider it credible (today) for a contributor
> to assert compliance with the DCO terms (b) or (c) (which is a stated
> pre-requisite for QEMU accepting patches) when a patch includes (or is
> derived from) AI generated code.
>
> By implication, I think that QEMU must (for now) explicitly decline
> to (knowingly) accept AI generated code.
>
> Perhaps a few years down the line the legal uncertainty will have
> reduced and we can re-evaluate this policy.
>
> Discuss...
>
> Changes in v4 [Markus Armbruster]:
>  * PATCH 1:
>    - Revert v3's "known identity", and instead move existing paragraph
>      from submitting-a-patch.rst to code-provenance.rst [Philippe]
>    - Add a paragraph on recording maintainer modifications [Alex]
>  * PATCH 3:
>    - Talk about "AI-assisted software development", "AI content
>      generators", and "content", not just "AI code generators" and
>      "code" [Stefan, Daniel]
>    - Fix spelling of Copilot, and mention Claude [Stefan]
>    - Fix link text for reference to the DCO
>    - Reiterate the policy does not apply to other uses of AI [Stefan,
>      Daniel]
>    - Add agents to the examples of tools impacted by the policy
>      [Daniel]
>
> Changes in v3 [Markus Armbruster]:
>
>  * PATCH 1:
>    - Require "known identity" (phrasing stolen from Linux kernel docs)
>      [Peter]
>    - Clarify use of multiple addresses [Michael]
>    - Improve markup
>    - Fix a few misspellings
>    - Left for later: explain our use of Message-Id: [Alex]
>  * PATCH 2:
>    - Minor phrasing tweaks and spelling fixes
>  * PATCH 3:
>    - Don't claim DCO compliance is currently impossible, do point out
>      it's unclear how, and that we consider the legal risk not
>      acceptable.
>    - Stress that the policy is open to revision some more by adding
>      "as AI tools mature".  Also rephrase the commit message.
>    - Improve markup
>
> Changes in v2 [Daniel Berrang=C3=A9]:
>
>  * Fix a huge number of typos in docs
>  * Clarify that maintainers should still add R-b where relevant, even
>    if they are already adding their own S-oB.
>  * Clarify situation when contributor re-starts previously abandoned
>    work from another contributor.
>  * Add info about Suggested-by tag
>  * Add new docs section dealing with the broad topic of "generated
>    files" (whether code generators or compilers)
>  * Simplify the section related to prohibition of AI generated files
>    and give further examples of tools considered covered
>  * Remove repeated references to "LLM" as a specific technology, just
>    use the broad "AI" term, except for one use of LLM as an example.
>  * Add note that the policy may evolve if the legal clarity improves
>  * Add note that exceptions can be requested on case-by-case basis
>    if contributor thinks they can demonstrate a credible copyright
>    and licensing status
>
> Daniel P. Berrang=C3=A9 (3):
>   docs: introduce dedicated page about code provenance / sign-off
>   docs: define policy limiting the inclusion of generated files
>   docs: define policy forbidding use of AI code generators
>
>  docs/devel/code-provenance.rst    | 338 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  23 +-
>  3 files changed, 341 insertions(+), 21 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

