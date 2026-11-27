Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MoHtUlFt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWy8f-0004yk-TT; Fri, 27 Nov 2026 10:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWy8Z-0004nv-JU
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:45:26 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWy8X-0003Kb-O1
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:45:23 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67bee1f693bso6432410d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 07:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795794320; cv=none;
 d=google.com; s=arc-20260327;
 b=QwAj2V6cnlv+2FWns9zWsK56oueXn8I+dg8PVu6nQy2Cff1WurpmdqK1L5n1KBvKGU
 +ckxPl/0tLjPvH4MSlbp9n/c9960XVtGNv3OEWxJ/diuo8kf1DptUH0q6AjcPqOqF/RQ
 FBZbxx9RUxWy1r4iQB3DvtSUR+KsI7VAYChwWDUvMvLQbthJJ+jSpHMDKBXmSQlRm+5d
 qrYZVnChW9OPWczRzqNeRI7MdSuYXGtLPf6GKQhtq5m5bU3uDRXVspK54EVUjoDkBbnv
 ShJ1R1LYEKI4FYK66cGIwKg8QICjAVOB0qbburUkW1kTNoPWPUL9aKq3fskhjrjD2asX
 aFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V6e8bUcXfmwruurGdsPve2y/06lAnsYQxcrnSfqCA90=;
 fh=UJMDAVwLVhpMd5RwAIjwTn+9mazAuKfJdIKrk6gZ+1Y=;
 b=P/16aqGOAyR3pmyvbDs26Y7zjNDlYZ7FHY9Ffp/Stj89ZxhXsaHDyHPkLUd6WnfkYQ
 S5pgSPS4USwHxu39MZNeh+21evCBpUnt3q1GmE4q0gdUPLM/VhQOizfB/ZIwvxRI6tP1
 1l1QYbLILzgKg87SIn5vGfWzDtLZToavyd+DpuQPKGY7FXCPGLhG+j4oHL6CGeg+g3ae
 23pF2cNGpe1vRQdty1QkCs1badnWaZksGmLkNIR4ghHpDQ7SItaDQNFzBBDSWSx/iZyr
 Omc2ZrYVKIux9RAm1JoWV3zjJeg0MfAq/VL0J7EJ5yq7QdLtyoP+YazVyDiRWiyTlU8Z
 aCgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795794320; x=1796399120; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V6e8bUcXfmwruurGdsPve2y/06lAnsYQxcrnSfqCA90=;
 b=MoHtUlFtX4iemadm4aesYg0iDhXPoHgEtrwVuylewLdYpJKwIOSYBarJCsn4lUKiyy
 rVEH0Tne2luTZeBzUndwMa4buic6uiei35vcxO9FuHbMiN9ztl0gdnwLx20wTlhLvNbj
 5u0JDaUhVEx7gxHUoq8Ub9tDoEv+Qriph4RCbLCHoC1ZPqAS/H6B1c+LaFDIjAVXPiPB
 SZqFcm0qTOpiAieRwtrP2HPfDV9pIkusWxmRpZ+vcGTGG31v/rI6Mv9NG7TzwoPupBGD
 scC4gKmmr85MTp7NuUl1jRIc504qkSo3JfmbJ/NWvBsaosmDZy+pR9yZyD1gXGJW1J8b
 wJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795794320; x=1796399120;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V6e8bUcXfmwruurGdsPve2y/06lAnsYQxcrnSfqCA90=;
 b=T7c++pIL5RgjXUyAO+NpTphvT6STozq6cAUtt+FtVy+CGi+oD2m/e5xPv5L/QXj2zP
 LkoKPV6etE/aURJ34QGMwuQsfygCcq6OMg5bilXAytMrSvxIrO5k0yKlyS1JSmzBtnYV
 IiEbAqFVdUZXHq70RiY/C+CazWNA+9+FavPlTFJ7ZKhgy2zsrS6ie97S1OFkOoep3bYl
 hYl0vItxI6fhFIgSa9qx+yKx4AbhZJgv4rwMwZ24DCqHIw8H7hA5JFgLASSehXTB2Tes
 Cb3mo46k2WZo/tkH2oovklAyyFUbBDv/wuNi9WVV6xOfnlhtxb+ifBpXht0UlfV8mAlR
 PNkg==
