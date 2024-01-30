Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39EAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkp8-0007a4-52; Tue, 30 Jan 2024 04:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUkp6-0007Zw-VV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:54:32 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUkp5-0001Pf-5O
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:54:32 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29065efa06fso2935174a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706608470; x=1707213270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3LA7pKjS+cqivPRFbLc9stKhMVxea41zBFI4U/QlJY=;
 b=sYgy9k7WVmyZNUK+fXH6snnuKtkf1q7pCV/1ZJpyuUyQxYb3nFpHhK12ivhqiaPbqj
 bg37LWAUxQ8BXdlZM2i+2osmzMt3JC6IDrU8MSiOEMJLFgyJPqItUVR6pWqIjFTToBxu
 tCYZug7FHhDLr+jxv0Gdugwf1SLK+UW4Wgrrso2LPRLrBMQtY4WombnVyBlwJxKBec9D
 EYaBvvyYwAopGY5VexTG3EroJMakLy8L4kFdAOgd6+kKEbb/ooB80ZVVppzW2idxlVZl
 Gvk4i3kNrUcNfnH+yHLfRTtfDJb531aA07mCmlryjWJ/eWlvJkzLiQLS3CsddVI/r54I
 30Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706608470; x=1707213270;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3LA7pKjS+cqivPRFbLc9stKhMVxea41zBFI4U/QlJY=;
 b=XjUUTF3kuEglV520t9tguXxbAzU+2Yw9Ns//rzcr9VVB0B3kbzVYF79XoaZSXld8Se
 xtHyF//Y0vZS6aqBrrJMAQvsFzfqiac8gTEQ10c71Aux62wwAXNIzRMdGH1/nfcJPrOd
 mWVtY795PIm36r71ZKOTNZMRnKszohDbwav6tfByGGvT2ojfTHx0FdMQOmh9hiIHglot
 O9r26U2SrmOhj3W6+bNxDI3bfA/k+oqYion0c3jKgCzHJojsy7QawykggV38w40QFqIz
 W3b8JNawVRJOADyRG7IinAxujkhNpUDMs/Ly8Q7Wz1IkDBc1qSJKa4Rqb3DzVbxmHYpc
 sNRg==
X-Gm-Message-State: AOJu0YxRZjaBxZwowTHuhQ8+HRfB9Sa/OHs3Tq7lMsg9d03yJDvCKK01
 OdvCqyOGyb+O5ugfaQM8K+wUPN/4bZ7Ozz3WUt9HhhmtfrgRln/R5KBDjdGEfD4=
X-Google-Smtp-Source: AGHT+IFrRFQQnDvtOazpmEIr7KYcxPXn1OOYBtjCJAqxhG/7+eoe1CjB1P0zN/RNXFMpUL3rLnsCzg==
X-Received: by 2002:a17:90a:ec0e:b0:28c:8eaa:e5e3 with SMTP id
 l14-20020a17090aec0e00b0028c8eaae5e3mr5208885pjy.17.1706608469797; 
 Tue, 30 Jan 2024 01:54:29 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a17090add8500b0028dfdfc9a8esm9900799pjv.37.2024.01.30.01.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 01:54:29 -0800 (PST)
Message-ID: <2aaad4fa-4520-417c-adbf-142c3cc8d403@linaro.org>
Date: Tue, 30 Jan 2024 19:54:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/29] target: Replace CPU_GET_CLASS(cpu -> obj) in
 cpu_reset_hold() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129164514.73104-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/30/24 02:44, Philippe Mathieu-Daudé wrote:
> Since CPU() macro is a simple cast, the following are equivalent:
> 
>    Object *obj;
>    CPUState *cs = CPU(obj)
> 
> In order to ease static analysis when running
> scripts/coccinelle/cpu_env.cocci from the previous commit,
> replace:
> 
>   - CPU_GET_CLASS(cpu);
>   + CPU_GET_CLASS(obj);
> 
> Most code use the 'cs' variable name for CPUState handle.
> Replace few 's' -> 'cs' to unify cpu_reset_hold() style.
> 
> No logical change in this patch.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

