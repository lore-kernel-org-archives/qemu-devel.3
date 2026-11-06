Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB6606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ctJ/8qHS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPFN-0008TK-CM; Fri, 06 Nov 2026 14:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPPFI-0008SI-HU
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:05:05 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPPFG-0007IV-Eu
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:05:04 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b65d69f5c2so1197794a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:05:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793991900; cv=none;
 d=google.com; s=arc-20260327;
 b=D5c5qXBkbj8Kkpjk2y72Ww8uxuRdCIMC8V9fxV3z/qfYkMEodPYMqpIu8d+hwecaFf
 kBkap0DdLjDqcPV13h7i+6uEEad9HaS0QzGv7P8c79LvpNQsw6dfIrmRDMgqMk7F1GHP
 bn2MIvjsh4yFpT+G4B/RKqE1VkEtF6gYmcIfTXQ6zqdFEHbOsHVcxMgOC9SnnSlnaL7D
 iRgUe7jzSepapVmHfztFcAEBaHYVk5Mfb1IS9sQkcbXrtTUy+RdFtiuaEzR/ROlPQYg0
 dlLiStOHpyGE3D5qYrS7u3VPC7p/pt3wlDZeNZvWFek6H5dNBwqjJzaKNumM5fFcLANB
 6AIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=RRu/ESU2BT5Ip9ThCIokgkCfDknwYZ0+Lfprs+20sVQ=;
 fh=3cPWwIXhiQ0xxSmv1Q3njkrhS14Dx8pNCV6A7StAyfA=;
 b=NZntbvEqbkbk2dvEna1r51X22IE/245lBaadqx4y8NhElbf1xsjW6joCdNIpN/Ti7w
 qNsvuwrO/BTgUYsx8CbjMMVC6ntsHb0/J0QJw2YZUeP5P64A6UoRGj3ypLVGTe4yZWVa
 GBGQY0634zjhEqtI4+ykTkmplgUK9Kmzb/NFgpYFJaeu+XJpsyAYg3rWWUZOM8MPrCnI
 F7NrcPHv+rSDj8Oh0dos6ehY5jpsNwmj5/6bJZ/lqnf3HQh9a65sMs7VSkiIQgZslajD
 MWiT+llrEArCKPnRKbfw742w6MHnNWONyLqwUwvmQ0Jz8lGUYx+WXaGJJJ4ff1cq1D5Q
 62ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793991900; x=1794596700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RRu/ESU2BT5Ip9ThCIokgkCfDknwYZ0+Lfprs+20sVQ=;
 b=ctJ/8qHSIrfVugtNcBZCpUv333abaM5yJL43UMMifokkEW9cx53ytUMbizbwoTa3uM
 UxuMljXlwJIqC/EiLVy/pjMYVCWIIXXzxmwrUv2nNHJldxfg2bk5464mAzwngpKJi9Pi
 FG2o5xety3OxEMKCiorln7vO6T1Xe6e1AaOncwnrBqg9wqr5ul6CaS7wD7ZQAZSkF+ml
 Af7xAvKU5UOIZX5rqGzVEPs9zK+DPRjrXdfIWBU4J5AnZlaxMeaMm+J0vA3dco9cBEVf
 KwHYQRB9r77FP4QbfmSHz5m08bWkpN1LtPUibkDCObuiJw1X1/p8GECQUUrRGwcKdFlp
 kqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991900; x=1794596700;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRu/ESU2BT5Ip9ThCIokgkCfDknwYZ0+Lfprs+20sVQ=;
 b=xJ+ICPuh8GcGPrSMBSxPMHVhqXUTgy+k5qZKiAFNmRUCRz9rMPk89nePtpJ01BJhH9
 Zk72/R39LGck1vfdEaVR0tZF84NMX/LE2Hhb6eQMgjWUgI+AigVS5wyu/1HjDJwATQIL
 9ousCWV6m+dUrmBFm05OT5QO2DY94HfIxBlTlzPHQAPAqQqPnIOzolvl9eJ3qIB36v8g
 J8yLAUNqcXWE4r18uXktSzTJLLd9ZP8XynIkbQ7jNhEQEC58COXh2HNfbYabX4+iHrjX
 MSZQlzOGsv5lu5ELfT/aH4W7SQnzAODpLMP4arywtU2Oxzw1ERJP0It+9ES6vDQuNZOD
 Gojw==
