Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A21C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKYd-0004au-S3; Tue, 04 Feb 2025 10:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKYb-0004UK-7F
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:09:45 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKYZ-0006Ke-KS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:09:44 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e573136107bso6084137276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681782; x=1739286582; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWNSQGL5aJVYEVZQCGlkPNzok/EZiOoyN3zu02wGQv0=;
 b=JrKBQICUghgYNwOzuf3kPWx6OgWKqK5YfJJ4sUQDMlDVXYnQ0Os8wmOtVTEVkieujE
 Ugt+MHWVVfDK77+/tKetP9QXAamQ6yr3jRuP+SfsAgx+PpAEuq/X9vAKcSQ8ezmejtl2
 At9QRgUV+tsXzoTd8jQc5aEatrk37wJOSXkfqAbsRXn0L4P8I2ucn0zCwxygYAk+SmRV
 6Yy3qcAX4bDhSctRHm6vEz5C0gdPwYXMx7vBDKypVsxzBMrLkTqF5HY4zJXGBzfd8xVw
 +4T73j2jj28AI5k2J0mNmJSaAiSujN7eBxXDwOQht1LH9QrK8a5mll54Dh+0oVeMQJKJ
 YcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681782; x=1739286582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWNSQGL5aJVYEVZQCGlkPNzok/EZiOoyN3zu02wGQv0=;
 b=ARx+ggaUzME3v83JWBuUFedsPFAjR+mQJliIp7LEH427ms5oRUmfhG5AQcsDYXMZ76
 5rg4UmFhasCCPCkkGRsqTClzmmw3P94SdF0ciuWvqHLp5QTD+9G8R3Tc6JC0x0k7C4uM
 AtnZt1R0p+SCGr1dgX2rITm4Ki65dGJCDh1tNVAa2nvNgMr+ztPg93pyD36GowxdVGOI
 vcmwMJoDqHO641MfwFQm9Hun4zfl2+I5NZxtShuKlVNmeRBVh6KTHulrOURDr8FWBAgC
 yYzEbEUaFCCWcgrfW7LDHKL+Op3WGeDr4ygS48tSOTRVJAkwr6L7wx943oORzSYkDEkJ
 DIUg==
X-Gm-Message-State: AOJu0YxH7wDu1hnYkQT46BSHBYHJ1uDxq7iq5cnvPvC4fWqVPsGJWuJo
 JCly2F5WcrHKWZgRFPk+3s3N7fO94dt+Dr4jb/poleLwBZQ83Nw6TvewazeOSt5im14QGdMmNHF
 1BYi0nH6fLtuznfX1k/9vaXs/7PoJTLiqO8Iw/y/bGi/wtQ0/
X-Gm-Gg: ASbGncvlCj/JFwHs3Qq2Ylx7HtgW8+ebWR3EKJ/1CIZXr2Ok/U8zAs2WerU4aisoyH8
 ROmopUw4zD0mgoiHmXNQxucA1VrFDwqxQ5RqXduRzSHY0CCva+Ek+M3KSS//m6uOtNKXRHr888Q
 ==
X-Google-Smtp-Source: AGHT+IFV3CLZLrcg6yKFRfqJpKchyZ+s55CDDOdvQ/gFRpfuN0lQJElqAB2GNFgl+zJCJD00LNfzMD/d+OQ/9orlcS0=
X-Received: by 2002:a05:6902:c0e:b0:e57:2e8f:b682 with SMTP id
 3f1490d57ef6-e58a4ae916fmr20177983276.22.1738681782386; Tue, 04 Feb 2025
 07:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-7-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:09:31 +0000
X-Gm-Features: AWEUYZmlqKw2QuC9sIS36HGrtHZoqOk4Aq0vSmGaRqN_5Mc9jW2YfXvm-rWnzsE
Message-ID: <CAFEAcA-YXwa9ZQWiV+nBC2p8chq2NkDfksiADNh540nLZYeMCw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] hw/arm/raspi: Consider network interface for B
 models
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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
> Raspberry Pi 'B' models have an ethernet chipset (the LAN9512).
> Since we don't yet model it, add a /* TODO */ comment.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/raspi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 1a6a1f8ff22..68332fba027 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -143,6 +143,16 @@ static const char *board_type(uint32_t board_rev)
>      return types[bt].model;
>  }
>
> +static bool is_model_b(uint32_t board_rev)
> +{
> +    return !!strchr(board_type(board_rev), 'B');
> +}
> +
> +static bool has_enet(uint32_t board_rev)
> +{
> +    return is_model_b(board_rev);
> +}
> +
>  static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
>  {
>      static const ARMInsnFixup smpboot[] =3D {
> @@ -304,6 +314,10 @@ void raspi_base_machine_init(MachineState *machine,
>                              machine->kernel_cmdline, &error_abort);
>      qdev_realize(DEVICE(soc), NULL, &error_fatal);
>
> +    if (has_enet(board_rev)) {
> +        /* TODO: model LAN9512 and wire over USB2 */
> +    }
> +

Why bother, if we don't do anything anyway? We can
say in the TODO comment
 /* TODO: "B" models have a LAN9512 on the USB bus */

thanks
-- PMM

