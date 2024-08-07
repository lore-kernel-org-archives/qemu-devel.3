Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B98C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUya-00015b-Nh; Tue, 06 Aug 2024 20:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbUyW-0000yW-N4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:56:24 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbUyV-0007nF-5j
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:56:24 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-816ca307407so48597339f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722992181; x=1723596981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2C2X2HiL9VDUxZH0TC1Qj10+K5gWbIw2K3vuNa4Td0E=;
 b=BwXHnVeUf+A9n/er9FXY4PTHHThr3I+qG3/m/rh3MSVjjVqaYNkr5WF6iYbVmAndWN
 J6OxAQfrilEYmpoJyo4PrT6VDmWokzusjXYSWx6xQVkWtWmAdqxTYBXGHbnu6wGS9ACk
 yOlzoluhynCY3RsxKiCPbG3HRThBNAmy91UlaXHZEQHVCyfM644bHJgIictM859yWVQC
 8cjgfDZbsDSJoK+d/2NJyECDLDkegPPhJmaNPwh1MrAfrRfpgxCfw1QEo3Q/tRbeNxSf
 gY4vKEcTOgxiIrp/VU9lKtbXsvj9T+J0SPUSp8Stci3eDQ+cpLErzshHv5UQKGTmJRI1
 7hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722992181; x=1723596981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2C2X2HiL9VDUxZH0TC1Qj10+K5gWbIw2K3vuNa4Td0E=;
 b=DvJlSuotN3Qh/IA9rKkKhJ6I8LyXfLI3VTzLDbMCo6LJpei/AL1Vf1HxTqd15xu07I
 uAnemhXQf5HFPkUqLjrlbVAL59jgeG7cHOJLKBARdQpHL0iU7DVUBSFGBUXNLhBZpYIF
 vy1JR9UeszsbJtoyB2UqaBzbow72VUAWZJSVsV84y+bu3Zie4lMyGOJ0kCvyJf2VZ0yV
 jy/Gva9ww/eYnrB2oNRv799S4zkP1HDDO6aRfYPOej5fBLgStpf7jgCfKBvtCy4cn521
 FXa3SeA9q1116ZrtLSDfbv/JxnzX+bnESolbNp8Qke0+59+mXC81oCcje+yL+8m4A15W
 MJMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCfx5zn+JPAmc2hTmG3eNmMgOAVi0eLu0fhUU9f9qKxnCsdEMYihFPolq2NAAajPXNk8ywVhJiQjzU6fOFs7PkVhTUexw=
X-Gm-Message-State: AOJu0Yxb3kt7UEyIvN3arW/YZm8yW4XVhax+66z+Rtm0gpekWiuz4nqS
 FqfjKDTF5v+XJTylEje0El2aWRBM4yRsy41Ete6/ykiFaX7GgCOL1wo242/hTdw=
X-Google-Smtp-Source: AGHT+IE0DuVB2sGXp+ToFcPOf2qfi3ov58wh9HJRU2LfWWTNC3E+ddo36sK7YwSj3slZMjKwYgb5iA==
X-Received: by 2002:a92:ce0f:0:b0:398:770d:1fa4 with SMTP id
 e9e14a558f8ab-39b1fc2bef1mr197695445ab.25.1722992181471; 
 Tue, 06 Aug 2024 17:56:21 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7653b4d99sm6301944a12.84.2024.08.06.17.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 17:56:21 -0700 (PDT)
Message-ID: <bd2f7f31-966e-4bec-a4be-8c030d1ac4a7@linaro.org>
Date: Wed, 7 Aug 2024 10:56:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] target/riscv: Introduce elp state and enabling
 controls for zicfilp
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-4-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-4-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> +/* enum for branch tracking state in cpu/hart */
> +typedef enum {
> +    NO_LP_EXPECTED = 0,
> +    LP_EXPECTED = 1,
> +} cfi_elp;

I know this is language is in the spec, but would it make more sense to use

   bool elp_expected;

?

If not, Coding Style requires CamelCase for typedefs.


r~

