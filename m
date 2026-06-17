Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65880CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrcE-0000i8-Qh; Wed, 17 Jun 2026 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrbu-0000fw-DF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:51:30 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrbn-0007vI-Qw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:51:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36da151a152so4180344a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781707867; x=1782312667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WYemxzS8oIfdXRpcGrHyfNkpyGVjpdK45RZ2HLBL3+I=;
 b=xkOF1DDxx7LkiGMqTkMHXw4s0UADKprCSpQGaTsXrS5OkDUN1ZW6VY35hrpwJv/RlF
 8JVkwVhRhn38F4Ox69/sE/qR0+/ZLFNVV+XopKk6/Ry64dIhqCva2qOpTxU+XOcRozFI
 lRaZsd8gcidYEOjWRhI44lJK7v0xS6/QcqZqmhPZd1ZC5XPsLOKG3mI2H2yCazS+t0fy
 teYVj27SusaKiBShGblK4pNXyOnmyErx8WZPj2fQVzkvSoj3Ah9TznEygbdNOb/qvwFk
 w80ZLdtjRD2ldpBWLuKpPpFmp6Rn1F1AwA2wh5y9qwzW5vPNdN0lTgbo8qvsbaDVlrNN
 3XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707867; x=1782312667;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYemxzS8oIfdXRpcGrHyfNkpyGVjpdK45RZ2HLBL3+I=;
 b=R+iz7y5vhEL+gQKYlsewkdJY8MLrN6vDAHxYFqLUL2mw/3oqOMxVzsdXgyt2OosxzC
 /Hs57F7XwiVfsfkX95puJtOTf/MieuLD08hBxgEzofGQODuYTyOhAV3DlwqWUzj2Gp2l
 EZW3X6Ra/dhLaWdFg5umTgkF5+Xr6czRQ39+kOIfnY65Vb1HK37wZ34pRJpOkHNILAlY
 iz6RzjDSa+7Z+cthiI/vaUvPUaVwezNX99T1X0lfWKsLH2kF4kLG1iRIYx4q5k2QQWhQ
 bsdJGOKl1Sk2i/+nzJ+49NnWz+3HvvaCAIDWLDHFnn+UvBy0gPVjZ8cIdI/REU6OmuqR
 sOnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GV0uyP91yE28Hoc0GMPUG6bIPhOZPIF/wQv9vL6MWQRRcObMVukJYpv2eWNw+ra2KYL3SNNhDi8cZ@nongnu.org
X-Gm-Message-State: AOJu0YxHrPouSjI5TJyEi0vXXR5JG7TdemHipSADPYjkqp/sQfsCBcm8
 sJwzusSx0bo/APlKAbVJKMFXZqiUQboVEOyAv1iGL7EN9BGYpgWlBxs/VK3jNOFCyhQ=
X-Gm-Gg: AfdE7cn2wCfqDdceBR7N5OIPZguP5v++Y2UkIDR0GnbT0hFSVroLv3it992ukH8x5ck
 cI0n8aC0gHXTdBxOtOtZFgEpEMnbWtRa68RuqCVJLV+jiedYzG+f4AXN5yOzBuY62/72wDFNFPu
 1+/ZGlkCiFMvb8+KdMG7ubOSl+q9di4c3zKVTnipEz1L/TgE5DJAg/mqM0Dc8YLvn23XbgrRtCG
 LKWGNo9i5zPt6j+voWjHda1CgxduGnTEFWWyMaG0w5V8Hu23xwVwKu4eEaks5k/LAT+oh+bAEUT
 aNEULSLm60D63NwwjQ44YQNezxFWMzKcWC99t+SSJFGHyl7GPcsWwuWtiBHMTL9w7XLfIlnOIuG
 EcTRkAkz4Ht9a8mAOiSuoCBbgLhquHHOql1tI6yGR7ARRzmGnvnJOl41r1Dej8/VYkR95tkBEG4
 jbP3YFfVL0h4wCeQ1pZDgXL5D40x7VSj33nk7KkBiVrbUz6J1w0Amd9x4Zrw==
X-Received: by 2002:a17:90b:5347:b0:36a:7c8f:1423 with SMTP id
 98e67ed59e1d1-37c933225bfmr4598176a91.9.1781707866822; 
 Wed, 17 Jun 2026 07:51:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ca7a7sm6350396a91.7.2026.06.17.07.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:51:06 -0700 (PDT)
Message-ID: <05667f78-bdf8-425b-a242-4c1aa21e8626@linaro.org>
Date: Wed, 17 Jun 2026 07:51:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-3-philmd@oss.qualcomm.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
>       case DIAG308_STORE:
>       case DIAG308_PV_STORE:
>           if (diag308_parm_check(env, r1, addr, ra, true)) {
> -            return;
> +            break;
>           }
>           if (subcode == DIAG308_PV_STORE) {
>               iplb = s390_ipl_get_iplb_pv();

Why change these return to break, rather than just return false?
There aren't *that* many places where reset_requested are set.


r~

