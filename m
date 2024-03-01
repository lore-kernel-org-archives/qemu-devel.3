Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529D9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxeR-0006kS-F6; Fri, 01 Mar 2024 02:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxeP-0006k7-UN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxeO-0003Jn-Ew
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709279387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pxAaiKR8ZYDb60Wg6lzRq50nAR6wuS5j1owv949mqfw=;
 b=STbwWpUkYWv12k0Fo6SsxYDbb3ptR3OLReg4YgfwuBtAsPM64uUrLZfuROwJRJKTFSzZVi
 s9DyNnGLQJf4mfonkJA2ZkQaVgDNyZwhxZ2vhrrX4xhqmtbbKr6nPJRx3lZjYkP6/9lApP
 csQrEzuUWTpewjbtGc+bvVDETxJXnl4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-wa-uBKOMMz6VstIUbgslBQ-1; Fri, 01 Mar 2024 02:49:46 -0500
X-MC-Unique: wa-uBKOMMz6VstIUbgslBQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a44563c65dcso100402066b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 23:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709279385; x=1709884185;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxAaiKR8ZYDb60Wg6lzRq50nAR6wuS5j1owv949mqfw=;
 b=gi9RTZbvu8HZh+v6T+7/ZilG65/vKIxh1zW2kfjIn8mc/8Pb4wUAQND+wTNWLbcD/v
 kFrH0z6Yz6CufDj2LYJMyGtCgsvpI17e7LOcHTzEvEgawWa1YzX7dZESVehINOtWtO/y
 jEKJfuc4xIcH1gpaBVXzlrZfbU4So/IwBzTGl3ClK4oBa3+/HdLD3GjLAONoWbHbCOqq
 tLB8pPFrwc81rGAw0JRldliYPAISfQIy+4YIGqM0y+jG6XjDDHANkjaZZNZo862oGH/Y
 GkGF8ZjMjH9P+FTlTJ/22onMs2x5Q+PES5wDqKtUfY60M/W6asCQB7IMdAtGqI2JX/Pm
 BByg==
X-Gm-Message-State: AOJu0Yyln2zZGhzINYIqyhreCaP+ELOysXAjS2Y13yw3Js9dfN00LCKG
 cWpALI/lCaKkY/wHiJVBb/+IppBnlBsiRgpGJkY+0QhRqVybRU5qWEY8P7V5VSkH3zrmkK1glka
 YuWSOMTBO+kQZoFzW/9zoelsi9QM3IzYsjVjArAGzxnJlrKJAcW6z
X-Received: by 2002:a17:907:1708:b0:a44:7e16:ae8c with SMTP id
 le8-20020a170907170800b00a447e16ae8cmr686125ejc.43.1709279385113; 
 Thu, 29 Feb 2024 23:49:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqY5ytucQU1qlIk+o1TKpqhbjAe0Qm2qJhuzUHRWMEw88Ym/I1FnXxFTROTV7Q4MKF8qK+Gw==
X-Received: by 2002:a17:907:1708:b0:a44:7e16:ae8c with SMTP id
 le8-20020a170907170800b00a447e16ae8cmr686109ejc.43.1709279384801; 
 Thu, 29 Feb 2024 23:49:44 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 kw11-20020a170907770b00b00a43f170ad9asm1423998ejc.152.2024.02.29.23.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 23:49:44 -0800 (PST)
Message-ID: <7b906143-fe36-484d-b42c-d7291574be0d@redhat.com>
Date: Fri, 1 Mar 2024 08:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/unit/test-smp-parse.c: Make test cases aware of
 the book/drawer
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
 <20240118144857.2124034-4-zhao1.liu@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240118144857.2124034-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18/01/2024 15.48, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Currently, -smp supports 2 more new levels: book and drawer.
> 
> It is necessary to consider the effects of book and drawer in the test
> cases to ensure that the calculations are correct. This is also the
> preparation to add new book and drawer test cases.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   tests/unit/test-smp-parse.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 55ba13bf7d15..a8eb3bbb35ed 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -384,6 +384,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
>       return g_strdup_printf(
>           "(SMPConfiguration) {\n"
>           "    .has_cpus     = %5s, cpus     = %" PRId64 ",\n"
> +        "    .has_drawers  = %5s, drawers  = %" PRId64 ",\n"
> +        "    .has_books    = %5s, books    = %" PRId64 ",\n"
>           "    .has_sockets  = %5s, sockets  = %" PRId64 ",\n"
>           "    .has_dies     = %5s, dies     = %" PRId64 ",\n"
>           "    .has_clusters = %5s, clusters = %" PRId64 ",\n"
> @@ -392,6 +394,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
>           "    .has_maxcpus  = %5s, maxcpus  = %" PRId64 ",\n"
>           "}",
>           config->has_cpus ? "true" : "false", config->cpus,
> +        config->has_drawers ? "true" : "false", config->drawers,
> +        config->has_books ? "true" : "false", config->books,
>           config->has_sockets ? "true" : "false", config->sockets,
>           config->has_dies ? "true" : "false", config->dies,
>           config->has_clusters ? "true" : "false", config->clusters,
> @@ -404,10 +408,10 @@ static char *smp_config_to_string(const SMPConfiguration *config)
>   static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
>   {
>       /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
> -    if (!topo->sockets) {
> +    if (!topo->drawers || !topo->books || !topo->sockets) {
>           return 0;
>       } else {
> -        return topo->max_cpus / topo->sockets;
> +        return topo->max_cpus / topo->drawers / topo->books / topo->sockets;
>       }
>   }
>   
> @@ -429,6 +433,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
>       return g_strdup_printf(
>           "(CpuTopology) {\n"
>           "    .cpus               = %u,\n"
> +        "    .drawers            = %u,\n"
> +        "    .books              = %u,\n"
>           "    .sockets            = %u,\n"
>           "    .dies               = %u,\n"
>           "    .clusters           = %u,\n"
> @@ -438,7 +444,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
>           "    .threads_per_socket = %u,\n"
>           "    .cores_per_socket   = %u,\n"
>           "}",
> -        topo->cpus, topo->sockets, topo->dies, topo->clusters,
> +        topo->cpus, topo->drawers, topo->books,
> +        topo->sockets, topo->dies, topo->clusters,
>           topo->cores, topo->threads, topo->max_cpus,
>           threads_per_socket, cores_per_socket);
>   }
> @@ -473,6 +480,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
>       if (is_valid) {
>           if ((err == NULL) &&
>               (ms->smp.cpus == expect_topo->cpus) &&
> +            (ms->smp.drawers == expect_topo->drawers) &&
> +            (ms->smp.books == expect_topo->books) &&
>               (ms->smp.sockets == expect_topo->sockets) &&
>               (ms->smp.dies == expect_topo->dies) &&
>               (ms->smp.clusters == expect_topo->clusters) &&
> @@ -564,6 +573,16 @@ static void unsupported_params_init(const MachineClass *mc, SMPTestData *data)
>           data->expect_prefer_sockets.clusters = 1;
>           data->expect_prefer_cores.clusters = 1;
>       }
> +
> +    if (!mc->smp_props.books_supported) {
> +        data->expect_prefer_sockets.books = 1;
> +        data->expect_prefer_cores.books = 1;
> +    }
> +
> +    if (!mc->smp_props.drawers_supported) {
> +        data->expect_prefer_sockets.drawers = 1;
> +        data->expect_prefer_cores.drawers = 1;
> +    }
>   }
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


