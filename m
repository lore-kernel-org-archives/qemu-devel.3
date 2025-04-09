Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835A4C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 10:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2T5R-0001kt-Pz; Wed, 09 Apr 2025 06:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2T5G-0001jX-63
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:55:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2T5C-00009l-Tg
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:55:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4717016f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744196097; x=1744800897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jcBAbBd5FPIILIqTt7rvo07REbaJqjD83akAyEzos0E=;
 b=AcI83aw8xqMbKvhTi6WedIZgbDHKXhHx/MNwVldaakexeFaCf+0U9gdiVxkjSJS8Sh
 SLJ9qWd9Uh4vXjFzAltib1921W2FyaEHl90JaoyJRYu1VlnNkp3t5ya2vXfh5XYDzc2w
 KRsnIvCns9ZuG3735IM2S8sJgHtIIYzj3kehLuoXnoKbCvxk6o4G2UPANNHX/ti5CAA1
 l1KyfHvtaujY7Gd7mVsHlGuIy8sBhKzTAmKAbidTyvlBNpYRKDr1Um3kxpHtAq/f8nUP
 UpY0ZYQjxq86Pwl27631vSsgW/sI0bs4MUnCBwF/2LJRyV7iVd+uwXCAI2YKpSG9orLf
 JSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744196097; x=1744800897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jcBAbBd5FPIILIqTt7rvo07REbaJqjD83akAyEzos0E=;
 b=k2dbCbcD5YGfc8RoBNbs6WGXviG5BcTB5ru0AgxfNMM+Ms9f2EpDB2NpmuE5KPPvDt
 AOaYY+pH7HY7PqsE0U5z0wTzD8QtYgchaajwTreLTWuz+D73tMaHjw66M96Puz1MILSH
 sjR9Me/PRKWFwV3IhRGCCpx3BzghjgZlPQPargPob0IraMD26SNDF6Jr9b8dtp4ETn4g
 QhYv8AWDrAAjaQEt2GAJzoWnJkvxQKBw8awB8moFfVU8773tDPMc+/3NQiOHSQARCkr4
 0dlXX3sfFh+JNUfcdPrrd34ZjltlBuiMgDFHKcbJyCyrnErArqMyvEV48nIW/Dz1jaHa
 FQWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz7nPKe0t0FPZVceCu3pa3dBx4uFhDyFKGOzx6boNYeTneGJjophDzMzxToMgQ4HdkRgHlYDGNtSVZ@nongnu.org
X-Gm-Message-State: AOJu0YwDCd1O5DM739hqN1JFzqATRKuL3VQKn4sCyF8v0OrRi4QKOP9x
 eQffu8i078AJ64oP85UM/XxMU3s7nMUL7nsBs4BPOMUIKofARz8eiMPmOAQP+FM6yHdGmNUxPxM
 FrS0=
X-Gm-Gg: ASbGncslOBjd8cuQmXmH3EMKs0b8SjlwJ2iY9EgSKKKU0IZ8k/j+cWiYXYBZknoq6Pq
 R85wKfHxJPMk98pUybVWIspnwyeBywY+Ek2rwPZZv9z9lf+KoX1EHSqpW8Pqk1Mp6nj42hK6Lju
 iVm7ZNw1VDx6SBzxYEgnVyNEjKALt9gHfAoSkyNAWkwX7dgwTA5Axdt9S56bCJJy6VjRdT6cC8s
 YcIbimNVmTsu4oGDrFt1YaGLxlxa9YjpafkfSbCZy2lpgGB9gsSWEC0F17a2R6TDL7YWorj6iz/
 GJ0vG1CaxKpsNdRTUI0Kbn5rfb8xatIC0+9YfbjOcm/NZJ00GqGGoGy+pFRnzju4MZs08pAzqmX
 tDO6Pu+7hcT4=
X-Google-Smtp-Source: AGHT+IEv7Xxdb4HKM1O/QUHyqJdmOZet1wAx2IE66VhM4OMBEgcQ+cG2syd8513zhiem0AbxZJ42og==
X-Received: by 2002:a05:6000:2a10:b0:39c:1257:dbab with SMTP id
 ffacd0b85a97d-39d87cddd45mr1521437f8f.59.1744196097044; 
 Wed, 09 Apr 2025 03:54:57 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20625592sm16121325e9.10.2025.04.09.03.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 03:54:56 -0700 (PDT)
Message-ID: <e6cbd3ae-356d-4805-bca1-90b0e98c4d0d@linaro.org>
Date: Wed, 9 Apr 2025 12:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] various: Fix type conflict of GLib function pointers
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <2be81d2f86704662c9fa33ceb46077804e34ac77.1744032780.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2be81d2f86704662c9fa33ceb46077804e34ac77.1744032780.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Kohei,

On 7/4/25 16:45, Kohei Tokunaga wrote:
> On emscripten, function pointer casts can cause function call failure.
> This commit fixes the function definition to match to the type of the
> function call.
> 
> - qtest_set_command_cb passed to g_once should match to GThreadFunc
> - object_class_cmp and cpreg_key_compare are passed to g_list_sort as
>    GCopmareFunc but GLib cast them to GCompareDataFunc.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   hw/riscv/riscv_hart.c | 9 ++++++++-
>   qom/object.c          | 5 +++--
>   target/arm/helper.c   | 4 ++--
>   3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index a55d156668..e37317dcbd 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -102,10 +102,17 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
>       return false;
>   }
>   
> +static gpointer g_qtest_set_command_cb(
> +    bool (*pc_cb)(CharBackend *chr, gchar **words))
> +{

Why not use a GThreadFunc prototype, casting the argument?

> +    qtest_set_command_cb(pc_cb);
> +    return NULL;
> +}
> +
>   static void riscv_cpu_register_csr_qtest_callback(void)
>   {
>       static GOnce once;
> -    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
> +    g_once(&once, (GThreadFunc)g_qtest_set_command_cb, csr_qtest_callback);
>   }
>   #endif
>   

OK for the rest, but it might help to merge by corresponding maintainers
if split in 3 distinct patches.

> diff --git a/qom/object.c b/qom/object.c
> index 01618d06bd..19698aae4c 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1191,7 +1191,8 @@ GSList *object_class_get_list(const char *implements_type,
>       return list;
>   }
>   
> -static gint object_class_cmp(gconstpointer a, gconstpointer b)
> +static gint object_class_cmp(gconstpointer a, gconstpointer b,
> +                             gpointer user_data)
>   {
>       return strcasecmp(object_class_get_name((ObjectClass *)a),
>                         object_class_get_name((ObjectClass *)b));
> @@ -1201,7 +1202,7 @@ GSList *object_class_get_list_sorted(const char *implements_type,
>                                        bool include_abstract)
>   {
>       return g_slist_sort(object_class_get_list(implements_type, include_abstract),
> -                        object_class_cmp);
> +                        (GCompareFunc)object_class_cmp);
>   }
>   
>   Object *object_ref(void *objptr)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index bb445e30cd..68f81fadfc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -220,7 +220,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
>       }
>   }
>   
> -static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
> +static gint cpreg_key_compare(gconstpointer a, gconstpointer b, void *d)
>   {
>       uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
>       uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
> @@ -244,7 +244,7 @@ void init_cpreg_list(ARMCPU *cpu)
>       int arraylen;
>   
>       keys = g_hash_table_get_keys(cpu->cp_regs);
> -    keys = g_list_sort(keys, cpreg_key_compare);
> +    keys = g_list_sort(keys, (GCompareFunc)cpreg_key_compare);
>   
>       cpu->cpreg_array_len = 0;
>   


