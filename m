Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ACFC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdCn-0007cX-V4; Tue, 01 Jul 2025 11:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWdCl-0007by-UU
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWdCj-0001vR-2z
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751384846;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3wxbJ6u0LbCPii/UzJiKDKg2FWqqu/s9vaGG/5Susc=;
 b=eNOmHv5YkipAimd2nhQSp66pQDbZRpqo6y/IgC/sP1X5QBnMNYp2Y5JTq3nqu8ALqOCJgb
 rSWuBNX/n6TjeJ/OKkEs50Yy1Co3nt7D4iKZLMaNVuaSwFYas7VnFAr86WER2A6um7CmjY
 JENJILQ1DIkp4ROpmIHeWaIbeu+r2Ew=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-0ymGtSmBMbW2yxurJIhgHg-1; Tue, 01 Jul 2025 11:47:25 -0400
X-MC-Unique: 0ymGtSmBMbW2yxurJIhgHg-1
X-Mimecast-MFC-AGG-ID: 0ymGtSmBMbW2yxurJIhgHg_1751384844
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45311704d1fso21345455e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 08:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751384844; x=1751989644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3wxbJ6u0LbCPii/UzJiKDKg2FWqqu/s9vaGG/5Susc=;
 b=ls8+OyEXs8YvdgBhiUsfg7lGeyISJWGQQpODuBHXwyc7iPCxq0vzdYaDHAubasU02y
 R8eKQT9PsYo2DS2VnaHcJz88IVfagbltu4bL9G1zoRkTf9E1wYIX8QODQzO+4vCLY9Cj
 /SXdwjtMvElJkcOyBBzT0zNM3iYvqbQQDUSc/CX0LEYrbJVepJ6rwuwssm0dm5TPHZWE
 c+9+9Wx4C+anadn36EOKZVCNxoIuOqd90ExinBSA7mCo8HZ5Ria2xXP6aUTcdc52lZl5
 Q2F1xLGw54kCj5oZxnlshsqEMsnadm8n2ALmebEEx+2CwnaDZuOElhxHirsP73L2ylDc
 WogQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn6W10GIroMfXtf9sparz2pZcaXZ88UxWVvLdKcaOqTyaQEqWttSZQzL55gUA0RjrJp/s4B/5g+2eS@nongnu.org
X-Gm-Message-State: AOJu0Yw5vFpwar/+j2JmJhNk5C6Dj9K151QCj+jiSnUnvCxa6O7O5rre
 h3SSxbHt9iVmxsrnX1G1Qjya/CZJooxeLPjBJ4EMZ4CYd4W+yL722byAmp+8OmChq4jTXg11yoH
 pLe3pk+PE3VdprF8rqQX9E0gw3OOT4s7HLGEYnayEIiogAI5hnjqRx/LK
X-Gm-Gg: ASbGncv+xqBplY3WuM6MN5qZ7sCjG610Tzpk6OeQGv23c4hWXSlsxMbEtbIIt7NVWHu
 C0XJiRG6hDv7tcNdxkS/jF42A4+OaGiu1yegqZAUmIR+03Kpf49TRfLGpAa/YxoDAxY2E8o8ytV
 mRCno8bdh3YCtH7KD14lT7DQHqxSHnAkpyOx0y8sM9CpMxMqDaZj6ZU7sQBN12TtErWb48P5QIP
 Xi5cK60zpoXGfdI/hUi9pPnkqcyfmpWati6F3WlAYEihia/c3Arv0WQ9E+AOkTueXuFzbOeeNAg
 6C5H2ZQ4fDkDy1CXLSS07fJp/8Os2Q2ujxRHIicnz6nPMGmy5s9lDyudZBpGydBd4Ue6XA==
X-Received: by 2002:a05:600c:c4a7:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-45391b6b961mr155578265e9.1.1751384843633; 
 Tue, 01 Jul 2025 08:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUlW/iYyEMISr2wG82jHg+cr6qo8A5+AAh5UTTei64Zk2bZgbhU1lubsjcDM47l8/A3nww1Q==
X-Received: by 2002:a05:600c:c4a7:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-45391b6b961mr155577905e9.1.1751384843132; 
 Tue, 01 Jul 2025 08:47:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c1easm198152655e9.3.2025.07.01.08.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:47:22 -0700 (PDT)
Message-ID: <30f089df-c521-49c7-ad1f-f4663de4958f@redhat.com>
Date: Tue, 1 Jul 2025 17:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v16 5/5] qtest/cxl: Add aarch64 virt test for CXL
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> Add a single complex case for aarch64 virt machine.
> Given existing much more comprehensive tests for x86 cover the
> common functionality, a single test should be enough to verify
> that the aarch64 part continue to work.
nit: continues
>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> ---
> v16: Update to bring improvements made to other tests (Peter Maydell).
>      I'd failed to notice when rebasing this over time that the
>      other tests had undergone various improvment and I should have
>      updated this one as well.
> ---
>  tests/qtest/cxl-test.c  | 58 ++++++++++++++++++++++++++++++++---------
>  tests/qtest/meson.build |  1 +
>  2 files changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index a600331843..8fb7e58d4f 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -19,6 +19,12 @@
>      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
>  
> +#define QEMU_VIRT_2PXB_CMD \
> +    "-machine virt,cxl=on -cpu max " \
> +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +
>  #define QEMU_RP \
>      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>  
> @@ -197,25 +203,51 @@ static void cxl_2pxb_4rp_4t3d(void)
>      qtest_end();
>      rmdir(tmpfs);
>  }
> +
> +static void cxl_virt_2pxb_4rp_4t3d(void)
> +{
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    g_autofree const char *tmpfs = NULL;
> +
> +    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> +
> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +    rmdir(tmpfs);
> +}
>  #endif /* CONFIG_POSIX */
>  
>  int main(int argc, char **argv)
>  {
> -    g_test_init(&argc, &argv, NULL);
> +    const char *arch = qtest_get_arch();
>  
> -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> -    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> -    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> +    g_test_init(&argc, &argv, NULL);
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> +        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> +        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
> +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>  #ifdef CONFIG_POSIX
> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> -    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
> +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> +        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> +        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
> +                       cxl_2pxb_4rp_4t3d);
>  #endif
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +#ifdef CONFIG_POSIX
> +        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
> +                       cxl_virt_2pxb_4rp_4t3d);
> +#endif
> +    }
> +
>      return g_test_run();
>  }
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8ad849054f..42e927b32a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -261,6 +261,7 @@ qtests_aarch64 = \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
> +  qtests_cxl +                                                                                  \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',


