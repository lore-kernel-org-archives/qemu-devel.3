Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOmbCkdM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUKcA-00008Y-QL; Fri, 20 Nov 2026 04:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUKc5-00008I-Av
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUKc3-0004ar-05
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795165733;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cRamx0hoEWcf4zifaHAmskP2+P+K+4Q+72PUTiZXrbo=;
 b=ZOmbCkdMWoc4v0zTi5WkoCwY4hMIZAaWZxhmt4qdb9sYpXXn7gQKl4tP1vQL9wARhKWocS
 FR1yjM9JnKR4yTglP9uoPQxfGxABMjSVr5c6CWe+GQvr39rgPF3TyZmaEyMmdM5x12jKGk
 ZUK74qB89/05u0csiYQrfVzVzCFBIyU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-LtmgCe5YObKIkaTs2E-1rw-1; Fri,
 20 Nov 2026 09:08:49 +0000
X-MC-Unique: LtmgCe5YObKIkaTs2E-1rw-1
X-Mimecast-MFC-AGG-ID: LtmgCe5YObKIkaTs2E-1rw_1795165728
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 697961800343; Fri, 20 Nov 2026 09:08:48 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A61A1195B3C4; Fri, 20 Nov 2026 09:08:46 +0000 (UTC)
Date: Fri, 20 Nov 2026 09:08:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nagendran K <nagendranjairam52@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, daan.j.demeyer@gmail.com,
 peter.maydell@linaro.org, alistair@alistair23.me
Subject: Re: [PATCH] hw/core/loader: Add Extended Tektronix HEX support
Message-ID: <awAOG_BGiCgjM8nE@redhat.com>
References: <20261114112855.108-1-nagendranjairam52@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114112855.108-1-nagendranjairam52@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 04:58:50PM +0530, Nagendran K wrote:

Please provide a commit message to explain the purpose of
this addition.

> Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
> ---
>  hw/core/loader.c         | 231 +++++++++++++++++++++++++++++++++++++++
>  include/hw/core/loader.h |  15 +++
>  2 files changed, 246 insertions(+)

....this is adding a new API to common code and then not
calling it from anywhere in QEMU. This is pointless
and so is not likely to be accepted in isolation without
a proposed usage accompanying it.


> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86d24569923c863d6ecda125ce43bceb..33ccb51d56dda1035e815479e20c2a6c793843d9 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1940,3 +1940,234 @@ ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
>      g_free(hex_blob);
>      return total_size;
>  }
> +
> +typedef enum Ext_Tek_HexRecord Ext_Tek_HexRecord;
> +enum Ext_Tek_HexRecord {
> +    TEK_DATA_RECORD = 0,
> +    TEK_TERMINATION_RECORD
> +};
> +
> +#define DATA_FIELD_MAX_LEN 0xff
> +
> +typedef struct {
> +    uint8_t record_length;
> +    uint8_t record_type;
> +    uint8_t checksum;
> +    uint32_t address;
> +    uint8_t data[DATA_FIELD_MAX_LEN];
> +} Ext_Tek_HexLine;
> +
> +/* return 0 or -1 if error */
> +static bool parse_ext_tek_hex_record(Ext_Tek_HexLine *line,
> +                                     uint8_t *our_checksum,
> +                                     const uint8_t c,
> +                                     uint32_t *index,
> +                                     const bool in_process)
> +{
> +    /* +---------+---------------+-----------+---------------+-------------+
> +     * | record  |    record     |           |               |             |
> +     * | length  |    type       | checksum  |   address     |   data      |
> +     * +---------+---------------+-----------+---------------+-------------+
> +     *     ^             ^            ^              ^            ^
> +     * |1 byte   |    1 bytes    |1 byte     | 1 to N byte   | 0-255 bytes |
> +     */
> +    uint8_t value = 0, address_len = 0;
> +    uint32_t idx = *index;
> +    /* ignore space */
> +    if (g_ascii_isspace(c)) {
> +        return true;
> +    }
> +    if (!g_ascii_isxdigit(c) || !in_process) {
> +        return false;
> +    }
> +    /* still idx is computed nibble wise */
> +    value = g_ascii_xdigit_value(c);
> +    value = (idx & 0x1) ? (value & 0xf) : (value << 4);
> +    if (idx < 2) {
> +        line->record_length |= value;
> +    } else if (idx == 2) {
> +        line->record_type |= value;
> +    } else if (2 < idx && idx <= 4) {
> +        line->checksum |= value;
> +    }
> +    /*
> +     * Extracting address length from record to fill that many no of address
> +     * characters in the address field of the line structure.
> +     */
> +    else if (idx == 5) {
> +        address_len |= value;
> +    } else if (6 <= idx &&
> +                   idx <= (6 + address_len)) {
> +        line->address <<= address_len;
> +        line->address += g_ascii_xdigit_value(c);
> +    }
> +    /*
> +     * Checking whether index above address last char index
> +     * and reaches till record length. Right shifting one divides the
> +     * nibble wise index by 2 to get the byte wise index to
> +     * fill the data field of the line structure
> +     */
> +    else if ((6 + address_len) < idx &&
> +              idx <= line->record_length) {
> +        line->data[(idx - (6 + address_len)) >> 1] |= value;
> +    } else {
> +        return false;
> +    }
> +    *our_checksum += value;
> +    ++(*index);
> +    return true;
> +}
> +
> +typedef struct {
> +    const char *filename;
> +    Ext_Tek_HexLine line;
> +    uint8_t *bin_buf;
> +    hwaddr *start_addr;
> +    int total_size;
> +    uint32_t next_address_to_write;
> +    uint32_t current_address;
> +    uint32_t current_rom_index;
> +    uint32_t rom_start_address;
> +    AddressSpace *as;
> +    bool complete;
> +} Ext_TekHexParser;
> +
> +/* return size or -1 if error */
> +static int handle_ext_tek_hex_record_type(Ext_TekHexParser *parser)
> +{
> +    Ext_Tek_HexLine *line = &(parser->line);
> +    switch (line->record_type) {
> +    case TEK_DATA_RECORD:
> +        parser->current_address = line->address;
> +        /* verify this is a contiguous block of memory */
> +        if (parser->current_address != parser->next_address_to_write) {
> +            if (parser->current_rom_index != 0) {
> +                rom_add_blob_fixed_as(parser->filename, parser->bin_buf,
> +                                      parser->current_rom_index,
> +                                      parser->rom_start_address, parser->as);
> +            }
> +            parser->rom_start_address = parser->current_address;
> +            parser->current_rom_index = 0;
> +        }
> +
> +        /* copy from line buffer to output bin_buf */
> +        /* sizeof(line->data) dynamically calculates the size of data field */
> +        memcpy(parser->bin_buf + parser->current_rom_index, line->data,
> +               sizeof(line->data));
> +        parser->current_rom_index += sizeof(line->data);
> +        parser->total_size += sizeof(line->data);
> +        /* As address is absolute, we dont need to calculate next address */
> +        break;
> +
> +    case TEK_TERMINATION_RECORD:
> +        if (parser->current_rom_index != 0) {
> +            rom_add_blob_fixed_as(parser->filename, parser->bin_buf,
> +                                  parser->current_rom_index,
> +                                  parser->rom_start_address, parser->as);
> +        }
> +        parser->complete = true;
> +        return parser->total_size;
> +
> +    default:
> +        return -1;
> +    }
> +
> +    return parser->total_size;
> +}
> +
> +/* return size or -1 if error */
> +static int parse_ext_tek_hex_blob(const char *filename,
> +                                  hwaddr *addr,
> +                                  uint8_t *ext_tek_blob,
> +                                  size_t ext_tek_blob_size,
> +                                  AddressSpace *as)
> +{
> +    /* avoid re-enter and check whether record begin with '%' */
> +        bool in_process = false;
> +        uint8_t *end = ext_tek_blob + ext_tek_blob_size;
> +        uint8_t our_checksum = 0;
> +        uint32_t record_index = 0;
> +
> +        Ext_TekHexParser parser = {
> +        .filename = filename,
> +        .bin_buf = g_malloc(ext_tek_blob_size),
> +        .start_addr = addr,
> +        .as = as,
> +        .complete = false
> +        };
> +
> +        rom_transaction_begin();
> +
> +        for (; ext_tek_blob < end && !parser.complete; ++ext_tek_blob) {
> +            switch (*ext_tek_blob) {
> +            case '\r':
> +            case '\n':
> +                if (!in_process) {
> +                    break;
> +                }
> +
> +                in_process = false;
> +                /*
> +                 * record_length byte stores the number of hex characters
> +                 * (nibbles) in the record and compare it directly to
> +                 * the nibble index(record index).
> +                 */
> +                if ((parser.line.record_length != record_index) ||
> +                    (our_checksum != 0)) {
> +                    parser.total_size = -1;
> +                    goto out;
> +                }
> +
> +                if (handle_ext_tek_hex_record_type(&parser) == -1) {
> +                    parser.total_size = -1;
> +                    goto out;
> +                }
> +                break;
> +
> +            /* start of a new record. */
> +            case '%':
> +                memset(&parser.line, 0, sizeof(Ext_Tek_HexLine));
> +                in_process = true;
> +                record_index = 0;
> +                break;
> +
> +            /* decoding lines */
> +            default:
> +                if (!parse_ext_tek_hex_record(&parser.line,
> +                                            &our_checksum,
> +                                            *ext_tek_blob,
> +                                            &record_index, in_process)) {
> +                    parser.total_size = -1;
> +                    goto out;
> +                }
> +                break;
> +            }
> +        }
> +
> +    out:
> +        g_free(parser.bin_buf);
> +        rom_transaction_end(parser.total_size != -1);
> +        return parser.total_size;
> +}
> +
> +
> +/* return size or -1 if error */
> +ssize_t load_targphys_ext_tek_hex_as(const char *filename,
> +                                     hwaddr *entry,
> +                                     AddressSpace *as)
> +{
> +    gsize ext_tek_blob_size;
> +    gchar *ext_tek_blob;
> +    int total_size = 0;
> +
> +    if (!g_file_get_contents(filename, &ext_tek_blob,
> +                             &ext_tek_blob_size, NULL)) {
> +        return -1;
> +    }
> +    total_size = parse_ext_tek_hex_blob(filename, entry,
> +                                       (uint8_t *)ext_tek_blob,
> +                                       ext_tek_blob_size, as);
> +
> +    g_free(ext_tek_blob);
> +    return total_size;
> +}
> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> index d9431e8a8d12e3b676160f70ed141f1064143ea3..c0d29b1d4456bb92984749e56f1109f8421cee51 100644
> --- a/include/hw/core/loader.h
> +++ b/include/hw/core/loader.h
> @@ -57,6 +57,21 @@ ssize_t load_image_targphys_as(const char *filename,
>  ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
>                               AddressSpace *as);
>  
> +/**
> + * load_targphys_ext_tek_as:
> + * @filename: Path to the .tek file
> + * @entry: Store the entry point given by the .tek file
> + * @as: The AddressSpace to load the .tek file to. The value of
> + *      address_space_memory is used if nothing is supplied here.
> + *
> + * Load a fixed .tek file into memory.
> + *
> + * Returns the size of the loaded .tek file on success, -1 otherwise.
> + */
> +ssize_t load_targphys_ext_tek_hex_as(const char *filename,
> +                                     hwaddr *entry,
> +                                     AddressSpace *as);
> +
>  /** load_image_targphys:
>   * Same as load_image_targphys_as(), but doesn't allow the caller to specify
>   * an AddressSpace.
> -- 
> 2.54.0.windows.1
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


