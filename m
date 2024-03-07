Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AE8C54E55
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 06:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri6v5-0002Ll-Ms; Thu, 07 Mar 2024 01:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ri6v3-0002LJ-Jb
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ri6v1-0007wM-Ul
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709791671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tW6GZrePSbngs484fE2xRrRcWfq7gTab+KL0v1lNTjg=;
 b=hTMieT7+AhMOCqipSSgxyKQjOt7T/ergevsHz0ec/R7h4l4Z7O1Ef/Ok+EoueEY7Goy0zm
 v25erYzJySt0l+qtxpk7louxjTNjpwBpxNg0mWS0f0YvO3cwg9njgPSXTOSN26n7S/bQBX
 1CpqFtVbmLWInny2fhNO34rRzdHcRsw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-HFs5vk9SO3C9JfOPAgMY7A-1; Thu, 07 Mar 2024 01:07:48 -0500
X-MC-Unique: HFs5vk9SO3C9JfOPAgMY7A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a45ac612a4dso174878366b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 22:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709791668; x=1710396468;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tW6GZrePSbngs484fE2xRrRcWfq7gTab+KL0v1lNTjg=;
 b=GdMOBvktjxZd5gqDKiOk4gDWpnLaveR4EpsdylWTemvmHpG1rpIax90Yq0AByYIOQh
 Z9bu/NA9saZPwZhf1bqQNxWjvRsfzMoVP5I+sLzj0ma2Cp1NAIMv88iTQtSmTVAbyzen
 11Dy7Kur1jm7QToXS0oi5HmwozUg+9ExsdUdbB1AsNn7sdb53jV/shNOplJJuyoRmo7c
 rMUp5QD2+bQpXMnvUxixbeGJwmIneMj4lDg48tRF4xdxq7VfWGRmcTSv5J+ChwVpCtgB
 wOu8ramkGe037dHrI/HGuPqc0MCdbFrYivkUVfx/Wg+sCa6gtWECc6t33eza+6S3IyxQ
 OThw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8pknh3aJF2Ep/kM2d74WCBR5XggLsCRu8A284iGLJ2dTGGLfLEBxwj0J46orjkwM97VhVvz8t760+kHnH0MJ1G2JPrLU=
X-Gm-Message-State: AOJu0YwR3g9f0vQHVmbUUZsoZRlKaVgGbzStji2Xzav1mTReBEDIOzOl
 gpXb05mMRJjJQetVgd0xlJvtmIzHlu5FBqg+CjpHeewwzoSuMjb5J0tixIp1b/Sx0ttq3XGCxZ7
 CtlkxhwZfFFzHaWlNYFWetF3LxQV9gGslW7EKAmTmSrHeNEIhbrJw
X-Received: by 2002:a17:906:11d9:b0:a45:ada9:4bf1 with SMTP id
 o25-20020a17090611d900b00a45ada94bf1mr424377eja.12.1709791667746; 
 Wed, 06 Mar 2024 22:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFusPxhPQ5//eVC3tdZpOZBd6dKZbNAAdVyihLUFwXvetpIZ60j/x/W8BsH5klFgk7G4OdayQ==
X-Received: by 2002:a17:906:11d9:b0:a45:ada9:4bf1 with SMTP id
 o25-20020a17090611d900b00a45ada94bf1mr424353eja.12.1709791667374; 
 Wed, 06 Mar 2024 22:07:47 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 ef5-20020a17090697c500b00a449cb924dbsm6535442ejb.124.2024.03.06.22.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 22:07:46 -0800 (PST)
