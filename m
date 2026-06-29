Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B710AC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weA0v-0003vf-Lk; Mon, 29 Jun 2026 07:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weA0q-0003v7-Ue
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weA0o-0001gL-Q6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 07:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782731929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K1eo34HDlJf8DxUgko0Ua0AT3spbAIisH7eKoas4rug=;
 b=UUVrcsq4/YI7r/MrpfrMEBrRo0gzGMBPiXgOXY1SrF0PjxB9VdtEgE+DsBs56RHHqKAqiD
 ROC/AwkMKGiYB9OmVg6Bsb8f0wTrSetLMb41Sewv1zs9NWtxoE6Ylvq0yVJEHCtlNxhYmK
 wq3DSl1d03vSs/RAs2Rqww2SevA9TkQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-693DqAU8MkqtKJGq4JtwAw-1; Mon, 29 Jun 2026 07:18:48 -0400
X-MC-Unique: 693DqAU8MkqtKJGq4JtwAw-1
X-Mimecast-MFC-AGG-ID: 693DqAU8MkqtKJGq4JtwAw_1782731927
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so475691f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782731927; x=1783336727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=K1eo34HDlJf8DxUgko0Ua0AT3spbAIisH7eKoas4rug=;
 b=SpzbriqY39yYlDgujCK3AnL0aA7cUqNTSHfx4urW57iq5ouDudYZe0zTDaYKEma93O
 pd8kZ4ZZBma0UMW3gIdzJiRLTXmISkjwf2iyDkoYAOdmqOlGdw91As66DSzvHDInYHT0
 2LkumDhMuhx/xTrBcJwCJ735ndwAFI1ujfJr4AjMOYtcb8n9DeOCWuDm4T0OyLOz7BpA
 VSLI0KED7ltAqnWm0C1DtZYu8RLSJ2Nljp0IFKJd/SzJQnjVO+CqQeptXUCl8LTzX3ib
 j9h1H+wZ7NiWwuLupa7DJERCJ0L5GGqfXlRkw2mMsRp9+f0VBZXEbjHSUISVjq7dVDQR
 6Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782731927; x=1783336727;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1eo34HDlJf8DxUgko0Ua0AT3spbAIisH7eKoas4rug=;
 b=Z5+1qJ/B+FCs7VU1JgBpIWPxFnOPXlUq0sl0aHGr1H3HykstJxy+Phlwz5H/Q4P42S
 hl7zEjwUXUayAzZU3a+RwJs+ZIoSj2jsDWCys2h3omwhec1blCfjBgpkbkTvcNp+Ecw7
 2XXLhRlYcUXzHq7eatE9gZhyLcAmS0YSEss8Z5lQWGfj92h6chOZ5ckK8F/BVfiPVxjZ
 8N1EeBJjGeQpleow22bx7ANhkcnrKIjTlK2212iXup1F/oLlPNbobIwziBr4AnpXxI2+
 ES+wawmPmZVpTIsbjpsYMmLxOlndVqGM2iQxfxLkRlJy3H+xi/hHAAfhUfOuLz2AIMdO
 pWaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC0rs1ZQiuWAb4vmHSfgbqokyHDv1PLjr6P/CeEU5FobCLSQib+Ko3ced+xiQ9YyO+tIOde6bCOuGr@nongnu.org
X-Gm-Message-State: AOJu0YwbUG+aoqnV7BKBQP93Iz7ztF5DB+rELATa/jo6LaoomSOII32S
 LInHs3Dfqrm720LmQ0QVqgw33mJjcbLwMtKraraU195SjrcDB7Censk+NEb/zqZwBaZ//LSJ9bN
 828THz2u4xiTlTEo4mQZaeo+aeD6RXH3X6tUArVpqRZA8ZSRCLPcWpCqY
X-Gm-Gg: AfdE7cm9juqzNgZG1UYNuhymwSxweHzwnFTzISRPUVBSNmY884b46OZjlhOh557xydf
 U/WIwPvqGyty+P9BQ1nt0gqb5B0cEzQQR5XF7kZNqBMXVgOtWHWClUAtit06CJAY+gz1+KqZ5ve
 S+Bv6H9JzzUJ/eqpJ/1oWmcy9+zM9nNmYxxEgmzj/SCqG9ehGGeMXpa5K9Gjwb7oPA5a82c5HII
 xKmmh4auGuXaXhCAPWaedtf0V1f4zXckAvWon9vMS/KOOpQMpwoAcNOJS2+t/P1M8XtYQqbDSsx
 DkbXEjveiVsq2bR7xaVCnBE6MChg1YpKOUb15Wq+8pH7lR78rjZSdUon7Py5i3zt6bQttq6pt/1
 xNGZE/fqr5tM+/Sq9Kl/xWzeRkKl0ds6wtb0XObvOinpkWTEPJw==
