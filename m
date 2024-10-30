Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D9DD6B6AD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BvZ-0002Ji-MN; Wed, 30 Oct 2024 12:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t6BvX-0002Dl-OJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:52:11 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t6BvV-0007JJ-2H
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:52:11 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-84fed1ff217so489140241.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730307128; x=1730911928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPQY7TmP7oiDaTw+kan7ynxRCQCdLmwUdVQ7ZzT5UsU=;
 b=bGceNJhjOtUy6fN5CErbb+t+L10tNss2O61lLBnCZ4rFwffeCYJauBoSJ5/XgzAqLA
 v8xxm3emX/NTAfcjxJROnJmJgDXglTJeoQ+yo2sII8vVtLhxDJQYxntGKH2JhBHX6sEi
 puv8D/jWABo+S4MW2UihE065d2dGDTf7WiBPyI6XGcY2i0CKniEQimqi7HaigFgac766
 0YDIKsl3+hY4t4g6qguaq+oxxBX1hPdFeCzPuU12AXd5SFBrfkf/CkQ7peDMmYld4qoh
 eZ+2U1Zc/aE7te6I/jwBZ45QkWrsM0ZboBX6+358tPCQkMmkbNIk60iBCV1JCAE896Oh
 IG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730307128; x=1730911928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPQY7TmP7oiDaTw+kan7ynxRCQCdLmwUdVQ7ZzT5UsU=;
 b=Z2HK4rrtr6fLbJWUr/dw/4j3TQgnBJ5NA0iJY/NxENFnB/caYU0L/cDmqVfefKaIXe
 erhCizIo+duoEalqSZmw4kX1LkvjnzeiSREw8Dn6YnBnVD6/qtPLPbC39tG2YAhHskkc
 xjPwdLZ4aDxudhY3VzkB7m1jMKwAqxuteluCv2BQJxI+WgZ68ynDkRXJL+S7Tzncc1z/
 lZjZPBvusfRa06qb+QOQ2ZKcdwzH6q351YDNyU4feQ3LuOhn+oGEGg6tzfWtNvm1GT+R
 XokGYpd05TC+ZU3kYhFSYiWEZlg5wOy45TulyBcRtUs3Sh3JherMeC1RJGpOyNSs9lqC
 rqmw==
X-Gm-Message-State: AOJu0Yz4p3VxbIvDVq0g1wOszGrMOzd1UU5RA/+Nb/Z6RAvwpqsLcPzP
 vaZ6eTVlGk0ll4PkF6/PFspEyhlHXvYzAucJHd7OdlE3IWbuQbMqeJXRX/qfL5LiTiNCPVivnIV
 bSPP6X/he8/SMT8amHOgO4ZEdi8Bo4YwBiHpo
X-Google-Smtp-Source: AGHT+IFr2+Na0Gd+U/OyxjwdtZ5LKOyKEp57HXVv7bLR5GSiJFNOQO5JjeCX694yYNW1I2Q1ORnGoT3ZPzfGzWWVZrI=
X-Received: by 2002:a05:6122:208d:b0:50d:5754:c903 with SMTP id
 71dfb90a1353d-51060864862mr2743733e0c.4.1730307127609; Wed, 30 Oct 2024
 09:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241014184847.1594056-1-roqueh@google.com>
In-Reply-To: <20241014184847.1594056-1-roqueh@google.com>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Wed, 30 Oct 2024 09:51:55 -0700
Message-ID: <CAKbPEtYiZWVo5CxH30sqePTT3RaFWtBbJbpKUAmnJsLg+kUpdQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net: Changing log error to trace message
To: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=roqueh@google.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hello,

Is there any feedback for this patch?

Thanks

Roque

On Mon, Oct 14, 2024 at 11:49=E2=80=AFAM Roque Arcudia Hernandez
<roqueh@google.com> wrote:
>
> From: Nabih Estefan <nabihestefan@google.com>
>
> Converting error to trace message to avoid spamming of message when
> there is nothing to transmit.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  hw/net/npcm_gmac.c  | 5 ++---
>  hw/net/trace-events | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 6fa6bece61..685905f9e2 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -546,9 +546,8 @@ static void gmac_try_send_next_packet(NPCMGMACState *=
gmac)
>
>          /* 1 =3D DMA Owned, 0 =3D Software Owned */
>          if (!(tx_desc.tdes0 & TX_DESC_TDES0_OWN)) {
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "TX Descriptor @ 0x%x is owned by software\n",
> -                          desc_addr);
> +            trace_npcm_gmac_tx_desc_owner(DEVICE(gmac)->canonical_path,
> +                                          desc_addr);
>              gmac->regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA_STATUS_TU;
>              gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SH=
IFT,
>                  NPCM_DMA_STATUS_TX_SUSPENDED_STATE);
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 4c6687923e..bb8f59cf23 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -476,6 +476,7 @@ npcm_gmac_packet_received(const char* name, uint32_t =
len) "%s: Reception finishe
>  npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet sen=
t!, length: 0x%04" PRIX16
>  npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, u=
int32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0=
x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " D=
escriptor 3: 0x%04" PRIX32
>  npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t=
 tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32
> +npcm_gmac_tx_desc_owner(const char* name, uint32_t desc_addr) "%s: TX De=
scriptor @0x%04" PRIX32 " is owned by software"
>
>  # npcm_pcs.c
>  npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint6=
4_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64=
 " value: 0x%04" PRIx16
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

