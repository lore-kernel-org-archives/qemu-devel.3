Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=frqPUu6m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnxG-0004QA-BX; Tue, 24 Nov 2026 05:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnxB-0004PS-KR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:40:49 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnx9-00015j-QZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:40:49 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67da7d18f2fso4902448d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:40:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795516846; cv=none;
 d=google.com; s=arc-20260327;
 b=S98wz0EmBrlTYijAAAeiT4ncWG3BNml7c8Wr2qEZuNuMbgQnlUOL4sxX60s4R6BTnD
 JNwDWSnvzXTE2wuMHO+eI1GML0naIt1W3EWlgDMDV8Xkgn5Jb5Qkq8eRPJU0GwZQ5WGT
 Av80j/wSsj+lfu5SVOh9QRkK3BDgOHJ6k3wiUhSqQNuR3lClmsYqXM3fdldYhl/r85ym
 hr92WL0Rh1j21v2TJbDEy9ypvUm+MA0dt2I2nAIO9mekMjLZyn/IodplZ9tyhc5bYEk2
 7cIZqfuk9GRnxGOVaI/NzUXcwX9xIs1ql4KaBEc04GJa9sVi3CLqq6IsIkXJk2vIrlkx
 4hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EFuwYvEYSsINZDclvRW4Uqg7aHkv+AHDdxLIg+FxQxQ=;
 fh=rh7+eygl3oD7YpqbjveebHdCZpX3Tl2dB611KSoMP5E=;
 b=YuDzOfX09BWb7BGn5y6x7NhjZWtQJVW27o3CJ/hMro2iLHFklpLAzicVzax0k53tkP
 vnLOpo7bNPFehiDGWpVUZv5n/lGNPTWh8Aoe0gradUdQo31R7SU9HezjzC5Q42y1ZOJV
 ZlggEKf6sjfG7mg33qg0EJ05frmkK0mgCYyodEbtvZ4DXE/o9x3SP/A7PYrXzu3RNSMd
 igG2GzArpnEmEpr8RKg0oMYYmBs44VGAXAZje9g7TqRGU7EnpGjuycAPTXE4EGNmfPVR
 Qigup0lgJaMlXTVEvjbZPrjbZYOqdq8rOo1YcX6YLXcoP/JKSxAA8qonnmORprZ5njgR
 E3Bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795516846; x=1796121646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EFuwYvEYSsINZDclvRW4Uqg7aHkv+AHDdxLIg+FxQxQ=;
 b=frqPUu6m+hg9wvwPAMk6RqUJZZcmOIqa7b5NSfl2jqZ3rE/RHx3W1n4JH+5Vrfvjss
 HcJ9XfLTixLoLwA7ykE+airgNpH6N5swssHQiRDXFhZhdC+BzSazcOXyyEaU0JCu92FD
 9LhBgJgaoSyFr3tKKAx091ZF1PNyHK33T+nZeZC6DSbauheupXWod4dqKnd0706MAzuX
 CItsY88/2adByZs8LsZ23tUD5lYrlY+Bxiuk96O5L9J5dAzs0QMhmnrfRbbPGKzgqZ33
 dz4uh7O8+MtdhLjS0OsxfVbvI8awdKAhGLDmBcM3gGmkPkGLuKv2ESxmTLWzUYxEMD71
 4ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795516846; x=1796121646;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EFuwYvEYSsINZDclvRW4Uqg7aHkv+AHDdxLIg+FxQxQ=;
 b=vUXBsd0yc5FHfEznDS1bdd+V64YP9WkbC+HMStUutyzhjlwOdfNA4DHHXfLMa9wdWX
 Fk5rbIiSiML7HmBWV4fzGUbaIT5siZrntIcReUIe9A9JnuFZlBuqse7Xy91sv0L0p2Ky
 VTMeONAO3Mw+pOmn+W4zkMZD6lgCVVeJ7khsIGnh3b5SH0uzFK9rTpONvn+gjVDd+U5e
 qG0WE48Q1hvlFyZUuVGkhiS6GqF1KyHyrRqowtpF6dQjgzWAxUeQHYwezfUneGZrAiEl
 A0czhpVxp4dsQzD9nElWyFgeYXNRg1S7rwubdOkUEdSyXa3fhVoNouB4jI6pKvqvSpTL
 Uytg==
X-Forwarded-Encrypted: i=1;
 AL+hErEBlxq4a2PqAuShfz4MJZy/c2tnjbLLcYIvScbWlcmadvEBjmllqYPXxG15TGotT8h/1QaRWNkrm3rb@nongnu.org
