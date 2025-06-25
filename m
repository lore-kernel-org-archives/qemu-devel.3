Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B21C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 17:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUU2k-0003o4-Gf; Wed, 25 Jun 2025 13:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUU2K-0003lt-SA
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 13:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUU2F-0001MJ-2o
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 13:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750872943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00DB+SSRdwHKOyusU4cMMbYpeqAuVYJIoyFzCQOSb6w=;
 b=TspfQV++OJh8td4fCtpwpXhiLO98z68HB6KW0jaLbnn2NKoYkMqcapTOTNqN4cWMrsxDm8
 yIWnew01t15eVoNqWukhlaOOFuT8U58I0LdTF5zRUK07lvaBICc9LuOwZfa16P7/U8uCOq
 4h+pwZfsKBvu9Rj7omXS1cH6YK6x/gM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-lg22hiBpMCuoYIxvPgCSQw-1; Wed, 25 Jun 2025 13:35:41 -0400
X-MC-Unique: lg22hiBpMCuoYIxvPgCSQw-1
X-Mimecast-MFC-AGG-ID: lg22hiBpMCuoYIxvPgCSQw_1750872940
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2369261224bso1487445ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 10:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750872940; x=1751477740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=00DB+SSRdwHKOyusU4cMMbYpeqAuVYJIoyFzCQOSb6w=;
 b=S5h5P6ODBscqPDPNRVl/LrQYGcjz1Xih94BYOU4Shicij1QpSPx365a7rbuk2u1/a3
 3+exeQJ4S/pPf8KHPDSoz6J+715wTkAeb9K/wXIaDRf3juQ88kxVcT7dnnTjGrX31qlk
 otQ71inCIBh2eNptbOoxS8ZerK5tLxG+www7STxtb9tWspCVkYjfaM20XVmEk/djtvYn
 WXI0fW4x752t+430tS3z8yuQ+NNPFpM6vR5niJOaYW9ZLC/Du4UJDwJsNJq8wnlzGBNi
 K+G/3Jy6e1jiTb2TMjb9wcVj3GJhbK4hcJrgBxkCZOmAR4y0ahanHwxU7/ZAZrgCbSKg
 OzWg==
X-Gm-Message-State: AOJu0YwlZ4VmX4giVkBai7KkC1tvEBYjA7Hs8gYBVWLZ1RYh5AZ/RCUz
 uUo8kgQTE/qjxdTOC3hoYA90pHfFTHjdDM/uS7DMbxFRsidOvegmjv5Sxiw7CaDF2gn3DQZzsnF
 45SKUbEBOp7IzYzENDaDS/JFmnipiWjlu7hHw3MQInGAbL7G32XGSKeAilE1ykGgrBXwMwxG0zJ
 IYRwy+TFVc+3pnBols5oQWMpgOmX36mcE=
X-Gm-Gg: ASbGncsG1q1kxygFJDFiz2bf1ibsejgj0QaZUmqPjufaqjBe9Q52kpwyIMCZViUY2AC
 iFSwWNyxNy1jO3i46kI2ulJg1E/0Au+Uoh1cZNujFJZIzK/eH17Mqu0eBKNx8s5lKH03zJuaWAw
 qL1ljJt92NASm2IKAWXHLhISiHqXsw4tLdwM4=
X-Received: by 2002:a17:903:4b0c:b0:234:b44c:d3c8 with SMTP id
 d9443c01a7336-2382407271emr60407635ad.37.1750872940067; 
 Wed, 25 Jun 2025 10:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTQwWeqtgwf15lzTnqTkt5ZpLkOMZnDNdXpzNEsR+lJRj4BRWH7JyEGDviuoSqz5hWL+/JbjWAU/ox0/JN+7E=
X-Received: by 2002:a17:903:4b0c:b0:234:b44c:d3c8 with SMTP id
 d9443c01a7336-2382407271emr60407225ad.37.1750872939601; Wed, 25 Jun 2025
 10:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250612205451.1177751-1-jsnow@redhat.com>
 <20250612205451.1177751-7-jsnow@redhat.com>
 <87cyatmw40.fsf@pond.sub.org>
In-Reply-To: <87cyatmw40.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 25 Jun 2025 13:35:24 -0400
X-Gm-Features: AX0GCFu24gcy7gu7f1D_mcQaqWYN_lmZubp5dC6zB91-XnM9SnsHagHu3mq7Xgg
Message-ID: <CAFn=p-YPN6MWZiETi7XWkyYVPpe7uew49CwjEdAsMmW=ZPOx5A@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] python: upgrade to python3.9+ syntax
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Yi Liu <yi.l.liu@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Helge Deller <deller@gmx.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Fabiano Rosas <farosas@suse.de>, 
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ed Maste <emaste@freebsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 Kevin Wolf <kwolf@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Eric Blake <eblake@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Troy Lee <leetroy@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Roth <michael.roth@amd.com>, 
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Steven Lee <steven_lee@aspeedtech.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-s390x@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Mads Ynddal <mads@ynddal.dk>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Alessandro Di Federico <ale@rev.ng>, Thomas Huth <thuth@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Hyman Huang <yong.huang@smartx.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Magnus Damm <magnus.damm@gmail.com>, qemu-rust@nongnu.org,
 Bandan Das <bsd@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 kvm@vger.kernel.org, Fam Zheng <fam@euphon.net>, Jia Liu <proljc@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>, 
 Alexandre Iooss <erdnaxe@crans.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 qemu-ppc@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000009cc6ee063868df67"
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

