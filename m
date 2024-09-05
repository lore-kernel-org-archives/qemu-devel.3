Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F7CD5BCC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smE5O-0006BL-GE; Thu, 05 Sep 2024 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smE5G-0006AC-NT
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:07:42 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smE5F-00019h-3E
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:07:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5AA8FA44D32
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2024 15:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE461C4CECB
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="W9PxaiQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725548855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2mchVWEFa+UEZBLyToTME5uIAwdXMvriDfoFaA/ie8=;
 b=W9PxaiQiFmDqH7BTMpT5HTzVD0vMiJ44EzIA1oCdNuwwbjjU291VS1th5/wgVVa7uLOob+
 mq6cPalu38Qv+2JK9AzKcDR5RHspzwUnkOJk3lwK2xhBa09OT+tfzRo60HNgJXs9ST9+JB
 lwK8LpCL4rX85o0T3NifHd/5oTtXgZM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d08990ad
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Thu, 5 Sep 2024 15:07:35 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-277f35c01f5so519443fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 08:07:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ib5yFRY9MTtKsXUBP0pQoIZUM1CYc8Ptq2t6Z7W93PrjiPj9MVWgj1koLgIprvpmgaBBjn+gNWuW@nongnu.org
X-Gm-Message-State: AOJu0YyENkcV+hgllXlmMO2Pu5lLG04AR6qpnHRYPsw+TPGRtc4Q2FbH
 SamOIj27oCRUjoPWJDnv9YMA9XwINhwN3DVl3wlWkrpwqCvbXPrrqRzK/MQ3OxYHFMr949vD9FF
 2M05+3xFtFb7B5NaPWSArHPK7M8w=
X-Google-Smtp-Source: AGHT+IH/v2t+ij91vaCzCIZsMD90hI0GAjiKSi8I2aCx9cm4gUr7Kw3J32OUlV8tZz83zjXgCFqqKXfOUd/m8AhH1So=
X-Received: by 2002:a05:6870:828f:b0:278:3de:c8de with SMTP id
 586e51a60fabf-27803df0c8amr11214672fac.24.1725548854039; Thu, 05 Sep 2024
 08:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de> <ZtnGA4mH0I2hdx4N@zx2c4.com>
 <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
In-Reply-To: <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 5 Sep 2024 17:07:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9pPvk4s9JnEPmc9w71hkeHD_1U-fAy0+8MQNmO_9Gh3=g@mail.gmail.com>
Message-ID: <CAHmME9pPvk4s9JnEPmc9w71hkeHD_1U-fAy0+8MQNmO_9Gh3=g@mail.gmail.com>
Subject: Re: qemu direct kernel boot on LoongArch
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: maobibo <maobibo@loongson.cn>, loongarch@lists.linux.dev,
 qemu-devel@nongnu.org, xry111@xry111.site
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Sep 5, 2024 at 5:05=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2024-09-05 16:53:55+0000, Jason A. Donenfeld wrote:
> > On Thu, Sep 05, 2024 at 07:25:05AM +0200, Thomas Wei=C3=9Fschuh wrote:
> > > On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
> > > > On Thu, Sep 5, 2024 at 5:45=E2=80=AFAM maobibo <maobibo@loongson.cn=
> wrote:
> > > > >
> > > > > Jason,
> > > > >
> > > > > With the latest qemu 9.1 version, elf format booting is supported=
.
> > > >
> > > > Thanks, I just figured this out too, about 4 minutes ago. Excellent=
.
> > > > And the 1G minimum ram limit is gone too.
> > > >
> > > > Now working on how to trigger resets.
> > >
> > > With "reset" do you mean normal (non-panic) system shutdown/poweroff?
> > > Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
> > > that in a cross-architecture way.
> >
> > What I mean is that I need for userspace calling `reboot(RB_AUTOBOOT);`
> > to actually result in QEMU being told to reboot the system. Sounds like
> > that's not possible (yet?) in 9.1?
>
> With reboot(RB_POWER_OFF) this is indeed the exact usecase for pvpanic

I'm actually using reboot(RB_AUTOBOOT) wth QEMU's -no-reboot, because
that tends to be far more compatible with a greater number of
platforms, for example, x86 without acpi. Shucks.

