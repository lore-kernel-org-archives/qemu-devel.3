Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96DFC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 07:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmoxe-0005FQ-Nv; Tue, 25 Feb 2025 02:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jksoftdeveloper@gmail.com>)
 id 1tmoxa-0005FE-Hz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:02:30 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jksoftdeveloper@gmail.com>)
 id 1tmoxX-0004dg-AY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:02:28 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so9618977a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740466945; x=1741071745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lBiNhYAD/Hw+3CQYcnOxM+KZflEaCWsEGR0ap+QLUaY=;
 b=YnhjRW8HyS1GU8+f95MfAKJ7+QigvfpeGHkASZEgRwMpC3BWjI2lfiV4fUwWoiS6LS
 E77LTP4+Yz/OEGq7tcTSJjesUtP0hQ8n5WOdVEqOWLW/9tKmzL7+MRIOtldIS6McY8G4
 7nQyJiH5BhAtsH5VijBPtpazbfnN6wdQA6mF/Eh27qdsNCAGtNU7/JCsVPo8kgu7y//S
 RxYmlczCJbhMo0HOBhjszHNJYW6zUwXbKm9Hi2bIWAnyS5EKzruYx4mYaGma9DJyjnDs
 fGfs7jjWHDMZXsNDYjg0Xo7cQ/h5IqGj4zHjBYpXG0KERmmAHb2C7+AiF9z8bEGl1vy4
 grdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740466945; x=1741071745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBiNhYAD/Hw+3CQYcnOxM+KZflEaCWsEGR0ap+QLUaY=;
 b=bqdaMckgCksyFm05ubI1xkUnGdgMsmXJy4r56mBfsCXMmeuXJsPWo25HjNXZGiaRGo
 2gsQWsIdOgm7xtzDDaxoz09lAEYKMulpYFZGSruCR+/C0zamaAGPgL0AgvT83ECh/e4M
 IJRbsnCthGmyjLbjkfrPQ+x1ElqVqf3dF3x/Q6vXw4bVySTn+H99n/tQqHIZV1DS6Eok
 h1FlBXRUtamsoQTZ68KqUBOEkO+OwRpSDAiUnSNNPquHsYt2cb9PLfW6FJKRZJ9db4p1
 RaGv0KjNobB1nI4nzBiDjWQQKLAd7d+pAM6JyBMkVtm2zAlcyUe7X9FtDrx5J047PVrJ
 iUyQ==
X-Gm-Message-State: AOJu0YxoSBzmWJMrvgfletRAYMhC8MLVdGk8D6ibAajGs6DrfeU9lFaL
 At+hs6wIb25B8JlEVS4xozibuWjedSj5M60TExt7tkRkR98RI2iVIYbbqwzmmKYJoi4zmkmrwmN
 BdwmYFSEigqSekl/g4JEUKBG0heQJwg==
X-Gm-Gg: ASbGncsD4ph6r0IZkXWf+n1ZEcUBIZnS1SGCFzBbfyMz05j6SO3vOB94gmgzHZcHcWv
 gHijyQXd26xcoZ2xjH2+y9eQZQhsyL+922+r9nGjuRVjeoGqYu26Gkgyc2o54AzoWQnpwoswqil
 IpeXhceaa/BL5OcTneKtzxCA+X3GUokX1+Q0FX6iA=
X-Google-Smtp-Source: AGHT+IHy/qk5upE7w1jX1+zPoeQI5scJmQ71NGlEL2CWtSeTl1gXBWScUu8TCbAhgwqPkYzZWeWmdGcbbpz0AMrO6xI=
X-Received: by 2002:a05:6402:348d:b0:5dc:7823:e7e4 with SMTP id
 4fb4d7f45d1cf-5e0b70f8732mr15970093a12.12.1740466944480; Mon, 24 Feb 2025
 23:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAEHwtECacvmv98uAvXisx57qEN1hMbLjHNWUkm8mOt56wtWGaQ@mail.gmail.com>
 <3c9247b8-7caa-49f8-a892-f044ab48ec12@linaro.org>
In-Reply-To: <3c9247b8-7caa-49f8-a892-f044ab48ec12@linaro.org>
From: Jayakrishnan A <jksoftdeveloper@gmail.com>
Date: Tue, 25 Feb 2025 12:32:13 +0530
X-Gm-Features: AQ5f1Jq9XncugqvuMD_bGmaiYmKj2DdhnoLMx3wUCPqUT78Oo3jamoQffsQ26ws
Message-ID: <CAEHwtEBSv4KUh6momc=u7k9v8tbQ8sNCAdVprHg-mLVqOU_QGw@mail.gmail.com>
Subject: Re: Seeking help on implementing sync over ivshmem shared memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f81b17062ef2091a"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jksoftdeveloper@gmail.com; helo=mail-ed1-x536.google.com
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

--000000000000f81b17062ef2091a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your support . It will be a great help for us .

On Mon, 24 Feb 2025 at 3:03=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Cc'ing Gustavo who maintains the IVSHMEM device.
>
> On 23/2/25 15:48, Jayakrishnan A wrote:
> > Hi Team ,
> >
> > Seeking help on implementing sync over ivshmem shared memory , As part
> > of internal project we could able to achieve shared ivshmem with
> > doorbell mechanism ,But in order to achieve shared memory
> > synchronisation we are trying to add atomic operation  over this shared
> > memory area variables , Just wanted to analyse whether this atomic
> > variable between VMs shared memory will work as expected , If not is
> > there any suggested way ahead to implement synchronisation over ivshmem
> > shared memory for threads running in multiple VMs.
> >
> > Thanks and Regards ,
> > Jayakrishnan A
> >
>
>

--000000000000f81b17062ef2091a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Thanks for your support . It will be a great help fo=
r us .</div></div><div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, 24 Feb 2025 at 3:03=E2=80=AFPM, Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">p=
hilmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:s=
olid;padding-left:1ex;border-left-color:rgb(204,204,204)">Cc&#39;ing Gustav=
o who maintains the IVSHMEM device.<br>
<br>
On 23/2/25 15:48, Jayakrishnan A wrote:<br>
&gt; Hi Team ,<br>
&gt; <br>
&gt; Seeking help on implementing sync over ivshmem shared memory , As part=
 <br>
&gt; of internal project we could able to achieve shared ivshmem with <br>
&gt; doorbell mechanism ,But in order to achieve shared memory <br>
&gt; synchronisation we are trying to add atomic operation =C2=A0over this =
shared <br>
&gt; memory area variables , Just wanted to analyse whether this atomic <br=
>
&gt; variable between VMs shared memory will work as expected , If not is <=
br>
&gt; there any suggested way ahead to implement synchronisation over ivshme=
m <br>
&gt; shared memory for threads running in multiple VMs.<br>
&gt; <br>
&gt; Thanks and Regards ,<br>
&gt; Jayakrishnan A<br>
&gt; <br>
<br>
</blockquote></div></div>
</div>

--000000000000f81b17062ef2091a--

