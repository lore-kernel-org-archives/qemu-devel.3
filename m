Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63566C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmOl-0006sl-FY; Tue, 13 May 2025 05:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmOj-0006s2-T7
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:58:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmOi-0006TT-B5
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:58:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a0ebf39427so4379891f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130283; x=1747735083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+orejYg5iGx2gkb2gtAC+NwOz7ulxd/j87UKY2QmtE=;
 b=c6TYyx2Jkupf1DY8juFZyBwve6I5KlHuzJtFPLRNPMDC9F02wW/lZM7+CI6ktpUYbz
 r9cXOabOzvQKHHHoESPMI2dvkiHU8t8MHX5XOwgpEhm+JwKCgROVdRVAJiG/yPVYAQ1R
 xoqGxm81JjP50rUk4iZrrKWZpVu3zgWckhKlFMtAfhae+Pl1dZUQdgtrFmxzpk15KF0c
 mBq+IdDJ5RfsFuUiBO1nq/QRJRTwF0tOHOvhwvtaAeNWy4u5/gT6BVETlGCVg3+6U2Pn
 bSd5rp7Ins8b+Mw/zI5uiknxEeV6r6Hh4g+DGATMGZZ6hB1WoAJ7m++Rb78h+wfmop0d
 46Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130283; x=1747735083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+orejYg5iGx2gkb2gtAC+NwOz7ulxd/j87UKY2QmtE=;
 b=rVHvdZA9N5vxIGNdFg7NSytqExkWZhFsbPqx5jpOJOwAkLaii2UQHdg7MgCuUR3ACS
 pq7xPkDZhTcAgIrMwVUUC1NRH4MaPrBROld98nCqHMqCesn6TRvdinfEPLLkF1T5EL8H
 r6nHy0p8+gzqq28i4ZOPUqngg2sbD1sM8jQEs7rp3+954Az3mh7Sy+hCBUj0bnV13tK+
 W/7uqZoW1waqaGsI6tnIw0YfeA77ffJXBIL19/xqqVtk1VvporOIZSXg+Ao5Zb/8M3eG
 ZwcFsKDfq8owviBpiv3W/NyregANcYfFs7mCDOWRhP4lnNhf0QSdMk1Ysw2+V1J2LvKp
 I36g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKF9+5KoH0u0osS3kyXqvfkbUhbk38zOfiNR00AQYn5zaHzwVe77fAxRdAo7cS73nOi6c9/8iStLcm@nongnu.org
X-Gm-Message-State: AOJu0YzrWS0DSzGeaNwIHaWuApqYx1haGUjRY4RU5FJB1YvwjhOc7jvW
 OzG2NOLwHpLXRMqDWFJUmBuFM/PkBN4apUHGfnrEZIQ1kMUhZq2B9A6Sn/6U/OcJlqG7GPf0P0w
 3LyQk4gAZ
X-Gm-Gg: ASbGncukh1UTPMySl/e0cOeTYDdioqujNmGe0IkENGJ1ayxSJJai8A9NbtSyswUaJoq
 4EfZFe17axZkflOQxF9vZtLv8hJvg9GvBtJko/tcnno8R+1jjGVoWCCQo9vU8z9X8Jg9dDtKjrk
 RmHapKfmn3X/sIzGrAbuKInLAgZLf/nbMhlYgpln61jtqfpui7bD7RhkTiPEHygu6NwS06dVIHV
 7mjXWXg/eICkEp9QjbMlKFXY+d/7+kpEYJc1i2VIExJwuJb21bWSNrJ88V2jgM0pYVEY/HjKkpu
 6h6lH9Pxe5F+OYY4iqxDdOg8K5FQ7jPd2jrAdrkaar20QfwBdsgYwR0RGOVeLdbT5y9xU+vCncE
 2g9QpKCK3vn9HVAR2wmfnmns=
X-Google-Smtp-Source: AGHT+IFH2OlvRcGl4N9FjP9kuGhmZ9IA5VlsAJQgKag/eumhT+Cs9hNppG5RoEwO0fq6PUrIk86v4Q==
X-Received: by 2002:a05:6000:22c4:b0:3a1:fb7c:278f with SMTP id
 ffacd0b85a97d-3a1fb7c29b0mr9435718f8f.22.1747130282699; 
 Tue, 13 May 2025 02:58:02 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2ca31sm15710232f8f.65.2025.05.13.02.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 02:58:02 -0700 (PDT)
Message-ID: <a7c1d6b0-8e62-4bcf-8b0b-35311d4f7802@linaro.org>
Date: Tue, 13 May 2025 10:58:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/48] include/system/hvf: missing vaddr include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> On MacOS x86_64:
> In file included from ../target/i386/hvf/x86_task.c:13:
> /Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
>      vaddr pc;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
>      vaddr saved_insn;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>                   ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/system/hvf.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index 7b45a2e1988..a9a502f0c8f 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -17,6 +17,7 @@
>   #include "qemu/queue.h"
>   #include "exec/vaddr.h"

               ^^^^^^^^^^^^

Since commit 0af34b1dacc this patch isn't needed anymore.

(no need to respin as it can simply be skipped).

>   #include "qom/object.h"
> +#include "exec/vaddr.h"
>   
>   #ifdef COMPILING_PER_TARGET
>   # ifdef CONFIG_HVF


