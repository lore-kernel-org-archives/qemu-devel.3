Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEF1C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvoh-0006ZU-Gl; Tue, 25 Feb 2025 09:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvoW-0006UY-Jg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:21:44 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvoQ-0007Qr-F1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:21:32 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f7031ea11cso50334487b3.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740493288; x=1741098088; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=82DEW22uAFsv54Y58YBO4EhI2WtyZctL9L4mAS15Np0=;
 b=ZYs0F4wuLn+BYDxTSBlrSNKUWWi33JoCHn1B0ISNa08rTVGS5A73qykonf4EisX9Vf
 SXbSztKpLTwhMVcekgWBByKE1evipLJ7wNpboEd4qApVUhAHp1S/1LJujIiRsNmkW8ft
 t6Bijh7xnFLryzKQMYUMh8UxtLj3S+bjnGPqk5bSiSTvJZMudOpbZGd2Z9q7jLkbssJE
 wzToXViwgyMbM/Bl2bjY8M3u7XGnytHGDlGpCTum8ck/hFuRxbExfMo1SYlC43xcOBpC
 Ztg1qkGtoW+HqhYCG/asvwolrbQCKjP+Iv/EEQrJCTaInFnG5OGPuZ7BwC7e750ZCNCQ
 PNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740493288; x=1741098088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=82DEW22uAFsv54Y58YBO4EhI2WtyZctL9L4mAS15Np0=;
 b=ZSd5I3fVfoArbbuw1+47k3hNCGaM6j/OAGRV0eDG1hGOJTorrLwIOx8jrAOE21fXxr
 SRy96vEcRQ8zZSjbKBFgK1pC6avOlWEGr3vgGcpw86SD7e2iYNN5hqYvJGir1Ox4u7nL
 1eYoIUTQ1KmTTEmPF+MA1Xljirqb3bflafktbJ2mAP4bFUpB5zk/nLm/xmiCuRPhB82L
 mhLIhJj7v/e0mTRB00qrO7hdc3f6RLHuhi9bZQ3d2bif+0OHQqhZ9EMXmyxbn86nt2+y
 39O72dHH0hQGDeyd6NWjgi4VGh8e61s/gDwi/PU9F0DfDXXVGFlRkoIrhPxiYmqMNUC7
 zWGQ==
X-Gm-Message-State: AOJu0YxFDuIXxgzHlzjZeTCRhIlshQ6tQ+yDFvJE+o8//hUz+8GKeiSg
 8OxCTca97ERfq5UgVqKKwuRnUUgDkQPFWpKIoMsTNttx9SGjQu58JYkoHg3JcuGRmT5V+nIlBhH
 tXdVftPVwDwf6YFKVwwS+5Pu9bASdpId29VnAIg==
X-Gm-Gg: ASbGncs0dgLYIkUkY9DManAFSaQydIebpClhC2m6aLMrKQ77tGvLDPMBV+HGgQBAWAZ
 fGQETg8H3UQuzymK8jkhlCFAf5OsAxdQlBKx7eonlXKw6H2e0csPJEQWuzj2sXPx5RvNVi37rPD
 nE2DWongwN
X-Google-Smtp-Source: AGHT+IH5rf4BvEWFV6g+KdBjSKYhtCtGwHt+IHunPnf/s3vlsGgY3WB0yDX1VXadodV3qNA6WP2xGSGo2dJ8M5SVObs=
X-Received: by 2002:a05:690c:6a0a:b0:6fb:9495:1650 with SMTP id
 00721157ae682-6fbcc235dd8mr157385117b3.11.1740493287754; Tue, 25 Feb 2025
 06:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-6-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-6-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 14:21:15 +0000
X-Gm-Features: AWEUYZlRVKWPPJQVmvT2l4P7pv6igPT3SESkS6yWN2IcVJzWFnlS0ZpTsSWNVD0
Message-ID: <CAFEAcA-5g2=2JxorPGkkYR1X9LmR2HBiW_zz7+4ZGwQT4y19fA@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] hw/arm/fsl-imx8mp: Implement clock tree
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Fixes quite a few stack traces during the Linux boot process. Also provides the
> clocks for devices added later, e.g. enet1.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

