Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C807CD277CA
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 05:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veRbP-0005g9-NV; Sat, 10 Jan 2026 00:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRbL-0005fW-PY
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:33:27 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRbH-0007Z5-Ef
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:33:26 -0500
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so7841393a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 21:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768023201; x=1768628001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZJM9+Qb5R3H/JqYUjp/RvWtsDXW5WPQG7eijFBqulg=;
 b=Ox8Z2fCDtqkKy0ccow6gvft/0vBYW6FudclJmVzHNIhQx9urFeubBju+Ee7mVcCStD
 0IjQW5d25F6F1Nk88ya7Po66QeelKcCn7cfj3zcOc28HGSjBTHAgDcgwhV21BIXFqdC3
 zdq34l39kxakdO/c93tlrDkdYgWQ4vCi93socnu3KJY6t+zHJ+532Zxs1D7hevtOL61E
 u/MMqmYYEgDmxFCBxsfzPwDGrgC+eKqvMAczifLNUwQTatsn0vieDue8uDenINcWCu2X
 z1qg6nNH8TcDpqUVR9uKAuPnqck44DoguTFpD6GruHr+WuNRlM8RPEOxvrYIpFQ0Kvvn
 aLAA==
X-Gm-Message-State: AOJu0Ywiqjv5LT+odbcEuHGXzanlRuC6bAdLldmEutSWVPqLV/nIjBdk
 pPTvzgrXT2xLRn91s999J7SxEY3fu3I9yKoKYcixj4bb607fUi/0Ohly
X-Gm-Gg: AY/fxX6pXkudsxb0jbVC4IsgK2qN+ihRsRsJQQitH0v5hGwncjw4koj/2AU45Itu/Eq
 HRj9q1Ye2IM6ryJMJ39+Za89YhREowXe70bIFKXS7gsxK0NRQKHXW4xLgeHu+xpIUBFAYbSmcjf
 RmiEnYXhaC6sCN2rAXz8ZGsFRYy2FGBUWisjXlXKLd+re7fBdeXwTyIPhMpLBJESGXQoAOPYp9K
 RgQrbgwHJEOnsMRW8fxlTLG5wE/9u0gGJ6mRe/Q+buZll98cRPJYcXdhNYfFf1wuq5ycUM9nt6B
 DR55jQZrRgo+/AXFwbA+FrgvPhBD3ZbU7/7wrk01UQ+2DD06aIgjaZe98Z1BT+E7ZEPnmS9trZX
 gcsJqLpAaj//ffbGixIwjhuNj9tfaTp2SVx8ZqkM0jVkU008zckCmzb+bbhwzBgUQd2kRYpc2dd
 4=
X-Google-Smtp-Source: AGHT+IExWRr5JVdYHAcJM2mVArTFlt0PJWqFpyIFMwyhmdizG/7Pg9VpAVShnvab0J7VJmLTx3TlAQ==
X-Received: by 2002:a17:907:60d4:b0:b80:413:16d6 with SMTP id
 a640c23a62f3a-b844537804fmr1121005866b.44.1768023201181; 
 Fri, 09 Jan 2026 21:33:21 -0800 (PST)
Received: from tpx1 ([47.64.114.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86fee09163sm5120966b.26.2026.01.09.21.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 21:33:20 -0800 (PST)
Date: Sat, 10 Jan 2026 06:33:17 +0100
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
Subject: Re: [RFC PATCH 02/12] target/m68k: introduce env->reset_pc
Message-ID: <20260110063317.38311d23@tpx1>
In-Reply-To: <20260108143423.1378674-3-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-3-alex.bennee@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.53; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f53.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Thu,  8 Jan 2026 14:34:13 +0000
schrieb Alex Benn=C3=A9e <alex.bennee@linaro.org>:

> To transition CPUs to use the multi-phase resettable logic we need to
> stash some information for the reset handlers. Arm does this with
> arm_boot_info but for m68k all we really need is the PC we should
> reset to.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/m68k/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index d9db6a486a8..fda015c4b7b 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -155,6 +155,7 @@ typedef struct CPUArchState {
> =20
>      /* Fields from here on are preserved across CPU reset. */
>      uint64_t features;
> +    uint32_t reset_pc;
>  } CPUM68KState;

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

