Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F4606C938
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sl3LXoUV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOi95-0003Yn-No; Wed, 04 Nov 2026 16:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOi94-0003Yf-AM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 16:03:46 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOi91-0002Kx-Rc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 16:03:46 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so733142b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 13:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793826222; cv=none;
 d=google.com; s=arc-20260327;
 b=KJxgBbm8VGmAqDuViIJrWcHUWWg6qcFOaC/AE69ZeA6Mb6yTffi5uVBnOgZIxU8REX
 Sr5kqqbB9XjJq3bV1oUnnC+LrzkDf4p45/Skf2eRuFuTbmrgNDYCnUUETrvYts7yAUm1
 R0QWpdW9vYBKtqlcv9TO32+4GT6uHswru6Y3v8DiUrj4615NHpwLtwpJ5nVFe7nNcAoe
 Tzjj6e2ad28068HT6n8enTSWvhRkk4whRiTk42C7b+Lrlvae7yYV2zLHJMVcOBbym8ki
 v3wNVZvu4oKLEP4XG8vmSLSTYRHDZDN+ADmpefq6YTa6mkJH7uYacA8whCqlQgyj+syU
 CsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Beuhh0uJ/dWmbxmSH/WdQAfsLD2FceXknODJAa2Bq6I=;
 fh=zgr7BFV9NqzbGbK2jkIcDr/KLnFt1cLdgtzPAjTKPvM=;
 b=PPhpGvdD/owMjGuWYRbLY1311K3kN6DvgxHejoAmNXlymNSE6B0qSaBxywm+5FC8LM
 3Q4Wiwl2A5lWGM7dNlHcUiLEbSmki+4XGPtImIiVwhKCRd4LaCMUbyVdaFHaPgv3VQji
 oYxMUjhW3zAn1Y/bjtZDj3C1VziA+Azfj623wcu3Y0hOy+1pl7rZrGH6pfCww9Wb2Z9n
 ZDoS+gwCvl548grfcwSPCigOJno8oK/PQUBecFi8bHF+rOfHbr/sbE2t6NwpYAjqr7A+
 kqRqfrI3mRtyugxJicGoLHqZnvJUC/3xe6ikKOpp6EwZ3V2EFkiqnkDykm2OaimReXoW
 /tUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793826222; x=1794431022; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Beuhh0uJ/dWmbxmSH/WdQAfsLD2FceXknODJAa2Bq6I=;
 b=Sl3LXoUVzn18gABfamPGq3SNwM83W+OSYU7guglSVgkmSLv2rX7rdYm8iyf1B/aOWQ
 N5iLzmlooMGsiowuRDnVqET8awO0I2WB2sfD4QyUmzSaU0pkgvgODwdyQAy6gg5v6yXr
 jrqclbACTrVsyis7zh1TqgnJPrepCN3GokBp6WKPtqyeOwPZdoIXeiZYfCxiJL0m2PgL
 +dNGsmdq0R/EBVwkyZLsLGQmSsoBHD7V0nF1pTw5F6I0E4sMkzosNgjpIhCBJ2m1f712
 i06qH3Q2CDPkcta1lINz6E0glNw2amsp5dM9bijNPDKXTT4yr8tZM8qs8vJU2q83JIgh
 bA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793826222; x=1794431022;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Beuhh0uJ/dWmbxmSH/WdQAfsLD2FceXknODJAa2Bq6I=;
 b=OqpqwnRtPxfwIs67esgxXqgfcyL/enezDdowL4WRowNeiEMXrhqgJY2nKboxcFoOfD
 8qqPqimEidld8ugmpOFlmFXh4DlW5IAow2BiIllHjksT7zK1V+21Ye9G4QU8hqqCc0fO
 fRtHbL9l7V2446Yzmvi1njiO+V3AJs8Q8qgNnoeyeKl+ASXhn5qQD1NNyKgHITRPA6WE
 OhZKDs+xR62KHJS5aBkfdYzhgGd0KIRwY3rqwxZaaxIqPjE/S64AcCrsAtQK1kfLUnix
 Ln+ufpPHe80JBugwQr8qmecLB2V0xDNTfalgHveRTuKESMsKbP104WHNc5X5bQ5lH3FC
 jntg==
