Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B89DD3C927
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 00:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gER-0001aA-Hj; Sun, 20 Oct 2024 20:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gEP-0001Yu-Hc; Sun, 20 Oct 2024 20:25:09 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gEN-0000ZK-RT; Sun, 20 Oct 2024 20:25:09 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-84fb1225a89so1028336241.2; 
 Sun, 20 Oct 2024 17:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729470306; x=1730075106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNzc2jIZN5Rh9EKyji6oxoPXHk3c/6roJ04rXBWrt0Q=;
 b=fOt5X6m1wTjndQrclxMuZRuGH7suw4teQDOn9iZWryazv8cg6Ol5NswMHnK1HWW/JR
 iS7fI3alR3UTPpoEMx0A0YlMlwAmZ/KKXSo+caTqPR8SYOZoW70HWOwtePBoyySIHQMT
 Au3U9gVaHcg0jPuTAv/rgmV02RdLMKPn9VJU24T/VkH39PV4i8gzo19ULbrNx64uT9HB
 +qKfEkEDeP0GMwouIIx4FLus/1ubUyXy0Z9a8AByvyoHcjUUgdHqWqH0XykpoB6LaORo
 a4PaVVsBGabEnk8NMaLIuZLpiB/f4Y/s3wqpw949ioQeLlfqlS1dD5kUrMAez8yF0idg
 l4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729470306; x=1730075106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNzc2jIZN5Rh9EKyji6oxoPXHk3c/6roJ04rXBWrt0Q=;
 b=bOSvwPQ1fPEe3eXo5Yqy6QtKmjLQAJddwO2vpqNc0z6MkUztN50jmyUa3En3rhq7GJ
 J4Gr2R9UZdm5vmJGByPZXxUr1lR6ParDfrtlfm1sLYObpK4KAF1zXm6IkfzIUQG0xNc2
 dGpAZasYYUGvMEfuA2I7xM1EexPLbWbnmbQz88Bhuz8hR/r6ulRhM6l3pH53aprk9m4h
 bVG4jLoSlknkc3fvVghdXYgPT9SQNvV58mFZq9q2CGn/Jy4eetmzqLjoi3n98NsOZ9sf
 oV4aa5ZtGutLCrh8PkjMRqleqY/6Djl4kBjYAIbcth2YvOKZlHlmc7ACBVjuNbHCtRVZ
 FKtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjz0W3m28H+aWK6uLn9psxtSUiOGNJJCDqcE7Ht8xnr0jr/mXCIDNdJfP84Y83mlGmAi7Bl2mQEUQv@nongnu.org
X-Gm-Message-State: AOJu0Ywp2FydMT8miO9CXhM0tRBuBgTU0CkhtB/DzwOb/iQyMPRRNpLP
 7MWNSXV9y+ywsgv1odtOeQKvm/xwdDqAVZwpZw0o6XsZPoJT6BJp0QyncLAFFECJhCdWfNM+k1c
 jJNAEzvFV0sRoqmuQzwpHAt7jaag=
X-Google-Smtp-Source: AGHT+IEZzQIGb0GIcBmvOglROU/O/G1iCZse/nYX0pGeIPg9x6dnFKiBoHavOr5qRy8CzTOSRxnVFjYsv09paCjplPQ=
X-Received: by 2002:a05:6122:2188:b0:50d:47c9:9683 with SMTP id
 71dfb90a1353d-50dda172a2bmr6729220e0c.4.1729470305946; Sun, 20 Oct 2024
 17:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241018141332.942844-1-peter.maydell@linaro.org>
 <20241018141332.942844-6-peter.maydell@linaro.org>
In-Reply-To: <20241018141332.942844-6-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 10:24:39 +1000
Message-ID: <CAKmqyKNuJ8zAOxrs9Pgs-0Wh1hdCEXehF9XGFCzp7H7WoCJFRQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] docs/system/arm: Add placeholder doc for xlnx-zcu102
 board
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Sat, Oct 19, 2024 at 12:15=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> Add a placeholder doc for the xlnx-zcu102 board.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                     |  1 +
>  docs/system/arm/xlnx-zcu102.rst | 19 +++++++++++++++++++
>  docs/system/target-arm.rst      |  1 +
>  3 files changed, 21 insertions(+)
>  create mode 100644 docs/system/arm/xlnx-zcu102.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 031b117a3a0..7c3325628c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1016,6 +1016,7 @@ F: include/hw/ssi/xilinx_spips.h
>  F: hw/display/dpcd.c
>  F: include/hw/display/dpcd.h
>  F: docs/system/arm/xlnx-versal-virt.rst
> +F: docs/system/arm/xlnx-zcu102.rst
>
>  Xilinx Versal OSPI
>  M: Francisco Iglesias <francisco.iglesias@amd.com>
> diff --git a/docs/system/arm/xlnx-zcu102.rst b/docs/system/arm/xlnx-zcu10=
2.rst
> new file mode 100644
> index 00000000000..534cd1dc887
> --- /dev/null
> +++ b/docs/system/arm/xlnx-zcu102.rst
> @@ -0,0 +1,19 @@
> +Xilinx ZynqMP ZCU102 (``xlnx-zcu102``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``xlnx-zcu102`` board models the Xilinx ZynqMP ZCU102 board.
> +This board has 4 Cortex-A53 CPUs and 2 Cortex-R5F CPUs.
> +
> +Machine-specific options
> +""""""""""""""""""""""""
> +
> +The following machine-specific options are supported:
> +
> +secure
> +  Set ``on``/``off`` to enable/disable emulating a guest CPU which imple=
ments the
> +  Arm Security Extensions (TrustZone). The default is ``off``.
> +
> +virtualization
> +  Set ``on``/``off`` to enable/disable emulating a guest CPU which imple=
ments the
> +  Arm Virtualization Extensions. The default is ``off``.
> +
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index a7f88c8f317..ace36d1b17d 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -107,6 +107,7 @@ undocumented; you can get a complete list by running
>     arm/xenpvh
>     arm/xlnx-versal-virt
>     arm/xlnx-zynq
> +   arm/xlnx-zcu102
>
>  Emulated CPU architecture support
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.34.1
>
>

