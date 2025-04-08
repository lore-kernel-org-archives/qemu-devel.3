Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F959C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E83-0006dT-Rq; Tue, 08 Apr 2025 14:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E81-0006Tw-Ig
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7v-0004Jr-3R
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3313756f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138608; x=1744743408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aar0fJ7Vs4z1geDlA6Q01FVDg7iAx6AqY33ZS2R/YkM=;
 b=jwNKARXBKbnXnOCJ6a99cY2TDrEywIAcxRC3yUIQGgVBHWSkNpmdO710uUzAt6REe+
 YcUCqNkofQFlQttC18wA6IJ+gsi679Nl7ynw5+PIhqs5XIFtjIH9KWjCf+7hmJCOrK9k
 dReLmtTLmcSVOnrRL0GploqABmhF4rY8ILsNdh1RDr4lPghs1PVm3JN/HTwN1Vg5fQXV
 /4W4yENisUSV2lTLjuXwzPrZyIRIlPPEdxsOUoLJn/9BLXvztl3nWb3XsvBj5x+2MyqE
 gM53rDu2ukhXB8Ox7D9tD1CE8hHkEq8BITjKDRnr7EgZ2C/QbiOQtLSewQBAV5kYeZNV
 e3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138608; x=1744743408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aar0fJ7Vs4z1geDlA6Q01FVDg7iAx6AqY33ZS2R/YkM=;
 b=HHInEL2EzwWHrV6GVgK8j1ULmsU4S5MdxvreYHVMCiqed7RFE1TLJED0jmPgioWcdf
 CmLExbvFvTquMjb33bT3tgT8qW1oWc6prXKGhW0Lcv0uMp48n3ZPJxyWxnXuzUIdsWGZ
 6lux7eFHMtr0kboLbldVVAelzA1p2D/zuyoZtEGE1IWJFGFBm72kTSDhv+JZmzXLXJTk
 xR4HFUgPgyaEQM3eNaZkS/tl+h6MkparKXFelK9jEa1X6AtC5afVDGOMDXALqsfpAjGp
 LLA86bhQiebUJ9YP1lWOtUNaF7yCJgsjmwv0IU3LA3KEWZ89pJxLNdO6zfcsr2A6iOGq
 vyOA==
X-Gm-Message-State: AOJu0YwQRMQNtKBti6V03W3cags+1OTzy5agd1HNpmgED4SJ0u915b6X
 nh2ki4GoNf9tiWkxBFS7uzyZzOBoqakHS8z62kIutNvnkrMbQz8FNonSEgoktl0=
X-Gm-Gg: ASbGncsQpzGm+s6hDOGP7xIT7p9O6Lmi/n8CMIuIUP8yHWvj8j6IgyIEbp7VthRsJia
 ox7ISXPuyncnjcdKB29Sfo9Lkj9g5kMILyOgP5MOX2Ju5y1/y3s1YCdeK2EhWOWbQ2LZPzYPNc/
 NtsfiRlX5652hHgjRGOlKsgizK/TSnmnGqOP+PIl1nKbltODDMznudj5Ta4IqWkhJV+0Ar6S3Tk
 1/HnIiuuLvxH3HTfHOJ1tr5p3IG+7mAfjjO+9YQqVwejAZYEq7aHAT3wPgYhXrJB4VQa7so4BEC
 0t6bV54/UoLARHhPRb0QTrXW3tv51frnO0ZZkC9nFM1DomhLCOprmoK/Jsr0b47maQqQo5qYwvJ
 oYVGIKljKVXrt
X-Google-Smtp-Source: AGHT+IF7r+OdHif1nTU2mBrUYmvofGlvkInl34cpcpHmVd5KfXG5VkXIRiGC4sT7Wh8qiV9M5gBm4g==
X-Received: by 2002:a05:6000:1863:b0:39c:1424:3246 with SMTP id
 ffacd0b85a97d-39d87aa1e43mr292400f8f.2.1744138607827; 
 Tue, 08 Apr 2025 11:56:47 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a732asm15876480f8f.30.2025.04.08.11.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 11:56:47 -0700 (PDT)
Message-ID: <151210e9-1969-4e55-99d2-53dc7e9d9864@linaro.org>
Date: Tue, 8 Apr 2025 20:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: Fix typo in SPDX-License-Identifier
 keyword
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20250408162702.2350565-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250408162702.2350565-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/4/25 18:27, Zhao Liu wrote:
> Fix the typo in the error message to help `grep` the example:
> 
> ERROR: New file '***' requires 'SPDX-License-Identifer'
> 
> Fixes: fa4d79c64dae ("scripts: mandate that new files have SPDX-License-Identifier")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   scripts/checkpatch.pl | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks!

