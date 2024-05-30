Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B935C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbDk-0002Gl-EF; Thu, 30 May 2024 04:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCbDi-0002Dk-PZ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 04:33:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCbDg-0003vU-Ol
 for qemu-devel@nongnu.org; Thu, 30 May 2024 04:33:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57863a8f4b2so661606a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717057987; x=1717662787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BR0tSkJOMvOdmP7ujTpSxtn2cbluB1WhcFJ51DyKmjM=;
 b=HOrwK6rXi6D6jKzT8rWJew+3B69PWdsiPfJu5a//NlIqbjDVrH3jbj8l48djfvnTK4
 Bh784K648jAZyFaW9DQ9eM4krKOVxlEOTjOnpaSMd+GNt577m73hpb6r/2wkyPEW6b9p
 isxsg4uxRZY9BITgLTNq7lCesI1KZsrVnS3Ysrd3sh8AZtzby9CczCH4Y66y4CBS+0pK
 ithWwwCpFOlpNdbjDnEmyFwfAde50p/T1xYzfkPm5HcrlWvesRgwdN8XTxfSEBvN82zb
 I2l2rFNdqLiPGMSamd+fcJBfPxEOE+fryVA/0Rv+yhcj9uwjYR2vk6mBxSG7qzt163ly
 AqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717057987; x=1717662787;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BR0tSkJOMvOdmP7ujTpSxtn2cbluB1WhcFJ51DyKmjM=;
 b=tSNYJC6liPypxn1pZMrNYGny67w4peIitI7Tus22i7Axzia/MV199CL8SQcMV2Ozn/
 tVIUYzP0eaRSimgPdC1mm/I6+t78ubuk+wll+9aHRsCEkmKJHWTmLP8pNyz8p/cSxMkr
 iT+EgxBk+2e0aGuupMfnNIj9ShWp8gGLt4IvQUHCYjfmuEVLKy7GyvgFsGL1ZPx1tWN9
 j8od2AQaRjeQhcpniagHzQCSEWXa+I3SFnarQsG5CxZWx/V2X6PQ+7XmwCz6EDf23QA/
 /saIcnHMOgRcHTjmMHrJ57TWAp1yhJyTXiskhLBEl92hKa6OmetCX+o5APDQua846Gu6
 I80w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpVj1LWlm28lb4FWWIAyIpvIX0GcSlouySGD//IqRSrvgL0V+vhlBYrOm86nH5VRSkcXhDLsctRFEqH2i0Nhh9Xao/TDI=
X-Gm-Message-State: AOJu0YyaERBsZwe8YijUQui/CG0BjtM/jO2guCCbvPdrrrcCj497d9V7
 NUAUUMh8h2jm35hnWotCA3+6s99y2ebZx9amSHHqaAl8RLNgfllsWV7ob2TQA8w=
X-Google-Smtp-Source: AGHT+IFJ4ZmRLxZi6nW7CZ1TH58Jx7/0HYifdWDswszkMbr43Si84j2c/YIXcyjVsUmh+Fe3nc+PgQ==
X-Received: by 2002:a05:6402:1e87:b0:578:6832:8c38 with SMTP id
 4fb4d7f45d1cf-57a177fa02bmr805926a12.24.1717057986763; 
 Thu, 30 May 2024 01:33:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57852339fc4sm9436064a12.15.2024.05.30.01.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 01:33:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB6665F77F;
 Thu, 30 May 2024 09:33:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
In-Reply-To: <CACBuX0SR2cuFu+GaFGxp5rD_b+4HnNHfhQx2Csdw8L8QN+T7AA@mail.gmail.com>
 (Cord Amfmgm's message of "Wed, 29 May 2024 23:54:18 -0500")
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
 <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
 <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
 <CACBuX0SR2cuFu+GaFGxp5rD_b+4HnNHfhQx2Csdw8L8QN+T7AA@mail.gmail.com>
Date: Thu, 30 May 2024 09:33:05 +0100
Message-ID: <87zfs7d7i6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Cord Amfmgm <dmamfmgm@gmail.com> writes:

> On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
>
>  On Tue, 28 May 2024 at 16:37, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>  >
>  > On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
>  >>
>  >> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>  >> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <peter.mayde=
ll@linaro.org> wrote:
<snip>
>  >> > And here's an example buffer of length 0 -- you probably already kn=
ow what I'm going to do here:
>  >> >
>  >> > char buf[0];
>  >> > char * CurrentBufferPointer =3D &buf[0];
>  >> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in the =
buffer"
>  >> > // The OHCI Host Controller than advances CurrentBufferPointer like=
 this: CurrentBufferPointer +=3D 0
>  >> > // After the transfer:
>  >> > // CurrentBufferPointer =3D &buf[0];
>  >> > // BufferEnd =3D &buf[-1];
>  >>
>  >> Right, but why do you think this is valid, rather than
>  >> being a guest software bug? My reading of the spec is that it's
>  >> pretty clear about how to say "zero length buffer", and this
>  >> isn't it.
>  >>
>  >> Is there some real-world guest OS that programs the OHCI
>  >> controller this way that we're trying to accommodate?
>  >
>  >
>  > qemu versions 4.2 and before allowed this behavior.
>
>  So? That might just mean we had a bug and we fixed it.
>  4.2 is a very old version of QEMU and nobody seems to have
>  complained in the four years since we released 5.0 about this,
>  which suggests that generally guest OS drivers don't try
>  to send zero-length buffers in this way.
>
>  > I don't think it's valid to ask for a *popular* guest OS as a proof-of=
-concept because I'm not an expert on those.
>
>  I didn't ask for "popular"; I asked for "real-world".
>  What is the actual guest code you're running that falls over
>  because of the behaviour change?
>
>  More generally, why do you want this behaviour to be
>  changed? Reasonable reasons might include:
>   * we're out of spec based on reading the documentation
>   * you're trying to run some old Windows VM/QNX/etc image,
>     and it doesn't work any more
>   * all the real hardware we tested behaves this way
>
>  But don't necessarily include:
>   * something somebody wrote and only tested on QEMU happens to
>     assume the old behaviour rather than following the hw spec
>
>  QEMU occasionally works around guest OS bugs, but only as
>  when we really have to. It's usually better to fix the
>  bug in the guest.
>
> It's not, and I've already demonstrated that real hardware is consistent =
with the fix in this patch.
>
> Please check your tone.

I don't think that is a particularly helpful comment for someone who is
taking the time to review your patches. Reading through the thread I
didn't see anything that said this is how real HW behaves but I may well
have missed it. However you have a number of review comments to address
so I suggest you spin a v2 of the series to address them and outline the
reason to accept an out of spec transaction.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

