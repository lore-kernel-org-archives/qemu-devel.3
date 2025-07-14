Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05627C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 06:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubCcY-0002cO-CT; Mon, 14 Jul 2025 02:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubCYv-0007BK-8N
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 02:21:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubCYm-000288-IL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 02:21:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23694cec0feso34652285ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752474066; x=1753078866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qOiEXphEPiqgKsY1y6w++yRHPNKSxYKRUlALomX/iCc=;
 b=dHDNtP7ToceLcDVGI937ZCPv+ycU/fUT6W6gKXOELoaAZ0EYi0kSqDuLE2bGBRegMf
 pBzwck+/xCcvk+Ck8kQSVPgk09yirMMe/zrM4/BMqahfU8Wie1uFJIdEzVbQo/RvD1If
 BD/HcLvJl2b5G5zRJjh1yPgfL4aSeCNL/FSKnbndVWUN9tSHu9jDxL2D88M1RwfaeQX1
 39m5Q8HzsIZiOyANf4YE6+ddRgsqzalKY8lqfIjt2qRdEi+ZXKXGKZuUQ1uz0Y/cqJgq
 5Wjl8L3riQw8TOwwR0qv+OdG+q56KzGNSmjcE04qYSKabcSk3/BQ+gf0XRXp95+a3BM/
 LUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752474066; x=1753078866;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOiEXphEPiqgKsY1y6w++yRHPNKSxYKRUlALomX/iCc=;
 b=ttPo/nHKMUlcyLEo2kpPtjoNO9Kp/Q6ELUggfqoEsUAicEQY7x01p2DMbe8sbiP28Z
 EaXlDb1FP9Y2ERKqQA5QDkK1FOoFRV7nagKv8Aw55PlWIdCKxEx3DP4h9ToAiDqLYyXw
 qdX3uo4mhx55OM7P+Hf2rQ6gYFgdo7HRjQ986eS+WmbVg+0OAY5cksvrhW4ycxiD8FaV
 keippj+wwIcPsQU7wxsIb0R7LQJMHaiNOxXlzxRR6zhkXFCxiJUus+/jw0A6VXkc95we
 dqA2g7v3ib9SY72vrjnQ32dK/uY1L4GuO52qjCuFzYh+w0eqtJQely4pdCKW0JNbXca6
 zCKA==
X-Gm-Message-State: AOJu0YzRdY9YKhG2EiWfQOf55OYFi3BDV+nZWo44UjmDgfcYqh/TJlk6
 Hy5+kW2SL6lftATUzoEdWX+HoXRJFpsFe6l7/Xl2bjQArw4Fb3sFt/SAwRsMKO6HyLU=
X-Gm-Gg: ASbGncudwxXfFGsBSLZ+nC5rW9/2F5P9Y6Km2XIb1+c6L05BPDwc44V7W/8fliOE2Qt
 d4nOMMtschALBCssp4lLeiTNYSE60W/fsHgqRWSJZdVNK7atlMejjFcysXIFvM4TySMhsUhdrwo
 p9fZdnirPHCN4fiqeZYJrJP0/9drTcBniLTpciRS1ApXFzWwgBZzTc6OsBhehWWX+mwMPR2i8cV
 5kZaV2cccoAVR2Zv8Nt9sm3dBNjdnK+yXKuvjTXefh+EPBqlEBakit1IhIg35QMWRS/ZPvn2iGn
 iIeHpioHU1SW7ObLulPyZgT66EoF3Ezl9BfVV4WumK6FAOJOUIipNWz2e+xwCrvdiiPpKc8ld7M
 LJwBnex+Y8Jf/QYq0zp4skzUDBcE5M1PKxZM=
X-Google-Smtp-Source: AGHT+IGsryutDF1fCIoUOf2fRTv3c7zlcgcLGjANfI8nm1c86XFRahAJ0OkDwcAkpA6GOcRnmv0omw==
X-Received: by 2002:a17:903:1acb:b0:234:9066:c857 with SMTP id
 d9443c01a7336-23dede4f2bbmr135687515ad.21.1752474065593; 
 Sun, 13 Jul 2025 23:21:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42847casm91306925ad.14.2025.07.13.23.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Jul 2025 23:21:05 -0700 (PDT)
Message-ID: <65e20340-e164-4424-bc60-52d78b9a17b8@linaro.org>
Date: Sun, 13 Jul 2025 23:21:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] target/arm: Add FEAT_TCR2
To: Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
 <20250711140828.1714666-5-gustavo.romero@linaro.org>
 <21bfbfaa-f0df-413d-bad6-b69688ac381a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <21bfbfaa-f0df-413d-bad6-b69688ac381a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/13/25 2:59 PM, Richard Henderson wrote:
> On 7/11/25 08:08, Gustavo Romero wrote:
>> Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
>> These registers are extensions of the TCR_ELx registers and provide
>> top-level control of the EL10 and EL20 translation regimes.
>>
>> Since the bits in these registers depend on other CPU features, and only
>> FEAT_MEC is supported at the moment, the FEAT_TCR2 only implements the
>> AMEC bits for now.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> This causes a regression in tests/functional/test_aarch64_device_passthrough.py, by
> continually trapping on an access to TCR2_EL1 while the HCRX_EL2 enable bit is not set.
> 
> Unlike the similar SCTRL2 failure, it's not 100% clear to me how the guest and nested
> guest kernels are related.  But it is clear that the outer kernel does not does not
> support TCR2_EL1 (and also doesn't manipulate ID_AA64MMFR3_EL1 to hide FEAT_TCR2), but the
> nested guest kernel does support TCR2_EL1.
> 

The same kernel is used for host and guest.
Maybe it's related to kvm support?

> 
> r~


