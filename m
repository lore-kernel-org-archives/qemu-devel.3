Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D0DC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcc7W-0000SR-Q6; Tue, 20 Feb 2024 21:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcc7V-0000PO-Ng
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcc7T-00080m-TM
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708481638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RO+xt5lFKH/d2VYIcFsobSEtSGxghlf/ShLhSWPZyIY=;
 b=GBScBOFejnyKmHntJzPwkTyCqxGIINiG2JCTDGP2+/p/R8oM2xbgVt7rhxLWy6ZNQRgaQ/
 z/nTvWBvOfQRoC2sOBgtx6YRqV2yO+YTzBm7JofmCCstDz66LIiW2yh6fE9Rw6G6zKADjf
 DC0GM0sAtqkn9KJKn5zyMre+yA0mUjs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-XfRljbI4Nz2PbjmH6vduFQ-1; Tue, 20 Feb 2024 21:13:57 -0500
X-MC-Unique: XfRljbI4Nz2PbjmH6vduFQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5d57b2d2758so1818002a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708481636; x=1709086436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RO+xt5lFKH/d2VYIcFsobSEtSGxghlf/ShLhSWPZyIY=;
 b=HoCgoz/SX+V/wiKxKGPA9r5M+Uei2/d57+BJw0VYrxsFJH9CcD+19sxkt6/YZOs7CC
 JdUIsU29RJl5zvzgxNm7cwy2vSmXLqDvVCO44SZWEPAtK/T5w/GIdZQ0Bzl8Lhtkhftd
 7QXstX3+OMv5/OzJO0lHHpNENVI6zq9L8gMnp6FYqVmqdVRDmLegjZscYz/wO9q65Gh7
 YsPuxUOXyP3TULhAU0IMQLjWAJjS1mAF5Q/VftEeOYZH1P39Dr9wLjCcravLsRi/wtd+
 Ujjrrk1MW+XSDPY7mG+oxJtAse/HFDHBFsSG6NI0TJAwJ+kZlsuOScD0j/X1bK/OPDfb
 goCg==
X-Gm-Message-State: AOJu0Yy3TUvE6TwX9uoB0EPDDdIpx/DLl82FIXLGoryY+K/fCvPxDurC
 bNiV3CpEQdCVJDQUSLxbOtkEp+AkIYWsUXBNLkDV98T6ZT9JRLFyzD/MU+dIaCdqeoRqyG54d3u
 fa+ZCShONXYCFTSMWbgS8PqyJU5HZZetGT5IZeyFU/QI3SGl1vE47
X-Received: by 2002:a05:6a20:6a24:b0:1a0:c2f4:89b4 with SMTP id
 p36-20020a056a206a2400b001a0c2f489b4mr203491pzk.5.1708481635939; 
 Tue, 20 Feb 2024 18:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkDOisIP/rOi5C1hwqCjEREv8GSSeQ07BStqU0i1t05jEngV+enxHF8Rl8K+g7WiBB14r8zg==
X-Received: by 2002:a05:6a20:6a24:b0:1a0:c2f4:89b4 with SMTP id
 p36-20020a056a206a2400b001a0c2f489b4mr203480pzk.5.1708481635643; 
 Tue, 20 Feb 2024 18:13:55 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fn16-20020a056a002fd000b006e3dfb2ef4esm6191665pfb.95.2024.02.20.18.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:13:55 -0800 (PST)
Date: Wed, 21 Feb 2024 10:13:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 00/13] allow cpr-reboot for vfio
Message-ID: <ZdVcXE89BviCPYXI@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <ZdRZpiiD05JS_AkF@x1n>
 <3784e88c-b48a-46d3-8742-c3b94ad422c5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3784e88c-b48a-46d3-8742-c3b94ad422c5@oracle.com>
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

On Tue, Feb 20, 2024 at 05:32:34PM -0500, Steven Sistare wrote:
> On 2/20/2024 2:49 AM, Peter Xu wrote:
> > On Thu, Feb 08, 2024 at 10:53:53AM -0800, Steve Sistare wrote:
> >> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> >> guest drivers' suspend methods flush outstanding requests and re-initialize
> >> the devices, and thus there is no device state to save and restore.  The
> >> user is responsible for suspending the guest before initiating cpr, such as
> >> by issuing guest-suspend-ram to the qemu guest agent.
> >>
> >> Most of the patches in this series enhance migration notifiers so they can
> >> return an error status and message.  The last few patches register a notifier
> >> for vfio that returns an error if the guest is not suspended.
> >>
> >> Changes in V3:
> >>   * update to tip, add RB's
> >>   * replace MigrationStatus with new enum MigrationEventType
> >>   * simplify migrate_fd_connect error recovery
> >>   * support vfio iommufd containers
> >>   * add patches:
> >>       migration: stop vm for cpr
> >>       migration: update cpr-reboot description
> > 
> > This doesn't apply to master anymore, please rebase when repost, thanks.
> 
> Will do.  Before I do, any comments on "migration: update cpr-reboot description"?
> After we converge on that short description, I will submit a longer treatment in
> docs/devel/migration, which I see you have recently populated.

Sounds good; yes I hope we have a file there, as it'll pop up later in
https://www.qemu.org/docs/master/devel/migration/.

You can add a short sentence to forbid postcopy if that's the plan.  Other
than that it looks good.

Thanks,

-- 
Peter Xu


