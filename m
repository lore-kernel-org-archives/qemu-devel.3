Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC05C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF8z-0000RL-Kh; Tue, 04 Feb 2025 04:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfF8w-0000H6-C1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 04:22:54 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfF8u-0005Cv-J5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 04:22:54 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso5227222276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 01:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738660971; x=1739265771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmTq86FYCcD32W1a13YONW1OgZwVXJNTzJxvAv4s/LI=;
 b=UEXGoLOwAT5nJ2y0foLgORLqjHXJdO+JAl0JBC9jJkHhCkGsoDKdLk+vbfXRIzQHUM
 iqOG43sxPg3NeQB/q8IR601zt9ecZaP8PqYHm3wPcFcWy5AxnmSn8n33fdF3VG0rK/fg
 U44OCWYa0wrA0UB4s21lmgOo+Orb8r0odlEKODHzQvMNbxVjAOe+CuUxZ/nMRfQkA0+D
 iwKNw47x+3ooqgwL5gzlvA+Q0eEF8jd64QeaRK6m9iTDyEitoUFQEAH9kjspQdtCeC/B
 3ecxQ7IIUiYX/zP74S1dWNajg9Bl+xChcNA2YPdvigjVDAR7HkzBk+OBpByP8KxNJspc
 SG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660971; x=1739265771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmTq86FYCcD32W1a13YONW1OgZwVXJNTzJxvAv4s/LI=;
 b=BBg8Q4bhXzVcSRF8xWsYTzW9GZe4L/XrswLSbZ0MkdXwI+51jEymD2MezjW9gHUneD
 D/majDRwtq6bfvx+dkjuuo3Sd7Ke9M1AyWwurREFHzIJPaisLG/Vc1lkS5MnfMAVyzTQ
 HZtRulilwqnZl5T1Buik5JB7TLw1Lx8gr/xiu5nXiZRyCkwjFeIq2nhfU/AvoiyVnNxU
 cVRlrY6XOhuYIZxX/YiR3VUPqmHrco63XWJ+btmbuRlcIDehs97ZVXBY3jDvxqQdr0IO
 bkHWs0AuCyEp8EQoR7RdkZD7B/DsievX8EAjv2+TH0dIRcBS81gAfODPzHisBmYle8SC
 Wj1g==
X-Gm-Message-State: AOJu0YzD8xBS0mxif81pEoD/KxfDl3UuSXRUsNE4Xbsn/CLJDZQRuwnG
 EX9Onh+4PzGqvJZNtzs0sxy+QEXejFYlVaXsVqk480nSGVht0vr196qO0v55bOiN0i3BOHq8BLJ
 HrGDl+yzVdoMt6ouCkPzlvg0JxQ+tMEC/SrA5bQ==
X-Gm-Gg: ASbGnctnmfBn4hjhrXzj/goTTh+nR0YTm2eN/+eYhRdddg/YaPNNNMhrJO2Ij0pQIeV
 IrPStmjDgu5vi7AI4riBIFCRmDv7kNCoriAeD9C0Meeur0hgJrxySytooSN0j5ChBgBkKptoPCQ
 ==
X-Google-Smtp-Source: AGHT+IFFjXuj8XbVbZVDT1GJ1qUUlvLcG/+G3580Q4Aiu9VRYi6+8xxGCC+IlQwKFz0q0mtKFx5CW37+SY+RBGB6Mh0=
X-Received: by 2002:a05:6902:18c5:b0:e4d:89e9:6a96 with SMTP id
 3f1490d57ef6-e58a4ac4ad0mr18807657276.18.1738660971230; Tue, 04 Feb 2025
 01:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-12-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 09:22:40 +0000
X-Gm-Features: AWEUYZnyAqsYIZvVkTJpPKo3klQkwasA6ZLEXrr7ajvWzT26Y73l5f5_IaGZxzE
Message-ID: <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <lvivier@redhat.com>, 
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> All previous raspi machines can be created using the
> generic machine. Deprecate the old names to maintain
> a single one. Update the tests.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4a3c302962a..c9a11a52f78 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`=
` and ``xlnx-zynqmp-pmu`` ma
>  Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little e=
ndian
>  CPUs. Big endian support is not tested.
>
> +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and=
 ``raspi4b`` machines (since 10.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''
> +
> +The Raspberry Pi machines have been unified under the generic ``raspi`` =
machine,
> +which takes the model as argument.
> +
> +    - `raspi0`` is now an alias for ``raspi,model=3DZero``
> +    - `raspi1ap`` is now an alias for ``raspi,model=3D1A+``
> +    - `raspi2b`` is now an alias for ``raspi,model=3D2B``
> +    - `raspi3ap`` is now an alias for ``raspi,model=3D3A+``
> +    - `raspi3b`` is now an alias for ``raspi,model=3D3B``
> +    - `raspi4b`` is now an alias for ``raspi,model=3D4B``

This is not how we typically handle "we have a bunch
of different devboards in one family". What's wrong with the
existing set of machine names?

Can we implement "support more than just the fixed amount
of RAM" by making '-m 2G' work, without changing the
machine names at all, please?

thanks
-- PMM

