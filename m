Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B16D74EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJoe-0003qP-CZ; Fri, 23 Jan 2026 11:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjJob-0003oo-AZ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:15:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjJoZ-0000ql-Hf
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:15:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso19769415e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769184914; x=1769789714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=St6WiDlN5y3/67x6/i4DWB3p/o72JYEaip1j9p8qdas=;
 b=GLKhb0vGsDus7so8esZ5pvTVMVwL0vHcKKpWM1Vmrh7jZtZBJ5e2l72ewZzV/Rzifa
 b9nFCrzkG6Fuy8J/YEPWjHvRQg56PnbPPQCJ6jxWBbEX5gaTV477dm3k6c58mop4QrOU
 QKSSNOJnF3SyNlIHquQlTbnwA8257V8h6QYnNSt0JGutNFBoRjSFyKItbExn2bDYHgNH
 SYi/J/FXiWlNNdM0DtzZ7GYUQjsF9EP+Y8BhGLnVjchkwZE+EXiLyvKsJlktZM0zy6JF
 011WSQmi06MNLY88RsEWJfjKVTNTUGeWcgYrHWulKNqPlhFIIj6x+olMUGQ7i609m4TO
 wd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184914; x=1769789714;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=St6WiDlN5y3/67x6/i4DWB3p/o72JYEaip1j9p8qdas=;
 b=vs0fcQrHrU0h+BaW2F+aBqnR1X1tdIMl4/Dts6tD821yuM/5wDJZwcif6z7LfscWv1
 KeDi0K9aNqPXntnqWG+X6pMjZJlURyOXlmc3vR/6pBsNeLTr4b5Vt53wGdPLge189oDq
 KKQ1N6nGIKfi6kZbkbCgd3sMe9tO6K1ZiCsgIzs8YSh6PDMTy47Z63wU4YF3JY3NdkMa
 aQ4ps1Eu1miOx3XdCggVy1Zi7XtJ1oDIIx8IpKFugeAwuWtHIBdVc15S3BO0IzL57jYY
 YDAonHTwHZxZotaoSzUrPI1hVPDXmK1pRJSzXqs0R/RT7mF4DvMgzv3lhS2V7092PkCR
 PTVQ==
X-Gm-Message-State: AOJu0YzBeg0gRj1l8RDc3OzO0Es3W2VWWWvkpcJCZ899nmZMdh3+NYEE
 r1CDXiyDQb/pQ+U8CayVKnQPK8W/Y/lq1cTHyjxuLFQdGlw8TdAUF2ugjV6ozyF8/7g=
X-Gm-Gg: AZuq6aIvWnJ5LGYXz2KYmgxlpHVanFMPLyH2cp6Cg5jaEQkYgRmzFoi96uY/b+Ey6Ls
 dAhc8tuJy9JSNlNeseUFeBw41LZ5QERKWXh86NTz+FDjAKMGTnHrOHTcQwGfuM5hzllsFxQTqxD
 co8InZZ06JTTGCNSFFjUI1zHz6rIxl94qHUSKxnkzbx//TpyajkFqwMHAn7jzbSsmbNBRZLDcBO
 NJ/0jaWQif0ly7tBOf2uziqTfBtbguqlxqdnf8/4EIvxCVr8ZdaarbOZg/oH6sAMdvvJonZFPUg
 MLkb6REQRucIEOsJqLwaBa0dIMSe+asxeCuY4yPOyf/DPaHIynFjOxtLxHB1MNgXKmfKnUECNUR
 71IU6f+c37WFDQP+mDiWO54jxecb8uA0/IUwhMy+XMyO+Q+5vaJTWs63KRvT8SF5odC3kQa40aD
 6jRLMQm1r0iOoz
X-Received: by 2002:a05:600d:644a:20b0:47e:e38b:a83 with SMTP id
 5b1f17b1804b1-48047068f88mr88207525e9.7.1769184913068; 
 Fri, 23 Jan 2026 08:15:13 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470287c3sm159293055e9.3.2026.01.23.08.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 08:15:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1EB75F7B3;
 Fri, 23 Jan 2026 16:15:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Joe Perches
 <joe@perches.com>,  John Snow <jsnow@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
In-Reply-To: <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 (Warner Losh's message of "Fri, 23 Jan 2026 08:12:33 -0700")
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Fri, 23 Jan 2026 16:15:09 +0000
Message-ID: <87343wmhki.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Warner Losh <imp@bsdimp.com> writes:

(Cc sniping Paolo/Peter/Markus for AI discussion)

> On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  We should reflect the current status so users don't have unrealistic
>  expectations of how quickly things can get reviewed and merged.
>
>  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
>=20=20
>  ---
>
>  [AJB] I realise this is a slightly provocative patch but given how
>  widely used *-user is downstream we should be clear about the current
>  state and hopefully encourage those who rely on it to step-up.
>
> For the bsd-user case this is likely correct. We run hot and cold about b=
eing
> proactive at fixing things, and we've been somewhat cold for a while now.
>
> Part of the problem is that this submission process is very very heavywei=
ght
> compared to other projects I contribute to. Not sure what to do about tha=
t since
> there's a reluctance to move away from it. Or alternatively, I'm somehow =
making
> it too hard.

We have discussed in the past allowing maintainers to directly submit
their PRs via GitLab which would be beneficial from a testing point of
view. To move this forward someone needs to propose the changes to our
policy documents so it can be discussed and merged.

However we still expect patches to go onto the mailing list for
review. The greybeards (like myself ;-) are very wedded to the inline
email workflow but if we could keep that interface while making use of
the GitLab UI for those that grew up knowing only the web maybe we could
make the project more friendly to new contributors.

I'd be interested in knowing where the pain points are for you because
modern tools like b4 make some of the grind (collecting tags and
applying patches from ML) a lot easier.

Usually the most difficult thing is getting email setup so you can
git-send-email or git-publish.

> A lot of the upstreaming work that's stalled would be ideal to tell claud=
e to do,
> but I'm unsure the project's stance on using claude to move code, and git=
 log
> 5 different trees to get the original author(s) of the code and make triv=
ial compile
> tweaks.

There was some discussion at the maintainers summit about relaxing the
rules on AI submission for "mechanical" changes but it ran into the
weeds without any firm conclusion. We could certainly revisit it.

I think the concern about potential license pollution is a valid one but
this is more of a concern for "novel" changes made by AI. I've been more
relaxed on my personal FLOSS projects where I have allowed AI
contributions but made it clear that the submitter is expected to
understand whats going on. But being personal projects they are less
likely to be spammed to death by AI slop PRs which seems to be a growing
problem in the wider ecosystem.

>
> Warner=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

