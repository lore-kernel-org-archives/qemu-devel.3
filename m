Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DA3E6FE22
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smac0-0002ef-V8; Fri, 06 Sep 2024 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaby-0002dz-Gf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:10:58 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smabw-0003o6-VA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:10:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f50966c448so26232171fa.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725635455; x=1726240255; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8S2qBXw58HubFPjgYvZHdTrph5ldqi+E2lDd4xVTbno=;
 b=Tq6iek+1mBbcaKyFcciO2sbAhS3n6g4sSwlCLMzu48fI7kIkpZBEfQRjWvBjYwZEJS
 52k7fFupLeQnRAZm9hiKW1bm5Kqdh+6m7LfJUwip1Hqm30yYmJL+yBaQpmGgUoCnoar1
 oWV8Fi3ZR6A2AGOaCkjIihyklOeW/6uBQe/D0J5kggZ7XhrPQa1iQaxpeVBajU2gGM5B
 B3oNhWsA7W3YT529qFwAYvg2JnUgMXe+C0NWcmWorljQgeobZTT1I8CumwUzKmFtCMyK
 SPpcKJdRb3GyL6INqY7ToLnZfmaMYd4ugMhl/c7NV9yxMI1XFA5WQBrp4/xNq4e13y8p
 WVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725635455; x=1726240255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8S2qBXw58HubFPjgYvZHdTrph5ldqi+E2lDd4xVTbno=;
 b=cYKhqsvKRreD2GWpCm2FH+LjTVdu5sAbBSmZ63HvmwM9jUWnpU5ro2czGOty23wIwb
 q8JB+Stuf9j+oGFEfEjl5UhfJLg7IDjtGBuIg5IGET1SLNjfM2yLB+FdmADVg36K40fK
 1QIdRB2leO6PqGgQhvGddzEhCpwNEJBhwKDCSN075O5hiwcCXMbqh4WI/RUjIwu4+XYu
 GS3wG1uAi5sq8cojExpuCLDRkmHdZJIu6nhNeDMwI04pnQHQxtT9k0e9mDnicXhAdGev
 8J3LQzq7qt3GUWNmQaVImg9yc69fUWd3ukMi4th/aHGauj0wNrV+jBDhG+pr6EZgwloi
 FxaQ==
X-Gm-Message-State: AOJu0YwkVKVkiMP/Rz0JEPLVJQh45owiURwzfu2Qi3G7EFWYavUf9ac5
 UXcIwcP4t+1F6Lum8tvQkoGEb6C29PHflk3O56RakMkkyOCA/5B54efdfkrZGrkl7h+n0x6+BKI
 YPrQKGpBFXURJV8NG3xK2BeDmp5XJqMiRO3bXeDpLGqKoufCh
X-Google-Smtp-Source: AGHT+IHU9oRqXFmXUlVrJ24k8zQG2Fl9TglgQEvC6NUptLFeFIoEJ1JOOeoN9dLMj11KVdui77AK9U++cj5gXFSSs1A=
X-Received: by 2002:a2e:819:0:b0:2f7:4c9d:7a87 with SMTP id
 38308e7fff4ca-2f75232641cmr20319311fa.21.1725635454537; Fri, 06 Sep 2024
 08:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240815131206.3231819-1-peter.maydell@linaro.org>
In-Reply-To: <20240815131206.3231819-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:10:42 +0100
Message-ID: <CAFEAcA_cpkdKTvm5Sx3AwvMzd9+1umvwBpB=XLEO2ULj1wiHzw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 0/2] accel/kvm: Fix two minor Coverity nits
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Aug 2024 at 14:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset fixes a couple of minor Coverity nits:
>  * a can't-happen integer overflow when assigning from a long to
>    an int in kvm_init_vcpu()
>  * some unreachable code in kvm_dirty_ring_reaper_thread()
>
> Since there's no actual incorrect behaviour, these are 9.2
> material.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   kvm: Make 'mmap_size' be 'int' in kvm_init_vcpu(),
>     do_kvm_destroy_vcpu()
>   kvm: Remove unreachable code in kvm_dirty_ring_reaper_thread()

Ping for review on patch 2, please?

(I can take these through target-arm if you like.)

thanks
-- PMM

