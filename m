Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527B606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PWVblEOo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOP91-0008OB-6o; Tue, 03 Nov 2026 19:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xOP8z-0008NH-Rj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 19:46:26 -0500
Received: from mail-lr2-x07.google.com ([2a00:1450:4864:38::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xOP8x-0005fo-5z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 19:46:24 -0500
Received: by mail-lr2-x07.google.com with SMTP id
 38308e7fff4ca-3ab1b11ca0bso1293621fa.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 16:46:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793753179; cv=none;
 d=google.com; s=arc-20260327;
 b=LylTS/mdAACxbnINI5UHdeEZEFLcbN+euqE492W9MoTpSM6TlyHJchsxKX497MSAoZ
 p48mRA9VKvyTpVIOw8W+PqavRQRE2++jmKh/nMWDsHUZvsmtM+0/9eKNMYwg6uVTvSXi
 O3w2v3PrnQ4S3F5sULmCUlCMQFqFTyzIKxUKkpwbNDTTVJV0uAveWWPdo+d1fbfaMGiK
 vGo+31t9FdN40FthQdhJs3U7fj2Ct5nFtIwCwQyBlZzLy2oLWxoo5wMF2eoNNDVLVPpM
 WPoxB48uYwiBCboWGDwiS1m9B4xlp9skD0SYGz4SXiyFIvROOsaVmR7muXxzbVaci2gh
 RLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3x5U6U5sP+d8TBdF09UQxwnOAy7Em8w8k6z+rZytcvY=;
 fh=C610jvcrafpJpv+nhwL3d0G0iCieofbR34w/Da3d5Hw=;
 b=XhzaeKxzUL0Fej/KAtEYKdl/6gjy1UPtmDEM1y7qGg19qeQS4yFrtNB0p2iOtqEImO
 9g9FMye6iK3dReaIkFf+wHpPo++JL7Ht+5k8rSwj7GsMMAYNaKlaNUbLXrXK7kYKVt4r
 ZIhqQP0SO5reQCqadauGy7g2u+6wdJGsLglLIpsFtZtrEAo6EePenz895Maqqikz1D9Q
 hB2CY3fVJ1SlFZlLJlqPyJerZwkP17/Hb8ANRBhXf7c4Yn+09xGehLhORkJw0o8C/WGl
 orcKblIre7S5vZrhcOr4jEPIR9P3CAVPwLTZaLunDLUHW4WklH6QbmIM/3WGpZcneOTi
 gS0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793753179; x=1794357979; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3x5U6U5sP+d8TBdF09UQxwnOAy7Em8w8k6z+rZytcvY=;
 b=PWVblEOoejPcLiXtuUddJLCzJD5vbS5rDXYtrtpG8l2mc4cEzOKnRYDyXMdotHCV3r
 4cwN8trLGaQ8bp7rRaRgOw7SgrtfwZEr3xTlT1LhUR0PnZJUcWshCIksRPBsKf+SIrln
 dEIvE5lTmvboqc0vK9C2Q4NeYkPJ4ashwICAv5AC46tI6NgUFeEkhz7H/6YJhDK9szrx
 Pwtx7uezhamHOmnFMBK1u7olSWH87folP1/W2hOsH5c5uwgRQgrsSLva6+0wMtazmFPX
 a69w1Icv8dcuTzXYLjmneIX9ZpeHNvBwjwvkEKYISSi2cCjhs/Bz76iIhmrdCmGpGPIn
 Mv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793753179; x=1794357979;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3x5U6U5sP+d8TBdF09UQxwnOAy7Em8w8k6z+rZytcvY=;
 b=PcHx5Z5fWsWg5p1PbZ4yULrz3+xSYYSPdveGkAImuKF1uuENH90ZZARBsKxyPF1S9o
 Owey2uwOxrrC36dZJ5bX7whWKmQW7kTzeqThzkitVHSMQdclVrcba6vT48SRUyX0eU9k
 S2H9acs1Id5Si3PjTWr9hsdZx8n9IeWg0pyso7AheSDhwbAQmvMwByaL+NOXw+8JwLfw
 rE09c7U/yaf61/egfjUWupvE8C1dFJCcbQtCfUb9d+L4YUVrdaViFgDeXXYgHJoBr8GB
 87W0rRnoPEsCj+vTUCT77ZodrUa2tSgd6M2ca43SExJ75w5PLzJ4+SxkYwnb/NZb2Hqu
 i2Hw==
X-Gm-Message-State: APuU4Z+FEDEoxl5fbCcj/hdRSlR3wy4Dnlv9nY0YLexDgGedpRj+eeiP
 J7Qug7Thx8ek4Dl76DeFa52IHey4bmUV+6NqPAOh8iWvS8woNy3utVVcjtBHQFmClK7uV4/aCnr
 FoliaMHKB/arEagVZ+A629cIieKVOviU=
X-Gm-Gg: AYBFou0FmCiIAnKCWL8K6eNtz2JvQiBBuULDN9aWW/caKQxt+e7cd99xLoDY0lPExPS
 TQf+/lWiIUyAgmqy28dXmu904+Q/vTWJpVepkzyn6Q+7ggvK6beP9p2uNyEpxk7eW6JFmhpBHe9
 o5wvw3FwcZv1lJTNBBIDjP6zFZyqgs5s3rRXc+G1shtDnDoOGZzhru1uep9EJ+uZwG31zXv2hhe
 mYn1et5MUj5ZurYO0kIjiK/4CPR/+cnI+mSwiK5540RMxBebtcgEA+zoaHjGpAvqa++aTgZE9Ut
 9MwMHAeoQNhCAjURypdFXK132a5tYP+NUSjsD+sbnTd+c3tFb3cGSV3qRQaO0O7zbwJ+kljXKGn
 PQp9LLFQoNcCzoJFXtG1ADjS5Ac7qSsQGaQ80dmieSiDqtL9flW6qYRLGO7AA
X-Received: by 2002:a05:6512:3090:b0:5bf:b7d1:6466 with SMTP id
 2adb3069b0e04-5bfd9571f34mr4712399e87.36.1793753178109; Tue, 03 Nov 2026
 16:46:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
 <20261102095049.31551-1-fritchleybohrer@gmail.com>
 <170bc1e13e7abe45c34b0ddab66841bc85a79ef9.camel@wdc.com>
In-Reply-To: <170bc1e13e7abe45c34b0ddab66841bc85a79ef9.camel@wdc.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Wed, 4 Nov 2026 08:46:06 +0800
X-Gm-Features: AclHuK8F6Y1XQ00hqARD3gTCcH7PLYL4XWjnVaWzY7ab1a6geeZEtShzpXvo1f0
Message-ID: <CAN4PorW4_OcscCXAVL5edWt2Z7D-Q03R==iz+m99JhwnELp_qA@mail.gmail.com>
Subject: Re: [PULL v2 00/50] riscv-to-apply queue
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fefa89065f68b4f5"
Received-SPF: pass client-ip=2a00:1450:4864:38::7;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lr2-x07.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000fefa89065f68b4f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

Thanks for the clarification!

I'll rework both patches based on the latest QEMU master, verify the
builds, and send updated versions.

Thanks,
Zephyr

On Wed, Nov 4, 2026 at 8:18=E2=80=AFAM Alistair Francis <Alistair.Francis@w=
dc.com>
wrote:

> On Mon, 2026-11-02 at 17:50 +0800, fritchleybohrer@gmail.com wrote:
> > From: Zephyr Li <fritchleybohrer@gmail.com>
> >
> > Hi Alistair,
> >
> > I noticed that my following two patches were included in the
> > original RISC-V pull request but dropped from v2:
> >
> > - target/riscv: report WRS.NTO opcode in tval on illegal instruction
> > - target/riscv: save ELP in MPELP for NMIE=3D0 exceptions
> >
> > Were these patches deferred to a later pull request, or is there
> > anything I need to address?
>
> Hmm.... I thought I would have replied to the patches with the issue.
>
> From memory I think they caused build failures so they got removed from
> the patch series
>
> Alistair
>
> >
> > Thanks,
> > Zephyr
>

--000000000000fefa89065f68b4f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Alistair,</p><p>Thanks for the clarification!</p><p>=
I&#39;ll rework both patches based on the latest QEMU master, verify the bu=
ilds, and send updated versions.</p><p>Thanks,<br>Zephyr</p></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Nov 4, 2026 at 8:18=E2=80=AFAM Alistair Francis &lt;<a href=
=3D"mailto:Alistair.Francis@wdc.com">Alistair.Francis@wdc.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-1=
1-02 at 17:50 +0800, <a href=3D"mailto:fritchleybohrer@gmail.com" target=3D=
"_blank">fritchleybohrer@gmail.com</a> wrote:<br>
&gt; From: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gmail.com" targe=
t=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Hi Alistair,<br>
&gt; <br>
&gt; I noticed that my following two patches were included in the<br>
&gt; original RISC-V pull request but dropped from v2:<br>
&gt; <br>
&gt; - target/riscv: report WRS.NTO opcode in tval on illegal instruction<b=
r>
&gt; - target/riscv: save ELP in MPELP for NMIE=3D0 exceptions<br>
&gt; <br>
&gt; Were these patches deferred to a later pull request, or is there<br>
&gt; anything I need to address?<br>
<br>
Hmm.... I thought I would have replied to the patches with the issue.<br>
<br>
From memory I think they caused build failures so they got removed from<br>
the patch series<br>
<br>
Alistair<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Zephyr<br>
</blockquote></div>

--000000000000fefa89065f68b4f5--

