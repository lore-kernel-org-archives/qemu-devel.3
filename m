Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F497C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58KO-00080K-F4; Thu, 09 May 2024 14:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s58KM-00080B-UU
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:17:10 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s58KL-0002y6-51
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:17:10 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f04f01f29aso720062a34.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715278627; x=1715883427; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YddP+uW0vZ5rv5ICzqmidP81Gty7647owFzaMFMpKro=;
 b=RMBiyw7mqczqqCpK3CCWXBwdQsj49sySBFjsC+ik8PmWTOn4unKtqbgYbEaWvwXEre
 BR2KtWaDiFsEXxKTsndq2gvNxa1rSCj1vCfFDuTaTTmDn9/EfXBzAvw3pyM8awGXSaLs
 woEWAAXKtdxiSDih46b38s9of1T8soSpYhYKvYw6hQazfTRI16wZPNKWX2jMiZxgYP0X
 ZmMbcxMJtcwRtJz63r4Afhijp9sHWz9MMm3Qn78U1d6RgsT5aNKSELZ5CHWGkXKR8n9Y
 XTWZOTxLHl1YBzLkYlJX2/xZYdut9ckCx091+Qg9ihzo8H0dRXct224o1BVS+3MUmqZQ
 z9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715278627; x=1715883427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YddP+uW0vZ5rv5ICzqmidP81Gty7647owFzaMFMpKro=;
 b=uG1tFPtGLkAbmnENM69AlWFyABAQpMWYLl/ELsA9ZDyv98eHSVLWjrau8Q1aPnC38z
 /S8vbNGWYC2b/0WEnpmE/WLFghe/IAqIkcSbCE6na7UqRCNlS9q7mTUC8vLmdKPEL3WE
 Yx7/Q/EZTvUCPhpQFhTwpLqiMBFEWaWAOxYKtFu4kBZwi30rbDN/tg0sXxIww21zt7Kw
 T9gi2XFFpXhxIbf7zegHAbhSL/OBGLueMeHCK4ZtjnpoY/yMMdGpBL9Q3tn+YytolHn4
 /oL8hGpnOSSbYMkCROD1xDdwfecnPuLRuuEIPvshmohWOMg8cL9M8mJUgC6Btl8IjYTS
 hjRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAKZ41w1Wst9JypUIjJxE3hXq01RDQHYFmhXFstECiqdsKfCpsZ85yTokaTqPnhVOXghtmBOFJyHgAPXnOwqazOe4uNC4=
X-Gm-Message-State: AOJu0YyYJxl8S8BUA4oKxJBIYG2o/Srj7KQF2rBzvc8JWfrn+1lXG8kj
 NGbrvdCoXbzaZBJc56I4z0UIXCqwPJZC5/nfhtEO/j9aWL+osvYl2XrnGYbmptY6JgxoWElshdU
 pL+oOM8T2HkTVS9yQ3J30djrPQG8=
X-Google-Smtp-Source: AGHT+IEu6Zmo8S518bx6l/X0CQW+Ys+rcaWJakWmnVkcYyrhwoRFtvhy4DTgn5xb90TnokmD8HoM1JQrUbtJYfUdXys=
X-Received: by 2002:a05:6358:27aa:b0:186:4ada:4256 with SMTP id
 e5c5f4694b2df-193bcfe35cfmr17673155d.22.1715278627457; Thu, 09 May 2024
 11:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
 <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
 <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
In-Reply-To: <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Thu, 9 May 2024 13:16:56 -0500
Message-ID: <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000047d4060618096d9f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000047d4060618096d9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 12:48=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Wed, 8 May 2024 at 16:29, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> > On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth <thuth@redhat.com> w=
rote:
> >>
> >> Your Signed-off-by line does not match the From: line ... could you
> please
> >> fix this? (see
> >>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
> >> , too)
> >
> >
> > I'll submit the new patch request with my pseudonym in the From: and
> Signed-off-by: lines, per your request. Doesn't matter to me. However, th=
is
> arises simply because I don't give gmail my real name -
> https://en.wikipedia.org/wiki/Nymwars
>
> I'm confused now. Of the two names you've used in this
> patch (Cord Amfmgm and David Hubbard), are they both
> pseudonyms, or is one a pseudonym and one your real name?
>
>
Hi Peter,

I am attempting to submit a small patch. For context, I'm getting broader
attention now because apparently OHCI is one of the less used components of
qemu and maybe the review process was taking a while. That's relevant
because I wasn't able to get prompt feedback and am now choosing what
appears to be the most expeditious approach -- all I want is to get this
patch done and be out of your hair. If Thomas Huth wants me to use a
consistent name, have I not complied? Are you asking out of curiosity or is
there a valid reason why I should answer your question in order to get the
patch submitted? Would you like to have a friendly chat over virtual coffee
sometime (but off-list)?

If you could please clarify I'm sure the answer is an easy one.

Thanks

--00000000000047d4060618096d9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 9, 2024 at 12:48=E2=80=AF=
PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, 8 May 2024 at 16:29, Cord Amfmgm &lt;<a href=3D"mailt=
o:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<b=
r>
&gt; On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth &lt;<a href=3D"mail=
to:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Your Signed-off-by line does not match the From: line ... could yo=
u please<br>
&gt;&gt; fix this? (see<br>
&gt;&gt; <a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-pat=
ch.html#patch-emails-must-include-a-signed-off-by-line" rel=3D"noreferrer" =
target=3D"_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch=
.html#patch-emails-must-include-a-signed-off-by-line</a><br>
&gt;&gt; , too)<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ll submit the new patch request with my pseudonym in the From: a=
nd Signed-off-by: lines, per your request. Doesn&#39;t matter to me. Howeve=
r, this arises simply because I don&#39;t give gmail my real name - <a href=
=3D"https://en.wikipedia.org/wiki/Nymwars" rel=3D"noreferrer" target=3D"_bl=
ank">https://en.wikipedia.org/wiki/Nymwars</a><br>
<br>
I&#39;m confused now. Of the two names you&#39;ve used in this<br>
patch (Cord Amfmgm and David Hubbard), are they both<br>
pseudonyms, or is one a pseudonym and one your real name?<br>
<br></blockquote><div><br></div><div>Hi Peter,</div><div><br></div><div>I a=
m attempting to submit a small patch. For context, I&#39;m getting broader =
attention now because apparently OHCI is one of the less used components of=
 qemu and maybe the review process was taking a while. That&#39;s relevant =
because I wasn&#39;t able to get prompt feedback and am now choosing what a=
ppears to be the most expeditious approach -- all I want is to get this pat=
ch done and be out of your hair. If Thomas Huth wants me to use a consisten=
t name, have I not complied? Are you asking out of curiosity or is there a =
valid reason why I should answer your question in order to get the patch su=
bmitted? Would you like to have a friendly chat over virtual coffee sometim=
e (but off-list)?</div><div><br></div><div>If you could please clarify I&#3=
9;m sure the answer is an easy one.</div><div><br></div><div>Thanks</div></=
div></div>

--00000000000047d4060618096d9f--

