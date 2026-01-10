Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FCED277D0
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 05:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veRjw-0007KL-AU; Sat, 10 Jan 2026 00:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRju-0007Ju-ID
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:42:18 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRjr-0001sB-RK
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:42:18 -0500
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b7277324204so762528366b.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 21:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768023734; x=1768628534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zkZ3g/PYYS1upNUgjJa89MZRfvZ4OxliVSa97j3PzXo=;
 b=vRfvQRfrMfEH3D49vczEIeKGidCRB73Vpp6wBC39MZXp6L/BseNKbY9M4n2DVxpHZq
 b2o7uYcg01mQWcjcEnLlctWpIJCFYKZ60Q0A/k36qIqHL9dI7iuLlgrqeEglwQ5pVC3T
 XxuBkFAlKn6UHHISS/sGpjYtcNnnunEtNJqdEKOaiQMdjrGQq9vHG1Zfjvjs07r8ya6U
 +xMGEH4HM1NcLlSc5JEVpc7JTVlfW87wza5QlL9rdhhFaf5IVJfWa5SDeskwLVWxxq1U
 4tvI2cf9lH0pglmqoADq1/uCfthslC+GaKjukpO4hheEqCm/3+V5poEH8zQ+Gxcy8ynR
 ScVA==
X-Gm-Message-State: AOJu0YyvtOp/uX3HBnzg3rKOk6PVT3L7PqgrM157vYkpYa0pXV4Nk7Db
 oPdFSd5D4zY2tXikazXI6olEfwTyOInOS/pkvW3iiZdR/4eNkO5iyth2
X-Gm-Gg: AY/fxX6kIIVbBZzcQvkAy+kx4xnBnyvfgOov3h+WcyJT7Gt0xjLmmT5hFkk25trVEmp
 M3IwW6f4uaNb2yFpznZj6xrpzDTO4lXgM8UVA+vasGp+MU7BrV3q9vnRYCU/dbj5VT87tEJi7wV
 M7erCA41MJeiiF7HIH8iK4UK5v7BZgiOYrp9zWzyMCEdBL1hueIosch+/lT/YJEJpLLLslYfUJv
 mAEbil1P1za95q3ZsCQmhzWnY2LDS4Bca+FX5Uy1RplzQ66y30+M1otWlnIW+jsaNr5u/IYj03I
 BiAKOp/dH2dyA9MpYKd6C8dn18UQ6JxTfYVslex/GAOwyIl4Mo7Nq6wLbv9Z3Jnz0Pz4W/Al/mf
 w5Q2mETR7w7E4VF4QSaJaThPKAd2H3NvuMOiOl1gbcmyDmwfC0EKNe1VDRN36/x9tlaN1N5oilg
 4=
X-Google-Smtp-Source: AGHT+IHU+EVzbu2BPgGceKfUbYZbfiXbVVDhji/SMTbft2TAcuTVtIwnstWw43EMU4R3lxIuHHd4oA==
X-Received: by 2002:a17:907:2da6:b0:b72:134a:48c8 with SMTP id
 a640c23a62f3a-b8445232b14mr1156831566b.14.1768023733996; 
 Fri, 09 Jan 2026 21:42:13 -0800 (PST)
Received: from tpx1 ([47.64.114.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f61d2774sm70046066b.41.2026.01.09.21.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 21:42:13 -0800 (PST)
Date: Sat, 10 Jan 2026 06:42:11 +0100
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
Subject: Re: [RFC PATCH 03/12] hw/m68k: register a nextcube_cpu_reset handler
Message-ID: <20260110064211.40a4388d@tpx1>
In-Reply-To: <20260108143423.1378674-4-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-4-alex.bennee@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.52; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f52.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Thu,  8 Jan 2026 14:34:14 +0000
schrieb Alex Benn=C3=A9e <alex.bennee@linaro.org>:

> This is a fairly simple migration to the handler. Alternatively we
> could eschew stashing the value in reset_pc and just re-read the ROM
> on reset.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/m68k/next-cube.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

