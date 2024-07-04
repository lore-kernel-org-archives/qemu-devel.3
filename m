Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC6FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH6z-0006eU-5Y; Thu, 04 Jul 2024 03:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH6w-0006dU-9Q; Thu, 04 Jul 2024 03:42:34 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH6r-0004QF-Dy; Thu, 04 Jul 2024 03:42:34 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-711b1512aeaso227357a12.3; 
 Thu, 04 Jul 2024 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078944; x=1720683744; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsXiVc0fLwRigRqfl/lxu+hQMc8XGBWBIxDEqCRG+zE=;
 b=BNlkBWAoJ+4f7dobSodZSd5QndFzSbdAIxNeXXKDWLZEnU91tXRaoebyjgJET0DK6h
 5J53ZUwLAmZF9xXCtCFV7mYL1kUyp3XKE38NsMqkqzYgL/Y0yrZpcLO556bRTyXjKIpM
 XD0pq7SU5DWXjoQcyNZ6FZgkC2L1sMtNFl77TNg2M8FGqT+Y3NP/5vjKljd8u2mRe6VQ
 LRi7kCehEBiLBsSikOxdA5VtZn+UW4Lhhb7r8rvifu0L80/urVNRmsUxFZLD44iWTrCn
 JQCUrnw+PFg/dVCrg3DyqugWxxxHlw6gusRgjp8oXI92izTcJgKkCjCB19NMJUA252zz
 0kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078944; x=1720683744;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VsXiVc0fLwRigRqfl/lxu+hQMc8XGBWBIxDEqCRG+zE=;
 b=vn6MrsSDp6Xa7wHm5ywNxtXiU1wUXHZKw7RUgU15hru7NijkCBZrl/SZN3AU0ZgH4X
 VghHESd7uGJJJOL0iY+I4wSQyZajYqPNQnsD8x5NxDcGp3bHQARTL9LDYiuKkbb+dRnS
 Js20mfngHPrVPB7HXLgIaFAk0BijE8cbowaYy9V30pH84VkuZopiP2dT+QJtZX992U8W
 Ywq1kFPC42kddkf+uXImWMSUQYCcOMSyIaHB9jdqvzhb5sNKi7tzQkkQytSLHSbJq8hV
 KB0uBTBT841vG2KezrkVnIgbmmsV+LXMxn/CVpiM2oOBPQjtjgXWiWx16/Isnst4pS3Y
 UXlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBqBnyjwWqJScch731M+16G0DvFvfiNevlRcFAMJuse9QYS+szpEbjILeSi8t00TxrRX/0aHKs26oz01Nl9Smmn9pr0PWulrD2XDW+uhqnERYizui57xJQ/SM=
X-Gm-Message-State: AOJu0Yx3V+wibexYIDSqcKn4PHEocoXjtu2EedQhRhaSbUD2epbxALSB
 uBP/6CzYYTTxEHZ97SsQI5zUwTXs9FvaaPUC8Aks6u0DlRCSUJnM
X-Google-Smtp-Source: AGHT+IFp3WYRzkKTEVpWzicX+2yaITA+PPngMcOStC3QfN5XHfBeXbkHcsB2HIucm4q9+URgc7z62w==
X-Received: by 2002:a05:6a20:9c90:b0:1bd:2c23:4d14 with SMTP id
 adf61e73a8af0-1c0cc8d7014mr872270637.53.1720078944232; 
 Thu, 04 Jul 2024 00:42:24 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb36ff02e4sm5674165ad.116.2024.07.04.00.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:42:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:42:19 +1000
Message-Id: <D2GL3FVDHU8B.28PFLUET2HFG8@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 1/7] target/ppc: use locally stored msr and avoid
 indirect access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-2-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-2-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

On Thu May 23, 2024 at 3:14 PM AEST, Harsh Prateek Bora wrote:
> hreg_compute_hflags_value already stores msr locally to be used in most
> of the logic in the routine however some instances are still using
> env->msr which is unnecessary. Use locally stored value as available.

BTW hreg_store_msr uses env->msr a bunch of times. Would a local
variable improve that too?

Thanks,
Nick

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/helper_regs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 25258986e3..945fa1a596 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -106,10 +106,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCSta=
te *env)
> =20
>      if (ppc_flags & POWERPC_FLAG_DE) {
>          target_ulong dbcr0 =3D env->spr[SPR_BOOKE_DBCR0];
> -        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(env->msr, MSR, DE)) {
> +        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(msr, MSR, DE)) {
>              hflags |=3D 1 << HFLAGS_SE;
>          }
> -        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(env->msr, MSR, DE)) {
> +        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(msr, MSR, DE)) {
>              hflags |=3D 1 << HFLAGS_BE;
>          }
>      } else {


