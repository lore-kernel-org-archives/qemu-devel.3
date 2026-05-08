Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D22CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOzw-00012M-Ql; Fri, 08 May 2026 13:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOzu-00011t-RV
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:28:22 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOzt-0005Dc-9p
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:28:22 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so1046392eaf.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778261300; x=1778866100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTXnDZQCOJhXXH8fEMl8WEakNQGNw8knKy4t21c3KMU=;
 b=eRduro3nPD2NXzuEe1tQAPh/67wHRhGEy3Sq7CYQJCLrPBQ/tsgSKr5dZEZAlFNPe0
 YBBehc/uWJgJKR/zy79Kh4NbGneFfWS3mq66HgYQoWjCTttUm34ARLmiFUC4C1Lvo+S0
 PhhpYofX8CwjCfV87v0E59iPFy1FQcJPnmj32IUUOXZ2BqDMk/Vz64aaqm71XzfXeL+H
 j0J13Urme4s1raDWksitxjlbGuLbQAOzjC4E2bvMAhDoVCpvGohDAhDUE81MG5I26msn
 U7rd143TkuALBDFL4WVZZaNXJIBHOROqw3WWlgkeDlPcPL8aO73jHjOoyNd7akL2S4ET
 gH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778261300; x=1778866100;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTXnDZQCOJhXXH8fEMl8WEakNQGNw8knKy4t21c3KMU=;
 b=lhM7mUGGPVy3oLhU1TBtIH32ROC+2LQf0B3Ubn9Dyy4dgANmga/+IXJ8CqLQw/tEGX
 nrkCw5bfBjzoa/TKZhfK5bb0a9/o91UhJMWF2geEaoY5xPNzrFj9Q17Pn5q6oRA8tqOc
 wSzpJRgD5nr3T5BmtoTkbTK+QlwHBQJj5f6hbwmaoien5delX6hfwiWG95s1mDMWTb96
 Wa9Pk1qfJzQAK1LynjoV56zzQPJ48YxaUM1uZBHpH8OaQj05EL81EI4rQMRaHtxQDukx
 GX516+J6esS6ydxigneJrKkeuCzDHpI4eiNhiyJ+EWli5pHvv4FcoRbXwJ8/mr4ltESM
 +CEQ==
X-Gm-Message-State: AOJu0YySbhIc91C5qY0npjZRm7mLoMoqujWjA+7R1zxzG1fECdDAarXq
 doOg1scSRmHEebzNen6LJPgSY9sBDCEvzOtzK97Ld9Nilnt9CAIRT8XMLE7fuNcJ1IwrwY/CRfl
 avpmw
X-Gm-Gg: AeBDieug8P3ZUDoCYRbIVgBVLJdhMTPhUoNRgIPNj/dSDFBnJWexrE5D+4Ekqd2q6x2
 ZdPNuSzu0rl8jjTowXRmTRTr8qWTwbYHohCabbAHx8vaJerC3M0kiTya99p98WedpF6cNoeHQaK
 nByumjL4jpysvG+YsTm5vT4ina7RATAILVW1MXALr62BIp2leq+m0q+ShjVOMCgNcTa43WLdFNx
 VAmQSUE/c4dvM2BZOFn/ZDj0BlZ/wp75CQbZG94XY9ToW55wqmrIxMvAsDBmIQRZNAbfXXiAwqN
 +4Gt0CzlWpQwxt87keChZ8LJxdrgrQ0IpCR0HoKFELKfh1LrGH3FC4ia8i9Vlr98HV/R6STdlBH
 9ln5KdNoW731HO7vi1XCXYl2XGmclShYIxVGTE8XYEpzi7Aq1xJrvPMbF5wP1Z/o6I2YyvQKmdN
 wXHYYsNIuWhsOi1RkD84ZXgyrRNOE2AHJOfnNTP4AMfY0OmjYg2rH7ti+ZEqOtXHf7cDw0Jln+6
 yPpGTSJm5ICNq2SN+nt
X-Received: by 2002:a05:6820:1c91:b0:67e:42ca:bf0 with SMTP id
 006d021491bc7-69998d173d6mr7290014eaf.39.1778261299877; 
 Fri, 08 May 2026 10:28:19 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c1ba56sm1406512eaf.3.2026.05.08.10.28.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:28:19 -0700 (PDT)
Message-ID: <bb1d11b8-7b2c-4fc0-b83a-5fe8d1a968eb@linaro.org>
Date: Fri, 8 May 2026 12:28:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/32] target/mips: fix Octeon arithmetic destination
 handling
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-4-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-4-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/8/26 10:12, James Hilliard wrote:
> BADDU and DMUL write their results to rd, not rt.  Route writes through
> gen_store_gpr() so rd == $zero is handled consistently.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Split the BADDU/DMUL destination handling fix out of the Octeon
>      arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Remove the rd == $zero fast paths and let gen_store_gpr() discard
>      writes to $zero.  (suggested by Richard Henderson)
> ---
>   target/mips/tcg/octeon_translate.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

