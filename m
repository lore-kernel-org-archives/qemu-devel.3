Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BAFC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sARkM-0005gg-Rf; Fri, 24 May 2024 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sARkK-0005fs-W6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sARkJ-0006Db-48
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716544913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1qR3XsZSarc+I1sNe5g3Bu3oEruxkZoMhxo7cL72AY=;
 b=e1j81tgoEvRM9Nk4oB9UQnlnAvnoS8+BFuisoQrriD7WWnHG9nZoXgztj/3j8vWEv8X2lU
 evoqRr+LwtpxV4TmtW7RYuCRfFR0RN1NylQtVjsNe4x0zk1PS98wSSo/DWY2syN7Utfj7/
 CfYrq6G6rhdZwJ9wOZE3rdBwqcZPPZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-FetDi6ydNEOnf9Ikv3p4aQ-1; Fri, 24 May 2024 06:01:52 -0400
X-MC-Unique: FetDi6ydNEOnf9Ikv3p4aQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-354e0805ef3so54777f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716544911; x=1717149711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u1qR3XsZSarc+I1sNe5g3Bu3oEruxkZoMhxo7cL72AY=;
 b=RsgA+RND/SirtYZeNmm872cKRd5QR1Sdvg2ne9eKIG7HHVmD8T+U4gRRxBwbUH4rza
 X70n+ECDzy9+cDgtHqrOIZfQOOfpJIDgfo5tZL5AEX2lHFG1aOf/UBJaFCFnUtKE8t/D
 /nZ5bMCRDuGdA0E0u9nhUxYZ0bQL84jFTs5WlMZ2Ij1pbpzmTTlkePfyyv1AbHZZQInx
 LF0UW4zbJG/T56apEogB8HTN+twswLjnATSN8gISBAxOHy6Rsopj+hTvNsab4VI0m/9h
 DIfwbnJ7x9c96MJHGf91KM/GjaX1vSWut7/M08Ez9ve/H+A9YMuAD1TKgmtTYlUGTI+5
 XgSw==
X-Gm-Message-State: AOJu0YxONv5JJw1PniZELoXoEm391uL6SqBRF9/7jBzZc1czzYXuLs3p
 rZWGF1G0xuWsDMq6suLe72NogWZsH29XcooIV51teEbbVdDwyFVUClWAUUt47aFOfrUX/fmUqkp
 FZbXjaLt9jjWgQitLWdlf5nw8PQGSEhzoBXscJsp6GXP3gVNft61I39B9iMJUZZDodjQWaaRqSD
 TXK6BZTD8R9JASyeA5lALlBsT5ugI=
X-Received: by 2002:a5d:65c7:0:b0:354:f1b7:7469 with SMTP id
 ffacd0b85a97d-3552fdc8280mr1715380f8f.51.1716544910447; 
 Fri, 24 May 2024 03:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHerhH4vTEAVFl/wAtyhpYfOvEdEDBLAyFHHL4JD4xKHGo9EhsGf9XF9dhB5HOYpfxtjQNXEQpPFbjBm854ctY=
X-Received: by 2002:a5d:65c7:0:b0:354:f1b7:7469 with SMTP id
 ffacd0b85a97d-3552fdc8280mr1715342f8f.51.1716544909735; Fri, 24 May 2024
 03:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716531409.git.yong.huang@smartx.com>
 <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
In-Reply-To: <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 24 May 2024 15:31:33 +0530
Message-ID: <CAE8KmOyXhvYHOw2MOSbwSetC7jyFNFsf0E81O0wQ1WEGGXY-TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Hyman,

* Is this the same patch series as sent before..?
  -> https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00816.html

On Fri, 24 May 2024 at 12:02, Hyman Huang <yong.huang@smartx.com> wrote:
> For VMs configured with the USB CDROM device:
>
> -drive file=/path/to/local/file,id=drive-usb-disk0,media=cdrom,readonly=on...
> -device usb-storage,drive=drive-usb-disk0,id=usb-disk0...
>
> QEMU process may crash after live migration,
> Do the live migration repeatedly, crash may happen after live migratoin,

* Does live migration work many times before QEMU crashes on the
destination side? OR QEMU crashes at the very first migration?

>    at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/iov.h:49

* This qemu version looks quite old. Is the issue reproducible with
the latest QEMU version 9.0?

> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> +static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req)
> +{
> +    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    if (s->migrate_emulate_scsi_request) {
> +        scsi_disk_save_request(f, req);
> +    }
> +}
> +
>  static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
>  {
>      SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> @@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
>      qemu_iovec_init_external(&r->qiov, &r->iov, 1);
>  }
>
> +static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req)
> +{
> +    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    if (s->migrate_emulate_scsi_request) {
> +        scsi_disk_load_request(f, req);
> +    }
> +}
> +
>  /*
>   * scsi_handle_rw_error has two return values.  False means that the error
>   * must be ignored, true means that the error has been processed and the
> @@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops = {
>      .read_data    = scsi_disk_emulate_read_data,
>      .write_data   = scsi_disk_emulate_write_data,
>      .get_buf      = scsi_get_buf,
> +    .load_request = scsi_disk_emulate_load_request,
> +    .save_request = scsi_disk_emulate_save_request,
>  };
>
>  static const SCSIReqOps scsi_disk_dma_reqops = {
> @@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] = {
>  static int scsi_disk_pre_save(void *opaque)
>  {
>      SCSIDiskState *dev = opaque;
> -    dev->migrate_emulate_scsi_request = false;
> +    dev->migrate_emulate_scsi_request = true;
>

* This patch seems to add support for migrating SCSI requests. While
it looks okay, not sure if it is required, how likely is someone to
configure a VM to use CDROM?

*  Should the CDROM device be reset on the destination if no requests
are found? ie. if (scsi_req_get_buf -> scsi_get_buf() returns NULL)?

Thank you.
---
  - Prasad


