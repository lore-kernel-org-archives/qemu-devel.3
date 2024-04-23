Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0769EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGKY-0000Dg-8I; Tue, 23 Apr 2024 09:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGKW-0000D7-UX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:37:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGKV-0005q0-F3
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:37:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-417f5268b12so59298905e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879422; x=1714484222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fM3ccpkYJRuskNx0e/VTTw+Z7UBIVonl78ki0TPTKTo=;
 b=rAoljtmKw6jzbCxmmxFQtfQnowTErwWCwSBHDN6vcolTdRXP4QmIqG82Wy69fa3XAt
 rMbFAmGkNsQO5hkK2Ll0hMRfpGrpyybvnT42DahAp1qpUjZrtaXqf4UkS/1INejxt3k+
 bEv8QVArO54D6t+OVS3g7KgB7nhOfZmzB6aDy3bGE5ML2r53tm7xAR0f5iA0KPEWPe3y
 4B4UWPz26jDaXkfr16BST87p0TDFJjAdmYvUGjvLRJZtYhsuh6hMN18/4TkKUkAxhXso
 AixIJpYT5sVkIVf2V1H2Y00/+Ek5oUKRHvZEPjRaAbFInW7LKUUznd+2krCm27Veebu7
 9Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879422; x=1714484222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fM3ccpkYJRuskNx0e/VTTw+Z7UBIVonl78ki0TPTKTo=;
 b=Nvkw3CUTxzxIegWI0Ei2uKYRKVIe6X3g/nvlL7KYjv9xtYW5sTQROHMXuaTRlXOVRo
 csjX6qtSIx3MsnsMvUwFh01U9EaclvMZzdH3Ux9V/78I1vWAF5SvoazFi7kHT34xn8xz
 P6lU/ko0ome01+9Rwbr8uEVY5BsQ2jXSTAO9OalEG8Mp6UAa10tnWL+xQXpv42HbFkSg
 dm1ZPgbSrdwhT5kgHRE4XLLeNBsp5pV3g3eGWj069RLs5PCKPu1f+75t6Cb34fCivVHv
 Pks9aDkCP75RPPMCxmECNCJPV1mXJU4h7xa7cQ6UWrOVMIXMNnPIaw5AY7IeM2Gfw3IL
 abuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+C39bQoHn+pr2PL0nMfqrXnzPViBW+UrRKqBoWvnV6soHeR3icGBExGT59aqnxiRkt7dZ+kQa3nLgqzGYfUAASZiZQQ=
X-Gm-Message-State: AOJu0YxvZl6nA3iRfMw1t/0tFOHBcML/ECzzhfzO3eASkQN8sTb8gmCF
 KdHhsL5FNiCE4Z82PEG+8C0kD2dHefda8a16u7PGM2IXFfu5gc5/mIsu5ZGekmbBwWBiPp+I0bX
 ClZs=
X-Google-Smtp-Source: AGHT+IE6GjkP5BKdIlC8BeHKGnaSEddWo8EJg9SiDpSaGiccm80vQbugqDewWqSbxmewh3hLH5oLZw==
X-Received: by 2002:adf:f343:0:b0:343:5cca:f7c7 with SMTP id
 e3-20020adff343000000b003435ccaf7c7mr10845851wrp.41.1713879421793; 
 Tue, 23 Apr 2024 06:37:01 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c0a0900b00418916f5848sm19856832wmp.43.2024.04.23.06.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:37:01 -0700 (PDT)
Message-ID: <6a19f4eb-866e-4f08-bde8-9ba89b5d0b12@linaro.org>
Date: Tue, 23 Apr 2024 15:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] microblaze: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-11-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/4/24 15:16, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with Microblaze.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/microblaze-softmmu/default.mak | 9 ++++-----
>   hw/microblaze/Kconfig                          | 6 ++++++
>   2 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


