Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3B6C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2N6-0006L7-8E; Tue, 12 Mar 2024 09:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rk2N0-0006EJ-0b
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:40:43 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rk2My-0003bR-6g
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:40:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6ade6a66aso287334b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710250837; x=1710855637; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+t0uUj/8xAe8ZWRbCuC0kSPruwvyWe/doC3vWBR0dLM=;
 b=bmn/7dbMbKAi3xWTJH8VezwxUavfClVoJsKTSTPKlvy2ZNzCO50EVjIoMwrP9KQzRq
 8G+JXJfBKI8duUx29q6Y3kVmVWaOgEjlSDdhsHZBO8Zv7xAhFoOKqBIoPy7t7APqAo3t
 5k8+AfRUhDQCkaWk8kcScXR5gBXYPwt4OBFoa0DaN4qcDWf61sN5wPzTgMK++u86QfUl
 f77TIWRroIq5qOVufDibWvsK3Rqz3BR+sc5SA4aVSGOOM+fwZxeief0yvMa+ApVGjNQD
 zfP31Ozh5APDFqcKq1Y4LWV8JCn5RPr4On3ocjFkH4FKcLqN6ugYAiGNtKMWwe/UKMmW
 7gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710250837; x=1710855637;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+t0uUj/8xAe8ZWRbCuC0kSPruwvyWe/doC3vWBR0dLM=;
 b=OI3XqgoYgG27SY33B/jPCi7nnrfrUTlXRqZ7bcmNo5QLXpOKtJgbGj2NH15Vt1hJjp
 7KkHC/WOxqtjVtvtddJpxj+RwKxk9zXjtukUWKT6bXzWByvtPKyChpZbXR1L7xAJensT
 A9NesVb/xPNoq397LqdbWAaZ/YXkstirKlGBeXySvTCQjDfNKXBoC5Ga1PBv6HY8oNod
 qwL3+bV0ne9CIxcfUr20693JDzcq9qMD6euB4rKkYs/BKgGhZDTd/r4k3h7TuxYVAFTc
 aFzgA9zLyuwfbXgpC2IeZAINCbtZwB1KMazQ7WF5j3hHcnfMan2qu/Lmm2vnYGfd0Ij1
 6I3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXyCpPXZ1ImdnxktTJQipuyI+Ev5WQFU+J7lxTxUb5R1jN679tJonTgGtxYESbHQoF3Q2h6RWb5EUcQ/RnLqfEmrNOMI=
X-Gm-Message-State: AOJu0YxVnz8LCbV4fQzAz8O4ki9wcqgS2BNIQm3ITzjpnBX1tMyEV8g+
 rG9+Bk+oBjHuk6TKOEk3UxPSdq4mm7hQdMbH03t/3TJ2fAtEFJxA
X-Google-Smtp-Source: AGHT+IEpJoNp0cfz01x93j0abfFKHk2Sji/WkDLSqghDCfCwWzbosMy7IznK5pLRaGmysMkbo0TopQ==
X-Received: by 2002:a05:6a20:7283:b0:1a1:4c39:3247 with SMTP id
 o3-20020a056a20728300b001a14c393247mr3711198pzk.40.1710250837670; 
 Tue, 12 Mar 2024 06:40:37 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 x18-20020aa784d2000000b006e571bef670sm6128412pfn.70.2024.03.12.06.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 06:40:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 23:40:32 +1000
Message-Id: <CZRTBM1D8OV3.WKHMJHWCAH8K@wheely>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-devel@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as reviewer from PPC
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240220080956.1341831-1-clg@kaod.org>
In-Reply-To: <20240220080956.1341831-1-clg@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Feb 20, 2024 at 6:09 PM AEST, C=C3=A9dric Le Goater wrote:
> PPC maintainership has been a side activity for the last 2 years and
> it is time to let go some of it now that Nick has taken over.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a74d73960c0a..f5a4e4745c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -316,7 +316,6 @@ F: tests/tcg/openrisc/
>  PowerPC TCG CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
>  M: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: C=C3=A9dric Le Goater <clg@kaod.org>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: target/ppc/
> @@ -468,7 +467,6 @@ F: target/mips/sysemu/
>  PPC KVM CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
>  R: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: C=C3=A9dric Le Goater <clg@kaod.org>
>  S: Odd Fixes
>  F: target/ppc/kvm.c
> =20
> @@ -1502,7 +1500,6 @@ F: tests/avocado/ppc_prep_40p.py
>  sPAPR (pseries)
>  M: Nicholas Piggin <npiggin@gmail.com>
>  R: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: C=C3=A9dric Le Goater <clg@kaod.org>
>  R: David Gibson <david@gibson.dropbear.id.au>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org


