Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E340CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE196-0003Z7-WF; Wed, 29 Oct 2025 04:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE18N-00039g-AM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:02:19 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE18J-0003ch-2U
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:02:18 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63bad3cd668so13448849a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724931; x=1762329731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WscbCcmz1jc5Gwh5WBGhVUBrxowj5OKXTiAX6c7aWLM=;
 b=YWYOGPd4M/hRfeSaL+g6CEPt8hfb8Hv3QFUIvtk/8WUX+28vvCwphKXAf9mpP8j4OM
 Vjw0oz6BGJ7O8sFipSKpm6CRBidHBW50YjwG7lBBPcw+DCo2acnfLonSr/cE2Phm1CBS
 /CpBowMG+xDxT5Do5UH4fbHZM1SVMa2IULCgBCwp2zokFLcr0V45Iwr5l9Fa7YF1aIjs
 d/cwo5AL4xaLaCNAAWWXo+QBUM5zRxvMFxlQ6Irt/10qjkAQ5c+72Dlz35tSa1ELy5GG
 ImK3Z5uP+dY6+gTPgTsdO/tlJH+KWdVhjR6AoIaPzl0ajHldMkOIJVFvCGNPHwoCNNlG
 SK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724931; x=1762329731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WscbCcmz1jc5Gwh5WBGhVUBrxowj5OKXTiAX6c7aWLM=;
 b=BvBMp7q3c3X6qlq9qmSi7QsPTMxgRVkxmgQOWYMMmR6SHfq0xFhL3hZ2g78CxW7Fn9
 qKbjFcmwpf+p7J4EuGLfbbveVCDzfVZRC4I1fWgiHAk6xmvBn62YuNtH+RR4bkGojJEg
 58GsdVJQY22iwkIjN86m2KXycPLUtAxktguYtwjulwkzqxw2NSf+fE/GZmaa53u6dQQZ
 RQByD3L/BQv759Yf9TViozaEAwrfzXKA/6zib9dQC45s8e3FXdBKWgWs1VMou+UF40Yr
 u9UJW0m5Bxvkz9Enee75/dWIEg8oaI8hsyiERdSPM/pVrcGooLm2NiUMg3ianObDY8A7
 ciyA==
X-Gm-Message-State: AOJu0YxHZbrT6DLNsGwHXPOJdKVSpDG/VTDn2NMrNbmkiMT+xqXEfdCY
 KOGCPzG+AT7TAtZ9nVaPH3Y1ryjCbNzJIJpQFObl78Pq2msHR4yRYwxJOQqMlXrwmXJg8t4/bSq
 kRdn2xmYERd5iRE3sb8ZEbEEO5zXFoo9aSR5fGU7cfA==
X-Gm-Gg: ASbGncsgfQ+6tL1kwvWGynvgWL3GSWTEtcqt8sFtqvcw7oQ7ebcClL0YbINqMBP7NYL
 HAE2y5nLSnzP8c3ZIVX5S+v2kyk7CwfKGeuya1l57oWxWrfsTrsFfgMdIWCJL8JamZILcQ16M/F
 2RWOLGxmUEsBHtipOwb7XucImqvqREAbagFgOw8ssInUq2MQqWjo4BAmS8kX24einn9z5+c8CNX
 XTVa5yEVRI+rFdVr8jyOqKn6teO4nkHTKJ7+N0NymdbvNL24Mn4od619hiC
X-Google-Smtp-Source: AGHT+IHJbV+NYmSO//92bode9TKPTyrX4/f5dkPcK0r9xVIJlpa5ZEBSqxhnkT6xUT7LB9APAjrIf9VcnWbP1XBR3D4=
X-Received: by 2002:a05:6402:35c3:b0:63b:f91e:60a2 with SMTP id
 4fb4d7f45d1cf-64044276880mr1335139a12.25.1761724930692; Wed, 29 Oct 2025
 01:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251029075257.63635-1-philmd@linaro.org>
In-Reply-To: <20251029075257.63635-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 10:01:44 +0200
X-Gm-Features: AWmQ_bmdgjM6n8K3Go8XXHz87bf2sCkEyWDESvMwwj9cEgPYj7w34B5qT_pu7ew
Message-ID: <CAAjaMXYuXpp3s9_v6Zvkbzgu07JE5Pe7soaeFB+G4wG3v976nw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm283x: Initialize CPU objects in SoC common
 DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, Oct 29, 2025 at 9:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> QOM .instance_init() handler can not fail. QDev DeviceRealize
> can.
>
> The device-introspect QTest enumerates all QDev types and
> instantiate each one, without realizing it, then introspects
> the instance properties.
>
> When switching to a single QEMU binary, all QDev types are
> available in the binary, but only a filtered subset might be
> available, depending on which previous target the binary is
> trying to mimic.
>
> In particular with the Raspi machines, the TYPE_RASPI4B_MACHINE
> and ARM_CPU_TYPE_NAME("cortex-a72") will be built in the
> qemu-system-arm binary, while not available (because filtered
> as being 64-bit, for the qemu-system-aarch64 binary).
>
> However the TYPE_BCM2838 SoC is not filtered out, and will
> abort when being initialized, because the "cortex-a72" CPU type
> is filtered out, leading to device-introspect failure:
>
>   1/1 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test        ERRO=
R            2.46s   killed by signal 6 SIGABRT
>   stderr:
>   unknown type 'cortex-a72-arm-cpu'
>   Broken pipe
>   ../../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU p=
rocess but encountered exit status 1 (expected 0)
>   (test program exited with status code -6)
>   TAP parsing error: Too few tests run (expected 167, got 5)
>
> In order to avoid that, move the CPU *initialization* in the
> SoC DeviceRealize handler, so the SoC initialization won't
> fail, while realization still will.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/arm/bcm2836.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index cd61ba15054..6e4066f137d 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
>  {
>      BCM283XBaseState *s =3D BCM283X_BASE(obj);
>      BCM283XBaseClass *bc =3D BCM283X_BASE_GET_CLASS(obj);
> -    int n;
>
> -    for (n =3D 0; n < bc->core_count; n++) {
> -        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
> -                                bc->cpu_type);
> -    }
>      if (bc->core_count > 1) {
>          qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_pro=
perty);
>          qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count=
);
> @@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPe=
ripheralBaseState *ps,
>      BCM283XBaseClass *bc =3D BCM283X_BASE_GET_CLASS(dev);
>      Object *obj;
>
> +    for (int n =3D 0; n < bc->core_count; n++) {
> +        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
> +                                bc->cpu_type);
> +    }
> +
>      /* common peripherals from bcm2835 */
>
>      obj =3D object_property_get_link(OBJECT(dev), "ram", &error_abort);
> --
> 2.51.0
>
>

