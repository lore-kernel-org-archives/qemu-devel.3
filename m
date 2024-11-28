Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B45D6D255
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 03:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGVA0-0000RT-CG; Wed, 27 Nov 2024 22:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1tGV9u-0000Qa-MX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 22:25:38 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1tGV9r-0002bF-NA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 22:25:37 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53dd668c5easo440099e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 19:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732764332; x=1733369132; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TPpM3+hhiQQO2fEwaDISyqX0W/di6qkTKJPXgsqgaCM=;
 b=vkNwbS/rOKo3gw+tymweFIG/EtnDxef7EitTJLhKKKUAKuRpKEx8i5aJ9sFV6HoX9X
 M2z25btdC9TnnF5JF0aJZhCOtW+IDlDYVm66ApY7NKJ1vXd7rQZEy8O5ExjPMsGGUjNM
 dWDN1vCc/mo+wb7DaFHFlrXTTclGVXs6Yz+RXjpYVjo+bo/qPkCoB8CJ//rExi4FidvF
 sxYFnbxzjqwhu6vk4sgldjzoehrqRAtywf309CD6pxhS7D0WSTdU/Tois0OfHmqksBH3
 VED/+s25NX8MbCu3zZHRsmaLaoYtahsfPACBqRdH2KX3UeDSmWj5lDNkWNqSAQgZz/hS
 WGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732764332; x=1733369132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPpM3+hhiQQO2fEwaDISyqX0W/di6qkTKJPXgsqgaCM=;
 b=c2pBc/oRn9HApkqG6EwO3FwzOtSQypIw/tlhssxawDCtgnEMoltwQbqs8JAHrAObnl
 kBte8B30e0tFKnCzCg5yypP1pAJUMTEUZkiMvtDSuFR2Mj+cnMijafR7rwbzreol8kDh
 9ZJDAaaKGibopoE7FuXZj1AcBXOnzOO+1LRNvozUsWDynw8+sMDeLP0QOduqdNNOTTS4
 Vzb1bGtXcVGuCmvMataLQeDKGfNLrbRF4kx+IvBmsiyjhUfh2P4DX87JfRzAaaz1M7iW
 PosRSj1RXhls5SzhCAAAcNjsUbnvd2FHom2eXbI2VQWrTf0fP3iY7CPT0DIc5Vsvxh3a
 wS2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhSR0Sf/7SZKu6GYb91CSfkxO2cDFUk/jqz94Eo2pm/3DzmmmgRzcy8r/F28xMXvWGs5eZGwphqK2V@nongnu.org
X-Gm-Message-State: AOJu0Yy7JyN3JO0huJk20SmDIssYcESyYro5HUvr9t07WuynQ5eoo0Hw
 pSDOsL24Q4J8R6g0YDpHgoasqGeAl7Wy2oedSiaDigFGzb50X9cD4yP6OscA+MhDHHwUbvUK7pf
 P2Wy2CkiO4nH3xdcnbXfQgrEN0Kg/b5fO2s0rlg==
X-Gm-Gg: ASbGnct2Vodx50OKbKCmmUI274ZX7wRu8n26VrbL0eA+mnMQzRwZctvON9T7jiu91/9
 lc9pEE0xTXyj25nm6Un0FeFYIKP2H
X-Google-Smtp-Source: AGHT+IFi0C4DY/G3XhxGMaWlhHJhZ9nYB1bVKo1NviecUL3Ncd7XqdZGovFjs1F789XoBscGVUiyIRDBfVmoeZCdlGQ=
X-Received: by 2002:a05:6512:2209:b0:53d:f198:a835 with SMTP id
 2adb3069b0e04-53df506e5e6mr444115e87.18.1732764332443; Wed, 27 Nov 2024
 19:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
 <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
In-Reply-To: <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 28 Nov 2024 11:25:21 +0800
Message-ID: <CABQgh9ErT6BmvbrUr_aNiLFws2Kx-=NzGJJCo+vV7AV_U6Pk9g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
To: eric.auger@redhat.com
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Donald Dutile <ddutile@redhat.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, 
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Eric

On Thu, 28 Nov 2024 at 00:06, Eric Auger <eric.auger@redhat.com> wrote:

> > Yeah, there is no live migration support yet in the SMMU qmeu driver,
> > AFAIK?
> the non accelerated SMMU QEMU device does support migration.

Could you clarify more about this?
The migration is not supported if using viommu (SMMU QEMU device), isn't it?

Thanks

