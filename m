Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5142FC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUCP-0000bY-7r; Sun, 09 Mar 2025 23:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trUCN-0000b4-0s; Sun, 09 Mar 2025 23:53:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trUCK-0003Tx-Jq; Sun, 09 Mar 2025 23:53:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2235189adaeso60500315ad.0; 
 Sun, 09 Mar 2025 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741578779; x=1742183579; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7mGyAoLIhfQyiD6auzcbuw4s1xDbAKcFJrc7KQPHb0=;
 b=OwHrJ7IAKSACcODIj3h4bSkSXuEN+i71oqkpeP+UzKik8EN5+mvKUQEIPF26oVEjwi
 Wqw8VfX6TgT4n9YAZy9iZF3BOx3SWatKhoMYcGJdjgqQsyfs6sRj+M8dFsfMmJi5pXFE
 SI8KWYWp9LU9gKOkR6eNIoUS8jxwvVsgls+uLPHKTqTGPggTOeV1KMey/a5ldevmtb7C
 vI6uaiUGLeEQFR3iRzGfCKIqB6hEdPOOujemEI9MH174VHbTLje/uUsWUSkTLJaTRkkw
 WLPAW/eirHtncdK8Fsvg70L8GDHxUkkWdpe9j/75lAUcnTWYZSe5D7/70ECGFlTuoyAN
 BoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741578779; x=1742183579;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H7mGyAoLIhfQyiD6auzcbuw4s1xDbAKcFJrc7KQPHb0=;
 b=vjq0NuE4fQzvFMHkvzT5Q4xp7gvfi2L4mC5hrv/RSJyme2mF7LSL2ZStegQN90uuHk
 RpjarlRXnnSsi8vPU2CVM/cQWCkRhBQH4GrlQkBrK/d0IVvQJsy7e9LYSDZFncq02rtS
 wlHWz4f91XnispPvflRRyfhixRSJtjKDGN4zsbksUQ6ukhECzyB/enUIJJd2ZeqMVGbt
 syiEcrQ05AM2ryg+m5tdC1xhk1Bc0R7W6X36umcmq4lp7Uvp95OTI0D6woj1F40X81Qy
 03IlhS0d6qtd6Rq8qy32Ae2ZRDoZ+78O/SL1XWxZqvpeY2PqBYy83bMRXAmueIVvwgZF
 DADQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPvTveRcqpt6YY9/pYSJgQQiWYGdBwXnOddUpD2fVHTmUXfpD8wdotx77xuKfY3/Dt8deGw4pPaj9k@nongnu.org
X-Gm-Message-State: AOJu0YwAqaY44+2AyuDL6qx/pGV9z8aEGTOJ9FcNJZRpKih94nKPySFf
 UZHcrybZParCtywWKMbQ5wmP2ZuoZ3ZGCzoZfnmj/0M9Pg3HJ6rgNbDfww==
X-Gm-Gg: ASbGncvJY1qcmB/iWUQoCk51uLyUjNz5UCIXxMqplY9jcjPa/Ndo718sHmTzPyfoTII
 Xjgxr3J8aWPXN+o8uE8gLt6fGIDOXLnuzzruXN2TZDhSJbynv/eDiHYZAEHu4rv5AS3nAFuXz59
 rvcXI/nJf4oRu37CyE+dCHep9TTFg0L8Hza7Hke5IDN+ZjmgUYgk3Dp4eIaiUP9+YCHEs8VbeBQ
 Sf88p+UIgFvRXTxxRzOLbndP85e70qj1ymwky6Xccx36Rd/gPoRuiaFzOEPYFsggExm++VIw949
 FRJnLBmcfQdEOuouxwuYIr7c4aLfFlTVKrKZtA1O
X-Google-Smtp-Source: AGHT+IEYoJyYR7Yo/hpBMwQ7pp6i7VLiq9XwWvMHctwpWIS8ixDwBe8asabnN7qpao4FPF/SUywDHA==
X-Received: by 2002:a17:902:f610:b0:21f:6546:9adc with SMTP id
 d9443c01a7336-2246285e464mr141565545ad.13.1741578778619; 
 Sun, 09 Mar 2025 20:52:58 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa4cc5sm67090145ad.220.2025.03.09.20.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 20:52:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 13:52:52 +1000
