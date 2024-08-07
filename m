Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66242C52D71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 15:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbirc-0004J5-Th; Wed, 07 Aug 2024 11:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbirW-0004IS-Od
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 11:46:06 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbirU-0006Qi-8h
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 11:46:06 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2689f749702so21104fac.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723045440; x=1723650240;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2wwnQZAZTutW1/5c+dMVshvT+BgeY8/AGOPZebu2DA=;
 b=h0Ry+78NCxsWsxroFycMrNGRSPHHHpW3IldrkIhicQmohKOEL98smqcUmfkFMACAEP
 r4a2qK1n7D9cNJObbG3i1+J70MQW1L9sAb7Bz20NpwI4oXhB0OV1lUKlHcamGJrqSEIj
 tNhboxs0yy5Bi5LjkYuh8oCIHZvfSNC0Yje94Ic7Wxw7xtShDSSp7v7C6e5mnY8k2+Lr
 SWL/vFjrtEKPAy4sRRqled5WRctL5MjpDpSWwNJukoZZTwNRMvvCuf3y+JW2rj8Y7KoJ
 MaurDWE4pg3cKzO57QM6dAT+Xk5IKch4Lvhx7Ez43gxjGPLFmP+V/Ctsq8nwDEpmbk5u
 PCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723045440; x=1723650240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z2wwnQZAZTutW1/5c+dMVshvT+BgeY8/AGOPZebu2DA=;
 b=kWnMXbtseJLAEXzno3JbANrpMxp2YKbZqAAFRYXdhnrWVnD2iLlZkZiusZVpt2QXIU
 s4m1lCWFOAxRRHLb/9YxKdemj6VTNThyrFgl70KnFpvf887ENyfSD07PTMkAp0LRSXBS
 CdDmlNO8fEPTEVXY0IADs1NSgWX+JDYNEvqQ8uVZ+6ZSR0qQmiX5E+SPt3Ik2+2Q3RDg
 EnlZkDzdBJNFzi83KVdZ1X8It6zn3uSERF0Oyqxh0/rwAPGmCvHr961AIQwfTJpBdyfS
 OLSvI53AflAV0U16cw6mCHurx/tek/iDHtse5ejnmd5vS6cBTJ33kaLbcoByPxwnQeze
 1SVQ==
X-Gm-Message-State: AOJu0YyvL83DtRLeqgHULe1/D89XSEeDd6WJNxpP03z9uvQ+qdyFG3TV
 lDuwCavflbefLB7w4puyHel3AxfNNtCGy2YoUlquxepnwp1Bj+IVYbepHBCaNTBvMAgJfdcNWMX
 OR3fsB7NrU7V0FIsyfq/PmXwVah/LX7DsVtPmbg==
X-Google-Smtp-Source: AGHT+IHecYjktdhWQx0npsv1Cry93lfgxyNUBojMh3eK5bj/2jdLO0PWVkoChn59iHIRd8XUgl/SO/gyrhuHGYDTMYk=
X-Received: by 2002:a05:6870:f14e:b0:260:f43e:7d89 with SMTP id
 586e51a60fabf-26891a80a57mr24602241fac.2.1723045439511; Wed, 07 Aug 2024
 08:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
 <ZqlGjaleFHdnJUZy@x1n>
 <CAK9dgmbkKPDTYv0i1jpASgTR5iN+_4+DrZUxo5VxQF3NdZewaQ@mail.gmail.com>
 <ZrJTDhyRdjEL9VTV@x1n>
 <CAK9dgmYcW7C9i+KGMH1pN_QRWy_A1ZGXixi49Unt6VhaP6DVzw@mail.gmail.com>
 <ZrNvltexbLK8yxTm@x1n>
In-Reply-To: <ZrNvltexbLK8yxTm@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 7 Aug 2024 23:43:43 +0800
Message-ID: <CAK9dgmbWf19X_2zWYG7w4b7mzDncCw0jBEVG0EQ8k003AQ_dqg@mail.gmail.com>
Subject: Re: [PATCH] migration: Refine the convergence detection
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000005abb0d061f19c745"
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000005abb0d061f19c745
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:59=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Wed, Aug 07, 2024 at 02:46:29PM +0800, Yong Huang wrote:
> > I still think dropping the dirty_rate_high_cnt is a refinement. If
> migration
> > has a precise detection of convergence, what do you think of it?
>
> Maybe; I don't think I thought through those yet..  If so that'll make
> sense to be based on the sync change first, then we can have a parameter
> (doesn't sound like a cap on its own) for keeping the old auto-converge,
> and pile new logics there.
>

Get it, I'll try it this way and see how it works


>
> Thanks,
>
> --
> Peter Xu
>
>

--=20
Best regards

--0000000000005abb0d061f19c745
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 7, 202=
4 at 8:59=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pete=
rx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Aug 07, 2024=
 at 02:46:29PM +0800, Yong Huang wrote:<br>
&gt; I still think dropping the dirty_rate_high_cnt is a refinement. If mig=
ration<br>
&gt; has a precise detection of convergence, what do you think of it?<br>
<br>
Maybe; I don&#39;t think I thought through those yet..=C2=A0 If so that&#39=
;ll make<br>
sense to be based on the sync change first, then we can have a parameter<br=
>
(doesn&#39;t sound like a cap on its own) for keeping the old auto-converge=
,<br>
and pile new logics there.<br></blockquote><div><br></div><div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">Get it, I&#39;ll try it this way and see how it works</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000005abb0d061f19c745--

