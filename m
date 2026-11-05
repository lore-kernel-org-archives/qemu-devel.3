Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40E606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQV1RZNp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2ys-0000UD-O1; Thu, 05 Nov 2026 14:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2yo-0000Tv-Vl
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:18:35 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2ym-0005FA-SB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:18:34 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b56bbf8330so17546a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793906310; cv=none;
 d=google.com; s=arc-20260327;
 b=OYqNOI86N9AVZZPuxh0asawCAkkCEVFzVO4QfHGeIZfivs0DqSMSkYmPVX1DbeG0j1
 AfJ3dUHjbbTf0D6mEDAEJnZ5l1QrPKBHYbQTn0RgNJvFS3RFshw/1tASFj9MRFWWJJm+
 x9eK9eisI9DG5R1tQ3B3QkItnvfG4UFHb5YaujcOVzTftV7HkFqGTaoQa0Z7Pn/mRfQr
 eKc09d0cVr3umFMvSlyQ+jqzEpXpSBkDkscQqke8PlIhx8iL+DLdkaTaBO7j1wwBB2gq
 rKApXaL7YfWqrOkaIvjcFnWpmMST8d8Y7PF1+vwrYfY+i/Kw19eB8iZzy+QTURnurMiC
 W5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jU/iJY8kTPV/T1iMro7XT5GZDwIc5XurvGqFi+v/ZWg=;
 fh=qNcwErX+pvm4tIF9yW+eftyFY9eLhq31DvMxiEYAQZg=;
 b=q9Fn0OyYZDtWaUYAUHm6LN3eWZ7Oo+Nfx5uUtHStX3Q3nkpGQP6lUjGMPd/fEGYt9J
 tm4H0UDF+/xJT/UMsjsA1j/IMVzagHwzhQzTCRQ4NNS5dLtwN1KXSGPQ1SrRVWewKuQL
 HWWXvzbGl1Hoj/y79VVeFXtTalc/Rg2XONpZfiIFwvMqxFjnVIhig324i2puaZDGLFDf
 Jwtw1jyrf2uYD48jlctEOfB7ggNnN0+k7Ss/aBABTK9M/qrm5yr+4v6SNVvpB4l7x9vL
 rqe9eFvlLcAf2rhabzB6vDhiGsBHCc43y+u0IsF211g1f6+p08P35zJlzmszbf0RUjYO
 w/Mg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793906310; x=1794511110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jU/iJY8kTPV/T1iMro7XT5GZDwIc5XurvGqFi+v/ZWg=;
 b=YQV1RZNpk4v8/mdOcPvOhNUK/yVVnjgz40Pjo8WIllzCDoWuszkXoTEXQgM/a8ebwA
 ycRy/lr9BkSpUYl6mFZukn2GCni6wosTcE4C5Lno1Or6XsHOhMq/JqtA1rvADkQZuNGv
 JaWYnUD2Okr391RPUjniXsbgFWLVebAfHVJEglPItwBKvM/gV9WpBs2qPvG1lVEdXVSO
 wxGguhIv5k70d9w+ocpe5i5GeAD4dn3jXzbxowRWXbmos/y2QDGTfaWTlm7XeykBl5W4
 xSrJ11fbv3+nGkbcOoBkwBCPppjXX0p/FjKbpfOUq/Qyh9ouOWt2mqP5aBRvEcqXDnxc
 04Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793906310; x=1794511110;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jU/iJY8kTPV/T1iMro7XT5GZDwIc5XurvGqFi+v/ZWg=;
 b=MMGR9yhWEkPmREjZ+/8F3VwVvBaQTVSeeHNSjrjaN78s57peWGTEHrgvP8ts8o0Ije
 9tqkGNt3CJ2mjKAqti8AHUBp8hzdnOECncBul1u6T9V9YIhUC1RJtmM/t2KwnsLLulqX
 z2nZuHj3IivdnVxN3+x+hd4M+FPkfKWYVanymLOWzI86ND7Q5EHZxkKpCSSvmeWc+fJd
 s+bhiJrfhHGSz2P86SPJ13ffVGkiTGQPOqeM3K+L5sFc+UoGI3aC5xYZcn0WzARIPmVs
 SgZaLcEgM4h37AWA435aPLTeX5uxZ5UCqHuhdDrMei6M7BYC1L9c6w3DSFjggc3rLN3g
 +N8A==
X-Gm-Message-State: APuU4Z/qb0N9WLf3T2P40MsDexlPHucnKBTDfYqF8+jK4kR24MsbFZXv
 jaNSRXYyXSrKnO7KqAGMAmV4JuWXb0IU4qLvVclaD1Sp/u2T0p9pLDPKUsVXgbBLmd+yleHV9fi
 vxv95CQpr5SBU9iwmJGyG5ERfW+1QGMQ=
X-Gm-Gg: AYBFou0XF4jQUVXUiEKoccsG3D1K1HDyOAlUeyqX+uuWRpfuw3yJ/7MkBge6mf7nFxr
 XhsSqkOtUUpkfMWqh4E6Amk+9hkxktN9qyIartn5q2SZ4rHxKS8m0fVdunQWzNRMTiuKi6dekTI
 LMv8DbDh0JymN39We0DxpyV2XMMcggTLMu1AseGzW0dchj7M84Byy4CiioC1iRc+I+muV7LX642
 d3qFl7puJi7KMqXhwi9yhxHRrcdDbfMd7Dj3j3Sw7jzA8X6I2e76iUmW0Sf0c6AId3JxeMZ67gR
 eetOeB6e4tCdTOOd6T0jdPQOr3wiVLMmtnUmTtvzfkcX6tUyqW0Xz8sCDeprdN3wxl3AqyMyazI
 fWrgg6q53qF6PNnj41KxXNkRdM0rF3sKtA8An
