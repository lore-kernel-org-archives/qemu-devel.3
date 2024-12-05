Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9625E77178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEye-0004NB-AJ; Thu, 05 Dec 2024 11:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJEyP-0004Hl-5d
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:45:06 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJEyN-0000h5-1K
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:45:04 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53e224bbaccso1227876e87.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733417100; x=1734021900; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1sb14BRxQacuKFTQeJyr0bsm5xU3QUxAOI52PoVBMY=;
 b=ebLBgnU549YvEO+UVUZ2vvTJP9F+aL3vRI1RoxZubbDX3hvUbLwl1B9J/M8EsO2Rsn
 ZXCyxM/AauZ/Y5QV29i99ZKAwEvuPRHhIXhdX8DxpwNUxG5MErm5rE/Y7As+BF9czMVY
 tR8hsIHsqJknUKBisutPU9UsUEEyl62sdxkNY98nQNmJZ1ucbdHz26JdyLwVhqGVvSla
 hRXo+7r9dSZI0y+XV9ZlRfiv4X0nmmiHTqHI+HESDRdeMGB0DiqVuKvN2RtImSCKdYu2
 7Y5It/hC/ES40sfRDnjYbcx+znQX4tZnfqFKTKNJ78zkusKVqGdr4CNnQrEQxLxB94L+
 YpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733417100; x=1734021900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m1sb14BRxQacuKFTQeJyr0bsm5xU3QUxAOI52PoVBMY=;
 b=M1iNeKpM0MzyJQX6KNNOGeFUr0x/nA5Qdm0nrwWeg6kasRfc0ICvS+ea4O+1WnsVEV
 52B/RjBdAuap6619sMEZGQlTZDh9sHw6BGwnzlUgW9nMM/vcBgWCyxlpfRr0ifV7uh6K
 Xo9IdM8qMmZjWHJ8ST5cs0blQRgU79pB1KeRDugpWf473H0AWst3kb1H15joB9X4lFgG
 JIyjw/ZGfuxByRB60Gb6Hq+hrt5zPUDY31fQQvv9I8mUlSUtbRSxPGhjbP0nL5qA3As0
 3X36Tl9LfEAlAJo6p+on174iaWGYu/x10n2ttZGueanyuXkShgwH285bRQVDjID/al0I
 npDQ==
X-Gm-Message-State: AOJu0YwqOxdxw4cJjm0h/keVG3A+OueWJGHkWuOsvgeidOabF7v++VcD
 QYHeKcOnx3Jt49JcSMATz24XYxrNrFPQ3A8ZkVJ6T4/MeKKVd4ysB0NdzTlrHf/I018ndPC1o8o
 HTQyN1cTd6747BA1w6QqBO7tmNBFYC7AXUHDcSg==
X-Gm-Gg: ASbGncvOnJYcp7AGZAsGcrxXWJ2aP87WztAndbCfvpJLAjFwYNbEo4/zUUInoi/3u7O
 x7PSMncGcEOgShybcsFGgHnMdBi9jn9qj
X-Google-Smtp-Source: AGHT+IEZMDEQ+YfoyGSAVfjR0hOYrRi4mT+hliHgm8LSWru9MexD+l7mTdpgmiE1fn1ZvNJrgPRLz8Y4WPKon6aEUHg=
X-Received: by 2002:a05:6512:3f2a:b0:53d:a58c:c5a4 with SMTP id
 2adb3069b0e04-53e12a22f0bmr6202589e87.40.1733417099945; Thu, 05 Dec 2024
 08:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20241126112212.64524-1-philmd@linaro.org>
 <20241126112212.64524-6-philmd@linaro.org>
In-Reply-To: <20241126112212.64524-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 16:44:49 +0000
Message-ID: <CAFEAcA_K_DqRfipvQf0LcrXAMANVrwtCPD3cd2gMah=p2JH2DQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 v2 05/13] hw/pci: Propagate bar_at_addr_0_refused
 to pci_root_bus_internal_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-riscv@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 26 Nov 2024 at 11:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Have pci_root_bus_internal_init() callers set the
> 'bar_at_addr_0_refused' argument. No logical change.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/pci/pci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 27b66583e54..8eacb8f82fc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -529,7 +529,8 @@ static bool machine_refuses_bar_at_addr_0(void)
>
>  static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
>                                         MemoryRegion *mem, MemoryRegion *=
io,
> -                                       uint8_t devfn_min)
> +                                       uint8_t devfn_min,
> +                                       bool bar_at_addr_0_refused)
>  {
>      assert(PCI_FUNC(devfn_min) =3D=3D 0);
>      bus->devfn_min =3D devfn_min;
> @@ -537,7 +538,7 @@ static void pci_root_bus_internal_init(PCIBus *bus, D=
eviceState *parent,
>      bus->address_space_mem =3D mem;
>      bus->address_space_io =3D io;
>      bus->flags |=3D PCI_BUS_IS_ROOT;
> -    if (machine_refuses_bar_at_addr_0()) {
> +    if (bar_at_addr_0_refused && machine_refuses_bar_at_addr_0()) {

Should this be || rather than &&  ? If I understand the
intent correctly, we want to prevent a BAR at address 0
if either:
 * the MachineClass field says we don't want one
   (legacy handling, eventually goes away)
 * the new command line argument says we don't want one

rather than only if *both* say "no address 0" ?

thanks
-- PMM

