Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F179C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpSl-0000Lm-IN; Wed, 24 Jan 2024 21:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpSk-0000Ky-25
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpSi-00029V-I7
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706149648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGSvalmy3OOuq6kmTYY8j96vTanO2aEuHW1+v0wfOAg=;
 b=QcnmH109/9K8j1uLVEPZDUtTQqvi16nPHbQUmPUJk+0UOJz7akRaFU3xh3B2bl3a+pPb5S
 k0rR7BgJqsq5obwBoxuSMJKU8TgNEWvViZcTX9zIhn9A7SAO5fKxh6sTIuusB3VA4EFE0m
 ihpgL2pv3R/fBNzSRjhcWMzEkhDH4SQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-guH1_gErNyeZDw-3EG30Og-1; Wed, 24 Jan 2024 21:27:24 -0500
X-MC-Unique: guH1_gErNyeZDw-3EG30Og-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d43d0d6024so1511356a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706149644; x=1706754444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGSvalmy3OOuq6kmTYY8j96vTanO2aEuHW1+v0wfOAg=;
 b=v7AcbfJEbp5oQgIiJrOwjHS01jzW5b3xNmDMf2VH7L1u4ZHxXPFQJ2pgdNCmUtXhye
 k3DC46epLAuCk1mGe5VgiCFP2CIEN2yxFS+V3fm1Um31tv96FUwZ7zQQSbOLI9cFp0RI
 PSDYTKMNGW9K8tZAi70x1ywz7JmYMy7TSGMm+SBTRZy9Mlxi7anxM4HIHPH/33433agU
 gG7QSBJBp4OXmctwaysWjVZb90Alf9wIEJv+nQTyfRpMX7LkAqv0gYeZs//oCDL6znYk
 70bjiI1d7cwAyFdbldBubd+NC+P/Kq5qEimS2KU2aQkDtp4A6rJZQbIc4X0VByZtEZWi
 pvDw==
X-Gm-Message-State: AOJu0Yx8mbP2H/V9aLRZDlTj2saSrG4YvELi1AM2gH0yAcy+mcMNPNfV
 lyDkZa7u4eCsCuJm7ViO46CiJO9F8vCyw1kr1PN+jEnMAND5wtNI6twvh5ZyjCexGDubIelihXW
 Aw6jbi78URUpCoVUQtp/KctZedjRxX68opr5hiIsiehZdUObHs3WN
X-Received: by 2002:a17:903:32cd:b0:1d7:1c67:3f7c with SMTP id
 i13-20020a17090332cd00b001d71c673f7cmr211089plr.92.1706149643879; 
 Wed, 24 Jan 2024 18:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhVwQPv45Nmak+PDpiW69uGMalWXO+wW5roa0w7KcVhxcsRTKqrmaDNmbXzGB0JHZQcwdlUg==
X-Received: by 2002:a17:903:32cd:b0:1d7:1c67:3f7c with SMTP id
 i13-20020a17090332cd00b001d71c673f7cmr211085plr.92.1706149643638; 
 Wed, 24 Jan 2024 18:27:23 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a170902b7c100b001d75db0ae21sm4696611plz.170.2024.01.24.18.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:27:23 -0800 (PST)
Message-ID: <a7f9105f-5375-45de-b25a-f47df582d30e@redhat.com>
Date: Thu, 25 Jan 2024 12:27:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] hw/arm/aspeed: Introduce aspeed_soc_cpu_type()
 helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-5-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123224842.18485-5-philmd@linaro.org>
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
> In order to alter AspeedSoCClass::cpu_type in the next
> commit, introduce the aspeed_soc_cpu_type() helper to
> retrieve the per-SoC CPU type from AspeedSoCClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/aspeed_soc.h | 1 +
>   hw/arm/aspeed_ast10x0.c     | 2 +-
>   hw/arm/aspeed_ast2400.c     | 3 ++-
>   hw/arm/aspeed_ast2600.c     | 3 ++-
>   hw/arm/aspeed_soc_common.c  | 5 +++++
>   5 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


