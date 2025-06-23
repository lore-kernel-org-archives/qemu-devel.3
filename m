Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11109C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 19:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTmcW-0005rY-Ch; Mon, 23 Jun 2025 15:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTmcR-0005qS-U7
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:14:16 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTmcP-0005ZT-6s
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:14:15 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6097b404f58so8250204a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750706051; x=1751310851; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfTP6Pxc2LTi7dNCqHTyrs2OuMzLO6Tl0OLgRBNknQM=;
 b=GOOB0FrBrVA+35AQyLaq3rwrs7JOqplbxoglUXctsab5rIB1vT+QbAfWSPltfWr7W+
 JZ76LzeIGG+OalR7I41fAG/qvfyWKj8k68l700gZwUrZLFT5n1QQD0BQlYUveUGe7Kmb
 2xPzVJZHik+UPo77QYg7qZs4SWeX4N663mMoInnHRHT4d+854etvW9Vjxy6E4GYzr2um
 JFzeQEAKmj+BGyt4SW5uyfs0uacoUYwfY4NFBS9BRp3zR8mBq3ODWLT+Z+zdBI1oEvvE
 J+ODJ+mQlbOMsghxPUKHMjc+7/pF6B/piyCqKrRiXtaGYvbo2wyBRvpgfCONlT5bCUlU
 dHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750706051; x=1751310851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfTP6Pxc2LTi7dNCqHTyrs2OuMzLO6Tl0OLgRBNknQM=;
 b=IIOhuWpHGSFa0+l6qH93eEJtHgr8OiG8Xqsh7Pr0jbIWpJgiUVWXcC/VbzPCLiN6Y1
 HfcELFJCnOBix6boyJcesoVKX//ls6Y6NaHLQnhuCydRHrNbJQL97Lxuh8L6ehyHnIfr
 hhFsfBX6l1bXvj6K7hVaFC2Q74Y7S6zvD4TkV0T7sE9NQj4jmBev+bzqk9RcfGdQTYuO
 ukW+qo0S68w/pa58TW0oILMgXcuq7WTMtIhwpALuEN67H4ItQhIjdPbZc6v6xbg4Aem9
 gpQ4MXy3rxl/mkaAbUS168sG4jRV2oHmNCJuYsWupzvPPY32em6DVTFpxdLry0VZFrkh
 IEVw==
X-Gm-Message-State: AOJu0YwnwquP8UCgZkpgN0WLpNuJQoHdSwiZZW/3hsNolMQYfA/WIFUt
 pT2Eeau037oYT6kVGCeiU3LRkwHvgZMe9K/gWBR6sP/JqKkNb8+aczmrVqccSWODsqCsabddm+I
 Vh+aUAngzV5WuuNt+SkwJFlzsEnB8G7321w==
X-Gm-Gg: ASbGncu40FxShNVGlH8D83kuI0qM/R5190hO9dxOQ4GPyf5esCmGcOsvFyXKvd8JU/e
 j8yXgn63YOyE0CGgSoqeN7ni6Xs/rKgO2X7uqUAprQ00YhHiNjjktE/xndatBk8jUlaN95vB2X9
 KJHHzghcpJPjQIcODO7jfZnKxDGD9kJMWb2GkQZBuV6C/TI2HRIrnJ
X-Google-Smtp-Source: AGHT+IFE3th4+MC9+hIUK+s89d7U9KUfztc+mtBq5Kw3FWl2iDxnzsO47inTD6yFnqIl95LsPeFlmoc1Bf+JPa5/iTs=
X-Received: by 2002:a05:6402:348e:b0:60c:1a20:1cc with SMTP id
 4fb4d7f45d1cf-60c1a200860mr559621a12.27.1750706050751; Mon, 23 Jun 2025
 12:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250619082817.1517996-1-gaosong@loongson.cn>
 <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
 <b9f57a29-b13b-cd94-dc92-bc9ea45cc077@loongson.cn>
 <CAJSP0QXGg9_hcdNVJ4LyVNB8ujFSX5jMfYSwbsfX2xQ2XAJdCw@mail.gmail.com>
 <79e720ca-ef28-c7cd-9226-00f9264da81e@loongson.cn>
