Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76E9C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnSsq-0001F4-2R; Wed, 26 Feb 2025 20:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSso-0001Er-4d; Wed, 26 Feb 2025 20:40:14 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSsj-0003Kq-O4; Wed, 26 Feb 2025 20:40:13 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22355618fd9so25235ad.3; 
 Wed, 26 Feb 2025 17:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740620408; x=1741225208; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWaot+uyaZYm4wcxUf87nRRPVj2nF/cN+fVw6ciHKxk=;
 b=lIsGxqv8DDfssKMQXG6CVxQ5/a0ZFaTiJBFU+uyuwPOa90v96aDi1DvdNJ4E/7OzUA
 ditYjGkV+6Wo8DJWq9jHnCinNzJWowTUBNMKpOcnrwyOP9PHKWdtWPXzKqTZCxRu24AR
 4iHw2qwAXEZgFGeWftdqeWrCelUmRS1NljIaUfYI+pGHr6en/W+clu/t/NQyUWk8GP0o
 rLgjIPfFwxwx6BagcqOqpNps0K6GJGGWkBiLnDMYRyJo0Nkg8sZf3G4KDph+41VOwUtO
 DmcYfXV8fNyR3xPXrCAkXTB4kYWJqqvQlJsgdX9X0XI77r+7RWD+rD8k75sPscSzJRT0
 ErNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740620408; x=1741225208;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zWaot+uyaZYm4wcxUf87nRRPVj2nF/cN+fVw6ciHKxk=;
 b=UjDaVIWLzsDKsXNAtWNm75i3IJ/ovKHFqsj2lanS3rD2EEpjtVsTSl1JhJBmMnpA83
 gyOF2CMntIsK41n3ZEeYlED1cmnR18e5cEbEK1OOi6McAxcVQhBeGJRTYeTeVgpuUpgp
 3UkmXaReWXFz8SuJY3pkjhTibGbA1MdY77B/CDzDXZ7SVGGJf2uYejRkFUvGQ+mz83CM
 PiqAh70FQHjOS912BaVAZqyOcyUp8iDAg1HdQ1K5/yd/n4BzYwz8tGIr1gr1T5WKpTF7
 Dvz9FVXvVBT154wyaacF2aiwkI3Wbo7ebVwDdMbyRY80v0Pe60SdHGY1lLtn0YmIRusM
 InaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA9sixqgKLuHQkyzhv72O2e2cUn/FfJa1xFiEuPBsWbISKP5Ak7kpWSOedFgz1W+nb670vehgabFke@nongnu.org
X-Gm-Message-State: AOJu0Yzn4AheIdz9WBNhu8cA239tZjmMAZkj2za+J6BESjs5PMveGJ+m
 kpLeCRU94wKQOOyDr7+c2d9WuR9qwaNVUXxFiKE6umbsUn1gPnYB
X-Gm-Gg: ASbGncu/gH3Ie9VOPo5qjmK5l2C39VpriJ7MPzlAgaIu/HdDH0Lw9JjdcpIq2W91clf
 +GO7fUUTv3za+VhufZ3jy+JLZA7z89OvS6eojEpKpYJwS0NsSC4luswaVjbAzUhSK0NQvqVzryj
 uN29Aq7+ndLkb9+vSN0wiunbDAwqBqC1jJQNkT5ukKP6OgI2jIelgZY88DR3WCxLWkp91YcR21g
 Uj9DHWxWi1k7kvgY5oaMylrnIfYj/YhGTLKA+IvGre3YdebDVDBE99d2UzetZ9STfAfYWr6lzVU
 FchcG03iMWEmvVnURw==
X-Google-Smtp-Source: AGHT+IEcdH2WUk1RLSkurrq6KlVz6Fhpxu0V3/4E1tCgSbPPnkl7aBbMTVc9RzDiQvJr7gkvPVDjKw==
X-Received: by 2002:a05:6a00:14c1:b0:730:8e97:bd76 with SMTP id
 d2e1a72fcca58-73426cb143cmr32162665b3a.9.1740620407535; 
 Wed, 26 Feb 2025 17:40:07 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0060069sm265491b3a.159.2025.02.26.17.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:40:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:39:59 +1000
