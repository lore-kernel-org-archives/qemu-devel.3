Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CF5C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokYu-0003qH-Cn; Mon, 25 Mar 2024 09:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokYt-0003pn-Br
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:40:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokYr-0000LF-Cp
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:40:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4147e135f4dso18455755e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711374024; x=1711978824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6MuEQSkb/kt5823ISGd/KisLUiiIt3CnAcazZPSXC4=;
 b=DFKufq7J9/x4+E5Z499QVNIIoHKt7GOt8pxofAUcp2qyQmmYAuegs4c+52UeX2ETMg
 Xgo4vYH+jqsV0CAxFi8u1wiqBSeEwsgPxMOrLBqVs7Qi4pSQ1k0oRKSIxXeMJy/Lz/mP
 swJLx3obio/nc8AY8DFgw3xkwmY63h9ADM2B+r5YJcj4HIvVoLaTah5b/2M4KGWyKUCn
 mDca1FbhIQa3j8lcwRg2vOKiKp9g3PAJxnXZQvRXSeDlOzTJD8Rhae7d4qVD8kFWIMlA
 nTGStJGyhYGJBO6WvdK93l85r+Qk7DZ0b943OKm90ygAMrsjsBzCq6LHqoL6lg2J8PUE
 wC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711374024; x=1711978824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6MuEQSkb/kt5823ISGd/KisLUiiIt3CnAcazZPSXC4=;
 b=DvWs15QYzq5DDVBsjNrGovJ0758E3qtX6dCNihEOINW6WYURHHebywRX5TpfRiJtis
 zQcBg6DBjwFfdsGpIFmSr83BGf3KOh/97Tj6GkOul7z78yRmz3MXffdNN62//FsJhJeP
 Me/F84TjFirkBdT1BfrEN9edNChyfjHDdRn6MGJy+7aAUs2HhkdXTnrfTcN5BH+BN+z8
 QUJFVC54TKKTOF8btsnu7xOmr906iFKljUPs7GA+cIC7dgMm1s5jEh0wdQ+pbRhb5Uhs
 /8ydbTOrL/UQ40orT7dk0NPzTjzto2UxKp6z1FTUJUx0qPL5f1OHgAbAj82jboP5Az3B
 0GkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKD7OG8VJuM1ZRa8cOzDpz8tHh1TAgrwp6kCo7w2WMUNtVcPMErDR3lkXMGJ4ryHllxV208W7ul/kYZgynJvv3TVhKAzY=
X-Gm-Message-State: AOJu0YylbZHwIJ8w7byW5MvE+iu9barRdLL+BYtj4XNoKnarCgox/kEm
 tSnlbjsB28U5Fpd3DtugMvY3uEPVKLsbCltqauQ8LFTWFzEk15v5CQDlOw0KW2k=
X-Google-Smtp-Source: AGHT+IHNsNG6BHUhvFMTG55UDBvRU+R3T9K/XOHcrTxNCYrdHMtF+hiVFyMOoEjJMfEZOsVmXzVrvQ==
X-Received: by 2002:a05:600c:4da4:b0:413:f290:c747 with SMTP id
 v36-20020a05600c4da400b00413f290c747mr5171829wmp.33.1711374023661; 
 Mon, 25 Mar 2024 06:40:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05600c198900b0041330d49604sm8527103wmq.45.2024.03.25.06.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 06:40:23 -0700 (PDT)
Message-ID: <ca6b1ae9-14b9-413b-93dc-a28d930b0e3a@linaro.org>
Date: Mon, 25 Mar 2024 14:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios
 build
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20240325130920.349521-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240325130920.349521-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Michael,

On 25/3/24 14:09, Michael Tokarev wrote:
> When building qemu with smbios but not legacy mode (eg minimal microvm build),
> link fails with:
> 
>    hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
> 
> This is because fw_cfg interface can call this function if CONFIG_SMBIOS
> is defined.  Made this code block to depend on CONFIG_SMBIOS_LEGACY.
> 
> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/i386/fw_cfg.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index d802d2787f..d5e78a9183 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -70,6 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>       /* tell smbios about cpuid version and features */
>       smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
>   
> +#ifdef CONFIG_SMBIOS_LEGACY
>       if (pcmc->smbios_legacy_mode) {

But then having pcmc->smbios_legacy_mode == true without
CONFIG_SMBIOS_LEGACY would be a bug. IMHO what we want is:

-- >8 --
diff --git a/hw/smbios/smbios_legacy_stub.c b/hw/smbios/smbios_legacy_stub.c
index f29b15316c..7d593dca98 100644
--- a/hw/smbios/smbios_legacy_stub.c
+++ b/hw/smbios/smbios_legacy_stub.c
@@ -13,3 +13,8 @@
  void smbios_add_usr_blob_size(size_t size)
  {
  }
+
+uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
+{
+    g_assert_not_reached();
+}
---

>           smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
>                                                   &error_fatal);
> @@ -77,6 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>                            smbios_tables, smbios_tables_len);
>           return;
>       }
> +#endif
>   
>       /* build the array of physical mem area from e820 table */
>       mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());


