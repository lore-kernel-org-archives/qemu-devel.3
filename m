Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8E4C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKKY-0000nt-Qb; Thu, 04 Jul 2024 07:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPKKV-0000nV-Lv; Thu, 04 Jul 2024 07:08:47 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPKKH-0006oC-7w; Thu, 04 Jul 2024 07:08:47 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5ba33b08550so243080eaf.2; 
 Thu, 04 Jul 2024 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720091311; x=1720696111; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KavNL3WVgEdjsP69NCyf7w7YkEUcVGhcbIhho1oC7s=;
 b=dbWndbpw5dl2AhW6Y63Lkz7+LobK8fBzjNfvP1lNb+kyalzLQ7+09c1Z2AgvV/P5Ub
 kEheD6EBAiUYMQ79hJ2AbTmeq9dNkVBTZ/QXNkxLg6ICaqxe14tgqvMnpJHtZy72U1vc
 cIEXgoBC7mADxtuBsYUZjXyaQXFj/t2zSmEIShamJP3g0a7VvWX4LaOXwUKI3jweQ8O8
 anRsNvCagMhEQ0iFYNHKmoc10fSqGcczEkojetpQIb+7b9vY1gk9mxs6KlKMDDXEF2/r
 zAQAc5kO1aH69PzG2lNdNYC/iYsx4CXX/RgOf/1gqymAl+bo9pD/sOIKI2MpMnc7orwt
 TCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720091311; x=1720696111;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/KavNL3WVgEdjsP69NCyf7w7YkEUcVGhcbIhho1oC7s=;
 b=RHwi4h2EKhFwt28M5EXyZ4CnlGb6s2y0jqZB/BKeNa+oTCYb6B8BM/A1AongThplKD
 HzgywULYTZDYUyELLSM6BAuERbkjqlEjW9AXaaagdANSTo/cpc12gdJk8aVpP/8bw1dO
 HuQapbs1bb4aHiAiZqiRimuDoEpeePHgCCMcpbSzgQgPO4zLmQgPE4s6M5w4sDviqsvv
 yoCVeaxkI4iNWnyl112IWwrJg3CCeX5PMsFuCA6JnumtyY61Hv8UJlB9YsJm4CFanI3J
 cet+0FUtHpM+Fe8cKY0xKSAW6xxc7zcJ0mMEdsYQixLHoxNxKrJzmbl282KRRyEHmm9g
 G3kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWle/+Pyi+EE9qTR64e4Z+Xr1b/tJSwitCW82Ch0VVaJ0W4iHMXMDRQB4dM6rZaUq/DpyScuFerf6Icym1JdcpVHfa5h9yeHNDti7ZCvLhQ5ApaD127uR8BH7jmiKxlOhlww5QwvJzp0cPd1M6WabVBDtY=
X-Gm-Message-State: AOJu0YxpZ2p9LtPyG2NRGFsTA1aBHuXtcd2g1ozzZsqMor4xr78DKtGq
 RW4qw/aSDwcXPnCsfP7Ot5i2CS6xXOxM6w57ARDpjT6WaHGdPi1c
X-Google-Smtp-Source: AGHT+IH1UtA8aeBw+pwAIhktWEPrHD5CXYbo97+Xjv54sPOI2zfUioFLzbRKrY91XKDLy/NcP14jJA==
X-Received: by 2002:a05:6870:41d1:b0:25e:13b7:e361 with SMTP id
 586e51a60fabf-25e2bb7af60mr1177892fac.25.1720091310758; 
 Thu, 04 Jul 2024 04:08:30 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708042c07d7sm12376179b3a.143.2024.07.04.04.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 04:08:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 21:08:24 +1000
Message-Id: <D2GPH8NDJC5N.W2ANEA2TF82V@gmail.com>
Subject: Re: [PATCH] spapr: Migrate ail-mode-3 spapr cap
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240506115607.13405-1-npiggin@gmail.com>
 <0ab5211c-f947-4a7c-b878-f48d1748a972@tls.msk.ru>
 <793df53e-337c-46b0-be32-ced550002daf@tls.msk.ru>
In-Reply-To: <793df53e-337c-46b0-be32-ced550002daf@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon Jul 1, 2024 at 5:10 PM AEST, Michael Tokarev wrote:
> 06.06.2024 14:26, Michael Tokarev wrote:
> > 06.05.2024 14:56, Nicholas Piggin wrote:
> >> This cap did not add the migration code when it was introduced. This
> >> results in migration failure when changing the default using the
> >> command line.
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Fixes: ccc5a4c5e10 ("spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 su=
pport for H_SET_MODE hcall")
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >> =C2=A0 include/hw/ppc/spapr.h | 1 +
> >> =C2=A0 hw/ppc/spapr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 1 +
> >> =C2=A0 hw/ppc/spapr_caps.c=C2=A0=C2=A0=C2=A0 | 1 +
> >> =C2=A0 3 files changed, 3 insertions(+)
> >=20
> > Hi!
> >=20
> > Has this change been forgotten?=C2=A0 It's aimed at -stable, so must be
> > fixing a real issue.
>
> Ping #2 ? :)

Ah sorry, I meant to deal with this before. But yes I did forget it in
the last PR and it does fix a migration issue. Thanks for the reminder
of it.

I'll send it in  soon.

Thanks,
Nick

