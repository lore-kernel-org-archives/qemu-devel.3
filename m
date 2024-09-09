Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9800FECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfcc-00038Y-J1; Mon, 09 Sep 2024 10:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfca-00032y-E6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:44:04 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfcX-00062R-Mt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:44:04 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-26fda13f898so2774843fac.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725893040; x=1726497840;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qpFZNBJAG/hzFbvreOVozM4YhJsJSBZDFa0KK//dxPk=;
 b=RHsem83Bx3+0tg05lBR4Y7zOjQ0f274N9wxkUj8EALp7UqIlc6zfL68DmnfKFRP6hE
 y9THh3973B1RO5l5rG5TBip9EmH7xv0bseM52KWc7yl4SwbRWffxAzn34ZdB3Eq7zGcJ
 FzI39GatsPDoquAtBQx6f3EEgQxPS1kayH9A4dWWkMkgVGkQNQaVLHBxSh6kWVGxmvde
 XgZtDhnXGGy78VUNOHFaysMsW3gQncm5bev/N/IchJ7CVOnZDOXTs3P7Q8BqFxrxYOMB
 rRKxAmCDNhe6bOkN3H/bpxUZnVJV7WOQjqw4GZIk5DcRMjamhdAqKISqxLwhf5I0FyOK
 BtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893040; x=1726497840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpFZNBJAG/hzFbvreOVozM4YhJsJSBZDFa0KK//dxPk=;
 b=PeQC2+hHv/1WXf1OvMRRHKoIVhwSeNLgyl1aga5vYOEApiE+1i0tiuvL36xa/qb7xj
 40YQFJWqqO924gjMBXWwu5aUe06uAchQY+1QaUhQEr2NmbDtp2Uf5Jo2q7hQWh4tWNsP
 T/twXzZlfGqZInvkhkSFKoVB/aifgOeiKjSw59HA1/lxv5YgZ2RhxDskThrRbSfBxCVa
 BND5iS3dpUYiEfnc/GCFIPa2nXiu2P4MzLrUHjVwxC1O4groi2wvbDRNnyIfWZFD8eqf
 Q+iSU+1wCjkxzofSYWkoVNN1Y/T7agKZ40RKDlXTs4FemTuIUQ4ok7oQnnoKjNArvlUW
 NZEA==
X-Gm-Message-State: AOJu0YxTyqGGmX9NETpttaOBh7dsNi2Pvx/Q0I/gXAWCztxEKChRunXc
 u7o/pY6EbL3woJvBf+6iQY1rp0afR4onZWbrZ69Fz3YvH3YzoimhT7XVN5VrVyzTn/3KVy6VMdY
 iQE0L4zCAO9XK626CwCz3Rxz/7OWf0W9OLaWkRw==
X-Google-Smtp-Source: AGHT+IHEhzXejhFmJPvKWXDUJAyXq3XVM6CI6X/tU0+iJCMh1inHhnd8N07JBWdEQAK2yRzkJtUS6fsZSbcyOtgUsyo=
X-Received: by 2002:a05:6870:a406:b0:277:e286:88f5 with SMTP id
 586e51a60fabf-27b82e59afbmr13556845fac.20.1725893038958; Mon, 09 Sep 2024
 07:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
In-Reply-To: <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 9 Sep 2024 22:43:42 +0800
Message-ID: <CAK9dgmYe7vKSh6sNRPBSf+H+OOXF4QT0Q5RX8QNmsQkKj64TRw@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008206c20621b0c99e"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000008206c20621b0c99e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
> >
> > Despite the fact that the responsive CPU throttle is enabled,
> > the dirty sync count may not always increase because this is
> > an optimization that might not happen in any situation.
> >
> > This test case just making sure it doesn't interfere with any
> > current functionality.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>
> tests/qtest/migration-test already runs 75 different
> subtests, takes up a massive chunk of our "make check"
> time, and is very commonly a "times out" test on some
> of our CI jobs. It runs on five different guest CPU
> architectures, each one of which takes between 2 and
> 5 minutes to complete the full migration-test.
>
> Do we really need to make it even bigger?
>

No, I don't insist on that; the cpu-responsive-throttle
parameter may also be enabled on the existing
migrate_auto_converge test case by default.

Thank for the comment.

Yong.


>
> thanks
> -- PMM
>


--=20
Best regards

--0000000000008206c20621b0c99e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 9, 202=
4 at 10:03=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lin=
aro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Mon, 9 Sept 2024 at 14:51, Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Despite the fact that the responsive CPU throttle is enabled,<br>
&gt; the dirty sync count may not always increase because this is<br>
&gt; an optimization that might not happen in any situation.<br>
&gt;<br>
&gt; This test case just making sure it doesn&#39;t interfere with any<br>
&gt; current functionality.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
tests/qtest/migration-test already runs 75 different<br>
subtests, takes up a massive chunk of our &quot;make check&quot;<br>
time, and is very commonly a &quot;times out&quot; test on some<br>
of our CI jobs. It runs on five different guest CPU<br>
architectures, each one of which takes between 2 and<br>
5 minutes to complete the full migration-test.<br>
<br>
Do we really need to make it even bigger?<br></blockquote><div><br></div><d=
iv><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif"><s=
pan style=3D"color:rgb(0,0,0)">No, I don&#39;t insist on that; the cpu-resp=
onsive-throttle</span></font></div><div class=3D"gmail_default"><font face=
=3D"comic sans ms, sans-serif"><span style=3D"color:rgb(0,0,0)">parameter m=
ay also be enabled on the existing</span></font></div><div class=3D"gmail_d=
efault"><font face=3D"comic sans ms, sans-serif"><span style=3D"color:rgb(0=
,0,0)">migrate_auto_converge test case by default.</span></font><br></div><=
/div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=
<span style=3D"color:rgb(0,0,0)"><br></span></font></div><div class=3D"gmai=
l_default"><font face=3D"comic sans ms, sans-serif"><span style=3D"color:rg=
b(0,0,0)">Thank for the comment.</span></font></div><div class=3D"gmail_def=
ault"><font face=3D"comic sans ms, sans-serif"><span style=3D"color:rgb(0,0=
,0)"><br></span></font></div><div class=3D"gmail_default"><font face=3D"com=
ic sans ms, sans-serif"><span style=3D"color:rgb(0,0,0)">Yong.</span></font=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000008206c20621b0c99e--

