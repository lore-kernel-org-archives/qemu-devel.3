Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B8D31768
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 17:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8N7U-0000hK-4s; Tue, 05 Nov 2024 12:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8N7Q-0000gu-Ki
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:13:28 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8N7P-0007J8-2P
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:13:28 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso7190243a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730826805; x=1731431605; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=no9Y8erOq0EIaiTxgO0OXZAI9WlZQZuBOlovtynxEjU=;
 b=BuDJ1qQDL248KuncL/6DtNrNA86euM3eyvsy6kNhaCPpO4H1pVbJ0mF946dVlsR9e0
 AEdzabzIVPw+b9uID/j8QkD5PlKT9/USCXRibq2dYHJbW1eEH086JKrxwwuX9pXA3dHj
 iW6k/M6ZcF7FJmR4eGLa8Tx5JyO9fNbwQfhap/rzhiwE7AR45dtNsoDMREgzEFGcy+If
 tpWzarICVX1TEJQQ1U4qNm2E1UwHcmFzlY80iTHX4+3HXd1FS6j0aGEvK03x/TNKJyRP
 jOeLJqffnlOJd0gpFI0qmdX1+0IMEoNDFnFottcceeqn24ReVRLlH+ngAsG0UIMtm3C4
 C43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730826805; x=1731431605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=no9Y8erOq0EIaiTxgO0OXZAI9WlZQZuBOlovtynxEjU=;
 b=ihqjs7S98WtGhGuvBV+nkPWzWYphXSFFSY1QmzLunKZdyj63vXs2o1q7ew1ZJjiyFj
 tUjiP6ojvC2f+PeeBdN/s7ZldcsICkeygRhMGsbqdEVL/4jS7FpEUshG5+x0AM6P2Cgp
 tO7thIOVtTLIdHUGQVLhOjZCK127r3p2aCNhFd7Jf3iQQpgNZAAYDTQUQLbWCxxox2FD
 y4qV2EcWihJYxa20n3w1xIMB+5AT48HElaAB24q4xSISiim0jFX7UHaBcZ8TWo6SBenK
 zFFn83XHno8sr0Sm1Xg9gAIqbdcMlkBT6zoL8gyMn3CXQqszAPO+Bd6YZTRfNAqfDq8w
 Sp8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPCD4hTIW6VROiQXL0yfcMyjbkfiB0NNdhchRRBH/83JYLZ9ezxOTCa4q9EGs7xcPkRfCXVzxhWvaO@nongnu.org
X-Gm-Message-State: AOJu0YxS5H/fP5qvKr4hJnSnIWg06f1V1Dq+IhrAdBe/OSduySsOVIDL
 3cPxSpMmF0Z85z1pDnCBQWoI7uBWYk0y6ufQJbXwR95yK0Nb1No9KRfrgIvUBacm6eU/b/3b0X2
 VPDush5JqKpiMKU6qB6Gmk4euRS8/vvwh1c94MA==
X-Google-Smtp-Source: AGHT+IF0PRx6WQFOC56PE96wH0H1RyLvoeihi15aiRTx4pVm3/Z54VD5U3H8XM3AOzi8m023Aqeqjs+X/FKbQ+FwO/4=
X-Received: by 2002:a05:6402:90c:b0:5c7:2122:6ad with SMTP id
 4fb4d7f45d1cf-5cbbf89a142mr30683017a12.14.1730826804974; Tue, 05 Nov 2024
 09:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
 <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
 <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
In-Reply-To: <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 17:13:13 +0000
Message-ID: <CAFEAcA84hhWu2ouirfDPbCpq_=QLQxAf3k47h0Pij8iEnOVj+A@mail.gmail.com>
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 5 Nov 2024 at 17:02, Stefan Berger <stefanb@linux.ibm.com> wrote:
> On 11/5/24 11:14 AM, Peter Maydell wrote:
> > Q1: why is apparmor forbidding swtpm from doing something that
> > it needs to do to work?
>
> What distro and version is this?
>
> The profile may be too strict and not reflecting all the paths needed
> for running the test cases. Ubuntu for example would have to update
> their profile in such a case.

This is Ubuntu 22.04 "jammy" (with swtpm 0.6.3-0ubuntu3.3).

> > Q2: is there a way to run swtpm such that it is not
> > confined by apparmor, for purposes of running it in a test case?
>
> Try either one:
> - sudo aa-complain /usr/bin/swtpm
> - sudo aa-disable /usr/bin/swtpm

We don't have root access from QEMU's 'make check',
though (and shouldn't be globally disabling apparmor
even if we could). I had in mind more a way that an
individual user can say "run this swtpm process but don't
apply the apparmor profile to it".

> > Q3: if not, is there a way to at least detect that swtpm is
> > broken on this system so we can skip the test case?
>
> It's not swtpm that is broken but the AppArmor profile is too strict.
> Above command lines should work.

But this is a widely deployed distro in its default
configuration. We have to either work with it or detect
that it's broken so we can skip the test.

thanks
-- PMM

