Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4E9C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 11:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWDtD-00041d-FD; Sat, 03 Feb 2024 06:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWDt8-0003zK-AP
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:08:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWDt6-0004Sl-Ld
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:08:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso2492303f8f.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706958515; x=1707563315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+n9/L3a+iva7ZWBXFTYcwmPL7Ovxu0paRzwqx1wXoMY=;
 b=kSQbtC9LMTvLjTMNSX6Z+H5HRk74c1Wgj3VNqUfKeB03Z2i61/oD0gSZW5683lt1+B
 +dVS+O23hTPB7eQ/MW0lCB4VscvudQBWXqK7yrFj01XGWlu+rXbfegXRVrxPSMFF07Qd
 /OYDLo7ok+DZ5OHbEygs9cIuS/CB2sl28NECBrw3kd5c1Oq1ROt9UEYy63ga1cVNQmMX
 tV+x1dhcnoniVqUWPTQHIxBMQIMhdyAty64f3IIYE2qXX7vSmozgVQ+NKHuJhKjX4+mE
 wkmp1OOAQQQQdNMwJRWn1Bv5fRv3GD8qT8MKvE/O0XZnsdwMjO2RgyS44kkHvjJZrfJw
 ZCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706958515; x=1707563315;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+n9/L3a+iva7ZWBXFTYcwmPL7Ovxu0paRzwqx1wXoMY=;
 b=M3c0/5CMZ9XAURNmocqgOW5okAwUtiHqh3hwPI/Oer+cBtl6L0xZ8pngMna9zBpAci
 37Upv64s50X1EKgCynpSsyz7RVF7NKtGEUI0kQVY3lJ0kx/EFOzyBpbXJQvnqrqJteKj
 iywwukRvvGvEJ8qY/V3nJfVcqfplz/NGe3xU+Df0sVro67E4sofAOtOXu95LwnLzzjGe
 uaT2J21wfdjAZUKE9y5NMQd2m3IdC5Oe4pIEd6X5N+b6Y5qykznIfSsqnxDDjLFQp3QD
 bmRqhMUIg0320K9yKzaSL0PHCzT0e4wcGDWJkSYiDwj0StDX2U6VGVBsTnXp4/bw9j72
 926A==
X-Gm-Message-State: AOJu0Yw+ZEFQkSUH7aRGC+B0dn90MhdwZx882uKArJUWLT5EemGjKb2n
 aSrwWCmbkYz+QLm3Htl1fn/cEQZB2ub+xV1IUnKQPBWx8dVvkeACfzEkpOWwbaQ=
X-Google-Smtp-Source: AGHT+IF4RePuSuwNf2ovazPLTQfoY9PdPn7EG3jqRRwU12AeOmE92ftOmJLOBC9X8lyZwyD0ZSoSYA==
X-Received: by 2002:adf:e7ce:0:b0:33b:146e:241f with SMTP id
 e14-20020adfe7ce000000b0033b146e241fmr1035837wrn.4.1706958515009; 
 Sat, 03 Feb 2024 03:08:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUS5eksnhgu4lRXfF1LpbFgK3yR7mfnhrDPeg/i30k7vRzCeqlcKCf8rR5yRnS3ufT4AcBtAcYpoTKw/RERBU//g+YafszD8VzdxuH7kUdMZ4bJoJGlGiE8MS4nZP4z0KbPVGBOy4s29VFgHP6IfmaYzRhKhODKw4JV3avTDR1mMF/evnGTUvToTWCw4EVGqN85wGQNfvnyAusmtJWSRqw1muZR2knFZdEw46mT3NDLioSqL5dZzIFNiXs+NZ+XRgFm9bIBRMhCX83+JQGzUvtbyTfKEgrOn6+AhZgV9tCmd63fj0MQu8Yb8YOqb2uc9FGVyXyoltFsZI4VarnEHtxlV8MdbP3oMUWVtk5eGLxs4FCSyPglz39GSYLb4Yk8trdeUGxKmJpdM+gAwVtimedPfzAfkZSRTWBz3QMyLK6aB2jZ
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv15-20020a05600c548f00b0040efd192a95sm2633080wmb.1.2024.02.03.03.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 03:08:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A0425F7A9;
 Sat,  3 Feb 2024 11:08:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Bin Meng <bin.meng@windriver.com>,  Weiwei Li
 <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mikhail Tyutin <m.tyutin@yadro.com>,  Aleksandr Anenkov
 <a.anenkov@yadro.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Andrew Jones <ajones@ventanamicro.com>,
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
In-Reply-To: <20240203-riscv-v11-0-a23f4848a628@daynix.com> (Akihiko Odaki's
 message of "Sat, 03 Feb 2024 19:11:07 +0900")
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Sat, 03 Feb 2024 11:08:34 +0000
Message-ID: <87bk8xpzyl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This series extracts fixes and refactorings that can be applied
> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>
> The patch "target/riscv: Move MISA limits to class" was replaced with
> patch "target/riscv: Move misa_mxl_max to class" since I found instances
> may have different misa_ext_mask.

As this is re-based on Alistair's riscv-to-apply.next tree I'll wait for
this to go through the RiscV trees and then re-base the plugin patches
and dropping the merged riscv patches from my tree.

In the meantime feel free to review:

  Message-Id: <20240122145610.413836-1-alex.bennee@linaro.org>
  Date: Mon, 22 Jan 2024 14:55:49 +0000
  Subject: [PATCH v3 00/21] plugin updates (register access) for 9.0 (pre-P=
R?)
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

For:

  contrib/plugins: extend execlog to track register changes
  gdbstub: expose api to find registers

So I can add this to my maintainer omnibus series for the next PR I
send.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

