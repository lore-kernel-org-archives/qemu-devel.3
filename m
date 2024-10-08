Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1371ECED274
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 08:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy58u-0006PC-Bl; Tue, 08 Oct 2024 04:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy58h-0006CA-Fx; Tue, 08 Oct 2024 04:00:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy58a-0005rE-SK; Tue, 08 Oct 2024 04:00:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso530507b3a.2; 
 Tue, 08 Oct 2024 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728374406; x=1728979206; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A13jeLXlcu2m59gSTad54YOQHVOtiKesrZaQPgw8OiE=;
 b=eToQOPuYLQsRsikGjMG9qXvJVutAkaYbTDhVSDJFmXTSF5NG/0iRRob4Iu46CD6U/N
 g0jUTt1MtjNofk4MivcfO7wwR8B5/zTb2mnwwm83uigBG0Swi7kjqrXyAQb/3a90F5pE
 xLklXjFFlVSX6yk2SkAErsHBt1wxL8nB0ZYJtuoraYT4H2UOOsg2RicHgvKrEvvPNVvy
 kP2OEJcRLpyjTUCoyWwwsYRDyJyadu9Q2tCfoi/w1EKUSGR4Sl8HVHzbU4e1X+QfvUJ6
 ad1pV2U8BuaPfSFuqVuXge8HSSYzbqZqOIYkowuP72jPpq6r1sBlYN9Q5YiZKNNOL3jW
 TRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374406; x=1728979206;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A13jeLXlcu2m59gSTad54YOQHVOtiKesrZaQPgw8OiE=;
 b=w0PAnyi/09FP3y+ulLsU9WzeD8KDrOXkdM9MrH8b2xvn3QWg/P6lLOWZawycvbaiVg
 Nsyl1Eb85GwkqLQOTzUsZ4g9e4KlJZkHYPOvfmjAMshUGQ0sFoTGFH+oqLzKUThTdzD9
 sXBE23mBZKtPTPZCzPYKapON8zm1tcuPggZiFGk48BfSM6O25+Q+LCU3GeFurEDfblSm
 D9Esju6pU9QttirXG/Ub4ojUfBuBIzdDN0IAqIERj+nRwl2tSBYNd/82vKNccfOIzMl+
 3HvWcv5fV9TEhoa8ekPnn1cFhUrLd6AmBtEeGjDhxXzH02KrqX8dRDMK3rYR5p0P9mNL
 sb9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5W6Z33aSaEifa8ViQeMN4c51uRvvS3WgSrbsrmYT0Uo0V3KVnWFgYTBZ65eeuMzyUoqdYoiwNj4iZ@nongnu.org
X-Gm-Message-State: AOJu0YzbPvlSkDJ5xbes2nOGiWYGK1cQ6FZUnMVtGwrK/wCxQoRfkdcl
 VvZM1eNIE/tXZYdpwNYeuRWqG73e6ebt8YmAY9yPsgtrbjODK09KzcVJjg==
X-Google-Smtp-Source: AGHT+IF8j2Mf1nvBDOO2RtfB3HstfVSxvOgMv+QqxG0FxVVviJiHfFc+NS5zXDvUjaC/rQjr5mCPnA==
X-Received: by 2002:a05:6a00:2d25:b0:71d:fb83:6301 with SMTP id
 d2e1a72fcca58-71dfb8365eamr13263989b3a.16.1728374406329; 
 Tue, 08 Oct 2024 01:00:06 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d622fcsm5789119b3a.143.2024.10.08.01.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 01:00:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 17:59:59 +1000
Message-Id: <D4Q9L9R90CZP.1ZF3E32R9II6C@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v3 2/3] hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8
 structure
