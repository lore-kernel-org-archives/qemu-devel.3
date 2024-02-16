Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7155EC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raznT-0002h8-SV; Fri, 16 Feb 2024 10:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1raznO-0002gO-G1
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1raznM-0001CL-5k
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPBTdysDYpPiACBe5cKL5ETdbaaMEMrm03T0DAO6ASg=;
 b=DIreeWh0Y2xeNPhO13/qom3iQkp+sl2284J8lHWlFYhQwbGrxm3RpgoIVq8E9k0EmJ02V4
 r8Gn7TG8PIanx/bMMIMW+AUVj1HubqItPzLiax05Dx7AfE+gO68CDYh5NqUqFalrVndxkT
 tt9ESR7Lo9X9Car7buRAAWGRNCvnpRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-d6VkizI0PhCbTpGCuEf_yQ-1; Fri, 16 Feb 2024 10:06:27 -0500
X-MC-Unique: d6VkizI0PhCbTpGCuEf_yQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d23c8694dso159520f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708095986; x=1708700786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPBTdysDYpPiACBe5cKL5ETdbaaMEMrm03T0DAO6ASg=;
 b=A0Wx77Zg8MVck3n02XpHhnyhWJXGvoOFx9NIMm5w7l3URQPaBEei8t5bSrGjJA7TkR
 DQTWx8I1EePi4AUkX1g4jJbLO9FSQ9v6JvYfjYGERUrnlsQfwPetGxCnYYPc73B9yYT7
 ErwYCAACb85s7PmJDeoCiliv4dbeMGO7sP4lOMxu33wF4dGY9Ih/+h7PARmYgNBj25UL
 mwu/v+xgWT/7IjeZBeHcVXpIQ4QIbrN52XLnz/81nvFzALjyrSXZr+zNLmmGhd6zlLnD
 pWeWAmMgfxQvmi/Qh5ayXRdkI/B7jp2a7MlEBQyY65AKVEAWYgwDmRenvdMcyL0Dcr2f
 34tw==
X-Gm-Message-State: AOJu0YwBXFWhmhzx8cuAkeKuEmV/BAgj0FvuATtDkJ8LgZnbN66Oo8nA
 2biSd9rJCQ3yVgk+0ZGJyE6v+UHqjHQ6taMvNimmwymzI8vn9tl5pSYr/TzRFas1r28fdOZhA4e
 xzKYOgZGDzEgODBeBtwXLxE/LGKiKTHkWAAbx/Onpg0+XvKo+bc96Fjztzl0U1NiIcrCCj0ISua
 +6JTdWqOGw1TYNBtyMTjnBNEIUp8k=
X-Received: by 2002:adf:a30e:0:b0:33d:1f21:2dd with SMTP id
 c14-20020adfa30e000000b0033d1f2102ddmr1385083wrb.40.1708095986567; 
 Fri, 16 Feb 2024 07:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6nb+V5JIUApGsbqtuvHC1+amCjLEW74NDgmopjTNFkQqUwUy/KpRDF9zaSew+lpAWDcwhzXC54uzrYLovztI=
X-Received: by 2002:adf:a30e:0:b0:33d:1f21:2dd with SMTP id
 c14-20020adfa30e000000b0033d1f2102ddmr1385068wrb.40.1708095986202; Fri, 16
 Feb 2024 07:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20240216091621.32989-1-thuth@redhat.com>
In-Reply-To: <20240216091621.32989-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Feb 2024 16:06:00 +0100
Message-ID: <CABgObfYf7Yy3sfDSfU7v+RFLsa5VShC9FSiNCd0CkJyun6vkbA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 16, 2024 at 10:16=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> When running "configure" with "--without-default-devices", building
> of qemu-system-hppa currently fails with:
>
>  /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in function =
`machine_HP_common_init_tail':
>  hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
>  /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to `usb_create_s=
imple'
>  /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_find=
'
>  /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_create_s=
imple'
>  collect2: error: ld returned 1 exit status
>  ninja: build stopped: subcommand failed.
>  make: *** [Makefile:162: run-ninja] Error 1
>
> And after fixing this, the qemu-system-hppa binary refuses to run
> due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
> the right config switches to fix these problems.

USB_OHCI_PCI is something similar to what was going on with the
Loongsoon virt machine, and Philippe asked me to look at removing
usb_bus_find() everywhere. But I have no objection to having this
patch committed in the meanwhile.

Paolo

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Keep "select SERIAL" instead of replacing it
>
>  hw/hppa/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index ff8528aaa8..dff5df7f72 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -7,6 +7,7 @@ config HPPA_B160L
>      select DINO
>      select LASI
>      select SERIAL
> +    select SERIAL_PCI
>      select ISA_BUS
>      select I8259
>      select IDE_CMD646
> @@ -16,3 +17,4 @@ config HPPA_B160L
>      select LASIPS2
>      select PARALLEL
>      select ARTIST
> +    select USB_OHCI_PCI
> --
> 2.43.0
>


