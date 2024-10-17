Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C17CD374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SX1-0008K1-C1; Thu, 17 Oct 2024 11:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t1SWz-0008Jo-5a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:35:17 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t1SWw-0003ob-4h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:35:15 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e6010a3bbfso46407b6e.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729179311; x=1729784111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HKcOJtQqUpgADS85x9pvH9/g33I9cenjUOsTdfxZF8=;
 b=yr2uBiiXRRar2v/fb1T8PnNe6BdoKLhshyBl0yqD1Uhyc7CSMopuzM1R97k1mqVEJv
 zcAE5Og63mFVq8gq8f/AQspvcxOip6dxHw48bQyQUwx1Kjzq7V7SdIui7BnoivT2VEDZ
 tpdvkQcZlqzKDvscG0WjIHSc7EKnFGW0GfIedQBwR2Kj3Q69Y1sT2i4xbCd/2lgHZjCW
 gshycPFKW2qsnPpuYG82C0uwkEklTZS0EStm9rL/mcNHmyhSedGbnJ9CqviI4K4xl1gv
 p5GDW0HSdx/n7s7BSiDPYKc7hyQEIBowUBz1yZM3SgvuMnlk045Y2zmFZoXx8i0NhNMn
 ul3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729179311; x=1729784111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HKcOJtQqUpgADS85x9pvH9/g33I9cenjUOsTdfxZF8=;
 b=rm4Cmg6aMncMciWQgpHfao/97i9uv0FkUlEIKqUoeU5Q4ZJMfw1Loqdx0QDUQGigtY
 N7C2Rx7VVdb1kGJWBQBniP8HKCoQBddQYVVOQ6i7qaJZWUN9umdMfD8Kd9Nb1mppnq/5
 KzSjsdAHA6DOFaf6zu8k9Fz4m6Rj6i45lbqfKwdOVxmjtiZj3w0kRrv4vPtbCeaWgDWC
 cNHO4JmOhOu5Iv/eGWRqKdCZcethiBPeEaj77BxQARM2V+cQIo82y6zzhVz6ftLRnHaA
 Yn49D7yDx3j/3IMtOrl0khWp5irO+sOGy0jZWqgHYmi+1UPIftadiiGxBlA7iDing6AG
 pRxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUoGC6vq9PbH68Z3As5FFShZKEmOqeDM6+xA6M4OdoHPlz3z2AodvTPP6auV9IBJ2GOdoVhsxEud7K@nongnu.org
X-Gm-Message-State: AOJu0Yx3w9UDQ9/fDLE1dw1c6+oVv5KEfxeSARWNbS1WKXRpQq2wyq0z
 /L13jq8sdThsHJjtSDTaL+UtQ9bdYxCB+wEAMWK+e6iewi1SD80WuH0A1qj3TR1V5ZdqjmfJcTU
 Zeel4av+hSzhjqFuMCwmeYABINEcyYYDft92W
X-Google-Smtp-Source: AGHT+IFMF1WqNd/AX105v8Hj56R65omEzX3+Mzpr0jpffbqghbiLf+QZ5RTdXBD9wf7N/b6mYsAQ4e11PtkX6BfmSKQ=
X-Received: by 2002:a05:6808:2f13:b0:3e5:df53:2f7b with SMTP id
 5614622812f47-3e5df532f95mr13075275b6e.44.1729179309524; Thu, 17 Oct 2024
 08:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240906225451.1039718-1-roqueh@google.com>
 <20240906225451.1039718-2-roqueh@google.com>
 <87v7y71tr4.fsf@draig.linaro.org>
In-Reply-To: <87v7y71tr4.fsf@draig.linaro.org>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Thu, 17 Oct 2024 08:34:57 -0700
Message-ID: <CAKbPEtYUcyXTSBW3Vs_g=UAMcNLbRJG0==bheO043-CW_XOFTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@linaro.org, 
 slongfield@google.com, komlodi@google.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=roqueh@google.com; helo=mail-oi1-x22b.google.com
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

I'm adding extra documentation to those fields in a new patchset.

On Fri, Oct 4, 2024 at 1:46=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> Roque Arcudia Hernandez <roqueh@google.com> writes:
>
> > In the context of using the remote gdb with multiple
> > processes/inferiors (multiple cluster machine) a given breakpoint
> > will target an specific inferior. If needed the remote protocol will
> > use the packet 'H op thread-id' with op =3D 'g' to change focus to the
> > inferior we want to insert/remove the breakpoint to, for instance
> > 'Hgp3.3' and not 'Hcp3.3'.
> >
> > This is supported by the documentation of the H packets:
> >
> >  > 'H op thread-id'
> >  > Set thread for subsequent operations ('m', 'M', 'g', 'G',
> >  > et.al.). Depending on the operation to be performed, op should be
> >  > 'c' for step and continue operations (note that this is
> >  > deprecated, supporting the 'vCont' command is a better option),
> >  > and 'g' for other operations.
>
> Can we better comment:
>
>     CPUState *c_cpu; /* current CPU for step/continue ops */
>     CPUState *g_cpu; /* current CPU for other ops */
>
> in GDBState?
>
> >
> > This can also be verified in the GDB source code file gdb/remote.c.
> > Functions remote_target::insert_breakpoint and
> > remote_target::remove_breakpoint will eventually call
> > remote_target::set_general_thread if it needs to change the process
> > focus and not remote_target::set_continue_thread.
> >
> > This can be seen around a comment that says:
> >
> >       /* Make sure the remote is pointing at the right process, if
> >          necessary.  */
> >
> > Google-Bug-Id: 355027002
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > ---
> >  gdbstub/gdbstub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > index d08568cea0..98574eba68 100644
> > --- a/gdbstub/gdbstub.c
> > +++ b/gdbstub/gdbstub.c
> > @@ -1148,7 +1148,7 @@ static void handle_insert_bp(GArray *params, void=
 *user_ctx)
> >          return;
> >      }
> >
> > -    res =3D gdb_breakpoint_insert(gdbserver_state.c_cpu,
> > +    res =3D gdb_breakpoint_insert(gdbserver_state.g_cpu,
> >                                  gdb_get_cmd_param(params, 0)->val_ul,
> >                                  gdb_get_cmd_param(params, 1)->val_ull,
> >                                  gdb_get_cmd_param(params, 2)->val_ull)=
;
> > @@ -1172,7 +1172,7 @@ static void handle_remove_bp(GArray *params, void=
 *user_ctx)
> >          return;
> >      }
> >
> > -    res =3D gdb_breakpoint_remove(gdbserver_state.c_cpu,
> > +    res =3D gdb_breakpoint_remove(gdbserver_state.g_cpu,
> >                                  gdb_get_cmd_param(params, 0)->val_ul,
> >                                  gdb_get_cmd_param(params, 1)->val_ull,
> >                                  gdb_get_cmd_param(params, 2)->val_ull)=
;
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

