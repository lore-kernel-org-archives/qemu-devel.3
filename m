Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D2DC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ezy-0008SG-BM; Thu, 16 May 2024 13:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7ezu-0008Jo-Bz
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:34:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7ezs-0003IC-M3
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:34:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so6820187a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715880867; x=1716485667; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paanTEc72lz9sM89hZL353Y73QQ66ufqBNY+K5WLARs=;
 b=carndNEd5P+QsTadVcuo7/h6ZDAPSiTbbWXTA3NXt636x6pTdb0BAwexh6rIosAyZK
 sLuGNXj3x81N/jTJLkrVGr6QvoPPqtjbkVOZG2JMkAoXbDwvussDTAh0ijx+UVeaHwcW
 h6tG1WQtdwCPhWXtH6ZYOMe4NTsOhU2KRn1J0Qdf/fbn90PW+Spf14cwJhNMl0juhPBo
 fUbcSlq/gRCiU/eO8nQTDjEhh4vJ5MLguugat5YBtT0j+XUCjpagUTtwTW/izJAJGj3n
 Caouok0OnWx2INl8FAFThAA9rzk7RopZ8d5gW+jOoqka6ja5HQ3Mc8UROv2DpqlsKCDy
 zwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715880867; x=1716485667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paanTEc72lz9sM89hZL353Y73QQ66ufqBNY+K5WLARs=;
 b=Vx6ENhMhvfZxYNZNmwznLThw7K9GQfptomLPgDA4snbCRLlu7CYry6El66DTMUDDuA
 0pC2UdhJbZQLFInCldxWGQSOw61bp5yiZE82OvwhaHINLCBrOL1DAVpctmQHIKk/3f+E
 NVdC8VXU/8IMabrQQMx4Vi9Jd76DR/z6As05KCXVvEmqZ7yewo/uT1PRIweexx3RNztq
 MnCSgmJRkqskJpIxF/dMgpbacWbKsp5Rsx96K9/ST4do222/4HFax0aaDDHea2osG9OJ
 mhUYOhg6YPNFKReKWtoPnvAluE+34fcTmbBxcLqqGDTxygF49y8EwaXCyvIn3xG+a1Bc
 xw5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiSLQ4HgrS1qQABKV7M0rI+vQ26zDe1gwl4dIzkDsoIaT+U7UvNQa8tqzCX6pwRj/Xv4vy8L6YNFRCOwxb4sGN7tjp7aU=
X-Gm-Message-State: AOJu0YwO73iMXLq4yoi4EEmPURoELzMyZ/B4qvrn17jA9MY/12yrbbbn
 8jcB3ekrwlaHVSwGDgn/ffGyB5QguF0IRk03NUJcZBFfI+sPGo3j45XAWHK4095B1L9BS34y4wQ
 V0hDYcZ6HLr0EIgmfXnKm/KVQFBKPEnCzfJQH4A==
X-Google-Smtp-Source: AGHT+IEwO3j33IqugvO0R/lnnmAFNAh42r7YpncNknOoT1iUZyq91RqrDAFmU5cr9M2jKxi7Nz69uVuPxCOD9zKfciw=
X-Received: by 2002:a05:6402:430c:b0:572:afb6:3b7c with SMTP id
 4fb4d7f45d1cf-573322c59ecmr24537547a12.0.1715880866889; Thu, 16 May 2024
 10:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516131141-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240516131141-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2024 18:34:13 +0100
Message-ID: <CAFEAcA_ZhSvaZtwooZXfM2=acypm=uCvVFroPOy5E2BbKtGRKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 16 May 2024 at 18:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 16, 2024 at 05:22:27PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > AFAICT at its current state of (im)maturity the question of licensing
> > of AI code generator output does not have a broadly accepted / settled
> > legal position. This is an inherant bias/self-interest from the vendors
> > promoting their usage, who tend to minimize/dismiss the legal questions=
.
> > >From my POV, this puts such tools in a position of elevated legal risk=
.
> >
> > Given the fuzziness over the legal position of generated code from
> > such tools, I don't consider it credible (today) for a contributor
> > to assert compliance with the DCO terms (b) or (c) (which is a stated
> > pre-requisite for QEMU accepting patches) when a patch includes (or is
> > derived from) AI generated code.
> >
> > By implication, I think that QEMU must (for now) explicitly decline
> > to (knowingly) accept AI generated code.
> >
> > Perhaps a few years down the line the legal uncertainty will have
> > reduced and we can re-evaluate this policy.

> At this junction, the code generated by these tools is of such
> quality that I really won't expect it to pass even cursory code
> review.

I disagree, I think that in at least some cases they can
produce code that would pass our quality bar, especially with
human supervision and editing after the fact. If the problem
was merely "LLMs tend to produce lousy output" then we wouldn't
need to write anything new -- we already have a process for
dealing with bad patches, which is to say we do code review and
suggest changes or simply reject the patches. What we *don't* have
any process to handle is the legal uncertainties that Dan outlines
above.

-- PMM

