Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC8FC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFxr3-0002rw-OV; Sat, 08 Jun 2024 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sFxr2-0002re-2y
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 11:19:40 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sFxqz-0006kI-TC
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 11:19:39 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-80b865e0978so128086241.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717859976; x=1718464776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=raz808e4rOaR/rFCPCrAQcdec3LfvRvmPagjFUHjYPQ=;
 b=ZGYbQ1vyGvWe7u1lRuntm9ioy1kXLZq04S+YrFX5/US8ASlM1VQPdFwdA2k6zIBpqp
 VlrzS2qElrOwuhHsNvh4lHBNtTo/bC96SCsZZLXEn4aS23Lb/0vunTW1wUv5qu6ywdNm
 Hyn9F5FOHqjWU10CgWvy8n7TI13LDTEE/Q24RrBpgVjNyQh+IdQasuDWJhdLnoXUNc8Y
 FkdtFZf7h5UiSVDCFnrKU77/k+7f1+BnNPkc+IjWULUbai8yXqA66CLcAb0F2wjNGAG5
 LClsH5ix7HwqJdxCVukYjssiz5Z/PeIZGS+GpiT/0FMWadP52SMoFk+9Q/zrJs9hJWKK
 vgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717859976; x=1718464776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=raz808e4rOaR/rFCPCrAQcdec3LfvRvmPagjFUHjYPQ=;
 b=U45j+8efpNPgPFPifLBZRVAyofarZE9RKdZ3vnOh61Qb8uRYAD+pG1jNstEfx/2Llg
 2jG+DNWOKhwYr6eEXvrPiJ9I9Dzqed9HZ1Whpo7r4bbEdA44NN3eInunWZi9OsiIYB0O
 CYnn4sOBPmc6h2Wmb4L6We2upWkwE4s7B4hwRhh8d3DIkzzja2WDmnHO63UswW4l/aKP
 Fto7s2H35rm8jkuEYjtSqZL+de8yUL4CdQa43f9NElAZKKuSHUa6Jqj+quOth2XrwArT
 hCx0E1qHGqE4nwf3SHtKu6ffAqPj4Kn7fgiR+ETgVVxEWotuaKhyPZ2bIAMKwv9u4ypi
 8YqQ==
X-Gm-Message-State: AOJu0YzXtTeNIHKFV0xMgHUOLhVEFFIEYATZvn/6cGlZWywSfbQpB/Go
 ad9p69oF5xEUg0asSOzLNWKaZMyHcAGLv8ViH4/27ENPozNYpBZ7Nzn2kOW8Bh8GbNrCLBT1gKs
 GdNjJGJ40A1U7FRjvskSe6ML6afQ=
X-Google-Smtp-Source: AGHT+IH8WAjnozQb61cnaieBAaOcxknYdW1UQwVkGrqt7faK9T+LRnOjvYtXyFV5ZbwEqWZ85DUK5YsaHOZigWn+ml8=
X-Received: by 2002:a05:6102:c8a:b0:47b:b2f7:2006 with SMTP id
 ada2fe7eead31-48c2758b3e4mr5897863137.3.1717859976042; Sat, 08 Jun 2024
 08:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <CAFEAcA8JFMid+SeHWuoaK9meVWwgch9wwzKmT4SFUXz4U_iacw@mail.gmail.com>
 <CACBuX0RaZyXZtmdSsF279UZnw_St8mgX_U284zZ+o0o4ziHypw@mail.gmail.com>
 <CAFEAcA-xF=ko5xZ-KfquY_PBr3xXdnRrwp9JR01W7ko40_BFDQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-xF=ko5xZ-KfquY_PBr3xXdnRrwp9JR01W7ko40_BFDQ@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Sat, 8 Jun 2024 10:19:24 -0500
Message-ID: <CACBuX0RatoEjUd0J5TXmwAxxRSg-y23++WnppZaK2f8xkfa8Ow@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a56010061a6271e6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.3, HTML_MESSAGE=0.001,
 NORMAL_HTTP_TO_IP=0.001, NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000a56010061a6271e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:23=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Fri, 31 May 2024 at 19:16, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> > On Fri, May 31, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >> What I would like to see is what we could classify under
