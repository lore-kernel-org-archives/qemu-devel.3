Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C23D185D8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnkh-0000sp-Bd; Thu, 08 Jan 2026 06:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnkT-0000bi-2G
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:00:14 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnkR-0008Pg-9p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:00:12 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so33144045e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870006; x=1768474806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=goEhRns7hs+YsqOPg3SX5za03rOuwB+1VM5JeVFL/oo=;
 b=PhjtSojHfUEpwDDYzj/ke1Q2CTLUR8M1igDMi6Q8l3cSiues0JGTVuG2rh96xummGe
 iiT7xYPtaOFMahlLABXd9Fp4tDxLcwlBjUIztDjQLVthR6Mf/8IM15Q9YqE9cpkuxctI
 G81MLOhSrILob5J+nVJgGK+vLSYdcazlOxjdKR7jUvcpjRVRBg09vDzYusuDp54Pu9o8
 uAF5J/nCvMsXdCxtzszWX3bM0dhMjB7iO8g9hfS1pTbEQ3RLO6qEdxrIppbmzfqqKdh5
 2sU9z3t92Lg++4KQH84Vj6nnvk+hZmjbXOLa3konhsK8rCKguCerc7esZKjx0GcJc3gc
 SuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870006; x=1768474806;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=goEhRns7hs+YsqOPg3SX5za03rOuwB+1VM5JeVFL/oo=;
 b=PLZtIoMWzYgP+nFcQoWOVmztNwcr/iEpSv1F1pgtBLpXgw6kCdhFdsag3stgAnMt/O
 T1d9VChq42Kscl+cjOIBxUMiOJcLfPkZpg/rUsXSEMyKynH6iRmbMdTEpTjQ79hpS/o9
 6aZhsX0xCSfXBzbyqolRZvmQ6gSY/mqHM+W5lMG9dHG6MyygPsKACuC5r2FoqmSUj52b
 j8b/jk//iMRszQABIhYpnJY3v+o59QOShwzafIHYInTWG2/wkYBY14Hs72LscnDsXKyD
 QG/T4q/R/gpEc27XfcsVPuTZ2QK2xwH08wYTbD/dvIZJB+BCgBg8YNzAWn0URvM15VpY
 2VnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAf+oj91z0JKVekMthaQF0FPYz/gz0arjjLJeTy8NJOnBbfbkplEqrCyt79J3+B018szj+Ny2bMDS7@nongnu.org
X-Gm-Message-State: AOJu0YwDuGVMW+qRFYxFfh+ASXXScMS4c8DSeqUijhL8Yr3tohEixdmo
 WiiLIIO4Xw5K45GOzHEFiTMUoetVF37XQudHgFAWyiJQqT5CRAhGdWuvUG8U7IupYI4=
X-Gm-Gg: AY/fxX5sny7rIsRg+4t35Kwe7h62jHLFLAJd6ZMj4JTbIpyMHwCPQrWBDiVI7o6P4kp
 xlAF7p7KzgiuG5deomRhTavIUaw17+CVNG/Vc/WcQbLHQNhTaAFN6062sFDZOHHKGfvT/CniUic
 8y1E/HkoZ6e8LVtDnc4CvwMJst6QbiUKarIbUwCHrWcR7dIy+VKb98Syh4LQz5vkIbUxOPUUYYB
 JJ1JDfRIftdVRYSsF6oUVkQnn9lcpQmI9nJoe9xKpJOXHu8JOqrBjxe7rfFc+qyPDi1IQM2a/Ez
 VP/14o/XfmTt+LP9yeun+WrB8EIxGYkhDpRu0YlyoPwARZym3iIFOBYdDAHE/VVmozXoVpvDQd7
 pHaNLvlUj6yAq8LHRJA5pLtrJP43Qf/BO46Nr52+1o57f95MydDVe2XVpvHhjDtp6f2TQPKUvrV
 Vju4aH4XdjPchoc1Zeu52PuShB8FCHIJqdGZjKrqE5pRS1RXWl/+qkUg==
X-Google-Smtp-Source: AGHT+IFyagw3CXtpIFsFvxoQUqJnLunJObGzJ2cTT8KUluAkCFzrvavm8WctxgU0sMA4ifcyO/Ur0A==
X-Received: by 2002:a05:600c:a102:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-47d84b32793mr59845505e9.23.1767870005984; 
 Thu, 08 Jan 2026 03:00:05 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm15858198f8f.33.2026.01.08.03.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:00:05 -0800 (PST)
Message-ID: <6fad00ab-1b9e-41bd-89b9-b7095bc18658@linaro.org>
Date: Thu, 8 Jan 2026 12:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/50] meson: Drop host_arch rename for riscv64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> This requires renaming several directories:
> tcg/riscv, linux-user/include/host/riscv, and
> common-user/host/riscv.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/{riscv => riscv64}/host/cpuinfo.h           | 0
>   linux-user/include/host/{riscv => riscv64}/host-signal.h | 0
>   tcg/{riscv => riscv64}/tcg-target-con-set.h              | 0
>   tcg/{riscv => riscv64}/tcg-target-con-str.h              | 0
>   tcg/{riscv => riscv64}/tcg-target-has.h                  | 0
>   tcg/{riscv => riscv64}/tcg-target-mo.h                   | 0
>   tcg/{riscv => riscv64}/tcg-target-reg-bits.h             | 0
>   tcg/{riscv => riscv64}/tcg-target.h                      | 0
>   MAINTAINERS                                              | 2 +-
>   common-user/host/{riscv => riscv64}/safe-syscall.inc.S   | 0
>   configure                                                | 4 ++--
>   meson.build                                              | 2 --
>   tcg/{riscv => riscv64}/tcg-target-opc.h.inc              | 0
>   tcg/{riscv => riscv64}/tcg-target.c.inc                  | 0
>   14 files changed, 3 insertions(+), 5 deletions(-)
>   rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
>   rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target.h (100%)
>   rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{riscv => riscv64}/tcg-target.c.inc (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


