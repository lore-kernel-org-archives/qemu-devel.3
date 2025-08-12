Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C975C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uls1S-0006Uc-DK; Tue, 12 Aug 2025 12:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uls1J-0006U1-7x
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:38:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uls1A-0004fy-OW
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:38:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so48109965e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755016705; x=1755621505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZe33EGwIBhcqa5V+MvPE0Dt5p4/9WZqVJH8bLA0QBM=;
 b=l9SawndrP8i9OdgxV9va79AcoW60unP/F4A4eQ9NaAzF3hWui/a1tzXt6ofjjRQaKN
 42nknO8pob/kB1J47hb+U20c9T/UP2TLFvKLB7Wt6NqQEtchV61N8UMC7KkWo4vOn1Qv
 rOStVevyWB9QeM0A+VpdL1+3qJBfuvMm8CF17MoWoOfetzn0KXfirQKaqQLK1iXwl8Ma
 tgt6/Y7iRuj+6uU7Sg+nd9D21NeVqchI/xPaXfjjT9P9ktUfvhFt7lheFL31flXNRtkG
 +NW9QZWSgw62w4p7HNgfQbDWlsvpCxpbYVXPeb1y0QRC1ymW4GZ5AaVc/yopTMqPWA7k
 zXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755016705; x=1755621505;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EZe33EGwIBhcqa5V+MvPE0Dt5p4/9WZqVJH8bLA0QBM=;
 b=JCjmfd9D2RNM4Y7dgxRs4enzpMrDlW4OrAmdUGRI5HWowhKIHSyU/V8XeWNdN2LbOc
 HRxahVSR8EuIUyOnnIryBxyVrPMCJOwt7isrGjeYN2Bl7eAnN0IJGpNIFCB5zCehuomk
 NfGj/hIJQt4rsGPu9j40y+lTJ9eOnW/20kcphMDFTaODoOxty3xf8+E2F9qmv/TmEGSy
 xn3YpUI7Ee6GitiTrw0ENa1q7k3Xp6IBqkFMuLvIJC3O9CmJDG4yhCHhOXld2e0hRpJ6
 37lD4CEvZbxcvT4wShTYKACSez7nh93SAQn3c1dT3aI07prfVFxWU5WTYDSSHwJoOxTY
 vNmw==
X-Gm-Message-State: AOJu0Yw5oFxgENy7Swl7BZyqDsaA8Ew5yJZSYsIl2PIL/ihKm+4HfRR4
 qh53brvoZ4ZdVNAS3jgqXHBP5LCf4ahyhDY2IwYjKwc4FuaBcTZo1XuW7AZ4Hw+mK7o=
X-Gm-Gg: ASbGncuC2kVGw39Yw0dlbU7yn8H2pttxMOHzQPLvt4Xyeu6S/Q+i1inyJoSQE0xiyyK
 tW5GDDmF1bdTQ2Vr3/jiH2jQam753leeGFW82DLf53Nt78lECHqPEAxlg0lFFLNC6Sk9EkqT3Wq
 jyuF9hoz0Th2/f4saetVQ4+lxB93Hpbo9nJDQ3nhsnB1bIEFO0VY7xYsuPty7GGYydXWFZu2cut
 vpISpZv97Kp+yPR5r+uHvKO5KUDj5P3Q1FBks6jy1QUEtfbgCScfHhEeNJ02RUAPlOXSB6cUDXz
 z2L3q0+L/kCs9FGlSotBPgLOg3BmQ7xBzVLY//VzKJ25FED32TJ8tXE/Xl1HqyxBzkmhfW9wwNl
 lfqTQc97tBmXmhdc5qtUQPHw=
X-Google-Smtp-Source: AGHT+IEbilfyGm48/zMNecjxU0WgUgMRHeobCn+6jXWERoIoEnaylntDn1Tjh4UWXg4PFNOvxLpd6g==
X-Received: by 2002:a05:600c:4511:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-45a15b4fe5bmr4545965e9.8.1755016704770; 
 Tue, 12 Aug 2025 09:38:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c45346asm44742726f8f.39.2025.08.12.09.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:38:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1A5C5F7F3;
 Tue, 12 Aug 2025 17:38:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH-for-10.1 RESEND RESEND v2 3/3] hw/ssi: Document
 ssi_transfer() method
In-Reply-To: <20250812140415.70153-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 12 Aug 2025 16:04:15
 +0200")
References: <20250812140415.70153-1-philmd@linaro.org>
 <20250812140415.70153-4-philmd@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 12 Aug 2025 17:38:22 +0100
Message-ID: <87cy90a41t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> A SPI transaction consists of shifting bit in sync with the CLK
> line, writing on the MOSI (output) line / and reading MISO (input)
> line.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

