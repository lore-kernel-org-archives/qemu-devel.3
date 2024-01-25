Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E1AC46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpJ0-0004cb-Ig; Wed, 24 Jan 2024 21:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpIw-0004aL-Pe
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpIu-0006P1-Oy
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706149040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riOWdTRcTBxaCY1uwzMiCSlBMLfG4ktU0x8g455Wx/c=;
 b=TphdeXlRVNuHQVP9Bu9+f0HOEpX00Z/TH4D6Mn698a+E62EagmDPrKqd6IIEgOnZMCzT+D
 KwYj+3svvQS8pPi0dszslo3Fp4IRuTnMgdtERMZotuA+4CFmtxsUnUaKTQM1y7CvomyhOz
 MHvDI3TlnLlKhZMq7zsqRCej26izJTw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-qUeBxTFrMfuvUt8xrisLFQ-1; Wed, 24 Jan 2024 21:17:18 -0500
X-MC-Unique: qUeBxTFrMfuvUt8xrisLFQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6dfb69507beso6392269a34.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706149038; x=1706753838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=riOWdTRcTBxaCY1uwzMiCSlBMLfG4ktU0x8g455Wx/c=;
 b=RKWaBztLVE9uAYjUjCBhCeOTp9fLfpGjn2pOxX/p+bZSP2K4FaIGwOblloOoDuJPdX
 at0I0VBTMg0Jfq0FYwyqMcnAvfRdCG5ZnsoD9U2wvxzwWmO3hLR9MsLns8YjDafAoOZm
 d9/dfDcdAq8VWPGZZxQpq5zQxr3wP1J8gTmalui9SyefmGArRy4aL6EQrzlC5aZrxt37
 29r6He8wZnrr/q8a3fCqcEowKYks8xaXYIQJF2hlMA5opfI9omKr6UElx4J4PBDlnwJC
 VZZGq/IC3xet9gGjfaMWelaB7pM2ogVxokHfOj2Ns4EWL7/34HlQ7YP/xdvKuWMcY0/Z
 mBvA==
X-Gm-Message-State: AOJu0Yy8eUnJoCrLxBpUMxFos0AiODXVHUvV/bqoCFnjqMQHMgKJJXfE
 6z/o7zU5oZQ/Zf5Im8OqmPf+KqYpDAVD3VMGxA7EqDTIRh/e5mUlVo8BVukErd3X7kztQFob4DX
 FCk38dnkHcSrgb42drm/ngloKTTu241VBYPiJyPXlPKuOdm2SyNQM
X-Received: by 2002:a05:6830:1097:b0:6dd:dda6:67b3 with SMTP id
 y23-20020a056830109700b006dddda667b3mr155851oto.67.1706149037917; 
 Wed, 24 Jan 2024 18:17:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo088OkYgZw1HE4B0TDyp7XBHVWoJYErc+fBJ0lSVwkFZaF+ftHU0uLj/BlFCjVbssga4VmA==
X-Received: by 2002:a05:6830:1097:b0:6dd:dda6:67b3 with SMTP id
 y23-20020a056830109700b006dddda667b3mr155839oto.67.1706149037650; 
 Wed, 24 Jan 2024 18:17:17 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 b19-20020aa78713000000b006ddc661a619sm423036pfo.7.2024.01.24.18.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:17:17 -0800 (PST)
Message-ID: <70ca8c50-3c67-4fb6-8919-33ddd38925b4@redhat.com>
Date: Thu, 25 Jan 2024 12:17:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hw/arm/zynq: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-7-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123222508.13826-7-philmd@linaro.org>
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/xilinx_zynq.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