X-Gm-Message-State: APuU4Z+eZz9Vypst4K+EjfTko29GpYg4C/I6UuKZ4sQV1zZQ4+jToJtR
 gBIT1UCaukBBd8drudxx6+0vzaLL1CjXZ/eoSU5KgCCgcUD7x8KtVzY26k5LNDaNFb4v2Ji3LC5
 W1pIhnt2R8yiLOtkEG26yyR2AacLvpEQ=
X-Gm-Gg: AYBFou3Bx64h9CUuYrbc9dpHGsjC5dwd+H2SthSoKe+BrzO+uph2ENAPNnjK0m3mx1L
 DJT9yaDWcnzyJMjyeYU81DJa6rZoAqpWHj02gAdPgNi5zKWpDoWJsjQQ8IzTtZEu7TsXp6T8sg8
 XPa8oEkKKF2If9B1DAQZBcPgOqAm4kaBampJoo2lgO/gD67odYHbPTqrQerPPJizA3JKmcM8BHE
 yZhFchdnEWwobJ87Fdn1hiTSlacKnX/pdQRWDGV4+NKRL+HYqq+XvAYJeu0mg931H8nSJ2Dr0ce
 YROnE5J48VSt+p1fxuzyGP8++4Ne82rs0QBButrMPdJrNPvGIixKzluFGxPkRzDYGjeUXqerMua
 ELCFMsuZzyvm0lfX0AY5FCvhuM82apWayax2BQcaa3UVesUNuXavIpPWefdVYShCGQc20o0257H
 leVgezWwVdZbBjORA=
X-Received: by 2002:a05:6a21:3945:b0:3e2:b905:12c7 with SMTP id
 adf61e73a8af0-3e928ab8949mr14269585637.78.1793826221854; Wed, 04 Nov 2026
 13:03:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104111619.24479-1-conti.manuele@gmail.com>
 <20261104123605.37729-1-conti.manuele@gmail.com>
 <7240871b-1ff0-40ee-bcf0-bb15139f6c4a@oss.qualcomm.com>
 <CAKm0YZzOEEMK=z5JfJb-fBqWMDwN7_rS2sQR+6dSndB2b+tCrw@mail.gmail.com>
In-Reply-To: <CAKm0YZzOEEMK=z5JfJb-fBqWMDwN7_rS2sQR+6dSndB2b+tCrw@mail.gmail.com>
From: Manuele Conti <conti.manuele@gmail.com>
Date: Wed, 4 Nov 2026 22:03:30 +0100
X-Gm-Features: AclHuK_RxMuSa6HcAqm8HQyCo2xQahGt2_TipTdnkQ-vjvqIHJgoPFdEf62oHVY
Message-ID: <CAKm0YZyEiJ2P_3EUMH6y=CovHkOobA1xPFg_=2ZRNxhs6oSq4w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/sd/ssi-sd: Handle immediate write start token after
 R1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>
Content-Type: multipart/alternative; boundary="000000000000be14e9065f79b6a2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=conti.manuele@gmail.com; helo=mail-pf1-x42e.google.com
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000be14e9065f79b6a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe, Bin,

I've completed the investigation using the unchanged STM32F4 firmware ELF.

You were right about the NWR timing. The SPI trace confirms that the
firmware sends 0xFE immediately after R1, without the required clock
interval.

Therefore, the proposed patch is a workaround for the guest behavior rather
than a QEMU bug fix. I won't pursue it upstream.

However, the investigation also revealed a separate QEMU regression in SPI
mode.

After ACMD41, the card remains in sd_ready_state, but CMD16 requires
sd_transfer_state. This causes CMD16 to fail and the subsequent CMD9 to
return R1 =3D 0x04 (ILLEGAL_COMMAND).

