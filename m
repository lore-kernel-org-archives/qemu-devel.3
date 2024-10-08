Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D0ECED274
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 08:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy5ME-0004zl-Ib; Tue, 08 Oct 2024 04:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy5M4-0004yW-3b; Tue, 08 Oct 2024 04:14:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy5M1-0007lG-WD; Tue, 08 Oct 2024 04:14:03 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7e9fd82f1a5so1604428a12.1; 
 Tue, 08 Oct 2024 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728375240; x=1728980040; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kx4oI2LbuJVqqIAIe+CbvZgClKYN6OigLYxs0qK/vnw=;
 b=LlAtxO4pjiU8bXp0bB7SNp81nmJ7cB32ItAzkQTwbzG9A08YVEiHmM42sBQgR2qyno
 dRxRCiGxsTSO0W6SoMlb0S/L821N5SF4Bkk6Wt227xCDnETbVX05N1FTt2eZh/0TqwQ9
 hQ5oLxcDFKI7gIO+O+shUlqo3rXMWtz8W1OOEWj0Y0EF4pBCIPQyMNdrhnMb/DuqgbcQ
 ZWc3tpjeSybOlep0wT+4QLt4y0812gTH6IYeG5T40qSbqG6YZKy66P5RKW2YWueNGhQa
 HSKhSoU9eQPmgovIqYopGNmo6/ezc0u66go+SNhv97AMfLLmc6DE6BbseQnoMEBZCcJR
 imEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728375240; x=1728980040;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kx4oI2LbuJVqqIAIe+CbvZgClKYN6OigLYxs0qK/vnw=;
 b=RbbsWORhEKxa28Bw5tWOZdgQXERZ4GFf3b4AhESzXGiuZCWZ6F1LvxNTMN7r1w3QIp
 yZDv0vZGZ/lDKe4pVI9YJLJuuHLh2Ke5s7SrCiBBjFOIe9aGaVDNnAhXvrJJoDrpSY3Y
 L1CiEGdjIH6fc9V10q5J/pzUtxu8Y3psLRBqdIAnYtU9Uwur2eI9VU6gRlUlUhhevqt3
 3q/obuicSc0Af0qYrDy1cNFaKFiwx2UTm0uGLFppWk1wILwmNRr7sj2EuECCe9j8nKAf
 6TjMRYDLKz5epVwv0TU2gEN0iaRo9+1+/9NEbpTCM6RPapfGf/ZDjleKppl3ma4lgPcV
 FTqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlAUW/HmoE2GBQ8PcA/+Ip+NKVzmSvCIVwUzhL673x2fBW69v5tPBTDIlrIoQTDyuXiNjN8Bh+Uudl@nongnu.org
X-Gm-Message-State: AOJu0YzPVEL7I5yfY/4n24NEoNmee64ek9F0c7p/zRMqZgfc8ZD0iRC0
 X8IadFkF0Q40VJdr6HWcKNsHMcxIaUXZWBkRjOi8oGioQYl6S1UE
X-Google-Smtp-Source: AGHT+IGaNiMDbUw079dulF+ipPQcX0Jv6Dloj+wXa2AFD/tbfI/CIs4G+Ruk9ZWiywpIe751OBTlRA==
X-Received: by 2002:a05:6a21:e8d:b0:1cf:2988:c34c with SMTP id
 adf61e73a8af0-1d6dfa46c32mr21268917637.22.1728375240042; 
 Tue, 08 Oct 2024 01:14:00 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d7d444sm5582691b3a.211.2024.10.08.01.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 01:13:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 18:13:53 +1000
