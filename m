Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508B606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmg9nLsC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLi48-0004OQ-2C; Tue, 27 Oct 2026 10:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLi3v-0004Ms-N6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:22:08 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLi3t-0004I0-SR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:22:03 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6df5e315bd1so2960169eaf.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793110920; x=1793715720; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hBc2cr45C6cbVa960jsQEGRROgbvNTrQ9bk+dKhFnc=;
 b=fmg9nLsCGVw8+3evHnn93OqOr7gBh3yKEbvXFQMA8ciGox3tTJMlK3BaUfoLOULhFe
 0VLz/GV1AsI3GK6G+JVNataNUPEJqQYGNLfoaKafjY4Ci1S7s9vknQuGsgA7NIz4o8ea
 R3L1PSiNCM5FC5OVRHkDyefZivjHn7XPQqRtXlu+c3+pmzPvskbErjADLtCYOXzzaXHJ
 MJEq5dT9vrRtGmCfL/0OaK8fYzHTd+fnenkdszGUJOlp8OOtW724nP44hZsrg8ole3/q
 DZnYHQHSMaN3s1I6otofMsXS/Z4vIrthYiPrqDB64NCXCjg7VVhJm3HeHrCLlSLq0DrU
 nYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110920; x=1793715720;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8hBc2cr45C6cbVa960jsQEGRROgbvNTrQ9bk+dKhFnc=;
 b=w+uHVCm3MacUXdGV0b55R+lj17okT0dNBE9TwCyGZYn+1aY2wp/UQN3nGBlWaNS/rN
 JImEMLmQkXShMzaZsWGLbENSJpwuRZnnWjqs6aX+wOiQs+n5sX0EEo4EdduBi0b6ZlVx
 414gt7AJY2S6eWmAtXwof5fqWCPlMNX2cBqUuVCvObyzEaP35XWhDckqqCXULFdNEGmK
 hBiFPyaRNN/qw3G+vQfS4o+y8+S3+d6ue462q0Tx6/0gRK1gAMuhxYj5uewkpFsRO9VQ
 0bb0mp1zQ+wmdtMd5znFjajiyV/14jZGaqkwdnkMfQi0+GoJMvXREBiiaKwygSWzO4DI
 zTNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx26uVAJORlEHw8e82PRmpDb6gY87FDdAs7Lo10KEn2vZiLk+z24e8k0TAjqOj05MDjMnTXk5ipPv4v@nongnu.org
X-Gm-Message-State: AFq9FYJL9cPu76Z7riLE87uFD417BNUPgLTEnBpDU50LsC570GiU08Cq
 d+y9BK95Qny0CWHLErljaYsHSWspYMkrAnoRay7sKx8zJV9jOmksVVyxmV0Hmrp3qfo=
X-Gm-Gg: AYBFou0jWt1RGb4PM4Hq5Aet8kw2bEnH1vgw3SbnzMqbLM9PDgadGxeZHIMSUarXlGY
 M2PhfYFPEiNohEP2l9LVOpYbn8mYrkjOO3hEXDmzKa77vk0IT59EK+1rJwYLu++ZRnFHG/orkhf
 aMbxs9TvncUPIh+zLkpY0mmE+zsDrvUQsuC05V/OIvEgxxRG71yLqCjNF+7CaDdYolOgMqeOBYL
 3WcwF9R2CqDqH7rgl3izvedvva6DsTm2aUnTDJNqguYTkn/C5M3BseoxM7xYllrmcRMO20fAaTN
 4jCz/hZ47juTcY3PARvQBoXBjODBBMh3P6A6XmCatYEopKbLNMY6FRWw0t84PluoPjEPIok3HCc
 by/f6RrUzEA0/2Y2LiFl1sCdZ9uNNf5yV2IOnFRXesGJS+j8ddcQ/8ZNvFBJwAJJpZ0ZGZu0qGj
 eMUkjprtN9l1T5yDhiLokyE59ME1cDtwPycBKo6c8oSBNp7QZ1j/F2dkxY4lItPUybZEtcnOn9H
 fuvPkWrGdzmZVHu2PlJ0lfSCTAsuHJMSaKN0LNzgTL/JZJBuhqGyGRRK6rgR4uy5WwBUuQ=
X-Received: by 2002:a05:6820:7094:20b0:702:3405:dd86 with SMTP id
 006d021491bc7-70ba0edc0ddmr3671233eaf.74.1793110920101; 
 Tue, 27 Oct 2026 07:22:00 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70bfa90c943sm7295828eaf.3.2026.10.27.07.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 07:21:59 -0700 (PDT)
Message-ID: <abf65923-52ad-4515-9a17-3b134faba7f6@linaro.org>
Date: Tue, 27 Oct 2026 09:21:57 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] multi-target 20261024
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 12:36, Pierrick Bouvier wrote:
> The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:
> 
>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261024
> 
> for you to fetch changes up to 59f954f8277e80065b1286bfe89ca8861c08d1c5:
> 
>    meson.build: list all remaining softmmu targets as comments (2026-10-24 17:36:09 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2 00/11] multi-target: prefix helpers with target prefix (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261024163249.77855-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH v3 0/9] multi-target: add riscv64-softmmu (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261024061616.27381-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

