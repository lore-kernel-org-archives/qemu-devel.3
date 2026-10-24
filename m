Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3B606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e6YxjOYa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKWzp-00016Y-6k; Sat, 24 Oct 2026 04:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xKWzZ-000166-O7
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 04:20:43 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xKWzV-00064r-UT
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 04:20:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b4213059d4so1583929a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 01:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792830034; cv=none;
 d=google.com; s=arc-20260327;
 b=igroxHefTQAUOycinvqzCciuNXGcUa6wllmWfzFr5bYfwWtkjxI02TFTPkV/4X6Dc3
 Soa1p1//4a4cDJYSuYrH6rROh5gvp9oBqP6gGpaEVwwyKhdQ+vLfBHgE0bG71/48Giin
 td5MuGhBDf0OSMoixwjktPQjnmjQj0+w9OY4/COJJLC6h7VbV2mKl1RPNzH2JvE5RyZM
 r4b/gyLSXaa8sI53K2UXELhf8YghbD0WcA+FEv7FVFWsA53gGTEVHxR5PyxRej9guwDx
 tBOCAuCObjWISke0CQhlvUkI+cKsPZzFrISPB7Qxn3PbSJEq1DiCGjib5nF7vrtTtAzs
 FBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=pToyZEsMQcnnK/K9SHbtCiiY1SOcsA947piF/MF4FdA=;
 fh=s78ZTenUdEUgKjwGhjomvA2uKRL+ofyF24hx+ILH2nw=;
 b=HgqC7db/SQnGY4UBkAFkE9W1vtX+swAA2TgYBygennU6c8Zmb80NI+UxB6hCFGkI2G
 tz7SnCreDRnpyROkqHqfs31+ssyRGlOSSl4NWosU8ZG/PwXgkV6+NoFfY0Gnu/Rgo7J8
 OZGuP9oPuGb3/qSv7p5mmJlpRoEE9DYcTQYb7blb8A/s+Yl2gFmVPm/YvR8zJqbDAbHK
 vm/fYKYxxHgOxhtQjCAAWgIhNA/lOG1Ay2edwQ9ajU5dLKM6y+cv0vww9fiCuz+EYOAm
 XBwzfyAYM8dnqAf6o77s5BMPchiUFF8Ll2agCs/1xNii310xJ7WYEU+Ln9nIi+HcKG0C
 vRUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792830034; x=1793434834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pToyZEsMQcnnK/K9SHbtCiiY1SOcsA947piF/MF4FdA=;
 b=e6YxjOYaJMAAYjjjr6Aj/95R59qgUMFzKaNO8HDJFxvwJyPm8j6LKnTuYmw+wPCENR
 MjJv0N5VcwTYs5AR8tIgvuMxnBqQrV+Udn2hLw0K33FxlNTpqbSemi7K//U+h9oPDTYs
 HQpz4QTblLcHUYcK2ucI8gXJW7Om11CdD2G5J3PRV25FLKznLI6u91YRP+wauCskGrPt
 y64NzwJa9qMiVmGz8HPpZn03OY47JgEYM/6MkSlI3CHYT4CDuSCdiP5Sti6osIN9eZKn
 MdeqOMFefZmmM4JE+oLRBB6/U/noD8uwRCKKbqHWk4eyGRT9fMU8Pm8gFQot4e/ug8IO
 3SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792830034; x=1793434834;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pToyZEsMQcnnK/K9SHbtCiiY1SOcsA947piF/MF4FdA=;
 b=hQTZAptyj0zh89Gdy+jNzSS+cgpX/G5SZvsovmL/eTJx/uNJ1tWRAhwLuEQOUdbdeR
 aAQfbzGALfAlYNI9C+4v7qfAWlO+7cowF+2VxneQFOYujq4Zrtf5eMC/c8meHYV3rnAu
 Ur93P6mXHULyxFCAWPtVS+bJfN4R75tG8HSjM//AxNzOvUgFmk5K3whGiHm4AqId3j5e
 g9W81nOc8DoKZQRs2cNhBQai+D3lQ1MYpUY/Z2a4RTSG6Pme5aUlKhr3I/f+bNASUWDQ
 OL0t4Mpf+VbSygRLT98L6I9sflL61BV07K0jeMRwIGD8SLRDLNVA76wVuq4aRE/+OS5S
 K3IA==
