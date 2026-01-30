Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030F1E6BF31
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 17:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlsQU-0001eE-LT; Fri, 30 Jan 2026 12:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlsQT-0001e5-O1
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:36:57 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlsQS-0000SB-36
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:36:57 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso21324435ad.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 09:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769794614; x=1770399414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=deAY+imuz/KLXjNs7gkzSIa4a5AQdjL5/KX/fQLtLJA=;
 b=Gjch9BHM3ffgWcG5TbwqSZENrQ4y7Odrxdso9LKDZncA5zFOAB9bR3nczsmh8Ad7bR
 7F1Io5yzx3x0naQgvYqV6BnSaHIWkub5+1YX39O8ORFU7HMzKOG/PSDs4JZeSo4wxr48
 dUSjXT2zTk4CP9GTGnOBbL6Rt2y+O1XqMDILJIjrX0RpP6p2GJannnSIlF26/CHGmpiC
 E4a28dT9htR77CNBBFc2MzcoHXDCl6EbciaSmjfQ5Qf2Q1IIaY4fDxGKnmjol0qmNhDu
 Q+XSxQR1YAV98urBYBr2x7xaHaQo0ver3JdckrQwjWRws4yTv8ymihf1Gv44Sv70GPHm
 KtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794614; x=1770399414;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=deAY+imuz/KLXjNs7gkzSIa4a5AQdjL5/KX/fQLtLJA=;
 b=LoUyFCBsk9ncnsGhgWWJ5Iq1nOXcwy9sa8LUYt0BNrKhLPlgmkVRETgbEaOVGQPPDr
 4tDm1M9c820vWnAovHGCu2ri5ZkjRfDZgIUukqvH5sBLmKJv15GFSKKQlbH7Xdwmmv/v
 mLGhcP6hvmeOWRTKsUaiM7yikO/pdZ1ofIsII3R5UN888HMdZOBT7gP2GRTzht/X/De5
 i/5EB0gdCnw2di01Aj/DveRLc13mvLOchs91f57n7KaITsLNLkJgP2461WM4TeFZQMq2
 6PC0JAIeR6ZEybURPw3xlH24EofoFam66kDlWq2KiAi8s3X5hZ9+NJqnA9HntvZgYCX7
 Jy6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoZuD3kXyRvuBgmGVqPTRWZvo8fMxHKFcKzZWnXxfD8hywYxE9jKaHQ4jXolzRCJVznvMJk0VRdR9G@nongnu.org
X-Gm-Message-State: AOJu0YxVYKtEeTjJ+BLNESlyNqMtdutJUk1YSuCDFNRnhWoG0pt6YkEV
 U35W8hwMhUlClVQkcPNpm8C7UZi7Q7QoXROhbyq+zlCbbT+eSlQ80D+gFwX0KvmCmyM=
X-Gm-Gg: AZuq6aI2Ol4GFfR4AfUXpFt3yP9MZYKqkmjBjCTez9buz+Fxj+VhSnGeIsSpeewiiob
 HiJQfKtzO3SAVvPEjupacZ/do5vyQ1QZ1VNFafvHEgSq3zmqU4nKB1GLmuCdtYNYaCsyhfyFH16
 NrdbVg8iXA4mUhwWhSYl/ZlRdZPP4RlC59wRyZ5Ysz8XGehFNXatfAvndVIUf4S5NtCgat5asrm
 Zd+o4Y6W021boSBWlscwHS83BtBwm4o1thuOSbqllFh7px8pZYbTv/NbAIua/Dg0DrgZc/d2FxH
 xb25DXd9zPMiV/edVJ+50xruPgSITo4UqUFSu3Bcs6CA+Ll+0Jhb0LqNbWSlDBYIra27NZXw3DR
 mEGB73zyE+/E3l99ObTH7FJKHzHm/XhF7uhoPuAfg4HGm/MNBAN/wRl72aTSNWA9WJPHoJgvt6A
 CXHkujItdHvPWhpqDMEDzv91+0sDXWGuCdtcVftpVTTHuJipzDgWLIZFmU
X-Received: by 2002:a17:903:1547:b0:2a7:af02:2fb9 with SMTP id
 d9443c01a7336-2a8d9919538mr40130785ad.36.1769794614176; 
 Fri, 30 Jan 2026 09:36:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b413c1asm72863355ad.28.2026.01.30.09.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 09:36:53 -0800 (PST)
Message-ID: <4246c42d-fe85-4deb-850e-c3c3a011c6fe@linaro.org>
Date: Fri, 30 Jan 2026 09:36:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bulk: Stop forward-declaring enum typedefs
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Will Hollins <whollins@google.com>, jpcottin@google.com, jansene@google.com
References: <20260130170417.43356-1-philmd@linaro.org>
 <20260130170417.43356-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260130170417.43356-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/30/26 9:04 AM, Philippe Mathieu-Daudé wrote:
> The C99 standard chapter §6.7.2.2 point 4 mentions:
> 
>    Each enumerated type shall be compatible with char, a signed
>    integer type, or an unsigned integer type. The choice of type
>    is implementation-defined, but shall be capable of representing
>    the values of all the members of the enumeration.
> 
> Align with that recommendation by defining the typedef
> along with the enum.
> 
> For information, building with -Werror=pedantic was reporting:
> 
>    In file included from ../../ui/kbd-state.c:10:
>    include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 'enum' types [-Werror,-Wpedantic]
>       12 | typedef enum QKbdModifier QKbdModifier;
>          |              ^
>    ...
> 
> Reported-by: Roman Kiryanov <rkir@google.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/riscv-iommu-bits.h          |  4 ++--
>   hw/riscv/riscv-iommu.h               |  2 --
>   include/hw/misc/auxbus.h             | 11 ++++-------
>   include/hw/pci/pci_device.h          |  5 ++---
>   include/hw/ssi/ssi.h                 |  6 ++----
>   include/hw/xen/interface/io/xenbus.h |  5 ++---
>   include/io/channel.h                 | 11 ++++-------
>   include/system/replay.h              | 10 ++++------
>   include/ui/clipboard.h               | 15 ++++++---------
>   include/ui/kbd-state.h               |  6 ++----
>   pc-bios/s390-ccw/virtio.h            |  5 ++---
>   tests/qtest/libqos/qgraph_internal.h | 10 ++++------
>   hw/core/loader.c                     |  5 ++---
>   hw/display/xlnx_dp.c                 | 11 ++++-------
>   hw/dma/xlnx_dpdma.c                  | 10 ++++------
>   qapi/opts-visitor.c                  |  7 ++-----
>   qapi/string-output-visitor.c         |  6 ++----
>   tests/unit/check-qom-proplist.c      |  6 ++----
>   18 files changed, 50 insertions(+), 85 deletions(-)
> 

This looks good!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