Message-Id: <D82UFOB22C3K.31271R5VWD0LU@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v5 1/4] hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8
 structure
X-Mailer: aerc 0.19.0
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-2-chalapathi.v@linux.ibm.com>
In-Reply-To: <20250103161824.22469-2-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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
> In PnvXferBuffer dynamically allocating and freeing is a
> process overhead. Hence used an existing Fifo8 buffer with
> capacity of 16 bytes.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ssi/pnv_spi.h |   3 +
>  hw/ssi/pnv_spi.c         | 237 +++++++++++++--------------------------
>  2 files changed, 81 insertions(+), 159 deletions(-)
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
> index 15e25bd1be..63d298980d 100644
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
> @@ -35,48 +36,14 @@
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
> -    g_free(payload->data);
> -    g_free(payload);
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
>       * According to spec, the mask bits that are 0 are compared and the
>       * bits that are 1 are ignored.
>       */
> -    uint16_t rdr_match_mask =3D GETFIELD(SPI_MM_RDR_MATCH_MASK,
> -                                        s->regs[SPI_MM_REG]);
> -    uint16_t rdr_match_val =3D GETFIELD(SPI_MM_RDR_MATCH_VAL,
> -                                        s->regs[SPI_MM_REG]);
> +    uint16_t rdr_match_mask =3D GETFIELD(SPI_MM_RDR_MATCH_MASK, s->regs[=
SPI_MM_REG]);
> +    uint16_t rdr_match_val =3D GETFIELD(SPI_MM_RDR_MATCH_VAL, s->regs[SP=
I_MM_REG]);
> =20
>      if ((~rdr_match_mask & rdr_match_val) =3D=3D ((~rdr_match_mask) &
>              GETFIELD(PPC_BITMASK(48, 63), s->regs[SPI_RCV_DATA_REG]))) {

Usually try to avoid unrelated / cleanup in the same patch that acually
changes things. In this case it's quite minor but it helps with review
and rebasing to avoid.

If it's on the same line or very close line to your change, or
occasional ones I don't mind so much, but you have quite a few
more further down the patch.

> @@ -107,8 +74,8 @@ static uint8_t get_from_offset(PnvSpi *s, uint8_t offs=
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
> @@ -118,20 +85,23 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *r=
ead_buf, uint8_t nr_bytes,
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
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: Reading empty RX_FI=
FO\n");
>          }
>          count++;
>      } /* end of while */
>      return shift_in_count;
>  }
> =20
> -static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload=
)
> +static void spi_response(PnvSpi *s)
>  {
>      uint8_t ecc_count;
>      uint8_t shift_in_count;
> +    uint32_t rx_len;
> =20
>      /*
>       * Processing here must handle:
> @@ -144,13 +114,14 @@ static void spi_response(PnvSpi *s, int bits, PnvXf=
erBuffer *rsp_payload)
>       * First check that the response payload is the exact same
>       * number of bytes as the request payload was
>       */
> -    if (rsp_payload->len !=3D (s->N1_bytes + s->N2_bytes)) {
> +    rx_len =3D fifo8_num_used(&s->rx_fifo);
> +    if (rx_len !=3D (s->N1_bytes + s->N2_bytes)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in=
 "
>                         "bytes, expected %d, got %d\n",
> -                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
> +                       (s->N1_bytes + s->N2_bytes), rx_len);
>      } else {
>          uint8_t ecc_control;
> -        trace_pnv_spi_rx_received(rsp_payload->len);
> +        trace_pnv_spi_rx_received(rx_len);
>          trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
>                          s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->=
N2_rx);
>          /*
> @@ -175,15 +146,12 @@ static void spi_response(PnvSpi *s, int bits, PnvXf=
erBuffer *rsp_payload)
>          /* Handle the N1 portion of the frame first */
>          if (s->N1_rx !=3D 0) {
>              trace_pnv_spi_rx_read_N1frame();
> -            shift_in_count =3D read_from_frame(s, &rsp_payload->data[0],
> -                            s->N1_bytes, ecc_count, shift_in_count);
> +            shift_in_count =3D read_from_frame(s, s->N1_bytes, ecc_count=
, shift_in_count);
>          }
>          /* Handle the N2 portion of the frame */
>          if (s->N2_rx !=3D 0) {
>              trace_pnv_spi_rx_read_N2frame();
> -            shift_in_count =3D read_from_frame(s,
> -                            &rsp_payload->data[s->N1_bytes], s->N2_bytes=
,
> -                            ecc_count, shift_in_count);
> +            shift_in_count =3D read_from_frame(s, s->N2_bytes, ecc_count=
, shift_in_count);
>          }
>          if ((s->N1_rx + s->N2_rx) > 0) {
>              /*
> @@ -210,36 +178,38 @@ static void spi_response(PnvSpi *s, int bits, PnvXf=
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
> -    if (!rsp_payload) {
> -        return;
> -    }
> -    for (int offset =3D 0; offset < payload->len; offset +=3D s->transfe=
r_len) {
> +    payload_len =3D fifo8_num_used(&s->tx_fifo);
> +    for (int offset =3D 0; offset < payload_len; offset +=3D s->transfer=
_len) {
>          tx =3D 0;
>          for (int i =3D 0; i < s->transfer_len; i++) {
> -            if ((offset + i) >=3D payload->len) {
> +            if ((offset + i) >=3D payload_len) {
>                  tx <<=3D 8;
> +            } else if (!fifo8_is_empty(&s->tx_fifo)) {
> +                tx =3D (tx << 8) | fifo8_pop(&s->tx_fifo);
>              } else {
> -                tx =3D (tx << 8) | payload->data[offset + i];
> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underfl=
ow\n");
>              }
>          }
>          rx =3D ssi_transfer(s->ssi_bus, tx);
>          for (int i =3D 0; i < s->transfer_len; i++) {
> -            if ((offset + i) >=3D payload->len) {
> +            if (((offset + i) >=3D payload_len) || fifo8_is_full(&s->rx_=
fifo)) {
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
>      }
> -    spi_response(s, s->N1_bits, rsp_payload);
> -    pnv_spi_xfer_buffer_free(rsp_payload);
> +    spi_response(s);
> +    /* Reset fifo for next frame */
> +    fifo8_reset(&s->tx_fifo);
> +    fifo8_reset(&s->rx_fifo);
>  }
> =20
>  static inline uint8_t get_seq_index(PnvSpi *s)
> @@ -310,13 +280,11 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>               * If Forced Implicit mode and count control doesn't
>               * indicate transmit then reset the tx count to 0
>               */
> -            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
> -                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 0) =
{
> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, s->regs[SPI_CTR_CFG_REG=
]) =3D=3D 0) {
>                  s->N1_tx =3D 0;
>              }
>              /* If rx count control for N1 is set, load the rx value */
> -            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
> -                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 1) =
{
> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, s->regs[SPI_CTR_CFG_REG=
]) =3D=3D 1) {
>                  s->N1_rx =3D s->N1_bytes;
>              }
>          }
> @@ -328,8 +296,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>       * cap the size at a max of 64 bits or 72 bits and set the sequencer=
 FSM
