Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32BAC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59MG-00023w-Dx; Fri, 11 Sep 2026 18:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59MD-00023P-Tz
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:04:29 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59MC-0001iV-81
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:04:29 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so406835ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789164267; x=1789769067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6+qRxgg9E8CgchbD97qM4tTX7Ks8f5CeiQrZx8frWrY=;
 b=QxEUv9Nlf5rvcMvRb0ADVnMlY75Fk030dsHwGT62E1zJRm4xjoKc9xZmgDotnE3Nsw
 AZq/9/gUlAt/+KSCCGSa+V3VeqezVxlwNxYYx45OXzHws7rxmGygDUndNLr92O7+iqhl
 aRAWCiNmLlHD3O838fNLXg+5IPn2QzgQHNaGrhket2lFTqaHc0WmvqSJkZNod+zVrQO/
 1BqSl8BzsMZRR1v7iBqlOziiq9TNjHkf5USciXLRrxG4jRepJFwYc3cJXHHm6v/IZKEu
 LPYHAYehYg1FYlnnGunkXl6KCspi75ieYiVUvveax0gH3IfFhwwM4onUSZsA7BmoDdVC
 DBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164267; x=1789769067;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6+qRxgg9E8CgchbD97qM4tTX7Ks8f5CeiQrZx8frWrY=;
 b=n5J7nWMtCZ/PA5q1wD601nWZX4BNRwV7WEIWVyV90ftYB+mjMCjHGpXQUVx3DsXD+0
 e3NnBu91xDTkeRPwuGuPCwXJ2XwPrE/mOK73qs47UvIx/g6sFo30ZrOER7YDN9YtpBTS
 rk+tBEE7fgAgKgtlGJ8fDwS4Mm+98VYQNzVyFGRojQC/D6FspjowuZ1gg4BnpzkQoBif
 iX8crtr0pEBVzTiqYOxaNxOLI7Yt071xq6GHQhbTpOL6LwqyejjcC1i0AnxWwmJGGqxw
 q69F88YPhWpZZoKMhNa2xcQ+BDjKDJDesSm7GM+4DWlJ13w82f2+Q98wyTHXvtij4oDC
 +x7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByoJA1o5sLqnMGnSWRA1WiBzPsvYJ+yPpzrNM9fLWgK6QdBfIfsi4jM0eRJdzPLHVXE8dT+aGusWL2O@nongnu.org
X-Gm-Message-State: AFuF++npvVsxHKQze6vrWUInL5qfh2wU/Irsb/xesTFoLQiA0/lYw/5h
 Nf25LTyk+YCTtSiN593xMnW5JdPU8B9saWGnh2I74JNlkb4PpU11orZlERJF3Bs2cO/KSdbWXXo
 /nI1jsSg=
X-Gm-Gg: AYBFou0/srALXjMPzxoKMSaWYHuUxIMxv1OgtxcjC9dy62Ac6nrFsLfwvQSxZZIE5Eh
 qmcwQGPhRoF5ssY9UT7NNAZ5vgzFkLYQPsh0fAXXV6504bLBK54T0RmHbj/hzCJ7C8dmKeFk49l
 nkWXv3gvoQ7YgSXuyVt7rH23T533msuDQsznmTyOTSL4QIuxCZFaYHvYPahnYH+NxVcPNrSi1c1
 E6eiHHzvWIplNziHrrPdqfO87omfbZR6/cJBAr8ddQGq93v1X2+bA9E3D+LQY0UAl/A43/bMBrM
 9ndt3YfyZ8yzsGoFuhCejRDs9sh7+0drD43JgpkeOgMWnAwr9/OAIsteTuGaxmYxjhdqTAYVWSb
 i9bV1OLJO4m3wjSMuw4qC4ssDMcm767JG+kcXkxC9PfCzzTihyZMw0h9JfSqkreIG4d44bjdDan
 Okn3P9FbIgCVon0xpssJWcJNypmBjQJJZoVLJfASd0CBTnlwWl1JK8bQpYNkMREabmVjAlNlFh2
 ktLFr+jI2d6e+OJwvr1ZgTJJvsHhAwS/D5cPkfXptELFb9Udh0jyD4ObraIIfbacyn1Gg==
X-Received: by 2002:a17:90b:3c43:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39dbbe88dd6mr392909a91.4.1789164266573; 
 Fri, 11 Sep 2026 15:04:26 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33baf0ea9a1sm6203169eec.8.2026.09.11.15.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 15:04:26 -0700 (PDT)
Message-ID: <789b4102-31ec-4640-9dc9-3238d48cb2bd@linaro.org>
Date: Fri, 11 Sep 2026 12:04:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/11/26 06:02, Brian Cain wrote:
> The following changes since commit 209b2afaface001c7d4d981e38f186afe7b24a50:
> 
>    Merge tag 'pull-parallels-2026-09-11' ofhttps://gitlab.com/dlunev/qemu into staging (2026-09-10 22:02:18 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20260911
> 
> for you to fetch changes up to 8acc03787bd602dec74c0169cf8cf232356eedbd:
> 
>    docs: Correct semihost spec URL (2026-09-11 07:29:10 -0700)
> 
> ----------------------------------------------------------------
> Hexagon: v81 support
> 
> Initial support for v81, scalar only for now.  HVX support
> to follow.
> 
> Adds new machine definitions, v81 system architecture changes,
> new scalar opcodes.

Applied, thanks.

r~

