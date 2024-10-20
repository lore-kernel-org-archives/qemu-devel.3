Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFEBD3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 21:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2dLY-0000jm-QB; Sun, 20 Oct 2024 17:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2dLV-0000jN-MS
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 17:20:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2dLU-0002R4-3F
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 17:20:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20caea61132so30307295ad.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729459214; x=1730064014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsdKrG6BeC8jQPAMdQTEklAuLVrs/HSCe6D2dkSa5NE=;
 b=Pe1BtkhSxueZtyvvNEUp4vk0LpiSxp2jau20WBMLXoXLUGVzlbNUMitk+YPUtYUiGK
 pH16J+hlsIdLWIZqwRT7dlIgbRnFLQgTeAsGEcuuvd4oE+Od7+O90UdF279YXZS9Hy//
 7+dsJ2nvP80HJQQTJcYg3myaplIiACrGReVue1w1tu+CF2pMDhVRMX3BetMlWgCH2ySg
 CN0q8htR7ujWASEzN9w2jmGG7Yz/9w0/Mjjy7xKyQxLwqQR6P2CUwf6k5EnhUsGcljDF
 t7+3ue2+U4GmfcYSLFttOSNmVBGPcfJgBZSYP4KfrsY3ZTtHtPHWHwKZkpfcY/7uBiE/
 kuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729459214; x=1730064014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsdKrG6BeC8jQPAMdQTEklAuLVrs/HSCe6D2dkSa5NE=;
 b=bpjLWfcExchN3RDjse40QU2Yxr26iV8hPdY2FGjE2OxyT7ChOY61g6L6Ptx4bmRhdR
 djUpddDx/obMGf3xJRP/ZQHtm0XQ5tOJRbdMuBEeh1Vyjiyqserooc2Ae6leXCVLiP8l
 MVQpMx12hkUu3mVMutEJ8SEAFIJMxmpMdn7TMUCS68HNm27H882OFhSCwKQpk+hwtMO8
 OtZmPa+uEBmOCMU7lZLFWez55X7aynpMi/+QCT0og/798D0VwFLBm52WKje5oKTXM4VI
 ysbLFmtWc9IJoBQ2YnyGbcyRFauBCicgEHxGAcnDMq6QVsnoBtc2pdq+pSA61DdM7HDl
 pxdQ==
X-Gm-Message-State: AOJu0Yyv0zfJmP+e2jDsOYsVtUU9hPrI9Vl60gt2TRMfgFJrco1jQ3HV
 VBMD1d0VAgTX5xZ8jbgyi69ZTwvc904jBfIV2hvr9vcMYQGEo6IXyXbtHFjq18o=
X-Google-Smtp-Source: AGHT+IFKq+moUkxYE+oPFC/A6/4xWT0dZNj9xlCL1e6ClR7IvJ0oswi/7Gx2bsSo5A61HG8O1rJDNg==
X-Received: by 2002:a17:902:fc4d:b0:20e:5aaf:32c1 with SMTP id
 d9443c01a7336-20e5aaf4098mr150729795ad.30.1729459213860; 
 Sun, 20 Oct 2024 14:20:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7eee63f0sm14022705ad.3.2024.10.20.14.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 14:20:13 -0700 (PDT)
Message-ID: <5bb8386f-489d-434f-90f4-59b089bce6af@linaro.org>
Date: Sun, 20 Oct 2024 14:20:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/ppc: Fix sigmask endianness issue in
 sigreturn
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241017125811.447961-1-iii@linux.ibm.com>
 <20241017125811.447961-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017125811.447961-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/17/24 05:54, Ilya Leoshkevich wrote:
> do_setcontext() copies the target sigmask without endianness handling
> and then uses target_to_host_sigset_internal(), which expects a
> byte-swapped one. Use target_to_host_sigset() instead.
> 
> Fixes: bcd4933a23f1 ("linux-user: ppc signal handling")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/ppc/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

