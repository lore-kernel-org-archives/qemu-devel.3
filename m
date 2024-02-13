Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA491C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvtJ-00014P-M5; Tue, 13 Feb 2024 11:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvtE-00010s-Iq
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:44:13 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvtD-0007UB-4X
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:44:12 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2971562c3ceso2326949a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707842650; x=1708447450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7nBWRsuCQlsNbtBOpqtHnya017dBRZ4EUJKfbZzGgaM=;
 b=p3ouFN7hvLvp3jR4iVukAra7SNnrmKjh81AT0W0OM0DGL917Uii2orWzVsD72/mAeB
 0rXJ1xK7ZHN5mtXW5LnD+bGDk7ayVS+62c3OwVyTFDXW54jNseG/YCRofkvup861s1M+
 TiKgp2y1Z37a5vknmopmGCoe2HfsjP4qLhvq6TiHShCbDAkeiTi+KkMHnyyxOJH26ROn
 WjQ1B+DMvyHsc2qb7TDsOSc+IM6o9y6+MoNMd22yQvz9pts0QINk/+V/lnRGpzCDViFi
 xnEba7MJEO8g9/vAsRU1W8FfjAZkVoR0gNg32cNSrwCDQbHr+T66CWrNTnAvcheQZOLC
 j0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707842650; x=1708447450;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7nBWRsuCQlsNbtBOpqtHnya017dBRZ4EUJKfbZzGgaM=;
 b=e7cQhbSx76GcoVAORFPyhvqgZlTYQD3CU38sxqen7KccVpcn4qeQ8SUpOjzODbA/Sx
 wZxZ6klCUiyXOD4ojh63c56WBumaIy3aQG1x6MpxO1upVPckja1GbRE1i+ce+ngMlv4k
 0RAskuiF8pgMnYKX+cxQL0XAziOcB73AUGfnlXrNd2NIQCnCjH36zkhQXuaJVQ8m5tjz
 CRyV29NqJwCUMOdq7NNfeVp+aCA8Jd3GTYcMU+VO7msLgaS7uEQLl2ImXZdFhprigUFO
 mpYGVt5Ltg4p1eu0NpYwYTX0JYl+6XoYtzx7W/374rTL0BZjfMLu5QZzWyRioDXjOYBW
 hlAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPvpkPNcVbDul20TXoqJ2IFQRSKEq8RLmp+mx7TVCSui9smKyc7yeGD74dTN4nuW0tqrh1tHPBIxIbFEKgDNyGPsqkBoA=
X-Gm-Message-State: AOJu0Yzb3gr/TeZEEaRR49vjPDG53jUn6hldNJ4bXdYsEff+Lha8mqZg
 injg+UrnGVfJ9fqGq+nxnB6PNPOwI9eQGZptyb3lQ8i9pNJAyljFugaN/mNOifY=
X-Google-Smtp-Source: AGHT+IHkyKsR22Wvb2hIhBZ8T+y+ssbNH/EpECJ4Pv3hirvDaCLyZIuIxSX69uiHYsWoxcVXZi5yWQ==
X-Received: by 2002:a17:90a:6c41:b0:297:2258:b54e with SMTP id
 x59-20020a17090a6c4100b002972258b54emr24077pjj.11.1707842649803; 
 Tue, 13 Feb 2024 08:44:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6BXhnP4sXxHNHHVPsSIHyS36H3YWUGgYucO8hugZxrcR1+NOHKmlYhDp8f/3s6gGh26AA9VtnUKYvcYAuAoir/cCXlI=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ep23-20020a17090ae65700b00298a1d613c4sm1832683pjb.27.2024.02.13.08.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:44:09 -0800 (PST)
Message-ID: <f3d2bf54-e5f6-4641-b98f-f6bceedc7a8a@linaro.org>
Date: Tue, 13 Feb 2024 06:44:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] hw/ide/ahci: Pass AHCI context to
 ahci_ide_create_devs()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
> Since ahci_ide_create_devs() is not PCI specific, pass
> it an AHCIState argument instead of PCIDevice.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/ide/ahci.h | 2 +-
>   hw/i386/pc_q35.c      | 2 +-
>   hw/ide/ahci.c         | 5 +----
>   hw/mips/boston.c      | 2 +-
>   4 files changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

