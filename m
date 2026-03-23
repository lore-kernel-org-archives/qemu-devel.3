Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5022ED58B00
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4eSR-0008BT-Vb; Mon, 23 Mar 2026 08:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4eSQ-0008B3-4v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:32:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4eSN-0001m8-Np
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:32:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso1950248f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774269150; x=1774873950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nO+jjWxT+fBbHad0xaSFQs/OYQG5HaNYoduaoDtscB8=;
 b=AHrUv0nddZYg7D4Ch+QhvWuZoAkM3JWYEdyrkC/JyexSKjyLyT5MZE+5Zpm7CO8pLx
 u/H6QLx60B2UPOhyuaJCa9Fugonh6xSG/lEa0sTjdZ7bCitl9WsLIYFulcxU40hBW6Dj
 QmxWwsvPm0plRQe0fUzpUjoIUXV0VhVQxqGc2aLujEDv9cReyd3Fwo54AhqlEZ1TxlGb
 vzgY3yxR419TMpqBl+G0mw2aAfUVD3G1vFCHXPt+q9lThilJi313nd7fP5Q3UnHnYW9Q
 2/7Y1at1jI50k8gAQM3Jb0WL+BRqxMaJ9ie73T8kioxrTKs5/saOQYbQEEoKJ7hfrR0Q
 0C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774269150; x=1774873950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nO+jjWxT+fBbHad0xaSFQs/OYQG5HaNYoduaoDtscB8=;
 b=JzLz784zqweaIOpn+segEUMfH81hckwo6xUhik8011h342Ag/kjt54DmPH4CkT8oMw
 9OGWYG8R7wK3LzmpD2k0IBDP22cGv6u7DYLxhdrAvgdJibkQcciH+pi+FaOISCg8eux2
 jal7QztUEwm9yW4h9Up3p2LoNF3A2qiWCTKEiFaDrjly00Z+904MZLLVcFeZEC7Avd/A
 qHYrJciLEfh5g8pG0I8uiAS4SDexKA2WY+7akMFclH2ZzikcJVeSrIQ+/JnKPdjZF3xa
 GeYP4757bbeWHonZ8nAYtZaX2qQeU3Hohp1uIpndoMI1ptitb47PkAZS5FR0mQgLo8Xk
 W9tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSgqaF9Me3uZLRcuahQifBxb+ebwnAvVJDugqQPJtbC1+YO0YhkVbChiahkzAdQYGvrEwGzWboLveR@nongnu.org
X-Gm-Message-State: AOJu0YxPxj9r3F/bcFz/25J4/RiF/03PBaNOFfrQo2A9vs2nq2suu+9a
 SHTPKHlWxpOwSss1aWfGo3VpM7GdD5hiTysm1uyDNGxl6AVf7rIoSkBcgFYgPKrTxvdrLQ9ypie
 xiqQVNxM=
X-Gm-Gg: ATEYQzx0dIJcsGD4aovcVwmYlfall1sepONaBDPpK6zc1iIoK4JUK/aUutd79kwuPFJ
 FQ2b5MYa8lhiVkoz2Ed5d5DfRSOGtcymNy/eVd/vJxs7tx1hTqh59O2zxZWse7Nu5AKCd2FTIhe
 rStGi4+NReCoG6k1XX6FdZUfimgz1xDxldeA1MbzZlK2Yko1H8rzIQFQul9TzoA0fKFRtGMOaGf
 Y9xcXMYNwOz18AzaUuQ272XoMTuYSD0Cxy+GAaqYY4ZlQYLQCYWdouRQojSeCdf/sb7qotelDCj
 mvp0kyhL7R3r7mlvqRMQLijXAUeg31YIn0lxDtQH963ugCABlnDO9EnmTcOLGCoccamtcZW7DuE
 bBMQZCz8Wp/uFpAVxNbYIL5yDVZ/HI3XvBscxsw7dLnmZjNqtEirZ9e0MtvGyze/BeXDXB2Rd/e
 L7fUVLg1r1FBP68iWTt1nTmQhFDxh+sjsbbX5NPel+ClMvjLd9ZPVFzFxOqLf33rE6Uw==
X-Received: by 2002:a05:6000:2301:b0:43a:16d8:96e8 with SMTP id
 ffacd0b85a97d-43b63fef61amr18091446f8f.0.1774269149694; 
 Mon, 23 Mar 2026 05:32:29 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm29945670f8f.26.2026.03.23.05.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 05:32:29 -0700 (PDT)
Message-ID: <9d492305-aad0-4aa5-9aab-d6ad0d222964@linaro.org>
Date: Mon, 23 Mar 2026 13:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/hyperv: add QEMU_PACKED to uapi structs
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>, Wei Liu <wei.liu@kernel.org>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>
References: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 23/3/26 13:06, Magnus Kulke wrote:
> The uapi definitions are marked with __packed hints in the kernel
> headers, since we want to keep the contract of the Microsoft Hypervisor
> ABI explicit, we should also added them in our vendored files, with a
> few notable exceptions where the attribute is a noop.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   include/hw/hyperv/hvgdk_mini.h | 37 ++++++++++++++++++++++------------
>   include/hw/hyperv/hvhdk.h      | 14 +++++++------
>   2 files changed, 32 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

