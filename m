Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF5C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMWKs-0006Nn-Gw; Tue, 03 Jun 2025 14:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMWKo-0006NF-OI
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:26:02 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMWKm-0004JD-Ed
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:26:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-606b6ba36d8so1559938a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748975156; x=1749579956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5SeXtN7eedZ/YFgySCmIbCEdkC6JKMgh8WlOUxfZTA=;
 b=AQxzhOD8jGeu2+LUT33efpM7ba39HETtZ4w/nplscrUfZScOE1qL33VjqM/YONL0gK
 IB/T7MEQJ+gQgtdafyIZMenFBgaWFKdrrs+Bpk/S0C3MnH1yQRD6QLoVhtI5C2NEOPbN
 w94i4JDlm5THb5bD828WheZaL7HV/r0O8KHSK/gatkBkahDohhU67anNCpa5HnnN3Bbf
 uOV1OmXt8LfwDVe/jEv9mfEh/a3te7p8JK3xadj88kV2R4iPFSCkYd9al6dy0bxDmxn3
 Icbwj70OZlDKYozoQ06XhSkldS94ITFYpYcy9F5k6LSlm0jArmwyY6X6CrM3U5/II/36
 3/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748975156; x=1749579956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5SeXtN7eedZ/YFgySCmIbCEdkC6JKMgh8WlOUxfZTA=;
 b=eHs2pGg5jEWVh54XxV0GogSZtt37Bg5PNMtkwLNka3FZW3XewUR6bSK1ZUcx0BEe+o
 W6dSltJWryH7haw10hKWDYhgHtl4yPyUohzP6RJjSTG8nA+grfjU6iIZyRlbQKgen2fH
 rTlFl2BAD3ZjWlzkGvmhWJUWDC+C3rp0DBtCAxV2OVyfqUyg/xy54wnIVaF/Ne38xCKc
 YfUfSyz95vkGxgWw2TnqcctLtVRk5tL9GbijgyjibrmZ0MWsdpQjfYZzpaErd9a/F1+i
 PJ0Wikubn8YoAK5eIa3ocpkhBAw5lGsJXICw+nhzCDQ9e115iMmEJ+wRQKaqcJkPgaCp
 K+uA==
X-Gm-Message-State: AOJu0Yw8ok0hGJW6M78Ruq4tmLik6PCUf0a9kVAyDrmje65D+W08YNE4
 +vQXVSsOrTZp6wb48WuDWneNtHzLI1P8YC7+O77ber+AJjWIkZ8HQCTFHXtZJhFaNyBoJHbOg3n
 GqrWyhD0jwl1St0LQP1Pq6J3PA4bvP6Q=
X-Gm-Gg: ASbGncurBN3pGAlj1HJYwWGwjeX3ET1qaFd4btgmxOLTp9RG9yWgN9CbqX5Heu6mMWk
 4AE6qCS71WNMGC7mDnEQUgPOzQx1DI50hZe10EUGiqX2m3aND1chqJ6O/pZNPtVlWfsxLSOMDbp
 E+tUh4NlPiwEeLDrfm6BJq5WOq+ZN/QsI=
X-Google-Smtp-Source: AGHT+IHOtqaeFly5cN1WgIaFTp6vQpW04NwVr8UFwEyQXUNhrNUz+g3xu2DYEO2kYFuauSU7sNIpdHj9ES0/RAVl0u0=
X-Received: by 2002:a17:906:6a0d:b0:ad8:a935:b907 with SMTP id
 a640c23a62f3a-adb493ab589mr1198964966b.8.1748975155798; Tue, 03 Jun 2025
 11:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
