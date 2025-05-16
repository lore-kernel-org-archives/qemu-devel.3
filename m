Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CC7C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFinI-0000Fk-7Z; Thu, 15 May 2025 20:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFinG-0000Cf-7i; Thu, 15 May 2025 20:19:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFinE-0003mK-BF; Thu, 15 May 2025 20:19:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2301ac32320so17170915ad.1; 
 Thu, 15 May 2025 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354755; x=1747959555; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vp1r2WD284soMc46zcEv677TS41H9bMJi50rKw6wMgU=;
 b=Us/G9vfUlF2BEIw0rZcbn2I3LsV69p/n+1tbt4yqxU50ea/fCYPLJw+GpuDhSwoiV5
 mRqvTg7dc/RvqOHzkrIjOqIJMsjnDELNy2y+Q+nO4u0/qgeq2EXWYHpo+0ntN/R7hNX+
 hdgaTombOgKVaEmTWz6LvARxq45YX+p9buo9fakN8Bz01nhL+QQkIuQrcYeaOiTrjBCs
 ZmsKH9/RVq8r5VKG38ioe7AQ4lQzXRHHndRu75FOGymeWqU15UGyKXjOYG/ea/MZNneN
 0O/lasupAfvCOKWBC5MoKOMemGd7Srxu8uRDVqfm0WAxETMiyT6tcHFiy0PdqRIcOzDa
 4SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354755; x=1747959555;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vp1r2WD284soMc46zcEv677TS41H9bMJi50rKw6wMgU=;
 b=LjwBJQJJQ+KZfK17rqiQx9dD1MnvMNgifrVQ1q6i4Sn+2EVFwKn71+04+DAqCwshf3
 MYhI3Z0b9PF1zEWZUNHM0Fwj22LHalT0ay8OTcBjej92olih3VdH8KACOrq4Hh3y1m4F
 +rX7r0hHWnEBBCeadWWajEBgzFp8hDIwo8g9/uo7ZuRZmldpeyATTPVa3NzW7BdtNJ3B
 o6vgQ2u6MYoV9ZnWinMNgMRp2y3IARZ12eiFdtuF05ZUWtCHH1xe6M5GubORqCIvzZeh
 qhdT0oNcyNtElgYAn911TPExRbBcYMhun9oVgf+6tHEJzgO2mfRlKzbkaoeBvo04jwHL
 xYcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJdQl0RUahQtg2b9+DG32E4TiLQKHCwuH+tsCpxO5NsD8RvxOw8mSI3M8c4cSVSXSLP80rADkxfw==@nongnu.org
X-Gm-Message-State: AOJu0YzH3C/zXODHp7U58VW2y9D2ylB2eNvr3FGh4fVlohhG6xoMu0/v
 rPgSjv7FT6vXv5/cN6BajJzm7msgsBAyy2k91JwaLZXLhBjDLVwjAG+G
X-Gm-Gg: ASbGncuf0BU/XfBVllxRLZn0Ojs0eiLWK40+6Myo7Gm+TLL7PxNg6jU+oEizrZ6pSOl
 fFPwxVVxHNpixnApPLvs4hF90XdqC5t9R3c7WoTx+aIICFmFAcEuduOl0QZSfZK2tDTUfBTdv+f
 dQUjIW/4JAPTOCX9vTi7kp7z5vnJt+BDRAQ1u9Zi7pHgVX9Zk8QayYtxyyBegdmhmEp3RfUjIdi
 5YQocTC9NBpa0z9rzpADUra9Tfc0lzM3qc1dDvfIkR0Tsfre9Tibp1eFQDQReoNT0oRAJjbJUat
 4KVL3vHeNUL5t3ajdf7lR0Bnox6ouwnIXpKijsI5aiOJQPo=
X-Google-Smtp-Source: AGHT+IGWfYEZwY5HuJFnQQnEVaWV/GYHoFzTtPio8YCFXU5wWzGDGSGzxqH5Do5Ln63CP/V9mBXlyw==
X-Received: by 2002:a17:903:f8c:b0:223:50f0:b97 with SMTP id
 d9443c01a7336-231d45d67f2mr13794015ad.52.1747354754648; 
 Thu, 15 May 2025 17:19:14 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed8931sm3387515ad.251.2025.05.15.17.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:19:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:19:09 +1000
