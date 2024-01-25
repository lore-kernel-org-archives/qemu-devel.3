Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD922C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpUK-0001Nc-8R; Wed, 24 Jan 2024 21:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpUH-0001NT-8V
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpU9-0002qQ-ST
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706149737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sbOvcfEWWEK53LE7l0I3Dcz+BF6OyIsjlFHOT7/sAs=;
 b=KPnZwpdfaDv9nnb2MCufuHdDAff9tqMN3SEH1CSbVuN3uYaEtfyB4DfzpTlbrID9SleQ/g
 I4uYR8kTtO1juVq9eNsQR5ZuCGVJh6nIlAoqpcR1z7NtnbgRLBcOCu1S6V6nmNuegl26L1
 dmtLbBHDBKZ3jkY0OmfTiNXgPAvwZIc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-dcxpn1tvMT6w7ilLy0BwXg-1; Wed, 24 Jan 2024 21:28:55 -0500
X-MC-Unique: dcxpn1tvMT6w7ilLy0BwXg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6dd7b50177eso2045057b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706149734; x=1706754534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2sbOvcfEWWEK53LE7l0I3Dcz+BF6OyIsjlFHOT7/sAs=;
 b=Rowq8CWs9OEBPNRoyVxFFmlfDKDML4bDJCEJ/rt/tAGn5DBVhUP/iN26JdgpXq5W32
 c3qlFrD2QvkzdJ2/Pl/NCcSOF/xjkigy/TSUjGY19sT9eDDtM1tMQgs0Gid8N7tZLBNJ
 9WCcE00e1ulGHUOV8tSZMgNfu7ejEa/F3bOXoHG6jFkfGPJtYQy8/qPHfywTBqZcBfmV
 PJtHESXV8d2aHtQs9uyld3YdElE/RUZGkFbw0tnWL26g1M3blQ/z1DxpDd6RkgYTxsbU
 7KYtRHQeHvML7JP96PQwSdKQ0BNlHpIiRww3lrbuocdGuV3UqZU2Q1JGPnT9QLVyD9kd
 vnnQ==
X-Gm-Message-State: AOJu0Yz27LKK6YuVAgjseqhKacV/icfOZmprKSOx5U9srSSZWE1FQd9s
 8FT2kjEBYYJ+KzFPMJD48C2R7FEzcigOE9fnQrKHUf01oyGNVp4fq76tIi3QMlCuXXGBtTU09rN
 8+JTtMR+N1DUKDSzkt6UW9sGqNy5az4Qn0ggb72GwigAGBx3pqeIq
X-Received: by 2002:a05:6a20:3d85:b0:19c:7690:12ec with SMTP id
 s5-20020a056a203d8500b0019c769012ecmr49636pzi.5.1706149734092; 
 Wed, 24 Jan 2024 18:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFIRHPIvy5+1UilGV44d/5PT9inJrTeLnrvKKT69NG5r1wt3DLvXXKHtE6ShNB1b+/Zrh+Wg==
X-Received: by 2002:a05:6a20:3d85:b0:19c:7690:12ec with SMTP id
 s5-20020a056a203d8500b0019c769012ecmr49629pzi.5.1706149733816; 
 Wed, 24 Jan 2024 18:28:53 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a170902b7c100b001d75db0ae21sm4696611plz.170.2024.01.24.18.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:28:53 -0800 (PST)
Message-ID: <b71999c2-2b6b-4996-827d-577b5ab65daa@redhat.com>
Date: Thu, 25 Jan 2024 12:28:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-6-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123224842.18485-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
> Aspeed SoCs use a single CPU type (set as AspeedSoCClass::cpu_type).
> Convert it to a NULL-terminated array (of a single non-NULL element).
> 
> Set MachineClass::valid_cpu_types[] to use the common machine code
> to provide hints when the requested CPU is invalid (see commit
> e702cbc19e ("machine: Improve is_cpu_type_supported()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/aspeed_soc.h |  3 ++-
>   hw/arm/aspeed.c             |  1 +
>   hw/arm/aspeed_ast10x0.c     |  6 +++++-
>   hw/arm/aspeed_ast2400.c     | 12 ++++++++++--
>   hw/arm/aspeed_ast2600.c     |  6 +++++-
>   hw/arm/aspeed_soc_common.c  |  5 ++++-
>   6 files changed, 27 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


