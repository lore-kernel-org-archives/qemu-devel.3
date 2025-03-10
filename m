Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79ACC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXC6-000772-Bg; Mon, 10 Mar 2025 03:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trXBz-00076P-NE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trXBx-00077i-V9
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741590287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zg6i9PdiDMFf2Xj1Q+YoFq6UiGTD9+WRi3LKv0Gb7s8=;
 b=SexKamSHMSLCrbrF8U5DKTeZVhdICLOq/7Z5035JB3dI9aW6pZlWWZVdOjrrJmK1cZzpDz
 oWU2o1iFOyyfMMZXeImNodRHId1gsv/OvHMn7Qny6hmgrOv5W53ne4FIs16rb4v8Q8DXYG
 Tr1vyUd2KlGGXq8f5biN4jUIvaxccDQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-jlZu5LjBNlWeNtVQgBpaZQ-1; Mon, 10 Mar 2025 03:04:44 -0400
X-MC-Unique: jlZu5LjBNlWeNtVQgBpaZQ-1
X-Mimecast-MFC-AGG-ID: jlZu5LjBNlWeNtVQgBpaZQ_1741590283
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac1e442740cso358997066b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 00:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741590283; x=1742195083;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zg6i9PdiDMFf2Xj1Q+YoFq6UiGTD9+WRi3LKv0Gb7s8=;
 b=a/g5TseLrQFbCIbzhhJ8rvRIksSbyu68HfPD/MmEHBwsG70ThmEwgksikZmDaqa651
 LxmpvzV52OK6SVkGnNdJrM4DIWf/sFrzX+4Qsz27WmUr0NBX0Dd8/SiI6suK+jIK01wM
 ZZJMCxGVrGwOwBjnnsXy6+SplL3klRNYTky+ywZ7Eev15AjXJcuheQy/RPQrMHueKs9y
 QkY+JdB/R49J03EAZ144q1UoSWFnY5dFC/dZyxndi05r5qvbEQ0ZfzZJG0JW8IBVzsfh
 V98QKS4sDfPGLz5CBZ/vRrW8hcshxlzxsJwAIkC2lDKVf9M/I+rNmVfevwAB8JSjuSzU
 vYag==
X-Gm-Message-State: AOJu0Yzq4lDJ6hGtW2It3+XqbWsX55Seop6ays4Tn757JXH2R2/Rx4F0
 kgOe0D+/WuDGN6is09gBftmome7hrAFIL3m/q3ocEnar61zZD2QXAeatINouT5b9nu8YifIVJdW
 NZRESxd7febc1HZcv3tdGWZATTad9fnvFBCdrzwL65wmGkB13wnJ6qXR51kqJyZW8OkD67EWe68
 5HPwQAxYGwiNuVk+Y493Q8ovDU+cl2LwOE
X-Gm-Gg: ASbGncsN0Y59lsSi/17mCag7cEBidEKXSEt8NmSXYGcowienDwUb6CqArcz3vVXDFyv
 fNJBxrcCqe3RaY/8PcVOUakFu9EMYBy9pjC8ujQKsqXZb2ZKqJEyO+SQzvGWlRsg96QrvjW47vp
 DzyYXjq8ITmrikdW8WFPMdCJ8YUBbePX3xUlIKvBytp/8Qlo9DookT2D4Ifmb66CYKft7+rdO7X
 e7eiXddvwn+RAaRjXWrRiQrFFsxzF4/F5DaSIX5er7HVif8wchMfPsfrElm5NpTaKcCndfqDDIQ
 t+NBgIlGe25ZEgxxN51KfymURLA42EzCb3d7uFI665YFYVc=
X-Received: by 2002:a17:907:3f9b:b0:ac1:ddaa:2c11 with SMTP id
 a640c23a62f3a-ac25210ff7emr1463713666b.0.1741590283012; 
 Mon, 10 Mar 2025 00:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrbeOrX5sFwExi9v8xTa4kQUmOqfvEMF52okDfTQZn6lw9Xb+dk00SEUjToiTB7yA3ufofvA==
X-Received: by 2002:a17:907:3f9b:b0:ac1:ddaa:2c11 with SMTP id
 a640c23a62f3a-ac25210ff7emr1463710466b.0.1741590282583; 
 Mon, 10 Mar 2025 00:04:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac292fc25f0sm209839366b.35.2025.03.10.00.04.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:04:41 -0700 (PDT)
Message-ID: <ce0f0c13-0e04-444f-b5db-8fdb7af6f945@redhat.com>
Date: Mon, 10 Mar 2025 08:04:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
To: qemu-devel@nongnu.org
References: <20250310062456.2453189-1-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250310062456.2453189-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 10/03/2025 07.24, Bibo Mao wrote:
> Add cpu hotplug testcase support for LoongArch system, it passes to
> run with command "make check-qtest-loongarch64" as following:
>    qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 0.64s 1 subtests passed
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tests/qtest/cpu-plug-test.c | 28 ++++++++++++++++++++++++++++
>   tests/qtest/meson.build     |  2 +-
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
> index 6633abfc10..790b9693b3 100644
> --- a/tests/qtest/cpu-plug-test.c
> +++ b/tests/qtest/cpu-plug-test.c
> @@ -156,6 +156,32 @@ static void add_s390x_test_case(const char *mname)
>       g_free(path);
>   }
>   
> +static void add_loongarch_test_case(const char *mname)
> +{
> +    char *path;
> +    PlugTestData *data;
> +
> +    if (!g_str_has_prefix(mname, "virt")) {
> +        return;
> +    }
> +
> +    data = g_new(PlugTestData, 1);
> +    data->machine = g_strdup(mname);
> +    data->cpu_model = "la464";
> +    data->device_model = g_strdup("la464-loongarch-cpu");
> +    data->sockets = 1;
> +    data->cores = 3;
> +    data->threads = 1;
> +    data->maxcpus = data->sockets * data->cores * data->threads;
> +
> +    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
> +                           mname, data->sockets, data->cores,
> +                           data->threads, data->maxcpus);
> +    qtest_add_data_func_full(path, data, test_plug_with_device_add,
> +                             test_data_free);
> +    g_free(path);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       const char *arch = qtest_get_arch();
> @@ -168,6 +194,8 @@ int main(int argc, char **argv)
>           qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
>       } else if (g_str_equal(arch, "s390x")) {
>           qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
> +    } else if (g_str_equal(arch, "loongarch64")) {
> +        qtest_cb_for_every_machine(add_loongarch_test_case, g_test_quick());

There seems to be only one unversioned "virt" machine for loongarch, so 
using qtest_cb_for_every_machine() and g_str_has_prefix(mname, "virt") in 
above function seems unnecessary? I'd suggest to call 
add_loongarch_test_case() here directly instead and only add the single test 
case for the virt machine there. Or do you plan to introduce other machines 
any time soon?

>       }
>   
>       return g_test_run();
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8a6243382a..60e16614b2 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -149,7 +149,7 @@ qtests_hppa = \
>   
>   qtests_loongarch64 = qtests_filter + \
>     (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
> -  ['boot-serial-test']
> +  ['boot-serial-test', 'cpu-plug-test']

I'd like to suggest to put tests on separate lines here (we do it for most 
of the other targets already), that will make "git blame" more useful in the 
future when the list changed a couple of times.

  Thomas