X-Gm-Message-State: APuU4Z9mOJcvMo2vWZnXyUADK1Nf/o/Q6Q8dwi8ZOj2OmurqXOMxjjfx
 Fjyn0eh7Da+w1cR320HdEupn9eFvUPJjr6MRT6yBlJCDUydfHWMPdFjK7Pxt5/TL/vjJzjKmWaU
 iqwU4NGiqS3nC7wEHpPZ0ZVPvS/RiFoEE54W5AR5gWA==
X-Gm-Gg: AZFdTZeYUhjcvmTkfvPTFcTjZ4nH8iRC2u1WEz95yCv3XG/D/0dJkx+pY9RIKJ+RiBv
 9nr2fR0WbH8MZf0KNmYO2m/ys4Mqy3TU+CU0RQ55MB/7PBWJwmOY3VflCTQanKfBiTgWFu8ZYJ3
 NdPwpEQyA2cx3yS3MCHEm6uRULH5zwODhk4mdQy5BWf57Vv6sFxQGAHYVOyn2BXkz/WQDWg7bg5
 jmUibxlE88Zkl+hxX4nLnDYKuUMagvz51d0nMOnAWIASKcgURHjY8Ndegw5pEWuIVqu9IN3XhZP
 4wR0QxkH9xsGjjXSBXCH9lIxwn/L3rJP3bimcZBcv5ZRQ7sZ8zirVS1LJj2gzU1czh2IKqIFrb3
 twqJbA96MTwaw8ijN/2gkACQN6VFJZA7xm5doBHB0z10OOiWiDYvTAdpLgGkxA4P+pO1QSBNlyB
 v2ygCIWT3Zk2hoYx2h2GAv
X-Received: by 2002:a05:690e:1442:b0:67e:64eb:2b8d with SMTP id
 956f58d0204a3-67e64eb2c02mr2256295d50.61.1795794319869; Fri, 27 Nov 2026
 07:45:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126131312.47658-1-tcalifano@redhat.com>
In-Reply-To: <20261126131312.47658-1-tcalifano@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 15:45:07 +0000
X-Gm-Features: Aa3M54p2r4e_mYST33TITxdC2qcCJVL8HklNHJReTfCKbqMUDdz2sPd3EnyWkeg
Message-ID: <CAFEAcA_LTV2PNkT+OjvwJHx1mCzM_w2ofezvy9qFGqzpqzV1oA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/dev-storage: Fix heap overflow on BOT reset
 (CVE-2026-121860)
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Bin Guo <guobin@linux.alibaba.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 at 13:13, Tommaso Califano <tcalifano@redhat.com> wrote:
>
> Handling a Bulk-Only Mass Storage Reset only reset the state machine to
> USB_MSDM_CBW, leaving active SCSI requests in flight. Subsequent CBWs
> would overwrite s->req without unreferencing the old request, causing
> late callbacks to pair stale transfer lengths (s->scsi_len) with new,
> smaller request buffers leading to a guest-controlled heap buffer
> overflow of up to ~124 KiB on DATAOUT transfers.
>
> Route the class reset through usb_msd_handle_reset() instead of
> open-coding the state transition. This also ensures s->needs_reset is
> cleared, allowing a guest that triggered usb_msd_fatal_error() to
> recover without requiring a full port reset.
>
> This aligns with the "Universal Serial Bus Mass Storage Class Bulk-Only
> Transport" specification (section 5.3.3.1).
>
> Cc: qemu-stable@nongnu.org
> Fixes: CVE-2026-121860
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4578
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
> ---
>  hw/usb/dev-storage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index 040cf15051..4f1e33506d 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -358,8 +358,8 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
>          break;
>          /* Class specific requests.  */
>      case ClassInterfaceOutRequest | MassStorageReset:
> -        /* Reset state ready for the next CBW.  */
> -        s->mode = USB_MSDM_CBW;
> +        /* Reset the device for the next CBW.  */
> +        usb_msd_handle_reset(dev);
>          break;
>      case ClassInterfaceRequest | GetMaxLun:
>          maxlun = 0;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