X-Mailer: aerc 0.18.2
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <20240918165045.21298-3-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240918165045.21298-3-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
> In PnvXferBuffer dynamically allocating and freeing is a
> process overhead. Hence used an existing Fifo8 buffer with
> capacity of 16 bytes.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ssi/pnv_spi.h |   3 +
>  hw/ssi/pnv_spi.c         | 167 +++++++++++++--------------------------
>  2 files changed, 56 insertions(+), 114 deletions(-)
>
> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
> index 8815f67d45..9878d9a25f 100644
> --- a/include/hw/ssi/pnv_spi.h
> +++ b/include/hw/ssi/pnv_spi.h
> @@ -23,6 +23,7 @@
> =20
>  #include "hw/ssi/ssi.h"
>  #include "hw/sysbus.h"
> +#include "qemu/fifo8.h"
> =20
>  #define TYPE_PNV_SPI "pnv-spi"
>  OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
> @@ -37,6 +38,8 @@ typedef struct PnvSpi {
>      SSIBus *ssi_bus;
>      qemu_irq *cs_line;
>      MemoryRegion    xscom_spic_regs;
> +    Fifo8 tx_fifo;
> +    Fifo8 rx_fifo;
>      /* SPI object number */
>      uint32_t        spic_num;
>      uint8_t         transfer_len;
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 9e7207bf7c..2fd5aa0a96 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -19,6 +19,7 @@
> =20
>  #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
>  #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
> +#define PNV_SPI_FIFO_SIZE 16
> =20
>  /*
>   * Macro from include/hw/ppc/fdt.h
> @@ -35,38 +36,6 @@
>          }                                                          \
>      } while (0)
> =20
> -/* PnvXferBuffer */
> -typedef struct PnvXferBuffer {
> -
> -    uint32_t    len;
> -    uint8_t    *data;
> -
> -} PnvXferBuffer;
> -
> -/* pnv_spi_xfer_buffer_methods */
> -static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
> -{
> -    PnvXferBuffer *payload =3D g_malloc0(sizeof(*payload));
> -
> -    return payload;
> -}
> -
> -static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
> -{
> -    free(payload->data);
> -    free(payload);
> -}
> -
> -static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
> -                uint32_t offset, uint32_t length)
> -{
> -    if (payload->len < (offset + length)) {
> -        payload->len =3D offset + length;
> -        payload->data =3D g_realloc(payload->data, payload->len);
> -    }
> -    return &payload->data[offset];
> -}
> -
>  static bool does_rdr_match(PnvSpi *s)
>  {
>      /*
> @@ -107,8 +76,8 @@ static uint8_t get_from_offset(PnvSpi *s, uint8_t offs=
et)
>      return byte;
>  }
> =20
> -static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_=
bytes,
> -                uint8_t ecc_count, uint8_t shift_in_count)
> +static uint8_t read_from_frame(PnvSpi *s, uint8_t nr_bytes, uint8_t ecc_=
count,
> +                uint8_t shift_in_count)
>  {
>      uint8_t byte;
>      int count =3D 0;
> @@ -118,8 +87,8 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *rea=
d_buf, uint8_t nr_bytes,
>          if ((ecc_count !=3D 0) &&
>              (shift_in_count =3D=3D (PNV_SPI_REG_SIZE + ecc_count))) {
>              shift_in_count =3D 0;
> -        } else {
> -            byte =3D read_buf[count];
> +        } else if (!fifo8_is_empty(&s->rx_fifo)) {
> +            byte =3D fifo8_pop(&s->rx_fifo);
>              trace_pnv_spi_shift_rx(byte, count);
>              s->regs[SPI_RCV_DATA_REG] =3D (s->regs[SPI_RCV_DATA_REG] << =
8) | byte;
>          }

What happens to the else case here? Did the previous code underflow
read_buf, or is it a programming error?

> @@ -128,7 +97,7 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *rea=
d_buf, uint8_t nr_bytes,
>      return shift_in_count;
>  }
> =20
> -static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload=
)
> +static void spi_response(PnvSpi *s)
>  {
>      uint8_t ecc_count;
>      uint8_t shift_in_count;
> @@ -144,13 +113,13 @@ static void spi_response(PnvSpi *s, int bits, PnvXf=
erBuffer *rsp_payload)
>       * First check that the response payload is the exact same
>       * number of bytes as the request payload was
>       */
> -    if (rsp_payload->len !=3D (s->N1_bytes + s->N2_bytes)) {
> +    if ((&s->rx_fifo)->num !=3D (s->N1_bytes + s->N2_bytes)) {

fifo8_num_used()

>          qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in=
 "
>                         "bytes, expected %d, got %d\n",
> -                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
> +                       (s->N1_bytes + s->N2_bytes), (&s->rx_fifo)->num);
>      } else {
>          uint8_t ecc_control;
> -        trace_pnv_spi_rx_received(rsp_payload->len);
> +        trace_pnv_spi_rx_received((&s->rx_fifo)->num);

fifo8_num_used()

>          trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
>                          s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->=
N2_rx);
>          /*
> @@ -175,14 +144,13 @@ static void spi_response(PnvSpi *s, int bits, PnvXf=
erBuffer *rsp_payload)
>          /* Handle the N1 portion of the frame first */
>          if (s->N1_rx !=3D 0) {
>              trace_pnv_spi_rx_read_N1frame();
> -            shift_in_count =3D read_from_frame(s, &rsp_payload->data[0],
> -                            s->N1_bytes, ecc_count, shift_in_count);
> +            shift_in_count =3D read_from_frame(s, s->N1_bytes,
> +                            ecc_count, shift_in_count);

Maybe indent this ^ line up to the ( of the function call operator
if possible (not sure it's a hard rule  but it reads a bit better
unless you have really run out of columns)..

>          }
>          /* Handle the N2 portion of the frame */
>          if (s->N2_rx !=3D 0) {
>              trace_pnv_spi_rx_read_N2frame();
> -            shift_in_count =3D read_from_frame(s,
> -                            &rsp_payload->data[s->N1_bytes], s->N2_bytes=
,
> +            shift_in_count =3D read_from_frame(s, s->N2_bytes,
>                              ecc_count, shift_in_count);

Same here, and for other code where you touch nearby lines.

>          }
>          if ((s->N1_rx + s->N2_rx) > 0) {
> @@ -210,34 +178,36 @@ static void spi_response(PnvSpi *s, int bits, PnvXf=
erBuffer *rsp_payload)
>      } /* end of else */
>  } /* end of spi_response() */
> =20
> -static void transfer(PnvSpi *s, PnvXferBuffer *payload)
> +static void transfer(PnvSpi *s)
>  {
> -    uint32_t tx;
> -    uint32_t rx;
> -    PnvXferBuffer *rsp_payload =3D NULL;
> +    uint32_t tx, rx, payload_len;
> +    uint8_t rx_byte;
> =20
> -    rsp_payload =3D pnv_spi_xfer_buffer_new();
> -    for (int offset =3D 0; offset < payload->len; offset +=3D s->transfe=
r_len) {
> +    payload_len =3D (&s->tx_fifo)->num;

fifo8_num_used()

(And several other cases below should use num_used).

> +    for (int offset =3D 0; offset < payload_len; offset +=3D s->transfer=
_len) {
>          tx =3D 0;
>          for (int i =3D 0; i < s->transfer_len; i++) {
> -            if ((offset + i) >=3D payload->len) {
> +            if ((offset + i) >=3D payload_len) {
>                  tx <<=3D 8;
> -            } else {
> -                tx =3D (tx << 8) | payload->data[offset + i];
> +            } else if (!fifo8_is_empty(&s->tx_fifo)) {
> +                tx =3D (tx << 8) | fifo8_pop(&s->tx_fifo);
>              }

Similar question about underflow here. Is there an assert or error
message or trace event for all these over/under flow cases?

>          }
>          rx =3D ssi_transfer(s->ssi_bus, tx);
>          for (int i =3D 0; i < s->transfer_len; i++) {
> -            if ((offset + i) >=3D payload->len) {
> +            if ((offset + i) >=3D payload_len) {
>                  break;
>              }
> -            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->le=
n, 1)) =3D
> -                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
> +            rx_byte =3D (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0x=
FF;
> +            if (!fifo8_is_full(&s->rx_fifo)) {
> +                fifo8_push(&s->rx_fifo, rx_byte);
> +            }
>          }

And overflow, this just gets lost? You can just put || fifo8_is_full()
in the break condition I think?.

>      }
> -    if (rsp_payload !=3D NULL) {
> -        spi_response(s, s->N1_bits, rsp_payload);
> -    }
> +    spi_response(s);
> +    /* Reset fifo for next frame */
> +    fifo8_reset(&s->tx_fifo);
> +    fifo8_reset(&s->rx_fifo);
>  }
> =20
>  static inline uint8_t get_seq_index(PnvSpi *s)
> @@ -348,19 +318,10 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>  /*
>   * Shift_N1 operation handler method
>   */
> -static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
> -                       PnvXferBuffer **payload, bool send_n1_alone)
> +static bool operation_shiftn1(PnvSpi *s, uint8_t opcode, bool send_n1_al=
one)
>  {
>      uint8_t n1_count;
>      bool stop =3D false;
> -
> -    /*
> -     * If there isn't a current payload left over from a stopped sequenc=
e
> -     * create a new one.
> -     */
> -    if (*payload =3D=3D NULL) {
> -        *payload =3D pnv_spi_xfer_buffer_new();
> -    }
>      /*
>       * Use a combination of N1 counters to build the N1 portion of the
>       * transmit payload.
> @@ -411,9 +372,10 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opc=
ode,
>                   */
>                  uint8_t n1_byte =3D 0x00;
>                  n1_byte =3D get_from_offset(s, n1_count);
> -                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
> -                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->le=
n, 1)) =3D
> -                        n1_byte;
> +                if (!fifo8_is_full(&s->tx_fifo)) {
> +                    trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count=
);
> +                    fifo8_push(&s->tx_fifo, n1_byte);
> +                }
>              } else {
>                  /*
>                   * We hit a shift_n1 opcode TX but the TDR is empty, tel=
l the
> @@ -440,10 +402,9 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opc=
ode,
>                                  "set for receive but RDR is full");
>                  stop =3D true;
>                  break;
> -            } else {
> +            } else if (!fifo8_is_full(&s->tx_fifo)) {
>                  trace_pnv_spi_tx_append_FF("n1_byte");
> -                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->le=
n, 1))
> -                        =3D 0xff;
> +                fifo8_push(&s->tx_fifo, 0xff);
>              }
>          }
>          n1_count++;
> @@ -484,15 +445,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t op=
code,
>       */
>      if (send_n1_alone && !stop) {
>          /* We have a TX and a full TDR or an RX and an empty RDR */
> -        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
> -        transfer(s, *payload);
> +        trace_pnv_spi_tx_request("Shifting N1 frame", (&s->tx_fifo)->num=
);

> +        transfer(s);
>          /* The N1 frame shift is complete so reset the N1 counters */
>          s->N2_bits =3D 0;
>          s->N2_bytes =3D 0;
>          s->N2_tx =3D 0;
>          s->N2_rx =3D 0;
> -        pnv_spi_xfer_buffer_free(*payload);
> -        *payload =3D NULL;
>      }
>      return stop;
>  } /* end of operation_shiftn1() */
> @@ -588,19 +547,10 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
>   * Shift_N2 operation handler method
>   */
> =20
> -static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
> -                       PnvXferBuffer **payload)
> +static bool operation_shiftn2(PnvSpi *s, uint8_t opcode)
>  {
>      uint8_t n2_count;
>      bool stop =3D false;
> -
> -    /*
> -     * If there isn't a current payload left over from a stopped sequenc=
e
> -     * create a new one.
> -     */
> -    if (*payload =3D=3D NULL) {
> -        *payload =3D pnv_spi_xfer_buffer_new();
> -    }
>      /*
>       * Use a combination of N2 counters to build the N2 portion of the
>       * transmit payload.
> @@ -639,25 +589,26 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t op=
code,
>              /* Always append data for the N2 segment if it is set for TX=
 */
>              uint8_t n2_byte =3D 0x00;
>              n2_byte =3D get_from_offset(s, (s->N1_tx + n2_count));
> -            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_c=
ount));
> -            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1=
))
> -                    =3D n2_byte;
> -        } else {
> +            if (!fifo8_is_full(&s->tx_fifo)) {
> +                trace_pnv_spi_tx_append("n2_byte", n2_byte,
> +                                (s->N1_tx + n2_count));
> +                fifo8_push(&s->tx_fifo, n2_byte);
> +            }
> +        } else if (!fifo8_is_full(&s->tx_fifo)) {
>              /*
>               * Regardless of whether or not N2 is set for TX or RX, we n=
eed
>               * the number of bytes in the payload to match the overall l=
ength
>               * of the operation.
>               */
>              trace_pnv_spi_tx_append_FF("n2_byte");
> -            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1=
))
> -                    =3D 0xff;
> +            fifo8_push(&s->tx_fifo, 0xff);
>          }
>          n2_count++;
>      } /* end of while */
>      if (!stop) {
>          /* We have a TX and a full TDR or an RX and an empty RDR */
> -        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
> -        transfer(s, *payload);
> +        trace_pnv_spi_tx_request("Shifting N2 frame", (&s->tx_fifo)->num=
);
> +        transfer(s);
>          /*
>           * If we are doing an N2 TX and the TDR is full we need to clear=
 the
>           * TDR_full status. Do this here instead of up in the loop above=
 so we
> @@ -680,8 +631,6 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opco=
de,
>          s->N1_bytes =3D 0;
>          s->N1_tx =3D 0;
>          s->N1_rx =3D 0;
> -        pnv_spi_xfer_buffer_free(*payload);
> -        *payload =3D NULL;
>      }
>      return stop;
>  } /*  end of operation_shiftn2()*/
> @@ -699,19 +648,6 @@ static void operation_sequencer(PnvSpi *s)
>      uint8_t opcode =3D 0;
>      uint8_t masked_opcode =3D 0;
> =20
> -    /*
> -     * PnvXferBuffer for containing the payload of the SPI frame.
> -     * This is a static because there are cases where a sequence has to =
stop
> -     * and wait for the target application to unload the RDR.  If this o=
ccurs
> -     * during a sequence where N1 is not sent alone and instead combined=
 with
> -     * N2 since the N1 tx length + the N2 tx length is less than the siz=
e of
> -     * the TDR.
> -     */
> -    static PnvXferBuffer *payload;
> -
> -    if (payload =3D=3D NULL) {
> -        payload =3D pnv_spi_xfer_buffer_new();
> -    }
>      /*
>       * Clear the sequencer FSM error bit - general_SPI_status[3]
>       * before starting a sequence.
> @@ -840,7 +776,7 @@ static void operation_sequencer(PnvSpi *s)
>                  }
>                  s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>                                  FSM_SHIFT_N1);
> -                stop =3D operation_shiftn1(s, opcode, &payload, send_n1_=
alone);
> +                stop =3D operation_shiftn1(s, opcode, send_n1_alone);
>                  if (stop) {
>                      /*
>                       *  The operation code says to stop, this can occur =
if:
> @@ -895,7 +831,7 @@ static void operation_sequencer(PnvSpi *s)
>                  /* Ok to do a Shift_N2 */
>                  s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>                                  FSM_SHIFT_N2);
> -                stop =3D operation_shiftn2(s, opcode, &payload);
> +                stop =3D operation_shiftn2(s, opcode);
>                  /*
>                   * If the operation code says to stop set the shifter st=
ate to
>                   * wait and stop
> @@ -1208,6 +1144,9 @@ static void pnv_spi_realize(DeviceState *dev, Error=
 **errp)
>      s->cs_line =3D g_new0(qemu_irq, 1);
>      qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
> =20
> +    fifo8_create(&s->tx_fifo, PNV_SPI_FIFO_SIZE);
> +    fifo8_create(&s->rx_fifo, PNV_SPI_FIFO_SIZE);
> +
>      /* spi scoms */
>      pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s), &pnv_spi_xscom=
_ops,
>                            s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);


Looks nice, simplifies the code and tricky pointer and memory handling.

Thanks,
Nick

