Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5479CC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 17:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qJS-0005bB-7A; Mon, 07 Apr 2025 13:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1qJH-0005Yu-QV
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1qJG-0000AR-92
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744047056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfoVmOBD5xgr+eXJQDG+Yi3XuSvAykSDMs2Nslin8KM=;
 b=fyPPXnukbW+iC/WFpjzi3/zZLN/Tfy9vg4k1NPLxQ+VTXD0geC5BjUr7zSUuBXEsYr8mFu
 aEX8xFoL1tr8ETZbVJ5+WOmdB32J9wTY4KKIOhR/3ZTStXzguaoa/9rgo7D8Hrs+hcu3vc
 QuvxOLDlkvxUH/kZ8R15AdhHsJackDs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-wwnoLw0zMICue0R3uvSZSA-1; Mon, 07 Apr 2025 13:30:51 -0400
X-MC-Unique: wwnoLw0zMICue0R3uvSZSA-1
X-Mimecast-MFC-AGG-ID: wwnoLw0zMICue0R3uvSZSA_1744047050
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3913d8d7c3eso2504960f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 10:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744047050; x=1744651850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfoVmOBD5xgr+eXJQDG+Yi3XuSvAykSDMs2Nslin8KM=;
 b=dKoxKmsdyhOitVRBkNAudKPN9eAOoQNBagbqx9bG6e6X6JR98EJ5Eil641WGpDRCmc
 cALgjm7mkJlbMRdTWQSGsdBzb5/O9vsowMCz6EJnsGIdrv6mTI8nHFIrxenj6erCeE/t
 WxQ73k+d1gjBOWhjju2AtYl3shIEpZlGcB6/9lIYwOztdZ5ROVukPEoKEgytiq9QW0VL
 FzQwolcsValE1IFfYADqCHmFmbBT4ptbnaxTH/ORkIxD/YbX6amt6gFlYiy0jRaotesP
 VQJ5omcbaLPL36fehOZ79kUJ+YBnotCWHDXlNSm9mdX+mT5t7Q1zdK19T4IHTXbAZyyh
 v5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfb6vBp3azDYHyIgDpg32rkGgIdqLlwZN2j/TIzeHoVe2DdfmSStjDMpHt34Qb+lxT6yPZnzViGRsZ@nongnu.org
X-Gm-Message-State: AOJu0YxceqQzKj8m32T4y58wO7coKK6RQKISi4tjI2YarlCQDRoJJCUD
 RLxVNF59qHNDkWufzOzdQSOyKzQZyTfslKJZAwXf5SIcBdt2YhrMlxZYS7yCMH4m8UCOh9l/jCx
 w7PhXK9u1A5382u3E19Wo0rJnX/ChcXZOBfm5r5k5AeuJ2DG8FD/g
X-Gm-Gg: ASbGncvW1qbzMg/r/0TZYT3KM33GMjle8ezxu66hSadwmyPAlAUFAlZodREAUIX0Whz
 p7ekbpCLGyONehu1f8kEHuM1gCPkyGw4OXRFilMhusYV/T9kSrojqPsYQah8Q3cfemH3Sq8fXjg
 E9UnusgSQfti1QrZ878aqnpqEgplpu76QupXQe+dvw9uk9PJL4og5jusp9eVaIfG3Wo5vmvD8eg
 U5FZrK/NQMfYovmzwMW0jxUt6OeL3VZ2CcTc/UpLbP714XOSDGyuQU2UA33SGvJc9ZuPNXbqWlc
 5afheXAwF421RZNv+N3qJnmFlYkEx/Il7OieRnyCCOIZQgphKSRBmOlwoRscggU=
X-Received: by 2002:a05:6000:2486:b0:390:f699:8c27 with SMTP id
 ffacd0b85a97d-39d07ad5183mr9959113f8f.12.1744047050529; 
 Mon, 07 Apr 2025 10:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEdp62lovLfcYdOwa1BDUqSa6s2e8EZCFpmnbyrSNExP924y2GbtAGn2mNnS4gjwSlBx7fRQ==
X-Received: by 2002:a05:6000:2486:b0:390:f699:8c27 with SMTP id
 ffacd0b85a97d-39d07ad5183mr9959082f8f.12.1744047050147; 
 Mon, 07 Apr 2025 10:30:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d7c6d838bsm2555024f8f.69.2025.04.07.10.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 10:30:49 -0700 (PDT)
Message-ID: <03409a9d-fbee-4e08-9ca3-861bf8eddd55@redhat.com>
Date: Mon, 7 Apr 2025 19:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] tests/qtest/bios-table-test: testing new ARM ACPI
 PPTT topology
Content-Language: en-US
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: mst@redhat.com, zhao1.liu@intel.com, dapeng1.mi@linux.intel.com,
 armbru@redhat.com, farman@linux.ibm.com, peter.maydell@linaro.org,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
 jiangkunkun@huawei.com, yangyicong@hisilicon.com, linuxarm@huawei.com
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
 <20250310162337.844-6-alireza.sanaee@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250310162337.844-6-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 3/10/25 5:23 PM, Alireza Sanaee via wrote:
> Test new PPTT topolopy with cache representation.
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tests/qtest/bios-tables-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec43536..6bdc25f4df1e 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2142,6 +2142,10 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=cluster,"
> +                  "smp-cache.1.cache=l1d,smp-cache.1.topology=cluster,"
> +                  "smp-cache.2.cache=l2,smp-cache.2.topology=cluster,"
> +                  "smp-cache.3.cache=l3,smp-cache.3.topology=cluster "
In the coverletter you used different topologies: core, cluster, socket.
Don't you want to test the same config here?

Is it better to reuse the existing ".topology" variant or to create
another one? (I have no strong opinion though)

Thanks

Eric
>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>      free_test_data(&data);
>  }


