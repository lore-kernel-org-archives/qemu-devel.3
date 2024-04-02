Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2122ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 21:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrlvB-0004sp-KN; Tue, 02 Apr 2024 17:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrlvA-0004sP-9U
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrlv8-0005Um-MA
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712094233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0kRk94Z9tu2HxIzMcN/bHkEOYXUirz36ddTo9vD2Z0=;
 b=JSO3pmwCTo7AgBv0jVJTB71aGhTnutDtBtOW5VNONxjNAcoOt+aE7uqfb8NEiGd+5fqv1t
 g7uY8PoJAZoFBIYBn4004nV86rKLK2wZTwGjqFTApV63gd0NVGYqcQ9X93OnK//Eh3iMaA
 5QDf6kE5ME/SAvT92zQJB5U85CjlXlI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-F9OGnvSgPEy5NMbJfpdeuQ-1; Tue, 02 Apr 2024 17:43:52 -0400
X-MC-Unique: F9OGnvSgPEy5NMbJfpdeuQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c4f6ef2801so241902b6e.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 14:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712094232; x=1712699032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0kRk94Z9tu2HxIzMcN/bHkEOYXUirz36ddTo9vD2Z0=;
 b=XiF0nueacwNX3hqjpzY1vb2qUIi+8QLZ0b9zNjm0PVNaIJIsEKFB2wrA37Df4E0j7G
 n1ftRSfBqauE+aazlEQB8qhk+Tt7zrQeA9A0qONRtpFblKAbutfoAS0EG8vRG4E4fjmD
 TIjqL9yoMT4XMs7YD32+nNPS0iJ/0QY+fUsdip0wbbFfL7HMkPVAqe0OSy6k5clhoSMw
 0HYgxUNoE5mJLouNMLlcvKvQ3rnM7yi9wCKW4wViFg5/asMQCG64lj4JxilM3xbZbvhO
 Kp4WelECcM73KnTJ9B5jSxcjl/9v70ashYWL+8VRYZPpiEGHk/YQjHz8x8FEilZLkED3
 LfTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz3yKUT8W4I6wCsINEVqQcq5IXcRDKJ9x4AqydEeEbEW8GBWVDY/4ZBSz10BsLwjWusWrPVMPMI+XelyMGt7zkDTiY51I=
X-Gm-Message-State: AOJu0YwNxibuMjNd/y8dsZZWcpV5TB4k2X4JRgWbM54Iae6Qjqy5VC19
 O1ZZwjbVQ/ME8AABKXdlQHm9e3alehOdzPPP6hgo38smb9Ptco8E8LB9FoLrUbB8e87ZLiOqbIg
 dARS04hl/A8PGHM8upmBuCnkFw60bP1UfkQYWX3cb7SdVWBcYHiAn
X-Received: by 2002:a05:6870:1d1:b0:22e:7040:6fd with SMTP id
 n17-20020a05687001d100b0022e704006fdmr2778730oad.3.1712094231688; 
 Tue, 02 Apr 2024 14:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ2x7wc/CsufYG8HdeQyJIKY/pZMujHRCMIEAzmpl2VfYME6CCE5ZV5pSGnTQo3rA+kX6ufQ==
X-Received: by 2002:a05:6870:1d1:b0:22e:7040:6fd with SMTP id
 n17-20020a05687001d100b0022e704006fdmr2778716oad.3.1712094231140; 
 Tue, 02 Apr 2024 14:43:51 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ez6-20020a05622a4c8600b0043146d55f0csm5890370qtb.60.2024.04.02.14.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 14:43:50 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:43:48 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Message-ID: <Zgx8FFzaFS1RsNmc@x1n>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n>
 <DS0PR11MB6373B342B3CFF787E3C2A5FFDC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373B342B3CFF787E3C2A5FFDC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Apr 02, 2024 at 07:20:01AM +0000, Wang, Wei W wrote:
> > IIUC we still need that pre_7_2 stuff and keep the postponed connect() to
> > make sure the ordering is done properly.  Wei, could you elaborate the patch
> > you mentioned?  Maybe I missed some spots.
> 
> Sure. I saw your patch (5655aab079) ensures that the preempt channel to be
> created when PONG is received from the destination, which indicates that
> the main channel has been ready on the destination side.
> 
> Why was it decided to postpone the preempt channel's connect() for newer QEMU
> only? The old QEMU (before 7.2) still performs preempt channel connect() in
> migrate_fd_connect(), doesn't it have the disordering issue?

Yes it has, but the solution actually was not compatible with older
binaries, so migration was broken back then..  See:

https://lore.kernel.org/qemu-devel/20230326172540.2571110-1-peterx@redhat.com/

My memory was that we didn't have a good solution to fix it without
breaking the old protocol, so it can only be fixed on newer binaries.

Thanks,

-- 
Peter Xu


