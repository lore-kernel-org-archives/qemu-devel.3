Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C95C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 04:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXvzS-0001rZ-QU; Wed, 07 Feb 2024 23:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXvzR-0001rN-Bo
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 23:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXvzP-0000OA-Qf
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 23:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707366378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWDX2ryH6YVnQdUr37ZX4+PQ8zoa4QA3hBa0fahx5L0=;
 b=hDmeFzWoOP9bI+FsljgSinCDcn99vok4ZnZ6pO/72tF4isovsXbWGpxLNtnnM58TIQwAjr
 QW2VdPlQtb3DoCS71MmwSX1OicmaG/FGhXK2SgAIQS9hsKVshm+ZlDkMjUrjHX1LB63rkT
 wH3rVQ9Y2egXywd7LyNV3Tp1Ow5+LSw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-V-C10rWqMrWNKRag--K4fg-1; Wed, 07 Feb 2024 23:26:17 -0500
X-MC-Unique: V-C10rWqMrWNKRag--K4fg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bd7d395d7eso679033b6e.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 20:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707366376; x=1707971176;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWDX2ryH6YVnQdUr37ZX4+PQ8zoa4QA3hBa0fahx5L0=;
 b=nq+eU2QzwdMfFX/qybnxBf3nkJbdyVDSrmg9JxyYckxUvdolu3L0zj0k9syUyjJOEZ
 +/6rMVg97g2H/KwSS7PomRCz0NFVU1XxDz3nveg+cOBnyUu/CwpLG9Yl8VxGScMiMnHR
 8sduMLXHo1NxDfwadSyWPW+qsdiTyuaVdjVvEyDPLrLj0Lo9Lx74zuo2VEXlh94YAHrH
 jDB6coMPVvkg8MMdKlQciw288CnK83ZobiXqI2C5rdxUPW21UDZ0gWVU2ibEIdhmFMh6
 rrnWBrZ6A6i9aW9mXdcqYdcohHOxf26RxaNrYK6Mf2aTjJvt9+a2JTBycmRnliTd5RVw
 MQCg==
X-Gm-Message-State: AOJu0YxySC+M+jsOyk+96RkEoLmvkmEbvzO3Q9q6m6JPzw0nTXFbTQ5p
 E+9Jmo2TikDEKc4pdzhf/gWm6e9hoeCok6uw1FoXJbwNJ4Zs7PIdsjRyax/dR0tzw8obNdqWU9o
 y1feollFAYBVyDckNDW7DJpMc1v8SaZBkgoWg1mHhrdo09hi9zJU7
X-Received: by 2002:a05:6358:e48f:b0:176:c1e1:7556 with SMTP id
 by15-20020a056358e48f00b00176c1e17556mr8365656rwb.0.1707366376302; 
 Wed, 07 Feb 2024 20:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHElNvmj8BlqpfNtsyFNqTsJKTNbTu4pBkHBR5slEz4jacPV7ag/QPBB87cuK+2AS6FVztHbw==
X-Received: by 2002:a05:6358:e48f:b0:176:c1e1:7556 with SMTP id
 by15-20020a056358e48f00b00176c1e17556mr8365647rwb.0.1707366376018; 
 Wed, 07 Feb 2024 20:26:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWbysJSUrqOKjfjpzyOaQBUD11MEaNEiOCi91UA+RbtSZF9IYQEtMR1nm/UbmMZdOmZZb4yUHc0Y/Jy3XLf3eBAZ6xwWFu0GxTHx0VvZBlNBgCwmYdUV4bEc3mA
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c126-20020a633584000000b005dc1edf7371sm2547192pga.9.2024.02.07.20.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 20:26:15 -0800 (PST)
Date: Thu, 8 Feb 2024 12:26:10 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 01/14] migration: Add Error** argument to .save_setup()
 handler
Message-ID: <ZcRX4rAssqDkZKMF@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-2-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207133347.1115903-2-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 07, 2024 at 02:33:34PM +0100, Cédric Le Goater wrote:
> diff --git a/migration/ram.c b/migration/ram.c
> index d5b7cd5ac2f31aabf4a248b966153401c48912cf..136c237f4079f68d4e578cf1c72eec2efc815bc8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2931,7 +2931,7 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>   * @f: QEMUFile where to send the data
>   * @opaque: RAMState pointer

Document may need a touch-up.

>   */
> -static int ram_save_setup(QEMUFile *f, void *opaque)
> +static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
>      RAMState **rsp = opaque;
>      RAMBlock *block;

Besides:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


