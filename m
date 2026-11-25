Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DA606A338
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BVQVeRTR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWKQ2-0007dL-Vt; Wed, 25 Nov 2026 16:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWKPv-0007d0-TK
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:20:40 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWKPr-0003h7-Mk
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:20:37 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3b3a914e4c8so3468990a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795641633; x=1796246433; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=POMjowG126XnQibLE5jeJpWU/Av6GVTdrJ43gyabHnI=;
 b=BVQVeRTRNV9BBm89720Hby6Rn5KIuWh8BT88Htm22tjY01wjEaZ9Iq/nqjizQxcUfx
 mNJEi0WhL977qZDMmL2bNM5BAXeB+1pERq9UgCLUG/f8A7QSpnSOgqSXOqUbSM+BNvcS
 utDcEMF+d2f2P9ExVwzwxIbCdVGTvA+yflmR9J9+mlnG4valyBY/DMAvuneT+iGqN06J
 D0zMfIq7Hq6nUOwmN3yiWj7pFcGwup6An+2JBpo/FOKqJDezx6Ry0s2SaXfip/sjmaHV
 a8FL93OaU5UUF2m9Tiz/FJOiAXiG5DbbdnWUhNgQddtcg0I+AV3oAAyGzemxqPhNJh18
 IHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795641633; x=1796246433;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=POMjowG126XnQibLE5jeJpWU/Av6GVTdrJ43gyabHnI=;
 b=dQUw9mbW1cLB585LeO8uBdFJDLwUGzLYC1BVzkixivhGEwLYDVC8pT8+sZ6jEaAPOn
 QjBabz8lcfWYnPSROs2Anu5FNjmxxM36jAKY2EJoLUHXqDKE0X1hoOMAB7WtxL5bryWZ
 3/9CaJ4MezqpQMkOkXatAk9bwaF/rjWudFldcxt8K5s1ULmZbWlLffoALglv8QCHvhGy
 TGaO6glrpsJCZsWUZLlV7IGNSLI7vr4GoTUcnMa923MLW6yFrhC3oviz7qBzXy62Dv03
 CRXXH5Qb2qHLKOy2VplhXojuvPIFdYvViTuMKhg29WtMzI7AgBsczcnNkXvAta62B3oy
 VvEw==
X-Gm-Message-State: APuU4Z/gJ2gcirhAs6/2ri2P+pgDcrPP4HiHkQCZMhdFZ5bIVxmQcWK8
 lgGLTW+EuBSGXFWVuIAGsMXhqrBvk1TiQJfw6kdH/eK7nnjtUm6PH+0FGthYVIShSiI=
X-Gm-Gg: AZFdTZftKsUZ2qgpZRn7pyAsxl2xP0UuPmGjC/k4kvmEr+9rWp0AU1RrhAv/7Nm+1qQ
 u3gSKvRiNWd42B2Q/5XbOG0VtLDUf+8/ZcjyCPRx2b5QVw9wjcxcybwSWg43lGNuBQX16kctqzU
 QbpBLdayup0aNJSoTSuYDPsc8zFXbNXVZiXZsFWtM7Ol3BVZX5wET8HA1kLHTglqCAzUP7YOy2w
 LK+A0emEe7h+nL411oZkhgSDGUkNXFZikWLmR6WVGeoCg6NEa4izkpzgWFz7r8xj01MmaHpiJ42
 g/ayLdP54EpkekactlkbO50trHZhElDrn17O4tzewCHDjR5INqz5HHFJnhs/e+LN8Lbwl6bPw5F
 7l2WJykQHxkIq5UEIlaNvzGU2hl/bUGKilP9xcRAme9wSYKJzchfmyJB+dJvFTjmW/vn2Z0CKcG
 HVFDTqL31d5VR9FtHLQ1MY7/fWnVmgms9IIGg73Ul2czbWSb2ZDJwUOsLDEz301YutNtYqdPucY
 PD/8Fgv6M5M7CZEfGJaqacIujuVEVJNmh0beqLw81F9aV53GBGJsPqGZpzcG+AbJgXZCpICw1ol
 Ln/hZwwDnHrkv7qXk+gNqUaJfbRb5z0SdN2AyZAQ2BOa4Fz5MDRwlwEKv+N0jD6a
X-Received: by 2002:a17:90b:3d92:b0:3ac:83c1:2c0 with SMTP id
 98e67ed59e1d1-3b41c9b2de6mr16464541a91.64.1795641633404; 
 Wed, 25 Nov 2026 13:20:33 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b792474sm13736191a91.3.2026.11.25.13.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 13:20:33 -0800 (PST)
Message-ID: <2d3db874-3510-4f3e-8784-f86721c858f7@linaro.org>
Date: Wed, 25 Nov 2026 13:20:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
 <awbpz7SZ5grn9gyi@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <5cb298ce-7f9b-40fd-b553-879a567e78a5@oss.qualcomm.com>
 <6da6b191-6ec2-49bf-b25d-aeedac071b40@linaro.org>
Content-Language: en-US
In-Reply-To: <6da6b191-6ec2-49bf-b25d-aeedac071b40@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 13:00, Richard Henderson wrote:
> Grepping around accel/tcg/, we're also caching romd in cputlb.  We need 
> to flush those entries when exiting romd mode.
> 
> I think that can wait until 12.0 though...
Bah, nevermind.

memory_region_transaction_commit runs the listeners, which reaches 
tcg_commit, which flushes the tlb.


r~

