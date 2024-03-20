Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEDC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 01:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rml3Q-0000X7-JH; Tue, 19 Mar 2024 21:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rml3P-0000Ws-Ge
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 21:47:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rml3O-0002hA-04
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 21:47:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1def2a1aafaso32091635ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 18:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710899260; x=1711504060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bO58h9RrKvMI+tBcSflboNNXkwfvvDPaUx27qicmeIw=;
 b=WoxTmXSeUmLWiUF3E8IMHZzoALG31d69N+Lob99J/5ECam8Gwk+TCvFZq4sZaJW+9R
 ajTFXj8q5efwKqk7W1Sge7+W3CSRmE4ux1DTEbvReTd4xDc7DZhG5smoolpgAyMmTSGt
 Oh1mZ+srJxLDYqNdKJk4UIY0ESmtxLVjfaYJWML2q9mHKr6ZQJiyX9ZI98bCr8sHizzn
 PbLKvYVaveZJZwUWww4yu2C42bUWCPv9L7vWUI5Z+cdFLPuxGRvjVyt5MoNi+CG8HENK
 lg9HfsYhv3TDmZG93MeXWt61LSP8RpYflqfxZOYJOwCnW10Y6K4xQtwYTbnsEoTL/1rm
 uCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710899260; x=1711504060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bO58h9RrKvMI+tBcSflboNNXkwfvvDPaUx27qicmeIw=;
 b=OyoIzuDfsdrnLTDpf9Dp+Zp5tnsoKv2Zva/diOECKImjpe3FdY/HlvKDO1o7Tfl1K2
 Bmq7AjRnapkj9+bDyF/xpFSAEO4U4njYXi42A78TiDw9kwm4TaxqOS2At9/AJ2l+aoEV
 fkgQlpVVri//9myQPlV6H+b93lCR1J9cYljtBFQ9qyDJsJqJID9kNDHKKTibasBohX8Y
 pRV9DpuAgoc3W1sKaoDTcqdOHkDqaS+skvPILsyXen7TwY+sZt6FQi1NOaUA/YPku7BI
 zvOwYLy642/g8eojcP5upuGF5zrN65ccRCCi8Td9qZOLMZY7VGlNsWOjoTHPRIrS96Dl
 rTwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXjfE6+/bRdOgh5Khdxfkn5xceQyAwXsN/xa9cnTysTaoTI5zVwb/676yROmqLDXdad4GxbXYa53ADHb1v+CaIW4wmflI=
X-Gm-Message-State: AOJu0Ywx7TJToo+ceZcjEYIjmggiLruXnkailSBXF6JGlKXegRpBTYCC
 pEkAL9iughTwpKukMOu0K17197+n4/3vkyBRFd2oqCOOTd/5yrsezYQ3tSPHk7s=
X-Google-Smtp-Source: AGHT+IFDewNMHgIfJfYfusp6uNznUqLHTrZKqgFjOClM1wzhAVu6u99mzmYcuys2W6IdXcJC4AkMXA==
X-Received: by 2002:a17:902:d68b:b0:1de:f91:3cf3 with SMTP id
 v11-20020a170902d68b00b001de0f913cf3mr14300683ply.55.1710899259945; 
 Tue, 19 Mar 2024 18:47:39 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y11-20020a17090322cb00b001e021e90968sm5246250plg.306.2024.03.19.18.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 18:47:39 -0700 (PDT)
Message-ID: <a29b683e-8183-4449-ab4a-4da85b569d2b@linaro.org>
Date: Tue, 19 Mar 2024 15:47:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: Fix qemu-loongarch64 hang when
 executing 'll.d $t0,$t0, 0'
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn, lixing@loongson.cn
References: <20240320013955.1561311-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240320013955.1561311-1-gaosong@loongson.cn>
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

On 3/19/24 15:39, Song Gao wrote:
> On gen_ll, if a->imm is zero, make_address_x return src1,
> but the load to destination may clobber src1. We use a new
> destination to fix this problem.
> 
> Fixes: c5af6628f4be (target/loongarch: Extract make_address_i() helper)
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

