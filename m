Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB54C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKWJ-0001oP-NH; Tue, 04 Feb 2025 10:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKVz-0001ml-5L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:07:06 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKVx-00060M-2t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:07:02 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5b1837d182so549020276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681613; x=1739286413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvsUuJWe9RvhXqA747nGDaYATpe2HmzJ5+xRgOBNDec=;
 b=A5tVO0+a9NbbW7A9oJqnOVmSUkfBJq6wOsAc1z0unpp7QsDt26p3qeQNW51m3rA1Tv
 VeL5ZutCIylQhtvRL7mzDcSSGPcvgyhnYTCcEcndg++JGIPsFIthfbNq7htZcg2OOyA4
 cjVVBPqYGYPsDWVVxmuECV8LsTuHo3398nVR1HCtKXhYnFDzR0JJ99Bn2Ez5rOJumxC9
 l3yFYEbz+lnLMIravVSyf01wVXBpKMTakXUJhJyL8WL33r9Tapf00tiF+QLLL1io/4Xw
 8Cj5Pmk69HQtIFUEmQOSJRkG/H8d3nL23pTt4LYQigyPwPiDfHXzpssQEqED3wnIqREh
 Av6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681613; x=1739286413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvsUuJWe9RvhXqA747nGDaYATpe2HmzJ5+xRgOBNDec=;
 b=jZBOkJBZHLXUFnTpRP/622N+tJWb1BlTMKU9D8GiZmgdKawVzGVfcgLK0MKC0JdItX
 TQvu/0GFiwr0wV/b1qMPirSlY/NZiM935uNwhIO2izOgxuXXunoFL0qDNScDmEBO2igF
 PYIGcOQ65Oor/W1/JqlwDTPQHFovME4pLe2sW3ssYpnf16jPBriKHOH8RwooRHW2R5Oq
 A9FFMhy6Vo6NDAzcULpI2H5r/f83eMspQi+sUGjXSmpqSQcV83BdHZauCi1UL3Z0Dqv4
 webSx9IMPPgQvO/1lRAD4HI5wEwXbMleeEdrEC40azb9bK169vG1/GAGQznmYeQA+XjB
 wxLA==
X-Gm-Message-State: AOJu0YzJS7Q4J+YmJaN1MtMGr/KpKmOE+OSQ7cDQyElK0U4rySjwCU1a
 68Y/AHr8OGtvPRqrfKeE+HvCjh75/+0rdaG/EMavWO8hJ1KAiUdpr5W7XhJptmVsG1pbD7RNxup
 5oIL7ifHSKvmQM9Z39mPAIMZGQBOZ12f+/9Mrig==
X-Gm-Gg: ASbGncvxhvRUoJ9nct0oQNBGIymZHkbhJnIyTqtSu+sw14m1qgD8EnNgyywAHfSpXMv
 yPYHY3k56v63f6qiJRzSu80U2B/s+JGJmUXwx/eSHIO15JiC5HlmKPLeP/OBGq+HCRCbOFUxRFA
 ==
X-Google-Smtp-Source: AGHT+IGsjl3ZXwFhDzzL3TR7GiZ5aZhSsdWVUdMkA40VfGIaKQvcRftCjN+55wrCC2qrBvCBxOLQRolyLNO14fhr68E=
X-Received: by 2002:a05:6902:2481:b0:e58:55be:b0ae with SMTP id
 3f1490d57ef6-e5b135baa29mr3250832276.14.1738681612724; Tue, 04 Feb 2025
 07:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-4-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:06:41 +0000
X-Gm-Features: AWEUYZlJeSPpkEmY8V_OFRFE4QwuMGfbLvKpvxPfi8-motuDR53oUNLUaclNfgI
Message-ID: <CAFEAcA_81PfM3SFTXEgj3c2yBh32XDwbkosM8z+qBY2ZZb2Akw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] hw/arm/raspi: Unify RASPI_MACHINE types
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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
> Merge Raspi4bMachineState within RaspiMachineState by
> using an unnamed union.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/raspi.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 3fa382d62ce..ef94d57dab5 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -38,9 +38,6 @@
>  #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
>  OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
>
> -#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
> -OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
> -
>  #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAG=
S */
>  #define MVBAR_ADDR      0x400 /* secure vectors */
>  #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
> @@ -49,15 +46,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI=
4B_MACHINE)
>  #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
>
>  struct RaspiMachineState {
> -    /*< private >*/
>      RaspiBaseMachineState parent_obj;
> -    /*< public >*/
> -    BCM283XState soc;
> -};
>
> -struct Raspi4bMachineState {
> -    RaspiBaseMachineState parent_obj;
> -    BCM2838State soc;
> +    union {
> +        BCM283XState soc;
> +        BCM2838State soc4;
> +    };

Do we have any other examples of using a union like this?
I think it's exactly because the components are different
for raspi4b that it has its own machine state struct.

thanks
-- PMM