In-Reply-To: <20250603142524.4043193-4-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Jun 2025 14:25:42 -0400
X-Gm-Features: AX0GCFsmBhuXx6iBY46hVuuLCMIzTvdoNE0QIQ338NbWvZZ5enx-4cergYcuE9s
Message-ID: <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> There has been an explosion of interest in so called AI code
> generators. Thus far though, this is has not been matched by a broadly
> accepted legal interpretation of the licensing implications for code
> generator outputs. While the vendors may claim there is no problem and
> a free choice of license is possible, they have an inherent conflict
> of interest in promoting this interpretation. More broadly there is,
> as yet, no broad consensus on the licensing implications of code
> generators trained on inputs under a wide variety of licenses
>
> The DCO requires contributors to assert they have the right to
> contribute under the designated project license. Given the lack of
> consensus on the licensing of AI code generator output, it is not
> considered credible to assert compliance with the DCO clause (b) or (c)
> where a patch includes such generated code.
>
> This patch thus defines a policy that the QEMU project will currently
> not accept contributions where use of AI code generators is either
> known, or suspected.
>
> These are early days of AI-assisted software development. The legal
> questions will be resolved eventually. The tools will mature, and we
> can expect some to become safely usable in free software projects.
> The policy we set now must be for today, and be open to revision. It's
> best to start strict and safe, then relax.
>
> Meanwhile requests for exceptions can also be considered on a case by
> case basis.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@gmail.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 50 +++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index c27d8fe649..261263cfba 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -270,4 +270,52 @@ boilerplate code template which is then filled in to=
 produce the final patch.
>  The output of such a tool would still be considered the "preferred forma=
t",
>  since it is intended to be a foundation for further human authored chang=
es.
>  Such tools are acceptable to use, provided they follow a deterministic p=
rocess
> -and there is clearly defined copyright and licensing for their output.
> +and there is clearly defined copyright and licensing for their output. N=
ote
> +in particular the caveats applying to AI code generators below.
> +
> +Use of AI code generators
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +TL;DR:
> +
> +  **Current QEMU project policy is to DECLINE any contributions which ar=
e
> +  believed to include or derive from AI generated code. This includes Ch=
atGPT,
> +  CoPilot, Llama and similar tools**

GitHub spells it "Copilot".

Claude is very popular for coding at the moment and probably worth mentioni=
ng.

> +
> +The increasing prevalence of AI code generators, most notably but not li=
mited

More detail is needed on what an "AI code generator" is. Coding
assistant tools range from autocompletion to linters to automatic code
generators. In addition there are other AI-related tools like ChatGPT
or Gemini as a chatbot that can people use like Stackoverflow or an
API documentation summarizer.

I think the intent is to say: do not put code that comes from _any_ AI
tool into QEMU.

It would be okay to use AI to research APIs, algorithms, brainstorm
ideas, debug the code, analyze the code, etc but the actual code
changes must not be generated by AI.

> +to, `Large Language Models <https://en.wikipedia.org/wiki/Large_language=
_model>`__
> +(LLMs) results in a number of difficult legal questions and risks for so=
ftware
> +projects, including QEMU.
> +
> +The QEMU community requires that contributors certify their patch submis=
sions
> +are made in accordance with the rules of the dco_ (DCO).
> +
> +To satisfy the DCO, the patch contributor has to fully understand the
> +copyright and license status of code they are contributing to QEMU. With=
 AI
> +code generators, the copyright and license status of the output is ill-d=
efined
> +with no generally accepted, settled legal foundation.
> +
> +Where the training material is known, it is common for it to include lar=
ge
> +volumes of material under restrictive licensing/copyright terms. Even wh=
ere
> +the training material is all known to be under open source licenses, it =
is
> +likely to be under a variety of terms, not all of which will be compatib=
le
> +with QEMU's licensing requirements.
> +
> +How contributors could comply with DCO terms (b) or (c) for the output o=
f AI
> +code generators commonly available today is unclear.  The QEMU project i=
s not
> +willing or able to accept the legal risks of non-compliance.
> +
> +The QEMU project thus requires that contributors refrain from using AI c=
ode
> +generators on patches intended to be submitted to the project, and will
> +decline any contribution if use of AI is either known or suspected.
> +
> +Examples of tools impacted by this policy includes both GitHub's CoPilot=
,

Copilot

> +OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are l=
ess
> +well known.
> +
> +This policy may evolve as AI tools mature and the legal situation is
> +clarifed. In the meanwhile, requests for exceptions to this policy will =
be
> +evaluated by the QEMU project on a case by case basis. To be granted an
> +exception, a contributor will need to demonstrate clarity of the license=
 and
> +copyright status for the tool's output in relation to its training model=
 and
> +code, to the satisfaction of the project maintainers.
> --
> 2.48.1
>

