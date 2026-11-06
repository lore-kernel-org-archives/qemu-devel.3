Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E1606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LD6vAIP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPLw-0003ga-J8; Fri, 06 Nov 2026 14:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPPLt-0003ft-OP
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:11:53 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPPLr-0008FR-S6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:11:53 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b596569640so1456322a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793992309; cv=none;
 d=google.com; s=arc-20260327;
 b=XzCxLZeOL1VzVMFfOAmjtAJXWWfxxoHr7DmpjMoE7jxsa/3eMSCN5kNMO/GyqFrl16
 +w7p8D5/UbiWip/DSvb4ie2n2eyqQv1jmoi5xarTTLLO4j1dLF6jTuSXoHPx9B6tc4z/
 p8hjRVer6GhEkk2wW/8Lt1o3Icmlvg/9SCUM22yPq4qEEmWXWgndbW0s+lltVwq/PgVq
 cRirp3AR/CYyzNa/4hLUjhRp6L50/u7S0myYeW1lGZoTgTHIRPvSadanbsP2BTWCUkyi
 In5eVKOV+Xz/rogrf6nUzG64KPDhzor+hqaV10UIdO6cM8pej+lk7klzDorguWbQ/XME
 IJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Rm0T3JR3b5RyuRo7YTsTdhH/OGJIqX40Tz4+NayYYf8=;
 fh=3cPWwIXhiQ0xxSmv1Q3njkrhS14Dx8pNCV6A7StAyfA=;
 b=UZPHHuhtOzwKJBAWJ61ypY4VGywO77f775F7072acq7aPwPq6KY6+VzjkXw6H4TEsO
 A0mVbpUyQrmEsutjXNlWDURIIZloDroylN/GVJN7svcJ4p/o34TmzCKsUAYJ5NAIncxy
 mLxYSRygHNHt2HV5u5zOkveiphawjd6AF5fqD2/QrVPGyQHBbDKNenAD0TQVcLdVkTII
 qkqQzhpgkm3UAJPBsNWpYg/HczknJYe4q/1NpcXRq0/+YyUtSxRrW8Sgergiily62ZiS
 NIYoYjSRObBRqeCLwAV2WaV+cB6ycOpoTd38gVptcEqF+8EPsYySu5lC07N/HQv5HNJH
 Oxog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793992309; x=1794597109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rm0T3JR3b5RyuRo7YTsTdhH/OGJIqX40Tz4+NayYYf8=;
 b=0LD6vAIPrrVtdH1dKKCoxAFNaWzJG0g95b2YfGs7ZzLx2knza+iTJb28DPdLqaS9S7
 rumXVsGvSgRfNN1llvNeTvQczwkHs17WbscU+0MZ5wdN8ecrHczJTWCkB1zYSGwK6XdA
 g0Ff0RARwI9k1xcEwgqwSND0B32t8elvfaAvqOi+NkK1lpjQP1iC5Vj5DhIJR6SeZg2S
 wYLeMT5D3roHXuWFZAzGjKYc2h13vxvLebUPqUzRrSOPfitZoTwbCPwBedObSSrkmmgP
 grbXqXRWuG+hCF4rSxLKd2mT+WaIHTRyUO08IK1PoHvPcVfm8+UbrE8WgHu0KTKUhm1B
 PdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793992309; x=1794597109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rm0T3JR3b5RyuRo7YTsTdhH/OGJIqX40Tz4+NayYYf8=;
 b=IKfr/Da7Jd+IjvclLd196aK4CTf3I8PrKnq5iyHjUa9vVpPV6CtCUVtA/RUuHVGG6O
 qI0JRoWjviNRp533tGX5VX8jtm4pDIcrg9kd7hBeVHyCsP0C0HQFHJY4lsDLpSel8es5
 5FCM8oJZTnxGHjKVh2YRYbwDlYl4yfj1FGb9Al33q/Ucj2S+JlqqHLDa/k8KSLi6R/q4
 FHRMgCev8IjYg4WEwu2nG/8Elr2anvWhOlxhhmdLyqOiuaAt2YEg+Vai2wawjcWz8uML
 I80rHW8VG7ij+v/6IfdFvDJyxDJ0uPEeutgTkE8xPdG8dt6z1n1G3OvBTHgtFIJMt8je
 aFxg==
X-Gm-Message-State: APuU4Z+HcUSGK+PDcz4MfLxLjsyPZS1nNibka0Je/VRDdt2+dp1Q0vI8
 3WOgoj6qc/jq/LNlszuSA2W4dD/LgT4JfhtekE0nRQfr/geynqShKjiTJaTQ0wIp0Crga+8xYYq
 W/GEsQPSvuzhDnOwWLW0qdKx2AfzY1xs=