X-Gm-Message-State: APuU4Z/u74Q3QHaij7TRwuEuWu6oe2qI7+Nwtz4Y9qNoty4QOuWbe8V4
 d0PLVTTJ+QxAwHdev/rUe3iPoRm07XaI0ePtwQhQ40ADHI6+hmZcANuYur35xBZ/giEaAJ5MbsO
 ppCG7BAXBQoEmuHOC9ESCEaStagiWPfGyk6eaRX9Y4A==
X-Gm-Gg: AZFdTZdfBfEzNf5kdXe71v9iCibkjjfxi6c0TXShqnxQtsbOea7MFjCZ7PweLWHDIgH
 dOrijjdESfAIALRW4zK2hXAdJsNd0+DqBWgOi/iOfnCHt+eJNynGZxm6J+Z/vw+C6CiMLVAxc6K
 xxe4D1xaHzOOTaBkSRsflPgsA1rwaHRu2Zd9MJEgPKGFrK3vGpcV5ZbkuMaFyDOiWaqem6SRCYT
 CSXhHJhoxoYZoj6H2p0UMvUYzw50LusTpkpYiRG0fx+waqFKNVmsbzi3dib1SEX5SSIxufpKBVw
 MgSfi8lO9GbME+UWm+NEteNvyzZm4GN/gnsxgSddxWKrvwuWi4Jb1gwOn5doTsk2m+N55Oe34Or
 v4qhluyDFR/whJXWDOXfeDsfjLEZtTjc66V3/NfKc+U2lbiqNFtlvSPYOcH2hgc7/jZahgDJm5z
 /4ovyaCSrFrhbLYWmPqjlr
X-Received: by 2002:a05:690e:1241:b0:67d:ac2d:d81a with SMTP id
 956f58d0204a3-67dec50bcf3mr6351225d50.52.1795516846290; Tue, 24 Nov 2026
 02:40:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
 <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
 <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
 <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
In-Reply-To: <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 10:40:34 +0000
X-Gm-Features: Aa3M54qwtc9nGOU2i9gywqOyABxwd3NetD5-2njxpFfOzgz_Iw4X88nIrb1GD1s
Message-ID: <CAFEAcA-dFzpiYDmphruEwdrvQt1xwtn-BVG1W_7OQU+hiccaSA@mail.gmail.com>
Subject: Re: [PReP] Maintainer status check for PReP machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@pond.sub.org>,
 Utkarsh Verma <uverma@linux.ibm.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <huth@tuxfamily.org>, 
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Helge Deller <deller@gmx.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Chinmay Rath <rathc@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 10:37, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 24/11/26 11:19, Peter Maydell wrote:
> > On Tue, 24 Nov 2026 at 10:06, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >> I'm probably missing the point here, I'd rather look to help maintaini=
ng
> >> unmaintained / broken subsystems. Why care about a well working area a=
nd
> >> ask the maintainer to step down? Why not ask the same to ARM / RISCV /
> >> X86 maintainers? What is the underlying problem?
> >
> > The underlying problem is that it gives a misleading view of
> > whether something's actually maintained if you look at
> > MAINTAINERS and there's an "S: Maintained" label but in fact
> > that person hasn't been actively involved with the project
> > for years and is probably not reading their qemu-devel email.
> > If the real situation on the ground is "effectively this is
> > Orphan and patches for it are unlikely to get review" then I
> > think it's better to have MAINTAINERS say so.
> >
> > This is why at the beginning of the year I did a run through the
> > MAINTAINERS file to look for "stale" entries and query whether
> > the people listed still wished to be listed. (It was about 50:50
> > whether they said "yeah, it would be better to not list me" versus
> > "I do still want to be listed".)
>
> Hmm. Utkarsh should have mentioned that context first, hard to
> otherwise guess.
>
> Are we trying to address a 3rd class of your survey, people who
> didn't even replied?

No. People who didn't reply I treated as not wanting to be listed.

> > I don't view this as "kicking out maintainers" but rather trying
> > to make our maintainer docs match reality: if anybody I contacted
> > in my run through the MAINTAINERS file requested to retain their
> > listing I did so.
> >
> > We can discuss whether it's better to do this as a coordinated
> > process over the whole file versus single subsystems and who
> > is best placed to be sending out the queries and whether that
> > works better as private email vs cc to qemu-devel, but I think
> > the general principle is right: many people who drift away from
> > the project do not actively send us a MAINTAINERS update and
> > so we do have to do a little active housekeeping on it from
> > time to time.
>
> Since you sent the survey, I'd expect you to send the finalMAINTAINERS
> update.

I did; see commit 250c9de78044 and preceding ones from back in April.

thanks
-- PMM

