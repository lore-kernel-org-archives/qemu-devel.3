Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKy7-0000Bz-UZ; Fri, 12 Apr 2024 13:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKy5-0000Bl-TI
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:45:41 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKy4-0006lE-Ap
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:45:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso791816f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943939; x=1713548739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LLxjJrKOU/RZB6lETW3lESfwoK7Q2gd5hathJbreZs=;
 b=nBhGrTokf4LBAGULv5x3bg3BMTGPZXEG17lYuyBwye3F1tQcwa7s5KWF4yfin+jWZ8
 2rne2Cfh2SZ8YlVpzqOrIY4WkoU3BdiP0o+d3BfnzfDjARno3AoJoUo383k6jb48aSvi
 PUkm5JV574rJGAfNgodTvmit1ZrUo1nqbDCzEZqrNGspB6iA3sfC26TQf8uO2WO9Hht3
 4Ij7J52BB+pel4ybbMxNbn/QG32ixhRhOL1gUMzQ51XLjBOBTt9KEGJ5fmKNzCiunBP7
 PlC53+5cJdtko6d1vAFDUbFaDsmNebJUS6Rfx8fWL8uV/I7ZwDWHZTb7O4AGsA6xPk2g
 Ey6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943939; x=1713548739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LLxjJrKOU/RZB6lETW3lESfwoK7Q2gd5hathJbreZs=;
 b=tjHdv15EIxLQZlf6dK4uzTQoQSLe/2agHxuJBC8r20cYNSQwrHzaQCXTO/HlxxMpoA
 R2xoSRZMtaFV2cztby3gAcJz4Q2hfUTMcirjULSiI6FMGa6MXSTeypZliixGwjgfb2oj
 JL5kQQkXdm0KyNcRPtHVkYyAK5ZR8PDnkY9em7ocWmMmbefAfqegl9F0irTw60ehnRPv
 jSYgcjFIsF19JQdOhL8pveBPqe43zWZ6IH53JuUuyU4IrPnKNoA7R3W2ZEVT25FcXqLZ
 AHz6PdiJYLe+3/YtPLilGF7a8tj6RKVUs8O7BHV3FrcDYKjxcDRQrWYdjczFuqk3SfAP
 vGyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcLu3ntA9GvoGNcF3E/ADOeb+w4cvEvLPeR4+Kk5N7X2rsyx8IXgvAuXIACVQAtu3gd2dVTBUpB0CfjYgYe3QB6l6gNy8=
X-Gm-Message-State: AOJu0Yy40YAIicfAPlLhecIH/QQ/aCL3WIF1xE5uaF2HghWlfjsqax2H
 qR7LRJ9kDBAc9uTvyNbsLIhZ8qNpWDn2QRW9D6jRiAYgnaJkQ7a7yxVmspM3KHyh1p3jh+1oOt0
 Y
X-Google-Smtp-Source: AGHT+IFX4mz4nz3wRVv8IiUYgAl6fA8z+xX6KPl8eUFE/I4NvZzDV26FDbVR9hJ1KcOU0d75Ttax8w==
X-Received: by 2002:adf:fe88:0:b0:346:7f2d:7775 with SMTP id
 l8-20020adffe88000000b003467f2d7775mr2403375wrr.48.1712943938869; 
 Fri, 12 Apr 2024 10:45:38 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d6e53000000b0034349225fbcsm4702290wrz.114.2024.04.12.10.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:45:38 -0700 (PDT)
Message-ID: <28501f34-b355-4d94-8602-c8c0cf1c80c6@linaro.org>
Date: Fri, 12 Apr 2024 19:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/27] hw/scsi/scsi-disk: Use qemu_hexdump_line to
 avoid sprintf
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
> Using qemu_hexdump_line both fixes the deprecation warning and
> simplifies the code base.
> 
> Note that this drops the "0x" prefix to every byte, which should
> be of no consequence to tracing.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/scsi/scsi-disk.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


