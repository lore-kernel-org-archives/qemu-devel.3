Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46848C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPiV-0003xN-B4; Tue, 23 Jan 2024 17:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPiQ-0003wg-7u
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:57:58 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPiO-0005mn-4Y
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:57:57 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so749690a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050674; x=1706655474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VfX7PvtuU6sQswDMBJTfdwXYAVMGdKVCo6D8KO1tzaY=;
 b=KNWELlTSaNL1EPbvxO2o2iDi0il2A/3R7+e2kSRjmwJAOZs6b7cRKSFUpjP1hX7BH2
 EMcspCnw0ryf25Wxa4pfDHKXytyv+EhDWK+Oi2Rdo4ibwK41pZIDJhBuprOBFh8V+Xxq
 PxGlFD5aj2aTyPtylWuk+oSHva/8L7Zt8yrYLSiYfqejkpXBm1CoNsG08sLVBPP0GlGz
 dAlzCYirPk0d0JDC54Rm/Sj2upkcIoMDeCdHZ0pemwJOd+S1GyZnjbzWPeeZQSFZgHw+
 LgEq5Kgp8Bf3BQOgjZvkzXwsS/d9NYPQxp4nn1eLl8CU6JAibUTJ4/9F9/HHzvlyZaPS
 HxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050674; x=1706655474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfX7PvtuU6sQswDMBJTfdwXYAVMGdKVCo6D8KO1tzaY=;
 b=gQc+PffWyMFRr3bfXET8KbvF0oJ+JGeL35qLuXBWL2qe3RvCsnLMouLmd7M8PpP7aZ
 m7+ObehBQIs59ylAHTfR0m4wNfqxYvX499yPbOxuNkcMShtwXI1uEuErJjDvgPVx6/qY
 ee5psQ27AO/kjCYF/WXRYDOyneBMgchwqWg0LbwW2EIpJqJGd6h2vHLwOMPxpvWpwF23
 9bw97s/fvNWN18+x8ycRv8Bc2ZSJ5/IQ18/FUVZ6cTwcgxKJLiqiAr6AZW5kAXrcB6Gy
 16fdioPsz/3vP3czUpXmPQ1Pm42XbXB6inz1Pl71EZxgNviKku1nzoxBwstRq59VIHR5
 mozg==
X-Gm-Message-State: AOJu0Yw/mjoNFaYjJlaYWVWcdK2vYGKy7wgkImDcBMIwWnoQpxqywdON
 vvIOoUHWh6nfiSmJoN2CvR173OUFGeYd7Pw80+X79gDOiEzZ1y5SUtoTpVmvpbg=
X-Google-Smtp-Source: AGHT+IH2vOFRq7Azv5/rQpBoKw9EiodqZ0VT/5zsRJ9MigImYkU2s2QVFATkPT05UeytgGgaXBrtow==
X-Received: by 2002:a05:6a20:158f:b0:19a:f1bb:5b1 with SMTP id
 h15-20020a056a20158f00b0019af1bb05b1mr3689440pzj.96.1706050674579; 
 Tue, 23 Jan 2024 14:57:54 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a056a00191100b006d977f70cd5sm12184674pfi.23.2024.01.23.14.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 14:57:53 -0800 (PST)
Message-ID: <dd125003-24a5-4fac-a9aa-e0dcfaeda9bf@linaro.org>
Date: Wed, 24 Jan 2024 08:57:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/34] hw/core: [VADDR] Include vaddr.h from cpu.h
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-8-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-8-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> cpu-common.h is only needed for vaddr
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

