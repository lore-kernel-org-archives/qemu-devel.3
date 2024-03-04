Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D1C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh87I-0005yx-EM; Mon, 04 Mar 2024 08:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh874-0005xq-K3
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:12:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh872-0003aO-K6
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709557931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hya7C3IrM4vtFfsgfyACNWyuC5xB51ekW/NKhHA8ZaU=;
 b=MfKh8gnyKqUUtdec2g1oyu6tNpFFsDhsnoMiGoxWSfdyPJN41vLoQaT8DQIqO48x79OYmd
 YyKJRLZUue0S7Pd/kYfsrzPIfuNzTby8i3+Y0Iuigp9qB53IJc14F0GdQASqmc7uLz3cUT
 J5wyivQ196+a8ME4Z2oVDftOb6dl+Io=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-mC8unQavO2iqqhE8sczGzA-1; Mon, 04 Mar 2024 08:12:10 -0500
X-MC-Unique: mC8unQavO2iqqhE8sczGzA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299565dfd2dso921097a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557929; x=1710162729;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hya7C3IrM4vtFfsgfyACNWyuC5xB51ekW/NKhHA8ZaU=;
 b=QeUBLTjkC5WbnTHTyEPmYMFrXnfhXdFI3T2fKxeVGbfljvgNR8r6K9a/xqnmSELp27
 /E90j++nkq20pu060krNvJrYN+E4qzR3Gd/UGgaFUgjlGpI37bZeCucIuFEcOJI16hmy
 ikbVMLbxDv82gUTY/6Jjl+wOjCNc6K2LnKSkfcPD8ZlrDZkbh9c7Mw9gGG8C06EIsbTh
 EG8sv+wNCPK4taiV4vY8dUGbeUCe/uJGGbHVgVEKKcmd1WCQ8ruxRJ93vvGqFYEXKRNv
 KFoZGg9Horp0TuQeg4DmyMggL+GzGo/EvhHVAsz8wK4GVDZbI3+dt3sTe6yy6m3fqNnx
 jk9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkDckBVQdaQzMsL+i9r3nKAS+t0C9t/wm5kJ3eRFzW65L35L4XJsAEb1woAc7Sj24teSTOpGaKSCY37csJEFhq96yYKi0=
X-Gm-Message-State: AOJu0YwTZEfkCVgFS4tki5Qe/I1mMLWX7WE0ImJLMonfX4lfj7tcQJPL
 e//NyR8uM6eUu63Ih+TqneezzMucBJw6NE3BCy9fE0o8XieEnvybz4vP632YOcl50G4dm3YoOMy
 DIxtYE5nvhjUvKxT8gaySu6XeXqW5B4c6AaMlaH+tsLcTodfqF5uh
X-Received: by 2002:a17:90a:b78d:b0:299:25ad:7c98 with SMTP id
 m13-20020a17090ab78d00b0029925ad7c98mr7307383pjr.2.1709557929213; 
 Mon, 04 Mar 2024 05:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcgeXQaCSNbnuX/ApZebFy6vU/au5RMDT2Y2rooNkM+sJeBdjC9Vu0QMCrnT/OCYpUlAROUw==
X-Received: by 2002:a17:90a:b78d:b0:299:25ad:7c98 with SMTP id
 m13-20020a17090ab78d00b0029925ad7c98mr7307372pjr.2.1709557928909; 
 Mon, 04 Mar 2024 05:12:08 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 q66-20020a17090a17c800b0029aea375586sm7393998pja.1.2024.03.04.05.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:12:08 -0800 (PST)
Date: Mon, 4 Mar 2024 21:12:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeXIoVho09HtXKQQ@x1n>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com> <ZeXEROyMmHffj1b2@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeXEROyMmHffj1b2@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Mon, Mar 04, 2024 at 08:53:24PM +0800, Peter Xu wrote:
> On Mon, Mar 04, 2024 at 12:42:25PM +0000, Daniel P. Berrangé wrote:
> > On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
> > > Fabiano,
> > > 
> > > On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> > > > => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
> > > 
> > > I'm curious normally how much time does it take to do the final fdatasync()
> > > for you when you did this test.
> > > 
> > > I finally got a relatively large system today and gave it a quick shot over
> > > 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
> > > migration save/load does all fine, so I don't think there's anything wrong
> > > with the patchset, however when save completes (I'll need to stop the
> > > workload as my disk isn't fast enough I guess..) I'll always hit a super
> > > long hang of QEMU on fdatasync() on XFS during which the main thread is in
> > > UNINTERRUPTIBLE state.
> > 
> > That isn't very surprising. If you don't have O_DIRECT enabled, then
> > all that disk I/O from the migrate is going to be in RAM, and thus the
> > fdatasync() is likely to trigger writing out alot of data.
> > 
> > Blocking the main QEMU thread though is pretty unhelpful. That suggests
> > the data sync needs to be moved to a non-main thread.
> 
> Perhaps migration thread itself can also be a candidate, then.
> 
> > 
> > With O_DIRECT meanwhile there should be essentially no hit from fdatasync.
> 
> The update of COMPLETED status can be a good place of a marker point to
> show such flush done if from the gut feeling of a user POV.  If that makes
> sense, maybe we can do that sync before setting COMPLETED.
> 
> No matter which thread does that sync, it's still a pity that it'll go into
> UNINTERRUPTIBLE during fdatasync(), then whoever wants to e.g. attach a gdb
> onto it to have a look will also hang.

Or... would it be nicer we get rid of the fdatasync() but leave that for
upper layers?  QEMU used to support file: migration already, it never
manage cache behavior; it does smell like something shouldn't be done in
QEMU when thinking about it, at least mapped-ram is nothing special to me
from this regard.

User should be able to control that either manually (sync), or Libvirt can
do that after QEMU quits; after all Libvirt holds the fd itself?  It should
allow us to get rid of above UNINTERRUPTIBLE / un-debuggable period of QEMU
went away.  Another side benefit: rather than holding all of QEMU resources
(especially, guest RAM) when waiting for a super slow disk flush, Libvirt /
upper layer can do that separately after releasing all the QEMU resources
first.

Thanks,

-- 
Peter Xu


