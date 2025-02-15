Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540CEC021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 20:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjORD-0001QU-Te; Sat, 15 Feb 2025 15:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjORC-0001Q7-DW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:06:54 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjORA-0005Q8-Gv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:06:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220e6028214so48435285ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739650011; x=1740254811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGrF7bWHQlQuccblAQ3TQgqcIclFALt4AgreR1jmSKE=;
 b=wbgAxQS87g65Qoj0wBpTW0eoX8tKrVkqNnmBl3awjYoBek8LMehJE/Q5/p7IORURmB
 845n8uJ1nNKgojESK6WZMMgYkPx7qL/RZtQqE2dykdJzHQg6xI5+upCUTXIfl8L9dfxB
 UM/jq32zrykoHv5djHUgyYZ+pCSDkzEnqY5g85yvZEe8tTdCKfK3ULrRVwCIHEeDQ9cS
 A6UkvQgShuBhwqtyaBob2CvG1crLdDFst/vzeS9LvkWYwPILrIU4ZymzKirhjBiRuou4
 lcagNJViHv6C7Xj2A50aEemtF79jfYn/oylALKzKfqSeZdEiJYjxjpkRhQ1YG+B96MRF
 T5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739650011; x=1740254811;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HGrF7bWHQlQuccblAQ3TQgqcIclFALt4AgreR1jmSKE=;
 b=sgPmvBBaEbs26lx2uQFesXXXXiVpi3IfddVpAilG/tp7EwFPEDHgnR3QOVMZOPEniL
 SvP8B38nPQyeOtZwCROGhHlWRYxVmz9sidlqn0n8F7WjuUxCpN3zmzNF7SA5XIqp07KG
 98Vwc1nbjfhBGjo3Yez0BOhFamdQ4R2vUVvvtFSXUKEWfDcUSEerLvbVEpse9YXztCsE
 JpUBKFEnL26wRxEAVOAiIbtbjyJwkhde85RVXWN/+fsuNGhetLFnrUXrMcBFrQCU3uso
 ksSg5TQvHNBl0JN79SJg3LCTXAI/6fiIrK+e5/5i47VTENxSjphYatPW0atF9JMYyU0t
 wcqQ==
X-Gm-Message-State: AOJu0Yz0hf4Ls3cNTjaGXwmd+s3uIQaQZRXq/r66fLi6YzXdA7Kv3eLp
 csHD/U6vqiGWJIQ05h0RwEeIdvFKn0E3Vq1qwimZpstlWaQ5eBbhbLqV/ghEZ0CzjQnuZEAYeaP
 f
X-Gm-Gg: ASbGnctJTH3d/frc6wqOnIMGMrH27Yt9NM4j6UE+0f7YHOddjFbe7zIOkwORGTi9TC/
 cHpcchocV67hy6We50XNFsFiNGVzjF87eO0AtA0NdGYOBWH8w5fCxc7BADXLxzXnhzeaUTpBJUN
 KnU9jM33y1B7uJRxgpTakDa9Fbbm9yTgy8gxkbCnmUz8vM1oVjg7MIJhCFvdEOLYdXvlZUNUJMV
 7OqyZP5PLFS2To+R+02zsPkKygMWpzlCN2TPR990TnsEJ6FSj5TrnTg6AUBhH3MgxsCHGZbjrh/
 Bgdsi/eLF6y+oSn4nu8wc9TmYUqbjxgsefkvt1g/TiBIYVaXxJYT8wo=
X-Google-Smtp-Source: AGHT+IGoyoehxDGyXjffgYDaiSpHTYqjqBVcC25R8yUj0Oelu5NTtl/Lmm9bIX+vKvJCEyh9fRe1sg==
X-Received: by 2002:a05:6a21:6e91:b0:1ee:391a:8119 with SMTP id
 adf61e73a8af0-1ee8cb49991mr7566742637.12.1739650011062; 
 Sat, 15 Feb 2025 12:06:51 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73271a02648sm253682b3a.107.2025.02.15.12.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 12:06:50 -0800 (PST)
Message-ID: <3689674a-fa0a-4a9b-a447-8d706d7e3e4d@linaro.org>
Date: Sat, 15 Feb 2025 12:06:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tcg: Introduce constraint for zero register
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250212034617.1079324-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/11/25 19:46, Richard Henderson wrote:
> Based-on:20250205040341.2056361-1-richard.henderson@linaro.org
> ("[PATCH 00/11] tcg: Cleanups after disallowing 64-on-32")
> 
> Introduce a new general-purpose constraint which maps 0
> to TCG_REG_ZERO, if defined.  This differs from existing
> constant constraints in that const_arg[*] is recorded as
> false, indicating that the value is in a register.
> 
> This doesn't make much difference to the current tree, but as a
> prelude to [1], where small output functions are categorized by
> register vs immediate arguments, then this provides a way to
> send a constant zero as a register argument.
> 
> 
> r~
> 
> 
> [1]https://patchew.org/QEMU/20250107080112.1175095-1-richard.henderson@linaro.org/
> 
> Richard Henderson (6):
>    tcg: Introduce the 'z' constraint for a hardware zero register
>    tcg/aarch64: Use 'z' constraint
>    tcg/loongarch64: Use 'z' constraint
>    tcg/mips: Use 'z' constraint
>    tcg/riscv: Use 'z' constraint
>    tcg/sparc64: Use 'z' constraint

Queued.


r~

