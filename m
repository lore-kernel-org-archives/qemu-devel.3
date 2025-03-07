Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE32C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZqg-0006t0-Tq; Fri, 07 Mar 2025 10:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tqZqf-0006sr-Su
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tqZqe-0003Qd-11
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741362169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SoxLa8rCXRjAf79S0Qtyb5MwFktxgBiLOHN77Jge0A=;
 b=DbVqQqs0S2nmvBBNbeE3NjJztzUjWkIq5w6ZcHvURr+8TifqXZqhekpsU3V60jpD/tfnBo
 pBuyWBWxeciWFXfUAWfDa7Ce2mfN4tlbxr1o61U3j1L//exh7yYXepEivRpvGeSRCWfOI5
 C6UPLVFxHL1PRvLw4rCaGCWz7LHTv3E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-SOO0E2HdMjOCMhLDMZd_oQ-1; Fri, 07 Mar 2025 10:42:48 -0500
X-MC-Unique: SOO0E2HdMjOCMhLDMZd_oQ-1
X-Mimecast-MFC-AGG-ID: SOO0E2HdMjOCMhLDMZd_oQ_1741362167
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac1dca8720cso226271466b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741362167; x=1741966967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SoxLa8rCXRjAf79S0Qtyb5MwFktxgBiLOHN77Jge0A=;
 b=u1g05L95nyBLP7RsKkSl8HKAR7DO1+Gw/6H1bVEzTYjLsu8pQeyGAJwyHJR0M/OO1J
 zjAj0jPDBj5QlRXWFn38eSIgpv/QhaoYwL4mnraesJ0OA8uR3eQ1vgXmIDgCpFNKkIya
 JwxkfeJtdJTXxjb66ePtx64ePYO4ISUI9ew/a5RySEL4qp7wrHkiMePVjUuE37Tmbm0O
 O/AasHk3BDXM7TfckCCHV+OfPuU8TN3+oAw5RgvQySTleGpQzMnYg6A+0QCiLrcScCXR
 bOE9u+UlTJNmmEcBBb46aY4Z4W0oq4DCO4/x5F2Kgh/vZn17RAo5I5TWny8Q5ZWeGPyb
 j7Mg==
X-Gm-Message-State: AOJu0YxIGcswiPklQRcUWZpezncVLVL2qmXfk34NKSnbK2dnj6XLjVUe
 Tz5xznn5wi+IKLaCJdjxOmo7OyB5XEsUimptJUae1L1HLMSMxFuWbHuGmr8y8zGIcdQUxF/wDFY
 k0gzruvbFP+ZlVUED6pQyRM6DD69kHbJk6XOlIZHfD6b8FA0QkcN4GQt+EsTRclbuBKdwu0cuf6
 804tD+/LKx37nW6+bm8Miby5hfCeg=
X-Gm-Gg: ASbGncug5RXFGHujOrImgKad1gDk15qgVXG7lFns7TFlfkys0omyYFWnqVlq7aH94/o
 QBa6uKk8nk0ORn43V5ckPJvFWVg/7UGS/7l+bQ7xkQrSy15vIPh3IplcYRc3f8BsXi34BvN6JdA
 ==
X-Received: by 2002:a17:907:94ce:b0:ac1:e1e1:1f37 with SMTP id
 a640c23a62f3a-ac25273af3dmr486273066b.10.1741362167322; 
 Fri, 07 Mar 2025 07:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5gMiJ2wyiUDzshtHVo3FckG9GoIp73K9+hfgkfhzPVLgzWqpqc9HeZzXl1i3GtPdpF5Pu6f2OxOxfZoX51UE=
X-Received: by 2002:a17:907:94ce:b0:ac1:e1e1:1f37 with SMTP id
 a640c23a62f3a-ac25273af3dmr486268566b.10.1741362166962; Fri, 07 Mar 2025
 07:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-3-philmd@linaro.org>
In-Reply-To: <20250307151543.8156-3-philmd@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 7 Mar 2025 21:12:35 +0530
X-Gm-Features: AQ5f1JowLkJcvz_0Kwnicw2NI-UnhThU1OVeUkO_BmitZhX28NqOmE8Nr0WC1qI
Message-ID: <CAK3XEhOGuvGgQZ67SLxTonV6Nge_1=zMF4ezsYygvhDjf3Jjqw@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/acpi: Introduce acpi_builtin() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 7, 2025 at 8:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> acpi_builtin() can be used to check at runtime whether
> the ACPI subsystem is built in a qemu-system binary.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Ah, very similar to something I did recently.
Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/acpi/acpi.h | 3 +++
>  hw/acpi/acpi-stub.c    | 5 +++++
>  hw/acpi/core.c         | 5 +++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index e0e51e85b41..d1a4fa2af84 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -150,6 +150,9 @@ struct ACPIREGS {
>      Notifier wakeup;
>  };
>
> +/* Return whether ACPI subsystem is built in */
> +bool acpi_builtin(void);
> +
>  /* PM_TMR */
>  void acpi_pm_tmr_update(ACPIREGS *ar, bool enable);
>  void acpi_pm_tmr_calc_overflow_time(ACPIREGS *ar);
> diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
> index e268ce9b1a9..790bf509e5d 100644
> --- a/hw/acpi/acpi-stub.c
> +++ b/hw/acpi/acpi-stub.c
> @@ -25,3 +25,8 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
>  {
>      g_assert_not_reached();
>  }
> +
> +bool acpi_builtin(void)
> +{
> +    return false;
> +}
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 870391ed7c8..58f8964e130 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -78,6 +78,11 @@ static void acpi_register_config(void)
>
>  opts_init(acpi_register_config);
>
> +bool acpi_builtin(void)
> +{
> +    return true;
> +}
> +
>  static int acpi_checksum(const uint8_t *data, int len)
>  {
>      int sum, i;
> --
> 2.47.1
>


