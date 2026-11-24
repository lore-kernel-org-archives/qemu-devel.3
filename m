Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF514606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w8V/GfEf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVof4-0007sm-Tq; Tue, 24 Nov 2026 06:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVof2-0007sb-Rj
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:26:08 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVof0-0003bE-Uw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:26:08 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67da7d18f2fso4947657d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:26:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795519566; cv=none;
 d=google.com; s=arc-20260327;
 b=XxkMm/MZeKobHPTG+iYi14AGAiUgvCcakgUkZ+YjX4Vle+MKuHFB6LvgxhCpEJHgpO
 Tlscmffz1PJKl/q3qjvaGa/Dk2hn4TucmOvyytP0AaiaMPhoGLD0asD8qKAx3h9WJ7+4
 +qOmJJs8yVXddacBrrl6QaYs2qzx/Z/HP8zOIU4huC1KGZMlQuxAGz4Ax6NbhEU+JCoo
 U8sffYEiH1aigNx7GMLSWTJY6LPJR5Dvf1xquO0uIU02mzgPIF3GAui/cBzE2pDrArUa
 bMVTWiYke7DvByiZ6osJQ4qAkwrlkncqSHYcSqJAhCtb8Ap990yOm3R0iKb1YFYCTcOk
 dMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GWXunI8k46mfE3OZAz+eEJFeBhom7X3Z+4anDyaJbH8=;
 fh=xafnnP1oUcGC69geXJmsBseOA75j7wiEWX3Cjjd3E7I=;
 b=WG4oVdRDcPpRNbnadgXhyFq+/OvSRZ31RLH+8il4RGU5Zv92BkUhWVVi6Zv121Klpj
 dqJ/eZ8+Bazng2pSi1vrJqBopFbkGov+KFheHIHWrGO2dN7E6knfH5W7nWjewhci4kxn
 TAn1BNONJksfbg7qc9uiSjLiS8d6EkxgoJyWjKS8ZYgJCJjjSvtykBkoW0Em3grD4Agy
 Jy2jyGAvyCvCZQZY8eAFtlyz+MFw0jOMpqNciPnGp/jK2GbgeEmW9wtJoM/RF28sR5WT
 qjJ6TXIx437I2bQHiMdH/IoyXcI7KULo7yX76iOd8BrU2SCUT32XcBt5bHMCp7Zi1fIv
 dw9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795519566; x=1796124366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GWXunI8k46mfE3OZAz+eEJFeBhom7X3Z+4anDyaJbH8=;
 b=w8V/GfEf82HkuW9R824+fLiwa6YBuquETFVUMShDfSbnPK9NwYMOtyRjUm/AjGxJ3y
 gPhxBFDb9lIwNtnmzZ/Go8FifkJOQ2ykDqo+7cthOJWU5vGl6WCjPJVRJWWgQZFbKKYO
 GCsYEO7qkbs15DIhowucnoWxRl/hlJmTqRxiocsMDpdbiy6gtp6GLQghtxUNF2R7smgw
 d+LI9NUybhuu2M+XllkzRlfJT9Y3AQMx2peF0/33p/Uk4whElr5U61igDc1M1nObdqns
 15fPhLlkes0L/HBO2EQhy3//bkQWCdBCGViFH7FRPZvJ73pxHP8qJ2M8rQLxrlXkEGLX
 kiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795519566; x=1796124366;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GWXunI8k46mfE3OZAz+eEJFeBhom7X3Z+4anDyaJbH8=;
 b=2UGSgs8aDnJp4FPtuMBO3JCt9AJyMhjgcr9E3gG8bA8Br9YP826UBkNlVYOa/US3Ih
 MiYa7LWq1GYtzmtbfnfE5ouQLilEo/XvMCIPJrXT16JQ8hWjeEMij5fkqs6ZBi6H0Z/p
 35klr9pKHJuekEuOjkAbVrEs/QB1O3DF+6ROWsyBpzEi448fVVceoxD9NUUGoW0B/kcv
 Ld6rbveOmU32wbmpdA5OocJamuDQwegesbpUv2WD6bgqgJBBCOXCoFPZwTjmeq1j6+6B
 CdCvScLuLQUskxvaVxhJ0aqJzwCmEuoYdbWw0tmLrZ33iZkEhplyqJPncXuc9UBg9eGk
 3QfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFG3D9815tDSVg0rTWJFCAMzyxroecnrCorPvBzWg6wGAjAOsCuO/cxxmbcL4zx3byaiRso5PqUb6VL@nongnu.org
