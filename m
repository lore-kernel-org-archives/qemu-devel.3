Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B55D15D96
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tHF-00019r-Uz; Mon, 21 Oct 2024 10:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2tHE-00019Y-IJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:20:56 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2tHB-0007C9-J0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:20:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so46556561fa.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729520451; x=1730125251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXsMc5bPhL0vQu70vsDLYLsIM/mkdMZ+PlLh5x7fuWQ=;
 b=Ys5dRJChcBDMviayPNpa3VjRyjzp4GFHcmdHxX7LyyQXAfqGhGrCx3+IUrQ1ZkqnV9
 rXxGD6ajl4XTVeJNS76cj9PQmrJN4UmZ77xmmsGvImISJrD6C9VzyoWzZ8LbLnykhkp4
 zTOAphJGQ6U+CuJRy797M7oCTJQxsck9Vu89Bb8Eu5etB2awP5Od9Hl4wGU3J2f8GdZo
 mUOtw13TRr0nVHhY/i94fUlCC3AKpq8YGzqHdf0wytVSoP+zRumMtb3HLsow/nC5m82+
 f0tZmA9dw5LOsaQZF3h305ugqPfippXx/WaU788zAs3S4eIIxII7fM4pTvY+Yein1Q5x
 a4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729520451; x=1730125251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXsMc5bPhL0vQu70vsDLYLsIM/mkdMZ+PlLh5x7fuWQ=;
 b=LnpRtY1vUNKvFB0yASn1l1wjOcW82Njh3Xb0hHRrRbxzJIHwZLTEF6ETLovNpqto2S
 zWEUU4RxyBPl4/1a+Tq1/X2j409oXcEKsIxMj06W8+FPdOZTzkSvNiwmqBgUzixS53ny
 a7/bVXlt9qajd28+inwg34gbVPxumeyvbhMfLiLMbVpTZLN1C5Xzqq6OSj3vupIOJfAX
 zm/gW0qehqLaCGBPzdTu5II3PuIl6GvqWqD64rG+wK71lwTDAqaakCyPZYP+VGnYZOSS
 0WEM8EvQorsv7cHEE3okIpy2mm6T7xAHHPz5U4srUOJa9u9hZ8eSUUcsbULd8zZ54vMg
 gjtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPIrfRd8ILkhNOqxZn2MV+pDao4Ptq5doTGOHyhnf7rnetRp+RqcBLUK3Q+UIGXb0TpMuvp0Z/L5VF@nongnu.org
X-Gm-Message-State: AOJu0Yy5XRXBMmL20OOyAyf4guEmeiseGgpGB9+OgJiydvC55m9D8vQa
 vApDTvASC2EZ1tI6IA0diSG7RN1x+cR5GwjwGNfCwuEdVs5EMMjNppu64+VnKxrX/haz3hk+6Zk
 9l9ENc67UOlhh7KoUikOhCJz8/T/U35NSntJiTQ==
X-Google-Smtp-Source: AGHT+IGsXMwXqIMDzLZtLnGu5jr+ezgOorFumOrIQbA1+EIlKM06dweAN9zoAqvNGHSWWjqbeIBaA1UQ0JMt1387O7g=
X-Received: by 2002:a2e:b8d0:0:b0:2f9:cc40:6afe with SMTP id
 38308e7fff4ca-2fb82ea23f4mr54514751fa.14.1729520450970; Mon, 21 Oct 2024
 07:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
In-Reply-To: <ZxZjqypRL7d2rMuQ@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 15:20:39 +0100
Message-ID: <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_What_is_the_definition_of_=E2=80=9Cprivate?=
 =?UTF-8?Q?=E2=80=9D_fields_in_QOM=3F?=
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Mon, 21 Oct 2024 at 15:12, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Hi Peter,
>
> On Mon, Oct 21, 2024 at 10:25:07AM +0100, Peter Maydell wrote:
> > Date: Mon, 21 Oct 2024 10:25:07 +0100
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Subject: Re: [Question] What is the definition of =E2=80=9Cprivate=E2=
=80=9D fields in
> >  QOM?
> >
> > On Sat, 19 Oct 2024 at 16:54, Zhao Liu <zhao1.liu@intel.com> wrote:
> > >
> > > Hi maintainers and list,
> > >
> > > In the QOM structure, the class and object structs have two members:
> > > parent_class and parent_obj, which are often marked as "< private >" =
in
> > > the comment.
> > >
> > > I couldn=E2=80=99t find information on why to define =E2=80=98private=
=E2=80=99 and =E2=80=98public=E2=80=99,
> > > even in the earliest QOM commits and the patch emails I could find.
> >
> > This is a rather old thing which I think was originally
> > borrowed from glib's commenting convention.
> >
> > I'm fairly sure that we decided a while back that they were entirely
> > unnecessary, so you don't need to add them in new code. (I can't
> > actually find anything with a quick list search about that though
> > so maybe I'm misremembering.)
>
> Thanks for your explanation! So I understand that directly accessing
> parent_obj/parent_class is actually allowed.

No, you shouldn't do that. You can use a QOM cast of the
object pointer to the relevant parent class if you need to
treat it as an instance of the parent class.

What I mean by "the private/public markers are unnecessary" is
that they don't tell the reader anything, because all the fields
in a QOM device struct are private.

If you're not in the implementation of that class, then you shouldn't
really be directly touching any of the fields in the state struct.
(In some places we take a shortcut and do it. But really it's almost
never necessary.)

thanks
-- PMM

