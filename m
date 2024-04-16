Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwoaR-0001tc-Qa; Tue, 16 Apr 2024 15:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwoaQ-0001sm-2j
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:35:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwoaO-0003FV-ED
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:35:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so26635115ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713296118; x=1713900918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DlgNTpyu9f9vo0Cy0xOg8PrUP+sW5dmO7a+Bb5bs+Hk=;
 b=Ca0bAMMQ16imIxNY4iGQHtXpDBd+BAUD1PtF0hYwDRMWip2YKF3n6oBs0/LB3UATXB
 ntbfvPs+UNqnAIiXLEkpgrkZd1wq1SUsHEzSRNWlTu6e55ajrzarUyW4rnAWfe9EbeBN
 dviYVnkOSagFhKIctBdTIAJ08GfxtCJNMvbib2NfAGVdNHw5ncSyRV7OHlBBlpttxr7q
 GrEyfqtvKoO+Lixed3agHAA9V+1BnUXjA5FgGUUEyDufeAjPyY8jYi/aTA5l88XaeQXW
 qc26xaHO3pmU9pEKyB3qWS3CfxvD1QcfP/s3ijNk25tv3aY+M2sb2XIslT8Q7/BvPl+u
 ZJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713296118; x=1713900918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DlgNTpyu9f9vo0Cy0xOg8PrUP+sW5dmO7a+Bb5bs+Hk=;
 b=appGNfp87HyPovKf82sNrQs3Bz1/PQs7zP35fBfGXMVCJVgii55jXwRSN86D9Amhx1
 EYzsbP0LIuCDsICHKbGzvrAI/edDWqVexB5Rv1qZkdfrELmT9BZ2slLkJoWzufnmuXie
 KZ7I1BBJw77WA3kDwyZ7QICOQjhNe9KaYrOAyk5oVVYUanru3VC5actX3cRWxwJUPKTQ
 p7xHZeYfL0WJML8L77dtCLBPaLUO9tauIoII+DaWKhAbluTP0FCELoZaWyKKv0al3IKP
 Cw3i7dVhtXFamyrjy2xlYcjs89TVfTgV4ns3SFsA2pzxmol49IjWExhGuUDw9Bo6IjYL
 HaiA==
X-Gm-Message-State: AOJu0YzCoawKBO7Q6EdJuf/c2iNMYc1P/HUXAEICiYNlfi+MDlLgZehr
 q+IhYyyrlKY7bb/1Rxz62rWoxorR5Rg1Qy25sZmHCNf/r+J0QYJN1GWivTYnajM=
X-Google-Smtp-Source: AGHT+IGpmgGtXko/+a3J0wTvBW1KiIiPqXMMZiiD+sBdnB/0VYay0VqMrF3T3g6BMxIoUvStdPD+nA==
X-Received: by 2002:a17:902:a384:b0:1e2:b4ce:4f8a with SMTP id
 x4-20020a170902a38400b001e2b4ce4f8amr13096862pla.53.1713296118618; 
 Tue, 16 Apr 2024 12:35:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a170903120500b001e4458831afsm10148809plh.227.2024.04.16.12.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 12:35:18 -0700 (PDT)
Message-ID: <3be7fc22-b181-4b0a-bf80-d2011da1a437@linaro.org>
Date: Tue, 16 Apr 2024 12:35:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/ppc: Move logical fixed-point instructions to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-9-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-9-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/15/24 23:39, Chinmay Rath wrote:
> Moving the below instructions to decodetree specification :
> 
> 	andi[s]., {ori, xori}[s]			: D-form
> 
> 	{and, andc, nand, or, orc, nor, xor, eqv}[.],
> 	exts{b, h, w}[.],  cnt{l, t}z{w, d}[.],
> 	popcnt{b, w, d},  prty{w, d}, cmp, bpermd	: X-form
> 
> With this patch, all the fixed-point logical instructions have been
> moved to decodetree.
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                        |   8 +-
>   target/ppc/insn32.decode                   |  38 +++
>   target/ppc/int_helper.c                    |  10 +-
>   target/ppc/translate.c                     | 359 ---------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 269 +++++++++++++++
>   5 files changed, 316 insertions(+), 368 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

