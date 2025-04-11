Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29580C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Xr-0003Xs-IX; Fri, 11 Apr 2025 04:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u39Xn-0003Wo-Me
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u39Xl-00067v-P4
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744359319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppY5B33YQyTZ3crV5ByVN+th4ULX6sffmn9o2mo9Lhs=;
 b=V5vRP0drJ2psdoNUL44bfQvBLV/6Gmn8IqLBd+2GNwteulVnrIiTH+DQPXAVOGNuIt4vd+
 EQXVQTk5p6N6M9maYRDeF1GjBKr0w/8GuCvwuHrOgVbgvICtRidg/PDXb4XyUUtD8fDIbb
 keUO8FhMOkTo0ewM+KeL9budJ8RMbs8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-xoQCcM0NMzuVdb0mM2RDtw-1; Fri, 11 Apr 2025 04:15:17 -0400
X-MC-Unique: xoQCcM0NMzuVdb0mM2RDtw-1
X-Mimecast-MFC-AGG-ID: xoQCcM0NMzuVdb0mM2RDtw_1744359316
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c184b20a2so855765f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744359316; x=1744964116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppY5B33YQyTZ3crV5ByVN+th4ULX6sffmn9o2mo9Lhs=;
 b=Ecznk2vXqUX5Nv6iljO41YPFi/NuhDkniti/+sV2xIUttrddV1TVSN+znd3pM6W9iE
 xo+Ol10sjg36BzMHTTbpTpTTKLUdvjIKszBJc8uKfwwZMEC6ZBFldr2Xw9VY82INYPJT
 AvDoOkONYObY7m0uTVfbm8Tk5yeZbliDeN7Q6av1Ftwb3oJ9mK2N3be5keds1HrNB7+d
 bMEjwoi4+b0u3YgMi+CJ3jy1+R/mN2yIisUICiGbTRvzlBQUqQtSI2a2VJxzo2BAaPJX
 P9vpLJc1yOhwaghXRumlNVqQtcPm/tQlWH1NvkjafkDVuGUJCWTUHGy2ne01qM8IyJFW
 PKfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvX19Lm+WS7aO77rsXSml8e6g7S8uRdm+B+1DfWlmRtZ5fThXw6npW+8S2+NCd4sc6351OZfeVnz9T@nongnu.org
X-Gm-Message-State: AOJu0YwZ6xHLClC6pD0Koru9lP2vY7gJvcqeLunA6sS7HFTilTbX9I2y
 aY2Ra34iP0jpDzSVhu54wuzljA+mj9x03bSM71NWUC36cX/3aAjda/D19gbm91+Hw6s94/B4gZa
 lG332fmuJKx6zlP78TRngMtXBVK39CSSaOxGNaIqLOAjAwJtarhc3
X-Gm-Gg: ASbGnct3ZRYBsMZ5xFBYlPogHiRH1l72AA1mgnVmCALIV6JU4wImy3mo1fRkwct8Fnv
 73hoPy6SVDcxCgfudbW06DJylVKare6mQ4UyVHQe98WHGJzhsVoiBl6EiTANIzyy7oCM+txC3y+
 DoTHnHmzmsO1fDnRNat3Hhc3pT/QzLcBrk/sjhtIvYAT0YNSGx5Xl9NKeIg0LRREzKEQTVGxWwO
 77zGKV8jkXZiDLqOP4w8hpKWy7WeK+XRaiGQ5Aq5JQn7De3RzhOu7ik/m2VKodUC6eyr+vRCH60
 C/XoAqR6r9ghQ19XAKn/Q7v1Zq5j82MYxpc7DqCbWFI/HjtO3qX8gDdMH6jonaa+0xUfyE9vY/8
 fsgHeGQ99MCQx02JscSljJZvK4GsvRMyJyNfAUgnX
X-Received: by 2002:a05:6000:2905:b0:39c:2665:2ce7 with SMTP id
 ffacd0b85a97d-39eaaecd56amr1359847f8f.53.1744359315720; 
 Fri, 11 Apr 2025 01:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj9IJxykzS3JicIhzf1PuxHHEEOAtn/xsjwt3R4XHhTzQJ4HwjRcFtiKRXaj0pg9EgKQSbLQ==
