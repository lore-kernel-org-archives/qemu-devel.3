Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D8C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNbB-0002HI-GZ; Thu, 20 Jun 2024 15:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sKNb9-0002H1-QJ; Thu, 20 Jun 2024 15:37:31 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sKNb7-0006T6-TC; Thu, 20 Jun 2024 15:37:31 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so14409901fa.3; 
 Thu, 20 Jun 2024 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718912247; x=1719517047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5iWSTrdenQZ0Bs3RekQHuYDNJaVWimLzJ5W1w3z5xls=;
 b=BaLAAKQujL6dhrxUSRx4g28QsX/EhU0RODEMXigFX1uGlgclkn2J8JCOTvhvUHFhp8
 He1WW4ksim8w8znbgG8Doou93xxGCCnYISqRluxmBNPuChRhngeVgzRuXrmPIE9E/4a+
 tFYHVejrD2ehYNbAAOkSZJpdpMqhQ6hHteFcEcmYxb3pu57p4ej4JSNhjB1tNPDI6xg1
 XgAHuHvjR7nHncBGDi+Jp68mxyINgouSmVrEElZM1FDaFGCTLQgFanGjkNi1nBewnqsg
 Vc80qPkIAcOVdZTBdhVxtaCYqh3i+5rbim0ahJC9xeLw4u5M6tzlWiWTYxH7u9Ye91Sm
 Cwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718912247; x=1719517047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5iWSTrdenQZ0Bs3RekQHuYDNJaVWimLzJ5W1w3z5xls=;
 b=ZcsFMh3OwdQJbnFclopA5WSGTmAJeyqdMDlI2jgczJE9uveIj59LlpKsjQ3amQ+pOf
 u0Upccrnd3kM3EsH6QQafKFKKXDEzqqaBT4kQPGQj2Vlx+UBVS0staQhLMTV4AgVNnAf
 2ugOGiHEimJ6pzWQmwHoN9gCkKv/enOm7wi5ZYGZtB+kCkzaup+VfDbKBNg0E0FH3YDP
 c31pPnqlvcT5UfE3zem3jWwB+XagBmUb1Ad7rcbk2CXXZMk0zTIx2HjQPt2wm6c53avk
 BSRP7T5p4hNrPEgr68+eFKhNNootnZp8wIjCSZS7px2E13skggW1RDp8HFCE+4wNyz+4
 YpCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA67Bt9Yly74q8Ka1pB4p46VGHg5F0FPHvAFPB0xvEbE1pZEOJNqspsn0+YdkpQGsNuwcO6b1jeV54hr9hUdAa36YvxZp+X5GjWMxj96YPy2osguUWrxqd/Wk=
X-Gm-Message-State: AOJu0YwgHHSde8FqUfd4gumKMhnzjNY/9j58fY7JV3c86P8crheBC0K+
 F05mTX8j7OERJOaa/Ai6yBPsaRYT/vwsyT/e7jEE8tKj/mOGzaOBKVBTGThMVP4lBDrSo/cZxzs
 ccOuT1gjPprMPXsFM7hp8QhRKS4GRAu0n
X-Google-Smtp-Source: AGHT+IHhfILptRWuQVqPT7Vxvm5yeQWfvbAGjMUxFpYaWoXW6ANbzm4JlWQBXUEhm8+0SPalneCrZCP0PNzK53NAJ1M=
X-Received: by 2002:a2e:9dd4:0:b0:2ec:1ad3:fb0a with SMTP id
 38308e7fff4ca-2ec3cfff3afmr40045111fa.43.1718912247344; Thu, 20 Jun 2024
 12:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
 <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
 <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
In-Reply-To: <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
From: Arthur Tumanyan <arthurtumanyan@gmail.com>
Date: Thu, 20 Jun 2024 23:37:15 +0400
Message-ID: <CADueUgS1==4gAmNmTBLZzrnRUp9z2wxkce8+TcOeoR3w_Pg-bg@mail.gmail.com>
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: peter.maydell@linaro.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 andrew.smirnov@gmail.com
Content-Type: multipart/alternative; boundary="000000000000e73980061b5771cd"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=arthurtumanyan@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e73980061b5771cd
Content-Type: text/plain; charset="UTF-8"

Thanks for the answers, I could move forward a bit more. I'm going/I need
to to create a "virt" machine with designware PCI controller for simulation
purposes. Will get back with progress in case anyone is interested in
results. Thank you again for your time and support.
Arthur

On Thu, Jun 20, 2024, 23:05 Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 20 Jun 2024 at 18:34, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 20/06/2024 10.28, Arthur Tumanyan wrote:
> > >  From the other hand the device is declared as non pluggable:
> > > dc->user_creatable = false;
> >
> > Well, that means that you cannot use those with "-device". They can only
> be
> > instantiated via the code that creates the machine.
> >
> > > Can you please help me to use designware-root-host/port devices ?
> >
> > It seems like the i.MX7 SABRE machine is using this device, so instead of
> > "-M virt", you could have a try with "-M mcimx7d-sabre" (and a kernel
> that
> > supports this machine) instead.
>
> Right -- these devices are the PCIe controller that's used on the i.MX7
> and i.MX6 SoCs, and they're automatically created when you use a machine
> type that uses one of those SoCs. The "virt" board doesn't use that
> PCIe controller, it uses the "generic PCIe bridge" TYPE_GPEX_HOST
> (and you automatically get a PCIe controller when you use the virt board).
> You can't change the PCIe controller type of a QEMU machine from
> the command line, you have to configure the guest to use the controller
> the machine type provides.
>
> thanks
> -- PMM
>

--000000000000e73980061b5771cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks for the answers, I could move forward a bit more. I&#=
39;m going/I need to to create a &quot;virt&quot; machine with designware P=
CI controller for simulation purposes. Will get back with progress in case =
anyone is interested in results. Thank you again for your time and support.=
<br>
Arthur </p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jun 20, 2024, 23:05 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lin=
aro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Thu, 20 Jun 2024 at 18:34, Thomas Huth &lt;<a href=3D"mail=
to:thuth@redhat.com" target=3D"_blank" rel=3D"noreferrer">thuth@redhat.com<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; On 20/06/2024 10.28, Arthur Tumanyan wrote:<br>
&gt; &gt;=C2=A0 From the other hand the device is declared as non pluggable=
:<br>
&gt; &gt; dc-&gt;user_creatable =3D false;<br>
&gt;<br>
&gt; Well, that means that you cannot use those with &quot;-device&quot;. T=
hey can only be<br>
&gt; instantiated via the code that creates the machine.<br>
&gt;<br>
&gt; &gt; Can you please help me to use designware-root-host/port devices ?=
<br>
&gt;<br>
&gt; It seems like the i.MX7 SABRE machine is using this device, so instead=
 of<br>
&gt; &quot;-M virt&quot;, you could have a try with &quot;-M mcimx7d-sabre&=
quot; (and a kernel that<br>
&gt; supports this machine) instead.<br>
<br>
Right -- these devices are the PCIe controller that&#39;s used on the i.MX7=
<br>
and i.MX6 SoCs, and they&#39;re automatically created when you use a machin=
e<br>
type that uses one of those SoCs. The &quot;virt&quot; board doesn&#39;t us=
e that<br>
PCIe controller, it uses the &quot;generic PCIe bridge&quot; TYPE_GPEX_HOST=
<br>
(and you automatically get a PCIe controller when you use the virt board).<=
br>
You can&#39;t change the PCIe controller type of a QEMU machine from<br>
the command line, you have to configure the guest to use the controller<br>
the machine type provides.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000e73980061b5771cd--

