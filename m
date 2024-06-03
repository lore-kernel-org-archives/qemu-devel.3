Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC3BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBhX-0000m3-CL; Mon, 03 Jun 2024 13:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEBhQ-0000ka-FA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:42:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEBhN-0003ti-Rs
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:42:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a68c8b90c85so248935866b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717436539; x=1718041339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0yUodIpQXH79Sdxh5ICQjlD3Cg+bsodUH2Y8XUimSH8=;
 b=CfpxUsAottAq3NX1pHhcofrI99ENrln9R5vpbUVX+zazjnP8xEq929i/b3fKcVHtf2
 wDnjawIuwWhBd9Ns9C6vvdlC6X2lxtokFJQZWsnl2lczNfQRiH1d6o5jnzSedfqFHG9L
 RxHuAZ55OAgkyQsvxcxjleh/RXsDjp1HsqCyY9JtMmBfvBcf7DZ0I7EIbi84yfaHP5PP
 z7XmHYdq11MeCjTapSb94QmLEHxhikNUsSEdXk85qgzmUwePmi0YRlPebT7gaFegHkL/
 +Amnl7ytbE7vZYr6RcNhXwvEBCZqfd1W72FQKUUXXYOw3P3BuEwRuJOoDG29ndfj5Hcf
 iGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436539; x=1718041339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0yUodIpQXH79Sdxh5ICQjlD3Cg+bsodUH2Y8XUimSH8=;
 b=YXbBeMFT9gmcb7F2Y93DXlcG4rfvF9o5BPUlZKOiRMl/nqGyLWqfhVF9sBnhTmwza3
 UkRn+EWWsbeWOEDUO0TiPSyhQ3wz7RxnF1xQ8yZBjiuBFKpTOCVY8m4phrX/Pgt3TknI
 plniWVXEb394szFwp8bZdcwbstnZ+dg/dYRFR2l8aiEQTZ44VK4/LDvu9V9hYFLQnYqo
 FWvhtEEamQ26jjn4nJBq3UEqwloVeIAbVTvcaytaCMsQek2+BP80IFO1Dn4r2uZ4EFNe
 ksxn0+KHk3PTQGvpM7uTCHfxNFY/r7XOuHCNRhGvqQ+gl2/GKZKF+ckYeNS+nOfgbAZZ
 uRag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOHeCRwDa9gznkp5T7vCJjrjzCmRYaannwRHfifoItyN5LAoPu/Vct+o/dX7zKndb8hIBKVsPiqQ8PoEY0xOa455xLH+A=
X-Gm-Message-State: AOJu0YxzIKqxdq/fD5RzzhuYzmKn304P9x6rLZZLt/kbXZA9+TiTwQ1U
 B98jCz9BGtpeon0KBcxG3uwXDN8RhzwlAAB9Oz8OQ1K4FLRWBf1ZqydIVrRmbME=
X-Google-Smtp-Source: AGHT+IF+XxgwoSpBKdJnVecqtsDzJ+MS/5rxV41Lgl5WPZmL9uopHVal7NhjD1/SYL2FvUGDNkmE8A==
X-Received: by 2002:a17:906:8902:b0:a62:b36a:eafa with SMTP id
 a640c23a62f3a-a6821d62a7amr692074066b.57.1717436539078; 
 Mon, 03 Jun 2024 10:42:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f4191cfdsm263113066b.137.2024.06.03.10.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 10:42:18 -0700 (PDT)
Message-ID: <cff2db06-0c63-4084-a9d1-631a3b578b71@linaro.org>
Date: Mon, 3 Jun 2024 19:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/27] util/hexdump: Remove ascii parameter from
 qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/4/24 09:33, Richard Henderson wrote:
