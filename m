Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E35ED7B8B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZqf-0000sm-0I; Tue, 14 Apr 2026 05:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZqc-0000s0-6j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:14:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZqa-0007UV-Iy
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:14:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so2993121f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776158054; x=1776762854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATbplWTHRL1bKh2jRDKkzuFfRjRr92P7D+wX0GVGWBI=;
 b=fMO6LyxYRmNK9IZRBWqJcwczqJ75+MusXaHL5B0v1lqSFF4vd1J9P7RtP376therMg
 Rl9i3DfM2qXiEc70jfHpYFczOfBcoL1ZR6xpnE+kgIhiYEbuQtlvH6Bk/OZ8zoqRiQwf
 fCJaktI+UasrQcXI6mWCJqDoWq8E25FnmZkSHCipesi7sJu1E2kWG8YtujX5zZzLytB0
 THeFOt9midqPkVtpcAVUMqss8Yv7cVaq2FHSFj0qyLifYzw0mqaE5TpAfe7r8CDHNaln
 TskBXp3JrXb599jptaKWTb3kFrUkE5PyLiMFeJOT1iapxV4oAhXR99oWbuAVtCKKdyt/
 wFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776158054; x=1776762854;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ATbplWTHRL1bKh2jRDKkzuFfRjRr92P7D+wX0GVGWBI=;
 b=mim+7oyKvkbMkWx3I3rUHWJ95DBCTkDnNCnwL4iCcKZsKpdZ3QI5d5v5nJqsn2mX/c
 WMWmRp+RTmkqannoXf19waa+W8rLr4TCU0icrHd4bHArhqJavDfd/JQDiL87qpDj82Bg
 rcCAXsScH8XaUbBMpa/nZA9vGuNbri7215zhLmFVDQ8DQWeCsKyYiHnER6NkTdkAyQKh
 H5HevrdR0sxnU5p7QcTfU5tdlzm8pGVoFVwHasf1bC6mQHdjrhqnNlawcHGGwiJdmbg/
 lvfeOF3GYGwvBMl0u2TIRCRtFHzKaNfFExIc02bJVIlKJG1ozUBxoMSsz7Cia/I/3hUr
 AnFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UodrmQsDOQJo0j5L5lqh+E9kOjjXO36VkF533TK11O/vGhGntKHviqbh1EW7iJ/Nx3s2eVGPf/yBY@nongnu.org
X-Gm-Message-State: AOJu0YwEkHLollRcd4gyKBaovSLx4OiIsCZn4KR95vv4On0Ry7fhVNQ8
 TVR9ZnPauL8KRnSQAogkLZsgeCMLJFRlxY81PUlBCT/QVyjx8+6+NLcE6exzPDgJaEQ=
X-Gm-Gg: AeBDieudQgNsev4uvHbqBIc7Fay3qKcf+fvr3gHyv6IJHj0zle6Wt/vGhAomHGekIVM
 wc2aCRFnoEJNTE6zBY0p556THidBEmQ09SsmFlLUNBllFDkYFeNonEVRzgzr3eZci1DMXONm1GT
 4gxHUzRMLSj/yUWRkoZPVtju7StcjJYgszVRWjL+efRNJVCLAV7F1LJVS+Bel/KgwYPa6gtQVf7
 pz2oZWfhPh4I4VDyKaRTjhws2/kAdGkR30KlPWiZf00Aji9otRZzAxNWK1z3YwXEMPsA7bsjDDM
 fVVzr44fPwsTENCktpODuSUHLgXrbJ7H3Uz3nk7MSvxe/ImT9jbkgwMbXe3Ow12TNNLWDpl5ApN
 3y32qri8/PjnUW2teUOe/b9zVQKl0Qf6xgMxKSBQVJg0bV4hN9891cUdJ7nAFDr52FTeKpqBvHC
 FGOn18/BNWhv2iBfPcrG18AYt7vQts+TK/9zdcKyifeiCKAGOKeUgsl58SvzlanhUY6g==
X-Received: by 2002:a05:6000:1844:b0:43e:a8ad:975e with SMTP id
 ffacd0b85a97d-43ea8ad9b14mr309903f8f.27.1776158053841; 
 Tue, 14 Apr 2026 02:14:13 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d750f0ca9sm20975947f8f.37.2026.04.14.02.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:14:13 -0700 (PDT)
Message-ID: <c1e69281-4837-431e-a12d-192d563d08a9@linaro.org>
Date: Tue, 14 Apr 2026 11:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-8-jamin_lin@aspeedtech.com>
 <b143a786-751e-4d19-b27f-40449aba52a7@linaro.org>
 <TYPPR06MB8206F995851E9CAC13928361FC252@TYPPR06MB8206.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <TYPPR06MB8206F995851E9CAC13928361FC252@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/4/26 04:49, Jamin Lin wrote:
> Hi Philippe
> 
>>
>> On 11/3/26 08:26, Jamin Lin wrote:
>>> EHCI supports 64-bit control data structure addressing when the 64-bit
>>> Addressing Capability bit in HCCPARAMS is set. In that mode, the
>>> CTRLDSSEGMENT register supplies the upper 32 bits which are
>>> concatenated with 32-bit link pointer fields to form full 64-bit
>>> descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).
>>>
>>> The current implementation assumes 32-bit QH descriptor addresses and
>>> directly uses link pointer values without applying the CTRLDSSEGMENT
>>> upper dword.
>>>
>>> Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit
>>> descriptor addresses when 64-bit capability is enabled. Update QH
>>> traversal paths (async list walk, horizontal QH link, and periodic
>>> schedule entry handling) to use the translated 64-bit addresses.
>>>
>>> Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer
>>> fields as defined in Appendix B.
>>
>> bufptr_hi[] is not used in this patch (but the following), however I wonder why
>> not convert to 64-bit:
>>
>> -    uint32_t bufptr[5];               /* Standard buffer pointer */
>> +    uint64_t bufptr[5];               /* Standard buffer pointer */
>>
>> adapting the current 32-bit path and extending 64-bit in the next patch.
>>
> 
> We cannot simply convert:
> 
> uint32_t bufptr[5];
> 
> to:
> 
> uint64_t bufptr[5];
> 
> because this does not match the EHCI specification for 64-bit data structures.
> 
> According to EHCI Specification 1.0, Appendix B (64-bit Data Structures), buffer pointers are not defined as a contiguous 64-bit field.
> Instead, they are explicitly split into two separate regions:
> 
> The 64-bit address is not stored as a single continuous 64-bit value, but as two independent 32-bit fields located at different offsets in the descriptor.
> 
> Therefore, changing:
> uint32_t bufptr[5];
> 
> to:
> 
> uint64_t bufptr[5];
> 
> would incorrectly assume that:
> 
> lower 32 bits and upper 32 bits are contiguous in memory
> and can be accessed as a single 64-bit value which is not compliant with the EHCI specification layout.

OK, thanks for the clarification. (Please mention part of it in this 
commit description).

Regards,

Phil.

> 
> Thanks,
> Jamin


