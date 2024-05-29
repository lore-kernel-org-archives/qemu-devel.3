Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE2AC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKG0-00041L-QK; Wed, 29 May 2024 10:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKFz-00040t-Hg
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKFy-0000pt-1h
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716992781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOMD8F9ksZ4auUcmXk5liNgJ88syReES2X7fMnPmge0=;
 b=HgaIp8ZkG0fnmbApyUjFRdb4naeDsVzxSRbdSHFOs8HQzul+FHfA8dyGCYwt0K6VPwkSNO
 CTbBwohcXlgWyq196L2z+RWIgcFAX+Ry3GV1GBhRo/UAwgaJ/otcISWtVgar0GMYowUU/x
 ShJhIXlwOk2F5i0BqAmmbw+zdcfSfeI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-B6PDLplfN5atPnF94eARkg-1; Wed, 29 May 2024 10:26:20 -0400
X-MC-Unique: B6PDLplfN5atPnF94eARkg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e95a73bf3cso20179661fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716992778; x=1717597578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOMD8F9ksZ4auUcmXk5liNgJ88syReES2X7fMnPmge0=;
 b=G9K1QCYeVbk+pbO2qoGQ3xvB13kxsK4RbupdCEmPk521boRMmfA+XWGRr86DMyX+WK
 kRTS0J4hRwu+YkY9KaYg9QTw30U6mS8NvLnJ8GOjtm5YHCV4tRRlj2/5DEZ/9IGMefF6
 aYw1ggCQO9Rxb0LIw190vSdHtm7qgQ8ZqxR/V5Dm/OOyOvgwKRtbhSqUl/7Vti8SPr94
 UHdoGJ2Bl9Yoi26kACxCawhMwR4y3m3msZuI1iHP/unT99wpolCvDEXcxXGB9ODhkO1c
 H8aiqFxwTayh4jBthcIx6pIAH8/hqYDVCdDUtsj8OTuDWRR5w489xFdCKDlYsjnVd5Hy
 rD3g==
X-Gm-Message-State: AOJu0YwmDmKH/ZELIxUDRsiDVIDozzHCSy2PC0qaRgDsZ/92Coxptk5o
 Pc5we2nvU+WOWTeA4Gq7lD/ZAX3sDNAho+pKX7J3u+wSh0lCjts3H0AoFZnm77ne693ESyBmYxI
 N47z9xOTRJ+HFvSMV5VLdt6evcePziE/HNR83K4OpVgDK/2pmJCR+
X-Received: by 2002:a2e:a36c:0:b0:2e9:866b:140c with SMTP id
 38308e7fff4ca-2e9866b14b4mr33199611fa.9.1716992778629; 
 Wed, 29 May 2024 07:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtQa6qFFFDo4GHB/X2td13t6d6cZDAhIxnkuuEUGZr3V7YljVzC1SUh3DYqtA8kPZCUbMtUQ==
X-Received: by 2002:a2e:a36c:0:b0:2e9:866b:140c with SMTP id
 38308e7fff4ca-2e9866b14b4mr33199421fa.9.1716992778143; 
 Wed, 29 May 2024 07:26:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564b762ca8sm14363998f8f.112.2024.05.29.07.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:26:17 -0700 (PDT)
Date: Wed, 29 May 2024 16:26:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 12/23] hw/smbios: Remove 'smbios_uuid_encoded',
 simplify smbios_encode_uuid()
Message-ID: <20240529162617.65dde102@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-13-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-13-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 29 May 2024 07:15:28 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> 'smbios_encode_uuid' is always true, remove it,
> simplifying smbios_encode_uuid().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

I'd squash this into previous commit, but won't insist.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
>  hw/smbios/smbios.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 8261eb716f..3b7703489d 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -30,7 +30,6 @@
>  #include "hw/pci/pci_device.h"
>  #include "smbios_build.h"
> =20
> -static const bool smbios_uuid_encoded =3D true;
>  /*
>   * SMBIOS tables provided by user with '-smbios file=3D<foo>' option
>   */
> @@ -600,11 +599,9 @@ static void smbios_build_type_0_table(void)
>  static void smbios_encode_uuid(struct smbios_uuid *uuid, QemuUUID *in)
>  {
>      memcpy(uuid, in, 16);
> -    if (smbios_uuid_encoded) {
> -        uuid->time_low =3D bswap32(uuid->time_low);
> -        uuid->time_mid =3D bswap16(uuid->time_mid);
> -        uuid->time_hi_and_version =3D bswap16(uuid->time_hi_and_version);
> -    }
> +    uuid->time_low =3D bswap32(uuid->time_low);
> +    uuid->time_mid =3D bswap16(uuid->time_mid);
> +    uuid->time_hi_and_version =3D bswap16(uuid->time_hi_and_version);
>  }
> =20
>  static void smbios_build_type_1_table(void)


