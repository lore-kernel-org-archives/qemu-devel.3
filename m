Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9190C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfPC-0000Xu-0v; Tue, 14 Jul 2026 11:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wjfPA-0000Xd-Jx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:50:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wjfP8-0000ze-QA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:50:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f36a122fdso1212595f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784044241; x=1784649041; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xU9T+E/CR6vOuPVwdM0D0NZW0cVuxQ9pv7viz+s2n30=;
 b=wCZvpK3zhUUABPiSDl6wYhFV07dS1ixjjt6r0UuHwZKS9GFEhSE6xvIhvz4Xg8vpXf
 o/ubT2BGr6Dyjm4z0X7XVy6oCWZRHWuxK6NTS4n9BDoAXFNxUSUFx0MEBSspSfgzSfvQ
 lVyFxvJm9Aal3gBzZH3wSaQrfxEoxkfv0RDZmp9IbE3OzLsTIMluMInO1ZQnKXprirHE
 C7NRESoFwOQ0PPb6kb82I9sS7hL+NehXUUGXddsH/Yql+6AJHYywJ6AOkOjf+AZYYsMs
 f8kBSaYbp9wW5+xb6c/NwLtRc5Rl505WGisC6J3M0s24Gnex9ujofbvAX4U50GFvFwLc
 gxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044241; x=1784649041;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xU9T+E/CR6vOuPVwdM0D0NZW0cVuxQ9pv7viz+s2n30=;
 b=rIegwrUUG4yVANct0J1DXvHpfioDwuIt01TjR0GqPEool33C4vASeO76rEX9uTB9ob
 vSFTD+AEqwFt22SEMl/QrhawGNUAvYZDVvXGLWM1eXDALuHf4UK6yjR/AtMsfoqzzs3E
 SxJCzNpNuAROy7ICAcgfxgkbvRSzRRJ6vVjMQ8U2Q1qA8O8Lu9pU7SGtf7+W2NwvBM/i
 tyomPMaUPURhjilm5WM/njLTSOOwVdN6aY0UHJgIUfaY5wo2UAtjNINOt2kJ/dGMztFX
 DIyKY8F1cxzzQgvUTlvsUENuswoNL+rSx2E7AiDISyjWaOPEEud/MpPkMBNELw1WBtgw
 b8cw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqpesewR4ABPwSAOglRPqGeRq52AB3LfdCgCGsWVCETFAj+4R3ZxZiOl1K5liwQ7BzIYnFfVoW/0tl@nongnu.org
X-Gm-Message-State: AOJu0YyAwpIN+uz9CD0Lz+P3blROmvHiJBCNESpQNdXvsJm6/QzenmgG
 EF7tSJW3H6ayP0V7Wv1y30Gy+7/xoiEzOLLwgsKmeh3N8CSmx5V7fAtxEGqzlP/YW3A=
X-Gm-Gg: AfdE7ckggn/XKlbR1VK8lseZAfjt32VKJGIamsjnuh2mEBGKnIQqEy/iw1SrVO94P/9
 m0qJ4blj2OTtggC2AANSR65SGeExwegnMdwVXL4wArY1NdnV7GqT4VND+gD/O0VQar0MBzRvJXz
 v3zh3rcJ8py+M+uWHExD5pm5I5Yi9gFBegGfS2XLWYT6XoC9F2UA2L2UA9H7CoTLoQDq+ng4Oxz
 JUWyDWEfzjZUzCSuu6i4Y8ZEv2mUbvelCuctr+DDUAmugInewvdD3gEQAgGfRYHUSPbRIm3MXbR
 wKUBC7RO0QLixJrtTmoQtAvBQcg30aE596ZGpCcE6g9g0VDoMsobUTaaYua9mN5j/CpReaG++ak
 AhAjhtPi+qOZF3W2YJGJE0x99G632AGKID58u6SvGCObEHGDqq2lbltv2RU3svCK83IE+UPPdKu
 Jsj4HjO80rG0HIdg==
X-Received: by 2002:a05:6000:240a:b0:46e:483c:2262 with SMTP id
 ffacd0b85a97d-47f2dcdecc8mr17464413f8f.14.1784044240934; 
 Tue, 14 Jul 2026 08:50:40 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:c8e:44fa:aef8:4850])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a63esm9581180f8f.9.2026.07.14.08.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:50:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:50:39 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/9] hw/dma/omap_dma: Be more careful about overflow in
 transfer setup
Message-ID: <alZaz6DQe4oMCvDn@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105907.2570621-5-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42f.google.com
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

On Fri, Jul 10, 2026 at 11:59:02AM +0100, Peter Maydell wrote:
> In omap_dma_transfer_setup(), the maximum number of elements we can
> transfer is 0xffff * 0xffff == 0xfffe0001 (because the max frame
> count and max elements per frame are both 65535).  However, we store
> total element counts in 'int' variables, and use INT_MAX as a "bigger
> than any valid value" sentinel, and when performing arithmetic with
> the total count of transferred elements we are not careful about
> avoiding overflows. Fix these:
> 
>  - use uint32_t rather than int for the local variables tracking
>    various element and frame counts
>  - use UINT_MAX as our sentinel
>  - calculate new packet, element and frame counter values using
>    arithmetic on a local uint32_t, rather than doing it in-place
>    on local variables that are only 'int' because the actual
>    counter registers are 16 bits
>  - use 64-bit arithmetic when calculating how much to advance the
>    source and dest pointers and the total dma->bytes transferred
> 
> Note that since soc_dma_ch_s::bytes is only 'int' this can still
> overflow; we'll fix that in a subsequent patch.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

LGTM, thanks Peter.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


