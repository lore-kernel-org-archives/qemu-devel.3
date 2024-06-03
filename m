Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D04DC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE74J-0004kV-SF; Mon, 03 Jun 2024 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE74F-0004jr-D3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:45:39 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE74C-0008W4-Im
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:45:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a677d3d79so1145052a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418733; x=1718023533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gmlkuNgEbbjNjB7ePZ9ooFXi1CZ3KjLC2lfwCL3kOtQ=;
 b=N/AkO976uAPgtOU6Nx3OMmwoTAjfix+bWjkV045iIAbJXRp5+D3aERMabH6SAO/4wM
 8TZyyThWPJC5SopnUrLV9nGTSrbFUFpayIZ5hr/YGSOY9bolz0efbuJMhSPXhPSoLFrv
 +DAavocGgdNK+pu7tJ28mHCNBDUs7gFtKVB0oA7/N/OO/ND04VsoggUNyzlXJoiSlu9x
 bF0Yk/CRueLCrB7ahhfi4EndAnP39yMgnLpmrc0hfnhppCS1eTSsfbNWNqx2JN9yzv2L
 y4eUYBwIjEXDJWSm61I3Mx0sU6KvH00MImmrj8o8tv4aBpDvPrcXSaET5b6InM6Bo22h
 ajog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418733; x=1718023533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmlkuNgEbbjNjB7ePZ9ooFXi1CZ3KjLC2lfwCL3kOtQ=;
 b=WYVa+UC/nloKM0tMI7WXPfhvet7w9irfKx5BylwXRKapvXBBLqFZxrOiEXeYpdVgqS
 P6uXROgaRL8M88dUfCmcySfGY3mG2kUqCJsJKlfuSRuo7U228VYawfcAbItIIboRYnF9
 /NRe84LFxIAFFfqS4RX2jGoIyAb6M6BU3wc78vRgPu8qPaHzaVetAPTmo2ZxRvjxUJCH
 6raNS+BypqbT3UeaxT94ImCMzzZda59FecuSAKUW+XOTbHPKfJWroFXywNETDosfE8qb
 4B9RomlqePAcYGRcX3YXATa44dtRNA8kMP65BVi2gp1kgf8I7yc/U7qgi1s6oR9/2OMX
 Klrw==
X-Gm-Message-State: AOJu0YxufYWU2d8JgyRXUbRs4Gbmr0HoPdxRJdKH/LIn8sMMD5aZw7Wu
 gk8YCuC5D18QigV9Uk5SmvNfFIQrSc2YoJyaJ9/WWRiSJi2xUkqfdZqGqeHZguK5I0Apx44vjio
 z
X-Google-Smtp-Source: AGHT+IFPyTy40M2l3vvYWeXduv45DuHHkZDrsu9AUfF72sRwGlI/yJRq6AnVEs3hpY98jX2d2kAmJw==
X-Received: by 2002:a17:907:502:b0:a5a:5b1a:e2e4 with SMTP id
 a640c23a62f3a-a68193354ebmr672230966b.20.1717418732918; 
 Mon, 03 Jun 2024 05:45:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68c9ea107fsm311345766b.12.2024.06.03.05.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:45:32 -0700 (PDT)
Message-ID: <d27a5741-5b5b-4a0f-9b4f-875321da0fe3@linaro.org>
Date: Mon, 3 Jun 2024 14:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qapi: Remove deprecated events
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240530071548.20074-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530071548.20074-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/5/24 09:15, Philippe Mathieu-Daudé wrote:
> Remove MEM_UNPLUG_ERROR and 'vcpu' field in TRACE events,
> all deprecated since long enough.
> 
> Philippe Mathieu-Daudé (2):
>    hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR event
>    trace: Remove deprecated 'vcpu' field from QMP trace events

Thanks, series queued.

