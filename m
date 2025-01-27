Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAEAC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 04:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcHDk-0000S9-BE; Sun, 26 Jan 2025 23:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcHDj-0000Rz-5r
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 23:59:35 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcHDh-0000AF-MQ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 23:59:34 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21bc1512a63so78169125ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 20:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737953972; x=1738558772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IX0Hf0/XtkyENMLwLCfuEv5yvEo+z6indaZP/7R0+m8=;
 b=Zj6IFMkZm3qDhS4tq6K5kEMijcddG3aX0I177XeOCAmaBEBJxGcyaejy7DZEnZxs18
 41kHu3i9HoRLvqGug+S4gLcU1RYCTFF7mLdS+ExtFgH2umRMWKWGoPaJS9GcqIauglS6
 0H/bfh1IxEYKzgg8u2C4zFCZkN6Fd4j4GBoDE9fwQALNrWGpOVNA4SZ5X6PcIb8Le2Vq
 Ws5hLRNhjNANz57DoSczLpHLTuDNo0lsEENYaS2DHtzBcS0i67sMthyza/D5kkCufn8Y
 jRdCzrVjyUnxpz6XQvwxfo9bPoLVLaUbCd2MriMBulGQCPZv7jBn1PitBaq0amMR/YUo
 /FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737953972; x=1738558772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IX0Hf0/XtkyENMLwLCfuEv5yvEo+z6indaZP/7R0+m8=;
 b=NkSNFQScNOBsGNopeDdE7sS/BHGdTS5sW1ZRqrVg5A31e0u+y9TuVlJy0gUpqms9t+
 TeuKoo01Tbr2u75COz5UdkepBC/h/9X45R4bLCvYoKDE1Afk1L7TqJncut12NIC5Wb/5
 a6R7gJg/I0hk/WjJgSrLIW0CVDDUmiFpNtT2wsAO29o1Arii5Mkz3Rq+WIEga71R1tRa
 gV7a8BNPXEjg1AgYrIfrn68oeTuL1yDe6xburWiMWm6s8o1BgyRR2WrTP0TVkZt+mTJN
 Xd1pLTgk7EpPOLcvsc6jNHMTOgqVLh6RCo5kuhn/DjGkXEEkFVo0IwXOWRUx5YqhqBxe
 aRzQ==
X-Gm-Message-State: AOJu0YymeSUWVeVNNv+JNvEqOFb7JvZ7z6DIHbXgIggBqsGGJFaUBH/G
 cbAvq3cXo2SUmD2CPRRg5w5eVQrX8vj9+6lzZ27w25238FSyk8lctdUl+BTQfFwoBBnOXizmg4+
 l
X-Gm-Gg: ASbGnctSYNhWVl1+K9gjrsdSDHEaQcm3DJAR6NvcZcSmUtpKbGpphonq+8hyqECtvBF
 6TUrLF1BlH6Tv0ZcANsvcUDYJfVQd7KMMGKLCHHLNxPAIYBHwBtGenFs0REsPzRwSToYHHjOhP0
 j5+xxPb4jxg0CRJtNEo9S/0i1Jmt90LU/7HlQDM5TsgZ/CGmPGJ08KsPEBcnms1YGAWsDXp6MJ5
 eFUO23dohkmxjeDNeujGLy6K4zFI/puCEIi/UM8ad7XVvCgN6A/6QttwusYcAwZxsBS8bDUcT4Z
 9udSAo4FVfWVguEWzoLVaY7ClDWe4mgSnEJIPM2/oVjsMDU=
X-Google-Smtp-Source: AGHT+IE0P5GvhxKelPHcfglRcTlkgqSmhqwD0ueizIQc6gl5S0GqPvnrl03CEirb4KNeWHxOEc9MIw==
X-Received: by 2002:a05:6a20:12d6:b0:1e1:ab03:8653 with SMTP id
 adf61e73a8af0-1eb2146024amr56350534637.9.1737953971964; 
 Sun, 26 Jan 2025 20:59:31 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c82fsm6102346b3a.126.2025.01.26.20.59.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 20:59:31 -0800 (PST)
Message-ID: <1d329b28-2c60-4156-a856-b2f14d4e0b77@linaro.org>
Date: Sun, 26 Jan 2025 20:59:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/76] target/arm: Define new fp_status_a32 and
 fp_status_a64
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 2d37d7c9f21..a7509b314b0 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -671,6 +671,8 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
>    */
>   typedef enum ARMFPStatusFlavour {
>       FPST_FPCR,
> +    FPST_FPCR_A32,
> +    FPST_FPCR_A64,

May I suggest calling these FPST_A32 and FPST_A64?
Just a bit less typing in the common case, and it's
not so different from FPST_STD and FPST_AH.


r~

