Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59527C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8z9-00056S-LO; Thu, 23 May 2024 09:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8z5-00055k-9C
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:59:55 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8z0-0000Pj-9n
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:59:53 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51f4d2676d1so7861572e87.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716472788; x=1717077588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b2mr7lVbeO+bj308APhWygOcy2XRVk5IKWekmqrcKgs=;
 b=Ugv0DaYJK8kU1AFZ4diJJnXB4YqxdihKYplqmT209nKgumbdM41R4cwP1C+dOZdcvf
 ivl0BYC6zxwTapN13GuBVMaB2Ev2tBuSj6P22aI98hiEiQtEC6kyUyKc+TQQeSZseKVU
 SWQWlPqcE0/wuB3dKSICe+vvHIea/k2uP4dZyaeuFUGUDlpVIGwUXcWc1xspp4PuRNul
 pdKsn0wcrfd6K1rIF9PJ1N6ej+VUKr0OS6M7PbJBwgi7bLhOCOtyEB58WtI1aITwYggH
 EiYkMOCFHkCkFWiwR29FXGgRqU3YZGciKIphT2R8gKu9lrnm1aQvTbZVLVxdh9XU79NL
 f03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716472788; x=1717077588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2mr7lVbeO+bj308APhWygOcy2XRVk5IKWekmqrcKgs=;
 b=j+XaJeZWQBkZWRJhFn0eGL549a4CIWaO7BW+urMRrbIGMfkfp139EB9pFt2Xc4/u3X
 dJRqM2FLyckVANmdaTet94pqG4Xfja26jtBiG6pvekex0iuUIY+wG5jQqrT8R3GWuU3g
 dxBFMU5xi//szyFgmDQ/1SWDuq3bvRHotzFQyTBT7CkAPBLrJgZaEcrmdO6Ce0+neNzt
 XgbUGZG/TjdB1VBow0z+TAgqi+REJTU2UXorNU9HChd47IVN1tRCXzG6cOgSSo85uX+1
 8zknOHcSuZhzkhZTozslwiSBzEuN45w3PIZa9qib0ETs+sI+cVitKiy1rgoYhiOawYIw
 tqdw==
X-Gm-Message-State: AOJu0YzNm1uUcsbwdotd2fJnlt37PmN6Ot8ui1wYYBLN5v+VQp4yhXWK
 Ul20zglAvvUq8qX4nsN9S0bTYrAnOpG0Bup8f9wAvxk48Yzx5KgXVxP/e/kkk44w/vq3zsRPCRF
 BIZcl923ec5WxaqqfqbZwAiypHn1+e3MmM0pwfg==
X-Google-Smtp-Source: AGHT+IEmasbpH6pkWG7pfPl1ski91uu7AeGd07FicnmMP7BjhZOmJa5QHnqO1ukxSg5r3+J60nkXcHpCc6ieJIvVEeI=
X-Received: by 2002:a19:ac02:0:b0:523:93e8:1ced with SMTP id
 2adb3069b0e04-526c0d491eamr2650469e87.53.1716472788460; Thu, 23 May 2024
 06:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-26-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 14:59:37 +0100
Message-ID: <CAFEAcA8DKEHkM9hhOQzvVh_5bvhfrQCff=XBraGp6Qw1Tw6HdA@mail.gmail.com>
Subject: Re: [PATCH 25/57] target/arm: Use gvec for neon padd
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Mon, 6 May 2024 at 02:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

