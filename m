Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A18ED3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSxXG-0006SO-Ve; Tue, 09 Dec 2025 08:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSxXF-0006R4-6A
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:13:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSxXD-0001Lp-Oi
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:13:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso58323355e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 05:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765286022; x=1765890822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uSP2RAP26b4ooMhvc4xzs5OpZA9d6YqSiTwp0gN/WM=;
 b=LdUSpapGIctWvMqV2XECJmJzjGoQqJDLrJpcVtNHxCuOBfUiIgOM2YbBDGIKnZWXJ8
 G2WfQioIFepEcQjom733uCLKj28xunrV4lwGgZHqJZiUeMICtNo/3oxxHZUBitKT9aBP
 +2607+JduBVdLbkKv+OhfeDJcR7KKq1LPevXDQ3xOmXwiw/tDJ2Q6s7/Ao7TImYE006H
 rtmsk9c2Nu5grURvc44ZRihu1nmroU0pgR/VR70KYedmzqjwjKHhb08wNQNG1nhPALNV
 iMH0SrYn3afyPUijuvj8snucsGRhl3/ZO+FGCKJ/DPBZUoQUS6z4jDSqpuJaTdLZbAfQ
 S9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765286022; x=1765890822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1uSP2RAP26b4ooMhvc4xzs5OpZA9d6YqSiTwp0gN/WM=;
 b=ISFzS8d5xSKkWedc6I9KmeDbgwmSosOCTe28ovdemmd3LPS9QjL+DWxuGlp20Z61Kj
 TlL+XTmjZUDIgly9ev25EMdIDyjaBnZDW/RljjgLvpIiURaAPgmLUEvI6zCVb+kZCXaR
 PKlBF16NQ01V8WrHDLp3Sz2IUQVadK0xFr6/Y6Fiv5GkHTin1exKN1G+t8eBCYAHFOVI
 ZkRr+z81m5wdbRWbMXWH0QLKKTCmtLNctwwJgDcv74IPX/mtNYd+ejlu758gcNu1enMA
 JOH/c0fXfvF6qOJul1LNXOcTTDFrkxULiv0+2EYpmBs+/4JXLq8Lv6XWdKg3+37k4uNd
 6HAw==
X-Gm-Message-State: AOJu0YwQPO/kFWxvX54Ku2jyNQJ6wUaMxBAKXq1A2jHbSx0eqpWHiJnD
 RkpXR3XGO77HNOCkMaLD7Ok4AiYIIlye7Jv9Pa+YGTvNdDnErUhGxs/foLEedGrK1AQ=
X-Gm-Gg: ASbGnctPfkc/6SYcQ71m0zBdWikA4FyvKpWCo5PFw9mBCQRdqww8p5rqtH4GORKuLFT
 rCDrrYwK//ha+ueXK1uxj5UYqytypXr/6dQeonsTsk4WSafRihqjl2fTIjCu6P0YeaXjmnGjp0J
 g6Y0G7E5PLx14EOaqogd6sSssH76mSuaOcFO9ogt9VUazRqEuQIcK/q6m66295hMp0CIYm2DEGZ
 6pp1/3wMiMUPtG/4b95YiqE3sILxmh2nAutodo1zW+h3IqU8VDJotfusB8QnsqS3voKhkKpzavX
 PnQeeWBUPnpbYt3UkBmOMSsCDZw5drQW5FCt5XSukhUIzNFCu+lEEllUVdfVGKPT6+vmCKz+xak
 BRvb8clRXV9h8wC53MsDe91W4X3ic4wVFkRRtnv1tlRWN4TuhpgRbVl/zRZHqpQcyFbaByAW/hY
 7b1zFk4E43kYi2Amg00D7uDMNd0Iu+Q7kVuKFTxvfIxc/WqgJ+KIArmA==
X-Google-Smtp-Source: AGHT+IFdYSRkOARYOXcqXvqWGrl8KTtiQO/fDmGCq3L1YyxTlpXbYzvI8dme8vaCOL2XF1BVgIidyg==
X-Received: by 2002:a05:600c:a013:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-47939c8bc7dmr127610225e9.0.1765286021875; 
 Tue, 09 Dec 2025 05:13:41 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d9243b2sm18707835e9.1.2025.12.09.05.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 05:13:41 -0800 (PST)
Message-ID: <bbbc3d36-5679-4be0-b8b0-d1bb300b91db@linaro.org>
Date: Tue, 9 Dec 2025 14:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] Fix typo in documentation
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20251209125759.764296-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251209125759.764296-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/12/25 13:57, Stefan Weil via wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   include/hw/pci/pci.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


