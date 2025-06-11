Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB79AC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIkk-0006b6-Ox; Wed, 11 Jun 2025 06:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPIkf-0006a5-Rs
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPIkW-0000YN-Mh
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749637914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYwl1oGVaWnICbOngbeJqBrYw/IXWit8BAm/nOhBPCk=;
 b=fWMayauyOcEoxubycJ1JSXbmfjAWjIvSWXg5WbMyoEFY86GXZEIip9wbhDqUWzgeIsShwB
 hixSTLn87rcQTW7jtsWMoAHP81zdYDe/h4PUX+jCqPG1/jM6Sag2zL6Tt1dn/tOcicdUv+
 /dDx6VzgiawO2IG3npibCLcT/XKUsro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-BISrT12lOCmht0cEsY2pkQ-1; Wed, 11 Jun 2025 06:31:51 -0400
X-MC-Unique: BISrT12lOCmht0cEsY2pkQ-1
X-Mimecast-MFC-AGG-ID: BISrT12lOCmht0cEsY2pkQ_1749637910
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450787c8626so37121175e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 03:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749637909; x=1750242709;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KYwl1oGVaWnICbOngbeJqBrYw/IXWit8BAm/nOhBPCk=;
 b=pAbo8HWmfYyzSJ9RiLOwj895hy5cTieksyQvOkQaF59BADjVDZrss7J3fsQpY26no1
 PnvvQYTkEfOiz/c/54AziDXt9lS0zF1LonLrgeS3XQQFOm6p/JUiNvffHqG9sRZ6nqxW
 JYWcSfp0Soum3ndNVJ8Rs9CfR4xRcobHU2C3PXtSYgkLkGGrbjmLNqqHSooyzMe7udA3
 APB0AlLmt/7JR5EvS+i4IFVgC2gzdM5jHJlMufVYSFjr8tDDdOj5/Z4c7tZ3G7Cx+tLh
 DupjJXYlraIpMdxY0WmxG5BNiBVyBmuR+sC9kGQbmi0CBxslJZvIorPIPyETWz+d/ThX
 /E7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTI9oh993iM/PNDB50klYnvDl3j2haAcKgh+YukeViFG288tNJj+nKq4NMPOkIr/30yF7nHeDUHXmj@nongnu.org
X-Gm-Message-State: AOJu0YxG7wijP1p/v42DW8j8tC2J6MerEtzlHomNpheA/hdcleGStt/j
 4aqPKn3bQYIV2opw1Yk1/fWA4xOih8sG56m7kzmp3VwRPNNnY5MqcrNxFW+Dphd6l4kyIj8aASP
 agIwkml1LCYuUSNVPdqcw7yskivmj0jU7r1wUljLkMAYApmJh3O0Us2Mo
X-Gm-Gg: ASbGncuyThsKGV3dzZlXRxgwjebVOB/m1S7aic151ao8+3DDACDYzrwuaGkNrK3UX/B
 GHBfu/PURGByzsJbQRBXLr5+lIlgkfSYe7GNKB+cIMnmYTckVUXpUFiq9DFts57ZtM8P/a7cljS
 aGVrZghAL9+JLwniiVmf7CAX6h9RG5+qGpm1onr9RVOrKOMn3KTeeRXc6Jmoiap4uzT9WSlPqTT
 kTl+zrZucIkrLO6g0TCobObx8CJAThaQPhmSogTm4kvB+sU6OdAt4RziJy1tqr8n0GZh3bY6FLL
 Dm43mGX3BVgeZBMcMfI12sOGkK/WDaHWlcYlxgQYhrGp9DRX2vPfDeU+IepBWls=
X-Received: by 2002:a05:600c:6612:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-453248ea6b3mr26108545e9.31.1749637909684; 
 Wed, 11 Jun 2025 03:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwsSCSIQndKWXCEasjIdday5YV9reC1YXCMJ+e9GeYXfdce70sEDPzUQ4ZYLJ0pK98Z3mf2A==
X-Received: by 2002:a05:600c:6612:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-453248ea6b3mr26108255e9.31.1749637909320; 
 Wed, 11 Jun 2025 03:31:49 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net.
 [47.64.115.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b33c3sm15049724f8f.34.2025.06.11.03.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 03:31:48 -0700 (PDT)
Message-ID: <2fcd528a-8372-49e5-94de-374e6f75619d@redhat.com>
Date: Wed, 11 Jun 2025 12:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw: Fix type constant for DTB files
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-2-shentey@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250610204131.2862-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/06/2025 22.41, Bernhard Beschow wrote:
> Commit fcb1ad456c58 ("system/datadir: Add new type constant for DTB files")
> introduced a new type constant for DTB files and converted the boards with
> bundled device trees to use it. Convert the other boards for consistency.
> 
> Fixes: fcb1ad456c58 ("system/datadir: Add new type constant for DTB files")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/boot.c | 2 +-
>   hw/ppc/e500.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