>       * error bit.
>       */
> -    uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL,
> -                                   s->regs[SPI_CLK_CFG_REG]);
> +    uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_C=
LK_CFG_REG]);
>      if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {
>          if (s->N1_bytes > (PNV_SPI_REG_SIZE + 1)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size wh=
en "
> @@ -340,8 +307,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>          }
>      } else if (s->N1_bytes > PNV_SPI_REG_SIZE) {
>          qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
> -                      "bytes =3D 0x%x, bits =3D 0x%x\n",
> -                      s->N1_bytes, s->N1_bits);
> +                      "bytes =3D 0x%x, bits =3D 0x%x\n", s->N1_bytes, s-=
>N1_bits);
>          s->N1_bytes =3D PNV_SPI_REG_SIZE;
>          s->N1_bits =3D s->N1_bytes * 8;
>      }
> @@ -350,19 +316,10 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
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
> @@ -413,9 +370,10 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opc=
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
> @@ -436,16 +394,14 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t op=
code,
>               * - we are receiving and the RDR is empty so we allow the o=
peration
>               *   to proceed.
>               */
> -            if ((s->N1_rx !=3D 0) && (GETFIELD(SPI_STS_RDR_FULL,
> -                                           s->status) =3D=3D 1)) {
> +            if ((s->N1_rx !=3D 0) && (GETFIELD(SPI_STS_RDR_FULL, s->stat=
us) =3D=3D 1)) {
>                  trace_pnv_spi_sequencer_stop_requested("shift N1"
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

Is there any problem or overrun that needs to be logged if the
fifo is full in the above two places?

>          }
>          n1_count++;
> @@ -486,15 +442,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t op=
code,
>       */
>      if (send_n1_alone && !stop) {
>          /* We have a TX and a full TDR or an RX and an empty RDR */
> -        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
> -        transfer(s, *payload);
> +        trace_pnv_spi_tx_request("Shifting N1 frame", fifo8_num_used(&s-=
>tx_fifo));
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
> @@ -552,13 +506,11 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
>               * If Forced Implicit mode and count control doesn't
>               * indicate a receive then reset the rx count to 0
>               */
> -            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
> -                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 0) =
{
> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, s->regs[SPI_CTR_CFG_REG=
]) =3D=3D 0) {
>                  s->N2_rx =3D 0;
>              }
>              /* If tx count control for N2 is set, load the tx value */
> -            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
> -                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 1) =
{
> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, s->regs[SPI_CTR_CFG_REG=
]) =3D=3D 1) {
>                  s->N2_tx =3D s->N2_bytes;
>              }
>          }
> @@ -571,8 +523,7 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
>       * cap the size at a max of 64 bits or 72 bits and set the sequencer=
 FSM