--0000000000009cc6ee063868df67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:34=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch is fully automated, using pymagic, isort and autoflake.
> >
> > Create a script named pymagic.sh:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > pyupgrade --exit-zero-even-if-changed --keep-percent-format \
> >           --py39-plus "$@"
> >
> > autoflake -i "$@"
> >
> > isort --settings-file python/setup.cfg \
> >       -p compat -p qapidoc_legacy -p iotests -o qemu "$@"
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > Then, from qemu.git root:
> >
> >> find . -type f -name '*.py' | xargs pymagic
> >> git grep --name-only "#!/usr/bin/env python" | xargs pymagic
> >
> > This changes a lot of old Pythonisms, but in particular it upgrades the
> > old Python type hint paradigm to the new 3.9+ paradigm wherein you no
> > longer need to import List, Dict, Tuple, Set, etc from the Typing modul=
e
> > and instead directly subscript the built-in types list, dict, tuple,
> > set, etc. The old-style annotations are deprecated as of 3.9 and are
> > eligible for removal starting in Python 3.14, though the exact date of
> > their removal is not yet known.
> >
> > pyupgrade updates the imports and type hint paradigms (as well as
> > updating other old 'isms, such as removing the unicode string
> > prefix). autoflake in turn then removes any unused import statements,
> > possibly left behind by pyupgrade. Lastly, isort fixes the import order
> > and formatting to the standard we use in qemu.git/python and
> > scripts/qapi in particular.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> >  448 files changed, 1959 insertions(+), 1631 deletions(-)
>
> *=C3=84chz*
>

Gesundheit.


>
> I hate it when people ask me to split up my mechanical patches...
>
> One split is by subsystem / maintainer.  I've done this a few times, and
> it's quite a bother.  Questionable use of your time if you ask me.
>

I'd prefer not to unless it is requested of me specifically. I don't think
most maintainers really care about the nuances of Python and as long as
their stuff continues to work they're not going to mind much.

Or, to be frank: I don't think this series would ever garner enough review
and attention to warrant the labor it'd take to tailor it to such a review.
It's mechanical, it's boring, it should be fine.

I switched from a manual patch series to a tool-driven one specifically to
make it more mindless and less interesting, and going through and splitting
it back out is ... eh. I would prefer not to.


>
> There's another split here...  Your pymagic.sh runs three tools.  If you
> commit after each one, the patch splits into three.
>

I use all three because each one alone isn't sufficient to then pass the
static analysis checks, they each do a little bit of damage that another
tool corrects afterwards.

pyupgrade works to modernize syntax, but leaves impotent import statements
hanging.
autoflake removes those impotent imports.
isort fixes the import statement ordering and formatting to our standard.
(And then I do some manual fixups to fix the linting tests where things
were auto-formatted suboptimally.)

I can still split it out for review purposes, like I did here with some
manual fixups appended to the end.

Just, for merge, they'll be combined by necessity as a result of our
no-regressions-for-bisect rule.


>
> I understand you pass --py39-plus to pyupgrade to get the type hints
> modernized.  If you run it without --py39-plus for all the miscellaneous
> upgrades, commit, then run it with --py39-plus for just the type hint
> upgrades, commit, the last patch splits again.
>

I can try it! I actually didn't try running it without py39-plus at all, so
I don't know what that'll do. but no harm in an experiment.


>
> Thoughts?


First and foremost I just thought it'd be good to get this mechanical
change squared away in one giant patch so we could add this one singular
horrible mega-commit into the git blame "ignored commits" list to minimize
the impact of the "flag day".

This upgrade will have to happen "eventually" but it needn't be "right
now", but I figured it'd be good to get it out of the way... or put another
way, "better my mess than someone else's".

--js

--0000000000009cc6ee063868df67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 24,=
 2025 at 3:34=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch is fully automated, using pymagic, isort and autoflake.<br>
