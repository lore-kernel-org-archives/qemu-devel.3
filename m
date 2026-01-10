Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FACD277D0
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 05:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veRrs-0000UT-49; Sat, 10 Jan 2026 00:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRrq-0000U8-Dy
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:50:30 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRro-0003qC-Vm
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:50:30 -0500
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so6000119a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 21:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768024227; x=1768629027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eRE2jIFI4PRbT5D4j3A4sJTwO2YmFR1VHKUIeiGdRb4=;
 b=Ddwm9nSFnzCAM/JdKK9PtS82ZocFxJfeMV5jb9+A43b2RvyoCVAMbZtfS7sCg9wr1J
 GegBw52rhpJnnigjXLM3gY4V0PBwvDsVT0FU82b/KbC+KbBcBExUNzB53vYgmlY5mX2D
 KQJNBGtHK6+UM3Jqwy8KvkO6w9fFd9wtoQKDK5hqCju4ab5Bvjy3tur/eAqAHckjCFzG
 /dZLxBsNEldU7MT3i5T0dSJosVKD175y6j4SSBd18PQmDFQ2H/tdltgZBZfIJp0OlzaP
 hXddEQASfN7iIpeMoWXaEKSCnodqBubWrHwN+61nvkmar4dmxoWUlxl7jEK/odJ64xiT
 wmwg==
X-Gm-Message-State: AOJu0YwYuwWWGQ/U8CJcvpkx0Wz8N7wgSjF4v3631822ZLKA1iBPEux6
 YV/JebDQSZWKANCPh7YrtMNP8S8M7I1sVBb8lVOiNGHPeidFNpDExen/
X-Gm-Gg: AY/fxX6JEQxTZgLogRVMN/xz7R1AI9UMc2SjSusBfuKJ+/2f7bzIp8r2Up9J0pyugKM
 xFc4KjO5eEM4cImYadOagMS1nHmrxrl4Vo/QZ1H6cVX0D+W2hNH9zA3N0bUYVaVn6PKWrjQlJON
 yQ3bEDiiFk6Hffmg2+UK5qET4Fw2qIqUG2Y80+u1f4pZnIvl6WBFuV6bxYvxCn5Ae9n9KgynUWa
 uQiIiQrhWLZcHHbOSNrQ1tgHHHy4SXRtuOV5SwcEjAeUF2XNOBLZJZft9oXh9pymQYkZN56ZFgU
 i9R0JK7K+NZG31fG2MbPnqplNb1CKvMWT7dbHgpQirvEnQS/eY8Ty51rOL1eXtnYRlukF1RcU6U
 AltTHlyYQV0CAeXOjNm7xJ3r0ZG9RHhvdJ0AUbQ2k8ykEV1TGCkEoaOULrOp/zkScrJwG0qQt5f
 c=
X-Google-Smtp-Source: AGHT+IEL1nXMeq2BJlsHuAy52u5aoRVpFjVRq5SiCRAICb4i7q/TqCJNzz6qu1PFd+45boSGk/vHHg==
X-Received: by 2002:a17:906:f599:b0:b83:288a:2bce with SMTP id
 a640c23a62f3a-b84451f1870mr1249853866b.24.1768024227225; 
 Fri, 09 Jan 2026 21:50:27 -0800 (PST)
Received: from tpx1 ([47.64.114.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27bfcasm1339724166b.21.2026.01.09.21.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 21:50:26 -0800 (PST)
Date: Sat, 10 Jan 2026 06:50:24 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Bastian Koppelmann
 <kbastian@rumtueddeln.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, qemu-arm@nongnu.org, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Yanan Wang <wangyanan55@huawei.com>, Aleksandar
 Rikalo <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH 05/12] hw/m68k: register a an5206_cpu_reset handler
Message-ID: <20260110065024.707a75f1@tpx1>
In-Reply-To: <20260108143423.1378674-6-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-6-alex.bennee@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.47; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f47.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Thu,  8 Jan 2026 14:34:16 +0000
schrieb Alex Benn=C3=A9e <alex.bennee@linaro.org>:

> As the mbar/rambar0 values are currently fixed we can migrate the
> setting of them to the reset handler as well.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/m68k/an5206.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