I traced this behavior back to changes introduced in QEMU 10.1.0. Restoring
the SPI transition to sd_transfer_state after ACMD41 fixes the
initialization failure with the unchanged firmware.

I'll address the CMD16/ACMD41 issue separately.

Thanks again for your helpful feedback.

Best regards,
Manuele

Il giorno mer 4 nov 2026 alle ore 21:21 Manuele Conti <
conti.manuele@gmail.com> ha scritto:

> Hi Philippe, Bin,
>
> Thank you for the detailed review and for pointing out the NWR timing
> requirement.
>
> I checked section 7.5.4 and Figure 56 of the SD Physical Layer
> Specification v1.10. I agree that NWR has a minimum of one byte (8 clock
> cycles), which means my zero-gap test case does not establish a
> protocol-compliant host sequence.
>
> The other observation about matching the write tokens to CMD24/CMD25 and
> handling the CMD25 data response is also valid.
>
> Before sending another revision, I will investigate the guest-side SPI
> sequence and check whether the issue can be reproduced with the required
> NWR interval.
>
> I will also check whether the firmware is accounting for this delay or
> whether the problem is caused by the interaction with QEMU's response
> handling.
>
> I won't submit a v3 until I can demonstrate a protocol-compliant
> reproducer.
>
> Thanks again for the careful review.
>
> Best regards,
> Manuele
>
> Il giorno mer 4 nov 2026 alle ore 15:25 Philippe Mathieu-Daud=C3=A9 <
> philmd@oss.qualcomm.com> ha scritto:
>
>> Please keep Bin in Cc (as maintainer)
>>
>> $ ./scripts/get_maintainer.pl -f hw/sd/ssi-sd.c
>> "Philippe Mathieu-Daud=C3=A9" <philmd@oss.qualcomm.com> (odd fixer:SD (S=
ecure
>> Card), gitlab:@philmd)
>> Bin Meng <bmeng.cn@gmail.com> (odd fixer:SD (Secure Card), gitlab:@lbmen=
g
>> )
>>
>> On 4/11/26 13:31, Manuele Conti wrote:
>> > When a write start token immediately follows the R1 response,
>> > the SPI SD controller may still be in SSI_SD_RESPONSE state
>> > and discard the token.
>> >
>> > Recognize single-block and multi-block write start tokens
>> > when the SD card is ready to receive data, allowing the
>> > write operation to proceed without an additional dummy byte.
>> >
>> > Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
>> > ---
>> > Hi Philippe,
>> >
>> > Thanks for your feedback.
>> >
>> > I encountered this issue while running a bare-metal STM32F4 firmware
>> under QEMU, using SPI mode to communicate with an SD card.
>> >
>> > The firmware performs a block write (CMD24) and sends the data start
>> token (0xFE) immediately after receiving the R1 response, without an
>> additional dummy byte.
>> >
>> > In this case, the SSI SD controller is still in SSI_SD_RESPONSE state
>> and discards the token, causing the subsequent write operation to fail.
>> >
>> > I've now added a regression test to reproduce this behavior without
>> requiring the original firmware.
>>
>> Wow, that was fast! I suppose you already had that qtest written
>> locally, if so next time better share along with a fix.
>>
>> Looking at older spec v1.10 I found section 7.5.4 "Timing Values" and
>> Figure 56 "Write operation - bus timing". The table gives NWR (between
>> the write command response and the data block) a minimum of 1, in
>> units of 8 clock cycles (so at least one byte). If that reading is
>> right, a host sending 0xFE in the very next byte after R1 is outside
>> the card timing, and the model dropping it is not obviously a bug.
>>
>> You described the model but not the guest, what firmware / drivers
>> it uses. Does your firmware work on real HW -- and if so what is the
>> SD card being used --? Does the FW intentionally send the token with
>> no gap, or does it poll/read a byte after the command response that
>> our SPI controller model hides or reorders?
>>
>> Thanks,
>>
>> Phil.
>>
>> > The test exercises the immediate write-token sequence and verifies tha=
t
>> the controller correctly transitions to the data-write state.
>> >
>> > I'll submit an updated patch including the regression test so the issu=
e
>> can be reproduced and verified independently.
>> >
>> > Best regards,
>> > Manuele
>> >
>> >   hw/sd/ssi-sd.c                        |   6 +
>> >   tests/qtest/ssi-sd-token-local-test.c | 165 ++++++++++++++++++++++++=
++
>> >   2 files changed, 171 insertions(+)
>> >   create mode 100644 tests/qtest/ssi-sd-token-local-test.c
>>
>>

