Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC91CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 05:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9zrl-0006wW-4W; Sat, 18 Oct 2025 01:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1v9zri-0006vZ-QY
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 01:52:31 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1v9zrg-0008GM-FE
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 01:52:30 -0400
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso471299966b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 22:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760766746; x=1761371546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kC5/uJPP3WnDo5AHh0vgk9XGDlztc0ecSESwKOHyIvY=;
 b=OZC8FfNcn91lNfcQ8Ei4oezndsy0aTLDRZI6J4qf2jPZqKd9V2YapU223OEhqK+H24
 1Yh/hgGfD4jtkxlMMha7DCL0FR5klCUQwFVD7Busi0f/WCb+NN+fCGhe5ZYHwZA4p4F2
 4MY/Nm/FY94fsdA3kZTEOW8RhhAFrIfO6nisMxHFbEPZAgmw0gMvF9f2n9aF+o9pVfiv
 921rBDp49h6u0zwqrMVG5TkQgGcjy9X9cEACil23+VRSqP4EN0G5iul3fho4GuFDi+W0
 5NPM0Ktb1kV+iaXlXb7pBeAlhiHTKbd+at+DSC+E+I22Zu53x8P3v9a2uRUslwVWVDJR
 OIdw==
X-Gm-Message-State: AOJu0YwQ/348y5Q29MndGJyPtooUeUDjN1u0FTSAG1+nnUDRA1E/d5sU
 Sfrw71E1n/MGQ/en0aDWNq9zn6RufRiWNlSZDYPc7aETOaT7jue9zWO4
X-Gm-Gg: ASbGncvdCv4iIM6Tx3VzSvFJp2SqBoqDpLe7kQIXjl7HAoOfguqzpJ5HoRRrIt02PS0
 ORboHJx0fEKBL0eH4pBBn+5jJTxrRFE+vY1+FHL1UZ3lP5hZx5TX6B7Nj7XMPK0DPCN5zdyaX9M
 tMQOe6fgDDovrbhOIBxWfHViMw0VZd+leMYBuiiTdD1j7xUW9T47x/WU9AiDed9HNnpvAfrPuhU
 Dy/spGwK2N6OoSTziszNk+vygE+Dz5N2ZVFhg3JiX8Yp1YbpzA8fJS1JCUp/8UBRIzmWwpD+idO
 QNAIilB6oRBP4uwa+6OVwtGFlxmv7exsL2fD+89hfu+Ob2ZWqtx45HPPtOgaaZdrB8VhobpLn6K
 ivzoyI1Di2M+tGgMo5q8fofhSQFXCU64ZRoTGbt/hVZzEb7SpFEoFC6oaKRcryUB9O4E4bwUco0
 0LYMqf/3yuO/bDcj6sXHp+D0jVy/QRo8rh
X-Google-Smtp-Source: AGHT+IEwM7hkjdYadSIZ/B1LrJ6NLoLeCs3l9kSDnXN0Bzcy3G/cTbunueoKKeMggcWXJ5k6oQ6wtw==
X-Received: by 2002:a17:907:c06:b0:b46:8bad:6977 with SMTP id
 a640c23a62f3a-b647235ff0emr769025566b.18.1760766745781; 
 Fri, 17 Oct 2025 22:52:25 -0700 (PDT)
Received: from tpx1 (ltea-047-064-114-135.pools.arcor-ip.net. [47.64.114.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb52603fsm167889266b.57.2025.10.17.22.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 22:52:25 -0700 (PDT)
Date: Sat, 18 Oct 2025 07:52:23 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <laurent@vivier.eu>
Subject: Re: [PATCH 06/22] hw/m86k: Get cpu first addr space with
 cpu_get_address_space()
Message-ID: <20251018075223.4f8c47bd@tpx1>
In-Reply-To: <20251001150529.14122-7-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
 <20251001150529.14122-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.53; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f53.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Wed,  1 Oct 2025 17:05:11 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> In order to remove the convenient CPUState::as field, access
> the vcpu first address space using the cpu_get_address_space()
> helper.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/m68k/mcf5208.c |  6 ++++--
>  hw/m68k/q800.c    | 17 ++++++++++-------
>  hw/m68k/virt.c    |  5 +++--
>  3 files changed, 17 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

