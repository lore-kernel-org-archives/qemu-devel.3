Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93A0C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 14:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbiJ-0004Gy-UT; Mon, 27 May 2024 10:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sBbiG-0004Fv-QO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:52:36 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sBbiD-0004QC-Uj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:52:36 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e9684e0288so30374121fa.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716821552; x=1717426352; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v5Ahsl39CsRbv/GEH4Brs/Ud4sVcpBnuUlL6/7VQ5Q=;
 b=VBTPx/TAYtRoAGco2FltYGhlO8xoVrLzVM5WelBGFban2S1VEjfymMWJK5DuOntiU9
 9fz8694NiaJfcsmAfSc4tfBfLQHgwp1DfyjcJ4Dc0zvf9wF++DqR2ur3TvjLspBaP0Zp
 dpYZORpRzpt61oRThfRbr08coewWpJDGwBNFmWT6rqde1YOm8JoYEoNEGtZ400sJRcPM
 hSLR5Lep0wI88aAaafEun7GqLNninacYzmO8BOp7ESTPvPxFF/0qU8hDS/jbtXL1PEoH
 FYz5z6o4M3gwMGo9hy7cm2Xddv3NoDtBY4MoXD2tgNRLP97+VCwHGtf47mxDKHFDmW8z
 LVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716821552; x=1717426352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6v5Ahsl39CsRbv/GEH4Brs/Ud4sVcpBnuUlL6/7VQ5Q=;
 b=Kbnk+sHWaD+rV8T/hRtSrfqe0in6xvzjLs8TglAs6r65DP6PVD9H2IbhGXNgX/iNTO
 zo8ZTNhTyFhOaxNqEn2pHJCMRykVydfi9fy59aulk3+V672823gO0/fvl2/0H4aID8Oy
 n9CFDrFDHdSxhbkneMzeL7LyWBFfIQUwIWDML1fnwU7xym3NdTHkz1PSYd3TbK+F0KyL
 pRX8M5bGL7h558D1r12+U5iql+R2cqkfF0UoPupRiC66nYOerCGvBgzk96xQ1OU3POYz
 S00yUaMvmOi3hGyMsp9st0BkI29Xq4NqkqWuukpembtPPejYoaOg4t6P0seU6eEiv1uB
 l32g==
X-Gm-Message-State: AOJu0YzE5GfsLCTfLNYxH4T3wkG1O9r7a6zAlqhmqr8MVr4TYv+sQQDq
 35KO2Q5wp8uinbw+rlknscHweHszT8z0zu7AQu2gCiWfCLKMTqkEY2tmydPft/V9dz23TGDlr/J
 oBHFbsLmqemWhZfR9hQJ+KqX5pew=
X-Google-Smtp-Source: AGHT+IEdS1cQg0FgWwzD6Ayd++rh+JInQBbPNFo753h7NZb+ck7hJ9xcpHaQ1RDDE7XHMGRlQrj3DpI0+J1boy7ro6Y=
X-Received: by 2002:a2e:7216:0:b0:2df:ffc6:1a0c with SMTP id
 38308e7fff4ca-2e95b042bebmr87157831fa.2.1716821551564; Mon, 27 May 2024
 07:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com>
 <bf9dc551-49e4-4ed9-941d-c095bab5755a@linaro.org>
In-Reply-To: <bf9dc551-49e4-4ed9-941d-c095bab5755a@linaro.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 May 2024 20:52:19 +0600
Message-ID: <CAFfO_h7_V13k9WizTYrY-UsjUhvWFeY4Fn7a_8_c4qEz4=hYFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,
Thank you for reviewing.

On Mon, May 27, 2024 at 4:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Dorjoy,
>
> On 18/5/24 10:07, Dorjoy Chowdhury wrote:
> > An EIF (Enclave Image Format)[1] image is used to boot an AWS nitro
> > enclave[2] virtual machine. The EIF file contains the necessary
> > kernel, cmdline, ramdisk(s) sections to boot.
> >
> > This commit adds support for loading EIF image using the microvm
> > machine code. For microvm to boot from an EIF file, the kernel and
> > ramdisk(s) are extracted into a temporary kernel and a temporary
> > initrd file which are then hooked into the regular x86 boot mechanism
> > along with the extracted cmdline.
> >
> > Although not useful for the microvm machine itself, this is needed
> > as the following commit adds support for a new machine type
> > 'nitro-enclave' which uses the microvm machine type as parent. The
> > code for checking and loading EIF will be put inside a 'nitro-enclave'
> > machine type check in the following commit so that microvm cannot load
> > EIF because it shouldn't.
> >
> > [1] https://github.com/aws/aws-nitro-enclaves-image-format
>
> The documentation is rather scarse...
>

Do you mean documentation about EIF file format?  If so, yes, right
now there is no specification other than the github repo for EIF.

> > [2] https://aws.amazon.com/ec2/nitro/nitro-enclaves/
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >   hw/i386/eif.c       | 486 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   hw/i386/eif.h       |  20 ++
> >   hw/i386/meson.build |   2 +-
>
> ... still it seems a generic loader, not restricted to x86.
>
> Maybe better add it as hw/core/loader-eif.[ch]?
>

Yes, the code in eif.c is architecture agnostic. So it could make
sense to move the files to hw/core. But I don't think the names should
have "loader" prefix as there is no loading logic in eif.c. There is
only logic for parsing and extracting kernel, intird, cmdline etc.
Because nitro-enclave machine type is based on microvm which only
supports x86 now, I think it also makes sense to keep the files inside
hw/i386 for now as we can only really load x86 kernel using it. Maybe
if we, in the future, add support for other architectures, then we can
move them to hw/core. What do you think?

Regards,
Dorjoy

