Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C654C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhQh-00040y-9q; Fri, 21 Jun 2024 12:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhQf-0003yu-EG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:48:01 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhQd-0000Ko-J6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:48:01 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso1436129a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718988478; x=1719593278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YvHvdAw+6rbSQ4u3H0WHyO4Udb0x3Rj1gDnph2JEOXA=;
 b=TZUqJPqqWEFoIY4nYsa4jPgIFwu8nKeqGuVUmheaR96wFZWdNr4GwuVv21CkQbGuLM
 A9NJhh2JLPwWyTcIk0v6bN5RYr0QFT0FEd30v90t/PC4fFsYiqCfNHrj39jV3sGAX2eR
 NUWDObarMpvdyyY8ScGl8+q0dZGf398AY8gfy5aEfJ0ZlJNBSD25pyxKiVCwdnYaoccw
 dByvmwGjeSCz3Cg9ngMpfWT5PbadipsRkKmT8Ecel10yBUjQZGttZeKAyUrMW5krrDCY
 33rmUc9pJotGnlP7PL3IZiMquxTEqpNU4jJybMWQMvS9zR8czLg3c2VQRGLw+0xIiOWz
 mItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718988478; x=1719593278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvHvdAw+6rbSQ4u3H0WHyO4Udb0x3Rj1gDnph2JEOXA=;
 b=jm6I5E+T7IUH/plGecW1BlI2nQO75yKa4J9pR/DbkUUSa1NYagrFlOpU6f34cnz3C4
 W5qfsnZJHONa2qu//a+SV09yOiReULwIAB2x69wAWwqc9zUDslr1v6d9k01RQGoIPnTZ
 bP5ntoN+KOuBZdtl6DiHKAkCFkfv6WTgCr0d24YxYbuH+kwM8hwbDytcqzzjNVMhGbEs
 6GyRPvPDFLq8qcWU5IoQA5CfoehsPoYQ9+f1F9BNvKNcCuTl5JbkWvRe29iSSBMutm7z
 IJotwG36z7uskanq2g7oAf35lAwZy5+IEDnKR2B0hIcHAlkWHW4S8qrX+p8E3VFM23Lu
 kbwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgfwFCeHQ7gx7W+IrbaQ91V8U5RlTFu04UPY0bdbb9bLzYj1IZgNltUbxMpn560nEj3mrT7gWDWXR51J5poqrVKqKhqXs=
X-Gm-Message-State: AOJu0Yy3TwatD/Rrmf16bFweHSUc7flKOTBKegxHfowtJpkU+3FpydwB
 UFUBLGS/ojiaulF5eDcJQa0fqOUxjMwZ2+9vkktc86+fcKC6AA1NU/uOdaAJaTY=
X-Google-Smtp-Source: AGHT+IHUn/1LnZrdIYnwY1zL1pjXDup7pAzJ6NkuBu9Aq1eryGcSvp7kKtpxGLeSV9nZpBB/LId4AA==
X-Received: by 2002:a17:90b:368b:b0:2c8:7ea:8578 with SMTP id
 98e67ed59e1d1-2c807ea8af9mr4177263a91.8.1718988477870; 
 Fri, 21 Jun 2024 09:47:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a7d60bsm1815243a91.22.2024.06.21.09.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 09:47:57 -0700 (PDT)
Message-ID: <c8644f08-d662-4578-9d08-779449eb5c7a@linaro.org>
Date: Fri, 21 Jun 2024 09:47:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bswap: Add st24_be_p() to store 24 bits in big-endian
 order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>, 
 Fan Ni <fan.ni@samsung.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240621075607.17902-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240621075607.17902-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 6/21/24 00:56, Philippe Mathieu-Daudé wrote:
> Commit 14180d6221 ("bswap: Add the ability to store to an
> unaligned 24 bit field") added st24_le_p() for little
> endianness, add st24_be_p() equivalent for bit one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Some SD card registers are 3 bytes wide stored MSB first.
> ---
>   include/qemu/bswap.h | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

