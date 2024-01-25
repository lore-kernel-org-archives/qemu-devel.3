Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC0C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpBb-0000qM-Q5; Wed, 24 Jan 2024 21:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpBa-0000q1-1l
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpBY-0005AB-Jo
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706148583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOHbsRr20QruXk56khtKTTMov+K3GYDTbgrYusTtrGc=;
 b=bqxOWOTgnmvHpM41A94arR+ZGFCRjjcSQHZalZ/2Th+L5BAtrrnWJVGNn6RUNLu5ZX59TX
 NuYCr9fsDc/8vkMf7kPJ5fNtU6X9pa69HNmRQt9Ey1q/hMbpXwv6ht95whKlUGZu9jYSwr
 I41CEUxXZMU72kfFVM9nFKmth5ZbJw4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-unklQh8FOVmw8Lfoi74_mA-1; Wed, 24 Jan 2024 21:09:41 -0500
X-MC-Unique: unklQh8FOVmw8Lfoi74_mA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d73d38b93bso57148995ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706148580; x=1706753380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MOHbsRr20QruXk56khtKTTMov+K3GYDTbgrYusTtrGc=;
 b=E2Q3RhpE98KzYTeT+S1bc7iUjpTuLFLu4VdUelgIL2fVtrSUeMJ28PjxgAzDDB8oyx
 xmly7S9ntnmfBsZ6A884qdjkJFdJo9KjXG1rUl5INaeFQInVHQaZzsTLLejPAChoBhFn
 sc37NQJg2d66Bk2XBNb+33rdYkQAfYW4UcVuvfZhcnM5yWLvd2n4Duak509g2leHAEk9
 8GDTMvN1WGPo9zncTXSTQtZ5vQfTGTOK2zP5ZkFOZAMANJSY6Pbxm9tX0CrS3/gHhKah
 NGk6Bl3RgydgoqMu2omVaJJ8wzHkZ3AQkk03/ChfaSkpysFzoyuQsjgzg1+uMG/vLLIq
 /RBQ==
X-Gm-Message-State: AOJu0YwCUBL5siJx9KOwvCWmkTRQNNH3dEhspSMa0I5o6rnfexVkddFZ
 daY8aCEHP/ObYr9F6y2/AAY7MYrfE3EB738Ti/SdoyprWijNEvWpqoOHZKPm5dpQsk/Hy93nRoS
 lfB4XUYqD9987BzZGldluDHWZsP2Z3UA7h/vi7C8jEMz2kKxiFQ9z
X-Received: by 2002:a17:902:e744:b0:1d7:505f:9223 with SMTP id
 p4-20020a170902e74400b001d7505f9223mr346188plf.80.1706148580256; 
 Wed, 24 Jan 2024 18:09:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMPBDnFwKe8/inF9yVwTzzUtzUDuTQfYs89TYjGp4zR2Zy93TO2OBWtLWtOhdNXsbqRNIPUA==
X-Received: by 2002:a17:902:e744:b0:1d7:505f:9223 with SMTP id
 p4-20020a170902e74400b001d7505f9223mr346167plf.80.1706148579938; 
 Wed, 24 Jan 2024 18:09:39 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902e9cc00b001d7035b11d6sm11015403plk.254.2024.01.24.18.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:09:39 -0800 (PST)
Message-ID: <8f5768fb-71f0-4c26-97d7-95177fa6cac3@redhat.com>
Date: Thu, 25 Jan 2024 12:09:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/exynos: Add missing QOM parent for CPU cores
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
 <20240123222508.13826-2-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123222508.13826-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/exynos4210.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