>       * error bit.
>       */
> -    uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL,
> -                    s->regs[SPI_CLK_CFG_REG]);
> +    uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_C=
LK_CFG_REG]);
>      if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {
>          if (s->N2_bytes > (PNV_SPI_REG_SIZE + 1)) {
>              /* Unsupported N2 shift size when ECC enabled */
> @@ -590,19 +541,10 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
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
> @@ -629,44 +571,41 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t op=
code,
>           * code continue will end up building the payload twice in the s=
ame
>           * buffer since RDR full causes a sequence stop and restart.
>           */
> -        if ((s->N2_rx !=3D 0) &&
> -            (GETFIELD(SPI_STS_RDR_FULL, s->status) =3D=3D 1)) {
> +        if ((s->N2_rx !=3D 0) && (GETFIELD(SPI_STS_RDR_FULL, s->status) =
=3D=3D 1)) {
>              trace_pnv_spi_sequencer_stop_requested("shift N2 set"
>                              "for receive but RDR is full");
>              stop =3D true;
>              break;
>          }
> -        if ((s->N2_tx !=3D 0) && ((s->N1_tx + n2_count) <
> -                                PNV_SPI_REG_SIZE)) {
> +        if ((s->N2_tx !=3D 0) && ((s->N1_tx + n2_count) < PNV_SPI_REG_SI=
ZE)) {
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
> +                trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + =
n2_count));
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
> +        trace_pnv_spi_tx_request("Shifting N2 frame", fifo8_num_used(&s-=
>tx_fifo));
> +        transfer(s);
>          /*
>           * If we are doing an N2 TX and the TDR is full we need to clear=
 the
>           * TDR_full status. Do this here instead of up in the loop above=
 so we
>           * don't log the message in every loop iteration.
>           */
> -        if ((s->N2_tx !=3D 0) &&
> -            (GETFIELD(SPI_STS_TDR_FULL, s->status) =3D=3D 1)) {
> +        if ((s->N2_tx !=3D 0) && (GETFIELD(SPI_STS_TDR_FULL, s->status) =
=3D=3D 1)) {
>              s->status =3D SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
>          }
>          /*
> @@ -682,8 +621,6 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opco=
de,
>          s->N1_bytes =3D 0;
>          s->N1_tx =3D 0;
>          s->N1_rx =3D 0;
> -        pnv_spi_xfer_buffer_free(*payload);
> -        *payload =3D NULL;
>      }
>      return stop;
>  } /*  end of operation_shiftn2()*/
> @@ -701,19 +638,6 @@ static void operation_sequencer(PnvSpi *s)
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
> @@ -775,10 +699,8 @@ static void operation_sequencer(PnvSpi *s)
>                  s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, F=
SM_DONE);
>              } else if (s->responder_select !=3D 1) {
>                  qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other th=
an 1 "
> -                              "not supported, select =3D 0x%x\n",
> -                               s->responder_select);
> -                trace_pnv_spi_sequencer_stop_requested("invalid "
> -                                "responder select");
> +                              "not supported, select =3D 0x%x\n", s->res=
ponder_select);
> +                trace_pnv_spi_sequencer_stop_requested("invalid responde=
r select");
>                  s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, F=
SM_IDLE);
>                  stop =3D true;
>              } else {
> @@ -840,9 +762,8 @@ static void operation_sequencer(PnvSpi *s)
>                                  =3D=3D SEQ_OP_SHIFT_N2) {
>                      send_n1_alone =3D false;
>                  }
> -                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> -                                FSM_SHIFT_N1);
> -                stop =3D operation_shiftn1(s, opcode, &payload, send_n1_=
alone);
> +                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, F=
SM_SHIFT_N1);
> +                stop =3D operation_shiftn1(s, opcode, send_n1_alone);
>                  if (stop) {
>                      /*
>                       *  The operation code says to stop, this can occur =
if:
> @@ -858,7 +779,7 @@ static void operation_sequencer(PnvSpi *s)
>                      if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
>                          s->shift_n1_done =3D true;
>                          s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->s=
tatus,
> -                                                  FSM_SHIFT_N2);
> +                                        FSM_SHIFT_N2);
>                          s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->sta=
tus,
>                                          (get_seq_index(s) + 1));
>                      } else {
> @@ -866,8 +787,7 @@ static void operation_sequencer(PnvSpi *s)
>                           * This is case (1) or (2) so the sequencer need=
s to
>                           * wait and NOT go to the next sequence yet.
>                           */
> -                        s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->s=
tatus,
> -                                        FSM_WAIT);
> +                        s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->s=
tatus, FSM_WAIT);
>                      }
>                  } else {
>                      /* Ok to move on to the next index */
> @@ -890,21 +810,18 @@ static void operation_sequencer(PnvSpi *s)
>                   * error bit 3 (general_SPI_status[3]) in status reg.
>                   */
>                  s->status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s->status,=
 1);
