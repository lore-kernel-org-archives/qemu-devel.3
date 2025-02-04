Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB9C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKZm-0005Z8-Fr; Tue, 04 Feb 2025 10:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKZU-0005VN-EB
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:10:41 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKZR-0006cA-Hn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:10:40 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so473293276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681835; x=1739286635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWuGHrcBgE5gWrOGEcMmcRHM4su5sxfaNfpSnxgJY44=;
 b=ihAUgYWtVjIUiatnjgQ6Hetr4RZmHMEXaL8q/SiAk+T4i1znxvX4mISml1GF7wyEJi
 Rxteh1l0W2KrvB2LWG7O0fAe13YN6Z5JceNrkR0l51WejrxoyCONRJPzLTNDNoOLfw1p
 bigQ56Mpd/1sKhU9abyCZrdiWfU7p6tgP0POs/peFTYUjGFQpwDkjiuZDYSHPrDXSqSv
 O12JBTZnGmu7spSnEuIRE1GwKWpy5zoWQqMFsO1nefg/k/TgZeYH07QAAKgvb3Yk5+U8
 aAdMUrYkxNZcAM544ChjzZ5FgTLstY98cW3HcravAMr/4d+CxuVdLty7jYcRbWEUt4jt
 SWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681835; x=1739286635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWuGHrcBgE5gWrOGEcMmcRHM4su5sxfaNfpSnxgJY44=;
 b=KakDolbUOzp7TYEAIMI5hUMKWh7M14NIx9mTzcIEYAnQbmIcyO8ZkukSba1xGh1WQ2
 se/Ys3DwBCqIiVcmpFZsi0pMH9krFroyHAP5vo/w96XWTjAL7V8TZpe6ifw50EHNNlJq
 ttvkvlbxMsCNwQlKcWUkMacy4XI3Rbla/tG8l2+UiKQlmkbf5qPf96RHZ1QgQhTDMPjc
 +hIMWSDcuxTZZMdtxLc8csqB7VeRibLeOoHg/MmknJqfA7IQAG4B3RElm+hDR5CKyxyt
 mKHzIu3Vi8klJ8gOYDTyEnb4JHgWymRf6vmWHAJcSk67O1aCTv0Rl/gRaShNnR6qvE+7
 oemA==
X-Gm-Message-State: AOJu0YwqNJVgNKV3+msod8gLttB5oXeMLsJMUjpj+ReB++4HIdQuDh6r
 TRQLjTKCeJrlZEqkMrpyTr0dj+OLI5ZZORnHkVq87+8gXyNRg+Gr7IB4cK6fzcsCJYBL3GifNix
 gP0itcVid8GBvqGx8hEsv9JYiRx+DrZ9cQCG7hw==
X-Gm-Gg: ASbGncvbHnJKmTwq/ppttedS93+FCL/P0WkubrIbmHiU3HCI/SNoO9VG9kbYqPX9ehH
 oa/pSHVigTTbbuBYi6ggMb9/wnxPsCXabBvhWstc5HE24JrCQ6kIOlOnR1MmteDEPERmR+kerTw
 ==
X-Google-Smtp-Source: AGHT+IFFDOWQ+brIrOrbY2qM/1jbZurjUz5KlsBxwHhSnSsTfLh/iq4ILQrbYGtZTi9eQP8BeKCLNfW0guPl2ilEN3A=
X-Received: by 2002:a05:6902:128f:b0:e5b:1108:2240 with SMTP id
 3f1490d57ef6-e5b1318c38dmr3383060276.0.1738681835552; Tue, 04 Feb 2025
 07:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-8-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:10:24 +0000
X-Gm-Features: AWEUYZkNiNVYYvGzIQpxktw7EIsb5zKYOhOLRKpDlnx_1hsSJUbMWGHSChHySfA
Message-ID: <CAFEAcA_sphbzR9V_dSgR4yP1msNjWTKbXcFi5H5497UUya67nw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] hw/arm/raspi: Check ramsize is within chipset
 aperture
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Add the 'max_ramsize' field to the soc_property[] array,
> corresponding to the maximum DRAM size a SoC can map.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/raspi.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 68332fba027..d44277001ee 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -76,11 +76,12 @@ typedef enum RaspiProcessorId {
>  static const struct {
>      const char *type;
>      int cores_count;
> +    uint64_t max_ramsize;
>  } soc_property[] =3D {
> -    [PROCESSOR_ID_BCM2835] =3D {TYPE_BCM2835, 1},
> -    [PROCESSOR_ID_BCM2836] =3D {TYPE_BCM2836, BCM283X_NCPUS},
> -    [PROCESSOR_ID_BCM2837] =3D {TYPE_BCM2837, BCM283X_NCPUS},
> -    [PROCESSOR_ID_BCM2838] =3D {TYPE_BCM2838, BCM283X_NCPUS},
> +    [PROCESSOR_ID_BCM2835] =3D {TYPE_BCM2835, 1,              512 * MiB}=
,
> +    [PROCESSOR_ID_BCM2836] =3D {TYPE_BCM2836, BCM283X_NCPUS,  1 * GiB},
> +    [PROCESSOR_ID_BCM2837] =3D {TYPE_BCM2837, BCM283X_NCPUS,  1 * GiB},
> +    [PROCESSOR_ID_BCM2838] =3D {TYPE_BCM2838, BCM283X_NCPUS,  8 * GiB},
>  };
>
>  static const struct {
> @@ -133,6 +134,11 @@ static int cores_count(uint32_t board_rev)
>      return soc_property[board_processor_id(board_rev)].cores_count;
>  }
>
> +static uint64_t ramsize_max(uint32_t board_rev)
> +{
> +    return soc_property[board_processor_id(board_rev)].max_ramsize;
> +}
> +
>  static const char *board_type(uint32_t board_rev)
>  {
>      assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
> @@ -294,6 +300,7 @@ void raspi_base_machine_init(MachineState *machine,
>      BlockBackend *blk;
>      BusState *bus;
>      DeviceState *carddev;
> +    uint64_t max_ramsize;
>
>      if (machine->ram_size !=3D ram_size) {
>          char *size_str =3D size_to_str(ram_size);
> @@ -301,6 +308,12 @@ void raspi_base_machine_init(MachineState *machine,
>          g_free(size_str);
>          exit(1);
>      }
> +    max_ramsize =3D ramsize_max(board_rev);
> +    if (ram_size > max_ramsize) {
> +        g_autofree char *max_ramsize_str =3D size_to_str(max_ramsize);
> +        error_report("At most %s of RAM can be used", max_ramsize_str);
> +         exit(1);

Indent error?

> +    }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

