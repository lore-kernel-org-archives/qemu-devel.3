Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081BCC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGgf-00082w-QP; Thu, 04 Jul 2024 03:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGgR-0007z2-DK; Thu, 04 Jul 2024 03:15:17 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGgI-0001cj-D0; Thu, 04 Jul 2024 03:15:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-72ed1fbc5d9so204168a12.0; 
 Thu, 04 Jul 2024 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077295; x=1720682095; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWEXgdIy3DkJlxF6sTkraf8zfclP/9i3zyl6cnw1LE0=;
 b=DbEOGEPnP5ShD3DNo3ITigXa7Np5t2ENDfbqyBz/3SIPivuAq2JouoLGGjPhVXeDFJ
 pB6b8YAZ9cEOpMzlVFsYsIqzH33TGNCwWM56qcbVYcj/WPWNkkiRRcennaIhL0F5tdWw
 iJ8PX0Om3Tskb4j7WEL1c1yHtopTJYU5vw98fpRplNYrLqy0nB1Crb8vAUUNRuB8HGRM
 FPR6iDoDmq6zClibwC+mxw17Zk7qAbaAqPdo1v63xZ/5Uxpxgp5Hf0XNxSVLYvXCOi58
 BdThm+Hld6w/yi1LObgx5VxWab7KnJjp+DJsTZr0PMQJ5QUR/xg5SJfF0eZsf8BImuVl
 iWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077295; x=1720682095;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bWEXgdIy3DkJlxF6sTkraf8zfclP/9i3zyl6cnw1LE0=;
 b=DslEs6ulJzOe7zaFFVpIOTIcmILnfzgVIW1T9Z/EIcILe+43sJ3EdFmkrjuFgMcsYB
 qzT0aY6ARQ5JTiZ2Ov0zYDHcU1PGJ6OI7KxaG8oNG7Pc8LJBjCvCkjNQCdogq87m84Lu
 8enQWhCTNkLYTJJTcwZnry/duOWi8ZQ1GUM6EbTEf1Rz3MfQecmGp1zztYGafES1kq+/
 tyZB/nc665ekoVEc4tme7QDfpXVZ6c/gx6ZPwSsLGa21tTeJC1qFxdoTjNk7BaUKLuhE
 wIv2eC9Rvd+FQ4IlfCHZencFtjmUyRSfcKzo71BP1N3tH4ovnk/UZHEmg6BSPJ55gJPV
 t5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5IwNBqyqYVQjM2e8dEIsyEfTSZe5kUSTkfiKsnPTinZhO/2VmD56wDZVajMhJL2Henme5AE55KL6JAtWHVoEgxcbjACdRHfdPjiHIXs77Y0Jm8pu8eg1sUGM=
X-Gm-Message-State: AOJu0YytysjbF8pFNpNr+P7FBmy7JzASuFT8e/1mkyhXIo0RSLXpsbcS
 DVYcB4V2c581lqcCzdJK5uG2rVa3J5JbHSSWv7hNQOjUTQVYOcv4uA0wPg==
X-Google-Smtp-Source: AGHT+IHG7KAupzl/V+Dd2Ufy4T5CxeAkdO/trNCfHw5Yz23J/qCLUbOM8OofZG6XbFDWOS/uKI4wxw==
X-Received: by 2002:a05:6a21:8cc8:b0:1be:c551:b74a with SMTP id
 adf61e73a8af0-1c0cc90ed63mr817812637.59.1720077295031; 
 Thu, 04 Jul 2024 00:14:55 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70afeb4186esm780127b3a.41.2024.07.04.00.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:14:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:14:49 +1000
Message-Id: <D2GKIE4BF6NO.22YUSSN6WED9T@gmail.com>
Subject: Re: [PATCH 29/43] target/ppc/mmu-hash32.c: Move get_pteg_offset32()
 to the header
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <b4c9ea90656039d93660ae4f6bf0d042e1a1e290.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <b4c9ea90656039d93660ae4f6bf0d042e1a1e290.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> This function is a simple shared function, move it to other similar
> static inline functions in the header.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 7 -------
>  target/ppc/mmu-hash32.h | 6 +++++-
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index c4de1647e2..44b16142ab 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -201,13 +201,6 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu,=
 target_ulong sr,
>      return false;
>  }
> =20
> -hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
> -{
> -    target_ulong mask =3D ppc_hash32_hpt_mask(cpu);
> -
> -    return (hash * HASH_PTEG_SIZE_32) & mask;
> -}
> -
>  static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
>                                       bool secondary, target_ulong ptem,
>                                       ppc_hash_pte32_t *pte)
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index bd75f7d647..2838de031c 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -3,7 +3,6 @@
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> -hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash);
>  bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access=
_type,
>                        hwaddr *raddrp, int *psizep, int *protp, int mmu_i=
dx,
>                        bool guest_visible);
> @@ -102,6 +101,11 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU=
 *cpu,
>      stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte=
1);
>  }
> =20
> +static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
> +{
> +    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
> +}
> +
>  static inline bool ppc_hash32_key(bool pr, target_ulong sr)
>  {
>      return pr ? (sr & SR32_KP) : (sr & SR32_KS);


