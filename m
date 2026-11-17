Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E03606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BhuyO1SL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOYG-0000Z8-CP; Tue, 17 Nov 2026 14:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOY9-0000YS-Oj
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:09:02 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOY8-0005Bw-AI
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:09:01 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3b0d0b80fb9so40044a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942538; x=1795547338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gi/sVnYsX2OyFNhRvNJMkbE2jzH8AniNoey7NE+coZ0=;
 b=BhuyO1SLSFxI+CTfv2jQCGJvW4RNkyTSh1tcBVvVfaZ8STYkIVCKQ8hqWoYdB5tq1g
 NjpZrSCGAem5BF1bR76cXIAbmxAdgjp3RklmK8U4JXPfFb0MZa2eAbTib8v67xP9VHN/
 Mc3qTHQuWFOnuYHN6xCFtBelQjjjlj54DxsceEHpfIWcGpVM+IKTf0BUQ70iyWkYq9bj
 BkMAf3mHucYk/zLH8PobHkAf/+U9ZVMGMxG7hk79fALT+IUn9Ps4A9qLPuABeafgcUbS
 9xyKezlIxO6oUfy0NnptmazqCab4XPPsfWtZdRWRPSM6I21TwZ0q7o9nSQpGWVqKNf7G
 aPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942538; x=1795547338;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gi/sVnYsX2OyFNhRvNJMkbE2jzH8AniNoey7NE+coZ0=;
 b=pXH3j+UALhDaqm0seuzTyEl2CH5Vn44aijkITINzk2DkoCTzHchvSBRJU/Nj3NZehQ
 HkjB77nHMT4Wc9SHPkn/jkMBx3P2Tjm3KHqIJsYoJbhNj8YNqTwlKbdEbTW7cZTGJbUd
 VFEcAHtgFs2AZOWxSfunjp9BqihpCwQbmJNRVsbJIktZ/fUQAfjN9RemBPPE2+Xy0Ito
 ey2q+HzqXBRTismgClej6UXyVqxtZwL/Jech5dI6JqGF7JLNJNEeEqYECInDsNJm8US7
 BFdeaEuRuaTQLjuvF/w6M7wMIQJYpLZuQ7FkQYy8xBd97uHdWLie9XtzEsPGxmAqQXFR
 lkcw==
X-Forwarded-Encrypted: i=1;
 AL+hErFkmyNxo699XIpUKqkPImo+QUB7KyCn7mVZWpXLChKZgcyJfhM/tQUqEkb3sMSrXbJEaAtA7tbjB5j+@nongnu.org
X-Gm-Message-State: APuU4Z8s77coM5+pZ6GEJ5QmyhTZ+LRh1NVZw9AbTx3PM0zW9cCQWnL2
 w84KRIPGmKUCWW05Qg+2RryRVEIgzkSxn1beIVhQxbUJNyrl2n2iWAw/0KVOGY9o9cc=
X-Gm-Gg: AZFdTZdJ2NLZw8mqDwzzcad5+UEMDjQ4w6KhLChdFRPfj8ZbFAhRMWBjABCv8gB+osT
 0SRTKAtePZwJAvB68nGiiR6PZDhoPzwIFJK2woi/T+IeBS7b6yy7QVwI0swnmR06RDHBX7Ls201
 vQ4LIW3m8gPPx0Y915y1p0D5I0hMyz6Zt+DhfsjPcraCoTnkuqBH0Ln6+sZcXWDsHtgVfvSGvOU
 xp0LUFJwdQkOGMfFYfBdeshvMjO3AeC4jF+dcKjnAoq/nkvcBM70YWuUwpSYJaxeCNrt36IUJu0
 ImXGiUWCWXZPL0VL7Z4+duaP66PPIBhec+rD9o3QMnLmZ8K3aWh08H6eSh7EN9O+WNGx9+o2grM
 7ukhC+Diiqh+AmT9Un9/thu7D1w6QRK1F1snE+VZPF3aKYZFPcTIMoTMDu4L3xjbp3g9M5hXa7F
 dEYKp1nOjibnd+hsl7OUuObBJSnA+al+RGpjfnsJwvomqFJJXWYUdcgrTqP+4nuQYYC5MyoY8P2
 hlteCZgmcGoveCa4svC1h9wRfhP0pPBlCOzlEHG+RZrgyQT/DnSUkmwMU+UIh+Q2ev3pUC0Fetl
 v5ZlRZO1MhUZnkp5EenPuhFWPZiSo1uAWuQFdvuIau9Xwldb2MKdxESbLrv2a/6lox30tKg=
X-Received: by 2002:a17:90b:2b4b:b0:3b0:9e2f:cfc3 with SMTP id
 98e67ed59e1d1-3b3d07b927amr311120a91.32.1794942538309; 
 Tue, 17 Nov 2026 11:08:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ab9f4c98sm5435706a91.0.2026.11.17.11.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:08:57 -0800 (PST)
Message-ID: <0bda87b9-97c2-4b84-8693-0554465f1669@linaro.org>
Date: Tue, 17 Nov 2026 11:08:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] target/mips: Fix microMIPS CACHE offset used for
 ITC tag access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> CACHE is encoded in POOL32B with a 9-bit signed offset in bits 8:0
> (MD00582 rev 6.04, p. 144).  The decoder passed the generic 'imm'
> (the low 16 bits of the opcode), which also holds the minor opcode
> and reserved bits 15:9, so the ITC tag access used a wrong effective
> address.  Extract the 9-bit offset, as done for CACHEE.
> 
> Fixes: 0d74a222c27e ("target-mips: make ITC Configuration Tags accessible")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/micromips_translate.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

