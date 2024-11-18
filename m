Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F98D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCz1q-0002s6-6m; Mon, 18 Nov 2024 05:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCz1k-0002qc-SE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:30:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCz1j-0001dP-4a
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:30:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so23722245e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731925837; x=1732530637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GfCwnFHBDBs9mhA0RO1FRVb8TdiDBm39bTKS+hetZfI=;
 b=lFiIcRDNbDPIDDtOi32a1q4aJewrzZXVFQuPXDeZ6Ssbl/J2tJ8WVDrJoTj9FKP9RB
 Sf+PGP/z50ky+GnjzUq2lne6tfsOWIQuhS1WWzGqSUp1q/8oOQ3nDJ00sgi6VZM+YCUu
 zULNTcfbEXzw39tRy8YFPH6xDIEpzod2IMS+bd20X9+BoVyTU/bdyrfb+Cw7naxMmPDe
 uwgi7XeQbqGQdiyicfwRfPq4H59v60CyDPj+TezQad0cy3xZGtDAaqmPpmSYdJL8Y58f
 R8M7jXg/QP0JUGasbA7VQ2+aWzph03dVNd/pHDmeNDHMMLkToemBHkfRVqEMbJHG+vtf
 ClWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731925837; x=1732530637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GfCwnFHBDBs9mhA0RO1FRVb8TdiDBm39bTKS+hetZfI=;
 b=ryBPUPYYw2e7sT4Dq7y5lofhY18BZUP9clyV/cjMKqs0PTV3gUtLRFPg8C9Q6pfxaH
 mM2GqwPYuTZGuNvWXsZ8bqVHsMQzeMCvsLoVR7GS+t26cW0J9cAxFQQtZl8u4QIhON8y
 X0nZxr5QTKnmCDUbG9YJhjT3ya52U+IpxWeov2YjDu8DZOp/6mCb1WZNAdHQQUe1A74f
 vID3jFFEXdi395gUjFdnDOf4ofNlsZS6UZextZX5Kto+vgm16wkt7yBhOexPASnlTGRX
 hIK4KcxAkZCs4kQD4tS5NZtkWl0emzKbPPG2Hfn3WeYchi3jqKZ/geVyat+YSr4G8gL8
 KJPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUndf1x2tz97puZs3LBlqbrrB2NCypktz6TbLBt4axeCMHxRXMQvHdxH5ENmmubYAroVatNPRA0SCIS@nongnu.org
X-Gm-Message-State: AOJu0YwKyRWpnAnsgN9gODi6zv2x3KWFzE0NV8rIda8s9rf4I0tuFRGY
 m18nXViOeZn7KTN3lEMOMXzCsLRW2WtIv49nx/vPXs7E3FUxeGegsX7W4Xpj2rrJA83RSncickJ
 r
X-Google-Smtp-Source: AGHT+IGDl7hTAMzyz0l/DZg7pI9Slsphi2T5VHzrZEXeNDGQjzxLJ7OEYAlZ/pNjTA+YcRJloZxCFQ==
X-Received: by 2002:a05:6000:1886:b0:382:32cd:8c1c with SMTP id
 ffacd0b85a97d-38232cd8e79mr6436071f8f.47.1731925837006; 
 Mon, 18 Nov 2024 02:30:37 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38247e034d2sm2522931f8f.110.2024.11.18.02.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:30:36 -0800 (PST)
Message-ID: <1738dcc8-630b-48ff-965e-d73b766f2ea6@linaro.org>
Date: Mon, 18 Nov 2024 11:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest: Add qtest_system_reset() utility function
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
References: <20241115165041.1148095-1-peter.maydell@linaro.org>
 <20241115165041.1148095-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241115165041.1148095-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/11/24 16:50, Peter Maydell wrote:
> We have several qtest tests which want to reset the QEMU under test
> during the course of testing something.  They currently generally
> have their own functions to do this, which work by sending a
> "system_reset" QMP command.  However, "system_reset" only requests a
> reset, and many of the tests which send the QMP command forget the
> "and then wait for the QMP RESET event" part which is needed to
> ensure that the reset has completed.
> 
> Provide a qtest_system_reset() function in libqtest so that
> we don't need to reimplement this in multiple different tests.
> 
> A few tests (for example device hotplug related tests) want to
> perform the reset command and then wait for some other event that is
> produced during the reset sequence.  For them we provide
> qtest_system_reset_nowait() so they can clearly indicate that they
> are deliberately not waiting for the RESET event.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/libqtest.h | 25 +++++++++++++++++++++++++
>   tests/qtest/libqtest.c | 16 ++++++++++++++++
>   2 files changed, 41 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


