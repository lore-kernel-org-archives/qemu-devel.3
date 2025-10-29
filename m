Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA00CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1D1-0006eO-F0; Wed, 29 Oct 2025 04:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Cv-0006e8-8L
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:07:01 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Cn-00048m-LE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:06:57 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo324843866b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761725209; x=1762330009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOwTF6WazFPbDs41ptm2izT7SOwThLtr1ckSwEUX874=;
 b=gWLVWOTuwA53Ov2cAgctraD1TZui3P8gnL2J6CafaLHCm6tW/rFDwwCGQDTPWl7Ws/
 +xXcGM+teEL/e/2niSt5VL6wtQ2trCcXmHfBTsYDMQo5ys+m2iVhBOOtW7i8cZiIouYw
 P7BzQnRn+iR0U4h9hoxS5VOhfHdNkgQBaHqrC0JDVEDhqKd83ucoTgZUrbxO/W+n8wxb
 FRM0q9NH442h6qeEL8zK9DehX0bCXLZhnpYkwtvg59stRPqFWdc0vL2PVG0uUhptTGZz
 rAKUy5qTeU45blGv1v1ENJeQHdSwv/y0AOnFIZGSir4RCBOYWotNFB6iFoSv9WvvLPKN
 7H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725209; x=1762330009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOwTF6WazFPbDs41ptm2izT7SOwThLtr1ckSwEUX874=;
 b=QwtJt+M18zsEb6ExZJIsv3Nrvxc3b1t6OM3GVWgMnNMJKXEKtwjjZyOUtm/MpNpdb8
 3UxBHEheckftEqIn4D18o7QyFFeBXh5OWaPbBQhVPiwa0wKxopVmV7WBPKHAsn+FPces
 d+vrn/gHnWf3+eDpniHc1WxR/tLtKznIOfDIfdUM4jAhOXJm0Z3COZretRTHI1ENL1ry
 41jj0ij60SZhRKvKBRN6Ke6JtAt/IKcQQvoMtGjCbr/xRPqp+t8chug8ocY/dspj/sRV
 FzpqP/4vWnDxwmN93GhkyZALm0OWBCCZ4xWyH4E62uDDJylRhU6AlWZoSQjGs3mZsZL/
 drOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgdA3qmxn1bcKPq9pM8CoBFtlryrvz/Bv4uxcHcPCnLZzxZZm5muMpaGauB5W099Kxm0zcXWfKAvBX@nongnu.org
X-Gm-Message-State: AOJu0YypGds1BPp8mE9kLS58VX5mUJNs3YKHlHSoFpbgpDO6dq7uuYSO
 UEQz93lJkJdcEixQLBCN6Z+SMy2M8A7BSGx+4rkOeTZac0gufykNaoDLXZdBNSlnv/OBgtTp8Dy
 34ZP3Rbwhsl8O7MFzGuuQdDwoN07HpB5TZSOd0MhEtYx4uKKlUP2jbSg=
X-Gm-Gg: ASbGnctO0z3xC99zT0nV/qnoO65SrpyFYZqWL4A5G10ecGKfqUEIZmTi7pR7UmQ7oCB
 PnS9iVnbSoKSLPkAiMit46GKWl6ac0pNpEj0tg443qchLCIrfvne25cTzcGVnZI/CETrnoglr76
 5k4sn2ct6J4tRBlCaGeSJGVGyhDaxpbRyzLk/hCAcaCHp3VxAVLN8EJZiE0O5ay4Qpfaw4ldbDY
 82o+Qos6EiHeXP92Mj9TPmQ3qYQa6RxAe9S41PhTSTjWK5cojCD5RObLoBBw3o6fm7aEOw=
X-Google-Smtp-Source: AGHT+IGjTiib+dJG+w62AzMBwHhiy30YLO/4B2mnxmL+Px1aHWeA8s/pmHHlzuk+bKZA7yZ73WQ5BsmU5STK0f2Mob0=
X-Received: by 2002:a17:907:3c86:b0:b41:abc9:6135 with SMTP id
 a640c23a62f3a-b703d524b0amr194404266b.41.1761725208628; Wed, 29 Oct 2025
 01:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251029080502.52938-1-thuth@redhat.com>
In-Reply-To: <20251029080502.52938-1-thuth@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 10:06:22 +0200
X-Gm-Features: AWmQ_bnFG4HD_P_QixsMVJPBnHF83JO6JjZ5T5ROdZGTf9rB5KV6JfwsmtgseZU
Message-ID: <CAAjaMXavqrDjS31Zu4UgWcqvJ-sKpbR_f9ANYkKeL-VnJdApyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/functional/ppc64/test_mac99: Fix style issues
 reported by pylint
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 29, 2025 at 10:05=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Pylint complained about lines being too long here, and mac99Test not
> following the usual CamelCase capitalization.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tests/functional/ppc64/test_mac99.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tests/functional/ppc64/test_mac99.py b/tests/functional/ppc6=
4/test_mac99.py
> index dfd9c01371d..a3261a8330a 100755
> --- a/tests/functional/ppc64/test_mac99.py
> +++ b/tests/functional/ppc64/test_mac99.py
> @@ -7,14 +7,16 @@
>  from qemu_test import LinuxKernelTest, Asset
>  from qemu_test import exec_command_and_wait_for_pattern
>
> -class mac99Test(LinuxKernelTest):
> +class Mac99Test(LinuxKernelTest):
>
>      ASSET_BR2_MAC99_LINUX =3D Asset(
> -        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/b=
uildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main'
> +         '/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vml=
inux'),
>          'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbf=
f')
>
>      ASSET_BR2_MAC99_ROOTFS =3D Asset(
> -        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//=
buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main'
> +         '/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/roo=
tfs.ext2'),
>          'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a=
4')
>
>      def test_ppc64_mac99_buildroot(self):
> --
> 2.51.0
>
>

