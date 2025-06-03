Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD4C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSup-0001qp-T6; Tue, 03 Jun 2025 10:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMSul-0001qb-Ha
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMSui-0002m6-NQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rL7JZNITIzVYoHRrpUOYJQiN5gTcywASsB1MYL+cmnY=;
 b=DTq9P10qWjRN53YfyiljrXB3KGrB5FhWQVkVcOv4tIi7TFge92XksVG1lMk0kSUQStjaTx
 yY73iqFs34/3guGceJ+kcTGp3sgZ9kD08I6WKqwhmOlGiSXoiOm3WhVtDPJN98w1RTpwyA
 q39gbRJMuKCXybqxCuhI2e4XwM13smA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-YCEDhkd0NMasQEJKiV_NyA-1; Tue, 03 Jun 2025 10:46:47 -0400
X-MC-Unique: YCEDhkd0NMasQEJKiV_NyA-1
X-Mimecast-MFC-AGG-ID: YCEDhkd0NMasQEJKiV_NyA_1748962006
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450cb902173so26182555e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962006; x=1749566806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rL7JZNITIzVYoHRrpUOYJQiN5gTcywASsB1MYL+cmnY=;
 b=IDJ2GZrKM+7YAv9c+f8fJKJhlaIr9VpHul0VWXKzF85WsJzJ5y8hs7vUMBXzeyGcUo
 bDLe9kYpq0NyJwk4lF9wnl7sRM4Z0ceAs0y9d6RoveZjXj+OyNSEcr65w3flu7zEo6w5
 XBSnCQvqhS7JlblK/2AQLI25AwBLvpv4tNju7zXomAFxwp05TLqMsMbZNvl6gjz5dFHt
 Yg0PY4wzEJa8izBdTKOQPi1wbg7jTCw4vH4DCVWg+vmTspWyneMmRLd8YT5SjNwcC2Q4
 dlAjcMk7o5yJr7Dbpd2nH6MAhjJFTV2nsGxfZlSyY67R/4gOzKpKyYDzJ+ma8n4PpOU/
 QlzA==
X-Gm-Message-State: AOJu0YxjgGjXy2k6vWQF5A/jp0JDr+aHs+xbUmy91ltivw3sT/9PJ3As
 wiB06S6hm0smAYdUbEQT+LHUOzZ48+c/DeC4RGDr/D+isnBIli0fwV+i8zkCCbpi1Tn2htZsi/0
 Phv+YHJB/PKyIYN/1niBbU7nEKJUAcmpA5xWc2kmV2y72aBsD+exrqsjJ
X-Gm-Gg: ASbGncvES9cOUzxRq7QDWVpBtf4rGo8GFyJs+2vXErK/6+r/qdtegBJPOuSDYFQmSZ6
 pZKXKfnHae+9Pv9yunEoo9zwn9srXeW07YaxYshhQpPjPwsQ1rHCRWSykA8yo4jG/JcvCGlQzvI
 uAmGLnI+3XBfo2+UZ/CXZ4UDHRHHuPopMEOLMr6KleslJ4x5vyvtztwl9A+zWr0Os8DsMGC+sdG
 +07T5c/BSFvtWbD6FNZEgt1D+6JkGNWbaD53QM3Ys8vmzF+9IJ5KvFI4KsAITGrzPknphMBs7ER
 lnJzJJnkCXYiMVWuf8jIGXFAFVHNb5yB
X-Received: by 2002:a05:600c:3acd:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-451e659a494mr30478255e9.3.1748962006459; 
 Tue, 03 Jun 2025 07:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6UxzPUvj78e/bymva1JmtEdilchoaO+XEuC+uYfKb3mpBlqVWBvAxahU8jzQ3tDT0qJHo5Q==
X-Received: by 2002:a05:600c:3acd:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-451e659a494mr30477905e9.3.1748962006052; 
 Tue, 03 Jun 2025 07:46:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f01sm18027728f8f.45.2025.06.03.07.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:46:45 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:46:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf
 <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v4 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Message-ID: <20250603164643.0eb609af@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250512083948.39294-2-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 12 May 2025 10:39:30 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
>=20
> Remove the qtest in test-x86-cpuid-compat.c file.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c                   | 13 -------------
>  hw/i386/pc_q35.c                    | 13 -------------
>  tests/qtest/test-x86-cpuid-compat.c | 14 --------------
>  3 files changed, 40 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0dce512f184..04213b45b44 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -791,19 +791,6 @@ static void pc_i440fx_machine_2_5_options(MachineCla=
ss *m)
> =20
>  DEFINE_I440FX_MACHINE(2, 5);
> =20
> -static void pc_i440fx_machine_2_4_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_machine_2_5_options(m);
> -    m->hw_version =3D "2.4.0";
> -    pcmc->broken_reserved_end =3D true;
> -    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
> -    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 4);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index c538b3d05b4..47e12602413 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -685,16 +685,3 @@ static void pc_q35_machine_2_5_options(MachineClass =
*m)
>  }
> =20
>  DEFINE_Q35_MACHINE(2, 5);
> -
> -static void pc_q35_machine_2_4_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_q35_machine_2_5_options(m);
> -    m->hw_version =3D "2.4.0";
> -    pcmc->broken_reserved_end =3D true;
> -    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
> -    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 4);
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-c=
puid-compat.c
> index c9de47bb269..456e2af6657 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -365,20 +365,6 @@ int main(int argc, char **argv)
>                         "level", 10);
>      }
> =20
> -    /*
> -     * xlevel doesn't have any feature that triggers auto-level
> -     * code on old machine-types.  Just check that the compat code
> -     * is working correctly:
> -     */
> -    if (qtest_has_machine("pc-i440fx-2.4")) {
> -        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
> -                       "SandyBridge", NULL, "pc-i440fx-2.4",
> -                       "xlevel", 0x80000008);
> -        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
> -                       "SandyBridge", "svm=3Don,npt=3Don", "pc-i440fx-2.=
4",
> -                       "xlevel", 0x80000008);
> -    }
> -
>      /* Test feature parsing */
>      add_feature_test("x86/cpuid/features/plus",
>                       "486", "+arat",


