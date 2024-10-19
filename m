Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DDD3E1BC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 07:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t24Ab-0005xv-Tf; Sat, 19 Oct 2024 03:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t24AZ-0005xD-L6
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:46:39 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t24AY-0006oj-0M
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:46:39 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso2189553a91.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729323996; x=1729928796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=amN8jQ0JuCvC6F/MWsgukBI9h+J2GlEcvQQDChKfKig=;
 b=k5GZXr5DjTKGqp+hP0JwKUPypsEupJmZ7tgoEiCD9WtAx6ekin4YnO8CFFj37diSt/
 vgcSsJ+bAPZ1FkEqWbfYR05wYZKpj+xssFUUkdZq6HvW2qCPVWIs6iF2gQpxztGG9FpG
 B2KeRjQ5eySNVAnUX0GxeqVuL3BSRsxz/ni2sw+Njcd15Q4FbfTtDpgZZe53poVEqMHB
 21TJQqDrL2YDRUDhLRSQYY1EZA1HH7qrz+BoHAAxlZMwnFHryTs5nslJYRJNTDXG7skV
 6TlfaFAXFEMJe4I6ZugoNfcl1qth50H7m7O3hBnfSMuSJ6LP8p2pn1Bv3RbRmEZoX+xr
 Yd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729323996; x=1729928796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=amN8jQ0JuCvC6F/MWsgukBI9h+J2GlEcvQQDChKfKig=;
 b=rBOiiWMHZnlgtIUpqXYNzuLIcDj/X5S8i/+nsd12rsQ1VpcAV78bK2nK+taFAB0jkI
 5mNNHmHNoS2zA0Oh0yi5Xa6ZKSxSlt/DZNvg35lbTvrmroTM4mvY3BTKpwrEOEZJX9n+
 8MbZlKgt1rZY4P0CR3qH1xCHubfhAmFtc5ucahMyhfHQ3A5Cc8YOxuGnIn0T0uW1EiMT
 AddPV8W4M6zsw+etmsMMKa1HtfYM0+chKxwIiimeWuGdYiAZp2u/sSamSBsl7ekA+D1Q
 dVA/D80nEJesYgktGaY8ZDU9A2Hld2PtmsAocX1UE3kfhsrh/Bhecjpfm1nUDgmTm0u5
 LTNw==
X-Gm-Message-State: AOJu0Yz+D5BV+tQhNCOBq3d65NdvD3SqDY7eFVFQTg5DohB8yHC8l8HV
 Jdy7XERCzCFhSWsH/03XNEsX+bxrciDhoUxbBMSKaMsustsBJblHwhP4TWJpImEseMNRMPZdWBP
 ZmVelsxqohiPOH29BIIC0byTHrYs=
X-Google-Smtp-Source: AGHT+IGDJ95oRJU+nwmnaYCHB8poSPx9TRgW0yf8Y8v8PMa5mkmWwmRbXcZ2awTaxuqcPADs/2iX2u1b+roUKvNxEG0=
X-Received: by 2002:a17:90a:4e0f:b0:2e2:e530:508d with SMTP id
 98e67ed59e1d1-2e56172bbaemr6016247a91.19.1729323996398; Sat, 19 Oct 2024
 00:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <AM9PR09MB485153B7CB706E188DED763484402@AM9PR09MB4851.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB485153B7CB706E188DED763484402@AM9PR09MB4851.eurprd09.prod.outlook.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Sat, 19 Oct 2024 09:46:25 +0200
Message-ID: <CAGQJe6rjo+Ukzk7MuwAdSpqiYuYavZeY+_Ycyjkpfoue3fJs5w@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] target/mips: Enable MSA ASE for mips32r6-generic
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000081cd170624cf9ec4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=arikalo@gmail.com; helo=mail-pj1-x1030.google.com
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

--00000000000081cd170624cf9ec4
Content-Type: text/plain; charset="UTF-8"

>
> Enable MSA ASE for mips32r6-generic CPU.
>
> Cherry-picked 0186e83a0613e90aff6d4c12c91cdb080d695d37
> from https://github.com/MIPS/gnutools-qemu
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  target/mips/cpu-defs.c.inc | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

-- Aleksandar

--00000000000081cd170624cf9ec4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Enable MSA ASE for mips32r6-generic CPU.<br>
<br>
Cherry-picked 0186e83a0613e90aff6d4c12c91cdb080d695d37<br>
from <a href=3D"https://github.com/MIPS/gnutools-qemu" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/MIPS/gnutools-qemu</a><br>
<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
Signed-off-by: Faraz Shahbazker &lt;<a href=3D"mailto:fshahbazker@wavecomp.=
com" target=3D"_blank">fshahbazker@wavecomp.com</a>&gt;<br>
Signed-off-by: Aleksandar Rakic &lt;<a href=3D"mailto:aleksandar.rakic@htec=
group.com" target=3D"_blank">aleksandar.rakic@htecgroup.com</a>&gt;<br>
---<br>
=C2=A0target/mips/cpu-defs.c.inc | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Aleksandar Rikalo &lt;<a href=3D"mailto:arikalo=
@gmail.com">arikalo@gmail.com</a>&gt;<br><br>-- Aleksandar</div><div>=C2=A0=
<br></div></div></div>

--00000000000081cd170624cf9ec4--

