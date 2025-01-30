Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F37C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 01:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdJHM-0002GI-EZ; Wed, 29 Jan 2025 20:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdJHK-0002Fz-DX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 20:23:34 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdJHJ-0001ea-0P
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 20:23:34 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd43aa1558so2893116d6.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 17:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738200211; x=1738805011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bxckD1K7fVQcFKMaab19A+tS2ehSonVgCyxLx+jHw+4=;
 b=NKAEtKze2laIEjapB/7OQVn6ySgpiZD2IyTmV0FKspiItVsx7vMJzNoxrD2qG2ny/I
 3Sja/jI9choAJQNqWpylHX40uKxd7lorOGpiIv/vX/QCqdkEmpqvgTT4C7ngzX+2kt0b
 JC/7Jofk9wJb8GVQZmigFK6EIrjAp1+RNAMLf2sI4+UZDkc7l8kJITUKLRKZ8AZ4Csh0
 Kx1PhvLz/NeTEd35sKNA0PG2k8FlH3mKGSxJ2StoRrbUFEWKMxYj5tdRUvgEJQvt4tWg
 fVPft7mtC6/xiZG0M0vusxJszr6EK56JvPwJw5vulkdMMqJ0GxuadvuyhV3bUBgVG5rc
 2wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738200211; x=1738805011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxckD1K7fVQcFKMaab19A+tS2ehSonVgCyxLx+jHw+4=;
 b=IJrl/UFL9Kn80BdlquDaIaif5Wvq3dWqmmsA0UkBZnI9qEC3rp4SwgGFnuffzoSq71
 xGfZtDGrM6ktP6Vw2O+NsuyNUabW9CFGv7E+shfgt788CqwjqOYSnVCAAnJAYmibhjwv
 qWvIdFDlNrEpMCll6CYFtm1gai4EtcNldA1S/28+lbT6irkETKMVTsrrLTPHDZGhWEIM
 z4KUZvwuySomoF7zohGeR2H00mJ+XruHcHTwAlMaUdBmhR8mW5NFRy2kqXHL6fF4DWJn
 rPjH0E2I6ZHjK3+QRJ34DTcClLqsEqVoPLRE2WOgLeoR5jmYlqrhCh9HUH5bWFyidZDm
 n4Ow==
X-Gm-Message-State: AOJu0YwsUmxcDZiCDQ8ATe1d5es3edJPDR50p0dSQbe6sL2xLdcpCtMy
 cuCuUf1Lz0PcFjF9+vKyu+LHAEY109zrQGy49PFl5RPc0n1aLPQAYhhPsJFXzc79g0N6kiA9zZP
 i
X-Gm-Gg: ASbGncvInejm3vozf7LDJTOwrpPoxaPRZ7ZqSjCiiI3nCzt7FfJTCZ4y1WO1zbdinih
 GeiF2bTruH3GViWF6jaNVUBjokVX5WZcth7gro+L5dV1PfIy5B3k8vE+wL9OEoWPwmUcxRw5dNP
 qSHSRfj5RfDPLETuKPt8VvfUX+zsnpYQo9dplkZCg2TZgcYY1rIqUqp3sN2/bry/G1FPrnuqSix
 qUPJjKvKy6+VAyzH8ZusZ2R6orhbxdrInz71vBuLE1RiqZuH+CP9Gxk3YUe8Wr0Pypn1QTRSI1b
 xgFNRgbyM5W7o/bjUouQk2pTofV1gCUA
X-Google-Smtp-Source: AGHT+IG3mD//aGqceTPmMSCnMU7qa9Bv0TpsepZBO0nM5jI4V20WnHf+rWkDxEp8PQt8NAvOOzdzCQ==
X-Received: by 2002:ad4:5de3:0:b0:6d8:aa04:9a60 with SMTP id
 6a1803df08f44-6e243befce7mr89509076d6.7.1738200211410; 
 Wed, 29 Jan 2025 17:23:31 -0800 (PST)
Received: from [192.168.163.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254814d1esm1058416d6.38.2025.01.29.17.23.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 17:23:31 -0800 (PST)
Message-ID: <484b6063-e21f-48d6-9121-6c0c64396889@linaro.org>
Date: Wed, 29 Jan 2025 17:23:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tcg/optimize: optimize TSTNE using smask and zmask
To: qemu-devel@nongnu.org
References: <20250129131127.1368879-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250129131127.1368879-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2a.google.com
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

On 1/29/25 05:11, Paolo Bonzini wrote:
> Generalize the existing optimization of "TSTNE x,sign" and "TSTNE x,-1".
> This can be useful for example in the i386 frontend, which will generate
> tests of zero-extended registers against 0xffffffff.
> 
> Ironically, on x86 hosts this is a very slight pessimization in the very
> case it's meant to optimize because
> 
>   brcond_i64 cc_dst,$0xffffffff,tsteq,$L1
> 
> (test %ebx, %ebx) is 1 byte smaller than
> 
>   brcond_i64 cc_dst,$0x0,eq,$L1
> 
> (test %rbx, %rbx).  However, in general it is an improvement, especially
> if it avoids placing a large immediate in the constant pool.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
> 	v2->v3: adjust for recent change to s_mask format
> 
>   tcg/optimize.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

