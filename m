Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5E606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bfDtOCCx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO7J5-0001Qv-Tl; Tue, 03 Nov 2026 00:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xO7J3-0001Q9-Ob
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 00:43:38 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xO7J1-0003On-RA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 00:43:37 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so3174443a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 21:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793684614; x=1794289414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=etpPhYedKb7zx1TJ6mdba+HSFV+WBdXGraJsYX9qIIE=;
 b=bfDtOCCxF2/M2x5rxp9WVtAzX6HTJbPeiyrgS2u9E4sOBlz4kQ2/aR2+ADosCnyTiq
 Z/LLAmqGo+sGDLfzqug+hKajo78HVbkyHJbJkhpJCBxaf8MyKKuohPCsWgzi/AKYF1RB
 9HyvNf6j/xT/sSOS4cMlQxQErxiqDxcaD+PSbxAShP/SebW+JmYrJo4gMzxZVo3W/C97
 O0AIQ7Y2IVl/GBJVrkFEE8yegeNc3SqyK5dJHmZhsJxbVtbPa69S6LdcHMvhKmfvIZl6
 6G5B9rCfJimEaJGPb/c9E8tU6IReDqAUGZMQEGRYCbn5FcVPdZ889j74wAPQ35y2zCrN
 m5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793684614; x=1794289414;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=etpPhYedKb7zx1TJ6mdba+HSFV+WBdXGraJsYX9qIIE=;
 b=kYEvWu/sw7q/KVwMwivnr1zc3iPV4GM78Ru7zBunFUUFf372gHj5P2Sb1fjeu5oXw7
 lvHFNDP79Py4ZdRrGeCaoN4+X5B9LfpyvL8/aG/1l4UHvoOHi1FD2Ju4tCaGdJvFuVPG
 WFswvZbktyFsEUbQtp94HnmiFwRxROIwi8TKAW5tBYHtcn6CxcMvVthWDw1SBOUKH+3O
 JICwLikEazwJMRpoh3YJMxmJ+0d3HJsvE2mLEU3WjH0WTcfirNKJXzDWzlpqilZ3vGO7
 m3ZK9OOQGTqylF699KHb9RwUntEn7PsiTrQFiaol0Sfhed8NiDGWjrvZp5f42KZBW/KE
 y5FQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgkCPuqd5/w1q/8/+9jF5ZHgJrr4VPyftsRaijvx034qz2M3CGAOVdjzvEm148hN42ac3GLJspo+qA@nongnu.org
X-Gm-Message-State: APuU4Z8hkyrByl632ISZOrpXqZNZqNWJK0OmWrB6zBFzkYSlFPpUaBem
 WGo+7MYcslgrgj28/kJeCQ7gcX0dg0Iym2GmoprSArAZFpuokqdmJHrU7gjeItVw9rv9WqpCQNF
 LTJb1
X-Gm-Gg: AYBFou2Ca4Rm/+lz4a3/6mBoHTbrqz/7gdyYbutgGlN24dW5FO3qadHJ5OVaCKdF3MK
 HnZzszodhp5nAXo0k7E5std03/ms4YVcxov38CkCjGGjcnsbxTX82dS2RHYr88dBIUhYzt8VzRt
 Zan2oxTKhrk2Ka8iFBbyQIcV2rPj0FbmSjR3LQalwFKLmaTeLlQDh7DLZ46KpHyA9JsnirBXNGx
 6oTi2vu51O8W3DrJYsK7Ey1e6a5rJRqWZq8WRjvmVb0oFdOz6b5L1qwgZwUKfB1XCVWxr3O3y5+
 wcrsqptwIxCsV+cPN9/HXkvZMX+rF9y071HnXkZ1y2jhf1xb3hEVNIV3QNkOntVlcQG+zFUXne1
 YTwEw34rrv9Tm9PnH9Lc0q8385jYeLi9zGexWFsskMKpclpM+Y6ZnL4oebYFqGxwGXMpkQ6rVvy
 5qFw+c7vD9KWisPumxk3qjtF24cesUFoRWxI6PjpgD38XmJ+aAhyLXntd26Gx+KyB90ZSbu0fUi
 8qk4f/+xs36uZGAG+KWwS1+prIpovLmgJlguTu4C4lMBDXGRAS+mKTev/1PdFeqI4/TTK++5Dp5
 KENLcNbwb2OaoAOKmKe3LNcS0rUOov6dT/WHDcV6v2z6onLV6C+87T8aAfjvIGTkPzRpLoE=
X-Received: by 2002:a17:90b:2b47:b0:3a6:e901:e79b with SMTP id
 98e67ed59e1d1-3ae897eb360mr9829335a91.15.1793684613590; 
 Mon, 02 Nov 2026 21:43:33 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85d24261sm9954136a91.0.2026.11.02.21.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 21:43:33 -0800 (PST)
Message-ID: <b8bc4430-c1c3-493a-801e-64f0b1ed6785@linaro.org>
Date: Mon, 2 Nov 2026 21:43:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/46] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261102170947.1427046-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102170947.1427046-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 11/2/26 09:09, Peter Maydell wrote:
> Hi; here's the target-arm queue for softfreeze.
> 
> v2 changes: drop the hvf patch which broke the macos CI jobs.
> 
> -- PMM
> 
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261102-1
> 
> for you to fetch changes up to cbad21fae0c451b1e2e50bb503d7af121454b698:
> 
>    target/arm: fix bcm2835 migration issue (2026-11-02 17:07:15 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * raspi4b: Implement PCI and GENET ethernet device
>   * target/arm: Initialize SMCR_EL1.EZT0 for linux-user
>   * hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
>   * target/arm: For linux-user, prioritize PC misalignment fault over insn abort
>   * net/tap: Avoid "close(-1)" in net_init_tap() error path
>   * hvf: arm: save/restore SME state only when SME on
>   * hvf: arm: advertise ID_AA64PFR0_EL1.GIC correctly
>   * target/arm: Refactoring preparatory to ID register configurability
>   * target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1
>   * gicv5: minor cleanups and bugfixes
>   * target/arm: hold bql when SEV sets the event_register
>   * target/arm: fix bcm2835 migration issue

Applied, thanks.

r~

