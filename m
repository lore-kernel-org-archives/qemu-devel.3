Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2615F9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdyC-00085z-OO; Tue, 14 Apr 2026 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdy9-00085H-UF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:38:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdy7-0006c6-K2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:38:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso52599955e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776173898; x=1776778698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EURxgzx/Zt8dqm62J0aO5vTStNu8jG/WOHHoBEotsXo=;
 b=ktRVEwdV020mjv4Xugw+zyfB0QyP3XKrSqpckyLPd3Wfpis//Yj9BuoamL17yWLiCX
 bZWZyWRQJ633vuY79QKk6an6eU39nOUKKTnjUV1nuktSUF7X5zpl/Lmg49wek54Fg4ON
 heUGvmKVAWRSdJIwC1l60fvThGnWL/dzl0rQDIx1Vv7IH98SgasMEgEGJnzvNGwegz+q
 NJ8QVkVsDhG/WtrISUSWAjR8fNchqmBDPBnNoncDc4KdqfSVgXS5mlljsMK+0OFbg4uT
 3GsfRdOVxM73uNBniLk8kOYNFem+N2rypAoQmeuneDqZ1niE5L1ixFYw48VX9KZNJcsa
 IEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776173898; x=1776778698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EURxgzx/Zt8dqm62J0aO5vTStNu8jG/WOHHoBEotsXo=;
 b=gS/xiooeT5PMTgUILx0Ugy7zf+7SSFSWdP/PlXQKz2iIUfbHCY8mp9Hbv+Y9dKRiKr
 DRjpWEoURcd9w0o1Y2lKnRyOcLijpQXv5po+GSRNrc3NQKEEVp5xg0PkxqJ9XZSBeuMC
 uj03ul7WbzM6pnfUPCA7NOnZZM4UpYBcI1IQe9YpYBrPn7hwE/x/4vT0PgFUQCMBukI7
 1aalRKOgVcVtRnIrOzLuBqn68WVAxx53J/QQJJUFBWMJ2yR2EqzhoE9CHGv6nO5Q09MY
 cmzk8CCMKUym0xarFTETI0RfcylXh8x5X4ys42ZO3mUvllQLzBcrYED1C2swhBRlJrWJ
 F27A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GVmLdtbmuUgWOTw8wsxwfEArGcUoEbYe/+21Z4rI8wTEVxDqeLrNUQmDD7070xUOWBxyip7UQ69+4@nongnu.org
X-Gm-Message-State: AOJu0Yy6ADQcDQZRAE4MfnkNYTpsl/4sEtMs3wXCI7Iw1oGY7sx+6rO/
 xSRb+dB4Kx6h7va/FfgQtj7yEslOP8e+rynKGv8AynlyCREy8dwcKl3s/MuyTMQAhC8=
X-Gm-Gg: AeBDies1CdV7/6KZ2h6ocRtJDRYSzDR3eOAakurDwgrl3kN5YBJ85vijZaTNBq5Oc76
 vpcQC195SsHu2NksXBkEU9/BN4E6uhYsLpmkrirmJbLO+2dFdC/moA7yOmc5dK59QgtJa8gLINo
 9szqiQfuTePR9CXdGTF3LrLDwqhMVEGkLJmhbpP2LU00zt095j3FjImReRC1qOuD97hrO3Z7ENz
 HD0uIpQUK8J7VfaE8l4Q6WBZBv3MokLnc9B0peZfkaiLbTpeoDLRleyKX1Uj0Q/2RZJwtjRQW/g
 bWmhNMIv4+3gLFnPNMk/i3ZmbH6cw1VoXrEFXgwf/w4RDWJ63TGHRgRk9iZkMYOMuoOj+M4ifZq
 WCjrT9Xbq1EqUX31mxgZojXYJtLL9h2L5MNzXXKve/FSagCOq1Sx+nJd+AfZDf9x0aIsbTERQ3N
 iYUlpUO0Kob46izHmku4e2PYXu4KoCALepDd5znprdKcsVhC9K53lh7RtpTsO8PC9m/A==
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id
 5b1f17b1804b1-488d67e262cmr161465815e9.9.1776173897808; 
 Tue, 14 Apr 2026 06:38:17 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488eddb9751sm86496805e9.0.2026.04.14.06.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:38:17 -0700 (PDT)
Message-ID: <1df47b0b-a94c-483b-a4c5-629af22353a5@linaro.org>
Date: Tue, 14 Apr 2026 15:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/sd: Switch read/write primitive to buf+len
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-1-dc1cf172ee57@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204-sdcard-performance-b4-v3-1-dc1cf172ee57@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Christian,

