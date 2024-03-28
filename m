Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD7CC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 01:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpeQO-00046Z-N2; Wed, 27 Mar 2024 21:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rpeQN-00046J-CY; Wed, 27 Mar 2024 21:19:23 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rpeQL-0005gv-SH; Wed, 27 Mar 2024 21:19:23 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7e0cfda8e00so97007241.2; 
 Wed, 27 Mar 2024 18:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711588760; x=1712193560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxqLt/KlC6tre5aErDNxnNj8XafgBxBA2yk6MH3jpZE=;
 b=VHeIpC6kjxqXcVgrg6wz5WqVA6BWngBaPGPZac4uKgAh5bJ3HyLyxpVrDFBsJWOAAq
 bN0NEObtTSSA41YiutKKtQC213/2vBf/6HZzH5R+CEc/9IcjiZr2MrxbeiyvAqWWQBhG
 l2jyKIXeQhNWaZxNO1NxmIg8A2oPpvf+fJivZ1Tu6kTyTmNmDuO3iTsFuRFduP4DFOTI
 RZvGLOlBNefYncf0bTijEqxfe7zczbWVtR1spv/BQO45RDixpQnOYnXdwe1cESEU5hQb
 1tLlV5WEUbBqDA/iPY4mHNXyUfrIOqiJsy8ui+FlGDLTenDv1VuhELVTmWWxJCkg23ar
 QRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711588760; x=1712193560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxqLt/KlC6tre5aErDNxnNj8XafgBxBA2yk6MH3jpZE=;
 b=eZfjfx20fZGLpR22pwgjyaBIfaM3sjyUjlslLFbAOnGzSVmHmZP3Fv2xbbTcZbRzti
 iIEqSW2dGoOwzAQxIjuWmp5TGXiMubs4dodRcQwoLYNEn3XTrvvmNpcoNc3q5/tK1rwe
 DFsyS3tbGZIa5nAsFrs9DeTmde1sB+Sf/dVMNamIO29yj/bPscFdSHOb7Ss8MNVe/DBl
 uk8Hzepd7LqyDbp5twLa2K2p6gKNzjoWGK+WGZcFo7Rmgud+QKq0/9onSxyKfqaJGrAm
 ycqyxAjcjND0Fl3u5IsmWqvCTHGADR1G1o5Cch8qEZai6lIe0AIuL0vUUJeI0J6KWS0S
 E38Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUik2BPI1fo2b8FhzBqi55PydY34n40DmI5IE4oDM925loj3BRXybwHIBDiHUqn2mE/cjD+tlNmt9oWYVwiGVB/oPK0BgDofZY9NKtInputXgZ3Mx2J+qC2gRybw==
X-Gm-Message-State: AOJu0Yz3OzwIyuup2PY0WixlcSiUJ6Bywkz5fPV+vb8HTuo3jUUlldqS
 Wm9y0jLtygqvAsNX4lo8tIrcFYg+ew47jrxxhqJr0KMLWMDj7eWLGwfjmJW0NI0LQl34miC6gtg
 1TAZrFd64djs8BD18dUdfoEtSJ+U=
X-Google-Smtp-Source: AGHT+IF7OJXtbzhwaMx9OMTtNvgjsLZfelE6lpP0uaN74s4dHsKgOE+XdbzsCiLw6vPiQVl8gexyNtciJ+eW0l9Mrfc=
X-Received: by 2002:a67:e986:0:b0:473:4d73:5e1c with SMTP id
 b6-20020a67e986000000b004734d735e1cmr1072355vso.9.1711588759746; Wed, 27 Mar
 2024 18:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240204054228.651-1-zhiwei_liu@linux.alibaba.com>
 <20240204054228.651-3-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKNGMjLg+JjJZAp+EsmfaWAyT7XiHZzBXZxeghS0hv6REg@mail.gmail.com>
 <CAEg0e7i6zaEhyfhRFKcTYjkCqRCzJ5eB+0EHUDVA6t-ypL78eg@mail.gmail.com>
 <CAKmqyKPgAQ4JaSNRmFfR-=w3daDkag-ORz0Ckn7r1JNmf8X2oA@mail.gmail.com>
 <20240327-overrun-outcast-795708a30e8c@spud>
In-Reply-To: <20240327-overrun-outcast-795708a30e8c@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Mar 2024 11:18:53 +1000
Message-ID: <CAKmqyKP8kE=BDv2NzLeU+B3WNMJyke41__yOdVVcwe7k=9wpwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Support xtheadmaee for thead-c906
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org, 
 bjorn@kernel.org, Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 27, 2024 at 9:19=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Christoph linked here on his submission to Linux of a fix for this, so I
> am reviving this to leave a couple comments :)
>
> On Thu, Feb 15, 2024 at 02:24:02PM +1000, Alistair Francis wrote:
> > On Mon, Feb 5, 2024 at 6:37=E2=80=AFPM Christoph M=C3=BCllner
> > <christoph.muellner@vrull.eu> wrote:
> > > On Mon, Feb 5, 2024 at 3:42=E2=80=AFAM Alistair Francis <alistair23@g=
mail.com> wrote:
> > > > On Sun, Feb 4, 2024 at 3:44=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux=
.alibaba.com> wrote:
>
> > > > >              ppn =3D (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PP=
N_SHIFT;
> > > >
> > > > Unfortunately we won't be able to take this upstream. This is core
> > > > QEMU RISC-V code that is now being changed against the spec. I thin=
k
> > > > adding the CSR is fine, but we can't take this core change.
> > > >
> > > > A fix that works for everyone should be supporting the th_mxstatus
> > > > CSR, but don't support setting the TH_MXSTATUS_MAEE bit. That way
> > > > guests can detect that the bit isn't set and not use the reserved b=
its
> > > > in the PTE. From my understanding the extra PTE bits are related to
> > > > cache control in the hardware, which we don't need here
> > >
> > > Sounds good! Let me recap the overall plan:
> > > * QEMU does not emulate MAEE, but signals that MAEE is not available
> > > by setting TH_MXSTATUS_MAEE to 0.
> >
> > Yep!
> >
> > > * Consequence: The c906 emulation does not enable any page-base memor=
y
> > > attribute mechanism.
> >
> > Exactly
> >
> > > * OpenSBI tests the TH_MXSTATUS_MAEE bit (M-mode only) and provides
> > > that information to user-space (e.g. DTB).
> >
> > To the kernel, but yep!
> >
> > > * The current Linux errata code will be enhanced to not assume MAEE
> > > for each core with T-Head vendor ID, but also query the MAEE bit and
> > > ensure it is set.
> >
> > I feel like it should already do that :)
>
> It doesn't quite do this right now. It only makes the assumption for
> CPUs where marchid and mvendorid are zero. The c908, and I think Guo Ren
> confirmed it will be the case going forward, sets these to non-zero
> values. We should have always required a dt property be set, rather than
> using m*id, but we can't go back on that for these devices. Going
> forward, if there are more CPUs that want to use this e.g. C908 in MAEE
> mode (it can do svpbmt too) I'm gonna require it is explicitly set in
> DT.

A DT node that we don't set also works fine for us

Alistair