Message-Id: <D9X5KA4LG6QB.2PZZXC8IICDI7@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 23/50] ppc/xive: Add more interrupt notification tracing
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-24-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-24-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Add more tracing around notification, redistribution, and escalation.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/trace-events |  6 ++++++
>  hw/intc/xive.c       |  3 +++
>  hw/intc/xive2.c      | 13 ++++++++-----
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index f77f9733c9..9eca0925b6 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -279,6 +279,8 @@ xive_tctx_notify(uint32_t index, uint8_t ring, uint8_=
t ipb, uint8_t pipr, uint8_
>  xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pi=
pr, uint8_t cppr, uint8_t nsr) "target=3D%d ring=3D0x%x IPB=3D0x%02x PIPR=
=3D0x%02x new CPPR=3D0x%02x NSR=3D0x%02x"
>  xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x=
%"PRIx64" IRQ 0x%x val=3D0x%"PRIx64
>  xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0=
x%"PRIx64" IRQ 0x%x val=3D0x%"PRIx64
> +xive_source_notify(uint32_t srcno) "Processing notification for queued I=
RQ 0x%x"
> +xive_source_blocked(uint32_t srcno) "No action needed for IRQ 0x%x curre=
ntly"
>  xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_d=
ata) "END 0x%02x/0x%04x -> enqueue 0x%08x"
>  xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_=
blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate EN=
D 0x%02x/0x%04x data 0x%08x"
>  xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, u=
int64_t value) "target=3D%d @0x%"PRIx64" sz=3D%d val=3D0x%" PRIx64
> @@ -289,6 +291,10 @@ xive_end_source_read(uint8_t end_blk, uint32_t end_i=
dx, uint64_t addr) "END 0x%x
>  # xive2.c
>  xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t prior=
ity, uint8_t rc) "NVP 0x%x/0x%x operation=3D%d priority=3D%d rc=3D%d"
>  xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint=
8_t priority, uint32_t rc) "NVGC crowd=3D%d 0x%x/0x%x operation=3D%d priori=
ty=3D%d rc=3D%d"
> +xive_redistribute(uint32_t index, uint8_t ring, uint8_t end_blk, uint32_=
t end_idx) "Redistribute from target=3D%d ring=3D0x%x NVP 0x%x/0x%x"
> +xive_end_enqueue(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "=
Queue event for END 0x%x/0x%x data=3D0x%x"
> +xive_escalate_end(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, ui=
nt32_t esc_idx, uint32_t esc_data) "Escalate from END 0x%x/0x%x to END 0x%x=
/0x%x data=3D0x%x"
> +xive_escalate_esb(uint8_t end_blk, uint32_t end_idx, uint32_t lisn) "Esc=
alate from END 0x%x/0x%x to LISN=3D0x%x"
> =20
>  # pnv_xive.c
>  pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=3D=
0x%"PRIx64
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 1a94642c62..7461dbecb8 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1276,6 +1276,7 @@ static uint64_t xive_source_esb_read(void *opaque, =
hwaddr addr, unsigned size)
> =20
>          /* Forward the source event notification for routing */
>          if (ret) {
> +            trace_xive_source_notify(srcno);
>              xive_source_notify(xsrc, srcno);
>          }
>          break;
> @@ -1371,6 +1372,8 @@ out:
>      /* Forward the source event notification for routing */
>      if (notify) {
>          xive_source_notify(xsrc, srcno);
> +    } else {
> +        trace_xive_source_blocked(srcno);
>      }
>  }
> =20
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 34fc561c9c..968b698677 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -616,6 +616,7 @@ static void xive2_redistribute(Xive2Router *xrtr, Xiv=
eTCTX *tctx,
>      uint8_t prio_limit;
>      uint32_t cfg;
> =20
> +    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx)=
;
>      /* convert crowd/group to blk/idx */
>      if (group > 0) {
>          nvgc_idx =3D (nvp_idx & (0xffffffff << group)) |
> @@ -1455,6 +1456,7 @@ static void xive2_router_end_notify(Xive2Router *xr=
tr, uint8_t end_blk,
>      }
> =20
>      if (!redistribute && xive2_end_is_enqueue(&end)) {
> +        trace_xive_end_enqueue(end_blk, end_idx, end_data);
>          xive2_end_enqueue(&end, end_data);
>          /* Enqueuing event data modifies the EQ toggle and index */
>          xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
> @@ -1631,11 +1633,11 @@ do_escalation:
>           * Perform END Adaptive escalation processing
>           * The END trigger becomes an Escalation trigger
>           */
> -        xive2_router_end_notify(xrtr,
> -                               xive_get_field32(END2_W4_END_BLOCK,     e=
nd.w4),
> -                               xive_get_field32(END2_W4_ESC_END_INDEX, e=
nd.w4),
> -                               xive_get_field32(END2_W5_ESC_END_DATA,  e=
nd.w5),
> -                               false);
> +        uint8_t esc_blk =3D xive_get_field32(END2_W4_END_BLOCK, end.w4);
> +        uint32_t esc_idx =3D xive_get_field32(END2_W4_ESC_END_INDEX, end=
.w4);
> +        uint32_t esc_data =3D xive_get_field32(END2_W5_ESC_END_DATA, end=
.w5);
> +        trace_xive_escalate_end(end_blk, end_idx, esc_blk, esc_idx, esc_=
data);
> +        xive2_router_end_notify(xrtr, esc_blk, esc_idx, esc_data, false)=
;
>      } /* end END adaptive escalation */
> =20
>      else {
> @@ -1652,6 +1654,7 @@ do_escalation:
>          lisn =3D XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4=
),
>                          xive_get_field32(END2_W4_ESC_END_INDEX, end.w4))=
;
> =20
> +        trace_xive_escalate_esb(end_blk, end_idx, lisn);
>          xive2_notify(xrtr, lisn, true /* pq_checked */);
>      }
> =20


