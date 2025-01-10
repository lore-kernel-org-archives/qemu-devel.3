Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84548E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHWI-0005RN-In; Fri, 10 Jan 2025 11:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWHWF-0005A8-7x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWHWB-0004uB-3x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736525149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KVxdPxOxfkLSM1NEfjh53dQJeocjyDnEHBh4FTY8LOs=;
 b=fXrTj7qB2kTA5KdMy0JQKLHYKVgYaT/ImX4xZctrdtswDoVrcMiUIoha45jJO1yDIYuTYr
 kyzIqFXC17bCngPwfVxCA+OCS6N2BPjbJrIHZKPMYasQOREZlULJtVblvCrzOY2yycR/AI
 fKW9SuMwImj1ArKIfz5KXAkbH+81m3w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-_SDwU10aO9ivup_RIQzkrQ-1; Fri, 10 Jan 2025 11:05:45 -0500
X-MC-Unique: _SDwU10aO9ivup_RIQzkrQ-1
X-Mimecast-MFC-AGG-ID: _SDwU10aO9ivup_RIQzkrQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e00ebb16so911257f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525144; x=1737129944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVxdPxOxfkLSM1NEfjh53dQJeocjyDnEHBh4FTY8LOs=;
 b=VIhS9I11SMIkfcAeFhmRcd0kC5HGkEtx2Rz1ZuDedaRJapVe0+Zmahmpoz55rVblUk
 HAITT9Hqn8J0HfugRRAiSbUUkBwEXQ83jQEDmqdL4PB0pm6vXPGrs2nmCINFWaf1kffE
 mrQm3QNw0JHfq3UwPemRYn1Qcmveh6Rx3DUgmwjajjppbCo5kz7u4S9v4e1lB/6RV2YC
 XQAWyTK15AGDY71oD6OXygVO51DHPea0oSf9vbBGTJUXCRzI8CLipG+zDQcX44GvKo5j
 bSxqWRKRRAcQgpeTzwyx9408vyHjLELMSR08yACmS6AMC+6ZFGbszhilyoH5vsFKBjWB
 TjlQ==
X-Gm-Message-State: AOJu0YzXPJTf+JzbXGY7xpVMmnS6QfImIvWSYZZhJhgBba6b61ktp1T0
 DEYGDPwSAM3Alz6dMchHs7v0ir0Bjt8KEImhQqHzX5ZYVvjGwuGzWy3Mtr2Oe6Qidt6DzHCh1NX
 i/Q+jlP6TFmyzXKT13r0Ix1SQH3+fCvjzMxL3RRFch725FXSI12/lwQ0MwP4kDBb/T4UnO/6m/z
 7WcmcrAzp9OMGxxqwh5QV3bmvu7HE=
X-Gm-Gg: ASbGncuyMy/FH2Uj143V7SofaxHMszMOgA7zd4XxVNfDYSWrEcnUakKxXOX4okadCl+
 TtABY62N9FDm25XJnns0MV3kip2F1CYUSfPc6GA==
X-Received: by 2002:a05:6000:1ac6:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-38a872db271mr9666205f8f.18.1736525144145; 
 Fri, 10 Jan 2025 08:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOCdjwZUeguT69dslBe+8ZhTSGtPepeU6xH2J3UK0craEGaQIqoKrSabJDPUifhv3yJy4coD2Yp+pgugivxLw=
X-Received: by 2002:a05:6000:1ac6:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-38a872db271mr9666147f8f.18.1736525143613; Fri, 10 Jan 2025
 08:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20250110094400.512788-1-michael@anarch128.org>
 <CABgObfY_GOQN5OWBQXYvfrBtNVZGGc75p3gRHrpqQNxUErfB3A@mail.gmail.com>
 <5244f8e9-b58d-4d37-9fe7-2236a862fd91@anarch128.org>
In-Reply-To: <5244f8e9-b58d-4d37-9fe7-2236a862fd91@anarch128.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Jan 2025 17:05:31 +0100
X-Gm-Features: AbW1kvYn1OiJ0HF0a1sv20kBywERZknQrTR2G3UapCL1A7qb0hAbDAgJYSxz-Ls
Message-ID: <CABgObfYdaBun9pZqTtZS_PzSKvrF=f5DE-Vb5pLMWq1HPcAVAg@mail.gmail.com>
Subject: Re: [RFC]: port of embedded x86-mini disassembler to QEMU
To: Michael Clark <michael@anarch128.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="00000000000054471a062b5c446b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000054471a062b5c446b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 10 gen 2025, 14:03 Michael Clark <michael@anarch128.org> ha scritto:

