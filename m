Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEA606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TO8ugZxy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPP2y-0006WL-Vz; Fri, 06 Nov 2026 13:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1xPP2u-0006VP-Pb
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 13:52:16 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1xPP2t-0005wi-2M
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 13:52:16 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-533202fe429so97871cf.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 10:52:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793991132; cv=none;
 d=google.com; s=arc-20260327;
 b=E59HTYYJbzB/pFA0PJlKSrKUQM+FD47jeUFu//wASWU0TAuRZq6GneNmiiiwHtFHra
 TIGbOcQp+vTbFfEDMqILPMHBd0Lfvym3xDqpjAQNKRkSk+ykfEdNI3JRVuowrmCqIfRV
 wew6AGTm5lUhGGaSzlVgeI6xplnJ3tC4AHMwkHeS/lH32jAGg2KaASynu6HXvuPAtNuf
 iP//5wGOPFbFf6o5h16G0KmibyEXmhFfinNVfXwOLklnmjjJ0FfZWAMsio4KrSfPUiWE
 K7q448uzM/7QirG8ZwGiUa8tnQQKA4Bb8qZDHAdERCd5k8pGagzh5XqSy03+K+VKVBkX
 WTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VXXQyV9M1cTPcSVctanj7RtvMiEbV7DDmFFZfiz27bw=;
 fh=SbqFKtU2evIKiTpLjKhThEm2BUO95O6s6ePtGD9foas=;
 b=fbql9Pm6hTuP9579K1ViJjReEslN05+EDZc75qWBP4c2eOIQUN2HCElVdy0i8aFbpy
 eMT5adI+2fDibHR7n+wGPaZJmdIe+ry0C/Y4xuOezDLxI/sjWiMIqtwuLTsZlJOwY+RC
 p9L0iPmvqo+QVkrn95MN+GVYNtvKgYZ0wiC/qb2kxq9QY5kYc782jxaXmDPEVg7Oejn+
 nk9bctXBfUqTLIoi85+GyyR0RJVZ82Ftk2mIEIGSD7hAumIjhNmw7VKZC5LLlLDEYijE
 NL/+SdPr9x5nTZfQwv17PhYTYEqNHjl8O/GUdtDqmZywiT2m4+Zs5ZuWsfPbKzQSPO9P
 kb/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793991132; x=1794595932; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VXXQyV9M1cTPcSVctanj7RtvMiEbV7DDmFFZfiz27bw=;
 b=TO8ugZxySpWo5pmtqST18HtzB5gJuP7BLOXiJVZTeshCFjeFF2eKgJDW98qoJCny8a
 WfJOewxNZ6CnOnTMQnjGHtmVlyMmjk+7m+v21O5V4YaIA9bTcT73Ku8lSWM1gpsgQxFZ
 ULUBI1L44AWbE55Mi1ldPbeOcQT1cOY67gai9e/D4K4JbSa/D0/6f0N5AP03uduLZo1L
 QBj6tZEW5r9/f3vls4rQTnN/6AKc6f7bDvHY4H1zCLa3JVm4+3/S+0AFDd/cLHhqIgKX
 Zi72INUCdFCuP9lrs0dg97FqPVXgJMucoG7su8rSUR0Clnk5IVy6WfLfT+oy+6VhcSqD
 khww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991132; x=1794595932;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VXXQyV9M1cTPcSVctanj7RtvMiEbV7DDmFFZfiz27bw=;
 b=Z+UwSoxbHzG56sQiuWfAtJgGyzYcO/bbXI9vvbmPjWm8uo0C+vTeEftphx9SoqO87b
 eSpL9SIz55uxLcZCS3ctH+p6IN+CZB95zVz1+gb/aubKtakem5sm6uWMiS6PeTM9td6H
 7c3VW4PASG7AxJf3jFK5Pfh8LmynJY+XKvVtU2rkj83j9GBMeEJNOjaK6c5Y7NcNSZxO
 syryAN7QpiQaOp/P8FNOWQoot0VA/qhqCZI0bnyQ7u3f1BnVIcAOIcMSGrr67/sj7Bg2
 486UU/7DHLd5um0JO5C3VSe+p66Hi31SBJeeUsEcdLJ2FHJPt1seP8In2o2coIHaFiXH
 puqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBshATY+Toef4JLFIn7pAeR6I/KgVuhI8MpMFjJml8Ei2J6RzmlESv/ZpaTMimNXYNZfZ13B3X5URV@nongnu.org
X-Gm-Message-State: APuU4Z+NDRZdfhbSqG4wy8aqbEnL7lArbTSy24gULspGBJRiibiydZJ+
 cPanavydKRslVuWeYcilLOhTemk8cA/adtqxUHMmOZUE7tyeLbeZbojFAGkIqi5XlkTCosA6k7C
 MLbyVLGZYGRiLB3DIVXmdcD2G+XjbYWK4ESiy5Um2
