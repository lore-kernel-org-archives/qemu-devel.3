Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACEB1067034
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gxd-0007Aq-HG; Thu, 12 Mar 2026 10:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1w0gxT-00078g-Eq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:24:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1w0gxP-0001B2-5f
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:24:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so11926405e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773325449; x=1773930249; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w77gb79l6FPZR6IcWMbMBMOT2ZUVKCQZW0zEe/s2wqk=;
 b=M26wB3dYOuYREeSfWOqKwXy4671FjLqrbUw9VHmz4WvLA8+91+h8WOuflo1iKvkzgV
 vmpxVG0qNaAyFCTjdK/Jg2Rc8qz8vpKqiZsM+G6bqMvKlz8dLe8ZY9gh9VXdX/2duX48
 xzG55/j0WIWLNStviA33g2HowNDOkn2TkvKbYcHx8wLmyGd9+bE5pPy2PWLpkUnt6iB1
 JRnh5ZMNtHXmVWQU98YFx0aSCk06lPV69CXeEhujc84LG/888QjKzN0mjFmeCMXoSkOB
 1HXdNwhMyVECRmpmRz/+BoeCReuLnw+z6Wj6Z4+4u3zPJ0/uJyGnEIdRmad3T5GYpETc
 q4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773325449; x=1773930249;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w77gb79l6FPZR6IcWMbMBMOT2ZUVKCQZW0zEe/s2wqk=;
 b=Y0XxWCqpDU0ATYkXz+iuCXQxbCafj54P8ZzVg6pL/i0J+jfkKvYr4JX4picrbNHIYi
 uU/LNqWbTfF+q2daNrGyTZKkBu4MybVf54JXpdVmIe+pMzQza566fwyB/IYuHkgWrAfI
 D99bnS0AuzftFUzr90Sfwd1hhnD1WFf6wiVlO8DMeWrZ4yC/h63C04Wt6pC4BmggLPdA
 jLd/EQXr3yTbr9x7Qe6JPIO3va9PRGac/07K8nF7Ha+bFTL/lcyOfQXTBEUNWuMQnTU+
 2Hj0n6+NRxTtQJf5qh9d674Od27uthS2ZSBho3ezVXPc3ZTmwb7CBoB7h6ctN0ohcBn/
 kf6w==
X-Gm-Message-State: AOJu0Yytjk4fG1NSouXTq4ORd3K54nw980hdJCPtNGT+QED3K4vpSrrc
 UQLttyt3hcAe5efgkcZRnsz4ioc6ZgocTJze8W5BhGGxknPe8zuSiPYiK9MXfQ==
X-Gm-Gg: ATEYQzwrsmxdLEvCOb1vB9hcSJzwVsT8iJjxL6fnh+vKfMovKxwJThOvKgk6p8CM2Mn
 CcXoIJvZwLCbxtPuAwntNKNAA5OzED+F/A65GQ/+pnt+b14uzqijfx8s8KGg1F4QJMobloKQZx5
 JTAkmn6HUMYV5stZ9K2D9lmh0uZd/WUCwpmTyURCSze/nwbBAMmTzKqT6XsOnR3K0fUKYLFGSi1
 TfbQLIkHd54dlrrnGD3rmMaQuImA9aKzWWj+p6hKcoDT3O+O4ZhjrUV5hRymhc9OX9ZEvxvcQq9
 LLMTzJpfO10wfl7lhw2Khi1rOgEcXpNyxAtO1lDNMqmSy6nRXcHfcBFCSvhNCk2h1oE0ev9mkXq
 AiIXqBSFTTcrTaNaau7O7SxE1PBU6ow5TC89FzLC/KXq7zWy72tn7ISnTAvAvAFwsAPNdiJ9D3c
 dF1NexnhpAhZDF8vpGrPXpyV2+matQLWHuzVkfgO6IKpCAXG8FDd7eAEEt6Wuyd0hQCDp6n8SpA
 +xWlE4HwHs1gPezXQDoUaRlreFtl+i0Gwj5Gg==
X-Received: by 2002:a05:600c:1f10:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-4854b0a4a87mr119497475e9.7.1773325448618; 
 Thu, 12 Mar 2026 07:24:08 -0700 (PDT)
Received: from ?IPv6:2a0d:6fc2:4ba1:a000:8b9d:e01e:98af:3679?
 ([2a0d:6fc2:4ba1:a000:8b9d:e01e:98af:3679])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0ea7easm96659945e9.5.2026.03.12.07.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 07:24:07 -0700 (PDT)
Message-ID: <b4e0bfe6264889b6082a8de70558dbeebd68f11d.camel@gmail.com>
Subject: Re: [PATCH] Fix iATU num viewports manipulation
From: shlomopongratz@gmail.com
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com
Date: Thu, 12 Mar 2026 16:24:05 +0200
In-Reply-To: <20231220131638.103357-1-shlomop@pliops.com>
References: <20231220131638.103357-1-shlomop@pliops.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 2023-12-20 at 15:16 +0200, Shlomo Pongratz wrote:
> The number of iATU ports in the RP emulation is 4.
> This value is exported via register at address 0x900
> The specification states that the value in the resisetr
> is 1 less then the actual number.
> the Linux kernel routine dw_pcie_iatu_detect in
> drivers/pci/controller/dwc/pcie-designware.c follows the
> following protocol, fisrt it reads this register,
> and if this value is not 0xFFFFFFFF it write 0xFF
> to this registers and reads it back, then it set the number
> of region to be 1 the number read plus 1.
> Then the kernel code tries to initialize this number of inbound
> and outbound entries.
> The current code in QEMU just accepts the number given by the kernel
> and returns it back without considering the implementation limit (4).
> As a result, with the current code the kernel tries to initalizes
> 256 enties. This patch limits the number the kernel can set to
> the value imposed by the implementation.
>=20
> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> ---
> =C2=A0hw/pci-host/designware.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index f477f97847..4558d552ab 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -340,7 +340,8 @@ static void
> designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 case DESIGNWARE_PCIE_ATU_VIEWPORT:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root->atu_viewport =3D val;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root->atu_viewport =3D val < =
DESIGNWARE_PCIE_NUM_VIEWPORTS ?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 val : (DESIGNWARE_PCIE_NUM_VIEWPORTS -
> 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 case DESIGNWARE_PCIE_ATU_LOWER_BASE:

Hi all, just a gentle ping on this patch from 2023. It is in Patchwork
ever since but haven't been merged yet. Is there anything I need to do
to get these into a future pull request?"

