Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2678E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7jW-0001Eq-Bg; Fri, 13 Dec 2024 10:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM7jS-0001EP-FN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:37:35 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM7jB-0000o3-Kw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:37:19 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef7640e484so20489267b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734104236; x=1734709036; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TSSAiMXN2YjyBddSL7QadCKvy86NxvQqg4ACDVITRV4=;
 b=P9BbYUOa2dQaXMzpR5FYW8KkeSNcWairk2dNM7avAVaoaZh2lx6Kji15ATMNIv2edN
 s6bF6sWUhA8oaMrLoavhkqrsjG3d2EDrfh8COgYbsguQPKnbDCgFGCeJgXpSFt29+xzX
 j/thvff7bOHFN7ZU2e6uaNsrUg9PoXgI1yQB7VRTnr/ffZtkvD9TkjkBHWwvjCN6aUk2
 /7+mUm9XQ+uSVK5yBXtJ+jRzd+kvdyJP+j14LjMdLZKgbzNHDc3BeQ0ZTn21dgE9DG1q
 Yrsy+aDtOLeduFI1MsBpYJcKWjhLBGDCqsPhGQdodvDiOYBH5vk1/jAPBCwNAoigLSdx
 Je/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734104236; x=1734709036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSSAiMXN2YjyBddSL7QadCKvy86NxvQqg4ACDVITRV4=;
 b=MtY8YPpTGVi7Q+irOiLj6AsCts/HJDATWqhcasVdtjIH+q596Eo6xNf3stNgXBSAsd
 5Rkdn0ksxWMLNLHW5nL4K59CUEMPd6RjkzMaczL7Cbv6LNHgqe7f1+/TULFP7Jhe+Ovq
 a5JbhKWUXR4WINq0vBaY06djosl6LEcKEAAoqOZ4e0OD8OOsGhrcwUjTpUMHppsBwn21
 l0wUAWdtZ0Yao6E753rdxcwGzlykI0JHnDflQ2oh+AKEZzl9rdxz6aCGJYywWmVq4DPY
 AIzEJhrapNS9fOzvf6sHBWt10emhbd7DBs2q5nGXCMVQkFl3c6lwva97ErPSrolT+cq7
 sxXg==
X-Gm-Message-State: AOJu0YyT9Pv5JVeWNI4Nxy8b6o3JGECl8HQ3JTGnYcv9EAO0nTVYHlUt
 Etgr24R6cXet7GO3EO7kzOoqXVov85bana1qCJZgEqn6xdB4zkvYPrv+GHXW1t95O945eKoQiVX
 X2i2BobQnVdB1ZMi0sjnigyJrDVhvN6bSGMphcWlbg7yRH/aY
X-Gm-Gg: ASbGncu6b46kiN1llLKFhk4icmcj5tXTKwaJRCnOVJ+Rkbd0wl5HONCWrtYK6rdPyhV
 dVmN9hThoGSI0gYHwGMtMt65dfxpPUVFZK6SjcFU=
X-Google-Smtp-Source: AGHT+IGwYw+BVOtoKvLgesairME07vmlCK2orfbln0yGma2TUjxCY5VrT5E73IZkPq7pXfV7diZJlbpdkqd8H7R78VA=
X-Received: by 2002:a05:690c:6212:b0:6ee:7797:672 with SMTP id
 00721157ae682-6f279ad1782mr32086977b3.7.1734104236159; Fri, 13 Dec 2024
 07:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 15:37:04 +0000
Message-ID: <CAFEAcA8TKyEJrPcNz3NOzv_LOkh9ENKiyMtBgDmH+xdEwZBqOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Minor fixes for Arm documentation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 6 Dec 2024 at 19:23, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Reviewed following things:
> - system/arm/cpu-features (options)
> - system/arm/virt (options)
> - boards documented and listed with -machine help (arm and aarch64)
> - grep object_class_property_set_description hw/arm: ensure all options are
>   documented
> - reviewed boards description
> - reviewed all Arm features (FEAT_) from: https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/
>
> The Arm section of the documentation is in very good shape, and this series only
> has minors fixes.
>



Applied to target-arm.next, thanks.

-- PMM