Message-ID: <363f8d66-646f-43cf-a49c-cf47af7dec19@redhat.com>
Date: Thu, 7 Mar 2024 07:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] tests/unit/test-smp-parse: Test "drawers" and
 "books" combination case
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-12-zhao1.liu@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240306095407.3058909-12-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 06/03/2024 10.54, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Since s390 machine supports both "drawers" and "books" in -smp, add the
> "drawers" and "books" combination test case to match the actual topology
> usage scenario.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Xiaoling Song <xiaoling.song@intel.com>
> ---
>   tests/unit/test-smp-parse.c | 103 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 103 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index aea1b2e73a55..0cf611519865 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -445,6 +445,33 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
>       },
>   };
>   
> +static const struct SMPTestData data_with_drawers_books_invalid[] = {
> +    {
> +        /*
> +         * config: -smp 200,drawers=2,books=2,sockets=2,cores=4,\
> +         * threads=2,maxcpus=200
> +         */
> +        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 200, T, 3, T, 5, T,
> +                                                2, T, 4, T, 2, T, 200),
> +        .expect_error = "Invalid CPU topology: "
> +                        "product of the hierarchy must match maxcpus: "
> +                        "drawers (3) * books (5) * sockets (2) * "
> +                        "cores (4) * threads (2) != maxcpus (200)",
> +    }, {
> +        /*
> +         * config: -smp 242,drawers=2,books=2,sockets=2,cores=4,\
> +         * threads=2,maxcpus=240
> +         */
> +        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 242, T, 3, T, 5, T,
> +                                                2, T, 4, T, 2, T, 240),
> +        .expect_error = "Invalid CPU topology: "
> +                        "maxcpus must be equal to or greater than smp: "
> +                        "drawers (3) * books (5) * sockets (2) * "
> +                        "cores (4) * threads (2) "
> +                        "== maxcpus (240) < smp_cpus (242)",
> +    },
> +};
> +
>   static char *smp_config_to_string(const SMPConfiguration *config)
>   {
>       return g_strdup_printf(
> @@ -698,6 +725,14 @@ static void machine_with_drawers_class_init(ObjectClass *oc, void *data)
>       mc->smp_props.drawers_supported = true;
>   }
>   
> +static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->smp_props.drawers_supported = true;
> +    mc->smp_props.books_supported = true;
> +}
> +
>   static void test_generic_valid(const void *opaque)
>   {
>       const char *machine_type = opaque;
> @@ -936,6 +971,67 @@ static void test_with_drawers(const void *opaque)
>       object_unref(obj);
>   }
>   
> +static void test_with_drawers_books(const void *opaque)
> +{
> +    const char *machine_type = opaque;
> +    Object *obj = object_new(machine_type);
> +    MachineState *ms = MACHINE(obj);
> +    MachineClass *mc = MACHINE_GET_CLASS(obj);
> +    SMPTestData data = {};
> +    unsigned int num_drawers = 5, num_books = 3;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
> +        data = data_generic_valid[i];
> +        unsupported_params_init(mc, &data);
> +
> +        /*
> +         * when drawers and books parameters are omitted, they will
> +         * be both set as 1.
> +         */
> +        data.expect_prefer_sockets.drawers = 1;
> +        data.expect_prefer_sockets.books = 1;
> +        data.expect_prefer_cores.drawers = 1;
> +        data.expect_prefer_cores.books = 1;
> +
> +        smp_parse_test(ms, &data, true);
> +
> +        /* when drawers and books parameters are both specified */
> +        data.config.has_drawers = true;
> +        data.config.drawers = num_drawers;
> +        data.config.has_books = true;
> +        data.config.books = num_books;
> +
> +        if (data.config.has_cpus) {
> +            data.config.cpus *= num_drawers * num_books;
> +        }
> +        if (data.config.has_maxcpus) {
> +            data.config.maxcpus *= num_drawers * num_books;
> +        }
> +
> +        data.expect_prefer_sockets.drawers = num_drawers;
> +        data.expect_prefer_sockets.books = num_books;
> +        data.expect_prefer_sockets.cpus *= num_drawers * num_books;
> +        data.expect_prefer_sockets.max_cpus *= num_drawers * num_books;
> +
> +        data.expect_prefer_cores.drawers = num_drawers;
> +        data.expect_prefer_cores.books = num_books;
> +        data.expect_prefer_cores.cpus *= num_drawers * num_books;
> +        data.expect_prefer_cores.max_cpus *= num_drawers * num_books;
> +
> +        smp_parse_test(ms, &data, true);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(data_with_drawers_books_invalid); i++) {
> +        data = data_with_drawers_books_invalid[i];
> +        unsupported_params_init(mc, &data);
> +
> +        smp_parse_test(ms, &data, false);
> +    }
> +
> +    object_unref(obj);
> +}
> +
>   /* Type info of the tested machine */
>   static const TypeInfo smp_machine_types[] = {
>       {
> @@ -968,6 +1064,10 @@ static const TypeInfo smp_machine_types[] = {
>           .name           = MACHINE_TYPE_NAME("smp-with-drawers"),
>           .parent         = TYPE_MACHINE,
>           .class_init     = machine_with_drawers_class_init,
> +    }, {
> +        .name           = MACHINE_TYPE_NAME("smp-with-drawers-books"),
> +        .parent         = TYPE_MACHINE,
> +        .class_init     = machine_with_drawers_books_class_init,
>       }
>   };
>   
> @@ -997,6 +1097,9 @@ int main(int argc, char *argv[])
>       g_test_add_data_func("/test-smp-parse/with_drawers",
>                            MACHINE_TYPE_NAME("smp-with-drawers"),
>                            test_with_drawers);
> +    g_test_add_data_func("/test-smp-parse/with_drawers_books",
> +                         MACHINE_TYPE_NAME("smp-with-drawers-books"),
> +                         test_with_drawers_books);
>   
>       g_test_run();
>   


