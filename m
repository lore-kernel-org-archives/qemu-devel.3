Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD42C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 10:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM3iu-0004dS-HY; Tue, 25 Jun 2024 06:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM3it-0004dK-DT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM3is-0005sU-1Z
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719312505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mQ99lHkIq3DfHEjy/RgutHBBcsK/k6F3d8XvkKQD8g=;
 b=SLLs95Bh7ebrB/TYzNQTX9p6FtAcyvmVwmhCAjRGhMq+VXtrAiRGRgGH6ewOMv+SQ6zBfS
 r0io5H1DSPIBvVQlOJfB/LRTMFWpdrx+qEV7/m2P9i4sfkb4uurtPt/jEZ3wNMU/y6Bzlj
 9odGv6dfVJj99h1NiowkDfAyRZ14EmQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-VyDPNjbWMXG2xl1gEjsMLA-1; Tue, 25 Jun 2024 06:48:20 -0400
X-MC-Unique: VyDPNjbWMXG2xl1gEjsMLA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4229bde57easo34893595e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 03:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719312499; x=1719917299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mQ99lHkIq3DfHEjy/RgutHBBcsK/k6F3d8XvkKQD8g=;
 b=mQeG2qS5MOdaFR1/qJaH+wKvgfuuErSdGwU0P+Q7dy1id1ZYAO+9KG17+jweWuYM0t
 nFFc9dQJZ3S7CGwNLowv7n+YOl420VTBDBylaHyoNRCAYyQw0kv0wn+1OiFSRQlHPcNX
 llOklMN/uBPpeUUdvcmypIHYsHntzsiC88SW4sEL+P8HsJIoxT9lAE/Cyl+hZKjP2X5b
 OE/qiLVrlnml6go72MsqRfW7ELKPmf76cFC3BE44hdddks/iXPjQpvafa2YlSdB0g86C
 UqIk4txg4XyvNrA0l/4uSJSadi5977BvursladQR1aa1UFm9gDqgzG/hnTZE5lrC2qIQ
 /rUQ==
X-Gm-Message-State: AOJu0YwqdnD9YopC9osrBYgh72U/z/agGtIqFR1SAVMPConHdyP5yZDN
 Rn8/LDlZ3gXLRWI64/n4clY3NFC0Yx69AWi/VVkdWr3ZRGCc9NdhjzfxNb9MAat3XURxIHW2cuN
 kUAEx5cKlSP1tbRvxaOJGVO+OrreVEiPNT4KAzwIWJggVFXWaJubq
X-Received: by 2002:a5d:5f49:0:b0:366:f713:bf05 with SMTP id
 ffacd0b85a97d-366f713c0f0mr3926626f8f.64.1719312499132; 
 Tue, 25 Jun 2024 03:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3oVYc1iXsoi6BD1dJyg6HQ20OHs2Mbk4XLJF7QxD0EJHqKRfbgJgmH5zeQRUGx1/F2r+x+Q==
X-Received: by 2002:a5d:5f49:0:b0:366:f713:bf05 with SMTP id
 ffacd0b85a97d-366f713c0f0mr3926602f8f.64.1719312498653; 
 Tue, 25 Jun 2024 03:48:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c1d1sm12589567f8f.51.2024.06.25.03.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 03:48:18 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:48:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 05/15] tests/qtest/bios-tables-test.c: Add support
 for arch in path
Message-ID: <20240625124816.48183def@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240621115906.1049832-6-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-6-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Jun 2024 17:28:56 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Since machine name can be common for multiple architectures (ex: virt),
> add "arch" in the path to search for expected AML files. Since the AML
> files are still under old path, add support for searching with and
> without arch in the path.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index c4a4d1c7bf..29c52952f4 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -78,6 +78,7 @@
>  typedef struct {
>      bool tcg_only;
>      const char *machine;
> +    const char *arch;
>      const char *machine_param;
>      const char *variant;
>      const char *uefi_fl1;
> @@ -262,8 +263,19 @@ static void dump_aml_files(test_data *data, bool rebuild)
>          g_assert(exp_sdt->aml);
>  
>          if (rebuild) {
> -            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
> +            aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir,
> +                                       data->arch, data->machine,
>                                         sdt->aml, ext);
> +
> +            /*
> +             * To keep test cases not failing before the DATA files are moved to
> +             * ${arch}/${machine} folder, add this check as well.
> +             */
> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> +                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir,
> +                                           data->machine, sdt->aml, ext);
> +            }
> +
>              if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>                  sdt->aml_len == exp_sdt->aml_len &&
>                  !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> @@ -398,8 +410,13 @@ static GArray *load_expected_aml(test_data *data)
>          memset(&exp_sdt, 0, sizeof(exp_sdt));
>  
>  try_again:
> -        aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
> -                                   sdt->aml, ext);
> +        aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->arch,
> +                                   data->machine, sdt->aml, ext);
> +        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> +            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
> +                                       sdt->aml, ext);
> +        }
> +
>          if (verbosity_level >= 2) {
>              fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
>          }