X-Gm-Gg: AYBFou2s1p3Ddan0RFHvIOWmqVx9AzX5LN3U9iSGDUwp1LZXUsAlwvwNk4RfrmBqgjg
 fj3y+dcy4DQ7OKIU6S+8QiCRHrpvoYsUUBsryZppVKVHBgcwL4g2JGCbF5Qsqx8ws7aNOQ0Zebs
 RvZoMle4DEar02yNXg1aZySCg/nCr3p02t7mzDbZSfJEy7vzoTziK4Hm7fPygUl9ecLWMnGubm9
 TrvBw4bx4C1mbeTkmVS4COH1icbj6yZzzXm+KZ7eXFyBG9gYnc6jYN7cQewM0fMpGf8qmJIQOZ0
 ZzLK5054Vgu+axzCpUYJUhvTZWVxxgNGrU+2Yt/JYtS0f0ptJhI1dWuEt1j/oEC5RE09cUBIMrc
 axBMAKgIlN6CBgpFt+fmc2WTKljt99IFZ5O5Nm08VTL3pgYJtvwWRgrjhFW8CfCxKWw==
X-Received: by 2002:a05:622a:261b:b0:546:92f2:7830 with SMTP id
 d75a77b69052e-54f5ddb53e0mr4482831cf.6.1793991131920; Fri, 06 Nov 2026
 10:52:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-3-philmd@oss.qualcomm.com>
 <87jymr6zc6.fsf@draig.linaro.org>
In-Reply-To: <87jymr6zc6.fsf@draig.linaro.org>
From: Hao Wu <wuhaotsh@google.com>
Date: Fri, 6 Nov 2026 10:52:00 -0800
X-Gm-Features: AclHuK9q5wox1xphTwrGgk65icFPF_MBSNTosjysXinwBG92Os4SIC9Mc8Q-vv8
Message-ID: <CAGcCb122Ye_in-uZkXNgf6_qfiRCac1+eDspYY5JnnVvM6DfDA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] tests/qtest/npcm7xx: Replace deprecated
 sprintf() with g_strdup_printf()
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000275e5c065fa01cd1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=wuhaotsh@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000275e5c065fa01cd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:02=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>
> > Replace sprintf() by safer g_strdup_printf() to fill the QOM path
> > and property names. This silences when using Apple clang 17.0.0:
> >
> >   ../tests/qtest/npcm7xx_adc-test.c:140:5: warning: 'sprintf' is
> deprecated [-Wdeprecated-declarations]
> >   ../tests/qtest/npcm7xx_adc-test.c:322:9: warning: 'sprintf' is
> deprecated [-Wdeprecated-declarations]
> >   ../tests/qtest/npcm7xx_pwm-test.c:244:5: warning: 'sprintf' is
> deprecated [-Wdeprecated-declarations]
> >   ../tests/qtest/npcm7xx_pwm-test.c:245:5: warning: 'sprintf' is
> deprecated [-Wdeprecated-declarations]
> >   ../tests/qtest/npcm7xx_pwm-test.c:255:5: warning: 'sprintf' is
> deprecated [-Wdeprecated-declarations]
> >   ../tests/qtest/npcm7xx_pwm-test.c:256:5: warning: 'sprintf' is
> deprecated [-Wdeprecated-declarations]
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
Reviewed-by: Hao Wu <wuhaotsh@google.com>

>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000275e5c065fa01cd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 5, =
2026 at 8:02=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@=
linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@oss.qualcomm.com" target=3D"_blank">philmd@oss.qualcomm.c=
om</a>&gt; writes:<br>
<br>
&gt; Replace sprintf() by safer g_strdup_printf() to fill the QOM path<br>
&gt; and property names. This silences when using Apple clang 17.0.0:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0../tests/qtest/npcm7xx_adc-test.c:140:5: warning: &#39;spr=
intf&#39; is deprecated [-Wdeprecated-declarations]<br>
&gt;=C2=A0 =C2=A0../tests/qtest/npcm7xx_adc-test.c:322:9: warning: &#39;spr=
intf&#39; is deprecated [-Wdeprecated-declarations]<br>
&gt;=C2=A0 =C2=A0../tests/qtest/npcm7xx_pwm-test.c:244:5: warning: &#39;spr=
intf&#39; is deprecated [-Wdeprecated-declarations]<br>
&gt;=C2=A0 =C2=A0../tests/qtest/npcm7xx_pwm-test.c:245:5: warning: &#39;spr=
intf&#39; is deprecated [-Wdeprecated-declarations]<br>
&gt;=C2=A0 =C2=A0../tests/qtest/npcm7xx_pwm-test.c:255:5: warning: &#39;spr=
intf&#39; is deprecated [-Wdeprecated-declarations]<br>
&gt;=C2=A0 =C2=A0../tests/qtest/npcm7xx_pwm-test.c:256:5: warning: &#39;spr=
intf&#39; is deprecated [-Wdeprecated-declarations]<br>
&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@oss.qualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockquote><div>Revi=
ewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuhaotsh@google.=
com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--000000000000275e5c065fa01cd1--

