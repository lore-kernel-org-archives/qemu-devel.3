Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7B4E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKhry-0001DO-MF; Mon, 09 Dec 2024 12:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKhrm-0001Cn-17
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:48:28 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKhrj-0000xW-Hx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:48:17 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3ea065b79so2864582a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 09:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733766493; x=1734371293; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uss8sDJX3h8g6sdprnfLLda8N9W/Y9nwwZw5IGJfD/c=;
 b=yv+xURZPDGkqADy6/92thhDDbkM+xT9bHrS/k1tEH7cN2djC2GCYGeYBL/6Ea/Aiun
 fFb2MuFlKvqBS3/y6ZBllTKZnZLfKSROuqUFXKiyR3EWEueE3pHq+I9FQpKPklh8Kktr
 YJcPFwW/dcaoUX1RDpQyrZUYFnk749QEEt04ICJOaPSovYD5Y3y92IHRBU+dimydVCI6
 1V8FSLIrB7rikfIqtEpnqtvDOMp3R3jc4Hy2Ydg3zPlshGYL+05WlpbByJwjs8hXwF9y
 POOzTuzCLVxO3TzZ6tbXkyiw03usYuZdkuK9mLYEPVPUvelnaSc8xMjRFQDcGUZ08Yqw
 cyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733766493; x=1734371293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uss8sDJX3h8g6sdprnfLLda8N9W/Y9nwwZw5IGJfD/c=;
 b=JC/N5Y6HCwEsJDjNyfGPIfKb65CopOruhcxdy9eHR1BlMoBwIBs0mUPH8SPomhVV0M
 Jss4Aylp5a8I6SuOF0QGoL4LxtFk96AMZ0CINBeX3F67Qfu0Gstr1H6LFRrVrydSSL1E
 mgC941Qb+amX3OPy9LB0hih6fWlNaOSwuiE8UrTOtRgJTgFgq3Kf2VzgXoyqulr0bOok
 L/wrp5ACpCWgIPDnQhjzI3uvHIXWwnTAM/PSCliMnM8LnLDYHfQe0fSjQ9Fk1CY9LFlD
 /g8UpeD6a2VHxSLu9JKUtJKwXsThfEBxqSDrVYncwezTJzNlQqW2luLYQs7yu3KvDpVu
 i4Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX29bgcTxz6raQDzB+JvpuRnxIW8vSa/ao2HGTeYfHdZIKjogpC8yf0t/0q+cwBJaa6l8yVRKLXMmfF@nongnu.org
X-Gm-Message-State: AOJu0YzXn2rjcG3PUNE5vWjboscQ7+Rw4r8s16ApJ/DgS1/d3OWX5RS5
 ttMrdyqy8TYltjRPLNU37NNAb9S5toCmbaTt486Bm9NHYal9Czp6F11rttf2GT0oWTw4zG4kzEc
 Blhnaz3T2gQuUm5gFqS7kl28mBSliXKXRZOhepA==
X-Gm-Gg: ASbGncucTPnsN+HHy0GkOoGAjSVat/x2wSZ63xUxMeWmNYkz4j6RcZV7c42t0ZlK3WO
 Da6bo71MhxfSfc7vmE1U7eC+I+AnrndNr
X-Google-Smtp-Source: AGHT+IGZN2oQEiqPy+UCuY+X3FXGV93mAE7F0rsNdAsBPNXWfCl4Bs7iD6coOhQ4HW6gl7tK+tEednKFBM7sLm99Evo=
X-Received: by 2002:a05:6402:3484:b0:5d3:ba42:e9d6 with SMTP id
 4fb4d7f45d1cf-5d4185694b1mr2102468a12.17.1733766493146; Mon, 09 Dec 2024
 09:48:13 -0800 (PST)
MIME-Version: 1.0
References: <AS8P192MB200003EB31EB6CD8EF3FE6C2B1332@AS8P192MB2000.EURP192.PROD.OUTLOOK.COM>
 <50d9751c-5399-4caf-85ed-912aa8227aea@redhat.com>
 <CAJSP0QW+ybkxDO6G0Eja4gaHvXBq5-3GmhjPJTHyngNMC=m45Q@mail.gmail.com>
In-Reply-To: <CAJSP0QW+ybkxDO6G0Eja4gaHvXBq5-3GmhjPJTHyngNMC=m45Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2024 17:48:02 +0000
Message-ID: <CAFEAcA-bURNUSEvCU2yMDnYB2kRZtekbh3vZRLDNPeGr2DFeSQ@mail.gmail.com>
Subject: Re: Please Read: Error in website redirection
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Myles Wilson <Mellurboo@outlook.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 9 Dec 2024 at 14:28, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, 9 Dec 2024 at 01:42, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 08/12/2024 01.17, Myles Wilson wrote:
> > > Hello,
> > > I was recently trying to download QEMU and noticed, on the landing page of
> > > https://www.qemu.org/ <https://www.qemu.org/>,//the button titled "Full list
> > > of releases"
> > > redirects to https://download.qemu.org/ <https://download.qemu.org/> which
> > > results in a *403 forbidden* error.
> > > the same issue is present throughout the whole site with any button or
> > > hyperlink to see full releases (even the one found in https://www.qemu.org/
> > > download/ <https://www.qemu.org/download/> )
> >
> > It seems to be broken for "https://download.qemu.org" but if you manually
> > add a slash at the end ("https://download.qemu.org/") it works at least for me.
> >
> > Paolo, Stefan, looks like a server misconfiguration to me, is this something
> > that could be fixed in the configs? Otherwise, I think we should update the
> > links on the website to include a slash at the end...
>
> This issue seems to be related to how the CDN server handles the HTTP
> Referer header.
>
> Paolo: Is there a GNOME GitLab project where we can raise an issue to
> ask the CDN admins to help?
>
> The 403 response occurs when I include the referrer:

The GNOME CDN sysadmins have now kindly fixed this for us.

thanks
-- PMM

