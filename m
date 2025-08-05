Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CDBC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKpi-0005jC-7x; Tue, 05 Aug 2025 12:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKpe-0005h4-5f
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:48:10 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKpc-0002h3-CW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:48:09 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6155e75a9acso8517614a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754412486; x=1755017286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gia9WWHTlTGh2REw9LUgcLe3DCJNJ0VnYRNN2Dja+nw=;
 b=NgK+8Y6V/XmMNBCl6Yl0Y9bTGs5fbtP8V3ZgoOfyYTSKxqlt0zu3B7cPHVETQZHE+P
 UNVP4I+mJp5JXycPz+0KoYjTDMQwQZue5CRWARk9uV2qIL7uUB3wkoSSfBHWbaP8I61e
 UXE6BcuA+daaXJL+vLVEI15lv9wQWkaB/bEaLtRy5yvKsJpJmVN9SYiPQ/PFBppydogu
 dPBA8neuZcjGJRv6jaJHxmjjBqMgoE5UjKtf1IUWPp4m+EqE3pZHKFSxA1/lS6apg45w
 nTk+nrN6RiqGDc1z9ZgKSUyDAd3XWrCNf4tkSn2eIcIqeySlWS8dYwwgwEOZegS1j1bk
 bjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754412486; x=1755017286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gia9WWHTlTGh2REw9LUgcLe3DCJNJ0VnYRNN2Dja+nw=;
 b=fJQqQ+fiYGtQESNxYPI7O9me64eUPykFuR5ZBt+74LU+0eSUCsXlUTD58aWcb2B4U7
 Q1/J/Qrky2Z8mnMywOakBmmZSkulLdIPuhmxVkEskIAAU6c7gJOwSEAprB0z7tro56D5
 t2SxeNE6vX0du0qr0z5FbKixWmF81m+8n4cvDKl8K96OtMx1q52NIOi/9Mf3165wRDBI
 VSzMHSAR1HA8pe185Y6GpjPAi+vOtrS4bGZ7vWhBzG6TQrLHS5xEtN1Ja0j7j4Uy9PSm
 tW1h3unNrCbejJFDG73mqaA7zeZaKlaAo7uxmtMDktmDW9Bv41QnybDz+2uIO9SO+Loq
 7tBA==
X-Gm-Message-State: AOJu0YxAcXi9LFo5sacDi/nkYGUs/rU3jM+f2Fy3Uvml7dJwJoM3hjD+
 iMTzl6KKTslN3bkaOhXJICpDzJkeRx0VzbjlD7GHCm07cXKeUOewKH4CFbsWv1UVUzchgCQBKX/
 C4DIf6FoJj6WsmVPeQaf5EqcdrcYNYIFoHmeq4guxKQ==
X-Gm-Gg: ASbGncuue3dgfSqULN2REBEMi3GmJa3kVe5I919CAqRAWE92okxSblkZEigW95No3A0
 910bFVQ6zKICN0iT/yF6lZZx6SnlnqmVgj2mZBGn/K5Kzt75bBCFe90IUiUMIJ5xrc+RWZ6t6Dp
 pUkSCvsUou07WObmpEyFL7q0KDyUfBZuASsDmBK3bdO5QB/hJWZzbCYkxIapqmx/XaVYWSwp0lX
 yhGtgYL
X-Google-Smtp-Source: AGHT+IGnL/HcRWFBIfD8KLABlRY1YA1o5/hiafLxqrIew4eNn/LJ/t/8mUh56lZqgZSuPoImtz83SWtehiVc6G45wno=
X-Received: by 2002:a05:6402:68a:b0:615:7047:4efd with SMTP id
 4fb4d7f45d1cf-615e6ed288bmr10328062a12.13.1754412486512; Tue, 05 Aug 2025
 09:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
In-Reply-To: <aJI0mr5HDgtE9HIc@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 5 Aug 2025 19:47:39 +0300
X-Gm-Features: Ac12FXw5z5QThovNUyMLGoZ4mp1RFpkiy0tJxM2eWnjb0r7jbcAf6BKdQIEyBDs
Message-ID: <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, Aug 5, 2025 at 7:43=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Aug 05, 2025 at 07:25:39PM +0300, Manos Pitsidianakis wrote:
> > On Tue, Aug 5, 2025 at 7:05=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > >
> > > On Mon, Aug 04, 2025 at 04:47:13PM +0300, Manos Pitsidianakis wrote:
> > > > This RFC series contains some simple patches I've been sitting on f=
or
> > > > some months to allow tracing in rust devices in a similar matter to=
 C,
> > > > only it's done via a proc-macro codegen instead of using tracetool
> > > > script or equivalent.
> > >
> > > IIUC, this series is only emitting the traces events via the
> > > qemu_log function, and so feels like it is missing the benefit
> > > of tracing, vs the traditional logging framework.
> > >
> > > In our RHEL & Fedora distro builds we disable the log backend
> > > and enable dtrace, so that we have fully dynamic tracing and
> > > observability across the kernel, qemu, libvirt and other
> > > components with dtrace integration.
> >
> > Hi Daniel,
> >
> > Thanks for the insight! Do you have any points where I should look at
> > the trace implementation for how the different backends are supported?
> >
> > So I think there's already work in progress to support proper tracing
> > for Rust, I only sent this as a temporary fixup to provide some kind
> > of parity between C and Rust implementations until a proper, better
> > solution is available that can replace it.
>
> Can the rust code not easily consume the existing functions in the
> trace.h files generated for the C code as a short-term solution ?
>
> It would not benefit from the code inlining in the same way as C
> would, but it would at least give feature parity for tracing with
> all the trace backends are available.
>
> Then, we can look at optimizing with a pure rust impl of some
> backends at a later date, to regain what we lost from lack of
> inlining ?

It can, but we'd need to add extra intermediate steps to convert the
trace headers into Rust equivalent code, so it's not ideal.

I tried to generate code exactly like the generated trace headers
though, so I'm not sure what is missing to be honest (hence my
previous email question). The generated code generates TraceEvents and
registers them with trace_event_register_group. What else is missing
to support e.g. dtrace?

Thanks in advance,

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

