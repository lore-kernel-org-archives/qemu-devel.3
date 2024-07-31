Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF45C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyUQ-0008Ca-OZ; Tue, 30 Jul 2024 21:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyUA-00088F-0h
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:50:44 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyU5-0001Ee-IS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:50:36 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7093ba310b0so1784365a34.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722390629; x=1722995429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J2UKc7cPTRStt86upDx05EExx+NbvE56LXjqhdeA9QM=;
 b=Z8MDzUbfT43yzQp1FzUMvY6oSF4buxUAX721r4LpRta2IqeOcVucmG6nVS43oTRHF9
 zKoaF89ZZuzZJv3WtMHv6jLgjMfduHgu8/hVs5aYEu0232kmdnS7AEiGeqU3Fzs1m3cl
 TnKzRJXO7hWrzIonNREIcjA54u/lm5W+0Caykrr6BsUODUOII/hLvIIVcPERzPII7Bux
 T9D2VA8dipWFJFaqbIsn+Blgpnvv4kNIFmsUSN022oyH9CmCifVewk80l4LDaoEQYU8q
 GUbXgB1Jzl//I0OjxSECB1Efco9TsURYbxi2x29M5sGfvAYYfuUiganPSUshhp33zxo1
 74Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390629; x=1722995429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J2UKc7cPTRStt86upDx05EExx+NbvE56LXjqhdeA9QM=;
 b=LsH+bgUBPVWjK85rCouqa3sYtEuCy/rQTUhjzWQpPrbSXi9M4Jw4sZsCtkpFghKL2F
 JIBeMxIl9owEg0Acasi8lDFG5ho7gOidS1rkoyvciIQCULgtMgQ7+XD+naNUDw5+IL5q
 7CQIEFw1X3XpsXh1lNrOsU8R6I45YYJTGjFdvW7jbfkicnuKUsK0yXgFWIb0nQQBv69j
 PCpRiBSvsmaYxqhIIiM6eRlGTjhjzBjXRXGyDF66jWHN7Dn5MBI/gVRpwHu7kq25M+bY
 /wNI5jYG+clRxSYHNDKcx3tajGY8Jf79qu86NjYM+Tsejb69LRgXyGQdaFngynmzdISy
 e1uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWknpbNUSOOk+31nPU6VsP3Mawh/l7jEreGeg22FDM4F+/IGlE1GKLnPpIAuDUES6X9eP10Bj2wvpTuqSRkFk+OqyXjrFg=
X-Gm-Message-State: AOJu0YxQ15bghzs0MfkxLOtg9EVLXAlo2Nn0bWxskN7hFE+MYd0aMKbV
 vZpKO2xnI7r8kdbXcRPYn0eNKUMvcYNQp1F0cEjgraDR7Y4YDLNOKijrCKgYTCQrKsgxnYa9noI
 egvI=
X-Google-Smtp-Source: AGHT+IGMn+HjSq1QcDtwBTKJLbMc2el8xGAh1jaBVwR1iV6jo3Bjr2caEQRG8/AfIULSMCwpPqhBSA==
X-Received: by 2002:a05:6830:6307:b0:709:449c:61d8 with SMTP id
 46e09a7af769-709449c6512mr16642865a34.6.1722390628901; 
 Tue, 30 Jul 2024 18:50:28 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead812895sm9060652b3a.102.2024.07.30.18.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:50:28 -0700 (PDT)
Message-ID: <f72574e7-478b-42e9-b3dc-e3d3d0e73f90@linaro.org>
Date: Wed, 31 Jul 2024 11:50:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/arm: Implement FPCR.EBF=1 semantics for
 bfdotadd()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> Implement the FPCR.EBF=1 semantics for bfdotadd() operations:
>   * is_ebf() sets up fpst and fpst_odd
>   * bfdotadd_ebf() implements the fused paired-multiply-and-add
>     operation that we need
> 
> The paired-multiply-and-add is similar to f16_dotadd() and
> we use the same trick here as in that function, but the inputs
> here are bfloat16 rather than float16.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 57 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 54 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

