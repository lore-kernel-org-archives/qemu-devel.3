Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E658606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LIJY+i/N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULTB-0003wt-SB; Fri, 20 Nov 2026 05:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xULT9-0003wk-Pe
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:03:48 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xULT5-0000Ap-99
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:03:47 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0d126f631so5560927b3.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795169020; cv=none;
 d=google.com; s=arc-20260327;
 b=ar7n9KRHnWoAMiUuZ76W+N8MAF4wudsTdLsYE3wRRuQYZQpaOzHwIXnkQNh/tUIpKi
 ORkclq5ItvUkIZ2LeNIm3YFk+sTfKqWN2GMpKasPpq/i31b4whO7aQ5S2o9uiK9lhpGS
 xWmHr7w9lPn37bIk+3QU5X1POb+QjkmeWmQqYXGFNzm4qy5EZHG//P45hrLX2flnYNc6
 t6dxeJXGKKAtoB44RSjajoO2W0RoXptXBxw1DoCLd36Ldey0WOzOdvynZX1wtmPXHjke
 ntpEZMMZIXoBmc9lzb43LM3mtnRyG6TWs6C5uj2YOyLkoaVQGxuLBwCXhlfteVZy2VzT
 j4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CIk+MOoU91DnHUC2sAM8KW+k5rKs/459K8BqC+h4qEY=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=hrZdc8tXUJL7/3xpV4UZdoA/6h+989m5LBY+p2EoYVxhYbfIqa9xhJtQGaKVm72Pgv
 ByWKxE8yczxmD7qYcdUuiqlCKD0IF58lnOYsTedcTYtfTgfC6DcyAb1hl3irwyYYJHUJ
 lHPSXK3Bpay4xlmL3LHNLW3jsdWEEVOJJmvT/9DNucrhT0id7FeDmJ9bzuRMoVZ33rQ0
 oif9e65PKjFCA+j2XZyxkYpa+t3sV+JBBYtTRXwY4aqR/wA9CtCifXdXYNDFuhmSeioR
 o4eQ6avY/0rps1CT0Zl4C1jbJjfKXe/+6MpEK+YP9+fpavWpAzN4KuFOLDwJquLeYZIW
 x93Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795169020; x=1795773820; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CIk+MOoU91DnHUC2sAM8KW+k5rKs/459K8BqC+h4qEY=;
 b=LIJY+i/NKKMBaxTkTKJbml7foKT2onP6WFO+njNz6mWWxAY91xUqYEodOVMSw5svmg
 olekBid8oVLziN+qrkUDxz5gz4vklKDVw10+6NqRGeGsvj9udSKztSijqGWW0TShMv6w
 DSuHAdBX/LGwhw3VU6rdXjcREl0inohzAwOunooG0BoAEKMcIdYHH/+RUGfEGqTGDKmS
 XCJuBAcoFozo3VUqwbh+LDJ/4L2ZXR8XpqbKEpZ4tHW6o81T5xi/94hMXBNYpYwOGi5f
 HeZ2xN00v6xpj3cVnlcMGybIX6ygGArc5jBfT+bfZvbYcsBwtVjD1zgmRroK/kPbn7Uv
 ZB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795169020; x=1795773820;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CIk+MOoU91DnHUC2sAM8KW+k5rKs/459K8BqC+h4qEY=;
 b=qwNCTO008I8+sm9xdopfcEfNIcXsivWmqoOOmaTxoSNmarUa9jxuQ2pF0XFaI3OzZq
 LHTk3nhb+3BHEQtOMXafDFlDZlODiYUKYGZJ/DnqKc4DNCwqlo58zOf50hsXTQmQRORm
 FbWTyGbtjBh9TwIdC8xCmOLKOhBYdhug47PmWQV35qfLkLkOhiXZxy8S3kTSW46D66Z8
 gMVOfErZSOAJCNVoTds7BJW184TQq1PWxJ/PduYIsAHV9SCzWoelu+ofum3IwPCnvjXL
 Zqd4F8my76yioR4fON0OHU5l5Ez+m3vIhS+g9vYPiGf2A0fukj00YnGb0VNBCjc82ULS
 pKHg==
