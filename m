Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D76C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnSwS-0002W6-Vc; Wed, 26 Feb 2025 20:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSwR-0002Vq-CL; Wed, 26 Feb 2025 20:43:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSwP-0003ki-Ro; Wed, 26 Feb 2025 20:43:59 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22349dc31bcso6129075ad.3; 
 Wed, 26 Feb 2025 17:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740620636; x=1741225436; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InF8DnnR6m1Zio9kxeVssLsQ+3B2vwIjwFSQEWbGxOo=;
 b=DhWg18qkc+vfyEUDBRlUREdRoLoBcz5oiU5M+mZR/6l+8fYGcYwo+DaKEdVQUfneIs
 T54MtwEbcHU6XRuhhAcLK26ofASPqqRUMlQdppNTbNzcupmpgc70MJNpLuyZcwSDYRlk
 +16n8XOTQXxrQP1uKstLf7BYV1WwIGxtfCG+JzzsjWyp28W/nR228bA3PGiLn7Hu4VAq
 0WhbD2sy7VytKN9HE7/K8Q+uGJ/XNxRH17+axqDw6P8/trSmf6Jx7cEE1ui083t6O6pK
 yovPXh6MCQl7w3APzjdsmoR6zZMw+qud6Nv3AILBpe751udSr7UQuUkZ1lyDIBtFuKd3
 Ba8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740620636; x=1741225436;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=InF8DnnR6m1Zio9kxeVssLsQ+3B2vwIjwFSQEWbGxOo=;
 b=pNQQDMyARfFnVDOBeEtAyTnNS/VxbzcBj6ldsubJxhf0F/fqVxRGov1RtgvE1+C87R
 UO637o7YSoH7FbffFkihH/hrZNl2XYiYxfyruYrz+nyMPsy3VZ1WZXp9rj4gCf6VdDI6
 o3elACzHGzcM9PG4N4nqL3Mg1QRY/WChlnurgwo43W24QanwcLAqpWI7OY8G86RddgO9
 ai373lm9cEfZSf9I/k4UgKqB87XLU7P5yKYojh39OH17wOezeX90Bpp7r+Ved42crVmd
 iUpujcoRpGTrlgVg+q+Fg6LlGqF03wx8FIkQKEKAFd8IUtIqmqkUmuy/qySuA9NUT6z/
 J/MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXamA+kn/rNOTKuWXx7DGc7mFPKV2CbCWoSoU3XATiOArN8rOpo2YXP77qARdasa3cpPTlOXM8E+3Mj@nongnu.org
X-Gm-Message-State: AOJu0YxDgCWPhjMrbcXxQn6SlSDAdLKD8WvdRg/LGBz19VmCY+WzrgJf
 /VE5OcvPNf25mucxs+6RBCp6kgFNTbwRYwbjM33fF7dWwvtyFyR5
X-Gm-Gg: ASbGncvLdGmnjlTgTYax+UCD69UA+uvDO/4IYCGbKQJw2KXGjIm1pMEPxv3t05Paerg
 6vC0cub5eAvB/OC8nIpkhokOLNKG/qsrn7t/bDAK4hOOz1Ov9XNj3Mx82fC5xt1gKL5WUsUUhhz
 RBvwGOT/DcLJ/Ka5C7fcO56jSqd7Eik7uJ7+JdxO7SdejtuntP7nmcRXmNG3BBcHKv6A+h07c9k
 vpGkKIEEK9imoa9ZkQSw+LllioIrxGCIquW+nW00jx5vdPypGX8dwSb1Xf6iPF0fTi76EYBuD7/
 v2M6TLDzikJW6aBHgA==
X-Google-Smtp-Source: AGHT+IExIevneZZsIlF/Ew+hU44UD2XeZGkM4lFPLH5kCI9x9s5rY4bLN25j7mT+BavWoa96x0cGkg==
X-Received: by 2002:a17:903:2f8f:b0:216:485f:bf90 with SMTP id
 d9443c01a7336-221a10ee708mr294879485ad.27.1740620636025; 
 Wed, 26 Feb 2025 17:43:56 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501fbdecsm3230435ad.101.2025.02.26.17.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:43:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:43:47 +1000
Message-Id: <D82UIL82RUKQ.17WJ17XP8YEVA@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v5 2/4] hw/ssi/pnv_spi: Coverity CID 1558827: Use local
 var seq_index instead of get_seq_index().
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-3-chalapathi.v@linux.ibm.com>
In-Reply-To: <20250103161824.22469-3-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
> Use a local variable seq_index instead of repeatedly calling
> get_seq_index() method and open-code next_sequencer_fsm().
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  hw/ssi/pnv_spi.c | 93 +++++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 45 deletions(-)
>
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 63d298980d..87eac666bb 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -212,18 +212,6 @@ static void transfer(PnvSpi *s)
>      fifo8_reset(&s->rx_fifo);
>  }
> =20
> -static inline uint8_t get_seq_index(PnvSpi *s)
> -{
> -    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
> -}
> -
> -static inline void next_sequencer_fsm(PnvSpi *s)
> -{
> -    uint8_t seq_index =3D get_seq_index(s);
> -    s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1)=
);
> -    s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_I=
NCREMENT);
> -}
> -
>  /*
>   * Calculate the N1 counters based on passed in opcode and
>   * internal register values.
> @@ -637,6 +625,7 @@ static void operation_sequencer(PnvSpi *s)
>      bool stop =3D false; /* Flag to stop the sequencer */
>      uint8_t opcode =3D 0;
>      uint8_t masked_opcode =3D 0;
> +    uint8_t seq_index;
> =20
>      /*
>       * Clear the sequencer FSM error bit - general_SPI_status[3]
> @@ -650,12 +639,13 @@ static void operation_sequencer(PnvSpi *s)
>      if (GETFIELD(SPI_STS_SEQ_FSM, s->status) =3D=3D SEQ_STATE_IDLE) {
>          s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
>      }
> +    seq_index =3D GETFIELD(SPI_STS_SEQ_INDEX, s->status);

You could add a comment that this field is kept in seq_index and not
updated in place until the end of the function.

Otherwise looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

