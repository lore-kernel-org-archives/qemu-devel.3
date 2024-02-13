Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E526C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvhd-0001s6-0F; Tue, 13 Feb 2024 11:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvhZ-0001rV-BX
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvhX-0005Dp-HK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:08 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d94323d547so40016365ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707841925; x=1708446725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gExtqSE0IX7pmHVcVUiR1sDsaiOGFEQlINdHMHbjOWo=;
 b=L1nkkh4vKoQ6mUq0uXKJc7gj4tR/9qBUsEKlUR89yaA8/ZEiGo17VH/mT00jwr429U
 P8PRJCBhVYq7+mJXVtErdmku9WF1RoBr9dQycfUZ059QWp0pxSZ9UNZBSrCDtk0Pkl1M
 8RfxHlZxvAJMbTe7cZPADlShetWKd2Yat6xeKg4Nca0Sur+zxmKvQslRr+7ngb0ZhbhM
 lcadALYqFcbtuoRIXQc5ArrGH6Fisb37Gmuvx7mxF/zq1QDvc93oFfML+aT7LsqZSfl9
 jNfV3+WWFKcONqTplN2vQxLh2n8vKvu8E7y4TIyEMp8VynFyTib5vIW24RK815SIS0bb
 gheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707841925; x=1708446725;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gExtqSE0IX7pmHVcVUiR1sDsaiOGFEQlINdHMHbjOWo=;
 b=CdKiz3w9suWyeXJv593PdfNwZwMXGFcQiAihxedyWnBFmBhuXTEX8vVEx3tI4BHcWm
 AJd2JDTxmoabSMHjBIFTCV0AD8CDMP0r16JmHVonelo7DdZnxbul7HUmhmtM+jpv5TLh
 YN6LxJxhcoYzuFy2EpKuJa94k9cI0n2TkgOUI5yjnokCqLOWscFHesxb97iJbii+7/1J
 FzVkWah4zvsng+sky2z88y95WAH1ThtfcpVbuyg+6Z1SctB+OEdJwU/ICwuc5v+xHnXf
 CjKruE/Fn8/o6uucGbfgJ74/x5hbrmSUjwXWyH2xJ1jS5FVZjs5EM8OJEaXGjtbOpWj8
 PwqQ==
X-Gm-Message-State: AOJu0YxIR6vTV3eZxWBFjGFzp5HxhvdRe+mmd+KNIHKteVamEugujjq8
 DqyAuQ2RDZpws34BilVSxAccRvb5QuFiP5RWbBIScnRb+a651a+5Wg31+UcuSiA=
X-Google-Smtp-Source: AGHT+IHB63Blk+AATNFfIKmY+pWejI7S0LIQrnUY5YRVxyQpZ6kXG/NiVXxw44n4di9JEbRe6QZtrA==
X-Received: by 2002:a17:903:2282:b0:1db:4288:f673 with SMTP id
 b2-20020a170903228200b001db4288f673mr29322plh.6.1707841925292; 
 Tue, 13 Feb 2024 08:32:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUw/RP/2djEDNdQkPmKZPpKtv6SIqOC0WYvicS6CwmfLxZ3FQV0OrPH6nGyaQqMCJ5m/SGqJNFpO1Hlt308Bu530abJkPU=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jx4-20020a170903138400b001d741873e4bsm2288247plb.95.2024.02.13.08.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:32:04 -0800 (PST)
Message-ID: <be91e350-20e4-4c60-908c-c19b0b663bc6@linaro.org>
Date: Tue, 13 Feb 2024 06:32:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] hw/ide/ahci: Rename AHCI PCI function as 'pdev'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
> We want to access AHCIPCIState::ahci field. In order to keep
> the code simple (avoiding &ahci->ahci), rename the current
> 'ahci' variable as 'pdev'
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/pc_q35.c | 15 ++++++++-------
>   hw/mips/boston.c | 10 +++++-----
>   2 files changed, 13 insertions(+), 12 deletions(-)