X-Gm-Message-State: APuU4Z8GUYu9Cyf10+jLmiLgMkxDPWgkL5j+ThONtRspjJHdkyODCzd1
 79UC2zpCVR+tKY/1xms+8yMiRHhaZ6qEqGZlXP8wzl+YEDQVTS9duuoSpFDzKuvZcfsP1NwXfQG
 SUKIk57ZgJPH/1WVDsC4k+KsjB8ElML0=
X-Gm-Gg: AZFdTZdIi6vP2MIYCjjfDrb58jlRahs4WANzi8XBNiqNLmdOCgYhkYQ/3JjGjyRJHP+
 XtOeFQZ+uOdIyx775Lrk3mmKlQOPBfGDlS26R2zL7ureEyGP4eQLGRcm6qC+QpEdF7iBuAXx3pb
 F9SM1Lhg05D+Y6BLT40rHGzKmKsabW+KlbVk3PhXrBhiU0ouB03fYOqlOxyBc2GjFCSgLVjQaqR
 QgQFE4fqa50d2NDGk77cneRA6xRrhb0h8fIyfG4KHDCT/rmA1mHGpM2R/P6KlTF33NEIx1Cn+fw
 W3sPFMbOULdEdvS1EqrmGxjkHSU4uWWgXVN3iidTSA608oRANZVVK4utzYtknJIDvOljal0pFmY
 6pkojN5wlHbH/JXxPQgL4/N96UqQNjthXOkT2
X-Received: by 2002:a05:690c:48c3:b0:8b4:f194:3e50 with SMTP id
 00721157ae682-8b5204bc10emr14201967b3.41.1795169020428; Fri, 20 Nov 2026
 02:03:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114112855.108-1-nagendranjairam52@gmail.com>
 <awAOG_BGiCgjM8nE@redhat.com>
 <CAEAkEp4N1uFczHexCAbABzYf5O-Th-o5dE-KasU1RXM_k7WKKQ@mail.gmail.com>
 <awATgHU90hAWdOiv@redhat.com>
In-Reply-To: <awATgHU90hAWdOiv@redhat.com>
From: Nagendran Jairam <nagendranjairam52@gmail.com>
Date: Fri, 20 Nov 2026 15:33:28 +0530
X-Gm-Features: AclHuK_XODdJsrHxnwA54wzsUG7zB_GMMDCHt8Iy6qvQ_E0ZXpQNgovgxbI50eU
Message-ID: <CAEAkEp5=iPduUoyO=_kTNjTpGjah=di+ZBQPWJ-b01k0OfwHDw@mail.gmail.com>
Subject: Re: [PATCH] hw/core/loader: Add Extended Tektronix HEX support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c64aaf0660b25b37"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c64aaf0660b25b37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026, 15:01 Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:

> Re-adding qemu-devel - please don't drop the mailing list when
> replying to review comments.
>
> On Fri, Nov 20, 2026 at 02:47:07PM +0530, Nagendran Jairam wrote:
> > On Fri, Nov 20, 2026, 14:38 Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
> wrote:
> >
> > > On Sat, Nov 14, 2026 at 04:58:50PM +0530, Nagendran K wrote:
> > >
> > > Please provide a commit message to explain the purpose of
> > > this addition.
> > >
> >        I am sorry, I forgot to mention that this function is being call=
ed
> > in generic-loader.c
> >        The purpose is to load .tek files (binaries commonly used in Tex=
as
> > instruments microcontrollers)  directly without worrying about raw bina=
ry
> > or hex conversion
> >         Hex and tek files have major differences and it reduces manual
> > effort for a user to convert .tek to .hex
>
> It is clearly not being called in generic-loader.c since this patch
> makes no changes to that file.
>
>  Alistair mailed me with the same issue too...Aactually my whole
> implementation is not in master..Its updated in my local not in upstream
>
      I will update my patch in upstream master..Thanks
    Nagendran

