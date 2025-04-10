Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D4BC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 14:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2sqz-0003Tt-EY; Thu, 10 Apr 2025 10:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2sqY-0003QQ-OH
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 10:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2sqW-0006VO-IM
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 10:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744295134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w1ogun7aTIt1NMY1yf7/6F6+f0XhZUZrplktf+85xsA=;
 b=Lhl3XXgqMp5fVzAu5XFkf/3VMcBvQQ0AwTKTNa3w8J/BIOWw7lc2/Hsi1i1OIoB/DtNPOt
 OKVumAIjCvVvTbxJyDOJsIEqe8nzwhcrMqaWn7wVtWyWPa7iT9bhkd4DDFjKpfNNsQG5ol
 uO5dSojBEZkwMYqWxf6on91XUyfMrLU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-CXSqrAWUOaiNIJzqn9V3TQ-1; Thu, 10 Apr 2025 10:25:32 -0400
X-MC-Unique: CXSqrAWUOaiNIJzqn9V3TQ-1
X-Mimecast-MFC-AGG-ID: CXSqrAWUOaiNIJzqn9V3TQ_1744295132
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e82ed0f826so920259a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744295131; x=1744899931;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w1ogun7aTIt1NMY1yf7/6F6+f0XhZUZrplktf+85xsA=;
 b=jA0uRHPi3SEAO6ubjnNryYRzyXCca8EZ5vH4wWRHy+4Atj59K2fIGnWVxY8XfuSnjG
 MubWjC19ZwzMqa0X3i0ykLO+tw4oUudlo8jx6hxwu7D7/sMQDtiaQ3lo2y77VCB4JTaI
 wGk3A9iY+zfZXfXRHsgbIFJR2XnjOKo2C4v24jxqv6OUQ/2Lf7tdUubGd0wM9o1v5uB6
 eVGklKftDLD+CmMrm9JUaQOq5L4G1nvEvQTGIYFPjW4JppsVyVeDLxfV9iZGLUfXFbXO
 aQoB6qEW7tFaOWUdf3bM3qK9zqi+ZW2sHtrmyOXhD21VWMQuEW6MKsKTOisMM2SmWisn
 iNcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbzc+ozWH4zO+FYuEB4/K3GcBMlAG2Akkr7B/Bvqmc2W9/r6OhgcoOOVk6uClfrWBBWm12kBERrM6J@nongnu.org
X-Gm-Message-State: AOJu0YxKfawWNSoWWfgijQk0OC72s2ZqcTnR0gyGFbJRq2mZfLNzhg83
 svI3vflFyllLJ/QSj8SyyI41y9pKFiaRNPZB38wiRvfVP0FoCDr3Eyw/TRQsIeu2UXiqzgnk9Y8
 Q/aULXV4CCU/aZ92TxcnFzCmmpDXOArsdxueXc01B57+qDOtngYoz
X-Gm-Gg: ASbGnctVegTR6mskmX8qIdVFmA/nPk3oUEsb/3zfSDCgJxsxgpaOsWnM8gCqZpR9XlR
 OT3yFRZLBTt7Wkwi1+lUvnUv7EIEaLf9A6MnsR9eGDDwRgs44rJOQCLyWBl6bsUEK4XEMi2JKYO
 GlANCy5JTxfFlVy5DTGaprEirULqpbuFsmmk4N9idMQ0RZ1mK/mFPK3ZOG/P5zCXy5bhnDxoVxT
 F2kHFyx39LFNbrSp852u4quB9J4c/rfm0tbJhkxCygfVfTG7GwxqCwNtewBrCv6E5V+LUY08nAE
 psR0NcY1wYMa4IoqWmDxVkBbXXUYcG0rgyZkwzZ+hNFN6zptGQ==
X-Received: by 2002:a05:6402:3513:b0:5e0:82a0:50ab with SMTP id
 4fb4d7f45d1cf-5f32c46cdd1mr2173901a12.27.1744295131588; 
 Thu, 10 Apr 2025 07:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtLbR5WfybBY6/PGrFzM5MG0KjIyZ+xcSBKvghnsYzALDmCvwDKjftIaor0Ru55zyQ4lMa0A==
X-Received: by 2002:a05:6402:3513:b0:5e0:82a0:50ab with SMTP id
 4fb4d7f45d1cf-5f32c46cdd1mr2173879a12.27.1744295131208; 
 Thu, 10 Apr 2025 07:25:31 -0700 (PDT)
