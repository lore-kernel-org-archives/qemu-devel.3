Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B5C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhAD-0000KP-QN; Tue, 18 Jun 2024 18:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhAC-0000KE-Gl
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:18:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhAA-00050N-U4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:18:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso4100184b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718749129; x=1719353929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Jdokwu765FJCWejpVJf4p5gTdeyXX0HupJARTqik3A=;
 b=baXFxNvOpuO9tvmhKM2KeG/T3PgW5ySuaOpBdtAUE3g6FC2EA0oOMiDXuG+HowZREM
 JI4zIIVNEpxcj6wY7r8a4eePDNzMl9fB7Ei+SuaAQTu5ct3mPWfTONOctMGnNCWSLJgD
 Dq16BBWhWABmHZtvnFGhUuszRiypae07IcH7X6utlSOTbkKtxoUf9z2okvT8dyWLRIDD
 nDaNgNqfniIjomXZR0yYLoD1S2LTDvZgaIj51zTdeQ+phWfV8X3wxGeF/2PMSH8jyYHs
 iN7oQrRR6/yCbW8kOqqAGkDfHjgwDHG4x/yGwCRTYxRqSuqkOW5+HrV7xBn7xgpudHt7
 0A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718749129; x=1719353929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Jdokwu765FJCWejpVJf4p5gTdeyXX0HupJARTqik3A=;
 b=OW34WOlCQ6FNdvxSMPgjW/eaIvg4ZzAzds51BlJqbf+fjvAlkA8fjp20AjsjMzBal3
 8WnSWa/AwKPEkduox+idZwBpR1Rwlbtc4vLna675KEVFhVH3DtDW16zs5BMXuA2KpH9f
 5kiKNS9LUCCJQ4u+GZuDk9dKbHSy8AJoMPCE8qh00LfAurQXgG09h4QSTxd4DcSFTxGc
 6OVZLdy0eSGq4fZqmNriPk6YeNGmN1BH4likU2R0OFx14g1Ps55s80B1D5DJPRsR+4BY
 Z6Vn0DcWZm9zz7xwgFu/xv6gBaqgFLrBi5HgFkcNYJrY8jlw04sJehqIg4d+9bdp4T8N
 qBlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9+323SuZXduTu0TNqNnvepm3BUaww9o+oHYxo2obqXw32S27AAYTAVhER1NfzGAn+ktTqo+Gu/J/1MtOA60ygJbPtPDI=
X-Gm-Message-State: AOJu0Yxr4p0BHzpQE4AebIMKc6MXwKMN5sZG9e5OP8aQ4iLrrsmlNWKD
 mrssyLo1W94bbKsm80rVf+1ab7Wfa+uQrpuyztDD+N8EPIsclULgAuF/g2PqrdU=
X-Google-Smtp-Source: AGHT+IE4aZVOF1hlS92OGMiDfpKHTc4v4tXyj4ZaGebcgitpjno6pbJB9S7tmrNsOsTv9kSaWxfiYw==
X-Received: by 2002:a05:6a20:c412:b0:1b2:b135:8efe with SMTP id
 adf61e73a8af0-1bcbb451684mr861663637.12.1718749129159; 
 Tue, 18 Jun 2024 15:18:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb8a29bsm9409968b3a.184.2024.06.18.15.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:18:48 -0700 (PDT)
Message-ID: <b723a419-e18d-4a45-bdda-fd8620322bd8@linaro.org>
Date: Tue, 18 Jun 2024 15:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] Add ARM AArch64 ELF definitions for bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-14-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-14-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Defined mmap and dynamic load adresses and
> set various elf parameters
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Kyle Evans<kevans@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_elf.h | 37 ++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_elf.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

