Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46121C83F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjglT-0000MZ-9I; Thu, 29 Aug 2024 11:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjglP-0000KI-B9
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:08:44 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjglM-00061F-Fl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:08:42 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bed05c0a2fso885242a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724944118; x=1725548918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvNuios4HApr/Y+i6mS7JZhR4zEmQ90eCTdmzt41o68=;
 b=pZQHC25U57M64mmPRiIaV2CVisB7BGsp9WN2G+RS1YzDuLOaT+x0uC/0spEYkZzb1f
 /k/3jUPBipmRrPlwk+CKphYca2FPpJzu7OOllvIr2HVrZaS4sqajwbONigbah+7DGVG4
 uhAQPlgkCG1V3TRpJmKtyxue/8fv9GgkREUmEjhNbgjk8ELYw5Y8goR7D7depTidJCuJ
 swNLG37UKKKLfNrchMkr6smR/MUZpSsinf++M1ueLpq1uX0xot5izdHJ2hcUgJp8Ktnb
 7sQhdcZy/C+dvlSMCR7Kp32pdGNViTP/85sHj5XDF232g7X6umYkMaBRfq4AC8WyJwt/
 91sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724944118; x=1725548918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvNuios4HApr/Y+i6mS7JZhR4zEmQ90eCTdmzt41o68=;
 b=SFo0y6OL8kFmoS7TL/HKPZ0b9+1GGhTgBXHJ/8enzMuD/Dq2FSrNc2qMMHkeOjObiU
 gaManatFlUHuC3EzIwg301GUfZf+CGiIzQRSNype5Qm/++HqIRbr/4PfRuP0W5x9+1Of
 P0JbtxfzYyQjOTUNhHV1kJydnruiuOb/vTwoj7MvxbZtq/vC4/ZCGnvmqMZTKzs12S32
 gZgKT2ayMDDz2+Su6K33zeCP649UW1JqEl+SULNpjaq1K8NCoskJPqecDW3q0bU7oMVG
 qmSuH0Jkf9IhQdZ+MIlH3d9xQtopwrwJJKC4k8v0RJQCgGPFTtBM0Q6DDg4xOu4+NK2X
 zV7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NadUcH2uxY8yMcnsT9ZDK8TjlgeP4HWXvpDtAk8gdluFOnHtCqlTC9Vi1T4Y2CYw/Eld5VM1kIta@nongnu.org
X-Gm-Message-State: AOJu0YxkpwyicwO4S3lMIRkbQiWJ3K/tGRr8Hz8KQfd02LomKKJq9FxJ
 RFvrL9XWevqpeaxPaLv9EcL5zG82iKCkPoUqGWIP3RMLKzPAtHHpCoqBrW1bwdyuJVQHuiILJuR
 362gObMwLnq4MErYBLTXQIHeF+VWZY8GtFS6peA==
X-Google-Smtp-Source: AGHT+IFIOtKIlQ7XhYZILKCMoMsjEKH5YMi24OAgpJjoQY6O0RTnb6+gkYJRHQvfvzSC59QXATu9/nLVRTwQdeA1Ct0=
X-Received: by 2002:a05:6402:50d2:b0:5bf:7dc:bbaa with SMTP id
 4fb4d7f45d1cf-5c21ed8e67emr3420816a12.26.1724944117992; Thu, 29 Aug 2024
 08:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
 <172493399778.162301.4960007495977124327@t14-nrb.local>
 <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
 <172493799281.162301.9447178356877601539@t14-nrb.local>
 <CAFEAcA8dk65ByV+x6A0hapL_D-52Rxwk35bgG2YMfL6bOAbcPw@mail.gmail.com>
 <172494264766.6066.36832168091845428@t14-nrb.local>
In-Reply-To: <172494264766.6066.36832168091845428@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 16:08:25 +0100
Message-ID: <CAFEAcA_8ENX+z0=G+wpQtp4mvttBQMpW3TM_D7uuT7nnWVX6EA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 29 Aug 2024 at 15:44, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Peter Maydell (2024-08-29 15:35:30)
> > On Thu, 29 Aug 2024 at 14:26, Nico Boehr <nrb@linux.ibm.com> wrote:
> > >
> > > Quoting Peter Maydell (2024-08-29 15:09:44)
> > > > Thanks. I tried this repro, but mkosi falls over almost
> > > > immediately:
> >
> > > In the meantime, looks like mkosi is trying to create an block image,=
 but
> > > that's not what it's configured to do; are you sure mkosi.conf is in =
the
> > > same directory you're calling it from?
> >
> > It is. I notice however that the manpage for mkosi
> > says that it looks for "mkosi.default", not "mkosi.conf".
> > Maybe it needs a newer mkosi than Ubuntu ships?
> > (mkosi --version says "mkosi 12".)
>
> Likely. I have mkosi 22 here.
>
> > I'll use the images C=C3=A9dric has kindly generated.
>
> Thanks, images by C=C3=A9dric look good, but I forgot to tell you that
> you need a SSH key for login too :)
>
> You could unpack image.cpio.gz, add your key to root/.ssh and repack the
> whole thing to image.new.xz:
> - mkdir xtract && cd xtract
> - unxz < ../image.cpio.xz | cpio -H newc -iv
> - cp ~/.ssh/authorized_keys root/.ssh/
> - find . 2>/dev/null | cpio -o -c -R root:root | xz -9 --format=3Dlzma > =
../image.new.xz

Thanks, I was just wondering how to get the ssh key into there.

I found I needed ...  cpio -H newc -o -R root:root | xz -9 -C crc32
when creating the new image, otherwise the kernel doesn't
like the format. (Also since I'm not root I needed to
sprinkle in some sudo invocations.)

-- PMM

