Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3773FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYZH-0004Aa-8J; Tue, 02 Jul 2024 04:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOYZF-0004AK-3v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:08:49 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOYZD-0003iA-KF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:08:48 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-446427c5923so36008811cf.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719907726; x=1720512526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8QGrMlwNoqZ8Ow6CEwgXFGmQfIRT9oXtSy6Qm7YZ3A4=;
 b=nNRX9I5tRgjwnkrn7hn4o6Q/nTlLCbu3UdFJ1Tn1Oj3RvhwV6/ROSH2Jc5XYiAv4RY
 upTf2DLgg2PHTWxnXNAEU3P7iR2wMDe7A4pZ45gW6o4kszXEj/sfV+BnY5Viyss2zL/0
 RseHBgwoUam9pIRYrdnKTAwY7YLDzcOswfobGKcqIDxRVjNB0UcI1q8sd2BmeHDvVDqr
 yPam74sV3Z1fmuBo1gbce82WJ+E0yjkrBYCKpnciqAb+qDmgSEi11QnzuUylvzrlp9bp
 o6TAEEIMCxoTM7UevZk/nx++2MQTYJVoheOgTQhqQk+fRzk/wL60UMfRwjQ9HSYPBa/a
 s8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719907726; x=1720512526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8QGrMlwNoqZ8Ow6CEwgXFGmQfIRT9oXtSy6Qm7YZ3A4=;
 b=wLE3qZnqfqtcBLZT2R+609UM/nkX+mwlGqQHzm712AlcSasKPyzAsLmV+7BKymQMB4
 L5q8ej9RWHtRtCsgAsuSop99DGh/JRfg9VuucFTH+fhPTLCT0OCn4Mb3JHCTQqqhjlGs
 WcEE2PmqfRpjNXVaz2nsjvNjmFUcMxjYLa3s1P+72MjaYa5oFSwtnPWVHSw6V0keEcc1
 q35P8gmWmnMqP97b1ddjJkPHX2k5ttLvs1PDGSfZXwc0nTZ7szdA3yzyVsOtU2MLKdK8
 trp42eF/TTcNCRQHWkvUA/zyjOe2AgYwz6i3WChz7Oq7JUoNz4GK0OkWWa80kVqYnH5G
 JUAw==
X-Gm-Message-State: AOJu0YyHrUIlIURtKMz7LvjT+Xx8vj3I/l8BBYEoB7BcUnmfuoYkMcml
 CAU3vCg1JNoR7HyVxNjW7un0Gae5roUU+Mr8GSXk54zxENMW5vRroJVy2Gskeci+5Rbpw7b8gRK
 boVIUTyOKG8Yf0c7efsLS11mEgFMgV3fj
X-Google-Smtp-Source: AGHT+IF5Lp5JLDlBcDdnCIa1VeR7oqVTRmdWcgUq+xuAyJC80hYJaf4XyBA9zz1X7CM2isCljA+reSekfp11tIvZPwk=
X-Received: by 2002:a05:622a:15cd:b0:444:cc00:84db with SMTP id
 d75a77b69052e-4465567bd20mr176009831cf.19.1719907725512; Tue, 02 Jul 2024
 01:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240626155140.74752-1-lvivier@redhat.com>
In-Reply-To: <20240626155140.74752-1-lvivier@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jul 2024 12:08:33 +0400
Message-ID: <CAJ+F1C+1fmOfE_48iNxCRvxNB+Q_yBrJAUoAi7WyPx-=N756-g@mail.gmail.com>
Subject: Re: [PATCH] net: update netdev stream/dgram man page
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000069c39061c3f39a4"
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

--000000000000069c39061c3f39a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 26, 2024 at 7:53=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:

> Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
> manpage.
>
> Add some examples on how to use them, including a way to use
> "-netdev stream" and "passt" in place of "-netdev user".
> ("passt" is a non privileged translation proxy between layer-2,
> like "-netdev stream", and layer-4 on host, like TCP, UDP,
> ICMP/ICMPv6 echo)
>

Was there any plan to have passt fallback (default / "-net passt") when
slirp is disabled ? spawning the process with -F fd etc. That would help
migrating away from slirp for some systems.

--=20
Marc-Andr=C3=A9 Lureau

--000000000000069c39061c3f39a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 26, 2024 at 7:53=E2=80=
=AFPM Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.com">lvivier@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Add the description of &quot;-netdev stream&quot; and &quot;-netdev d=
gram&quot; in the QEMU<br>
manpage.<br>
<br>
Add some examples on how to use them, including a way to use<br>
&quot;-netdev stream&quot; and &quot;passt&quot; in place of &quot;-netdev =
user&quot;.<br>
(&quot;passt&quot; is a non privileged translation proxy between layer-2,<b=
r>
like &quot;-netdev stream&quot;, and layer-4 on host, like TCP, UDP,<br>
ICMP/ICMPv6 echo)<br></blockquote><div><br></div>Was there any plan to have=
 passt fallback (default / &quot;-net passt&quot;) when slirp is disabled ?=
 spawning the process with -F fd etc. That would help migrating away from s=
lirp for some systems.<br><div><br></div></div><span class=3D"gmail_signatu=
re_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-An=
dr=C3=A9 Lureau<br></div></div>

--000000000000069c39061c3f39a4--

