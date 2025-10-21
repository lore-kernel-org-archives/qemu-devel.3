Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8E9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDdL-0003i3-CZ; Tue, 21 Oct 2025 10:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBDcs-0003gU-OR
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBDcm-0006br-Rz
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761057965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZw9EEOsBtcZ8TjrTjYR+u852NViaxsmdSB0ARQIZgo=;
 b=enUUuzpc+E1jkccmyJCC35VoXhZEiJWTcnZ/6VAw5BZ4Y0U9RRTxIRPvBz89iLMz7Vmi8O
 SVE2Net1KXEScFEcXc4Rx4cEX3J+ed1vCD63krcQbOzEJc6XpdXMYg46jGQ2oSaySm3Rc9
 SqrmsT0brhubHuMmkQFXwkW6EvcO4ts=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-aOiibOpVPJCUKo0n4R3xmg-1; Tue, 21 Oct 2025 10:46:01 -0400
X-MC-Unique: aOiibOpVPJCUKo0n4R3xmg-1
X-Mimecast-MFC-AGG-ID: aOiibOpVPJCUKo0n4R3xmg_1761057961
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-32edda89a37so5035076a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761057960; x=1761662760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZw9EEOsBtcZ8TjrTjYR+u852NViaxsmdSB0ARQIZgo=;
 b=QnOw/urAcp/aO7Fktfbih8GshtrQ5+BKwxJD6PdX070igeilc2tgUjEz4csv6F6E0I
 uGAkO1zBQcKWCytYiGTunlzg6A9bTPGFLf08E4Jk4/OZ/FF3bII9KDirFk48RS1HdTfP
 Fo/ZEzewyDuSXFcNqWIQDe7SrHT0DRO4MGagGE50EFEk5yZy6IEqwBhQw+ZeC+cl7f+z
 LHOgWbi99Vgry4GX/jJoklJErF3wO+EQSsckvlneKfZXcvfgXq1Wu9fCeDPkVnCcMVUy
 jLvpO4nZPwmIDlvvd1o05+D45zhSJcKVZRzD/NRYbvQp/8GOwiz28Ee6wbXcj2cjTzGH
 VYeA==
X-Gm-Message-State: AOJu0YyBTjykDR5misEhnUZybdqQXjcy3fKUW9/N5NXGRvVuYw6Ce1d2
 67wv37hrQ/XLNMqYKkv2rhSQFKuEGhE8iwIE/hryEWT7FRCPJyouxrNAjQIm0k8NCKxGgikk5gM
 O/eAtsB6mSFLtFCpQBAeoQS2m3hfs039rYlwGW8akdnADAg/S5iCSpB2Uv7XkT+/5Zp9u2/S+30
 yJw7wGOLAhkcQ75nSkTBvXaYhMWRX5LUM=
X-Gm-Gg: ASbGncsV27Kw10la3miKuFFq57Q7iil2jSllj6OtL2weS2fkEWROErpNKeUXZVu70Nw
 aiUFa2yIHKXz9eIZaW9tGV3UHuvBgeQMhxkelGZ92oh4QnI0inOjcJlNXNI+ezLq/RpY9HJWC/n
 9PV+wGPE8bJP3iWIvUtO9QC8Y+DBqD3wmDn+rbL+n6K5kN3CygNcTZGMnSnNsCXuBYw3zlWCBHf
 94BsvRJA+/9+PY=
X-Received: by 2002:a17:90b:5291:b0:32e:859:c79 with SMTP id
 98e67ed59e1d1-33bcec1ab25mr21902250a91.0.1761057960519; 
 Tue, 21 Oct 2025 07:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIcc1Bq5YWfJs6XZLx1zV2GKC04xQ+LyR4pPmvamkTvh3m7l8HLCnhjNonTbjuz6NiIRQL68ApzCZQJoph6jQ=
X-Received: by 2002:a17:90b:5291:b0:32e:859:c79 with SMTP id
 98e67ed59e1d1-33bcec1ab25mr21902182a91.0.1761057960055; Tue, 21 Oct 2025
 07:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251021122533.721467-1-marcandre.lureau@redhat.com>
 <01a51fe7-4414-e787-ddf5-5ede0c1e1e74@eik.bme.hu>
 <CAMxuvaz8GueSp-vPHFWnbv+Odcy63Cz_hZHd3NzReWXp3pnsqg@mail.gmail.com>
 <6c5e599f-f106-e89e-2a2d-6760a2b65c08@eik.bme.hu>