--000000000000be14e9065f79b6a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"caret-color: rgb(255, 255, 255);"><font color=
=3D"#000000">Hi Philippe, Bin,</font></p><p style=3D"caret-color: rgb(255, =
255, 255);"><font color=3D"#000000">I&#39;ve completed the investigation us=
ing the unchanged STM32F4 firmware ELF.</font></p><p style=3D"caret-color: =
rgb(255, 255, 255);"><font color=3D"#000000">You were right about the NWR t=
iming. The SPI trace confirms that the firmware sends 0xFE immediately afte=
r R1, without the required clock interval.</font></p><p style=3D"caret-colo=
r: rgb(255, 255, 255);"><font color=3D"#000000">Therefore, the proposed pat=
ch is a workaround for the guest behavior rather than a QEMU bug fix. I won=
&#39;t pursue it upstream.</font></p><p style=3D"caret-color: rgb(255, 255,=
 255);"><font color=3D"#000000">However, the investigation also revealed a =
separate QEMU regression in SPI mode.</font></p><p style=3D"caret-color: rg=
b(255, 255, 255);"><font color=3D"#000000">After ACMD41, the card remains i=
n sd_ready_state, but CMD16 requires sd_transfer_state. This causes CMD16 t=
o fail and the subsequent CMD9 to return R1 =3D 0x04 (ILLEGAL_COMMAND).</fo=
nt></p><p style=3D"caret-color: rgb(255, 255, 255);"><font color=3D"#000000=
">I traced this behavior back to changes introduced in QEMU 10.1.0. Restori=
ng the SPI transition to sd_transfer_state after ACMD41 fixes the initializ=
ation failure with the unchanged firmware.</font></p><p style=3D"caret-colo=
r: rgb(255, 255, 255);"><font color=3D"#000000">I&#39;ll address the CMD16/=
ACMD41 issue separately.</font></p><p style=3D"caret-color: rgb(255, 255, 2=
55);"><font color=3D"#000000">Thanks again for your helpful feedback.</font=
></p><p style=3D"caret-color: rgb(255, 255, 255);"><font color=3D"#000000">=
Best regards,<br>Manuele</font></p></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno mer 4 no=
v 2026 alle ore 21:21 Manuele Conti &lt;<a href=3D"mailto:conti.manuele@gma=
il.com">conti.manuele@gmail.com</a>&gt; ha scritto:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><p><font color=3D"#000=
000">Hi Philippe, Bin,</font></p><p><font color=3D"#000000">Thank you for t=
he detailed review and for pointing out the NWR timing requirement.</font><=
/p><p><font color=3D"#000000">I checked section 7.5.4 and Figure 56 of the =
SD Physical Layer Specification v1.10. I agree that NWR has a minimum of on=
e byte (8 clock cycles), which means my zero-gap test case does not establi=
sh a protocol-compliant host sequence.</font></p><p><font color=3D"#000000"=
>The other observation about matching the write tokens to CMD24/CMD25 and h=
andling the CMD25 data response is also valid.</font></p><p><font color=3D"=
#000000">Before sending another revision, I will investigate the guest-side=
 SPI sequence and check whether the issue can be reproduced with the requir=
