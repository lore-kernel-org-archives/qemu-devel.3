Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EB6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gYn-0006XT-JT; Mon, 22 Sep 2025 09:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gYl-0006XK-Pj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:26:27 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gYa-0005yC-FG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:26:27 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-72e565bf2f0so34031067b3.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758547573; x=1759152373; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JM5QaxpFdIxstXICZ9MSePRrwB8nlQ+4Fi8I1OdTnn0=;
 b=q5KI3mwmihBap+Dq5HcADID1L/naB9hg4nPmsUrqpKrcH5axYaFqcjpYmAd1+4Gd+5
 nmz3W6/TjuhXF8xU184U92JWoA8QwO252D2DmjhR5uGHiJUPZ8SsQOFPJa1kbwWNdaDR
 sDzuWQRavPOoRm/q41MnzW5N1P0RsRu8Man2KZm+h2G7SDj4V6Q97bEqp2wIA0E3Qt+f
 XovOZjCmvnAL9TwO9VHm0lUaFZlCSst73+oLn559WIJvjnJqhOqF36YjG02VBZjd8y1K
 S3MgLJPuwWR8ojY930fDz6nMTr//XydabHSMA4uFbskMV4aCF+9cURqdXoR5ey5DYtEg
 r+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758547573; x=1759152373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JM5QaxpFdIxstXICZ9MSePRrwB8nlQ+4Fi8I1OdTnn0=;
 b=N2pHPWSmL+Q8ZYccYtva6qHdMzbAjyLrYeEsxz5MFFsKrmlOWXZ2rI8HnbmqYc+5n4
 vUfGJseHQN/wWHa3b+EWL2x4RZZqgA2suLeOtgNY4eRv+wW92areekYCnj6fGpQttXpc
 Ebc/jSo0PqdPE76a4IVvL83eqazppIjqZL2MP+BcgdjhqrDO6Ie+/ocRf92IgBj8Oeef
 Dlg7OIb3Gg29RVSDF+lQzZyNm3VH1/Yt15Y6DSN2U28pwUxSkKM7xWpylGswAUBUMoFJ
 K7Bcl3KGl9JCTmo6yoW4BIhFZfxS/z65WO2Cy46S124c1ImSePnUWUXCCQONBEJIK0Xb
 6Wnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCHYgIEAwjwzIlq8PPw2LOxpbAgCUDLiGTkKSa8ZjDsxtoHdGPvDqQRVtJruOO9ffZkLXbG8o9pMsF@nongnu.org
X-Gm-Message-State: AOJu0YzsWWtamXCFOt2LaQxhJKZ2YLMtDDDKwboLhdd0n8CrtpRfshib
 aIehJYTjiLoJZahA0gIN/BtEp776Jokem69kwZXYOVhh/viCl0AyaT7OK+YasJcaINTUytE+QXZ
 RduKLxQQaD+0GJFdNnSUuFj8BfGwFJjMHnf+Aq+a4wIWPDkjTOil7
X-Gm-Gg: ASbGncsa0I0GXNbIjyzEwnFZDSjnzmq15YYLUFM3bB9TdF3wednMuLcv6SLCys15q0j
 7aafky2AImPGqUKCePbkDcOJBSG0tvTAgVhd7oMeuBznHcae0OctUX0ZrqRCEPO2NccP6FS4/Lr
 WZEPSU1MUmZdzL2rxCETg+GFlvH6VPAvPoUhwpLDIDnGtcKgPVUZX/mpPZIUdzS5slhzWOl0paG
 +vmojPH
X-Google-Smtp-Source: AGHT+IHzXUfXlsiEFEhmRJj4ZT8YeTCX+lMdIw5Z7uOVSKn1nYSeS9FPGgN9AJHI4erLTBRwXjOgqFMJFlGBtXZwPmI=
X-Received: by 2002:a05:690c:4912:b0:724:2cad:8df6 with SMTP id
 00721157ae682-73d3150f3eamr126583667b3.16.1758547573385; Mon, 22 Sep 2025
 06:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
 <aNFJVrusgEUaLuDW@redhat.com>
In-Reply-To: <aNFJVrusgEUaLuDW@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 14:26:00 +0100
X-Gm-Features: AS18NWAoNoDu4YTZqZt5QO7LU-nTnV3SGdLsEUi71zSCkidLS077XL63XCVYZY8
Message-ID: <CAFEAcA_rQhXdavAUCEt8atMhpZYEu0Lz6tVdu4+mfgPOK9iUuw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 22 Sept 2025 at 14:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Mon, Sep 22, 2025 at 12:46:51PM +0100, Peter Maydell wrote:
> > On Mon, 22 Sept 2025 at 12:32, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
> > >
> > > I do not think that anyone knows how to demonstrate "clarity of the
> > > copyright status in relation to training".
> >
> > Yes; to me this is the whole driving force behind the policy.
> >
> > > On the other hand, AI tools can be used as a natural language refacto=
ring
> > > engine for simple tasks such as modifying all callers of a given func=
tion
> > > or even less simple ones such as adding Python type annotations.
> > > These tasks have a very low risk of introducing training material in
> > > the code base, and can provide noticeable time savings because they a=
re
> > > easily tested and reviewed; for the lack of a better term, I will cal=
l
> > > these "tasks with limited or non-existing creative content".
> >
> > Does anybody know how to demonstrate "limited or non-existing
> > creative content", which I assume is a standin here for
> > "not copyrightable" ?
>
> That was something we aimed to intentionally avoid specifying in the
> policy. It is very hard to define it in a way that will be clearly
> understood by all contributors.

> TL;DR: I don't think we should attempt to define whether the boundary
> is between copyrightable and non-copyrightable code changes.

Well, this is why I think a policy that just says "no" is
more easily understandable and followable. As soon as we
start defining and granting exceptions then we're effectively
in the position of making judgements and defining the boundary.

-- PMM