Message-Id: <D8CA5ETLWI1K.AOEIWMQ0F5BB@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 03/14] ppc/xive2: Support group-matching when looking
 for target
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-6-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-6-kowal@linux.ibm.com>
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> If an END has the 'i' bit set (ignore), then it targets a group of
> VPs. The size of the group depends on the VP index of the target
> (first 0 found when looking at the least significant bits of the
> index) so a mask is applied on the VP index of a running thread to
> know if we have a match.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

Looks okay to me. We've iterated a little on some of this code in our
downstream tree but I've not been able to make much progress untangling
that and trying to merge it back, so I think this series is reasonable
as a starting point even if there are a few corner cases to fix later,
it's new functionality that Linux does not use, so existing setups will
not be impacted.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/xive.h  |  5 +++-
>  include/hw/ppc/xive2.h |  1 +
>  hw/intc/pnv_xive2.c    | 33 ++++++++++++++-------
>  hw/intc/xive.c         | 56 +++++++++++++++++++++++++-----------
>  hw/intc/xive2.c        | 65 ++++++++++++++++++++++++++++++------------
>  5 files changed, 114 insertions(+), 46 deletions(-)
>
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 971da029eb..21ce5a9df3 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -424,6 +424,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS=
 *eas);
>  typedef struct XiveTCTXMatch {
>      XiveTCTX *tctx;
>      uint8_t ring;
> +    bool precluded;
>  } XiveTCTXMatch;
> =20
>  #define TYPE_XIVE_PRESENTER "xive-presenter"
> @@ -452,7 +453,9 @@ int xive_presenter_tctx_match(XivePresenter *xptr, Xi=
veTCTX *tctx,
>  bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
>                             bool cam_ignore, uint8_t priority,
> -                           uint32_t logic_serv);
> +                           uint32_t logic_serv, bool *precluded);
> +
> +uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
> =20
>  /*
>   * XIVE Fabric (Interface between Interrupt Controller and Machine)
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 5bccf41159..17c31fcb4b 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -121,6 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, Xi=
veTCTX *tctx,
>                                 hwaddr offset, unsigned size);
>  void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                               hwaddr offset, uint64_t value, unsigned siz=
e);
> +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
>  void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>                              hwaddr offset, uint64_t value, unsigned size=
);
>  void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 834d32287b..3fb466bb2c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -660,21 +660,34 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr,=
 uint8_t format,
>                                                     logic_serv);
>              }
> =20
> -            /*
> -             * Save the context and follow on to catch duplicates,
> -             * that we don't support yet.
> -             */
>              if (ring !=3D -1) {
> -                if (match->tctx) {
> +                /*
> +                 * For VP-specific match, finding more than one is a
> +                 * problem. For group notification, it's possible.
> +                 */
> +                if (!cam_ignore && match->tctx) {
>                      qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found =
a "
>                                    "thread context NVT %x/%x\n",
>                                    nvt_blk, nvt_idx);
> -                    return false;
> +                    /* Should set a FIR if we ever model it */
> +                    return -1;
> +                }
> +                /*
> +                 * For a group notification, we need to know if the
> +                 * match is precluded first by checking the current
> +                 * thread priority. If the interrupt can be delivered,
> +                 * we always notify the first match (for now).
> +                 */
> +                if (cam_ignore &&
> +                    xive2_tm_irq_precluded(tctx, ring, priority)) {
> +                        match->precluded =3D true;
> +                } else {
> +                    if (!match->tctx) {
> +                        match->ring =3D ring;
> +                        match->tctx =3D tctx;
> +                    }
> +                    count++;
>                  }
> -
> -                match->ring =3D ring;
> -                match->tctx =3D tctx;
> -                count++;
>              }
>          }
>      }
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6e73f7b063..9345cddead 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1671,6 +1671,16 @@ static uint32_t xive_tctx_hw_cam_line(XivePresente=
r *xptr, XiveTCTX *tctx)
>      return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
>  }
> =20
> +uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
> +{
> +    /*
> +     * Group size is a power of 2. The position of the first 0
> +     * (starting with the least significant bits) in the NVP index
> +     * gives the size of the group.
> +     */
> +    return 1 << (ctz32(~nvp_index) + 1);
> +}
> +
>  static uint8_t xive_get_group_level(uint32_t nvp_index)
>  {
>      /* FIXME add crowd encoding */
> @@ -1743,30 +1753,39 @@ int xive_presenter_tctx_match(XivePresenter *xptr=
, XiveTCTX *tctx,
>  /*
>   * This is our simple Xive Presenter Engine model. It is merged in the
>   * Router as it does not require an extra object.
> - *
> - * It receives notification requests sent by the IVRE to find one
> - * matching NVT (or more) dispatched on the processor threads. In case
> - * of a single NVT notification, the process is abbreviated and the
> - * thread is signaled if a match is found. In case of a logical server
> - * notification (bits ignored at the end of the NVT identifier), the
> - * IVPE and IVRE select a winning thread using different filters. This
> - * involves 2 or 3 exchanges on the PowerBus that the model does not
> - * support.
> - *
> - * The parameters represent what is sent on the PowerBus
>   */
>  bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
>                             bool cam_ignore, uint8_t priority,
> -                           uint32_t logic_serv)
> +                           uint32_t logic_serv, bool *precluded)
>  {
>      XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
> -    XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
> +    XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0, .precluded =
=3D false };
>      uint8_t group_level;
>      int count;
> =20
>      /*
> -     * Ask the machine to scan the interrupt controllers for a match
> +     * Ask the machine to scan the interrupt controllers for a match.
> +     *
> +     * For VP-specific notification, we expect at most one match and
> +     * one call to the presenters is all we need (abbreviated notify
> +     * sequence documented by the architecture).
> +     *
> +     * For VP-group notification, match_nvt() is the equivalent of the
> +     * "histogram" and "poll" commands sent to the power bus to the
> +     * presenters. 'count' could be more than one, but we always
> +     * select the first match for now. 'precluded' tells if (at least)
> +     * one thread matches but can't take the interrupt now because
> +     * it's running at a more favored priority. We return the
> +     * information to the router so that it can take appropriate
> +     * actions (backlog, escalation, broadcast, etc...)
> +     *
> +     * If we were to implement a better way of dispatching the
> +     * interrupt in case of multiple matches (instead of the first
> +     * match), we would need a heuristic to elect a thread (for
> +     * example, the hardware keeps track of an 'age' in the TIMA) and
> +     * a new command to the presenters (the equivalent of the "assign"
> +     * power bus command in the documented full notify sequence.
>       */
>      count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
>                             priority, logic_serv, &match);
> @@ -1779,6 +1798,8 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t=
 format,
