Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC94E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKek7-0001lN-9l; Mon, 09 Dec 2024 09:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tKek3-0001ky-E4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 09:28:08 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tKek1-0005rr-MY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 09:28:07 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso1278029a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 06:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733754483; x=1734359283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3VzB4rQQ2XBhf3US1HbpYXW0ZRwVrixDn37AY5QOv4=;
 b=MWlMMt2B1OdPtuXp0PKZBcAegsfM5Lg3+xPvx6Q8+yHycztZPsX24X34YFDUMIi5LK
 a0zvH0wbpYTmzPqhgQnqsv6LOg3AipM0oY8zwfBGJQL0ucUX4f/FMAnXkO7o8QNVckug
 GbvFxTGWl4+VuSYyruO68XQJC6BdXiHWxV4Rl86C5nFng7LuvvjV1+fzXDm165QDOH2R
 5j5S78dR2rXQNW6pwprbSSMbMEiWaJxyPJ+JZflLOAv9KA5wEBHrL8dyu1CGFYuUCE+t
 nIecFfV4wiWLWjMYrYg4fdAYpvU78QioQK0z+rKwwV5X5lNunZ2smI7TVyAv/6t6q1c/
 imNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733754483; x=1734359283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3VzB4rQQ2XBhf3US1HbpYXW0ZRwVrixDn37AY5QOv4=;
 b=OtWXXIH7Y7h7UEDmVThrAB1Sr/avP+QGXBSo/vWz8u4Vip7l66e3gxgwP3X7wheXhF
 4u4LCqyVuqdLVUm4CadrIEOuLSSZBqH1AJbDdGmGyhVfzV7KR8+2upnYr+AfKkh6nMhp
 yLe2Ysc3A6WAWI5glho/Tfmtw14GWqN10q7185xCxeNT+n3hJrZVyGV6jab+bYxQSBYu
 r4WZJXU+UfBtys3Y7WZM7ux3u2PzB9oDfuzU9zcgCSvKmnep4+ablmADFIA1yFzPo4VD
 x39D07ClLJdxErfFdzDSJWLSSUi32PzZH334MG5mm03zp+FNeugT3DpQ6ux1UwJbM0rP
 /6qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRWzhoNUhTHOfWjLrbd8AH11CEKw66B93UAln2ly46f/iqq2UmyNpFXULL0wQc3TQuCju9XO5Gd2fk@nongnu.org
X-Gm-Message-State: AOJu0Yxt87YFdPCM9aN3HOsm1taHnK4X7Ei6fFp7hQ0bpDauzZ/9Vs5p
 qr/2yPtTGze1qWMw7BvNbvgzjl9VViorptp5GGuq2lVuG4g6blKvZqS7g1dtTF5CxHccQ/+wq3f
 tZ66ti4Pyf59sf1OvOnv6uIDL0TA=
X-Gm-Gg: ASbGnctusma9DRWpMsRYv7O2dplfEfx5Zs8DlejMKe1UWQJOyg9rFoPiZ8AGKMf6zcc
 CdbW/AAXsKJBaW+gkIVDVaxJIRlUR1E+CiQ==
X-Google-Smtp-Source: AGHT+IF0qbW2FLdKcVL87bL4Whuu5jaV9L8SGfmzK9xV0BzRpf6Hf8eWqjZqcy4aO9HCAIAnPrDWF2QAijAq6HHzNL0=
X-Received: by 2002:a17:90b:3908:b0:2ee:cddd:2454 with SMTP id
 98e67ed59e1d1-2efcf198e81mr1184127a91.15.1733754482619; Mon, 09 Dec 2024
 06:28:02 -0800 (PST)
MIME-Version: 1.0
References: <AS8P192MB200003EB31EB6CD8EF3FE6C2B1332@AS8P192MB2000.EURP192.PROD.OUTLOOK.COM>
 <50d9751c-5399-4caf-85ed-912aa8227aea@redhat.com>
In-Reply-To: <50d9751c-5399-4caf-85ed-912aa8227aea@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 9 Dec 2024 09:27:36 -0500
Message-ID: <CAJSP0QW+ybkxDO6G0Eja4gaHvXBq5-3GmhjPJTHyngNMC=m45Q@mail.gmail.com>
Subject: Re: Please Read: Error in website redirection
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Myles Wilson <Mellurboo@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 9 Dec 2024 at 01:42, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/12/2024 01.17, Myles Wilson wrote:
> > Hello,
> > I was recently trying to download QEMU and noticed, on the landing page of
> > https://www.qemu.org/ <https://www.qemu.org/>,//the button titled "Full list
> > of releases"
> > redirects to https://download.qemu.org/ <https://download.qemu.org/> which
> > results in a *403 forbidden* error.
> > the same issue is present throughout the whole site with any button or
> > hyperlink to see full releases (even the one found in https://www.qemu.org/
> > download/ <https://www.qemu.org/download/> )
>
> It seems to be broken for "https://download.qemu.org" but if you manually
> add a slash at the end ("https://download.qemu.org/") it works at least for me.
>
> Paolo, Stefan, looks like a server misconfiguration to me, is this something
> that could be fixed in the configs? Otherwise, I think we should update the
> links on the website to include a slash at the end...

This issue seems to be related to how the CDN server handles the HTTP
Referer header.

Paolo: Is there a GNOME GitLab project where we can raise an issue to
ask the CDN admins to help?

The 403 response occurs when I include the referrer:

$ curl 'https://download.qemu.org/' -H 'Referer: https://www.qemu.org/' -o -
<!DOCTYPE html>
<head>
    <base href="//error.c.cdn77.org/" target="_blank">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="author" content="(c) 2019 CDN77">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="nofollow" />
    <link rel="stylesheet" href="css/main.css">
    <link rel="shortcut icon" href="img/favicon.ico" />

    <title>Forbidden</title>
</head>
<body>
    <header class="Header">
        <div class="Header-wrap">
            <span class="Header-errorNumber">Error 403</span>
            <h1 class="Header-title">Forbidden</h1>
            <div class="Header-description">Sorry, you don't have
permission to access this resource.</div>
        </div>
    </header>
</body>

Now without the referrer:

$ curl 'https://download.qemu.org/' -o -
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<body>
<h1>Index of /</h1>
<hr>
<table id="list">
<thead><tr>
<th style="text-align: left; width:55%">Filename
                            </th>
<th style="text-align: left; width:20%">File Size
                            </th>
<th style="text-align: left; width:25%">Date</th>
</tr></thead>
<tbody>
...

Stefan

