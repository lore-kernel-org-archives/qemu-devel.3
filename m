Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354461075271
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w384J-0001Y6-I5; Thu, 19 Mar 2026 03:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w384B-0001Xc-Vv
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:45:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3847-0004qF-Io
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:45:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so4902395e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773906307; x=1774511107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gLzr8wGtZROuj+CLWDFW7qVHQ2OEntfYLgM+MR8M0Gc=;
 b=UmzRB2AhQiwnp4bPcKgoLvuZ9xX486GYZGSZhtGv93ZLlcK8mFSL7sPqDH0Urf+tgC
 2UizRmAtIUqXr3DPKo5/4ktVykTbWP9BhOgFgNk8ZwRneKOZ2+4LgI+LCPIbBQ3UfPQO
 Q3CPC22u32leOkZjb2/u+4EY9PPhAwmxw7XUPxL6VHQbXNQqMstqHEYRsijQV1W2c5Ez
 QUvwEWeUr2Cg2wg9Vf8vBGbItE1/bBoZcPhovBP66taQ48f7m7Ttx/L4KrCy9U1vgZpb
 6w+C1qiIR7oEus/CMIIp4FNM+ZEMqfEJDp2ef+UEiHJbgF4mImOugHvMqJbxg5Qe30XH
 8FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773906307; x=1774511107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLzr8wGtZROuj+CLWDFW7qVHQ2OEntfYLgM+MR8M0Gc=;
 b=VOyVfw5ciEz0+oGbsG2ralf/jCA/xANVKw2GtnC8SqGDo+JP/DzyYLRrDJRHWKGvRI
 NMnr2hpqG75OVHxegACsNcnwYNpqGQXZ+2VjnnbxcfHX8cuqpg2gSWKeLlm3NZPI3gAH
 X7o8xaOpnYWoZWYWV7KyZsjW5lMK2jT6RNJsMS4cyYIRLGAZqQQMuiuj6PnBuEljyHs+
 KfxVtIEsg3+1eCwQNVOTPz3LUP9Tn0LGEghojlWKQlWCaAxtmqHaXUw6S+S6eeshlmty
 u38ZR16dUQyLe3nl7dyilB6w/FIvwqlqcJeJgPiJRp9SiKj/I+8J6fWXOSl9HL8+Y8r1
 BXeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaYHZ71PlMJyUYEiG0A1iV8IF57yjsHg2nkXx2+weXQ7OhIIWrD6gNFHhnnp1GG53UDZZHmbIpj8uO@nongnu.org
X-Gm-Message-State: AOJu0Yz4MP9jbDMt/M4jFYWA0dXjDuxPQVXi6g5SOnG9DVQjfzsPD/6x
 TlSo8Stj2q7dX2U9m7zCHzvU/P7JJfYcrZoHgYUbnqR9g0reK43DZwJnpxrpDMzS7yXtn/cA4jG
 HXQ7j7zY=
X-Gm-Gg: ATEYQzyPo89mypUn2dWtdTnXf1nUYBADGkr6+hM8RAblbbmAWWkrwNhzp4N02pMRAwC
 VN5IislZJR414jQs1OgOgqzRiVaZfhcRjkD7NwN3ZedcR14u69xcqTh8y/zHDzid3/CwC56hXtm
 pM5zGk09eERylo7zW9JlEG6V1Tu7mbhkvswNrnkq0+fBLqPCLNoRrzeEQZ3mZEo5kvv3Fc0Lv+G
 L9ch0zDIqr3zLdDovRwqHqkzcyPbS1NR3rzo8meuA/CNA7DQwH31sBhaWZSXswttpPDa/oabCO6
 r/cdNW3xV8UQUOUlgOAFW2WoJZmsBbPUhryorTjURAg11hxtnM0LJuD+JLf/7+/+ogGS5vE50B0
 BqHlI49GnEq3/Wi/eefhZiZfsfDtXM3/4NpnuvNAyvjSuL2yU1QssazK1WsiIbnZj0JYzr0sHQ8
 DXQ7XwRJ/aL9rHOF96ejmClw8vmr7vlVRu0wk=
X-Received: by 2002:a05:600c:6097:b0:486:f634:ef3 with SMTP id
 5b1f17b1804b1-486f6340ff0mr71042785e9.32.1773906307177; 
 Thu, 19 Mar 2026 00:45:07 -0700 (PDT)
Received: from [192.168.69.206] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fbea40c2sm19803765e9.5.2026.03.19.00.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 00:45:06 -0700 (PDT)
Message-ID: <f974481e-17ac-4ed4-bfde-1d6f350d21da@linaro.org>
Date: Thu, 19 Mar 2026 08:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] hw/vfio: single-binary
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-ppc@nongnu.org
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/3/26 18:47, Pierrick Bouvier wrote:

> Pierrick Bouvier (8):
>    hw/vfio/listener.c: remove CONFIG_KVM
>    hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>    hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>    hw/vfio: eradicate CONFIG_IOMMU from sources
>    hw/vfio/pci.c: eradicate CONFIG_KVM
>    hw/vfio/ap.c: use full path for target specific header
>    hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>      hw/vfio/kvm-spapr.c
>    hw/vfio: all vfio files can now be common files

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


