Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73D2C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvBqD-0006N5-1V; Thu, 20 Mar 2025 05:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tvBqB-0006Mv-VJ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:05:27 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tvBqA-0008KJ-7L
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:05:27 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4769b16d4fbso2702801cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742461524; x=1743066324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQxqmXO0ndR9mSTUp4d7QyxDZY9EdYvjYU8Tm8AjhpY=;
 b=lTEIV6qf2vfg+plUNjkto0lI0xsQEkvzatCZlYsdynkI0/hLnuDUIEmsr5vuUvpgon
 YDL4EP7lLvG5zuuZGnkxedhtzfIeOwsK/k6Ja5cnP8xD7960eHRJCJTC2ZJNFjNJqi2k
 cpF7Bu/6wYlVCrPVPPF/mpmlvzAIDLwt1F320+6GFmg87n0JS9FN0i0KR5DHvursYUJf
 e6jneKjuby4sNYww9PpKdd7rtGQyvC8mW2qtOB6qpTScBvQX15sNweahtLwdK7Ui+cp3
 3WzR3Il084XzaoiluuWcMuifgoVem4xatIViOyeZGQ6ccqMu4yOYXuubL74dug5oB524
 XeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742461524; x=1743066324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQxqmXO0ndR9mSTUp4d7QyxDZY9EdYvjYU8Tm8AjhpY=;
 b=D7VMoGnnK7rOeM6bTSbferDDKStIo+HMVulSqalhec4D1VogjtLJp1l7gVJvpWndiI
 iJ7pAtY4hUlxAL+QtwHBMSdJoTEWyscFm8jLmZfTOLkHtWSvH4nIAaACcBQzCdnZ4yyN
 /mq8lPDJeWA/a3g4h0xRScV5aNcq/Qd6K0WRzvFGBr5P+GCb16KO1UAlOzz/RsOoxWkq
 pF24mw8tGb0HExmmgdvx02Gg7/qVp47O6+ndrbBc9mKsW+aw3nUz+m7Dje7NIpz22bF+
 FIPBP9IN1m7bCxx5KzBpICBUFtlKbsEOh8x7h9GYUucOqsHN0qkHVHVZw49P+NbPJ0vk
 KzzA==
X-Gm-Message-State: AOJu0YyfEeEV4ojvSLYMrYeRfNU1di5yqaiTw0LIyboEQTvrhV0sMz0Z
 DV7e0qo0r/8e4bD8zH9HjynBRD1xV4IaDOR9CGqSKzZ2SVAR03ePUw63IyQgHXy1wxLAAvTztUq
 Rx2EGleYdKtC+rmdCPrLEk1JdmxN7lwdKpJw=
X-Gm-Gg: ASbGncsETz2L66BjQS5GUtBuplVoF90alwSzATFTZvGwkhK/zD9qdI3tzRZAgXra4un
 SiHhVIlk8CSABj3/ybn6YpNmjR1zvgL4z4/EfdRmq9B1H7hJz4c6naVPPhc7ffmiU0m54BUj3G1
 6BUkSVTKDNK+CfiiklaFoo9u1Rz9iTEWqejpClFDKIsiKf+F5KxVvYhONfAOI=
X-Google-Smtp-Source: AGHT+IH/xzZQEE5+2kqkkEhM+BWw3zUOAWwUH9v/plH5JL+/6ZdkiKZsQEs4vSuo5AdEoTdN3Gs+VVKzEZ1+4qhp32o=
X-Received: by 2002:a05:622a:588c:b0:476:903a:b7f1 with SMTP id
 d75a77b69052e-47710c97ec9mr51857511cf.11.1742461524240; Thu, 20 Mar 2025
 02:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
 <20250311155932.1472092-11-marcandre.lureau@redhat.com>
 <CAE8KmOwiL+GNf3d_4W5Womh33UUP1oM7a6tQstDra6v=4rLTnQ@mail.gmail.com>
In-Reply-To: <CAE8KmOwiL+GNf3d_4W5Womh33UUP1oM7a6tQstDra6v=4rLTnQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Mar 2025 13:05:13 +0400
X-Gm-Features: AQ5f1Jpvx_Ote_LINGJkoAh7LiseKfCHIu_pLw4rqXZ7uBapeiXFqXrhtnRoQjA
Message-ID: <CAJ+F1CKE8T=g1Mkp8uJUTJ9aSdp_ooZrQ7h39yEh1Lm3KwY5qQ@mail.gmail.com>
Subject: Re: [PATCH for-10.1 10/10] ui/vdagent: remove migration blocker
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002fef360630c27097"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002fef360630c27097
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well, there isn't much else to say. And there is a Fixes tag. I don't think
we have strict rules about commit message, but I am fine adding more
context on each commit.

Le jeu. 20 mars 2025, 12:39, Prasad Pandit <ppandit@redhat.com> a =C3=A9cri=
t :

> On Tue, 11 Mar 2025 at 21:44, <marcandre.lureau@redhat.com> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Fixes: https://issues.redhat.com/browse/RHEL-81894
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> * No commit message? Same for patch 09/10.
>
> ---
>   - Prasad
>
>
>

--0000000000002fef360630c27097
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Well, there isn&#39;t much else to say. And there is a Fixes=
 tag. I don&#39;t think we have strict rules about commit message, but I am=
 fine adding more context on each commit.</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">Le jeu. 20 mars 2025, 12:39, Prasad Pandit &lt;<a href=3D"m=
ailto:ppandit@redhat.com">ppandit@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">On Tue, 11 Mar 2025 at 21:44, &lt;<a =
href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">marcandre.lureau@redhat.com</a>&gt; wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com<=
/a>&gt;<br>
&gt;<br>
&gt; Fixes: <a href=3D"https://issues.redhat.com/browse/RHEL-81894" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://issues.redhat.com/browse/R=
HEL-81894</a><br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@re=
dhat.com</a>&gt;<br>
<br>
* No commit message? Same for patch 09/10.<br>
<br>
---<br>
=C2=A0 - Prasad<br>
<br>
<br>
</blockquote></div>

--0000000000002fef360630c27097--

