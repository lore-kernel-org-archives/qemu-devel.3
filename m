Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B817C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDLx-0001p9-AJ; Fri, 26 Jul 2024 01:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDLu-0001oc-KB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:18:50 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDLs-00031V-Jd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:18:50 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cd1661174cso461653a91.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721971126; x=1722575926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vwA+xfcs2HeaOeSdan2wzbPOvVg0ft5wiBItOD7P98U=;
 b=bDMjOj1L/NipfMZRhFncDqdPs4+GVvn1QnQEIUMIa+3az5sPxIklCY8NhYoc9kz7zv
 eBjy1a241ePTTiVSbFp2ZCUUpDHfSZEY7za5vyvkt+7UYEYpe+y+bj0gDprWp2dZuaJw
 vMk48giP7W2aTqWK5+RGsXpCJZCT6nsMh5ZGPBOQVPmymjhy8Zret8h4rtjGzKfcv3ZB
 xzW4bge+sSuiIBnn3XzyO49Uiic2dAWvhCkRA1e8dBSg4+FDs/rkgqWlqTr0eL4xI7fE
 VnwFZJwvcsf+XqF5pBS0WpRpkfOW0h5TMhvJJGp8ovnlrIDm/22jGzNdiyr18kN4lGCF
 ajIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721971126; x=1722575926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwA+xfcs2HeaOeSdan2wzbPOvVg0ft5wiBItOD7P98U=;
 b=PrcegAT9mpxTqxqr4ZgBs7zh4plbxO6n37hZh6fxqPvRdlX3saTfJNLI//1MnK/iQK
 3kuslKyS6gHXjKa8nNxU5nW8UwDI+N8chR0hCMiCHo1p6L52Nuc08zooF+W8RJbeA2qn
 Am0UN/8gQMZwHDlZeVOdOmOgIlqjSteylE7XNhCqJiU8tj2VlRiJbQ5vj5p3vtB6kZWy
 2HkmBbOrCALIl2NdLcwBXUSPdYv//OMdmf5KU6zT8xHVAeQh8e+/sLBzgL4POqaB3mkb
 m+9A9GSKQIXwUnsTuMDcbwFe8dsrIaooCpopcek9Gq0/5TC7xtnhgCPki6O0ldPx+Spr
 fUUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG2YGwVFhpLMesKkA95CFDzpa/6zp86KCg4KkaUWO1QXmYwt53vid7wZpFiNys7R+42xp6muxGJq8J@nongnu.org
X-Gm-Message-State: AOJu0Yww6DE7v7qzX/02pdgZVsZSc7Wk0xtLo1wR/4S161UT03E3lgwP
 A9nxPL8DGx5B7ZeUL4huvXkoBGhIjX1CS/JauCVKn2SQFtCAEs6RhYz1qjqOUrQ=
X-Google-Smtp-Source: AGHT+IGm1AIPCRUPMzT+Cp9ujxMTGlMF4c1/FdQrRmu6VcAhXv6KOCdChGPst7b1dhj0Jr0iKjOchA==
X-Received: by 2002:a17:90a:8d16:b0:2cb:3749:7baf with SMTP id
 98e67ed59e1d1-2cf237a3332mr6053598a91.17.1721971125833; 
 Thu, 25 Jul 2024 22:18:45 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7b092sm2473082a91.20.2024.07.25.22.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 22:18:45 -0700 (PDT)
Message-ID: <182650c0-8a3a-4a09-878d-22a4cb36910e@linaro.org>
Date: Fri, 26 Jul 2024 15:18:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include/elf.h: align ELF macro name with glibc
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240726043246.10999-1-jim.shu@sifive.com>
 <20240726043246.10999-2-jim.shu@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240726043246.10999-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 7/26/24 14:32, Jim Shu wrote:
> Rename DT_BINDNOW to DT_BIND_NOW to align with glibc header: "elf/elf.h"
> 
> Signed-off-by: Jim Shu<jim.shu@sifive.com>
> ---
>   include/elf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

