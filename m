Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44715D3E772
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Qwt-00009x-Oi; Tue, 05 Nov 2024 16:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qwp-00009L-AL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:18:49 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qwn-000873-PR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:18:47 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e29267b4dc4so4953273276.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730841524; x=1731446324; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tEdrMlvscGRAELTFBlq9FDu6pV5+7du0Bd+t/STrdCg=;
 b=mZHPfsr6e80afAjD7Mx5p22SmAapdRpf5hjdRNw82Ki79QfH3RhmW7/DTZe00B+tsj
 jVs7inz9dDXDQMGkIIq5jYwuIALil85nUDYzDl03rxcrFTpfNHi2AjmqDZ+2+g+AwyJa
 Y16Rh8NLYdSPKO5ZQehZcam29XkEaS7qRSNdThnnOXlkHBCjudkoBFiW6wR+EiDbDTY1
 LadunyC5uZGo21K8/hd57iBiHh5jqBhtY2Wz1IKmIFbp8jEcc2YFBvXHtJaLBC0FPPks
 OXNDHKJ4bKeQQubyBcGxYbrUaCsjhUB+nL2/UdP+i/8LOOP4Ev4ra/WKZmKBujSy2bHw
 Au2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730841524; x=1731446324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEdrMlvscGRAELTFBlq9FDu6pV5+7du0Bd+t/STrdCg=;
 b=qaVQhEmuqFVkFFxt2BtGFNhYIyWkPvR6Q/93Q5WWvsOAB8+20verGb8Kzq2Z242+wR
 +xlNtiwRCJO4cieQ3fzQURJKkgosJB9noVDo0QTvuyE3jnlVTqkqSwZ6vqUvNlLFjhPy
 Hs8xZrAZe9rWdG5hQwr//D7wwAWwWSs+C4R1UrZMfzmDpeCxfB+M8KJHF3L2hHijlJ+P
 rkFrsrMDOtZe7G9ejYS3eqJrXBLjeuSZv/JT5q8LJGzIg/3H0Fot+PTLQAvb+VOvYJNJ
 87TsV+nWGsVdHs/uuRD2MjSsgbDUN+35SIU5RqykfjkUYErA7wK3cN49GwGsuZDkiP1y
 lm6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFqun5RUnPtp4adfmXkRnBnK8DrLY+DQ1GhSeSFis03Vvw+KNuTxbixSSTbNxyFNz/MgDjzrTYLVal@nongnu.org
X-Gm-Message-State: AOJu0YzRkvPeW8utHcPGzAHRA1PVP45JQOFOmv9D6Qkv8jr0lJzKaU0z
 wtdDRXr/Dn6bH+fu0HocTXrqQMJP4rz45dvlnrs4E7+HibPUoT78
X-Google-Smtp-Source: AGHT+IHfZcpEmqQofUMS9b6VJaypOwQchI4XxAVqs2DUyEbtqcHs7YBBVy7fOL7cI65GETtJFgk0LA==
X-Received: by 2002:a05:6902:2509:b0:e30:e6cb:26a1 with SMTP id
 3f1490d57ef6-e3302568b80mr14357745276.16.1730841524222; 
 Tue, 05 Nov 2024 13:18:44 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e30e8acda8fsm2717068276.46.2024.11.05.13.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:18:43 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:18:42 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 06/10] hw/cxl: Avoid accesses beyond the end of
 cel_log.
Message-ID: <ZyqLsvEhS80kQabs@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-7-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-7-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb29.google.com
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

On Fri, Nov 01, 2024 at 01:39:13PM +0000, Jonathan Cameron wrote:
> Add a check that the requested offset + length does not go beyond the end
> of the cel_log.
> 
> Whilst the cci->cel_log is large enough to include all possible CEL
> entries, the guest might still ask for entries beyond the end of it.
> Move the comment to this new check rather than before the check on the
> type of log requested.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2aa7ffed84..5e571955b6 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -937,24 +937,28 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>  
>      get_log = (void *)payload_in;
>  
> +    if (get_log->length > cci->payload_max) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
>      /*
>       * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
>       *   The device shall return Invalid Input if the Offset or Length
>       *   fields attempt to access beyond the size of the log as reported by Get
> -     *   Supported Logs.
> +     *   Supported Log.
>       *
> -     * The CEL buffer is large enough to fit all commands in the emulation, so
> -     * the only possible failure would be if the mailbox itself isn't big
> -     * enough.
> +     * Only valid for there to be one entry per opcode, but the length + offset
> +     * may still be greater than that if the inputs are not valid and so access
> +     * beyond the end of cci->cel_log.
>       */
> -    if (get_log->length > cci->payload_max) {
> +    if ((uint64_t)get_log->offset + get_log->length >= sizeof(cci->cel_log)) {
>          return CXL_MBOX_INVALID_INPUT;

Oh. This patch actually addresses my concern in the previous patch.
Maybe we can combine the changes in this patch and the previous one
together. Other than that 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>      }
>  
> -    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> -        return CXL_MBOX_INVALID_LOG;
> -    }
> -
>      /* Store off everything to local variables so we can wipe out the payload */
>      *len_out = get_log->length;
>  
> -- 
> 2.43.0
> 

-- 
Fan Ni