>
> > > > Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
> > > > ---
> > > >  hw/core/loader.c         | 231
> +++++++++++++++++++++++++++++++++++++++
> > > >  include/hw/core/loader.h |  15 +++
> > > >  2 files changed, 246 insertions(+)
> > >
> > > ....this is adding a new API to common code and then not
> > > calling it from anywhere in QEMU. This is pointless
> > > and so is not likely to be accepted in isolation without
> > > a proposed usage accompanying it.
> >   This is function has a call in generic-loader.c to load .tek files
> >
> >        Example Usecase: -device loader, file=3Dmy_test.tek, addr=3D0x00=
000000
> >
> > >
> > >
> > > >
> > > > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > > > index
> > >
> 5cbfba0a86d24569923c863d6ecda125ce43bceb..33ccb51d56dda1035e815479e20c2a6=
c793843d9
> > > 100644
> > > > --- a/hw/core/loader.c
> > > > +++ b/hw/core/loader.c
> > > > @@ -1940,3 +1940,234 @@ ssize_t load_targphys_hex_as(const char
> > > *filename, hwaddr *entry,
> > > >      g_free(hex_blob);
> > > >      return total_size;
> > > >  }
> > > > +
> > > > +typedef enum Ext_Tek_HexRecord Ext_Tek_HexRecord;
> > > > +enum Ext_Tek_HexRecord {
> > > > +    TEK_DATA_RECORD =3D 0,
> > > > +    TEK_TERMINATION_RECORD
> > > > +};
> > > > +
> > > > +#define DATA_FIELD_MAX_LEN 0xff
> > > > +
> > > > +typedef struct {
> > > > +    uint8_t record_length;
> > > > +    uint8_t record_type;
> > > > +    uint8_t checksum;
> > > > +    uint32_t address;
> > > > +    uint8_t data[DATA_FIELD_MAX_LEN];
> > > > +} Ext_Tek_HexLine;
> > > > +
> > > > +/* return 0 or -1 if error */
> > > > +static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line,
> > > > +                                     uint8_t *our_checksum,
> > > > +                                     const uint8_t c,
> > > > +                                     uint32_t *index,
> > > > +                                     const bool in_process)
> > > > +{
> > > > +    /*
> > > +---------+---------------+-----------+---------------+-------------+
> > > > +     * | record  |    record     |           |               |
> > >    |
> > > > +     * | length  |    type       | checksum  |   address     |
>  data
> > >     |
> > > > +     *
> > > +---------+---------------+-----------+---------------+-------------+
> > > > +     *     ^             ^            ^              ^            =
^
> > > > +     * |1 byte   |    1 bytes    |1 byte     | 1 to N byte   | 0-2=
55
> > > bytes |
> > > > +     */
> > > > +    uint8_t value =3D 0, address_len =3D 0;
> > > > +    uint32_t idx =3D *index;
> > > > +    /* ignore space */
> > > > +    if (g_ascii_isspace(c)) {
> > > > +        return true;
> > > > +    }
> > > > +    if (!g_ascii_isxdigit(c) || !in_process) {
> > > > +        return false;
> > > > +    }
> > > > +    /* still idx is computed nibble wise */
> > > > +    value =3D g_ascii_xdigit_value(c);
> > > > +    value =3D (idx & 0x1) ? (value & 0xf) : (value << 4);
> > > > +    if (idx < 2) {
> > > > +        line->record_length |=3D value;
> > > > +    } else if (idx =3D=3D 2) {
> > > > +        line->record_type |=3D value;
> > > > +    } else if (2 < idx && idx <=3D 4) {
> > > > +        line->checksum |=3D value;
> > > > +    }
> > > > +    /*
> > > > +     * Extracting address length from record to fill that many no =
of
> > > address
> > > > +     * characters in the address field of the line structure.
> > > > +     */
> > > > +    else if (idx =3D=3D 5) {
> > > > +        address_len |=3D value;
> > > > +    } else if (6 <=3D idx &&
> > > > +                   idx <=3D (6 + address_len)) {
> > > > +        line->address <<=3D address_len;
> > > > +        line->address +=3D g_ascii_xdigit_value(c);
> > > > +    }
> > > > +    /*
> > > > +     * Checking whether index above address last char index
> > > > +     * and reaches till record length. Right shifting one divides
> the
> > > > +     * nibble wise index by 2 to get the byte wise index to
> > > > +     * fill the data field of the line structure
> > > > +     */
> > > > +    else if ((6 + address_len) < idx &&
> > > > +              idx <=3D line->record_length) {
> > > > +        line->data[(idx - (6 + address_len)) >> 1] |=3D value;
> > > > +    } else {
> > > > +        return false;
> > > > +    }
> > > > +    *our_checksum +=3D value;
> > > > +    ++(*index);
> > > > +    return true;
> > > > +}
> > > > +
> > > > +typedef struct {
> > > > +    const char *filename;
> > > > +    Ext_Tek_HexLine line;
> > > > +    uint8_t *bin_buf;
> > > > +    hwaddr *start_addr;
> > > > +    int total_size;
> > > > +    uint32_t next_address_to_write;
> > > > +    uint32_t current_address;
> > > > +    uint32_t current_rom_index;
> > > > +    uint32_t rom_start_address;
> > > > +    AddressSpace *as;
> > > > +    bool complete;
> > > > +} Ext_TekHexParser;
> > > > +
> > > > +/* return size or -1 if error */
> > > > +static int handle_ext_tek_hex_record_type(Ext_TekHexParser *parser=
)
> > > > +{
> > > > +    Ext_Tek_HexLine *line =3D &(parser->line);
> > > > +    switch (line->record_type) {
> > > > +    case TEK_DATA_RECORD:
> > > > +        parser->current_address =3D line->address;
> > > > +        /* verify this is a contiguous block of memory */
> > > > +        if (parser->current_address !=3D
> parser->next_address_to_write) {
> > > > +            if (parser->current_rom_index !=3D 0) {
> > > > +                rom_add_blob_fixed_as(parser->filename,
> parser->bin_buf,
> > > > +                                      parser->current_rom_index,
> > > > +                                      parser->rom_start_address,
> > > parser->as);
> > > > +            }
> > > > +            parser->rom_start_address =3D parser->current_address;
> > > > +            parser->current_rom_index =3D 0;
> > > > +        }
> > > > +
> > > > +        /* copy from line buffer to output bin_buf */
> > > > +        /* sizeof(line->data) dynamically calculates the size of
> data
> > > field */
> > > > +        memcpy(parser->bin_buf + parser->current_rom_index,
> line->data,
> > > > +               sizeof(line->data));
> > > > +        parser->current_rom_index +=3D sizeof(line->data);
> > > > +        parser->total_size +=3D sizeof(line->data);
> > > > +        /* As address is absolute, we dont need to calculate next
> > > address */
> > > > +        break;
> > > > +
> > > > +    case TEK_TERMINATION_RECORD:
> > > > +        if (parser->current_rom_index !=3D 0) {
> > > > +            rom_add_blob_fixed_as(parser->filename, parser->bin_bu=
f,
> > > > +                                  parser->current_rom_index,
> > > > +                                  parser->rom_start_address,
> > > parser->as);
> > > > +        }
> > > > +        parser->complete =3D true;
> > > > +        return parser->total_size;
> > > > +
> > > > +    default:
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    return parser->total_size;
> > > > +}
> > > > +
> > > > +/* return size or -1 if error */
> > > > +static int parse_ext_tek_hex_blob(const char *filename,
> > > > +                                  hwaddr *addr,
> > > > +                                  uint8_t *ext_tek_blob,
> > > > +                                  size_t ext_tek_blob_size,
> > > > +                                  AddressSpace *as)
> > > > +{
> > > > +    /* avoid re-enter and check whether record begin with '%' */
> > > > +        bool in_process =3D false;
> > > > +        uint8_t *end =3D ext_tek_blob + ext_tek_blob_size;
> > > > +        uint8_t our_checksum =3D 0;
> > > > +        uint32_t record_index =3D 0;
> > > > +
> > > > +        Ext_TekHexParser parser =3D {
> > > > +        .filename =3D filename,
> > > > +        .bin_buf =3D g_malloc(ext_tek_blob_size),
> > > > +        .start_addr =3D addr,
> > > > +        .as =3D as,
> > > > +        .complete =3D false
> > > > +        };
> > > > +
> > > > +        rom_transaction_begin();
> > > > +
> > > > +        for (; ext_tek_blob < end && !parser.complete;
> ++ext_tek_blob) {
> > > > +            switch (*ext_tek_blob) {
> > > > +            case '\r':
> > > > +            case '\n':
> > > > +                if (!in_process) {
> > > > +                    break;
> > > > +                }
> > > > +
> > > > +                in_process =3D false;
> > > > +                /*
> > > > +                 * record_length byte stores the number of hex
> > > characters
> > > > +                 * (nibbles) in the record and compare it directly
> to
> > > > +                 * the nibble index(record index).
> > > > +                 */
> > > > +                if ((parser.line.record_length !=3D record_index) =
||
> > > > +                    (our_checksum !=3D 0)) {
> > > > +                    parser.total_size =3D -1;
> > > > +                    goto out;
> > > > +                }
> > > > +
> > > > +                if (handle_ext_tek_hex_record_type(&parser) =3D=3D=
 -1) {
> > > > +                    parser.total_size =3D -1;
> > > > +                    goto out;
> > > > +                }
> > > > +                break;
> > > > +
> > > > +            /* start of a new record. */
> > > > +            case '%':
> > > > +                memset(&parser.line, 0, sizeof(Ext_Tek_HexLine));
> > > > +                in_process =3D true;
> > > > +                record_index =3D 0;
> > > > +                break;
> > > > +
> > > > +            /* decoding lines */
> > > > +            default:
> > > > +                if (!parse_ext_tek_hex_record(&parser.line,
> > > > +                                            &our_checksum,
> > > > +                                            *ext_tek_blob,
> > > > +                                            &record_index,
> in_process))
> > > {
> > > > +                    parser.total_size =3D -1;
> > > > +                    goto out;
> > > > +                }
> > > > +                break;
> > > > +            }
> > > > +        }
> > > > +
> > > > +    out:
> > > > +        g_free(parser.bin_buf);
> > > > +        rom_transaction_end(parser.total_size !=3D -1);
> > > > +        return parser.total_size;
> > > > +}
> > > > +
> > > > +
> > > > +/* return size or -1 if error */
> > > > +ssize_t load_targphys_ext_tek_hex_as(const char *filename,
> > > > +                                     hwaddr *entry,
> > > > +                                     AddressSpace *as)
> > > > +{
> > > > +    gsize ext_tek_blob_size;
> > > > +    gchar *ext_tek_blob;
> > > > +    int total_size =3D 0;
> > > > +
> > > > +    if (!g_file_get_contents(filename, &ext_tek_blob,
> > > > +                             &ext_tek_blob_size, NULL)) {
> > > > +        return -1;
> > > > +    }
> > > > +    total_size =3D parse_ext_tek_hex_blob(filename, entry,
> > > > +                                       (uint8_t *)ext_tek_blob,
> > > > +                                       ext_tek_blob_size, as);
> > > > +
> > > > +    g_free(ext_tek_blob);
> > > > +    return total_size;
> > > > +}
> > > > diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> > > > index
> > >
> d9431e8a8d12e3b676160f70ed141f1064143ea3..c0d29b1d4456bb92984749e56f1109f=
8421cee51
> > > 100644
> > > > --- a/include/hw/core/loader.h
> > > > +++ b/include/hw/core/loader.h
> > > > @@ -57,6 +57,21 @@ ssize_t load_image_targphys_as(const char
> *filename,
> > > >  ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
> > > >                               AddressSpace *as);
> > > >
> > > > +/**
> > > > + * load_targphys_ext_tek_as:
> > > > + * @filename: Path to the .tek file
> > > > + * @entry: Store the entry point given by the .tek file
> > > > + * @as: The AddressSpace to load the .tek file to. The value of
> > > > + *      address_space_memory is used if nothing is supplied here.
> > > > + *
> > > > + * Load a fixed .tek file into memory.
> > > > + *
> > > > + * Returns the size of the loaded .tek file on success, -1
> otherwise.
> > > > + */
> > > > +ssize_t load_targphys_ext_tek_hex_as(const char *filename,
> > > > +                                     hwaddr *entry,
> > > > +                                     AddressSpace *as);
> > > > +
> > > >  /** load_image_targphys:
> > > >   * Same as load_image_targphys_as(), but doesn't allow the caller =
to
> > > specify
> > > >   * an AddressSpace.
> > > > --
> > > > 2.54.0.windows.1
> > > >
> > >
> > > With regards,
> > > Daniel
> > > --
> > > |: https://berrange.com       ~~        https://hachyderm.io/@berrang=
e
> :|
> > > |: https://libvirt.org          ~~          https://entangle-photo.or=
g
> :|
> > > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.co=
m
> :|
> > >
> > >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000c64aaf0660b25b37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 20, 2026, 15:01 Dani=
el P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Re-adding qe=
mu-devel - please don&#39;t drop the mailing list when<br>
replying to review comments.<br>
<br>
On Fri, Nov 20, 2026 at 02:47:07PM +0530, Nagendran Jairam wrote:<br>
&gt; On Fri, Nov 20, 2026, 14:38 Daniel P. Berrang=C3=A9 &lt;<a href=3D"mai=
lto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redh=
at.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Sat, Nov 14, 2026 at 04:58:50PM +0530, Nagendran K wrote:<br>
&gt; &gt;<br>
&gt; &gt; Please provide a commit message to explain the purpose of<br>
&gt; &gt; this addition.<br>
&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 I am sorry, I forgot to mention that this f=
unction is being called<br>
&gt; in generic-loader.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 The purpose is to load .tek files (binaries=
 commonly used in Texas<br>
&gt; instruments microcontrollers)=C2=A0 directly without worrying about ra=
w binary<br>
&gt; or hex conversion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hex and tek files have major differen=
ces and it reduces manual<br>
&gt; effort for a user to convert .tek to .hex<br>
<br>
It is clearly not being called in generic-loader.c since this patch<br>
makes no changes to that file.<br>
<br>=C2=A0Alistair mailed me with the same issue too...Aactually my whole i=
mplementation is not in master..Its updated in my local not in upstream<br>=
</blockquote></div></div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 I will upda=
te my patch in upstream master..Thanks</div><div dir=3D"auto">=C2=A0 =C2=A0=
 Nagendran</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; &gt; &gt; Signed-off-by: Nagendran K &lt;<a href=3D"mailto:nagendranja=
iram52@gmail.com" target=3D"_blank" rel=3D"noreferrer">nagendranjairam52@gm=
ail.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23=
1 +++++++++++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 include/hw/core/loader.h |=C2=A0 15 +++<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 246 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; ....this is adding a new API to common code and then not<br>
&gt; &gt; calling it from anywhere in QEMU. This is pointless<br>
&gt; &gt; and so is not likely to be accepted in isolation without<br>
&gt; &gt; a proposed usage accompanying it.<br>
&gt;=C2=A0 =C2=A0This is function has a call in generic-loader.c to load .t=
ek files<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Example Usecase: -device loader, file=3Dmy_=
test.tek, addr=3D0x00000000<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/core/loader.c b/hw/core/loader.c<br>
&gt; &gt; &gt; index<br>
&gt; &gt; 5cbfba0a86d24569923c863d6ecda125ce43bceb..33ccb51d56dda1035e81547=
9e20c2a6c793843d9<br>
&gt; &gt; 100644<br>
&gt; &gt; &gt; --- a/hw/core/loader.c<br>
&gt; &gt; &gt; +++ b/hw/core/loader.c<br>
&gt; &gt; &gt; @@ -1940,3 +1940,234 @@ ssize_t load_targphys_hex_as(const c=
har<br>
&gt; &gt; *filename, hwaddr *entry,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_free(hex_blob);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 return total_size;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +typedef enum Ext_Tek_HexRecord Ext_Tek_HexRecord;<br>
&gt; &gt; &gt; +enum Ext_Tek_HexRecord {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 TEK_DATA_RECORD =3D 0,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 TEK_TERMINATION_RECORD<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define DATA_FIELD_MAX_LEN 0xff<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +typedef struct {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t record_length;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t record_type;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t checksum;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t address;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t data[DATA_FIELD_MAX_LEN];<br>
&gt; &gt; &gt; +} Ext_Tek_HexLine;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* return 0 or -1 if error */<br>
&gt; &gt; &gt; +static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line,=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt8_t *our_checksum,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst uint8_t c,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t *index,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst bool in_process)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +---------+---------------+-----------+---------------+----------=
---+<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* | record=C2=A0 |=C2=A0 =C2=A0 record=
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt;=C2=A0 =C2=A0 |<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* | length=C2=A0 |=C2=A0 =C2=A0 type=C2=
=A0 =C2=A0 =C2=A0 =C2=A0| checksum=C2=A0 |=C2=A0 =C2=A0address=C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0data<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; +---------+---------------+-----------+---------------+----------=
---+<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0^=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* |1 byte=C2=A0 =C2=A0|=C2=A0 =C2=A0 1 =
bytes=C2=A0 =C2=A0 |1 byte=C2=A0 =C2=A0 =C2=A0| 1 to N byte=C2=A0 =C2=A0| 0=
-255<br>
&gt; &gt; bytes |<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t value =3D 0, address_len =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t idx =3D *index;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* ignore space */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (g_ascii_isspace(c)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!g_ascii_isxdigit(c) || !in_process) {<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* still idx is computed nibble wise */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 value =3D g_ascii_xdigit_value(c);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 value =3D (idx &amp; 0x1) ? (value &amp; 0xf)=
 : (value &lt;&lt; 4);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (idx &lt; 2) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 line-&gt;record_length |=3D val=
ue;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } else if (idx =3D=3D 2) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 line-&gt;record_type |=3D value=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } else if (2 &lt; idx &amp;&amp; idx &lt;=3D =
4) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 line-&gt;checksum |=3D value;<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Extracting address length from record=
 to fill that many no of<br>
