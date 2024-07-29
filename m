Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DCBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYS6K-0008RD-NE; Mon, 29 Jul 2024 11:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYS66-0007Tw-1X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:15:41 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYS64-0006DQ-9u
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:15:37 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so54428401fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266133; x=1722870933; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BKuqbZOXAboBHx1ox4X60UNfaU6nkT1ePbeK4FEBPyY=;
 b=GFs3sGdmMRkreX0FDgPIMQkBQzrzF+JhuW7yYi29tr2IavW3Hl+tFZJ4Gh4FAwE29T
 XXVNfRPPGIf9pT4Rt3jq7yoNJjoMZOi6c9totnPgWgZVIHvduNn1jOJdLCAEKfYXZJN1
 5up+U20P7XG9wnry0WdS8NMEYArI281arnYJN6njzF33CaQrN+0Ts3PGZb4BDv2WGjfL
 DuyIqDy0FD0gAMzpNU6gWxwXtGh8p3+FAIexUQldAtxr2Z0xW5jSTmCpE9pHbI8MY5YO
 XLcanmBldnMQUFmz1wfQnILnmZ8NUdcfur7EicVhBF7L5GmVFFwYgK6x7+EYm2Mi8yr7
 3Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266133; x=1722870933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKuqbZOXAboBHx1ox4X60UNfaU6nkT1ePbeK4FEBPyY=;
 b=mHCtRAFNhkOOsV6TjqmWZIiD5aWFm9CZd0l3gEyEU4YL/4vaSJFWlwR1I/+8fEJnK2
 uajxVpVZ5ZmwvnLchWjnCGgBeLaPPZQOnnZfbpchGjt02htxSWqNjJ+EkmOSmwXL/NEZ
 MBy5sYUlaUe3JV6jPUheXfMPYZzIH7UqRKotO7/5rAbVNCiJlLBpoOnxjg+/JulzllOV
 hg1Wrz2VO+LOu2kqm9eBfuWMqpchGvT09GSz8elTf2eBzS1fQvIx10kcAlz4u9LWMB8e
 9j+fmdgDTA9QfvQuno4wG2NmmQzthXKNDjeLrTt1bgBndHH0w7yuMIxa+Z5UTsKvB2Yt
 Metg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpMQnYrPB2ANJSffSuEyCE2/qj8VyNt+t9dHzgQu+IYw2i1eSFE4I8da9jjvA6W4+uPSDKeZuR/gJecmrXD5QXlYOEP1M=
X-Gm-Message-State: AOJu0YyCHYz8COb0tzesSxBzMlMbtDreoNB/+7qCJ92dgqpZ8W7I1XHn
 bHne8ALUuDyY+iWEnERG5CWuMF1NgSHrRYTbuNQhaHr94YeCyBQKM404EGMkLL4ucZgznCla1Np
 vQ760uj6Ge+0a8oXpEfhqfMbTXodH6i6Yv6CEDg==
X-Google-Smtp-Source: AGHT+IH6NpqeyCy53Urzjt7DAz1mAGiYBBvjPwebwZmqBTOauCa8V/qyDGsSedppiqHaYqy8RMHdkT7z1Q9117GMDBw=
X-Received: by 2002:a2e:3208:0:b0:2ef:2422:dc21 with SMTP id
 38308e7fff4ca-2f12ee6322emr66771801fa.43.1722266132405; Mon, 29 Jul 2024
 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:15:21 +0100
Message-ID: <CAFEAcA-ReAnVnq3WCZGEvBhH03gmwANC8TaiwMx5K6y7wQGRZg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/arm/kvm: Report PMU unavailability
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Sat, 20 Jul 2024 at 10:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> target/arm/kvm.c checked PMU availability but claimed PMU is
> available even if it is not. In fact, Asahi Linux supports KVM but lacks
> PMU support. Only advertise PMU availability only when it is really
> available.
>
> Fixes: dc40d45ebd8e ("target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport")
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> Akihiko Odaki (6):
>       target/arm/kvm: Set PMU for host only when available
>       target/arm/kvm: Do not silently remove PMU
>       target/arm: Always add pmu property for Armv7-A/R+
>       hvf: arm: Raise an exception for sysreg by default
>       hvf: arm: Properly disable PMU
>       hvf: arm: Do not advance PC when raising an exception

Thanks for this patchset; I've applied patches 1, 2, 4, 5 and 6
to target-arm.next, but I had comments about patch 3.
(Let me know if there's a dependency that 4-6 have on patch
3 that I've missed: but they look to me like they're
still OK to take without patch 3.)

-- PMM