> -                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
> -                                    "w/no shift_n1 done");
> +                trace_pnv_spi_sequencer_stop_requested("shift_n2 w/no sh=
ift_n1 done");
>                  stop =3D true;
>              } else {
>                  /* Ok to do a Shift_N2 */
> -                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> -                                FSM_SHIFT_N2);
> -                stop =3D operation_shiftn2(s, opcode, &payload);
> +                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, F=
SM_SHIFT_N2);
> +                stop =3D operation_shiftn2(s, opcode);
>                  /*
>                   * If the operation code says to stop set the shifter st=
ate to
>                   * wait and stop
>                   */
>                  if (stop) {
> -                    s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->statu=
s,
> -                                    FSM_WAIT);
> +                    s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->statu=
s, FSM_WAIT);
>                  } else {
>                      /* Ok to move on to the next index */
>                      next_sequencer_fsm(s);
> @@ -988,8 +905,7 @@ static void operation_sequencer(PnvSpi *s)
>          case SEQ_OP_BRANCH_IFNEQ_INC_2:
>              s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE=
_EXECUTE);
>              trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_ind=
ex(s));
> -            uint8_t condition2 =3D GETFIELD(SPI_CTR_CFG_CMP2,
> -                              s->regs[SPI_CTR_CFG_REG]);
> +            uint8_t condition2 =3D GETFIELD(SPI_CTR_CFG_CMP2, s->regs[SP=
I_CTR_CFG_REG]);
>              /*
>               * The spec says the loop should execute count compare + 1 t=
imes.
>               * However we learned from engineering that we really only l=
oop
> @@ -1209,6 +1125,9 @@ static void pnv_spi_realize(DeviceState *dev, Error=
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

Aside from those small nits, it looks like a good cleanup and
improvement with more error logging.

Thanks,
Nick

