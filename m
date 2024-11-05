Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9BD31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nsm-0005Fg-Mc; Tue, 05 Nov 2024 13:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Nsk-0005Dz-AM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:02:22 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Nsh-00047j-SN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:02:22 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e5ffbc6acbso3086026b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730829736; x=1731434536; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gtHAX6e1gVp4XzhgXtLPhaxyRzN6pXwJugKNF4diKms=;
 b=T2cMojiIJARH27rLw/xwTIxKuU6NiRKkTtdBkM/pGsoLxOqBXyHr7VQvWVVVbZx55U
 Gy1OtOV4AA5AH4LQdY3EmPfCoo5AV+loqE4qC7WTxZRdEGtIwOtN7NR9ZPZaIfT5LQo1
 3lHIEgdtHpkVcztNrTWGQE78H8B77IPPpLQDhewfJhA5/pc39E9B/2NUamOJcXrAfu1d
 2YP5Nxdcx63SI59UaA4epSy+QV0tQ+PNsoypsz3h63R2R9somg03WmDc7RpZ6pwgdV4O
 fsKgpInDkslM/1QBTfqB5x56OlrW8ildugiVq/WPUh2SJOKwyZh7DT19jzg03gq+zl3R
 CfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730829736; x=1731434536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtHAX6e1gVp4XzhgXtLPhaxyRzN6pXwJugKNF4diKms=;
 b=jiPZLt6Zmj0Qi9+ypcXzvOJvl6L/vSOO/xEmeW2H9PTCC3KI2uxBB8m2xLJzZGmWbI
 OIWykX7R8C2sXyz5zzGtv0ayW8CJiexq6WpJG/mx+SjY7e7z7uP11ui3N5+E9wbtydUV
 JHYOsbT4FePrvRKWmtLMdrdepmA72ts3R6onOOSDRzKOpQJfw6GY2I68V/3o2MyZuSIc
 1nrye4zsR1y0zTFfnelA3eYFnM5OH+aLRSSQrP69+mMXKIfzlbuN4qXQNfi4B9UjrdqT
 AZKGYJRD9DlmqN/bX1v+otUOQgoUuylORNmjf45LvM1BGPKfunAm36CnEZ+Et7t3xaW7
 IlWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbggfB4q/FTUP9icP4J8eCIj0PXvKokKe+7Hsv90Jq+gjv0aPvM4aTxGk01w56ej7UbHQCVHITXkZU@nongnu.org
X-Gm-Message-State: AOJu0YzjNJwWnlnm0a2f/ZKOv+ucgVvgfIRDwBaO/guFhaJIL6KpByZF
 5RkyRmCVwIwqzBw61svsydWa+/OUHyLT+/MNpDahe4LqlEdUYNkQ
X-Google-Smtp-Source: AGHT+IExTdeGw8aLpG72eeW9Aj6hyRgVSH5StOOqnMPdPcgbLC7hQF38iw0EtfAfIhxkTbAQk2Yokg==
X-Received: by 2002:a05:6808:152c:b0:3e0:42ba:c59b with SMTP id
 5614622812f47-3e758cb6ec1mr15776664b6e.40.1730829735661; 
 Tue, 05 Nov 2024 10:02:15 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e30e8aa2076sm2663139276.39.2024.11.05.10.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 10:02:15 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 10:01:53 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 01/10] hw/cxl: Check size of input data to dynamic
 capacity mailbox commands
Message-ID: <ZypdkVE5uD-0nCb2@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=nifan.cxl@gmail.com; helo=mail-oi1-x234.google.com
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

On Fri, Nov 01, 2024 at 01:39:08PM +0000, Jonathan Cameron wrote:
> cxl_cmd_dcd_release_dyn_cap() and cmd_dcd_add_dyn_cap_rsp() are missing
> input message size checks.  These must be done in the individual
> commands when the command has a variable length input payload.
> 
> A buggy or malicious guest might send undersized messages via the mailbox.
> As that size is used to take a copy of the mailbox content, each command
> must check there is sufficient data. In this case the first check is that
> there is enough data to read how many extents there are, and the second
> that there is enough for those elements to be accessed.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 97cb8bbcec..17924410dd 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2465,11 +2465,20 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      uint64_t dpa, len;
>      CXLRetCode ret;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (in->num_entries_updated == 0) {
>          cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>          return CXL_MBOX_SUCCESS;
>      }
>  
> +    if (len_in <
> +        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      /* Adding extents causes exceeding device's extent tracking ability. */
>      if (in->num_entries_updated + ct3d->dc.total_extent_count >
>          CXL_NUM_EXTENTS_SUPPORTED) {
> @@ -2624,10 +2633,19 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>      uint32_t updated_list_size;
>      CXLRetCode ret;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (in->num_entries_updated == 0) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> +    if (len_in <
> +        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      ret = cxl_detect_malformed_extent_list(ct3d, in);
>      if (ret != CXL_MBOX_SUCCESS) {
>          return ret;
> -- 
> 2.43.0
> 

-- 
Fan Ni