X-Received: by 2002:a05:6000:220e:b0:473:e954:6ac7 with SMTP id
 ffacd0b85a97d-473e9546e61mr4047420f8f.2.1782731926676; 
 Mon, 29 Jun 2026 04:18:46 -0700 (PDT)
X-Received: by 2002:a05:6000:220e:b0:473:e954:6ac7 with SMTP id
 ffacd0b85a97d-473e9546e61mr4047358f8f.2.1782731926123; 
 Mon, 29 Jun 2026 04:18:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4721c88bfcasm20051303f8f.10.2026.06.29.04.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 04:18:45 -0700 (PDT)
Message-ID: <32d7c4b1-dbb9-485b-8feb-df999532de60@redhat.com>
Date: Mon, 29 Jun 2026 13:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] tests/qtest: Add Power11 chip & machine to qtests
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-4-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260629110411.3051274-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/29/26 13:04, Aditya Gupta wrote:
> Previously the machines/chips tested by qtest was till Power10, update
> the tests to also test PowerNV11 and Power11 PNV Chip
> 
> Since if-else-if ladder was common pattern to get machine type,
> implement pnv_get_machine_type so new processor cases can be implemented
> in one location in pnv_get_machine_type
> 
> While at it, also add g_autofree to allocation by g_strdup_printf in
> modified tests
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/qtest/pnv-host-i2c-test.c    | 10 ++++------
>   tests/qtest/pnv-spi-seeprom-test.c |  2 +-
>   tests/qtest/pnv-xive2-test.c       |  2 +-
>   tests/qtest/pnv-xscom-test.c       | 22 +++++---------------
>   tests/qtest/pnv-xscom.h            | 32 +++++++++++++++++++++++++++---
>   5 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
> index 51e613ebdcb2..5fd54f9de771 100644
> --- a/tests/qtest/pnv-host-i2c-test.c
> +++ b/tests/qtest/pnv-host-i2c-test.c
> @@ -402,15 +402,14 @@ static void reset_all(QTestState *qts, const PnvChip *chip)
>   static void test_host_i2c(const void *data)
>   {
>       const PnvChip *chip = data;
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
> -    const char *machine = "powernv8";
>       PnvI2cCtlr ctlr;
>       PnvI2cDev pca9552;
>       PnvI2cDev pca9554;
>   
> -    if (chip->chip_type == PNV_CHIP_POWER9) {
> -        machine = "powernv9";
> -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> +    /* i2c is initialised for rainier in case of P10 */
> +    if (chip->chip_type == PNV_CHIP_POWER10) {
>           machine = "powernv10-rainier";

Is that true for all tests ? in that case, pnv_get_machine_type()
could return "powernv10-rainier".


>       }
>   
> @@ -473,10 +472,9 @@ static void add_test(const char *name, void (*test)(const void *data))
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> -        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
> +        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
>                                         pnv_chips[i].cpu_model);
>           qtest_add_data_func(tname, &pnv_chips[i], test);
> -        g_free(tname);
>       }
>   }
>   
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> index 1a78e8d966a5..8bb30eb649aa 100644
> --- a/tests/qtest/pnv-spi-seeprom-test.c
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -77,7 +77,7 @@ static void test_spi_seeprom(const void *data)
>       const PnvChip *chip = data;
>       QTestState *qts = NULL;
>       g_autofree char *tmp_path = NULL;
> -    const char *machine = "powernv10";
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       int ret;
>       int fd;
>   
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> index 5313d4ef18b7..80de9d09ed09 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -548,7 +548,7 @@ static void test_xive(void)
>   {
>       QTestState *qts;
>   
> -    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
> +    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
>                         "-nodefaults -serial mon:stdio -S "
>                         "-d guest_errors -trace '*xive*'",
>                         SMT, SMT);
> diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
> index c814c0f4f5b1..94b50c071c02 100644
> --- a/tests/qtest/pnv-xscom-test.c
> +++ b/tests/qtest/pnv-xscom-test.c
> @@ -28,15 +28,9 @@ static void test_xscom_cfam_id(QTestState *qts, const PnvChip *chip)
>   static void test_cfam_id(const void *data)
>   {
>       const PnvChip *chip = data;
> -    const char *machine = "powernv8";
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
>   
> -    if (chip->chip_type == PNV_CHIP_POWER9) {
> -        machine = "powernv9";
> -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> -        machine = "powernv10";
> -    }
> -
>       qts = qtest_initf("-M %s -accel tcg -cpu %s",
>                         machine, chip->cpu_model);
>       test_xscom_cfam_id(qts, chip);
> @@ -57,7 +51,8 @@ static void test_cfam_id(const void *data)
>   
>   static void test_xscom_core(QTestState *qts, const PnvChip *chip)
>   {
> -    if (chip->chip_type == PNV_CHIP_POWER10) {
> +    if ((chip->chip_type == PNV_CHIP_POWER10) ||
> +        (chip->chip_type == PNV_CHIP_POWER11)) {
>           uint32_t first_core_thread_state =
>                    PNV_XSCOM_P10_EC_BASE(chip->first_core) + 0x412;
>           uint64_t thread_state;
> @@ -84,14 +79,8 @@ static void test_xscom_core(QTestState *qts, const PnvChip *chip)
>   static void test_core(const void *data)
>   {
>       const PnvChip *chip = data;
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
> -    const char *machine = "powernv8";
> -
> -    if (chip->chip_type == PNV_CHIP_POWER9) {
> -        machine = "powernv9";
> -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> -        machine = "powernv10";
> -    }
>   
>       qts = qtest_initf("-M %s -accel tcg -cpu %s",
>                         machine, chip->cpu_model);
> @@ -104,10 +93,9 @@ static void add_test(const char *name, void (*test)(const void *data))
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> -        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
> +        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
>                                         pnv_chips[i].cpu_model);
>           qtest_add_data_func(tname, &pnv_chips[i], test);
> -        g_free(tname);
>       }
>   }
>   
> diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
> index 5aa1701ea768..eefe206a2007 100644
> --- a/tests/qtest/pnv-xscom.h
> +++ b/tests/qtest/pnv-xscom.h
> @@ -9,6 +9,9 @@
>   #ifndef PNV_XSCOM_H
>   #define PNV_XSCOM_H
>   
> +#include <stdint.h>
> +#include <assert.h>


Seems unrelated. Why do you need these includes ?

Thanks,

C.


> +
>   #define SMT                     4 /* some tests will break if less than 4 */
>   
>   typedef enum PnvChipType {
> @@ -17,6 +20,7 @@ typedef enum PnvChipType {
>       PNV_CHIP_POWER8NVL,   /* AKA Naples */
>       PNV_CHIP_POWER9,      /* AKA Nimbus */
>       PNV_CHIP_POWER10,
> +    PNV_CHIP_POWER11,
>   } PnvChipType;
>   
>   typedef struct PnvChip {
> @@ -60,15 +64,23 @@ static const PnvChip pnv_chips[] = {
>           .first_core = 0x0,
>           .num_i2c    = 4,
>       },
> +    {
> +        .chip_type  = PNV_CHIP_POWER11,
> +        .cpu_model  = "Power11",
> +        .xscom_base = 0x000603fc00000000ull,
> +        .cfam_id    = 0x220da04980000000ull,
> +        .first_core = 0x0,
> +        .num_i2c    = 0,
> +    },
>   };
>   
>   static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
>   {
>       uint64_t addr = chip->xscom_base;
>   
> -    if (chip->chip_type == PNV_CHIP_POWER10) {
> -        addr |= ((uint64_t) pcba << 3);
> -    } else if (chip->chip_type == PNV_CHIP_POWER9) {
> +    if ((chip->chip_type == PNV_CHIP_POWER11) ||
> +        (chip->chip_type == PNV_CHIP_POWER10) ||
> +        (chip->chip_type == PNV_CHIP_POWER9)) {
>           addr |= ((uint64_t) pcba << 3);
>       } else {
>           addr |= (((uint64_t) pcba << 4) & ~0xffull) |
> @@ -77,4 +89,18 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
>       return addr;
>   }
>   
> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
> +{
> +    static const char *const machine_types[] = {
> +         [PNV_CHIP_POWER8]  = "powernv8",
> +         [PNV_CHIP_POWER9]  = "powernv9",
> +         [PNV_CHIP_POWER10] = "powernv10",
> +         [PNV_CHIP_POWER11] = "powernv11",
> +     };
> +
> +    g_assert(chip_type <= PNV_CHIP_POWER11);
> +
> +    return machine_types[chip_type];
> +}
> +
>   #endif /* PNV_XSCOM_H */