> On 1/11/25 00:07, Paolo Bonzini wrote:
> > Il ven 10 gen 2025, 10:52 Michael Clark <michael@anarch128.org> ha
> scritto:
> >
> >> a note to announce a port of the x86-mini disassembler to QEMU.
> >>
> >> - https://github.com/michaeljclark/qemu/tree/x86-mini
> >
> > I assume the huge .h files are autogenerated? If so, QEMU cannot use th=
em
> > without including the human-readable sources in the tree.
>
> yes indeed. there is an x86_tablegen.py python script in the other repo
> but it is not in the current patch. it would be somewhat easy to read
> the tables from CSV files directly into arrays at the expense of several
> more milliseconds during startup. the revised operand formats maps
> relatively strictly to enum definitions with string tables in the source
> so a reader in C would not be impossible


Building the tables at compile time is fine, only leaving out the script is
not.

> I can see how that might be interesting for x86 virtualization where you
> > have only one target and therefore you can get rid of the capstone
> > dependency. At the same time, other virtualization targets like arm64 a=
nd
> > RISC-V are going to become more and more important=E2=80=94not less=E2=
=80=94and not
> having
> > to maintain a disassembler ourselves as part of QEMU is also a big
> plus...
>
> yes indeed. but in an ideal world the encoders and decoders are matched
> pairs. I would like to work on a translator or interpreter that uses the
> same codec as the disassembler


Ok, that makes sense. QEMU already has a decoder that is very table-based
though the tables are hand written. I am not wed to it though=E2=80=94as lo=
ng as
the code generators remain more or less unmodified, I would love to only
keep "these is how the operands are prepared for use in the IR emitters"
and make the details of x86 decoding Someone Else's Problem. So if you can
kill most (certainly not all) of the tables in
target/i386/tcg/decode-new.c.inc that would be interesting.

(I am sure you'd find some underspecified and/or wrong parts of the x86
spec, too :) For example many VEX classes are bollocks, plus some more
examples hinted at at the top of that file).

Paolo

anyway, in fact it is just yet another disassembler at this point, but
> the codec emitter works. it doesn't yet have an arch-neutral TCG-like
> API and IR to drive it yet.
>

--00000000000054471a062b5c446b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 10 gen 2025, 14:03 Michae=
l Clark &lt;<a href=3D"mailto:michael@anarch128.org">michael@anarch128.org<=
/a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 1/11/25 00:07, Paolo Bonzini wrote:<br>
&gt; Il ven 10 gen 2025, 10:52 Michael Clark &lt;<a href=3D"mailto:michael@=
anarch128.org" target=3D"_blank" rel=3D"noreferrer">michael@anarch128.org</=
a>&gt; ha scritto:<br>
&gt; <br>
&gt;&gt; a note to announce a port of the x86-mini disassembler to QEMU.<br=
>
&gt;&gt;<br>
&gt;&gt; - <a href=3D"https://github.com/michaeljclark/qemu/tree/x86-mini" =
rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/michaelj=
clark/qemu/tree/x86-mini</a><br>
&gt; <br>
&gt; I assume the huge .h files are autogenerated? If so, QEMU cannot use t=
hem<br>
&gt; without including the human-readable sources in the tree.<br>
<br>
yes indeed. there is an x86_tablegen.py python script in the other repo <br=
>
but it is not in the current patch. it would be somewhat easy to read <br>
the tables from CSV files directly into arrays at the expense of several <b=
r>
more milliseconds during startup. the revised operand formats maps <br>
relatively strictly to enum definitions with string tables in the source <b=
r>
so a reader in C would not be impossible</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Building the tables at compile time i=
s fine, only leaving out the script is not.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">&gt; I can see how that might b=
e interesting for x86 virtualization where you<br>
&gt; have only one target and therefore you can get rid of the capstone<br>
&gt; dependency. At the same time, other virtualization targets like arm64 =
and<br>
&gt; RISC-V are going to become more and more important=E2=80=94not less=E2=
=80=94and not having<br>
&gt; to maintain a disassembler ourselves as part of QEMU is also a big plu=
s...<br>
<br>
yes indeed. but in an ideal world the encoders and decoders are matched <br=
>
pairs. I would like to work on a translator or interpreter that uses the <b=
r>
same codec as the disassembler</blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Ok, that makes sense. QEMU already has a decoder =
that is very table-based though the tables are hand written. I am not wed t=
o it though=E2=80=94as long as the code generators remain more or less unmo=
dified, I would love to only keep &quot;these is how the operands are prepa=
red for use in the IR emitters&quot; and make the details of x86 decoding S=
omeone Else&#39;s Problem. So if you can kill most (certainly not all) of t=
he tables in target/i386/tcg/decode-new.c.inc that would be interesting.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">(I am sure you&#39;d find =
some underspecified and/or wrong parts of the x86 spec, too :) For example =
many VEX classes are bollocks, plus some more examples hinted at at the top=
 of that file).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">an=
yway, in fact it is just yet another disassembler at this point, but <br>
the codec emitter works. it doesn&#39;t yet have an arch-neutral TCG-like <=
br>
API and IR to drive it yet.<br>
</blockquote></div></div></div>

--00000000000054471a062b5c446b--


