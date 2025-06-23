Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC2C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 19:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTmsO-00088L-0k; Mon, 23 Jun 2025 15:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTmsL-000885-5M
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:30:41 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTmsI-0007dJ-MS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:30:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so6913676a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750707036; x=1751311836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEtMSXrNDxpUtZIIh+Y09rP/tmIdJ2AwBKCMtmK3JmA=;
 b=TdxaoJpsbxbQOgqh33my1MpoqxkcFXz7fqRIWhe/Zb2EwDc0HuaSqglYrUSvO/cVM7
 /ZBUxoFcpO4YkAdivutoCNiyZg+wP+QJioEq1Bq89EWA4J4zPb24PcHymw73HiQYN6ad
 9NOcF0dOcQxZI54CHfjSYT+zxxc49tNWTYx5MJS34aWosn+homlEWaJ9qtGsHhgPKiQS
 voyt/25SKFLCUrRbmA2LVXdR+BgCzF6q2ceazeLpxzY9tXyg1LqREFE+duoGu23MN+UP
 WLIA9RphF5O1coDJBAefAUHimweRCA9478pGUI3DRFklQeygouB45miDwlLi8G+AtSiO
 KORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750707036; x=1751311836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEtMSXrNDxpUtZIIh+Y09rP/tmIdJ2AwBKCMtmK3JmA=;
 b=VswEcYJDjgG2bebojhOwVRd+Wem6YV3PjwWmv6JAo/JXDhxlPpF6GWe8lVmgXsor7Z
 WF+eEho9Bcw6wr6YS7+75Yw7+9fVoKVpz+TFM+IB8fbDotUGEw5Cl9Mx1QyZa/1B2Mdu
 zCtC90g7jyAZ1s1+wJEjoJy3p2ZxdvoseA7gdSSFjBWSseUo+wc5JY0HSu9818rj5KAy
 BUxOqVZqX2YFGgAlZZU0mHR6fUXJd/BHdFTs36hk+J8SprVfJVSVHDUMCMDNloykfPf4
 zQro2qG5lPKxQWF5lV9xuB9pIiENXZ0holrbkyOGl+FvRooI0HfQ2XvpBVE9KbdpG45j
 M/pg==
X-Gm-Message-State: AOJu0YyPfgUoKaccochQ3d1N9CSUoeegYUa657mayq9Rv/9CATZdnMhW
 TecsRYJeDL2psGDjDyEffFTQbypYpsDFFWpVjv49HlAYI9q8ZgkLu8wgPQa8LyY1CbDcb6zh65V
 UG31u+fr1+jIdzriQ/Je3qR8QQkPWsFk=
X-Gm-Gg: ASbGncsCcPBYlSu4GtLJ8lr+ovh0q7ylJoH/DpYEb9kO51ndPl5rHXVRf0PIZ7Cc9sL
 2CqqeL/jTu+DESq3oakKO7YMwOz3vgS7GfvdZYBIiRz/wzfBXltdatSktOlGsO81MWrC2Y05ouD
 v4l9PxwWV4Ie4L/1C4PIwvXA0O7PPxCCMX3l1rgNFySA==
X-Google-Smtp-Source: AGHT+IGadOv8prPe2PFWnrEwZdlHNQul2ysb1a7swRAbTLmzpBjM05FGLerZNnBMOKT997KpZRg3057rkdW7H+LGd3Y=
X-Received: by 2002:a05:6402:13ce:b0:5fb:e868:8730 with SMTP id
 4fb4d7f45d1cf-60a1ccbcbe9mr13276116a12.10.1750707036126; Mon, 23 Jun 2025
 12:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250616092241.212898-1-armbru@redhat.com>
In-Reply-To: <20250616092241.212898-1-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 23 Jun 2025 15:30:23 -0400
X-Gm-Features: AX0GCFuBO0XOIMpFALGqMCpIMw9iszeSj5X8lBdWDbfI4ErL7XB1gihBRqelJWU
Message-ID: <CAJSP0QV=mfmUt7s+iBkJtZsLiNd1v2c6tNrZeG8htBs58JHhrA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] docs: define policy forbidding use of "AI" / LLM
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
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Jun 16, 2025 at 5:27=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
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

Any final comments before I merge this?

Stefan

>
> Changes in v4 [Markus Armbruster]:
>  * PATCH 2:
>    - Drop "follow a deterministic process" clause [Peter]
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
>
> --
> 2.49.0
>
>

