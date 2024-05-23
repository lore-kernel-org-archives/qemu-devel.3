Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC2AC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAA5u-000310-U3; Thu, 23 May 2024 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAA5o-00030E-DH
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:10:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAA5m-0006ZE-QX
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:10:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f43ee95078so3741760b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716477053; x=1717081853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xTCFjWIoWVn2N1HpbzNsEG3mTzzump9wh+FKltiiOF0=;
 b=aRqO8NpIxA3rAcezOtspu8Sc1DmAi9KUbilfzqKRIV6S9nTI+NJoVFK+EkzNMbYzlE
 2ZzPl5nf2GRDBNxdUVXhX1eK2HsoOxklQtbYhBnpE6mYoRhUZ0Yl/EvVj0ucZzYK63/9
 dVVdQSrTcq8ZB9H6JmheqGRqnb0MHDytJIsqdYd6XkFsbBqhTV4KeSVjZGnluSApJITg
 Vu/xF0gvhSeENgx65KDSFIgN9aDW9w8wDYeG1PW3T0VV3/tnUBjqx9FQZ0S0YIcrjLPS
 kRTzuAZupoibiKBoV/PyDrZi0NTaA2VJDjRsmQx+UuhkugxMG6Knjhk+4wtbno+4/OKJ
 ePTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716477053; x=1717081853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTCFjWIoWVn2N1HpbzNsEG3mTzzump9wh+FKltiiOF0=;
 b=jtMtQ3Q4N96wTaDrZWAVghEPRpZERjB5Z3lTZNlQ2tpU0KEP/HYTykjJbQQmR8vUK5
 88+6RWe9A9VEoH2xUyF1Yj9Vu82pa4kKO040D63q5SMAmr/BKvjWfY1P4Pt4UyLTXFpJ
 iiM3WwsAmxH07SsvmzNiQML8+J99Jj5KC8BnysFxAkU40VrT5e6Zhe2L4Bq4Qgs1mYhK
 EKWTvBfXBkD0+5b689LddekpHiMimBpNLYa4ChAofl3H6m55Pl1JgetQ794mb/awBiD9
 CyOl3Fa8tXlHsSTDJiFyvDc16fo4I6xohPVXg9G76XOLKHy1sbbHtmDG409e4L+1Ayu9
 UcPQ==
X-Gm-Message-State: AOJu0Yz4uwk/OK6+VgLB3DIyN3iDA3qpiLeiu822J+6+3Qm7gTu3uJGB
 SQLPmRTou/W4HoINii0WZpjBAFEgwgJAGIpKTnquBUa+fjM5l+MDFgJS7V86H1w=
X-Google-Smtp-Source: AGHT+IE/AQSVYkTl4Lb/a+3jVKAn/O1AJI7WeVMwiK0COvDYzHv7GTd/fHikZsaX8HAtY8DnPYWEMA==
X-Received: by 2002:a05:6a00:2d0c:b0:6ec:fd67:a27e with SMTP id
 d2e1a72fcca58-6f6d608dffemr5205397b3a.1.1716477053398; 
 Thu, 23 May 2024 08:10:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a6669dsm24157904b3a.31.2024.05.23.08.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 08:10:53 -0700 (PDT)
Message-ID: <ccb60042-538a-4705-b892-db11a8495eaf@linaro.org>
Date: Thu, 23 May 2024 08:10:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Move VSX logical instructions to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240523094821.124014-1-rathc@linux.ibm.com>
 <20240523094821.124014-4-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523094821.124014-4-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/23/24 02:48, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 
> 	xxl{and, andc, or, orc, nor, xor, nand, eqv}	: XX3-form
> 
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode            | 11 ++++++++
>   target/ppc/translate/vsx-impl.c.inc | 39 +++++++++++++----------------
>   target/ppc/translate/vsx-ops.c.inc  | 11 --------
>   3 files changed, 29 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