X-Gm-Message-State: APuU4Z/MF+KD1OH3yo/OukB2OGT6MROLyMZVPo5xMmQ1a0xGQTGDLf2q
 cODjVGdgyvjca7BtZ3qdFcKjW+HVVhzkHRy7RzpNgrILkvFkOSfeT/WQKaoXCi/YYZtZnElqh3S
 plLQQU55S5vcnKuG7p7JFims4/IlWWcg=
X-Gm-Gg: AYBFou0BVyFDGoHfA5nYaUKlyAx/Z2vSGFQs2KDsZYBpCBVkcVTY4VPAlSPORwXvTa4
 HIKpep/u6iJl9s5Iy5q/kEGQmTYKDRGGVQhkDF3S3WxSxTNEiF9elsFjZY/9lOrB5q93GRs3+Ui
 gOCIIPRfip7WlvEWeAKbccBCY3gbp/P00LXobOEn1GwzNU0xe14IfD1Id6d0xlfLcvW0MiK1jWB
 n2ZdtAzQqEHxAluoIVjS4uf7iUbHaMg8ErdR9pKGk1FrntvGVlloy/HFQwKfTUAYgVvKxRGyf1y
 WeCOLx+K/HzBYeuRLkJ3dQET8oATJahXrUvE1gTK8X/N2JrBoL1izK8vbn6zpcvNCWTT9eI/lat
 jvIqedlLdi2LwZqJX5mTzLc7T4r+S1T4bvhG1
X-Received: by 2002:a05:6402:3811:b0:6b5:8719:6d51 with SMTP id
 4fb4d7f45d1cf-6b5977e704fmr2459928a12.32.1793991900257; Fri, 06 Nov 2026
 11:05:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 03:04:46 +0800
X-Gm-Features: AclHuK_d2fZta-XyNdduS4bLzTs7INtKI4-y_szcgUBI1pZNS7zT3hCWKwcH-RM
Message-ID: <CAE2XoE8_Cg5Arv8SnA2yXP_5RAENhw2N-iysUP2Tc1E170VxNg@mail.gmail.com>
Subject: Re: [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching
 target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52a.google.com
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

On Sat, Nov 7, 2026 at 1:54=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On windows x64 host:
> $ ./build/tests/unit/test-multi-target
> Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
> (same for windows-arm64 hosts and whpx-accel-aarch64-cpu)
>
> Parent type is conditionally registered from current target:
> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
> name. Since whpx-common.c is shared between arm and x86_64 targets,
> only register whpx accelerator cpu type when current target cpu type
> matches the one it was compiled for.
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  accel/whpx/whpx-common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 78d2827809b..20c684638b0 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -20,6 +20,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/intc/ioapic.h"
>  #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-types-common.h"
>  #include "qapi/qapi-type-infos-common.h"
> @@ -492,11 +493,18 @@ static void whpx_cpu_accel_class_init(ObjectClass *=
oc, const void *data)
>      acc->cpu_instance_init =3D whpx_cpu_instance_init;
>  }
>
> +/* TYPE_ACCEL_CPU is only registered for current target cpu type */
> +static bool whpx_cpu_accel_is_available(void)
> +{
> +    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
> +}
> +
>  static const TypeInfo whpx_cpu_accel_type =3D {
>      .name =3D ACCEL_CPU_NAME("whpx"),
>
>      .parent =3D TYPE_ACCEL_CPU,
>      .class_init =3D whpx_cpu_accel_class_init,
> +    .is_available =3D whpx_cpu_accel_is_available,
>      .abstract =3D true,
>  };
>
> --
> 2.43.0
>
>

Hi, I think

[PATCH v5 0/3] Register accel-$cpu_type for all targets
https://lore.kernel.org/qemu-devel/20261106023936.772-1-luoyonggang@gmail.c=
om/

should also handled this. so this is_available do not need anymore.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

