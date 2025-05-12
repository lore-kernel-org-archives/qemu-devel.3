Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B168C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 01:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEHv3-00076x-5a; Sun, 11 May 2025 21:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uEHv1-0006yg-CC; Sun, 11 May 2025 21:25:23 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uEHux-00066W-9t; Sun, 11 May 2025 21:25:22 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2cc57330163so3060952fac.2; 
 Sun, 11 May 2025 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747013116; x=1747617916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mipSbUnKjFgKlTzmqb2djCsFVE522tiGnyBPnwXkDDQ=;
 b=gy2bQzj7jsWrmLJ3spE7pSUc0kWNMwQzv2YtIE4ZoQ/UTgc8LTJmelZiQJFWvmEoUJ
 9HRzSk/eKGWamDPdRZInVMYXI8eLIA3mKe8s6ZmZtwtjxJaBXwfXf2Lg4b09tKQNsH+f
 QvNFRa9ZvhH06/W4vFK8oHp67g7YAYYMDX2zFcZBBhT/S7lpkNLznPJdibtRIwbZTE7M
 pfzpC5WotGwZQqr5/QpqUt9P/FahiMXYgsEyGV2a/DXXirNulTPzz8R9M+O5Yg2AVQat
 W3uma8lN8aAOBbbMfZu3IsHjlNpEn5CkrpdwbZpM29FO6syokBwA5z/OITkwzjjh04QB
 fmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747013116; x=1747617916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mipSbUnKjFgKlTzmqb2djCsFVE522tiGnyBPnwXkDDQ=;
 b=OaXCRnC/Zu/wyCngVtgrazGP/NA4VsnsB7oN5+oIweOzomH4g2WGaFXTyHK7EESNt7
 YpqmvwGYXtwmk/iArFF7qDgv71p7XfK9OxvUDliY9/Gae/PHb3ck6Lop7AyndF/e/+mY
 JrYCaKA1A/vWZTmF0eD7dZ5QbYF0RKc0RnfX3vBCsZyXQERW99PKsVcqLJYIv2tY3HqK
 IHW81ZBkRKClhzM7lT4vdEDOljYCVfc59PL5GnzTjuZyujmw4kwULRnAH80glIayagZJ
 Vb1sd5LNUSU0i0cvEE2xn2hgUsa3tAtnW0zNUKkyE8sQFnqSfKj8pVIlG6hoHC21v9b/
 NpPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvMRoFXfDQ7n4OFrpuI/sy/X21uOcXaE/7m0H+Qta4seTbsarpoqQfvTMlhm6kqf+NO1iFTnDkTA==@nongnu.org,
 AJvYcCVnCCy7j/xBamy7YDtpFJCX695lfSAXmgWbObsBUoVi0jAvAWNez8j/LUkn/gaLBx5h8wocGdlkPCJqYw==@nongnu.org
X-Gm-Message-State: AOJu0Yz+c8yKCHrrxX9cHFblrlm4SU72NXxfXFz5SMLenLIRA5mAqrFK
 IoNcY0+pY5ldFttJeWwfcNgngFg1U0In6DbM7GHrdloV1a9qHAKBY8yeP/GbHN/jachW9r1CUTc
 31MuVaiyk7/vBx69GrUo8C4vzVPU=
X-Gm-Gg: ASbGncvHbSi0xlAx+Fr8KvhlXQHq6Oc9t3lEUrGjLrQEAdxztC4MuYKi1/QSIyKqbdR
 wKtwxt1RrtrGKKOhkOGW2lCjD1o1uWl4ZfVC9PQF/vJ1MAMWe3FoWnn028VdsH9lE87rk/O620g
 CloWyCaPOwuDAnG3IBgEYAYaXuh9cOFGQaXg==
X-Google-Smtp-Source: AGHT+IFXXI9DwNDMU2prKeYa1956yFFas218te9uVF284cWzOBhElClBVtDBRCvnGlbZ7uuYc5UXLmbBL63qp6daMSg=
X-Received: by 2002:a05:6870:3911:b0:2d4:d9d6:c8bf with SMTP id
 586e51a60fabf-2dba45ad740mr6767587fac.32.1747013116380; Sun, 11 May 2025
 18:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250507091859.2507455-1-timlee660101@gmail.com>
 <CAFEAcA82=0Pp9U=W5EAjcVkR0GL_o1iVPuUPA=w2SFy4mwd_5w@mail.gmail.com>
 <CAFEAcA8qYRa+CHD+z687ATYwOBenrm_c1hg=yvVq-hzRDxMdRA@mail.gmail.com>