X-Gm-Gg: AYBFou2KBbO8t4zG7GzMKni7sYbAUWlpHvE6Ya17b04i64a6hy0wVH9coA9SApBEZdU
 K4OhWNHtQLxnWTUJjxfDTI0eo+xM74E+yEEzdx8OVHyUzK/U5/pEWZG1nSN+iGuUYW0LH7W+0io
 8v+aMxJiGDUOBc1xwsk7pi8AI3XKB5OaKJb7bYWzEH+GrRdzYA317zinbySxgz2DeDtgLY0Yp9X
 5wgOzaNhTUWUWRv9FfNQ6U3/YnAmkC0uhrVJmFgW26NJGP8Ggp4cpF98LtVcWFyrZWAZy7Sx12s
 hDEdkXfwO2fsQt5nnOjcCGOIVSx7m0poY1WBHqv02ZJ5MwfEltyMlBD4JuCjAYL3XUR9XFQ0D+R
 /rXJ3VluqLxUzYLGO+M4FAJ0znk87ue33bIex
X-Received: by 2002:a05:6402:241f:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b5977d1584mr2729191a12.10.1793992309460; Fri, 06 Nov 2026
 11:11:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8_Cg5Arv8SnA2yXP_5RAENhw2N-iysUP2Tc1E170VxNg@mail.gmail.com>
 <5588b618-05aa-492d-a9dd-c32591a6f6cb@oss.qualcomm.com>
In-Reply-To: <5588b618-05aa-492d-a9dd-c32591a6f6cb@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 03:11:37 +0800
X-Gm-Features: AclHuK_9Y7PJhAfeE3Nnzd2LZLn3iwfioea-EU6RFQAMULmZXFXttmQ8v7FX1h8
Message-ID: <CAE2XoE8oPqPueC67BK88CBCEkHHqRWF-9xqaoj4ihWFZ=N91NA@mail.gmail.com>
Subject: Re: [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching
 target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52f.google.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 3:07=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/6/2026 11:04 AM, Yonggang Luo wrote:
> > On Sat, Nov 7, 2026 at 1:54=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On windows x64 host:
> >> $ ./build/tests/unit/test-multi-target
> >> Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
> >> (same for windows-arm64 hosts and whpx-accel-aarch64-cpu)
> >>
> >> Parent type is conditionally registered from current target:
> >> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
> >> name. Since whpx-common.c is shared between arm and x86_64 targets,
> >> only register whpx accelerator cpu type when current target cpu type
> >> matches the one it was compiled for.
> >>
> >> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  accel/whpx/whpx-common.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> >> index 78d2827809b..20c684638b0 100644
> >> --- a/accel/whpx/whpx-common.c
> >> +++ b/accel/whpx/whpx-common.c
> >> @@ -20,6 +20,7 @@
> >>  #include "hw/core/boards.h"
> >>  #include "hw/intc/ioapic.h"
> >>  #include "qemu/error-report.h"
> >> +#include "qemu/target-info.h"
> >>  #include "qapi/error.h"
> >>  #include "qapi/qapi-types-common.h"
> >>  #include "qapi/qapi-type-infos-common.h"
> >> @@ -492,11 +493,18 @@ static void whpx_cpu_accel_class_init(ObjectClas=
s *oc, const void *data)
> >>      acc->cpu_instance_init =3D whpx_cpu_instance_init;
> >>  }
> >>
> >> +/* TYPE_ACCEL_CPU is only registered for current target cpu type */
> >> +static bool whpx_cpu_accel_is_available(void)
> >> +{
> >> +    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
> >> +}
> >> +
> >>  static const TypeInfo whpx_cpu_accel_type =3D {
> >>      .name =3D ACCEL_CPU_NAME("whpx"),
> >>
> >>      .parent =3D TYPE_ACCEL_CPU,
> >>      .class_init =3D whpx_cpu_accel_class_init,
> >> +    .is_available =3D whpx_cpu_accel_is_available,
> >>      .abstract =3D true,
> >>  };
> >>
> >> --
> >> 2.43.0
> >>
> >>
> >
> > Hi, I think
> >
> > [PATCH v5 0/3] Register accel-$cpu_type for all targets
> > https://lore.kernel.org/qemu-devel/20261106023936.772-1-luoyonggang@gma=
il.com/
> >
> > should also handled this. so this is_available do not need anymore.
> >
>
> I would prefer to send the accel series later, giving time for
> additional reviews, if anyone has an objection.

Thanks, I got your intention now, it's fine to revert this after the
new release.

>
> the whpx fix is needed now as the test fails on windows at the moment.
> the patch can be removed after, no problem.
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