In-Reply-To: <79e720ca-ef28-c7cd-9226-00f9264da81e@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 23 Jun 2025 15:13:58 -0400
X-Gm-Features: AX0GCFupWVtqhJRRExfNDOTeMzRUrBztQoHAUdaecTbcikyPPET9rug03PP9pgM
Message-ID: <CAJSP0QUhCHqEReRw7SJ=L+YQ8UJW6P9WhPoPwg-QhY5w2R=4cQ@mail.gmail.com>
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 22, 2025 at 10:39=E2=80=AFPM gaosong <gaosong@loongson.cn> wrot=
e:
>
> =E5=9C=A8 2025/6/21 =E4=B8=8A=E5=8D=882:12, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Thu, Jun 19, 2025 at 11:11=E2=80=AFPM gaosong <gaosong@loongson.cn> =
wrote:
> >> =E5=9C=A8 2025/6/20 =E4=B8=8A=E5=8D=884:39, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> >>> gpg:                using RSA key CA473C44D6A09C189A193FCD452B96852B2=
68216
> >>> gpg: Can't check signature: No public key
> >>>
> >>> Why has the GPG key changed? Your previous pull request was signed
> >>> with key B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF.
> >>>
> >>> If you would like to change keys, please sign your new key using your
> >>> old key and upload the new key to the key servers again. That way I
> >>> know that the new key really belongs to you.
> >> Hi, Stefan
> >>
> >> I had  sign  new key using old key and send to the key server again
> >> should I need pull again?
> > Thanks!
> >
> > The pull request does not need to be resent.
> but I find the pull  key not sign wi/th the  old key. /
> > I wasn't able to fetch your new key with the signature from the
> > keyservers though. Did you `gpg --send-keys 0x452B96852B268216`?
> yes,  and I send it and tested recv the key
>
> gpg --keyserver hkp://keys.openpgp.org --search-keys 0x452B96852B268216
> gpg: data source:http://keys.openpgp.org:11371  <http://keys.openpgp.org:=
11371/>
> (1)     Song Gao <gaosong@loongson.cn>
>           1024 bit RSA key 452B96852B268216, created: 2022-09-16
> Keys 1-1 of 1 for "0x452B96852B268216".  Enter number(s), N)ext, or Q)uit=
 > s
> gaosong@loongson-pc:~$ gpg --recv-keys 0x452B96852B268216
> gpg: key 452B96852B268216: "Song Gao <gaosong@loongson.cn>" not changed
> gpg: Total number processed: 1
> gpg:              unchanged: 1
>
> > Alternatively, you could attach your new signed gpg key and send it as
> > an email attachment.
>
> Attached is the key I exported

For some reason I still don't see the signature when receiving the key
from hkp://keys.openpgp.org/, but your email attachment worked.
Thanks!

Stefan

>
> Thanks.
> Song Gao
>
> > Stefan
> >
> >> Thanks.
> >> Song Gao
> >>
> >> gpg --list-signatures
> >> /home/gaosong/.gnupg/pubring.kbx
> >> --------------------------------Attached is the key I exported
> >> pub   rsa1024 2022-09-16 [SC]
> >>         B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF
> >> uid           [ =E6=9C=AA=E7=9F=A5 ] Song Gao <m17746591750@163.com>
> >> sig 3        40A2FFF239263EDF 2022-09-16  Song Gao <m17746591750@163.c=
om>
> >> sig          452B96852B268216 2025-06-20  Song Gao <gaosong@loongson.c=
n>
> >>
> >> pub   rsa1024 2022-09-16 [SC]
> >>         CA473C44D6A09C189A193FCD452B96852B268216
> >> uid           [ =E6=9C=AA=E7=9F=A5 ] Song Gao <gaosong@loongson.cn>
> >> sig 3        452B96852B268216 2022-09-16  Song Gao <gaosong@loongson.c=
n>
> >> sig          40A2FFF239263EDF 2025-06-20  Song Gao <m17746591750@163.c=
om>
> >>
> >>
> >> gpg --send-keys CA473C44D6A09C189A193FCD452B96852B268216
> >> gpg: =E6=AD=A3=E5=9C=A8=E5=8F=91=E9=80=81=E5=AF=86=E9=92=A5 452B96852B=
268216 =E5=88=B0 hkps://keys.openpgp.org
> >> gpg --recv-keys CA473C44D6A09C189A193FCD452B96852B268216
> >> gpg: =E5=AF=86=E9=92=A5 452B96852B268216=EF=BC=9A=E2=80=9CSong Gao <ga=
osong@loongson.cn>=E2=80=9D =E6=9C=AA=E6=94=B9=E5=8F=98
> >> gpg: =E5=A4=84=E7=90=86=E7=9A=84=E6=80=BB=E6=95=B0=EF=BC=9A1
> >> gpg:              =E6=9C=AA=E6=94=B9=E5=8F=98=EF=BC=9A1
> >>
> >>
> >>
>