X-Received: by 2002:a05:6000:2905:b0:39c:2665:2ce7 with SMTP id
 ffacd0b85a97d-39eaaecd56amr1359813f8f.53.1744359315264; 
 Fri, 11 Apr 2025 01:15:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d732:e4be:15e6:ccc0:870d:ec27?
 (p200300cfd732e4be15e6ccc0870dec27.dip0.t-ipconnect.de.
 [2003:cf:d732:e4be:15e6:ccc0:870d:ec27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977fc8sm1254134f8f.48.2025.04.11.01.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 01:15:14 -0700 (PDT)
Message-ID: <c7b9ddb4-10de-4c66-9f2f-c964d77275e0@redhat.com>
Date: Fri, 11 Apr 2025 10:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] file-posix: probe discard alignment on Linux block
 devices
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
References: <20250410184103.23385-1-stefanha@redhat.com>
 <20250410184103.23385-2-stefanha@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250410184103.23385-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.04.25 20:41, Stefan Hajnoczi wrote:
> Populate the pdiscard_alignment block limit so the block layer is able
> align discard requests correctly.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/file-posix.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)

Ah, I didn’t know sysfs is actually fair game.  Should we not also get 
the maximum discard length then, too?

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..2a1e1f48c0 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1276,10 +1276,10 @@ static int get_sysfs_zoned_model(struct stat *st, BlockZoneModel *zoned)
>   }
>   #endif /* defined(CONFIG_BLKZONED) */
>   
> +#ifdef CONFIG_LINUX
>   /*
>    * Get a sysfs attribute value as a long integer.
>    */
> -#ifdef CONFIG_LINUX
>   static long get_sysfs_long_val(struct stat *st, const char *attribute)
>   {
>       g_autofree char *str = NULL;
> @@ -1299,6 +1299,30 @@ static long get_sysfs_long_val(struct stat *st, const char *attribute)
>       }
>       return ret;
>   }
> +
> +/*
> + * Get a sysfs attribute value as a uint32_t.
> + */
> +static int get_sysfs_u32_val(struct stat *st, const char *attribute,
> +                             uint32_t *u32)
> +{
> +    g_autofree char *str = NULL;
> +    const char *end;
> +    unsigned int val;
> +    int ret;
> +
> +    ret = get_sysfs_str_val(st, attribute, &str);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* The file is ended with '\n', pass 'end' to accept that. */
> +    ret = qemu_strtoui(str, &end, 10, &val);
> +    if (ret == 0 && end && *end == '\0') {
> +        *u32 = val;
> +    }
> +    return ret;
> +}
>   #endif
>   
>   static int hdev_get_max_segments(int fd, struct stat *st)
> @@ -1318,6 +1342,23 @@ static int hdev_get_max_segments(int fd, struct stat *st)
>   #endif
>   }
>   
> +/*
> + * Fills in *dalign with the discard alignment and returns 0 on success,
> + * -errno otherwise.
> + */
> +static int hdev_get_pdiscard_alignment(struct stat *st, uint32_t *dalign)
> +{
> +#ifdef CONFIG_LINUX
> +    /*
> +     * Note that Linux "discard_granularity" is QEMU "discard_alignment". Linux
> +     * "discard_alignment" is something else.
> +     */
> +    return get_sysfs_u32_val(st, "discard_granularity", dalign);
> +#else
> +    return -ENOTSUP;
> +#endif
> +}
> +
>   #if defined(CONFIG_BLKZONED)
>   /*
>    * If the reset_all flag is true, then the wps of zone whose state is
> @@ -1527,6 +1568,19 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>           }
>       }
>   
> +    if (S_ISBLK(st.st_mode)) {
> +        uint32_t dalign = 0;
> +        int ret;
> +
> +        ret = hdev_get_pdiscard_alignment(&st, &dalign);
> +        if (ret == 0) {
> +            /* Must be a multiple of request_alignment */
> +            assert(dalign % bs->bl.request_alignment == 0);

Is it fair to crash qemu if the kernel reports a value that is not a 
multiple of request_alignment?  Wouldn’t it make more sense to take the 
maximum, and if that still isn’t a multiple, return an error here?

Hanna

> +
> +            bs->bl.pdiscard_alignment = dalign;
> +        }
> +    }
> +
>       raw_refresh_zoned_limits(bs, &st, errp);
>   }
>   