ed NWR interval.</font></p><p><font color=3D"#000000">I will also check whe=
ther the firmware is accounting for this delay or whether the problem is ca=
used by the interaction with QEMU&#39;s response handling.</font></p><p><fo=
nt color=3D"#000000">I won&#39;t submit a v3 until I can demonstrate a prot=
ocol-compliant reproducer.</font></p><p><font color=3D"#000000">Thanks agai=
n for the careful review.</font></p><p><font color=3D"#000000">Best regards=
,<br>Manuele</font></p></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">Il giorno mer 4 nov 2026 alle ore 15:25 Philippe Mat=
hieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com" target=3D"_b=
lank">philmd@oss.qualcomm.com</a>&gt; ha scritto:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Please keep Bin in Cc (as maintainer)<br>
<br>
$ ./scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer" target=
=3D"_blank">get_maintainer.pl</a> -f hw/sd/ssi-sd.c<br>
&quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"mailto:philmd@oss.qu=
alcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt; (odd fixer:SD=
 (Secure <br>
Card), gitlab:@philmd)<br>
Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gmail.com" target=3D"_blank">bmeng.=
cn@gmail.com</a>&gt; (odd fixer:SD (Secure Card), gitlab:@lbmeng)<br>
<br>
On 4/11/26 13:31, Manuele Conti wrote:<br>
&gt; When a write start token immediately follows the R1 response,<br>
&gt; the SPI SD controller may still be in SSI_SD_RESPONSE state<br>
&gt; and discard the token.<br>
&gt; <br>
&gt; Recognize single-block and multi-block write start tokens<br>
&gt; when the SD card is ready to receive data, allowing the<br>
&gt; write operation to proceed without an additional dummy byte.<br>
&gt; <br>
&gt; Signed-off-by: Manuele Conti &lt;<a href=3D"mailto:conti.manuele@gmail=
.com" target=3D"_blank">conti.manuele@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; Thanks for your feedback.<br>
&gt; <br>
&gt; I encountered this issue while running a bare-metal STM32F4 firmware u=
nder QEMU, using SPI mode to communicate with an SD card.<br>
&gt; <br>
&gt; The firmware performs a block write (CMD24) and sends the data start t=
oken (0xFE) immediately after receiving the R1 response, without an additio=
nal dummy byte.<br>
&gt; <br>
&gt; In this case, the SSI SD controller is still in SSI_SD_RESPONSE state =
and discards the token, causing the subsequent write operation to fail.<br>
&gt; <br>
&gt; I&#39;ve now added a regression test to reproduce this behavior withou=
t requiring the original firmware.<br>
<br>
Wow, that was fast! I suppose you already had that qtest written<br>
locally, if so next time better share along with a fix.<br>
<br>
Looking at older spec v1.10 I found section 7.5.4 &quot;Timing Values&quot;=
 and<br>
Figure 56 &quot;Write operation - bus timing&quot;. The table gives NWR (be=
tween<br>
the write command response and the data block) a minimum of 1, in<br>
units of 8 clock cycles (so at least one byte). If that reading is<br>
right, a host sending 0xFE in the very next byte after R1 is outside<br>
the card timing, and the model dropping it is not obviously a bug.<br>
<br>
You described the model but not the guest, what firmware / drivers<br>
it uses. Does your firmware work on real HW -- and if so what is the<br>
SD card being used --? Does the FW intentionally send the token with<br>
no gap, or does it poll/read a byte after the command response that<br>
our SPI controller model hides or reorders?<br>
<br>
Thanks,<br>
<br>
Phil.<br>
<br>
&gt; The test exercises the immediate write-token sequence and verifies tha=
t the controller correctly transitions to the data-write state.<br>
&gt; <br>
&gt; I&#39;ll submit an updated patch including the regression test so the =
issue can be reproduced and verified independently.<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Manuele<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/sd/ssi-sd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 =C2=A0tests/qtest/ssi-sd-token-local-test.c | 165 ++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 171 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/qtest/ssi-sd-token-local-test.c<b=
r>
<br>
</blockquote></div>
</blockquote></div>

--000000000000be14e9065f79b6a2--

