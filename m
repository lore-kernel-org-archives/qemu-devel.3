Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A73EEF30B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy237-0002R0-RT; Thu, 05 Mar 2026 01:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vy22j-0001sT-FT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:18:43 -0500
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vy22f-0002ai-Ac
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:18:38 -0500
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2be19f05d7dso7413123eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772691515; x=1773296315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6x0h6jTA9+cR8/hZSGFcA5EYH/717k6FSSs+LV2fmw=;
 b=GE7TYQK/1KQz70UhyCfm10GEIe7b2DOQhVy3ASFgHw0sZ7/x66u6qTOwhKeditS32P
 X+sNB0n8Ei3mRpPJnIJitHt04jRnQiep/xhrPVdGaHNX3pf3dERq2DdovA0QXiejBYec
 Qg764lGTvVhJXO70PARvZEjv9FOzSgkLNryc93ja7wW+L6fexClalPwjZiJPxonn2nu6
 km8ukO7ii2Fck4BvDIXmB9hhMabsrfCC3+W4IxPMlv+u/mhPxEZjq8LzdcuPOJiwAool
 JKvazahA7877K1vQraKWSq/uA9egrDubMZPBdbCYL/rNMjYg9kyPCYKJ6pnnpgzqKEqB
 H0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772691515; x=1773296315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6x0h6jTA9+cR8/hZSGFcA5EYH/717k6FSSs+LV2fmw=;
 b=qn1PGcj0RoBzU4KmRGRKFsQxURyiPurZ2NKQz1hh/Y7D8+9s2Q43Xe2YYl/wdzb8KR
 1jEeWOs7HSezDymt7Msi8e+/EpM//rB/OrnRUHz/1ykqobFBPyzT6YzeHIogJHY6/6m3
 At2/M/Eva+AlOH3KvkI/xfWsagCRS3spdaYQKPLD7U9K2vIIe4MPYv5B7+I01wKehN7S
 iLE2p9OVfvVwU8Ecoh/g8AnKgAZOXcH1J3DTE8VQ3yW9BsynI2qWXBNGOUwMgt5LMrdY
 DJH897xJPgxCMr2y5jl84Jdk60g8N3+QP80FUcte2xBZWtjg2O4i0mmo7NmMz/xHva6+
 +hNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9S1OFOefSscXoXs8/mW2zDbMtTGinsxwZDvBbSlZ7x+Z2/9cDtLEWqb/rnypoGCRM4PSUFyhdEpbP@nongnu.org
X-Gm-Message-State: AOJu0Yz3IqdyAOlzw98NxO8BsEk/dA6IwOhgjQ0wgF27W5yvxY9C1j6P
 TJV9vMyiV1mKdJjZYNQP608/T9IgbZ/QxY9MHU9CKt+90rhk29iMXsUIu1Rwa3/FM1c=
X-Gm-Gg: ATEYQzyi55BbETsTe2TZKX2MSCXVbK+/kiA1cTxD+TOzuSUi9xJk6eqtCgn5Ia9sdrD
 +xJ+PIEA0GizTN2tYF/cjUE8Cm9kX5Z8QPZkbDNBU08xBIVko7SUJ+kQqdDIduKbypAf2ERwQkW
 BgVMohGB9ypdEYKq0pte1x4+kzuQXGdVcliWmRZM7+HNc2Zhw56ysH67ZYN3zARnna0F5Tz7jTu
 ZFZMBpbySHhjYftpmdN85SHyulklxCSSS591Sbf99v/V/yUbc3MTh9VRatyQdgak/lulLMpoWkl
 cRwxIFqfLM6qwMiNDahB9kEf1c94DIcEwAwY05RCyjw478rHyQy/gvdDxUf4LpAMyGHjoIBDOKa
 j46jewkseQ825z+lRp9tcBq76fjzVDB/bLMqncCcdxnVaeuE9+k9dQABy7ZNlRCkOiT+Qvy+G8u
 AXhkOJSf5MY+IB4njnL4Bv+N1r/0NYgS8A
X-Received: by 2002:a05:7301:678f:b0:2be:2e4c:209c with SMTP id
 5a478bee46e88-2be3109b1afmr1739518eec.20.1772691514704; 
 Wed, 04 Mar 2026 22:18:34 -0800 (PST)
Received: from [192.168.0.103] ([191.8.216.93])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm11241488eec.29.2026.03.04.22.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 22:18:34 -0800 (PST)
Message-ID: <2cdd5204-49fa-4aed-be93-d175af4a9e2a@linaro.org>
Date: Thu, 5 Mar 2026 03:18:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 7/8] tests/qtest/bios-table-test: testing new ARM ACPI
 PPTT topology
To: Alireza Sanaee <alireza.sanaee@huawei.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260220141128.789-1-alireza.sanaee@huawei.com>
 <20260220141128.789-8-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260220141128.789-8-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alireza,

On 2/20/26 11:11, Alireza Sanaee wrote:
> Test new PPTT topolopy with cache representation.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   tests/qtest/bios-tables-test.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index a5a5b8807b..510751799e 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2229,6 +2229,10 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>       };
>   
>       test_acpi_one("-cpu cortex-a57 "
> +                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=cluster,"
> +                  "smp-cache.1.cache=l1d,smp-cache.1.topology=cluster,"
> +                  "smp-cache.2.cache=l2,smp-cache.2.topology=cluster,"
> +                  "smp-cache.3.cache=l3,smp-cache.3.topology=cluster "
>                     "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>       free_test_data(&data);
>   }

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