Message-Id: <D4Q9VWVTUFEG.WMMBR56BBTY5@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v3 3/3] hw/ssi/pnv_spi: Use local var seq_index instead
 of get_seq_index().
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <20240918165045.21298-4-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240918165045.21298-4-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
> Use a local variable seq_index instead of repeatedly caling
> get_seq_index() method.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  hw/ssi/pnv_spi.c | 61 ++++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 2fd5aa0a96..962115f40f 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -210,15 +210,8 @@ static void transfer(PnvSpi *s)
>      fifo8_reset(&s->rx_fifo);
>  }
> =20
> -static inline uint8_t get_seq_index(PnvSpi *s)
> -{
> -    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
> -}
> -
>  static inline void next_sequencer_fsm(PnvSpi *s)
>  {
> -    uint8_t seq_index =3D get_seq_index(s);
> -    s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1)=
);
>      s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_I=
NCREMENT);
>  }
> =20
> @@ -647,6 +640,7 @@ static void operation_sequencer(PnvSpi *s)
>      bool stop =3D false; /* Flag to stop the sequencer */
>      uint8_t opcode =3D 0;
>      uint8_t masked_opcode =3D 0;
> +    uint8_t seq_index;
> =20
>      /*
>       * Clear the sequencer FSM error bit - general_SPI_status[3]
> @@ -660,12 +654,13 @@ static void operation_sequencer(PnvSpi *s)
>      if (GETFIELD(SPI_STS_SEQ_FSM, s->status) =3D=3D SEQ_STATE_IDLE) {
>          s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
>      }
> +    seq_index =3D GETFIELD(SPI_STS_SEQ_INDEX, s->status);
>      /*
>       * There are only 8 possible operation IDs to iterate through though
>       * some operations may cause more than one frame to be sequenced.
>       */
> -    while (get_seq_index(s) < NUM_SEQ_OPS) {
> -        opcode =3D s->seq_op[get_seq_index(s)];
> +    while (seq_index < NUM_SEQ_OPS) {
> +        opcode =3D s->seq_op[seq_index];
>          /* Set sequencer state to decode */
>          s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DEC=
ODE);
>          /*
> @@ -682,7 +677,7 @@ static void operation_sequencer(PnvSpi *s)
>          case SEQ_OP_STOP:
>              s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE=
_EXECUTE);
>              /* A stop operation in any position stops the sequencer */
> -            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
> +            trace_pnv_spi_sequencer_op("STOP", seq_index);
> =20
>              stop =3D true;
>              s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_I=
DLE);
> @@ -693,7 +688,7 @@ static void operation_sequencer(PnvSpi *s)
> =20
>          case SEQ_OP_SELECT_SLAVE:
>              s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE=
_EXECUTE);
> -            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s))=
;
> +            trace_pnv_spi_sequencer_op("SELECT_SLAVE", seq_index);
>              /*
>               * This device currently only supports a single responder
>               * connection at position 0.  De-selecting a responder is fi=
ne
> @@ -704,8 +699,7 @@ static void operation_sequencer(PnvSpi *s)
>              if (s->responder_select =3D=3D 0) {
>                  trace_pnv_spi_shifter_done();
>                  qemu_set_irq(s->cs_line[0], 1);
> -                s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status,
> -                                (get_seq_index(s) + 1));
> +                seq_index++;
>                  s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, F=
SM_DONE);
>              } else if (s->responder_select !=3D 1) {
>                  qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other th=
an 1 "
> @@ -732,13 +726,14 @@ static void operation_sequencer(PnvSpi *s)
>                   * applies once a valid responder select has occurred.
>                   */
>                  s->shift_n1_done =3D false;
> +                seq_index++;
>                  next_sequencer_fsm(s);

Maybe could just open-code next_sequencer_fsm() now, since a bunch of
other FSM fields seem to be open-coded?

>              }
>              break;
> =20
>          case SEQ_OP_SHIFT_N1:
>              s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE=
_EXECUTE);
> -            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
> +            trace_pnv_spi_sequencer_op("SHIFT_N1", seq_index);
>              /*
>               * Only allow a shift_n1 when the state is not IDLE or DONE.
>               * In either of those two cases the sequencer is not in a pr=
oper
> @@ -770,8 +765,9 @@ static void operation_sequencer(PnvSpi *s)
>                   * transmission to the responder without requiring a ref=
ill of
>                   * the TDR between the two operations.
>                   */
> -                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1=
])
> -                                =3D=3D SEQ_OP_SHIFT_N2) {
> +                if ((seq_index !=3D 7) &&
> +                    PNV_SPI_MASKED_OPCODE(s->seq_op[(seq_index + 1)]) =
=3D=3D
> +                    SEQ_OP_SHIFT_N2) {
>                      send_n1_alone =3D false;
>                  }
>                  s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,

The seq_index !=3D 7 is a new test? Is that a separate fix, I'm not
seeing how it's related to the seq_index change.

Thanks,
Nick

