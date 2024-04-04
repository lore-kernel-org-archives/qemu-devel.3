Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7364CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNvO-0000GU-V8; Thu, 04 Apr 2024 10:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNvN-0000Fs-Lw
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:18:41 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNvM-0000CH-8t
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:18:41 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d4a8bddc21so13503711fa.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240317; x=1712845117; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CBfrbWGzHNlTS4XQeBG+TQjAbkM8kCVd3lntc5GmhkU=;
 b=JETv1ABEcpasW/A2n/Y8fNKqFljKodGP1SJf43tEPvKiXSyUQz4QvlQwotNhmqddDc
 i8VoLb2EwJjzdxNjhvC8l7IKc1u3gW1Go+K2CoPUyk1QaW3zi8UfHPJd3yzuZ3Px+cHf
 /aQKhpAipA6VF31T37SsunT9iG6P6vaKGD5TptKQB7H21+x8eGS9+7uewjaQYIsvWoea
 HYbjnHOqz3l0tayCnY58oufymPjpkesYrUWag9nnt0+DnZ0RQr7ZdxZVRLEX++0csIQ9
 V+5gKyca7djLQSIF0M+jbcAmE/kEYrnIBgLONxBcmzHh3FwZzQfTxX8HPCZ4pBydlq+B
 Yl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240317; x=1712845117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBfrbWGzHNlTS4XQeBG+TQjAbkM8kCVd3lntc5GmhkU=;
 b=CPLsWYuKMEamfJmrsKDKsed716EFxaQZe1/m9+jmsoAxVqvscEXfHRsEP7IvqaHb7b
 bjQTLxcHr6Hwm8ul7E/VUD1tvQX2t0A3Ois1bw0CwZj17fSy0YTTs8VvQEzK0+S949Fl
 XLS8ixX5RyBvHUoyDE/401zf2iPUbvt+9EJBdYKm5mqixoQLwncTeytYPHiHFBq7HHpd
 b7AO+LKw052My5C+JLf0ptFOVlsIeCUod37WfnlCvOTSHBOAy0RT7XxPPBN2ybeZppon
 zzaYZbJPzNzRTwmRiWkPHZtZ/l9lcroePJ7XytJfxw1I9Wiw9lKHiWX/H3xBxb9EMrJa
 9kzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnSamTah+znkzP2AEBafxLByElKBZIq+Tr+jv8xbRxVVkwe4fKZFwlKpq3i6Q55oEj25y02uyvNgve0bFt44rx66LI9FI=
X-Gm-Message-State: AOJu0YxfIjVKPjtIl1gvJHSgmsGt2iP2cV9UKHRWxzxHsdMQdxGO2XJt
 NGbvWh0LhW9D5qh2X7o1ambj95Gr6PED9wxaMJFVpXIZk2ErzPMkKWGy3X+yhv/xbmX+xwPGCTV
 dtEJfT8cfZ83Eu7sjvsvxOEfQkPIUwYD98G3h/Q==
X-Google-Smtp-Source: AGHT+IGy/MyPTMo47U+KLm1zp+vQLbR3wp6AiIRN9+3jqDpKQOmea539WyHQnA6dpeX2yvsIOhSihJufcEjF5QNe8EQ=
X-Received: by 2002:a05:651c:91:b0:2d4:7455:89f4 with SMTP id
 17-20020a05651c009100b002d4745589f4mr1746810ljq.2.1712240317430; Thu, 04 Apr
 2024 07:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-10-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-10-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:18:26 +0100
Message-ID: <CAFEAcA8tGY8hD1y7Ygi+1EB_ZuxiPyC4S2frHFb2XBsugFiq-g@mail.gmail.com>
Subject: Re: [PATCH v12 09/23] target/arm: Handle PSTATE.ALLINT on taking an
 exception
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 3 Apr 2024 at 11:17, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Set or clear PSTATE.ALLINT on taking an exception to ELx according to the
> SCTLR_ELx.SPINTMASK bit.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