X-Received: by 2002:a05:6402:2743:b0:6b5:76b9:5040 with SMTP id
 4fb4d7f45d1cf-6b5978280cfmr150764a12.41.1793906309837; Thu, 05 Nov 2026
 11:18:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105102432.1131493-1-berrange@redhat.com>
In-Reply-To: <20261105102432.1131493-1-berrange@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 6 Nov 2026 03:18:15 +0800
X-Gm-Features: AclHuK9eKRzZswe4j-lehn6go7PUK0y6AO5O9G58l_o9FKuOEQ-ZGqNXDd5p4eg
Message-ID: <CAE2XoE8xNP=kwSROoHQEdRBLjmPGnY61mkQd=_t1oRHpD1QiXw@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw: support machine filtering without is_available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 6:24=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The 'is_available' callback on TypeInfo is based on a mistaken

Thanks, we realized the limitation of 'is_available', and discussed
with Pierrick a lot
about this, I implemented both ways to remove 'is_available' in my local br=
anch.

One is this idea(these patches), add targets in MachineClass::targets,
but we have to rename "virt-machine" that
in conflict.

The other one also achieves the same effect, except no need to rename
"virt-machine" QOM type names, by introducing a private
TypeBucket in object.c I post a small series to answer you question,
in my local branch, "is_avaiable" is removed.
https://lore.kernel.org/qemu-devel/20261105190346.1539-1-luoyonggang@gmail.=
com/T/#t


In both local branches, there is no more QOM name conflict, and target
is selected till the machine selection. so that
have no target_info() access in class_init or type_init.
object_class_get_list(NULL, true); can be called without target
selection, the current question which direction is better.
Both ways works fine, and both ways have their advantages and disadvantages=
.



> notion that we should filter out classes at registration time
> based on architecture.
>
> This creates new problems however, some already present and
> some which will impact a future multi-target binary
>
>  * For introspection of the binaries' features, we have
>    a dependancy on selecting a target before we can
>    introspect features. It would require re-launching
>    QEMU for each target, leading to lots of redundant
>    introspection and a big time sink. It would also not
>    be possible to introspect targets
>
>  * It creates a circular dependancy on QOM initialization
>    inside the QOM initialization code, since 'target_info()'
>    itself uses QOM. This then requires further work to break
>    by initializing QOM target info before the rest of QOM.
>
>  * We have no means to introspect what targets a machine
>    type can be used with, as this information is expressed
>    as code (in target_XXXX() methods), instead of as data.
>
>  * New fields in TypeInfo requires more changes to macros
>    used for initializing machines.
>
> There is no inherant conceptual reason why we must filter out
> classes at type registration time. This is just a shortcut to
> workaround historical technical debt where certain classes
> have clashing names. This is an undesirable approach, as it
> is trading one set of problems for a new set of problems.
>
> This series proposes removal of the 'is_available' concept
> from QOM, and illustrates handling machines with full introspection
> support available from the MachineClass.
>
> This implies fixing the root cause, of clashing class names,
> but does not include patches since various series have already
> been posted for machine class name fixes.
>
> The machine changes are fairly simple
>
>  * MachineClass gains a 'targets' field which is a bit mask
>    of SysEmuTarget
>  * machine_class_is_available() matches 'targets' against
>    'target_info()'
>  * -machine CLI enforces machine_class_is_available()
>  * query-machines filters on machine_class_is_available
>    by default
>  * query-machines gains 'all-targets': 'bool' to opt-in
>    to returning the unfiltered list, with a 'targets'
>    list present
>
> NB, this removes filtering from riscv CPUs with no
> alternative proposed. I'm unclear what this was trying
> to address to begin with, but utlimately it should be
> possible to address it with runtime filtering/matching
> of classes, instead of hiding TypeInfo registration.
> If someone gives me info on the CPUs problem I can a
> make a design suggestion.



>
> Daniel P. Berrang=C3=A9 (4):
>   hw/core: record permitted targets against MachineClass
>   hw: replace 'is_available' with 'targets' in machines
>   target/riscv: remove 'is_available' from riscv CPUs
>   qom: drop the 'is_available' callback from TypeInfo
>
>  hw/arm/aspeed_ast27x0-fc.c  |  3 ++-
>  hw/arm/aspeed_ast27x0_evb.c |  5 +++--
>  hw/arm/raspi.c              | 21 +++++++++++++--------
>  hw/arm/raspi4b.c            |  3 ++-
>  hw/arm/virt.c               |  5 +++--
>  hw/core/machine-qmp-cmds.c  | 18 ++++++++++++++++++
>  hw/core/machine.c           | 13 +++++++++++++
>  hw/hexagon/virt.c           |  3 ++-
>  hw/m68k/virt.c              |  4 ++--
>  hw/or1k/virt.c              |  3 ++-
>  hw/riscv/virt.c             |  4 +++-
>  include/hw/core/boards.h    |  3 +++
>  include/qom/object.h        |  3 ---
>  qapi/machine.json           | 12 +++++++++++-
>  qom/object.c                |  4 ----
>  rust/qom/src/qom.rs         |  1 -
>  system/vl.c                 |  9 +++++++++
>  target/riscv/kvm/kvm-cpu.c  |  1 -
>  target/riscv/tcg/tcg-cpu.c  |  1 -
>  19 files changed, 86 insertions(+), 30 deletions(-)
>
> --
> 2.56.0
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

