Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4ECCD1288
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprui-0005eA-5W; Thu, 28 Mar 2024 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprug-0005dQ-Sp
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:43:34 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpruf-0007qS-4M
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:43:34 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56c583f5381so664074a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711640611; x=1712245411; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SA9prWQH3+BKQDdv+4CEIFUq0hrH5UT0eDVBRphad+Y=;
 b=TJtMgdxwbLMVgdCwtC/sK/89pC3KS+oMtjFlkj2pexjbfX9bjGX9eltuO6QTVynRGz
 gHc5c1TY6dbHzWmQmRxhI4q+c3Fg9seXyM5TgCzLed/o4kppYcA1S3Pomq3ciodIoLhC
 JRFjNq7G3KiMGNZa4BMePpIXJnOKGZM4e2Y3/e7jSGZigcRPZO1/cA82cukWyERi+juA
 U5Lji5d4WYjUfskQDGVZJfZZ2dAOs8IDZgo7qkZKWZjSJm1dcn5ZGmzcDFE+12e0qmns
 UTIKS/5qbCrrRbzjZwT1/0CD9mtp54nimFUNHpbhszPUA6SlGAfvT1fVwPIf1l9hRt5A
 T1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711640611; x=1712245411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SA9prWQH3+BKQDdv+4CEIFUq0hrH5UT0eDVBRphad+Y=;
 b=VH0Lasm+AYBFcVuAIWPx076FtKCYnogDqcKxAGKcBhnWo7gnHHZ7y8zeg5B+km7JsV
 IQU38h/mu1BrkRUo9nTDkT8KOe3wMAaEldttZCSmCFJUbENvVnTIad0NL4lRKv7JpVx7
 gDdLdPhiiD0Xj5AczJJOhRtFh9SC/6y6hHvCKPjEq7QUe/BeAg8CHr2K3VkRnOWt7+l7
 n3us9X5V4CRLLwsqJhA1FLlotMijCcxTkdYmBkMRC4NIDJSZ8rjvPaNbPNVuDUDRO2py
 ykL+iscHbKonA/OVwCcZUQhM3u3j31Nwehp++BC/OVZtggIexKV3s14gEw+Nxlg9o8rX
 B1VA==
X-Gm-Message-State: AOJu0Ywt+r+GIdaoBrIN+QBTui6Icz0jJBBMJCfazs837T8/rQp//xrg
 drzkqw7hewadOnRf0OM61whE/qiFDffgCND/DTdumvJ63BWAGP7L+9EqjC6YSOy0SE5+jvEGaJs
 k3fgODDyRYtXAMtsEny52jp96qQINNNb1669DGA==
X-Google-Smtp-Source: AGHT+IF7UcjRa7s+quDC3emykMmfY37xeMSm0dxxeWvpTYmcSdfutJowEVjbS80bal+DSMza03b/MUrvmjVdvT0MAbA=
X-Received: by 2002:a50:d5c7:0:b0:567:e0e:dda5 with SMTP id
 g7-20020a50d5c7000000b005670e0edda5mr2134150edj.17.1711640611549; Thu, 28 Mar
 2024 08:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240326095819.1268062-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240326095819.1268062-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 15:43:20 +0000
Message-ID: <CAFEAcA_Hf_Ehk8Cc8kZGCO3niW_x18vwg4=JSFmYoFZOOTPzGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: sbsa: update specs, add dt note
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 26 Mar 2024 at 09:58, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Hardware of sbsa-ref board is nowadays defined by both BSA and SBSA
> specifications. Then BBR defines firmware interface.
>
> Added note about DeviceTree data passed from QEMU to firmware. It is
> very minimal and provides only data we use in firmware.
>
> Added NUMA information to list of things reported by DeviceTree.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  docs/system/arm/sbsa.rst | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
> index bca61608ff..d4d1f2efe3 100644
> --- a/docs/system/arm/sbsa.rst
> +++ b/docs/system/arm/sbsa.rst
> @@ -1,12 +1,16 @@
>  Arm Server Base System Architecture Reference board (``sbsa-ref``)
>  ==================================================================
>
> -While the ``virt`` board is a generic board platform that doesn't match
> -any real hardware the ``sbsa-ref`` board intends to look like real
> -hardware. The `Server Base System Architecture
> -<https://developer.arm.com/documentation/den0029/latest>`_ defines a
> -minimum base line of hardware support and importantly how the firmware
> -reports that to any operating system.
> +The ``sbsa-ref`` board intends to look like real hardware (while the ``virt``
> +board is a generic board platform that doesn't match any real hardware).
> +
> +The hardware part is defined by two specifications:
> +
> +  - `Base System Architecture <https://developer.arm.com/documentation/den0094/>`__ (BSA)
> +  - `Server Base System Architecture <https://developer.arm.com/documentation/den0029/>`__ (SBSA)
> +
> +The `Arm Base Boot Requirements <https://developer.arm.com/documentation/den0044/>`__ (BBR)
> +specification defines how the firmware reports that to any operating system.
>
>  It is intended to be a machine for developing firmware and testing
>  standards compliance with operating systems.
> @@ -35,16 +39,31 @@ includes both internal hardware and parts affected by the qemu command line
>  (i.e. CPUs and memory). As a result it must have a firmware specifically built
>  to expect a certain hardware layout (as you would in a real machine).
>
> +Note
> +''''
> +
> +QEMU provides us with minimal information about hardware platform using

s/us/the guest EL3 firmware/  (or whatever other term you want to
use to describe the guest software that reads the dt).

> +minimalistic devicetree. This is not a Linux devicetree. It is not even a
> +firmware devicetree.
> +
> +It is information passed from QEMU to describe the information a hardware
> +platform would have other mechanisms to discover at runtime, that are affected
> +by the QEMU command line.


Might want to say also
 Guest EL3 firmware does not pass this devicetree on to later
 components of the software stack.
?

> +
> +Ultimately this devicetree will be replaced by IPC calls to an emulated SCP.
> +And when we do that, we won't then have to rewrite Normal world firmware to
> +cope.

I would drop the last sentence here, and use "may" instead of "will".

> +
>  DeviceTree information
>  ''''''''''''''''''''''
>
> -The devicetree provided by the board model to the firmware is not intended
> -to be a complete compliant DT. It currently reports:
> +The devicetree reports:
>
>     - CPUs
>     - memory
>     - platform version
>     - GIC addresses
> +   - NUMA node id for CPUs and memory

Otherwise looks good to me, and the updates to the spec URLs
are particularly helpful. As a docs change I'd be happy
to take it into 9.0 (at least before rc2) if some other
sbsa-ref-knowledgeable person wants to either review or ack it.
(But it's also OK if it misses 9.0 and goes into 9.1.)

thanks
-- PMM

