Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5309C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2uIw-0005m9-Vt; Thu, 10 Apr 2025 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2uIq-0005dP-PL
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2uIo-0001qn-Vb
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744300733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y7YNPVvDGegBMftMugeCjfwZ2qjrwxZyvKO7qoUnSKE=;
 b=iC83Y6+ru48rPkkD9byGOLKn3gRLX6li75pMltxm1XOVEokEbFlAwsx96cjwLiQFGjPjNY
 vLGCNlhPA3JddAKoLPW6MUtFMzV/G91PGBFFLYWROfPp7h9Zl8Uitm+uyeR0sd8cIp4v2C
 aGdo5x3h0eSHyJQl8KymYgsKhgQ9JgQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-8znDjs6KO8OsDfyptLjA9w-1; Thu, 10 Apr 2025 11:58:51 -0400
X-MC-Unique: 8znDjs6KO8OsDfyptLjA9w-1
X-Mimecast-MFC-AGG-ID: 8znDjs6KO8OsDfyptLjA9w_1744300730
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e82390b87fso965915a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 08:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744300730; x=1744905530;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y7YNPVvDGegBMftMugeCjfwZ2qjrwxZyvKO7qoUnSKE=;
 b=QytL5XGGB1So1aYiHUT6TMtbGdbpFrl5q4HQW6mh4Jg7teJmQyFXCsTGQvfJrtErJn
 3p4PgRu++JVLo2wDW6lvM8wXLgO/QFlFV8qpcogQp1Enon/o/K+o+TlQSZolTsBJa6d+
 1W730eFgZV8AMMoBNYtT1tW13ZO5T15jHh4gl73DNugyAFtbk3TTi2F+CvrK25PITKH9
 zTN7iGNNTVlqy5uXa2otjBzR5U9LFzknL40c9xLLdcc+nJfk9Ucgkeo2mE4RJomq1pRv
 F8ENCWrXg3e/1X5u7AYlLxWALiSFKfs45DlKvdP2wRqdOE8RZN3+xaEHPV4LXDqUFPAM
 SYBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOGBNF8Atecqg3QZLKpsx5pKxgs4pQ5E3SCTpZh19HVvdp30PZoXy5O0teidN2qWUpTIZ6klflGBm2@nongnu.org
X-Gm-Message-State: AOJu0YwF1I2epy5izl0jeHUNOgK2Qn9USbXU+VPYTNGovkygK3lBki+4
 yj3ZMRQou+hd4zwTPd1ZZ2nmTEPfC5+z9UpIMCUdv6hPutgvirr8ibseA3KlyV9THLI8leOaL/z
 XMdeeOVTsg0QAvKY9VztPrAqmJuDq0aL3HXZjtHOH8LfseXXmIK5u
X-Gm-Gg: ASbGncuMPK7SDbLfTGl9/g0tnfRqqTd1MiV7bFboxEEaz+hCJREFaa8/d9b4CG/0hE5
 q+baJHWZoHErI3XN4evsRKPEradpw5C9O/UeTIPY5CtnEqE3Ej8LXQ1Tef9YadcYc1ro3ag3u7n
 KEhh3nRFpCrjUBptyaytVbLLYOCtgf87IxmpNSxHWND1qwypg8GfaWSkb7YW8AokY7iAoPve6do
 7slVQ6YXEFBEJD9+Uba5QVbZaMW0b1VD5H/xzB6vXWPEdjC6sHbnsoTTCrWyY3nv2ZTOCc5w74v
 UHpVcpxVvJfJ3YLt/xUkSkmzb2K2JjnmZoeB3Jy54R2hedDU4A==
X-Received: by 2002:a05:6402:35c9:b0:5ed:c188:8e7e with SMTP id
 4fb4d7f45d1cf-5f32930f5eemr2740188a12.27.1744300729814; 
 Thu, 10 Apr 2025 08:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFMjsYG4/orstB6BJBOAvCttKbWfA7npz4IEQdeqW9BNdRixHionFsRHi9LRtsDSwfojMVNQ==
X-Received: by 2002:a05:6402:35c9:b0:5ed:c188:8e7e with SMTP id
 4fb4d7f45d1cf-5f32930f5eemr2740156a12.27.1744300729357; 
 Thu, 10 Apr 2025 08:58:49 -0700 (PDT)
Received: from [192.168.213.163] (93-33-70-196.ip43.fastwebnet.it.
 [93.33.70.196]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbd3d9e1sm2461618a12.76.2025.04.10.08.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 08:58:48 -0700 (PDT)
Message-ID: <65a63820-e59d-47d4-883a-4affe40f9b38@redhat.com>
Date: Thu, 10 Apr 2025 17:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] various: Fix type conflict of GLib function pointers
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
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
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2be81d2f86704662c9fa33ceb46077804e34ac77.1744032780.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/7/25 16:45, Kohei Tokunaga wrote:
> On emscripten, function pointer casts can cause function call failure.
> This commit fixes the function definition to match to the type of the
> function call.
> 
> - qtest_set_command_cb passed to g_once should match to GThreadFunc

Sending an alternative patch that doesn't use GOnce, this code runs in 
the main thread.

> - object_class_cmp and cpreg_key_compare are passed to g_list_sort as
>    GCopmareFunc but GLib cast them to GCompareDataFunc.

Please use g_list_sort_with_data instead, and poison 
g_slist_sort/g_list_sort in include/glib-compat.h, with a comment 
explaining that it's done this way because of Emscripten.

Paolo

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


