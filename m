Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2564EC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKxVT-0005JA-Vc; Fri, 30 May 2025 07:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKxVS-0005Iw-Bp
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:02:34 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKxVQ-0005wS-DI
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:02:34 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-603fdd728ccso3141201a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748602950; x=1749207750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mPtcMoWtTEBNTHyvX1Nc/C8ZnELjgzqWfvPXd/RNj/A=;
 b=GzGMwgdXcH7msX2OMIYgRuVzwL2N+q08b0CsF9F+emfX+dBlVLg6LD/40O6pslHmhr
 Ql4EJvED3tgjHoJt/o02mr1lXaUVoFaZyaLrOTqnAcw5VGaWJM9G/s2SdcQEuzAWxqvV
 flGmvc4BlYQxAa6SpuOZzDERdsfEBPK+yPqiECnwsBkfFonzwtIWWGkY5Un1njuD2hOi
 gJSWOV8ZiEHcYiEBgrgHsZl4rxtKiqcb9N1lYHsInn7rQscp/qcSjc2ILtU7QvOPJe56
 cA281pT3QEe3xCDrOcXRsSsuLANnxUV8HcifeYZso1gNDVuQQBypk+TYCf+bhPWK08nd
 b+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748602950; x=1749207750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mPtcMoWtTEBNTHyvX1Nc/C8ZnELjgzqWfvPXd/RNj/A=;
 b=TQ84J1gp+SMQfYMZiXLfbNvkFlZxWQ+K2upFcSsZH1e7fW+QUQHfHtPOP183nsU0l9
 xgM48UqChhG04QiSh28LPE/CN+1lRxReX6/ALxlqmVzGIJWDitErcNzcNRdWkA6haHRz
 BKwimcrvljmMzgDuifvatmcnQhIjLDJsV1wGw0O5iaQpIWNe4QInWdOUGUrOZ7yGrfFv
 mO5SMqQAy7bqr82wzkvsFFDLb/JYvk6/dWQgyWelD1WxhnzKDsld6HnPrr8o8qtkVelP
 qSa0kbREml0gRHYIICtf2IlGNMUg7Q4k8e12SWDqhLAEeWOrDtbAF+fvW24VEskioYXG
 ZyQw==
X-Gm-Message-State: AOJu0Yz93swYHep1jxF1G28jegrmNbU2cXhFs+jLgrekaocMdneYWclx
 bVXsMR/ERyu2C9vYLBuy3uGLulnD3xoiPLrKbIv9FO+bI8aT23fw9XcH2Z+nznQYdqfuZiAmoct
 +SYCFjjnD1dMLUq1cAOoRhZsFeYi/qi4=
X-Gm-Gg: ASbGnctK/wg7hDl0tYo+8fQrHYCQay0wv9RtIo4Jwvz+2Yy/Ayqq/KX/Y5/qojmEnwY
 XKfiJT1RXRGeRfSbZ7HvcP+RXq6XwyGqe55/0HsgOhVxgcM/DjQcwmDg2cxC2BTQtEIyDQOoCau
 yVtPDhL6WK13KuIFdWDJ4z33btC8CNPk0=
X-Google-Smtp-Source: AGHT+IF6+qLHQFVt+SC+sDJ9G0UjplOH9loIJn3cnDwg3DVDnIe1Pp0w17/WwZbLjXrUZgSwcvPrtod/DUTVyBf8/xA=
X-Received: by 2002:a05:6402:510a:b0:605:878:3557 with SMTP id
 4fb4d7f45d1cf-6057c602f61mr1467711a12.16.1748602949469; Fri, 30 May 2025
 04:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXpwWZK3KeGZ-FVFLhu7CCv8PCRbGZ9MEJK5nS_jUWquQ@mail.gmail.com>
 <b374f581-fdbf-4fad-ab10-45394211c0d6@redhat.com>
In-Reply-To: <b374f581-fdbf-4fad-ab10-45394211c0d6@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 30 May 2025 07:02:20 -0400
X-Gm-Features: AX0GCFtcPgOqCrKFTRFLSrpXuLXvoyBQUBjEUzeEnFk0cDkw1XgYlf43GVEDlCw
Message-ID: <CAJSP0QWXRt2j2Uo=NMHXhiButMBJ7QMYfL=VvmspBc=oTgxDgw@mail.gmail.com>
Subject: Re: Armbian TLS certificate expired
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a80b260636585927"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

--000000000000a80b260636585927
Content-Type: text/plain; charset="UTF-8"

On Fri, May 30, 2025, 02:18 Thomas Huth <thuth@redhat.com> wrote:

> On 29/05/2025 16.45, Stefan Hajnoczi wrote:
> > The OrangePi, Cubieboard, Banana Pi, and replay tests use a sunxi
> > armhf Linux package URL that is failing due to an expired TLS
> > certificate:
> >
> > 2025-05-29 13:37:56,005 - qemu-test - INFO - Downloading
> >
> https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb
> > to
> /builds/qemu-project/qemu/functional-cache/download/3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22...
> > ...
> > urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED]
> > certificate verify failed: certificate has expired (_ssl.c:992)>
> >
> > I will ignore these test failures for the time being. Hopefully the
> > server admins will fix it. Otherwise it will be necessary to find a
> > working URL for these tests.
>
> I just gave it a try, and it seems like the certificate has been updated
> already? Anyway, in the worst case, we could also try to switch to http
> instead of https for this download (we're still checking the hashsum to
> make
> sure that nobody messed with the content).
>

Yes, it's working for me too. Thanks!

Stefan

  Thomas
>
>

--000000000000a80b260636585927
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 30, 2025, 02:18 Thom=
as Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 29/05/20=
25 16.45, Stefan Hajnoczi wrote:<br>
&gt; The OrangePi, Cubieboard, Banana Pi, and replay tests use a sunxi<br>
&gt; armhf Linux package URL that is failing due to an expired TLS<br>
&gt; certificate:<br>
&gt; <br>
&gt; 2025-05-29 13:37:56,005 - qemu-test - INFO - Downloading<br>
&gt; <a href=3D"https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-imag=
e-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V0=
14b-B067e-R448a.deb" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1=
_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb</a=
><br>
&gt; to /builds/qemu-project/qemu/functional-cache/download/3d968c15b121ede=
871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22...<br>
&gt; ...<br>
&gt; urllib.error.URLError: &lt;urlopen error [SSL: CERTIFICATE_VERIFY_FAIL=
ED]<br>
&gt; certificate verify failed: certificate has expired (_ssl.c:992)&gt;<br=
>
&gt; <br>
&gt; I will ignore these test failures for the time being. Hopefully the<br=
>
&gt; server admins will fix it. Otherwise it will be necessary to find a<br=
>
&gt; working URL for these tests.<br>
<br>
I just gave it a try, and it seems like the certificate has been updated <b=
r>
already? Anyway, in the worst case, we could also try to switch to http <br=
>
instead of https for this download (we&#39;re still checking the hashsum to=
 make <br>
sure that nobody messed with the content).<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Yes, it&#39;s working for me too.=
 Thanks!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>

--000000000000a80b260636585927--