On 4/2/26 14:22, Christian Speich wrote:
> Currently, read/writes are broken down into individual bytes which result
> in many function calls. This is quite bad for performance and since both
> the layer below and above work with larger buffers, it should be
> corrected.
> 
> This patch is the first that switches the corresponding interface over to
> use a buf+len instead of a single byte. However, for most cases the
> implementation still only reads one byte and is then called again with
> the remaining buffer.
> 
> Optimizations taking advantage of this new interface are to follow in the
> next commits.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/core.c       | 26 ++++++++++++++---------
>   hw/sd/sd.c         | 62 +++++++++++++++++++++++++++++++++++-------------------
>   include/hw/sd/sd.h | 22 +++++++++++++------
>   3 files changed, 71 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 3568a81e809fe107cfd0b5cc33b8b5761b11ce04..594c5e011ba30940a33799f9032c92494ee0ca19 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -113,21 +113,24 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
>       if (card) {
>           SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
> -        sc->write_byte(card, value);
> +        sc->write_data(card, &value, 1);
>       }
>   }
>   
>   void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
>   {
>       SDState *card = get_card(sdbus);
> -    const uint8_t *data = buf;
>   
>       if (card) {
>           SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
> -        for (size_t i = 0; i < length; i++) {
> -            trace_sdbus_write(sdbus_name(sdbus), data[i]);

Instead of removing this trace event,

> -            sc->write_byte(card, data[i]);
> +        while (length > 0) {
> +            size_t written = sc->write_data(card, buf, length);
> +

move it here, using qemu_hexdump_line().

> +            g_assert(written >= 1);
> +
> +            buf += written;
> +            length -= written;
>           }
>       }
>   }
> @@ -140,7 +143,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
>       if (card) {
>           SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
> -        value = sc->read_byte(card);
> +        sc->read_data(card, &value, 1);
>       }
>       trace_sdbus_read(sdbus_name(sdbus), value);
>   
> @@ -150,14 +153,17 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
>   void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
>   {
>       SDState *card = get_card(sdbus);
> -    uint8_t *data = buf;
>   
>       if (card) {
>           SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
> -        for (size_t i = 0; i < length; i++) {
> -            data[i] = sc->read_byte(card);
> -            trace_sdbus_read(sdbus_name(sdbus), data[i]);
> +        while (length > 0) {
> +            size_t read = sc->read_data(card, buf, length);
> +

Ditto with trace_sdbus_read().

> +            g_assert(read >= 1);
> +
> +            buf += read;
> +            length -= read;
>           }
>       }
>   }
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 37f6e0702b0bce85915ef727ba1ec05f02f9c32c..135113add29b5ee3cb11d9d535355eba8f6cb3f7 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2638,30 +2638,37 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
>       return false;
>   }
>   
> -static void sd_write_byte(SDState *sd, uint8_t value)
> +static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
>   {
>       unsigned int partition_access;
>       int i;
> +    const uint8_t *value = buf;
>   
>       if (!sd->blk || !blk_is_inserted(sd->blk)) {
> -        return;
> +        return length;
>       }
>   
>       if (sd->state != sd_receivingdata_state) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: not in Receiving-Data state\n", __func__);
> -        return;
> +        return length;
>       }
>   
>       if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
> -        return;
> +        return length;
> +
> +    /*
> +     * Only read one byte at a time. We will be called again with the
> +     * remaining.
> +     */
> +    length = 1;
>   
>       trace_sdcard_write_data(sd->proto->name,
>                               sd->last_cmd_name,
> -                            sd->current_cmd, sd->data_offset, value);
> +                            sd->current_cmd, sd->data_offset, value[0]);

Another qemu_hexdump_line() candidate.

>       switch (sd->current_cmd) {
>       case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
> -        if (sd_generic_write_byte(sd, value)) {
> +        if (sd_generic_write_byte(sd, value[0])) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
>               sd_blk_write(sd, sd->data_start, sd->data_offset);
> @@ -2686,7 +2693,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
>                   }
>               }
>           }
> -        sd->data[sd->data_offset++] = value;
> +        sd->data[sd->data_offset++] = value[0];
>           if (sd->data_offset >= sd->blk_len) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
> @@ -2716,7 +2723,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 26:  /* CMD26:  PROGRAM_CID */
> -        if (sd_generic_write_byte(sd, value)) {
> +        if (sd_generic_write_byte(sd, value[0])) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
>               for (i = 0; i < sizeof(sd->cid); i ++)
> @@ -2734,7 +2741,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 27:  /* CMD27:  PROGRAM_CSD */
> -        if (sd_generic_write_byte(sd, value)) {
> +        if (sd_generic_write_byte(sd, value[0])) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
>               for (i = 0; i < sizeof(sd->csd); i ++)
> @@ -2757,7 +2764,7 @@ static void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 42:  /* CMD42:  LOCK_UNLOCK */
> -        if (sd_generic_write_byte(sd, value)) {
> +        if (sd_generic_write_byte(sd, value[0])) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
>               sd_lock_command(sd);
> @@ -2767,36 +2774,47 @@ static void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 56:  /* CMD56:  GEN_CMD */
> -        sd_generic_write_byte(sd, value);
> +        sd_generic_write_byte(sd, value[0]);
>           break;
>   
>       default:
>           g_assert_not_reached();
>       }
> +
> +    return length;
>   }
>   
> -static uint8_t sd_read_byte(SDState *sd)
> +static size_t sd_read_data(SDState *sd, void *buf, size_t length)
>   {
>       /* TODO: Append CRCs */
>       const uint8_t dummy_byte = 0x00;
>       unsigned int partition_access;
> -    uint8_t ret;
>       uint32_t io_len;
> +    uint8_t *value = buf;
>   
>       if (!sd->blk || !blk_is_inserted(sd->blk)) {
> -        return dummy_byte;
> +        memset(buf, dummy_byte, length);
> +        return length;
>       }
>   
>       if (sd->state != sd_sendingdata_state) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: not in Sending-Data state\n", __func__);
> -        return dummy_byte;
> +        memset(buf, dummy_byte, length);
> +        return length;
>       }
>   
>       if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION)) {
> -        return dummy_byte;
> +        memset(buf, dummy_byte, length);
> +        return length;
>       }
>   
> +    /*
> +     * We will only read one byte at a time. We will be called again with the
> +     * remaining buffer.
> +     */
> +    length = 1;
> +
>       io_len = sd_blk_len(sd);
>   
>       trace_sdcard_read_data(sd->proto->name,

and I suppose we also need to update this trace event to use
qemu_hexdump_line.

The trace events changes can be done as a cleanup patch on top,
so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