> Split out asciidump_line as a separate function, local to hexdump.c,
> for use by qemu_hexdump.  Use "%-*s" to generate the alignment
> between the hex and the ascii, rather than explicit spaces.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/cutils.h  |  3 +--
>   hw/virtio/vhost-vdpa.c |  2 +-
>   util/hexdump.c         | 54 ++++++++++++++++++++++++------------------
>   3 files changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 3415f5d249..d0c5386e6c 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -257,8 +257,7 @@ int parse_debug_env(const char *name, int max, int initial);
>    */
>   #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
>   #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
> -void qemu_hexdump_line(char *line, const void *bufptr,
> -                       unsigned int len, bool ascii);
> +void qemu_hexdump_line(char *line, const void *bufptr, size_t len);
>   
>   /*
>    * Hexdump a buffer to a file. An optional string prefix is added to every line
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index b4afa142f6..32bad5ce68 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -946,7 +946,7 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
>   
>       for (b = 0; b < config_len; b += 16) {
>           len = config_len - b;
> -        qemu_hexdump_line(line, config + b, len, false);
> +        qemu_hexdump_line(line, config + b, len);
>           trace_vhost_vdpa_dump_config(dev, b, line);
>       }
>   }
> diff --git a/util/hexdump.c b/util/hexdump.c
> index 7324e7b126..dbc536fe84 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -16,8 +16,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
>   
> -void qemu_hexdump_line(char *line, const void *bufptr,
> -                       unsigned int len, bool ascii)
> +void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
>   {
>       const char *buf = bufptr;
>       int i, c;

'c' ...

> @@ -26,39 +25,48 @@ void qemu_hexdump_line(char *line, const void *bufptr,
>           len = QEMU_HEXDUMP_LINE_BYTES;
>       }
>   
> -    for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
> +    for (i = 0; i < len; i++) {
>           if (i != 0 && (i % 4) == 0) {
>               *line++ = ' ';
>           }
> -        if (i < len) {
> -            line += sprintf(line, " %02x", (unsigned char)buf[i]);
> -        } else {
> -            line += sprintf(line, "   ");
> -        }
> -    }
> -    if (ascii) {
> -        *line++ = ' ';
> -        for (i = 0; i < len; i++) {
> -            c = buf[i];
> -            if (c < ' ' || c > '~') {
> -                c = '.';
> -            }
> -            *line++ = c;

... is no more used;

> -        }
> +        line += sprintf(line, " %02x", (unsigned char)buf[i]);
>       }
>       *line = '\0';
>   }
>   
> +static void asciidump_line(char *line, const void *bufptr, size_t len)
> +{
> +    const char *buf = bufptr;
> +
> +    for (size_t i = 0; i < len; i++) {
> +        char c = buf[i];
> +
> +        if (c < ' ' || c > '~') {
> +            c = '.';
> +        }
> +        *line++ = c;
> +    }
> +    *line = '\0';
> +}
> +
> +#define QEMU_HEXDUMP_LINE_WIDTH \
> +    (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
> +
>   void qemu_hexdump(FILE *fp, const char *prefix,
>                     const void *bufptr, size_t size)
>   {
> -    unsigned int b, len;
>       char line[QEMU_HEXDUMP_LINE_LEN];
> +    char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
> +    size_t b, len;
>   
> -    for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
> -        len = size - b;
> -        qemu_hexdump_line(line, bufptr + b, len, true);
> -        fprintf(fp, "%s: %04x: %s\n", prefix, b, line);
> +    for (b = 0; b < size; b += len) {
> +        len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
> +
> +        qemu_hexdump_line(line, bufptr + b, len);
> +        asciidump_line(ascii, bufptr + b, len);
> +
> +        fprintf(fp, "%s: %04x: %-*s %s\n",

'b' is size_t.

> +                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
>       }
>   
>   }

Queued squashing:

-- >8 --
diff --git a/util/hexdump.c b/util/hexdump.c
index dbc536fe84..0f943e31e5 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -19,7 +19,7 @@
  void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
  {
      const char *buf = bufptr;
-    int i, c;
+    int i;

      if (len > QEMU_HEXDUMP_LINE_BYTES) {
          len = QEMU_HEXDUMP_LINE_BYTES;
@@ -65,7 +65,7 @@ void qemu_hexdump(FILE *fp, const char *prefix,
          qemu_hexdump_line(line, bufptr + b, len);
          asciidump_line(ascii, bufptr + b, len);

-        fprintf(fp, "%s: %04x: %-*s %s\n",
+        fprintf(fp, "%s: %04zx: %-*s %s\n",
                  prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
      }

---

