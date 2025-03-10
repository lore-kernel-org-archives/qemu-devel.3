Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90060C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trTo8-00050f-I3; Sun, 09 Mar 2025 23:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trTo6-00050P-Cd; Sun, 09 Mar 2025 23:27:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trTo4-0006D7-NF; Sun, 09 Mar 2025 23:27:58 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so7269285a91.3; 
 Sun, 09 Mar 2025 20:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741577275; x=1742182075; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkC8tP0hctYpo03T8g4388EWChg0670hgTHC/2lQT5I=;
 b=D5Xh7lL6aKTE5xryJpv+oM0oFGB5r/mzOjVynAPP9xDd0mNeinJogdbepK9rApTe/I
 Bpx2HvGoHcZAF6T78QeO2ma/BV2/u80vRAuC2514xSqj30F41l6eYocFH8C+UkuzbwPl
 jNJgl51+YypqPSmhGnrHiXwwAYhHxW3060K78ordUIutdJ3PS61V+PBr34p8Cj/Ru1Fs
 fVL25N2JqjS99sCpyC8Tkz3JtmWwY8EGUx7sJ0bPZv6HO9ElChKi4twb7jyTPluUJggq
 NdA4eRDE0oECgG3bE35GK1wwziJ/YoKDRe3AUGOVaXla/K9xbSRUhytZ0oi/Tjk7J7B9
 ZI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741577275; x=1742182075;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VkC8tP0hctYpo03T8g4388EWChg0670hgTHC/2lQT5I=;
 b=wp4r2ZStbWrOV6iqi4IW2velqwarmW9CaT5JzC57VPU3ZjyJL3Wzh+g3vWi1QryZRS
 rjGL/NMCOvyc5VlaPl6M4k39WdSumOKIdH0JTv9lO77nIDPk4ylTtfCDPKsG+Rjn5w9/
 Zkdk0+k/PQ/AejYMpxdFVSESHT9dOc7a7AQGkFuC6L84RHnYqV7CcGQgIRbEGPWopmtz
 hyIc0DsjHG789jFquJzoCeYuMkoZ7nvIBC5TWXKCS7w3pdF9BeMzh4rANjesnawj5X8Q
 pFzS2q597oqv/PAaKSdf7uA1dz/T8QTlb5FISENi1FId2p7wPw8ZJaqaLO2RvbygM3P5
 2FDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYuSTeRw5P1o8FKfv6u13W0cDhYV5/368Z5LzPcU0vYGW6a309JpwZ/1LSef1Uo8RZRUxRu7ACOOt3@nongnu.org
X-Gm-Message-State: AOJu0Yxk0gr1ZliSGYoEtRtjp4ei9/+XQ3JeKrhqn2q/BWmyCnZl3o3C
 COsQLVMbuWE3l3qqclbeGgjWjtOhq7MQxaxdFR5UtozBKF4jhZpK
X-Gm-Gg: ASbGncuofKQnKXddP87eGk+56E5EGvH3UFzwlCofjkKIAAK1rs6l8axc6QG1zqhp2DE
 /xs0OaxHfsqKMPMt08ONvAZ1Alxfupyrp1uXThkoeXDMraZvOtwYUcr3cjheF8aClhgcvjHSmyE
 Iakcw4slhDHNqhBEsOuD5xyaSer/Tsay8w/ed1qjmjcKOqOFHAAqH3bVrS3Wkd8nDZrhat5PSPd
 Ehun+0L0XdFIIhk6X4HJ7xujEUddekto0lI5UuI4tqtbsyIh09ZVrrwFmrUo6m4IkATlrpXZR6T
 VA6+XdavYx1BdOfxv/7ntFMXe7XhTdls89OmHN7G
X-Google-Smtp-Source: AGHT+IGreMQgnR6M/DNR2jaTLkK6bZLPVgxm7EQ6/hPRAliTFJg4WfgSVbiVT5x4CMgm/aIY8MN+FQ==
X-Received: by 2002:a17:90b:3b48:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2ff7ce7b5f5mr18421994a91.4.1741577274416; 
 Sun, 09 Mar 2025 20:27:54 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91971sm66713145ad.165.2025.03.09.20.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 20:27:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 13:27:47 +1000
Message-Id: <D8C9M7S4G9O9.2GJZI8XKEC0X9@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/14] ppc/xive2: Add grouping level to notification
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-3-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-3-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> The NSR has a (so far unused) grouping level field. When a interrupt
> is presented, that field tells the hypervisor or OS if the interrupt
> is for an individual VP or for a VP-group/crowd. This patch reworks
> the presentation API to allow to set/unset the level when
> raising/accepting an interrupt.
>
> It also renames xive_tctx_ipb_update() to xive_tctx_pipr_update() as
> the IPB is only used for VP-specific target, whereas the PIPR always
> needs to be updated.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---

[...]

> @@ -495,16 +502,20 @@ static void xive_tctx_need_resend(XiveRouter *xrtr,=
 XiveTCTX *tctx,
>          /* Reset the NVT value */
>          nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, 0);
>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
> -    }
> +
> +        uint8_t *regs =3D &tctx->regs[TM_QW1_OS];
> +        regs[TM_IPB] |=3D ipb;
> +}

Indentation bug here.

> +
>      /*
> -     * Always call xive_tctx_ipb_update(). Even if there were no
> +     * Always call xive_tctx_pipr_update(). Even if there were no
>       * escalation triggered, there could be a pending interrupt which
>       * was saved when the context was pulled and that we need to take
>       * into account by recalculating the PIPR (which is not
>       * saved/restored).
>       * It will also raise the External interrupt signal if needed.
>       */
> -    xive_tctx_ipb_update(tctx, TM_QW1_OS, ipb);
> +    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
>  }
> =20
>  /*

[...]

> @@ -594,15 +596,15 @@ static void xive2_tctx_need_resend(Xive2Router *xrt=
r, XiveTCTX *tctx,
>          nvp.w2 =3D xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
>          xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
>      }
> +    regs[TM_IPB] =3D ipb;
> +    backlog_prio =3D xive_ipb_to_pipr(ipb);
> +    backlog_level =3D 0;

There is also a bug here, ipb should be OR'ed into the IPB
reg (as xive1 code above does).

We have this fixed up in our internal tree, I have have just
folded that fix in here (Mike is on vacation so I've been trying
to help wrangle the xive patches...).

Otherwise I think it looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>



