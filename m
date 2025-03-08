Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAB0C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpJn-0006vg-Qk; Sat, 08 Mar 2025 03:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpJg-0006qw-R3
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:13:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpJf-0002gh-E0
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rs3YDNZwnE8xY74/07zEPjsAeais+w6Ak9Rd0OFB/Rw=;
 b=KP+a3fapPcrOT2QSQyBNCzF4WlK/2Jd2mg3EWwxwLmj7w126dAnITHvjhlY2n09LLnhW93
 f5Evfrl+ln76IHZ9RwhMAR7FVI5CDWjQnWfjOqO/kMUgJNjGf4gL9BItvXV4/aRXluAOz8
 B2KuLC8iBXWAzREB7f7Oh28mVOFvBts=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-pCbJOCL4PNe0B9--A8Hd3Q-1; Sat, 08 Mar 2025 03:13:48 -0500
X-MC-Unique: pCbJOCL4PNe0B9--A8Hd3Q-1
X-Mimecast-MFC-AGG-ID: pCbJOCL4PNe0B9--A8Hd3Q_1741421627
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2feded265deso4647105a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421627; x=1742026427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rs3YDNZwnE8xY74/07zEPjsAeais+w6Ak9Rd0OFB/Rw=;
 b=HjqJwpWl9nFscQYLsBxY45364DiRXJhoamq0Y6smEUWyLhT8PKgppEYazBZ1oz7gdU
 /yGjwg4r9+7VoxBVfVGA7CBGu6e6Cs5arlfcjlRvVKg8Tg6Q3duE6LGOvWtgVGqt9boz
 D5gUq3P7TurFW8R3OBphZJOhluEy6OpFta4tV+EmCBB90LshVfbNiBUAqRRIxitqZljN
 cP4YLfZ7HuTlVFDre7OmtGnMJZAxaJ1PkopPvfNSt0s1ei/F61qHJUb1tzVVFacqCKVd
 Ms2N25Md2T9lSasSdM5eN9Ia/iqNbBjzKSPeWtwfVxcTEiKaoULzrN1Jedh86Ajqlgdc
 Sl9Q==
X-Gm-Message-State: AOJu0YyhuypLlQGknyHeducBSA74N7aUkHxUDQqo37lxeAHsEVoa8/dM
 bwPd1lutP8XxEAAEc/HMCwVo4sLXUu1RaBhQJN7DVDESGYtueOaV6AzpUx/vzHmJrjxiF7By03c
 OAmtm/sZur2s8Wt2PfThqbaEwzzdjA21FRJsZnQQ8UQ0pN01Oewhn/sV1PsvFr0s+Tko4MyAayk
 e6L42iVxiaimPcsQAYfhU4yyRyQ+g=
X-Gm-Gg: ASbGncut4g/d0XdEFo8qxBM8V/8aD2qJwRjCVV4kQ1fW9Kg3pa9A0KvienGNyp7LpwX
 QLAK/3xFTXDcKet8CS3k7RqMH0+z6ykFKjWKBKetqyS0kH/WoZKL5k950N02REjD5qCvDYQ==
X-Received: by 2002:a17:90a:d44c:b0:2ff:6488:e026 with SMTP id
 98e67ed59e1d1-2ff7cf26d18mr9197797a91.30.1741421627309; 
 Sat, 08 Mar 2025 00:13:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4cQnYn0clmVJQ5kmMf2ANsiMPYZ0hJDTviAWGiJLVmJ/NgjYW9oL2XIcs427j/kpXc84zq1iSC5emLHD4+Ro=
X-Received: by 2002:a17:90a:d44c:b0:2ff:6488:e026 with SMTP id
 98e67ed59e1d1-2ff7cf26d18mr9197775a91.30.1741421627058; Sat, 08 Mar 2025
 00:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-57-jsnow@redhat.com>
 <87o6ydhvet.fsf@pond.sub.org>
In-Reply-To: <87o6ydhvet.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:13:34 -0500
X-Gm-Features: AQ5f1Jp9mTVu38nhAzbzVtJMpVQm_pv6yVyWr4onK_b5RYyAoP93r2LppfzEJWs
Message-ID: <CAFn=p-Z6a3Qq4-uHu1QUwdTrnxRuwKXo9iXwO8PV=hZm-ueTtA@mail.gmail.com>
Subject: Re: [PATCH 56/57] docs/qapidoc: add intermediate output debugger
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007c47ee062fd05115"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007c47ee062fd05115
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add debugging output for the qapidoc transmogrifier - setting DEBUG=3D1
> > will produce .ir files (one for each qapidoc directive) that write the
> > generated rst file to disk to allow for easy debugging and verification
> > of the generated document.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> I understand we generally need to examine these .ir files only when
> things go wrong, or maybe to help understanding the transmogrifier.  I
> guess few people will care, and only rarely.  But when we care, we
> likely care a *lot*.  Sure we want to dig the information on how to get
> .ir files out of a commit message then?
>

Intend to advertise it in the transmogrifier doc and/or extend the
doc-writing section of the qapi code gen doc.

--0000000000007c47ee062fd05115
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:34=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add debugging output for the qapidoc transmogrifier - setting DEBUG=3D=
1<br>
&gt; will produce .ir files (one for each qapidoc directive) that write the=
<br>
&gt; generated rst file to disk to allow for easy debugging and verificatio=
n<br>
&gt; of the generated document.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
I understand we generally need to examine these .ir files only when<br>
things go wrong, or maybe to help understanding the transmogrifier.=C2=A0 I=
<br>
guess few people will care, and only rarely.=C2=A0 But when we care, we<br>
likely care a *lot*.=C2=A0 Sure we want to dig the information on how to ge=
t<br>
.ir files out of a commit message then?<br></blockquote><div><br></div><div=
>Intend to advertise it in the transmogrifier doc and/or extend the doc-wri=
ting section of the qapi code gen doc.</div><div>=C2=A0</div></div></div>

--0000000000007c47ee062fd05115--


