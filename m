Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85E6C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQWB-0003WQ-Lw; Fri, 21 Feb 2025 05:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlQW4-0003R3-Cl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:44:21 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlQW2-0001uC-UW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:44:20 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso1093602f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740134657; x=1740739457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hwfsBzZh98QBTrbGtKBh6llchcX7pniNmKm5d/EfCI=;
 b=OKa+CY8fUH2oQzO6rj8NBvZLTx0zysrx3D4d4pLolYW9bUxM4zZaS/8rq+8ZXESKZC
 K0qS2Cqpgz+CPX+6CAcl+dxTVPNRxq3sQIWTyrJgZEFPBIKudYhIHuyc83Anq/JKq8lE
 2skxqMXZfe0OJ+tq8zNGwXu2IExN1/8miF9FvyC4YwzdNPJbQ+Alb5Fnmh0Y36Hvm5/d
 zCmVD0fa11+FjpZ5Z+u/PRpiNYHvB4Nfio0AwmErRvJbhh3xFo67/CMqGckcvWHGEAt2
 4NNwV/o5JiI2gNrdfAC3XU500+OzqpbXOoMwnQlXVNWfmYxUH8k+k9vNUlFn6faffS7x
 hBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740134657; x=1740739457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hwfsBzZh98QBTrbGtKBh6llchcX7pniNmKm5d/EfCI=;
 b=Udd6CfCKf26bt/slH7sDTFLgfpFfcAOcz5j4yTLgHJ5ZsyVfQr57fbcFTnYNs98wpm
 QNkn63OuAgL2IvP/5cV+xwUiYfZyfhAiBgOoxLqXgOGcZCkNFuKtCsJP6mj8+jdRAWYJ
 xXAkwSJDQpSp+ZH1VPLVOANw1V5ytp3+PT3c6xxLyFiZ996hAoE5uNQOnx/qZtTIEMYL
 eok3oDet4nGS1whW67EIMqOXCs6KtyUit3HHOfCgPcdCpU84CZ8f5jFmPDBaKQv5UqUf
 6H+2SKLi4ipEqnKCIjTrCeIbh+Bxl4yfaGYx/SI7iAq+RgrJ9ekmrR7cWjOq0Yp84Iql
 PlNQ==
X-Gm-Message-State: AOJu0Yw9fiftn8XR5NhMFaTw9qB4ux9Ja3dSaKpjcmHTqvOGHZoX4Kst
 R42mLHLupPAKGg+BpPn89KRyAEveoV/nAhRSNZn1R7nY3lz5TMmiO0U1zYFqotY=
X-Gm-Gg: ASbGncvo9A3rk79+KfAiUJYsPmBhCPhHhnY+mymE9TVJCzccRAtdsUiGt93DdPdS4bR
 sSJfu/pgZjVy7KE3bq2J6atS2hunuiPMtR5U2dN2EY2cHwytKi2pLX4UL0++k0ZlEk3QIqquQbs
 datL7mmufGeDqir6DdFpFVCW2qs0MSWGKDb29D2iS/dGEwQQOa/b9DGgkbys5zfxrFSjMkTHD9+
 FNAXOLoja+pvS5GDQVHuJcdbSuatJBtsbwAeIDgyDiEpcKVRErCZZLvaNQY/b7BRqefb0ZXAhXM
 fZPSUlPcZNs2+GmkC61bgdCp8WnP3okOf3Tc3MQQ/NyV1ePVy0+oaEZVTVnRUkQAOfygvQ==
X-Google-Smtp-Source: AGHT+IHw26zQV1ocpccpexbz/PlkpXzJHYNG/DxrREnl/pDC6lqCEt3k5kbXM46LNtNQbQGOyRAwpA==
X-Received: by 2002:a05:6000:154a:b0:38f:27d3:1b3b with SMTP id
 ffacd0b85a97d-38f6e756316mr2174134f8f.11.1740134657178; 
 Fri, 21 Feb 2025 02:44:17 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d58f3sm22964171f8f.73.2025.02.21.02.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:44:16 -0800 (PST)
Message-ID: <fc644b42-c6ad-47a5-9940-bb6842a06771@linaro.org>
Date: Fri, 21 Feb 2025 11:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] acpi/ghes: Make ghes_record_cper_errors() static
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214041635.608012-2-gshan@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250214041635.608012-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 14/2/25 05:16, Gavin Shan wrote:
> acpi_ghes_memory_errors() is the only caller, no need to expose
> the function. Besides, the last 'return' in this function isn't
> necessary and remove it.
> 
> No functional changes intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/acpi/ghes.c         | 6 ++----
>   include/hw/acpi/ghes.h | 2 --
>   2 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


