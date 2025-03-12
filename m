Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FD0C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 06:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsFao-0000tf-KW; Wed, 12 Mar 2025 02:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFaj-0000tJ-Cy
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFah-0006aU-81
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741760957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UwJdAKxFgnQGLoQzKvMxChv44r7g+McXVBRTAkgw6uw=;
 b=gxIS+qWqVCFF64BZ0GNaoK2AtwD11SL8WDtclwhUVtBLCq+33GJTpx2GJrW1XQyvS8dgnI
 IQk5i6SV8w/PdJnR9RlCY475HHHGTe29sfPSnCflBBongaSzfkxTe7Mmv7LHktoigBR2ra
 FY/79ijSR5bk8aOw+hbBXG+gnKx4qLM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-4PJ85mjROwG4SuGlN6wL7w-1; Wed, 12 Mar 2025 02:29:14 -0400
X-MC-Unique: 4PJ85mjROwG4SuGlN6wL7w-1
X-Mimecast-MFC-AGG-ID: 4PJ85mjROwG4SuGlN6wL7w_1741760953
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d025a52c2so9492835e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 23:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741760953; x=1742365753;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwJdAKxFgnQGLoQzKvMxChv44r7g+McXVBRTAkgw6uw=;
 b=tNesvqj3QklfNVNyO1drlmooDnejlxOMZLy7eetKwJPxuUhsENCov/MaGSyysVWDPi
 DGHXTA/DjdIGJj4bJC7aX1DbWuD60k6RwsenXAO8SdQVGUgTwVtx6IWwlD1CZ48KXz+g
 z4fbkDUS+5TdKk69W5er8JZKPlg3woC5BxQUom5EJ+iOKPCWr++VPXGzUVY1vZ5L25EC
 kfqa0mCPPRy0w/IWDskTn/lNxaExGeSrW4Gqgkc0EPtTypHo+HtaVmb6Vrl8tfIAaVJK
 kreNF/TUGkf7q3/ZALds36bNcZZP6KMTYwaA5zECDeCdnR3CBUrue0S83w5JuHLKvo/k
 e9Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7XFrJlD5MYenrhtO0zXqMYe1H52H1xyg5GAdZya9yFrNaltZou0GhLGNuPCSagejyy0LuV6y8ydQT@nongnu.org
X-Gm-Message-State: AOJu0Yzv2LAOBObHUFCpDdfxDhx+jOwxFpmEg+o3iD8J9MGdTLEJMjxY
 8ffuMkFrfRdGE8FTSRL7PtzU3ddPOWCxHTTCON3R1AURnruPimed91Ml+piTvIHcUR9ZqkINrH7
 f0RnLf86Z0yWofpz1zvGUDD7qe7cTXYQvZ+YqBZ2AURDhrVnmYVs3
X-Gm-Gg: ASbGncvSS8BBcFQyIoIYSLfZMU/NgOic9ln6toXO+JcNeot1rkPHp02luMlVy0EmAvy
 4Dti5lCp9KauYBayzBGdWx23kQboIbHx6+216Zcqh6dZJ8/5L4TiUw3dzMqKiAFMxZwSNVH6Ka1
 woemZQEKylLahmjCi13C/77yQH+HF2u1bEsYf89GD8uvNxTiXSR8hNbhhYL6AAOdQOndcmeNFqL
 /VaJRVD1FUeHssuWY5XABZTJ0tJEvYapr9q+t1A8tucOAAf8Oix/DY2z5Yed+/oi4I1Y+Q4QeKm
 pnOzbY9HjsVC7uve7iHNYWfweXVShWngJR/z/5x7EL7tNls=
X-Received: by 2002:adf:a397:0:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-3913f4fa2d3mr8777420f8f.32.1741760953221; 
 Tue, 11 Mar 2025 23:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE65rqSd4uhjLTENgYtn28M/THAmWmxq4DLlEFpM3nowH7ouXefPnSxv+VDhKxNaYzXkq6POw==
X-Received: by 2002:adf:a397:0:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-3913f4fa2d3mr8777412f8f.32.1741760952880; 
 Tue, 11 Mar 2025 23:29:12 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a78f1bbsm10961825e9.31.2025.03.11.23.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 23:29:12 -0700 (PDT)
Message-ID: <2c9e0443-538a-442e-a03b-58e5117e4a2f@redhat.com>
Date: Wed, 12 Mar 2025 07:29:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
To: Bibo Mao <maobibo@loongson.cn>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20250312034445.3350705-1-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250312034445.3350705-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/03/2025 04.44, Bibo Mao wrote:
> Add cpu hotplug testcase support for LoongArch system, it passes to
> run with command "make check-qtest-loongarch64" as following:
>    qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 0.38s 1 subtests passed
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>    1. Call test function add_loongarch_test_case() directly rather than
>       qtest_cb_for_every_machine() since compatible machine is not
>       supported on LoongArch system.
>    2. Add architecture specified test case in separate line.
> ---
>   tests/qtest/cpu-plug-test.c | 28 ++++++++++++++++++++++++++++
>   tests/qtest/meson.build     |  3 ++-
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
> index 6633abfc10..6af81330c0 100644
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

Should be ok to drop that check now ?

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
> +        add_loongarch_test_case("virt");
>       }
>   
>       return g_test_run();
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8a6243382a..7e62204dcc 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -149,7 +149,8 @@ qtests_hppa = \
>   
>   qtests_loongarch64 = qtests_filter + \
>     (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
> -  ['boot-serial-test']
> +  ['boot-serial-test',
> +   'cpu-plug-test']
>   
>   qtests_m68k = ['boot-serial-test'] + \
>     qtests_filter

With preferably the redundant check removed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


