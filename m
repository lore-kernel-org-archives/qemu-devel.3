Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91328C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUF3-0003Qi-H7; Tue, 04 Jun 2024 09:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUF1-0003Py-AL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:30:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUEz-000570-Nk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:30:19 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a68e7538cfaso318834866b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717507816; x=1718112616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VIjuQOs+XmCpoeqUNB1Wqml0seCMO2nrf7xftvecOkA=;
 b=bqOH9ia25L8a0bWT5GXeplkk1f51NFBG2PSf4qf9Psi8vtdboCRVsbiotgmcO936Y/
 gOGd2MY9ExUWUzoQz/8YUyr/zTd9KHpAhv2vh9Y5LY6pCUe2Fwp65f1ATSR4Wex9jFnk
 qijrgifs6T/GDVd8nUuf4J9lvDRjvMHFfvFZXyuNvnmIBIAfWnuma5qIsPYPUWdfytRO
 /BGw6Zaeq8famcuCOEFhJuJCcWIHtqruRCZVJRlKS6wcEB6jW80v0jrk9PXaYobmZkuX
 h3P7ibGHQAa0JBEm/x3LPc6AfXCQNcKMzq+4yLUQjlhrHNuX0S9jmzKRnD0Q9qZWaZr2
 engw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507816; x=1718112616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VIjuQOs+XmCpoeqUNB1Wqml0seCMO2nrf7xftvecOkA=;
 b=wk1k1k07dv3dY3yA7sdIFU/gtxdGnHlJ5Z0M7fhphKwr5hubXW/CnZaIerxcr0LG2K
 khHeL09HqG2Ox0g+c7yx0a+3SU4hr5c3lNyJ82B5Eiy4L74V+yiyyGjfncRCq62HJReP
 gx3jfb2gc7hWqDB1XCbCDYIhtrENtStBbws1kUdhenCV0YhEdil20s6arbVQ42kmZxws
 0l6Nkn0cjVa+3iqyvxCECa3NsCWYhmwdVSyBXYnKjgT696gaLPsLtNkcReIvzbsDdUP3
 dDDrJyMcfx123z/73sGGoLvsyoSD3UB/0FBEH5h+GFIVwLnp4Ybsko12mYUjKAwl4HH5
 abKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXuRCBxasuj7dlzQ91jP7p+b2k8lgwW+fxWZqbBMCqcQ4WLRQ40qgcbq8gLwK9rtV1/hXv+kGzdlQmUGQ2LMaw/KocD8Q=
X-Gm-Message-State: AOJu0YwThBVqaKcd8yyHPKirI153L5128IBD2wW6wzkhVKxvaP4BjczZ
 aHTd4gw9N66yKfTU/eHFrHlwltsNVd0o2Cyt1541Wi6ZJ6J1MmJE95ZuhXLZHGc=
X-Google-Smtp-Source: AGHT+IENADVzyzuv83NpvSh8bzn6FwFhbcVLOS4/mlF0MlkItzo2BLcH2kzRRRKlWL/1vM/B3js1Zw==
X-Received: by 2002:a17:907:94cd:b0:a69:dcc:bb1d with SMTP id
 a640c23a62f3a-a690dccc10dmr404700466b.13.1717507815643; 
 Tue, 04 Jun 2024 06:30:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6866a69125sm584737066b.118.2024.06.04.06.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:30:15 -0700 (PDT)
Message-ID: <2cabd838-c35c-4573-a5f0-09e4032ac9c4@linaro.org>
Date: Tue, 4 Jun 2024 15:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/37] target/sparc: Implement CMASK instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  3 +++
>   target/sparc/insns.decode |  4 ++++
>   target/sparc/translate.c  | 13 +++++++++++++
>   target/sparc/vis_helper.c | 38 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 58 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