&gt; &gt; address<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* characters in the address field of th=
e line structure.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 else if (idx =3D=3D 5) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 address_len |=3D value;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } else if (6 &lt;=3D idx &amp;&amp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0idx &lt;=3D (6 + address_len)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 line-&gt;address &lt;&lt;=3D ad=
dress_len;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 line-&gt;address +=3D g_ascii_x=
digit_value(c);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Checking whether index above address =
last char index<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* and reaches till record length. Right=
 shifting one divides the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* nibble wise index by 2 to get the byt=
e wise index to<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* fill the data field of the line struc=
ture<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 else if ((6 + address_len) &lt; idx &amp;&amp=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx &lt;=
=3D line-&gt;record_length) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 line-&gt;data[(idx - (6 + addre=
ss_len)) &gt;&gt; 1] |=3D value;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 *our_checksum +=3D value;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ++(*index);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return true;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +typedef struct {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 const char *filename;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Ext_Tek_HexLine line;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t *bin_buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 hwaddr *start_addr;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int total_size;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t next_address_to_write;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t current_address;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t current_rom_index;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t rom_start_address;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AddressSpace *as;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bool complete;<br>
&gt; &gt; &gt; +} Ext_TekHexParser;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* return size or -1 if error */<br>
&gt; &gt; &gt; +static int handle_ext_tek_hex_record_type(Ext_TekHexParser =
*parser)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Ext_Tek_HexLine *line =3D &amp;(parser-&gt;li=
ne);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 switch (line-&gt;record_type) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case TEK_DATA_RECORD:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;current_address =3D =
line-&gt;address;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* verify this is a contiguous =
block of memory */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parser-&gt;current_address =
!=3D parser-&gt;next_address_to_write) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parser-&gt;cu=
rrent_rom_index !=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom=
_add_blob_fixed_as(parser-&gt;filename, parser-&gt;bin_buf,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
arser-&gt;current_rom_index,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
arser-&gt;rom_start_address,<br>
&gt; &gt; parser-&gt;as);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;rom_st=
art_address =3D parser-&gt;current_address;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;curren=
t_rom_index =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* copy from line buffer to out=
put bin_buf */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sizeof(line-&gt;data) dynami=
cally calculates the size of data<br>
&gt; &gt; field */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(parser-&gt;bin_buf + par=
ser-&gt;current_rom_index, line-&gt;data,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size=
of(line-&gt;data));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;current_rom_index +=
=3D sizeof(line-&gt;data);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;total_size +=3D size=
of(line-&gt;data);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* As address is absolute, we d=
ont need to calculate next<br>
&gt; &gt; address */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case TEK_TERMINATION_RECORD:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parser-&gt;current_rom_inde=
x !=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_add_blob_fixe=
d_as(parser-&gt;filename, parser-&gt;bin_buf,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;curr=
ent_rom_index,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;rom_=
start_address,<br>
&gt; &gt; parser-&gt;as);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;complete =3D true;<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return parser-&gt;total_size;<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return parser-&gt;total_size;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* return size or -1 if error */<br>
&gt; &gt; &gt; +static int parse_ext_tek_hex_blob(const char *filename,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr *addr,<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *ext_te=
k_blob,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t ext_tek_=
blob_size,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AddressSpace *a=
s)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* avoid re-enter and check whether record be=
gin with &#39;%&#39; */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool in_process =3D false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *end =3D ext_tek_blob +=
 ext_tek_blob_size;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t our_checksum =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t record_index =3D 0;<br=
