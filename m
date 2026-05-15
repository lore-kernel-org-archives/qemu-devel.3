Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B999BCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtMq-0006aZ-N9; Fri, 15 May 2026 10:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtLu-0005kO-OW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:17:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtLr-0005x0-SP
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:17:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so50993445e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854638; cv=none;
 d=google.com; s=arc-20240605;
 b=OaU2xw6uE29gOtHef8MwY9vW4rKym4fa+zlKx0Y7l354ueCuE47GvBHx2BchW/d6hC
 d9T73KIyK1NdX4uAw7qkycBz4z2rWwz1ab7uCuIpKdjtJfKUlZ6qChBss5RyE3CJemRh
 cDHa+88LARnn/TNy9mnjEjBdjzSe8K3sFlVx39Pdv8upmATyb5oW3+mJcZr37lnKQ2Ee
 u2GwS0XXIpqZ9gmHbmPwL9c+VgPBgvdPRRqjAHjtSWboR1MhKdqMPdLPtevgUt07+bAc
 b0rzX9R1uGf7zkic2k689XZEcO67kgI3iyyiCk9ui+hCCG6Rb3yvqYaCL11XnHHu6Ugw
 E74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RpwF4bN9IyrPkq/1bQFEPnBnaxLa1OtsRvp4x+A6wU8=;
 fh=XU+e7/sdy3BdKRahytsg4BqM2g/A0Q0Ptwqap2eda14=;
 b=g//3/uWLph9GXyUN444SB1hP0NDb2zsOgfBauajq6Qazz9ODeFgjgr58UXhCoNSkui
 VexAQceTFus7qAmgvGCA7KE0XZGWLvOiC6v+7lz/sbctrgw8SiXpLG8CHPxZI3GpM7Mo
 AHlWXUdIknEIbCBBRiceW6Ec8LrLXhyHKXwpIZbuh29GHgvMh3Jjks0NK/MThIh4ffzJ
 I06TYkDpPvD2SeJyilCi9j03ZXY4IyapbfnS/rkKdpP6/IUQO2d8QTswpMG7XcqoyO/Q
 Obt6KqQPVd6UfvXrFQXdN998fGv8afG+pRfIO0oIa5JA8x1jeCEYnFLHLRgalD1onWdl
 YkiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854638; x=1779459438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpwF4bN9IyrPkq/1bQFEPnBnaxLa1OtsRvp4x+A6wU8=;
 b=ZK4Nlr0pTINP14ONSFj1LO8nhdnFIAXTbnRrZXrFw6Hzp/xJfpjsGs0m02Kf2fVvrd
 onAt3U3E0qMSfoYMCe8kJzLMihSrtgT+E4FRLB9Kyvf79VsxWZkbEePOU6w6pU6W9Hug
 7vNisO8QMDRIBSccK+8fRaLjY/voFDVb4Mnu3cYGmB3zavIonoAppQFh1+gaWTa7JQyG
 QEA4IX17jGrpPjQFW+cBc6c5DQh9QtjcjtO7KU/e/Nr0AtZdbEePIcj2MdgAnSj4AVzK
 M2VAR8CchS2YnjdjDdho5C1Amyp16el1Tkz8owMiH4xRtNhwYqYfz+XEK/QfHaMJjlWx
 iKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854638; x=1779459438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RpwF4bN9IyrPkq/1bQFEPnBnaxLa1OtsRvp4x+A6wU8=;
 b=g72T7g1qNp7iXkEoC9OzZ1COoUSyZoKByCTdCaGEQXMNTI65aXL/8uRnEYkolIETBv
 /vSwYI1DJHpfs8oX9F5Jax5ZVy2dyukPJz4eaE4V2GUgXaRVqLe8p5k+9V5JlE6ofGbV
 2vA19lVSvS0cgNm2UukADkHm6wh1Z+bRjdV/NgSwcbNjQw+ejtJ/eh2UI4SDJUzExakX
 IH0FpiFwzqcJjZIqKQFwmwjIgQBXqCjsHHwW92LMt6A+jdsssUDVVVdi6e/+CJh8nAyd
 Rxec/lDPSjQN5iCCpAV/xbtpYEXUd0wj2grmQ2IQlmQ6VGNcSiSGuc1KAvZpHB7slf6D
 dQTg==
X-Gm-Message-State: AOJu0Yyduq3xiyscsZjFZB3I4ujny0z20Y716XWs4Qd5n7+bAOKKSFT6
 jZjShanLDy0VWz26A2A59vSuTqY2ZuecJ4eRrzceJO41taEqHbh1HEos/bPrRoYlKzdIHhdgX6u
 iP+Rz7tjYvWbhivKJgh+im93YybZjQ/yu1mmp762eYA==
X-Gm-Gg: Acq92OGkFhjlKHzfKvG4CYGpQHTdpPZQ9oBuMGR4R5UkOpCw6HORfHiJvYAoM15WKn1
 7KE+sPJStxFKgaFTfm+8FERRILDxLCGRuMvUnF1a6P/825z8d0PvWMsclFRvajamiJuy9borx1W
 S5Ch0bM4bf75bpfgXtUrrvxWeIiidJZqg9Sxed4l6mEq/IDg9symn6+yvrTbV8/NvkeD2kkhwx+
 4asN1mUx3olgkSyPLPdKqGlfP9xFJlqTqlE/tGqqu3lXP9xfjt6qQUQ0FFoHHDP4uTXunXq3KSs
 nRmxjiRsy1yuQBSHBlZVsnVm/UppRp1M82ml2h0Tj2117zT78WZRqOWr6FGp
X-Received: by 2002:a05:600c:3e1b:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-48fe60eccc3mr55950055e9.13.1778854638222; Fri, 15 May 2026
 07:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-7-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:16:51 +0300
X-Gm-Features: AVHnY4J7SapanDU5sGaXP6WITthqt-mdUGcPCtRE-bf2yeGZO9maOS-JQHCmEtU
Message-ID: <CAAjaMXbiqcfhSoKHKJn5-+6XyTtOLd2OPb==HdYzC=qYxsuWpQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] hw/arm/meson: Remove now unused arm_ss[] source
 set
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

On Fri, May 15, 2026 at 5:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/arm/meson.build | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 7c3d66f4378..88e7ad1a3ed 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -1,4 +1,3 @@
> -arm_ss =3D ss.source_set()
>  arm_common_ss =3D ss.source_set()
>  arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
>  arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c=
'))
> @@ -108,5 +107,4 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: f=
iles('vexpress.c'))
>
>  arm_common_ss.add(files('boot.c'))
>
> -hw_arch +=3D {'arm': arm_ss}
>  hw_common_arch +=3D {'arm': arm_common_ss}
> --
> 2.53.0
>

