Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pHSU4KLV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRVA-0005qQ-8M; Wed, 21 Oct 2026 04:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJRV5-0005qC-EV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:16:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJRV3-0006y9-QL
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:16:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso269316f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792570599; x=1793175399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4oOYPVY0zbOEIsHVQSzVGZM6BVbxFx4x7E/5caMDdg4=;
 b=pHSU4KLV90GQbAdretgQe/FTTVk7/hsl3DzDa45xgjng93rlj8zkAHOH31CZt9evzA
 uJyuVDGQ2BBWPtHnrA+wqCnqc6h31GLhqLvpWcrrP0OQsCSgJwHb8n6/F8xg5YuwHlVL
 M6fi/TqXH33YK3jLYZni3daXXm7BwR400SFtTI5DWbhv6uQcRwhpDcQO6VIcvlutmalK
 3ik956HBy0+p/FTb76Zl2u0hyZeMTgSJgEHzdPy77q8WefNRlV619B8n2wEnagNa5EI8
 KnsqL3OL62XzudlTJpl1wWXhgKxNmsr3xy//LSQHPQpGmg8zWpcBu8qiAeL2VG9J+aF7
 tt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792570599; x=1793175399;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4oOYPVY0zbOEIsHVQSzVGZM6BVbxFx4x7E/5caMDdg4=;
 b=h+xC4SjAS/wYRdE1NDme1RM10c0DGpvq1DLxdEcc3TeRyUehLrOSWJbrRMQTZugcOT
 FU6anJN2uR+qKABOBrVMh4NeiVbDnh2Wt0jP9H1i05on4xBcQ0iLYEUAw+jPz3Z/9dI0
 OYLYpT+spXie2q79ASCdvTMxoG8iEi674zOS2JQtk/unF6zx0UbTfhjgv7V3zXU+LYNE
 Tq2wnQuoEw3C0a1up6KF8HYxyTpdl+8LVYIKIgQQlQfyrv3jypuRDiWQMZaEGx7+GyjI
 BDa9BapDFZfZQlxhU1dBB9fb/FTrBAU0ufYWJ7vWnJyU55LnOccwOliiX2mkaxWrxCGa
 IvvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznverlI92D14X5uGUp0v2rixxjygInyZBlIAX0tgz/hEG+uCpbWd9k+heI6RWos/eg7bUyc+GME0GU@nongnu.org
X-Gm-Message-State: AFq9FYKaOjw/lB3QdoJCLP4c/81s9+Id4Ze+WKC2a7TrfZ/VLDeNS06F
 MoNkk06Gzg+LouW4fmNWGRzuIEMqL3LZTcYAj23D+LTos/3AVQMEyjtg5Tybyg6YB7Q=
X-Gm-Gg: AYBFou158GQzta5VVp1OJ1IwiKmNpreJQ2F3gd4LcpMSFLYrXF/p1rR0aQFlfcIQoZu
 YNCLIq0DH2B77cRE4thvFHByFRaNqWecbiFoC2/o9G/Kf7Fy4geGzO98iep+Ce37yNwq7zL4jUB
 r52J1Tf/RqOHUtsPpqQlfg1K+kELkHMEId2xwnm3ngHsHvNsCfSk+cQYeaFnEK8Ftvf10mK2PpB
 Ag0hCNgLaTP8gqgJ2xZNXvIbBH4qdJ4ihqcWUzuGKWYNlmukOpQOyq0mbxh51yUOohUr9SCDYw/
 aahtoYFMHpO7qy27ViGCjqC9op8/jQh10renyQ5MuFYjB0u2ic8W3BGay6ImOUsQ4WHon7lg/Tz
 EaMTpauvT1rIFNzbDyKFbG/lDYe2FYNWkIFSqpag61V+R0usimqT6VilEEEwcvXUIGyPkQmxduf
 1HyfTZSbABGYUXDHuBuaU2neAFPJ/2U2RHpe3eQnO+Uz2ASWVbzYZkkzKEsYZY1JzG9UaXaMntY
 ouMlheBllKYjAo8QQ91tFZEt7CttLs55HRWCnO2GKCyrHs0yw25JmU9UC3RvSlJL4fq7Xz5EDQG
 ZvoxTw8vFQv3qYbZrP5REfJgZ2o=
X-Received: by 2002:a05:600c:4684:b0:4a1:d36f:1ba0 with SMTP id
 5b1f17b1804b1-4a1fdd74b6cmr24015435e9.35.1792570599509; 
 Wed, 21 Oct 2026 01:16:39 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0ad18esm29867825e9.0.2026.10.21.01.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:16:39 -0700 (PDT)
Message-ID: <16978d5c-8f78-4e6d-822f-097156561352@linaro.org>
Date: Wed, 21 Oct 2026 10:16:35 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add automatic retry
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/21/26 01:16, Pierrick Bouvier wrote:
> When merging PR on the project, it's possible to observe failures on CI
> that can be related to sporadic test failures or infrastructure issues
> (pod eviction with Kubernetes). As a result, it adds latency on the
> process and workload for our top maintainers.
> 
> This patch sets an automatic retry (supported by gitlab out of the box),
> so failing jobs are automatically retriggered.
> 
> It's important to note that in case there is a real test or build
> failure, concerned jobs will run a second time, and fail again. That
> said, it happens seldomly since sub maintainers are supposed to test for
> this before sending it. Also, the retry is limited to the job that
> failed, so it should be cheap in terms of CI minutes.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   .gitlab-ci.d/base.yml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

This is effectively what we're doing anyway, modulo looking for real 
failures first.


r~

