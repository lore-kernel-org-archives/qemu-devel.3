Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CF1CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVsv-0005aO-Et; Wed, 10 Apr 2024 07:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVsu-0005ZZ-0g
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:12:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVsn-0000fp-No
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:12:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516dd07d373so3109502e87.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747568; x=1713352368; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ALT6kqEnrjbh1nQAK2UvKfGb74xu8lPYLkMQ+6mKJxs=;
 b=b7pUXqcd0e6elvX7mBdj1mbqcrREqiHCMVN18s6a4kZ/prXTnQiP0q0fMt6edXoqqw
 /Id5ycsihowHKdgWRiSycOnUf6cMlASZmbo74QpzyAFq+S+mM5WgSnuM8DBdUKHPM2by
 5mz+S54oM4bNHeKJUnF6EUIjr0kJjiqE2pUaNNhKCoJ9rHTLrSo+asIRV+s9oPpmDcr3
 EGMHIDJlbEgyNvmkP9+Yu3lo+E1h3iP5yzqchNfeGSP51DyzBWkxWU/bUI6OgFMe1doK
 YdSshl+MEmvoL4OxNFEyb/2hvXYjbibClJulVwTeFi68aQ5xpJQ2OGDZCh0nUSqIuKTM
 AQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747568; x=1713352368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALT6kqEnrjbh1nQAK2UvKfGb74xu8lPYLkMQ+6mKJxs=;
 b=h+0C1nuFhqY7dFukhLTzopCODmilbMlXirBLDitCK0VJsrS41rgZj9hmeRLsHMBTO4
 snc3KjJ5sqQrLGMnhvqbqxxQhAvi+uHLDWdP8TSvuKsUWM+1WcLP+ej/Y3QxsWvZX5BA
 Wr8sjA95ML13KKta7VHOLU2abT7bsr0YYEepn35UFVNkWiMtae6AuyXYmx/JiPUHsPqU
 5iQfbg0GZmDUrmuz94fluqUxye8I8dsIPSl2DDON75CsE2rwmi0smXfEYdKQ7kv5iSWb
 7fBknvy0+rlfPsfGRtEICR+xCdH2lfBl6vvdhj4sA0ZA4VM+03og2liM/scvaPKsDY3F
 yQkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUcAW7v4WTJP1my2RgG07VGxynyqBA5qo0uu6+Ia/ndhgc8nIFk44o7Oc8tdicPXtljkk5wRGzBtBi7GzvxMyV70mN5DE=
X-Gm-Message-State: AOJu0YxY+PaJiDqbAQ2LEZy0eH0Cc1Ee10rSAgiON/3jkNVIc5bbD2dB
 mJXqQISVlYWxOiqs17lS+fTX4x78SQuHiDEYo5jhnQ6UYDzGD97NxexUeKgNWJLgZ0ZHD/PFZbo
 JLo8Rj3PUwqvdGrnGdBAO8k0e6ts=
X-Google-Smtp-Source: AGHT+IEcfMnAGY+YId1/vKeyCz6HCH/seMLuFbXPkv+qzkzyvPCN43a5QYTzcwAeKjoODGKkTEYUg8tHJxVPcN/UUM4=
X-Received: by 2002:ac2:5450:0:b0:516:d4f5:9382 with SMTP id
 d16-20020ac25450000000b00516d4f59382mr1328455lfn.52.1712747567575; Wed, 10
 Apr 2024 04:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-3-vikram.garhwal@amd.com>
 <875xy659op.fsf@draig.linaro.org>
In-Reply-To: <875xy659op.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:12:36 +0200
Message-ID: <CAJy5ezqbMq=gCPZJYsQZNq7V5OP-2BjA6kp7RbvZzyKzxC71mA@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 2/7] xen: add pseudo RAM region for grant mappings
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, 
 jgross@suse.com, Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: multipart/alternative; boundary="0000000000005af99c0615bc1ee1"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000005af99c0615bc1ee1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:06=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Vikram Garhwal <vikram.garhwal@amd.com> writes:
>
> > From: Juergen Gross <jgross@suse.com>
> >
> > Add a memory region which can be used to automatically map granted
> > memory. It is starting at 0x8000000000000000ULL in order to be able to
> > distinguish it from normal RAM.
>
> Is the Xen memory map for HVM guests documented anywhere? I couldn't
> find anything googling or on the Xen wiki. I'm guessing this is going to
> be shared across all 64 bit HVM arches in Xen?
>
> Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

--0000000000005af99c0615bc1ee1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Mar 1, 2024 at 3:06=E2=80=AFPM Al=
ex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@li=
naro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Vikram Garhwal &lt;<a href=3D"mailto:vik=
ram.garhwal@amd.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt; write=
s:<br>
<br>
&gt; From: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=3D"_=
blank">jgross@suse.com</a>&gt;<br>
&gt;<br>
&gt; Add a memory region which can be used to automatically map granted<br>
&gt; memory. It is starting at 0x8000000000000000ULL in order to be able to=
<br>
&gt; distinguish it from normal RAM.<br>
<br>
Is the Xen memory map for HVM guests documented anywhere? I couldn&#39;t<br=
>
find anything googling or on the Xen wiki. I&#39;m guessing this is going t=
o<br>
be shared across all 64 bit HVM arches in Xen?<br>
<br>
Anyway:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a =
href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></=
div><div><br></div></div></div>

--0000000000005af99c0615bc1ee1--

