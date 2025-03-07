Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8E0C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZs7-0007yZ-8h; Fri, 07 Mar 2025 10:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tqZs5-0007xq-3B
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tqZs3-0005yq-Ma
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741362257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExNoEaAp2+v6zoMqtSlPYfiA7ipYxOfcSqAT4+FMhvo=;
 b=V/XwbGk6S7GmHODE8Vk54J7WnfMMutJcYsmZlK1B9ynGV1rWrGvF2uCeLDsskQ0y6LyYfI
 ixh0Wa58ZSP8mdKKvWX4xWWqqudMBbKGekKtlIHL/YJ9PfNdrklDWEG3fEuBElCJBeYQJi
 aUPZb0zcLLaFSkc2NPmd1tssHsVckBw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-7nhYf3JJO8mMYhYOtNuwcw-1; Fri, 07 Mar 2025 10:44:14 -0500
X-MC-Unique: 7nhYf3JJO8mMYhYOtNuwcw-1
X-Mimecast-MFC-AGG-ID: 7nhYf3JJO8mMYhYOtNuwcw_1741362253
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abf597afe1fso214394766b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741362253; x=1741967053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExNoEaAp2+v6zoMqtSlPYfiA7ipYxOfcSqAT4+FMhvo=;
 b=cXnf3F/aZAx06CjoP331XKfb2P5c39l9SrMXOcn4ZYiGwFyh2czbo1ar/9lIqBuNVY
 WXUfv54+ldImlxPa7Lp2edBg33FaljgohWN1keZK905n4wWemtdcW+IsQgz0t2GMbSAg
 w5xTE2YJPwsNtFGhmhuA2Ac3Xibf0gzFtvJux/6T64wG3C7HsBk0CY7TonZcF/v96Vsg
 J5YmDcNC7MhbSgXg2iu/o3qe9fadEfU75fJUQm4U54gPQv8eCEPXKhCERrWq1WhXL5EW
 zdQgOWlTbMKaFUuYXUMqXZbkNLcINVK+XamuAL3JVwtFtekitSRXsZxCnGmRm1l4VDrg
 Mcrw==
X-Gm-Message-State: AOJu0Yz2aJ0mqF4jTbzM2ThnHjJ/JeJj7kbX2IRZcBV93GrH3P8ZVz3z
 EL6mXMj/GP0lnigm0G9+aSFPZmVxXnnx4ZZZtrLSxcbdDzkX9Z4PoipY0ALeV08dlmqMU3bYA/F
 uomd+MF3M3wahORmk1oj+pJPkvGwVG6pWyhR04kA9QfPcK4TgBCgK8DkTw0nYEZC44Ka85LMa8E
 RyDidvYhPwn01zLvFmF0cXpBj6f28=
X-Gm-Gg: ASbGnctsiB21xU2t2n01jIB9c0GI5mDrGBxfoHYDwak+2RUitLLMdV12IRvgVvPPw3t
 aS0TIoo7A/WJk8Lc6JqIyxloMTZaoWuCrvQlIsWVE22PmVzm9AfjP9W41D9Ko8HM2JDwohErfKQ
 ==
X-Received: by 2002:a17:907:7ba4:b0:abc:c34:4130 with SMTP id
 a640c23a62f3a-ac2525f958amr461829666b.18.1741362253078; 
 Fri, 07 Mar 2025 07:44:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBhfEvRBvvbQnFO7uRM8km/LIbveqMa9TaesbiIbVLXy9D5vhSrVCqEhb6vNm1u4W3O7WGRr/734aII2WVti4=
X-Received: by 2002:a17:907:7ba4:b0:abc:c34:4130 with SMTP id
 a640c23a62f3a-ac2525f958amr461826466b.18.1741362252776; Fri, 07 Mar 2025
 07:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-4-philmd@linaro.org>
In-Reply-To: <20250307151543.8156-4-philmd@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 7 Mar 2025 21:14:01 +0530
X-Gm-Features: AQ5f1Jra3rsqhm6dMYwg84R33Er4u6ws-CK9eOS6smI5xTSB7cavKI6cH0q_A_U
Message-ID: <CAK3XEhO0oAJBvzfFsrztPah14qr7pWhUrq9+eRMXXh0cbuKTdQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/i386/fw_cfg: Check ACPI availability with
 acpi_builtin()
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Replace the compile-time CONFIG_ACPI check by a runtime one.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/i386/fw_cfg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index d08aefa0291..a7f1b60b98c 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -145,10 +145,10 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>       */
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
> -#ifdef CONFIG_ACPI
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
> -                     acpi_tables, acpi_tables_len);
> -#endif
> +    if (acpi_builtin()) {
> +        fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
> +                         acpi_tables, acpi_tables_len);
> +    }
>      fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
>
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_c=
fg));
> --
> 2.47.1
>