&gt;<br>
&gt; Create a script named pymagic.sh:<br>
&gt;<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt;<br>
&gt; pyupgrade --exit-zero-even-if-changed --keep-percent-format \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--py39-plus &quot;$@&quot;<br>
&gt;<br>
&gt; autoflake -i &quot;$@&quot;<br>
&gt;<br>
&gt; isort --settings-file python/setup.cfg \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-p compat -p qapidoc_legacy -p iotests -o qe=
mu &quot;$@&quot;<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt;<br>
&gt; Then, from qemu.git root:<br>
&gt;<br>
&gt;&gt; find . -type f -name &#39;*.py&#39; | xargs pymagic<br>
&gt;&gt; git grep --name-only &quot;#!/usr/bin/env python&quot; | xargs pym=
agic<br>
&gt;<br>
&gt; This changes a lot of old Pythonisms, but in particular it upgrades th=
e<br>
&gt; old Python type hint paradigm to the new 3.9+ paradigm wherein you no<=
br>
&gt; longer need to import List, Dict, Tuple, Set, etc from the Typing modu=
le<br>
&gt; and instead directly subscript the built-in types list, dict, tuple,<b=
r>
&gt; set, etc. The old-style annotations are deprecated as of 3.9 and are<b=
r>
&gt; eligible for removal starting in Python 3.14, though the exact date of=
<br>
&gt; their removal is not yet known.<br>
&gt;<br>
&gt; pyupgrade updates the imports and type hint paradigms (as well as<br>
&gt; updating other old &#39;isms, such as removing the unicode string<br>
&gt; prefix). autoflake in turn then removes any unused import statements,<=
br>
&gt; possibly left behind by pyupgrade. Lastly, isort fixes the import orde=
r<br>
&gt; and formatting to the standard we use in qemu.git/python and<br>
&gt; scripts/qapi in particular.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt;=C2=A0 448 files changed, 1959 insertions(+), 1631 deletions(-)<br>
<br>
*=C3=84chz*<br></blockquote><div><br></div><div>Gesundheit.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I hate it when people ask me to split up my mechanical patches...<br>
<br>
One split is by subsystem / maintainer.=C2=A0 I&#39;ve done this a few time=
s, and<br>
it&#39;s quite a bother.=C2=A0 Questionable use of your time if you ask me.=
<br></blockquote><div><br></div><div>I&#39;d prefer not to unless it is req=
uested of me specifically. I don&#39;t think most maintainers really care a=
bout the nuances of Python and as long as their stuff continues to work the=
y&#39;re not going to mind much.</div><div><br></div><div>Or, to be frank: =
I don&#39;t think this series would ever garner enough review and attention=
 to warrant the labor it&#39;d take to tailor it to such a review. It&#39;s=
 mechanical, it&#39;s boring, it should be fine.</div><div><br></div><div>I=
 switched from a manual patch series to a tool-driven one specifically to m=
ake it more mindless and less interesting, and going through and splitting =
it back out is ... eh. I would prefer not to.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
There&#39;s another split here...=C2=A0 Your pymagic.sh runs three tools.=
=C2=A0 If you<br>
commit after each one, the patch splits into three.<br></blockquote><div><b=
r></div><div>I use all three because each one alone isn&#39;t sufficient to=
 then pass the static analysis checks, they each do a little bit of damage =
that another tool corrects afterwards.</div><div><br></div><div>pyupgrade w=
orks to modernize syntax, but leaves impotent import statements hanging.</d=
iv><div>autoflake removes those impotent imports.</div><div>isort fixes the=
 import statement ordering and formatting to our standard.</div><div>(And t=
hen I do some manual fixups to fix the linting tests where things were auto=
-formatted suboptimally.)</div><div><br></div><div>I can still split it out=
 for review purposes, like I did here with some manual fixups appended to t=
he end.</div><div><br></div><div>Just, for merge, they&#39;ll be combined b=
y necessity as a result of our no-regressions-for-bisect rule.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I understand you pass --py39-plus to pyupgrade to get the type hints<br>
modernized.=C2=A0 If you run it without --py39-plus for all the miscellaneo=
us<br>
upgrades, commit, then run it with --py39-plus for just the type hint<br>
upgrades, commit, the last patch splits again.<br></blockquote><div><br></d=
iv><div>I can try it! I actually didn&#39;t try running it without py39-plu=
s at all, so I don&#39;t know what that&#39;ll do. but no harm in an experi=
ment.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
Thoughts?</blockquote><div><br></div><div>First and foremost I just thought=
 it&#39;d be good to get this mechanical change squared away in one giant p=
atch so we could add this one singular horrible mega-commit into the git bl=
ame &quot;ignored commits&quot; list to minimize the impact of the &quot;fl=
ag day&quot;.</div><div><br></div><div>This upgrade will have to happen &qu=
ot;eventually&quot; but it needn&#39;t be &quot;right now&quot;, but I figu=
red it&#39;d be good to get it out of the way... or put another way, &quot;=
better my mess than someone else&#39;s&quot;.</div><div><br></div><div>--js=
</div></div></div>

--0000000000009cc6ee063868df67--


