Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF05C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5uA-0004a9-Cr; Mon, 05 May 2025 20:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5u8-0004Zk-B8
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:11:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5u6-00008g-L7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:11:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so4114987b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490281; x=1747095081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a3YXeIUESEjfnloi8gualHdIywIy1WnTpQLCZFfcuFY=;
 b=qLKrtn/YjHS3fTEIJeEVRcxsWYGommvCblTqBSn3VIXNsumui0eSHpZhfEvKNSQzva
 hsCK17SAzTqSeG/FunnOLnj/Vxn/0mAOe7wrgP/mdixV0rL5cFU03Fo2+lhXuNAp7W5d
 B8MbnbbAcxZxZn0pyaSkyc6LtirwyydwX4wmVdXL+ab93ksncmqS9WJbfI39IGOguE6x
 sD+CbMkVuTuAj2z1NerdfYTXxXyzCU3HmrC5Qw3V42u9ZTO12KNGxNsrDHu7tHlZExEH
 ETRjk6xa6m2UYNFcp3P6948GSE8Jb2vFJQlhLiIXI+DJYpNRGWheVDhgG/QknwjXo2IV
 M39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490281; x=1747095081;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3YXeIUESEjfnloi8gualHdIywIy1WnTpQLCZFfcuFY=;
 b=nx+hziRCVSD5qSGd3+XEj1ezc/P2FM9xLVyQhgK+5IymZAz/1jQmnOq0boGEXExuFk
 xgMjYa+WvohQ0Vd1MN1tsNugX9Pbfkuf9d/YCNUf79hkVl3TSHU/WGPCViJUIURm2PD8
 qFb5vKi9skTM9necnGIh4gh7gbv13IdMfx9/g7C/nTABlbeEsEz2Kw5ETT5ZkxhOH5Ot
 LFm6dnqNDIQRciqWL00rhwIVNDwekmftU9sAR5pbg14AJXnDU6ZJEVTeqwCWri6TGbRo
 ZOja9XfXwg58YqoGMqm2Dx4YuTjT7l+Gtc91m2lZcBznpKUAa8T4cGjm9tkfYMMSeGWo
 n5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjpzn7XU31YCDLGcwudpHumf3tEEi3417jetEyEgSFpspmwvDOs1zleWyj0HEUMx4mbo6F89onzNJz@nongnu.org
X-Gm-Message-State: AOJu0Yz+ZDgQXcg/A2gq5gzGT7XP+wGOw1WtVmugpZDuwF6zxjkYMzy3
 I6uBTr3Mt9P3+vBm2ZAWgqJrfwbKvalAIa6KKTPIGVzrsDYQs34KQuEpiu1TdpQ=
X-Gm-Gg: ASbGnctJyvvfOdcqXD5HZbZ3FHcTxZsdnus82qtKq62i8JPfvfyr3J3RCINk8BAyowY
 Iy04PoH45sLG4hpIb1NT8yFvfsVaGCnZjuMMgnz/mNvVrljQqT0inhmDSEY+LwaQAowKHRO2dCw
 Dwrqf+jjVXwVV3/PQ5csqMO0cTkVxPd1yOkpJJT+xU57f8C/2H9HvcoZ3mJQGOksDBD12/3e4IS
 Hw4NOm4Gz7xu678rYakgNdjFC+LtE5WYyCtaANY62e8SAY/pN9U/EeGz9sQnj+m80OTci/Ifonj
 v8R1M6nexdMxSHy1NDmyzrvMegS4ADPU2JoBxkK8YAG3RXfxGiqcuqhum55AE6zul498ER2t2bp
 YasrI5YVMwi9rZondcVw=
X-Google-Smtp-Source: AGHT+IEQlu622z9lRWVJIUHfIIS6uWvTATaJZOUEBE+Q4GFVoojGAdyc4H/Yn0d1VBIUCMFeiCjLnQ==
X-Received: by 2002:a05:6a00:8d87:b0:73e:2dc5:a93c with SMTP id
 d2e1a72fcca58-74091a3c859mr1448028b3a.11.1746490281258; 
 Mon, 05 May 2025 17:11:21 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020dedsm7781314b3a.91.2025.05.05.17.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:11:20 -0700 (PDT)
Message-ID: <0213a059-48bd-4c90-96be-afb25ae46341@linaro.org>
Date: Mon, 5 May 2025 21:11:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 02/24] hw/acpi/ged: Fix wrong identation
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-3-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x433.google.com
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/acpi/generic_event_device.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index c85d97ca37..7b2d582fff 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -458,11 +458,11 @@ static void acpi_ged_initfn(Object *obj)
>        * container for memory hotplug IO and expose it as GED sysbus
>        * MMIO so that boards can map it separately.
>        */
> -     memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
> -                        MEMORY_HOTPLUG_IO_LEN);
> -     sysbus_init_mmio(sbd, &s->container_memhp);
> -     acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
> -                              &s->memhp_state, 0);
> +    memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
> +                       MEMORY_HOTPLUG_IO_LEN);
> +    sysbus_init_mmio(sbd, &s->container_memhp);
> +    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
> +                             &s->memhp_state, 0);
>   
>       memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                             TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

