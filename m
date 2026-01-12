Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04272C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIS0-0001l5-Vh; Mon, 12 Jan 2026 08:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1vfIRv-0001k8-G4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:59:16 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1vfIRt-0000oE-JW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:59:15 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b87018f11e3so233372266b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768226351; x=1768831151; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fzb1AGi75spA3Dg09oVPKnny4FzdZJ5jCZYXkLrfdfM=;
 b=jQFV4OG8fBSUesck3QN7TpkGcGB/yLtCTsRSNFO9Q2KOTIO2TD/gi7T1MkdGnWZcIk
 xIW8w/G7634B5eTIYp1uQTe4ObucX4JteB17gyXaDgyOn2vaUQWqcrRFKjpxceuUIlLh
 t2pWLFAtToXD7+sw1j7MNvVN0GZfWLMUcyVUY9hFhB23AA01bGNgnIGWdcgzsUydaIOR
 9Bno//C+40Zh9Pul+M4EGZZ7RrMG6ODPVBfoRO1Hwu55hFICCap4KlRTmIg0TJo8Lghd
 uJZsaOjA6yGI/qNBIoQ0RKcorcaG1rYcdvfNXOOu0kRRXGGNnmnqVMpe3uP9FkVYSc89
 WBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768226351; x=1768831151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzb1AGi75spA3Dg09oVPKnny4FzdZJ5jCZYXkLrfdfM=;
 b=jqTq/VxgNjby+EBiT9YT0QJp1DlR9DfKVmH7Vpw9LiFIg9zI1r5A/EC/HlQtJqncd2
 RtYNgWJewK5PcK6vA++Q4PajOaFR8zYSBrJqhGXqvZn0kw8Exzn40AGs+1NYB/OQMI0b
 VCTOn12iEjs6fHjcXTXQMlrmuG38uFBct8XOQnIhU5DRe/7dFpV/MdyWZY1CMoWXypnF
 4EgSvHNbm+uOppkrFihFwGvxg8gEngrDJbswiWXZLYQ8ZVa60uy+H/Vez7efvwMvwZCW
 pcP/uiEd+qMd2r4d4IYev02temRcfTnREBMtVaN/0GVsOupe2EBrmJUIMzHAzbaKgeWp
 TxkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW061f9fTGGlXqxhCV5rBfxSaI7JT9osCgujCbS7We84btvRtSYZum8lo4LUxCXk+Xcz/rTytUlWQXd@nongnu.org
X-Gm-Message-State: AOJu0YyvQyRsdGEMExAFlo5YuVR/2UXCvVyslLX/4Qe9YiiSezw/m0Cl
 oyh/Kjk2bB6dKebQ1VNlqAtSNU0i5Tm8WPVFtRS1KMiFMRO2JNz1sGdY4KgfpwxBxk/piQ0qSNt
 Y0Vf4Bnrfzh9J9DAGyvV29kmmKhhSMVg=
X-Gm-Gg: AY/fxX69mDUjvxNau/bIdW+xSpRW2FzPvH0/BhnEXAio9P8yyu0ZKxygfkDQzTqc9Hs
 NjXFLBPGgVOyspYCHifBA6fqOGAcAfVg6hiDblxwt7fCHYys918B4WytD7GHGFBVaKH+QOVCiH7
 DUkQEjJGxqLVtT77Cx+ensVyNLZI8xh4hdGpj4WqWRfQUud7WOo87f9KObit5RFBGOif08bv4xx
 W6ijn/P4aamxNZd/QDJwLHzB8FOeGrb4f4KqxeMS1QtWwBIkPbxgcfikN2qEJHU/Wa0rNE0SziP
 IcIk20oG0dIAUwCzSARb20cv1G2pqw==
X-Google-Smtp-Source: AGHT+IGpk41a1MPiWJjgyXcuZysnvKnjNwySGbWk9NbwqqkQXFljIXmFAsRnQ4ApO1KBPbPxkcEgnpEIPrMIr985/DU=
X-Received: by 2002:a17:907:1c9e:b0:b87:2abc:4a32 with SMTP id
 a640c23a62f3a-b872abc6502mr140207666b.18.1768226351280; Mon, 12 Jan 2026
 05:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20260105160138.3242709-1-calebs@linux.ibm.com>
 <1301eb7b-31d8-476f-a12a-06470a349771@linux.ibm.com>
 <20260112-fuzzy-idealistic-labrador-9b5cff@lemur>
In-Reply-To: <20260112-fuzzy-idealistic-labrador-9b5cff@lemur>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Mon, 12 Jan 2026 19:28:59 +0530
X-Gm-Features: AZwV_QgGr3XSeKQIlFD2prhpEpQVOPW0J0oUo5bmWP1hwtv-QIy8cBWHVoSqJzE
Message-ID: <CAEuJdmqX3fJqC50i-96PYuz2skn33Y2YL3HqjWxsrYJ16JrdwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] hw/ppc: Snapshot support for several ppc devices
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, milesg@linux.ibm.com,
 alistair@alistair23.me, 
 chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, angeloj@linux.ibm.com
Content-Type: multipart/alternative; boundary="0000000000008cf58b06483147a7"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000008cf58b06483147a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan, 2026, 7:05=E2=80=AFpm Konstantin Ryabitsev, <
konstantin@linuxfoundation.org> wrote:

> On Mon, Jan 12, 2026 at 03:32:13PM +0530, Harsh Prateek Bora wrote:
> > > For the series:
> > > Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> > > Reviewed-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> >
> > For some reason b4 is not picking above tags even with -S (to avoid
>
> Because there is no space between the name and the address, which is not
> correct format.
>

Oh, yes. Thanks!


> -K
>
>
>

--0000000000008cf58b06483147a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 12 Jan, 2026, 7:05=E2=80=
=AFpm Konstantin Ryabitsev, &lt;<a href=3D"mailto:konstantin@linuxfoundatio=
n.org">konstantin@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On Mon, Jan 12, 2026 at 03:32:13PM +0530, Harsh Prateek B=
ora wrote:<br>
&gt; &gt; For the series:<br>
&gt; &gt; Reviewed-by: Aditya Gupta&lt;<a href=3D"mailto:adityag@linux.ibm.=
com" target=3D"_blank" rel=3D"noreferrer">adityag@linux.ibm.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Chalapathi V&lt;<a href=3D"mailto:chalapathi.v@linux=
.ibm.com" target=3D"_blank" rel=3D"noreferrer">chalapathi.v@linux.ibm.com</=
a>&gt;<br>
&gt; <br>
&gt; For some reason b4 is not picking above tags even with -S (to avoid<br=
>
<br>
Because there is no space between the name and the address, which is not<br=
>
correct format.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Oh, yes. Thanks!</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
-K<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000008cf58b06483147a7--

