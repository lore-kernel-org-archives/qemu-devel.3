Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2283AC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhqG-0004Rj-Lp; Mon, 09 Jun 2025 15:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uOhqE-0004RP-Sz
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uOhqC-0000HN-U8
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcUESyfIUIhBV36QKnBkAR2wu1H+tLhR7qJurWYI7aE=;
 b=LpL+SwLxeC/+G0XV7WFB47VvihSsqKvkfOXqRiO3G8R+M6b8RuVzeW3KrHdl+PVqHVvVRo
 cxx01f7Uwd9UwXbSJnAj6n2xHozvhrGhA23KyFBSKCCj2Qs2SU+i5NoYa6L14ejoCIbp1r
 1jUCGzvwD9x51JpPdtwgM3TYvXFr7X8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ajXhGHZKPkWSq6wHwpulDA-1; Mon, 09 Jun 2025 15:07:21 -0400
X-MC-Unique: ajXhGHZKPkWSq6wHwpulDA-1
X-Mimecast-MFC-AGG-ID: ajXhGHZKPkWSq6wHwpulDA_1749496040
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235dd77d11fso38783265ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496040; x=1750100840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JcUESyfIUIhBV36QKnBkAR2wu1H+tLhR7qJurWYI7aE=;
 b=f4PlqKAFZ/2/7t1Tg02w+ma2CsrcOq3ZNiywICGz+owhrUqV9xyFSORUbfDS+q+4Rf
 Cca3RLdHMB0X6aTYueBORhXkqirGrL+XW3vDP3GfovIhUpi80oLf2CqkpYQ4R01dg4i9
 4y1dSVjnTkl64Bub0U3EYMq6iVuYUGT1w+2x3eI7Hz4SiB8NNCFs9uE+yFUf+wQO4KpM
 mS8872TGNHZ5JaDdvdVLkdrFBKTYYixYHBlZ81d07WL1Gn+QthAjZrTw9OX57KtHDw47
 ylgPRdWyKCAP50lQUBwTtyyKYmvJKJ1VHrmHfxY1hF6QNjzv3itp85y4/JN3qBfBvy+B
 bJhA==
X-Gm-Message-State: AOJu0YwZpQioWnGhEcBNnFCGziMgd/50GlWGzzhiMnRpz0gZL3avwGG8
 hQzDUcx5jAowp/XmCJNqkVAGCWr0B62RsrK0Xv1Zovof/flamb6PRBZgI0eaURtjUUexySP0P2I
 A1/QVTNXomaf6JywzitDHIs4fdJdT0tIW2q/tE7rJV7d4lpJbhojtJ/iCC5UjuFkX2tWwIKF13H
 NmewTk5nbQ1Chk3xgdJThKUuaBFOF/mf4=
X-Gm-Gg: ASbGncttvD5UfAXofrLKTvs29ZHsydJzSN2GxDl7F10wX5Ix9cv+Zks0c5+iPj1GkEx
 9Qn0nVc0KHslAZdLXFlvw1mnIjDPc0YuNd3ZvjNuvPchDzczXLoYIOss98dXRo3SE26dmYnMmB/
 xpU94ciPt/n2QtOXHWHRSKus2M
X-Received: by 2002:a17:90a:dfc6:b0:313:17ec:80ec with SMTP id
 98e67ed59e1d1-31346f5ac9bmr16389014a91.26.1749496039900; 
 Mon, 09 Jun 2025 12:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2xKKlg75zuo/IELfLzeoA7u6tQWMYZbDl1FRAav00+bbFqRx0DWoxSPz0/T87DOguiANF961HyY49Rs8Dc3E=
X-Received: by 2002:a17:90a:dfc6:b0:313:17ec:80ec with SMTP id
 98e67ed59e1d1-31346f5ac9bmr16388994a91.26.1749496039605; Mon, 09 Jun 2025
 12:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250606205009.584615-1-jsnow@redhat.com>
 <20250606205009.584615-2-jsnow@redhat.com>
 <d1a5fe06-599d-4a04-a550-1c9927495516@daynix.com>
In-Reply-To: <d1a5fe06-599d-4a04-a550-1c9927495516@daynix.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 9 Jun 2025 15:07:08 -0400
X-Gm-Features: AX0GCFusqFHqbZFeTPUi0ZuHO9WvnIwJdzgn_jO6ON0wztvHbCuSeaNePXSqMBs
Message-ID: <CAFn=p-bk9ZdTdqNT6Z2d-28-nkqk+V7JjK+FZjfcyPJZYhoFHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] python: update requirements for Sphinx
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fa2c6106372849aa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000fa2c6106372849aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 1:26=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com>
wrote:

> On 2025/06/07 5:50, John Snow wrote:
> > In advance of actually bumping the build system requirements for Sphinx=
,
> > bump the version used for the static analysis tests. Update the minimum
> > requirements accordingly.
> >
> > This changes the test environment without actually changing the build
> > requirements, and no extra changes are needed for the tests to continue
> > passing.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> I didn't notice these files. Perhaps they are better to be documented
> with pythondeps.toml.
>

You didn't miss them, they were added after you submitted your patch :)

The python tests checking anything to do with sphinx are very recent. The
relationship between pythondeps.toml and python/setup.cfg and
python/tests/minreqs.txt is still tenuous, but I'll keep in mind that we
may need to better document the relationships.

(Sphinx and its dependencies are installed only for the sake of pylint and
mypy to check docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py, as
those packages need to be present in order for the static type analysis to
work fully. We don't actually *run* Sphinx from those tests, we just use
them as "headers", effectively.)

Thanks again,
--js


>
> Regards,
> Akihiko Odaki
>
>

--000000000000fa2c6106372849aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 8, =
2025 at 1:26=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@d=
aynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On 2025/06/07 5:50, John Snow wrote:<br>
&gt; In advance of actually bumping the build system requirements for Sphin=
x,<br>
&gt; bump the version used for the static analysis tests. Update the minimu=
m<br>
&gt; requirements accordingly.<br>
&gt; <br>
&gt; This changes the test environment without actually changing the build<=
br>
&gt; requirements, and no extra changes are needed for the tests to continu=
e<br>
&gt; passing.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.=
jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
<br>
I didn&#39;t notice these files. Perhaps they are better to be documented <=
br>
with pythondeps.toml.<br></blockquote><div><br></div><div>You didn&#39;t mi=
ss them, they were added after you submitted your patch :)</div><div><br></=
div><div>The python tests checking anything to do with sphinx are very rece=
nt. The relationship between pythondeps.toml and python/setup.cfg and pytho=
n/tests/minreqs.txt is still tenuous, but I&#39;ll keep in mind that we may=
 need to better document the relationships.</div><div><br></div><div>(Sphin=
x and its dependencies are installed only for the sake of pylint and mypy t=
o check docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py, as those pac=
kages need to be present in order for the static type analysis to work full=
y. We don&#39;t actually *run* Sphinx from those tests, we just use them as=
 &quot;headers&quot;, effectively.)</div><div><br></div><div>Thanks again,<=
/div><div>--js</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
</blockquote></div></div>

--000000000000fa2c6106372849aa--