X-Gm-Message-State: AFq9FYIFNrej3ztupmWoHhR+pb49Vl39Uq/2cDum9fjH6U82bNXVy1rZ
 HdH9t9TAazAF1iJMCzpdj1uYq9ue/Y/pntygriYvq02sUGVVRuCvEy+PkS2c9j37o4ayUar8wO3
 LbvWxxNn1BUoxLWyxeUCI+1aH6QfuwZ8=
X-Gm-Gg: AYBFou3Q7Q7L9P32hITFEd3dhN2TeqRLQsOeLJijYXvQ6Y2cAoIbMxs+GRlwvPWkmjo
 NBTS+LJpErXEAdazbqRpYdVorZFGAUBNVC08R/jwIWZjb57g8dKUOpt8p75yKjxYkmIHQRdIC2P
 tfFm2QFMrNWYgWpHomXsQlZJ6Ne28gW1SIhdi6IC9NRaqymD4qyWG6ZyC/bD1DY+1ZA/rNDaxJc
 Y+Jn6WBRAHGJf50fgbGbWnrkctLjjYvwMjXL+cSIjBVwIKD6iDcC4E672xxaqulTQKGr0q4MdvK
 jIACnDLJoQ159PH/MAQek1FY7aStjDWJd0As9yQGSBDMVilLdSJp9+oV6Xxhb0TYPJ1WLlBrlcY
 4vdsSqIIL0DnyrZrAMJpRKNSzSjh69pzf8pZhMqxODUvuf7aWzxweRzclVg==
X-Received: by 2002:a05:6402:a50b:10b0:6b4:208d:21f2 with SMTP id
 4fb4d7f45d1cf-6b442a82c9amr1193663a12.2.1792830033438; Sat, 24 Oct 2026
 01:20:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
 <20261024061616.27381-8-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261024061616.27381-8-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 24 Oct 2026 16:20:21 +0800
X-Gm-Features: AclHuK9V7Uwx6zg_JiVJqEyKT0IPIDyqujdcN4VTu33Zl-YLmWJrfgYWDru6rFE
Message-ID: <CAE2XoE-BzqTvMR24V-h02xf1EouSe-jW7AVmC-LPVCc7icrypw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] target/riscv/kvm: restrict kvm-accel-riscv-cpu to
 riscv targets
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>
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

On Sat, Oct 24, 2026 at 2:19=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On riscv hosts:
> $ ./build/tests/unit/test-multi-target
> Type 'kvm-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
> Aborted
>
> Parent type is conditionally registered from current target:
> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
> name. Thus, accelerator specific cpu types must only be registered for
> riscv targets.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 45ad5e1525a..f28d9115c82 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/target-info.h"
>  #include "qapi/visitor.h"
>  #include "system/system.h"
>  #include "system/kvm.h"
> @@ -2208,6 +2209,7 @@ static const TypeInfo kvm_cpu_accel_type_info =3D {
>
>      .parent =3D TYPE_ACCEL_CPU,
>      .class_init =3D kvm_cpu_accel_class_init,
> +    .is_available =3D target_base_riscv,
>      .abstract =3D true,
>  };
>  static void kvm_cpu_accel_register_types(void)
> --
> 2.43.0
>
>

This is my way

[PATCH 07/34] target-info: prepare the QOM target list before
module_call_init(MODULE_INIT_QOM)
https://lore.kernel.org/qemu-devel/20261014093152.834-8-luoyonggang@gmail.c=
om/

[PATCH 09/34] accel: register CPU parent for each target
https://lore.kernel.org/qemu-devel/20261014093152.834-10-luoyonggang@gmail.=
com/

with this, you have no need to repeat the
`.is_available =3D target_base_riscv`, work and then remove the latter.


 prepare the QOM target list before module_call_init(MODULE_INIT_QOM) is ne=
eded
because we can not query the target list within the type_init.



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

