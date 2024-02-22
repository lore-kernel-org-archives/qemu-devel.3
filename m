Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8764C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4zd-0006rz-K1; Thu, 22 Feb 2024 04:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd4zY-0006o8-2R
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd4zV-0007X0-6f
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708592619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv05f8x5vWm0P1YxxQcwmUCsgVjCkIE6X02d5uoaJgM=;
 b=J7fln5JyxrIUQEqu0laOu6wxpAcsEGGYOsvy4iuDOyHAj1+sqSits/KOQEOikrCwwH4uw5
 sdrlCT6I9Gfow7d2oTdx/BAlp/nT19QDaqHSQtkYM+AlqmM8owI1ezjrcpboj0t0AW4YGL
 F2SAm8F2UX6F8B65mtDTzzj1LlzX6DQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-rCYK7ptBPWC2Oy95aYTAQA-1; Thu, 22 Feb 2024 04:03:37 -0500
X-MC-Unique: rCYK7ptBPWC2Oy95aYTAQA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so514088a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 01:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708592617; x=1709197417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv05f8x5vWm0P1YxxQcwmUCsgVjCkIE6X02d5uoaJgM=;
 b=qyO7aCd8PaWrJCrxigv3Sl8eBQSwMvhGxKdFNBPCGFK7peixFYf6SqKPWfJzn2UYD9
 TUokr9BrnJaFl4r3IoToKFoUV+7CsFM/s00xoZmtD9e8atW6gtUSk8QbESRV5ypoZIem
 8Jsxj7qx+9YhjTfF7Nk/w7zjYYJDFkYU1nrSpyH0QbS9WHPFHI7KP94tzQQRL/SmvNJ0
 1a9SNw3PjLgGZzlxHRZ2YRiYIPNFx9czvCGQ+DrHGHSj8lkZqd3WhqXrIMa0qJu5Bsqo
 7VcY9K5xwLsC8+F64aKaHNXCTA8BjhuzhM6DsE1Ynlwcksvcl+zrVlOkUwe7Xx1XP/ZE
 4zfw==
X-Gm-Message-State: AOJu0YwVVIb71bgjMJ2egAv7UMuyJrnJldnCcDDI9QthKmeGEDfRutJZ
 p0P+RZzwnf7cKoRLX+LkxuzwBlXfysM5mEXVPGfEdLTzQFrxOlafhzHUgCKmPEsAM65mULWbr6e
 7zHd086g1/DQrIrLTxfsP08hCnB/1QeR/Phmzb+hMiMFywPbukCFq
X-Received: by 2002:a17:90a:985:b0:299:3258:fdfb with SMTP id
 5-20020a17090a098500b002993258fdfbmr15115865pjo.4.1708592616871; 
 Thu, 22 Feb 2024 01:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEVAMU0S5qNV+hzL4QKez6tnoeRD9VHxHLpXR9dv5T7G+CMCXOz68iH3qAjNsJ90rfoMcjEw==
X-Received: by 2002:a17:90a:985:b0:299:3258:fdfb with SMTP id
 5-20020a17090a098500b002993258fdfbmr15115851pjo.4.1708592616530; 
 Thu, 22 Feb 2024 01:03:36 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g15-20020a17090a708f00b0029937909580sm10888856pjk.52.2024.02.22.01.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:03:36 -0800 (PST)
Date: Thu, 22 Feb 2024 17:03:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Message-ID: <ZdcN4L0nNhsrkxB-@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
 <ZdRVz7gvh-qGNxXZ@x1n>
 <b573d625-154c-4df6-9e86-2b1bbff38ac0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b573d625-154c-4df6-9e86-2b1bbff38ac0@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 21, 2024 at 04:23:07PM -0500, Steven Sistare wrote:
> > How about postcopy?  I know it's nonsense to enable postcopy for cpr.. but
> > iiuc we don't yet forbid an user doing so.  Maybe we should?
> 
> How about this?
> 
> -------------------------------------------
> @@ -3600,6 +3600,11 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          return;
>      }
> 
> +    if (migrate_mode_is_cpr(s) && migrate_postcopy()) {
> +        error_setg(&local_err, "cannot mix postcopy and cpr");
> +        goto fail;
> +    }
> +
>      if (resume) {
>          /* This is a resumed migration */
>          rate_limit = migrate_max_postcopy_bandwidth();
> ------------------------------------------------

migrate_fd_connect() will be a bit late, the error won't be able to be
attached in the "migrate" request.  Perhaps, migrate_prepare()?

-- 
Peter Xu