>          group_level =3D cam_ignore ? xive_get_group_level(nvt_idx) : 0;
>          trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_=
level);
>          xive_tctx_pipr_update(match.tctx, match.ring, priority, group_le=
vel);
> +    } else {
> +        *precluded =3D match.precluded;
>      }
> =20
>      return !!count;
> @@ -1818,7 +1839,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveE=
AS *eas)
>      uint8_t nvt_blk;
>      uint32_t nvt_idx;
>      XiveNVT nvt;
> -    bool found;
> +    bool found, precluded;
> =20
>      uint8_t end_blk =3D xive_get_field64(EAS_END_BLOCK, eas->w);
>      uint32_t end_idx =3D xive_get_field64(EAS_END_INDEX, eas->w);
> @@ -1901,8 +1922,9 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveE=
AS *eas)
>      found =3D xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
>                            xive_get_field32(END_W7_F0_IGNORE, end.w7),
>                            priority,
> -                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));
> -
> +                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7),
> +                          &precluded);
> +    /* we don't support VP-group notification on P9, so precluded is not=
 used */
>      /* TODO: Auto EOI. */
> =20
>      if (found) {
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index db372f4b30..2cb03c758e 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -739,6 +739,12 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool =
crowd,
>     return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
>  }
> =20
> +static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
> +                                uint32_t vp_mask)
> +{
> +    return (cam1 & vp_mask) =3D=3D (cam2 & vp_mask);
> +}
> +
>  /*
>   * The thread context register words are in big-endian format.
>   */
> @@ -753,44 +759,50 @@ int xive2_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
>      uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>      uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
> =20
> -    /*
> -     * TODO (PowerNV): ignore mode. The low order bits of the NVT
> -     * identifier are ignored in the "CAM" match.
> -     */
> +    uint32_t vp_mask =3D 0xFFFFFFFF;
> =20
>      if (format =3D=3D 0) {
> -        if (cam_ignore =3D=3D true) {
> -            /*
> -             * F=3D0 & i=3D1: Logical server notification (bits ignored =
at
> -             * the end of the NVT identifier)
> -             */
> -            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\=
n",
> -                          nvt_blk, nvt_idx);
> -            return -1;
> +        /*
> +         * i=3D0: Specific NVT notification
> +         * i=3D1: VP-group notification (bits ignored at the end of the
> +         *      NVT identifier)
> +         */
> +        if (cam_ignore) {
> +            vp_mask =3D ~(xive_get_vpgroup_size(nvt_idx) - 1);
>          }
> =20
> -        /* F=3D0 & i=3D0: Specific NVT notification */
> +        /* For VP-group notifications, threads with LGS=3D0 are excluded=
 */
> =20
>          /* PHYS ring */
>          if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
> -            cam =3D=3D xive2_tctx_hw_cam_line(xptr, tctx)) {
> +            !(cam_ignore && tctx->regs[TM_QW3_HV_PHYS + TM_LGS] =3D=3D 0=
) &&
> +            xive2_vp_match_mask(cam,
> +                                xive2_tctx_hw_cam_line(xptr, tctx),
> +                                vp_mask)) {
>              return TM_QW3_HV_PHYS;
>          }
> =20
>          /* HV POOL ring */
>          if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
> -            cam =3D=3D xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
> +            !(cam_ignore && tctx->regs[TM_QW2_HV_POOL + TM_LGS] =3D=3D 0=
) &&
> +            xive2_vp_match_mask(cam,
> +                                xive_get_field32(TM2_QW2W2_POOL_CAM, qw2=
w2),
> +                                vp_mask)) {
>              return TM_QW2_HV_POOL;
>          }
> =20
>          /* OS ring */
>          if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
> -            cam =3D=3D xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
> +            !(cam_ignore && tctx->regs[TM_QW1_OS + TM_LGS] =3D=3D 0) &&
> +            xive2_vp_match_mask(cam,
> +                                xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2=
),
> +                                vp_mask)) {
>              return TM_QW1_OS;
>          }
>      } else {
>          /* F=3D1 : User level Event-Based Branch (EBB) notification */
> =20
> +        /* FIXME: what if cam_ignore and LGS =3D 0 ? */
>          /* USER ring */
>          if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>               (cam =3D=3D xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
> @@ -802,6 +814,22 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, =
XiveTCTX *tctx,
>      return -1;
>  }
> =20
> +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
> +{
> +    uint8_t *regs =3D &tctx->regs[ring];
> +
> +    /*
> +     * The xive2_presenter_tctx_match() above tells if there's a match
> +     * but for VP-group notification, we still need to look at the
> +     * priority to know if the thread can take the interrupt now or if
> +     * it is precluded.
> +     */
> +    if (priority < regs[TM_CPPR]) {
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static void xive2_router_realize(DeviceState *dev, Error **errp)
>  {
>      Xive2Router *xrtr =3D XIVE2_ROUTER(dev);
> @@ -841,7 +869,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr=
, uint8_t end_blk,
>      Xive2End end;
>      uint8_t priority;
>      uint8_t format;
> -    bool found;
> +    bool found, precluded;
>      Xive2Nvp nvp;
>      uint8_t nvp_blk;
>      uint32_t nvp_idx;
> @@ -922,7 +950,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr=
, uint8_t end_blk,
>      found =3D xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
>                            xive2_end_is_ignore(&end),
>                            priority,
> -                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end=
.w7));
> +                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end=
.w7),
> +                          &precluded);
> =20
>      /* TODO: Auto EOI. */
> =20


