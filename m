Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6048CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1KO-0005iI-Ra; Thu, 11 Apr 2024 16:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1KM-0005hH-QB
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:47:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1KI-0004dt-81
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:47:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so178976b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712868436; x=1713473236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+M45onNHGQcvvgN8G4lgCvuExfwR1VsOeMySRdzxe4U=;
 b=px6fC3zc1jOPLwdU0gvC7z6RxELV9DloEwy42OCxlOXnjGpDtCxkoAcTAqXAiaVh5G
 qzFqYjK0oSj50bFnhgL/wHS2OgIqSsarniCf2v9FEVY6GBs6CwJVpaMLGgoGUqazoS8i
 HtnK69vsfEAW788FLnrHL4pzUduR57PqaJ+6Vv6kkgmNy099LeX4RhSmK4eyi8Us7zGt
 7YsNqMpfCIWOyAV3r+mwRoujXWsaZcptlp3KYCzgAsCK03mNJH8I/t2VqnNUUH9NVWap
 kx1H7tm/8NheTGYbetBarJZ9sDN2zXKJH+46egbiJYNPSFiBYspJiEKg4xxsxfoRVI7n
 Kg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712868436; x=1713473236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+M45onNHGQcvvgN8G4lgCvuExfwR1VsOeMySRdzxe4U=;
 b=U+7bjSWSlr4fMHU8lMarKTjmvl5AnLKf2Zj8xduCv6vZOyIt4ddyFrxjCIfSIzOGMt
 /RwxshYAjEH7o5xjdU6H0sGzZkjw/603U2TzkP3cvvisfUwf22vvlO0I4OMwuXZTXsO1
 7DKaox5YUEQvEPHJCPu8/FBgPppF5iOsv7r+PMMGd6OddlH/s2IdI70fiTx5QsKrhhuT
 Y/WON6w/ut8Dcc3V2uHf5vIxrndElDUy0dJCQ+0jEQwm4+lwIa3LNoM+CzhpUo0JBUE5
 RwHf9pZppZkPp/axz3RTV0M/a68Kt5wXTCEMVUCz5aFABvvv5p1HPKZagk2zBIg2kM5o
 8OuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkbTSM8tg0w3PgmI/Yc9JDxFcLs1AhFZrtfK+oxoC8y1FGb2GOjSGKMWmdVUSghjZiwPgbTWuloE3gqRMz1VR/bj0yjwU=
X-Gm-Message-State: AOJu0YxiCBUL6mQO7znKcyKeOxphbrxw8BQk7DR3VQ/cBEpR16f9R+2D
 FF16eDpeQOchzAkeM71QROUCNzA6GzPqZUKCWZY9eW9shrfePXU6bEgnh77dt9w=
X-Google-Smtp-Source: AGHT+IEyj6Uq5RUWfmMbZo5xTvsJbpwsEzMKxyxjkMSxBh4ypHj+FLCRPLe1GnCaflIlSHP8ibvcyA==
X-Received: by 2002:a05:6a00:3904:b0:6ed:e1c:1038 with SMTP id
 fh4-20020a056a00390400b006ed0e1c1038mr940224pfb.7.1712868435629; 
 Thu, 11 Apr 2024 13:47:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056a00198400b006ed59172d2fsm1587712pfl.87.2024.04.11.13.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:47:15 -0700 (PDT)
Message-ID: <0a396055-1d20-423d-8635-72289b583982@linaro.org>
Date: Thu, 11 Apr 2024 13:47:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] util/hexdump: Have qemu_hexdump_line() return
 heap allocated buffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/cutils.h  | 10 +++++++---
>   hw/virtio/vhost-vdpa.c |  5 +++--
>   util/hexdump.c         | 12 ++++++++----
>   3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 70ca4b876b..e8d6b86098 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -254,18 +254,22 @@ int parse_debug_env(const char *name, int max, int initial);
>   
>   /**
>    * qemu_hexdump_line:
> - * @line: Buffer to be filled by the hexadecimal/ASCII dump
>    * @bufptr: Buffer to dump
>    * @offset: Offset within @bufptr to start the dump
>    * @len: Length of the bytes do dump
>    * @ascii: Replace non-ASCII characters by the dot symbol
>    *
>    * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
> + *
> + * The caller must use g_free() to free the returned data when it is
> + * no longer required.
> + *
> + * Returns: Hexadecimal/ASCII dump
>    */
>   #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
>   #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
> -void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
> -                       unsigned int len, bool ascii);
> +char *qemu_hexdump_line(const void *bufptr, unsigned offset,
> +                        unsigned int len, bool ascii);
>   
>   /*
>    * Hexdump a buffer to a file. An optional string prefix is added to every line
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index cf7cfa3f16..e61af86d9d 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -942,12 +942,13 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
>                                      uint32_t config_len)
>   {
>       int ofs, len;
> -    char line[QEMU_HEXDUMP_LINE_LEN];
> +    char *line;
>   
>       for (ofs = 0; ofs < config_len; ofs += 16) {
>           len = config_len - ofs;
> -        qemu_hexdump_line(line, config, ofs, len, false);
> +        line = qemu_hexdump_line(config, ofs, len, false);
>           trace_vhost_vdpa_dump_config(dev, line);
> +        g_free(line);
>       }
>   }
>   
> diff --git a/util/hexdump.c b/util/hexdump.c
> index 469083d8c0..b6f70e93bb 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -16,9 +16,10 @@
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
>   
> -void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
> -                       unsigned int len, bool ascii)
> +char *qemu_hexdump_line(const void *bufptr, unsigned offset,
> +                        unsigned int len, bool ascii)
>   {
> +    char linebuf[QEMU_HEXDUMP_LINE_BYTES], *line = linebuf;
>       const char *buf = bufptr;
>       int i, c;
>   
> @@ -48,18 +49,21 @@ void qemu_hexdump_line(char *line, const void *bufptr, unsigned offset,
>           }
>       }
>       *line = '\0';
> +
> +    return g_strdup(linebuf);
>   }
>   
>   void qemu_hexdump(FILE *fp, const char *prefix,
>                     const void *bufptr, size_t size)
>   {
>       unsigned int ofs, len;
> -    char line[QEMU_HEXDUMP_LINE_LEN];
> +    char *line;
>   
>       for (ofs = 0; ofs < size; ofs += QEMU_HEXDUMP_LINE_BYTES) {
>           len = size - ofs;
> -        qemu_hexdump_line(line, bufptr, ofs, len, true);
> +        line = qemu_hexdump_line(bufptr, ofs, len, true);
>           fprintf(fp, "%s: %s\n", prefix, line);
> +        g_free(line);
>       }
>   
>   }

Not especially efficient, re-allocating for each line.

How about

GString *qemu_hexdump_line(GString *str, buf, offset, len, ascii)
{
     if (str) {
         g_string_truncate(str, 0);
     } else {
         str = g_string_sized_new(QEMU_HEXDUMP_LINE_LEN);
     }
     ...
     return str;
}

void qemu_hexdump(FILE *fp, ...)
{
     g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_LEN);

     for (...) {
         qemu_hexdump_line(str, ...);
         fprintf(fp, "%s: %s\n", prefix, str->str);
     }
}

So that we reuse the one allocation across the whole loop.

r~

