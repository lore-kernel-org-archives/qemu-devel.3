Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB79CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 22:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQBkH-0002ey-Dh; Thu, 21 May 2026 18:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQBkC-0002ea-CP
 for qemu-devel@nongnu.org; Thu, 21 May 2026 18:19:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQBkA-0002jn-Ri
 for qemu-devel@nongnu.org; Thu, 21 May 2026 18:19:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3699cdeec05so2694852a91.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779401992; x=1780006792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DLknPmJPpJhnxcU5NLKQTN4jNRipVpMT88HAQLY06B8=;
 b=D3vls4uy1xOg5Iva9Ywog4/z3TNn+VTPr4+bxp9CZtmelR95AakjIlY5FCrydTMbf1
 nf0DJfN+xUHQAeg7bJbtCpiu0axtHUwFqwoySKvsKhRut2eb0qyGIKQl3j2zzZ2/t5s+
 tJsJ+B1yZsyvWMbQtePZYqBiCO1TeafrGjhR6wwFLs0u410bIJMYIuZsNew5rG6brSW6
 lJ7Ue2N3Uwrc2Bon3GfAP8jSiIqEnFFkyCEc/EgNTO2AhU7tQPU7e0DuLfG9MZlEh4a6
 Rpf9ME+TPkR7ii0si94XXw+BDJreGBFprjzEioAlmwhxmLg4QmRDdtZPQhljIs7F59tW
 OWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779401992; x=1780006792;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLknPmJPpJhnxcU5NLKQTN4jNRipVpMT88HAQLY06B8=;
 b=OpRn482AvarC4ojE0LBXf9PKUSpqLDCuU/hIS9QQJI96h6OI5HhlVUTIa1qgjYLyBW
 gs4YRhwZpLLxzidetYaMXtf7sOuhO0sLsMDLi4tat8jUStissGA/nT1TSp2lJMTlfACE
 zMO3dQTWrAwv1fKLnMhUzOgzzHtl/2CuKpxo9MHXbYMuwWR9OpD6kd6f9KuSALBECR89
 q2SGaKjOLgBAEzsqySMxZHnW2cnJgSL4zUolOhVzAxbQe78J+OZx2YZKcWlNjQ72UJ5f
 T2VE+0zd3x1RkCxSe5+q4Ckiq1bjhVBzMVi3aLxZP5r57Jzpf9voYsD9GM18vucGD77o
 JNxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dwGdSyOYhvDt9qDotGgI9a+U+Qp7EnjzJX0lAairjn9SkdAZALH5qFkTt4DWqvvHY4MgZmJ145Y8k@nongnu.org
X-Gm-Message-State: AOJu0YzeFhWulm3EjtfOFGqHmMP7ru6w/yhvvXRxMjnrgd6S3vZDP8D/
 DmY7bPI2tOTnJCjDDPdr30aC1AzViiokU6fx1PAr1sHmEzN6lgBrTxfgTRhKzlN/9KI=
X-Gm-Gg: Acq92OHAuM26SLZZYYeIFttF/cLHU4HpHwBdr6IxNSWnz56JTHosiDyn8ksTLhrYgFm
 spHqZgnWImBFmTHzNrdnWpABEp2R4HUELiediqhpsmkS1l65G7fj6fCaOHBNviQKvxtISJthgx8
 7AhqUIlr6/fN/ZZL0Pqjg7vbJNCwUqFFAWLAIAnZNyuHC7ZShcPzFXgY23/QrbmOKzvkNhmjTCj
 p6MLF3OtdZMgPLo/A/769COtPidE4pf2bsu/UAslL9XpJyiSA8A1riWMDav9GlfZnXnNAHzmWjx
 NyC+sjFch6/OjTSnBcGi3SEg9Fe8Q9vj7ieHrRLZdZcDVI2VBcJLzNnBLB+9uSUGFAh2OIs/t7j
 7+ilZA2a1y6AZmh9TaeNteJLQcrI0l/ed+UpA6s+uB93cC9XOhyvWUzCmmm0tfsSx8//1g9wbx1
 LskA0XX26NfZCzJ/zYavbxdZe40fbVIg6ipku+AHUW
X-Received: by 2002:a17:902:db07:b0:2b4:5b82:a8e3 with SMTP id
 d9443c01a7336-2beb0631a36mr7558785ad.24.1779401991995; 
 Thu, 21 May 2026 15:19:51 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb1412b91sm2384055ad.83.2026.05.21.15.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 15:19:51 -0700 (PDT)
Message-ID: <a016c64f-4952-4d16-a3a1-1184f2b0246d@linaro.org>
Date: Thu, 21 May 2026 15:19:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/22] target/mips: add Octeon COP2 crypto state
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v13-2-5a4cb8ec9cd3@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-2-5a4cb8ec9cd3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 5/21/26 11:05, James Hilliard wrote:
> Add the common architectural state needed by Octeon's selector-driven
> COP2 crypto interfaces. This includes storage for the base hash, AES,
> CRC, GFM, 3DES, KASUMI, and overlapping HSH/SHA512/SHA3/SNOW3G/ZUC
> selector windows.
> 
> Keep selector values and helper-local aliasing logic out of the CPU state
> header so the state definition remains limited to architectural storage.
> Helper code uses the same register banks instead of adding
> non-architectural shadow state.
> 
> Migrate the state in an Octeon-only subsection so non-Octeon CPU models
> do not grow migration data.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v10 -> v13:
>    - Keep reflected GFM selectors mapped onto the architectural GFM state
>      from the start instead of adding temporary reflected shadow fields.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

