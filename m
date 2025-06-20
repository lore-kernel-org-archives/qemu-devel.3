Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1023C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4Z-0000vE-1P; Fri, 20 Jun 2025 18:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uSgEY-0006Ns-0A
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 14:13:02 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uSgEW-0002Kw-AN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 14:13:01 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso3934645a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750443179; x=1751047979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q67CJf58ORykLyT/bLzexzt1GDtdjD5qmsU6LVD3Fc0=;
 b=AR6QQUD+SkrEAKCFuU9SWf8c8m5k3bnDe0ubkFW/9/lA+UOl/YdCp0wev235Lgvq5n
 Ec5dVcGAFuiANaPebSUryP+kqN2Ipo4RkvAirXW+bmCo0RU5K3fDkv7LORvxg4AtNY6B
 PdFb9GcklKDWI0ByLqkyVfLw4I/1ullnQKPpDRGO7QnQIYyVQ+KR0SGDBAgEaqA5DNM7
 1ZeGsC7Dw7qZE4/amxMZzY/w9xoJkprS6XNKlTb+6RUi+9QIWDMfggYqKjxn4k02Nk34
 qMfsxbttFGC1x5i2ygrYsUJeVXBEQvkGi2jJf77Tk3PzarFMIYoVvfxigPaRMKuOCSNJ
 4nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750443179; x=1751047979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q67CJf58ORykLyT/bLzexzt1GDtdjD5qmsU6LVD3Fc0=;
 b=SIfQzuWbyVtMhY7bsJreB8QXYd83GyxwvUnJQSPH7BtoQz21vlzViyMXzT2jjKQMrr
 hNuRTpCH9XxAp2nj8Z0crijWEKy+df165tfghWPC3kS85mfk+9VYli6bswdavfPKXaPY
 gRCzvZv2KDYUMR7kJWD1D/TWs9JlqIfOVA+OM0N6htlB9VOoQmb1FU3gWVCo88LZv9GA
 i85zJalgX9DR7ZtV3l0zFA7ppplimdHXYY5YfjPSl5EVVTif33RDNDmKjH7SyGOY3hZK
 YKiqskeefiyE7c9SP84sQdoesYiYGaPfilU+mRvhMXa8hWVEYH8f4dwT0Wo+Hi3rT/Hi
 LXYg==
X-Gm-Message-State: AOJu0Yzq7w/7jPH0IILraMCNw9qttMvNa5p95NTY1I7R/DU2MqaS5pSJ
 JgiUzJRwJg+FRa57FbmAR9Z5dvhxJT7UYgc31HPrENcK0sUL2NBkAssGBtdGH5xYHt6f423TWT/
 SWPXNSxFlLYikvxqX9tQFFEssE0qpNjYN6xPp
X-Gm-Gg: ASbGncuWSJ9o/m+iHKW6ydF24b6iz+hj5+5KTS6cw+MEspZPbf2V1JnMzJyn1wa8Fti
 PjMgbh2ijnvmPnZS4XNBRhIJ1jc/BEWhmwDnYV+FTM6N9HDAPhKpMNO58lW8HesdGg+ZqFCHBso
 VRUAxWerD4wRki1v3YAsAFoYnyEru++QcaFPcrWjL3Iw==
X-Google-Smtp-Source: AGHT+IH9b0EgaKfgKk4ySTSxFhJ+7OjqMVtsOJJ3txXd+x3YM9qcwMpiBGBSUZI86PvxdTtH8fcyemePQQHs7wiZCe8=
X-Received: by 2002:a05:6402:4315:b0:608:8204:c600 with SMTP id
 4fb4d7f45d1cf-60a1cca9c67mr3834590a12.3.1750443178333; Fri, 20 Jun 2025
 11:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250619082817.1517996-1-gaosong@loongson.cn>
 <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
 <b9f57a29-b13b-cd94-dc92-bc9ea45cc077@loongson.cn>
In-Reply-To: <b9f57a29-b13b-cd94-dc92-bc9ea45cc077@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Jun 2025 14:12:45 -0400
X-Gm-Features: AX0GCFsOZB4EhdQTfM9vLc_8Ay4P5xmNFGcnTLa4Gt_m4L6N8fopZZd3z5SVhLY
Message-ID: <CAJSP0QXGg9_hcdNVJ4LyVNB8ujFSX5jMfYSwbsfX2xQ2XAJdCw@mail.gmail.com>
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jun 19, 2025 at 11:11=E2=80=AFPM gaosong <gaosong@loongson.cn> wrot=
e:
>
> =E5=9C=A8 2025/6/20 =E4=B8=8A=E5=8D=884:39, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > gpg:                using RSA key CA473C44D6A09C189A193FCD452B96852B268=
216
> > gpg: Can't check signature: No public key
> >
> > Why has the GPG key changed? Your previous pull request was signed
> > with key B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF.
> >
> > If you would like to change keys, please sign your new key using your
> > old key and upload the new key to the key servers again. That way I
> > know that the new key really belongs to you.
> Hi, Stefan
>
> I had  sign  new key using old key and send to the key server again
> should I need pull again?

Thanks!

The pull request does not need to be resent.

I wasn't able to fetch your new key with the signature from the
keyservers though. Did you `gpg --send-keys 0x452B96852B268216`?

Alternatively, you could attach your new signed gpg key and send it as
an email attachment.

Stefan

>
> Thanks.
> Song Gao
>
> gpg --list-signatures
> /home/gaosong/.gnupg/pubring.kbx
> --------------------------------
> pub   rsa1024 2022-09-16 [SC]
>        B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF
> uid           [ =E6=9C=AA=E7=9F=A5 ] Song Gao <m17746591750@163.com>
> sig 3        40A2FFF239263EDF 2022-09-16  Song Gao <m17746591750@163.com>
> sig          452B96852B268216 2025-06-20  Song Gao <gaosong@loongson.cn>
>
> pub   rsa1024 2022-09-16 [SC]
>        CA473C44D6A09C189A193FCD452B96852B268216
> uid           [ =E6=9C=AA=E7=9F=A5 ] Song Gao <gaosong@loongson.cn>
> sig 3        452B96852B268216 2022-09-16  Song Gao <gaosong@loongson.cn>
> sig          40A2FFF239263EDF 2025-06-20  Song Gao <m17746591750@163.com>
>
>
> gpg --send-keys CA473C44D6A09C189A193FCD452B96852B268216
> gpg: =E6=AD=A3=E5=9C=A8=E5=8F=91=E9=80=81=E5=AF=86=E9=92=A5 452B96852B268=
216 =E5=88=B0 hkps://keys.openpgp.org
> gpg --recv-keys CA473C44D6A09C189A193FCD452B96852B268216
> gpg: =E5=AF=86=E9=92=A5 452B96852B268216=EF=BC=9A=E2=80=9CSong Gao <gaoso=
ng@loongson.cn>=E2=80=9D =E6=9C=AA=E6=94=B9=E5=8F=98
> gpg: =E5=A4=84=E7=90=86=E7=9A=84=E6=80=BB=E6=95=B0=EF=BC=9A1
> gpg:              =E6=9C=AA=E6=94=B9=E5=8F=98=EF=BC=9A1
>
>
>