Received: from [192.168.136.123] (93-33-70-196.ip43.fastwebnet.it.
 [93.33.70.196]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbc0d2d9sm2415120a12.29.2025.04.10.07.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 07:25:30 -0700 (PDT)
Message-ID: <bf72ef35-289c-4ec7-962b-414e3487c176@redhat.com>
Date: Thu, 10 Apr 2025 16:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20250407155949.44736-1-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250407155949.44736-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 4/7/25 17:59, Kevin Wolf wrote:
> Originally, all failed SG_IO requests called scsi_handle_rw_error() to
> apply the configured error policy. However, commit f3126d65, which was
> supposed to be a mere refactoring for scsi-disk.c, broke this and
> accidentally completed the SCSI request without considering the error
> policy any more if the error was signalled in the host_status field.
> 
> Apart from the commit message not describing the chance as intended,
> errors indicated in host_status are also obviously backend errors and
> not something the guest must deal with indepdently of the error policy.
> 
> This behaviour means that some recoverable errors (such as a path error
> in multipath configurations) were reported to the guest anyway, which
> might not expect it and might consider its disk broken.
> 
> Make sure that we apply the error policy again for host_status errors,
> too. This addresses an existing FIXME comment and allows us to remove
> some comments warning that callbacks weren't always called. With this
> fix, they are called in all cases again.
> 
> The return value passed to the request callback doesn't have more free
> values that could be used to indicate host_status errors as well as SAM
> status codes and negative errno. Store the value in the host_status
> field of the SCSIRequest instead and use -ENODEV as the return value (if
> a path hasn't been reachable for a while, blk_aio_ioctl() will return
> -ENODEV instead of just setting host_status, so just reuse it here -
> it's not necessarily entirely accurate, but it's as good as any errno).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: f3126d65b393 ('scsi: move host_status handling into SCSI drivers')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8da1d5a77c..e59632e9b1 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -68,10 +68,9 @@ struct SCSIDiskClass {
>       SCSIDeviceClass parent_class;
>       /*
>        * Callbacks receive ret == 0 for success. Errors are represented either as
> -     * negative errno values, or as positive SAM status codes.
> -     *
> -     * Beware: For errors returned in host_status, the function may directly
> -     * complete the request and never call the callback.
> +     * negative errno values, or as positive SAM status codes. For host_status
> +     * errors, the function passes ret == -ENODEV and sets the host_status field
> +     * of the SCSIRequest.
>        */
>       DMAIOFunc       *dma_readv;
>       DMAIOFunc       *dma_writev;
> @@ -225,11 +224,26 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
>       SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
>       SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
>       SCSISense sense = SENSE_CODE(NO_SENSE);
> +    int16_t host_status;
>       int error;
>       bool req_has_sense = false;
>       BlockErrorAction action;
>       int status;
>   
> +    /*
> +     * host_status should only be set for SG_IO requests that came back with a
> +     * host_status error in scsi_block_sgio_complete(). This error path passes
> +     * -ENODEV as the return value.
> +     *
> +     * Reset host_status in the request because we may still want to complete
> +     * the request successfully with the 'stop' or 'ignore' error policy.
> +     */
> +    host_status = r->req.host_status;
> +    if (host_status != -1) {
> +        assert(ret == -ENODEV);
> +        r->req.host_status = -1;

You should set ret = 0 here to avoid going down the 
scsi_sense_from_errno() path.

Otherwise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> +    }
> +
>       if (ret < 0) {
>           status = scsi_sense_from_errno(-ret, &sense);
>           error = -ret;
> @@ -289,6 +303,10 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
>           if (acct_failed) {
>               block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
>           }
> +        if (host_status != -1) {
> +            scsi_req_complete_failed(&r->req, host_status);
> +            return true;
> +        }
>           if (req_has_sense) {
>               sdc->update_sense(&r->req);
>           } else if (status == CHECK_CONDITION) {
> @@ -409,7 +427,6 @@ done:
>       scsi_req_unref(&r->req);
>   }
>   
> -/* May not be called in all error cases, don't rely on cleanup here */
>   static void scsi_dma_complete(void *opaque, int ret)
>   {
>       SCSIDiskReq *r = (SCSIDiskReq *)opaque;
> @@ -448,7 +465,6 @@ done:
>       scsi_req_unref(&r->req);
>   }
>   
> -/* May not be called in all error cases, don't rely on cleanup here */
>   static void scsi_read_complete(void *opaque, int ret)
>   {
>       SCSIDiskReq *r = (SCSIDiskReq *)opaque;
> @@ -585,7 +601,6 @@ done:
>       scsi_req_unref(&r->req);
>   }
>   
> -/* May not be called in all error cases, don't rely on cleanup here */
>   static void scsi_write_complete(void * opaque, int ret)
>   {
>       SCSIDiskReq *r = (SCSIDiskReq *)opaque;
> @@ -2846,14 +2861,10 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
>       sg_io_hdr_t *io_hdr = &req->io_header;
>   
>       if (ret == 0) {
> -        /* FIXME This skips calling req->cb() and any cleanup in it */
>           if (io_hdr->host_status != SCSI_HOST_OK) {
> -            scsi_req_complete_failed(&r->req, io_hdr->host_status);
> -            scsi_req_unref(&r->req);
> -            return;
> -        }
> -
> -        if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
> +            r->req.host_status = io_hdr->host_status;
> +            ret = -ENODEV;
> +        } else if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
>               ret = BUSY;
>           } else {
>               ret = io_hdr->status;


