Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E26C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9Bg-0001dj-2j; Fri, 26 Jun 2026 12:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd9Be-0001dV-2X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:13:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd9Ba-00076P-IN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:13:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c7ee3952ebso13552575ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782490425; x=1783095225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OWb7ZWSigkdyEnRF8EA+HYl276Ulv37LI21VxOIaFXE=;
 b=bH9hcTHNB+T8X5z0wGv/9Li6QWvZoapVuskm6f+8hpjtSsGc7olfe+Z5ZkGgRGBroF
 rCVL4WCvoo6POSxYpoIjiHQ6yC1+X3mHJYeMeMmHV43JAUBk8ZS8hTVs9vcSjis0vVjr
 ieP3KL+Jyg+pu/zu26Ze1HuSiaK10+nwt13O6MvrhMjy5Lz34zrGMJxVKEW2HYG8lFiJ
 NTQm/S4dYrQYsAm6F7u/AISUwSgNbYOxKuT6VmGQe4JiSJaHmCJo0M6XtdRmF9JzxE4u
 k54/VITNcB/9w4lcMZTlOfx9Huh8yLTuzzVgNP9Wn646hWkZAFX5OrofBmckyp4jCyfC
 lwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782490425; x=1783095225;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWb7ZWSigkdyEnRF8EA+HYl276Ulv37LI21VxOIaFXE=;
 b=F1UqcBvUzuIe4mHMAxCM2ZwSgIhoi5hVXN1pBDjDV1wvi61y6B271oI8tO4GYfE/X4
 vsH8vRAO/hiLJxkVDPPjD1BhEv6CTEAi/JQOevLMDml1S7ZHJy/t4N1PLYLV8y4p4nGt
 Vwzi+uhQcPUgbi/rGPyNmxrqAGA8w/V0/ip4McQOGaq3QhjBv+dswUsq9/MKWtSG0ibu
 MTeWbKrdTqjc/srPVcu9OrpuxjWfC4rnAC8zH2yfoaANR9JPCWNT5jU9C9Oa3e7WCUWe
 TE0jOOyF4eBMA8/KAKRyR4S+UNm4B/xsZ5JFKltFwRCSPT1t9Xc1B0NX0JRb/NSgM+oV
 PS9Q==
X-Gm-Message-State: AOJu0YzQ/3KLOkB8ORKwEmCfWQAv+Gx0GAW9SSAVhCO34k9o1PxNKfyd
 w+EPA++AZPGCOsrv738G1MsJw1wHCe9remonWN8Ur3nGnd0CI2lBa9cNnk8BFOnIlMP8N5rMZMC
 ditLF
X-Gm-Gg: AfdE7cluxcKd6nGxWqaOIRpWQnA7VB/HU54dvdDYesfJWIBVVTH/rKkLnl1eh9hcZBG
 AG2pfvg2ANhNfO6AaHytJe+p1C9ijZrca0tcOmiuvVwpUPkMy5ee+bC0Z1nTvhCYveiu22u4Xri
 g1GCkJCRBO5EOQrZKC/p3SNVDo+8vsK7rz4RpVxDraj9Ig5pcrjKbhpK1nt/Lh5nAhWhGrmO9Zf
 iKrUEVhRHUUYth0QZAyWlJUwxUETPSJlupGri6J11c+013mnAa5BDnDg7TCg62xF0ft8HEW+5Ph
 J11VpLXqGWCfodb68aEP4t+VzaRGDWRoMRjrRzT/nOJGwQv1+0UvMTHUUu7kPPWp0hP4NUbL7vI
 plNDSiVB3yB1isWTgcnAwSN8sWHet0kl/rL/aPF9Df/YjUjUFZikAS+KwVk6/nY7Wsnn1Y7Awf0
 21uKpTgQ/H5cXl3TOIRQJbAo8fc0IRJ11CSmnAgUQkgHE5sNn82eQZ2TnGuA==
X-Received: by 2002:a17:903:2ac4:b0:2c6:ad70:d870 with SMTP id
 d9443c01a7336-2c7fc6b9535mr79420115ad.13.1782490424674; 
 Fri, 26 Jun 2026 09:13:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c92ddca789sm6812695ad.12.2026.06.26.09.13.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 09:13:44 -0700 (PDT)
Message-ID: <f7e3a655-5b83-44d1-9f3a-7f86bfb7e50c@linaro.org>
Date: Fri, 26 Jun 2026 09:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: fix 68040 TLB permissions for clean pages
To: qemu-devel@nongnu.org
References: <20260626144155.2207356-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260626144155.2207356-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/26/26 07:41, Laurent Vivier wrote:
> +    if (!writeprot && (next & M68K_DESC_MODIFIED)) {
> +        *prot |= PAGE_WRITE;
> +    }
> +

Surely easier to clear PAGE_WRITE as we're currently doing than introduce a separate 
writeprot variable.

Don't you also need to sink the existing test against store?  E.g.

     if ((next & M68K_DESC_WRITEPROT) || !(next & M68K_DESC_MODIFIED)) {
         *prot &= ~PAGE_WRITE;
     }
     if ((access_type & ACCESS_STORE) && !(*prot & PAGE_WRITE)) {
         return -1;
     }

Unrelated to MODIFIED, but elsewhere in this function:

(1) I believe the PAGE_EXEC handling is incorrect.  It shouldn't just be set when 
ACCESS_CODE, but set always.

(2) The dirty/used bit update should be rewritten to be atomic, now that we have MTTCG. 
There are a couple of different approaches between {arm, i386} and {riscv, loongarch}.


r~

