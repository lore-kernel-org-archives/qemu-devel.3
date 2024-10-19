Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F8DD3E1BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 07:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t248x-0004a2-0U; Sat, 19 Oct 2024 03:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t248v-0004ZQ-1H
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:44:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t248t-0006XW-HN
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:44:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e56df894d4so1039944a91.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729323894; x=1729928694; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKGSxQH5ULr4e+aetQYRdQv7SYmv6bDHR0TMuRl2C5E=;
 b=BrouAZ1ZI04RyYEaXv4yA2KDvIT2ywAaDs5bc0q8TxSt9yOICBS6O7ICmP+UO2D6IE
 /omcbXkKkGpPSTRBvxwkkkKpcgAIyDScJWiNUYkmL8t4ilTfMZgTAK8DiX5bUeX0lHud
 hLVz/dDmTk63ZcgYBkLd48PusD0tul7WWVhR1blB8zZ3l+U+ompOao5mHibnahJowN/q
 BqFETw/ARZXCBkp7TyKraEonI/419nhR9Yp+BMT7lpctLglgujhRTXwfdmEs5Uz4Ot76
 mF3GX3IeoPgK0X+jvGUtNChcM3QPVGbNZCvLDHGqAxdj3HKAK90RUwCh1u84lPjvvLC8
 2gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729323894; x=1729928694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKGSxQH5ULr4e+aetQYRdQv7SYmv6bDHR0TMuRl2C5E=;
 b=pbEIdbRlFk3UetHV85adhUyxAC6Dl8EcGyH062rkqr8qZnjMJWP1Y6OTkGwv0Kp+LE
 cMNgFaHRAplIZEWpnAz6Lbfwqjtz8rq5tNj6KdSq15Wy9NII+K9++lyhqiYYz7VnnusC
 iGF/xklTiw8nrgcI5u0l2df3nNxd9y6CPhBz5c9fJerYTPSkzpSUq4Rc94pLDGiH5jpA
 3mlPdVBaKMCIZWByGKW1BLH/cEdFdWjGtEK9Mo1ozjeRgf0+hdEN8Dy8+zL69lvAliZE
 u5evTIr5jO+evOWAUFwtf6RHNz7eggl6CMxV7smb/Rwda82g+fQKhLNNboodABuqoRnd
 /ARA==
X-Gm-Message-State: AOJu0YzauP97tiwTUHqwCFAq/V3P/iaXdG8NRzp+dpOO3xrJNgTae6yj
 hBnY+Sx6rKtfljwFt8DBizVRad0daXuS+V2RqdqsPDcVsFSnicV0rzSXlUY7Mbs8sBFRTX6wfoE
 7u80VWqbA01IhZvdHVCaj+oqEeAA=
X-Google-Smtp-Source: AGHT+IHiUrD4H8Kysa66zBmjWn9n8v/GGp+68UUxut6PqAMwPhRTNE2dG4j6wQ9D0vsAUnxA3FjFSU+3z6Jgfz6irEo=
X-Received: by 2002:a17:90a:e643:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2e561900bf3mr6216353a91.28.1729323894011; Sat, 19 Oct 2024
 00:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <AM9PR09MB4851159EEED6EFB71176524684402@AM9PR09MB4851.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB4851159EEED6EFB71176524684402@AM9PR09MB4851.eurprd09.prod.outlook.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Sat, 19 Oct 2024 09:44:42 +0200
Message-ID: <CAGQJe6osWkzcxx4PR4q5O_fQDop-cwHdn1gQYh4HiQs_J4TMaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000067816a0624cf980c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=arikalo@gmail.com; helo=mail-pj1-x1033.google.com
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

--00000000000067816a0624cf980c
Content-Type: text/plain; charset="UTF-8"

>
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c().
>
> Cherry-picked 4cc974938aee1588f852590509004e340c072940
> from https://github.com/MIPS/gnutools-qemu
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  target/mips/helper.h        |  2 ++
>  target/mips/meson.build     |  1 +
>  target/mips/tcg/op_helper.c | 26 ++++++++++++++++++++++++++
>  target/mips/tcg/translate.c | 37 +++++++++++++++++++++++++++++++++++++
>  target/mips/tcg/translate.h |  1 +
>  5 files changed, 67 insertions(+)
>

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

-- Aleksandar

--00000000000067816a0624cf980c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Add emulation of MIPS&#39; CRC32 (Cyclic Redundancy Chec=
k) instructions.<br>
Reuse zlib crc32() and Linux crc32c().<br>
<br>
Cherry-picked 4cc974938aee1588f852590509004e340c072940<br>
from <a href=3D"https://github.com/MIPS/gnutools-qemu" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/MIPS/gnutools-qemu</a><br>
<br>
Signed-off-by: Yongbok Kim &lt;<a href=3D"mailto:yongbok.kim@mips.com" targ=
et=3D"_blank">yongbok.kim@mips.com</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
Signed-off-by: Aleksandar Rakic &lt;<a href=3D"mailto:aleksandar.rakic@htec=
group.com" target=3D"_blank">aleksandar.rakic@htecgroup.com</a>&gt;<br>
---<br>
=C2=A0target/mips/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/mips/meson.build=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/mips/tcg/op_helper.c | 26 ++++++++++++++++++++++++++<br>
=C2=A0target/mips/tcg/translate.c | 37 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/mips/tcg/translate.h |=C2=A0 1 +<br>
=C2=A05 files changed, 67 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Aleksandar Rikalo &lt;<a href=3D"mailto:arikalo@gmail.com">ar=
ikalo@gmail.com</a>&gt;<br><br>-- Aleksandar<br><br></div></div></div>

--00000000000067816a0624cf980c--

