Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731E0C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKtP-0005EW-30; Tue, 20 Feb 2024 02:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcKtM-0005EE-Ag
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcKtK-00066x-Rw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708415413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvGJ4uxTjCwUoosUEPAM1/X/c0U2rOH4s8jLLgrkLws=;
 b=RYR8Dhi7NdLSb38PA6brEaayBiRLum1w4UENXZoW933SXrtR8l3hcLrAPVILDDUJyT0kYU
 tWh83xYRa1vrNTGXvz32V3ti2Dt14giTuMoX5bzNtTOHp+1O8MQnaR/bec7QdHtbUSzFIt
 IjHQz8KkDXmSm5rxRrNpip54zyWb8Fw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-FfBWy9HpNGO8TkpMAdNPqA-1; Tue, 20 Feb 2024 02:50:11 -0500
X-MC-Unique: FfBWy9HpNGO8TkpMAdNPqA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so1438070a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708415410; x=1709020210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvGJ4uxTjCwUoosUEPAM1/X/c0U2rOH4s8jLLgrkLws=;
 b=fqd7MKbFYfQfwfKPnOLkkp/wgfMIaoPoIBtWiX9avVsSQu/jwXpR1YXjcrMRTs7XKq
 qTpOdaRFi8O/GtdYxe2iqoluofOiNTUbsWIfOPaQBARvlqUkWUh2twqGx6XULER4r5wW
 60OhTjsilXwiEYVIKiDpf9kKqCGQJ5BdzECNl45urya6VuXcwwZRvDb6HdQk6GeSIi/W
 mvDqKvzZA4kuF9iPWxVBuTU0X3cID8e7DJoIr7bErqI8fiqyxMKMuAyyNoALLCJrHXLH
 8n9KUvXPV5lxUqyTI+5h1mfVe6g70vXoS77aapunrSeC3812BY4exaNFjGIZznCQfWtN
 fiRQ==
X-Gm-Message-State: AOJu0Yww/AXt42/bX6dblfuFqJOUwRYGph6LBvC7mbFNqqJToF228RIA
 StMXfE6+qGcFM3fgUpL4H1ZF7x36berwPlBTjEMkF/9NLNBCjVcz1GKX7PufrHGq987Ui7TM7b9
 1duBtBWd+9jGIU1zpn+fcbLSYRvG81yOKnBaCYolmdCKu/CLQ90oK
X-Received: by 2002:a17:902:c14b:b0:1db:92e1:2e55 with SMTP id
 11-20020a170902c14b00b001db92e12e55mr12591925plj.2.1708415410622; 
 Mon, 19 Feb 2024 23:50:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdONfZKoD14GronVv0dakO3fVkL5CRJV0PYAYuWgavuhVItHwwiZgsWrTqk80uBlKSjKFiKg==
X-Received: by 2002:a17:902:c14b:b0:1db:92e1:2e55 with SMTP id
 11-20020a170902c14b00b001db92e12e55mr12591912plj.2.1708415410261; 
 Mon, 19 Feb 2024 23:50:10 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jc4-20020a17090325c400b001db3361bc1dsm5621929plb.102.2024.02.19.23.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 23:50:09 -0800 (PST)
Date: Tue, 20 Feb 2024 15:49:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 00/13] allow cpr-reboot for vfio
Message-ID: <ZdRZpiiD05JS_AkF@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

On Thu, Feb 08, 2024 at 10:53:53AM -0800, Steve Sistare wrote:
> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> guest drivers' suspend methods flush outstanding requests and re-initialize
> the devices, and thus there is no device state to save and restore.  The
> user is responsible for suspending the guest before initiating cpr, such as
> by issuing guest-suspend-ram to the qemu guest agent.
> 
> Most of the patches in this series enhance migration notifiers so they can
> return an error status and message.  The last few patches register a notifier
> for vfio that returns an error if the guest is not suspended.
> 
> Changes in V3:
>   * update to tip, add RB's
>   * replace MigrationStatus with new enum MigrationEventType
>   * simplify migrate_fd_connect error recovery
>   * support vfio iommufd containers
>   * add patches:
>       migration: stop vm for cpr
>       migration: update cpr-reboot description

This doesn't apply to master anymore, please rebase when repost, thanks.

-- 
Peter Xu


