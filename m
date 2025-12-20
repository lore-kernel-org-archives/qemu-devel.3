Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D18E668B4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 11:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWv87-0007Vs-G7; Sat, 20 Dec 2025 06:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWv85-0007Vb-N0
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 06:28:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWv84-0005cn-5x
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 06:28:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso18217555e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 03:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766230086; x=1766834886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0fm3U2J8/+VxcvIgSr7gIxkeUcO6lgXOKSa0Y//itI=;
 b=Cj4Hf6VVjNbMYW/PbJxQ366oCUQsSrZv+vtcF2kMxGOr7HNWR0sFDgYKloWEuBSCJj
 SqDETDwJV0Op++n6Fk19MqBDEXF7l9RUbJlProgBjNqaLM0NPM+7yPCNuyx3kg+hhzrm
 1UtY3r6vmaKDciWCUWgHKAC488M9PM4lJVP3fEW5qreUCaBidPSSygqrJRCT7rJFB46u
 sKItkcJQ7+Lv6YW7/cTl1xxUOdVoMq3D1ZbxklPcFnanxpIroW746bCB4hcyuJfTOdTB
 B5xiA7koD7hi1Zt9qa0dYPawwLa/MF7qgu6FCmI/q0Ezm49n0K87IgFVrVpej59hDNpt
 gEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766230086; x=1766834886;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0fm3U2J8/+VxcvIgSr7gIxkeUcO6lgXOKSa0Y//itI=;
 b=vqb4sI4ubyvG7BVs9GgzJPa4R0BxUj1DO1ZeOQxscFP6AYBs1vfDIyYEULbi5wTevj
 URrQNCpblColiX6vwhVbE8TUokHkyMAQeKPE1QcBAmLE76tAYTF0hcIdLbwoDGqM4Lcq
 y40QGPAHe1hSwb0IC64bzOuPBdGQGQ5W+W6ggKMyJ8x3aT8vxSYzIFZgWx4YOfe3RDdw
 PmzniEJBPDsVnbLOoAoP/G2WMfmf+3KFr5ttVlvExtHdec1TH4+gG+rr/4KBku7gfRVp
 iHfyBXo3ZH5NclF41dsdJYiHK5SoUAE3/IpJzdo6EVbXJ0dHBA1fMbRCHUV2YGX89t0E
 a9kg==
X-Gm-Message-State: AOJu0Yy7JxFxIgtk+q0Eu5JRJ1nBbyFxm8URuGmgn76gKizLYol5kJoo
 YAHGE0W2Y/G75x3K4mhuaXiL8eZpTTufl5jFW+DMjo2Jq4brwXnw5dv+0gpb0+HQUaw=
X-Gm-Gg: AY/fxX5JgLsPO3Ta9CQPiwrNVJcrey0nrsgTqDrSE0TWC3yMC7N7qCcBwtVgWFTRcBT
 ybSi0QygFj55NqPVV7nX2HFhpzi+t9LBlkXNnK/aykrHcMJuTbYEygwn7FjW6ieB/HfX4fg34hX
 Xrt9z+ysbC29eBcFG/WF5wI3t5x8q4fyU44LO25zeypwT6lXwQnJ//ppioqo8aSeFIhhIUkIzo1
 cCRfZ191RH9XtMcKzbNsvk56jHZ1nA23yLR16Ybgvf9LITm+FT4oq2M2NY4Qh95FAK5YaJ/1I7Y
 9hjRRdEUjextTqLDw8z1b/B3glgJ5pXr8rzSfz0IrUnUeBzwgM4wXa5b2nnEGZ83l59yn6x66if
 un2K0xYz18AdrCvgojzo+Xe/iB3RCrJl8kFN2Kdt3q0AaDa5ZX3oKybnijGg8xlbFvfxODqZHRF
 i/eM+SDrj1va0=
X-Google-Smtp-Source: AGHT+IGHXzkZ2+MnbIUO47sz53odNmfUlpILV20NbZVmTrmI3ZySeCLHd8yav9Cqq0a0X9a3hTXoTA==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr76705015e9.17.1766230086429; 
 Sat, 20 Dec 2025 03:28:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a210e7sm52315825e9.3.2025.12.20.03.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 03:28:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15A9C5F7C2;
 Sat, 20 Dec 2025 11:28:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,  Jackson
 Donaldson <jackson88044@gmail.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 4/4] MAINTAINERS: Add MAX78000FTHR section as orphan
In-Reply-To: <20251220072416.3745923-5-armbru@redhat.com> (Markus Armbruster's
 message of "Sat, 20 Dec 2025 08:24:16 +0100")
References: <20251220072416.3745923-1-armbru@redhat.com>
 <20251220072416.3745923-5-armbru@redhat.com>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Sat, 20 Dec 2025 11:28:03 +0000
Message-ID: <87ike1z930.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Markus Armbruster <armbru@redhat.com> writes:

> This machine was contributed by Jackson Donaldson a couple of months
> ago.  Its RISC-V core is not implemented.  Unfortunately, Jackson
> isn't able to serve as maintainer at this time, so add it as orphan.

Commit message doesn't match contents.

>
> Cc: Jackson Donaldson <jackson88044@gmail.com>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3efc943c9b..c493aceffc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -871,6 +871,15 @@ F: include/hw/misc/arm_integrator_debug.h
>  F: tests/functional/arm/test_integratorcp.py
>  F: docs/system/arm/integratorcp.rst
>=20=20
> +MAX78000FTHR
> +M: Jackson Donaldson <jackson88044@gmail.com>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: docs/system/arm/max78000.rst
> +F: hw/*/max78000*
> +F: include/hw/*/max78000*
> +F: tests/functional/arm/test_max78000fthr.py
> +
>  MCIMX6UL EVK / i.MX6ul
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Jean-Christophe Dubois <jcd@tribudubois.net>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