> >> "rationale", which is to say "what prompted us to make this
> >> change?". In my experience it's important to record this
> >> (including in the commit message). There are of course
> >> many cases in QEMU's git history where we failed to do that,
> >> but in general I think it's a good standard to meet. (I
> >> am also erring on the side of caution in reviewing this
> >> particular patch, because I don't know the relevant standards
> >> or this bit of the code very well.)
>
> > Thanks, in responding to that, I'm breaking down my responses into the
> following answers:
> >
> > Q1: (summarizing) What prompted us to make this change?
> >
> > A1: I'm summarizing what I wrote in previous emails and the commit
> message -
> >
> > * Bring qemu closer to actual hw with a neatly packaged test case to
> demonstrate the behavior
> > * I interpret the spec (Table 4-2) as saying the "be =3D cbp - 1" is
> valid, in addition to setting "cbp =3D 0"
> > * I interpret it that way due to a comment in an old linux kernel
> version in the 2.x range, ohci-hcd.c file. It said (paraphrasing) some
> misbehaving ohci controllers would fetch physical memory at 0 when cbp =
=3D 0
> was in the Transfer Descriptor
>
> Interesting. Do you have a more specific version for that?
> I had a look at various 2.x Linux OHCI drivers but they all seem to do
> zero-length packets "by the spec" with CBP=3DBE=3D0. eg 2.6.39.4:
>
> https://elixir.bootlin.com/linux/v2.6.39.4/source/drivers/usb/host/ohci-q=
.c#L539
> and there's no hardware-quirk handling to do it differently on
> some controllers. (The USB OHCI driver seems to have gone through
> a couple of rewrites in the 2.x kernel timeframe; the earlier 2.3.51
> version does the TD fill here:
> https://elixir.bootlin.com/linux/2.3.51/source/drivers/usb/usb-ohci.c#L81=
2
> and again it handles zero length as BE=3DCBP=3D0.)
>
> > But I only have a test case I created myself, and am not an expert on
> computer history here. I think "be liberal in what you accept, by
> conservative in what you send" applies when I don't know which historical
> OSes, if any, need this behavior. I think the behavior of actual hardware
> weighs more heavily since that *is* available and testable. Are there
> additional checks that would expand on what's known about actual ohci hw?
>
> The other side of the argument is "if in doubt and you don't
> know of any concrete problem being caused, don't change
> working code". If there are any historical OSes that rely on
> being able to send zero packets with be=3Dcbp-1 for some nonzero
> be, and anybody wants to run them on QEMU, then presumably they
> can send us a bug report saying "XYZ's USB support doesn't work".
> That nobody has ever does this is evidence on the side of
> "there is no such OS out there, everybody writing an OHCI driver
> read the spec and made their driver send zero length packets the
> way the spec very clearly says you should". Please correct me
> if I'm wrong, but my interpretation of your helpful explanation
> above is that this is essentially a theoretical problem rather
> than one that's caused you a problem you need to fix.
>

 I think that's fair.

I sent in the patch more out of a desire for qemu to have the greatest
possible ohci implementation, than due to knowledge of an actual OS that
couldn't work.

Up to you what to do from here.

--000000000000a56010061a6271e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 7, 2024 at 8:23=E2=80=AFA=
M Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayde=
ll@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Fri, 31 May 2024 at 19:16, Cord Amfmgm &lt;<a href=3D"mailt=
o:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<b=
r>
&gt; On Fri, May 31, 2024 at 9:03=E2=80=AFAM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt; What I would like to see is what we could classify under<br>
&gt;&gt; &quot;rationale&quot;, which is to say &quot;what prompted us to m=
ake this<br>
&gt;&gt; change?&quot;. In my experience it&#39;s important to record this<=
br>
&gt;&gt; (including in the commit message). There are of course<br>
&gt;&gt; many cases in QEMU&#39;s git history where we failed to do that,<b=
r>
&gt;&gt; but in general I think it&#39;s a good standard to meet. (I<br>
&gt;&gt; am also erring on the side of caution in reviewing this<br>
&gt;&gt; particular patch, because I don&#39;t know the relevant standards<=
br>
&gt;&gt; or this bit of the code very well.)<br>
<br>
&gt; Thanks, in responding to that, I&#39;m breaking down my responses into=
 the following answers:<br>
