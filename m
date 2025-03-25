Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953A3C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7Sv-0007A1-Ii; Tue, 25 Mar 2025 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx7St-00079q-Kb
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx7Sq-0004U4-Nz
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742921357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtH2M33umfySIMjnxIpgcUSWwKj+EKA9YRzetIFYSM8=;
 b=IMDMfOOKJJBUjj/QeZSmKdQlF+YmIcLRwLaabBLi2YqJbvzRaI4wSSYndTGGA8QGoGhAEr
 3Ff7Xgo0m4q22zmGqOUmWn9cI+3z4qsxj6vwnYrrtpuiUo1TXOFRxQclR+NcXHbPzGkH7w
 e3DRWAzz9mbVQooiD+49NUznkrSebLI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-pkn3yxNrO22QR7nPjyrZSA-1; Tue, 25 Mar 2025 12:49:15 -0400
X-MC-Unique: pkn3yxNrO22QR7nPjyrZSA-1
X-Mimecast-MFC-AGG-ID: pkn3yxNrO22QR7nPjyrZSA_1742921354
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3032f4eca83so5220664a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742921354; x=1743526154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OtH2M33umfySIMjnxIpgcUSWwKj+EKA9YRzetIFYSM8=;
 b=rlUi6davVY3WQR0Kh5jqojypaHyHTW6gwoS8QoqgEPqJjpHQzr0WLjsJoRVpDK7jp8
 GXqYly9kW/6V+IYLqO6mP7pbzds+2Gyzm9IVcAoC/d1MaK0Z5E1Uu8PT+MvnMcpftAjb
 tkSNAaFM30Y6fOZYpcER0LAA1EScObgbCzqFg9F/5/hbNKiQp6OL91Fe8O7lEjN9dIUP
 nuJbrvCBc2w9IBlGemYzGkiIbsBpJoFBdpc6tJy+sKSECUdA6wQJYhJrfpyMtjF/guqC
 KHbf+dneIL0cz7khPzYrjCpcOV7XMHC0tFHE5zdc3jnsKCvBkalfkYzahQyF+e+TloNl
 9MjA==
X-Gm-Message-State: AOJu0Yw6rKTxl1+MVNGAgsfs38YE5dohjCs4+4E/OLyg1NMfn4P7Vu6N
 Y6440GBlCWG6Z8econaues9Uq6cyOuOkprUmOBtzwGAyJXfL/T+WqvZAoJ2IVhUcMPoDRXUp6nq
 8d2e9pffFWtWACFTLf+GVcg7qyZTzdFjRhkYzGxpWB6bEkpSE7ruau3LGXt7zwNWLmsWyDgLb0y
 zPH0ERYcTDvz53C+4c4fRu9kUSH6g=
X-Gm-Gg: ASbGncvNlBM4HBlOiPxdOxiqkO0lJ1NSr5IEyy8ADMjWu+nl5JXPLX7r3bLjLXVYMZr
 XR9SzArNoIYa6oiny61lT/TokwTY/BRBFKHhZ33Xt8iUkHwM2GI3JMK7jAD0jLdj7A6UUG87/wF
 boB0jiLM4YpQJ2dOdvsufR1xub4szR
X-Received: by 2002:a17:90b:4a03:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-3030feba6cdmr31829626a91.16.1742921354299; 
 Tue, 25 Mar 2025 09:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP+WEfz1FHOjUkWOCpv9StTUJK+zHgkYTQC8aNsRhfvN+ToljLmfaw92uUdItRIi/h1drR/FcTt2EOb1gZyZs=
X-Received: by 2002:a17:90b:4a03:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-3030feba6cdmr31829590a91.16.1742921353876; Tue, 25 Mar 2025
 09:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-3-jsnow@redhat.com>
 <87y0wtpnod.fsf@pond.sub.org>
In-Reply-To: <87y0wtpnod.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Mar 2025 12:49:01 -0400
X-Gm-Features: AQ5f1JpmPq4v_fD3HupMKu8l5SVfc8WlR-_KKHLn5ljw2NAGt3bO-OphlhDk5wk
Message-ID: <CAFn=p-a1siA=PTGpO+PsW5x6uvEBV2=nm-8GV7mmxEcKnGQO2g@mail.gmail.com>
Subject: Re: [PATCH 2/5] docs/qapidoc: linting fixes
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002b715106312d8092"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

--0000000000002b715106312d8092
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 3:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This restores the linting baseline in qapidoc. The order of some import=
s
> > have changed slightly due to configuring isort a little better: isort
>
> Changed since when / what?
>

Changed as of this patch. Before, I was running isort directly from the
docs/sphinx folder, but now I'm running it from the Python directory with
some improved configuration as I explain in this commit: by teaching isort
that compat and qapidoc_legacy are local modules, isort decides to arrange
them differently.

Imports should always go in three sections, in order:

1. Standard library imports
2. Third party imports
3. First party (local) imports

Before, it was not, because it does not understand "docs/sphinx" as a local
package with local modules - I think it gets confused because of the folder
being named "sphinx".

Really, I am just explaining why some imports get shuffled around a little
bit - the new order is "correct" and the old order was slightly wrong.


>
> > was having difficulty understanding that "compat" and "qapidoc_legacy"
> > were local modules because docs/sphinx "isn't a python package".
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--0000000000002b715106312d8092
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25,=
 2025 at 3:36=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This restores the linting baseline in qapidoc. The order of some impor=
ts<br>
&gt; have changed slightly due to configuring isort a little better: isort<=
br>
<br>
Changed since when / what?<br></blockquote><div><br></div><div>Changed as o=
f this patch. Before, I was running isort directly from the docs/sphinx fol=
der, but now I&#39;m running it from the Python directory with some improve=
d configuration as I explain in this commit: by teaching isort that compat =
and qapidoc_legacy are local modules, isort decides to arrange them differe=
ntly.</div><div><br></div><div>Imports should always go in three sections, =
in order:</div><div><br></div><div>1. Standard library imports</div><div>2.=
 Third party imports</div><div>3. First party (local) imports</div><div><br=
></div><div>Before, it was not, because it does not understand &quot;docs/s=
phinx&quot; as a local package with local modules - I think it gets confuse=
d because of the folder being named &quot;sphinx&quot;.</div><div><br></div=
><div>Really, I am just explaining why some imports get shuffled around a l=
ittle bit - the new order is &quot;correct&quot; and the old order was slig=
htly wrong.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; was having difficulty understanding that &quot;compat&quot; and &quot;=
qapidoc_legacy&quot;<br>
&gt; were local modules because docs/sphinx &quot;isn&#39;t a python packag=
e&quot;.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--0000000000002b715106312d8092--


