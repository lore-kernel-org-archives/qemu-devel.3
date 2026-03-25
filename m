Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A55109C059
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5TqJ-0004Ih-Kh; Wed, 25 Mar 2026 15:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5TqI-0004I4-0d
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:24:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5TqG-0006jV-Bl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:24:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486fe36cfabso7085785e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774466675; x=1775071475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vc60GIHlHJ7K7BgojGhgNekPvAMuVde2nVI2tZay2Mw=;
 b=w1YqJvotRCAOvB2odrFjosZNagIqoBfKgG2b81dU4wsXy6TPZHvjsJYrORliOTOKxS
 8Pg0k19/cktjV3Q0b1eY1DWvTQLCZojKv8CCNGp6oJ+x+NQs9t4r2yz3NQWuIR5TX65x
 kpwzGNjOok+zU1uJkaJP3X0Ed1jtZDNj14Cj1npsQ5m+R+7qxLJeLzkEdeIoohKIAchx
 gPUheLwEfDuGKTA30G+AhSOqyRur59hsetth+wHi8UC1NXYZwHQwq+vt9WJipGQDa1GP
 FPU8Y2kijymzB1FLZCW99uXkKIKYDP+GotK3enVOooAX1VjMrf2LNe5/TabG115JC3GO
 GpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466675; x=1775071475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vc60GIHlHJ7K7BgojGhgNekPvAMuVde2nVI2tZay2Mw=;
 b=piGdD91gK/4Mh1qBmH7293JcbgKIOUgjabnMObT+2BiYWGTWMb+QPIZWAX3alF80bU
 skont5sRNTAsW5Z+vVhI3DRUUcLy4I+oOeWxi90wjxwzvGhptwqpnf6q517685TQFXxd
 tuiXsgeho1nn435s1nyJjPS9GZOcWq8Nga4o+TTNKU+3CgEPfJO/VAaNg/Vms3WAC6jN
 HkwBG6h04PWd8CQr5NCVN6nr/5QzVtkWHKZb2TS+AHSJye/CsNnpUKs9fymXuapN6dvk
 T9oXLEVB9WFWt4lfo01cdo5Zg7MTH7JXUxgPMkcxyD+fErGw+f7P+QGE0Gpgxm44GDmK
 dv0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIoMQhi9SNQYF6QzPr7Z//wJSB4/ngnRxCVyvs331FbARNHnSSCTBHy2NFRxIZfEzLjDFn5hJtb9yo@nongnu.org
X-Gm-Message-State: AOJu0YyYsjwxHQUQiA8vSTcBC+WyHpmmbikcZem6rSaPqs5/FuwK03ok
 8bs30vGiMFbgXxjq9eFp9vbqg2XtJEWkt+o1ZS9ngRdT8To11QRmNjgJ/QhNde1O41c=
X-Gm-Gg: ATEYQzxBJ0VsVuH8mY4NLgM7cK8E3A6RsLEH/TqLwJh/+8u/lSy7g2XTd+s7yi8DuIN
 eSby73ZE5SuweH+0qV1EAQ9w1scgj40AN8Ct5OU6NQahIC8CxY0Klz4YVDlgZlPfaHWCmjuWxUP
 Je0JyknEepqmd6aamgwbTawrFWyLSxCulfnlH5EPhvL9bpvmhABXselCAHV49G3CIDn4zjsOOiF
 BDPMaAYNDR2zQ+zwG3qGNpcpVQv0HguovjJXY3o+vsn0HhmSZc5SjvNImumx44gC95M5gX4mnc6
 g7i8QqHmRyea/acJOuLYSXNbAw82YGbLS3prYJN2S563ed6aMgqw8v01HHpbzilLjvi2GoYYYFb
 Ul6pzHD0kzp9gnl5qMpYrkohPHcw7b/HB/M0tMpBcECtd2b2PQY+xRe+vzYR40pJMDyCY6JpQhT
 gGQ7zIhjgQB0g6PB2YavO2K9zIVE4n6DOfP1IvFKIegcY7C+ikijYcUtD5haEgah8+sw==
X-Received: by 2002:a05:600c:3106:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-487160aac25mr67862005e9.15.1774466674555; 
 Wed, 25 Mar 2026 12:24:34 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb382cbsm2381125e9.5.2026.03.25.12.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 12:24:33 -0700 (PDT)
Message-ID: <65ebb608-fe2b-46ae-bf2f-a09b39f257e0@linaro.org>
Date: Wed, 25 Mar 2026 20:24:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/35] target/hexagon: Add sysemu TCG overrides
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
 <20260311034923.1044737-25-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311034923.1044737-25-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/3/26 04:49, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu_helper.h  | 18 ++++++++++++++++
>   target/hexagon/gen_tcg_sys.h | 40 ++++++++++++++++++++++++++++++++++++
>   target/hexagon/helper.h      |  1 +
>   target/hexagon/genptr.c      |  4 ++++
>   target/hexagon/op_helper.c   | 10 ++++++++-
>   target/hexagon/hex_common.py |  2 ++
>   target/hexagon/meson.build   | 13 ++++++------
>   7 files changed, 81 insertions(+), 7 deletions(-)
>   create mode 100644 target/hexagon/cpu_helper.h
>   create mode 100644 target/hexagon/gen_tcg_sys.h


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 327c233c01b..d9d84f05553 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -19,9 +19,10 @@
>   #include "qemu/log.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
> +#include "qemu/main-loop.h"

"qemu/main-loop.h" doesn't seem used in this patch.

> +#include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
> -#include "cpu.h"
>   #include "internal.h"
>   #include "macros.h"
>   #include "sys_macros.h"
> @@ -31,6 +32,7 @@
>   #include "mmvec/mmvec.h"
>   #include "mmvec/macros.h"
>   #include "op_helper.h"
> +#include "cpu_helper.h"
>   #include "translate.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "hexswi.h"
> @@ -1412,6 +1414,12 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
>   {
>       g_assert_not_reached();
>   }
> +
> +void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
> +{
> +    g_assert_not_reached();
> +}
> +
>   #endif


