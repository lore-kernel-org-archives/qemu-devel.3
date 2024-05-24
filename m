Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50C0C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVvB-00030x-8s; Fri, 24 May 2024 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVv9-000302-7I
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:29:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVv6-0002fU-2p
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:29:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f850ff30c0so1543189b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716560958; x=1717165758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HuGddQJlkhpizXDYOD2bAJ2Jv7ts0+4RYbulBaQDtBk=;
 b=aE/OG56eP3FDSYSgauD+HQx37EoEFIifwBReo1hHKeIiaavc/oiAT1bQJmxowWwKHY
 2LcqttkJEi3ffwoGJVTsNR95fArBsxK8mwkbNkaVlU7LhlOMuNdtZr2tgCz36kquatqG
 +0gbOdhk74WtRa8iZx3T2MiFfMpaPlA+XtTgeLjjZKIQo2o/46Ze7QBNEdzVlrMwnJ3V
 Ecf3MWLyfStKc/PMRwFuV1S5+7toGHR0bQRDq0StfLL0kATLZhS9P6kbWEoL+PEMHm6A
 zH3Qm8wEwpl9/3WZaIV1leJsq+9UslcnZGynRUgldXoM41CwYbTicpPNATup8lzDmnzW
 Hqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560958; x=1717165758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HuGddQJlkhpizXDYOD2bAJ2Jv7ts0+4RYbulBaQDtBk=;
 b=bF6UsYL7qHdgu1QvK8rjaUOhzG3xw8rbtByR5X0C6g/tCNNZhbnEC7hsiN+PZOFXM3
 pEgG4eBVHvrbXeUGp7SZetnoxxz2GR7hTH30X64n221wB80jDk+SFtjiVLJT0pro2KIS
 9mRGGLwKvt0uhfZ2Cai/EeXsT44+fDCHUWvuuUTGJEvWgzPt2rSHwOKP5hygCPEeFCFP
 tKW8b84kwscVUzSJm+38EZioPHdKhxSpcHa/focYrJ8crW0MGqtTOEtQU7j24OU1Hwj1
 WD5dmdmp1xXlW7h8WXJQVE7/nWSPEJnOA98O2A3ooJfsIxOLg/cM5ByZvXLBajszNQ0M
 i5eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSaUPfz2KVXFUQsAa/ofb/AigSsqwNePiOrh5lRVGad5K4m6zO8TPy0Uj4palrX8BSMu508mKVKc6HYk305DhO1VRMzPE=
X-Gm-Message-State: AOJu0Yz5c/C3j4sLnyXCC/gJQye+nB4vBAp8C6yDqyDfT0cOKO5aujHA
 NjjQEbW+0Bv7iEgjFcnOS8MOvq0cYoLVwQOZARfaBc5l0RPWr/I/uh8WIwlw5io=
X-Google-Smtp-Source: AGHT+IE6lIS+AN7y8JNfnxPaTKdY+MbhPtv50jkPnqAmQiTnUtGRkc5ofVMxA75mAoNJPu8J4hHkGA==
X-Received: by 2002:a05:6a00:4405:b0:6f8:e1c0:472f with SMTP id
 d2e1a72fcca58-6f8f2e7e15fmr2805038b3a.8.1716560958385; 
 Fri, 24 May 2024 07:29:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe6672sm1169502b3a.154.2024.05.24.07.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:29:18 -0700 (PDT)
Message-ID: <ff8e04aa-9e2c-400f-9168-b531309ed779@linaro.org>
Date: Fri, 24 May 2024 07:29:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] target/i386: avoid calling gen_eob_inhibit_irq
 before tb_stop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> sti only has one exit, so it does not need to generate the
> end-of-translation code inline.  It can be deferred to tb_stop.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 13 -------------
>   target/i386/tcg/emit.c.inc  |  4 +---
>   2 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

