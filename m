Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECD3CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 11:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6u6-0000i7-Ka; Mon, 15 Sep 2025 06:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6u1-0000gO-UB
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6tt-0003Yu-DD
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45f2a69d876so7747595e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757933844; x=1758538644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4SyjOe3pd8p+71nfanRe/QNNvlessHM/Nlzmnqfqrk=;
 b=DbZAWpCczkWmpIb+8AMEqEA9JQ3d3DiXSfWFuCpAT+rKYUjALZRUsPaUPJPilisk6w
 WJHw/5doWDXxXfSMPfbnmDGUjZw0PiiBrV5xpAykkDKzkHySzyWbEDGspm/Tc6KI7Zj2
 gVQRn+WQ79t+fVM98FZ/8lGO2OWEuiVaIiy/dCp0SuLBFcePIDAHfI8bDnV1J2Z6FaQZ
 QoUn//QnkdB2bDXJS21MtSByyyGLCVq6oGzzFckMcRoE/5pJ662dzOUVXCifY2kwMf5W
 eWQ9OTm07Z9ZgwIxwjpbp2btJFOs/uxwDOaimDGuo/xuLnJ4D16mjbL+FMgQLOFa3/11
 fTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757933844; x=1758538644;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4SyjOe3pd8p+71nfanRe/QNNvlessHM/Nlzmnqfqrk=;
 b=RqrWkvZYKvASD/64NtxMWGXOLi4ja6Ig9R8Ypuk9Ca9Ea5Efqc/1NU+VtboaRlF5xJ
 SnmrI1CZbepUvDzFgI2mNOpTPPrvXy8EMSAIWdC9LzGYEURVZuvlRH5bcDxAHdHunD4E
 2hYvpjPZwOw9gqU5PDuM5kO+yc1YgmkENfkjv+1PaDlXHSdi2BmpUtx+SenyM5vnPJps
 rgEIHBt9TZJi+iW6AMoDGDPGkMs38WM2dAQHcPKvm2tqoCN0CA/z6SvGrNhQYK69/trj
 4ws0OENYVg7I5EO2GHeP7FnUKPsp+QbRwPu/Qf85ZevwjePLOXKYQmUQUVZdSbncOxvV
 HYeg==
X-Gm-Message-State: AOJu0YxrDXDkO0wMf7SpPlQCf97QdX45bt9TON2GR4v+3uRN45sD1KuD
 5gIfrHgmAI6I7xggPzul/7HSy4jXWdML/zL+YvPRRrELjTjDfakTn4fnM+ERvQ==
X-Gm-Gg: ASbGnctZ2BhXWv2p5atxn8h73YUuZ6s2/1Q4o4+hmTiQWcB9/x12dHnyX2bVu7bd/4U
 uC9qXC4VQ7eXg7VFhT7khWPT/docxcPGSdmQKaV68co41V2BzuGPOUkfTDAfX+DtT+e+gfMREHe
 qiTZmLYl/vPda89n46u+rgCvKhUVfOv39HWmWGsQpN7o+jQZ3qQuyBGjt+yX2yD7OKC+nrW0wYM
 TkRrVOZG/VrnE2jNCrl44PFR+vIfLj/lv1eL147tSthueOCcNTEl/UBBmrbd7poCnuS2FpDddMt
 8e145wJf1mTpO9H480D9lY0R8Ok26Qb48oTSs4P67C6a8Scm4NV2wBYkRMfbvTE7lvwsyjbzQen
 26tLwLnHvpGY0o0Y11GwLzggEdLYuDHa1ntDYy9LJ
X-Google-Smtp-Source: AGHT+IE7hrdgzm0ZsEMwucyo7DPsxXGyhFVjFvbQyYCGJBJLb4EmbUcJj2qK9NN3TWvE2CnZS00I/Q==
X-Received: by 2002:a05:600c:6d8f:b0:45b:8078:b31d with SMTP id
 5b1f17b1804b1-45f211cbb0emr94822455e9.6.1757933843563; 
 Mon, 15 Sep 2025 03:57:23 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f2abd2c03sm68130085e9.13.2025.09.15.03.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 03:57:23 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:57:04 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_hw/pci-host/bonito=3A?=
 =?US-ASCII?Q?_Improve_various_emulation_functions?=
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
Message-ID: <64103F9C-3D1C-4609-B7C0-00AD61DA2A2D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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



Am 8=2E Mai 2025 14:46:05 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>Hi all,
>
>This series addressed a couple of missing Bonito functionalities
>I found when I was trying to test NetBSD against QEMU=2E
Nice work! With this series in combination with <https://lore=2Ekernel=2Eo=
rg/qemu-devel/20250914185526=2E3622-1-shentey@gmail=2Ecom/> I'm also able t=
o start PMON2000!

Could you share some details on how to run NetBSD on this machine, please?

>
>Please review=2E

[X] Done

Best regards,
Bernhard

>
>Thanks
>Jiaxun
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
>Jiaxun Yang (5):
>      hw/pci-host/bonito: Implement ICU
>      hw/pci-host/bonito: Implement PCIMAP register
>      hw/pci-host/bonito: Implement DMA address translation
>      hw/pci-host/bonito: Rework PCI config space accessor
>      hw/pci-host/bonito: Add comments about documentation
>
> hw/pci-host/bonito=2Ec     | 453 +++++++++++++++++++++++++++++----------=
--------
> hw/pci-host/trace-events |   3 -
> 2 files changed, 284 insertions(+), 172 deletions(-)
>---
>base-commit: c5e2c4042e3c50b96cc5eaa9683325c5a96913b0
>change-id: 20250507-bonito-482759b2b52f
>
>Best regards,

