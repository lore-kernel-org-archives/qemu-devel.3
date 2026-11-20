Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811A606A6CD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xoc+oISo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUSo-0001Pz-Tv; Fri, 20 Nov 2026 14:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUSl-0001OP-Gg
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:39:59 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUSi-0001Nc-R8
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:39:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2f0213202fdso7518365ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795203595; x=1795808395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDqPnKYtJ7HoOWBh+GRdA7KI1/Yh+SOQRffdE50PFTw=;
 b=xoc+oISodLgFfoNQ2O6OeNGvmRl2Umlkk3jxyJ6b5ejKpplegC3fr39UifrYCQmJx1
 gsGgUyFy4U21Rk179sZJIt0HWxwCnLlJkAHVsFujkOK2+mD+IdvGJezgNRw6WM2IXghu
 v5m5IJNyHUjsGq9DOI3G9K7EkPLK6MlQnYEiCbmvdtX9yH4PF+tVW2I7uvSnlsMpcbG/
 DAo8B+ouEyPrRBBT1pn+anYcyBdT7RghA4eX0nNRy7jJ6MLaX4HK3ePKNcOzle+zLaix
 wD08Aqw7/tzfaj9e1iwo0FKdwnQiFHGYrVZZGy4PBjfMll30dK3/MNFM9IPmw5LRA+xY
 wVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795203595; x=1795808395;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDqPnKYtJ7HoOWBh+GRdA7KI1/Yh+SOQRffdE50PFTw=;
 b=XGwkx4GvRv52juSTGgPutQ/tELwGtYxqxvUEFwxhcatbMhpI4sjlM34P52dBbfuvmk
 FUkse6gKy5E2wAYPG5NA9Hg2A8mUGDrSfYhYzt7dJ99sjIKeEGd769ltMPXF11Z4qL6k
 9YIEhiHAf7KnONj03lCvhZLVUH/ifJ2tH/btkBLEa51hYiDFfnq6rDlpcyJmmXJKiSpg
 50gemxhBOQqRm3qt/SFkhQk4tDWul9dMT9qCAc8APFhFn/mKUT9BkG7jcu3U2wY0ZWak
 ljCCHNRwMsfhZ8gWkaCA6EZjlS6iPX9D1SUs0hd/ETNobG8KaklJPXRMwD0zbdJA7EDf
 TYSA==
X-Forwarded-Encrypted: i=1;
 AL+hErEABe71qNJEXEP/MV2i2eUv1Q/grUziZaCRbPNGGx2GHMVDK7/0G8dFdqWBK0l3TEO14ZRBNLEUFSxm@nongnu.org
X-Gm-Message-State: APuU4Z+eor82DQpNm3IFQ3cNeySDZlSoRNPdtaZd1KUXvPePsXpVWZzR
 l1xfTvCFFVl+ezVgoNKW9y5/El+S+bnBdVJ85VBFmie8UpvXSaeMXCLmV2ppjkRF0rco6azrVwB
 +sFJR
X-Gm-Gg: AZFdTZfM/T2ctaBq2D4dNygf9GxSiWsrB7TlPW+xWN0fsMrLvWUGbDANbwCMVh7utot
 YxMNS/W8h5ww8ARqRnUumvdht9tuQvm5nGpF2CLtXLP2sICkDhJc1jn0m2SaxyAHSoHu7V9+WUT
 lbfH0ekNWm/WH+yOqv1L8SkPBWMB4M37ifjOEW4HkiswQY4Y3lg/j4TBWADNT08ZXqgf2pMlm+s
 LkOlzvT+rkQ6AwHC4Ge9SfctlMTvzKfb9aK1Psf+u1fOFyEevq5MRI2JCPuWUSf0j6iy9DghpNB
 fTH7qoCXmIJkJ3zEdGGJlFWxYCnVmkkntqDnoOG8Nt6yywBKzWuL/Fjl3sglp/AwyQHe5CsQiI/
 KvCP/GC4t1ZVsuRdNm+1zqEIt7F8neqprvgGXJm+oPTW80MqCaBB5JiWYlLoyWlvTFvZknsERjX
 FfFEBMhsvWV/q2+syBRtBwD4qgqWP2S/H+wzDGUHO4p5N7ewss3wwidQPv5TmASha0iWTn6ZRZd
 McufD/Ab7xLJA6zAP+NlCzf/L18JPoezC2RcPCTEe7pO82OFaFhhcl+2yWomCXKGIVN2qEKZfDZ
 G91CPWLdFY6kmizNrthHyiG9GX1COGnb98r60LvasOi+JoKTOKfEqnk0+GhkaO6ZHJDDNuM=
X-Received: by 2002:a17:903:2b0f:b0:2ed:2475:e40e with SMTP id
 d9443c01a7336-2f03f211a24mr41492295ad.61.1795203594978; 
 Fri, 20 Nov 2026 11:39:54 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0c42b1sm18276355ad.17.2026.11.20.11.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 11:39:54 -0800 (PST)
Message-ID: <5ce7927f-1a9d-405b-b2e9-49cd0a30bf53@linaro.org>
Date: Fri, 20 Nov 2026 11:39:51 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] accel/tcg: Check current CPU in icount interrupt
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ashish Anand
 <ashish.a6@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261119225514.4080-1-philmd@oss.qualcomm.com>
 <20261119225514.4080-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119225514.4080-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/19/26 14:55, Philippe Mathieu-Daudé wrote:
> Under round-robin TCG, all vCPUs share one host thread,
> so qemu_cpu_is_self() is true for every vCPU. The icount
> interrupt sanity check can therefore abort when an interrupt
> targets a different vCPU sharing the current thread.
> Compare current_cpu with the target CPU instead.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/tcg/tcg-accel-ops-icount.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
> index d0f7b410fab3..0313a4d128c5 100644
> --- a/accel/tcg/tcg-accel-ops-icount.c
> +++ b/accel/tcg/tcg-accel-ops-icount.c
> @@ -152,7 +152,7 @@ void icount_handle_interrupt(CPUState *cpu, int mask)
>       int old_mask = cpu->interrupt_request;
>   
>       tcg_handle_interrupt(cpu, mask);
> -    if (qemu_cpu_is_self(cpu) &&
> +    if (current_cpu == cpu &&
>           !cpu->neg.can_do_io
>           && (mask & ~old_mask) != 0) {
>           cpu_abort(cpu, "Raised interrupt while not in I/O function");


