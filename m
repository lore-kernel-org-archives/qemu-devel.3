Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92250CEE33F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 18:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sybpR-00037b-UL; Wed, 09 Oct 2024 14:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sybpP-00037M-Jf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:54:32 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sybpO-0003cx-0V
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:54:31 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo913387a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728500068; x=1729104868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OFEaE4S1IxaKlQiwenlhU49ny6vxqkanSjo3SHxYGFk=;
 b=LGoTF2vmaDA81qSGT+MklmuQ/EpT8YH5OR0hTSBTWzEZFaL+QmTvuln+Qah+A+nf6C
 is/xBR88dVzugUdP/+8vbK8Yri1llJuS+CND6zgShKmxsPcfxo/aPcMotIqKsyIXObSj
 X7DjMN1jAdWbMYTq/k7LXnojjxOPMdKF1DxQpZAwQdMoKFRI3j6GO2A47O/QU2ucLbcK
 LkimDALC+msEU73xUVCV1HbyR27fdkJXwwSLXfV/YiPYfVFnXOlnbRqoz45IXv2EiNwz
 45hEwxaK+yg60ddNR9Phhos2JwAkvoc+KRhKRs6dRfu9D8Fui6Dw8ufMHpvwVenhP3qR
 OQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728500068; x=1729104868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OFEaE4S1IxaKlQiwenlhU49ny6vxqkanSjo3SHxYGFk=;
 b=pIToESzQkEPivxUNkIhPtCNsDqVdVjMAPOKnuRzB6KSij3k2mtRIon87p+FC5J+OVE
 GLz8Zsjb6RksVkWqNHXiVlfPorwLC66m8b6mg7EbPdqxjf1/pEJetLPrNzWft8HWcgvQ
 Kb21wbcOanLiolvUqeAp/1zXVPuBjOjJbZoWSDacAEvxVJteWIaBRVNC+aZMfPK6vNIv
 NNFbL+QpWdQYM7PAdFAmQYnm1L8FHd9RnzhH/0Y6olAXqFqd3Z+FMcqF5jU4nleo2oWe
 TQVq944be5AJAJ/4Lg80c9aYRTmvRRG/zljP1p5fJGStdX7RD+4ai3yYt1aeJdI647wS
 q+Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/o3s1TvzLiQf1n+SRAYJDs9oDMbYIM5WiP0LM3KdB67xcdieVl1A3velVMBPsFvmsLeJ+OHC9inYs@nongnu.org
X-Gm-Message-State: AOJu0YyEPqXM4MGWv3fAzorYxopwYRsoyRyq7BchroeOAVO3Fiu5Squm
 IST4M7iibsDMvEY3wzKNXeBN8Q4NMD34u3skzVyaw5CrsrvwHnrpQ2PDBiSXbiw=
X-Google-Smtp-Source: AGHT+IFjzBljycyvxueoWlpWNT8EL7mYL8Ds0Rd2YHkIbSASvfBvUg8twB9n6BW4MnVDnt4G6vfT4w==
X-Received: by 2002:a17:903:1c9:b0:20b:9df1:54d5 with SMTP id
 d9443c01a7336-20c80531f49mr8023955ad.29.1728500068190; 
 Wed, 09 Oct 2024 11:54:28 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c728d8addsm11845655ad.103.2024.10.09.11.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 11:54:26 -0700 (PDT)
Message-ID: <72370736-8fea-4f45-888b-c6f36445df09@linaro.org>
Date: Wed, 9 Oct 2024 15:54:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] accel/tcg: Split out tlbfast_flush_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241009150855.804605-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x530.google.com
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

On 9/10/24 12:08, Richard Henderson wrote:
> We will have a need to flush only the "fast" portion
> of the tlb, allowing re-fill from the "full" portion.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


