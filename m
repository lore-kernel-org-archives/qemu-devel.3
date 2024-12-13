Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59D4E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7k6-0001fZ-SC; Fri, 13 Dec 2024 10:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM7k3-0001Xo-Rc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:38:11 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM7k2-0000sA-Cd
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:38:11 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f006748fd1so16049217b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734104289; x=1734709089; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mN0yqVY1KDnKK1o5pgOp0bfTzpFP36gE7pPwo0cfA2g=;
 b=D5wzMsyxLDUjkwee/MXbp9DBqI58X/IYK4Idp+AwRicnQ78dGB4EGASNIQeGa80/tj
 94Coc5xoeB07d0+NpXsslCgKKmaYRP495gFVoPMIX/DKHJF7TG9el+5JfZw0ReYmxb/C
 chlMKfwCikCAlpfUA0rVpzbhGDLUwWLy9iEcm56E1j0jOmbQSK/Ap4kUdzH4er81xJWO
 3Jt0pfZ5x+RF5IaAyFScNY+a2s8IHeX/bwlZw8JC5KevbpK/KL1W5nY1pIt7Gl7E/pAm
 YFCrYUVNTM3DqDMvjWijdowlknRMn9gYzFyyi/5q19O+WeZxBizxcyv9VjhIw2jdUUWF
 /9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734104289; x=1734709089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mN0yqVY1KDnKK1o5pgOp0bfTzpFP36gE7pPwo0cfA2g=;
 b=lBhWKOP4KHAtU3z+779rjhvam7kjGLlQCtVv+Lpf24FzCTfa4rJs7tRZ5u0JhFJ1pS
 VvkiWsDi0tU5zXriIWA7xvv2qYH746aINvqXn+xrcHnK62KNxwJRoCyn/PRPIWHEz1/k
 9TXsoZ5E6jkAaXwNNspo8qU7KKcUpa0cewrvz+bn9ceHsC5/5hLF+D+800srU2xV3tLE
 ZLKtyGPvb1DnOP6D7OltDPPRxmJmm82ZsJSjQXJAOMziT6szyvrfMPPJLZnc+uY/HazS
 063l/4znZ5gi+KulByzRZ2NtM/gFXiwEu5LqqVkNHZfRUDYPXvuVM4T1N5rj2QUPUgPE
 XnNg==
X-Gm-Message-State: AOJu0YyeCYamomw9WBiu4v+llTJWNs3pBuDCttReM5dg5Wn4mxhBT3vQ
 /BCJ55zSBCke29y7VyFzlYsn2PQB00vQOmuyslm2lbrNuqAulSifGfKAeXPiv1sVn8837qHV9KR
 CnWt7pHFKMHiNMllMdxmWvls75MBB5pbq3lQiOQ==
X-Gm-Gg: ASbGncv4OAyeDhv1wpCPOTvFKG7NOeCFuC7mcVLLIUJrEWfLVmnhLH69dukcin1lhsV
 pHEDmxQZO4/FmvQ7TfKnzzL41WbrYd6Vt5wwUKRM=
X-Google-Smtp-Source: AGHT+IG1qLGkLmokYc6i7PxxBs77FOccN4Tpv064qMnC9dfoWZbiwf6yLqf0Tv3DRXbFvuv3txk0brc8IOVojV90/7M=
X-Received: by 2002:a05:690c:b15:b0:6ee:5cf9:f898 with SMTP id
 00721157ae682-6f279b75052mr30419777b3.33.1734104289121; Fri, 13 Dec 2024
 07:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20241209181242.1434231-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20241209181242.1434231-1-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 15:37:56 +0000
Message-ID: <CAFEAcA_bgd05_+ga-DJ-Am-pGjUYYAEew-azH0w-Wr99viit+A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: correct my email address
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, 
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 9 Dec 2024 at 18:12, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> Mea culpa, I don't know how I got this wrong in 2dfe93699c.  Still
> getting used to the new address, I suppose.  Somehow I got it right in the
> mailmap, though.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>



Applied to target-arm.next, thanks.

-- PMM

