Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8873BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0R4-0008Vr-6q; Thu, 07 Aug 2025 09:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk0R2-0008Uw-PO
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk0Qz-0001Hw-Io
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754572406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VLFudbkZiFbI63E5uxV9T6D7dkpmszkegZG0OKRnABQ=;
 b=FQ2jKzwb6jENaBzLOd77Wfs+esfUSPSryX6Kad7KT7rQ+H/tFlwxyia2jdae5IQVSFhBIA
 03Lrbp898FhcxI7DT1KIAIwrSj6MGJNQos0qqVav4aKZp+bItfNpomL/49XDAZW+H4DJLG
 D33Y2vrvRVoL+4n176B5bO3f1VAErqc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-0odiTelUOcOlWCN80AuXLQ-1; Thu, 07 Aug 2025 09:13:24 -0400
X-MC-Unique: 0odiTelUOcOlWCN80AuXLQ-1
X-Mimecast-MFC-AGG-ID: 0odiTelUOcOlWCN80AuXLQ_1754572404
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e8db89e6a38so1093675276.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 06:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754572404; x=1755177204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLFudbkZiFbI63E5uxV9T6D7dkpmszkegZG0OKRnABQ=;
 b=dIODeNLwBY8mXHAP3Ieg7Gf+6uv+gmg6xx7AW472+4Y071U6V9do0H1x6ZENOtPRMz
 nJXdxIEb0JpfHvhwLzbu8ySH1htkxerncxjsgi8nfqtEdGWRjltjwato2c3jPrOyHu7P
 hMRXWCDN9XnlztQUaXsoR0doucNqSC+eUpYbEq+xFP26UsM++grTASBr/0TIu3CqnKgx
 h3Hw8lNcVp7XiguLQkivBFYZrlsgtDb+nvDUQrtF78nMOxvqrFDoupP/tpIkBf3EWx0z
 FqAV3fOByznDenZzhLVkkYCfVXLyQBkpsSPhi8kAJV4bLrGI8Aq1pGxTiPECiNhx7bwh
 pMPA==
X-Gm-Message-State: AOJu0YxYbNprWYqxv9ggngp0NWPjoPU96zVnXGcsGh5lnKwJlpiEA3Aw
 CJEDBw7Yrn24/h+pTHvnOP2Ne3JVsPc7xu1EbDjYK6Isd5ncjxw/ASTlPV383nfgRz3A0rWe9rM
 Ozqi+l8BczypZEW6p2F96GO9/fn5OsaY9dwhGDt5VkZXNGFDw5wF3WGB0
X-Gm-Gg: ASbGncvNjaD+Tfm0ajMwa9C7gbo8m7DLQjf20eWxViszQhDil/QppDma1Pa4KZqYB7D
 YkNUopUdzmUcR6UkIujtkGa1VZ9PA0d2sEBgSb8ZqJJ4KSDiQOQQge7nYQ4R0I9vrFqMxpGUbkK
 fPsp7iWwXhBoBgabcw2OZdy17iOK/DuqOIopzQ8dI39dJxaBF1rr5zG8IiB/T15DZrh/xQMURgo
 1OUEJF6oLqVrhrZvtnuXmm5FRtjGB6fpLgxdNwkiVhjJcoA9ZBAUnto+q5068ZGjSikrr3CIo8R
 KIysxJ5flgvdTLxsoZmj7XpezrUJSzTt
X-Received: by 2002:a05:6902:110e:b0:e90:1055:bcb8 with SMTP id
 3f1490d57ef6-e90287ac601mr8258618276.20.1754572403614; 
 Thu, 07 Aug 2025 06:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4k30Ftt7jPAk1jGvn+AbinuxaM0CAuib2M2byNx8DG4A9lFngboRqKG6/FodjlT5wEKd/Kw==
X-Received: by 2002:a05:6902:110e:b0:e90:1055:bcb8 with SMTP id
 3f1490d57ef6-e90287ac601mr8258586276.20.1754572403211; 
 Thu, 07 Aug 2025 06:13:23 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e8fd35a98eesm6364710276.0.2025.08.07.06.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 06:13:22 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:13:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
Message-ID: <aJSmZ2kmOeStv6aY@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <aJN7uOWSt10U7DMi@x1.local>
 <71a1cb1b-49b9-4a4c-aa6d-429aa3cf8a8a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71a1cb1b-49b9-4a4c-aa6d-429aa3cf8a8a@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 08:50:38AM -0400, Jonah Palmer wrote:
> 
> 
> On 8/6/25 11:58 AM, Peter Xu wrote:
> > On Tue, Jul 22, 2025 at 12:41:22PM +0000, Jonah Palmer wrote:
> > > Adds a new migration capability 'virtio-iterative' that will allow
> > > virtio devices, where supported, to iteratively migrate configuration
> > > changes that occur during the migration process.
> > > 
> > > This capability is added to the validated capabilities list to ensure
> > > both the source and destination support it before enabling.
> > > 
> > > The capability defaults to off to maintain backward compatibility.
> > > 
> > > To enable the capability via HMP:
> > > (qemu) migrate_set_capability virtio-iterative on
> > > 
> > > To enable the capability via QMP:
> > > {"execute": "migrate-set-capabilities", "arguments": {
> > >       "capabilities": [
> > >          { "capability": "virtio-iterative", "state": true }
> > >       ]
> > >    }
> > > }
> > > 
> > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > > ---
> > >   migration/savevm.c  | 1 +
> > >   qapi/migration.json | 7 ++++++-
> > >   2 files changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index bb04a4520d..40a2189866 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
> > >       switch (capability) {
> > >       case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
> > >       case MIGRATION_CAPABILITY_MAPPED_RAM:
> > > +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
> > >           return true;
> > >       default:
> > >           return false;
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 4963f6ca12..8f042c3ba5 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -479,6 +479,11 @@
> > >   #     each RAM page.  Requires a migration URI that supports seeking,
> > >   #     such as a file.  (since 9.0)
> > >   #
> > > +# @virtio-iterative: Enable iterative migration for virtio devices, if
> > > +#     the device supports it. When enabled, and where supported, virtio
> > > +#     devices will track and migrate configuration changes that may
> > > +#     occur during the migration process. (Since 10.1)
> > > +#
> > 
> > Having a migration capability to enable iterative support for a specific
> > type of device sounds wrong.
> > 
> > If virtio will be able to support iterative saves, it could provide the
> > save_live_iterate() function.  Any explanation why it needs to be a
> > migration capability?
> > 
> 
> It certainly doesn't have to be a migration capability. Perhaps it's better
> as a per-device compatibility property? E.g.:
> 
> -device virtio-net-pci,x-iterative-migration=on,...
> 
> I was just thinking along the lines of not having this feature enabled by
> default for backwards-compatibility (and something to toggle to compare
> performance during development).
> 
> Totally open to suggestions though. I wasn't really sure how best a
> feature/capability like this should be introduced.

Yep, for RFC is fine, if there'll be a formal patch please propose it as a
device property whenever needed, thanks.

-- 
Peter Xu


