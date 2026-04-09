Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C568CE9DE6A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkpT-0003az-MK; Thu, 09 Apr 2026 04:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wAkpP-0003a9-Cn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 04:33:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wAkpJ-0007LK-UI
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 04:33:28 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso595678a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775723604; x=1776328404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BCfCYkGALZIJEY6dXbEnDgJcOZSiaMpydLKwK5skXeQ=;
 b=MjbEYruSsTkWoM7FSHyNobgDOJyrAiyLQQpFSVnGlrm0fbf1EusAL7RU7fm8c3snWp
 QUPq+JaMS+lTsik3fO3GRcZ9YS7EjfRHXcfVlAUTdxbUEfHe3XwBYWIhtZPYSPZpaqCO
 wGQWwM872bCcbnvtV9nf9m95++9ZFBciH43kxpQBoefWwY27t0MTIDVb7JsYiCthwEt8
 AcloepyMbRG9GIfIWOJiUdMmmPTsyH2K5igkcj+OjB3HeEhZJigHUvwAraaJ1XVykS5T
 nHCfACyAtUaW9JjJY4T9jjLsxUVupgT2Lpb2kGwrH6SVXNbT3EXXqxoFxAgQQY4V8Ctu
 vBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775723604; x=1776328404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BCfCYkGALZIJEY6dXbEnDgJcOZSiaMpydLKwK5skXeQ=;
 b=aj9goKnLA4gHjINaafViU5ct1x8aDiz9UvZjxr7QsDHWRQ8lTrP1k3kaxjE1aPshKi
 pNPKTcecuP0pFlD4Qo6auZJACukbtiVTxOO2vjUz5YeovEYAKX1ZWhvpBpo2XpJqEg+m
 XM+9pVv4JBreGNF43xRqqgz6Yh/JJQA9MfI5llIVrAfQD0BJM35Vk3yh/5I2SPTs0LTV
 M6sejABE0ymTXU4U90yQbX5Nm+hHv7lxP0NDLUqP507t1v+lzh4PFXwJwPHiC017T2J5
 YlerfKNY9NhKXSD1j7NOR3FUyHrguv7+FOD8hHCps9G0oBliQzQNmf2YjzZTv/ni+bNO
 CqgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1RgcU9X1JPSSz0HpQR/c2GWf3Bz5SJubzWRveTW3KyGL97Fc39Zs3y5O8QbDS454f+khVcKW/0RVZ@nongnu.org
X-Gm-Message-State: AOJu0YxEoqU13nw4Sw4IFjZQ1SCzIpQ8sWtUD2DCp2PYartsirbBmrgq
 e0oNCjty6ozOntaCy0ZNgYd6fH3xY0KQaFk5E/7rTmj+9Swj/qg8mzZJDryWuA==
X-Gm-Gg: AeBDieu7YlD14U5rtlSaLSvbAphbu2wdUVvUK6PZX+mlG3frpUQLD0HJ5CEckqQOaIU
 h5BTo44vHXWV75ChrYyrzUctpqSMA/OItjcMuyHHwp+zji2T0lF/eVetuHGKYMT2k06lWnROu7t
 qRtBKYqDt4mfEVdzjljoHFcGi5X/xFHRE2WehmpgmVBT123UcXWpbzIJfqWw/j8p0l9X92Kj9ce
 dzddv2g+HngEd9CNKHKaaOLjOhe4jpUIZFZc2JtaYaxMzza64QyBLlz9oN3kqG5lTfimjB45k/Y
 THFp0jgZcVcpT7HGrTatHIY5kSqE4HlP68fHVgAc3WW20ACiNfhKpTw0sYpLJavyCm/wDpt6kmc
 fqxarslpi4vUT83EO+4Vu53yYHtEBmm2+47gGkn/IzVAoVvWLx5DkgGZUg8pIZLnPHApsG2WxXx
 KrjQOrkjclCQLkXd9vG/Ef8kF65fcbSCS4brAHQFbQgA==
X-Received: by 2002:a17:90b:52c6:b0:35b:e56e:b5a6 with SMTP id
 98e67ed59e1d1-35e357b1faamr2245309a91.1.1775723604416; 
 Thu, 09 Apr 2026 01:33:24 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e34fa9ecdsm2313212a91.4.2026.04.09.01.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 01:33:23 -0700 (PDT)
Message-ID: <80abd884-7d3a-48d0-875d-a95a306de3f6@gmail.com>
Date: Thu, 9 Apr 2026 17:33:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hw/ufs: Add UFS Write Booster Support
Content-Language: ko
To: Jaemyung Lee <ldc.jml@gmail.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jaemyung Lee <jaemyung.lee@samsung.com>
References: <20260409-write_booster-v3-0-dd2f1c0119c8@samsung.com>
 <20260409-write_booster-v3-4-dd2f1c0119c8@samsung.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260409-write_booster-v3-4-dd2f1c0119c8@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1033.google.com
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


