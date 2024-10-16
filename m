Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E209D2A52F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 17:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t17Oc-0002Et-5e; Wed, 16 Oct 2024 13:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t17OZ-0002Ea-Mz
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:01:11 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t17OX-0002km-FQ
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:01:11 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6e38fc62b9fso1097027b3.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729098067; x=1729702867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbVyShngESJuQxgCdfZv/jT1lPRNeKyviz+B8g8wqWM=;
 b=ikdQb1pQ279nJBcRZCdk07xZ9G+iZbBD1aaKB3NPrT1qPPuq1R6BKB5ztV4h4IbhsZ
 Dd9zjEf8WLjiljzO6/IcDPR34NIYDuosAFanksKHH2W/7u7DPfvK8JJ4cbn6N18sW5yw
 6L9r1EbMWO77EgWfsFnhCW2GXaYKmW2JYBav71g+PCQqUU8CrDlaJ1DWYWsJOBSkqbeN
 ZFDyDp2Yg8tbzCc+GKXcO9AGiGKlLdqJD1p+hk0hkCYG1jBjjR6KgQkoxUPzf3bVRbUz
 Mw6wrb2C5jqJuccFqKeL5ew6Leel8eMItz+kl+jQNSnrlIoCgUJxPZ9mU2BJ5F86maIH
 JhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729098067; x=1729702867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbVyShngESJuQxgCdfZv/jT1lPRNeKyviz+B8g8wqWM=;
 b=eGpSl8BjXPPxWBdjuLcsD4njfEdGqExhdIeiZrkGuV539n3oRcG/U+SFmj6NLnn3eZ
 ivMxWERNwAtNmk4K9T2i92gFTShD02zIPicDt67VRnvVG3tAyRC1U0kfrCDYClIQ29aR
 n+1NEO2IuyY+M4yBw24iNrrmkWyq6uw0ArCcSSRw9ICz/Jt88qvH1Xcc/vv9uOiGRQp6
 L3KlB8R9m0Y+h7BeHKsfWN0aV8vJnicu9w3BbFZQJQS3sxe69r3j1gh7O86RZdzcm9V3
 un77zU6RXuxYI0k6CIoqwlteMF94s6IZKoGtGA4ZCM0BQJ7y8EVqTxMTmRArMLc7vRro
 ed3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU7egRPtcVsMWigHpcXdqm2D0NV8JdABHHgwYfcXK2DWpcVrh5C1SAPr/D0/7+3gegiDQKrU2KQgeC@nongnu.org
X-Gm-Message-State: AOJu0YyTg3m77leccjYvSQLyNK4I6QEfKU34OBVxjvjUjKTy5ZTZ50ip
 VdgEu+pm0B07gcnSsyJcKih/yIe2RG7kexVMjqMHBWCrJy7jepYGUPu9KYQmPdVqtRdXQgzNKXG
 RhdX70sbeqRmDPx5VfpTTFyxTMtuIFsbUsVdJaM0N9R9JyYiK9Tm3
X-Google-Smtp-Source: AGHT+IGdru74k08SB1kq28aROQeh/d5FaNjlAHAopACy1cPKkhOta2/YvsSmW27jCBrOuZM2k6trz/6bIrwJJnSx/zs=
X-Received: by 2002:a05:6102:3913:b0:4a3:ba8c:879 with SMTP id
 ada2fe7eead31-4a475f12a6dmr10897097137.2.1729098055194; Wed, 16 Oct 2024
 10:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240906225451.1039718-1-roqueh@google.com>
 <20240906225451.1039718-2-roqueh@google.com>
 <2e4a7aad-02cc-40e6-a647-9e6bdba911a8@linaro.org>
In-Reply-To: <2e4a7aad-02cc-40e6-a647-9e6bdba911a8@linaro.org>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Wed, 16 Oct 2024 10:00:43 -0700
Message-ID: <CAKbPEtZmf7mxYnGE-rjbUSTc25CSJ1PxSefKLx3UDBLA74=e=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 slongfield@google.com, komlodi@google.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=roqueh@google.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hello Philippe,

The Google-Bug-Id is an internal ID and should have been removed. The
information in the bug was mostly transcribed in the cover letter of
this patch series.

Thanks

Roque

On Mon, Oct 7, 2024 at 1:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Roque,
>
> On 6/9/24 19:54, Roque Arcudia Hernandez wrote:
> > In the context of using the remote gdb with multiple
> > processes/inferiors (multiple cluster machine) a given breakpoint
> > will target an specific inferior. If needed the remote protocol will
> > use the packet 'H op thread-id' with op =3D 'g' to change focus to the
> > inferior we want to insert/remove the breakpoint to, for instance
> > 'Hgp3.3' and not 'Hcp3.3'.
> >
> > This is supported by the documentation of the H packets:
> >
> >   > 'H op thread-id'
> >   > Set thread for subsequent operations ('m', 'M', 'g', 'G',
> >   > et.al.). Depending on the operation to be performed, op should be
> >   > 'c' for step and continue operations (note that this is
> >   > deprecated, supporting the 'vCont' command is a better option),
> >   > and 'g' for other operations.
> >
> > This can also be verified in the GDB source code file gdb/remote.c.
> > Functions remote_target::insert_breakpoint and
> > remote_target::remove_breakpoint will eventually call
> > remote_target::set_general_thread if it needs to change the process
> > focus and not remote_target::set_continue_thread.
> >
> > This can be seen around a comment that says:
> >
> >        /* Make sure the remote is pointing at the right process, if
> >           necessary.  */
> >
> > Google-Bug-Id: 355027002
>
> Where can we find more information on this bug ID?
> I tried various query in the Google public tracker but
> couldn't find anything.
> (i.e. https://issuetracker.google.com/issues?q=3Dcanonicalid:355027002)
>
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > ---
> >   gdbstub/gdbstub.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>