X-Gm-Message-State: APuU4Z8U91mX3jgX50IV1etO9LsQCbfejZpAXZZeKhlJKg4LFy8uEzSA
 xRXpOxu46QsMmxLnQMqG8DAkIwJn4mGXFvulPoHtLAIn9SPwDVsZAWrbZDEtH5owX+DhLHrhF6o
 4sI2oPM+ObQN9mA/dEMW0k/PfVHIw/v4mMqdtWKbNSw==
X-Gm-Gg: AZFdTZeI4ufkwtUDBp0iaVcQ1ZhbU5HVd6ehzzHdP44bu+7t/c4L89dPdfS2eBslV/g
 AeOKE7hSGz42cCYHHDYbX0qBynmAmHq4rrUEuVqEt/+Mr7QRMUDz41AwPNTPQWxsmvNzqcNfDMb
 3vwCeTVGF6t5dhoFBBLxsw5o37BCgLUpidEdDaCpoajGCoV351jzRSMUhDEtlhLvUOHak+ftMAU
 7kHx7UyE/gINeV0MjqQwqWH9hdIPDZy/NjXJRDwQ6GT7qVHb/p3xSt/f2qaxueJSEOG6B6hxykS
 e0P+ZKZS9temSNKmPQ9yvoI1KNtKDvHZCqIQF/oiKpV1undaTTgEXNCZgSuylMTnbFvwxhFgbjQ
 mamXnr1IQrAThMMUO8vhha/kHhOtBqT3gs459mg5cVtFIBhPXYzSS0om+SR2v8xJ2mtuXSR6/Pf
 KxI6lXmVkI06X1VrcdSw7T
X-Received: by 2002:a05:690e:440f:b0:67c:28fa:29b5 with SMTP id
 956f58d0204a3-67df449d8bbmr3243411d50.37.1795519565710; Tue, 24 Nov 2026
 03:26:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
 <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
 <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
 <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
 <87mrqyv61x.fsf@draig.linaro.org>
In-Reply-To: <87mrqyv61x.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:25:53 +0000
X-Gm-Features: Aa3M54qolgljXsvfeCh-RGfGtJ-EitFSmODl6apvSuM69YiWGEaOyQKu5k0Ibc0
Message-ID: <CAFEAcA_qa+Aqs2aeV-Ras8NYngQ5ag0nDLByUuOKS9gveTbsWA@mail.gmail.com>
Subject: Re: [PReP] Maintainer status check for PReP machine
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@pond.sub.org>, Utkarsh Verma <uverma@linux.ibm.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 11:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>
> > On 24/11/26 11:19, Peter Maydell wrote:
> >> On Tue, 24 Nov 2026 at 10:06, Philippe Mathieu-Daud=C3=A9
> >> <philmd@oss.qualcomm.com> wrote:
> <snip>
> >> I don't view this as "kicking out maintainers" but rather trying
> >> to make our maintainer docs match reality: if anybody I contacted
> >> in my run through the MAINTAINERS file requested to retain their
> >> listing I did so.
> >> We can discuss whether it's better to do this as a coordinated
> >> process over the whole file versus single subsystems and who
> >> is best placed to be sending out the queries and whether that
> >> works better as private email vs cc to qemu-devel, but I think
> >> the general principle is right: many people who drift away from
> >> the project do not actively send us a MAINTAINERS update and
> >> so we do have to do a little active housekeeping on it from
> >> time to time.
> >
> > Since you sent the survey, I'd expect you to send the finalMAINTAINERS
> > update.
> >
> > Instead of having individual status checks, the process should
> > be automated with a script, likely running during the -rc tags.
>
> FWIW that's why I added --list-absent-maintainers-since to
> 20261120200511.822573-1-alex.bennee@linaro.org

Is that looking only at commits to the QEMU git repo? I think
that's the wrong metric, and we should do this based on
emails sent to the mailing list. That's what I did with the
scripts I used for the scan I did at the beginning of the year:

https://gitlab.com/pm215/misc-scripts/-/blob/master/check-maintainers?ref_t=
ype=3Dheads

(The script works off a local git clone of the public-inbox
archive of the mailing list.)

thanks
-- PMM

