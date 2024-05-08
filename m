Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DA3C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dA8-0005bF-3Z; Wed, 08 May 2024 05:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4dA6-0005ZA-F7
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4dA0-0002w5-Qt
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715158823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BRDsURdb3omi4rlCN6SqkGJ78a38FdCWlJAFnp5jlRA=;
 b=FXkIdm54FTUdIDXE+SRjMNDWTvue5IIHzga0zAyCFqULxZHB5brloSChMwEaIuuKR+I62g
 tChKKATVMJVKm1A5G+O+R6UCc9HwFrnvC4wvhzjuHu37x/95FFTEXRMtufG1XF0H+/DxNr
 zyMm9Yti24tKChQ4HOqhRP1HWUXnKI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-rNThUCoZNU2EhMPWIr2-QQ-1; Wed, 08 May 2024 05:00:21 -0400
X-MC-Unique: rNThUCoZNU2EhMPWIr2-QQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41e8954066aso14157365e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715158820; x=1715763620;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BRDsURdb3omi4rlCN6SqkGJ78a38FdCWlJAFnp5jlRA=;
 b=RTOk7m8bSanP5j1OEkM058haszcT7gj6Jy0IZREtdvwKUcAdupjTN6GWMBIv6Rih14
 AE5HGNY263/9WvyCi+mooj8bjtwxl3JVNVvr9dFrxAtkgsQbBZgGuXcxh7FSlVdaOrm/
 kgd7UmpNruxcsBPSCm0Wl8cJhIcZ1FeDe+Hbi7TTNUbaTJ4UagwvyUg6HWpiOB5A5Rso
 /y5+0Nj+cTAwAtfsg3nC8lgTH/D+gHBn+n5n2HR6D5bl4QBj5T/HlS/yccoRKkzUA4ij
 dCohE6hBDoXbz6SBqDTnMk7EDRFqkKtxEsO9fFtoB3lTIT1reXUmNgH7Tb1klmFC23On
 PkAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW7DE7pDyt0266BlKzfH1tPVJ7iiwuI7jsjo+tlusXuMeU2kUPimucymEYdTPbtkUZPadMjJUyF76lXEuI3/reL1KQUvo=
X-Gm-Message-State: AOJu0YzPqId0Dk9Besk8H42SvopfOcZnef/ZIfgyQ6k8+wCtIVBzl7jb
 3Gsn6Cco4/SprNZ27C5s+G1RhS8enkDjjVjDuRloTIyojJpqRJWiFjzM0b4ag5gU8GSZ8v0b0ku
 Qs5rjPeYZmrENlL84LhIg4gLAF2Y89uCEDrl3py2ZdpFTj5ZoFqhL
X-Received: by 2002:a05:600c:1f1b:b0:41b:e406:5ae6 with SMTP id
 5b1f17b1804b1-41f71ccc1c7mr13630575e9.9.1715158820352; 
 Wed, 08 May 2024 02:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+w45gIE92cdh+gbTRfOBULt/VuGaWAGaLh1YxRxCSlVYCQxl+jhdOx1uqTFuVN0oPKREngQ==
X-Received: by 2002:a05:600c:1f1b:b0:41b:e406:5ae6 with SMTP id
 5b1f17b1804b1-41f71ccc1c7mr13630385e9.9.1715158820018; 
 Wed, 08 May 2024 02:00:20 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c235b4sm15429905e9.11.2024.05.08.02.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 02:00:19 -0700 (PDT)
Message-ID: <4ce31fa5-16b0-491c-9956-35ed68af2a6f@redhat.com>
Date: Wed, 8 May 2024 11:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/boot-serial-test: Add support on LoongArch
 system
To: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508085514.2510592-1-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240508085514.2510592-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/05/2024 10.55, Bibo Mao wrote:
> Add boot-serial-test test case support on LoongArch system.

... and also the filter tests?

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tests/qtest/boot-serial-test.c | 10 ++++++++++
>   tests/qtest/meson.build        |  4 ++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
> index e3b7d65fe5..631015e8c8 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -129,6 +129,14 @@ static const uint8_t kernel_stm32vldiscovery[] = {
>       0x04, 0x38, 0x01, 0x40                  /* 0x40013804 = USART1 TXD */
>   };
>   
> +static const uint8_t bios_loongarch64[] = {
> +    0x0c, 0xc0, 0x3f, 0x14,                 /* lu12i.w $t0, 0x1fe00    */
> +    0x8c, 0x81, 0x87, 0x03,                 /* ori     $t0, $t0, 0x1e0 */
> +    0x0d, 0x50, 0x81, 0x03,                 /* li.w    $t1, 'T'        */
> +    0x8d, 0x01, 0x00, 0x29,                 /* st.b    $t1, $t0, 0     */
> +    0xff, 0xf3, 0xff, 0x53,                 /*  b      -16  # loop     */
> +};
> +
>   typedef struct testdef {
>       const char *arch;       /* Target architecture */
>       const char *machine;    /* Name of the machine */
> @@ -181,6 +189,8 @@ static const testdef_t tests[] = {
>       { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
>       { "arm", "stm32vldiscovery", "", "T",
>         sizeof(kernel_stm32vldiscovery), kernel_stm32vldiscovery },
> +    { "loongarch64", "virt", "-cpu max", "TT", sizeof(bios_loongarch64),
> +      NULL, bios_loongarch64 },
>   
>       { NULL }
>   };
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 6f2f594ace..6619b630e6 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -256,6 +256,10 @@ qtests_s390x = \
>   qtests_riscv32 = \
>     (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>   
> + qtests_loongarch64 = \
> +  qtests_filter + \
> +  ['boot-serial-test']

It's already a little bit messed up, but I think we originally had the 
entries in alphabetical order, so I'd like to suggest to add this between 
qtests_hppa and qtests_m68k instead.

  Thomas


>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(
>     'ac97-test.c',
> 
> base-commit: 4e66a08546a2588a4667766a1edab9caccf24ce3


