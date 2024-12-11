Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCDAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNLE-0006PK-30; Wed, 11 Dec 2024 09:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLNLB-0006Oq-MK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:05:25 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLNL8-00063x-Qp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:05:24 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb7ca55c3bso694317b6e.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733925920; x=1734530720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kvNMr97NdtdODpumSF8YerFyq9zlg29r2auNiVKe8Tw=;
 b=xaz8DDT+dlUomVqCJz+5sLA2h42lfYh3d9pIHS3b5dQ9Tq2wzW/4sox3t6XUkp4Cnb
 31Mrb+jeiHPLuhizGiXAe+e5wazfIyi78Q2XQE/dAODxc+gF13yMCL9gDuEC+20SaV8w
 lmX/WEfskTs+6bkqMJvrU1NPNt33VeH0Oq6PTt8PC1aJslomrddsf/AoSFH6KeBmYy7y
 BmxJ7c7CZrbPGfU/0tHG9oOLsbkvL6A8MH5XA4bRN1cjQPSizbvveIFwxoqHeZmaodNL
 kLdInO7H2nMZsR85gQueI3khwQOynBx34QB02/yuNn3hKeFeGcKVr+uub0C/Y15WtoJR
 XFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925920; x=1734530720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvNMr97NdtdODpumSF8YerFyq9zlg29r2auNiVKe8Tw=;
 b=KE+4+DgVBVTHxBE4I6ZgoKIXq8SeQRDSWcMYof4Q6stw1wQEviQnidnZKlM1wDjP2q
 F3xAut4JJN8eLeRQuQK6uVOlDoTXmVJunFeoK9je1YljsPYvx+MBXoU4Cqm6n1cqNGkb
 nSFppMFRhd9TpgbI9Dkgt7QXg9JeJYXeNyGW8rUZ/T6yxHyAoe+0NNWYqhYXSQHgr0gB
 id8LDyLBordwPbrBjbrYTTrEJFHIwVGbvDVGBdKLzvoiBDhliG5gq560fDrs05rHf82W
 p5wJNRlw1CNa/OTEKFr1ac3F02SOyP9fFP/aDtIym3lW3Jdxmb5bpE+3ShEPrcApIcF+
 s3Mw==
X-Gm-Message-State: AOJu0YwVwCFfcLaMrOu9sfPXyA/XZJy+nU3GFEqsSU1sLuGpXnNucMdH
 swod4UAj9DySgs5E6sZcxzfvln2mnLu6GSo50GBSd/6YGZWSmEf9aG5R6MZ3oXCRVD/W3JRNzRa
 H/HKyKt7w
X-Gm-Gg: ASbGncuJKUBpk+rpp4Ij0lroO1xw/94LxLISWeLjUa6KpyYlhRF6URNwK6G4dLPd199
 qpNohYQFRLEhAKUV4sBxfSweXNIptoeYDS41wYGAUtxi8oRFJQIqVvNdiJe+6A/wOvCGEIfUprP
 5uSGN35FpX213ypuMbTmEmFAzRWC410eeZjeVr2cSZXL8WNrD3LSoDqtcBtQTDOc1p2To/FQF0w
 CifXlrQqI5I7K+hC7fn1gwOHGBiR7vyPXK5qGIFdQB/9e5Ry88pbVtUPsKKBQU0TT5VspA=
X-Google-Smtp-Source: AGHT+IG//6Rs3k2whwxMnuyV/84crDG0VLXnO9Qxmq0z6f2IYA4OWjD33BAU3KylIbSJQVGB7hVUPw==
X-Received: by 2002:a05:6808:3c4f:b0:3eb:4076:8659 with SMTP id
 5614622812f47-3eb8576543bmr1740788b6e.0.1733925920550; 
 Wed, 11 Dec 2024 06:05:20 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b858asm3271779b6e.12.2024.12.11.06.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 06:05:20 -0800 (PST)
Message-ID: <0783e99a-4ad6-4391-af6e-39bcb8c0b2f5@linaro.org>
Date: Wed, 11 Dec 2024 08:05:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] target/riscv: add VILL field for vtype register
 macro definition
To: qemu-devel@nongnu.org
References: <cover.1733922709.git.lc00631@tecorigin.com>
 <bd2eb642a5876b4417517febc0656ec4beccb45c.1733922709.git.lc00631@tecorigin.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bd2eb642a5876b4417517febc0656ec4beccb45c.1733922709.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/11/24 07:47, Chao Liu wrote:
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> ---
>   target/riscv/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 284b112821..fc286484b8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -170,7 +170,8 @@ FIELD(VTYPE, VSEW, 3, 3)
>   FIELD(VTYPE, VTA, 6, 1)
>   FIELD(VTYPE, VMA, 7, 1)
>   FIELD(VTYPE, VEDIV, 8, 2)
> -FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
> +FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 12)
> +FIELD(VTYPE, VILL, 63, 1)

It's 63 for rv64, but it's 31 for rv32.
We handle this one manually.


r~