In-Reply-To: <6c5e599f-f106-e89e-2a2d-6760a2b65c08@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Oct 2025 18:45:48 +0400
X-Gm-Features: AS18NWBlleH-mo4oGeu524tNIOINwOvyhPFTIREW6JZFHOKHOAcAAl8PKRPMNnI
Message-ID: <CAMxuvawWEJHmJS=xOKbSnFS58HSLxRi0r7KP-GV9nuDDASTNcQ@mail.gmail.com>
Subject: Re: [PATCH] char: rename CharBackend->CharFrontend
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, Alberto Garcia <berto@igalia.com>, 
 Thomas Huth <huth@tuxfamily.org>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Magnus Damm <magnus.damm@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Corey Minyard <minyard@acm.org>, 
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 Vijai Kumar K <vijai@behindbytes.com>, Samuel Tardieu <sam@rfc1149.net>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, Lukas Straub <lukasstraub2@web.de>
Content-Type: multipart/alternative; boundary="0000000000002367b30641ac42ed"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002367b30641ac42ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 21, 2025 at 6:11=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Tue, 21 Oct 2025, Marc-Andr=C3=A9 Lureau wrote:
> > On Tue, Oct 21, 2025 at 5:25=E2=80=AFPM BALATON Zoltan <balaton@eik.bme=
.hu>
> wrote:
> >> On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> /**
> >>> - * struct CharBackend - back end as seen by front end
> >>> + * struct CharFrontend - back end as seen by front end
> >>
> >> I stopped here, haven't read the rest of the patch but the above comme=
nt
> >> seems to become inconsistent. Which is the front end and back end now?
> >>
> >>
> > It's the "frontend side" of a chardev "backend". Naming it CharBackend
> has
> > always been the source of confusion, since the actual backend is Charde=
v.
> > There was earlier attempt to rename it and various complains. I believe
> > this is is long overdue.
>
> Comment after patch says: "CharFrontend - back end as seen by front end"
> This can't be consistent as it calls CharFrontend a back end.
>

I am not sure how to better explain it than:

> It's the "frontend side" of a chardev "backend"

Another way to think of it is a "handle" ? but since we use char-fe.h and
_fe_*() already, this is just renaming by following the current API...


> Maybe it's actually the frontend/backend terminology what is confusing so
> just swapping the names won't fix that. Better find some clearer naming
> instead? Maybe something with Guest/Host or we already have
> chardev/blockdev/audiodev (matching the command options to specify these)
> for backends so call backends like that. But then I don't know what to
> call guest side as it's added by -device so could be CharDevice but
> CharDevice and Chardev does not seem too clear either. Maybe ChardevGuest
> ChardevHost or something along those lines?
>
>
As I argue earlier, Guest/Host is not generic enough as it ties a bit too
much to hypervisor terminology.


> Alternatively it may be easier to just add a file to docs first, listing
> these for existing frontend/backend pairs and explaining which is which
> before renaming anything and once we have a list of all of them at one
> place we can see what is the easiest way to rename them with least churn.
> I think that's similar to what Peter also proposed in previous reply. I'm
> afraid that renaming only some of these won't make them less confusing.


We have all the users in this patch. I don't think it's necessary to list
them in a separate file, but if necessary I can.

--0000000000002367b30641ac42ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 21, 2=
025 at 6:11=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme=
.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Tue, 21 Oct 2025, Marc-Andr=C3=A9 Lureau wrote:<b=
r>
&gt; On Tue, Oct 21, 2025 at 5:25=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"=
mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt; wro=
te:<br>
&gt;&gt; On Tue, 21 Oct 2025, <a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt;&gt;&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; /**<br>
&gt;&gt;&gt; - * struct CharBackend - back end as seen by front end<br>
&gt;&gt;&gt; + * struct CharFrontend - back end as seen by front end<br>
&gt;&gt;<br>
&gt;&gt; I stopped here, haven&#39;t read the rest of the patch but the abo=
ve comment<br>
&gt;&gt; seems to become inconsistent. Which is the front end and back end =
now?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; It&#39;s the &quot;frontend side&quot; of a chardev &quot;backend&quot=
;. Naming it CharBackend has<br>
&gt; always been the source of confusion, since the actual backend is Chard=
ev.<br>
&gt; There was earlier attempt to rename it and various complains. I believ=
e<br>
&gt; this is is long overdue.<br>
<br>
Comment after patch says: &quot;CharFrontend - back end as seen by front en=
d&quot; <br>
This can&#39;t be consistent as it calls CharFrontend a back end.<br></bloc=
kquote><div><br></div><div><div>I am not sure how to better explain it than=
:</div><div><br></div>&gt; It&#39;s the &quot;frontend side&quot; of a char=
dev &quot;backend&quot;</div><div><br></div>Another way to think of it is a=
 &quot;handle&quot; ? but since we use char-fe.h and _fe_*() already, this =
is just renaming by following the current API...</div><div class=3D"gmail_q=
uote gmail_quote_container"><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
Maybe it&#39;s actually the frontend/backend terminology what is confusing =
so <br>
just swapping the names won&#39;t fix that. Better find some clearer naming=
 <br>
instead? Maybe something with Guest/Host or we already have <br>
chardev/blockdev/audiodev (matching the command options to specify these) <=
br>
for backends so call backends like that. But then I don&#39;t know what to =
<br>
call guest side as it&#39;s added by -device so could be CharDevice but <br=
>
CharDevice and Chardev does not seem too clear either. Maybe ChardevGuest <=
br>
ChardevHost or something along those lines?<br>
<br></blockquote><div><br></div><div>As I argue earlier, Guest/Host is not =
generic enough as it ties a bit too much=C2=A0to hypervisor terminology.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Alternatively it may be easier to just add a file to docs first, listing <b=
r>
these for existing frontend/backend pairs and explaining which is which <br=
>
before renaming anything and once we have a list of all of them at one <br>
place we can see what is the easiest way to rename them with least churn. <=
br>
I think that&#39;s similar to what Peter also proposed in previous reply. I=
&#39;m <br>
afraid that renaming only some of these won&#39;t make them less confusing.=
</blockquote><div><br></div><div>We have all the users in this patch. I don=
&#39;t think it&#39;s necessary to list them in a separate file, but if nec=
essary I can.</div></div></div>

--0000000000002367b30641ac42ed--