>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ext_TekHexParser parser =3D {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .filename =3D filename,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .bin_buf =3D g_malloc(ext_tek_b=
lob_size),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .start_addr =3D addr,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .as =3D as,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .complete =3D false<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_transaction_begin();<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; ext_tek_blob &lt; end &a=
mp;&amp; !parser.complete; ++ext_tek_blob) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (*ext_tek_=
blob) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;\r&#39;=
:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;\n&#39;=
:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(!in_process) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in_=
process =3D false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* record_length byte stores the number of hex<br>
&gt; &gt; characters<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* (nibbles) in the record and compare it directly to<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* the nibble index(record index).<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
((parser.line.record_length !=3D record_index) ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (our_checksum !=3D 0)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 parser.total_size =3D -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(handle_ext_tek_hex_record_type(&amp;parser) =3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 parser.total_size =3D -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bre=
ak;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* start of a new=
 record. */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;%&#39;:=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem=
set(&amp;parser.line, 0, sizeof(Ext_Tek_HexLine));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in_=
process =3D true;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rec=
ord_index =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bre=
ak;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* decoding lines=
 */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(!parse_ext_tek_hex_record(&amp;parser.line,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;our_checksum,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *ext_tek_blob,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;record_index, in_process))<br>
&gt; &gt; {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 parser.total_size =3D -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bre=
ak;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 out:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(parser.bin_buf);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_transaction_end(parser.tota=
l_size !=3D -1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return parser.total_size;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* return size or -1 if error */<br>
&gt; &gt; &gt; +ssize_t load_targphys_ext_tek_hex_as(const char *filename,<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw=
addr *entry,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ad=
dressSpace *as)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 gsize ext_tek_blob_size;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 gchar *ext_tek_blob;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int total_size =3D 0;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!g_file_get_contents(filename, &amp;ext_t=
ek_blob,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ext_tek_blob_size, NULL))=
 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 total_size =3D parse_ext_tek_hex_blob(filenam=
e, entry,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(uint8_t *)ext_tek_blob,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ext_tek_blob_size, as);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 g_free(ext_tek_blob);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return total_size;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; diff --git a/include/hw/core/loader.h b/include/hw/core/load=
er.h<br>
&gt; &gt; &gt; index<br>
&gt; &gt; d9431e8a8d12e3b676160f70ed141f1064143ea3..c0d29b1d4456bb92984749e=
56f1109f8421cee51<br>
&gt; &gt; 100644<br>
&gt; &gt; &gt; --- a/include/hw/core/loader.h<br>
&gt; &gt; &gt; +++ b/include/hw/core/loader.h<br>
&gt; &gt; &gt; @@ -57,6 +57,21 @@ ssize_t load_image_targphys_as(const char=
 *filename,<br>
&gt; &gt; &gt;=C2=A0 ssize_t load_targphys_hex_as(const char *filename, hwa=
ddr *entry,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace *as);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/**<br>
&gt; &gt; &gt; + * load_targphys_ext_tek_as:<br>
&gt; &gt; &gt; + * @filename: Path to the .tek file<br>
&gt; &gt; &gt; + * @entry: Store the entry point given by the .tek file<br>
&gt; &gt; &gt; + * @as: The AddressSpace to load the .tek file to. The valu=
e of<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 address_space_memory is used if noth=
ing is supplied here.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Load a fixed .tek file into memory.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Returns the size of the loaded .tek file on success, -1 =
otherwise.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +ssize_t load_targphys_ext_tek_hex_as(const char *filename,<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw=
addr *entry,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ad=
dressSpace *as);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 /** load_image_targphys:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* Same as load_image_targphys_as(), but doesn&#3=
9;t allow the caller to<br>
&gt; &gt; specify<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* an AddressSpace.<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.54.0.windows.1<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; With regards,<br>
&gt; &gt; Daniel<br>
&gt; &gt; --<br>
&gt; &gt; |: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a>=
 :|<br>
&gt; &gt; |: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ~~=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://entangle-photo.or=
g</a> :|<br>
&gt; &gt; |: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~=
~=C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer =
noreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000c64aaf0660b25b37--

