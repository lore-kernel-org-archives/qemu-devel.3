Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE9C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXP3h-0006Ie-4q; Tue, 06 Feb 2024 12:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXP3g-0006IH-Ba
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:16:32 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXP3e-0004Ak-KI
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:16:32 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so8166978a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707239789; x=1707844589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9agnLMbdFvQaGn8zgw8Px7k/7ZwOY/58/R1FjZ2IZzc=;
 b=D4EgD6U/+CCDd1VbybgQ2tIxNToIdPEV7/7FI6SiB1mVdKATEfcRPjZru3f/YnATdd
 gnQ8QzOdGTr//+/9MFA04kfIAF90DEWS7BJOo9v3AjWUpFQWVGd6/MApr17ltQHzACUb
 QEfG0Sei0I/UFUoCH8d1arwBCYHBvz6YesNCE7MjdYR7BXyPJHb/2zaysuHcep9zejoR
 Q+5SSbcRAPNte/7xicuzRp+ALxBiZgqLiiuV3hIIRiPwscCrEe0KUbiefBBRgJo8plmQ
 JQrtl5BwfQ3vt6vH8ainy6ht3RaS/25rNij3hqxPOQwKeDxyyWStBDHZ+Xzl5QQxvzKK
 u1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707239789; x=1707844589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9agnLMbdFvQaGn8zgw8Px7k/7ZwOY/58/R1FjZ2IZzc=;
 b=pI7ikIJ58ajFKfywMhOzbb2u33XcURo2F4UE9+L0zzQgwieaLTgWDA4bNQOoHwnaPv
 9P/OYLv+OJvSjdg2XTs2JES+eyLlXMRyvYR8KkBZ1Kq3hFwI00gZFpq6Mcsv1buKpGv5
 yQRxulh1yzB7F3kzqC+mOuMVe1j6dLN24LwPedn7lMqoHMN3kXZ02WhOVTzmh1x98P+c
 jLaeuQMN+y/rIZLSUGNlJrXqJBNUTtCJbCwgC3rVfAHWI561ADpLtkELLQ9GCz6lU83F
 JvSPTufeq2VsGsj4/YhvYBQZvFOftzkxfkgdclOu05qWnrzA2sm5yd9az9HyHgx+VY7M
 tblg==
X-Gm-Message-State: AOJu0Yxf8FrWfZW+Q+5b5BckEOlDK1rp33XqnIqwVGyUSaI0+e3kAHWb
 nqjPcftF6olvsbj66V1EvsXtgnsOTg1OAGu0RwIZ6ryMGjb61ZkWXcC6u67Kl6ONDo7u6oxobm3
 g3H1Ds9L2aHfaAI44XFOaOU6UgerYm93UfVv9xYw4JrhAJcnp
X-Google-Smtp-Source: AGHT+IHwoiPXBVMJOllTavB0kUdzGsmXuQ4uN1k5y9VKGQz+2Ta3CEcWF3c2SeBb7ObGekWQCQuEOWsOL1Jt+BOqhoM=
X-Received: by 2002:aa7:d8d6:0:b0:560:24e:3caa with SMTP id
 k22-20020aa7d8d6000000b00560024e3caamr2425748eds.7.1707239788864; Tue, 06 Feb
 2024 09:16:28 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-WQa5rJK3e2Z8tgcm0ZN8dDnFnF0v=hTPdJpapN4vsNQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-WQa5rJK3e2Z8tgcm0ZN8dDnFnF0v=hTPdJpapN4vsNQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 17:16:17 +0000
Message-ID: <CAFEAcA-wDvn47y9fG4q3HdcxvZsnNEY60-7db9-sbtj2sMN3ow@mail.gmail.com>
Subject: Re: test-x86-cpuid-compat qtest produces warnings on TCG
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, 12 Jan 2024 at 13:42, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> When running under TCG, the 'test-x86-cpuid-compat' qtest produces
> warnings. You can see these for instance in the x64-freebsd-13-build
> CI job; here's an example:
>  https://gitlab.com/qemu-project/qemu/-/jobs/5918818568
>
> 24/837 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-x86-cpuid-compat
>           OK               7.32s   45 subtests passed
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> qemu-system-x86_64: warning: TCG doesn't support requested feature:
> CPUID.07H:EBX.intel-pt [bit 25]
> qemu-system-x86_64: warning: TCG doesn't support requested feature:
> CPUID.07H:EBX.intel-pt [bit 25]
> qemu-system-x86_64: warning: TCG doesn't support requested feature:
> CPUID.07H:EBX.intel-pt [bit 25]
> qemu-system-x86_64: warning: TCG doesn't support requested feature:
> CPUID.07H:EBX.intel-pt [bit 25]
>
>
> Can somebody look at these and work out whether:
>  (a) this is a real problem we need to fix
>  (b) this is a problem in the test case and it shouldn't be trying to
>      test a feature we don't implement
>  (c) we should suppress this warning
> ?
>
> (filed as https://gitlab.com/qemu-project/qemu/-/issues/2096 )

Ping, a month later ?

thanks
-- PMM