In-Reply-To: <CAFEAcA8qYRa+CHD+z687ATYwOBenrm_c1hg=yvVq-hzRDxMdRA@mail.gmail.com>
From: Tim Lee <timlee660101@gmail.com>
Date: Mon, 12 May 2025 09:25:05 +0800
X-Gm-Features: AX0GCFt2a2n95r6jy0aekN3RDrcQlu9MLcZMYp9cPw4b9e7RWqNRgcQOJrZ7DWg
Message-ID: <CAJG6D+g=87TT8qyHvztiLjr83Lm7oTR2qV89Pm4EfQC9zz25RQ@mail.gmail.com>
Subject: Re: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Peter Maydell <peter.maydell@linaro.org>
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=timlee660101@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Peter,
Sorry about that. When I ran this qtest and I found an error then I
tried to modify npcm_pspi driver to make data register read/write test
pass.

[R +0.080118] writew 0xf0201002 0x4
[S +0.080126] OK
[R +0.080148] readw 0xf0201002
[S +0.080153] OK 0x0000000000000004
[R +0.080168] writew 0xf0201000 0x1234
[S +0.080171] OK
[R +0.080191] readw 0xf0201000
[S +0.080194] OK 0x0000000000001234
[I +0.080445] CLOSED
ok 3 /aarch64/npcm8xx_pspi/data
# End of npcm8xx_pspi tests
# End of aarch64 tests

Here is the change diff of what I modified in npcm_pspi_write_data()
Should I submit this patch for npcm_pspi driver? I'm not sure if I
modified it correctly. Thanks for your time.

 static void npcm_pspi_write_data(NPCMPSPIState *s, uint16_t data)
 {
-    uint16_t value =3D 0;
+    uint16_t data_l, data_h =3D 0;

     if (FIELD_EX16(s->regs[R_PSPI_CTL1], PSPI_CTL1, MOD)) {
-        value =3D ssi_transfer(s->spi, extract16(data, 8, 8)) << 8;
+        data_h =3D (extract16(data, 8, 8) << 8);
+        ssi_transfer(s->spi, data_h);
     }
-    value |=3D ssi_transfer(s->spi, extract16(data, 0, 8));
-    s->regs[R_PSPI_DATA] =3D value;
+    data_l =3D extract16(data, 0, 8);
+    ssi_transfer(s->spi, data_l);
+    s->regs[R_PSPI_DATA] =3D (data_h | data_l);

Peter Maydell <peter.maydell@linaro.org> =E6=96=BC 2025=E5=B9=B45=E6=9C=881=
1=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=889:58=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Sun, 11 May 2025 at 14:47, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Wed, 7 May 2025 at 10:19, Tim Lee <timlee660101@gmail.com> wrote:
> > >
> > > - Created qtest to check initialization of registers in PSPI Module
> > > - Implemented test into Build File
> > >
> > > Tested:
> > > ./build/tests/qtest/npcm8xx-pspi_test
> > >
> > > Signed-off-by: Tim Lee <timlee660101@gmail.com>
> > > ---
> > > Changes since v1:
> > > - MAINTAINERS file not need to change
> > > - Add comment for copyright/license information
> > > - Correct CTL registers to use 16 bits
> > > - Remove printf() in test cases
> >
> >
> >
> > Applied to target-arm.next, thanks.
>
> ...but it fails "make check", so I've dropped it:
>
> not ok /aarch64/npcm8xx_pspi/data - ERROR:../../tests/qtest/npcm8xx_pspi-=
test.c:
> 80:test_data: assertion failed (output =3D=3D test): (0x00000000 =3D=3D 0=
x00001234)
> Bail out!
> ----------------------------------- stderr ------------------------------=
-----
> **
> ERROR:../../tests/qtest/npcm8xx_pspi-test.c:80:test_data: assertion faile=
d (outp
> ut =3D=3D test): (0x00000000 =3D=3D 0x00001234)
>
> (test program exited with status code -6)
>
> thanks
> -- PMM

--=20
Best regards,
Tim Lee

