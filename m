Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5CBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKtg-0005sq-9D; Fri, 12 Apr 2024 13:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKte-0005sg-R6
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:41:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKtc-0005vB-Lj
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:41:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4180c6a1003so3754195e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943661; x=1713548461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXByJc41ZVOtFp6wJBZNyFlzsgpdQrDT8X9F/CDiOG8=;
 b=HGbLlSn/quNL2y1GCYIFkXzab3cHm0DccW3HYlCo0hhIbg4NDFvh+SYjI1C9KPd20l
 IOzlpMfLG0uuAiB7u3hdlROrG/idyQ87dQ9dojYrUAudSF4ozxOx+/1egzPoanRpfeHx
 q+7jG9dxr+/UZ3uW0ElTClilQqaL1vqJet1smbp00B97R8/PiVZ6fK0rFZOHtefzRROo
 54yq6fvcNm7avVUgzUb9nquWa3mjQKthtvENnqMn9jNll6foG/7Kwe8FerLmqnDEsZMl
 J326GGhcsfFL5611cMuHHn9tOpUgde6wAdQcA0uw8b8vgDYjIbgYkKW68TlPfK+W0q3H
 DoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943661; x=1713548461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FXByJc41ZVOtFp6wJBZNyFlzsgpdQrDT8X9F/CDiOG8=;
 b=eFH43iFnPQZ5W94+nEGWJ+AcjSR2bp+ZdeSWzC/Qj3SMe0IekcDyLtH/PFU946EZyw
 IMWmiQPIgMN8EPFKaslGK17SOsrepIuL8WKSMsaxXVDX/RrMfMLcQtKqvaY50CepNWLU
 x2Cyl2JbB/asUbCMbFRyPDflPAxAMvtdmbbIJ2Onny32GyipA0YJ3emF8NUTP3y/vMBR
 zDPZQpr1im/KzuWE98bKAMkgFDafYfrBnsoYkrnk4Zb1RGy+YeFPK0a1p5hU9LGq6Ye9
 LCogvrvn+SxiWsc2RdyywOKa6Yl3SOyKJqOXjg9WLZqV0k9GrRMz2dWsJch5gB6S/L8g
 R+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSmd/OofJFYpO2KHa0A1F7a5K5idOujf9W29Fnoqp9nSQ0kvE5krW4aom5bNvVLSXhggEigKN9J7zl/x3lwTfkHvdW+do=
X-Gm-Message-State: AOJu0YxJTSFIH/QFlA5Lmv3ULXrbzw+vZ++vFMSqNCJUP+OFL1LtWW4N
 rtk5KY2wIJ2MVqX78dz34Bsbs2FK/8KBlrPFlB9qSkviRQz+bZ56suCxxIc6cz2wz3okwAOECyz
 9
X-Google-Smtp-Source: AGHT+IH1GTalK0dwihu3nBicNMXAtJYHDiuYYme7omaMKGSIn9J8Kx3DlgpM+t3/9sa0MuQ0iHErtQ==
X-Received: by 2002:a05:600c:4f4b:b0:418:16c3:499 with SMTP id
 m11-20020a05600c4f4b00b0041816c30499mr442224wmq.37.1712943661592; 
 Fri, 12 Apr 2024 10:41:01 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 n42-20020a05600c502a00b00417fa8ca4d9sm2973880wmr.42.2024.04.12.10.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:41:01 -0700 (PDT)
Message-ID: <698cc16f-cfb4-47a8-86fe-e4c8a6faecb6@linaro.org>
Date: Fri, 12 Apr 2024 19:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/27] util/hexdump: Use a GString for qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
> Allocate a new, or append to an existing GString instead of
> using a fixed sized buffer.  Require the caller to determine
> the length of the line -- do not bound len here.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/cutils.h  | 15 ++++++++++-----
>   hw/virtio/vhost-vdpa.c | 14 ++++++++------
>   util/hexdump.c         | 29 +++++++++++++++++------------
>   3 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d0c5386e6c..7311fb36ca 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -252,12 +252,17 @@ static inline const char *yes_no(bool b)
>    */
>   int parse_debug_env(const char *name, int max, int initial);
>   
> -/*
> - * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
> +/**
> + * qemu_hexdump_line:
> + * @str: GString into which to append
> + * @buf: buffer to dump
> + * @len: number of bytes to dump
> + *
> + * Append @len bytes of @buf as hexadecimal into @str.
> + * If @str is NULL, allocate a new string and return it;
> + * otherwise return @str.
>    */
> -#define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
> -#define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
> -void qemu_hexdump_line(char *line, const void *bufptr, size_t len);
> +GString *qemu_hexdump_line(GString *str, const void *buf, size_t len);


> diff --git a/util/hexdump.c b/util/hexdump.c
> index dbc536fe84..521e346bc6 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -16,22 +16,25 @@
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
>   
> -void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
> +GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len)
>   {
> -    const char *buf = bufptr;
> -    int i, c;
> +    const uint8_t *buf = vbuf;
> +    size_t i;
>   
> -    if (len > QEMU_HEXDUMP_LINE_BYTES) {
> -        len = QEMU_HEXDUMP_LINE_BYTES;
> +    if (str == NULL) {
> +        /* Estimate the length of the output to avoid reallocs. */
> +        i = len * 3 + len / 4;
> +        str = g_string_sized_new(i + 1);
>       }

[*]
          else {
            g_string_truncate(str, 0);
          }

>   
>       for (i = 0; i < len; i++) {
>           if (i != 0 && (i % 4) == 0) {
> -            *line++ = ' ';
> +            g_string_append_c(str, ' ');
>           }
> -        line += sprintf(line, " %02x", (unsigned char)buf[i]);
> +        g_string_append_printf(str, " %02x", buf[i]);
>       }
> -    *line = '\0';
> +
> +    return str;
>   }
>   
>   static void asciidump_line(char *line, const void *bufptr, size_t len)
> @@ -49,24 +52,26 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
>       *line = '\0';
>   }
>   
> +#define QEMU_HEXDUMP_LINE_BYTES 16
>   #define QEMU_HEXDUMP_LINE_WIDTH \
>       (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
>   
>   void qemu_hexdump(FILE *fp, const char *prefix,
>                     const void *bufptr, size_t size)
>   {
> -    char line[QEMU_HEXDUMP_LINE_LEN];
> +    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
>       char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
>       size_t b, len;
>   
>       for (b = 0; b < size; b += len) {
>           len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
>   
> -        qemu_hexdump_line(line, bufptr + b, len);
> +        g_string_truncate(str, 0);

Shouldn't we truncate in [*] ?

> +        qemu_hexdump_line(str, bufptr + b, len);
>           asciidump_line(ascii, bufptr + b, len);
>   
> -        fprintf(fp, "%s: %04x: %-*s %s\n",
> -                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
> +        fprintf(fp, "%s: %04zx: %-*s %s\n",
> +                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, str->str, ascii);
>       }
>   
>   }


