Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAB606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vmWFOMaz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvlz-00008H-20; Fri, 13 Nov 2026 13:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvlh-00007u-SS
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:12:58 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvlf-0003j3-Ur
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:12:57 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b4a2688f96so16790007b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794593574; x=1795198374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L7JIqzh9T056hoBY/NcIzaEtk56PSlTDLOLr2llVqSM=;
 b=vmWFOMazI3kn2JrG41/xnk+0v6GkbeDltnWn/Qfkq3BTvJwUjSwvxWrzzb2x/eAWSA
 7SY7XYBa5bnbwc60MZZRijrLLjiV/ig7NxOr0egZ93tGjON0Vu+sRw79c7OBG0bQ4r3K
 T+DXhUB1nkA09IXYQ+kxM3Hndg1pQvyATEPJKtAVaSRzpuvTKfh0JS+v+k/noF4kterH
 WsfVSlc6+40hHfu5I+9bDeql5qrUo9HnRYeZRs5aYFEbBhnibV14y7ZMsj8Wy4ohJkoD
 LjTuwe3vX9wAeQV17Vj0tXxracMr3UFaL8/DS82Z5l5NBpyGsiqoM+26RBEAIWQbEQ9i
 HJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794593574; x=1795198374;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7JIqzh9T056hoBY/NcIzaEtk56PSlTDLOLr2llVqSM=;
 b=HAYGGt1YIz1ZYRsp9jZB8LTVfgnuvtf2b63wSSoA92z4HazkSqxs6JepWfSKM0A2BU
 szwjBlgrXBqqHhTr0bYEPbF10fKDDPUq8DI93snyT+1KGUMf6K5DY+WFP+2ZSNi5r5UG
 wuwysT0iMsRcAUpjPzo5jsh35PsHxQTNELG5GiCUbIh3s9qIJlRnVxAosGQanNEFlZYB
 e6zSGCV+AKiRtuagO9AgHULRqpbn6Ac4A9Wnht4cBmo1JWraz4X1nSwdktzDs+qw8Qbi
 5kEWGe0J2Ejy5t/1nxr0QK7gV2AVQJzBYcLQRa0g82mE0e31lu5OF35dSef6GJpF8xgb
 WEXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF/QKBP6cKo+k007Vr7Z38mwEpkJowryNWhBhYOEsBA7mj9KpIEcFKadP5z7QA0W8baauo2ppw/jsVN@nongnu.org
X-Gm-Message-State: APuU4Z9uaQUecxLs4pdeT5n6WBi9N+69QTp18bg10+f4cU3+Z+48gqSc
 Mp7JREmua7YXIsgsrmYS/3uyiV2L2Y1lHynqMG5bLV2HB/8Ju7DDLK5IPx/ZaiLUu80=
X-Gm-Gg: AYBFou1Xs9lyvBBbtv2v0ZLJO62ueVUQ22anhO58aY5z0IPZYHuxjOY+3RyijV9cJIJ
 MkL0XSAe+defZWNuWF5krf3JAQ+Eb64TFigZcBV247hd1+qXtLr7WOtEhtRg24pxV8eb8haC6Yx
 vuYeUX8M9QtiGeLNB+YOuFKC7X7WZeroO9HemdqrE+4GpHHe4tmOzh6RiPn+ZXeDjxGWblswPsK
 iOEdIvxAlrd1UIZM9I4Y9ofVf/NvCOMz4W44XWDfRG2L8BRu4FbG4z6PE+lIoIwkGvzrRJhAsqv
 gBgMzZa9ZQYD27eHPLGs1O8dOGMpi2/+gOaIXbjt+ABROCJ4K3H0NONVQKDhdHwby3DuBo3PRG2
 M/nlz0lvFW11phXZ8FYLar069nA7uLmEnkccxFFWFd/+IQvko9EOvRLYU6Uwy5K2dLrUsIF6e1g
 ff6qI9gG2TQA59jpuvpRzGE4Q/uH3vNSee9Nq4gdAu7u59zrBmxfHM74udzkfatpEdEN6kWJJIf
 3wAOTz/1+eqfmWxNMiqYyO5DLt81dipnD44YHS7FUKe0Dm/6AAm2F8kzXb4uAJoBvudkdEP1Y/J
 dOlABT8PZVMKtk4RKf0yB1ZpeCGkFhgDrzPId3U1ddI=
X-Received: by 2002:a05:690c:fc2:b0:8b1:69b4:b56b with SMTP id
 00721157ae682-8b4aa0cff04mr22717397b3.8.1794593574530; 
 Fri, 13 Nov 2026 10:12:54 -0800 (PST)
Received: from [172.31.6.230] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa96b441sm26355247b3.23.2026.11.13.10.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:12:54 -0800 (PST)
Message-ID: <4a2dd42c-fe8e-46ad-a74c-bae94d088be8@linaro.org>
Date: Fri, 13 Nov 2026 11:12:51 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/i386: emulate LAM in TCG
To: Tim <mdspan.github@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com
References: <20261110130108.706228-1-mdspan.github@gmail.com>
 <20261110130108.706228-4-mdspan.github@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261110130108.706228-4-mdspan.github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 06:01, Tim wrote:
> @@ -581,15 +581,35 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>           }
>   
>           if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
> +            int lam_prot_mask = 0;
> +
>               in.cr3 = env->cr[3];
>               in.mmu_idx = mmu_idx;
>               in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
>               in.pg_mode = get_pg_mode(env);
>   
>               if (in.pg_mode & PG_MODE_LMA) {
> -                /* test virtual address sign extension */
> +                vaddr masked = x86_lam_mask_addr(env, addr);
>                   int shift = in.pg_mode & PG_MODE_LA57 ? 56 : 47;
> -                int64_t sext = (int64_t)addr >> shift;
> +                int64_t sext;
> +
> +                /*
> +                 * LAM masks data addresses but not fetches.  Both install
> +                 * the entry under the unmasked address, so if masking
> +                 * changes it, keep only the permissions of this access.
> +                 */
> +                if (masked != addr) {
> +                    if (access_type == MMU_INST_FETCH) {
> +                        lam_prot_mask = PAGE_READ | PAGE_WRITE;
> +                    } else {
> +                        lam_prot_mask = PAGE_EXEC;
> +                        addr = masked;
> +                        in.addr = addr;
> +                    }
> +                }
> +
> +                /* test virtual address sign extension */
> +                sext = (int64_t)addr >> shift;
>                   if (sext != 0 && sext != -1) {
>                       *err = (TranslateFault){
>                           .exception_index = EXCP0D_GPF,
> @@ -599,7 +619,11 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>                       return false;
>                   }
>               }
> -            return mmu_translate(env, &in, out, err, ra);
> +            if (!mmu_translate(env, &in, out, err, ra)) {
> +                return false;
> +            }
> +            out->prot &= ~lam_prot_mask;
> +            return true;
>           }

Swapping translations between read and execute isn't fantastic.  You may 
get away with it for the most part because rip-relative data is not 
generally stored on the same page as code.

Better would be to split the mmu_index in two: one for execute, one for 
read/write.


r~

