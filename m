Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2DCC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiRz-0001dw-7T; Thu, 27 Jun 2024 02:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiRj-0001Yb-Sb
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:17:36 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiRh-0008UQ-L4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:17:27 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52cdcd26d61so5770222e87.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719469043; x=1720073843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ndlifsNCQYezHNLFV2DqCJP6bFDNPD6ngbGuGWFra5U=;
 b=a7KggvbkzjPtlD89nm4Sx7ehUvXMF4MuJ8TEGG/mYPd4rDNzoppxmxES/wUrZA96PT
 /VJ88n0YXVgUhHQAxkrrX3OLv+aGapqAVRK/vK9dYgauRtf89D749LeMc3CnARK6rvLw
 afu2rBdFo5TtH45VxbT9mjpooKGq6Sqk/prxuUql++yVNiKHIvgxXTY1w6IawdtM2Kzk
 geTX3H2jxFRiouTRYG8DggDiGOcd1d6vFd2BbWCIW5TRACzB3SS/XfF8IloruW5VU8VP
 R/MMlFEH+ML7Mw3dcvykmDlf5tFVDPlFmpkvmxDc1+jVK4IwkbBvSuQZPnnBcGU2AhOF
 d00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719469043; x=1720073843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndlifsNCQYezHNLFV2DqCJP6bFDNPD6ngbGuGWFra5U=;
 b=RdhKKhbhXq3LFeZpZWrRpF+WPLWOg6Qet9wGoSbDKmeGHG8DOaLxMS+EozMOeqnYpj
 CK1axdl+WKBuSu+pt/JMO74HMK3jAvY48690lushQv5edfv6Jk1Ta+Z3KSKWVeZJOs0c
 xkB+CYZ3Dq/IzPfgjqWgEGoyCfsgI9SmM0MhryXFnfrxcWhFCK8vGEwwyg7ms8+xpDph
 WLQXfZnIWROT9vpWBqpFy1YMyIe9YHC6ki4os+RGC4KhMGzt6rFXfxlaASSwCU+1r8L8
 KigzQB2+1mAgcHAZJdOEQdHqdrdaFa8Wnjky6dYqJQ5XBTqf5LyqKfmyzT1+Z4OtGDj3
 biWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHq8wIHlgFYhl7RMJwmMu6V6W9MYzIVdb09303S5U0VOuxV1rxwG1bc9y+RW6Yu7tefntPVj3KlKPt+bLBCjxbUi0/pqo=
X-Gm-Message-State: AOJu0YwabTYt2UqkUNh/+kMhUcdxcSdC1kr9K3vk6tylloQ8/J10O01Q
 xdWhIINAN9CTFdrFnCevzgUy1o4avdV+2Tf4dKklDTtV1dj3Lza9ZDjgx8Vpxd0=
X-Google-Smtp-Source: AGHT+IHNbWb0Fxdioterhk72VL4p57G0k2byeAAADdvtY1bBX53j4hLNCHamVZNMN1gpjdJiY366gQ==
X-Received: by 2002:a05:6512:b11:b0:52c:f2e0:db23 with SMTP id
 2adb3069b0e04-52cf2fd4fcamr5187322e87.40.1719469043185; 
 Wed, 26 Jun 2024 23:17:23 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c826a2e7sm48980335e9.21.2024.06.26.23.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:17:22 -0700 (PDT)
Message-ID: <8f60edd7-192e-4690-a900-30140ca54028@linaro.org>
Date: Thu, 27 Jun 2024 08:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/i386/sev: Fix 32-bit host build issues
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, berrange@redhat.com
References: <20240626194950.1725800-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626194950.1725800-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 26/6/24 21:49, Richard Henderson wrote:

> Richard Henderson (3):
>    target/i386/sev: Cast id_auth_uaddr through uintptr_t
>    target/i386/sev: Use size_t for object sizes
>    target/i386/sev: Fix printf formats

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


