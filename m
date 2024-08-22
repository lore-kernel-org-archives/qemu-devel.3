Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92DDC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6hN-0001WU-3i; Thu, 22 Aug 2024 08:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh6hJ-0001TR-PF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:13:49 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh6hG-00039k-TO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:13:49 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5334c018913so704702e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724328824; x=1724933624; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A17X2vXtF3o1S3f4F9GKbovVAlswD6myVLbV8lTu3xA=;
 b=n8+TYbBSAgulwhHuVD3Ps7sA/HThuEOFtALUAd6JTgIiqtCLoNGg0WtWDuMdDzPmk9
 03S4IaYXMnzrbqclg+TBq+t/46B4dippTbXlHPb0g5nOhzaeA2jxhAfho7kZ0hk5mAXp
 W2eaz3xftnWLe9TTDc3va+NAorydrYmLg042NXAc/Q7aerlUIzzqnFSBPlXcj83/n9QH
 lZ2becyI5bWSZr2G1QSRw3JEoNguSgOAD6p1XJCXhOWksOjZrrI/i+WWHrvUuTmIsC7f
 lABUZTNHc2ZdFlts2O53pj0QKhCeBBf/RePE2KxGud3JO1KE5j70APEdNWbT378gNP2Z
 AXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724328824; x=1724933624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A17X2vXtF3o1S3f4F9GKbovVAlswD6myVLbV8lTu3xA=;
 b=hnI37s4V7jXfd6qVocYLsGqBRHD4ScQzVdTxAmZ5P43EI/OInPCgYDKvnp9zZzhsJ3
 Z0DLuO2rgWjkRkkkf30MeYJwXZ7PB5b3BQUJ8k+0iECf86HCA7aFj/zy/EsPJLcaTyPH
 19mwchidSMP2Kr15LCsEmSI2fIEjWLIA44yS0vkj4KsxzaZzbG1CV4odOtnucP3xFReB
 VFMuA60woKl+eEoMNf9kEvapixj9qJDwiTDlaaklMU9bKGQe69UyuVpa3SKRs0j7481Q
 R2MVfrXi2MIDx6pD1Z0p9qnSsjENycvFsYO/orXomnplHqvyPEkdKYp+CaT8NmdYYYrd
 D9Ag==
X-Gm-Message-State: AOJu0YxRRauUSswLsHJsEiHmUMk5e+iWoMK4xv08PJR9eDuio1mDvdix
 sghDB6rAVQJM3rJ/FKDCNr9nC9pw/KaayANZuow5dgvsqgw8aW6sw3W+xnGxe4xF43DMmcZ5OMR
 0qL6A+jBGr09M7z6LEfOhNLJihlLtRzVsSkH4DA==
X-Google-Smtp-Source: AGHT+IE1Q++zyAWTNS1+K308AAPTiPcpw+1GIfknE9e0yVp5fYiWiGyFhE/ZKUpRW8UVumWU0fm/4TytveRXJND+aZA=
X-Received: by 2002:a2e:be0e:0:b0:2ef:26f2:d3e2 with SMTP id
 38308e7fff4ca-2f405c7c311mr13821701fa.2.1724328823414; Thu, 22 Aug 2024
 05:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240630165327.38153-1-mjt@tls.msk.ru>
 <20240630165327.38153-16-mjt@tls.msk.ru>
In-Reply-To: <20240630165327.38153-16-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 13:13:32 +0100
Message-ID: <CAFEAcA9KpXLmaUQC6_FiJFX9RkkDSO0a0m7syhHbSokPojv78w@mail.gmail.com>
Subject: Re: [PULL 15/16] vl.c: select_machine(): add selected machine type to
 error message
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Sun, 30 Jun 2024 at 17:57, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  system/vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 92fc29c193..bdd2f6ecf6 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1674,7 +1674,7 @@ static MachineClass *select_machine(QDict *qdict, E=
rror **errp)
>          machine_class =3D find_machine(machine_type, machines);
>          qdict_del(qdict, "type");
>          if (!machine_class) {
> -            error_setg(errp, "unsupported machine type");
> +            error_setg(errp, "unsupported machine type: \"%s\"", optarg)=
;
>          }
>      } else {
>          machine_class =3D find_default_machine(machines);

Hi. This patch doesn't do the right thing:

$ ./build/x86/qemu-system-aarch64 -M bang
qemu-system-aarch64: unsupported machine type: "(null)"
Use -machine help to list supported machines

"optarg" is a global, and at the point where we call
select_machine() it isn't valid (we've finished parsing
the options entirely). The thing the error message should
be printing is the local variable "machine_type".

I'll send a patch in a moment.

thanks
-- PMM

