Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47447C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIVi-0001p6-FH; Mon, 03 Jun 2024 20:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEIVg-0001od-KC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:58:44 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEIVf-0006NO-6W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:58:44 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6aebdea932aso17702446d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717462721; x=1718067521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vh7xajWIzJcjEBubxVNtUm3KBGkSzVrBLiILMOlErNw=;
 b=AcuzsjwhUMqbDYvH+yLCk3Wg6ZwCauee5aKnL40FWPDUS/FldrXOdfjsCdGlqWOfTi
 tSLRE6NGPLcap6mczCon5YU8IaOzXQ/zVgbaIgeVTXCGV3N/yKE3WMlYUSrGvwU6Ko3u
 QgfMnyldfpUNXxvs2XHgOh/O83rYcjmzQZ/SWZ6hc2SSDSYOgen5X9DYx7p4BJM9rvGE
 2Iryl1oTZMttfbZi42a9ALXSL/Qcrp0c1z2WOLM1n9jROVtXx6hj5+TTeAdsbgkknSQM
 q1W9sbnECXOUA9XKUrSEPK4jBh8Fc13D9mcURnprjVQDPAm159tgBoHLM/qTj88hZgTV
 Mn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717462721; x=1718067521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh7xajWIzJcjEBubxVNtUm3KBGkSzVrBLiILMOlErNw=;
 b=G0Tit8NNDX4LO4PExQLMT9A3UpSnvc7bOUCp7YZ+kT5tf1YYxVrsYVohXmOzuBvR//
 N/OFbk4rLSFUO8XGZGaZRpDtjmjQgrVo1An/Wp9s0/v5hK2fraxRjutzst1Me+9jT1Iy
 Az7D1/3NFtGJvlTbKL2LvmTVoTyhk3uYPnCLOmTH2xC25Nwi2rVDHz9G0Xuec0BwTqbA
 Mm38IY4ncEAM6fbe3pi1HqskQQqTIjHSapD0PrAJZVJTbepuJs0ExSRiY0QBfeFP1Non
 pea/CnkoYIp35sWeB7OFepekIscJEeiNFTn6i0JVKLo6LMszgZOAU+t5bE0RsSYGs/Q0
 8u4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNXQ6Dj3dhyyx70FrVuH7jTkCUj9qXI/6KREDXa5H8vq6xWvU5CRPV9oC1I0KAzwvBxhK9JFeqjEpK/itOQUrkuGI8ESE=
X-Gm-Message-State: AOJu0Yx9mI5NCmgF46gAoBBV5k73rnzgNJtBXH8MtubJqlN2JLSo99Yj
 o544tbYFzVeng1HcZ7dhlT0pd5oTIHuJoGyknabS2uDZ1M9a4KkKkpa5OZA5JpQ=
X-Google-Smtp-Source: AGHT+IGmVJBejy4nHB879aK5sGFMhG/ZhjQ/DxduC8RM3rMqWyy7Mk11b3cNgfibAL0ku1pk+fgIOw==
X-Received: by 2002:a05:6214:3911:b0:6ad:79e7:fe43 with SMTP id
 6a1803df08f44-6aecd6fff08mr105722866d6.55.1717462721614; 
 Mon, 03 Jun 2024 17:58:41 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6af3d644efbsm23646676d6.19.2024.06.03.17.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 17:58:41 -0700 (PDT)
Message-ID: <aa04be33-02fe-4f80-84b7-fd463bf150a4@linaro.org>
Date: Mon, 3 Jun 2024 19:58:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/6] target/riscv: rvv: Optimize v[l|s]e8.v with
 limitations
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240531174504.281461-1-max.chou@sifive.com>
 <20240531174504.281461-6-max.chou@sifive.com>
 <1016c817-d1e0-4dbd-8fd9-921bcdc23a0a@linaro.org>
 <595c3be7-7a33-4812-a80c-975b2eaaf5a6@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <595c3be7-7a33-4812-a80c-975b2eaaf5a6@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 10:50, Max Chou wrote:
> Hi Richart,
> 
> Thank you for your feedback.
> This version is created by referencing the gen_sve_ldr translation function with the 
> similar assumptions that no mask(predication)/no tail agnostic/continuous load & store.

Except that gen_sve_ldr has a compile-time constant for the vector length, which is always 
a multiple of 16, and so has no extra special cases like you needed.


r~