On 4/9/2026 2:37 PM, Jaemyung Lee wrote:
> Add UFS Write Booster implementation which follows UFS 4.1 Spec.
>
> Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
> ---
>   hw/ufs/lu.c         |  94 +++++++++++++++
>   hw/ufs/ufs.c        | 333 +++++++++++++++++++++++++++++++++++++++++++++++++---
>   hw/ufs/ufs.h        |  47 ++++++++
>   include/block/ufs.h |  51 ++++++++
>   4 files changed, 510 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index 3f3c9589cee57ae3e77e2f486476d5fcec204d80..993fea8aae8d0b9135f4f1664b6cfa1bc34a9c82 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -58,6 +58,99 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
>                             status, data_segment_length);
>   }
>   
> +#define UFS_GROUP_NUMBER_MASK 0x1F
> +#define UFS_WB_GROUP_NUMBER_DEFAULT 0x00 /* 00000b */
> +#define UFS_WB_GROUP_NUMBER_PINNED 0x18 /* 11000b */
> +static bool ufs_wb_check_write_pinned(UfsHc *u, UfsRequest *req)
> +{
> +    uint8_t cmd = req->req_upiu.sc.cdb[0];
> +    uint8_t group_number = UFS_WB_GROUP_NUMBER_DEFAULT;
> +
> +    if (u->attributes.wb_buffer_partial_flush_mode != UFS_WB_FLUSH_PINNED) {
> +        return false;
> +    }
> +
> +    if (cmd == WRITE_16) {
> +        group_number = req->req_upiu.sc.cdb[14] & UFS_GROUP_NUMBER_MASK;
> +
> +    } else if (cmd == WRITE_10) {
> +        group_number = req->req_upiu.sc.cdb[6] & UFS_GROUP_NUMBER_MASK;
> +    }
> +
> +    return (group_number == UFS_WB_GROUP_NUMBER_PINNED);
> +}
> +
> +#define UFS_WB_TOTAL_WRITTEN_SHIFT 21 /* 10MB */
> +static void ufs_wb_process_write_pinned(UfsHc *u, UfsRequest *req,
> +                                        uint32_t transfered_len)
`req` is unused in `ufs_wb_process_write_pinned()`.
It looks like this helper only needs `UfsHc *u` and `transfered_len`.

The same applies to `ufs_wb_process_write_normal()`.


> +{
> +    UfsWb *wb = &u->wb;
> +    uint64_t remain_bytes, remain_data;
> +    uint32_t total_written;
> +
> +    if (!wb->pinned_curr_bytes) {
> +        return;
> +    }
> +
> +    if (wb->pinned_used_bytes >= wb->pinned_curr_bytes) {
> +        return;
> +    }
> +
> +    remain_bytes = wb->pinned_curr_bytes - wb->pinned_used_bytes;
> +    if (remain_bytes >= transfered_len) {
> +        wb->pinned_total_written_bytes += transfered_len;
> +        wb->pinned_used_bytes += transfered_len;
> +        remain_data = 0;
> +
> +    } else {
> +        wb->pinned_total_written_bytes += remain_bytes;
> +        wb->pinned_used_bytes += remain_bytes;
> +        remain_data = transfered_len - remain_bytes;
> +    }
> +
> +    total_written = wb->pinned_total_written_bytes >> UFS_WB_TOTAL_WRITTEN_SHIFT;
> +    u->attributes.pinned_wb_cumm_written_size = cpu_to_be32(total_written);
> +
> +    remain_bytes = wb->curr_bytes - wb->used_bytes;
> +    wb->used_bytes += MIN(remain_bytes, remain_data);
> +}
> +
> +static void ufs_wb_process_write_normal(UfsHc *u, UfsRequest *req,
> +                                        uint32_t transfered_len)
> +{
> +    UfsWb *wb = &u->wb;
> +    uint64_t curr_bytes, used_bytes, remain_bytes;
> +
> +    if (!wb->curr_bytes) {
> +        return;
> +    }
> +
> +    curr_bytes = wb->curr_bytes - wb->pinned_curr_bytes;
> +    used_bytes = wb->used_bytes - wb->pinned_used_bytes;
> +
> +    if (used_bytes >= curr_bytes) {
> +        return;
> +    }
> +
> +    remain_bytes = curr_bytes - used_bytes;
> +    wb->used_bytes += MIN(remain_bytes, transfered_len);
> +}
> +
> +static void ufs_wb_process_write_req(UfsRequest *req, uint32_t transfered_len)
> +{
> +    UfsHc *u = req->hc;
> +
> +    if (!u->flags.wb_en || !ufs_is_write_req(req)) {
> +        return;
> +    }
> +
> +    if (ufs_wb_check_write_pinned(u, req)) {
> +        ufs_wb_process_write_pinned(u, req, transfered_len);
> +    } else {
> +        ufs_wb_process_write_normal(u, req, transfered_len);
> +    }
> +}
> +
>   static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
>   {
>       UfsRequest *req = scsi_req->hba_private;
> @@ -68,6 +161,7 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
>       ufs_build_scsi_response_upiu(req, scsi_req->sense, scsi_req->sense_len,
>                                    transfered_len, status);
>   
> +    ufs_wb_process_write_req(req, transfered_len);

Please guard `ufs_wb_process_write_req()` with `status == GOOD`. WB 
accounting should only happen for successful writes.

>       ufs_complete_req(req, UFS_REQUEST_SUCCESS);
>   
>       scsi_req->hba_private = NULL;
>

