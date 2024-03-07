Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B1BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAyi-0001QN-CQ; Thu, 07 Mar 2024 05:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAyg-0001Ot-Ax
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:27:54 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAye-0000Og-Om
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:27:53 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a456ab934eeso111212466b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709807271; x=1710412071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cKCeQtL/dUfcVgKD4B15FVnDf7sWxcnGTwzsDERrzI8=;
 b=P0mlKfqmp5MPFym4FfzvqCFSMdmiDf8rYWS8uroUO7bDW9JFxgqQ9KtCbguTTluIQg
 sh9tMLJ8gVzU9QKyLTJhAsdEa7UkeKR4N6b5PxHf9eTVo+X4GjSCAoY9eO5/qdBM5mqm
 ptsAYgjJxZRa9eNqc2XHrRGHxcaIBJMhS2WvUhW5gDfNCCF56eQbXib6khasFQ4j6Yzq
 wHGXGWUVIsV/nmn8QBH+ZI1hHj7Tx0EEGmxJbZA2aOg2uBl+bCWylONfsxW2ZpEDE+fW
 Ht+Dit5MjgokkO/9xCSmMOE6Qm5+1DUBvyiJySHlfmpSl53Oq5lq9ZZFs3L7ZlPcBiq7
 jgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709807271; x=1710412071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cKCeQtL/dUfcVgKD4B15FVnDf7sWxcnGTwzsDERrzI8=;
 b=rnRZwa0s9WHpfgtdEAnP/dm1iK3D/uag+bErWwKyITDdLqKdUAnP7URk95E1J1B1Gw
 YxCZ6bzOd4Sl0lQxHYtYnTqN4gRuhTg9S7wjHntOh1N8uAslwMM+BNg772bJObhZP1bj
 PKVv/rKGyZyWxnv727hfUIPf7Pgdn+bd37E1/vrvRcIsLjUCp1ppq8kCPkGDD5CpOn04
 99UMthTsB2WPt2/cr6CIArHzL1pfgH5MBZWPb4Q8LYEZ1/F9JNMusPIrJcPUcUWTzcE4
 mtdnMhQrLF0t26geckBA6JqX1hrD1qkPszrPCBtqsWlwVWk+undmQZcsI8KqMAuzfkUQ
 XZUg==
X-Gm-Message-State: AOJu0YxRW84kh4t6sHT8U7ZBW5+y1dc5nP8laRlmXArMqyp6qw/Qid/j
 Fx6QbVlN9chdsNcwPFzCHaeRa6vJa54GrKx/+aZohbgoFK0355uBPn+ELV62ibgLtXcaQmo+Vxz
 r
X-Google-Smtp-Source: AGHT+IEUmJZbWsa++49qKnVLg9nbwMBHI+iuRxjMElZ4AesgSSLjghxPiLSkKWGYDaxXOtdRHV2l3Q==
X-Received: by 2002:a17:906:c454:b0:a45:432:cacc with SMTP id
 ck20-20020a170906c45400b00a450432caccmr9428721ejb.61.1709807270709; 
 Thu, 07 Mar 2024 02:27:50 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 qw28-20020a1709066a1c00b00a381ca0e589sm8063136ejc.22.2024.03.07.02.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:27:50 -0800 (PST)
Message-ID: <b631c97c-59e8-4de6-9b4e-342935309d5c@linaro.org>
Date: Thu, 7 Mar 2024 11:27:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] contrib/elf2dmp: Use lduw_le_p() to read PDB
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-13-4f324ad4d99d@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-13-4f324ad4d99d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/24 11:20, Akihiko Odaki wrote:
> The relevant value may be unaligned and is little-endian.
> 

Fixes: 231f6a7d66 ("elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   contrib/elf2dmp/pdb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