&gt;<br>
&gt; Q1: (summarizing) What prompted us to make this change?<br>
&gt;<br>
&gt; A1: I&#39;m summarizing what I wrote in previous emails and the commit=
 message -<br>
&gt;<br>
&gt; * Bring qemu closer to actual hw with a neatly packaged test case to d=
emonstrate the behavior<br>
&gt; * I interpret the spec (Table 4-2) as saying the &quot;be =3D cbp - 1&=
quot; is valid, in addition to setting &quot;cbp =3D 0&quot;<br>
&gt; * I interpret it that way due to a comment in an old linux kernel vers=
ion in the 2.x range, ohci-hcd.c file. It said (paraphrasing) some misbehav=
ing ohci controllers would fetch physical memory at 0 when cbp =3D 0 was in=
 the Transfer Descriptor<br>
<br>
Interesting. Do you have a more specific version for that?<br>
I had a look at various 2.x Linux OHCI drivers but they all seem to do<br>
zero-length packets &quot;by the spec&quot; with CBP=3DBE=3D0. eg <a href=
=3D"http://2.6.39.4" rel=3D"noreferrer" target=3D"_blank">2.6.39.4</a>:<br>
<a href=3D"https://elixir.bootlin.com/linux/v2.6.39.4/source/drivers/usb/ho=
st/ohci-q.c#L539" rel=3D"noreferrer" target=3D"_blank">https://elixir.bootl=
in.com/linux/v2.6.39.4/source/drivers/usb/host/ohci-q.c#L539</a><br>
and there&#39;s no hardware-quirk handling to do it differently on<br>
some controllers. (The USB OHCI driver seems to have gone through<br>
a couple of rewrites in the 2.x kernel timeframe; the earlier 2.3.51<br>
version does the TD fill here:<br>
<a href=3D"https://elixir.bootlin.com/linux/2.3.51/source/drivers/usb/usb-o=
hci.c#L812" rel=3D"noreferrer" target=3D"_blank">https://elixir.bootlin.com=
/linux/2.3.51/source/drivers/usb/usb-ohci.c#L812</a><br>
and again it handles zero length as BE=3DCBP=3D0.)<br>
<br>
&gt; But I only have a test case I created myself, and am not an expert on =
computer history here. I think &quot;be liberal in what you accept, by cons=
ervative in what you send&quot; applies when I don&#39;t know which histori=
cal OSes, if any, need this behavior. I think the behavior of actual hardwa=
re weighs more heavily since that *is* available and testable. Are there ad=
ditional checks that would expand on what&#39;s known about actual ohci hw?=
<br>
<br>
The other side of the argument is &quot;if in doubt and you don&#39;t<br>
know of any concrete problem being caused, don&#39;t change<br>
working code&quot;. If there are any historical OSes that rely on<br>
being able to send zero packets with be=3Dcbp-1 for some nonzero<br>
be, and anybody wants to run them on QEMU, then presumably they<br>
can send us a bug report saying &quot;XYZ&#39;s USB support doesn&#39;t wor=
k&quot;.<br>
That nobody has ever does this is evidence on the side of<br>
&quot;there is no such OS out there, everybody writing an OHCI driver<br>
read the spec and made their driver send zero length packets the<br>
way the spec very clearly says you should&quot;. Please correct me<br>
if I&#39;m wrong, but my interpretation of your helpful explanation<br>
above is that this is essentially a theoretical problem rather<br>
than one that&#39;s caused you a problem you need to fix.<br></blockquote><=
div><br></div><div>=C2=A0I think that&#39;s fair.</div><div><br></div><div>=
I sent in the patch more out of a desire for qemu to have the greatest poss=
ible ohci implementation, than due to knowledge of an actual OS that couldn=
&#39;t work.</div><div><br></div><div>Up to you what to do from here.</div>=
</div></div>

--000000000000a56010061a6271e6--

