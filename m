Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3547CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWbd-0004L9-PL; Tue, 20 Feb 2024 15:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWbb-0004KQ-WC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:20:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWbZ-0008A4-Gi
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:20:43 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so6136625ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708460440; x=1709065240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2M4AE9RRM/4QZV2UnhK85XWsVUnSs8vSGDt8cUvjfMI=;
 b=GZqErP8Fyzz4jQSKNQxtDLhtPe0gIdlRbsuKprtqOxxg/hUjNKwToBQqs4np0MJxft
 KLFeS92/25CJVa76j545RP9/Ne3G1SZnu0HvWS9hzN340ZsFkxDB2lNo0RMyyxxwQ3zT
 ryuKZukVzB8je8huXUehVQze1OgSN94jugYnFuvAzTPWkRGYJaC7zdsdpRm/3jezU3Ot
 gGXdDIEzQoKsNRcixFTP3UYvMab/X87n2yIDOSyaNmqxYCBV+NT/0LrpH3HWDXGk6VkJ
 0MLWiv36hovCc8qkilTSNdU72a3UKyeS68mcwUl5GB1IlL7lZeTUVmBw+ospPiyacUPE
 vG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708460440; x=1709065240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2M4AE9RRM/4QZV2UnhK85XWsVUnSs8vSGDt8cUvjfMI=;
 b=VtGzcXnSSFs64Gw/zIcD6LGqrKyUoE3yASH3CtuCKhyd2qmT/Tt8ZV88LFBy15jKfp
 /U2xjXhTMCccrWGy4IpveE98BzvgaIvUx6Kk+cXsRwirdFeHG2PQUi49QN6nqajWHLlD
 Toh4FbKHdZzbr+EuJlW16E1LQkbRwDEXcQkoXuIeVkYZ7aNqfm+lp2Tvw4qPWa/Mtv4S
 vgqPgVaz0Bx1VP5R7Balzf3c1qp2IahChRu1/CQ+VorBGDGu1BlpikHWsES4CawjZe1y
 uf+vRZrxHY2qLHXPILh7ErdaGCzPwlgPEonWGz4Clsl4IU6IE6+UC0BpKwj8B/qYkCOL
 YhLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9+c4o5gxffDG0ewe+FuTU0iEbpgFY7mQHDpYaV7jWdPaeay5vyxgYKN+D4u59L50p9BJRvWMWnZBGPzvoBQD3n+DLAaM=
X-Gm-Message-State: AOJu0Ywdg0ItEhbf8A6c06DjBcf3ocE0CjmSzEL81iK1fHKh+zAClMHw
 QL78Z8naYUmMPaRIgfQYpo+wFT5FLFFv2HNtSMO7hn7KqRSUHQPpADDb8LeWaKU=
X-Google-Smtp-Source: AGHT+IGxmQtgXYsVLEWVSWkPZL3iTSDkW20jQbgGnvQfMiV9KJ5iZBsuEgxKv+z3OSBExFO7Iw9cYw==
X-Received: by 2002:a17:903:2342:b0:1db:d9ed:f91d with SMTP id
 c2-20020a170903234200b001dbd9edf91dmr10130564plh.33.1708460440074; 
 Tue, 20 Feb 2024 12:20:40 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001db45b65e13sm6580544plk.279.2024.02.20.12.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:20:39 -0800 (PST)
Message-ID: <b7562627-6843-4f51-9726-d0d062d34c30@linaro.org>
Date: Tue, 20 Feb 2024 10:20:37 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] trans_rvv.c.inc: remove redundant mark_vs_dirty()
 calls
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
 <20240220192607.141880-5-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220192607.141880-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/20/24 09:26, Daniel Henrique Barboza wrote:
> trans_vmv_v_i , trans_vfmv_v_f and the trans_##NAME macro from
> GEN_VMV_WHOLE_TRANS() are calling mark_vs_dirty() in both branches of
> their 'ifs'. conditionals.
> 
> Call it just once in the end like other functions are doing.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

