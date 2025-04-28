Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE5C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WAv-0007Bc-BB; Mon, 28 Apr 2025 17:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WAt-00079V-H4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:38:03 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WAr-0004LS-RZ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:38:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3085f827538so7291320a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876280; x=1746481080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bv9s0XU0fSrF7wKrJOhCZJYZ1A5rRkecsR7oyH+hF78=;
 b=Rydfykaaf92v0NmLn/55n209VlG1U2nmclCTvC/Lr+BevwXNLfXUZrZ8spH2LdzAmo
 VH+6VOncqAbFRGhaKO6EzjE0ErujPb34BUi94bNwj+FhZzRCrr9JpHdSMPHIDCAW3Fyt
 ZeCp+8heB0ne0Kz1ACzA8x9lgFmyqvodxA87ruvJjzV1q26eEedxzgMGJhWFo2CuCfDp
 i2s2a2+UxMTQqxMwIFtblSCk/SWsol3Ph5s5fxDHuxmyZ4KOcFP58roXFPFa1EW+s7QI
 GxHKv4TMU684MX6zXqlbbjBOMdW0q7bn1eWJYFn4GDQKcwjokQSTmTkZyVdQQEXBNfyS
 HTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876280; x=1746481080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bv9s0XU0fSrF7wKrJOhCZJYZ1A5rRkecsR7oyH+hF78=;
 b=g0MvOm+w1k0pqMOsybsoU4htwrZtVvKJXfiRINyDyp9pc39rtlRcMRxiLsgTJrmfSJ
 hcdCkrQzinVIPK13HJqJeOpaIvAvY+P04Ev4fdMIvKgsBSA5fILddXyuDlCL47A0QWfA
 0/AIPX6Q858GwGaybEP56lOJvGyNa8dFSzh3dTx7qmVTf52Xn4jWROBdYs3zxT0US1TV
 +/Cs5StGqRajUeE6racgSbf/9oaHddwkjtqoHcWZFpfHjRvCNnpvChzRZuwwajGLjULU
 nZZVkU0dXokgpC6MmqtAgojyQz1utmGSsewNkrVEfxNRZIlkB5C01tkm8Lm7hEc7s/4d
 2nGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbvlhXfo+xTMaY2OYQFxi0LYiTN1K+rJngkWQEe1eOvBmyCY1ARfp8upC8/urJbw1pXc4SD85qUSI7@nongnu.org
X-Gm-Message-State: AOJu0Yw5hMzEqnIcy8vdTgKVpxKsGx3q/yqkECn4Mrkw8oDsNWCPNj7P
 u5NE6Q5qeu9oT/X1+vrOqQpRo7csNc4hiyfxDMm9yspZUb4TVZkrBv/Pl/EfZPQ=
X-Gm-Gg: ASbGncuqQYrYZuy7TEifPBBioPTuJWjynwELFLrU1YimZn1h8HuLFkm5jxDRhLWdr2q
 NNeUj3ZDpM6C72VAFeQZJ5RRkt2umdQ93I53UCFJlp+bUguuVh1W6Rhb+mtKE88fVlvIkKdltFj
 UCo257bR7IDLUuqCp5tNFkAGj1Uj7eWe4RRz52WDT+hjxu921QEmle+FqQljUQlzyU3uDDofu6H
 fHxuXGTZh0vFAKtm5o4MNqR/Y2BLDopKWvsVB9FrixVJzAPhV8DEZpTkMRV3Czkx8r/U2PhKbF0
 /qvCxaNmThviSFvhBeNC5lX2Fpzjk55Kt+tKzFQ3zf3/GgZenZjQVCPp/dzwoq0O
X-Google-Smtp-Source: AGHT+IFprCabT1RSIMWAdYrCNwaONRs9IzSAIvFJsNK5Ck+XS048pTUPkM9ypLSANCemPsW2Tnj68A==
X-Received: by 2002:a17:90b:278d:b0:2ff:6608:78cd with SMTP id
 98e67ed59e1d1-30a013279d6mr17242856a91.9.1745876280174; 
 Mon, 28 Apr 2025 14:38:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76c8bsm88323805ad.48.2025.04.28.14.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:37:59 -0700 (PDT)
Message-ID: <bb706ddf-ae69-4ddd-a6f4-67f7c993c355@linaro.org>
Date: Mon, 28 Apr 2025 14:37:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] accel/tcg: Unconditionally use CPU_DUMP_CCOP in
 log_cpu_exec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> This flag is only tested by target/i386, so including this
> makes no functional change.  This is similar to other places
> like cpu-target.c which use CPU_DUMP_CCOP unconditionally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> We could just as easily remove CPU_DUMP_CCOP entirely, and let
> target/i386 dump CCOP along with general regs like other targets.
> ---
>   accel/tcg/cpu-exec.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


