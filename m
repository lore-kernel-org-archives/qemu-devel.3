Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkhC-0000zG-Hk; Wed, 24 Apr 2024 18:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzkhA-0000yS-Ft
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:02:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzkh8-00055b-7L
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:02:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso2963075ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713996143; x=1714600943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9CwUmReig3G7NpBMEoNRZWtLIG9BKfDNAeIWPBESNBM=;
 b=ZyYteXScMYSmDubBaSFl7gLxc9mGz5vqi2knp2UOmRF8wA8J1B062GMtaN0N4Q54+R
 9b78R6kuNR5Sbk4sGPN0G4oMFrz0HJZSPfYI6GYokpv38mXPQ3RQQVMoZWWNhKu9C5bk
 lbR/OqWp9uMQQKHabVzp8LWh9r6oxUZzd+G5eEBfdiNafEPIjpBDbFi0hssFLCOOZFki
 8OcG/T7o97IsimlpgXaPpgzEx6VE6WMSYtOu5xpX8FW+iw/x0DXg3K/WLKaFUsvflo1i
 U5WObwzk1ioZ6eJswl5y41IYYzF1GSNMgc34SazAWGbyrFJA8VF0zcoCS+r2Sb28esAv
 u0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713996143; x=1714600943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9CwUmReig3G7NpBMEoNRZWtLIG9BKfDNAeIWPBESNBM=;
 b=tZQVOjOZIhrUzVSUVhPq2FFN+3M+PXkuFhatJUzX/ssYKXSeUeZp4+fhx4cXi1cKGP
 v7rTIEXPLdDKuTZ1+j/0MiiNOGb7dLLfkshOXz78ROrdyQ/i3BM4oXxJ1u/ybkJg1urx
 0yIK0uf56KOOSFsVtjuaQrb/mVu0tX13uIjLokpuBUzZfj3RuIs35mmeBaB0hG8K3+D6
 zAjgB6xUERwBJeLHAcQCegEHFXrBVilpnJQT9dlpGBzJpL/NKXtb+mMWf06nSdZyxLKx
 gKAjcQdlcq7X3dK4ZbjJTqPeCK3oLHcOZ34ax1vSVWgkHySSlSpQkzUg6nW3YlBvsPMs
 gsTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQFCJyG234HkwY0JWjz7nGgJdpbWyEzCR8vX86MXJhhTQUOfT3GGBdmiZxRsBVv+1ptVadODW1lEiOfWfzXzzWghBIcGE=
X-Gm-Message-State: AOJu0YyFjX5Sxp7EjHmt9pR6LWSqtguBBbiDtmgvEM+K/pdpc7wS7vAN
 hNBvADd7B1QtvBdhRuY2v13fdrzjQkY3W9yy4MIuUIHvL4NVldBXBB7ME86RFW0=
X-Google-Smtp-Source: AGHT+IHRofAoTFZw/8+2vk2wysmjYGG0xKy14yAXocSIfsv1+sm/iOsifgwRf+l6jloyIGOKG+/4wA==
X-Received: by 2002:a17:902:f54f:b0:1e2:6198:9e53 with SMTP id
 h15-20020a170902f54f00b001e261989e53mr4559413plf.0.1713996143300; 
 Wed, 24 Apr 2024 15:02:23 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a170902704800b001e868e29fabsm12395351plt.251.2024.04.24.15.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 15:02:22 -0700 (PDT)
Message-ID: <f25f7192-f69b-4caa-8d6f-49cc3cda97f7@linaro.org>
Date: Wed, 24 Apr 2024 15:02:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Housekeeping patches for 2024-04-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, qemu-block@nongnu.org
References: <20240424141408.87779-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424141408.87779-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/24/24 07:14, Philippe Mathieu-Daudé wrote:
> The following changes since commit 1a6f53953df65f31e922f8a1763dac9f10adc81b:
> 
>    Open 9.1 development tree (2024-04-23 17:33:36 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/housekeeping-20240424
> 
> for you to fetch changes up to 2d9cbbea64e67d90c3c22d7e2d5ab530d830eb33:
> 
>    block/gluster: Remove deprecated RDMA protocol handling (2024-04-24 16:03:38 +0200)
> 
> ----------------------------------------------------------------
> Removal of deprecated code
> 
> - Remove the Nios II target and hardware
> - Remove pvrdma device and rdmacm-mux helper
> - Remove GlusterFS RDMA protocol handling
> - Update Sriram Yagnaraman mail address

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


